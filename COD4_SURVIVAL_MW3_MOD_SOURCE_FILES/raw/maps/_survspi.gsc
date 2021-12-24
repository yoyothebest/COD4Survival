#include maps\_anim;
#include maps\_utility;
#include common_scripts\utility;
#include maps\_utility_code;
#include maps\_hud_util;
#include maps\_vehicle;
#include maps\_vehicle_aianim;

//SURVIVAL MODE.

/*

fix: ui_screen_trans_out

=======================
Known bugs or problems:
=======================

> It is likely that the Red Airstrike Smoke would pop out normal smoke as well. Very low possibilities but likely.
> It is also likely that some NPCs can be seen spawning.
> The Jet Airstrike Marker can be called off map even on the skybox
> Juggernauts have a few seconds delay before the juggernaut logic is applied to them once they land.
> The all health values stay the same atfer wave 20.
> Player can instantly die if he cook a grenade for too long even if he has last stand.
> The damage system isnt roughly tested but it seems to work fine. 
  Every weapon has different stats so the damage testing may differ 
  form user to user and it may not feel like WM3.
> There are plenty of leftover functions from features I either cancelled or commented to keep it more like MW3.
  Such functions are, the dog system which needs more work I can not do.
  The Ally Helicopter overwatch air support killstreak which I don't want to work on at all.
  Various perks and weapons.
  And finally the Hero Team Reinforcement. Which is pretty easy to bring back and completely functional.
> Shotgun enemies use a different set of animations which sometimes can make the NPC model stretch horizontally and look very odd. 
  That's a COD4 related bug. Not mine. Just so you know in case you come across it.
> There may be more I forgot to mention.
> I haven't included the solo helicopter announcer voiceover. He may say "multiple helis incoming" when just 1 comes.
> CL_ParseServerMessage: Illegible server message => Didn't show up anymore.

==========================
The Script is splitted in big Categories
in order to make browsing easier:
==========================

//CATEGORY 1: HITMARKER POINTS AND HUD
//CATEGORY 2: HUD WAVE HUD SCORE
//CATEGORY 3: WAVE THINK WAVE LOGIC WAVE CYCLES
//CATEGORY 4: NPC AI ENEMIES ALLIES SETUP
//CATEGORY 5: HELICOPTERS SETUP
//CATEGORY 6: ARMORIES ARMORY CODE
//CATEGORY 7: WEAPON STUFF
//CATEGORY 8: PLAYER HEALTH & PERKS
//CATEGORY 9: KILLSTREAKS
//CATEGORY 10: TOOLS


//Additional stuff to load in zone for mw3 mod

weapon,sp/smoke_marker
material,hudicon_american
material,hudicon_riot
material,icon_riot
material,icon_american
material,hud_self_revive_so
material,icon_vests
material,icon_ac130
material,icon_airstrike
xmodel,viewmodel_mw3_delta
xmodel,viewmodel_mw3_delta_player
xmodel,mw3_jugg_exp

material,armory_hudicon_weapons
material,armory_hudicon_equipment
material,armory_hudicon_support

xanim,Juggernaut_stand_idle
xanim,Juggernaut_aim5
xanim,Juggernaut_stand_reload
xanim,juggernaut_walkF

*/

survspi_init() // call before load main of your map
{

	// Shaders
	precacheShader( "weapon_m16a4" );
	precacheShader( "weapon_m16a4_gl" );
	precacheShader( "weapon_ak47" );
	precacheShader( "weapon_ak47_gl" );
	precacheShader( "weapon_m4carbine" );
	precacheShader( "weapon_m4carbine_suppressor" );
	precacheShader( "weapon_m4carbine_reflex" );
	precacheShader( "weapon_m4carbine_gl" );
	precacheShader( "weapon_m4carbine_acog" );
	precacheShader( "weapon_g3" );
	precacheShader( "weapon_g36c" );
	precacheShader( "weapon_mp44" );
	precacheShader( "weapon_mp5" );
	precacheShader( "weapon_mp5_reflex" );
	precacheShader( "weapon_mp5_suppressor" );
	precacheShader( "weapon_p90" );
	precacheShader( "weapon_p90_suppressor" );
	precacheShader( "weapon_p90_reflex" );
	precacheShader( "weapon_skorpion" );
	precacheShader( "weapon_aks74u" );
	precacheShader( "weapon_mini_uzi" );
	precacheShader( "weapon_mini_uzi_suppressor" );
	precacheShader( "weapon_m249saw" );
	precacheShader( "weapon_rpd" );
	precacheShader( "weapon_m60e4" );
	precacheShader( "weapon_m14" );
	precacheShader( "weapon_m14_scoped" );
	precacheShader( "weapon_m40a3" );
	precacheShader( "weapon_dragunovsvd" );
	precacheShader( "weapon_barrett50cal" );
	precacheShader( "weapon_remington700" );
	precacheShader( "weapon_aw50" );
	precacheShader( "weapon_winchester1200" );
	precacheShader( "weapon_benelli_m4" );
	precacheShader( "weapon_colt_45" );
	precacheShader( "weapon_m9beretta" );
	precacheShader( "weapon_desert_eagle" );
	precacheShader( "weapon_usp_45" );
	precacheShader( "weapon_usp_45_silencer" );
	precacheShader( "weapon_fraggrenade" );
	precacheShader( "weapon_flashbang" );
	precacheShader( "weapon_c4" );
	precacheShader( "weapon_claymore" );	
	precacheShader( "weapon_rpg7" );
	precacheShader( "weapon_at4" );
	
	precacheShader( "faction_128_usmc" );
	precacheShader( "faction_128_sas" );
	precacheShader( "faction_128_ussr" );
	precacheShader( "faction_128_arab" );
	
	precacheShader( "specialty_armorvest" );
	precacheShader( "specialty_extraammo" );
	precacheShader( "specialty_pistoldeath" );
	
	precacheShader( "specialty_longersprint" );
	precacheShader( "specialty_weapon_rpg" );
	precacheShader( "specialty_fastreload" );
	precacheShader( "specialty_twoprimaries" );
	//Dog
	precachestring(&"SCRIPT_PLATFORM_DOG_DEATH_DO_NOTHING");
	precachestring(&"SCRIPT_PLATFORM_DOG_DEATH_TOO_LATE");
	precachestring(&"SCRIPT_PLATFORM_DOG_DEATH_TOO_SOON");
	precachestring(&"SCRIPT_PLATFORM_DOG_HINT");
	
	precacheshader("hud_dog_melee");
	
	level._effect[ "dog_bite_blood" ]	= loadfx( "impacts/deathfx_dogbite" );
	level._effect[ "deathfx_bloodpool" ]	= loadfx( "impacts/deathfx_bloodpool_view" );
	
	// Armory Icons
	precacheShader( "armory_hudicon_weapons" );
	precacheShader( "armory_hudicon_equipment" );
	precacheShader( "armory_hudicon_support" );
	
	// MW3  icons
	precacheShader( "hudicon_american" );
	precacheShader( "hudicon_riot" );
	precacheShader( "icon_american" );
	precacheShader( "icon_riot" );
	precacheShader( "hud_self_revive_so" );
	precacheShader( "icon_vests" );
	precacheShader( "icon_ac130" );
	precacheShader( "icon_airstrike" );
	
	//failed to work on marker
	precacheShader( "hud_grenadeicon" );
	precacheShader( "specialty_grenadepulldeath" );
	precacheShader( "mtl_perc_martyrdom" );
	precacheShader( "hud_us_grenade" );
	precacheShader( "hud_grenadethrowback" );
	
	precacheShader( "damage_feedback" );
	
	precacheShader( "overlay_hunted_red" );
	
	precacheshader("gradient_center");
	precacheshader("gradient_bottom");
	precacheShader( "rank_bgen1" );

	// Models
	//precacheModel( "viewhands_player_usmc" ); //for dog
	precacheModel( "viewmodel_mw3_delta_player" ); //for dog
	
	precacheModel( "viewmodel_mw3_delta" ); 

	precacheModel( "vehicle_uav_static" );
	precacheModel( "vehicle_ac130_low" );
	precacheModel( "vehicle_mig29_desert_static" );
	precacheModel( "vehicle_mig29_missile_alamo" );
	precacheModel( "tag_flash" );
	precacheModel( "mw3_jugg_exp" );
	
	precacheModel( "weapon_us_smoke_grenade_burnt" );

	// Menus
	precachemenu("survspi_weapons");
	precachemenu("survspi_equipment");
	precachemenu("survspi_support");
	precachemenu("survspi_gameover");
	
	// Weapons/Items
	precacheitem("fraggrenade");
	precacheitem("flash_grenade");
	precacheitem("c4");
	precacheitem("claymore");
	
	precacheitem( "beretta" );
	precacheitem( "usp" );
	precacheitem( "usp_silencer" );
	precacheitem( "colt45" );
	precacheitem( "deserteagle" );
	
	precacheitem( "m16_basic" ); 
	precacheitem( "m16_grenadier" ); 
	precacheitem( "m203" ); 
	
	precacheitem( "ak47" );
	precacheitem( "ak47_grenadier" ); 
	precacheitem( "gp25" ); 
	
	precacheitem( "rpg_player" ); 
	precacheitem( "at4" ); 
	precacheitem( "stinger" ); 

	precacheitem( "m4_grunt" ); // Reflex
	precacheitem( "m4_grenadier" ); // GL Eotech
	precacheitem( "m4_silencer" );  // Reflex SD
	precacheitem( "m4_silencer_acog" ); // Acog SD 	
	precacheitem( "m4m203_acog" );  // Acog GL
	precacheitem( "m4m203_silencer" ); // SD GL
	precacheitem( "m4m203_silencer_reflex" );  // SOPMOD

	precacheitem( "m203_m4" ); 
	precacheitem( "m203_m4_acog" ); 
	precacheitem( "m203_m4_silencer" ); 
	precacheitem( "m203_m4_silencer_reflex" ); 
	precacheitem( "m203_m4_silencer_reflex" ); 

	precacheitem( "m14_scoped" );
	precacheitem( "m14_scoped_ghil" );
	precacheitem( "m14_scoped_woodland" );

	precacheitem( "g3" );
	precacheitem( "g36c" );
	precacheitem( "mp44" );
	
	precacheitem( "mp5" );
	precacheitem( "mp5_silencer" ); 
	precacheitem( "mp5_silencer_reflex" );	 
	
	precacheitem( "skorpion" );
	
	precacheitem( "uzi" );
	precacheitem( "uzi_sd" ); 
	
	precacheitem( "ak74u" );
	
	precacheitem( "p90" );
	precacheitem( "p90_silencer" ); 
	
	precacheitem( "saw" );
	precacheitem( "rpd" );
	precacheitem( "m60e4" );
	precacheitem( "m40a3" );
	precacheitem( "dragunov" );
	precacheitem( "remington700" );
	precacheitem( "barrett" );
	precacheitem( "winchester1200" );
	precacheitem( "m1014" );
	
	precacheItem("smoke_marker");
	precacheItem("airstrike_support");

	maps\_blackhawk::main( "vehicle_blackhawk" );
	maps\_mi17::main( "vehicle_mi17_woodland_fly" );
	maps\_hind::main("vehicle_mi24p_hind_woodland");	
	maps\_hind::main("vehicle_mi24p_hind_desert");	

	animscripts\dog_init::initDogAnimations();

	kill_bonuses = []; // We won't use that because mw3 dosn't use that.
	kill_bonuses[ "head" ] = 50;
	kill_bonuses[ "helmet" ] = 50;
	kill_bonuses[ "neck" ] = 0; //20
	kill_bonuses[ "torso_upper" ] = 0; //10
	kill_bonuses[ "torso_lower" ] = 0; //10
	kill_bonuses[ "right_arm_upper" ] = 0; //5
	kill_bonuses[ "left_arm_lower" ] = 0;
	kill_bonuses[ "right_leg_lower" ] = 0;
	kill_bonuses[ "left_leg_upper" ] = 0; //5
	kill_bonuses[ "right_leg_upper" ] = 0; //5
	kill_bonuses[ "left_leg_lower" ] = 0;
	kill_bonuses[ "left_foot" ] = 0;
	kill_bonuses[ "right_foot" ] = 0;
	kill_bonuses[ "left_hand" ] = 0;
	kill_bonuses[ "left_arm_upper" ] = 0;//5
	kill_bonuses[ "right_hand" ] = 0;
	kill_bonuses[ "right_arm_lower" ] = 0;
	kill_bonuses[ "gun" ] = 0;
	kill_bonuses[ "none" ] = 0;
	level.survspi_locationKillBonus = kill_bonuses;
	
	createthreatbiasgroup( "enemy" );
	createthreatbiasgroup( "allies" );
	createthreatbiasgroup( "player" );

	SetThreatBias( "enemy", "player", 10000 ); //(string) threat bias group for. 2 : (string) threat bias group against. 3 : (int) threat bias value.
	SetThreatBias( "enemy", "allies", 1000 );

// score values
	level.survspi_score = 0;
	level.survspi_total_score = 0;
	level.survspi_score_wave = 0;
	level.survspi_kills = 0;
	level.survspi_kills_wave = 0;
	level.survspi_headshots = 0;
	level.survspi_headshots_wave = 0;
	level.survspi_dmg = 0;	
	level.survspi_dmg_total = 0;	
	level.combo_count = 0;
	
	level.survspi_minutes = 0;
	level.survspi_seconds = 0;
	level.survspi_mili_seconds = 1;
	
	level.survspi_wave_minutes = 0;
	level.survspi_wave_seconds = 0;
	level.survspi_wave_mili_seconds = 1;
	
	level.survspi_wave_wave_bonus = 0;
	level.survspi_wave_kills_bonus = 0;
	level.survspi_wave_headshots_bonus = 0;
	
//wave values
	level.survspi_wave = 0;
	level.survspi_waves_completed = 0;
	level.survspi_enemies_left = 0;
	level.survspi_wave_cycles = 0;
	level.survspi_wave_cycle_part = 0;

	level.heavywave = false;
	level.heavywave_type = "jugg";
	level.dog_wave = false;
	level.one_heli = false;
	
	level.survspi_army_state = 0;
	level.survspi_havy_wave_state = 1;	

// player stuff
	level.survival_maxhealth_value = 250;
	level.survival_player_health_multiplier = 1;
	level.player_health_recharge_delay = 1;
	
	level.player_has_vest = true;
	level.player_vest_health = 0;
	level.player_vest_maxhealth = 250;
	
	level.player_hasLastStandPerk = true;
	level.player_isInLastStand = false;
	level.LastStandWeapon = "beretta";

	level.player_hasSprintPerk = false;
	level.player_hasReloadPerk = false;
	level.player_has3GUNPerk = false;

	level.player_hands_assigned = "usmc";
	level.squad_mode = "follow";
	level.squad_type = "";

	thread setup_heli_structs();
	
// misc

	level.hind_heli1_gb = undefined;
	level.hind_heli2_gb = undefined;

	level.reinforcements_active = 0;
	level.air_support_active = 0;

	level.nextGrenadeDrop = 100000; // from mw3, dunno if it works.
	
	//maps\_load::set_player_viewhand_model("viewhands_player_usmc"); //for dogs.
	maps\_load::set_player_viewhand_model("viewmodel_mw3_delta_player"); //for dogs.

// fx

	level._effect["big_explosion"]					= loadfx ("explosions/helicopter_explosion");
	level._effect["tracer_incoming"]				= loadfx ("misc/tracer_incoming");
	level._effect["smoke_grenade_11sec_mp"]				= loadfx ("smoke/smoke_grenade_11sec_mp");
	level._effect["red_smoke"]				= loadfx ("survival/red_smoke");
	
	level._effect["heli_smoke_grey2"]					= loadfx ("smoke/damaged_vehicle_smoke");
	level._effect["heli_smoke_black2"]					= loadfx ("survival/vehicle_damaged_black_smoke");

	
	level.air_support_fx_yellow = loadfx( "misc/ui_pickup_available" );
	level.air_support_fx_red 	= loadfx( "misc/ui_pickup_unavailable" );
	level.fx_airstrike_afterburner = loadfx ("fire/jet_afterburner");
	level.fx_airstrike_contrail = loadfx ("smoke/jet_contrail");

//===
// time	

	if (getdvar("survspi_time") == "")
	setdvar("survspi_time", "0");
	
	if (getdvar("survspi_wave") == "")
	setdvar("survspi_wave", "0");
	
	if (getdvar("survspi_score") == "")
	setdvar("survspi_score", "0");

	if (getdvar("survspi_total_score") == "")
	setdvar("survspi_total_score", "0");
	
	if (getdvar("survspi_headshots") == "")
	setdvar("survspi_headshots", "0");
	
	if (getdvar("survspi_kills") == "")
	setdvar("survspi_kills", "0");
	
	if (getdvar("survspi_minutes") == "")
	setdvar("survspi_minutes", "0");
	
	if (getdvar("survspi_seconds") == "")
	setdvar("survspi_seconds", "0");
	
	if (getdvar("survspi_mili_seconds") == "")
	setdvar("survspi_mili_seconds", "0");

	if (getdvar("survspi_sub_seconds") == "")	
	setdvar("survspi_sub_seconds", "0");

	//wave time
	if (getdvar("survspi_wave_minutes") == "")
	setdvar("survspi_wave_minutes", "0");
	
	if (getdvar("survspi_wave_seconds") == "")
	setdvar("survspi_wave_seconds", "0");
	
	if (getdvar("survspi_wave_mili_seconds") == "")
	setdvar("survspi_wave_mili_seconds", "0");

	if (getdvar("survspi_wave_sub_seconds") == "")	
	setdvar("survspi_wave_sub_seconds", "0");
	
	if (getdvar("survspi_wave_sub_seconds") == "")	
	setdvar("survspi_wave_total_time", "0");

	//--
	
	if (getdvar("spi_devhack") == "")
	setdvar("spi_devhack", "0");
}

survspi_start() // call after load main of your map
{

	thread PLAYER_SURVIVAL_HEALTH();

	thread WAVE_MONEY_HUD();	
	
	thread survspi_hitmarker_init();
	
	thread setup_NPC_spawn_settings(); // down below wave_think();
	
	thread SURVSPI_calc_Mili_Seconds();
	thread SURVSPI_calc_Minutess_Seconds();
	
	thread score_dvar_store_loop();
	
	thread buy_stuff_unlock();

	thread pre_wave(); // STARTS WAVE GAMEPLAY
	
	thread STATS_CALC_WAVE_TOTAL_AND_HUD(); // Waits for wave to end and show wave specific stats
	
	thread remove_dropped_weapons();
	thread no_ai_grenades();
	thread uav_ac130_models();
	
	thread BUYABLE_ENDING();
	
	wait 0.05; 
	thread simple_hud_hide();
	level.early_level[ level.script ] = false;
	level.friendlyFireDisabled = 1;

	//mw3 hands.
	level.player setviewmodel( "viewmodel_mw3_delta" );


	// OPTIONAL!
	thread player_give_body_armor();
	
	// Testing
	thread TEST_health_bar();
	thread SPI_DEV_HACK(); // SCRIPTERS ONLY 

	while(level.survspi_waves_completed < 25 ) wait 0.05;

	thread fake_achivement( "rank_bgen1", &"SURVSPI_ACHIVEMENT_UNLOCKED", &"SURVSPI_ACHIVEMENT_SURVIVOR" );
}

score_dvar_store_loop()
{
	while(1)
	{
		setdvar("survspi_score", level.survspi_score );
		setdvar("survspi_total_score", level.survspi_total_score );
		wait 0.05;
	}
}

/*#########################################
##### DEVELOPER CHEATS FOR SURVIVAL #######
#######################################*/


SPI_DEV_HACK()
{
	thread botkill();
	
	while( 1 )
	{
		if( getdvar("spi_devhack") == "1")
		{
		
		if(	level.player buttonpressed("=") )
		{
			level.survspi_wave++;
			level.survspi_waves_completed++;
			calculate_wave_progression_values();
		}
		else if ( level.player buttonpressed("-") )
		{
			level.survspi_wave--;
			level.survspi_waves_completed--;
		}
		
		if ( level.player buttonpressed("b") )
			level.survspi_score = level.survspi_score+1000;
		else if ( level.player buttonpressed("v") )
			level.survspi_score = level.survspi_score-1000;
		
		}
		wait 0.1;
	}
}

botkill()
{
	while( 1 )
	{
		if( getdvar("spi_devhack") == "1")
		{
			waittill_player_pressed_button("n");
			waittill_player_pressed_button("o");
			waittill_player_pressed_button("t");
			thread kill_all_axis();
		}
		wait 0.05;
	}
}

kill_all_axis()
{
	level.survspi_enemies_left = 0;

	ai = getaiarray( "axis" );
	for( i = 0 ; i < ai.size ; i++ )
	ai[i] dodamage( ai[i].health+999999, ai[i].origin, level.player );


	if(isdefined(level.hind_heli1_gb))
	{	
		
		level.hind_heli1_gb.fake_heli_health = 0;
		getent( "enemy_heli_trigger6", "targetname" ) dodamage( 1, level.hind_heli1_gb.origin );
	}
	if(isdefined(level.hind_heli2_gb))
	{
		level.hind_heli2_gb.fake_heli_health = 0;
		getent( "enemy_heli_trigger7", "targetname" ) dodamage( 1, level.hind_heli2_gb.origin );
	}

	if(isdefined(level.dog_force))
	{
		for( i = 0 ; i < level.dog_force.size ; i++ )
		level.dog_force[i] dodamage( level.dog_force[i].health+999999, level.dog_force[i].origin, level.player );
	}

}

check_cheat_dvar()
{
	for(;;)
	{
		if( getdvar("spi_devhack") == "1")
			return true;
		else if( getdvar("spi_devhack") == "0" )
			return false;
		else
			return false;
		
		return false;
	}
}

//===============================================
//===============================================
//===============================================
//===============================================
//===============================================
//CATEGORY 1: HITMARKER POINTS AND HUD PART 1
//===============================================
//===============================================
//===============================================
//===============================================
//===============================================

survspi_hitmarker_init()
{
	wait 0.05; // Necessary.
	level.global_kill_func = ::survspi_hitmarker_kill;
	level.global_damage_func_ads = ::survspi_hitmarker_damage;
	level.global_damage_func = ::survspi_hitmarker_damage;
}

survspi_hitmarker_damage( type, location, point )
{
	level notify("hitmarker");
	thread survspi_display_hitmarker( false , location);
}

survspi_hitmarker_kill( type, location, point )
{
	level notify("hitmarker");
	thread survspi_display_hitmarker( true , location );
}

survspi_hitmarker_destroy()
{
    level notify("hitmarker");
    if (isDefined(level.hud_hitmarker))
        level.hud_hitmarker destroy();
}

