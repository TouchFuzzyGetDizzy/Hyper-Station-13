#define DEFAULT_SLOT_AMT	2
#define HANDS_SLOT_AMT		2
#define BACKPACK_SLOT_AMT	4

/datum/preferences
	//gear
	var/gear_points = 10
	var/list/gear_categories
	var/list/chosen_gear
	var/gear_tab

	//pref vars
	var/screenshake = 100
	var/damagescreenshake = 2
	var/arousable = TRUE
	var/widescreenpref = TRUE
	var/autostand = TRUE
	var/auto_ooc = FALSE
	//var/lewdchem = TRUE replaced with new prefs

	//vore prefs
	var/toggleeatingnoise = TRUE
	var/toggledigestionnoise = TRUE
	var/hound_sleeper = TRUE
	var/cit_toggles = TOGGLES_CITADEL

	//Hyper prefs
	var/noncon = FALSE  //Definitely want this off by default

	// stuff that was in base
	max_save_slots = 20


/datum/preferences/New(client/C)
	..()
	LAZYINITLIST(chosen_gear)

/datum/preferences/proc/is_loadout_slot_available(slot)
	var/list/L
	LAZYINITLIST(L)
	for(var/i in chosen_gear)
		var/datum/gear/G = i
		var/occupied_slots = L[slot_to_string(initial(G.category))] ? L[slot_to_string(initial(G.category))] + 1 : 1
		LAZYSET(L, slot_to_string(initial(G.category)), occupied_slots)
	switch(slot)
		if(SLOT_IN_BACKPACK)
			if(L[slot_to_string(SLOT_IN_BACKPACK)] < BACKPACK_SLOT_AMT)
				return TRUE
		if(SLOT_HANDS)
			if(L[slot_to_string(SLOT_HANDS)] < HANDS_SLOT_AMT)
				return TRUE
		else
			if(L[slot_to_string(slot)] < DEFAULT_SLOT_AMT)
				return TRUE

datum/preferences/copy_to(mob/living/carbon/human/character, icon_updates = 1)
	..()
	character.give_genitals(TRUE)
	character.ooc_text = features["ooc_text"] //Let's update their flavor_text at least initially
	character.canbearoused = arousable
	//character.client?.prefs.lewdchem = lewdchem
	if(icon_updates)
		character.update_genitals()
