aggroDefault = {
	{id="2009948435",	name="Sequence",	pid="none"},
	{id="1351912750",	name="If",	pid="2009948435"},
	{id="3646194541",	name="CheckProspectAggression",	pid="1351912750"},
	{id="2493941910",	name="If",	pid="2009948435"},
	{id="1725623190",	name="CheckProspectInRange",	pid="2493941910",	args={condition=0.0}},
	{id="4287005799",	name="If",	pid="2009948435"},
	{id="415432002",	name="CheckProspectLOS",	pid="4287005799"},
	{id="199246519",	name="SetDefenderFromProspect",	pid="2009948435"}}
addAiTemplate("aggroDefault", aggroDefault)

attackDefault = {
	{id="4024177786",	name="Sequence",	pid="none"},
	{id="2812006626",	name="RandomSelector",	pid="4024177786"},
	{id="169743063",	name="WriteBlackboard",	pid="2812006626",	args={key="attackType", val=DEFAULT}},
	{id="1932903383",	name="WriteBlackboard",	pid="2812006626",	args={key="attackType", val=DEFAULT}},
	{id="2322819263",	name="WriteBlackboard",	pid="2812006626",	args={key="attackType", val=DEFAULT}},
	{id="1163120514",	name="EraseBlackboard",	pid="2812006626",	args={param="attackType"}},
	{id="3280863871",	name="Sequence",	pid="4024177786"},
	{id="3604417668",	name="Sequence",	pid="3280863871"},
	{id="2582933389",	name="SelectAttack",	pid="3604417668",	args={attackNum=-1}},
	{id="763264896",	name="If",	pid="3604417668"},
	{id="1728591479",	name="CheckAttackInRange",	pid="763264896"},
	{id="807085653",	name="If",	pid="3604417668"},
	{id="728357096",	name="CheckAttackIsValid",	pid="807085653"},
	{id="2327622682",	name="EnqueueAttack",	pid="3280863871"},
	{id="179413845",	name="SetAttackPosture",	pid="3280863871"}}
addAiTemplate("attackDefault", attackDefault)

awareDefault = {
	{id="4203407615",	name="Selector",	pid="none"},
	{id="1249379660",	name="LookForTarget",	pid="4203407615"},
	{id="1806193610",	name="Sequence",	pid="1249379660"},
	{id="1216252065",	name="CalculateAggroMod",	pid="1806193610"},
	{id="3272345327",	name="AlwaysSucceed",	pid="1806193610"},
	{id="3080558973",	name="Sequence",	pid="3272345327"},
	{id="1816592184",	name="Not",	pid="3080558973"},
	{id="1491613169",	name="If",	pid="1816592184"},
	{id="2200708579",	name="CheckMovementState",	pid="1491613169",	args={condition=WATCHING}},
	{id="474617061",	name="TreeSocket",	pid="3080558973",	args={slot=STALK}},
	{id="3394370660",	name="If",	pid="1806193610"},
	{id="1278976041",	name="CheckProspectInRange",	pid="3394370660",	args={condition=0.0}},
	{id="1799248528",	name="AlwaysSucceed",	pid="1806193610"},
	{id="3025856600",	name="TreeSocket",	pid="1799248528",	args={slot=LOOKAT}},
	{id="3702045485",	name="Sequence",	pid="1806193610"},
	{id="3753019142",	name="Selector",	pid="3702045485"},
	{id="115067313",	name="If",	pid="3753019142"},
	{id="922359392",	name="CheckMovementState",	pid="115067313",	args={condition=WATCHING}},
	{id="2011944136",	name="If",	pid="3753019142"},
	{id="3410143777",	name="CheckMovementState",	pid="2011944136",	args={condition=STALKING}},
	{id="2798415930",	name="Selector",	pid="3702045485"},
	{id="188522178",	name="Sequence",	pid="2798415930"},
	{id="2785404516",	name="If",	pid="188522178"},
	{id="178753499",	name="CheckAggroDelayPast",	pid="2785404516"},
	{id="3940938445",	name="TreeSocket",	pid="188522178",	args={slot=AGGRO}},
	{id="3558245448",	name="TreeSocket",	pid="2798415930",	args={slot=SCARE}},
	{id="574247012",	name="TreeSocket",	pid="4203407615",	args={slot=KILL}},
	{id="1890417720",	name="AlwaysFail",	pid="4203407615"},
	{id="2435336978",	name="Sequence",	pid="1890417720"},
	{id="57489269",	name="EraseBlackboard",	pid="2435336978",	args={param="aggroMod"}},
	{id="2315536834",	name="EraseBlackboard",	pid="2435336978",	args={param="targetProspect"}}}
