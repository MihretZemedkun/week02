(* file: rational.mli
   author: Bob Muller

   CS1103 Computer Science I Honors

   Lecture Notes/Code for Week 14

   Topic:

   Using OCaml's module system to make new types.  We use an example of rational
   numbers.  This file contains a module type or signature specifying a type for
   rational numbers.  See also the accompanying implementation in rational.ml.
 *)
type t
val make : int -> int -> t
val add : t -> t -> t
val compareTo : t -> t -> int
val toString : t-> string
