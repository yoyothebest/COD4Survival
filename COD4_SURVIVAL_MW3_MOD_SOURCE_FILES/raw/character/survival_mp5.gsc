// THIS FILE IS AUTOGENERATED, DO NOT MODIFY
main()
{
	self setModel("mw3_body_russ_army_b");
	codescripts\character::attachFromArray(xmodelalias\survival_mp5_heads::main());
	self.voice = "russian";
}

precache()
{
	precacheModel("mw3_body_russ_army_b");
	codescripts\character::precacheModelArray(xmodelalias\survival_mp5_heads::main());
}
