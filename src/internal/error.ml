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

open Tcutil

let of_int m = function
  | r when r = tCESUCCESS -> SUCCESS m
  | r when r = tCETHREAD -> THREAD m
  | r when r = tCEINVALID -> INVALID m
  | r when r = tCENOFILE -> NOFILE m
  | r when r = tCENOPERM -> NOPERM m
  | r when r = tCEMETA -> META m
  | r when r = tCERHEAD -> RHEAD m
  | r when r = tCEOPEN -> OPEN m
  | r when r = tCECLOSE -> CLOSE m
  | r when r = tCETRUNC -> TRUNC m
  | r when r = tCESYNC -> SYNC m
  | r when r = tCESTAT -> STAT m
  | r when r = tCESEEK -> SEEK m
  | r when r = tCEREAD -> READ m
  | r when r = tCEWRITE -> WRITE m
  | r when r = tCEMMAP -> MMAP m
  | r when r = tCELOCK -> LOCK m
  | r when r = tCEUNLINK -> UNLINK m
  | r when r = tCERENAME -> RENAME m
  | r when r = tCEMKDIR -> MKDIR m
  | r when r = tCERMDIR -> RMDIR m
  | r when r = tCEKEEP -> KEEP m
  | r when r = tCENOREC -> NOREC m

  | _ -> MISC m
