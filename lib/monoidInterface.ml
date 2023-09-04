open Monoids;;
open Algebra;;



(*
implicit module To_Code {A : Algebra.MONOID} : Algebra.MONOID with type t = A.t code = struct 
  type t = A.t code
  let unit = .<A.unit>.
  let (<*>) x y =  .<A.( .~x <*> .~y )>.
end
*)

module type ClearInterface = sig
  type t
  type l
  val sta' : l -> t
  val var' : l Aux.var -> t
end

let sta' {C : ClearInterface} = C.sta'
let var' {C : ClearInterface} = C.var'

module CreateInterface (A : MONOID) (B : MONOID with type t = A.t code) : sig 
  include S.PS with type A.T.t = A.t 
  implicit module OpMonoid : MONOID with type t = T.t 
  implicit module CI : ClearInterface with type t = T.t and type l = A.T.t 
  end = struct 
  
    module PS = PS_monoid(A)(B) 
    include PS

    implicit module OpMonoid : MONOID with type t = T.t = struct
      type t = T.t
      let unit = Op.unit
      let (<*>) = Op.(<*>)
    end 

    implicit module CI : ClearInterface with type t = T.t and type l = A.T.t = struct
      type t = T.t
      type l = A.T.t
      let sta' = PS.sta
      let var' = PS.var
    end
  end 