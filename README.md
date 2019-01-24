

# CSCI 3366 Programming Languages

### Spring 2019

**R. Muller**

------

### Lecture Notes: Week 2

#### This Week

1. OCaml: Basic Types, Literals & Expressions; Naming; Defining Functions
2. Structured Types & Recursive Functions
3. Functions are Values
4. Imperative Features
5. Modules
6. Solutions to Exercises

---

Like most programming languages, OCaml is text-based: OCaml source code is written out in text and is then processed by the computer to carry out the expressed computation. OCaml source code is stored in files with the `.ml` extension. OCaml code can either be compiled and executed as an application via a command shell or, under some circumstances, it can be executed by an interpreter.

**Compilation**

The OCaml compiler `ocamlc` translates OCaml source code and produces a byte-code file that can be executed on OCaml's virtual machine.

```
> ocamlc -o go myprogram.ml
> ./go
```

Executing the `go` byte-code file fires up OCaml's virtual machine to execute the code expressed in `myprogram.ml`. For this course, compilation will involve multiple source files and libraries so the process is usually configured using  the Unix `make` command. Most often, you'll compile with

```
> make
> ./go
```

**Interpretation**

OCaml's interpreter `ocaml` can be fired up from the Unix command line. It cycles through a loop: reading, evaluating, printing and then looping back. Interpretation loops of this kind are often referred to as REPLs. An interaction with OCaml's REPL shell might look like:

```ocaml
> ocaml
...
# 3 * 2;;
- : int = 6

#
```

The hash-sign `#` is OCaml's prompt and the trailing `;;` is the user's signal to OCaml that they'd like the expression to be evaluated.  In practice, when we wish to run an OCaml REPL, we'll usually run it from within the Atom editor. The details are spelled out in problem set 1.

----------------

## 1. Basic Types, Literals & Expressions; Naming; Defining Functions

In computing, *types* can be understood as sets of "things" that are the subject of the computation. All programming languages provide a number of basic types that are built-in to the language. Most programming languages have ways to define new types. We'll get to that topic later.

Virtually all programming languages have basic types `int` and `float` together with built-in operators (e.g., `+`, `-`, `*`, `/`, `mod`) that work on values of that type.

**The unit Type**

The `unit` type has exactly one value `()`.

```ocaml
# ();;
- : unit = ()
```

**The int Type**

```ocaml
# 2;;
- : int = 2
```

The numeral `2` is a *literal* expression of type `int`. OCaml's REPL displays both the type of the expression as well as its value.

```ocaml
# (* This is a comment; ignored by OCaml *)
```

```ocaml
# 5 * 2;;
- : int = 10
```

The expression `5 * 2` simplifies to the literal `10`. Expressions that can't be further simplified are called *values*.

**Convention** Infix operators should have spaces on either side.  So `5 / 2` is good, `5/2` is less good, and both `5 /2` and `5/ 2` are bad. Some coders prefer a style in which operators of lower precedence are surrounded by spaces while operators of higher precedence do not.  For example, instead of

```ocaml
a * x + b * x + c
```

one might write:

```ocaml
a*x + b*x + c
```

but the former is preferred in CS3366.

**Integer Division**

```ocaml
# 7 / 2;;
- : int = 3

# 99 / 100;;
- : int = 0

# 1 / 0;;
Exception: Division_by_zero.

# 7 mod 5;;
- : int = 2

# max_int;;
- : int = 4611686018427387903
```

**The float Type**

```ocaml
# 3.14;;
- : float = 3.14

# 314e-2;;
- : float = 3.14

# 2.0 *. 3.14;;               (* NB: The floating point operators: +., -, ... end with a . *)
- : float = 6.28

# 7.0 /. 2.0;;
- : float = 3.15

# 2.0 ** 3.0;;
- : float = 8.0

# infinity;;
- : float = infinity

# 1.0 /. 0.0;;
- : float = infinity

# 1.0 /. 2;;
Error: This expression has type int but an expression was expected of type float
```

**Type Conversion**

```ocaml
# float_of_int 1;;
- : float = 1.0

# float 1;;
- : float = 1.0

# int_of_float 1.9999;;
- : int = 1
```

The built-in operators are interpreted using the familiar PEMDAS order for the operators.

```ocaml
# 2.0 +. 3.14 *. 4.0;;
- : float = 14.56

# (2.0 +. 3.14) *. 4.0;;
- : float = 20.5600000000000023          (* NB: 15 decimal places for floats *)
```

