open Imp
open Implexer

exception UnexpectedValue of expr
exception UnvalidType of typ * typ
exception UnvalidFunctionArgumentNb of int * int * string
exception NoMainFunction
exception VariableNotDefined of string
exception FunctionNotDefined of string


let rec print_type ty = 
    match ty with
    | Int -> Printf.printf " %s  \n" "Int"
    | Bool -> Printf.printf " %s  \n" "Bool"
    | Void -> Printf.printf " %s  \n" "Void"
    | a -> Printf.printf " %s " "Inconnu"
;;

let typeVariable var env =
  try Hashtbl.find env var
  with Not_found -> failwith "nom de variable ou de fonction inconnu";;

let addToEnv str ty env =  Hashtbl.add env str ty; env;;

let rec addParamsToEnv l env =
  match l with
  | (str, ty)::tl ->  addToEnv str ty env;
                      addParamsToEnv tl env
  | _ -> env
;;

let transtypable firstTyp secondTyp =
  match firstTyp with
  | Void -> secondTyp = Void
  | Bool -> begin match secondTyp with
              | Void -> false
              | Bool -> true
              | Int -> true 
            end
  | Int ->  begin match secondTyp with
              | Void -> false
              | Bool -> true
              | Int -> true 
            end
;;

let isTranstypable firstTyp secondTyp =
  if (transtypable firstTyp secondTyp) then true else failwith "type non polymorphe";;

let rec type_expr expr env envf =
  match expr with
  | Cst x -> Int

  | Add(x, y) -> isTranstypable (type_expr x env envf) Int;
                 isTranstypable (type_expr y env envf) Int;
                 Int

  | Mul(x, y) -> isTranstypable (type_expr x env envf) Int;
                 isTranstypable (type_expr y env envf) Int;
                 Int

  | Lt(x, y) ->  isTranstypable (type_expr x env envf) Int;
                 isTranstypable (type_expr y env envf) Int;
                 Int
  | Lte(x, y) -> isTranstypable (type_expr x env envf) Int;
                 isTranstypable (type_expr y env envf) Int;
                 Int
  | Neq(x, y) -> isTranstypable (type_expr x env envf) Int;
                 isTranstypable (type_expr y env envf) Int;
                 Int
  | Eq(x, y) ->  isTranstypable (type_expr x env envf) Int;
                 isTranstypable (type_expr y env envf) Int;
                 Int

  | Get(nomVariable) -> typeVariable nomVariable env

  | Call(nomFonction, args) -> let myFun = typeVariable nomFonction envf in
                               let _ = eval_args myFun.params args env envf in
                               myFun.return
and
  eval_args params args env envf =
    match params, args with
    | (str, ty)::tlf, expr::tle ->  let _ = isTranstypable ty (type_expr expr env envf) in
                                    eval_args tlf tle env envf
                                  
    | _ -> true
;;

let rec check_seq li f env envf =
  match li with
  | (Putchar expr)::[] -> isTranstypable (type_expr expr env envf) Int
  | (Set(declVar, expr))::[] -> isTranstypable (typeVariable declVar env) (type_expr expr env envf)
  | (If(expr, listInstrA, listInstrB))::[] -> isTranstypable (type_expr expr env envf) Bool;
                                              let _ = check_seq listInstrA f env envf in
                                              let _ = check_seq listInstrB f env envf in
                                              true
  | (While(expr, listInstr))::[] -> isTranstypable (type_expr expr env envf) Bool;
                                    check_seq listInstr f env envf
  | (Return expr)::[] -> let ty_expr = type_expr expr env envf in
                         isTranstypable ty_expr f.return
  | (Expr expr)::[] -> let _ = type_expr expr env envf in true
  | a::[] -> failwith "sequence non reconnue"
  | l::tl ->  let _ = check_seq (l::[]) f env envf in
              check_seq tl f env envf
  | [] -> true
;;



let rec check_variable lg env envf =
  match lg with
  | (str, ty, Aff(expr))::tl -> let typ_e = type_expr expr env envf in
                                let _ = isTranstypable typ_e ty in
                                let env = addToEnv str ty env in
                                check_variable tl env envf
                             


  | (str, ty, Decl )::tl -> let env = addToEnv str ty env in 
                            check_variable tl env envf
                            
  | _ -> true
;;





let rec check_func lf env envf =
  match lf with
  | func::tl -> let envf = addToEnv func.name func envf in
                let env = addParamsToEnv func.params env in
                let env = addToEnv func.name func.return env in
                let _ = check_seq func.code func env envf in
                check_func tl env envf

  | _ -> true
;;

let check_prog prog =
  let () = print_string "Evaluation du Programme \n" in
  let env, envf = Hashtbl.create 32, Hashtbl.create 32 in
  let env_globale = check_variable prog.globals env envf in
  let env_function = check_func prog.functions env envf in
  let () = print_string "Programme Evalué \n" in
  ()
;;


let start prog = 
  let env = Hashtbl.create 32 in
  let envf = Hashtbl.create 32 in
  check_prog prog
;;
