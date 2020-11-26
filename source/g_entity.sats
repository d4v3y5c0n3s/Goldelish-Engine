(*
###  g_entity.sats  ###

This is an interface for interacting with entities
*)

staload "./g_engine.sats"
staload "./data/dict.sats"

#define MAX_ENTITIES 512

fn entity_init () : dict//  makes a dictionary for the entities of size MAX_ENTITIES
fn entity_finish ( dict ) : void//  deletes a dictionary (intended for deleting an entity dictionary)

fn{a:vt@ype} entity_new ( string ) : void//  implemented for each entity type

fn entity_exists ( string ) : bool
fn{a:vt@ype} entity_get ( string ) : a//  implemented for each entity type
fn{a:vt@ype} entity_delete ( string ) : void//  implemented for each entity type
