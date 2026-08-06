hg.settings = hg.settings or {}
hg.settings.tbl = hg.settings.tbl or {}

function hg.settings:AddOpt( strCategory, strConVar, strTitle, bDecimals, bString, category )
    self.tbl[strCategory] = self.tbl[strCategory] or {}
    self.tbl[strCategory][strConVar] = { strCategory, strConVar, strTitle, bDecimals or false, bString or false, category }
end
local hg_firstperson_death = CreateClientConVar("hg_firstperson_death", "0", true, false, "Toggle first-person death camera view", 0, 1)
local hg_font = CreateClientConVar("hg_font", "Bahnschrift", true, false, "change every text font to selected because ui customization is cool")
local hg_attachment_draw_distance = CreateClientConVar("hg_attachment_draw_distance", 0, true, nil, "distance to draw attachments", 0, 4096)
local hg_appearance_darkmode_autotime = CreateClientConVar("hg_appearance_darkmode_autotime", "1", true, false, "Auto switch appearance menu dark mode based on your local PC time", 0, 1)
local hg_appearance_darkmode = ConVarExists("hg_appearance_darkmode")
    and GetConVar("hg_appearance_darkmode")
    or CreateClientConVar("hg_appearance_darkmode", "0", true, false, "Toggle dark mode for the appearance editor", 0, 1)

xbars = 17
ybars = 30

gradient_l = Material("vgui/gradient-l")
local gradient_d = Material("vgui/gradient-d")
local gradient_u = Material("vgui/gradient-u")
local gradient_r = Material("vgui/gradient-r")

local blur = Material("pp/blurscreen")
local blur2 = Material("effects/shaders/zb_blur" )
local sw, sh = ScrW(), ScrH()

local function IsSettingsNightHours()
    local hour = tonumber(os.date("%H") or "12") or 12
    return hour >= 20 or hour < 7
end

local function IsSettingsDarkMode()
    local manualDarkMode = hg_appearance_darkmode:GetBool()
    if hg_appearance_darkmode_autotime:GetBool() and not manualDarkMode and IsSettingsNightHours() then
        return true
    end

    return manualDarkMode
end

local function SettingsThemeColor(light, dark)
    return IsSettingsDarkMode() and dark or light
end

local function MenuTranslate(text)
    if hg and hg.MenuTranslate then
        return hg.MenuTranslate(text)
    end

    return text
end

local function PaintSettingsLightSwitch(w, h, enabled)
    local plateCol = enabled and Color(214, 218, 226, 255) or Color(232, 229, 221, 255)
    local plateShadow = enabled and Color(86, 96, 118, 255) or Color(160, 156, 148, 255)
    local plateHighlight = enabled and Color(245, 248, 255, 220) or Color(255, 255, 255, 235)
    local switchBorder = enabled and Color(68, 78, 98, 255) or Color(108, 104, 96, 255)
    local switchCol = enabled and Color(236, 242, 250, 255) or Color(243, 241, 236, 255)
    local slotCol = enabled and Color(130, 140, 164, 255) or Color(195, 190, 180, 255)

    draw.RoundedBox(0, 0, 0, w, h, plateShadow)
    draw.RoundedBox(0, 1, 1, w - 2, h - 2, plateCol)

    surface.SetDrawColor(plateHighlight)
    surface.DrawLine(1, 1, w - 2, 1)
    surface.DrawLine(1, 1, 1, h - 2)
    surface.SetDrawColor(plateShadow)
    surface.DrawLine(1, h - 2, w - 2, h - 2)
    surface.DrawLine(w - 2, 1, w - 2, h - 2)

    local screwCol = enabled and Color(110, 120, 142, 255) or Color(140, 136, 128, 255)
    surface.SetDrawColor(screwCol)
    surface.DrawRect(math.floor(w / 2) - 1, 3, 2, 2)
    surface.DrawRect(math.floor(w / 2) - 1, h - 5, 2, 2)

    local slotX = 4
    local slotY = 6
    local slotW = w - 8
    local slotH = h - 12
    draw.RoundedBox(0, slotX, slotY, slotW, slotH, slotCol)

    local rockerInset = 2
    local rockerX = slotX + rockerInset
    local rockerY = enabled and (slotY + 1) or (slotY + 3)
    local rockerW = slotW - rockerInset * 2
    local rockerH = slotH - 4
    draw.RoundedBox(0, rockerX, rockerY, rockerW, rockerH, switchCol)
    surface.SetDrawColor(switchBorder)
    surface.DrawOutlinedRect(rockerX, rockerY, rockerW, rockerH, 1)

    local lineCol = enabled and Color(124, 136, 164, 255) or Color(158, 152, 142, 255)
    surface.SetDrawColor(lineCol)
    surface.DrawRect(rockerX + 2, rockerY + rockerH / 2 - 3, rockerW - 4, 1)
    surface.DrawRect(rockerX + 2, rockerY + rockerH / 2, rockerW - 4, 1)

    if enabled then
        surface.SetDrawColor(140, 210, 255, 30)
        surface.DrawRect(2, 2, w - 4, h - 4)
    end