survspi_display_hitmarker( iskill, location )
{
	survspi_hitmarker_destroy();
	level endon("hitmarker");
	level.hud_hitmarker = newHudElem();
	level.hud_hitmarker.horzAlign = "center";
	level.hud_hitmarker.vertAlign = "middle";
	level.hud_hitmarker.x = -12;
	level.hud_hitmarker.y = -12;
	level.hud_hitmarker.alpha = 1;
	level.hud_hitmarker.foreground = 1;
	
	if(!isdefined(self.reward))
		self.reward = 0;
	
	if( iskill == true )
	{	
		thread combo_logic();
		total_kill_reward = (self.reward*level.combo_count);
		level.hud_hitmarker.color = (1, 0.2, 0.2);
		//level.survspi_score = level.survspi_score+ ( self.reward + level.survspi_locationKillBonus[location] ) ;
		
		thread add_points(total_kill_reward);
		
		level.survspi_kills++;
		level.survspi_kills_wave++;
		if( isdefined(location) && location == "head" )
		{
			level.survspi_headshots++;
			level.survspi_headshots_wave++;
		}
		thread hitmarker_kill_points_text(total_kill_reward);
	}
	/*
	// with the current multiply system the damage is not so necessary.
	else
	{
		level.survspi_score = level.survspi_score+10;
		level.survspi_score_wave = level.survspi_score_wave+10;
		level.survspi_dmg++;
	}
	*/
	level.hud_hitmarker setShader("damage_feedback", 24, 48);
	level.hud_hitmarker fadeOverTime(1);
	level.hud_hitmarker.alpha = 0;
	level.player thread play_sound_on_tag("hitmarker_snd");
	wait 1;
	level.hud_hitmarker destroy();
}

combo_logic()
{
	level notify("new_combo");
	level endon("new_combo");
	level.combo_count++;
	wait 1.5;
	level.combo_count = 0;
}

add_points(total_kill_reward)
{
	level endon("new_combo");
	wait 1.5;
	
	thread points_add_up(total_kill_reward);
	level.survspi_score_wave = level.survspi_score_wave + total_kill_reward;
	//level.survspi_score = level.survspi_score + total_kill_reward;
}

points_add_up(add_score)
{
	level.survspi_total_score = level.survspi_total_score+add_score;
	increment = ( add_score / 10 );
	for (i = 0; i < 10; i++) 
	{
		level.survspi_score = level.survspi_score+increment;

		wait 0.05;
	}
}

hitmarker_kill_points_text( points )
{
	level notify("hitmarker_kill_points_text_kill");
	level endon("hitmarker_kill_points_text_kill");

	hitmarker_points_hud = newHudElem();
	hitmarker_points_hud.alignX = "center";
	hitmarker_points_hud.alignY = "middle";
	hitmarker_points_hud.horzAlign = "center";
	hitmarker_points_hud.vertAlign = "middle";
	hitmarker_points_hud.x = 0;
	hitmarker_points_hud.y = -50;
	hitmarker_points_hud.alpha = 1;
	hitmarker_points_hud.font = "objective";
	hitmarker_points_hud.fontScale = 5;
	hitmarker_points_hud.foreground = true;
	hitmarker_points_hud.label = &"SURVSPI_PLUS_YELLOW";
	hitmarker_points_hud setvalue( int(points) ); 

	hitmarker_points_hud ChangeFontScaleOverTime( 0.15 ); 
	hitmarker_points_hud.fontScale = 1.25;
	hitmarker_points_hud thread hitmarker_kill_points_text_destroy();

	wait 1;
	
	hitmarker_points_hud MoveOverTime(0.15);
	hitmarker_points_hud.alignX = "left";
	hitmarker_points_hud.alignY = "middle";
	hitmarker_points_hud.horzAlign = "right";
	hitmarker_points_hud.vertAlign = "top";
	hitmarker_points_hud.x = level.survspi_money_hud.x;
	hitmarker_points_hud.y = level.survspi_money_hud.y+20; 
	
	wait 0.5; // this wait also prevents the change of alignment glitch. Also must wait same time as we wait to add the points in total points.
	
	increment = ( points / 10 );
	for (i = 0; i < 10; i++) 
	{
		points = points - increment;
		hitmarker_points_hud setvalue( int(points) ); 
		wait 0.05;
	}
	hitmarker_points_hud thread fade_overlay_survspi( 0, 0.5);
	wait 0.6; 
	hitmarker_points_hud destroy();		
}

hitmarker_kill_points_text_destroy()
{
	self endon("death");
	level waittill("hitmarker_kill_points_text_kill");
	self destroy();	
}

//===============================================
//===============================================
//===============================================
//===============================================
//===============================================
//CATEGORY 2: HUD WAVE HUD SCORE
//===============================================
//===============================================
//===============================================
//===============================================
//===============================================

WAVE_MONEY_HUD()
{
//---------------------------------- WAVE #
	level.survspi_wave_counter = newHudElem();
	level.survspi_wave_counter.alignX = "left";
	level.survspi_wave_counter.alignY = "middle";
	level.survspi_wave_counter.horzAlign = "right";
	level.survspi_wave_counter.vertAlign = "top";
	level.survspi_wave_counter.fontScale = 1.25; //1.6
	level.survspi_wave_counter.font = "objective";
 	level.survspi_wave_counter.hidewheninmenu = true;
 	level.survspi_wave_counter.foreground = 1;
	level.survspi_wave_counter.alpha = 0;
	
	level.survspi_wave_counter.x = -130;
	
	level.survspi_wave_counter.y = 160; 
	level.survspi_wave_counter.label = &"SURVSPI_CURRENT_WAVE";
	thread wave_counter_update();

//---------------------------------- ENEMIES LEFT
	level.survspi_enemy_counter = newHudElem();
	level.survspi_enemy_counter.alignX = "left";
	level.survspi_enemy_counter.alignY = "middle";
	level.survspi_enemy_counter.horzAlign = "right";
	level.survspi_enemy_counter.vertAlign = "top";
	level.survspi_enemy_counter.font = "objective";
	level.survspi_enemy_counter.fontScale = 1.25; //1.6
 	level.survspi_enemy_counter.hidewheninmenu = true;
 	level.survspi_enemy_counter.foreground = 1;
	level.survspi_enemy_counter.alpha = 0;

	level.survspi_enemy_counter.x = -130;
	
	level.survspi_enemy_counter.y = 180; 
	level.survspi_enemy_counter.label = &"SURVSPI_ENEMIES_LEFT";
	thread enemy_counter_update();

//---------------------------------- MONEY #
	level.survspi_money_hud = newHudElem();
	level.survspi_money_hud.alignX = "left";
	level.survspi_money_hud.alignY = "middle";
	level.survspi_money_hud.horzAlign = "right";
	level.survspi_money_hud.vertAlign = "top";
	level.survspi_money_hud.font = "objective";
	level.survspi_money_hud.fontScale = 1.25; //1.6
 	level.survspi_money_hud.hidewheninmenu = true;
 	level.survspi_money_hud.foreground = 1;
	level.survspi_money_hud.alpha = 0;

	level.survspi_money_hud.x = -130;

	level.survspi_money_hud.y = 200; 
	level.survspi_money_hud.label = &"SURVSPI_DOLLAR_SURV";
	level.survspi_money_hud setvalue( level.survspi_score );
	level.survspi_money_hud thread survspi_score_update();
	level.survspi_money_hud thread money_text_color_think();
//================================ END

	level waittill("survival_end");
	
	level.survspi_wave_counter destroy();
	level.survspi_enemy_counter destroy();
	level.survspi_money_hud destroy();

	setdvar("survspi_minutes", level.survspi_minutes );
	setdvar("survspi_seconds", level.survspi_seconds );
	setdvar("survspi_mili_seconds", level.survspi_mili_seconds );
	
	setdvar("survspi_score", level.survspi_score );
	setdvar("survspi_kills", level.survspi_kills);
	setdvar("survspi_wave", level.survspi_wave);
}

money_text_color_think()
{
	level endon("survival_end");
	temp = level.survspi_score;
	while(1)
	{
		if( temp == level.survspi_score )
			self.color = (1,1,1);
		else if( temp < level.survspi_score )
			self.color = (0.5,1,0.5);
		temp = level.survspi_score;
		wait 0.2;
	}
}

wave_counter_update()
{
	level endon("survival_end");

	while(1)
	{
		level.survspi_wave_counter setvalue( level.survspi_wave );
		wait 0.05;
	}
}

enemy_counter_update()
{
	level endon("survival_end");

	level waittill("waves_started");
	while(1)
	{
		level.survspi_enemy_counter setvalue( level.survspi_enemies_left );
		
		if( level.survspi_enemies_left < 6 && level.survspi_enemies_left > 0 )
			level.survspi_enemy_counter.color = (1,0.25,0.25);
		else
			level.survspi_enemy_counter.color = (1,1,1);
		
		wait 0.05;
	}
}

survspi_score_update()
{	
	level endon("survival_end");
	while(1)
	{
		self setvalue( level.survspi_score );
		wait 0.05;
	}
}

STATS_CALC_WAVE_TOTAL_AND_HUD()
{
	level endon("survival_end");
	level waittill("wave_started");	

	while(1)
	{
		// reset wave stats
		level.survspi_score_wave = 0;
		level.survspi_kills_wave = 0;
		level.survspi_headshots_wave = 0;
		
		level.survspi_wave_minutes = 0;
		level.survspi_wave_seconds = 0;
		level.survspi_wave_mili_seconds = 1;
		
		thread SURVSPI_calc_Mili_Seconds_WAVE();
		thread SURVSPI_calc_Minutess_Seconds_WAVE();
	
		level waittill("wave_ended");	
		
		setdvar("survspi_wave_minutes",level.survspi_wave_minutes);
		setdvar("survspi_wave_seconds", level.survspi_wave_seconds);
		setdvar("survspi_wave_mili_seconds", level.survspi_wave_mili_seconds);
		//setdvar("survspi_wave_sub_seconds", "0"); // ???

		thread wave_bonus();

		level waittill("wave_started");					
		wait 0.05;
	}
}


wave_bonus()
{
	//wave bonus = 25*wave_number
	//kills_bonus = 10*wave_kills
	//headshots_bonus = 20*wave_headshots
	
	wave_mins = getdvar("survspi_wave_minutes");
	wave_secs = getdvar("survspi_wave_seconds");
	wave_milsecs = getdvar("survspi_wave_mili_seconds");
	
	total_wave_time = wave_mins + ":" + wave_secs + "." + wave_milsecs;	
	setdvar("survspi_wave_total_time", total_wave_time);
	
	wait 1.6; // for combo wait.
	wait 0.4; // more wait for new combo addup system.
	
	level.survspi_wave_wave_bonus = 25*level.survspi_wave;
	level.survspi_wave_kills_bonus = 10*level.survspi_kills_wave;
	level.survspi_wave_headshots_bonus = 20*level.survspi_headshots_wave;
	level.total_wave_bonus = level.survspi_wave_wave_bonus+level.survspi_wave_kills_bonus+level.survspi_wave_headshots_bonus;
	
	wait 0.5; // more wait time was needed.
	
	level.player thread play_sound_on_tag("ui_mw3_wave_stats_in"); // doesnt sound

	thread add_points(level.total_wave_bonus);
	thread hitmarker_kill_points_text( level.total_wave_bonus );

	//xpos1 = -150;
	xpos1 = -300;
	

	thread create_after_action_report_text( &"SURVSPI_WAVE_STATS"  , xpos1, -110, 2.5, 10, "l" );
	thread create_after_action_report_text( &"SURVSPI_WAVE_WAVE" , xpos1, -80, 1.5, 10, "l", level.survspi_wave );
	thread create_after_action_report_text( &"SURVSPI_WAVE_KILLS"  , xpos1, -60, 1.5, 10,"l", level.survspi_kills_wave);
	thread create_after_action_report_text( &"SURVSPI_WAVE_HS"     , xpos1, -40, 1.5, 10, "l",level.survspi_headshots_wave );
	thread create_after_action_report_text( &"SURVSPI_WAVE_MONEY"  , xpos1, -20, 1.5, 10,"l", level.survspi_score_wave );
	thread create_after_action_report_text( &"SURVSPI_WAVE_TIME" , xpos1, -0, 1.5, 10, "l" );

	thread create_after_action_report_text( &"SURVSPI_PLUS" , xpos1, -80, 1.5, 180, "r", level.survspi_wave_wave_bonus );
	thread create_after_action_report_text( &"SURVSPI_PLUS" , xpos1, -60, 1.5, 180, "r", level.survspi_wave_kills_bonus );
	thread create_after_action_report_text( &"SURVSPI_PLUS" , xpos1, -40, 1.5, 180, "r", level.survspi_wave_headshots_bonus );
	thread create_after_action_report_text( &"SURVSPI_PLUS" , xpos1, -20, 1.5, 180, "r", level.total_wave_bonus );
	thread create_after_action_report_text(  getdvar("survspi_wave_total_time") , xpos1, -0, 1.5, 180, "r" );

	thread survival_bonus_bg("black", 200 , 150, xpos1);

	wait 10;
	level.player thread play_sound_on_tag("ui_mw3_wave_stats_out"); // doesnt sound
	
}

create_after_action_report_text( text , offsetX, offsetY, TextSize, OGx, alignx, value  )
{
	afac_txt = maps\_hud_util::get_countdown_hud();
	
	if(alignx == "r")
		afac_txt.alignX = "right";
	else if(alignx == "l")
		afac_txt.alignX = "left";
	
	afac_txt.alignY = "middle";
	afac_txt.horzAlign = "left";
	afac_txt.vertAlign = "middle";
	afac_txt.fontScale = TextSize;
 	afac_txt.hidewheninmenu = true;
	afac_txt.alpha = 1;
	afac_txt.x = offsetX;
	afac_txt.y = offsetY; 
	afac_txt.label = text;
	if(isdefined(value))
	{
		afac_txt setvalue( value );
	}
	afac_txt MoveOverTime(0.25);
	afac_txt.x = OGx;
	wait 10;
	afac_txt MoveOverTime(0.25);
	afac_txt.x = offsetX;
	wait 0.25;
	afac_txt destroy();
}

survival_bonus_bg( shader, width, height, xpos1 )
{
	barElemBG = newHudElem();
	barElemBG.elemType = "bar";
	barElemBG.alignX = "left";
	barElemBG.alignY = "middle";
	barElemBG.horzAlign = "left";
	barElemBG.vertAlign = "middle";
	barElemBG.x = xpos1;
	barElemBG.y = -60;
	barElemBG.width = width;
	barElemBG.height = height;
	barElemBG.xOffset = 0;
	barElemBG.yOffset = 0;
 	barElemBG.hidewheninmenu = true;
	barElemBG.sort = -2;
	barElemBG.foreground = 1;
	barElemBG.alpha = 0.5;
	barElemBG setShader( shader, width, height );
	barElemBG MoveOverTime(0.25);
	barElemBG.x = 0;
	wait 10;
	barElemBG MoveOverTime(0.25);
	barElemBG.x = xpos1;
	wait 0.25;
	barElemBG destroy();
}

/*####### TIME FUNCS #####
#########################*/

SURVSPI_calc_Mili_Seconds()
{
	
	level endon("survival_end");

	wait 0.05;
	while(1)
	{
		for( i=0; i<10; i++ )
		{
			level.survspi_mili_seconds = i;
			wait 0.1;
		}
	}
}

SURVSPI_calc_Minutess_Seconds()
{
	level endon("survival_end");

	wait 0.05;
	while(1)
	{
		for( i=0; i<60; i++)
		{
			level.survspi_seconds = i;
			wait 1;
		}
		level.survspi_minutes++;
	}
}

SURVSPI_calc_Mili_Seconds_WAVE()
{
	
	level endon("wave_ended");

	wait 0.05;
	while(1)
	{
		for( i=0; i<10; i++ )
		{
			level.survspi_wave_mili_seconds = i;
			wait 0.1;
		}
	}
}

SURVSPI_calc_Minutess_Seconds_WAVE()
{
	level endon("wave_ended");

	wait 0.05;
	while(1)
	{
		for( i=0; i<60; i++)
		{
			level.survspi_wave_seconds = i;
			wait 1;
		}
		level.survspi_wave_minutes++;
	}
}

//===============================================
//===============================================
//===============================================
//===============================================
//===============================================
//CATEGORY 3: WAVE THINK WAVE SPAWN LOGIC CYCLES
//===============================================
//===============================================
//===============================================
//===============================================
//===============================================



//================ wave calculations above ================
pre_wave()
{	

	wave0_black = thread hud_overlay_survspi( "black", 1 );
	wave0_white = thread hud_overlay_survspi( "white", 0 );
	
	surv_int_org1 = getent( "surv_int_org1" , "targetname"); 
	surv_int_org2 = getent( "surv_int_org2" , "targetname"); 
	level.player takeallweapons();
	level.player freezecontrols(true);
	
	level.player thread play_sound_on_tag( "ui_zoomin" );

	linker = spawn( "script_origin", ( 0, 0, 0 ) );
	linker.origin = level.player.origin;
	linker.angles = level.player getplayerangles();
	level.player playerlinktodelta( linker, "", 0, 0, 0, 0, 0 );
	
	wait 0.1;
	musicplay("blackout_nightvision");

	linker moveto(surv_int_org1.origin, 0.1);
	linker rotateto(surv_int_org1.angles, 0.1);
	
	wait 0.5;
	
	linker moveto(surv_int_org2.origin, 1, 0, 0.25);
	
	wave0_black thread fade_overlay_survspi( 0, 0.25 );
	
	wait 0.5;
	wave0_white thread fade_overlay_survspi( 0.8, 0.25 );
	linker rotateto(surv_int_org2.angles, 0.5, 0.25, 0.25);

	wait 0.25;
	wave0_white thread fade_overlay_survspi( 0, 0.25 );

	wait 0.25;
	wait 0.2;
	level.player unlink();
	linker delete();
	level.player freezecontrols(false);
	wave0_black destroy();
	wave0_white destroy();
	
	level.player giveweapon("beretta");
	level.player givemaxammo("beretta");
	level.player switchtoweapon( "beretta" );
	level.player giveWeapon( "fraggrenade" );
	level.player giveWeapon( "flash_grenade" );
	level.player SetWeaponAmmoClip( "fraggrenade", 2 );
	level.player SetWeaponAmmoClip( "flash_grenade", 2 );

	objective_add (1, "active" , &"SURVSPI_OBJ_SURV" );	
	objective_current( 1 );
	wait 2;

	//begin stuff chat/wave center hud info(func making it come and go on center of screen) and more?
	
	thread wave_think();
	wait 0.05;
	thread simple_hud_show();
	
	level.survspi_wave_counter.alpha = 1;
	level.survspi_enemy_counter.alpha = 1;
	level.survspi_money_hud.alpha = 1;
	thread hideshow_health_Bar(1);
	
	level notify("waves_started");
	
	level.player thread play_sound_on_tag("su_hq_start");

	wait 20;
	musicstop(3);	
}


wave_intermission()
{
	level notify("end_wave");
	level.player thread play_sound_on_tag( "ui_mw3_wave_won" );

	wait 5; //wave # cleared goes away.
	
	thread intermission_time();
	thread intermission_time_skip();
	level waittill("start_next_wave");
	thread wave_think();
	wait 3;

}


//==================
// Wave intermission
//==================

intermission_time()
{
	level endon("skip_intermission");

	//level.next_wave_in_hud = maps\_hud_util::get_countdown_hud();
	level.next_wave_in_hud = newHudElem();
	level.next_wave_in_hud.alignX = "center";
	level.next_wave_in_hud.alignY = "middle";
	level.next_wave_in_hud.horzAlign = "center";
	level.next_wave_in_hud.vertAlign = "middle";
	level.next_wave_in_hud.font = "objective";
	level.next_wave_in_hud.x = 0;
	level.next_wave_in_hud.y = -180;
	level.next_wave_in_hud.hidewheninmenu = true;
	level.next_wave_in_hud.foreground = 1;
	//level.next_wave_in_hud.fontScale = 2.5;
	level.next_wave_in_hud.fontScale = 1.6;
	level.next_wave_in_hud.label = &"SURVSPI_NEXT_WAVE_IN";
	
	level.next_wave_skip_hint = newHudElem();
	level.next_wave_skip_hint.alignX = "center";
	level.next_wave_skip_hint.alignY = "middle";
	level.next_wave_skip_hint.horzAlign = "center";
	level.next_wave_skip_hint.vertAlign = "middle";
	level.next_wave_skip_hint.font = "objective";
	level.next_wave_skip_hint.x = 0;
	level.next_wave_skip_hint.y = -200;
	level.next_wave_skip_hint.foreground = 1;
	level.next_wave_skip_hint.hidewheninmenu = true;
	level.next_wave_skip_hint.fontScale = 1.2;
	//level.next_wave_skip_hint.fontScale = 1.2;
	level.next_wave_skip_hint.label = &"SURVSPI_PRESS_TO_SKIP";

	sec25z = 30;
	
	for(i=0; i<25; i++) // 5 seconds
	{
		level.next_wave_in_hud setvalue(sec25z);
		wait 1;
		sec25z = sec25z-1;
	}

	level notify("skip_missed");
	thread sec5_for_next_wave();
}

intermission_time_skip()
{
	level endon("skip_missed");
	thread skip_button_tab();
	level.player waittill( "skip_wave_button_pressed" );
	level notify("skip_intermission");
	sec5_for_next_wave();
}

skip_button_tab()
{
	level endon("skip_missed");
	level.player notifyOnCommand( "skip_wave_button_pressed", "+scores" );
}

sec5_for_next_wave()
{	
	cent_num_cnt = newHudElem();
	cent_num_cnt.alignX = "center";
	cent_num_cnt.alignY = "middle";
	cent_num_cnt.horzAlign = "center";
	cent_num_cnt.vertAlign = "middle";
	cent_num_cnt.font = "objective";
	cent_num_cnt.x = 0;
	cent_num_cnt.y = 0; 
	cent_num_cnt.hidewheninmenu = true;
	cent_num_cnt.foreground = 1;
	
	if( isdefined(level.next_wave_in_hud))
		level.next_wave_in_hud destroy();

	if( isdefined(level.next_wave_skip_hint))
		level.next_wave_skip_hint destroy();

	sec5 = 5;

	for(i=0; i<5; i++) // 5 seconds
	{
		level.player thread play_sound_on_tag( "countdown_beep" ); 
		cent_num_cnt.fontScale = 5; 
		cent_num_cnt setText( sec5 );
		
		for(j=0; j<10; j++) // 1 second
		{
			cent_num_cnt.fontScale = cent_num_cnt.fontScale-0.3;
			wait 0.05;
		}
		wait 0.5;
		sec5= sec5-1;
	}
	level notify("start_next_wave");
	cent_num_cnt destroy();
}

