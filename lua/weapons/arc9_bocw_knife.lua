--=============================================================================
--   ARC9 CALL OF DUTY: BLACK OPS COLD WAR
--   MELEE
--   KNIFE
--=============================================================================
--[[
--   SWEP INFORMATION:

--   BASE  : ARC9
--   BUILD : v2025.12
--   SR.NO : 4003160/3420-T



oooo    oooo              o8o   .o88o.           
`888   .8P'               `"'   888 `"           
 888  d8'    ooo. .oo.   oooo  o888oo   .ooooo.  
 88888[      `888P"Y88b  `888   888    d88' `88b 
 888`88b.     888   888   888   888    888ooo888 
 888  `88b.   888   888   888   888    888    .o 
o888o  o888o o888o o888o o888o o888o   `Y8bod8P' 
                                                 
]]

AddCSLuaFile()


SWEP.Base = "arc9_base"

SWEP.Spawnable = true
SWEP.Category = "ARC9 - Black Ops Cold War"
SWEP.SubCategory = "9Melee"
SWEP.AdminOnly = false

SWEP.PrintName = "Knife"
SWEP.TrueName = "Knife"
SWEP.Class = "Melee"
SWEP.Trivia = {
    Manufacturer = "Unknown",
    Mechanism = "Mechanics",
    Country = "Unknown",
    Year = "Unknown"
}

SWEP.Credits = {
     Author = "multinett",
     --Contact = "https://steamcommunity.com/id/multinett/"
}

SWEP.Description = [[Lethal melee weapon. Military-issue combat knife with a straight-edge blade that kills enemies with a single deadly strike. Trusted by the U.S. Military since the early 40's.

The Knife is the standard close quarters combat (CQC) melee weapon in every main game since Call of Duty 4: Modern Warfare, and also appearing in Call of Duty 3, Call of Duty: Modern Warfare: Mobilized, Modern Warfare 2: Ghost, Call of Duty: Black Ops (Nintendo DS), Find Makarov, Find Makarov: Operation Kingfish, Call of Duty: Modern Warfare 3: Defiance, Call of Duty: Black Ops: Declassified, Call of Duty Online and Call of Duty: Mobile.

The Knife returns in Call of Duty: Black Ops Cold War where it once more has been changed to be a separate Melee Weapon.]]

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arc9/c_arc9_knife_bocw.mdl"
SWEP.WorldModel = "models/weapons/arc9/c_arc9_knife_bocw.mdl"

SWEP.Slot = 0

SWEP.MirrorVMWM = true

SWEP.NoTPIKVMPos = true
SWEP.TPIKforcelefthand = true

SWEP.DefaultBodygroups = "00000000000000"

SWEP.WorldModelOffset = {
    Pos = Vector(12.5, -6, -14),
    Ang = Angle(140, 0, 0),
    Scale = 1
}

SWEP.Crosshair = true
SWEP.CanBlindFire = false

SWEP.ViewModelFOVBase = 70

-------------------------- MAGAZINE

SWEP.Ammo = "" -- What ammo type this gun uses.

SWEP.ChamberSize = 0 -- The amount of rounds this gun can chamber.
SWEP.ClipSize = -1 -- Self-explanatory.
SWEP.SupplyLimit = 0 -- Amount of magazines of ammo this gun can take from an ARC-9 supply crate.
SWEP.SecondarySupplyLimit = 0 -- Amount of reserve UBGL magazines you can take.

-------------------------- FIREMODES

SWEP.Firemodes = {
    {
        Mode = 1,
        PrintName = "Melee"
    },
}

SWEP.CantSafety = true

-------------------------- HANDLING

SWEP.FreeAimRadius = 0 -- In degrees, how much this gun can free aim in hip fire.

SWEP.Sway = 0

SWEP.SprintToFireTime = 0.2 -- How long it takes to go from sprinting to being able to fire.

SWEP.ShootWhileSprint = false

SWEP.Speed = 1

SWEP.SpeedMult = 1

local SprintMultCvar = GetConVar("arc9_bocw_sprintmultiplier")

if SprintMultCvar:GetBool() then
    SWEP.SpeedMultSprint = 0.685185185185185 -- SPRINT SPEED RELATIVE TO MOVE SPEED
else
    SWEP.SpeedMultSprint = 1 -- this may possibly change later
end

SWEP.SpeedMultSights = 1
SWEP.SpeedMultShooting = 1
SWEP.SpeedMultMelee = 1
SWEP.SpeedMultCrouch = 1

-------------------------- MELEE

SWEP.DamageMax = 150

SWEP.Bash = true
SWEP.PrimaryBash = true
SWEP.Bash2 = true
SWEP.SecondaryBash = true

SWEP.BashDamage = 150
SWEP.BashLungeRange = 64
SWEP.BashRange = 64
SWEP.PreBashTime = 0.29
SWEP.PostBashTime = 0.6
SWEP.BashDamageType = DMG_SLASH
SWEP.BashDecal = "ManhackCut"

SWEP.SecondaryBash = true

SWEP.Bash2Damage = 150
SWEP.Bash2LungeRange = 64
SWEP.Bash2Range = 64
SWEP.PreBash2Time = 0.25
SWEP.PostBash2Time = 0.6
SWEP.Bash2DamageType = DMG_CLUB
SWEP.Bash2Decal = "ManhackCut"

--[[
SWEP.Backstab = true
SWEP.BackstabDamage = 300
SWEP.BackstabRange = 64
SWEP.PreBackstabTime = 0.5
SWEP.PostBackstabTime = 0.5
SWEP.BackstabDamageType = DMG_CLUB
SWEP.BackstabDecal = "ManhackCut"
]]
-------------------------- NPC

SWEP.NotForNPCs = true -- Won't be given to NPCs.
SWEP.NPCWeight = 100 -- How likely it is for an NPC to get this weapon as opposed to other weapons.

-------------------------- SOUNDS

SWEP.MeleeHitSound = "ARC9_BOCW.Shared_Melee_slash"
SWEP.MeleeHitWallSound = "ARC9_BOCW.Knife_impact"
SWEP.MeleeSwingSound = ""

-------------------------- EFFECTS

SWEP.CamQCA = 2

SWEP.FireInterruptInspect = true

SWEP.NoViewBob = false

-------------------------- POSITIONS

SWEP.HasSights = false

SWEP.ActivePos = Vector(0, -1.2, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.CrouchPos = Vector(0, -1, -1)
SWEP.CrouchAng = Angle(0, 0, 0)

-- Position when sprinting or safe
SWEP.RestPos = Vector(0, -1.2, 0)
SWEP.RestAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(0, -1.2, 0)
SWEP.SprintAng = Angle(0, 0, 0)

SWEP.HolsterPos = Vector(0, 0, -5)
SWEP.HolsterAng = Angle(0, -15, 25)

-- Position for customizing
SWEP.CustomizeAng = Angle(90, 0, 0)
SWEP.CustomizePos = Vector(20, 30, 7)
SWEP.CustomizeRotateAnchor = Vector(20, -7, -7)

SWEP.CustomizeSnapshotFOV = 70
SWEP.CustomizeSnapshotPos = Vector(0, 20, 0)
SWEP.CustomizeSnapshotAng = Angle(0, 0, 0)
SWEP.CustomizeNoRotate = false

-------------------------- HoldTypes

SWEP.HoldType = "knife"
SWEP.HoldTypeSprint = "normal"
SWEP.HoldTypeHolstered = "normal"
SWEP.HoldTypeCustomize = "slam"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN
--SWEP.AnimReload = ACT_HL2MP_GESTURE_RELOAD_AR2 -- While in TPIK only
SWEP.NonTPIKAnimReload = false
SWEP.AnimDraw = false
SWEP.AnimMelee = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN

-------------------------- ATTACHMENTS
SWEP.AttachmentElements = {}

SWEP.Attachments = {
    {
        PrintName = "CAMO",
        DefaultIcon = Material("arc9/def_att_icons/skin.png"),
        Category = {"universal_camo"},
        CosmeticOnly = true,
    },
    {
        PrintName = "STICKER 1",
        Category = "stickers",
        StickerModel = "models/weapons/arc9/stickers/bocw_knife_sticker1.mdl",
        CosmeticOnly = true,
    },
}
--=========================================================
-- CUSTOM SLOT INSERTION
local CustomSlotCvar = GetConVar("arc9_bocw_customslot")
local CustomSlotTable = {
    PrintName = "Custom Slot",
    Bone = "tag_weapon",
    Pos = Vector(0, 0, 0),
    Ang = Angle(0, 0, 0),
    Icon_Offset = Vector(-2, 0, 0),
    Category = {"bocw_custom_slot", "bocw_custom_slot_knife"},
}

if CustomSlotCvar:GetBool() then
    table.insert(SWEP.Attachments, CustomSlotTable)
end
--=========================================================

SWEP.Animations = {
    ["idle"] = {
        Source = "idle",
    },
    ["draw"] = {
        Source = "draw",
    },
    ["holster"] = {
        Source = "holster",
    },
    ["ready"] = {
        Source = "ready",
        EventTable = {
            { s = "ARC9_BOCW.Knife_ready", t = 0.1 },
        },
    },
    ["bash"] = {
        Source = "melee1",
        EventTable = {
            { s = "ARC9_BOCW.Shared_Knife_Swing", t = 0.1 },
        },
    },
    ["1_bash"] = {
        Source = "melee2",
        EventTable = {
            { s = "ARC9_BOCW.Shared_Knife_Swing", t = 0.1 },
        },
    },
    ["bash2"] = {
        Source = "melee3",
        EventTable = {
            { s = "ARC9_BOCW.Shared_Knife_Swing", t = 0.05 },
        },
    },
    ["enter_sprint"] = {
        Source = "supersprint_in",
        Time = 0.75,
        NoStatAffectors = true
    },
    ["idle_sprint"] = {
        Source = "sprint_loop",
        Time = 3,
        NoStatAffectors = true
    },
    ["exit_sprint"] = {
        Source = "sprint_out",
        Time = 0.4,
        NoStatAffectors = true
    },
    ["enter_inspect"] = {
        Source = "inspect",
        EventTable = {
            { s = "ARC9_BOCW.Knife_inspect", t = 0 },
        },
    },
}