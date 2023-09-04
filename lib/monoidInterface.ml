open Monoids;;
open Algebra;;



(*
implicit module To_Code {A : Algebra.MONOID} : Algebra.MONOID with type t = A.t code = struct 
  type t = A.t code
  let unit = .<A.unit>.
  let (<*>) x y =  .<A.( .~x <*> .~y )>.
end
*)

(* This has been moved to common interface*)
(* This needs to be a more general interface in a different file*)
module type ClearInterface = sig
  type t (* :: Coprod algebra a b also known as free extension*)
  type l (* :: algebra of the basic thing *)
  (* l Aux.var this is the free object, feels general enough ... that this uses Aux.var*)
  val sta' : l -> t (* this is correct maps algebra into free extension*)
  val var' : l Aux.var -> t (* maps free object into free extension *)
  (* val eva' : (l -> 'a) -> (l Aux.var -> 'a) -> t -> 'a *) (* can make 'a an "Any" type *)
  val eva' : (l -> l code list) -> (l Aux.var -> l code list) -> t -> l code list

end

let sta' {C : ClearInterface} = C.sta'
let var' {C : ClearInterface} = C.var'
let eva' {C : ClearInterface} = C.eva'

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
      let eva' =     let module E = Eva(struct module Op = struct
                              type t = A.T.t code list (* here just need to state that the output being used is ... *)
                              let unit = []
                              let (<*>) = (@)
                            end
                      module T = struct type t = A.T.t code list end
                            end) in E.eva
                              (* want to replace "code list" with any algebra
                        Is this neccesarry ^, seems for monoid you will always use a code list *)
    end
  end 