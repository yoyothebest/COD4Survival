// THIS FILE IS AUTOGENERATED, DO NOT MODIFY
main()
{
	self setModel("mw3_body_russ_army_c_woodland");
	codescripts\character::attachFromArray(xmodelalias\survival_ak47_heads::main());
	self.voice = "russian";
}

precache()
{
	precacheModel("mw3_body_russ_army_c_woodland");
	codescripts\character::precacheModelArray(xmodelalias\survival_ak47_heads::main());
}