**The char Type**

```ocaml
# 'M';;
- : char = 'M'

# Char.code 'M';;
- : int = 77

# Char.chr 77;;
- : char = 'M'
```

The last two examples uses functions from the built-in `Char` library, part of the standard library that ships with OCaml. We'll have more to say about libraries below.

The string type and the bool type are built-in "base" types but they're actually a bit different than the base types shown above. For now we'll ignore the difference.

**The string Type**

```ocaml
# "hello world!";;
- : string = "hello world!"

# "hello" ^ " world!";;                 (* string concatenation *)
- : string = "hello world!"

# String.length "hello world!";;
- : int = 12

# "CSCI3366".[1];;                      (* string indexing yields a char *)
- : char = 'S'
```

**The bool Type**

```ocaml
# true;;
- : bool = true

# false;;
- : bool = false

# false || true;;
- : bool = true

# false && true;;
- : bool = false

# not (false && true);;
- : bool = true
```

**Relational Operators**

Values of the same type can be compared.

```ocaml
# 'A' = 'A';;
- : bool = true

# 'A' <> 'A';;
- : bool = false

# 3 >= 4;;
- : bool = false

# compare "Alice" "Alice";;
- : int = 0

# compare "Al" "Alice";;
- : int = -1

# compare "Alice" "Al";;
- : int = 1
```

### Libraries

