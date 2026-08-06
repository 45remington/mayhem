if SERVER then AddCSLuaFile() end

SWEP.Base = "weapon_bigconsumable"
SWEP.PrintName = "Beer"
SWEP.Instructions = "A beer bottle. Drink it to restore satiety."
SWEP.Category = "ZCity Other"
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.ViewModel = ""
SWEP.WorldModel = "models/props_junk/garbage_glassbottle001a.mdl"

if CLIENT then
	SWEP.WepSelectIcon = Material("vgui/wep_jack_hmcd_fooddrink")
	SWEP.IconOverride = "vgui/wep_jack_hmcd_fooddrink.png"
	SWEP.BounceWeaponIcon = false
end

SWEP.FoodModels = {
	"models/props_junk/garbage_glassbottle001a.mdl",
}

SWEP.WaterModel = {
	["models/props_junk/garbage_glassbottle001a.mdl"] = true,
}

SWEP.DrunkDuration = 960
SWEP.DrunkMaxStacks = 6
local DRUNK_MAX_STACKS = SWEP.DrunkMaxStacks

local hg_healanims = ConVarExists("hg_healanims") and GetConVar("hg_healanims") or CreateConVar("hg_healanims", 0, FCVAR_REPLICATED + FCVAR_ARCHIVE, "Toggle heal/food animations", 0, 1)

function SWEP:ApplyDrunkEffect(owner, org)
	if not SERVER or not IsValid(owner) or not owner:IsPlayer() or not org then return end

	local currentTime = CurTime()
	local currentStacks = (org.beerDrunkUntil or 0) > currentTime and (org.beerDrunkStacks or 0) or 0
	local newStacks = math.min(currentStacks + 1, self.DrunkMaxStacks)
	local newUntil = math.max(org.beerDrunkUntil or 0, currentTime) + self.DrunkDuration

	org.beerDrunkStacks = newStacks
	org.beerDrunkUntil = newUntil

	if newStacks == 2 and math.random(2) == 1 then
		owner:Notify("Oh yeahhhh this feels gooood!", 10, "beer_good_2", 0)
	end

	if newStacks >= 3 then
		local beerAnalgesia = math.min(0.12 + (newStacks - 3) * 0.12, 0.48)
		org.analgesia = math.max(org.analgesia or 0, beerAnalgesia)
	end

	owner.fullsend = true
end

function SWEP:InitializeAdd()
	self:SetHold(self.HoldType)

	local model = self.FoodModels[1]
	self:SetModel(model)
	self:SetCurModel(model)
	self.WorldModel = model

	if SERVER then
		timer.Simple(0, function()
			if not IsValid(self) then return end

			self:PhysicsInit(SOLID_VPHYSICS)

			local phys = self:GetPhysicsObject()
			if IsValid(phys) then
				phys:Wake()
			end
		end)
	end
end

if SERVER then
	local ang_drink = Angle(6, 0, 0)

	function SWEP:Heal(ent, mode)
		if ent:IsNPC() then
			self:SpawnGarbage(self:GetCurModel() or nil)
			self:NPCHeal(ent, 0.2, "snd_jack_hmcd_drink" .. math.random(3) .. ".wav")
			return
		end

		local org = ent.organism
		if not org then return end

		self.Eating = self.Eating or 0
		self.CDEating = self.CDEating or 0
		if self.CDEating > CurTime() then return end

		local owner = self:GetOwner()
		if ent == hg.GetCurrentCharacter(owner) and hg_healanims:GetBool() then
			self:SetHolding(math.min(self:GetHolding() + 10, 100))

			if self:GetHolding() < 100 then
				return
			end
		end

		org.satiety = org.satiety + 25 / 5
		owner:ViewPunch(ang_drink)
		ent:EmitSound("snd_jack_hmcd_drink" .. math.random(3) .. ".wav", 60, math.random(95, 105))

		self.CDEating = CurTime() + 0.5
		self.Eating = self.Eating + 1

		if self.Eating > 5 then
			self:ApplyDrunkEffect(owner, org)
			owner:SelectWeapon("weapon_hands_sh")
			self:SpawnGarbage(self:GetCurModel() or nil)
			self:Remove()
		end

		return true
	end
