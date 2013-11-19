open TokyoCabinet

let database = "test_bdb.dat"
and open_options = [BDB.OpenMode.WRITER; BDB.OpenMode.CREAT;]

let test_key = "test_key"
and test_value = "test_value"

let main () =
  match BDB.new_ () with
    | None -> failwith "Allocation failure"
    | Some db ->
        BDB.set_mutex db;
        BDB.open_ db database open_options;
        BDB.put db test_key test_value;
        match BDB.get3 db test_key with
          | None ->
              failwith (Printf.sprintf "Key %S not found" test_key)
          | Some v ->
              Printf.printf "%s -> %S (expected: %S)\n" test_key v test_value;

        let c = BDB.Cur.new_ db in
        let rec dump cur =
          let k = BDB.Cur.key3 cur
          and v = BDB.Cur.val3 cur in
          begin match (k, v) with
            | (Some k', Some v') ->
                Printf.printf "%S => %S\n" k' v'
            | _ ->
                failwith "NULL key or value from cursor"
          end;

          if BDB.Cur.next cur
            then dump cur
            else ()
        in
        if BDB.Cur.first c
          then dump c
          else ();
        BDB.Cur.del c;

        BDB.out db test_key;
        BDB.close db;
        BDB.del db
;;

main ()
