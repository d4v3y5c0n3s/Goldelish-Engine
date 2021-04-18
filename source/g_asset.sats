(*
###  g_asset.sats  ###

This defines what an asset is in the context of the engine.
*)

staload "./g_engine.sats"

//  storable asset handle
absvt@ype asset_hndl (a:vt@ype)

fn{a:vt@ype} file_load ( filename: !fpath ): a
fn file_exists ( filename: !fpath ): bool

fn{a:vt@ype} asset_delete ( x: a ) : void

fn{a:vt@ype} asset_get ( filename: !fpath ): a

vtypedef asset_hndl_out_get_path (a:vt@ype) = [l:addr] @{ path=ptr, x=(a @ l, mfree_gc_v(l) | ptr l) }
vtypedef asset_hndl_out_get_asset (a:vt@ype) = [l:addr] @{ path=fpath, x=(unit_p, unit_p | ptr l) }
fn{a:vt@ype} asset_hndl_new ( filename: fpath ): asset_hndl(a)
fn{a:vt@ype} asset_hndl_get_path ( ah: !asset_hndl(a) >> asset_hndl_out_get_path(a) ): fpath
fn{a:vt@ype} asset_hndl_get_asset ( ah: !asset_hndl(a) >> asset_hndl_out_get_asset(a) ): a
fn{a:vt@ype} asset_hndl_set_path ( ah: &asset_hndl(a), path: fpath ): void
fn{a:t@ype} asset_hndl_set_asset ( ah: &asset_hndl(a), x: a ): void

fn map_fullpath ( filename: !fpath ): fpath
fn map_shortpath ( filename: !fpath ): fpath
