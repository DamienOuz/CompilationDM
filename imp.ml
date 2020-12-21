type typ =
  | Int
  | Bool
  | Void

type expr =
  | Cst  of int
  | Add  of expr * expr
  | Mul  of expr * expr
  | Lt   of expr * expr
  | Lte  of expr * expr
  | Eq   of expr * expr
  | Neq  of expr * expr
  | And  of expr * expr
  | Or   of expr * expr
  | Get  of string
  | Call of string * expr list
  
type instr =
  | Putchar of expr
  | Set     of string * expr
  | If      of expr * seq * seq
  | While   of expr * seq
  | Return  of expr
  | Expr    of expr

and seq = instr list

type declaff = 
| Decl
| Aff of expr

type fun_def = {
  name:   string;
  params: (string * typ) list;
  return: typ;
  locals: (string * typ* declaff) list;
  code:   seq;
}


type prog = {
  globals:   (string * typ * declaff) list;
  functions: fun_def list;
}