addAiTemplate("awareDefault", awareDefault)

crackdownScanDefault = {
	{id="688534916",	name="Selector",	pid="none"},
	{id="3269996958",	name="Sequence",	pid="688534916"},
	{id="1824436907",	name="If",	pid="3269996958"},
	{id="2380017041",	name="CheckCrackdownScanner",	pid="1824436907"},
	{id="2904764039",	name="LookForPlayer",	pid="3269996958"},
	{id="2120293750",	name="Sequence",	pid="2904764039"},
	{id="3355601546",	name="If",	pid="2120293750"},
	{id="3223870287",	name="CheckProspectIsType",	pid="3355601546",	args={condition=PLAYERTYPE}},
	{id="2557331632",	name="If",	pid="2120293750"},
	{id="3227701225",	name="CheckProspectInRange",	pid="2557331632",	args={condition=25.0}},
	{id="1840897137",	name="ContrabandScan",	pid="2120293750"},
	{id="1246036558",	name="AlwaysFail",	pid="688534916"},
	{id="1955645295",	name="EraseBlackboard",	pid="1246036558",	args={param="targetProspect"}}}
addAiTemplate("crackdownScanDefault", crackdownScanDefault)

equipDefault = {
	{id="2941044245",	name="ParallelSequence",	pid="none"},
	{id="1893489794",	name="Sequence",	pid="2941044245"},
	{id="475418752",	name="UpdateRangeToFollow",	pid="1893489794"},
	{id="3588683982",	name="Selector",	pid="1893489794"},
	{id="284029936",	name="Sequence",	pid="3588683982"},
	{id="848281294",	name="If",	pid="284029936"},
	{id="2143400703",	name="CheckFollowInWeaponRange",	pid="848281294",	args={condition=PRIMARYWEAPON}},
	{id="3507834914",	name="If",	pid="284029936"},
	{id="1423335520",	name="CheckFollowClosestIdealRange",	pid="3507834914",	args={condition=PRIMARYWEAPON}},
	{id="485346421",	name="WriteBlackboard",	pid="284029936",	args={key="stagedWeapon", val=PRIMARYWEAPON}},
	{id="3286553516",	name="Sequence",	pid="3588683982"},
	{id="4256376058",	name="If",	pid="3286553516"},
	{id="1599543891",	name="CheckFollowInWeaponRange",	pid="4256376058",	args={condition=SECONDARYWEAPON}},
	{id="3111019196",	name="If",	pid="3286553516"},
	{id="3429738785",	name="CheckFollowClosestIdealRange",	pid="3111019196",	args={condition=SECONDARYWEAPON}},
	{id="2825297726",	name="WriteBlackboard",	pid="3286553516",	args={key="stagedWeapon", val=SECONDARYWEAPON}},
	{id="1510007529",	name="EquipStagedWeapon",	pid="1893489794"},
	{id="2512472344",	name="EraseBlackboard",	pid="2941044245",	args={param="stagedWeapon"}},
	{id="4004759019",	name="EraseBlackboard",	pid="2941044245",	args={param="followRange"}}}
addAiTemplate("equipDefault", equipDefault)

