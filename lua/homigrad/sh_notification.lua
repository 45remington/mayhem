local hg_furcity = ConVarExists("hg_furcity") and GetConVar("hg_furcity") or CreateConVar("hg_furcity", 0, bit.bor(FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_LUA_SERVER), "Toggle phrase furryfier :3", 0, 1)

hg.fur = {
	" rawr~",
	" mrrrph~~",
	" meow :3",
	" uwu",
	" >w<",
	" OwO",
	" ^w^",
	" *blushes*",
	" -w-",
	" ~w~",
	" mrrawr~~",
	" mrrp~",
	" mrreow~",
	" mwah~",
	"~",
	"~~"
}

local translateSymbol = {
	["r"] = "w",
	["R"] = "W",
	["l"] = "w",
	["L"] = "W",
	["з"] = "в",
	["З"] = "В",
	["ш"] = "ф",
	["Ш"] = "Ф",
	--["ч"] = "т",
	--["Ч"] = "Т",
	--["у"] = "ю",
	--["У"] = "Ю",
	--["т"] = "в",
	--["Т"] = "В",
}

local repeating = {
	["r"] = true,
	["R"] = true,
	["р"] = true,
	["Р"] = true,
}

// можно сделать чтобы оно просто брало стринг, текущее местоположение буквы и добавляло ещё сверху
//



