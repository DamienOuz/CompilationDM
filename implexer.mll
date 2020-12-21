{
open Impparser
exception SyntaxStringError of string
exception SyntaxCharError of char

let tbl = Hashtbl.create 17
let assoc = [("while", WHILE);
	     ("if", IF);
	     ("else", ELSE);
	     ("putchar", PRINT);
			 ("for", FOR);
	     ("return", RETURN)]
let _ = List.iter (fun (s, tok) -> Hashtbl.add tbl s tok) assoc
}

let num = ['0'-'9']+

let var = ['a'-'z' 'A'-'Z']


let ident =
  (var) (var | num | '_')*

let syntaxError = num var (num|var)*


rule token = parse
| [' ' '\t'] 				{ token lexbuf }
| '\n'							{ Printf.printf " \n"; token lexbuf}
| num as i        	{ Printf.printf " %s" i ;INT (int_of_string i) }
| "true"          	{ Printf.printf " true"; INT(1) }
| "false"         	{ Printf.printf " false"; INT(0) }
| "int"		  				{ Printf.printf " int" ; TYPE(Int) }
| "bool" 	  				{ Printf.printf " bool"; TYPE(Bool) }
| "void"	  				{ Printf.printf " void" ; TYPE(Void) }
| ident as s        { Printf.printf " %s" s; match Hashtbl.find_opt tbl s with
      	 	    				| Some tok -> tok
		    							| None -> VARIABLE s }
| '+'             	{ Printf.printf " PLUS"; PLUS }
| '-'             	{ Printf.printf " MINUS"; MINUS }
| '*'             	{ Printf.printf " MUL"; MUL }
| '<'             	{ Printf.printf " LT"; LT}
| '>'			  				{ Printf.printf " GT"; GT }
| "<="             	{ Printf.printf " LTE"; LTE }
| ">="			  			{ Printf.printf " GTE"; GTE }
| "=="			 				{ Printf.printf " EGALE"; EGALE}
| "!="							{ Printf.printf " NEQ"; NEQ}
| "&&"							{ Printf.printf " AND"; AND}
| "||"							{ Printf.printf " OR"; OR}
| ';'		  					{ Printf.printf " SEMI"; SEMI }
| '{'		  					{ Printf.printf " {"; LBRACKET }
| '}'		  					{ Printf.printf " }"; RBRACKET }
| '('		  					{ Printf.printf " ("; LPAR }
| ')'		  					{ Printf.printf " )" ; RPAR }
| '='		  					{ Printf.printf " eq"; EQ }
| ','		  					{ Printf.printf " ,"; COMMA }
| eof             	{ EOF }
| syntaxError as lxm	{ raise (SyntaxStringError lxm) }
| _ as lxm					{ raise (SyntaxCharError lxm) }