idleDefault = {
	{id="2434234854",	name="Selector",	pid="none"},
	{id="3408558848",	name="Sequence",	pid="2434234854"},
	{id="480022165",	name="If",	pid="3408558848"},
	{id="1939596405",	name="CheckHasPatrol",	pid="480022165"},
	{id="2896409758",	name="WriteBlackboard",	pid="3408558848",	args={key="moveMode", val=WALK}},
	{id="1424165865",	name="TreeSocket",	pid="3408558848",	args={slot=MOVE}},
	{id="852586211",	name="Wait",	pid="3408558848",	args={duration=5.0}},
	{id="4072235030",	name="Sequence",	pid="2434234854"},
	{id="3483017378",	name="If",	pid="4072235030"},
	{id="776089883",	name="CheckOutdoors",	pid="3483017378"},
	{id="1547268873",	name="GeneratePatrol",	pid="4072235030",	args={distFromHome=10.0, numPoints=5}}}
addAiTemplate("idleDefault", idleDefault)

killDefault = {
	{id="3446643166",	name="Sequence",	pid="none"},
	{id="2438979001",	name="If",	pid="3446643166"},
	{id="1145316404",	name="CheckIsKiller",	pid="2438979001"},
	{id="3202537488",	name="If",	pid="3446643166"},
	{id="3792349256",	name="CheckProspectIsIncapacitated",	pid="3202537488"},
	{id="3121274485",	name="If",	pid="3446643166"},
	{id="1800910595",	name="CheckProspectInRange",	pid="3121274485",	args={condition=0.0}},
	{id="3171471690",	name="If",	pid="3446643166"},
	{id="3828589773",	name="CheckProspectLOS",	pid="3171471690"},
	{id="1985163643",	name="SetMovementState",	pid="3446643166",	args={state=WATCHING}},
	{id="1819260193",	name="SetAlert",	pid="3446643166",	args={duration=10.0, show=false}},
	{id="1512963980",	name="KillProspect",	pid="3446643166"}}
addAiTemplate("killDefault", killDefault)

lookDefault = {
	{id="2391667584",	name="Sequence",	pid="none"},
	{id="3448746212",	name="Selector",	pid="2391667584"},
	{id="1485546267",	name="If",	pid="3448746212"},
	{id="2646753484",	name="CheckMovementState",	pid="1485546267",	args={condition=OBLIVIOUS}},
	{id="3934657672",	name="If",	pid="3448746212"},
	{id="1417574534",	name="CheckMovementState",	pid="3934657672",	args={condition=STALKING}},
	{id="268320967",	name="If",	pid="3448746212"},
	{id="1819497657",	name="CheckMovementState",	pid="268320967",	args={condition=PATROLLING}},
	{id="1650016708",	name="If",	pid="2391667584"},
	{id="638753146",	name="CheckProspectLOS",	pid="1650016708"},
	{id="411818367",	name="Not",	pid="2391667584"},
	{id="3870509434",	name="If",	pid="411818367"},
	{id="673698221",	name="CheckProspectIsIncapacitated",	pid="3870509434"},
	{id="4076527471",	name="SetMovementState",	pid="2391667584",	args={state=WATCHING}},
	{id="2037171568",	name="AlwaysSucceed",	pid="2391667584"},
	{id="1583995406",	name="SetAlert",	pid="2037171568",	args={duration=5.0, show=true}}}
addAiTemplate("lookDefault", lookDefault)

moveDefault = {
	{id="95757095",	name="Selector",	pid="none"},
	{id="2725427749",	name="Not",	pid="95757095"},
	{id="2494411167",	name="Sequence",	pid="2725427749"},
	{id="4016651762",	name="If",	pid="2494411167"},
	{id="938685055",	name="CheckPosture",	pid="4016651762",	args={condition=UPRIGHT}},
	{id="2354494630",	name="If",	pid="2494411167"},
	{id="1233890036",	name="CheckDestination",	pid="2354494630",	args={condition=0.0}},
	{id="1049607122",	name="Sequence",	pid="95757095"},
	{id="361808887",	name="If",	pid="1049607122"},
	{id="1901811754",	name="CheckRetreat",	pid="361808887",	args={condition=256}},
	{id="4131275375",	name="Leash",	pid="1049607122"},
	{id="439475086",	name="Sequence",	pid="95757095"},
	{id="1464671058",	name="If",	pid="439475086"},
	{id="2800332243",	name="CheckFlee",	pid="1464671058",	args={condition=0.1}},
	{id="3377670639",	name="Flee",	pid="439475086",	args={delay=15}},
	{id="3937110156",	name="ParallelSelector",	pid="95757095"},
	{id="3859304677",	name="Evade",	pid="3937110156",	args={maxEvadeChance=0.07, minEvadeChance=0.02}},
	{id="3690551020",	name="FindNextPosition",	pid="3937110156"}}
