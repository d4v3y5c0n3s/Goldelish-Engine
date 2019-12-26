(*
###  g_asset.dats  ###

source file for dealing with assets
*)

staload "g_asset.sats"

staload "data/dict.sats"
staload "data/list.sats"

datatype MAX_ASSET =
	 | MAX_ASSET_HANDLERS of 512
	 | MAX_PATH_VARIABLES of 512

typedef asset_handler = @{
	type=type_id, extension=char ptr, load_func=char ptr -> ptr, del_func=void
}

val asset_handlers: asset_handler = //[MAX_ASSET.MAX_ASSET_HANDLERS]
val num_asset_handlers = 0

typedef path_variable = @{
	variable=fpath, mapping=fpath
}

val path_variables: path_variable = //[MAX_PATH_VARIABLES]
val num_path_variables = 0

implement
asset_add_path_variable ( variable, mapping ) =
(
			if num_path_variables == MAX_PATH_VARIABLES then error("Already reached maximum num of path variables (%i)", MAX_PATH_VARIABLES)
			if variable.ptr[0] != '$' then error("Variables must start with a dollar sign e.g. '$CORANGE'")
			val pv: path_variable = { variable, mapping }//  WIP
			path_variables[num_path_variables] := pv//  WIP
			num_path_variables = num_path_variables + 1
)