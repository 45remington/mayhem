local PANEL = {}
local curent_panel 
local red_select = Color(192,0,0)
local ZCityMay = Material("vgui/mayhemlogo2.png")
local appearanceDarkMode = ConVarExists("hg_appearance_darkmode")
    and GetConVar("hg_appearance_darkmode")
    or CreateClientConVar("hg_appearance_darkmode", "0", true, false, "Toggle dark mode for the appearance editor", 0, 1)
local escapeMenuLanguage = ConVarExists("hg_menu_language")
    and GetConVar("hg_menu_language")
    or CreateClientConVar("hg_menu_language", "0", true, false, "Set the escape menu language preference", 0, 2)
local menuResolutionScale = math.Clamp(1 + ((ScrH() / 720) - 1) * 0.32, 1, 1.18)

local function MenuScale(value)
    return math.floor(ScreenScale(value) * menuResolutionScale)
end

local function MenuScaleH(value)
    return math.floor(ScreenScaleH(value) * menuResolutionScale)
end

DISCORD_URL = "https://discord.gg/475EmEdTgH"

local Selects = {
    {Title = "Disconnect", Func = function(luaMenu) RunConsoleCommand("disconnect") end},
    {Title = "Main Menu", Func = function(luaMenu) gui.ActivateGameUI() luaMenu:Close() end},
    {Title = "Discord", Func = function(luaMenu) luaMenu:Close() gui.OpenURL(DISCORD_URL)  end},
    {Title = "Traitor Role",
    GamemodeOnly = true,
    CreatedFunc = function(self, parent, luaMenu)
        local btn = vgui.Create( "DLabel", self )
        btn:SetText( "SOE" )
        btn:SetMouseInputEnabled( true )
        btn:SizeToContents()
        btn:SetFont( "ZC_MM_MenuButton" )
        btn:SetTall( ScreenScale( 15 ) )
        btn:Dock(BOTTOM)
        btn:DockMargin(ScreenScale(20),ScreenScale(10),0,0)
        btn:SetTextColor(Color(255,255,255))
        btn:InvalidateParent()
        btn.x = btn:GetX()

        function btn:DoClick()
            luaMenu:Close()
            hg.SelectPlayerRole(nil, "soe")
        end
    
        function btn:Think()
            self:SetTextColor(Color(235,235,235))
            self:SetX(self.x + ScreenScaleH(40))
        end

        local btn = vgui.Create( "DLabel", btn )
        btn:SetText( "STD" )
        btn:SetMouseInputEnabled( true )
        btn:SizeToContents()
        btn:SetFont( "ZC_MM_MenuButton" )
        btn:SetTall( ScreenScale( 15 ) )
        btn:Dock(BOTTOM)
        btn:DockMargin(0,ScreenScale(2),0,0)
        btn:SetTextColor(Color(255,255,255))
        btn:InvalidateParent()
        btn.x = btn:GetX()

        function btn:DoClick()
            luaMenu:Close()
            hg.SelectPlayerRole(nil, "standard")
        end
    
        function btn:Think()
            self:SetTextColor(Color(235,235,235))
            self:SetX(self.x + ScreenScaleH(35))
        end
    end,
    Func = function(luaMenu)
        
    end,
    },
    {Title = "Achievements", Func = function(luaMenu,pp) 
        hg.DrawAchievmentsMenu(pp)
    end},
    {Title = "Settings", Func = function(luaMenu,pp) 
        hg.DrawSettings(pp) 
    end},
    {Title = "Appearance", Func = function(luaMenu,pp) hg.CreateApperanceMenu(luaMenu) end},
    {Title = "Return", Func = function(luaMenu) luaMenu:Close() end},
}

local MarqueeSelectTitles = {
    "Discord",
    "Achievements",
    "Settings",
    "Appearance",
    "Return",
    "Disconnect",
    "Main Menu"
}

