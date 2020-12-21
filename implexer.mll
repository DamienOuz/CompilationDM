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
| [' ' '\t' '\n'] 	{ token lexbuf }
| num as i        	{ Printf.printf " %s \n" i ;INT (int_of_string i) }
| "true"          	{ Printf.printf " true \n"; INT(1) }
| "false"         	{ Printf.printf " false \n"; INT(0) }
| "int"		  				{ Printf.printf " int \n" ; TYPE(Int) }
| "bool" 	  				{ Printf.printf " bool \n"; TYPE(Bool) }
| "void"	  				{ Printf.printf " void \n" ; TYPE(Void) }
| ident as s        { Printf.printf " %s \n" s; match Hashtbl.find_opt tbl s with
      	 	    				| Some tok -> tok
		    							| None -> VARIABLE s }
| '+'             	{ Printf.printf " PLUS \n"; PLUS }
| '-'             	{ MINUS }
| '*'             	{ Printf.printf " MUL \n"; MUL }
| '<'             	{ Printf.printf " LT \n"; LT}
| '>'			  				{ Printf.printf " GT \n"; GT }
| "<="             	{ Printf.printf " LTE \n"; LTE }
| ">="			  			{ Printf.printf " GTE \n"; GTE }
| "=="			 				{ Printf.printf " EGALE \n"; EGALE}
| "!="							{ Printf.printf " NEQ \n"; NEQ}
| "&&"							{ Printf.printf " AND \n"; AND}
| "||"							{ Printf.printf " OR \n"; OR}
| ';'		  					{ Printf.printf " SEMI \n"; SEMI }
| '{'		  					{ Printf.printf " { \n"; LBRACKET }
| '}'		  					{ Printf.printf " } \n"; RBRACKET }
| '('		  					{ Printf.printf " ( \n"; LPAR }
| ')'		  					{ Printf.printf " ) \n" ; RPAR }
| '='		  					{ Printf.printf " eq \n"; EQ }
| ','		  					{ Printf.printf " , \n"; COMMA }
| eof             	{ EOF }
