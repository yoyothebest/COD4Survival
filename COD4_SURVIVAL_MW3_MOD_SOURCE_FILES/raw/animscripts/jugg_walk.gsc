#include animscripts\utility;
#include animscripts\combat_utility;
#include animscripts\shared;
#include common_scripts\utility;
#using_animtree ("generic_human");

MoveCQB()
{
	animscripts\run::changeWeaponStandRun();
	
	// any endons in this function must also be in CQBShootWhileMoving and CQBDecideWhatAndHowToShoot
	
	if ( self.a.pose != "stand" )
	{
		self clearAnim( %root, 0.2 );
		if ( self.a.pose == "prone" )
			self ExitProneWrapper( 1 );
		self.a.pose = "stand";
	}
	self.a.movement = self.moveMode;
	
	self clearanim(%combatrun, 0.2);
	
	self thread CQBTracking();
	
	//cqbWalkAnim = %walk_CQB_F;
	
	// Juggernaut Walk, Run, Sprint Animations.
	cqbWalkAnim = undefined;
	//if ( distanceSquared( self.origin, self.enemy.origin ) < 500 * 500 )
		cqbWalkAnim = %juggernaut_walkf;
		/*
	else if ( distanceSquared( self.origin, self.enemy.origin ) < 1000 * 1000 )
		cqbWalkAnim = %juggernaut_runf;
	else if ( distanceSquared( self.origin, self.enemy.origin ) >= 1000 * 1000 )
		cqbWalkAnim = %juggernaut_sprint;
	// Juggernaut Walk, Run, Sprint Animations.
	*/
	rate = self.moveplaybackrate;
	
	// (we don't use %body because that would reset the aiming knobs)
	self setFlaggedAnimKnobAll( "runanim", cqbWalkAnim, %walk_and_run_loops, 1, 0.3, rate );
	
	// Play the appropriately weighted animations for the direction he's moving.
	animWeights = animscripts\utility::QuadrantAnimWeights( self getMotionAngle() );
	self setanim(%combatrun_forward, animWeights["front"], 0.2, 1);
	self setanim(%walk_backward, animWeights["back"], 0.2, 1);
	self setanim(%walk_left, animWeights["left"], 0.2, 1);
	self setanim(%walk_right, animWeights["right"], 0.2, 1);
	
	animscripts\shared::DoNoteTracksForTime( 0.2, "runanim" );
	
	self thread DontCQBTrackUnlessWeMoveCQBAgain();
}

CQBTracking()
{
	self notify("want_cqb_tracking");
	
	if ( isdefined( self.cqb_track_thread ) )
		return;
	self.cqb_track_thread = true;
	
	self endon("killanimscript");
	self endon("end_cqb_tracking");
	
	self.rightAimLimit = 45;
	self.leftAimLimit = -45;
	self.upAimLimit = 45;
	self.downAimLimit = -45;
	
	self setAnimLimited( %walk_aim_2 );
	self setAnimLimited( %walk_aim_4 );
	self setAnimLimited( %walk_aim_6 );
	self setAnimLimited( %walk_aim_8 );
	
	self.shootEnt = undefined;
	self.shootPos = undefined;
	
	if ( animscripts\move::MayShootWhileMoving() )
	{
		self thread CQBDecideWhatAndHowToShoot();
		self thread CQBShootWhileMoving();
	}
	self trackLoop( %w_aim_2, %w_aim_4, %w_aim_6, %w_aim_8 );
}
CQBDecideWhatAndHowToShoot()
{
	self endon("killanimscript");
	self endon("end_cqb_tracking");
	self animscripts\shoot_behavior::decideWhatAndHowToShoot( "normal" );
}
CQBShootWhileMoving()
{
	self endon("killanimscript");
	self endon("end_cqb_tracking");
	self animscripts\move::shootWhileMoving();
}
DontCQBTrackUnlessWeMoveCQBAgain()
{
	self endon("killanimscript");
	self endon("want_cqb_tracking");
	
	wait .05;
	
	self notify("end_cqb_tracking");
	self.cqb_track_thread = undefined;
}
