main()
{
	maps\_survspi::survspi_init(); // This must be BEFORE maps\_load::main(); 
	
	maps\_load::main(); // START OF LEVEL
	
	thread maps\_survspi::survspi_start(); // This must be RIGHT AFTER maps\_load::main(); 
	
}
