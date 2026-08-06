AddCSLuaFile()

hg = hg or {}
hg.StockMarket = hg.StockMarket or {}

local STOCK_STATE_NET = "hg_stockmarket_state"
local STOCK_STATE_REQUEST_NET = "hg_stockmarket_state_request"
local STOCK_CASH_NWVAR = "hg_stock_cash"
local STOCK_CASH_TABLE = "hg_stock_cash"
local STOCK_HISTORY_LENGTH = 18
local LOW_KARMA_THRESHOLD = 70
local LOW_KARMA_REWARD = 250
local TRAITOR_REWARD = 500

hg.StockMarket.Entries = hg.StockMarket.Entries or {
    {symbol = "GDHD", name = "Godhead Heavy Industries", base = 41.8, swing = 5.8, speed = 0.72, phase = 0.2, crash = 9.4, rise = 5.2},
    {symbol = "VEME", name = "Veggo's Meatoids", base = 66.4, swing = 8.6, speed = 0.54, phase = 1.1, crash = 14.8, rise = 8.3},
    {symbol = "SCRD", name = "Security, Redefined", base = 28.9, swing = 4.1, speed = 0.86, phase = 2.3, crash = 7.2, rise = 4.8},
    {symbol = "PIHO", name = "Pizza House", base = 53.7, swing = 7.4, speed = 0.62, phase = 0.9, crash = 12.1, rise = 6.7},
    {symbol = "NGT", name = "NegroTech AI Corporation", base = 220.0, swing = 8.4, speed = 0.48, phase = 1.8, crash = 9.5, rise = 10.2}
}

