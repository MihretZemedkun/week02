module type RATIONAL =
sig
  type t
  val make : int -> int -> t
  val getNumerator : t -> int
  val getDenominator : t -> int
  val add : t -> t -> t
  val compareTo : t -> t -> int
  val toString : t -> string
end

module Rational : RATIONAL =
  struct
  type t = {numerator : int; denominator : int}

  let rec gcd m n =
    match n = 0 with
    | true  -> m
    | false -> gcd n (m mod n)

  let make numerator denominator =
    let gcd = gcd numerator denominator
  in
  match denominator < 0 with
  | true  ->
    { numerator   = - (numerator / gcd)
    ; denominator = - (denominator / gcd)
    }
  | false ->
    { numerator   = numerator / gcd
    ; denominator = denominator / gcd
    }

let getNumerator rational = rational.numerator
let getDenominator rational = rational.denominator

let add {numerator=n1; denominator=d1} {numerator=n2; denominator=d2} =
  { numerator   = n1 * d2 + n2 * d1
  ; denominator = d1 * d2
  }

let compareTo rat1 rat2 =
  let a = rat1.numerator   * rat2.denominator in
  let b = rat1.denominator * rat2.numerator
  in
  a - b

let toString {numerator; denominator} =
  (string_of_int numerator) ^ "/" ^ (string_of_int denominator)
  end