wave_startend_hud( state )
{
	next_wave_hud = maps\_hud_util::get_countdown_hud();
	next_wave_hud.alignX = "center";
	next_wave_hud.alignY = "middle";
	next_wave_hud.horzAlign = "center";
	next_wave_hud.vertAlign = "middle";
	next_wave_hud.x = 0;
	next_wave_hud.y = -180; 
	next_wave_hud.fontScale = 2; 
	if( state == "start" )
	{
		next_wave_hud.label = &"SURVSPI_WAVE_BEGIN"; 
		next_wave_hud setvalue(level.survspi_wave);
		next_wave_hud SetPulseFX( 50, 3200, 500 );
		wait 4;
		next_wave_hud destroy();
	}
	else if( state == "end" )
	{
		next_wave_hud.label = &"SURVSPI_WAVE_COMPLETED"; 
		next_wave_hud setvalue(level.survspi_wave);
		next_wave_hud SetPulseFX( 50, 4500, 500 );//fade in time, time ms, fade out time
		wait 5;
		next_wave_hud destroy();
	}
}

//=====================================================
//=====================================================

wave_end_dialogue()
{
	wait 3;
	
	if(level.survspi_waves_completed == 1)
		level.player thread play_sound_on_tag( "su_hq_armory_wpn" );
	else if(level.survspi_waves_completed == 2)
		level.player thread play_sound_on_tag( "su_hq_armory_eq" );
	else if(level.survspi_waves_completed == 3)
		level.player thread play_sound_on_tag( "su_hq_armory_air" );
	else if(level.survspi_waves_completed > 3)
		level.player thread play_sound_on_tag( "su_hq_wave_over" );

}


wave_begin_dialogue()
{

	wait 1;
	
	if( level.heavywave == true && level.survspi_waves_completed < 18  )
	{
		if(level.heavywave_type == "heli")
		{
			if(level.one_heli == true)
				level.player play_sound_on_tag( "su_hq_heli_single" );
			else
				level.player play_sound_on_tag( "su_hq_helis" );
		}
		
		else if( level.heavywave_type == "jugg" )
			level.player play_sound_on_tag( "su_hq_jugg" );
		
		else if( level.heavywave_type == "mixed" )
		{
			if(level.survspi_havy_wave_state == 1)
			{
				level.player play_sound_on_tag( "su_hq_jugg" );
			}
			else
			{
				if(level.one_heli == true)
					level.player play_sound_on_tag( "su_hq_heli_single" );
				else
					level.player play_sound_on_tag( "su_hq_helis" );
				
				level.player play_sound_on_tag( "su_hq_jugg" );
			}
		}
		
		if( level.dog_wave == true )
		{
			//level.player play_sound_on_tag( "su_hq_dog" );
		}
	}
	else if( level.heavywave == true && level.survspi_waves_completed > 18  )
	{
		level.player play_sound_on_tag( "su_hq_helis" );
		level.player play_sound_on_tag( "su_hq_jugg" );
	}
	else
	{
		if( level.dog_wave == true )
		{
			// Since I disabled dogs for reasons explained in their function.
			// I replace this dog wave announcement with the normal one since dog_wave value is still applied. 
			//level.player play_sound_on_tag( "su_hq_dog" );
			level.player play_sound_on_tag( "su_hq_wave_start" );
		}
		else
		{
			level.player play_sound_on_tag( "su_hq_wave_start" );
		}
	}
	
}

//=====================================================
//=====================================================

/*
OUR wave cycle based on MW3 wave/round cycles:
Wave 1  10x Shotgun
Wave 2  12x Shotgun
Wave 3  12x Shotgun + 2x Dogs
Wave 4  10x MP5 
Wave 5  12x MP5
Wave 6  1x Helis || 1xJuggMed
Wave 7  15x MP5 
Wave 8  12x MP5 + 2x Dogs
Wave 9  15x MP5 + 2x Dogs
Wave 10 2xJuggMed || 2x Helis || 1xHelis + 1xJuggMed
Wave 11 10x AK47
Wave 12 12x AK47
Wave 13 12x AK47 + 2x Dogs
Wave 14 15x AK47 + 2x Dogs
Wave 15 3xJuggMed || 2x Helis + 1xJuggMed || 1x Helis + 2xJuggMed 
Wave 16 10x ACR
Wave 17 12x ACR
Wave 18 12x ACR + 2x Dogs
Wave 19 15x ACR + 2x Dogs
Wave 20 1xJuggMed + 1xJuggHeavy || 1x Helis + 1xJuggHeavy

[ forever this cycle. Every time it ends FAD regulars health is boosted. Not sure how much. maybe x2
Wave 21 10x FAD
Wave 22 12x FAD 
Wave 23 12x FAD + 2x Dogs
Wave 24 15x FAD + 2x Dogs
Wave 25 1xJuggMed + 2xJuggHeavy || 2xHelis + 1xJuggHeav || 1x Helis + 2xJuggHeav 
]
*/

wave_think()
{
	level endon("end_wave");
	
	level.survspi_wave++;	
	level notify("wave_started");	
	level.player thread play_sound_on_tag( "ui_mw3_wave_start" );
	//level.player thread play_sound_on_tag( "arcademode_zerodeaths" );
	thread wave_startend_hud("start");	
	thread calculate_wave_progression_values(); 

	wait 2;
	
	if(level.survspi_wave < 11)	
		thread bring_wave_forces_think();
	else if( level.survspi_wave == 11 || level.survspi_wave > 11 )	
		thread infinite_wave_cycle();
	
	wait 0.5;
	
	if(level.survspi_wave != 1) // not first wave.
		thread wave_begin_dialogue(); // a few lines above.

	while( level.survspi_enemies_left > 0) // HANDLES WAVE OVER 
		wait 0.05;

	level.survspi_enemies_left = 0;
	level.dog_wave = false;
	level.heavywave  = false;
	level.one_heli = false;

	thread wave_end_dialogue(); // a few lines above.

	level notify("wave_ended");
	thread wave_startend_hud("end");	
	level.survspi_waves_completed++;
	thread wave_intermission();
	
}

// This is important. It counts waves and tells when each new unit and type will come.
calculate_wave_progression_values()
{
	//=== Army Rank Manage ================================
	
	if( level.survspi_wave < 4 )
		level.survspi_army_state = 0; // shotgun

	else if( level.survspi_wave > 3 && level.survspi_wave < 11 )
		level.survspi_army_state = 1; // mp5

	else if( level.survspi_wave > 10 && level.survspi_wave < 16  )
		level.survspi_army_state = 2; // ak47

	else if( level.survspi_wave > 15 && level.survspi_wave < 21  ) 
		level.survspi_army_state = 3; // commandos

	else if( level.survspi_wave > 20 ) 
		level.survspi_army_state = 4; // mini juggernauts

	//=== Heavy Wave Level Setup ================================

	if( level.survspi_wave == 10 )
		level.survspi_havy_wave_state = 2; // 2 juggs || 2 hinds || 1 jugg+1 hind

	else if( level.survspi_wave == 15 )
		level.survspi_havy_wave_state = 3; // 3 juggs || 2 hinds || 2 juggs+1 hind || 1 jugg+2 hinds

	else if( level.survspi_wave == 20 || level.survspi_wave > 20 )
		level.survspi_havy_wave_state = 4; // 3 juggs || 3 juggs+1 hind || 3 juggs + 2 hinds

	//=== Infinite Cycle ================================

	if( level.survspi_wave == 11 || level.survspi_wave > 11 )
	{
		if(level.survspi_wave_cycle_part == 5)
		{
			level.survspi_wave_cycle_part = 1;
			level.survspi_wave_cycles++;
		}
		else
			level.survspi_wave_cycle_part++;
	}	
	/*
	//=== Check if Heavy Wave ================================

	if( level.survspi_wave == 6 )
		level.heavywave = true;		
	else if( level.survspi_wave > 6 && (level.survspi_wave % 5) == 0 )
		level.heavywave = true;
	else
		level.heavywave = false;
*/

}


// LOGIC OF SPAWNING ENEMIES IN EACH WAVE
bring_wave_forces_think() // WAVE FIRST 10 CYCLE LOGIC
{
	//-------------------------------
	if(level.survspi_wave == 1)
	{
		thread bring_surv_regulars(10);	
	}
	else if(level.survspi_wave == 2)
	{
		thread bring_surv_regulars(12);	
	}
	else if(level.survspi_wave == 3)
	{
		thread bring_surv_regulars(12);	
		thread bring_surv_dogs(2);	
	}	
	else if(level.survspi_wave == 4)
	{
		thread bring_surv_regulars(10);	
	}		
	else if(level.survspi_wave == 5)
	{
		thread bring_surv_regulars(12);	
	}		
	//-------------------------------
	else if(level.survspi_wave == 6)
	{
		thread bring_heavy_wave_setup();
	}		
	else if(level.survspi_wave == 7)
	{
		thread bring_surv_regulars(15);	
	}	
	else if(level.survspi_wave == 8)
	{
		thread bring_surv_regulars(12);	
		thread bring_surv_dogs(2);	
	}	
	else if(level.survspi_wave == 9)
	{
		thread bring_surv_regulars(15);	
		thread bring_surv_dogs(2);		
	}	
	else if(level.survspi_wave == 10)
	{
		thread bring_heavy_wave_setup();
	}		
	//-------------------------------
}

infinite_wave_cycle() // WAVE ROUNDS WILL GO IN A LOOP FROM NOW ON
{
	if(level.survspi_wave_cycle_part == 1)
	{
		thread bring_surv_regulars(10);	
	}		
	else if(level.survspi_wave_cycle_part == 2)
	{
		thread bring_surv_regulars(12);	
	}	
	else if(level.survspi_wave_cycle_part == 3)
	{
		thread bring_surv_regulars(12);	
		thread bring_surv_dogs(2);	
	}	
	else if(level.survspi_wave_cycle_part == 4)
	{
		thread bring_surv_regulars(15);	
		thread bring_surv_dogs(2);		
	}	
	else if(level.survspi_wave_cycle_part == 5)
	{
		rand1 = randomintrange(9,12);
		rand2 = randomintrange(1,2);
		
		thread bring_heavy_wave_setup();
		
		if(level.survspi_wave > 21)
		{
			thread bring_surv_regulars(rand1);	
			if(rand2 == 1)
			{
				thread bring_surv_dogs(2);	
			}
		}
	}		
}

// REGULARS SYSTEM
bring_surv_regulars( force_amount ) // Make sure your force amount doesn't exceed the given spawn points in your map.
{
	if( level.survspi_army_state == 0 ) // shotguns
	{
		thread regulars_spawn( "force1", force_amount );
	}
	else if( level.survspi_army_state == 1 ) // smgs
	{
		thread regulars_spawn( "force2", force_amount );
	}
	else if( level.survspi_army_state == 2 ) // assaulters
	{
		thread regulars_spawn( "force3", force_amount );
	}		
	else if( level.survspi_army_state == 3 ) // commandos 
	{
		thread regulars_spawn( "force4", force_amount );
	}		
	else if( level.survspi_army_state == 4 ) // heavy assaulters
	{
		thread regulars_spawn( "force5", force_amount );
	}
}

regulars_spawn( forceid, force_amount )
{
	level.regular_force = []; 
	main_force = []; 
	force1 = getentarray( forceid, "targetname");
	main_force = getFurthestSpawners(forceid,force_amount);
	for(i=0; i<force_amount	; i++)
	{
		level.regular_force[i] = main_force[i] Stalingradspawn();
		level.survspi_enemies_left++;
		wait 0.05;
	}
	//self.health = self.health+ (level.survspi_wave*50);
	level notify("regulars_spawned");

	wait 0.05;
	waittill_dead(level.regular_force);
	level notify("regulars_dead");
}

// SURV DOGS
bring_surv_dogs(amount)
{
	level.dog_wave = true;
	
	// SPi - March 22, 2020.
	// I disabled dogs because the fake player health system and with revive system are quite messy combined the dog to player knockdown system.
	// I did some tweaks in animscripts/dog_combat.gsc but there were still plenty glitches in the way.
	// Like player revive weapons not being called back properly. And player weapons being taken entirely when he recovers.
	// Stances don't restore properly. Player can crouch while being revived after dog knockdown, 
	// a small under ground throw moment of the player view during knockdown restore and stuff like that.
	// I don't have the time or sanity to sit down and fix all those. If anyone is willing to work on them. Feel free to do so.
/*
	level.dog_force = []; 
	force1 = getentarray( "dog_force", "targetname");
	main_force = getFurthestSpawners("dog_force",force_amount);
	for(i=0; i<amount	; i++)
	{
		level.dog_force[i] = main_force[i] Stalingradspawn();
		level.dog_force[i].reward = 150;
		level.survspi_enemies_left++;
		wait 0.05;
	}
*/
}

// A cool function by Scillman!
getFurthestSpawners(forceid, count)
{
    Player_origin = level.player.origin;

    spawners = getEntArray(forceid, "targetname");
    assert(spawners.size > 0);
    assert(spawners.size >= count);

    output = [];
    output[0] = spawners[0];

    for (i = 1; i < spawners.size; i++)
    {
        dist = distance(Player_origin, spawners[i].origin);

        for (j = 0; j < count; j++)
        {
            if (!isDefined(output[j]))
            {
                output[j] = spawners[i];
                break;
            }

            if (dist > distance(Player_origin, output[j].origin))
            {
                for (k = count - 2; k > j; k--)
                {
                    output[k + 1] = output[k];
                }
                output[j] = spawners[i];
                break;
            }
        }
    }
    return output;
}

/*
	Useful description of how heavywave difficulty evolves.
	level.survspi_havy_wave_state = 1; // 1jugg || 1hind
	level.survspi_havy_wave_state = 2; // 2juggs || 2hinds || 1 jugg+1hind
	level.survspi_havy_wave_state = 3; // 3juggs || 2hinds || 2 juggs+1hind || 1jugg+2 hinds
	level.survspi_havy_wave_state = 4; // 3juggs + 2hinds // always
*/

// HEAVY WAVES
bring_heavy_wave_setup()
{
	level.heavywave = true;
	coin1 = randomintrange(0,3);
	
	heavy_wave_choice = "mixed"; //needs to be defined anyway
	
	if( level.survspi_wave < 24 )
	{
		if(coin1 == 0)
		{
			heavy_wave_choice = "jugg";
			musicplay("sniperescape_run_music");
		}
		else if(coin1 == 1)
		{
			heavy_wave_choice = "heli";
			musicplay("jeepride_defend_music");
		}
		else if(coin1 == 2)
		{
			heavy_wave_choice = "mixed";
			musicplay("sniperescape_run_music");
		}
	}
	else
	{
		heavy_wave_choice = "mixed";	
		musicplay("sniperescape_run_music");
	}
	
	level.heavywave_type = heavy_wave_choice;
	
	//iprintlnbold(heavy_wave_choice);

/*
	if(heavy_wave_choice == "jugg")
	{
		level.heavywave_type = "jugg";
		musicplay("sniperescape_run_music");
	}
	else if(heavy_wave_choice == "heli")
	{
		level.heavywave_type = "heli";
		musicplay("jeepride_defend_music");
	}
	else if(heavy_wave_choice == "mixed")
	{
		level.heavywave_type = "mixed";
		musicplay("sniperescape_run_music");
	}
*/

	if(level.survspi_havy_wave_state == 1) 
	{
		if(heavy_wave_choice == "jugg")
		{
			thread bring_juggs_amount(1);
		}
		else if(heavy_wave_choice == "heli")
		{
			thread bring_helis_amount(1);
		}
		else if(heavy_wave_choice == "mixed")
		{
			thread bring_juggs_amount(1);
		}		
	}
	else if(level.survspi_havy_wave_state == 2) 
	{
		
		if(heavy_wave_choice == "jugg")
		{
			thread bring_juggs_amount(2);
		}
		else if(heavy_wave_choice == "heli")
		{
			thread bring_helis_amount(2);
		}
		else if(heavy_wave_choice == "mixed")
		{
			thread bring_juggs_amount(1);
			thread bring_helis_amount(1);
		}			
	}
	else if(level.survspi_havy_wave_state == 3) 
	{
		if(heavy_wave_choice == "jugg")
		{
			thread bring_juggs_amount(3);
		}
		else if(heavy_wave_choice == "heli")
		{
			thread bring_helis_amount(2);
		}
		
		else if(heavy_wave_choice == "mixed")
		{
			coin = randomintrange(0,2);
			if(coin == 1)
			{
				thread bring_juggs_amount(2);
				thread bring_helis_amount(1);
			}
			else //if(coin == 0)
			{
				thread bring_juggs_amount(1);
				thread bring_helis_amount(2);
			}
		}			
	}
	else if(level.survspi_havy_wave_state == 4) 
	{
		thread bring_juggs_amount(3);
		thread bring_helis_amount(2);		
	}

	level waittill("wave_ended");	
	musicstop();
}

bring_helis_amount(amount)
{
	coin_heli = randomintrange(0,2);
	if(amount == 1) 
	{
		if(coin_heli == 0)
			thread bring_hind_attack(6,4);
		else if(coin_heli == 1)
			thread bring_hind_attack(7,5);
		else
			thread bring_hind_attack(6,4);
		
		level.one_heli = true;
	}
	else if(amount == 2) 
	{
		thread bring_hind_attack(6,4);
		thread bring_hind_attack(7,5);
		
		level.one_heli = false;
	}
}

bring_hind_attack(spawngroup_hind, pathid)
{
	hind_heli = maps\_vehicle::create_vehicle_from_spawngroup_and_gopath(spawngroup_hind);
	hind_choppa = hind_heli[0];
	level.survspi_enemies_left++;
	
	if(spawngroup_hind == 6)
		level.hind_heli1_gb = hind_choppa;
	else if(spawngroup_hind == 7)
		level.hind_heli2_gb = hind_choppa;
	

	hind_choppa.godmode = false; 
	hind_choppa.health = 99999;
	hind_choppa.team_value = "axis";
	hind_choppa.fake_heli_health = 4000;
	hind_choppa.script_bulletshield = false;
	hind_choppa.reward = 600;
	hind_choppa thread heli_damage_trigger(spawngroup_hind);
	hind_choppa thread setup_attack_heli_path(pathid);
	hind_choppa thread heli_damage_fx();
	
	hind_choppa waittill("in_map");

	hind_choppa thread maps\_helicopter_globals::shootEnemyTarget_Bullets( level.player_targeted_org );

	hind_choppa waittill( "death" );	
	level.survspi_enemies_left--;

	if(spawngroup_hind == 6)
		level.hind_heli1_gb = undefined;
	else if(spawngroup_hind == 7)
		level.hind_heli2_gb = undefined;

	heli_crash_pos = getClosest( hind_choppa.origin, level.heli_crash_orgs);

	hind_choppa.perferred_crash_location = heli_crash_pos;
	hind_choppa thread setvehgoalpos_wrap(heli_crash_pos.origin , 1 );
	hind_choppa thread maps\_vehicle::vehicle_paths( heli_crash_pos );
}

heli_damage_trigger(spawngroup_hind) // I had to. I couldn't make helicopters recieve bullet damage.
{
	trigger = getent( "enemy_heli_trigger"+spawngroup_hind, "targetname" );
	trigger thread manual_linkto_spi(self, (0,0,-120) ); // 512,512,128 sizes
	self waittill("in_map");
	while(1)
	{
		trigger waittill( "damage", amount, attacker, direction_vec, point, type);
		dmg_type = maps\_destructible::getDamageType( type );
		if(attacker == level.player )
		{
			self.health = self.health+99999;
			if( dmg_type == "splash" || dmg_type == "impact" )
			{
				self.fake_heli_health = self.fake_heli_health-amount*15;
			}
			else if( dmg_type == "bullet" )
			{
				self.fake_heli_health = self.fake_heli_health-amount;
			}
			self thread survspi_display_hitmarker( false );
		}
		else if(attacker == self )
			continue;
		
		if(self.fake_heli_health == 0 || self.fake_heli_health < 0)
			break;
		wait 0.05;
	}
	self thread survspi_display_hitmarker( true );
	self.health = 1;
	self dodamage( self.health + 99999, self.origin );
	trigger notify("unlink");
	self notify( "death" );
}

heli_damage_fx()
{
	self endon( "death" );
	while(self.fake_heli_health>0)
	{
		if(self.fake_heli_health < 2500 && self.fake_heli_health > 1500 )
		{
			PlayFXOnTag( level._effect["heli_smoke_grey2"], self, "tag_origin" );
		}
		else if(self.fake_heli_health < 1501 )
		{
			PlayFXOnTag( level._effect["heli_smoke_black2"], self, "tag_origin" );
		}
		wait 0.25;	
	}
}

bring_juggs_amount(amount) // 1-2-3
{
	// jugg spawngroups are 0,4,5 
	
	coin_jugg = randomintrange(0,3);
	
	if(amount == 1) 
	{
		if(coin_jugg == 0)
		{
			thread bring_juggernaut(0, 1);// parameters are spawngroup and start_path_id
		}
		else if(coin_jugg == 1)
		{
			thread bring_juggernaut(4, 3);
		}
		else if(coin_jugg == 2)
		{
			thread bring_juggernaut(5, 2);
		}
		else
		{
			thread bring_juggernaut(0, 1);
		}	
	}
	else if(amount == 2) 
	{
		if(coin_jugg == 0)
		{
			thread bring_juggernaut(0, 1);
			thread bring_juggernaut(4, 3);
		}
		else if(coin_jugg == 1)
		{
			thread bring_juggernaut(0, 1);
			thread bring_juggernaut(5, 2);
		}
		else if(coin_jugg == 2)
		{
			thread bring_juggernaut(5, 2);
			thread bring_juggernaut(4, 3);
		}
		else
		{
			thread bring_juggernaut(0, 1);
			thread bring_juggernaut(4, 3);
		}		
	}
	else if(amount == 3) 
	{
		if( level.survspi_havy_wave_state == 4 && level.survspi_wave < 21 )
		{
			thread bring_juggernaut(0, 1, "jugg_shield");
			thread bring_juggernaut(4, 3, "jugg_regular");
			thread bring_juggernaut(5, 2, "jugg_heavy");
		}
		else if( level.survspi_havy_wave_state == 4 && level.survspi_wave > 21 )
		{
			thread bring_juggernaut(0, 1, "jugg_shield");
			thread bring_juggernaut(4, 3, "jugg_heavy");
			thread bring_juggernaut(5, 2, "jugg_heavy");
		}
		else if( level.survspi_havy_wave_state == 3 )
		{
			coin_jugg15 = randomintrange(0,2); 
			if(coin_jugg15 == 1)
			{
				thread bring_juggernaut(0, 1, "jugg_regular");
				thread bring_juggernaut(4, 3, "jugg_regular");
				thread bring_juggernaut(5, 2, "jugg_heavy");
			}
			else
			{
				thread bring_juggernaut(0, 1, "jugg_regular");
				thread bring_juggernaut(4, 3, "jugg_regular");
				thread bring_juggernaut(5, 2, "jugg_shield");
			}
		}

	}
}

