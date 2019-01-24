(* file: rational.ml
   author: Bob Muller

   CS1103 Computer Science I Honors

   Lecture Notes/Code for Week 14

   Topic:

   Using OCaml's module system to make new types.  We use an example of rational
   numbers.  This file contains a module structure implementing the signature
   specified in the accompanying rational.mli file.

 *)
type t = {numerator : int; denominator : int}

let rec gcd m n =
  match n = 0 with
  | true  -> m
  | false -> gcd n (m mod n)

let make m n =
  let gcd = gcd m n
  in
  {numerator = m / gcd; denominator = n / gcd}

let toString {numerator; denominator} =
  (string_of_int numerator) ^ "/" ^ (string_of_int denominator)
                                      
let add {numerator=n1; denominator=d1} {numerator=n2; denominator=d2} =
  {
    numerator   = n1 * d2 + n2 * d1
  ; denominator = d1 * d2
  }

let compareTo rat1 rat2 =
  let a = rat1.numerator   * rat2.denominator in
  let b = rat1.denominator * rat2.numerator
  in
  a - b

