






(* What else needs to go in here, what is the complete interface that frex exposes? *)
(* missing dyn *)
(* missing cd :: t -> l code should be based of eva' *)
module type ClearInterface = sig
  type t (* :: Coprod algebra a b also known as free extension*)
  type l (* :: algebra of the basic thing *)
  type evaOut
  (* l Aux.var this is the free object, feels general enough ... that this uses Aux.var*)
  (* is it necessary to wrap l Aux.var in another type? *)
  val sta' : l -> t (* this is correct maps algebra into free extension*)
  val var' : l Aux.var -> t (* maps free object into free extension *)
  (* val eva' : (l -> 'a) -> (l Aux.var -> 'a) -> t -> 'a *) (* can make 'a an "Any" type *)
  val eva' : (l -> evaOut) -> (l Aux.var -> evaOut) -> t -> evaOut

end