bring_juggernaut(spawngroup_jugg, pathid, jugg_type)
{
	juggtype = "jugg_regular";

	if(isdefined(jugg_type))
	{
		if( level.survspi_havy_wave_state > 2)
		juggtype = jugg_type;
	}

	jugheli = maps\_vehicle::create_vehicle_from_spawngroup_and_gopath(spawngroup_jugg);
	jugg_choppa = jugheli[0];
	
	jugg_choppa.team_value = "axis";
	jugg_choppa thread setup_transport_heli_path(spawngroup_jugg, pathid);
	juggernaut_local = [];
	for(i=0; i<jugg_choppa.riders.size; i++)
	{
		juggernaut_local[i] = jugg_choppa.riders[i];
		//juggernaut_local[i] thread jugg_reg_settings();

		if(juggtype == "jugg_regular")
			juggernaut_local[i] thread jugg_reg_settings();
		else if(juggtype == "jugg_shield")
			juggernaut_local[i] thread jugg_shield_settings();
		else if(juggtype == "jugg_heavy")
			juggernaut_local[i] thread jugg_heavy_settings();
		
		level.survspi_enemies_left++;
	}
	jugg_choppa waittill( "unloaded" );
	juggernaut_local[0] notify("landed");
	juggernaut_local[0] waittill( "death" );
	level.survspi_enemies_left--;
}


//===============================================
//===============================================
//===============================================
//===============================================
//===============================================
//CATEGORY 4: NPC AI ENEMIES ALLIES SETUP
//===============================================
//===============================================
//===============================================
//===============================================
//===============================================

setup_NPC_spawn_settings()
{
	run_thread_on_targetname( "force1", ::add_spawn_function, ::shotgunners_settings );
	run_thread_on_targetname( "force2", ::add_spawn_function, ::mp5ers_settings );
	run_thread_on_targetname( "force3", ::add_spawn_function, ::ak47ers_settings );
	run_thread_on_targetname( "force4", ::add_spawn_function, ::acrers_settings );
	run_thread_on_targetname( "force5", ::add_spawn_function, ::minijuggs_settings );
}

task_force_reinforce() 
{

	spawngroup = 2;
	//level.player thread play_sound_on_tag(  "arcademode_kill_streak_lost"  );
	heli = maps\_vehicle::create_vehicle_from_spawngroup_and_gopath(spawngroup);
	wait 0.05;
	choppa1 = heli[0];
	choppa1.team_value = "allies";
	choppa1 thread setup_transport_heli_path(spawngroup);
	
	level.player thread play_sound_on_tag( "su_hq_ally_delta" );
	level.reinforcements_active = 1;
	level.squad_type = "marines";

	task_force_team = [];
	for(i=0; i<choppa1.riders.size; i++)
		task_force_team[i] = choppa1.riders[i];
	
	for(i=0; i<task_force_team.size; i++)
		task_force_team[i] thread task_force_think();
	
	choppa1 waittill( "unloaded" );
	level notify("stop_task_force_shield");
	//iprintlnbold(&"unloaded");
	
	waittill_dead(task_force_team);

	thread survspi_message( &"SURVSPI_TF_DIED" );
	level.reinforcements_active = 0;
	wait 0.1;
	level.squad_mode = "follow";
	thread enable_ally_color_trigs();
}

spec_ops_reinforce() 
{			
	spawngroup = 1;
	//level.player thread play_sound_on_tag(  "arcademode_kill_streak_lost"  );
	heli2 = maps\_vehicle::create_vehicle_from_spawngroup_and_gopath(spawngroup);
	wait 0.05; 
	choppa2 = heli2[0];
	choppa2.team_value = "allies";
	choppa2 thread setup_transport_heli_path(spawngroup);

	level.player thread play_sound_on_tag( "su_hq_ally_gign" );
	level.reinforcements_active = 1;
	level.squad_type = "sas";

	spec_ops_team = [];
	for(i=0; i<choppa2.riders.size; i++)
		spec_ops_team[i] = choppa2.riders[i];

	for(i=0; i<spec_ops_team.size; i++)
		spec_ops_team[i] thread spec_ops_think();
	
	choppa2 waittill( "unloaded" );
	level notify("stop_spec_ops_shield");
	//iprintlnbold(&"unloaded");
	
	waittill_dead(spec_ops_team);
	
	thread survspi_message( &"SURVSPI_SO_DIED" );
	level.reinforcements_active = 0;
	wait 0.1;
	level.squad_mode = "follow";
	thread enable_ally_color_trigs();
}



hero_team_reinforce() 
{			
	spawngroup = 3;
	//level.player thread play_sound_on_tag(  "arcademode_kill_streak_lost"  );
	heli3 = maps\_vehicle::create_vehicle_from_spawngroup_and_gopath(spawngroup);
	wait 0.05; 
	choppa3 = heli3[0];
	choppa3.team_value = "allies";
	choppa3 thread setup_transport_heli_path(spawngroup);
	

	hero_wave = level.survspi_waves_completed;
	hero_wave_end = hero_wave+10;
	level.hero_leave_trigg = getent( "hero_delete_trigg" , "targetname" ); // we have to define this here.

	level.reinforcements_active = 1;
	level.squad_type = "hero";
	
	level.price = get_living_ai( "price" , "script_noteworthy" );
	level.gaz = get_living_ai( "gaz" , "script_noteworthy" );
	level.vsq = get_living_ai( "vsq" , "script_noteworthy" );
	level.grigs = get_living_ai( "grigs" , "script_noteworthy" );

	hero_team = [];
	for(i=0; i<choppa3.riders.size; i++)
		hero_team[i] = choppa3.riders[i];

	for(i=0; i<hero_team.size; i++)
		hero_team[i] thread hero_team_think();
	
	choppa3 waittill( "unloaded" );
	level notify("stop_hero_land_shield");

	while(1)
	{
		if( hero_wave_end == level.survspi_waves_completed)
			break;
		wait 0.05;
	}

	level notify("hero_team_leave");
	
	wait 0.1;
	
	level.hero_leave_trigg notify("trigger");

	level.reinforcements_active = 0;
}

shotgunners_settings()
{
	self.maxhealth = 150;
	self.health = 150;
	self.reward = 100;
	self thread enemy_settings();
}

mp5ers_settings()
{
	self.maxhealth = 300;
	self.health = 300;
	self.reward = 125;
	self thread enemy_settings();
}

ak47ers_settings()
{
	self.maxhealth = 500;
	self.health = 500;
	self.reward = 150;
	self thread enemy_settings();
}

acrers_settings()
{
	self.maxhealth = 1000;
	self.health = 1000;
	self.reward = 200;
	self thread enemy_settings();
}

minijuggs_settings()
{
	self.maxhealth = 1250;
	self.health = 1250;
	self.reward = 275;


	// I will disable health increase of regulars and juggs 
	// because its both messy and too hard for balance.
/*
	if(level.survspi_wave_cycles>0)
	{
		helth = int(self.health + (level.survspi_wave_cycles * 100));
		self.maxhealth = helth;
		self.health = helth;
	}
*/
	self thread enemy_settings();

}

enemy_settings()
{
	self.spawn_origin = self.origin;
	self.goalradius = 900;
	self setengagementmindist( 300, 200 );
	self setengagementmaxdist( 512, 768 );
	self.goalheight = 80;
	self.baseAccuracy = 1;
	self thread enemy_player_revive_logic();
	
	self setEngagementMinDist( 256.000000, 0.000000 );
	self setEngagementMaxDist( 768.000000, 1024.000000 );
	
	self waittill("death");
	level.survspi_enemies_left--;
}

jugg_reg_settings()
{
	self thread magic_bullet_shield();
	self.ignoreme = true;
	self.allowdeath = false;
	self.a.disablePain = true;
	self.ignoreSuppression = true;
	self.alwaysRunForward = true;
	self.disableArrivals = true;
	self.disableExits = true;
	self.reward = 500;
	self.dropweapon = false;
	self.juggernaut = true;
	self enable_cqbwalk();
	
	self waittill("landed");
	
	self thread stop_magic_bullet_shield();
	self.maxhealth = 75000;
	self.health = 7500;
	self.ignoreme = false;
	self.allowdeath = true;
	self.baseAccuracy = 1;
	self.moveplaybackrate = 1;
	
	self thread jugg_health_logic();
	self thread follow_player(25, 25);	
}

jugg_heavy_settings()
{
	self thread magic_bullet_shield();
	self.ignoreme = true;
	self.allowdeath = false;
	self.a.disablePain = true;
	self.ignoreSuppression = true;
	self.dropweapon = false;
	self.reward = 1000;
	self.juggernaut = true;
	self enable_cqbwalk();
	
	self setmodel("mw3_jugg_exp");

	self waittill("landed");
	
	self thread stop_magic_bullet_shield();
	self.maxhealth = 12000;
	self.health = 12000;
	self.ignoreme = false;
	self.allowdeath = true;
	self.baseAccuracy = 1;
	self.moveplaybackrate = 0.8;
	
	self thread jugg_health_logic();
	self thread follow_player(25, 25);	
}

jugg_shield_settings()
{
	self thread magic_bullet_shield();
	self.ignoreme = true;
	self.allowdeath = false;
	self.a.disablePain = true;
	self.ignoreSuppression = true;
	self.dropweapon = false;
	self.reward = 750;
	
	self waittill("landed");
	
	self thread stop_magic_bullet_shield();
	self.ignoreme = false;
	self.allowdeath = true;
	self.maxhealth = 10000;
	self.health = 10000;
	self.baseAccuracy = 1;
	self.moveplaybackrate = 0.8;
	
	self thread jugg_health_logic();
	
	self thread follow_player(25, 25);	
	self AllowedStances( "crouch" );

	health_third = int(self.health/3);
	while(self.health > health_third ) wait 0.05;
	
	self AllowedStances( "stand" );
	self.juggernaut = true;
	self enable_cqbwalk();
}

jugg_health_logic()
{
/*
	// I will disable health increase of regulars and juggs 
	// because its both messy and too hard for balance.
	if(level.survspi_wave_cycles>0)
	{
		helth = int(self.health + (level.survspi_wave_cycles * 100));
		self.health = helth;
	}
*/
}


follow_player( plr_dist, goalrad)
{
	self endon("death");
	
	player_dist = plr_dist;
	self.goalradius = goalrad;
	while(1)
	{
		if( distance( self.origin, level.player.origin) < player_dist )
			self thread set_goal_pos(self.origin);
		else if( distance( self.origin, level.player.origin) > player_dist)
			self thread set_goal_pos(level.player.origin);
		wait 0.05;
	}
}

enemy_player_revive_logic()
{
	self endon("death");
	while(1)
	{		
		if(level.player_isInLastStand == true)
		{
			self setgoalpos(self.spawn_origin);
		}
		else
		{
			self setgoalpos(self.origin);
			self setgoalentity( level.player );
		}
		
		condition = level.player_isInLastStand;	
		while(condition == level.player_isInLastStand)    
			wait 0.05;
	}
}


task_force_think()
{
	self thread magic_bullet_shield();
	self.ignoreme = true;
	self.allowdeath = false;
	self.ignoreSuppression = true;
	self SetFlashbangImmunity( true );
	
	level waittill("stop_task_force_shield");
	
	self thread mark_ent_npc( "hudicon_american" );
	self thread stop_magic_bullet_shield();
	self.ignoreme = false;
	self.allowdeath = true;
	self.maxhealth = 2500;
	self.health = 2500;
	self.a.disablePain = true;
	self.baseAccuracy = 2;

	self thread squad_order_trigg();
}

spec_ops_think()
{
	self thread magic_bullet_shield();
	self.ignoreme = true;
	self.allowdeath = false;
	self.ignoreSuppression = true;
	self SetFlashbangImmunity( true );
	
	level waittill("stop_spec_ops_shield");
	
	self thread mark_ent_npc( "hudicon_riot" );
	self thread stop_magic_bullet_shield();
	self.ignoreme = false;
	self.allowdeath = true;
	self.maxhealth = 4000;
	self.health = 4000;
	self.a.disablePain = true;
	self.baseAccuracy = 5;
	self thread squad_order_trigg();

}

hero_team_think()
{
	self thread magic_bullet_shield();
	self.ignoreme = true;
	self.allowdeath = false;
	self.ignoreSuppression = true;
	self SetFlashbangImmunity( true );
	self.a.disablePain = true;
	self.baseAccuracy = 10;
	
	level waittill("stop_hero_land_shield");
	
	self thread squad_order_trigg();
	self.ignoreme = false;

	level waittill("hero_team_leave");
	self notify("leaving");

	self enable_ai_color();
	self set_force_color( "c" );
	
	self setHintString( &"SURVSPI_NULL" );

	if(self == level.price)
	 self thread play_sound_on_tag("price_leaving");
	
	while(!self istouching(level.hero_leave_trigg))
		wait 0.05;
	
	self thread stop_magic_bullet_shield();
	self delete();
	
}


squad_order_trigg()
{
	self endon("death");
	self endon("leaving");
	
	self.useable = true;
	//self disable_ai_color();	
	
	self thread squad_mode_trigger();
	while(1)
	{
		if( level.squad_mode == "follow" )
		{
			self setHintString( &"SURVSPI_SQUAD_HOLD_TRIGG" );
		}
		else if( level.squad_mode == "hold" )
		{
			self setHintString( &"SURVSPI_SQUAD_FOLLOW_TRIGG" );
		}
		wait 0.05;
	}
}


squad_mode_trigger()
{
	self endon("death");
	self endon("leaving");
	
	//reset_cover_nodes();
	//self thread ally_follow_player();

	while(1)
	{
		self waittill( "trigger" );
		level notify("squad_mode_changed");
		//reset_cover_nodes();
		if(level.squad_mode == "follow")
		{
			level.squad_mode = "hold";
			thread disable_ally_color_trigs();
			//self thread ally_hold_position();
		}
		else if(level.squad_mode == "hold")
		{
			level.squad_mode = "follow";
			thread enable_ally_color_trigs();
			//self thread ally_follow_player();
		}
		self order_dialogue();
		wait 0.05;
	}
}


ally_hold_position()
{
	level endon("squad_mode_changed");
	self endon("death");

	the_closer_node = getClosest_covernode(self.origin);
	the_closer_node.occupied = 1;
	self setgoalnode(the_closer_node);
}

ally_follow_player()
{
	level endon("squad_mode_changed");
	self endon("death");
	
	while(1)
	{
		the_closer_node = getClosest_covernode(level.player.origin);
		the_closer_node.occupied = 1;
		self setgoalnode(the_closer_node);
		while(distance(level.player.origin, self.origin) < 350) 
			wait 0.05;
		the_closer_node.occupied = 0;
		wait 0.05;
	}
}

getClosest_covernode(org)
{
	self endon("death");
	
	nodes = GetNodeArray( "cover_nodes", "targetname" );

	closest = nodes[0];
    closestDist = distance(org, closest.origin);

	for(i=1; i<nodes.size; i++)
	{	        
		current = nodes[i];
		dist = distance(org, current.origin);
		if ( dist < closestDist && nodes[i].occupied == 0 )
        {
            closest = current;
            closestDist = dist;
        }
	}
    return closest;
}

reset_cover_nodes()
{
	nodes = GetNodeArray( "cover_nodes", "targetname" );
	for(i=0; i<nodes.size; i++)
	nodes[i].occupied = 0;
}




disable_ally_color_trigs()
{
	ally_color_triggs = getentarray( "ally_color_triggs" , "targetname" );	
	for(i=0; i<ally_color_triggs.size; i++)
		ally_color_triggs[i] trigger_off();
}

enable_ally_color_trigs()
{
	ally_color_triggs = getentarray( "ally_color_triggs" , "targetname" );	
	for(i=0; i<ally_color_triggs.size; i++)
		ally_color_triggs[i] trigger_on();
}





order_dialogue()
{
	if(level.squad_mode == "follow")
	{
		if(level.squad_type == "marines")
		{
			//self play_sound_on_tag("usmc_copy");
		}
		else if(level.squad_type == "sas")
		{
			self play_sound_on_tag("sas_copy");
		}
		else if(level.squad_type == "hero")
		{
			if(self == level.price)
				self play_sound_on_tag("price_move");
			else if(self == level.vsq)
				self play_sound_on_tag("vsq_roger");
			else if(self == level.gaz)
				self play_sound_on_tag("sas_copy");
			else
				self play_sound_on_tag("griggs_roger");
		}		
	}
	else if(level.squad_mode == "hold")
	{
		if(level.squad_type == "marines")
		{
			//self play_sound_on_tag("usmc_copy");
		}
		else if(level.squad_type == "sas")
		{
			self play_sound_on_tag("sas_copy");
		}
		else if(level.squad_type == "hero")
		{
			if(self == level.price)
				self play_sound_on_tag("price_roger");
			else if(self == level.vsq)
				self play_sound_on_tag("vsq_roger");
			else if(self == level.gaz)
				self play_sound_on_tag("sas_copy");
			else
				self play_sound_on_tag("griggs_roger");
		}		
	}
}


no_ai_grenades()
{
	add_global_spawn_function( "axis", ::no_grenades );
	axis = getaiarray( "axis" );
	array_thread( axis, ::set_grenadeammo, 0 );
	
	add_global_spawn_function( "allies", ::no_grenades );
	allies = getaiarray( "allies" );
	array_thread( allies, ::set_grenadeammo, 0 );
}

no_grenades()
{
	self.grenadeammo = 0;
}


//===============================================
//===============================================
//===============================================
//===============================================
//===============================================
//CATEGORY 5: HELICOPTERS SETUP
//===============================================
//===============================================
//===============================================
//===============================================
//===============================================
//helicopter stuff
//transport stuff

/*
heli
helicopter
choppers
LZ landing zones
LZ landing_zones

Make a helicopter system for the (~6) lz spots.
Each newly spawned helicopter transport will seek the closest LZ to player.

if(Lz_not_occupied && get_closest_to_player_lz) then land to that lz.

so how we do this?
here's my thoughs so far
each LZ will have:
Zstruct. Ground origin (to calc player distance.) thats mostly it.
there will be global variables for each lz.
example: level.lz1_occupued = false;
then distance between player and ground origin. maybe put it target of struct? if it works yes. put a made up targetname just in case.

max jugg helis around 3 on very late waves.
+ the reinformcenets heli they all together can take up 4 occupied LZs at the same time if possible.
so 4 lz minimum per map. We have 6 in the basic survival rooftops map.


*/




setup_heli_structs()
{
	level.lzs = getEntArray( "lzsnw" , "script_noteworthy" ); //lzsnw is script_noteworthy // lzs targetname
	for ( i = 0; i < level.lzs.size; i ++ )
	{
		level.lzs[i].occupied_node = false;
	}
	
	level.heli_exits = getEntArray( "heli_exits_nw" , "script_noteworthy" ); //heli_exits_nw is script_noteworthy //heli_exits targetname
	for ( i = 0; i < level.heli_exits.size; i ++ )
	{
		level.heli_exits[i].occupied_node = false;
	}
	
	level.heli_attacks = getEntArray( "attack_heli_org_nw" , "script_noteworthy" ); //attack_heli_org_nw is script_noteworthy //heli_exits targetname
	for ( i = 0; i < level.heli_attacks.size; i ++ )
	{
		level.heli_attacks[i].occupied_node = false;
	}
	
	level.heli_crash_orgs = getEntArray( "crash_org" , "script_noteworthy" );	
	
	wait 0.05;
	
	level.player_targeted_org = spawn( "script_origin", level.player.origin+(0,0,48)  );
	level.player_targeted_org.angles = level.player getplayerangles();
	while( 1 )
	{		
		level.player_targeted_org moveto( level.player.origin+(0,0,48), 0.05);
		wait 0.1;
	}	
}


setup_attack_heli_path(id)
{
	dist = 512;

	if( !isdefined(id) )
		id = 4;

	enemy_heli_enter = getent( "enemy_heli_enter"+id , "targetname" ); // ally helis have 1 spawn.
	while(1)
	{
		if( dist > distance( self.origin, enemy_heli_enter.origin ) )
		{
			break;
		}
		wait 0.05;
	}

	self notify("in_map");

	self vehicle_pathdetach();
	
    path_atk = level.heli_attacks getClosestUnoccupied(level.player.origin);
	self thread setvehgoalpos_wrap(path_atk.origin , 1 );
	self thread maps\_vehicle::vehicle_paths( path_atk );
	wait 12;
	path_atk.occupied_node = 0;

	while( isdefined( self ) )
	{
		path_atk = level.heli_attacks getClosestUnoccupied(level.player.origin);
		self thread setvehgoalpos_wrap(path_atk.origin , 1 );
		self thread maps\_vehicle::vehicle_paths( path_atk );
		wait 4;
		path_atk.occupied_node = 0;
	}
	path_atk.occupied_node = 0;
}


setup_transport_heli_path(spawngroup, id)
{
	dist = 512;

	if( !isdefined(id) )
		id = 1;

	if(self.team_value == "allies")
	{
		ally_heli_enter = getent( "ally_heli_enter"+id , "targetname" ); // ally helis have 1 spawn.
		while(1)
		{
			if( dist > distance( self.origin, ally_heli_enter.origin ) )
			{
				break;
			}
			wait 0.05;
		}
	}
	else if(self.team_value == "axis")
	{
		enemy_heli_enter = getent( "enemy_heli_enter"+id , "targetname" ); 
		while(1)
		{
			if( dist > distance( self.origin, enemy_heli_enter.origin ) )
				break;
			wait 0.05;
		}
	}
	
	self vehicle_pathdetach();

    path_lz = level.lzs getClosestUnoccupied(level.player.origin);
	
	self thread setvehgoalpos_wrap(path_lz.origin , 1 );
	self thread maps\_vehicle::vehicle_paths( path_lz );

	self waittill("unload");
	//self waittill( "unloading" ); // mw3?
	
	if( self.team_value == "axis" )
	{
		lzsmoke = getent( path_lz.target , "targetname" ); 
		lzsmoke playsound("smokegrenade_explode_default");
		PlayFX( level._effect["smoke_grenade_11sec_mp"], lzsmoke.origin );
	}

	self waittill( "unloaded" );
	path_lz.occupied_node = 0;

    path_exit = level.heli_exits getClosestUnoccupied(self.origin);

	self thread setvehgoalpos_wrap(path_exit.origin , 1 );
	self thread maps\_vehicle::vehicle_paths( path_exit );
	
	wait 5; // should be enough. Otherwise make a loop waitting for self to be not defined.
	
	path_exit.occupied_node = 0;
}



// USAGE: target = array getClosestUnoccupied( origin );
getClosestUnoccupied(org, occupy)
{
    unoccupied = self getUnoccupied();
    closest = unoccupied getClosest_here(org);
	closest.occupied_node = true;
	return closest;
}