end

surface.CreateFont("ZCity_setiings_tiny", {
	font = "tt_kp",
	size = ScreenScale(7),
	weight = 100
})

surface.CreateFont("ZCity_setiings_fine", {
	font = "tt_kp",
	size = ScreenScale(10),
	weight = 100
})

surface.CreateFont("ZCity_setiings_category", {
	font = "tt_kp",
	size = ScreenScale(15),
	weight = 100
})


hg.settings:AddOpt("Gameplay","hg_old_notificate", "Old Notifications")
hg.settings:AddOpt("Gameplay","hg_cheats", "Enable Cheats")
hg.settings:AddOpt("Gameplay","hg_showthoughts", "Show thoughts")
hg.settings:AddOpt("Gameplay","hg_hints", "Show hints")
hg.settings:AddOpt("Gameplay","hg_gary", "HG GARY")
hg.settings:AddOpt("Gameplay","hg_deathfadeout", "Death fade out")
--hg_gary
--hg_deathfadeout
if not game.IsDedicated() then
	hg.settings:AddOpt("Serverside gameplay","hg_toughnpcs", "Tough npcs")
	hg.settings:AddOpt("Serverside gameplay","hg_thirdperson", "Thirdperson (WIP)")
	hg.settings:AddOpt("Serverside gameplay","hg_legacycam", "Legacy camera")
	hg.settings:AddOpt("Serverside gameplay","hg_ragdollcombat", "Ragdoll combat mode")
	hg.settings:AddOpt("Serverside gameplay","hg_movement_stamina_debuff", "Movement stamina debuff")
	hg.settings:AddOpt("Serverside gameplay","hg_furcity", "Furcity")
	hg.settings:AddOpt("Serverside gameplay","hg_appearance_access_for_all", "Appearance full access for all", nil, nil, "bool")
	hg.settings:AddOpt("Serverside gameplay","hg_healanims", "Heal & food animations")
	hg.settings:AddOpt("Serverside gameplay","hg_aimtoshoot", "DarkRP-like shoot system (aim to shoot)")
	hg.settings:AddOpt("Serverside gameplay","hg_slings", "Sling system")
    hg.settings:AddOpt("Serverside gameplay","homicide_traitoramount", "Homicide: Traitor Amount", nil, nil, "int")
end
--hg_appearance_access_for_all
--hg_furcity
--hg_legacycam
--hg_toughnpcs

hg.settings:AddOpt("Debug","hg_show_hitposmuzzle", "Show weapon hitpos")
hg.settings:AddOpt("Debug","hg_setzoompos", "Edit weapon zoompos, check console for results")
hg.settings:AddOpt("Debug","hg_show_hitbox", "Show hitboxes")

