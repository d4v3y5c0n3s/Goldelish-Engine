(* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. *)
(*
### skeleton.sats  ###

defines a skeleton for 3D animations
*)

staload "./../g_engine.sats"

typedef frame = @{
	joint_count=int,
	joint_parents=(*int*) ptr,
	joint_positions=(*vec3 *)ptr,
	joint_rotations=(*quat*) ptr,
	transforms=(*mat4*) ptr,
	transforms_inv=(*mat4*) ptr
}

fun frame_new () : (*frame*) ptr = "sta#%"
fun frame_copy ( f: (*frame*) ptr ) : (*frame*) ptr = "sta#%"
fun frame_interpolate ( f0: (*frame*) ptr, f1: (*frame*) ptr, amount: float ) : (*frame*) ptr = "sta#%"
fun frame_copy_to ( f: (*frame*) ptr, out: (*frame*) ptr ) : void = "sta#%"
fun frame_interpolate_to ( f0: (*frame*) ptr, f1: (*frame*) ptr, amount: float, out: (*frame*) ptr ) : void = "sta#%"
fun frame_decendants_to ( f0: (*frame*) ptr, f1: (*frame*) ptr, amount: float, joint: int, out: (*frame*) ptr ) : void = "sta#%"
fun frame_delete ( f: (*frame*) ptr ) : void = "sta#%"

fun frame_joint_transform ( f: (*frame*) ptr, i: int ) : mat4 = "sta#%"
fun frame_joint_add ( f: (*frame*) ptr, parent: int, position: vec3, rotation: quat ) : void = "sta#%"

fun frame_gen_transforms ( f: (*frame*) ptr ) : void = "sta#%"
fun frame_gen_inv_transforms ( f: (*frame*) ptr ) : void = "sta#%"

typedef skeleton = @{ joint_count=int, joint_names=string, rest_pose=(*frame*) ptr }

fun skeleton_new () : (*skeleton*) ptr = "sta#%"
fun skeleton_delete ( s: (*skeleton*) ptr ) : void = "sta#%"
fun skeleton_joint_add ( s: (*skeleton*) ptr, name: string, parent: int ) : void = "sta#%"
fun skeleton_joint_id ( s: (*skeleton*) ptr, name: string ) : int = "sta#%"

fun skl_load_file ( filename: string ) : (*skeleton*) ptr = "sta#%"