// USAGE: unoccupied = array getUnoccupied()
getUnoccupied()
{
    paths = [];

    for (i = 0; i < self.size; i++)
    {
        if (self[i].occupied_node == false)
        {
            paths[paths.size] = self[i];
        }
    }

    return paths;
}

// USAGE: closest = array getClosest( origin );
getClosest_here(org)
{
    assert(self.size > 0);

    closest = self[0];
    closestDist = distance(org, closest.origin);

    for (i = 1; i < self.size; i++)
    {
        current = self[i];

        dist = distance(org, current.origin);
        if (dist < closestDist)
        {
            closest = current;
            closestDist = dist;
        }
    }

    return closest;
}





/*
setup_heli_structs()
{	
	level.lzs = getentarray( "lzsnw" , "script_noteworthy" ); //lzsnw is script_noteworthy // lzs targetname
	for ( i = 0; i < level.lzs.size; i ++ )
	{
		level.lzs[i].occupied_node = 0;
	}
	
	level.heli_exits = getentarray( "heli_exits_nw" , "script_noteworthy" ); //heli_exits_nw is script_noteworthy //heli_exits targetname
	for ( i = 0; i < level.heli_exits.size; i ++ )
	{
		level.heli_exits[i].occupied_node = 0;
	}
	
	level.heli_attacks = getentarray( "attack_heli_org_nw" , "script_noteworthy" ); //heli_exits_nw is script_noteworthy //heli_exits targetname
	for ( i = 0; i < level.heli_attacks.size; i ++ )
	{
		level.heli_attacks[i].occupied_node = 0;
	}
	
	level.heli_crash_orgs = getentarray( "crash_org" , "script_noteworthy" );	
	
	wait 0.05;
	
	level.player_targeted_org = spawn( "script_origin", level.player.origin+(0,0,48)  );
	level.player_targeted_org.angles = level.player getplayerangles();
	while( 1 )
	{		
		level.player_targeted_org moveto( level.player.origin+(0,0,48), 0.05);
		wait 0.1;
	}	
}


setup_attack_heli_path(id)
{
	dist = 512;

	if( !isdefined(id) )
		id = 4;

	enemy_heli_enter = getent( "enemy_heli_enter"+id , "targetname" ); // ally helis have 1 spawn.
	while(1)
	{
		if( dist > distance( self.origin, enemy_heli_enter.origin ) )
		{
			break;
		}
		wait 0.05;
	}

	self notify("in_map");

	self vehicle_pathdetach();
	
	path_atk = get_best_heli_path(level.player.origin, "attack_heli_org_nw");
	path_atk.occupied_node = 1;
	self thread setvehgoalpos_wrap(path_atk.origin , 1 );
	self thread maps\_vehicle::vehicle_paths( path_atk );
	wait 12;
	path_atk.occupied_node = 0;

	while( isdefined( self ) )
	{
		path_atk = get_best_heli_path(level.player.origin, "attack_heli_org_nw");
		path_atk.occupied_node = 1;
		self thread setvehgoalpos_wrap(path_atk.origin , 1 );
		self thread maps\_vehicle::vehicle_paths( path_atk );
		wait 12;
		path_atk.occupied_node = 0;
	}
	path_atk.occupied_node = 0;
}


setup_transport_heli_path(spawngroup, id)
{

	dist = 512;

	if( !isdefined(id) )
		id = 1;

	if(self.team_value == "allies")
	{
		ally_heli_enter = getent( "ally_heli_enter"+id , "targetname" ); // ally helis have 1 spawn.
		while(1)
		{
			if( dist > distance( self.origin, ally_heli_enter.origin ) )
			{
				break;
			}
			wait 0.05;
		}
	}
	else if(self.team_value == "axis")
	{
		enemy_heli_enter = getent( "enemy_heli_enter"+id , "targetname" ); 
		while(1)
		{
			if( dist > distance( self.origin, enemy_heli_enter.origin ) )
				break;
			wait 0.05;
		}
	}
	
	self vehicle_pathdetach();
	
	path_lz = get_best_heli_path(level.player.origin, "lzsnw");
	path_lz.occupied_node = 1;
	
	self thread setvehgoalpos_wrap(path_lz.origin , 1 );
	self thread maps\_vehicle::vehicle_paths( path_lz );

	self waittill("unload");
	
	if( self.team_value == "axis" )
	{
		lzsmoke = getent( path_lz.target , "targetname" ); 
		lzsmoke playsound("smokegrenade_explode_default");
		PlayFX( level._effect["smoke_grenade_11sec_mp"], lzsmoke.origin );
	}

	self waittill( "unloaded" );
	path_lz.occupied_struct = 0;

	path_exit = get_best_heli_path(self.origin, "heli_exits_nw");
	path_exit.occupied_node = 1;

	self thread setvehgoalpos_wrap(path_exit.origin , 1 );
	self thread maps\_vehicle::vehicle_paths( path_exit );
	
	wait 5; // should be enough. Otherwise make a loop waitting for self to be not defined.
	
	path_exit.occupied_node = 0;
}




get_best_heli_path(closeEnt, scrnw)
{
    arr = getUnoccupiedHeliPaths(scrnw);
    return getClosestInArray(closeEnt, arr);
}

getUnoccupiedHeliPaths(scrnw)
{
    paths = getEntArray(scrnw , "script_noteworthy");

    for (i = 0; i < paths.size; i++)
    {
        if (paths[i].occupied_node)
        {
            for (j = i + 1; j < paths.size; j++)
            {
                paths[j - 1] = paths[j];
            }

            paths[paths.size - 1] = undefined;
        }
    }

    return paths;
}

getClosestInArray(org, arr)
{
    assert(arr.size > 0);

    closest = arr[0];
    closestDist = distance(org, closest.origin);

    for (i = 1; i < arr.size; i++)
    {
        current = arr[i];

        dist = distance(org, current.origin);
        if (dist < closestDist)
        {
            closest = current;
            closestDist = dist;
        }
    }

    return closest;
}
*/


//===============================================
//===============================================
//===============================================
//===============================================
//===============================================
//CATEGORY 6: ARMORIES ARMORY CODE
//===============================================
//===============================================
//===============================================
//===============================================
//===============================================

/*########################################################
################## WEAPON ARMORY ####################
########################################################*/


buy_stuff_unlock()
{
	weapon_armory_laptop_open = getent("weapon_armory_laptop_open","targetname");
	weapon_armory_laptop_closed = getent("weapon_armory_laptop_closed","targetname");
	equipment_armory_laptop_open = getent("equipment_armory_laptop_open","targetname");
	equipment_armory_laptop_closed = getent("equipment_armory_laptop_closed","targetname");
	support_armory_laptop_open = getent("support_armory_laptop_open","targetname");
	support_armory_laptop_closed = getent("support_armory_laptop_closed","targetname");
	
	weapon_armory_laptop_open hide();
	equipment_armory_laptop_open hide();
	support_armory_laptop_open hide();

	while( level.survspi_waves_completed < 1 )
		wait 0.05;		
	
	thread weapon_armory_setup();
	weapon_armory_laptop_open show();
	weapon_armory_laptop_closed hide();
	
	while( level.survspi_waves_completed < 2 )
		wait 0.05;	
	
	thread equipment_armory_setup();	
	equipment_armory_laptop_open show();
	equipment_armory_laptop_closed hide();

	
	while( level.survspi_waves_completed < 3 )
		wait 0.05;	
	
	thread airsupport_armory_setup();	
	support_armory_laptop_open show();
	support_armory_laptop_closed hide();

}

weapon_armory_setup()
{
	weapon_trigg = getent("weapon_trigg","targetname");
	weapon_trigg sethintstring(&"SURVSPI_WEAP_ARMORY_TRIGG");
	weapon_trigg thread mark_ent_survspi("ammo");
	while(1)
	{
		weapon_trigg trigger_on();
		weapon_trigg waittill("trigger");
		weapon_trigg trigger_off();
		setblur(2, .1);
		level.player openMenu("survspi_weapons");
		level.player waittill("menuresponse", menu, response);
		setblur(0, .1);
		
		if( response == "close" ) // add this because when it closes with close button it doesnt reopen.

			continue;
		
		if( response == "ammo" )
		{
			weap_price = get_weapon_price("ammo");
			canbuy = buy_item( weap_price, "ammo");
			if( canbuy == true)
			{
				level.player thread play_sound_on_tag("ui_mw3_buy");
				thread refill_player_ammo();
			}
		}
		else
		{
			if( level.player HasWeapon( response ) )
			{
				level.player SwitchToWeapon(response);
			}
			else
			{
				weap_price = get_weapon_price(response);
				canbuy = buy_item( weap_price, "weapon"  );	
				
				if( canbuy == true)
				{
					level.player thread play_sound_on_tag("ui_mw3_buy");
					plrweapamount = level.player GetWeaponsListPrimaries();
					if( plrweapamount.size > 1)
						level.player takeweapon(level.player GetCurrentWeapon());
						
					level.player giveweapon(response);
					level.player givemaxammo(response);
					level.player SwitchToWeapon(response);
				}
			}
		}
		wait 0.1;
	}
}

/*########################################################
################## EQUIPMENT ARMORY ####################
########################################################*/
equipment_armory_setup()
{
	equipment_armory_trigg = getent("equipment_armory_trigg","targetname");
	equipment_armory_trigg sethintstring(&"SURVSPI_EQUIP_ARMORY_TRIGG");
	equipment_armory_trigg thread mark_ent_survspi("frag");
	while(1)
	{
		equipment_armory_trigg trigger_on();
		equipment_armory_trigg waittill("trigger");
		equipment_armory_trigg trigger_off();
		setblur(2, .1);
		level.player openMenu("survspi_equipment");
		level.player waittill("menuresponse", menu, response);
		setblur(0, .1);
		
		if( response == "close" ) //necessary
			continue;
		//-------------------------
		if( response == "frag" )
		{
			weap_price = get_weapon_price("fraggrenade");
			canbuy = buy_item( weap_price, "equipment", "fraggrenade" );
			if( canbuy == true)
			{
				level.player thread play_sound_on_tag("grenade_pickup");
				level.player giveWeapon( "fraggrenade" );
				level.player givemaxammo( "fraggrenade" );
			}
		}
		//-------------------------
		else if( response == "flash" )
		{
			weap_price = get_weapon_price("flash_grenade");
			canbuy = buy_item( weap_price, "equipment", "flash_grenade" );
			if( canbuy == true)
			{
				level.player thread play_sound_on_tag("grenade_pickup");
				level.player giveWeapon( "flash_grenade" );
				level.player givemaxammo( "flash_grenade" );
			}
		}
		//-------------------------		
		else if( response == "c4" )
		{
			if(level.player HasWeapon("c4") )
			{
				weap_price = get_weapon_price("c4");
				canbuy = buy_item( weap_price, "equipment", "c4" );
			}
			else
			{
				weap_price = get_weapon_price("c4_full");
				canbuy = buy_item( weap_price, "equipment", "c4" );
			}
			if( canbuy == true)
			{
				level.player thread play_sound_on_tag("detpack_pickup");
				if(level.player HasWeapon("c4") )
				{
					level.player givemaxammo("c4");	
				}
				else
				{
					level.player SetActionSlot( 2, "weapon" , "c4" );
					level.player giveweapon("c4");
					level.player givemaxammo("c4");	
				}
			}
		}
		//-------------------------
		else if( response == "clay" )
		{
			if(level.player HasWeapon("claymore") )
			{
				weap_price = get_weapon_price("claymore");
				canbuy = buy_item( weap_price, "equipment", "claymore" );
			}
			else
			{
				weap_price = get_weapon_price("claymore_full");
				canbuy = buy_item( weap_price, "equipment", "claymore" );
			}
			if( canbuy == true)
			{
				level.player thread play_sound_on_tag("grenade_pickup");
				if(level.player HasWeapon("claymore") )
				{
					level.player givemaxammo("claymore" );	
				}
				else
				{
					level.player SetActionSlot( 1, "weapon" , "claymore" );
					level.player giveweapon("claymore");
					level.player givemaxammo("claymore");	
				}
			}
		}
		else if( response == "rpg" )
		{
			if( level.player HasWeapon( "rpg_player" ) )
			{
				level.player SwitchToWeapon("rpg_player");
				level.player givemaxammo("rpg_player");
			}
			else
			{
				weap_price = get_weapon_price("rpg_player");
				canbuy = buy_item( weap_price, "weapon" );	
				
				if( canbuy == true)
				{
					level.player thread play_sound_on_tag("ui_mw3_buy");
					plrweapamount = level.player GetWeaponsListPrimaries();
					if( plrweapamount.size > 1)
						level.player takeweapon(level.player GetCurrentWeapon());
						
					level.player giveweapon("rpg_player");
					level.player givemaxammo("rpg_player");
					level.player SwitchToWeapon("rpg_player");
				}
			}
		}
		else if( response == "at4" )
		{
			if( level.player HasWeapon( "at4" ) )
			{
				level.player SwitchToWeapon("at4");
				level.player givemaxammo("at4");
			}
			else
			{
				weap_price = get_weapon_price("at4");
				canbuy = buy_item( weap_price, "weapon" );	
				
				if( canbuy == true)
				{
					level.player thread play_sound_on_tag("ui_mw3_buy");
					plrweapamount = level.player GetWeaponsListPrimaries();
					if( plrweapamount.size > 1)
						level.player takeweapon(level.player GetCurrentWeapon());
						
					level.player giveweapon(response);
					level.player givemaxammo(response);
					level.player SwitchToWeapon(response);
				}
			}
		}
		// Perks 
		else if( response == "body_armor" )
		{
			if( level.player_has_vest == true )
			{
				thread survspi_message( &"SURVSPI_GOT_ARMOR" );
			}
			else
			{
				weap_price = get_weapon_price("body_armor");
				canbuy = buy_item( weap_price, "weapon" );	
				
				if( canbuy == true)
				{
					level.player thread play_sound_on_tag("ui_mw3_buy");
					thread player_give_body_armor();
				}
				else
				{
					thread survspi_message( &"SURVSPI_GOT_NOMONEY" );
				}
			}
		}	
		else if( response == "self_revive" )
		{
			if( level.player_hasLastStandPerk == true )
			{
				thread survspi_message( &"SURVSPI_GOT_REVIVE" );
			}
			else
			{
				weap_price = get_weapon_price("self_revive");
				canbuy = buy_item( weap_price, "weapon" );	
				if( canbuy == true)
				{
				level.player thread play_sound_on_tag("ui_mw3_buy");
					level.player_hasLastStandPerk = true;
				}
				else
				{
					thread survspi_message( &"SURVSPI_GOT_NOMONEY" );
				}
			}
		}
		// hands
		else if( response == "usmc" )
		{
			if( level.player_hands_assigned == response )
			{
				thread survspi_message( &"SURVSPI_GOT_SKIN" );
			}
			else
			{
				weap_price = get_weapon_price( response );
				canbuy = buy_item( weap_price, "hands" );	
				if( canbuy == true)
				{
					level.player thread play_sound_on_tag("ui_mw3_buy");
					level.player setviewmodel( "viewmodel_mw3_delta" );
					level.player_hands_assigned = response;
				}
			}
		}
		else if( response == "sasw" )
		{
			if( level.player_hands_assigned == response )
			{
				thread survspi_message( &"SURVSPI_GOT_SKIN" );
			}
			else
			{
				weap_price = get_weapon_price( response );
				canbuy = buy_item( weap_price, "hands" );	
				if( canbuy == true)
				{
				level.player thread play_sound_on_tag("ui_mw3_buy");
					level.player setviewmodel( "viewhands_sas_woodland" );
					level.player_hands_assigned = response;
				}
			}
		}
		else if( response == "russ" )
		{
			if( level.player_hands_assigned == response )
			{
				thread survspi_message( &"SURVSPI_GOT_SKIN" );
			}
			else
			{
				weap_price = get_weapon_price( response );
				canbuy = buy_item( weap_price, "hands" );	
				if( canbuy == true)
				{
				level.player thread play_sound_on_tag("ui_mw3_buy");
					level.player setviewmodel( "viewhands_op_force" );
					level.player_hands_assigned = response;
				}
			}
		}
		else if( response == "arab" )
		{
			if( level.player_hands_assigned == response )
			{
				thread survspi_message( &"SURVSPI_GOT_SKIN" );
			}
			else
			{
				weap_price = get_weapon_price( response );
				canbuy = buy_item( weap_price, "hands" );	
				if( canbuy == true)
				{
				level.player thread play_sound_on_tag("ui_mw3_buy");
					level.player setviewmodel( "viewhands_desert_opfor" );
					level.player_hands_assigned = response;
				}
			}
		}	
		else if( response == "bkkt" )
		{
			if( level.player_hands_assigned == response )
			{
				thread survspi_message( &"SURVSPI_GOT_SKIN" );
			}
			else
			{
				weap_price = get_weapon_price( response );
				canbuy = buy_item( weap_price, "hands" );	
				if( canbuy == true)
				{
				level.player thread play_sound_on_tag("ui_mw3_buy");
					level.player setviewmodel( "viewhands_black_kit" );
					level.player_hands_assigned = response;
				}
			}
		}
		else if( response == "frcn" )
		{
			if( level.player_hands_assigned == response )
			{
				thread survspi_message( &"SURVSPI_GOT_SKIN" );
			}
			else
			{
				weap_price = get_weapon_price( response );
				canbuy = buy_item( weap_price, "hands" );	
				if( canbuy == true)
				{
				level.player thread play_sound_on_tag("ui_mw3_buy");
					level.player setviewmodel( "viewhands_force_recon" );
					level.player_hands_assigned = response;
				}
			}
		}
		else if( response == "snpr" )
		{
			if( level.player_hands_assigned == response )
			{
				thread survspi_message( &"SURVSPI_GOT_SKIN" );
			}
			else
			{
				weap_price = get_weapon_price( response );
				canbuy = buy_item( weap_price, "hands" );	
				if( canbuy == true)
				{
				level.player thread play_sound_on_tag("ui_mw3_buy");
					level.player setviewmodel( "viewhands_marine_sniper" );
					level.player_hands_assigned = response;
				}
				else
				{
					thread survspi_message( &"SURVSPI_GOT_NOMONEY" );
				}
			}
		}	
	}
}

/*########################################################
################## SUPPORT ARMORY ####################
########################################################*/
airsupport_armory_setup()
{
	support_trigger = getent("support_trigger","targetname");
	support_trigger sethintstring(&"SURVSPI_AIRSUP_ARMORY_TRIGG");
	support_trigger thread mark_ent_survspi("uav");
	while(1)
	{
		support_trigger trigger_on();
		support_trigger waittill("trigger");
		support_trigger trigger_off();
		setblur(2, .1);
		level.player openMenu("survspi_support");
		level.player waittill("menuresponse", menu, response);
		setblur(0, .1);
		
		if( response == "close" ) 
			continue;
		
		if( response == "jet_strike" )
		{
			if( level.air_support_active == 1 )
			{
				thread survspi_message( &"SURVSPI_GOT_KILLSTREAK" );
			}
			else
			{
				weap_price = get_weapon_price("jet");
				canbuy = buy_item( weap_price, "air_support" ); //1000
				if( canbuy == true)
				{
					level.player thread play_sound_on_tag("ui_mw3_buy");
					level.air_support_active = 1;
					thread jet_killstreak();
				}
				else
				{
					thread survspi_message( &"SURVSPI_GOT_NOMONEY" );
				}
			}	
		}
		else if( response == "ac130_strike" )
		{
			if( level.air_support_active == 1 )
			{
				thread survspi_message( &"SURVSPI_GOT_KILLSTREAK" );
			}
			else
			{
				weap_price = get_weapon_price("ac130");
				canbuy = buy_item( weap_price, "air_support" ); //2000
				if( canbuy == true)
				{
					level.player thread play_sound_on_tag("ui_mw3_buy");
					level.air_support_active = 1;
					thread ac130_killstreak();
				}
				else
				{
					thread survspi_message( &"SURVSPI_GOT_NOMONEY" );
				}
			}		
		}		
		else if( response == "heli_support" )
		{
			weap_price = get_weapon_price("heli");
			canbuy = buy_item( weap_price, "air_support" ); //4000
			if( canbuy == true)
			{
			//iprintlnbold(&"Heli_Support");
			//thread heli_killstreak();
			}
		}
		else if( response == "task_force" )
		{
			weap_price = get_weapon_price("task_force");
			canbuy = buy_item( weap_price, "reinforcements" ); //5000
			if( canbuy == true)
			{
				level.player thread play_sound_on_tag("ui_mw3_buy");
				thread task_force_reinforce();
			}
		}
		else if( response == "spec_ops" )
		{
			weap_price = get_weapon_price("spec_ops");
			canbuy = buy_item( weap_price, "reinforcements" ); //7000
			if( canbuy == true)
			{
				level.player thread play_sound_on_tag("ui_mw3_buy");
				thread spec_ops_reinforce();
			}
		}
		else if( response == "hero_team" )
		{
			weap_price = get_weapon_price("hero_team");
			canbuy = buy_item( weap_price, "reinforcements" ); //10000
			if( canbuy == true)
			{
				level.player thread play_sound_on_tag("ui_mw3_buy");
				thread hero_team_reinforce();
			}
		}
		// PERKS	
		else if( response == "sprint_perk" )
		{
			if( level.player_hasSprintPerk == true )
			{
				thread survspi_message( &"SURVSPI_GOT_SPRINT" );
			}
			else
			{
				weap_price = get_weapon_price("sprint_perk");
				canbuy = buy_item( weap_price, "perk" );	
				if( canbuy == true)
				{
					level.player thread play_sound_on_tag("ui_mw3_buy");
					level.player_hasSprintPerk = true;
				}
				else
				{
					thread survspi_message( &"SURVSPI_GOT_NOMONEY" );
				}
			}
		}	
		else if( response == "gun3_perk" )
		{
			if( level.player_has3GUNPerk == true )
			{
				thread survspi_message( &"SURVSPI_GOT_OVERKILL" );
			}
			else
			{
				weap_price = get_weapon_price("gun3_perk");
				canbuy = buy_item( weap_price, "perk" );	
				if( canbuy == true)
				{
					level.player thread play_sound_on_tag("ui_mw3_buy");
					level.player_has3GUNPerk = true;
				}
				else
				{
					thread survspi_message( &"SURVSPI_GOT_NOMONEY" );
				}
			}
		}	
		wait 0.1;
	}
}


/*###################
####### ENDING #######
#####################*/
BUYABLE_ENDING()
{
	endtrg = getent( "surv_ending_trigg" , "targetname" );
	endtrg sethintstring( &"SURVSPI_TRIGG_ENDING_PRICE_1MIL" );
	while(1)
	{
		endtrg waittill("trigger");		
		weap_price = get_weapon_price("ending");
		canbuy = buy_item( weap_price, "other" );
		if(canbuy == true)
		{
			//thread survival_ending();
			endtrg trigger_off();
			level.player.ignoreme = true;
			level.player Enableinvulnerability();
			thread hideshow_health_Bar( 0 );
			thread survival_gameover(&"SURVSPI_GAME_OVER_WIN");
			level notify( "survival_end" );
			musicstop(0.1);
			break;
		}
		else
		{
			thread survspi_message( &"SURVSPI_GOT_NOMONEY" );
		}
		wait 0.1;	
	}
	wait 0.1;
	musicplay("bog_a_victory");
	level.player thread play_sound_on_tag( "su_hq_win" );
}
/*########################################################
################## ARMORY CODE ####################
########################################################*/

