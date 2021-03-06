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


let show = function
  | LocalReturn -> "LocalReturn"
  | Logging -> "Logging"
  | RemoteCodeExecution -> "RemoteCodeExecution"
  | SQL -> "SQL"
  | Thrift -> "Thrift"
  | Test -> "Test"
  | XMLParser -> "XMLParser"


let create = function
  | "LocalReturn" -> LocalReturn
  | "Logging" -> Logging
  | "RemoteCodeExecution" -> RemoteCodeExecution
  | "SQL" -> SQL
  | "Test" -> Test
  | "Thrift" -> Thrift
  | "XMLParser" -> XMLParser
  | name -> failwith (Format.sprintf "Unsupported taint sink %s" name)
