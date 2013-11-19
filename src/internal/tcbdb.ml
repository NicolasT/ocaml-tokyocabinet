open Ctypes
open Foreign

open Ctypes_extra

let bDBOREADER = 1 lsl 0
let bDBOWRITER = 1 lsl 1
let bDBOCREAT = 1 lsl 2
let bDBOTRUNC = 1 lsl 3
let bDBONOLCK = 1 lsl 4
let bDBOLCKNB = 1 lsl 5
let bDBOTSYNC = 1 lsl 6

type tCBDB = unit
let tCBDB : tCBDB typ = void

let tcbdberrmsg = foreign "tcbdberrmsg" (int @-> returning string)

let tcbdbnew = foreign "tcbdbnew" (void @-> returning (ptr_opt tCBDB))
let tcbdbdel = foreign "tcbdbdel" (ptr tCBDB @-> returning void)

let tcbdbecode = foreign "tcbdbecode" (ptr tCBDB @-> returning int)

let tcbdbsetmutex = foreign "tcbdbsetmutex" (ptr tCBDB @-> returning bool)

let tcbdbopen = foreign "tcbdbopen" (ptr tCBDB @-> string @-> int @-> returning bool)
let tcbdbclose = foreign "tcbdbclose" (ptr tCBDB @-> returning bool)

let tcbdbput = foreign "tcbdbput" (ptr tCBDB @-> ptr char @-> int @-> ptr char @-> int @-> returning bool)
let tcbdbout = foreign "tcbdbout" (ptr tCBDB @-> ptr char @-> int @-> returning bool)
let tcbdbget3 = foreign "tcbdbget3" (ptr tCBDB @-> ptr char @-> int @-> ptr int @-> returning (ptr_opt char))

let tcbdbtranbegin = foreign "tcbdbtranbegin" (ptr tCBDB @-> returning bool)
let tcbdbtrancommit = foreign "tcbdbtrancommit" (ptr tCBDB @-> returning bool)
let tcbdbtranabort = foreign "tcbdbtranabort" (ptr tCBDB @-> returning bool)


type bDBCUR = unit
let bDBCUR : bDBCUR typ = void

let tcbdbcurnew = foreign "tcbdbcurnew" (ptr tCBDB @-> returning (ptr bDBCUR))
let tcbdbcurdel = foreign "tcbdbcurdel" (ptr bDBCUR @-> returning void)
let tcbdbcurfirst = foreign "tcbdbcurfirst" (ptr bDBCUR @-> returning bool)
let tcbdbcurlast = foreign "tcbdbcurlast" (ptr bDBCUR @-> returning bool)
let tcbdbcurjump = foreign "tcbdbcurjump" (ptr bDBCUR @-> ptr char @-> int @-> returning bool)
let tcbdbcurprev = foreign "tcbdbcurprev" (ptr bDBCUR @-> returning bool)
let tcbdbcurnext = foreign "tcbdbcurnext" (ptr bDBCUR @-> returning bool)
let tcbdbcurkey3 = foreign "tcbdbcurkey3" (ptr bDBCUR @-> ptr int @-> returning (ptr_opt char))
let tcbdbcurval3 = foreign "tcbdbcurval3" (ptr bDBCUR @-> ptr int @-> returning (ptr_opt char))