buy_item( price, type, subtype )
{
		if( level.survspi_score < price )
		{
			thread survspi_message( &"SURVSPI_GOT_NOMONEY" );
			wait 0.1;
			return false;
		}
		else if( type == "ammo" && check_if_full_weap_ammo() )
		{
			thread survspi_message( &"SURVSPI_GOT_AMMO" );
			wait 0.1;
			return false;
		}
		else if( type == "air_support" && level.air_support_active == 1 )
		{
			thread survspi_message( &"SURVSPI_GOT_AIRSUP" );
			wait 0.1;
			return false;
		}
		else if( type == "reinforcements" && level.reinforcements_active == 1 )
		{
			thread survspi_message( &"SURVSPI_GOT_REINF" );
			wait 0.1;
			return false;
		}
		else if( type == "equipment" && isdefined(subtype) && check_if_full_eq_ammo( subtype ) )
		{
			thread survspi_message( &"SURVSPI_GOT_AMMO" );
			wait 0.1;
			return false;
		}
		else
		{
			level.survspi_score = level.survspi_score-price;
			return true;
		}
}

check_if_full_weap_ammo() // Scillman made this based on a nooby version of mine.
{
    weapons = level.player GetWeaponsListPrimaries();
    for ( i = 0; i < weapons.size; i++ )
    {
        weapon = weapons[i];
        if ( level.player getWeaponAmmoClip( weapon ) < WeaponClipSize( weapon ) )
            return false;
        if ( level.player getWeaponAmmoStock( weapon ) < WeaponMaxAmmo( weapon ) )
            return false;  
    }
    return true;
}

check_if_full_eq_ammo( subtype )
{
	if( subtype == "fraggrenade")
	{
		clipCount = level.player GetWeaponAmmoStock( "fraggrenade" );
		if( clipCount == 4 )
			return true;
		else 
			return false;
	}
	else if( subtype == "flash_grenade")
	{
		clipCount = level.player GetWeaponAmmoStock( "flash_grenade" );
		if( clipCount == 4 )
			return true;
		else 
			return false;
	}
	else if( subtype == "claymore")
	{
		clipCount = level.player GetWeaponAmmoStock( "claymore" );
		if( clipCount == 10 )
			return true;
		else 
			return false;
	}
	else if( subtype == "c4")
	{
		clipCount = level.player GetWeaponAmmoStock( "c4" );
		if( clipCount == 10 )
			return true;
		else 
			return false;
	}
}
 
disable_survival_stores()
{
	weapon_trigg = getent("weapon_trigg","targetname");
	equipment_armory_trigg = getent("equipment_armory_trigg","targetname");
	support_trigger = getent("support_trigger","targetname");
	weapon_trigg trigger_off();
	equipment_armory_trigg trigger_off();
	support_trigger trigger_off();
}
enable_survival_stores()
{
	weapon_trigg = getent("weapon_trigg","targetname");
	equipment_armory_trigg = getent("equipment_armory_trigg","targetname");
	support_trigger = getent("support_trigger","targetname");
	weapon_trigg trigger_on();
	equipment_armory_trigg trigger_on();
	support_trigger trigger_on();
}

get_weapon_price(response_name)
{
price = 0;

// Weapons

if( response_name == "ammo" )
price = 750;

else if( response_name == "ending" )
price = 100000;

else if( response_name == "beretta" )
price = 750;

else if( response_name == "usp" )
price = 500;
else if( response_name == "usp_silencer" )
price = 700;
else if( response_name == "colt45" )
price = 500;
else if( response_name == "deserteagle" )
price = 1000;

else if( response_name == "m16_basic" )
price = 2000;
else if( response_name == "m16_grenadier" )
price = 2500;
else if( response_name == "ak47" )
price = 2500;
else if( response_name == "ak47_grenadier" )
price = 3000;
else if( response_name == "m4_grunt" )
price = 2800;
else if( response_name == "m4_silencer" )
price = 3100;
else if( response_name == "m4m203_silencer" )
price = 3500;
else if( response_name == "m4_grenadier" )
price = 3500;
else if( response_name == "m4m203_acog" )
price = 4000;
else if( response_name == "m4_silencer_acog" )
price = 4000;
else if( response_name == "m4m203_silencer_reflex" )
price = 4500;

else if( response_name == "g3" )
price = 1000;
else if( response_name == "g36c" )
price = 2000;
else if( response_name == "mp44" )
price = 1500;

else if( response_name == "mp5" )
price = 1200;
else if( response_name == "mp5_silencer" )
price = 1500;
else if( response_name == "mp5_silencer_reflex" )
price = 2000;

else if( response_name == "uzi" )
price = 1000;
else if( response_name == "uzi_sd" )
price = 1200;

else if( response_name == "p90" )
price = 2500;
else if( response_name == "p90_silencer" )
price = 3000;

else if( response_name == "skorpion" )
price = 700;
else if( response_name == "ak74u" )
price = 1500;

else if( response_name == "saw" )
price = 7000;
else if( response_name == "rpd" )
price = 7000;
else if( response_name == "m60e4" )
price = 7000;

else if( response_name == "m40a3" )
price = 2000;
else if( response_name == "dragunov" )
price = 2500;
else if( response_name == "remington700" )
price = 2000;
else if( response_name == "barrett" )
price = 3500;

else if( response_name == "m14_scoped_woodland" )
price = 2500;
else if( response_name == "m14_scoped_ghil" )
price = 3000;
else if( response_name == "m14_scoped" )
price = 2500;

else if( response_name == "m1014" )
price = 1200;
else if( response_name == "winchester1200" )
price = 1000;

else if( response_name == "rpg_player" )
price = 1500;
else if( response_name == "at4" )
price = 2000;
else if( response_name == "stinger" )
price = 3000;

// Hands
else if( response_name == "usmc" )
price = 1000;
else if( response_name == "sasw" )
price = 1000;
else if( response_name == "russ" )
price = 1000;
else if( response_name == "arab" )
price = 1000;
else if( response_name == "bkkt" )
price = 1500;
else if( response_name == "frcn" )
price = 1500;
else if( response_name == "snpr" )
price = 2000;

// Equipments
else if( response_name == "fraggrenade" )
price = 750;
else if( response_name == "flash_grenade" )
price = 1000;

else if( response_name == "c4" )
price = 750;
else if( response_name == "c4_full" )
price = 1000;

else if( response_name == "claymore" )
price = 1000;
else if( response_name == "claymore_full" )
price = 1500;

// Support
else if( response_name == "jet" )
price = 2500;
else if( response_name == "ac130" )
price = 2500;
else if( response_name == "heli" )
price = 4000;

// Reinforcements
else if( response_name == "task_force" )
price = 3000;
else if( response_name == "spec_ops" )
price = 5000;
else if( response_name == "hero_team" )
price = 10000;

// Perks
else if( response_name == "body_armor" )
price = 2000;
else if( response_name == "self_revive" )
price = 4000;
else if( response_name == "sprint_perk" )
price = 4000;
else if( response_name == "gun3_perk" )
price = 5000;

return price;
}


//===============================================
//===============================================
//===============================================
//===============================================
//===============================================
//CATEGORY 7: WEAPON STUFF
//===============================================
//===============================================
//===============================================
//===============================================
//===============================================


refill_player_ammo()
{
	level.player thread play_sound_on_tag("weap_pickup");

	level.player givemaxammo("ak47");
	level.player givemaxammo("ak47_grenadier");
	level.player givemaxammo("gp25");
	
	level.player givemaxammo("m16_basic");
	level.player givemaxammo("m16_grenadier");
	level.player givemaxammo("m203");
	
	level.player givemaxammo("m4_grunt");
	level.player givemaxammo("m4_grenadier");
	level.player givemaxammo("m4_silencer");
	level.player givemaxammo("m4_silencer_acog");
	level.player givemaxammo("m4m203_acog");
	level.player givemaxammo("m4m203_silencer");
	level.player givemaxammo("m4m203_silencer_reflex");
	
	level.player givemaxammo("m203_m4");
	level.player givemaxammo("m203_m4_acog");
	level.player givemaxammo("m203_m4_silencer");
	level.player givemaxammo("m203_m4_silencer_reflex");

	level.player givemaxammo("g36c");
	level.player givemaxammo("g3");
	level.player givemaxammo("mp44");

	level.player givemaxammo("mp5");
	level.player givemaxammo("mp5_silencer");
	level.player givemaxammo("mp5_silencer_reflex");
	level.player givemaxammo("uzi");
	level.player givemaxammo("uzi_sd");
	level.player givemaxammo("p90");
	level.player givemaxammo("p90_silencer");
	level.player givemaxammo("ak74u");
	level.player givemaxammo("skorpion");
	
	level.player givemaxammo("saw");
	level.player givemaxammo("rpd");
	level.player givemaxammo("m60e4");
	
	level.player givemaxammo("m40a3");
	level.player givemaxammo("m14_scoped");	
	level.player givemaxammo("m14_scoped_ghil");	
	level.player givemaxammo("m14_scoped_woodland");	
	level.player givemaxammo("dragunov");
	level.player givemaxammo("remington700");
	level.player givemaxammo("barrett");
	
	level.player givemaxammo("m1014");
	level.player givemaxammo("winchester1200");
	
	level.player givemaxammo("beretta");
	level.player givemaxammo("usp");
	level.player givemaxammo("usp_silencer");
	level.player givemaxammo("colt45");
	level.player givemaxammo("deserteagle");
	
	// AMMO CLIP FILL

	level.player SetWeaponAmmoClip("ak47", 30 );
	level.player SetWeaponAmmoClip("ak47_grenadier", 30 );
	level.player SetWeaponAmmoClip("gp25", 1 );
	
	level.player SetWeaponAmmoClip("m16_basic", 30 );
	level.player SetWeaponAmmoClip("m16_grenadier", 30 );
	level.player SetWeaponAmmoClip("m203", 1 );
	
	level.player SetWeaponAmmoClip("m4_grunt", 30 );
	level.player SetWeaponAmmoClip("m4_grenadier", 30 );
	level.player SetWeaponAmmoClip("m4_silencer", 30 );
	level.player SetWeaponAmmoClip("m4_silencer_acog", 30 );
	level.player SetWeaponAmmoClip("m4m203_acog", 30 );
	level.player SetWeaponAmmoClip("m4m203_silencer", 30 );
	level.player SetWeaponAmmoClip("m4m203_silencer_reflex", 30 );
	
	level.player SetWeaponAmmoClip("m203_m4", 1 );
	level.player SetWeaponAmmoClip("m203_m4_acog", 1 );
	level.player SetWeaponAmmoClip("m203_m4_silencer", 1 );
	level.player SetWeaponAmmoClip("m203_m4_silencer_reflex", 1 );

	level.player SetWeaponAmmoClip("g36c", 30 );
	level.player SetWeaponAmmoClip("g3", 20 );
	level.player SetWeaponAmmoClip("mp44", 30 );

	level.player SetWeaponAmmoClip("mp5", 30 );
	level.player SetWeaponAmmoClip("mp5_silencer", 30 );
	level.player SetWeaponAmmoClip("mp5_silencer_reflex", 30 );
	level.player SetWeaponAmmoClip("uzi", 32 );
	level.player SetWeaponAmmoClip("uzi_sd", 32 );
	level.player SetWeaponAmmoClip("p90", 50 );
	level.player SetWeaponAmmoClip("p90_silencer", 50 );
	level.player SetWeaponAmmoClip("ak74u", 30 );
	level.player SetWeaponAmmoClip("skorpion", 30 );
	
	level.player SetWeaponAmmoClip("saw", 100 );
	level.player SetWeaponAmmoClip("rpd", 100 );
	level.player SetWeaponAmmoClip("m60e4", 100 );
	
	level.player SetWeaponAmmoClip("m40a3", 5 );
	level.player SetWeaponAmmoClip("m14_scoped", 10 );
	level.player SetWeaponAmmoClip("m14_scoped_ghil", 10 );
	level.player SetWeaponAmmoClip("m14_scoped_woodland", 10 );
	level.player SetWeaponAmmoClip("dragunov", 10 );
	level.player SetWeaponAmmoClip("remington700", 4 );
	level.player SetWeaponAmmoClip("barrett", 10 );
	
	level.player SetWeaponAmmoClip("m1014", 7 );
	level.player SetWeaponAmmoClip("winchester1200", 7 );
	
	level.player SetWeaponAmmoClip("beretta", 15 );
	level.player SetWeaponAmmoClip("usp", 12 );
	level.player SetWeaponAmmoClip("usp_silencer", 12 );
	level.player SetWeaponAmmoClip("colt45", 7 );
	level.player SetWeaponAmmoClip("deserteagle", 7 );
	
	wait 1;
}	

refill_player_frags()
{
	level.player thread play_sound_on_tag("grenade_pickup");

	level.player giveWeapon( "fraggrenade" );
	wait 1;
}	

refill_player_flash()
{
	level.player thread play_sound_on_tag("grenade_pickup");

	level.player giveWeapon( "flash_grenade" );
	wait 1;
}
	
refill_player_claymore()
{
	level.player thread play_sound_on_tag("grenade_pickup");
	level.player giveweapon("claymore");
	level.player givemaxammo("claymore");
	level.player SetActionSlot( 4, "weapon" , "claymore" );
	wait 1;
}

refill_player_c4()
{	
	level.player thread play_sound_on_tag("detpack_pickup");
	level.player giveweapon("c4");
	level.player givemaxammo("c4");
	level.player SetActionSlot( 2, "weapon" , "c4" );
	wait 1;
}

remove_dropped_weapons()
{
	for(;;)
	{
		guns = getentarray();
		for ( i = 0; i < guns.size; i++ )
			if ( getsubstr( guns[i].classname, 0, 10 ) == "weapon_rpd" )
				guns[i] delete();
		
		wait 0.05;
	}	
}

SavePlayerWeaponStatePersistent( slot )
{
	current = level.player getCurrentWeapon();
	if ( ( !isDefined( current ) ) || ( current == "none" ) )
		assertmsg( "Player's current weapon is 'none' or undefined. Make sure 'disableWeapons()' has not been called on the player when trying to save weapon states." );

	game[ "weaponstates" ][ slot ][ "current" ] = current;

	offhand = level.player getCurrentOffHand();
	game[ "weaponstates" ][ slot ][ "offhand" ] = offhand;
	game[ "weaponstates" ][ slot ][ "list" ] = [];
	weapList = level.player getWeaponsList();
	for ( weapIdx = 0 ; weapIdx < weapList.size ; weapIdx ++ )
	{
		game[ "weaponstates" ][ slot ][ "list" ][ weapIdx ][ "name" ] = weapList[ weapIdx ];
		game[ "weaponstates" ][ slot ][ "list" ][ weapIdx ][ "clip" ] = level.player getWeaponAmmoClip( weapList[ weapIdx ] );
		game[ "weaponstates" ][ slot ][ "list" ][ weapIdx ][ "stock" ] = level.player getWeaponAmmoStock( weapList[ weapIdx ] );
	}
}

RestorePlayerWeaponStatePersistent( slot )
{
	if ( !isDefined( game[ "weaponstates" ] ) )
		return false;

	if ( !isDefined( game[ "weaponstates" ][ slot ] ) )
		return false;

	for ( weapIdx = 0 ; weapIdx < game[ "weaponstates" ][ slot ][ "list" ].size ; weapIdx ++ )
	{
		weapName = game[ "weaponstates" ][ slot ][ "list" ][ weapIdx ][ "name" ];
		
		level.player giveWeapon( weapName );
		
		level.player setWeaponAmmoClip( weapName, game[ "weaponstates" ][ slot ][ "list" ][ weapIdx ][ "clip" ] );
		level.player setWeaponAmmoStock( weapName, game[ "weaponstates" ][ slot ][ "list" ][ weapIdx ][ "stock" ] );
	}

	level.player switchToOffhand( game[ "weaponstates" ][ slot ][ "offhand" ] );
	level.player switchToWeapon( game[ "weaponstates" ][ slot ][ "current" ] );

	return true;
}


//===============================================
//===============================================
//===============================================
//===============================================
//===============================================
//CATEGORY 8: PLAYER HEALTH & PERKS
//===============================================
//===============================================
//===============================================
//===============================================
//===============================================


PLAYER_SURVIVAL_HEALTH()
{
	level.survival_maxhealth = level.survival_maxhealth_value;
	level.survival_health = level.survival_maxhealth;
	
	level.player thread InfiniteHealth();
	level.player thread survival_player_health();
	level.player thread survival_player_health_restore();
	
	thread survival_player_health_multiplier_think();
	
	//then again maybe not.
	//wait 0.05; // needed so we make sure values are set in init.
	
	thread body_armor_HUD();
	thread last_stand_HUD();
	thread sprint_perk_HUD();
	thread guns3_perk_HUD();
	thread FastReload_perk_HUD();
	
	thread guns3_perk_manage();

	thread kill_perks_on_end();
	
	wait 0.05;
	// Made it too easy Keeping default.
	// Also keep it here just in case.
	setsaveddvar("player_damageMultiplier", "0.26"); // Making it easier.

}

guns3_perk_manage()
{

	while(1)
	{ if(level.player_has3GUNPerk == true) break; wait 0.05; }
	
	plrweapamount = level.player GetWeaponsListPrimaries();
	//for ( i = 0; i < plrweapamount.size; i++ )
	
	if( plrweapamount.size == 1 )
	{
		level.player giveweapon("usp");
		level.player givemaxammo("usp");
		
		level.player giveweapon("colt45");
		level.player givemaxammo("colt45");
	}
	else if( plrweapamount.size == 2 )
	{
		//attempt #1 beretta
		if( level.player HasWeapon( "beretta" ) )
		{
			//attempt #2 usp
			if( level.player HasWeapon( "usp" ) )
			{
				level.player giveweapon("colt45");
				level.player givemaxammo("colt45");
			}
			else
			{
				level.player giveweapon("usp");
				level.player givemaxammo("usp");
			}
		}
		else
		{
			level.player giveweapon("beretta");
			level.player givemaxammo("beretta");
		}
		
	}
}

InfiniteHealth()
{
	self endon( "death" );
	self endon( "survival_end" );
	for ( ;; )
	{
		level.player.health = 1000000;
		level.player waittill( "damage" );
	}
}


survival_player_health()
{
	self endon( "death" );
	self endon( "survival_end" );
	self endon( "start_laststand" );
	for ( ;; )
	{
		self waittill( "damage", damage );
		if ( level.player_has_vest ) 
		{
			level.player_vest_health = level.player_vest_health - damage;
			if ( level.player_vest_health <= 0 )
			{
				level.player_has_vest = false;
				level.player_vest_health = 0;
			}
		}
		else
			level.survival_health = level.survival_health - damage;
	}
}

player_give_body_armor()
{
	level.player_has_vest = true;
	level.player_vest_health = level.player_vest_maxhealth;
}


survival_player_health_restore()
{
	self endon( "death" );
	//self endon( "survival_end" );
	self endon( "start_laststand" );
	for ( ;; )
	{
		if ( level.survival_health <= 0 )
		{
			thread lose_perks_exceptLS();
			
			if ( level.player_hasLastStandPerk == true )
			{				
				self thread playerLastStand();
			}
			else
			{
				self EnableInvulnerability();
				thread hideshow_health_Bar( 0 );
				thread survival_gameover(&"SURVSPI_GAME_OVER", 1);
				self notify( "survival_end" ); // player died
				break;
			}
		}
		
		//small delay before it starts recharging. Delay comes back every time player's shot.
		else if ( level.survival_health < level.survival_maxhealth )
		{
			thread restore_health_system();
		}		
		//else if ( level.survival_health < level.survival_maxhealth )
			//level.survival_health = level.survival_health + level.survival_player_health_multiplier;	
		else if ( level.survival_health == level.survival_maxhealth )
		{
			wait( 0.05 );
			continue;
		}
		wait( 0.05 );
	}
	wait 1;	
	level.player thread play_sound_on_tag( "su_hq_fail" );
}


restore_health_system()
{
	level.player endon( "damage" );
	
	wait level.player_health_recharge_delay;
	level.survival_health = level.survival_health + level.survival_player_health_multiplier;
}


survival_player_health_multiplier_think()
{
	level.survival_player_health_multiplier = 1;
	level.player_health_recharge_delay = 0.1;

	while(1)
	{
		if(level.survival_health < 50)
		{
			level.survival_player_health_multiplier = 1;
			level.player_health_recharge_delay = 0.1;
		}
		else if(level.survival_health < 100)
		{
			level.survival_player_health_multiplier = 2.5;
			level.player_health_recharge_delay = 0.25;
		}	
		else if(level.survival_health < 250)
		{
			level.survival_player_health_multiplier = 5;
			level.player_health_recharge_delay = 1;
		}
		else
		{
			level.survival_player_health_multiplier = 1;
			level.player_health_recharge_delay = 0.1;
		}
		//iprintlnbold(level.player_health_recharge_delay);
		wait 0.05;
	}

}

lose_perks_exceptLS()
{
	level.player_hasSprintPerk = false;
	level.player_hasReloadPerk = false;
	//level.player_has3GUNPerk = false; // we never lose this.
}

survival_gameover( text, red_bg)
{
	//level waittill( "survival_end" );
	
	//======================================================

	if( level.survspi_seconds < 10)
		setdvar("survspi_sub_seconds", 0 );
	else
		setdvar("survspi_sub_seconds", "" );

	survspi_waves_survived = level.survspi_wave;

	setdvar("survspi_wave", level.survspi_wave );

	setdvar("survspi_minutes", level.survspi_minutes );
	setdvar("survspi_seconds", level.survspi_seconds );
	setdvar("survspi_mili_seconds", level.survspi_mili_seconds );
	setdvar("survspi_score", level.survspi_score );
	setdvar("survspi_kills", level.survspi_kills);
	setdvar("survspi_headshots", level.survspi_headshots);
	
	//======================================================
	
	if ( !level.player.ignoreme )
		level.player.ignoreme = true;

	level notify( "end_survival_gameplay" ); // use on wave system
	if(isdefined(red_bg))
	{
		//level.player  AllowStand( false );
		//level.player  AllowCrouch( false );
		thread ForcePlayerProneTimer();
	}
	level.player  AllowSprint( false );

	level.player disableweapons();
	level.player TakeAllWeapons();
	thread simple_hud_hide();
	wait( 1 );

	game_over = NewHudElem();
	game_over.alignX = "center";
	game_over.alignY = "middle";
	game_over.horzAlign = "center";
	game_over.vertAlign = "middle";
	game_over.x = 0;
	game_over.y = -150; 
	game_over.foreground = true;
	game_over.fontScale = 5;
	game_over.alpha = 1;
	game_over.sort = 1;
	//game_over SetPulseFX( 50, 3200, 500 );//fade in time, time ms, fade out time
	
	//game_over.label = &"SURVSPI_GAME_OVER"; 
	game_over.label = text; 
	
	level.player freezeControls( true );

	game_over thread fade_overlay_survspi( 1, 2);
	setblur(4, 2);
	
	if(isdefined(red_bg))
	{
	red_overlay = hud_overlay_survspi( "overlay_hunted_red", 0 );
	red_overlay.sort = -1;
	red_overlay thread fade_overlay_survspi( 0.5, 2);
	}

	wait( 2 );
	level.player openMenu("survspi_gameover");
	level.player waittill("menuresponse", menu, response);

	if(response == "back2menu")
	{
		changelevel("");
	}	
}



