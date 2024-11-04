
class CfgPatches
{
	class BAX_HellDivers
	{
		addonRootClass = "A3_Weapons_F";
		Author = "BAXENATOR, Venom, Neex, Grave, Phenosi, PAPAFOX, BigRed";
		requiredAddons[]={};
		requiredVersion=0.1;
		units[] = {
			"BAX_HellDivers_SupportPod",
			"BAX_HellDivers_SES_Liberty",
			"BAX_HellDivers_SES_blank",
			"BAX_HellDivers_SES_Cyberstan",
			"BAX_HellDivers_SES_DawnCrimson",
			"BAX_HellDivers_SES_ElectedRep",
			"BAX_HellDivers_SES_FamilyValues",
			"BAX_HellDivers_SES_Wreck",
			"BAX_HellDivers_SES_Hammer",
			"BAX_HellDivers_SES_Kemal",
			"BAX_HellDivers_SES_Precursor",
			"BAX_HellDivers_SES_Redemption",
			"BAX_HellDivers_SES_Sage",
			"BAX_HellDivers_SES_Soul",
			"BAX_HellDivers_SES_Spear",
			"BAX_HellDivers_SES_UM_UnqualifiedMinds"
		};
		weapons[] = {};
	};
};

// TODO: Add grenades
// TODO: Factions

class CfgEditorCategories
{
	class BAX_HellDivers_Objects
	{
		displayName = "Helldiver 2 Objects";
	};
};

class CfgEditorSubcategories
{
	class BAX_HellDivers_Props {
		displayName = "Props";
	};

	class BAX_HellDivers_Supply {
		displayName = "Supply";
	};

	class BAX_HellDivers_DropPods {
		displayName = "Drop Pods";
	};
};

class CfgVehicleClasses
{
	class BAX_HellDivers {
		displayName = "Drop Pods";
	};
};

class CfgVehicles {
	class ReammoBox_F;
	class BAX_HellDivers_SupportPod: ReammoBox_F {
		author = "Venom, Neex, Grave, Phenosi";
		displayName = "Support Pod";
		model = "\bax_hellDivers\assets\supportPod\HellDiversSupPod1.p3d";
		editorCategory = "BAX_HellDivers_Objects";
		editorSubcategory = "BAX_HellDivers_Supply";
		maximumLoad = 4000;
		side = 4;
		scope = 2;
		ScopeCurator = 2;
	};

