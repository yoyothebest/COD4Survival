// THIS FILE IS AUTOGENERATED, DO NOT MODIFY
main()
{
	codescripts\character::setModelFromArray(xmodelalias\survival_mw3_sas_bodies::main());
	codescripts\character::attachFromArray(xmodelalias\survival_mw3_sas_heads::main());
	self.voice = "british";
}

precache()
{
	codescripts\character::precacheModelArray(xmodelalias\survival_mw3_sas_bodies::main());
	codescripts\character::precacheModelArray(xmodelalias\survival_mw3_sas_heads::main());
}