body_armor_HUD()
{
	level endon("survival_end");

	level.body_armor_hud = maps\_hud_util::get_countdown_hud();
	level.body_armor_hud.alignX = "center";
	level.body_armor_hud.alignY = "bottom";
	level.body_armor_hud.horzAlign = "center";
	level.body_armor_hud.vertAlign = "bottom";
	level.body_armor_hud.y = -40;
	level.body_armor_hud.x = 30;
	level.body_armor_hud.fontScale = 1;
	level.body_armor_hud.hidewheninmenu = true;
	level.body_armor_hud.alpha = 0;
	level.body_armor_hud.color = ( 1.0, 1.0, 1.0 );
	level.body_armor_hud.label = &"SURVSPI_ARMOR_COUNT"; 

	level.body_armor_hud_icon = NewHudElem();
	level.body_armor_hud_icon.alignX = "center";
	level.body_armor_hud_icon.alignY = "bottom";
	level.body_armor_hud_icon.horzAlign = "center";
	level.body_armor_hud_icon.vertAlign = "bottom";
	level.body_armor_hud_icon.y = -50;
	level.body_armor_hud_icon.x = 30;
	level.body_armor_hud_icon.foreground = true;
	level.body_armor_hud_icon.hidewheninmenu = true;
	level.body_armor_hud_icon.alpha = 0;
	level.body_armor_hud_icon SetShader( "icon_vests", 32, 32 );
	
	level waittill("waves_started");

	while(1)
	{			
		level.body_armor_hud setValue( level.player_vest_health );
		if(level.player_has_vest == true)
		{
			level.body_armor_hud_icon.alpha = 1;
			level.body_armor_hud.alpha = 1;
		}
		else
		{
			level.body_armor_hud_icon.alpha = 0;
			level.body_armor_hud.alpha = 0;
		}
		wait 0.05;
	}

}

last_stand_HUD()
{
	level endon("survival_end");

	level.last_stand_hud = NewHudElem();
	level.last_stand_hud.alignX = "center";
	level.last_stand_hud.alignY = "bottom";
	level.last_stand_hud.horzAlign = "center";
	level.last_stand_hud.vertAlign = "bottom";
	level.last_stand_hud.y = -50; //50
	level.last_stand_hud.x = -30; // 20
	level.last_stand_hud.foreground = true;
	level.last_stand_hud.hidewheninmenu = true;
	level.last_stand_hud.alpha = 0;
	level.last_stand_hud SetShader( "hud_self_revive_so", 32, 32 );

	level waittill("waves_started");

	while(1)
	{
		if(level.player_hasLastStandPerk == true)
		{
			level.last_stand_hud.alpha = 1;
		}
		else
		{
			level.last_stand_hud.alpha = 0;
		}
		wait 0.05;
	}

}

sprint_perk_HUD()
{
	level endon("survival_end");

	level.sprint_perk_hud = NewHudElem();
	level.sprint_perk_hud.alignX = "center";
	level.sprint_perk_hud.alignY = "bottom";
	level.sprint_perk_hud.horzAlign = "center";
	level.sprint_perk_hud.vertAlign = "bottom";
	level.sprint_perk_hud.y = -50; 
	level.sprint_perk_hud.x = -90; 
	level.sprint_perk_hud.foreground = true;
	level.sprint_perk_hud.hidewheninmenu = true;
	level.sprint_perk_hud.alpha = 0;
	level.sprint_perk_hud SetShader( "specialty_longersprint", 32, 32 );

	level waittill("waves_started");

	while(1)
	{
		if(level.player_hasSprintPerk == true)
		{
			level.sprint_perk_hud.alpha = 1;
			level.player setMoveSpeedScale( 1.25 );
		}
		else
		{
			level.sprint_perk_hud.alpha = 0;
		}
		wait 0.05;
	}

}

guns3_perk_HUD()
{
	level endon("survival_end");

	level.guns3_perk_hud = NewHudElem();
	level.guns3_perk_hud.alignX = "center";
	level.guns3_perk_hud.alignY = "bottom";
	level.guns3_perk_hud.horzAlign = "center";
	level.guns3_perk_hud.vertAlign = "bottom";
	level.guns3_perk_hud.y = -50; 
	level.guns3_perk_hud.x = 90; 
	level.guns3_perk_hud.foreground = true;
	level.guns3_perk_hud.hidewheninmenu = true;
	level.guns3_perk_hud.alpha = 0;
	level.guns3_perk_hud SetShader( "specialty_twoprimaries", 32, 32 );

	level waittill("waves_started");

	while(1)
	{
		if(level.player_has3GUNPerk == true)
		{
			level.guns3_perk_hud.alpha = 1;
			break;
		}
		wait 0.05;
	}

	while(1)
	{
		if(level.player_isInLastStand == true)
		{
			level.guns3_perk_hud.alpha = 0;
		}
		else
		{
			level.guns3_perk_hud.alpha = 1;
		}
		wait 0.05;
	}

}

FastReload_perk_HUD()
{
	level endon("survival_end");

	level.fastreload_perk_hud = NewHudElem();
	level.fastreload_perk_hud.alignX = "center";
	level.fastreload_perk_hud.alignY = "bottom";
	level.fastreload_perk_hud.horzAlign = "center";
	level.fastreload_perk_hud.vertAlign = "bottom";
	level.fastreload_perk_hud.y = -50; 
	level.fastreload_perk_hud.x = -90; 
	level.fastreload_perk_hud.foreground = true;
	level.fastreload_perk_hud.alpha = 0;
	level.fastreload_perk_hud SetShader( "specialty_fastreload", 32, 32 );

	level waittill("waves_started");

	while(1)
	{
		if(level.player_hasReloadPerk == true)
		{
			level.fastreload_perk_hud.alpha = 1;
		}
		else
		{
			level.fastreload_perk_hud.alpha = 0;
		}
		wait 0.05;
	}

}

kill_perks_on_end()
{
	level waittill("survival_end");

	level.last_stand_hud destroy();
	level.body_armor_hud_icon destroy();
	level.body_armor_hud destroy();
	level.sprint_perk_hud destroy();
	level.guns3_perk_hud destroy();
	level.fastreload_perk_hud destroy();
}

playerLastStand()
{
	self endon( "death" );
	self notify( "start_laststand" );
	level notify( "player_in_laststand" );
	level.player_isInLastStand = true;

	level.player_hasLastStandPerk = false;
	level.player thread play_sound_on_tag(  "ui_mw3_wave_lasta"  );

	thread disable_survival_stores();

	thread ForcePlayerProneTimer();

	self setMoveSpeedScale( 0.8 );

	thread SavePlayerWeaponStatePersistent( "last_stand" );

	self takeAllWeapons();
	self thread playerGiveLastStandWeapon();
	self.ignoreme = true;
	self thread revive_load_bar();
	
	//self shellShock( "jeepride_action", 10 ); // no good
	self waittill( "revived" );
	level.survival_health = level.survival_maxhealth;
	self thread survival_player_health();
	self thread survival_player_health_restore();
	level.player_isInLastStand = false;

	thread enable_survival_stores();

	thread ForcePlayerStandTimer_free();

	self setMoveSpeedScale( 1 );
	self takeAllWeapons();
	self.ignoreme = false;

	bWeaponsCarriedOver = RestorePlayerWeaponStatePersistent( "last_stand" );
}

ForcePlayerProneTimer()
{		
	level.player allowProne( true );
	level.player AllowSprint( false );
	level.player allowStand( false );
	level.player allowCrouch( false );
	wait 0.5;
	level.player setStance( "prone" );
}

ForcePlayerStandTimer_free()
{		
	level.player AllowSprint( true );
	level.player allowStand( true );
	level.player allowCrouch( true );
	level.player allowProne( true );
	wait 0.5;
	level.player setStance( "stand" );
}

playerGiveLastStandWeapon()
{
	if ( !isDefined( level.LastStandWeapon ) )
		level.LastStandWeapon = "defaultweapon";

	self giveWeapon( level.LastStandWeapon );
	self giveMaxAmmo( level.LastStandWeapon );
	self switchToWeapon( level.LastStandWeapon );
}

revive_load_bar( )
{	
	revive_kill = level.survspi_kills;

	level.secondaryProgressBarY = 75;
    level.secondaryProgressBarHeight = 14;
    level.secondaryProgressBarWidth = 152;
    level.secondaryProgressBarTextY = 45;
    level.secondaryProgressBarFontSize = 2;

    interval = .05;
    timesofar = 0;
    planttime = 8;

    while ( true )
    {
        level.player startProgressBar( planttime );
        level.player.progresstext settext( &"SURVSPI_REVIVING" );
        success = false;
		
        while ( true )
        {
            timesofar += interval;
            level.player setProgressBarProgress(timesofar / planttime);
            if (timesofar >= planttime)
            {				
                success = true;
                break;
            }		
			if( revive_kill < level.survspi_kills )
			{
				//iprintlnbold(&"revive_kill");
				success = true;
				break;	
			}
			wait 0.05;
        }
		
        level.player endProgressBar();
        if ( success )
            break;
    }
	level.player notify( "revived" );

}

// ------------ progress bar ------------

startProgressBar( planttime )
{
	self.progresstext = createSecondaryProgressBarText();
	self.progressbar = createSecondaryProgressBar();
}

setProgressBarProgress( amount )
{
	if ( amount > 1 )
		amount = 1;

	self.progressbar maps\_hud_util::updateBar( amount );
}

endProgressBar()
{
	if ( isDefined( self.progresstext ) )
		self.progresstext maps\_hud_util::destroyElem();

	if ( isDefined( self.progressbar ) )
		self.progressbar maps\_hud_util::destroyElem();
}

createSecondaryProgressBar()
{
	bar = maps\_hud_util::createBar( "white", "black", level.secondaryProgressBarWidth, level.secondaryProgressBarHeight );
	bar maps\_hud_util::setPoint( "CENTER", undefined, 0, level.secondaryProgressBarY );
	return bar;
}

createSecondaryProgressBarText()
{
	text = maps\_hud_util::createFontString( "default", level.secondaryProgressBarFontSize );
	text maps\_hud_util::setPoint( "CENTER", undefined, 0, level.secondaryProgressBarTextY );
	return text;
}

// ======= Health Bar ========

TEST_health_bar()
{	
	level endon("survival_end");
	
	level.HealthBarX = 0;
	level.HealthBarY = 230;
    level.HealthBarHeight = 12;
    level.HealthBarWidth = 128;

	//survival_player_health_restore() check the small delay between recharge.

	level.player startHealthBar();
	thread hideshow_health_Bar( 0 );

    while(1)
    {
		level.player thread setHealthBarProgress( level.survival_health / level.survival_maxhealth );
		wait 0.05;
    }
}

startHealthBar()
{
	self.healthbar = createSecondary_health_Bar();
	self.healthbar.foreground = 1;
	self.healthbar.hidewheninmenu = true;
	self.healthbar.bar.foreground = 1;
	self.healthbar.bar.hidewheninmenu = true;
}

createSecondary_health_Bar()
{
	bar = maps\_hud_util::createBar( "white", "black", level.HealthBarWidth, level.HealthBarHeight );
	bar maps\_hud_util::setPoint( "CENTER", undefined, level.HealthBarX, level.HealthBarY );
	return bar;
}

setHealthBarProgress( amount )
{
	level endon("survival_end");

	if ( amount > 1 )
		amount = 1;
	else if ( amount < 0 )
		amount = 0;
		
		
	self.healthbar.bar thread healthbar_color_manage();
	self.healthbar thread maps\_hud_util::updateBar( amount );
}

healthbar_color_manage()
{
	value = level.survival_health;

	//define what colors to use
	color_green = []; //250
	color_green[0] = 0.0;
	color_green[1] = 1.0;
	color_green[2] = 0.0;
	color_lime = [];
	color_lime[0] = 0.5;
	color_lime[1] = 1.0;
	color_lime[2] = 0.0;
	color_yellow = [];
	color_yellow[0] = 1.0;
	color_yellow[1] = 1.0;
	color_yellow[2] = 0.0;
	color_orange = [];
	color_orange[0] = 1.0;
	color_orange[1] = 0.5;
	color_orange[2] = 0.0;
	color_red = []; //0
	color_red[0] = 1.0;
	color_red[1] = 0.0;
	color_red[2] = 0.0;

	//default color
	SetValue = [];
	SetValue[0] = color_green[0];
	SetValue[1] = color_green[1];
	SetValue[2] = color_green[2];
	
	//define where the non blend points are	
	green = level.survival_maxhealth_value;
	lime = 175;
	yellow = 125;
	orange = 75;
	red = 0;
	
	iPercentage = undefined;
	difference = undefined;
	increment = undefined;
	
	if ( (value < green) && (value >= lime) )
	{
		iPercentage = int( (value - green) * (100 / (lime - green) ) );
		for ( colorIndex = 0 ; colorIndex < SetValue.size ; colorIndex++ )
		{
			difference = (color_lime[colorIndex] - color_green[colorIndex]);
			increment = (difference / 100);
			SetValue[colorIndex] = color_green[colorIndex] + (increment * iPercentage);
		}
	}
	else if ( (value < lime) && (value >= yellow) )
	{
		iPercentage = int( (value - lime) * (100 / (yellow - lime) ) );
		for ( colorIndex = 0 ; colorIndex < SetValue.size ; colorIndex++ )
		{
			difference = (color_yellow[colorIndex] - color_lime[colorIndex]);
			increment = (difference / 100);
			SetValue[colorIndex] = color_lime[colorIndex] + (increment * iPercentage);
		}
	}
	else if ( (value < yellow) && (value >= orange) )
	{
		iPercentage = int( (value - yellow) * (100 / (orange - yellow) ) );
		for ( colorIndex = 0 ; colorIndex < SetValue.size ; colorIndex++ )
		{
			difference = (color_orange[colorIndex] - color_yellow[colorIndex]);
			increment = (difference / 100);
			SetValue[colorIndex] = color_yellow[colorIndex] + (increment * iPercentage);
		}
	}
	else if ( (value < orange) && (value >= red) )
	{
		iPercentage = int( (value - orange) * (100 / (red - orange) ) );
		for ( colorIndex = 0 ; colorIndex < SetValue.size ; colorIndex++ )
		{
			difference = (color_red[colorIndex] - color_orange[colorIndex]);
			increment = (difference / 100);
			SetValue[colorIndex] = color_orange[colorIndex] + (increment * iPercentage);
		}
	}
	else if ( (value <= red) )
	{
		for ( colorIndex = 0 ; colorIndex < SetValue.size ; colorIndex++ )
		{
			SetValue[colorIndex] = color_red[colorIndex];
		}
	}

	self.color = (SetValue[0], SetValue[1], SetValue[2]);
}


hideshow_health_Bar( arg )
{
	if(arg == 1)
	{
		level.player.healthbar.bar.alpha = 1;
		level.player.healthbar.alpha = 0.5;
	}
	else
	{
		level.player.healthbar.bar.alpha = 0;
		level.player.healthbar.alpha = 0;
	}
}


//===============================================
//===============================================
//===============================================
//===============================================
//===============================================
//CATEGORY 9: KILLSTREAKS
//===============================================
//===============================================
//===============================================
//===============================================
//===============================================

uav_ac130_models()
{
	//default, each map can have different onces.
	uav_offset_width = 5000;
	uav_offset_height = 5000;
	ac130_offset_width = -8000;
	ac130_offset_height = 8000;

	survival_center_of_map_org = getent( "survival_center_of_map_org" , "targetname" );	
	survival_center_of_map_org thread spawn_survival_uav( uav_offset_width, uav_offset_height );
	survival_center_of_map_org thread spawn_survival_ac130( ac130_offset_width, ac130_offset_height );	
}

spawn_survival_uav( offset_w, offset_h )
{
	uav_org = spawn("script_origin", self.origin );
	uav_org.origin = self.origin;
	uav_org.angles = (0, 0, 0);

	uav = spawn("script_model", self.origin );
	uav.origin = self.origin;
	uav.angles = self.angles;
	uav setmodel( "vehicle_uav_static" );
	uav linkto( uav_org , "" , (offset_w , 0 , offset_h) , (0, 90, -30 ) );
	while(1)
	{
		uav_org rotateyaw(360, 120);
		wait 120;	
	}	
}

spawn_survival_ac130( offset_w, offset_h )
{
	ac130_org = spawn("script_origin", self.origin );
	ac130_org.origin = self.origin;
	ac130_org.angles = (0, 0, 0);

	level.ac130_model = spawn("script_model", self.origin);
	level.ac130_model.origin = self.origin;
	level.ac130_model.angles = self.angles;
	level.ac130_model setmodel( "vehicle_ac130_low" );
	level.ac130_model linkto( ac130_org , "" , (offset_w , 0 , offset_h) , (45, 0, 0) );
	while(1)
	{
		ac130_org rotateyaw(360, 180);
		wait 180;	
	}	
}

/*######################
######### AC130 #########
########################*/

ac130_killstreak()
{
	level.player giveWeapon( "smoke_marker" );
	level.player SetActionSlot( 4, "weapon", "smoke_marker" );
	level.player SetWeaponAmmoClip( "smoke_marker", 0 );
	level.player SetWeaponAmmoStock( "smoke_marker", 1 );
	
	while(1)
	{
		level.player waittill ( "grenade_fire", grenade, weaponName );
		if ( weaponname == "smoke_marker" )
		{
			level.player TakeWeapon( "smoke_marker" );
			tracker = spawn ("script_model", grenade.origin);
			tracker setmodel("weapon_us_smoke_grenade_burnt");
			tracker.angles = (90,90,0);
			tracker hide();
			tracker thread track_grenade_origin( grenade );
			wait 3.5;
			grenade notify("collision");
			grenade delete();
			tracker show();
			tracker playsound("smokegrenade_explode_default");
			PlayFX( level._effect["red_smoke"], tracker.origin );
			break;
		}
	}
	wait 0.5;
	level.player thread play_sound_on_tag( "air_support_response" );
	wait 2;
	thread ac130_strike(tracker);
	level waittill("destroy_smoke_marker");
	tracker delete();
	level.air_support_active = 0;
}
	
track_grenade_origin( grenade )
{
	grenade endon ( "death" );
	grenade endon ( "collision" );
	while ( 1 )
	{
		self.origin = grenade.origin;
		wait .05;
	}
}	


ac130_strike(smoke_marker_position)
{
	for( i = 0 ; i < 10 ; i++ )
	{
		smoke_marker_position thread ac130_fire();
		wait 0.5;
	}
	wait 3;
	level notify("ac130_finished");
	level notify("destroy_smoke_marker");
}

ac130_fire()
{
	ac_org = spawn("script_model", self.origin );
	ac_org.origin = self.origin;
	ac_org.angles = VectorToAngles(level.ac130_model.origin-self.origin);
	ac_org setmodel( "tag_flash" );
	//level.ac130_model playsound("ac130_40mm_fire");
	level.ac130_model playsound("ac130_105mm_fire");
	
	self playsound("artillery_incoming");
	PlayFXOnTag( level._effect["tracer_incoming"], ac_org, "tag_origin" );
	wait 1;
	PlayFX( level._effect["big_explosion"], self.origin );
	self thread killstreak_explosion_damage();
	self playsound("artillery_explosion");
	wait 3;
	ac_org delete();
}

/*####################
######### JET #########
#####################*/

jet_killstreak()
{

	level.player giveWeapon( "airstrike_support" );
	level.player SetActionSlot( 4, "weapon" , "airstrike_support" );
	level.player SetWeaponAmmoClip( "airstrike_support", 1 );
	level.player SetWeaponAmmoStock( "airstrike_support", 0 );
	
	thread airstrike_support();
}

airstrike_support()
{
	level endon( "air_support_called" );

	level.playerPreviousWeapon = undefined;
	
	for ( ;; )
	{
		while( level.player getcurrentweapon() != "airstrike_support" )
		{
			level.playerPreviousWeapon = level.player getcurrentweapon();
			
			wait( 0.05 );
		}
		
		thread airstrike_support_activate();
		
		while( level.player getcurrentweapon() == "airstrike_support" )
		{
			wait( 0.05 );
		}
		
		level notify( "air_support_canceled" );
		
		thread airstrike_support_deactive();
		
		wait( 0.05 );
	}
}

