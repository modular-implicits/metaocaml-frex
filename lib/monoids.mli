module S : Aux.Sig with module Ops := Algebra.Monoid_ops

module Coproduct_monoid (A : S.Algebra) (B : S.Algebra) :
  S.COPRODUCT with module A.T = A.T with module B.T = B.T

module Free_monoid (A : Algebra.TYPE) :
  Algebra.MONOID with type t = A.t list

module type ClearInterface = sig
  type t
  type l
  val sta' : l -> t
  val var' : l Aux.var -> t
end

module PS_monoid' (A : Algebra.MONOID)
    (C : Algebra.MONOID with type t = A.t code) : S.PS with type A.T.t = A.t

module PS_monoid (A : Algebra.MONOID)
    (C : Algebra.MONOID with type t = A.t code) : sig 
      include S.PS with type A.T.t = A.t
      implicit module OpMonoid : Algebra.MONOID with type t = T.t 
      implicit module CI : ClearInterface with type t = T.t and type l = A.T.t end