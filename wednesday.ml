(* file: wednesday.ml
   author: Bob Muller

   CSCI 3366 Programming Languages

   This is an introduction to writing functions in OCaml.
*)
(* double : int -> int *)
let double n = n * 2
let double (n : int) = n * 2
let double (n : int) : int = n * 2

type fruit = Lemon | Lime | Apple | Pear

(* isCitrus : fruit -> bool *)
let isCitrus fruit =
  match fruit with
  | Lemon | Lime -> true
  | _ -> false                       (* _ is a wildcard *)

(* Three variations of the power function ***********************)

(* power : int -> int -> int *)
let rec power m n =
  match n = 0 with
  | true  -> 1
  | false -> m * (power m (n - 1))

(* Simplification Process

   power 3 (1 + 1) ->
   power 3 2 ->            Plug 3 in for m and 2 in for n
   match 2 = 0 with | true -> 1 | false -> 3 * (power 3 (2 - 1)) ->
   match false with | true -> 1 | false -> 3 * (power 3 (2 - 1)) ->
   3 * (power 3 (2 - 1)) ->
   3 * (power 3 1) ->
   3 * (match 1 = 0 with | true -> 1 | false -> 3 * (power 3 (1 - 1))) ->
   3 * (match false with | true -> 1 | false -> 3 * (power 3 (1 - 1))) ->
   3 * (3 * (power 3 (1 - 1))) ->
   3 * (3 * (power 3 0)) ->
   3 * (3 * (match 0 = 0 with | true -> 1 | false -> 3 * (power 3 (0 - 1)))) ->
   3 * (3 * (match true with | true -> 1 | false -> 3 * (power 3 (0 - 1)))) ->
   3 * (3 * 1) ->
   3 * 3 ->
   9        an irreducible expression, i.e., a value, in 14 steps
*)

(* power : int -> int -> int
   This version is motivated by the observation that m is invariant wrt
   power (the version above).
*)
let power m n =                    (* NB: m & n are variables wrt power *)
  let rec loop n =                 (* A local recursive function loop *)
    match n = 0 with
    | true  -> 1
    | false -> m * (loop (n - 1))  (* NB: m is constant wrt loop so we *)
  in                               (* don't pass it as an argument. *)
  loop n

(* power : int -> int -> int *)
let power m n =                           (* NB: tail-recursion *)
  let rec loop n answer =                 (* product computed on *)
    match n = 0 with                      (* the way in rather than *)
    | true  -> answer                     (* on the way out. => JMP *)
    | false -> loop (n - 1) (m * answer)
  in
  loop n 1

(* Simplification Process

 power 3 (1 + 1) ->
 power 3 2 ->
 let rec loop n ans =
   match n=0 with | true -> ans | false -> loop (n-1) (3*ans) in loop 2 1 ->
 match 2 = 0 with | true -> 1 | false -> loop (2 - 1) (3 * 1) ->
 match false with | true -> 1 | false -> loop (2 - 1) (3 * 1) ->
 loop (2 - 1) (3 * 1) ->
 loop 1 (3 * 1) ->
 loop 1 3 ->
 match 1 = 0 with | true -> 3 | false -> loop (1 - 1) (3 * 3) ->   width is
 match false with | true -> 3 | false -> loop (1 - 1) (3 * 3) ->   constant
 loop (1 - 1) (3 * 3) ->
 loop 0 (3 * 3) ->
 loop 0 9 ->
 match 0 = 0 with | true -> 9 | false -> loop (0 - 1) (3 * 9) ->
 match true with | true -> 9 | false -> loop (0 - 1) (3 * 9) ->
 9      an irreducible expression, i.e., a value, in 15 steps
*)

(* Friday *)

(* type number = Int of int | Flt of float *)

(* addJS : number -> number -> number *)

(* length : 'a list -> int *)

(* addInts : int list -> int *)

(* mem : 'a -> 'a list -> bool *)

(* append 'a list -> 'a list -> 'a list *)

(* reverse : 'a list -> 'a list *)
