{
open Impparser

let tbl = Hashtbl.create 17
let assoc = [("while", WHILE);
	     ("if", IF);
	     ("else", ELSE);
	     ("putchar", PRINT);
	     ("return", RETURN)]
let _ = List.iter (fun (s, tok) -> Hashtbl.add tbl s tok) assoc
}

let num = ['0'-'9']+

let var = ['a'-'z' 'A'-'Z']


let ident =
  (var) (var | num | '_')*


rule token = parse
| [' ' '\t' '\n'] { token lexbuf }
| num as i        { Printf.printf " %s \n" i ;INT (int_of_string i) }
| "true"          { INT(1) }
| "false"         { INT(0) }
| "int"		  { Printf.printf " int \n" ; TYPE(Int) }
| "bool" 	  { TYPE(Bool) }
| "void"	  { Printf.printf " void \n" ; TYPE(Void) }
| ident as s        { Printf.printf " %s \n" s; match Hashtbl.find_opt tbl s with
      	 	    | Some tok -> tok
		    | None -> VARIABLE s }
| '+'             { Printf.printf " PLUS \n"; PLUS }
| '-'             { MINUS }
| '*'             { Printf.printf " MUL \n";MUL }
| '<'             { LT }
| ';'		  {  Printf.printf " SEMI \n"; SEMI }
| '{'		  {Printf.printf " { \n"; LBRACKET }
| '}'		  {Printf.printf " } \n"; RBRACKET }
| '('		  { LPAR }
| ')'		  { Printf.printf " ) \n" ;RPAR }
| '='		  {  Printf.printf "eq"; EQ }
| ','		  { COMMA }

| eof             { EOF }
