// THIS FILE IS AUTOGENERATED, DO NOT MODIFY
main()
{
	codescripts\character::setModelFromArray(xmodelalias\survival_mw2_tf_bodies::main());
	codescripts\character::attachFromArray(xmodelalias\survival_mw2_tf_heads::main());
	self.voice = "american";
}

precache()
{
	codescripts\character::precacheModelArray(xmodelalias\survival_mw2_tf_bodies::main());
	codescripts\character::precacheModelArray(xmodelalias\survival_mw2_tf_heads::main());
}