local function BuildMarqueeSelects()
    local lookup = {}
    local ordered = {}

    for _, entry in ipairs(Selects) do
        lookup[entry.Title] = entry
    end

    for _, title in ipairs(MarqueeSelectTitles) do
        if lookup[title] then
            ordered[#ordered + 1] = lookup[title]
        end
    end

    return ordered
end

local MarqueeSelects = BuildMarqueeSelects()

local splasheh = {
    'LIKE HOMICIDED',
    'PLUV PLUV PLUVISKI',
    'LULU IS NOT DEAD | !PLUV',
    'THE TRAITOR WAS KILLED',
    'NAB HOMICIDE SERVER',
    'ALSO TRY MODDED HOMICIDE 2',
    'HOP ON Z-CITY',
    'JOHN Z-CITY',
    ':pluvrare:',
    'SAW51 IS REAL',
    'MORE SMALLTOWN',
    'MORE CLUE2022',
    'BACKROOMS == CLUE',
    'HELL IS NEAR',
    'I WISH YOU GOOD HEALTH, JASON STATHAM'
}

--print(string.upper('I wish you good health, Jason Statham'))
surface.CreateFont("ZC_MM_Title", {
    font = "Tt-Kp Medium",
    size = MenuScale(40),
    weight = 500,
    antialias = true
})

surface.CreateFont("ZC_MM_TitleHuge", {
    font = "Tt-Kp Medium",
    size = MenuScale(74),
    weight = 500,
    antialias = true
})

surface.CreateFont("ZC_MM_MenuButton", {
    font = "Tt-Kp Medium",
    size = MenuScale(11),
    weight = 500,
    antialias = true,
    extended = true
})

surface.CreateFont("ZC_MM_MenuButtonMarquee", {
    font = "Tt-Kp Medium",
    size = MenuScale(13),
    weight = 650,
    antialias = true,
    extended = true
})

surface.CreateFont("ZC_MM_MenuButtonMarqueePop", {
    font = "Tt-Kp Medium",
    size = MenuScale(15),
    weight = 750,
    antialias = true,
    extended = true
})

surface.CreateFont("ZC_MM_StockTitle", {
    font = "tt_kp",
    size = MenuScale(6.2),
    weight = 700,
    antialias = true,
    extended = true
})

surface.CreateFont("ZC_MM_StockText", {
    font = "tt_kp",
    size = MenuScale(4.9),
    weight = 500,
    antialias = true,
    extended = true
})

surface.CreateFont("ZC_MM_StockPrice", {
    font = "tt_kp",
    size = MenuScale(8.5),
    weight = 700,
    antialias = true,
    extended = true
})

surface.CreateFont("ZC_MM_StockMini", {
    font = "tt_kp",
    size = MenuScale(4.5),
    weight = 500,
    antialias = true,
    extended = true
})

surface.CreateFont("ZC_MM_SwitchLabel", {
    font = "tt_kp",
    size = MenuScale(5.5),
    weight = 500,
    antialias = true,
    extended = true
})

surface.CreateFont("ZC_MM_Greeting", {
    font = "tt_kp",
    size = MenuScale(7),
    weight = 500,
    antialias = true,
    extended = true
})
-- local Title = markup.Parse("error")

local Pluv = Material("pluv/pluvkid.jpg")

function PANEL:InitializeMarkup()
    if hg.PluvTown.Active then
        self.SelectedPluv = table.Random(hg.PluvTown.PluvMats)
    end

    return markup.Parse("")
end

local color_red = Color(255,25,25,45)
local clr_gray = Color(255,255,255,25)
local clr_verygray = Color(10,10,19,235)
local menuShellModels = {
    "models/weapons/shotgun_shell.mdl",
    "models/weapons/shell.mdl",
    "models/weapons/rifleshell.mdl",
    "models/shells/fhell_10mm.mdl",
    "models/shells/fhell_50ae.mdl",
    "models/shells/fhell_50cal.mdl",
    "models/shells/fhell_545.mdl",
    "models/shells/fhell_556.mdl",
    "models/shells/fhell_9x19mm.mdl",
    "models/weapons/arc9/darsu_eft/shells/patron_12x70_shell.mdl",
    "models/weapons/arc9/darsu_eft/shells/patron_12x70_slug_grizzly_40_shell.mdl"
}
local menuShellCameraDistance = 205
local menuShellCameraFOV = 38
local menuShellCameraPos = Vector(0, 0, 0)
local menuShellCameraAng = Angle(0, 0, 0)
local menuFisheyeOverlay = "models/props_c17/fisheyelens"
local menuFisheyeAmount = -0.018
local menuFisheyePulse = 0.0025
local menuFisheyeLerp = 0
local menuTextTravelDuration = 10
local defaultMenuStockEntries = {
    {symbol = "GDHD", name = "Godhead Heavy Industries", base = 41.8, swing = 5.8, speed = 0.72, phase = 0.2, crash = 9.4, rise = 5.2},
    {symbol = "VEME", name = "Veggo's Meatoids", base = 66.4, swing = 8.6, speed = 0.54, phase = 1.1, crash = 14.8, rise = 8.3},
    {symbol = "SCRD", name = "Security, Redefined", base = 28.9, swing = 4.1, speed = 0.86, phase = 2.3, crash = 7.2, rise = 4.8},
    {symbol = "PIHO", name = "Pizza House", base = 53.7, swing = 7.4, speed = 0.62, phase = 0.9, crash = 12.1, rise = 6.7},
    {symbol = "NGT", name = "NegroTech AI Corporation", base = 220.0, swing = 8.4, speed = 0.48, phase = 1.8, crash = 9.5, rise = 10.2}
}
local menuStockEntries = (hg.StockMarket and hg.StockMarket.Entries) or defaultMenuStockEntries

local function GetStockTickerState(symbol)
    local market = hg.StockMarket
    return market and market.ClientState and market.ClientState[symbol] or nil
end

local function GetStockTickerPrice(stock)
    local state = GetStockTickerState(stock.symbol)
    return state and (state.price or state.history and state.history[#state.history]) or nil
end

local function GetStockTickerPreviousPrice(stock)
    local state = GetStockTickerState(stock.symbol)
    if not state then return nil end

    if state.prevPrice then
        return state.prevPrice
    end

    local history = state.history
    return history and history[#history - 1] or nil
end

local function GetStockTickerHistory(stock)
    local state = GetStockTickerState(stock.symbol)
    return state and state.history or nil
end

local function GetPlayerStockCash()
    local ply = LocalPlayer()
    if not IsValid(ply) then return 0 end
    return math.max(0, ply:GetNWInt("hg_stock_cash", 0))
end

local function FormatStockMoney(amount)
    return "$" .. string.Comma(math.Round(tonumber(amount) or 0))
end

local function GetMenuStockValue(stock, t)
    local baseWave = math.sin(t * stock.speed + stock.phase) * stock.swing
    local detailWave = math.sin(t * (stock.speed * 1.9) + stock.phase * 2.1) * stock.swing * 0.22
    local driftWave = math.sin(t * 0.16 + stock.phase * 0.8) * stock.swing * 0.35
    local crashWave = math.max(0, math.sin(t * (stock.speed * 0.33) + stock.phase * 1.7))
    local riseWave = math.max(0, math.sin(t * (stock.speed * 0.27) + stock.phase * 2.8 + 1.4))
    local crash = 0
    local rise = 0

    if crashWave > 0.79 then
        local frac = (crashWave - 0.79) / 0.21
        crash = frac * frac * stock.crash
    end

    if riseWave > 0.81 then
        local frac = (riseWave - 0.81) / 0.19
        rise = frac * frac * stock.rise
    end

    return math.max(0.5, stock.base + baseWave + detailWave + driftWave + rise - crash)
end

local CapsStockOverlay
local CapsStockOverlayEnabled = false
local CapsStockToggleKeyDown = false
local PaintStockTickerPanel

local function CycleStockSelection(stateHolder, delta)
    stateHolder.SelectedStockIndex = (stateHolder.SelectedStockIndex or 1) + delta

    if stateHolder.SelectedStockIndex < 1 then
        stateHolder.SelectedStockIndex = #menuStockEntries
    elseif stateHolder.SelectedStockIndex > #menuStockEntries then
        stateHolder.SelectedStockIndex = 1
    end
end

local function HandleStockTickerArrowInput(stateHolder)
    local upDown = input.IsKeyDown(KEY_UP)
    local downDown = input.IsKeyDown(KEY_DOWN)

    if upDown and not stateHolder.StockArrowUpDown then
        CycleStockSelection(stateHolder, -1)
    end

    if downDown and not stateHolder.StockArrowDownDown then
        CycleStockSelection(stateHolder, 1)
    end

    stateHolder.StockArrowUpDown = upDown
    stateHolder.StockArrowDownDown = downDown
end

local function LayoutStockTickerPanel(panel)
    local panelW = math.max(MenuScale(250), ScrW() * 0.34)
    local panelH = math.max(MenuScaleH(118), ScrH() * 0.22)
    panel:SetSize(panelW, panelH)
    panel:SetPos(ScrW() - panelW - MenuScale(18), MenuScaleH(14))
end

local function RemoveCapsStockOverlay()
    if IsValid(CapsStockOverlay) then
        CapsStockOverlay:Remove()
        CapsStockOverlay = nil
    end
end

local function EnsureCapsStockOverlay()
    if IsValid(CapsStockOverlay) then
        return CapsStockOverlay
    end

    CapsStockOverlay = vgui.Create("DPanel")
    CapsStockOverlay.SelectedStockIndex = 1
    CapsStockOverlay.StockGraphStates = {}
    CapsStockOverlay.StockTickerStateOwner = CapsStockOverlay
    CapsStockOverlay:SetMouseInputEnabled(false)
    CapsStockOverlay:SetKeyboardInputEnabled(false)
    CapsStockOverlay.Paint = PaintStockTickerPanel
    CapsStockOverlay.Think = function(this)
        LayoutStockTickerPanel(this)
        this:MoveToFront()
    end

    return CapsStockOverlay
end

local function CanShowCapsStockOverlay()
    local ply = LocalPlayer()
    return IsValid(ply)
        and ply:Alive()
        and (not ply.organism or not ply.organism.otrub)
        and not gui.IsGameUIVisible()
        and not IsValid(MainMenu)
end

PaintStockTickerPanel = function(this, w, h)
    local parent = this.StockTickerStateOwner or this:GetParent()
    if not IsValid(parent) and parent ~= this then
        return
    end

    local now = RealTime()
    local leftInset = MenuScale(4)
    local topInset = MenuScaleH(4)
    local tabY = topInset
    local tabH = MenuScaleH(7)
    local listTop = tabY + tabH + MenuScaleH(3)
    local listW = math.floor(w * 0.54)
    local rightX = listW + MenuScale(6)
    local graphX = rightX + MenuScale(4)
    local graphY = topInset + MenuScaleH(22)
    local graphW = w - graphX - MenuScale(8)
    local graphH = MenuScaleH(34)
    local selectedIndex = math.Clamp(parent.SelectedStockIndex or 1, 1, #menuStockEntries)
    local selectedStock = menuStockEntries[selectedIndex]
    local graphPointCount = 18
    local graphBucketSpan = 0.24

    parent.StockGraphStates = parent.StockGraphStates or {}
    local graphState = parent.StockGraphStates[selectedStock.symbol]
    local sharedHistory = GetStockTickerHistory(selectedStock)

    local function GetGraphSampleValue(sampleIndex)
        local sampleTime = sampleIndex * graphBucketSpan * 0.9 + selectedIndex * 0.37
        local value = GetMenuStockValue(selectedStock, sampleTime)
        value = value
            + math.sin(sampleIndex * 1.83 + selectedIndex * 0.8) * selectedStock.swing * 0.17
            + math.cos(sampleIndex * 2.67 + selectedIndex * 1.2) * selectedStock.swing * 0.08
            + math.sin(sampleIndex * 0.61 + selectedIndex * 2.1) * selectedStock.swing * 0.04
        return value
    end

    local function GetGraphUpdateInterval(sampleIndex)
        local variance = (math.sin(sampleIndex * 1.41 + selectedIndex * 0.77) + math.cos(sampleIndex * 0.63 + selectedIndex * 1.29)) * 0.5
        return 0.22 + (variance + 1) * 0.09
    end

    if not sharedHistory and not graphState then
        graphState = {
            points = {},
            sampleIndex = 0,
            nextUpdate = now + GetGraphUpdateInterval(0)
        }

        for i = 1, graphPointCount do
            local sampleIndex = i - graphPointCount
            graphState.points[i] = GetGraphSampleValue(sampleIndex)
        end

        parent.StockGraphStates[selectedStock.symbol] = graphState
    end

    if not sharedHistory and graphState then
        while now >= (graphState.nextUpdate or now) do
            table.remove(graphState.points, 1)
            graphState.sampleIndex = (graphState.sampleIndex or 0) + 1
            graphState.points[#graphState.points + 1] = GetGraphSampleValue(graphState.sampleIndex)
            graphState.nextUpdate = (graphState.nextUpdate or now) + GetGraphUpdateInterval(graphState.sampleIndex)
        end
    end

    local currentPrice = GetStockTickerPrice(selectedStock)
        or (graphState and graphState.points[#graphState.points])
        or GetGraphSampleValue(graphState and graphState.sampleIndex or 0)
    local previousPrice = GetStockTickerPreviousPrice(selectedStock)
        or (graphState and graphState.points[#graphState.points - 1])
        or currentPrice
    local currentChange = currentPrice - previousPrice
    local currentChangePct = previousPrice ~= 0 and (currentChange / previousPrice) * 100 or 0
    local cash = GetPlayerStockCash()
    local totalHoldings = cash

    surface.SetDrawColor(0, 0, 0, 245)
    surface.DrawRect(0, 0, w, h)
    surface.SetDrawColor(32, 32, 32, 165)
    surface.DrawRect(rightX, 0, 1, h)
    surface.SetDrawColor(42, 42, 42, 150)
    surface.DrawOutlinedRect(0, 0, w, h, 1)

    draw.RoundedBox(0, leftInset + MenuScale(30), tabY, MenuScale(18), tabH, Color(95, 255, 70, 255))
    draw.RoundedBox(0, leftInset + MenuScale(49), tabY, MenuScale(16), tabH, Color(160, 10, 10, 255))
    draw.SimpleText("Stocks", "ZC_MM_StockMini", leftInset + MenuScale(39), tabY + 1, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
    draw.SimpleText("recent", "ZC_MM_StockMini", leftInset + MenuScale(57), tabY + 1, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
    draw.SimpleText("Cash: " .. FormatStockMoney(cash), "ZC_MM_StockText", rightX + MenuScale(5), topInset + 1, Color(235, 235, 235, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    draw.SimpleText("Total holdings: " .. FormatStockMoney(totalHoldings), "ZC_MM_StockText", rightX + MenuScale(5), topInset + MenuScaleH(5), Color(200, 200, 200, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

    for index, stock in ipairs(menuStockEntries) do
        local rowY = listTop + (index - 1) * MenuScaleH(10)
        local price = GetStockTickerPrice(stock) or GetMenuStockValue(stock, now)
        local prevPrice = GetStockTickerPreviousPrice(stock) or GetMenuStockValue(stock, now - 0.2)
        local change = price - prevPrice
        local quantity = math.floor(stock.base * 31 + index * 7)
        local lineCol = index == selectedIndex and Color(255, 255, 255, 255) or Color(185, 185, 185, 255)
        local changeCol = change >= 0 and Color(0, 255, 0, 255) or Color(255, 70, 70, 255)

        surface.SetDrawColor(42, 42, 42, 60)
        surface.DrawLine(0, rowY + MenuScaleH(6), listW - 2, rowY + MenuScaleH(6))
        draw.SimpleText(string.format("(%d) %s", quantity, stock.symbol), "ZC_MM_StockText", leftInset, rowY, lineCol, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        draw.SimpleText(string.format("%+.1f", change), "ZC_MM_StockText", leftInset + MenuScale(52), rowY, changeCol, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        draw.SimpleText(string.format("$%.0f", price * quantity), "ZC_MM_StockText", listW - MenuScale(4), rowY, lineCol, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
    end

    local minValue = math.huge
    local maxValue = -math.huge
    local points = sharedHistory or (graphState and graphState.points) or {}

    for i = 1, #points do
        local value = points[i]
        minValue = math.min(minValue, value)
        maxValue = math.max(maxValue, value)
    end

    local range = math.max(0.01, maxValue - minValue)
    surface.SetDrawColor(42, 42, 42, 150)
    surface.DrawOutlinedRect(graphX, graphY, graphW, graphH, 1)

    for i = 1, #points - 1 do
        local valueA = points[i]
        local valueB = points[i + 1]
        local x1 = graphX + ((i - 1) / (#points - 1)) * graphW
        local x2 = graphX + (i / (#points - 1)) * graphW
        local y1 = graphY + graphH - ((valueA - minValue) / range) * (graphH - 4) - 2
        local y2 = graphY + graphH - ((valueB - minValue) / range) * (graphH - 4) - 2
        local rising = valueB >= valueA

        surface.SetDrawColor(rising and Color(0, 255, 0, 255) or Color(255, 70, 70, 255))
        surface.DrawLine(x1, y1, x2, y2)
    end

    draw.SimpleText(string.lower(selectedStock.name), "ZC_MM_StockText", rightX + MenuScale(5), graphY + graphH + MenuScaleH(4), Color(175, 175, 175, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    draw.SimpleText("(" .. selectedStock.symbol .. ")", "ZC_MM_StockText", rightX + MenuScale(5), graphY + graphH + MenuScaleH(10), Color(175, 175, 175, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    draw.SimpleText(string.format("Price: $%.2f  %.2f%%", currentPrice, currentChangePct), "ZC_MM_StockText", rightX + MenuScale(5), graphY + graphH + MenuScaleH(16), Color(235, 235, 235, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
    draw.SimpleText("MKT: " .. FormatStockMoney(totalHoldings), "ZC_MM_StockText", rightX + MenuScale(5), graphY + graphH + MenuScaleH(22), Color(235, 235, 235, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
end
local escapeMenuLanguages = {
    "english language",
    "russian language",
    "polish language"
}
local escapeMenuTranslations = {
    ["Disconnect"] = {ru = "Отключиться", pl = "Rozlacz"},
    ["Main Menu"] = {ru = "Главное меню", pl = "Menu glowne"},
    ["Discord"] = {ru = "Дискорд", pl = "Discord"},
    ["Traitor Role"] = {ru = "Роль предателя", pl = "Rola zdrajcy"},
    ["Achievements"] = {ru = "Достижения", pl = "Osiagniecia"},
    ["Settings"] = {ru = "Настройки", pl = "Ustawienia"},
    ["Appearance"] = {ru = "Внешность", pl = "Wyglad"},
    ["Return"] = {ru = "Назад", pl = "Powrot"},
    ["back"] = {ru = "назад", pl = "powrot"},
    ["dark mode"] = {ru = "темный режим", pl = "tryb ciemny"},
    ["light mode"] = {ru = "светлый режим", pl = "tryb jasny"},
    ["english language"] = {ru = "английский язык", pl = "jezyk angielski"},
    ["russian language"] = {ru = "русский язык", pl = "jezyk rosyjski"},
    ["polish language"] = {ru = "польский язык", pl = "jezyk polski"},
    ["good morning"] = {ru = "доброе утро", pl = "dzien dobry"},
    ["good afternoon"] = {ru = "добрый день", pl = "dobre popoludnie"},
    ["good evening"] = {ru = "добрый вечер", pl = "dobry wieczor"},
    ["Authors"] = {ru = "Авторы", pl = "Autorzy"},
    ["Gameplay"] = {ru = "Геймплей", pl = "Rozgrywka"},
    ["Serverside gameplay"] = {ru = "Серверный геймплей", pl = "Rozgrywka serwerowa"},
    ["Debug"] = {ru = "Отладка", pl = "Debug"},
    ["Optimization"] = {ru = "Оптимизация", pl = "Optymalizacja"},
    ["Blood"] = {ru = "Кровь", pl = "Krew"},
    ["UI"] = {ru = "Интерфейс", pl = "Interfejs"},
    ["Weapons"] = {ru = "Оружие", pl = "Bronie"},
    ["View"] = {ru = "Вид", pl = "Widok"},
    ["Sound"] = {ru = "Звук", pl = "Dzwiek"},
    ["Old Notifications"] = {ru = "Старые уведомления", pl = "Stare powiadomienia"},
    ["Enable Cheats"] = {ru = "Включить читы", pl = "Wlacz cheaty"},
    ["Show thoughts"] = {ru = "Показывать мысли", pl = "Pokaz mysli"},
    ["Show hints"] = {ru = "Показывать подсказки", pl = "Pokaz wskazowki"},
    ["HG GARY"] = {ru = "HG GARY", pl = "HG GARY"},
    ["Death fade out"] = {ru = "Затухание после смерти", pl = "Zanikanie po smierci"},
    ["Tough npcs"] = {ru = "Крепкие NPC", pl = "Twarde NPC"},
    ["Thirdperson (WIP)"] = {ru = "Третье лицо (WIP)", pl = "Trzecia osoba (WIP)"},
    ["Legacy camera"] = {ru = "Старая камера", pl = "Stara kamera"},
    ["Ragdoll combat mode"] = {ru = "Режим боя в регдолле", pl = "Tryb walki ragdoll"},
    ["Movement stamina debuff"] = {ru = "Штраф к выносливости", pl = "Kara do staminy ruchu"},
    ["Furcity"] = {ru = "Furcity", pl = "Furcity"},
    ["Appearance full access for all"] = {ru = "Полный доступ к внешности для всех", pl = "Pelny dostep do wygladu dla wszystkich"},
    ["Heal & food animations"] = {ru = "Анимации лечения и еды", pl = "Animacje leczenia i jedzenia"},
    ["DarkRP-like shoot system (aim to shoot)"] = {ru = "Стрельба как в DarkRP (прицелился - стреляешь)", pl = "Strzelanie jak w DarkRP (celujesz by strzelac)"},
    ["Sling system"] = {ru = "Система ремней", pl = "System zawiesi"},
    ["Homicide: Traitor Amount"] = {ru = "Homicide: количество предателей", pl = "Homicide: liczba zdrajcow"},
    ["Show weapon hitpos"] = {ru = "Показывать точку попадания оружия", pl = "Pokaz punkt trafienia broni"},
    ["Edit weapon zoompos, check console for results"] = {ru = "Редактировать позицию прицела, смотрите консоль", pl = "Edytuj pozycje przyblizenia broni, sprawdz konsole"},
    ["Show hitboxes"] = {ru = "Показывать хитбоксы", pl = "Pokaz hitboxy"},
    ["Potato PC Mode"] = {ru = "Режим слабого ПК", pl = "Tryb slabego PC"},
    ["Animations Draw Distance"] = {ru = "Дистанция анимаций", pl = "Dystans rysowania animacji"},
    ["Animations FPS"] = {ru = "FPS анимаций", pl = "FPS animacji"},
    ["Attachment Draw Distance"] = {ru = "Дистанция отрисовки навесов", pl = "Dystans rysowania dodatkow"},
    ["Maximum Smoke Trails"] = {ru = "Максимум дымовых следов", pl = "Maksymalna liczba smug dymu"},
    ["TPIK Render Distance"] = {ru = "Дистанция TPIK", pl = "Dystans renderowania TPIK"},
    ["Blood Draw Distance"] = {ru = "Дистанция крови", pl = "Dystans rysowania krwi"},
    ["Blood FPS"] = {ru = "FPS крови", pl = "FPS krwi"},
    ["Blood Sprites (DISABLED FOR EVERYONE)"] = {ru = "Спрайты крови (ОТКЛЮЧЕНО ДЛЯ ВСЕХ)", pl = "Sprite'y krwi (WYLACZONE DLA WSZYSTKICH)"},
    ["Old blood"] = {ru = "Старая кровь", pl = "Stara krew"},
    ["Change Custom Font"] = {ru = "Сменить пользовательский шрифт", pl = "Zmien niestandardowa czcionke"},
    ["Auto Appearance Dark Mode By Time"] = {ru = "Авто-темный режим внешности по времени", pl = "Automatyczny ciemny tryb wygladu wg czasu"},
    ["Shooting Blur"] = {ru = "Размытие при стрельбе", pl = "Rozmycie przy strzale"},
    ["Dynamic Ammo Inspect"] = {ru = "Динамическая проверка магазина", pl = "Dynamiczna kontrola magazynka"},
    ["Scope sensitivity"] = {ru = "Чувствительность прицела", pl = "Czulosc lunety"},
    ["Toggle high pitched gunfire sounds inside buildings"] = {ru = "Высокие звуки выстрелов в помещениях", pl = "Przelacz wysokie dzwieki strzalow w budynkach"},
    ["First-Person Death"] = {ru = "Смерть от первого лица", pl = "Smierc z pierwszej osoby"},
    ["Field Of View"] = {ru = "Поле зрения", pl = "Pole widzenia"},
    ["Smooth Spectator Camera"] = {ru = "Плавная камера наблюдателя", pl = "Plynna kamera obserwatora"},
    ["C'sHS Ragdoll Camera"] = {ru = "Камера регдолла C'sHS", pl = "Kamera ragdolla C'sHS"},
    ["Gun Camera (ADMIN ONLY)"] = {ru = "Камера оружия (ТОЛЬКО АДМИН)", pl = "Kamera broni (TYLKO ADMIN)"},
    ["Disable/Enable FOV Zoom"] = {ru = "Включить/выключить зум FOV", pl = "Wlacz/wylacz zoom FOV"},
    ["Realism camera (shitty)"] = {ru = "Реалистичная камера (кривая)", pl = "Realistyczna kamera (slaba)"},
    ["GoPro camera"] = {ru = "Камера GoPro", pl = "Kamera GoPro"},
    ["New fake camera"] = {ru = "Новая fake-камера", pl = "Nowa sztuczna kamera"},
    ["Lean camera mul"] = {ru = "Множитель наклона камеры", pl = "Mnoznik wychylenia kamery"},
    ["Gun camera (WIP Admin only)"] = {ru = "Камера оружия (WIP только админ)", pl = "Kamera broni (WIP tylko admin)"},
    ["Dynamic Music"] = {ru = "Динамическая музыка", pl = "Dynamiczna muzyka"},
    ["Enable/Disable Quietshoot Sounds"] = {ru = "Включить/выключить тихие выстрелы", pl = "Wlacz/wylacz ciche strzaly"},
    ["on"] = {ru = "вкл", pl = "wl"},
    ["off"] = {ru = "выкл", pl = "wyl"},
    ["items"] = {ru = "предметы", pl = "przedmioty"},
    ["greetings,"] = {ru = "приветствия,", pl = "pozdrowienia,"},
    ["close"] = {ru = "закрыть", pl = "zamknij"},
    ["shirt color"] = {ru = "цвет рубашки", pl = "kolor koszuli"},
    ["Models"] = {ru = "Модели", pl = "Modele"},
    ["Hats"] = {ru = "Шляпы", pl = "Kapelusze"},
    ["Face"] = {ru = "Лицо", pl = "Twarz"},
    ["Body"] = {ru = "Тело", pl = "Cialo"},
    ["Jacket"] = {ru = "Куртка", pl = "Kurtka"},
    ["Color"] = {ru = "Цвет", pl = "Kolor"},
    ["Pants"] = {ru = "Штаны", pl = "Spodnie"},
    ["Boots"] = {ru = "Ботинки", pl = "Buty"},
    ["Gloves"] = {ru = "Перчатки", pl = "Rekawice"},
    ["Facemap"] = {ru = "Лицо", pl = "Mapa twarzy"},
    ["models"] = {ru = "модели", pl = "modele"},
    ["hats"] = {ru = "шляпы", pl = "kapelusze"},
    ["face"] = {ru = "лицо", pl = "twarz"},
    ["body"] = {ru = "тело", pl = "cialo"},
    ["jacket"] = {ru = "куртка", pl = "kurtka"},
    ["color"] = {ru = "цвет", pl = "kolor"},
    ["pants"] = {ru = "штаны", pl = "spodnie"},
    ["boots"] = {ru = "ботинки", pl = "buty"},
    ["gloves"] = {ru = "перчатки", pl = "rekawice"},
    ["facemap"] = {ru = "лицо", pl = "mapa twarzy"},
    ["return"] = {ru = "назад", pl = "powrot"},
    ["apply"] = {ru = "применить", pl = "zastosuj"},
    ["none"] = {ru = "ничего", pl = "brak"},
    ["None"] = {ru = "Ничего", pl = "Brak"},
    ["remove cosmetic"] = {ru = "убрать косметику", pl = "usun kosmetyke"},
    ["custom audio url"] = {ru = "своя ссылка на аудио", pl = "wlasny url audio"},
    ["custom stream"] = {ru = "свой поток", pl = "wlasny strumien"},
    ["now playing: "] = {ru = "сейчас играет: ", pl = "teraz gra: "},
    ["I will definitely survive..."] = {ru = "Я точно выживу...", pl = "Na pewno przezyje..."},
    ["Die from hypoxia."] = {ru = "Умереть от гипоксии.", pl = "Umrzyj z powodu hipoksji."},
    ["Overstimulated"] = {ru = "Перестимулирован", pl = "Przestymulowany"},
    ["Die from opioids overdose."] = {ru = "Умереть от передозировки опиоидами.", pl = "Umrzyj od przedawkowania opioidow."},
    ["I'll be back"] = {ru = "Я вернусь", pl = "Wroce"},
    ["Get shot in the head and get up alive."] = {ru = "Получить пулю в голову и выжить.", pl = "Dostan strzal w glowe i przezyj."},
    ["Kill Em All"] = {ru = "Убей их всех", pl = "Zabij ich wszystkich"},
    ["Kill everyone being a traitor and win the round\nplayers on the server should be more than 9."] = {ru = "Убей всех будучи предателем и выиграй раунд.\nНа сервере должно быть больше 9 игроков.", pl = "Zabij wszystkich jako zdrajca i wygraj runde.\nNa serwerze musi byc wiecej niz 9 graczy."},
    ["Deadly Gambling"] = {ru = "Смертельная игра", pl = "Smiercionosny hazard"},
    ["Survive 10 games of Russian roulette in one life."] = {ru = "Пережить 10 игр в русскую рулетку за одну жизнь.", pl = "Przetrwaj 10 gier w rosyjska ruletke w jednym zyciu."},
    ["Hydrogen bomb vs Lobotomized patient"] = {ru = "Водородная бомба против лоботомированного пациента", pl = "Bomba wodorowa kontra zlobotomizowany pacjent"},
    ["Kill the traitor while having brain damage"] = {ru = "Убить предателя с повреждением мозга", pl = "Zabij zdrajce z uszkodzeniem mozgu"},
    ["Hot Potato"] = {ru = "Горячая картошка", pl = "Goracy kartofel"},
    ["Kill the traitor using his own grenade"] = {ru = "Убить предателя его же гранатой", pl = "Zabij zdrajce jego wlasnym granatem"},
    ["Sir please calm down"] = {ru = "Сэр, пожалуйста, успокойтесь", pl = "Prosze pana, prosze sie uspokoic"},
    ["Something terrible happened on that plane..."] = {ru = "В том самолете случилось что-то ужасное...", pl = "Na tym samolocie stalo sie cos strasznego..."}
}

local function IsEscapeMenuDarkMode()
    return appearanceDarkMode:GetBool()
end

local function EscapeThemeColor(light, dark)
    return IsEscapeMenuDarkMode() and dark or light
end

local function GetEscapeMenuLanguageIndex()
    return math.Clamp(escapeMenuLanguage:GetInt() or 0, 0, #escapeMenuLanguages - 1)
end

function hg.GetEscapeMenuLanguageCode()
    local languageCodes = {"en", "ru", "pl"}
    return languageCodes[GetEscapeMenuLanguageIndex() + 1] or "en"
end

function hg.MenuTranslate(text)
    if not isstring(text) or text == "" then
        return text
    end

    local languageCode = hg.GetEscapeMenuLanguageCode and hg.GetEscapeMenuLanguageCode() or "en"
    if languageCode == "en" then
        return text
    end

    local entry = escapeMenuTranslations[text]
    if not entry then
        return text
    end

    return entry[languageCode] or text
end

local function GetEscapeMenuLanguageLabel()
    return hg.MenuTranslate(escapeMenuLanguages[GetEscapeMenuLanguageIndex() + 1] or escapeMenuLanguages[1])
end

local function GetEscapeGreeting()
    local hour = tonumber(os.date("%H") or "12") or 12
    local greeting

    if hour < 12 then
        greeting = hg.MenuTranslate("good morning")
    elseif hour < 18 then
        greeting = hg.MenuTranslate("good afternoon")
    else
        greeting = hg.MenuTranslate("good evening")
    end

    local lply = LocalPlayer()
    local name = "player"
    if IsValid(lply) then
        if lply.SteamName then
            name = lply:SteamName()
        else
            name = lply:Nick()
        end
    end

    return greeting .. ", " .. tostring(name)
end

local function MenuShellScreenToWorld(w, h, x, y, depth)
    local halfHeight = math.tan(math.rad(menuShellCameraFOV * 0.5)) * depth
    local halfWidth = halfHeight * (w / math.max(h, 1))
    local right = (x / math.max(w, 1) - 0.5) * 2 * halfWidth
    local up = (0.5 - y / math.max(h, 1)) * 2 * halfHeight
    return Vector(depth, right, up)
end

local function GetMenuShellSpawnX(w)
    local overflow = w * 0.06
    local leftMin = -overflow
    local leftMax = w * 0.42
    local rightMin = w * 0.58
    local rightMax = w + overflow

    if math.random() < 0.5 then
        return math.Rand(leftMin, leftMax)
    end

    return math.Rand(rightMin, rightMax)
end

local function PaintAppearanceLightSwitch(w, h, enabled)
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

local function PaintLanguageSwitch(w, h, languageIndex)
    local plateCol = Color(232, 229, 221, 255)
    local plateShadow = Color(160, 156, 148, 255)
    local plateHighlight = Color(255, 255, 255, 235)
    local switchBorder = Color(108, 104, 96, 255)
    local switchCol = Color(243, 241, 236, 255)
    local slotCol = Color(195, 190, 180, 255)
    local lineCol = Color(158, 152, 142, 255)
    local activeCol = Color(170, 156, 118, 255)

    draw.RoundedBox(0, 0, 0, w, h, plateShadow)
    draw.RoundedBox(0, 1, 1, w - 2, h - 2, plateCol)

    surface.SetDrawColor(plateHighlight)
    surface.DrawLine(1, 1, w - 2, 1)
    surface.DrawLine(1, 1, 1, h - 2)
    surface.SetDrawColor(plateShadow)
    surface.DrawLine(1, h - 2, w - 2, h - 2)
    surface.DrawLine(w - 2, 1, w - 2, h - 2)

    surface.SetDrawColor(140, 136, 128, 255)
    surface.DrawRect(math.floor(w / 2) - 1, 3, 2, 2)
    surface.DrawRect(math.floor(w / 2) - 1, h - 5, 2, 2)

    local slotX = 4
    local slotY = 6
    local slotW = w - 8
    local slotH = h - 12
    draw.RoundedBox(0, slotX, slotY, slotW, slotH, slotCol)

    local steps = #escapeMenuLanguages
    local segmentH = slotH / steps
    local rockerInset = 2
    local rockerX = slotX + rockerInset
    local rockerY = slotY + 1 + segmentH * languageIndex
    local rockerW = slotW - rockerInset * 2
    local rockerH = math.max(4, segmentH - 2)
    draw.RoundedBox(0, rockerX, rockerY, rockerW, rockerH, switchCol)
    surface.SetDrawColor(switchBorder)
    surface.DrawOutlinedRect(rockerX, rockerY, rockerW, rockerH, 1)

    surface.SetDrawColor(lineCol)
    for i = 1, steps - 1 do
        local y = slotY + segmentH * i
        surface.DrawRect(slotX + 1, y, slotW - 2, 1)
    end

    local indicatorY = rockerY + rockerH / 2 - 1
    surface.SetDrawColor(activeCol)
    surface.DrawRect(rockerX + 2, indicatorY, rockerW - 4, 2)
end

function PANEL:Init()
    self:SetAlpha(255)
    self:SetSize(ScrW(), ScrH())
    self:Center()
    self:SetTitle("")
    self:SetDraggable(false)
    self:SetBorder(false)
    self:SetColorBG(EscapeThemeColor(clr_verygray, Color(4, 4, 7, 245)))
    self:SetDraggable(false)
    self:ShowCloseButton(false)
    curent_panel = nil
    self.Title, self.TitleShadow = self:InitializeMarkup()
    self.MenuShells = {}
    self.MenuShellUpdate = RealTime()
    self.MenuTextTravelStart = RealTime()
    self.SelectedStockIndex = 1
    self.StockGraphStates = {}

    timer.Simple(0, function()
        if self.First then
            self:First()
        end
    end)

    self.lDock = vgui.Create("DPanel", self)
    local lDock = self.lDock
    local menuAspectRatio = ScrW() / math.max(ScrH(), 1)
    local menuTextOffsetY = menuAspectRatio <= 1.4 and MenuScaleH(16) or 0
    lDock:SetSize(MenuScale(220), MenuScaleH(395))
    lDock:SetPos(MenuScale(8), MenuScaleH(8))
    lDock:DockPadding(0, MenuScale(132) + menuTextOffsetY, 0, 0)
    lDock.Paint = function(this, w, h)
        if hg.PluvTown.Active then
            surface.SetDrawColor(color_white)
            surface.SetMaterial(self.SelectedPluv or Pluv)
            surface.DrawTexturedRect(0, MenuScale(27), MenuScale(35), MenuScale(27))
        end

        local logoW = MenuScale(182)
        local logoH = MenuScale(124)
        surface.SetDrawColor(255, 255, 255, 255)
        surface.SetMaterial(ZCityMay)
        surface.DrawTexturedRect((w - logoW) / 2, MenuScale(6), logoW, logoH)
    end

    local bottomDock = vgui.Create("DPanel", self)
    bottomDock:SetPos(MenuScale(1), ScrH() - ScrH()/10)
    bottomDock:SetSize(MenuScale(190), MenuScaleH(40))
    bottomDock.Paint = function(this, w, h) end
    self.ButtonDock = vgui.Create("DPanel", self)
    self.ButtonDock.IsMarqueeDock = true
    self.ButtonDock:SetPos(0, ScrH() - MenuScaleH(22))
    self.ButtonDock:SetSize(1, MenuScaleH(22))
    self.ButtonDock.Paint = function(this, w, h) end
    self.ButtonDockWrap = vgui.Create("DPanel", self)
    self.ButtonDockWrap.IsMarqueeDock = true
    self.ButtonDockWrap:SetPos(0, ScrH() - MenuScaleH(22))
    self.ButtonDockWrap:SetSize(1, MenuScaleH(22))
    self.ButtonDockWrap.Paint = function(this, w, h) end
    self.panelparrent = vgui.Create("DPanel", self)
    self.panelparrent:SetPos(bottomDock:GetWide()+bottomDock:GetX(), 0)
    self.panelparrent:SetSize(ScrW() - bottomDock:GetWide()*1, ScrH() - MenuScaleH(24))
    self.panelparrent.Paint = function(this, w, h) end
    self.StockTicker = vgui.Create("DPanel", self)
    LayoutStockTickerPanel(self.StockTicker)
    self.StockTicker.StockTickerStateOwner = self
    self.StockTicker.Paint = PaintStockTickerPanel
    self.StockTicker.Think = function(this)
        local parent = this:GetParent()
        LayoutStockTickerPanel(this)
        this:SetVisible(not curent_panel and not IsValid(parent.FullscreenPanel))
    end
    lDock:MoveToFront()
    self.ButtonDock:MoveToFront()
    self.ButtonDockWrap:MoveToFront()

    self.Buttons = {}
    local wrapButtons = {}
    self.WrapButtons = wrapButtons
    local function PopulateMarqueeDock(dock, targetButtons)
        local oldButtons = self.Buttons
        self.Buttons = targetButtons
        for _, v in ipairs(MarqueeSelects) do
            self:AddSelect(dock, v.Title, v)
        end
        self.Buttons = oldButtons
    end

    PopulateMarqueeDock(self.ButtonDock, self.Buttons)
    PopulateMarqueeDock(self.ButtonDockWrap, wrapButtons)
	self.ButtonDock.VerticalMenu = true
	self.ButtonDock:SetPos(MenuScale(28), MenuScaleH(178))
	self.ButtonDock:SetSize(MenuScale(205), MenuScaleH(250))
	self.ButtonDockWrap:SetVisible(false)

    local gap = MenuScale(10)
    local totalWide = 0
    for _, button in ipairs(self.Buttons) do
        if not IsValid(button) then continue end
        totalWide = totalWide + button:GetWide() + gap
    end
    totalWide = math.max(1, totalWide - gap)
    self.ButtonDock:SetSize(totalWide, MenuScaleH(22))
    self.ButtonDockWrap:SetSize(totalWide, MenuScaleH(22))
    self.MenuMarqueeGap = gap
    self.MenuMarqueeSpeed = (ScrW() + totalWide + gap) / math.max(menuTextTravelDuration, 0.01)
    self.MenuMarqueeOffset = 0
    self.MenuMarqueeLastUpdate = RealTime()
    self.ButtonDock:SetPos(0, ScrH() - MenuScaleH(22))
    self.ButtonDockWrap:SetPos(-(totalWide + gap), ScrH() - MenuScaleH(22))
	if self.ButtonDock.VerticalMenu then
		self.ButtonDock:SetPos(MenuScale(28), MenuScaleH(178))
		self.ButtonDock:SetSize(MenuScale(205), MenuScaleH(250))
		self.ButtonDockWrap:SetVisible(false)
	end
    self.MenuTextTravelStart = RealTime()
    function self:IsMenuMarqueeHovered()
        for _, button in ipairs(self.Buttons or {}) do
            if IsValid(button) and button:IsHovered() then
                return true
            end
        end

        for _, button in ipairs(self.WrapButtons or {}) do
            if IsValid(button) and button:IsHovered() then
                return true
            end
        end

        return false
    end
    function self.ButtonDock:Think()
        local parent = self:GetParent()
        local wrap = IsValid(parent) and parent.ButtonDockWrap
        if not IsValid(parent) or not IsValid(wrap) then
            return
        end
		if self.VerticalMenu then
			self:SetPos(MenuScale(28), MenuScaleH(178))
			wrap:SetVisible(false)
			return
		end

        local y = ScrH() - MenuScaleH(22)
        local speed = parent.MenuMarqueeSpeed or 0
        local spacing = self:GetWide() + (parent.MenuMarqueeGap or 0)
        local now = RealTime()
        local lastUpdate = parent.MenuMarqueeLastUpdate or now
        parent.MenuMarqueeLastUpdate = now

        if not parent:IsMenuMarqueeHovered() then
            parent.MenuMarqueeOffset = ((parent.MenuMarqueeOffset or 0) + math.max(0, now - lastUpdate) * speed) % spacing
        end

        local offset = parent.MenuMarqueeOffset or 0
        self:SetPos(math.floor(offset), y)
        wrap:SetPos(math.floor(offset - spacing), y)
    end

    local submenuBackButton = vgui.Create("DButton", self)
    submenuBackButton:SetText("")
    submenuBackButton:SetVisible(false)
    submenuBackButton:SetCursor("hand")
    submenuBackButton.ButtonText = "back"
    submenuBackButton.ShowForSubmenu = false
    function submenuBackButton:Think()
        local luaMenu = self:GetParent()
        local panel = IsValid(luaMenu) and luaMenu.panelparrent
        local canShow = self.ShowForSubmenu
            and IsValid(luaMenu)
            and IsValid(panel)
            and not IsValid(luaMenu.FullscreenPanel)

        self:SetVisible(canShow)
        if not canShow then
            return
        end

        self:SetPos(MenuScale(8), math.floor(luaMenu:GetTall() * 0.5 - MenuScaleH(10)))
        self:SetSize(math.max(MenuScale(78), panel:GetX() - MenuScale(16)), MenuScaleH(20))
        self:MoveToFront()
    end
    function submenuBackButton:Paint(w, h)
        local col = self:IsHovered() and Color(255, 255, 255) or Color(235, 235, 235, 220)
        draw.SimpleText("< " .. string.lower(hg.MenuTranslate(self.ButtonText or "back")) .. " >", "ZC_MM_MenuButton", w / 2, h / 2, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    function submenuBackButton:DoClick()
        local luaMenu = self:GetParent()
        if IsValid(luaMenu) and luaMenu.ReturnToBaseMenu then
            luaMenu:ReturnToBaseMenu()
        end
    end
    self.SubmenuBackButton = submenuBackButton
    
    local git = vgui.Create("DLabel", bottomDock)
    git:Dock(BOTTOM)
    git:DockMargin(ScreenScale(10), 0, 0, 0)
    git:SetFont("ZCity_Tiny")
    git:SetTextColor(clr_gray)
    git:SetText("GitHub: github.com/" .. hg.GitHub_ReposOwner .. "/" .. hg.GitHub_ReposName)
    git:SetContentAlignment(4)
    git:SetMouseInputEnabled(true)
    git:SizeToContents()

    function git:DoClick()
        gui.OpenURL("https://github.com/" .. hg.GitHub_ReposOwner .. "/" .. hg.GitHub_ReposName)
    end

    local version = vgui.Create("DLabel", bottomDock)
    version:Dock(BOTTOM)
    version:DockMargin(ScreenScale(10), 0, 0, 0)
    version:SetFont("ZCity_Tiny")
    version:SetTextColor(clr_gray)
    version:SetText(hg.Version)
    version:SetContentAlignment(4)
    version:SizeToContents()

    local zteam = vgui.Create("DLabel", bottomDock)
    zteam:Dock(BOTTOM)
    zteam:DockMargin(ScreenScale(10), 0, 0, 0)
    zteam:SetFont("ZCity_Tiny")
    zteam:SetTextColor(clr_gray)
    zteam:SetText(hg.MenuTranslate("Authors") .. ": uzelezz, Sadsalat, \nMr.Point, Zac90, Deka, Mannytko")
    zteam:SetContentAlignment(4)
    zteam:SizeToContents()

end

function PANEL:First( ply )
    self:SetAlpha(255)
end

local gradient_d = surface.GetTextureID("vgui/gradient-d")
local gradient_r = surface.GetTextureID("vgui/gradient-u")
local gradient_l = surface.GetTextureID("vgui/gradient-l")

local clr_bg = Color(120, 120, 120, 140)
function PANEL:DrawMenuShellPass(w, h, drawBehindLogo)
    cam.Start3D(menuShellCameraPos, menuShellCameraAng, menuShellCameraFOV, 0, 0, w, h, 1, 1024)
    render.SuppressEngineLighting(true)
    render.SetLightingMode(1)
    cam.IgnoreZ(true)

    for _, shell in ipairs(self.MenuShells or {}) do
        if not IsValid(shell.Model) or shell.BehindLogo ~= drawBehindLogo then continue end

        local depthFactor = 1 - math.Clamp((shell.depthOffset + 48) / 92, 0, 1) * 0.45
        if not shell.BehindLogo then
            depthFactor = depthFactor + 0.18
        end

        local shellPos = MenuShellScreenToWorld(w, h, shell.x, shell.y, menuShellCameraDistance + shell.depthOffset)
        shell.Model:SetPos(shellPos)
        shell.Model:SetAngles(Angle(shell.pitch, shell.ang, shell.roll))
        shell.Model:SetModelScale(shell.scale, 0)
        shell.Model:SetRenderAngles(Angle(shell.pitch, shell.ang, shell.roll))
        shell.Model:SetupBones()
        shell.Model:DrawModel()
    end

    cam.IgnoreZ(false)
    render.SuppressEngineLighting(false)
    render.SetLightingMode(0)
    cam.End3D()
end

function PANEL:ShouldDrawMenuShells()
    return false
end

function PANEL:ShouldDrawMenuFisheye()
    return false
end

function PANEL:Paint(w,h)
    draw.RoundedBox(0, 0, 0, w, h, EscapeThemeColor(clr_bg, Color(6, 6, 10, 205)))
    hg.DrawBlur(self, 5)

    local now = RealTime()
    local delta = math.Clamp(now - (self.MenuShellUpdate or now), 0, 0.05)
    self.MenuShellUpdate = now

    for _, shell in ipairs(self.MenuShells or {}) do
        shell.y = shell.y + shell.vy * delta
        shell.ang = shell.ang + shell.spin * delta
        shell.roll = shell.roll + shell.rollSpin * delta
        shell.pitch = shell.pitch + shell.pitchSpin * delta

        if shell.y - shell.drawSize > h + ScreenScale(58) then
            self:ResetMenuShell(shell)
        end
    end

    self.MenuShellParallaxX = 0
    self.MenuShellParallaxY = 0
    self.MenuContentParallaxX = 0
    self.MenuContentParallaxY = 0

    if self:ShouldDrawMenuShells() then
        self:DrawMenuShellPass(w, h, true)
    end
end

function PANEL:PaintOver(w, h)
    if self:ShouldDrawMenuShells() then
        self:DrawMenuShellPass(w, h, false)
    end
end

function PANEL:ResetMenuShell(shell, initial)
    local w, h = self:GetWide(), self:GetTall()
    local desiredModel = table.Random(menuShellModels)
    if not IsValid(shell.Model) or shell.Model:GetModel() ~= desiredModel then
        if IsValid(shell.Model) then
            shell.Model:Remove()
        end

        shell.Model = ClientsideModel(desiredModel, RENDERGROUP_BOTH)
        if IsValid(shell.Model) then
            shell.Model:SetNoDraw(true)
        end
    end

    shell.seed = math.Rand(0, 100)
    shell.x = GetMenuShellSpawnX(w)
    shell.y = initial and math.Rand(-h * 0.3, h * 1.15) or -math.Rand(ScreenScale(18), h * 0.55)
    shell.vy = math.Rand(70, 170)
    shell.spin = math.Rand(-92, 92)
    shell.ang = math.Rand(18, 342)
    shell.pitch = math.Rand(25, 155)
    shell.roll = math.Rand(-85, 85)
    shell.pitchSpin = math.Rand(-48, 48)
    shell.rollSpin = math.Rand(-86, 86)
    shell.scale = math.Rand(2.1, 4.1)
    shell.drawSize = ScreenScale(math.Rand(62, 126))
    shell.depthOffset = math.Rand(-48, 44)
    shell.BehindLogo = math.random() < 0.42
end

function PANEL:OnRemove()
    for _, shell in ipairs(self.MenuShells or {}) do
        if IsValid(shell.Model) then
            shell.Model:Remove()
        end
    end
end

function PANEL:ClearActiveSelect()
    curent_panel = nil

    if IsValid(self.panelparrent) then
        self.panelparrent:SetAlpha(255)
        self.panelparrent:SetVisible(true)
    end

    if IsValid(self.ExternalSubmenuBackButton) then
        self.ExternalSubmenuBackButton:Remove()
        self.ExternalSubmenuBackButton = nil
    end

    if IsValid(self.SubmenuBackButton) then
        self.SubmenuBackButton.ShowForSubmenu = false
        self.SubmenuBackButton:SetVisible(false)
    end
end

function PANEL:ShowSubmenuBackButton(text)
    if not IsValid(self.SubmenuBackButton) then
        return
    end

    self.SubmenuBackButton.ButtonText = text or "back"
    self.SubmenuBackButton.ShowForSubmenu = true
    self.SubmenuBackButton:MoveToFront()
end

function PANEL:ReturnToBaseMenu()
    if not IsValid(self.panelparrent) then
        self:ClearActiveSelect()
        return
    end

    if IsValid(self.FullscreenPanel) then
        self.FullscreenPanel:Remove()
        self.FullscreenPanel = nil
    end

    local panel = self.panelparrent
    panel:AlphaTo(0, 0.12, 0, function()
        if not IsValid(panel) then
            return
        end

        panel:Clear()
        panel.Paint = function() end
        panel:SetAlpha(255)

        if not IsValid(self) then
            return
        end

        self:ClearActiveSelect()

        if IsValid(self.lDock) then
            self.lDock:MoveToFront()
        end
    end)
end

function PANEL:AddSelect( pParent, strTitle, tbl )
    local id = #self.Buttons + 1
    self.Buttons[id] = vgui.Create( "DLabel", pParent )
    local btn = self.Buttons[id]
    local marqueeButton = pParent.IsMarqueeDock == true
    local btnFont = marqueeButton and "ZC_MM_MenuButtonMarquee" or "ZC_MM_MenuButton"
    btn:SetText( "" )
    btn:SetMouseInputEnabled( true )
    btn:SetCursor("hand")
    btn:SizeToContents()
    btn:SetFont( btnFont )
    btn.MenuFont = btnFont
    btn:SetTall( marqueeButton and MenuScaleH( 22 ) or MenuScaleH( 16 ) )
    btn:Dock(marqueeButton and TOP or LEFT)
    btn:DockMargin(0, 0, marqueeButton and 0 or MenuScale(4), marqueeButton and MenuScaleH(2) or 0)
    btn.Func = tbl.Func
    btn.HoveredFunc = tbl.HoveredFunc
    local luaMenu = self 
    if tbl.CreatedFunc then tbl.CreatedFunc(btn, self, luaMenu) end
    btn.RColor = Color(235,235,235)
    surface.SetFont(btn.MenuFont)
    local displayTitle = string.lower(hg.MenuTranslate(strTitle))
    local displayText = "[" .. displayTitle .. "];"
    local textW = surface.GetTextSize(displayText)
    btn:SetWide(textW + (marqueeButton and MenuScale(10) or MenuScale(6)))
    function btn:DoClick()
        self.ClickPulse = CurTime() + 0.25
        -- ,kz оптимизировать надо, но идёт ошибка(кэшировать бы luaMenu.panelparrent вместо вызова его каждый раз)
        if curent_panel == string.lower(strTitle) then
			for i = 1, 3 do
				surface.PlaySound("shitty/tap_release.wav")
			end
            if IsValid(luaMenu.FullscreenPanel) then
                luaMenu.FullscreenPanel:Remove()
                luaMenu.FullscreenPanel = nil
            end
            luaMenu.panelparrent:AlphaTo(0,0.2,0,function()
                luaMenu.panelparrent:Remove()
                luaMenu.panelparrent = nil
                luaMenu.panelparrent = vgui.Create("DPanel", luaMenu)
                
                luaMenu.panelparrent:SetPos(some_coordinates_x, 0)
                luaMenu.panelparrent:SetSize(some_size_x, some_size_y)
                luaMenu.panelparrent.Paint = function(this, w, h) end
                --btn.Func(luaMenu,luaMenu.panelparrent)
                curent_panel = nil
            end)
            return 
        end
        some_size_x = luaMenu.panelparrent:GetWide()
        some_size_y = luaMenu.panelparrent:GetTall()
        some_coordinates_x = luaMenu.panelparrent:GetX()
        if IsValid(luaMenu.FullscreenPanel) then
            luaMenu.FullscreenPanel:Remove()
            luaMenu.FullscreenPanel = nil
        end
        luaMenu.panelparrent:AlphaTo(0,0.2,0,function()
            luaMenu.panelparrent:Remove()
            luaMenu.panelparrent = nil
            luaMenu.panelparrent = vgui.Create("DPanel", luaMenu)
            
            luaMenu.panelparrent:SetPos(some_coordinates_x, 0)
            luaMenu.panelparrent:SetSize(some_size_x, some_size_y)
            luaMenu.panelparrent.Paint = function(this, w, h) end
            btn.Func(luaMenu,luaMenu.panelparrent)
            curent_panel = string.lower(strTitle)
        end)
		for i = 1, 3 do
			surface.PlaySound("shitty/tap_depress.wav")
		end
    end

    function btn:Paint(w, h)
        local active = curent_panel == string.lower(strTitle) and strTitle ~= "Traitor Role"
        local hovered = self:IsHovered()
        local displayTitle = string.lower(hg.MenuTranslate(strTitle))
        local displayText = "[" .. displayTitle .. "];"
        local pop = self.PopAnim or 0
        local font = pop > 0.45 and "ZC_MM_MenuButtonMarqueePop" or (self.MenuFont or "ZC_MM_MenuButton")
        local textCol = active and Color(255, 255, 255) or hovered and Color(255, 255, 255) or Color(235, 235, 235, 210)
		draw.SimpleText(displayText, font, MenuScale(10) * pop + 2, h / 2 + 2, Color(0, 0, 0, 90), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        draw.SimpleText(displayText, font, MenuScale(10) * pop, h / 2, textCol, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end

    function btn:Think()
        local active = curent_panel == string.lower(strTitle) and strTitle ~= "Traitor Role"
        local clicked = (self.ClickPulse or 0) > CurTime()
        self.PopAnim = LerpFT(0.12, self.PopAnim or 0, (self:IsHovered() or active or clicked) and 1 or 0)
        surface.SetFont(self.PopAnim > 0.45 and "ZC_MM_MenuButtonMarqueePop" or (self.MenuFont or "ZC_MM_MenuButton"))
        local displayTitle = string.lower(hg.MenuTranslate(strTitle))
        local displayText = "[" .. displayTitle .. "];"
        local textW = surface.GetTextSize(displayText)
        self:SetWide(textW + (marqueeButton and MenuScale(30) or MenuScale(6)))
		if marqueeButton then self:SetTall(MenuScaleH(22) + MenuScaleH(12) * (self.PopAnim or 0)) end
        self:SetTextColor(self.RColor)
    end
end

function PANEL:Close()
    self:SetKeyboardInputEnabled(false)
    self:SetMouseInputEnabled(false)
    self:Remove()
end

function PANEL:OnKeyCodePressed(keyCode)
    if IsValid(self.FullscreenPanel) then return end
    if curent_panel then return end

    if keyCode == KEY_UP then
        CycleStockSelection(self, -1)
    elseif keyCode == KEY_DOWN then
        CycleStockSelection(self, 1)
    end
end

vgui.Register( "ZMainMenu", PANEL, "ZFrame")

hook.Add("RenderScreenspaceEffects", "ZMainMenuFisheye", function()
    local target = 0

    if IsValid(MainMenu) and MainMenu.ShouldDrawMenuFisheye and MainMenu:ShouldDrawMenuFisheye() then
        target = 1
    end

    menuFisheyeLerp = Lerp(FrameTime() * 2.2, menuFisheyeLerp, target)
    if target == 0 and menuFisheyeLerp < 0.01 then
        menuFisheyeLerp = 0
        return
    end

    local eased = menuFisheyeLerp * menuFisheyeLerp * (3 - 2 * menuFisheyeLerp)
    local pulse = math.sin(RealTime() * 0.55) * 0.5 + 0.5
    local refract = (menuFisheyeAmount - menuFisheyePulse * pulse) * eased

    DrawMaterialOverlay(menuFisheyeOverlay, refract)
    DrawBloom(0.1, 0.32 * eased, 9, 9, 1, 0.45, 1, 0.97, 0.92)
    DrawColorModify({
        ["$pp_colour_addr"] = 0.003 * eased,
        ["$pp_colour_addg"] = 0.004 * eased,
        ["$pp_colour_addb"] = 0.007 * eased,
        ["$pp_colour_brightness"] = 0.012 * eased,
        ["$pp_colour_contrast"] = 1 + 0.025 * eased,
        ["$pp_colour_colour"] = 0.95 - 0.015 * eased,
        ["$pp_colour_mulr"] = 0,
        ["$pp_colour_mulg"] = 0,
        ["$pp_colour_mulb"] = 0
    })
end)

hook.Add("OnPauseMenuShow","OpenMainMenu",function()
    local run = hook.Run("OnShowZCityPause")
    if run != nil then
        return run
    end

    if MainMenu and IsValid(MainMenu) then
        MainMenu:Close()
        MainMenu = nil
        return false
    end

    MainMenu = vgui.Create("ZMainMenu")
    MainMenu:MakePopup()
    return false
end)

hook.Add("Think", "ZMainMenuCapsStockOverlay", function()
    local capsDown = input.IsKeyDown(KEY_CAPSLOCK)
    if capsDown and not CapsStockToggleKeyDown and CanShowCapsStockOverlay() then
        CapsStockOverlayEnabled = not CapsStockOverlayEnabled
    end
    CapsStockToggleKeyDown = capsDown

    local canShow = CapsStockOverlayEnabled and CanShowCapsStockOverlay()

    if not canShow then
        RemoveCapsStockOverlay()
        return
    end

    local overlay = EnsureCapsStockOverlay()
    if IsValid(overlay) then
        HandleStockTickerArrowInput(overlay)
    end
end)

concommand.Add("hg_toggle_stockmarket", function()
    CapsStockOverlayEnabled = not CapsStockOverlayEnabled

    if not CapsStockOverlayEnabled then
        RemoveCapsStockOverlay()
        return
    end

    if not CanShowCapsStockOverlay() then
        CapsStockOverlayEnabled = false
        return
    end

    EnsureCapsStockOverlay()
end)
