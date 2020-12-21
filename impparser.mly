%{
    open Imp
%}

%token<int> INT
%token<string> VARIABLE
%token<Imp.typ> TYPE
%token PLUS ETOILE MINUS MUL RETURN LT GT GTE LTE EGALE NEQ AND OR
%token WHILE IF ELSE
%token SEMI LBRACKET RBRACKET LPAR RPAR PRINT EQ COMMA
%token EOF


%left EQ NEQ
%left AND OR
%left LTE
%left LT
%left GTE
%left GT
%left PLUS 
%left MUL

%start<Imp.prog> prog
%%

prog:
  | d=decl p=nonempty_list(foncs)  EOF {  let prog = { globals = d ; functions = p } in prog }
;

decl:
| decl decls { ($2)::($1) } 
| {[]}
;

decls:
  | TYPE VARIABLE SEMI { ($2,$1, Decl ) } 
  | TYPE VARIABLE EQ e = expr SEMI { ($2,$1, Aff (e) ) } 
;

foncs:
| return=TYPE name=VARIABLE LPAR param=param RPAR LBRACKET locals=decl code = instr RBRACKET 
    {{name = name; params = param; return = return; locals = locals ; code = code}}
;
param:
| param params { ($2)::($1) }
| {[]}
;
params:
| TYPE VARIABLE COMMA { ($2, $1) }
| TYPE VARIABLE { ($2, $1) }
;


instr:
| instr instrs { ($2)::($1) }
| {[]}
;


instrs:
  | PRINT LPAR e=expr RPAR SEMI
    { Putchar e }
  | v=VARIABLE EQ e=expr SEMI
    { Set (v, e) }
  | IF LPAR e=expr RPAR LBRACKET st=instr RBRACKET ELSE LBRACKET se=instr RBRACKET
    { If (e, st, se) }
  | WHILE LPAR e=expr RPAR LBRACKET s=instr RBRACKET
    { While (e, s) }
  | RETURN e=expr SEMI
    { Return (e) }
  |  e=expr 
    { Expr e }
;

expr:
  | INT {   Cst $1 }
  | MINUS INT { Cst (- $2) }
  | expr PLUS expr { Add ( $1, $3) }
  | expr MUL expr { Mul ( $1, $3) }
  | expr LT expr { Lt ( $1, $3) }
  | VARIABLE LPAR p=appel RPAR { Call($1,p) }  
  | x=VARIABLE { Get ( x) }

  | e1=expr PLUS e2=expr
    { Add(e1, e2) }

  | e1=expr ETOILE e2=expr
      {Mul( e1, e2) }
  | e1=expr LT e2=expr
      { Lt( e1, e2) }
  | e1=expr GT e2=expr
      { Lt( e2, e1) }
  | e1=expr LTE e2=expr
      { Lte( e1, e2) }
  | e1=expr GTE e2=expr
      { Lte( e2, e1) }
  | e1=expr EGALE e2=expr
      { Eq( e1, e2) }
  | e1=expr NEQ e2=expr
      { Neq( e1, e2) }
  | e1=expr AND e2=expr
      { And( e1, e2) }
  | e1=expr OR e2=expr
      { Or( e1, e2) }
;

appel:
| appel appels { ($2)::($1) }
| {[]}

appels:
  | e = expr COMMA{ e }
  | e = expr { e }

;
