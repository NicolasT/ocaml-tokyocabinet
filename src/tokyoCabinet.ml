module Error : sig
  exception SUCCESS of string
  exception THREAD of string
  exception INVALID of string
  exception NOFILE of string
  exception NOPERM of string
  exception META of string
  exception RHEAD of string
  exception OPEN of string
  exception CLOSE of string
  exception TRUNC of string
  exception SYNC of string
  exception STAT of string
  exception SEEK of string
  exception READ of string
  exception WRITE of string
  exception MMAP of string
  exception LOCK of string
  exception UNLINK of string
  exception RENAME of string
  exception MKDIR of string
  exception RMDIR of string
  exception KEEP of string
  exception NOREC of string

  exception MISC of string
end = Tokyocabinet_internal.Error

module BDB : sig
  module OpenMode : sig
    type t = READER
           | WRITER
           | CREAT
           | TRUNC
           | NOLCK
           | LCKNB
           | TSYNC
  end

  type t

  val new_ : unit -> t option
  val del : t -> unit

  val set_mutex : t -> unit

  val open_ : t -> string -> OpenMode.t list -> unit
  val close : t -> unit

  val put : t -> string -> string -> unit
  val out : t -> string -> unit
  val get3 : t -> string -> string option

  val tranbegin : t -> unit
  val trancommit : t -> unit
  val tranabort : t -> unit

  module Cur : sig
    type db = t
    type t

    val new_ : db -> t
    val del : t -> unit
    val first : t -> bool
    val last : t -> bool
    val jump : t -> string -> bool
    val prev : t -> bool
    val next : t -> bool
    val key3 : t -> string option
    val val3 : t -> string option
  end
end = Tokyocabinet_internal.BDB