	class Car;
	class Car_F: Car {
		class HitPoints;
	};
	class DropBase: Car_F {
		class HitPoints: HitPoints {
			class HitHull;
		};
	};
	class BAX_HellDivers_DropPod_Base: DropBase {
		unitInfoType = "RscUnitInfoAir";
		icon = "iconObject_circle";
		simulation = "carx";
		scope = 1;
		scopeCurator = 1;
		faction = "Helldiver_Faction"; // TODO:
		editorSubcategory = "BAX_HellDivers_DropPods";
		side = 1;
		displayName = "Drop Pod";
		author = "Dosiel";
		model = "\HELLPOD\models\Hellpod.p3d";
		armor = 900000;
		crewCrashProtection = 0;
		crewExplosionProtection = 0;
		crewVulnerable = 0;
		destrType = "DestructNo";
		driverAction = "passenger_apc_generic01";
		driverCanEject = 1;
		fuelCapacity = 0;
		fuelConsumptionRate = 1;
		fuelExplosionPower = 0;
		getInAction = "GetInLow";
		getOutAction = "GetOutLow";
		getinRadius = 3.5;
		magazines[] = {};
		transportSoldier = 0;
		weapons[] = {};
		memoryPointsGetInCargo = "mem1";
		memoryPointsGetInCargoDir = "mem1";
		memoryPointsGetInDriver = "mem1";
		cargoAction[] = {"passenger_apc_generic01"};
		class DestructionEffects {};
		class Eventhandlers {
			init = "_this select 0 allowDamage false";
		};
		class Turrets {};
		soundGetIn[] = {"A3\Sounds_F\vehicles\air\CAS_01\getin_wipeout", 1, 1, 40};
		soundGetOut[] = {"A3\Sounds_F\air\Plane_Fighter_03\getout", 1, 1, 40};
		buildCrash0[] = {"A3\Sounds_F\vehicles\crashes\cars\cars_coll_big_default_ext_1", 1, 1, 900};
		buildCrash1[] = {"A3\Sounds_F\vehicles\crashes\cars\cars_coll_big_default_ext_2", 1, 1, 900};
		buildCrash2[] = {"A3\Sounds_F\vehicles\crashes\cars\cars_coll_big_default_ext_3", 1, 1, 900};
		buildCrash3[] = {"A3\Sounds_F\vehicles\crashes\cars\cars_coll_big_default_ext_4", 1, 1, 900};
		soundBuildingCrash[] = {"buildCrash0", 0.25, "buildCrash1", 0.25, "buildCrash2", 0.25, "buildCrash3", 0.25};
		WoodCrash0[] = {"A3\Sounds_F\vehicles\crashes\cars\cars_coll_big_wood_ext_1", 3.16228, 1, 900};
		WoodCrash1[] = {"A3\Sounds_F\vehicles\crashes\cars\cars_coll_big_wood_ext_2", 3.16228, 1, 900};
		WoodCrash2[] = {"A3\Sounds_F\vehicles\crashes\cars\cars_coll_big_wood_ext_6", 3.16228, 1, 900};
		WoodCrash3[] = {"A3\Sounds_F\vehicles\crashes\cars\cars_coll_big_wood_ext_8", 3.16228, 1, 900};
		soundWoodCrash[] = {"woodCrash0", 0.25, "woodCrash1", 0.25, "woodCrash2", 0.25, "woodCrash3", 0.25};
		armorCrash0[] = {"A3\Sounds_F\vehicles\crashes\cars\cars_coll_big_default_ext_1", 1, 1, 900};
		armorCrash1[] = {"A3\Sounds_F\vehicles\crashes\cars\cars_coll_big_default_ext_2", 1, 1, 900};
		armorCrash2[] = {"A3\Sounds_F\vehicles\crashes\cars\cars_coll_big_default_ext_3", 1, 1, 900};
		armorCrash3[] = {"A3\Sounds_F\vehicles\crashes\cars\cars_coll_big_default_ext_4", 1, 1, 900};
		soundArmorCrash[] = {"ArmorCrash0", 0.25, "ArmorCrash1", 0.25, "ArmorCrash2", 0.25, "ArmorCrash3", 0.25};
		Crash0[] = {"A3\Sounds_F\vehicles\crashes\cars\cars_coll_big_default_ext_1", 1, 1, 900};
		Crash1[] = {"A3\Sounds_F\vehicles\crashes\cars\cars_coll_big_default_ext_2", 1, 1, 900};
		Crash2[] = {"A3\Sounds_F\vehicles\crashes\cars\cars_coll_big_default_ext_3", 1, 1, 900};
		Crash3[] = {"A3\Sounds_F\vehicles\crashes\cars\cars_coll_big_default_ext_4", 1, 1, 900};
		soundCrashes[] = {"Crash0", 0.25, "Crash1", 0.25, "Crash2", 0.25, "Crash3", 0.25};
		soundDammage[] = {"", 0.562341,1};
		soundSetSonicBoom[] = {"Plane_Fighter_SonicBoom_SoundSet"};
		class Sounds {
			soundSets[] = {"Plane_Fighter_04_EngineLowExt_SoundSet", "Plane_Fighter_04_EngineHighExt_SoundSet", "Plane_Fighter_04_ForsageExt_SoundSet", "Plane_Fighter_04_WindNoiseExt_SoundSet", "Plane_Fighter_04_EngineExt_Dist_Front_SoundSet", "Plane_Fighter_04_EngineExt_Middle_SoundSet", "Plane_Fighter_04_EngineExt_Dist_Rear_SoundSet", "Plane_Fighter_04_EngineLowInt_SoundSet", "Plane_Fighter_04_EngineHighInt_SoundSet", "Plane_Fighter_04_ForsageInt_SoundSet", "Plane_Fighter_04_WindNoiseInt_SoundSet", "Plane_Fighter_04_VelocityInt_SoundSet"};
		};
		class RainExt {
			sound[] = {"A3\Sounds_F\vehicles\noises\rain1_ext", 1.77828, 1, 100};
			frequency = 1;
			volume = "camPos * rain * (speed factor[50, 0])";
		};
		class RainInt {
			sound[] = {"A3\Sounds_F\vehicles\noises\rain1_int", 1, 1, 100};
			frequency = 1;
			volume = "(1-camPos) * rain * (speed factor[50, 0])";
		};
	};
	class BAX_HellDivers_DropPod: BAX_HellDivers_DropPod_B {
		author = "People";
		scope = 2;
		scopeCurator = 2;
		scopeArsenal = 2;
		displayName = "Helldiver Drop Pod (Landed)";
		model = "\HELLPOD\models\HellpodDeployed.p3d";
		icon = "\A3\Supplies_F_Exp\Ammoboxes\Data\UI\icon_equipment_box_ca.paa";
		reversed = 1;
	};
	class Wreck_base_F;
	class BAX_HellDivers_DropPod_Wreck: Wreck_base_F {
		author = "People";
		scope = 2;
		scopeCurator = 2;
		// scopeArsenal = 2; // TODO: WHAT?
		displayName = "Helldiver Drop Pod (Landed)";
		model = "\HELLPOD\models\HellpodDeployed.p3d";
		icon = "\A3\Supplies_F_Exp\Ammoboxes\Data\UI\icon_equipment_box_ca.paa";
		reversed = 1;
	};

