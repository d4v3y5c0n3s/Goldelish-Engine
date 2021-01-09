(*
###  g_entity.sats  ###

This is an interface for interacting with entities
*)

staload "./g_engine.sats"

#define MAX_ENTITIES 512

absvt@ype entity_table

absvt@ype animated_object
abst@ype camera
absvt@ype instance_object
absvt@ype landscape
abst@ype light
absvt@ype particles
absvt@ype physics_object
absvt@ype static_object

datavtype ENTITY =
| entity_empty of ()
| entity_AO of animated_object
| entity_C of camera
| entity_IO of instance_object
| entity_LD of landscape
| entity_LT of light
| entity_P of particles
| entity_PO of physics_object
| entity_SO of static_object

vtypedef entity = ENTITY

fn entity_table_init () : entity_table
fn entity_table_finish ( entity_table ) : void

fn{a:vt@ype} entity_new ( !entity_table, string ) : void

fn{a:vt@ype} entity_exists ( !entity_table, string ) : bool
fn{a:vt@ype} entity_get ( !entity_table, string ) : Option_vt(a)
fn{a:vt@ype} entity_delete ( !entity_table, string ) : void
