(** Copyright (c) 2016-present, Facebook, Inc.

    This source code is licensed under the MIT license found in the
    LICENSE file in the root directory of this source tree. *)

open Ast
open Expression


(** Roots representing parameters, locals, and special return value in models. *)
module Root : sig
  type t =
    | LocalResult (* Special root representing the return value location. *)
    | Parameter of { position: int }
    | Variable of Identifier.t
  [@@deriving compare, sexp, show, hash]
end


type t = {
  root: Root.t;
  path: AccessPathTree.Label.path;
}

val create: Root.t -> AccessPathTree.Label.path -> t

val of_accesses: Access.t -> t option

val of_expression: Expression.t -> t option

val get_index: Expression.t -> AccessPathTree.Label.t

type normalized_expression =
  | Access of { expression: normalized_expression; member: Identifier.t }
  | Call of {
      callee: normalized_expression;
      arguments: Argument.t list Node.t;
    }
  | Index of {
      expression: normalized_expression;
      index: AccessPathTree.Label.t;
      original: Identifier.t;
      arguments: ((Expression.t Argument.record) list) Node.t;
    }
  | Global of Access.t
  | Local of Identifier.t
  | Expression of Expression.t
[@@deriving show]

val normalize_access: Access.t -> normalized_expression

val as_access: normalized_expression -> Access.t

val to_json: t -> Yojson.Safe.json