function hg.FurrifyPhrase(msg)
	local iter = utf8.codes(msg)
	local len = 0
	local chars = {}

	for i, code in iter do
		len = len + 1
		chars[len] = utf8.char(code)
	end

	-- local lastpos = 0
	-- while lastpos != -1 do
	--     local newpos = string.find(msg, "[rR]", lastpos)

	-- end


	--i нельзя менять
	for i = #chars, 1, -1 do
		if repeating[chars[i]] and math.random(2) == 1 then
			for i2 = 1, math.random(3) do
				table.insert(chars, i, chars[i])
			end
		elseif translateSymbol[chars[i]] and math.random(2) == 1 then
			chars[i] = translateSymbol[chars[i]]
		end
	end--legendary

	msg = table.concat(chars)

	if math.random(4) == 1 then
		msg = msg..hg.fur[math.random(#hg.fur)]
	end

	return msg
end

if CLIENT then
	local hg_old_notificate = ConVarExists("hg_old_notificate") and GetConVar("hg_old_notificate") or CreateConVar("hg_old_notificate",0,{FCVAR_USERINFO,FCVAR_ARCHIVE},"Toggle old notifications (chatprints)",0,1)

	surface.CreateFont("BerserkFont", {
		font = "Who asks Satan",
		size = ScreenScale(25),
		extended = true,
		weight = 400,
		antialias = true,
	})

	surface.CreateFont("HuyFont", {
		font = "BudgetLabel",
		extended = true,
		size = ScreenScale(9),
		weight = 0,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		strikeout = false,
		shadow = false,
		outline = false,
	})

	surface.CreateFont("SmallHuyFont", {
		font = "BudgetLabel",
		extended = true,
		size = ScreenScale(7),
		weight = 0,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		strikeout = false,
		shadow = false,
		outline = false,
	})

	hg.notifications = hg.notifications or {}
	hg.notificationFont = "HuyFont"

	hook.Add("Player_Death","removeNotifications",function(ply)
		if ply != lply then return end

		//hg.currentNotification = nil
		hg.notifications = {}
	end)

	hook.Add("Player Spawn","removeNotificationsa",function(ply)
		if ply != lply then return end

		hg.currentNotification = nil
		hg.notifications = {}
	end)

	hook.Add("HG_OnOtrub","removeNotificationsb",function(ply)
		if ply != lply then return end
	end)

	local defaultShowTimer = 3

	local function CreateNotification(msg, showTimer, clr)
		if hg_furcity:GetBool() or lply.PlayerClassName == "furry" then
			msg = hg.FurrifyPhrase(msg)
		end

		if lply:IsBerserk() then
			return
		end

		for _, tbl in ipairs(hg.notifications) do
			if tbl[1] == msg then
				tbl[2] = CurTime()
				tbl[3] = showTimer or defaultShowTimer
				tbl[4] = clr or Color(255, 255, 255, 255)
				tbl[5] = (tbl[5] or 1) + 1
				return
			end
		end

		table.insert(hg.notifications, {msg, CurTime(), showTimer or defaultShowTimer, clr or Color(255, 255, 255, 255), 1})
	end

	local function CreateNotificationBerserk(msg, showTimer, clr)
		if hg_furcity:GetBool() or lply.PlayerClassName == "furry" then
			msg = hg.FurrifyPhrase(msg) -- uhhhh... hate to break it to you but-
		end

		local tbl = hg.currentNotification

		local clr = tbl and tbl[4] and IsColor(tbl[4]) and tbl[4] or Color(255, 255, 255, 255)
		if tbl and clr and tbl[1] then
			chat.AddText(Color(clr.r, clr.g, clr.b, 255), (last_message or tbl[1]).."\n")
		end

		hg.currentNotification = nil
		hg.notifications = {}

		table.insert(hg.notifications, {msg, CurTime(), showTimer or defaultShowTimer, clr or Color(255, 255, 255, 255), 1})
	end

	local PLAYER = FindMetaTable("Player")

	function PLAYER:Notify(...)
		return CreateNotification(...)
	end

	function PLAYER:NotifyBerserk(...)
		return CreateNotificationBerserk(...)
	end

	net.Receive("HGNotificate",function()
		local msg = net.ReadString()
		local clr = net.ReadColor()

		if msg == "" then return end

		CreateNotification(msg, showtime, clr)
	end)

	net.Receive("HGNotificateBerserk",function()
		local msg = net.ReadString()
		local clr = net.ReadColor()

		if msg == "" then return end

		CreateNotificationBerserk(msg, showtime, clr)
	end)

	local screenMessage
	net.Receive("HGScreenMessage", function()
		screenMessage = {net.ReadString(), net.ReadString(), CurTime()}
	end)

	hg.CreateNotification = CreateNotification
	hg.CreateNotificationBerserk = CreateNotificationBerserk
	local colred = Color(255,0,0)
	local maxDrawNotifications = 6

	local time_spent = CurTime()
	local coloruse = Color(255,255,255,255)
	local function NotificationsThink()
		if #hg.notifications == 0 then return end
		if !lply:Alive() then hg.notifications = {} return end
		for i = #hg.notifications, 1, -1 do
			local tbl = hg.notifications[i]
			if !tbl or tbl[2] + tbl[3] + 1 < CurTime() then table.remove(hg.notifications, i) end
		end
	end

	local colBrown = Color(40,40,40)
	local ColorNotification = Color(48,4,4,0)
	local maxtimefade = 1
	local oldclick = 0

	sound.Add({
		name = "peepsnd",
		channel = CHAN_AUTO,
		volume = 0.5,
		level = 30,
		pitch = {150, 150},
		sound = "snd_jack_peep.wav"
	})

	local last_message
	local last_time

	local vector_one = Vector( 1, 1, 0)

	local bluewhite = Color(187, 187, 255)
	local whiteGlow = Color(255,255,255)
	local redGlow = Color(255,20,20)
	local darkRed = Color(65,0,0)
	local shine = Color(255,255,255)
	local function DrawScreenMessage()
		if not screenMessage then return end
		local msg, kind, start = screenMessage[1], screenMessage[2], screenMessage[3]
		local life = CurTime() - start
		local dur = kind == "death" and 5 or 6
		if life > dur then screenMessage = nil return end

		local fadeIn = math.ease.OutCubic(math.Clamp(life / 0.7, 0, 1))
		local fadeOut = math.ease.InCubic(math.Clamp((dur - life) / 1.1, 0, 1))
		local alpha = 255 * math.min(fadeIn, fadeOut)
		local font = kind == "death" and "HomigradFontGigantoNormous" or "HomigradFontBig"
		local shake = kind == "death" and math.max(0, 8 - life * 1.2) or math.sin(CurTime() * 2) * 1.5
		local x = ScrW() / 2 + math.Rand(-shake, shake)
		local y = ScrH() / 2 + math.Rand(-shake, shake)
		local glow = kind == "death" and redGlow or whiteGlow
		local shadow = kind == "death" and darkRed or color_black
		local lines = kind == "death" and {msg} or {"YOU HAVE BEEN GIVEN A SECOND CHANCE", "BY THE UPPERS"}

		for id, text in ipairs(lines) do
			local lineY = y + (id - (#lines + 1) / 2) * ScreenScale(18)
			for i = 8, 1, -1 do
				glow.a = alpha * (0.045 * i)
				draw.SimpleText(text, font, x, lineY, glow, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end

			shadow.a = alpha
			draw.SimpleTextOutlined(text, font, x, lineY, kind == "death" and Color(255,0,0,alpha) or Color(255,255,255,alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, kind == "death" and 3 or 2, shadow)

			if kind ~= "death" then
				shine.a = alpha * math.Clamp(math.sin((life * 5 + id) % math.pi), 0, 1)
				draw.SimpleText(text, font, x + math.sin(CurTime() * 6 + id) * 3, lineY - 2, shine, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
		end
	end

	local function NotificationsDraw()
		time_spent = CurTime()
		lply = LocalPlayer()
		DrawScreenMessage()
		local org = lply.organism
		if not org or not org.pain or not org.brain then return end
		//if org.otrub and !last_message then return end

		local font = hg.notificationFont
		local start = math.max(#hg.notifications - maxDrawNotifications + 1, 1)
		for i = start, #hg.notifications do
			local tbl = hg.notifications[i]
			local msg, time, timeshow, clr, count = tbl[1], tbl[2], tbl[3], tbl[4], tbl[5] or 1
			local drawMsg = count > 1 and (msg .. " (x" .. count .. ")") or msg
			local fadeIn = math.ease.OutCubic(math.Clamp((time_spent - time) / 0.45, 0, 1))
			local fadeOut = math.ease.InCubic(math.Clamp((time + timeshow + 0.8 - time_spent) / 0.8, 0, 1))
			local alpha = 255 * math.min(fadeIn, fadeOut)

			if alpha > 0 then
				coloruse.r = clr.r
				coloruse.g = math.min(math.Clamp(((90 - org.pain) / 90) * 255, 0, 255), clr.g)
				coloruse.b = math.min(math.Clamp(((90 - org.pain) / 90) * 255, 0, 255), clr.b)
				coloruse.a = alpha
				colBrown.a = alpha

				surface.SetFont(font)
				local txtw, txth = surface.GetTextSize(drawMsg)
				local shake = math.Clamp(1 - (time_spent - time) / (timeshow + 0.8), 0, 1) * 2
				local x, y = ScrW() / 2 - txtw / 2 + math.Rand(-shake, shake), ScrH() - ScrH() / 8 - (#hg.notifications - i) * (txth + 10) + math.Rand(-shake, shake)

				draw.SimpleTextOutlined(drawMsg, font, x, y, coloruse, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1.5, colBrown)
			end
		end
	end

	hook.Add("DrawOverlay", "HGNotificationsThink", NotificationsDraw)
	hook.Add("Think", "HGNotificationsThink", NotificationsThink)
else
	concommand.Add("hg_notify", function(ply, cmd, args)
		if not ply:IsAdmin() then return end
		for i, ply in pairs(player.GetListByName(args[1])) do
			//(ply, msg, delay, msgKey, showTime, func, clr)
			ply:Notify(args[2], 6, nil, 0, nil, Color(args[3] or 255, args[4] or 255, args[5] or 255))
		end
	end)
end