if SERVER then
    util.AddNetworkString(STOCK_STATE_NET)
    util.AddNetworkString(STOCK_STATE_REQUEST_NET)

    local market = hg.StockMarket
    market.State = market.State or {}

    local function EnsureCashTable()
        sql.Query("CREATE TABLE IF NOT EXISTS " .. STOCK_CASH_TABLE .. " (steamid64 TEXT PRIMARY KEY, cash INTEGER NOT NULL DEFAULT 0)")
    end

    local function NormalizeCash(value)
        return math.max(0, math.Round(tonumber(value) or 0))
    end

    function market.GetCash(ply)
        if not IsValid(ply) then return 0 end
        return NormalizeCash(ply.HGStockCash)
    end

    local function SaveCash(ply)
        if not IsValid(ply) then return end

        EnsureCashTable()

        sql.Query(string.format(
            "REPLACE INTO %s (steamid64, cash) VALUES (%s, %d)",
            STOCK_CASH_TABLE,
            sql.SQLStr(ply:SteamID64()),
            market.GetCash(ply)
        ))
    end

    local function LoadCash(ply)
        if not IsValid(ply) then return end

        EnsureCashTable()

        local steamID64 = ply:SteamID64()
        local row = sql.QueryRow(string.format(
            "SELECT cash FROM %s WHERE steamid64 = %s",
            STOCK_CASH_TABLE,
            sql.SQLStr(steamID64)
        ))

        local cash = row and NormalizeCash(row.cash) or 0

        if not row then
            sql.Query(string.format(
                "INSERT INTO %s (steamid64, cash) VALUES (%s, 0)",
                STOCK_CASH_TABLE,
                sql.SQLStr(steamID64)
            ))
        end

        ply.HGStockCash = cash
        ply:SetNWInt(STOCK_CASH_NWVAR, cash)
    end

    function market.SetCash(ply, amount)
        if not IsValid(ply) or not ply:IsPlayer() then return 0 end

        local cash = NormalizeCash(amount)
        ply.HGStockCash = cash
        ply:SetNWInt(STOCK_CASH_NWVAR, cash)
        SaveCash(ply)

        return cash
    end

    function market.AddCash(ply, amount)
        amount = NormalizeCash(amount)
        if amount <= 0 then return 0 end

        return market.SetCash(ply, market.GetCash(ply) + amount)
    end

    local function IsTraitorPlayer(ply)
        if not IsValid(ply) then return false end

        local subRole = string.lower(tostring(ply.SubRole or ""))
        if subRole ~= "" and string.find(subRole, "traitor", 1, true) then
            return true
        end

        local nwSubRole = string.lower(ply:GetNWString("SubRole", ""))
        if nwSubRole ~= "" and string.find(nwSubRole, "traitor", 1, true) then
            return true
        end

        return false
    end

    local function ResolveAttackerPlayer(attacker)
        if not IsValid(attacker) then return nil end
        if attacker:IsPlayer() then return attacker end
        if attacker:IsVehicle() then
            local driver = attacker:GetDriver()
            if IsValid(driver) and driver:IsPlayer() then
                return driver
            end
        end

        local owner = attacker.GetOwner and attacker:GetOwner() or nil
        if IsValid(owner) and owner:IsPlayer() then
            return owner
        end
    end

    hook.Add("PlayerInitialSpawn", "HG_StockCashLoad", function(ply)
        timer.Simple(0, function()
            if not IsValid(ply) then return end
            LoadCash(ply)
        end)
    end)

    hook.Add("PlayerDisconnected", "HG_StockCashSave", function(ply)
        SaveCash(ply)
    end)

    hook.Add("PlayerDeath", "HG_StockCashRewards", function(victim, inflictor, attacker)
        local killer = ResolveAttackerPlayer(attacker)
        if not IsValid(killer) or killer == victim then return end
        if not IsValid(victim) or not victim:IsPlayer() then return end

        local reward = 0

        if tonumber(victim.Karma) and victim.Karma < LOW_KARMA_THRESHOLD then
            reward = reward + LOW_KARMA_REWARD
        end

        if IsTraitorPlayer(victim) then
            reward = reward + TRAITOR_REWARD
        end

        if reward > 0 then
            market.AddCash(killer, reward)
        end
    end)

    local function BuildInitialHistory(entry)
        local history = {}
        local price = entry.base

        for i = 1, STOCK_HISTORY_LENGTH do
            local delta = math.Rand(-entry.swing * 0.34, entry.swing * 0.34)
            price = math.max(0.5, price + delta)
            history[i] = math.Round(price, 2)
        end

        return history
    end

    local function GetNextUpdateDelay(entry)
        local minDelay = 0.32 / math.max(entry.speed, 0.35)
        local maxDelay = 0.78 / math.max(entry.speed, 0.35)
        return math.Rand(minDelay, maxDelay)
    end

    local function GetNextPrice(entry, previousPrice)
        local delta = math.Rand(-entry.swing * 0.28, entry.swing * 0.28)

        if math.Rand(0, 1) < 0.16 then
            delta = delta + math.Rand(-entry.crash * 0.32, entry.rise * 0.32)
        end

        if math.Rand(0, 1) < 0.06 then
            delta = delta + math.Rand(-entry.crash * 0.52, entry.rise * 0.52)
        end

        return math.Round(math.max(0.5, previousPrice + delta), 2)
    end

    local function EnsureMarketState()
        for _, entry in ipairs(market.Entries) do
            local state = market.State[entry.symbol]

            if not state then
                local history = BuildInitialHistory(entry)
                market.State[entry.symbol] = {
                    history = history,
                    price = history[#history] or entry.base,
                    prevPrice = history[#history - 1] or history[#history] or entry.base,
                    nextUpdate = CurTime() + GetNextUpdateDelay(entry)
                }
            end
        end
    end

    local function BuildSnapshot()
        local snapshot = {}

        for _, entry in ipairs(market.Entries) do
            local state = market.State[entry.symbol]
            if state then
                snapshot[entry.symbol] = {
                    price = state.price,
                    prevPrice = state.prevPrice,
                    history = table.Copy(state.history)
                }
            end
        end

        return snapshot
    end

    local function BroadcastSnapshot(target)
        net.Start(STOCK_STATE_NET)
            net.WriteTable(BuildSnapshot())

        if IsValid(target) then
            net.Send(target)
        else
            net.Broadcast()
        end
    end

    hook.Add("Initialize", "HG_StockCashInit", function()
        EnsureCashTable()
        EnsureMarketState()
    end)

    hook.Add("Think", "HG_StockMarketThink", function()
        EnsureMarketState()

        local now = CurTime()
        local dirty = false

        for _, entry in ipairs(market.Entries) do
            local state = market.State[entry.symbol]

            if state and now >= (state.nextUpdate or 0) then
                local previousPrice = state.price or entry.base
                local nextPrice = GetNextPrice(entry, previousPrice)

                state.prevPrice = previousPrice
                state.price = nextPrice
                state.nextUpdate = now + GetNextUpdateDelay(entry)

                table.remove(state.history, 1)
                state.history[#state.history + 1] = nextPrice

                dirty = true
            end
        end

        if dirty then
            BroadcastSnapshot()
        end
    end)

    net.Receive(STOCK_STATE_REQUEST_NET, function(_, ply)
        EnsureMarketState()
        BroadcastSnapshot(ply)
    end)

    timer.Simple(0, function()
        EnsureCashTable()
        EnsureMarketState()

        for _, ply in ipairs(player.GetAll()) do
            LoadCash(ply)
            BroadcastSnapshot(ply)
        end
    end)
else
    local market = hg.StockMarket
    market.ClientState = market.ClientState or {}

    net.Receive(STOCK_STATE_NET, function()
        market.ClientState = net.ReadTable() or market.ClientState
    end)

    hook.Add("InitPostEntity", "HG_StockMarketRequestState", function()
        net.Start(STOCK_STATE_REQUEST_NET)
        net.SendToServer()
    end)
end
