open Ctypes

open Tcbdb

module OpenMode = struct
  type t = READER
         | WRITER
         | CREAT
         | TRUNC
         | NOLCK
         | LCKNB
         | TSYNC

  let to_int = function
    | READER -> bDBOREADER
    | WRITER -> bDBOWRITER
    | CREAT -> bDBOCREAT
    | TRUNC -> bDBOTRUNC
    | NOLCK -> bDBONOLCK
    | LCKNB -> bDBOLCKNB
    | TSYNC -> bDBOTSYNC
end

type t = tCBDB ptr

let new_ = tcbdbnew
let del = tcbdbdel

let check t = function
  | 1 -> ()
  | _ ->
      let c = tcbdbecode t in
      let m = tcbdberrmsg c in
      raise (Error.of_int m c)

let wrap0 fn = fun t ->
  let r = fn t in
  check t r

let wrap2 fn = fun t a b ->
  let r = fn t a b in
  check t r

let wrap4 fn = fun t a b c d ->
  let r = fn t a b c d in
  check t r

let set_mutex = wrap0 tcbdbsetmutex

let open_ t p f =
  let f' = List.fold_left (fun a b -> a lor OpenMode.to_int b) 0 f in
  let r = tcbdbopen t p f' in
  check t r

let close = wrap0 tcbdbclose

let put t k v =
  let k' = coerce string (ptr char) k
  and kl = String.length k
  and v' = coerce string (ptr char) v
  and vl = String.length v in
  wrap4 tcbdbput t k' kl v' vl

let out t k =
  let k' = coerce string (ptr char) k
  and kl = String.length k in
  wrap2 tcbdbout t k' kl

let get3 t k =
  let k' = coerce string (ptr char) k
  and kl = String.length k
  and sp = allocate int 0 in
  match tcbdbget3 t k' kl sp with
    | None -> None
    | Some p ->
        (* TODO Might be more efficient by using what's in `sp` instead of
         * depending on null-termination? *)
        let r = coerce (ptr char) string p in
        Some r

let tranbegin = wrap0 tcbdbtranbegin
let trancommit = wrap0 tcbdbtrancommit
let tranabort = wrap0 tcbdbtranabort

module Cur = struct
  type db = t
  type t = bDBCUR ptr

  let new_ = tcbdbcurnew
  let del = tcbdbcurdel

  let wrap0 fn = fun t ->
    match fn t with
      | 1 -> true
      | 0 -> false
      | _ -> failwith "Invalid bool value"

  let first = wrap0 tcbdbcurfirst
  let last = wrap0 tcbdbcurlast
  let jump t k =
    let k' = coerce string (ptr char) k
    and kl = String.length k in
    match tcbdbcurjump t k' kl with
      | 1 -> true
      | 0 -> false
      | _ -> failwith "Invalid bool value"
  let prev = wrap0 tcbdbcurprev
  let next = wrap0 tcbdbcurnext
  let key3 t =
    let sp = allocate int 0 in
    match tcbdbcurkey3 t sp with
      | None -> None
      | Some p ->
          (* TODO See get3 *)
          let s = coerce (ptr char) string p in
          Some s
  let val3 t =
    let sp = allocate int 0 in
    match tcbdbcurval3 t sp with
      | None -> None
      | Some p ->
          (* TODO See get3 *)
          let s = coerce (ptr char) string p in
          Some s
end