addAiTemplate("moveDefault", moveDefault)

rootDefault = {
	{id="714360210",	name="Selector",	pid="none"},
	{id="4192507528",	name="Sequence",	pid="714360210"},
	{id="1064078295",	name="Not",	pid="4192507528"},
	{id="3716307837",	name="If",	pid="1064078295"},
	{id="3269440031",	name="CheckMovementState",	pid="3716307837",	args={condition=FLEEING}},
	{id="112941615",	name="TreeSocket",	pid="4192507528",	args={slot=TARGET}},
	{id="1711463331",	name="ParallelSelector",	pid="4192507528"},
	{id="3085594992",	name="Sequence",	pid="1711463331"},
	{id="2197461733",	name="TreeSocket",	pid="3085594992",	args={slot=EQUIP}},
	{id="1754584012",	name="TreeSocket",	pid="3085594992",	args={slot=ATTACK}},
	{id="3434357109",	name="Sequence",	pid="1711463331"},
	{id="2676240638",	name="WriteBlackboard",	pid="3434357109",	args={key="moveMode", val=RUN}},
	{id="4148461600",	name="AlwaysSucceed",	pid="3434357109"},
	{id="4224133747",	name="TreeSocket",	pid="4148461600",	args={slot=MOVE}},
	{id="3497802169",	name="TreeSocket",	pid="714360210",	args={slot=AWARE}},
	{id="772402747",	name="TreeSocket",	pid="714360210",	args={slot=CRACKDOWNSCAN}},
	{id="2514877899",	name="TreeSocket",	pid="714360210",	args={slot=IDLE}}}
addAiTemplate("rootDefault", rootDefault)

scareDefault = {
	{id="9692099",	name="Sequence",	pid="none"},
	{id="1540135288",	name="If",	pid="9692099"},
	{id="1764032694",	name="CheckOutdoors",	pid="1540135288"},
	{id="700140749",	name="If",	pid="9692099"},
	{id="3760018670",	name="CheckProspectLevel",	pid="700140749"},
	{id="3822915915",	name="If",	pid="9692099"},
	{id="223077338",	name="CheckProspectBackAggression",	pid="3822915915"},
	{id="3929926457",	name="If",	pid="9692099"},
	{id="3129896739",	name="CheckProspectSpeed",	pid="3929926457",	args={condition=FAST}},
	{id="4278456295",	name="If",	pid="9692099"},
	{id="4154513359",	name="CheckProspectFacing",	pid="4278456295"},
	{id="3009279984",	name="If",	pid="9692099"},
	{id="1391512006",	name="CheckProspectLOS",	pid="3009279984"},
	{id="2633134651",	name="RunAway",	pid="9692099",	args={dist=64.0}},
	{id="2259218024",	name="SetAlert",	pid="9692099",	args={duration=5.0, show=false}}}
addAiTemplate("scareDefault", scareDefault)

stalkDefault = {
	{id="1672513422",	name="Sequence",	pid="none"},
	{id="3739778054",	name="If",	pid="1672513422"},
	{id="4188555031",	name="CheckIsStalker",	pid="3739778054"},
	{id="1616171750",	name="If",	pid="1672513422"},
	{id="3970049935",	name="CheckOutdoors",	pid="1616171750"},
	{id="2548145200",	name="Not",	pid="1672513422"},
	{id="4223807049",	name="If",	pid="2548145200"},
	{id="3347717967",	name="CheckMovementState",	pid="4223807049",	args={condition=STALKING}},
	{id="842511065",	name="Not",	pid="1672513422"},
	{id="970505057",	name="If",	pid="842511065"},
	{id="2130079230",	name="CheckIsInCombat",	pid="970505057"},
	{id="3337736172",	name="If",	pid="1672513422"},
	{id="3024166838",	name="CheckTargetIsValid",	pid="3337736172"},
	{id="1047936480",	name="If",	pid="1672513422"},
	{id="1298894483",	name="CheckProspectLOS",	pid="1047936480"},
	{id="1993075065",	name="StalkProspect",	pid="1672513422"},
	{id="2442951800",	name="TreeSocket",	pid="1672513422",	args={slot=MOVE}}}
