(*
###  goldelish.dats  ###
*)

#include "goldelish.hats"

//  may not need all of these... reexamine later
datatype SIG_ERR =
| ABRT of ()
| FPE of ()
| ILL of ()
| INT of ()
| SEGV of ()
| TERM of ()
exception SIG_ABRT of ()//  program aborted
exception SIG_FPE of ()//  division by zero
exception SIG_ILL of ()//  illegal instruction
exception SIG_INT of ()//  program interrupted
exception SIG_SEGV of ()//  segmentation fault
exception SIG_TERM of ()//  program terminated

fun corange_signal ( sig: int ) : void =
    case+ of
    | ABRT() => $raise SIG_ABRT()
    | FPE() => $raise SIG_FPE()
    | ILL() => $raise SIG_ILL()
    | INT() => $raise SIG_INT()
    | SEGV() => $raise SIG_SEGV()
    | TERM() => $raise SIG_TERM()

val logout: FILE ptr = ()

fun corange_error ( str: string ) : void =
(

)

fun corange_

fun corange_

implement corange_

implement corange_