	class House_F;
	class BAX_HellDivers_SES_Liberty: House_F
	{
		displayName = "SES Destroyer 'Liberty'";
		author = "PAPAFOX, BigRed, Venom and Phenosi";
		model = "\bax_hellDivers\assets\destroyer\SES.p3d";
		hiddenSelections[] = {"hull","detail"}; ///we want to allow changing the texture of this selection
		hiddenSelectionsTextures[] = {"bax_hellDivers\assets\destroyer\data\SES_Variants\Destroyer_Liberty_CO.paa", "bax_hellDivers\assets\destroyer\data\SES_Detail_CO.paa"};
		destructbuilding = 0;
		mapSize = 35.54;
		icon = "iconObject_2x1";
		armor = 999999;
		armorStructural = 999;
		editorCategory = "BAX_HellDivers_Objects";
		editorSubcategory = "BAX_HellDivers_Props";
		scope = 2;
		ScopeCurator = 2;
	};
	class BAX_HellDivers_SES_blank: BAX_HellDivers_SES_Liberty
	{
		displayName = "SES Destroyer (blank)";
		hiddenSelections[] = {"hull","detail"}; ///we want to allow changing the texture of this selection
		hiddenSelectionsTextures[] = {"bax_hellDivers\assets\destroyer\data\SES_Variants\Destroyer_BLANK_CO.paa", "bax_hellDivers\assets\destroyer\data\SES_Detail_CO.paa"};
	};
	class BAX_HellDivers_SES_Cyberstan: BAX_HellDivers_SES_Liberty
	{
		displayName = "SES Destroyer (Cyberstan)";
		hiddenSelections[] = {"hull","detail"}; ///we want to allow changing the texture of this selection
		hiddenSelectionsTextures[] = {"bax_hellDivers\assets\destroyer\data\SES_Variants\Destroyer_Cyberstan_CO.paa", "bax_hellDivers\assets\destroyer\data\SES_Detail_CO.paa"};
	};
	class BAX_HellDivers_SES_DawnCrimson: BAX_HellDivers_SES_Liberty
	{
		displayName = "SES Destroyer 'Dawn of Crimson'";
		hiddenSelections[] = {"hull","detail"}; ///we want to allow changing the texture of this selection
		hiddenSelectionsTextures[] = {"bax_hellDivers\assets\destroyer\data\SES_Variants\Destroyer_DawnCrimson_CO.paa", "bax_hellDivers\assets\destroyer\data\SES_Detail_CO.paa"};
	};
	class BAX_HellDivers_SES_ElectedRep: BAX_HellDivers_SES_Liberty
	{
		displayName = "SES Destroyer 'Elected Representative of Self-determination'";
		hiddenSelections[] = {"hull","detail"}; ///we want to allow changing the texture of this selection
		hiddenSelectionsTextures[] = {"bax_hellDivers\assets\destroyer\data\SES_Variants\Destroyer_ElectedRep_CO.paa", "bax_hellDivers\assets\destroyer\data\SES_Detail_CO.paa"};
	};
	class BAX_HellDivers_SES_FamilyValues: BAX_HellDivers_SES_Liberty
	{
		displayName = "SES Destroyer 'Bringer of Family Values'";
		hiddenSelections[] = {"hull","detail"}; ///we want to allow changing the texture of this selection
		hiddenSelectionsTextures[] = {"bax_hellDivers\assets\destroyer\data\SES_Variants\Destroyer_FamilyVals_CO.paa", "bax_hellDivers\assets\destroyer\data\SES_Detail_CO.paa"};
	};
	class BAX_HellDivers_SES_Wreck: BAX_HellDivers_SES_Liberty
	{
		displayName = "SES Destroyer (Wreck)";
		hiddenSelections[] = {"hull","detail"}; ///we want to allow changing the texture of this selection
		hiddenSelectionsTextures[] = {"bax_hellDivers\assets\destroyer\data\SES_Variants\Destroyer_WRECK_CO.paa", "bax_hellDivers\assets\destroyer\data\SES_Variants\Destroyer_Engine_WRECK_CO.paa"};
	};
	class BAX_HellDivers_SES_Hammer: BAX_HellDivers_SES_Liberty
	{
		displayName = "SES Destroyer 'Hammer of Judgement'";
		hiddenSelections[] = {"hull","detail"}; ///we want to allow changing the texture of this selection
		hiddenSelectionsTextures[] = {"bax_hellDivers\assets\destroyer\data\SES_Variants\Destroyer_Hammer_CO.paa", "bax_hellDivers\assets\destroyer\data\SES_Detail_CO.paa"};
	};
	class BAX_HellDivers_SES_Kemal: BAX_HellDivers_SES_Liberty
	{
		displayName = "SES Destroyer 'M. Kemal'";
		hiddenSelections[] = {"hull","detail"}; ///we want to allow changing the texture of this selection
		hiddenSelectionsTextures[] = {"bax_hellDivers\assets\destroyer\data\SES_Variants\Destroyer_Kemal_CO.paa", "bax_hellDivers\assets\destroyer\data\SES_Detail_CO.paa"};
	};
	class BAX_HellDivers_SES_Precursor: BAX_HellDivers_SES_Liberty
	{
		displayName = "SES Destroyer 'Precursor of War'";
		hiddenSelections[] = {"hull","detail"}; ///we want to allow changing the texture of this selection
		hiddenSelectionsTextures[] = {"bax_hellDivers\assets\destroyer\data\SES_Variants\Destroyer_Precursor_CO.paa", "bax_hellDivers\assets\destroyer\data\SES_Detail_CO.paa"};
	};
	class BAX_HellDivers_SES_Redemption: BAX_HellDivers_SES_Liberty
	{
		displayName = "SES Destroyer 'Wings of Redemption'";
		hiddenSelections[] = {"hull","detail"}; ///we want to allow changing the texture of this selection
		hiddenSelectionsTextures[] = {"bax_hellDivers\assets\destroyer\data\SES_Variants\Destroyer_Redemption_CO.paa", "bax_hellDivers\assets\destroyer\data\SES_Detail_CO.paa"};
	};
	class BAX_HellDivers_SES_Sage: BAX_HellDivers_SES_Liberty
	{
		displayName = "SES Destroyer 'Sage of Democracy'";
		hiddenSelections[] = {"hull","detail"}; ///we want to allow changing the texture of this selection
		hiddenSelectionsTextures[] = {"bax_hellDivers\assets\destroyer\data\SES_Variants\Destroyer_Sage_CO.paa", "bax_hellDivers\assets\destroyer\data\SES_Detail_CO.paa"};
	};
	class BAX_HellDivers_SES_Soul: BAX_HellDivers_SES_Liberty
	{
		displayName = "SES Destroyer 'Sould of Audacity'";
		hiddenSelections[] = {"hull","detail"}; ///we want to allow changing the texture of this selection
		hiddenSelectionsTextures[] = {"bax_hellDivers\assets\destroyer\data\SES_Variants\Destroyer_Soul_CO.paa", "bax_hellDivers\assets\destroyer\data\SES_Detail_CO.paa"};
	};
	class BAX_HellDivers_SES_Spear: BAX_HellDivers_SES_Liberty
	{
		displayName = "SES Destroyer 'Spear of Liberty'";
		hiddenSelections[] = {"hull","detail"}; ///we want to allow changing the texture of this selection
		hiddenSelectionsTextures[] = {"bax_hellDivers\assets\destroyer\data\SES_Variants\Destroyer_Spear_CO.paa", "bax_hellDivers\assets\destroyer\data\SES_Detail_CO.paa"};
	};
	class BAX_HellDivers_SES_UM_UnqualifiedMinds: BAX_HellDivers_SES_Liberty
	{
		displayName = "SES Destroyer 'Unqualified Might'";
		hiddenSelections[] = {"hull","detail"}; ///we want to allow changing the texture of this selection
		hiddenSelectionsTextures[] = {"bax_hellDivers\assets\destroyer\data\SES_Variants\Destroyer_Unqualified_CO.paa", "bax_hellDivers\assets\destroyer\data\SES_Detail_CO.paa"};
	};
};

class CfgAmmo
{
	class R_PG7_F;
	class Hellpod_ImpactAmmo: R_PG7_F
	{
		submunitionAmmo = "";
		submunitionDirectionType = "";
		submunitionInitSpeed = 0;
		submunitionParentSpeedCoef = 0;
		submunitionInitialOffset[] = {0,0,0};
		explosionEffects = "ExplosionEffects";
		CraterEffects = "GrenadeCrater";
		explosionSoundEffect = "DefaultExplosion";
		explosionEffectsRadius = 1;
		hit = 999999;
		indirectHit = 999;
		indirectHitRange = 0.1;
		explosive = 1;
		explosionTime = -1;
		caliber = 100;
		thrustTime = 0;
		thrust = 0;
		fuseDistance = 0;
		timeToLive = 30;
		typicalSpeed = 1;
		soundFly[] = {"A3\Sounds_F\arsenal\weapons\Launchers\RPG32\Fly_RPG32",0.1,1.5,900};
	};
};
