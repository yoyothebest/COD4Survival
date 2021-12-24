main()
{
	maps\_survspi::survspi_init(); // This must be BEFORE maps\_load::main(); 
	
	maps\_load::main(); // START OF LEVEL
	
	thread maps\_survspi::survspi_start(); // This must be RIGHT AFTER maps\_load::main(); 
	
	maps\_compass::setupMiniMap("compass_map_su_welltown"); // Map specific minimap settings.
	
	ambientplay("amb_daytime", 2);
	
	wait 0.05;
	setsaveddvar("cg_fov" , "75");
	setsaveddvar( "compassmaxrange", 2000 );
}
