(** Copyright (c) 2016-present, Facebook, Inc.

    This source code is licensed under the MIT license found in the
    LICENSE file in the root directory of this source tree. *)


type t =
  | LocalReturn  (* Special marker to infer function in-out behavior *)
  | Logging
  | RemoteCodeExecution
  | SQL
  | Test
  | Thrift
  | XMLParser
[@@deriving compare, eq, sexp, show, hash]

val create: string -> t