end

if CLIENT then
	local beerDistortMat = Material("effects/shaders/zb_heat")
	local beerBlurMat = Material("pp/blurscreen")
	local beerEffectLerp = 0
	local beerSwerveOffset = 0
	local beerSwerveTarget = 0
	local beerNextSwerve = 0

	local function GetBeerEffectStackScale(stacks)
		if stacks < 3 then
			return 0
		end

		if stacks == 3 then
			return 0.12
		end

		if stacks == 4 then
			return 0.22
		end

		if stacks == 5 then
			return 0.4
		end

		return 0.72
	end

	local function GetBeerEffectStrength()
		local ply = LocalPlayer()
		if not IsValid(ply) then return 0 end
		if not ply:Alive() then return 0 end
		if GetViewEntity() ~= ply then return 0 end

		local org = ply.new_organism or ply.organism
		if not org then return 0 end

		local drunkUntil = org.beerDrunkUntil or 0
		if drunkUntil <= CurTime() then return 0 end

		local stacks = math.max(org.beerDrunkStacks or 0, 0)
		local stackMul = GetBeerEffectStackScale(stacks)
		if stackMul <= 0 then return 0 end
		local fadeMul = math.Clamp((drunkUntil - CurTime()) / 15, 0, 1)

		return math.Clamp(stackMul * math.max(fadeMul, 0.45), 0, 1.1)
	end

	hook.Add("Post Processing", "weapon_beer_postfx", function()
		beerEffectLerp = Lerp(FrameTime() * 2, beerEffectLerp, GetBeerEffectStrength())
		if beerEffectLerp <= 0.01 then return end

		DrawColorModify({
			["$pp_colour_addr"] = 0.01 * beerEffectLerp,
			["$pp_colour_addg"] = 0,
			["$pp_colour_addb"] = 0,
			["$pp_colour_brightness"] = 0.015 * beerEffectLerp,
			["$pp_colour_contrast"] = 1 - 0.08 * beerEffectLerp,
			["$pp_colour_colour"] = 1 - 0.18 * beerEffectLerp,
			["$pp_colour_mulr"] = 0,
			["$pp_colour_mulg"] = 0,
			["$pp_colour_mulb"] = 0
		})
	end)

	hook.Add("Post Pre Post Processing", "weapon_beer_distortion", function()
		if beerEffectLerp <= 0.01 then return end

		local wave = math.sin(CurTime() * (1.2 + beerEffectLerp)) * beerEffectLerp
		DrawToyTown(2 + beerEffectLerp * 5, ScrH() * (0.5 + wave * 0.03))

		render.UpdateScreenEffectTexture()
		beerDistortMat:SetFloat("$c0_x", -CurTime() * (0.12 + beerEffectLerp * 0.12))
		beerDistortMat:SetFloat("$c0_y", 0.006 + beerEffectLerp * 0.028)
		beerDistortMat:SetFloat("$c2_x", wave * 1.6)
		render.SetMaterial(beerDistortMat)
		render.DrawScreenQuad()

		local scrW, scrH = ScrW(), ScrH()
		local blurStrength = 0.6 + beerEffectLerp * 1.6
		local blurAlpha = math.Clamp(45 + beerEffectLerp * 45, 0, 160)
		surface.SetMaterial(beerBlurMat)
		surface.SetDrawColor(255, 255, 255, blurAlpha)
		for i = 0.35, 1, 0.35 do
			beerBlurMat:SetFloat("$blur", blurStrength * i)
			beerBlurMat:Recompute()
			render.UpdateScreenEffectTexture()
			surface.DrawTexturedRect(0, 0, scrW, scrH)
		end

		local doubleVisionOffset = math.floor((2 + beerEffectLerp * 6) + math.abs(math.sin(CurTime() * 1.8)) * beerEffectLerp * 8)
		local doubleVisionAlpha = math.Clamp(20 + beerEffectLerp * 35, 0, 110)
		beerBlurMat:SetFloat("$blur", 0)
		beerBlurMat:Recompute()
		render.UpdateScreenEffectTexture()
		surface.SetDrawColor(255, 255, 255, doubleVisionAlpha)
		surface.DrawTexturedRect(-doubleVisionOffset, 0, scrW, scrH)
		surface.DrawTexturedRect(doubleVisionOffset, 0, scrW, scrH)
	end)

	hook.Add("MotionBlur", "weapon_beer_motionblur", function(x, y, w, z)
		if beerEffectLerp <= 0.01 then return end

		return {
			0.08 + beerEffectLerp * 0.06,
			0.7 + beerEffectLerp * 0.6,
			0.003 + beerEffectLerp * 0.025,
			z
		}
	end)

	hook.Add("CalcViewModelView", "weapon_beer_viewmodelsway", function(wep, vm, oldPos, oldAng, pos, ang)
		local strength = beerEffectLerp
		if strength <= 0.01 then return end

		local ply = LocalPlayer()
		if not IsValid(ply) or not ply:Alive() then return end
		if GetViewEntity() ~= ply then return end
		if not IsValid(vm) or not IsValid(wep) or wep ~= ply:GetActiveWeapon() then return end

		local swayTime = CurTime()
		local swayAng = Angle(
			math.cos(swayTime * 1.35) * strength * 0.8 + math.sin(swayTime * 3.2) * strength * 0.25,
			math.sin(swayTime * 0.95) * strength * 1.6 + beerSwerveOffset * strength * 2.5,
			math.sin(swayTime * 1.8) * strength * 2.4 + math.cos(swayTime * 2.65) * strength * 0.7
		)

		ang:RotateAroundAxis(ang:Right(), swayAng.p)
		ang:RotateAroundAxis(ang:Up(), swayAng.y)
		ang:RotateAroundAxis(ang:Forward(), swayAng.r)

		local swayPos = Vector(
			math.sin(swayTime * 1.1) * strength * 0.35,
			math.cos(swayTime * 1.55) * strength * 0.55,
			math.abs(math.sin(swayTime * 1.9)) * strength * 0.25
		)

		pos = pos + ang:Right() * swayPos.x + ang:Forward() * swayPos.y + ang:Up() * swayPos.z

		return pos, ang
	end)

	hook.Add("HG.InputMouseApply", "weapon_beer_aimdrift", function(tbl)
		local strength = beerEffectLerp
		if strength <= 0.01 then
			beerSwerveOffset = Lerp(FrameTime() * 2, beerSwerveOffset, 0)
			beerSwerveTarget = 0
			beerNextSwerve = 0
			return
		end

		local currentTime = CurTime()
		if currentTime >= beerNextSwerve then
			beerNextSwerve = currentTime + math.Rand(math.max(0.45, 1.9 - strength * 0.45), math.max(0.8, 3.1 - strength * 0.6))
			beerSwerveTarget = math.Rand(-1, 1) * (0.2 + strength * 0.65)
		end

		beerSwerveOffset = Lerp(FrameTime() * (1.2 + strength * 0.4), beerSwerveOffset, beerSwerveTarget)

		local yawDrift = ((math.sin(currentTime * 0.85) * 0.35) + (math.sin(currentTime * 2.15) * 0.2) + beerSwerveOffset) * strength * FrameTime() * 9
		local pitchDrift = (math.cos(currentTime * 1.15) * 0.18 + math.sin(currentTime * 2.8) * 0.12) * strength * FrameTime() * 5

		tbl.angle.pitch = math.Clamp(tbl.angle.pitch + pitchDrift, -89, 89)
		tbl.angle.yaw = tbl.angle.yaw + yawDrift
	end)
end