hg.settings:AddOpt("Optimization","hg_potatopc", "Potato PC Mode")
hg.settings:AddOpt("Optimization","hg_anims_draw_distance", "Animations Draw Distance", true, nil, "int")
hg.settings:AddOpt("Optimization","hg_anim_fps", "Animations FPS", nil, nil, "int")
hg.settings:AddOpt("Optimization","hg_attachment_draw_distance", "Attachment Draw Distance", true, nil, "int")
hg.settings:AddOpt("Optimization","hg_maxsmoketrails", "Maximum Smoke Trails", nil, nil, "int")
hg.settings:AddOpt("Optimization","hg_tpik_distance", "TPIK Render Distance", true, nil, "int")

hg.settings:AddOpt("Blood","hg_blood_draw_distance", "Blood Draw Distance")
hg.settings:AddOpt("Blood","hg_blood_fps", "Blood FPS")
hg.settings:AddOpt("Blood","hg_blood_sprites", "Blood Sprites (DISABLED FOR EVERYONE)")
hg.settings:AddOpt("Blood","hg_old_blood", "Old blood")

hg.settings:AddOpt("UI","hg_font", "Change Custom Font", false, true)
hg.settings:AddOpt("UI","hg_appearance_darkmode_autotime", "Auto Appearance Dark Mode By Time")

hg.settings:AddOpt("Weapons","hg_weaponshotblur_enable", "Shooting Blur")
hg.settings:AddOpt("Weapons","hg_dynamic_mags", "Dynamic Ammo Inspect")
hg.settings:AddOpt("Weapons","hg_zoomsensitivity", "Scope sensitivity")
hg.settings:AddOpt("Weapons","hg_highpitchgunfire", "Toggle high pitched gunfire sounds inside buildings")

hg.settings:AddOpt("View","hg_firstperson_death", "First-Person Death")
hg.settings:AddOpt("View","hg_fov", "Field Of View")
hg.settings:AddOpt("View","hg_newspectate", "Smooth Spectator Camera")
hg.settings:AddOpt("View","hg_cshs_fake", "C'sHS Ragdoll Camera")
hg.settings:AddOpt("View","hg_gun_cam", "Gun Camera (ADMIN ONLY)")
hg.settings:AddOpt("View","hg_nofovzoom", "Disable/Enable FOV Zoom")
hg.settings:AddOpt("View","hg_realismcam", "Realism camera (shitty)")
hg.settings:AddOpt("View","hg_gopro", "GoPro camera")
hg.settings:AddOpt("View","hg_newfakecam", "New fake camera")
hg.settings:AddOpt("View","hg_leancam_mul", "Lean camera mul", true, nil, "int")
hg.settings:AddOpt("View","hg_gun_cam", "Gun camera (WIP Admin only)")
--hg_hints
--hg_leancam_mul
  --hg_newfakecam
hg.settings:AddOpt("Sound","hg_dmusic", "Dynamic Music")
hg.settings:AddOpt("Sound","hg_quietshots", "Enable/Disable Quietshoot Sounds")


