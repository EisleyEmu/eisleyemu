stim_b_smc_vurlene = {
	minimumLevel = 0,
	maximumLevel = 0,
	customObjectName = "",
	directObjectTemplate = "object/tangible/medicine/crafted/medpack_damage_b.iff",

	craftingValues = {
		{"power",100,250,0},
		{"charges",5,10,0},
		{"skillmodmin",35,50,0},
	},
	customizationStringNames = {},
	customizationValues = {},
	--TODO: HOW DO WE VARY WHAT STATS & TYPES OF THINGS THESE CAN HEAL? (re: mind, poison, etc. )
}

addLootItemTemplate("stim_b_smc_vurlene", stim_b_smc_vurlene)