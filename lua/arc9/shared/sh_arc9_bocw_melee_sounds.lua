--=============================================================================
--   ARC9 CALL OF DUTY: BLACK OPS COLD WAR
--   MELEE
--   SOUNDS MASTER FILE
--[[
oooo    oooo              o8o   .o88o.           
`888   .8P'               `"'   888 `"           
 888  d8'    ooo. .oo.   oooo  o888oo   .ooooo.  
 88888[      `888P"Y88b  `888   888    d88' `88b 
 888`88b.     888   888   888   888    888ooo888 
 888  `88b.   888   888   888   888    888    .o 
o888o  o888o o888o o888o o888o o888o   `Y8bod8P' 
]]
-- READY FOLEY

sound.Add({
    name = "ARC9_BOCW.Knife_ready",
    channel = CHAN_AUTO,
    volume = 1.0,
    sound = {"weapons/arc9/bocw_knife/knife_ready1.wav", "weapons/arc9/bocw_knife/knife_ready2.wav"}
})

-- INSPECT FOLEY

sound.Add({
    name = "ARC9_BOCW.Knife_inspect",
    channel = CHAN_ITEM,
    volume = 1.0,
    sound = "weapons/arc9/bocw_knife/knife_inspect.wav"
})

-- PULLOUT PUTAWAY

sound.Add({
    name = "ARC9_BOCW.Knife_draw",
    channel = CHAN_AUTO,
    volume = 1.0,
    sound = "weapons/arc9/bocw_knife/knife_draw.wav"
})

sound.Add({
    name = "ARC9_BOCW.Knife_holster",
    channel = CHAN_AUTO,
    volume = 1.0,
    sound = "weapons/arc9/bocw_knife/knife_holster.wav"
})

-- FIRING SOUNDS

sound.Add({ -- BLACK OPS COLD WAR
    name = "ARC9_BOCW.Knife_impact",
    channel = CHAN_AUTO,
    volume = 1.0,
    sound = {"weapons/arc9/bocw_knife/knife_impact1.wav", "weapons/arc9/bocw_knife/knife_impact2.wav", "weapons/arc9/bocw_knife/knife_impact3.wav"}
})

sound.Add({
    name = "ARC9_BOCW.Knife_stab",
    channel = CHAN_AUTO,
    volume = 1.0,
    sound = {"weapons/arc9/bocw_knife/knife_stab1.wav", "weapons/arc9/bocw_knife/knife_stab2.wav", "weapons/arc9/bocw_knife/knife_stab3.wav", "weapons/arc9/bocw_knife/knife_stab4.wav"}
})