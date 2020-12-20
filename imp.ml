  type typ =
    | Int
    | Bool
    | Void

type expr =
    | Cst  of int
    | Add  of expr * expr
    | Mul  of expr * expr
    | Lt   of expr * expr
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

(*
let tbl = Hashtbl.create 17

let find s =
  try Hashtbl.find tbl s
  with Not_found -> failwith ("can't find : " ^ s)

let replace s v =
  try Hashtbl.replace tbl s v
  with Not_found -> failwith ("can't find : " ^ s)

let rec interp_prog decls p =
  List.iter (fun v -> Hashtbl.add tbl v (Int 0)) ("arg"::decls);
  interp_instrs p

and interp_instrs l = List.iter interp_instr l

and interp_instr = function
  | Print e ->
      let code = interp_int e in
      printf "%c" (Char.chr code)
  | Assign (s, e) ->
      let v = interp_expr e in
      replace s v
  | If (e, st, se) ->
      let b = interp_bool e in
      if b then interp_instrs st else interp_instrs se
  | While (e, s) ->
      let b = interp_bool e in
      if b then interp_instrs (s @ [While (e, s)])

and interp_expr e = match e with
  | Int _ | Bool _ -> e
  | Var s -> find s
  | Not e -> Bool (not (interp_bool e))
  | Binop (op, e1, e2) ->
      match op with
      | Plus -> Int (interp_int e1 + interp_int e2)
      | Minus -> Int (interp_int e1 - interp_int e2)
      | Mul -> Int (interp_int e1 * interp_int e2)
      | Div -> Int (interp_int e1 / interp_int e2)
      | Mod -> Int (interp_int e1 mod interp_int e2)
      | Eq -> Bool (interp_int e1 = interp_int e2)
      | Neq -> Bool (interp_int e1 <> interp_int e2)
      | Gt -> Bool (interp_int e1 > interp_int e2)
      | Lt -> Bool (interp_int e1 < interp_int e2)
      | Geq -> Bool (interp_int e1 >= interp_int e2)
      | Leq -> Bool (interp_int e1 <= interp_int e2)
      | Or -> Bool (interp_bool e1 || interp_bool e2)
      | And -> Bool (interp_bool e1 && interp_bool e2)

and interp_bool e = match interp_expr e with
  | Bool b -> b
  | _ -> failwith "boolean was expected"

and interp_int e = match interp_expr e with
  | Int i -> i
  | _ -> failwith "integer was expected"
*)