Like most programming languages, OCaml has libraries of code that can be used more or less off-the-shelf. The [Standard Library](http://caml.inria.fr/pub/docs/manual-ocaml/stdlib.html) comes with all implementations of OCaml. We've referred to the Standard Library's **Char** and **String** modules already, there are many more: a **Random** module for working with random numbers, a  **Printf** module for formatted printing and so on. It's worth noting that OCaml's Standard Library is pretty spare in comparison to standard library's in other programming languages.

Symbols defined in library modules can be accessed by prefixing them with the module name.

```ocaml
# String.length "Alice";;
- : int = 5
-
# Random.int 3;;                 (* equal chance of 0, 1 or 2 *)
- : int = 1

# Random.float 1.0;;
- : float = 0.432381

# Printf.sprintf "My friend %s is %d years old." "Jasmine" 19;;
- : string : "My friend Jasmine is 19 years old."
```

One can omit the module-name prefix by opening the module.

```ocaml
open Printf

sprintf "Hello %s" "world!";;
```

It's common to make an abbreviation for a module name.
```ocaml
module P = Printf
P.sprintf "Hello %s" "world!"
```

**Pervasives**

Some library resources are used so, well, pervasively, in OCaml code, their definitions are housed in a module [Pervasives](http://caml.inria.fr/pub/docs/manual-ocaml/libref/Pervasives.html) that is opened automatically. Instead of requiring `Pervasives.min`, one can write simply `min`.

**The Code Module**

For XXX

#### Summary

- OCaml expressions are mostly familiar, being built-up from literals of base type, operators and parentheses;

- OCaml's modus operandi is to simplify:

  ```ocaml
  2 + 3 + 4 + 5 ->
    5 + 4 + 5 ->
    9 + 5 ->
    14
  ```

- A *value* is an expression that cannot be further simplified.



**Comments**:

1. In the last two examples: the infix operators `+, *, /, -, …` can be used in *prefix* *position* by enclosing them in parentheses as shown.
2. The type of the `+` operator is `int -> int -> int` — this may look a little strange; we'll explain it later.
3. NB: the multiply operator must be surrounded by spaces `( * )` so it isn't confused with a comment.

```ocaml
 ( * ) 2 3;;
- : int = 6
```

This is also true for the exponentiation operator `**`.

-------------------

### Naming Values

In OCaml, values can be named using a `let`-expression. There are two basic forms:

```ocaml
let x = expr                                    --- top-level let
let x = expr1 in expr2                          --- let-in  
```

The former makes the name `x` usable throughout the top-level. In the latter, the name `x` is only usable in the expression immediately after the `in`  keyword: i.e., the expression `expr2`.

```ocaml
# let a = 3.0 . 2.0;;                  ( top level let *)
val a : float = 6.0

# a;;
- : float = 6.0

# let b = 3.0 . 2.0 in b ** 2.0;;      ( let-in *)
- : float = 36.0

# b;;
Error: Unbound variable b

# let school = "Boston College";;
val school : string = "Boston College"

# school.[0];;
- : char = 'B'
```

**Name Formation** Names in OCaml can be formed in the standard ways. Names beginning with a lowercase letter are used for values and types; names beginning with an uppercase letter are used for module names, signature names or constructors. We'll discuss these in the next section.

**Conventions**

1. **Name Formation**: OCaml coders tend to follow the standard conventions using either **camelCase** or **snake_case** for symbols.
2. **Cascaded Lets**: It's very common to have a cascade of `let-in`-expressions as in

```ocaml
let x1 = expr1 in let x2 = expr2 in ... let xn = exprn in expr
```

​In this case we stack up the lets as follows:

```ocaml
  let x1 = expr1 in
  let x2 = expr2 in
  ...
  let xn = exprn
  in
  expr
```



```ocaml
# let smaller = min 2 3;;
val smaller : int = 2

# floor 3.9999;;
- : int = 3

# abs (-3);;
- : int = 3

# abs_float (-2.0);;
- : float = 2.
```

Modules that are not part of the Standard Library need to be made known to the OCaml compiler. This can be done in a number of ways, we'll come back to this topic later.

**Packages**

The world-wide OCaml community has developed many more library modules that provide functionality beyond the Standard Library. These libraries usually take the form of **packages** that implement complete applications or services. OCaml packages can be installed and managed by OCaml's package manager [OPAM](https://opam.ocaml.org/).

### Defining Functions

Functions are the main tool for packaging up computation in almost all programming languages. In this section we'll introduce the basic form. In the next section we'll discuss how to write functions in general. Functions have **definitions** and **uses**.  

**Function Definitions** The two variations of the `let`-expression discussed earlier can be used to name a function value.

```ocaml
  let functionName x1 ... xn = expr1                    --- top-level
  let functionName x1 ... xn = expr1 in expr2           --- let-in
```

The symbols `x1`, ..., `xn` denote binding occurrences of **variables**. These occurrences are called **parameters** or **formal  parameters**. Formal parameters usually govern applied occurrences or uses of the variables in the function **body**  `expr1`.

**Notes**:

1. The variables `x1`, …, `xn` can be used only in `expr1`;
2. The function name `functionName` cannot be used in `expr1`, in the former case it can be used in the top-level and in the latter case it can be used only in `expr2`.

Function definitions are usually stored in text files with the **.ml** extension.

**Function Calls**

A function *call* or *application* has the form:

```ocaml
functionName expr1 ... exprn            or         (functionName expr1 ... exprn)
```

where each of `expr1`, ..., `exprn` is an expression. How does a function do its job? As with the simple algebraic expressions, through simplification.

1. When a function call is evaluated, for each i = 1,..,n, `expri` is evaluated. This process may produce a value Vi, it may encounter an error or it may not stop (more on that later).

2. If for each i, the evaluation of `expri` produces a value Vi, the value Vi is plugged-in for `xi` in the function body (i.e., each occurrences of `xi` in `expr1` is **replaced** by value Vi).

3. Then the body of the function is simplified. If the body of the function has a value V, then V is the value of the function call.


**Example**: a doubling function

```ocaml
# let double n = n * 2;;
val double : int -> int

double (2 + 2) ->              --- simplification requires 3 steps
  double 4 ->
  4 * 2 ->
  8
```

```ocaml
double 3 + double (2 + 3) ->   --- simplification requires 6 steps
  3 * 2 + double (2 + 3) ->
  6 + double (2 + 3) ->
  6 + double 5 ->
  6 + 5 * 2 ->
  6 + 10 ->
  16
```

**Example**: A min3 function that uses the two-argument pervasive `min` function to compute the minimum of 3 inputs.

```ocaml
# let min3 p q r = min p (min q r);;
val min3 : 'a -> 'a -> 'a -> 'a

min3 1 2 3 ->
  min 1 (min 2 3) ->
  min 1 2 ->
  1
```

**Prefix Notation for Operators**

Operators such as `+`, `*`, etc which ordinarily appear in infix notation, i.e., between the operands, are functions that can be applied with function application notation. In order to do this, they have to be enclosed in parentheses.

```ocaml
# (+);;
- : int -> int -> int = <fun>

# (+) 2 3;;
- : int = 5
```

## 2. Structured Types & Recursive Functions

In the previous section, we learned the basics of OCaml, the basic data types, operators etc. In this section we're going to explore OCaml's built-in structured types, ways to make new types and how to process data of unbounded size using recursive functions.

#### Tuples & Pattern Matching

```ocaml
# let pair = (1 + 2, Char.chr 65);;
val pair : int * char = (3, 'A')                (* int * char is -product- type *)

# fst pair;;                                    (* fst : 'a * 'b -> 'a is pervasive *)
- : int = 3

# snd pair;;
- : char = 'A'

# let (n, a) = pair;                             (* matching pattern (n, a) against pair *)
val n : int = 3
val a : char = 'A'
```

#### Polymorphism

The type of a function depends on its definition. For example, the definition of the following `swap` function

```ocaml
let swap (x, y) = (y, x)
```

doesn't impose any constraints on the inputs `x` and `y`. OCaml will infer the most general possible type

```ocaml
val swap : ('a * 'b) -> ('b * 'a)
```

where `'a` and `'b` are type variables.


#### Records

```ocaml
# type point = {x : int; y : int};;              (* x and y are field labels *)
type point = {x : int; y : int}

# let p = {x = 2 * 2; y = 8};;
val p : point = {x = 4; y = 8}

# p.x;;
- : int = 4
```

Records are very useful data structures, especially because OCaml provides powerful pattern matching support.

```ocaml
# let {x = a; y = b} = p;;  (* variables a and b matched to the values of the x and y fields. *)
val a : int = 4
val b : int = 8

# let {x; y} = p;     (* choosing variable names same as field name allows this abbreviation*)
val x : int = 4
val y : int = 8

# let {x} = p;;       (* matching only the x field *)
val x : int = 4

# let makePoint x y = {x; y};;       (* NB: using variable names same as record field names *)
val makePoint : int -> int -> point

let q = makePoint 2 3;;
val q : point = {x = 2; y = 3}
```

#### Sums

Sum types are especially important in programming languages. They're sometimes called *variants* types and sometimes called *(disjoint) unions*.

```ocaml
# type fruit = Apple | Lemon | Tomato | Lime;;
type fruit = Apple | Lemon | Tomato | Lime

# let t = Tomato;;
val t : fruit = Tomato
```

The symbols enumerated on the right: `Apple`, `Lemon`, `Tomato` and `Lime` are *constructors* — they construct values of type `fruit`.  We can think of them as a complete enumeration of the values of type `fruit`.

#### Match Expressions

OCaml has a powerful `match` form for processing values of sum type.

```ocaml
(* isCitrus : fruit -> bool
*)
let isCitrus fruit =
  match fruit with
  | Apple  -> false
  | Lemon  -> true
  | Tomato -> false
  | Lime   -> true

let isCitrus fruit =         (* more succinctly *)
  match fruit with
  | Lemon | Lime -> true
  | _ -> false
```

```ocaml
type herb = Basil | Celery | Banana

type food = Fruit of fruit | Herb of herb
```

The symbols `Fruit` and `Herb` are *constructors*. We can think of the `Fruit` constructor as a function from `fruit` to `food` — if you apply it to a value of type fruit, it returns a value of type food.

```ocaml
# let aBite = Fruit Tomato;;
val aBite : food = Fruit Tomato

(* tomLikes : food -> bool                   Tom likes Apples and Celery
*)
let tomLikes food =
  match food with
  | Fruit fruit -> (match fruit with | Apple  -> true | _ -> false)
  | Herb  herb  -> (match herb  with | Celery -> true | _ -> false)
```

**Exercise**

Write  function `coinFlip : unit -> string` that has a 50/50 chance of returning `"heads"` or `"tails"`.

#### Option Types

The sum type is convenient for specifying different options. The built-in sum type `'a option` is provided to deal with cases where one of the options is that something doesn't exist. For example, the expression `1 / 0` has no value. If we evaluate this, OCaml raises a run-time exception:

```ocaml
# 1 / 0;;
Exception: Division_by_zero.
```

Using an option type, we could write an alternative version of integer division as:

```ocaml
(* carefulDivide : int -> int -> int option
*)
let carefulDivide m n =
  match n = 0 with
  | true  -> None
  | false -> Some (m / n)

# carefulDivide 6 2;;
- : int option = Some 3

# carefulDivide 6 0;;
- : int option = None
```

#### Lists

The most common data structure in OCaml is the list.

```ocaml
# type fruit = Apple | Lemon | Tomato | Lime;;
type fruit = Apple | Lemon | Tomato | Lime

# [Apple; Lime];;
- : fruit list = [Apple; Lime]

# Apple :: [Lime];;
- : fruit list = [Apple; Lime]
```

The operator `::`, called "cons", is a built-in list constructor that accepts a list element and a list and returns a new list with one new element. OCaml views it as a sequence of conses ending in the empty list `[]` called "nil".

```ocaml
# Apple :: Lime :: [];;
- : fruit list = [Apple; Lime]
```

```ocaml
# let ns = [1 + 1; 4; 3 + 3];;
- : int list = [2; 4; 6]

# let head :: tail = ns;;                 (* matching a cons *)
val head : int = 2
val tail : int list = [4; 6]               (* the tail of a list is a list. *)

# List.length ns;;
- : int = 3
```

Lists can hold values of any type as long as all the values in the list are of the same type. What if we want a list of floats and ints together? Must make a combining type:

```ocaml
type number = Float of float | Int of int

# let numbers = [Float 3.14; Int 343; Float 0.5];;
val numbers : number list = [Float 3.14; Int 343; Float 0.5]
```

### Recursive Functions

In OCaml, the natural way to express repetition in a function is to define it recursively. In order to define a recursive function, the keyword `rec` is required as an annotation:

```ocaml
  let rec functionName x1 ... xn = expr1                    --- top-level
  let rec functionName x1 ... xn = expr1 in expr2           --- let-in
```

In a recursive function, the function name can be used in `expr1`.

**Example**

```ocaml
let rec factorial n =
  match n = 0 with
  | true  -> 1
  | false -> n * factorial (n - 1)
```

**Exercise**

Write the function `power : int -> int -> int` such that a call `(power m n)` returns `m` raised to the `n`.

The list type is defined in OCaml as a recursive sum of products (!). Roughly speaking:

```ocaml
type 'a list = [] | :: of 'a * 'a list
```

This is really just a slogan suggesting how lists work, the actual list type is built-in as a special case because it is so ubiquitous.

**Example**

A function `downFrom : int -> int list` a call `(downFrom n)` returns a descending list `[n - 1; …; 0]`.

```ocaml
let rec downFrom n =
  match n = 0 with
  | true  -> []
  | false ->
    let m = n - 1
    in
    m :: downFrom m
```

**Exercise**

Write a function `range : int -> int list` such that a call `(range n)` returns an ascending list `[0; …; n - 1]`.

```ocaml
# let foods = [Fruit Lemon; Herb Banana; Fruit Lime; Fruit Apple];;
val foods : food list = [Fruit Lemon; Herb Banana; Fruit Lime; Fruit Apple]

(* countFruits : food list -> int
*)
let rec countFruits foods =
  match foods with
  | [] -> 0
  | (Fruit _) :: foods -> 1 + countFruits foods
  | _ :: foods -> countFruits foods
```

**Key Idea**

> *when writing a function that processes a value of a recursive type, one can often solve a major sub-problem by applying the function recursively to those parts of the value that are defined recursively in the type.*

```ocaml
(* append : 'a list -> 'a list -> 'a list

   For a call (append xs ys), this function definition is linear in (List.length xs).
*)
let rec append xs ys =
  match xs with
  | [] -> ys
  | x :: xs -> x :: append xs ys

(* copy : 'a -> int -> 'a list
*)
let rec copy item n =
  match n = 0 with
  | true  -> []
  | false -> item :: copy item (n - 1)
```

Two versions of a list reversal function.

```ocaml
(* reverse : 'a list -> 'a list

   For a call a (reverse xs), this function is QUADRATIC in (List.length xs). Why? It calls
   a linear function a linear number of times. Not good!
*)
let rec reverse xs =
  match xs with
  | [] -> []
  | x :: xs -> append (reverse xs) [x]

(* A more efficient, tail-recursive version. This version is LINEAR in (List.length xs)
*)
let reverse xs =
  let rec loop xs answer =
    match xs with
    | [] -> answer
    | x :: xs -> loop xs (x :: answer)
  in
  loop xs []
```

**Trees**

```ocaml
type 'a tree = Empty
             | Node of { info : a'
                       ; left : 'a tree
                       ; right: 'a tree
                       }
```

A `'a tree` is a binary tree carrying information of polymorphic type `'a`. Since the `left` and right fields are defined recursively, processing `'a tree`s will usually involve some sort of recursive calls on those fields. **Note that there is no null in OCaml — the base case of the recursive definition is explicitly defined as `Empty`.**

```ocaml
type sym = A | B | C | D | E                                                          

let t : sym tree = Node { info = A
                        ; left = Node { info  = B                              A
                                      ; left  = Empty                         / \
                                      ; right = Node { info  = D             B   C
                                                     ; left  = Empty          \                                                   
                                                     ; Right = Empty           D
                                                     }
                                      }
                        ; right = Node { info  = C
                                       ; left  = Empty
                                       ; Right = Empty
                                       }
                        }  

(* preorder : 'a tree -> 'a list
*)
let rec preorder tree =
  match tree with
  | Empty -> []
  | Node{info; left; right} -> info :: (preorder left) @ (preorder right)

(* breadthFirst : 'a tree -> 'a list
*)
let breadFirst tree =
  let rec loop forest =
    match forest with
    | [] -> []
    | Empty :: forest -> loop forest
    | (Node{info; left; right}) :: forest ->
      info :: loop (left :: right :: forest)
  in
  loop [tree]                 
```

**Abstract Syntax Trees**

```ocaml
type value = Value of int

type ast = Literal of int
         | Plus of  {left : ast; right : ast}
         | Times of {left : ast; right : ast}

let fmt = Printf.sprintf

(* format : ast -> string
*)
let rec format ast =
  match ast with
  | Literal i -> string_of_int i
  | Plus{left; right}  -> fmt "(%s + %s)" (format left) (format right)
  | Times{left; right} -> fmt "(%s * %s)" (format left) (format right)

(* eval : ast -> value
*)
let rec eval ast =
  match ast with
  | Literal i -> Value i
  | Plus {left; right}  ->
    let Value v1 = eval left in
    let Value v2 = eval right
    in
    Value (v1 + v2)
  | Times {left; right}  ->
    let Value v1 = eval left in
    let Value v2 = eval right
    in
    Value (v1 * v2)
```

## 3. Functions are Values

Types can be understood as denoting sets of values. For example, the literals `1` and `2` are elements of the set denoted by the type `int` and the literals `'A'` and `'B'` are elements of the set denoted by the type `char`. This idea is orthogonal in OCaml: it applies to structured types as well as the base types. Thus, the pair value `(1, 2)` is an element of the product set denoted by the type `int * int`. And so forth.

In this chapter, we consider *function values* i.e., the values occupying the sets denoted by function types. For example, the `double` function in:

```ocaml
(* double : int -> int
*)
let double n = n * 2
```

is of type `int -> int`, so we can usefully view it as an element of the set denoted by the type `int -> int`. This is a rich and interesting topic and a fundamental aspect of modern coding.

The function definition notation in this example is shorthand for

```ocaml
let double = fun n -> n * 2
```

The expression `fun n -> n * 2` denotes an *anonymous function*.

#### Mapping Functions over Lists

Many common computational idioms or *patterns* as they are sometimes called, can be captured by treating functions as *first-class* values. That is, by treating functions in the same way that one treats values of other types such as integers or floats — to allow them to be passed as arguments to functions, returned as results of functions, stored in lists, records and tuples and so forth.

Let the polymorphic `pair` function be defined as:

```ocaml
(* pair 'a -> ('a * 'a) list
*)
let pair x = (x, x)
```

and consider the following four example list processing functions:

```ocaml
(* codes : char list -> int list
*)
let rec codes chars =
  match chars with
  | [] -> []
  | char :: chars -> (Char.code char) :: codes chars

(* doubles : int list -> int list
*)
let rec doubles ns =
  match ns with
  | [] -> []
  | n::ns -> (double n) :: doubles ns

(*  stringLens : string list -> int list
 *)
let rec stringLens strings =
  match strings with
  | [] -> []
  | string :: strings -> (String.length string) :: stringLens strings

(* pairAll : 'a list -> ('a * 'a) list
 *)
let rec pairAll xs =
  match xs with
  | [] -> []
  | x :: xs -> pair x :: pairAll xs
```

All four of these functions accept a list of items and return a new list wherein each element is the image of some function applied to the corresponding element of the input list. For `codes` that function is `Char.code`, for `doubles` that function is `double`, for `stringLens` that function is `String.length` and for `pairAll` that function is `pair`.

We prefer to capture this common pattern in a procedural abstraction. We do this by abstracting with respect to the parts that varied in the concrete examples above. The result is the famous `map` function:

```ocaml
(* map : ('a -> 'b) -> 'a list -> 'b list
*)
let rec map f xs =
  match xs with
  | [] -> []
  | x :: xs -> (f x) :: map f xs
```

The `map` function is so useful that it is included in the Standard Library's `List` module. So we could write:

```ocaml
let doubles ns    = List.map double ns
let codes chars   = List.map List.code chars                  (* 1 *)
let stringLens ss = List.map String.length strings
let pairAll xs    = List.map pair xs                          (* 2 *)
```

Here we see that the functions `double`, `Char.code` and so on are being passed to the `List.map` function as input arguments. This is fine in OCaml and in most other modern programming languages.

#### Polymorphism

It's worth noting the role of the polymorphism of the `List.map` function. It accepts a function mapping `'a`s to `'b`s and a list of `'a`s. When provided inputs of these types, it returns a list of `'b`s. In the application of map in `(1)` above, the first argument `Char.code`, is of type `char -> int`. Then the second argument is *required* to be a list of `chars`. In the application in `(2)` above, the first argument `pair` is of polymorphic type `'a -> ('a * 'a)`. Thus, the second argument `xs` can be any type `t` and the result wil be a list of pairs of `t`s, i.e., a value of type `(t * t) list` for any type `t`.

#### Filtering Lists

Another common idiom using functions as arguments is filtering a list to retain only those elements that pass a given test.

```ocaml
(* filter : ('a -> bool) -> 'a list -> 'a list
*)
let rec filter test xs =
  match xs with
  | [] -> []
  | x :: xs ->
    (match test x with
     | true  -> x :: filter test xs
     | false -> filter test xs)
```

#### Folding/Reducing Lists

Another common computational pattern involving lists is combining the elements of a list together into a single value. For example, we may wish to find the largest integer in a list:

```ocaml
(* maxList : int list -> int
*)
let rec maxList ns =
  match ns with
  | [] -> min_int
  | n :: ns -> max n (maxList ns)
```

Or, we may wish to add a list of floats:

```ocaml
(* addAll : float list -> float
*)
let rec addAll ns =
  match ns with
  | [] -> 0.0
  | n :: ns -> (+.) n (addAll ns)
```

or we may wish to concatenate a list of strings:

```ocaml
(* concatAll : string list -> string
 *)
let rec concatAll strings =
  match strings with
  | [] -> ""
  | string :: strings -> (^) string (concatAll strings)
```

**Folding Left and Right**

There are two ways to fold a list: folding left and folding right. (NB: In some languages (e.g., Python) fold is called reduce.) Each method requires an input function `f`, a list `xs` and an identity element `id`.

```ocaml
(* fold_left : ('a -> 'b -> 'a) -> 'a -> 'b list -> 'a
*)
let rec fold_left (f : 'a -> 'b -> 'a) (id : 'a) (xs : 'b list) : 'a =
  match xs with
  | [] -> id
  | x :: xs -> fold_left f (f id x) xs
```

```ocaml
(* fold_right : ('a -> 'b -> 'b) -> 'a list -> 'b -> 'b
*)
let rec fold_right (f : 'a -> 'b -> 'b) (xs : 'a list) (id : 'b) : 'b =
  match xs with
  | [] -> id
  | x :: xs -> f x (fold_right f xs id)
```

These two alternatives combine values in different orders. For example, using `a`, `b`, `c` and `d` as values of the same type, we see that calls of `fold_left` and `fold_right` simplify as in:

```ocaml
fold_left f d [a; b; c] ->> f (f (f d a) b) c

fold_right f [a; b; c] d ->> f a (f b (f c d))
```

For [associative](https://en.wikipedia.org/wiki/Associative_property) operators such as `+`, `*` or `^` either folding function will do. But for non-associative operators such as `-` and`/` one has to choose the appropriate fold. For example, to subtract off integers  `a` and then `b` and then `c` from integer `k` one could write:

```ocaml
List.fold_left (-) k [a; b; c]
```

 But one could not arrive at this result by writing:

```ocaml
List.fold_right [a; b; c] k
```

The types of the first argument are important too. Is the first argument of type `('a -> 'b -> 'a)` or is it of type `('a -> 'b -> 'b)`? Sometimes the latter is what is required.

#### Example: Permutations

As an example of the use of `List.map` and `List.fold_left`, consider a set of $k$ symbols $A = \{a_1, …, a_k\}$ and the problem of producing all length $n$ permutations of symbols from $A$. As we've noted, there are $k^n$ of them. We write

```ocaml
(* permutations : 'a list -> int -> 'a list list

 The call (permutations syms n) returns all length n permutations of symbols in syms. For
 example, the call (permutations [0; 1] 2) returns the list [[0; 0]; [0; 1]; [1; 0]; [1; 1]].
 *)
let rec permutations symbols n =
  match n = 0 with
  | true  -> [[]]
  | false ->
    let previous = permutations symbols (n - 1) in
    let oneMore  = List.map (fun sym -> (List.map (fun perm -> sym :: perm) previous)) symbols
    in
    List.fold_left (@) [] oneMore
```


## 4. Modules

In many programming languages, definitions that are inherently related to one another can be packaged up in *modules*. Consider an implementation of rational numbers — numbers such as $1/3$ that can be expressed as the ratio of two integers. An implementation of rational numbers would require some representation type, in OCaml, by convention this is often called simply `t`,  together with whatever operations one might want for working with rational numbers.

For the purposes of illustration, let's specify an implementation of rationals with type signatures for the following 4 operations. In OCaml, we would house this specification, a *module signature*, in an *interface* file with the `.mli` extension, say in the file `rational.mli`:

```ocaml
type t

val make : int -> int -> t
val add : t -> t -> t
val compareTo : t -> t -> int
val toString : t-> string
```
A module `Rational` implementing this specification would then be stored in a companion file `rational.ml` (NB: the specification is in a `.mli` file and the implementation is in a `.ml` file.)

```ocaml
type t = { numerator : int     (* Choosing to represent a rational number as a record. *)
         ; denominator : int
         }

let rec gcd m n =
  match n = 0 with
  | true  -> m
  | false -> gcd n (m mod n)

let make numerator denominator =
  let gcd = gcd numerator denominator
  in
  match denominator < 0 with
  | true  ->
    { numerator = - (numerator / gcd)
    ; denominator = - (denominator / gcd)
    }
  | false ->
    { numerator = numerator / gcd
    ; denominator = denominator / gcd
    }

let add {numerator=n1; denominator=d1} {numerator=n2; denominator=d2} =
  { numerator   = n1 * d2 + n2 * d1
  ; denominator = d1 * d2
  }

let compareTo rat1 rat2 =
  let a = rat1.numerator * rat2.denominator in
  let b = rat1.denominator * rat2.numerator
  in
  a - b

let toString {numerator; denominator} =
  (string_of_int numerator) ^ "/" ^ (string_of_int denominator)
```

When compiled as in

```
> ocamlc rational.mli rational.ml -o rational
> ls
rational*          rational.cmi    rational.cmo    rational.ml     rational.mli
```

The compiler will check to ensure that the implementation satisfies the specification. The file `rational*` is the linked and executable byte-code object file, the file `rational.cmi` is the compiled interface file, the file `rational.cmo` is the (unlinked) byte-code object file resulting from the compilation of the source file `rational.ml`.

Then one could use the module as in

```ocaml
open Rational

let r1 = Rational.make 1 3
let r2 = Rational.make 3 5
let r3 = Rational.add r1 r2

print_string (Rational.toString r3)
```

#### Modules in One File

In OCaml the module specification and module implementation can also be defined in one file as follows.

```ocaml
module type RATIONAL =
  sig
    type t
    val make : int -> int -> t
    val add : t -> t -> t
    val compareTo : t -> t -> int
    val toString : t-> string
  end

module Rational : RATIONAL =
  struct
    type t = {numerator : int; denominator : int}
    ...
  end
```

## 5. Solutions to Exercises

1. Write  a function `coinFlip : unit -> string` that has a 50/50 chance of returning `"heads"` or `"tails"`.

   ```ocaml
   let coinFlip () =
     match Random.int 2 = 0 with
     | true  -> "heads"
     | false -> "tails"
   ```

2. Write the function `power : int -> int -> int` such that a call `(power m n)` returns `m` raised to the `n`.

   ```ocaml
   let rec power m n =
     match n = 0 with
     | true  -> 1
     | false -> m * power m (n - 1)
   ```

   ```ocaml
   let rec power m n =
     if n = 0 then 1 else m * power m (n - 1)
   ```

   ```ocaml
   let power m n =
     let rec fastLoop n answer =
       match n = 0 with
       | true  -> answer
       | false -> fastloop (n - 1) (m * answer)
     in
     fastLoop n 1  
   ```

3. Write a function `range : int -> int list` such that a call `(range n)` returns an ascending list `[0; …; n - 1]`.

   ```ocaml
   let range n =
     let rec loop i answer =
       match i = n with
       true  -> answer
       false -> loop (i - 1) (i :: answer)
     in
     loop 0 []
   ```

   ​

   ​
