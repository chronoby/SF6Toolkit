local gBattle
local p1 = {}
local p2 = {}

local display_juggle_data = false
local changed

re.on_draw_ui(function()
    if imgui.tree_node("BattleInfo") then
        changed, display_juggle_data = imgui.checkbox("Display Juggle Data", display_juggle_data)
        imgui.tree_pop()
    end
end)

re.on_frame(function()
    gBattle = sdk.find_type_definition("gBattle")
    if gBattle == nil then
        return
    end

    local sPlayer = gBattle:get_field("Player"):get_data(nil)
    local cPlayer = sPlayer.mcPlayer

    local p1HitDT = cPlayer[1].pDmgHitDT
	local p2HitDT = cPlayer[0].pDmgHitDT
		
    p1.juggle = cPlayer[0].combo_dm_air
    p1.juggleLimit = p1HitDT.JuggleLimit
    p1.juggleAdd = p1HitDT.JuggleAdd
    p1.juggle1st = p1HitDT.Juggle1st

    p2.juggle = cPlayer[1].combo_dm_air
    p2.juggleLimit = p2HitDT.JuggleLimit
    p2.juggleAdd = p2HitDT.JuggleAdd
    p2.juggle1st = p2HitDT.Juggle1st
    
end)