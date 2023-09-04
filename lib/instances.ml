open Aux;;
open Monoids;;
open Algebra;;
open Monads;;

(*
implicit module String_monoid : Algebra.MONOID with type t = string = struct 
  type t = string 
  let unit = ""
  let (<*>) = (^)
end 
*)

implicit module To_Code {A : Algebra.MONOID} : Algebra.MONOID with type t = A.t code = struct 
  type t = A.t code
  let unit = .<A.unit>.
  let (<*>) x y =  .<A.( .~x <*> .~y )>.
end