airstrike_support_activate()
{
	level endon( "air_support_canceled" );
	level endon( "air_support_called" );

	thread airstrike_support_paint_target();

	level.airstrikeAttackArrow = spawn( "script_model", ( 0, 0, 0 ) );
	level.airstrikeAttackArrow setModel( "tag_origin" );
	level.airstrikeAttackArrow.angles = ( -90, 0, 0 );
	level.airstrikeAttackArrow.offset = 4;

	playfxontag( level.air_support_fx_yellow, level.airstrikeAttackArrow, "tag_origin" );

	level.playerActivatedAirSupport = true;

	coord = undefined;

	traceOffset = 15;
	traceLength = 15000;
	minValidLength = 300 * 300;

	trace = [];

	trace[ 0 ] = spawnStruct();
	trace[ 0 ].offsetDir = "vertical";
	trace[ 0 ].offsetDist = traceOffset;

	trace[ 1 ] = spawnStruct();
	trace[ 1 ].offsetDir = "vertical";
	trace[ 1 ].offsetDist = traceOffset * -1;

	trace[ 2 ] = spawnStruct();
	trace[ 2 ].offsetDir = "horizontal";
	trace[ 2 ].offsetDist = traceOffset;

	trace[ 3 ] = spawnStruct();
	trace[ 3 ].offsetDir = "horizontal";
	trace[ 3 ].offsetDist = traceOffset * -1;

	for ( ;; )
	{
		wait( 0.05 );
		
		prof_begin( "spotting_marker" );
		
		direction = level.player getPlayerAngles();
		direction_vec = anglesToForward( direction );
		eye = level.player getEye();
		
		for ( i = 0 ; i < trace.size ; i++ )
		{
			start = eye;
			vec = undefined;
			if ( trace[ i ].offsetDir == "vertical" )
				vec = anglesToUp( direction );
			else if ( trace[ i ].offsetDir == "horizontal" )
			{
				vec = anglesToRight( direction );
			}
			
			assert( isdefined( vec ) );
			
			start = start + vector_multiply( vec, trace[ i ].offsetDist );
			
			trace[ i ].trace = bullettrace( start, start + vector_multiply( direction_vec , traceLength ), 0, undefined );
			
			trace[ i ].length = distanceSquared( start, trace[ i ].trace[ "position" ] );
		}
		
		validLocations = [];
		
		validNormals = [];
		
		for ( i = 0 ; i < trace.size ; i++ )
		{
			if ( trace[ i ].length < minValidLength )
			{
				continue;
			}
			
			index = validLocations.size;
			
			validLocations[ index ] = trace[ i ].trace[ "position" ];
			validNormals[ index ] = trace[ i ].trace[ "normal" ];
		}
		
		if ( validLocations.size == 0 )
		{
			for ( i = 0 ; i < trace.size ; i++ )
			{
				validLocations[ i ] = trace[ i ].trace[ "position" ];
				validNormals[ i ] = trace[ i ].trace[ "normal" ];
			}
		}
		
		assert( validLocations.size > 0 );
		
		if ( validLocations.size == 4 )
		{
			fxLocation = findAveragePointVec( validLocations[ 0 ], validLocations[ 1 ], validLocations[ 2 ], validLocations[ 3 ] );
			fxNormal = findAveragePointVec( validNormals[ 0 ], validNormals[ 1 ], validNormals[ 2 ], validNormals[ 3 ] );
		}
		else if ( validLocations.size == 3 )
		{
			fxLocation = findAveragePointVec( validLocations[ 0 ], validLocations[ 1 ], validLocations[ 2 ] );
			fxNormal = findAveragePointVec( validNormals[ 0 ], validNormals[ 1 ], validNormals[ 2 ] );
		}
		else if ( validLocations.size == 2 )
		{
			fxLocation = findAveragePointVec( validLocations[ 0 ], validLocations[ 1 ] );
			fxNormal = findAveragePointVec( validNormals[ 0 ], validNormals[ 1 ] );
		}
		else
		{
			fxLocation = validLocations[ 0 ];
			fxNormal = validNormals[ 0 ];
		}
		
		thread drawAirstrikeAttackArrow( fxLocation, fxNormal );
		
		prof_end( "spotting_marker" );
	}
}

drawAirstrikeAttackArrow( coord, normal )
{
	assert( isdefined( level.airstrikeAttackArrow ) );
	
	coord += vector_multiply( normal, level.airstrikeAttackArrow.offset );
	level.airstrikeAttackArrow.origin = coord;
	level.airstrikeAttackArrow rotateTo( vectortoangles( normal ), 0.2 );
}

findAveragePointVec( point1, point2, point3, point4 )
{
	assert( isdefined( point1 ) );
	assert( isdefined( point2 ) );
	
	if ( isdefined( point4 ) )
	{
		x = findAveragePoint( point1[ 0 ], point2[ 0 ], point3[ 0 ], point4[ 0 ] );
		y = findAveragePoint( point1[ 1 ], point2[ 1 ], point3[ 1 ], point4[ 1 ] );
		z = findAveragePoint( point1[ 2 ], point2[ 2 ], point3[ 2 ], point4[ 2 ] );
	}
	else if ( isdefined( point3 ) )
	{
		x = findAveragePoint( point1[ 0 ], point2[ 0 ], point3[ 0 ] );
		y = findAveragePoint( point1[ 1 ], point2[ 1 ], point3[ 1 ] );
		z = findAveragePoint( point1[ 2 ], point2[ 2 ], point3[ 2 ] );
	}
	else
	{	
		x = findAveragePoint( point1[ 0 ], point2[ 0 ] );
		y = findAveragePoint( point1[ 1 ], point2[ 1 ] );
		z = findAveragePoint( point1[ 2 ], point2[ 2 ] );
	}
	return( x, y, z );
}

findAveragePoint( point1, point2, point3, point4 )
{
	assert( isdefined( point1 ) );
	assert( isdefined( point2 ) );
	
	if ( isdefined( point4 ) )
		return ( ( point1 + point2 + point3 + point4 ) / 4 );
	else if ( isdefined( point3 ) )
		return ( ( point1 + point2 + point3 ) / 3 );
	else
		return ( ( point1 + point2 ) / 2 );
}


airstrike_support_paint_target()
{
	level endon( "air_support_canceled" );

	level.player waittill( "weapon_fired" );
	wait 0.1;
	level.player thread play_sound_on_tag( "jet_strike_response" );

	thread airstrike_support_mark();

	weaponList = level.player GetWeaponsListPrimaries();

	if ( isdefined( weaponList[ 0 ] ) && ( weaponList[ 0 ] == level.playerPreviousWeapon ) )
	{
		level.player switchToWeapon( weaponList[ 0 ] );
	}
	else if ( isdefined( weaponList[ 1 ] ) && ( weaponList[ 1 ] == level.playerPreviousWeapon ) )
	{
		level.player switchToWeapon( weaponList[ 1 ] );
	}
	else
	{
		level.player switchToWeapon( weaponList[ 0 ] );
	}

	level.player TakeWeapon( "airstrike_support" );

	coord = level.airstrikeAttackArrow.origin;

	thread airstrike_support_launch( coord );

	level notify( "air_support_called" );

	airstrike_support_deactive();

}

airstrike_support_mark()
{
	marker = spawn( "script_model", level.airstrikeAttackArrow.origin );
	marker setModel( "tag_origin" );
	marker.angles = level.airstrikeAttackArrow.angles;

	level.marker = marker;

	wait( 0.1 );

	playfxontag( level.air_support_fx_red, marker, "tag_origin" );

	wait( 5 );

	marker delete();
}

airstrike_support_launch( coord )
{
	wait 5;
	thread jet_pass( coord );
}


jet_pass(air_support_marker)
{
	jet_height = 3000;
	jet_distance = 20000;
	jet_n_distance = jet_distance*-1;
	jet_time = 2.5;
	
	drop_org = spawn("script_origin", air_support_marker );
	drop_org.origin = air_support_marker;
	drop_org.angles = (0,0,0);
	wait 0.1;
	jet_org = spawn("script_origin", air_support_marker+(jet_distance,0,jet_height) );
	jet_org.origin = air_support_marker+(jet_distance,0,jet_height);
	jet_org.angles = (0,0,0);
	wait 0.1;
	for( i = 0 ; i < 3 ; i++ )
	{
		thread jet_strike(jet_org, drop_org, jet_time, air_support_marker, jet_n_distance, jet_height);
		wait 1.5;
		//wait jet_time;
	}
	
	level notify("airstrike_finished");
	wait 2;
	level.air_support_active = 0;

}


jet_strike(jet_org, drop_org, jet_time, air_support_marker, jet_n_distance, jet_height)
{
	jet_model = spawn("script_model", air_support_marker+(jet_n_distance,0,jet_height));
	jet_model.origin = air_support_marker+(jet_n_distance,0,jet_height);
	jet_model.angles = VectorToAngles(jet_model.origin-jet_org.origin)+(0,180,0);
	jet_model setmodel( "vehicle_mig29_desert_static" );
	
	playfxontag( level.fx_airstrike_afterburner, jet_model, "tag_engine_right" );
	playfxontag( level.fx_airstrike_afterburner, jet_model, "tag_engine_left" );
	playfxontag( level.fx_airstrike_contrail, jet_model, "tag_right_wingtip" );
	playfxontag( level.fx_airstrike_contrail, jet_model, "tag_left_wingtip" );
	
	jet_model moveto(jet_org.origin, jet_time);
	jet_model thread jet_sound_fx(jet_time);		
	wait jet_time/2;
	
	level notify("jet_hit");
	drop_org thread jet_drop_missile(jet_height);
	
	wait jet_time/2;		
	wait 0.1;
	jet_model delete();
}

jet_sound_fx(jet_time)
{
	jet_sound_org = spawn("script_origin", self.origin);
	jet_sound_org playsound("jet_sound");
	jet_sound_org linkto(self);
	wait jet_time;
	jet_sound_org unlink();
	
	totime = 7-jet_time;
	wait totime;

	jet_sound_org delete();

}

jet_drop_missile(jet_height)
{
	wait 0.05; // timed the jet position.
	jet_missile = spawn("script_model", self.origin+(0,0,jet_height-200));
	jet_missile.origin = self.origin+(0,0,jet_height-200);
	jet_missile.angles = (90,0,0); 
	jet_missile setmodel( "vehicle_mig29_missile_alamo" );
	
	jet_missile moveto(self.origin, 0.5);
	wait 0.5;
	RadiusDamage( self.origin+(0,0,64), 350, 1000, 150, level.player );
	self thread killstreak_explosion_damage();
	PlayFX( level._effect["big_explosion"], self.origin );
	self playsound("artillery_explosion");
	jet_missile delete();
}


airstrike_support_deactive()
{
	wait( 0.05 );

	if ( isdefined( level.airstrikeAttackArrow ) )
	{
		level.airstrikeAttackArrow delete();
	}
}


/*####################
######### HELI #########
#####################*/

heli_killstreak()
{
// Ally heli will not be implemented because helicopter paths are already messy 
// and one more would be too crowded. Besides there's no such feature in mw3.
}

// ###################################
//KILL STREAK TOOLS ###################################
// ###################################

killstreak_player_damage_warning()
{
	dist = Distance( level.air_support_marker.origin, level.player.origin );
	if( dist < 350 || dist == 350  )
		thread survspi_message( &"SURVSPI_KILLSTREAK_WARNING" );
}

killstreak_explosion_damage()
{

	RadiusDamage( self.origin, 350, 1000, 150, level.player );
	Earthquake( 0.5, 3, self.origin, 1200 );
	SetPlayerIgnoreRadiusDamage( true );

	dist = Distance( self.origin, level.player.origin );
	if( dist < 150 )
		level.player dodamage( 9999 , self.origin );
	else if( dist < 250  )
		level.player dodamage( 200 , self.origin );
	else if( dist < 350 || dist == 350  )
		level.player dodamage( 100 , self.origin );
}

// GET ENEMY RELATIVE CENTER ###################################
spawn_mark_position()
{
	axis = getaiarray( "axis" );
	for( i = 0 ; i < axis.size ; i++ )
	level.air_support_marker = spawn("script_model", axis[0].origin);
	level.air_support_marker thread followGroup(axis);
	level waittill("destroy_airsupport_marker");
	level.air_support_marker delete();
}

followGroup(group)
{
	level endon("destroy_airsupport_marker");
	while(1)
	{
		av_origin = (0,0,0);
		divider = 0;
		for(i=0;i < group.size; i++)
		{
			if(isAlive(group[i] ) )
			{
				av_origin += group[i].origin;
				divider += 1;
			}
		}
		if(divider > 0)
		{
			av_origin /= divider;
			
			self.origin = av_origin + (0, 0, 72); 
		}
		wait 0.05;
	}
}
//#######################################
//#######################################

// Fake Achivement!
fake_achivement( icon_shader, text_title, text_subtitle )
{	
	alignX = "left";
	alignY = "top";
	horzAlign = "left";
	vertAlign = "top";
	
	bg_width = 200;
	bg_height = 70;
	
	icon_size = 60;
	icon_x = (bg_width-icon_size)-5;
	icon_y = 5;
	icon_y_m = -65;
	
	title_text_y = 4;
	subtitle_text_y = 24;

	//Gray Achivement Fill.
	fakachiev_BG_bg2 = newHudElem();
	fakachiev_BG_bg2.alignX = alignX;
	fakachiev_BG_bg2.alignY = alignY;
	fakachiev_BG_bg2.horzAlign = horzAlign;
	fakachiev_BG_bg2.vertAlign = vertAlign;
	fakachiev_BG_bg2.x = 0;
	fakachiev_BG_bg2.y = -1*bg_height;
	fakachiev_BG_bg2.width = bg_width;
	fakachiev_BG_bg2.height = bg_height;
 	fakachiev_BG_bg2.hidewheninmenu = false;
	fakachiev_BG_bg2.alpha = 1;
	fakachiev_BG_bg2.sort = -1;
	fakachiev_BG_bg2 setShader( "white", bg_width, bg_height );
	fakachiev_BG_bg2.color = (0.25, 0.25, 0.25 );

	//Gradient Achivement Fill.
	fakachiev_BG = newHudElem();
	fakachiev_BG.alignX = alignX;
	fakachiev_BG.alignY = alignY;
	fakachiev_BG.horzAlign = horzAlign;
	fakachiev_BG.vertAlign = vertAlign;
	fakachiev_BG.x = 0;
	fakachiev_BG.y = -1*bg_height;
	fakachiev_BG.width = bg_width;
	fakachiev_BG.height = bg_height;
 	fakachiev_BG.hidewheninmenu = false;
	fakachiev_BG.alpha = 0.5;
	fakachiev_BG.sort = 0;
	fakachiev_BG setShader( "gradient_bottom", bg_width, bg_height );

	//Icon Gradient Background.
	fakachiev_icon_BG = newHudElem();
	fakachiev_icon_BG.elemType = "bar";
	fakachiev_icon_BG.alignX = alignX;
	fakachiev_icon_BG.alignY = alignY;
	fakachiev_icon_BG.horzAlign = horzAlign;
	fakachiev_icon_BG.vertAlign = vertAlign;
	fakachiev_icon_BG.x = icon_x;
	fakachiev_icon_BG.y = icon_y_m;
	fakachiev_icon_BG.sort = 1;
	fakachiev_icon_BG.alpha = 1;
 	fakachiev_icon_BG.hidewheninmenu = false;
	fakachiev_icon_BG setShader( "gradient_center" , icon_size, icon_size );
	fakachiev_icon_BG.color = (0.1, 0.1, 0.1 );
	
	//Icon.
	fakachiev_icon = newHudElem();
	fakachiev_icon.alignX = alignX;
	fakachiev_icon.alignY = alignY;
	fakachiev_icon.horzAlign = horzAlign;
	fakachiev_icon.vertAlign = vertAlign;
	fakachiev_icon.x = icon_x;
	fakachiev_icon.y = icon_y_m; 
	fakachiev_icon.alpha = 1;
	fakachiev_icon.sort = 2;
 	fakachiev_icon.hidewheninmenu = false;
	fakachiev_icon setShader( icon_shader, icon_size, icon_size );

	//Achivement Unlocked Title.
	fakachiv_hud = newHudElem();
	fakachiv_hud.alignX = alignX;
	fakachiv_hud.alignY = alignY;
	fakachiv_hud.horzAlign = horzAlign;
	fakachiv_hud.vertAlign = vertAlign;
	fakachiv_hud.x = 4;
	fakachiv_hud.y = -1*bg_height+title_text_y; 
	fakachiv_hud.font = "objective";
	fakachiv_hud.fontScale = 1;
	fakachiv_hud.alpha = 1;
	fakachiv_hud.sort = 1;
 	fakachiv_hud.hidewheninmenu = false;
	fakachiv_hud.label = text_title;

	//Achivement Text.
	fakachiv2_hud = newHudElem();
	fakachiv2_hud.alignX = alignX;
	fakachiv2_hud.alignY = alignY;
	fakachiv2_hud.horzAlign = horzAlign;
	fakachiv2_hud.vertAlign = vertAlign;
	fakachiv2_hud.x = 4;
	fakachiv2_hud.y = -1*bg_height+subtitle_text_y; 
	fakachiv2_hud.fontScale = 1.25;
	fakachiv2_hud.alpha = 1;
	fakachiv2_hud.sort = 1;
 	fakachiv2_hud.hidewheninmenu = false;
	fakachiv2_hud.label = text_subtitle;
	
	fakachiev_BG MoveOverTime(0.5);
	fakachiev_BG_bg2 MoveOverTime(0.5);
	fakachiev_icon_BG MoveOverTime(0.5);
	fakachiev_icon MoveOverTime(0.5);
	fakachiv_hud MoveOverTime(0.5);
	fakachiv2_hud MoveOverTime(0.5);
	
	fakachiev_BG.y = 0;
	fakachiev_BG_bg2.y = 0;
	fakachiev_icon_BG.y = icon_y; 
	fakachiev_icon.y = icon_y; 
	fakachiv_hud.y = title_text_y;
	fakachiv2_hud.y = subtitle_text_y;

	wait 5.5;
	
	fakachiev_BG MoveOverTime(0.5);
	fakachiev_BG_bg2 MoveOverTime(0.5);
	fakachiev_icon_BG MoveOverTime(0.5);
	fakachiev_icon MoveOverTime(0.5);
	fakachiv_hud MoveOverTime(0.5);
	fakachiv2_hud MoveOverTime(0.5);
	
	fakachiev_BG.y = -1*bg_height;
	fakachiev_BG_bg2.y = -1*bg_height;
	fakachiev_icon_BG.y = icon_y_m;
	fakachiev_icon.y = icon_y_m; 
	fakachiv_hud.y = -1*bg_height+title_text_y;
	fakachiv2_hud.y = -1*bg_height+subtitle_text_y;
	
	wait 0.5;
	
	fakachiev_BG destroy();
	fakachiev_BG_bg2 destroy();
	fakachiev_icon_BG destroy();
	fakachiev_icon destroy();
	fakachiv_hud destroy();
	fakachiv2_hud destroy();
}

//===============================================
//===============================================
//===============================================
//===============================================
//===============================================
//CATEGORY 10: TOOLS
//===============================================
//===============================================
//===============================================
//===============================================
//===============================================

waittill_player_pressed_button(button)
{
	while( !level.player buttonpressed( button ) )
		wait 0.05;		
}


// Mark static non npc ent
mark_ent_survspi( type )
{
	Assertex( IsDefined( type ), "mark type is not defined" );
	markerMat = "";
	if( type == "ammo" )
		markerMat = "armory_hudicon_weapons";
	else if( type == "frag" )
		markerMat = "armory_hudicon_equipment";
	else if( type == "uav" )
		markerMat = "armory_hudicon_support";
	self.marker = NewHudElem();
	self.marker.z =	self.origin[ 2 ];
	self.marker.x = self.origin[ 0 ];
	self.marker.y = self.origin[ 1 ];
	self thread marker_destroy();
	self.marker.alpha = 1;
	self thread hide_with_draw2d(1);
	self.marker.archived = true;
	self.marker.foreground = 1;
	self.marker SetShader( markerMat , 8, 8);
	self.marker SetTargetEnt( self );
	self.marker SetWayPoint( true );

}

marker_destroy()
{
	self waittill( "destroy_marker" );
	self.marker destroy();
}

// mark NPC ent

mark_ent_npc( markerMat )
{
	self.marker = NewHudElem();
	self thread marker_position_npc();
	self thread npc_marker_destroy();
	self.marker.alpha = 0.85;
	self thread hide_with_draw2d(0.85);
	self.marker.archived = true;
	self.marker.foreground = 1;
	self.marker SetShader( markerMat , 8, 8);
	self.marker SetTargetEnt( self );
	self.marker SetWayPoint( true );	
}

npc_marker_destroy()
{
	self waittill( "death" );
	self.marker destroy();
}

marker_position_npc()
{
	self endon ( "death" );
	while(1)
	{
		origin = self getEye();
		self.marker.z = origin[ 2 ] + 5;
		self.marker.x = origin[ 0 ];
		self.marker.y = origin[ 1 ];
		origin = self getEye();
		wait 0.05;
	}
}

hide_with_draw2d(prealpha)
{
	self endon ( "death" );
	self endon ( "destroy_marker" );
	level endon( "destroy_marker" );

	while(1)
    {
        if ( getDvarInt( "cg_draw2d" )  )
        {
            self.marker.alpha = prealpha;
        }
        else
        {
            self.marker.alpha = 0;
        }
        wait 0.05;
    }
}


hud_overlay_survspi( shader_name, start_alpha )
{
	overlay = newHudElem();
	overlay.x = 0;
	overlay.y = 0;
	overlay setshader ( shader_name, 640, 480);
	overlay.alignX = "left";
	overlay.alignY = "top";
	overlay.sort = 1;
	overlay.horzAlign = "fullscreen";
	overlay.vertAlign = "fullscreen";
	overlay.alpha = start_alpha;
	overlay.foreground = true;
	return overlay;
}

survspi_message( text, time )
{
	level notify("survspi_message_destroy");
	level endon("survspi_message_destroy");
	
	survspi_message = NewHudElem();
	survspi_message.alignX = "center";
	survspi_message.alignY = "middle";
	survspi_message.horzAlign = "center";
	survspi_message.vertAlign = "middle";
	survspi_message.x = 0;
	survspi_message.y = -100; 
	survspi_message.foreground = true;
	survspi_message.fontScale = 2;
	survspi_message.alpha = 1;
	survspi_message setText(text);
	
	survspi_message thread survspi_message_destroy();
	
	if(isdefined(time))
		wait time;
	else
		wait 3.5;

	survspi_message thread fade_overlay_survspi( 0, 1);
	wait 1.1; 
	survspi_message destroy();	
}

survspi_message_destroy()
{
	self endon("death");
	level waittill("survspi_message_destroy");
	self destroy();	
}

fade_overlay_survspi( target_alpha, fade_time )
{
	self fadeOverTime( fade_time );
	self.alpha = target_alpha;
	wait fade_time;
}

simple_hud_hide()
{
	setsaveddvar( "compass", 0 ); 
	setsaveddvar( "hud_showstance", "0" ); 
	SetSavedDvar( "ammoCounterHide", "1" );
}

simple_hud_show()
{
	setsaveddvar( "compass", 1 ); 
	setsaveddvar( "hud_showstance", "1" ); 
	SetSavedDvar( "ammoCounterHide", "0" );
}

// Amazing function by Scillman
getValuePercentage(value, min_src_value, max_src_value, min_dest_value, max_dest_value)
{
    if (value >= min_src_value && value <= max_src_value)
    {
        max_src = ( max_src_value - min_src_value );
        max_dest = ( max_dest_value - min_dest_value );

        value -= min_src_value;

        result = ( ( value * max_dest ) / max_src );

        return result + min_dest_value;
    }
    else if (value > max_src_value)
    {
        return max_dest_value;
    }
    else
    {
        assert(value < min_src_value);
        return min_dest_value;
    }
}

CalculatePercentage(numA, numB)
{
	per = (numA / numB) * 100;
	return per;
}

manual_linkto_spi( entity, offset )
{
	self endon( "unlink" );
	entity endon( "death" );
	if ( !isdefined( offset ) )
	{
		offset = ( 0, 0, 0 );
	}
	for ( ;; )
	{
		self.origin = entity.origin + offset;
		self.angles = entity.angles;
		wait( 0.05 );
		if( !isdefined(entity) )
			break;
	}
}