addAiTemplate("stalkDefault", stalkDefault)

targetDefault = {
	{id="4111738087",	name="Selector",	pid="none"},
	{id="3879553011",	name="Sequence",	pid="4111738087"},
	{id="3082634307",	name="Sequence",	pid="3879553011"},
	{id="2109205448",	name="AlwaysSucceed",	pid="3082634307"},
	{id="417268659",	name="Selector",	pid="2109205448"},
	{id="1167160726",	name="GetProspectFromThreatMap",	pid="417268659"},
	{id="2134393409",	name="Sequence",	pid="417268659"},
	{id="2779379872",	name="Not",	pid="2134393409"},
	{id="3059827967",	name="If",	pid="2779379872"},
	{id="391660027",	name="CheckMovementState",	pid="3059827967",	args={condition=FLEEING}},
	{id="518009030",	name="GetProspectFromDefenders",	pid="2134393409"},
	{id="1116588539",	name="Selector",	pid="3082634307"},
	{id="2048074292",	name="If",	pid="1116588539"},
	{id="2151843468",	name="CheckTargetIsValid",	pid="2048074292"},
	{id="3200087626",	name="AlwaysFail",	pid="1116588539"},
	{id="4242405620",	name="Sequence",	pid="3200087626"},
	{id="70282946",	name="DropProspectFromDefenders",	pid="4242405620"},
	{id="1667318362",	name="EraseBlackboard",	pid="4242405620",	args={param="targetProspect"}},
	{id="1198270730",	name="SetDefenderFromProspect",	pid="3082634307"},
	{id="2169906593",	name="AlwaysSucceed",	pid="3082634307"},
	{id="801245995",	name="Sequence",	pid="2169906593"},
	{id="2064919983",	name="If",	pid="801245995"},
	{id="1297959577",	name="CheckProspectIsType",	pid="2064919983",	args={condition=PLAYERTYPE}},
	{id="2449360311",	name="If",	pid="801245995"},
	{id="1840187439",	name="CheckIsKiller",	pid="2449360311"},
	{id="2430725850",	name="If",	pid="801245995"},
	{id="455203671",	name="CheckProspectIsIncapacitated",	pid="2430725850"},
	{id="474513793",	name="TreeSocket",	pid="801245995",	args={slot=KILL}},
	{id="2799331507",	name="AlwaysSucceed",	pid="3879553011"},
	{id="1092122064",	name="Sequence",	pid="2799331507"},
	{id="760406382",	name="If",	pid="1092122064"},
	{id="1263807142",	name="CheckFollowHasState",	pid="760406382",	args={condition=PEACE}},
	{id="3243539519",	name="If",	pid="1092122064"},
	{id="907649009",	name="CheckRandomLevel",	pid="3243539519",	args={condition=1}},
	{id="4235079436",	name="Not",	pid="1092122064"},
	{id="2741672315",	name="If",	pid="4235079436"},
	{id="3481038322",	name="CheckFollowAggression",	pid="2741672315"},
	{id="2102245599",	name="ExitCombat",	pid="1092122064",	args={clearDefenders=1}},
	{id="2289904783",	name="AlwaysFail",	pid="4111738087"},
	{id="214464091",	name="Sequence",	pid="2289904783"},
	{id="2590329793",	name="Not",	pid="214464091"},
	{id="1425466029",	name="If",	pid="2590329793"},
	{id="3340870082",	name="CheckMovementState",	pid="1425466029",	args={condition=FLEEING}},
	{id="3752919331",	name="ExitCombat",	pid="214464091",	args={clearDefenders=1}}}
addAiTemplate("targetDefault", targetDefault)

