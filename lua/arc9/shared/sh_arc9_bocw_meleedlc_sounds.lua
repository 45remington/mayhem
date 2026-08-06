--=============================================================================
--   ARC9 CALL OF DUTY: BLACK OPS COLD WAR
--   MELEE DLC
--   SOUNDS MASTER FILE
--[[
 .oooooo..o oooo                  .o8                       oooo                                                                         
d8P'    `Y8 `888                 "888                       `888                                                                         
Y88bo.       888   .ooooo.   .oooo888   .oooooooo  .ooooo.   888 .oo.    .oooo.   ooo. .oo.  .oo.   ooo. .oo.  .oo.    .ooooo.  oooo d8b 
 `"Y8888o.   888  d88' `88b d88' `888  888' `88b  d88' `88b  888P"Y88b  `P  )88b  `888P"Y88bP"Y88b  `888P"Y88bP"Y88b  d88' `88b `888""8P 
     `"Y88b  888  888ooo888 888   888  888   888  888ooo888  888   888   .oP"888   888   888   888   888   888   888  888ooo888  888     
oo     .d8P  888  888    .o 888   888  `88bod8P'  888    .o  888   888  d8(  888   888   888   888   888   888   888  888    .o  888     
8""88888P'  o888o `Y8bod8P' `Y8bod88P" `8oooooo.  `Y8bod8P' o888o o888o `Y888""8o o888o o888o o888o o888o o888o o888o `Y8bod8P' d888b    
                                       d"     YD                                                                                         
                                       "Y88888P'                                                                                         
]]
-- READY FOLEY

sound.Add({
    name = "ARC9_BOCW.Sledgehammer_ready",
    channel = CHAN_AUTO,
    volume = 1.0,
    sound = "weapons/arc9/bocw_sledgehammer/sledgehammer_ready.wav"
})

-- INSPECT FOLEY

sound.Add({
    name = "ARC9_BOCW.Sledgehammer_inspect",
    channel = CHAN_ITEM,
    volume = 1.0,
    sound = "weapons/arc9/bocw_sledgehammer/sledgehammer_inspect.wav"
})

-- MELEE SOUNDS

sound.Add({ -- BLACK OPS COLD WAR
    name = "ARC9_BOCW.Sledgehammer_impact",
    channel = CHAN_AUTO,
    volume = 1.0,
    sound = {"weapons/arc9/bocw_sledgehammer/sledgehammer_impact1.wav", "weapons/arc9/bocw_sledgehammer/sledgehammer_impact2.wav", "weapons/arc9/bocw_sledgehammer/sledgehammer_impact3.wav", "weapons/arc9/bocw_sledgehammer/sledgehammer_impact4.wav"}
})

sound.Add({
    name = "ARC9_BOCW.Sledgehammer_swing",
    channel = CHAN_AUTO,
    volume = 1.0,
    sound = {"weapons/arc9/bocw_sledgehammer/sledgehammer_swing1.wav", "weapons/arc9/bocw_sledgehammer/sledgehammer_swing2.wav", "weapons/arc9/bocw_sledgehammer/sledgehammer_swing3.wav"}
})

sound.Add({
    name = "ARC9_BOCW.Sledgehammer_hit",
    channel = CHAN_AUTO,
    volume = 1.0,
    sound = {"weapons/arc9/bocw_sledgehammer/sledgehammer_hit1.wav", "weapons/arc9/bocw_sledgehammer/sledgehammer_hit2.wav", "weapons/arc9/bocw_sledgehammer/sledgehammer_hit3.wav", "weapons/arc9/bocw_sledgehammer/sledgehammer_hit4.wav"}
})
--[[
oooooo   oooooo     oooo           oooo         o8o                                oooo         o8o  
 `888.    `888.     .8'            `888         `"'                                `888         `"'  
  `888.   .8888.   .8'    .oooo.    888  oooo  oooo    oooooooo  .oooo.    .oooo.o  888 .oo.   oooo  
   `888  .8'`888. .8'    `P  )88b   888 .8P'   `888   d'""7d8P  `P  )88b  d88(  "8  888P"Y88b  `888  
    `888.8'  `888.8'      .oP"888   888888.     888     .d8P'    .oP"888  `"Y88b.   888   888   888  
     `888'    `888'      d8(  888   888 `88b.   888   .d8P'  .P d8(  888  o.  )88b  888   888   888  
      `8'      `8'       `Y888""8o o888o o888o o888o d8888888P  `Y888""8o 8""888P' o888o o888o o888o 
]]
-- READY FOLEY

sound.Add({
    name = "ARC9_BOCW.Wakizashi_ready",
    channel = CHAN_AUTO,
    volume = 1.0,
    sound = "weapons/arc9/bocw_wakizashi/wakizashi_ready.wav"
})

-- INSPECT FOLEY

sound.Add({
    name = "ARC9_BOCW.Wakizashi_inspect",
    channel = CHAN_ITEM,
    volume = 1.0,
    sound = "weapons/arc9/bocw_wakizashi/wakizashi_inspect.wav"
})

-- MELEE SOUNDS

sound.Add({
    name = "ARC9_BOCW.Wakizashi_swing",
    channel = CHAN_AUTO,
    volume = 1.0,
    sound = {"weapons/arc9/bocw_wakizashi/wakizashi_swing1.wav", "weapons/arc9/bocw_wakizashi/wakizashi_swing2.wav", "weapons/arc9/bocw_wakizashi/wakizashi_swing3.wav"}
})
--[[
oooooooooooo         ooooooooooooo                     oooo  
`888'     `8         8'   888   `8                     `888  
 888                      888       .ooooo.   .ooooo.   888  
 888oooo8                 888      d88' `88b d88' `88b  888  
 888    "    8888888      888      888   888 888   888  888  
 888       o              888      888   888 888   888  888  
o888ooooood8             o888o     `Y8bod8P' `Y8bod8P' o888o 
]]
-- READY FOLEY

sound.Add({
    name = "ARC9_BOCW.ETool_ready",
    channel = CHAN_AUTO,
    volume = 1.0,
    sound = "weapons/arc9/bocw_etool/etool_ready.wav"
})

-- INSPECT FOLEY

sound.Add({
    name = "ARC9_BOCW.ETool_inspect",
    channel = CHAN_ITEM,
    volume = 1.0,
    sound = "weapons/arc9/bocw_etool/etool_inspect.wav"
})

-- MELEE SOUNDS

sound.Add({
    name = "ARC9_BOCW.ETool_swing",
    channel = CHAN_AUTO,
    volume = 1.0,
    sound = {"weapons/arc9/bocw_etool/etool_swing1.wav", "weapons/arc9/bocw_etool/etool_swing2.wav", "weapons/arc9/bocw_etool/etool_swing3.wav"}
})
--[[
ooo        ooooo                     oooo                      .             
`88.       .888'                     `888                    .o8             
 888b     d'888   .oooo.    .ooooo.   888 .oo.    .ooooo.  .o888oo  .ooooo.  
 8 Y88. .P  888  `P  )88b  d88' `"Y8  888P"Y88b  d88' `88b   888   d88' `88b 
 8  `888'   888   .oP"888  888        888   888  888ooo888   888   888ooo888 
 8    Y     888  d8(  888  888   .o8  888   888  888    .o   888 . 888    .o 
o8o        o888o `Y888""8o `Y8bod8P' o888o o888o `Y8bod8P'   "888" `Y8bod8P' 
]]
-- READY FOLEY

sound.Add({
    name = "ARC9_BOCW.Machete_ready",
    channel = CHAN_AUTO,
    volume = 1.0,
    sound = "weapons/arc9/bocw_machete/machete_ready.wav"
})

-- INSPECT FOLEY

sound.Add({
    name = "ARC9_BOCW.Machete_inspect",
    channel = CHAN_ITEM,
    volume = 1.0,
    sound = "weapons/arc9/bocw_machete/machete_inspect.wav"
})

-- MELEE SOUNDS

sound.Add({
    name = "ARC9_BOCW.Machete_swing",
    channel = CHAN_AUTO,
    volume = 1.0,
    sound = {"weapons/arc9/bocw_machete/machete_swing1.wav", "weapons/arc9/bocw_machete/machete_swing2.wav", "weapons/arc9/bocw_machete/machete_swing3.wav", "weapons/arc9/bocw_machete/machete_swing4.wav", "weapons/arc9/bocw_machete/machete_swing5.wav"}
})
--[[
oooooooooo.                                .o8                 oooo  oooo     oooooooooo.                .   
`888'   `Y8b                              "888                 `888  `888     `888'   `Y8b             .o8   
 888     888  .oooo.    .oooo.o  .ooooo.   888oooo.   .oooo.    888   888      888     888  .oooo.   .o888oo 
 888oooo888' `P  )88b  d88(  "8 d88' `88b  d88' `88b `P  )88b   888   888      888oooo888' `P  )88b    888   
 888    `88b  .oP"888  `"Y88b.  888ooo888  888   888  .oP"888   888   888      888    `88b  .oP"888    888   
 888    .88P d8(  888  o.  )88b 888    .o  888   888 d8(  888   888   888      888    .88P d8(  888    888 . 
o888bood8P'  `Y888""8o 8""888P' `Y8bod8P'  `Y8bod8P' `Y888""8o o888o o888o    o888bood8P'  `Y888""8o   "888" 
]]
-- READY FOLEY

sound.Add({
    name = "ARC9_BOCW.BaseballBat_ready",
    channel = CHAN_AUTO,
    volume = 1.0,
    sound = "weapons/arc9/bocw_baseballbat/baseballbat_ready.wav"
})

-- INSPECT FOLEY

sound.Add({
    name = "ARC9_BOCW.BaseballBat_inspect",
    channel = CHAN_ITEM,
    volume = 1.0,
    sound = {"weapons/arc9/bocw_baseballbat/baseballbat_inspect1.wav","weapons/arc9/bocw_baseballbat/baseballbat_inspect2.wav"}
})

-- MELEE SOUNDS

sound.Add({ -- BLACK OPS COLD WAR
    name = "ARC9_BOCW.BaseballBat_impact",
    channel = CHAN_AUTO,
    volume = 1.0,
    sound = {"weapons/arc9/bocw_baseballbat/baseballbat_impact1.wav", "weapons/arc9/bocw_baseballbat/baseballbat_impact2.wav"}
})

sound.Add({
    name = "ARC9_BOCW.BaseballBat_hit",
    channel = CHAN_AUTO,
    volume = 1.0,
    sound = {"weapons/arc9/bocw_baseballbat/baseballbat_hit1.wav", "weapons/arc9/bocw_baseballbat/baseballbat_hit2.wav"}
})
--[[
ooo        ooooo                               
`88.       .888'                               
 888b     d'888   .oooo.    .ooooo.   .ooooo.  
 8 Y88. .P  888  `P  )88b  d88' `"Y8 d88' `88b 
 8  `888'   888   .oP"888  888       888ooo888 
 8    Y     888  d8(  888  888   .o8 888    .o 
o8o        o888o `Y888""8o `Y8bod8P' `Y8bod8P' 
]]
-- READY FOLEY

sound.Add({
    name = "ARC9_BOCW.Mace_ready",
    channel = CHAN_AUTO,
    volume = 1.0,
    sound = "weapons/arc9/bocw_mace/mace_ready.wav"
})
sound.Add({
    name = "ARC9_BOCW.Mace_ready_end",
    channel = CHAN_AUTO,
    volume = 1.0,
    sound = "weapons/arc9/bocw_mace/mace_ready_end.wav"
})

-- INSPECT FOLEY

sound.Add({
    name = "ARC9_BOCW.Mace_inspect",
    channel = CHAN_ITEM,
    volume = 1.0,
    sound = "weapons/arc9/bocw_mace/mace_inspect.wav"
})

-- MELEE SOUNDS

sound.Add({
    name = "ARC9_BOCW.Mace_swing",
    channel = CHAN_AUTO,
    volume = 1.0,
    sound = {"weapons/arc9/bocw_mace/mace_swing1.wav", "weapons/arc9/bocw_mace/mace_swing2.wav", "weapons/arc9/bocw_mace/mace_swing3.wav"}
})
--[[
  .oooooo.                                   
 d8P'  `Y8b                                  
888           .oooo.   ooo. .oo.    .ooooo.  
888          `P  )88b  `888P"Y88b  d88' `88b 
888           .oP"888   888   888  888ooo888 
`88b    ooo  d8(  888   888   888  888    .o 
 `Y8bood8P'  `Y888""8o o888o o888o `Y8bod8P' 
]]
-- READY FOLEY

sound.Add({
    name = "ARC9_BOCW.Cane_ready",
    channel = CHAN_AUTO,
    volume = 1.0,
    sound = "weapons/arc9/bocw_cane/cane_ready.wav"
})

-- INSPECT FOLEY

sound.Add({
    name = "ARC9_BOCW.Cane_inspect",
    channel = CHAN_ITEM,
    volume = 1.0,
    sound = "weapons/arc9/bocw_cane/cane_inspect.wav"
})

-- MELEE SOUNDS

sound.Add({
    name = "ARC9_BOCW.Cane_swing",
    channel = CHAN_AUTO,
    volume = 1.0,
    sound = {"weapons/arc9/bocw_cane/cane_swing1.wav", "weapons/arc9/bocw_cane/cane_swing2.wav", "weapons/arc9/bocw_cane/cane_swing3.wav"}
})
--[[
 .oooooo..o            o8o  
d8P'    `Y8            `"'  
Y88bo.       .oooo.   oooo  
 `"Y8888o.  `P  )88b  `888  
     `"Y88b  .oP"888   888  
oo     .d8P d8(  888   888  
8""88888P'  `Y888""8o o888o 
]]
-- READY FOLEY

sound.Add({
    name = "ARC9_BOCW.Sai_ready",
    channel = CHAN_AUTO,
    volume = 1.0,
    sound = "weapons/arc9/bocw_sai/sai_ready.wav"
})

-- INSPECT FOLEY

sound.Add({
    name = "ARC9_BOCW.Sai_inspect",
    channel = CHAN_ITEM,
    volume = 1.0,
    sound = "weapons/arc9/bocw_sai/sai_inspect.wav"
})

-- MELEE SOUNDS

sound.Add({
    name = "ARC9_BOCW.Sai_swing",
    channel = CHAN_AUTO,
    volume = 1.0,
    sound = {"weapons/arc9/bocw_sai/sai_swing1.wav", "weapons/arc9/bocw_sai/sai_swing2.wav", "weapons/arc9/bocw_sai/sai_swing3.wav"}
})
--[[
oooooooooo.                .       .   oooo                     .o.                             
`888'   `Y8b             .o8     .o8   `888                    .888.                            
 888     888  .oooo.   .o888oo .o888oo  888   .ooooo.         .8"888.     oooo    ooo  .ooooo.  
 888oooo888' `P  )88b    888     888    888  d88' `88b       .8' `888.     `88b..8P'  d88' `88b 
 888    `88b  .oP"888    888     888    888  888ooo888      .88ooo8888.      Y888'    888ooo888 
 888    .88P d8(  888    888 .   888 .  888  888    .o     .8'     `888.   .o8"'88b   888    .o 
o888bood8P'  `Y888""8o   "888"   "888" o888o `Y8bod8P'    o88o     o8888o o88'   888o `Y8bod8P' 
]]
-- READY FOLEY

sound.Add({
    name = "ARC9_BOCW.BattleAxe_ready",
    channel = CHAN_AUTO,
    volume = 1.0,
    sound = "weapons/arc9/bocw_battleaxe/battleaxe_ready.wav"
})

-- INSPECT FOLEY

sound.Add({
    name = "ARC9_BOCW.BattleAxe_inspect",
    channel = CHAN_ITEM,
    volume = 1.0,
    sound = "weapons/arc9/bocw_battleaxe/battleaxe_inspect.wav"
})
--[[
ooooo   ooooo                                                                                                 .o8      .oooooo..o  o8o            oooo        oooo            
`888'   `888'                                                                                                "888     d8P'    `Y8  `"'            `888        `888            
 888     888   .oooo.   ooo. .oo.  .oo.   ooo. .oo.  .oo.    .ooooo.  oooo d8b     .oooo.   ooo. .oo.    .oooo888     Y88bo.      oooo   .ooooo.   888  oooo   888   .ooooo.  
 888ooooo888  `P  )88b  `888P"Y88bP"Y88b  `888P"Y88bP"Y88b  d88' `88b `888""8P    `P  )88b  `888P"Y88b  d88' `888      `"Y8888o.  `888  d88' `"Y8  888 .8P'    888  d88' `88b 
 888     888   .oP"888   888   888   888   888   888   888  888ooo888  888         .oP"888   888   888  888   888          `"Y88b  888  888        888888.     888  888ooo888 
 888     888  d8(  888   888   888   888   888   888   888  888    .o  888        d8(  888   888   888  888   888     oo     .d8P  888  888   .o8  888 `88b.   888  888    .o 
o888o   o888o `Y888""8o o888o o888o o888o o888o o888o o888o `Y8bod8P' d888b       `Y888""8o o888o o888o `Y8bod88P"    8""88888P'  o888o `Y8bod8P' o888o o888o o888o `Y8bod8P' 
]]
-- READY FOLEY

sound.Add({
    name = "ARC9_BOCW.HammerandSickle_ready",
    channel = CHAN_AUTO,
    volume = 1.0,
    sound = "weapons/arc9/bocw_hammerandsickle/hammerandsickle_ready.wav"
})

-- INSPECT FOLEY

sound.Add({
    name = "ARC9_BOCW.HammerandSickle_inspect",
    channel = CHAN_ITEM,
    volume = 1.0,
    sound = "weapons/arc9/bocw_hammerandsickle/hammerandsickle_inspect.wav"
})
--[[
 .oooooo..o                           .   oooo                  
d8P'    `Y8                         .o8   `888                  
Y88bo.       .ooooo.  oooo    ooo .o888oo  888 .oo.    .ooooo.  
 `"Y8888o.  d88' `"Y8  `88.  .8'    888    888P"Y88b  d88' `88b 
     `"Y88b 888         `88..8'     888    888   888  888ooo888 
oo     .d8P 888   .o8    `888'      888 .  888   888  888    .o 
8""88888P'  `Y8bod8P'     .8'       "888" o888o o888o `Y8bod8P' 
                      .o..P'                                    
                      `Y8P'                                     
]]
-- READY FOLEY

sound.Add({
    name = "ARC9_BOCW.Scythe_ready",
    channel = CHAN_AUTO,
    volume = 1.0,
    sound = "weapons/arc9/bocw_scythe/scythe_ready.wav"
})

-- INSPECT FOLEY

sound.Add({
    name = "ARC9_BOCW.Scythe_inspect",
    channel = CHAN_ITEM,
    volume = 1.0,
    sound = "weapons/arc9/bocw_scythe/scythe_inspect.wav"
})

-- MELEE SOUNDS

sound.Add({
    name = "ARC9_BOCW.Scythe_swing",
    channel = CHAN_AUTO,
    volume = 1.0,
    sound = {"weapons/arc9/bocw_scythe/scythe_swing1.wav", "weapons/arc9/bocw_scythe/scythe_swing2.wav", "weapons/arc9/bocw_scythe/scythe_swing3.wav"}
})