function hg.CreateCategory(ctgName, ParentPanel, yPos)
    local pppanel = vgui.Create('DPanel', ParentPanel)
    pppanel:SetSize(ParentPanel:GetWide() / 1.05, ParentPanel:GetTall() * 0.07)
    pppanel:SetPos(ParentPanel:GetWide() / 2 -pppanel:GetWide() / 2, yPos)
    --pppanel:SetText(ctgName)
    pppanel.Paint = function(self,w,h)
        draw.RoundedBox(0, 0, 0, w, h, SettingsThemeColor(Color(255, 255, 255, 245), Color(24, 27, 34, 245)))
        surface.SetDrawColor(SettingsThemeColor(Color(205, 205, 205, 255), Color(82, 92, 114, 255)))
        surface.DrawOutlinedRect(0, 0, w, h, 1)
        draw.SimpleText(string.lower(MenuTranslate(ctgName)), 'ZCity_setiings_category', w / 2, h / 2, SettingsThemeColor(Color(0, 0, 0), Color(255, 255, 255)), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    
    return pppanel
end

function hg.GetConVarType(convar)
    local stringv = convar:GetString()
    local floatVal = convar:GetFloat()
    local intVal = convar:GetInt()
    local boolVal = convar:GetBool()

    if (stringv == '0' and not boolVal) or (stringv == '1' and boolVal) then
        return 'bool'
    end

    if tonumber(stringv) and math.floor(stringv) == floatVal then
        if intVal == floatVal then
            return "int"
        end
    end

    return "string"
end

local function SetConVarValue(convar, value)
    if not convar then
        return
    end

    local name = convar.GetName and convar:GetName()
    if not name or name == "" then
        return
    end

    if isbool(value) then
        RunConsoleCommand(name, value and "1" or "0")
        return
    end

    RunConsoleCommand(name, tostring(value))
end

function hg.CreateButton(buttonData, convarName, ParentPanel, yPos)
    local convar = GetConVar(convarName)

    if not convar then 
        return 
    end
    local pppanel = vgui.Create('DPanel', ParentPanel)
    pppanel:SetSize(ParentPanel:GetWide()/1.05, ParentPanel:GetTall()/15)
    pppanel:SetPos(ParentPanel:GetWide()/2-pppanel:GetWide()/2, yPos)
    
    convarType = buttonData[6] or hg.GetConVarType(convar)
    pppanel.Paint = function(self,w,h)
        local displayTitle = MenuTranslate(buttonData[3])
        local displayHelp = MenuTranslate(convar:GetHelpText())

        surface.SetFont('ZCity_setiings_fine')
        local _, titleHeight = surface.GetTextSize(displayTitle)

        draw.SimpleText(string.lower(displayTitle), 'ZCity_setiings_fine', 30, h / 2 - titleHeight / 2.5, SettingsThemeColor(Color(20, 20, 20, 225), Color(255, 255, 255, 225)), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(displayHelp, 'ZCity_setiings_tiny', 30, h / 2 + titleHeight / 2, SettingsThemeColor(Color(80, 80, 80, 180), Color(210, 216, 228, 170)), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end

    if convarType == 'bool' then
        local toggle = vgui.Create('DButton', pppanel)
        toggle:SetSize(ScreenScale(22), ScreenScale(12))

        
        toggle:SetPos(pppanel:GetWide() - toggle:GetWide()*1.4 - pppanel:GetWide() / 20, pppanel:GetTall() / 2 - toggle:GetTall() / 2)
        toggle:SetText('')
        
        function toggle:Paint(w, h)
            local enabled = convar:GetBool()
            local textCol = enabled
                and SettingsThemeColor(Color(25, 25, 25, 240), Color(255, 255, 255, 240))
                or SettingsThemeColor(Color(80, 80, 80, 220), Color(210, 216, 228, 210))

            draw.SimpleText(MenuTranslate(enabled and "on" or "off"), "ZCity_setiings_tiny", w / 2, h / 2, textCol, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
        
        function toggle:DoClick()
            if convar then
                local newValue = not convar:GetBool()
                SetConVarValue(convar, newValue)

                surface.PlaySound('glide/headlights_on.wav')
            end
        end
        
    elseif convarType == 'int' then
        local slider = vgui.Create('DNumSlider', pppanel)
        slider:SetSize(280, 30)
        slider:SetPos(pppanel:GetWide() - 300, pppanel:GetTall() / 2 - 15)
        slider:SetText('')
        
        local min = convar:GetMin() or 0
        local max = convar:GetMax() or 100
        local decimals = buttonData[4] and 2 or 0
        
        slider:SetMin(min)
        slider:SetMax(max)
        slider:SetDecimals(decimals)
        slider:SetValue(decimals > 0 and convar:GetFloat() or convar:GetInt())
        
        function slider:OnValueChanged(val)
            if convar then
                SetConVarValue(convar, decimals > 0 and math.Round(val, decimals) or math.Round(val))
            end
        end
        
        local valueLabel = vgui.Create('DLabel', pppanel)
        valueLabel:SetPos(pppanel:GetWide() - 350, pppanel:GetTall() / 2 - 8)
        valueLabel:SetSize(50, 20)
        valueLabel:SetText(convar:GetInt())
        valueLabel:SetTextColor(SettingsThemeColor(Color(25, 25, 25, 210), Color(255, 255, 255, 220)))
        valueLabel:SetFont('ZCity_setiings_tiny')
        
        slider.Think = function()
            if convar then
                valueLabel:SetText(convar:GetInt())
            end
        end
        
    elseif convarType == 'string' then
        local textEntry = vgui.Create('DTextEntry', pppanel)
        textEntry:SetSize(pppanel:GetWide()/8, pppanel:GetTall()/2)
        textEntry:SetPos(pppanel:GetWide()-pppanel:GetWide()/8-20, pppanel:GetTall()/2-textEntry:GetTall()/2)
        textEntry:SetText(convar:GetString())
        textEntry:SetUpdateOnType(true) 
        textEntry:SetFont('ZCity_setiings_tiny')
        
    
        textEntry.Paint = function(self, w, h)
            surface.SetDrawColor(SettingsThemeColor(Color(255, 255, 255, 220), Color(33, 37, 46, 235)))
            surface.DrawRect(0, 0, w, h)
            surface.SetDrawColor(SettingsThemeColor(Color(185, 185, 185, 255), Color(92, 102, 126, 255)))
            surface.DrawOutlinedRect(0, 0, w, h)
            
            local textCol = SettingsThemeColor(Color(0, 0, 0), Color(255, 255, 255))
            self:DrawTextEntryText(textCol, Color(70, 130, 180), textCol)
        end
        
        function textEntry:OnValueChange(val)
            if convar then
                SetConVarValue(convar, val)
            end
        end
    end
    
    return pppanel
end

function hg.DrawSettings(ParentPanel)
    local luaMenu = ParentPanel:GetParent()
    ParentPanel:SetAlpha(0)
    ParentPanel.Paint = function(self,w,h)
        surface.SetDrawColor(SettingsThemeColor(Color(255, 255, 255, 255), Color(20, 22, 28, 255)))
        surface.DrawRect(0, 0, w, h)
        surface.SetDrawColor(SettingsThemeColor(Color(246, 246, 246, 255), Color(30, 33, 41, 255)))
        surface.SetMaterial(gradient_u)
        surface.DrawTexturedRect(0, 0, w, h)
        surface.SetDrawColor(SettingsThemeColor(Color(225, 225, 225, 180), Color(14, 16, 20, 220)))
        surface.SetMaterial(gradient_d)
        surface.DrawTexturedRect(0, h * 0.35, w, h * 0.65)
        surface.SetDrawColor(SettingsThemeColor(Color(235, 235, 235, 70), Color(60, 68, 84, 60)))
        surface.SetMaterial(gradient_r)
        surface.DrawTexturedRect(0, 0, w, h)
    end
    ParentPanel:AlphaTo(255,0.15,0)

    local closeButton = vgui.Create("DButton", ParentPanel)
    closeButton:SetSize(ScreenScale(14), ScreenScale(14))
    closeButton:SetPos(ParentPanel:GetWide() - closeButton:GetWide() - ScreenScale(8), ScreenScale(8))
    closeButton:SetText("")
    closeButton:SetCursor("hand")
    function closeButton:Paint(w, h)
        local textCol = self:IsHovered()
            and SettingsThemeColor(Color(20, 20, 20, 245), Color(255, 255, 255, 245))
            or SettingsThemeColor(Color(70, 70, 70, 210), Color(210, 216, 228, 210))

        draw.SimpleText("x", "ZCity_setiings_fine", w / 2, h / 2, textCol, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    function closeButton:DoClick()
        if IsValid(luaMenu) and luaMenu.ReturnToBaseMenu then
            luaMenu:ReturnToBaseMenu()
        end
    end

    local pppanel3 = vgui.Create('DScrollPanel', ParentPanel)
    pppanel3:SetSize(ParentPanel:GetWide(), ParentPanel:GetTall())
    pppanel3:SetPos(0,0)
    --pppanel3:SetAlpha(0)
    pppanel3.Paint = function()end
    local sbar = pppanel3:GetVBar()
    sbar:SetWide(ScreenScale(4))
    sbar:SetHideButtons(true)
    function sbar:Paint(w, h)
        draw.RoundedBox(4, 0, 0, w, h, SettingsThemeColor(Color(20, 20, 30, 200), Color(24, 27, 36, 220)))
        surface.SetDrawColor(SettingsThemeColor(Color(100, 100, 120, 200), Color(92, 102, 128, 220)))
        surface.DrawOutlinedRect(0, 0, w, h, 1)
    end
    function sbar.btnGrip:Paint(w, h)
        local gripCol = self:IsHovered()
            and SettingsThemeColor(Color(100, 100, 130, 255), Color(118, 130, 165, 255))
            or SettingsThemeColor(Color(70, 70, 90, 255), Color(88, 98, 125, 255))
        draw.RoundedBox(4, 2, 2, w - 4, h - 4, gripCol)
    end
    -- 🥴 <- лучший смайлик

    local yOffset = pppanel3:GetTall()/100

    for categoryName, categoryTable in pairs(hg.settings.tbl) do
        local category = hg.CreateCategory(categoryName, pppanel3, yOffset)
        yOffset = yOffset + category:GetTall() + 12
        for convarName, settingData in pairs(categoryTable) do
            local vbv = hg.CreateButton(settingData,convarName,pppanel3,yOffset)
            if not vbv then continue end
            yOffset = yOffset + (vbv:GetTall()) + 12
        end
    end
    local pppanel23 = vgui.Create('DPanel', pppanel3)
    pppanel23:SetSize(0, 0)
    pppanel23:SetPos(0,yOffset+12)

    if IsValid(luaMenu) then
        if IsValid(luaMenu.ExternalSubmenuBackButton) then
            luaMenu.ExternalSubmenuBackButton:Remove()
            luaMenu.ExternalSubmenuBackButton = nil
        end

        local backButton = vgui.Create("DButton", luaMenu)
        backButton:SetSize(ScreenScale(52), ScreenScale(16))
        backButton:SetText("")
        backButton:SetCursor("hand")
        function backButton:Think()
            if not IsValid(luaMenu) or not IsValid(ParentPanel) then
                self:Remove()
                return
            end

            local x = math.max(ScreenScale(8), ParentPanel:GetX() - self:GetWide() - ScreenScale(12))
            local y = ParentPanel:GetTall() / 2 - self:GetTall() / 2
            self:SetPos(x, y)
            self:MoveToFront()
        end
        function backButton:Paint(w, h)
            local bgCol = self:IsHovered()
                and SettingsThemeColor(Color(245, 245, 245, 235), Color(34, 38, 48, 235))
                or SettingsThemeColor(Color(255, 255, 255, 210), Color(24, 27, 34, 220))
            local borderCol = self:IsHovered()
                and SettingsThemeColor(Color(90, 90, 90, 255), Color(140, 152, 180, 255))
                or SettingsThemeColor(Color(160, 160, 160, 255), Color(82, 92, 114, 255))
            local textCol = self:IsHovered()
                and SettingsThemeColor(Color(20, 20, 20, 255), Color(255, 255, 255, 255))
                or SettingsThemeColor(Color(35, 35, 35, 235), Color(230, 235, 245, 235))

            draw.RoundedBox(0, 0, 0, w, h, bgCol)
            surface.SetDrawColor(borderCol)
            surface.DrawOutlinedRect(0, 0, w, h, 1)
            draw.SimpleText(MenuTranslate("back"), "ZCity_setiings_fine", w / 2, h / 2, textCol, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
        function backButton:DoClick()
            if IsValid(luaMenu) and luaMenu.ReturnToBaseMenu then
                luaMenu:ReturnToBaseMenu()
            end
        end

        luaMenu.ExternalSubmenuBackButton = backButton
        backButton:MoveToFront()
    end
end
