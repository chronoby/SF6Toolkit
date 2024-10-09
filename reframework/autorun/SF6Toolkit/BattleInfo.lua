-- @author: 一拳怪怪
-- https://space.bilibili.com/104493811

local gBattle
local displayJuggleData = false
local changed
local rgba = 0xFF00FF00
local sceneManager = sdk.get_native_singleton("via.SceneManager")
local sceneManagertypedef = sdk.find_type_definition("via.SceneManager")
local mainView = sdk.call_native_func(sceneManager, sceneManagertypedef, "get_MainView")
local windowSize = mainView:call("get_WindowSize")
local w = windowSize.w
local h = windowSize.h

re.on_draw_ui(function()
    if imgui.tree_node("BattleInfo") then
        changed, displayJuggleData = imgui.checkbox("Display Juggle Data", displayJuggleData)
		changed, rgba = imgui.color_edit("Text Color", rgba)
        imgui.tree_pop()    
    end
end)

re.on_frame(function()
    if displayJuggleData ~= false then
        return
    end
    gBattle = sdk.find_type_definition("gBattle")
    if gBattle == nil then
        return
    end

    local sPlayer = gBattle:get_field("Player"):get_data(nil)
    cPlayer = sPlayer.mcPlayer

    if cPlayer[0].pos.x.v == 0.0 then
        return
    end
    
    local p1HitDT = cPlayer[1].pDmgHitDT
	local p2HitDT = cPlayer[0].pDmgHitDT
    
    local p1Juggle = cPlayer[0].combo_dm_air
    local p2Juggle = cPlayer[1].combo_dm_air

	draw.text("Juggle Counter: " .. p1Juggle, 0.1 * w, 0.1 * h, rgba)
	draw.text("Juggle Counter: " .. p2Juggle, 0.8 * w, 0.1 * h, rgba)

    if p1HitDT ~= nil then
        draw.text("JuggleLimit: " .. p1HitDT.JuggleLimit .. "\nJuggleAdd: " .. p1HitDT.JuggleAdd .. "\nJuggle1st: " .. p1HitDT.Juggle1st, 0.25 * w, 0.16 * h, rgba)
    end

    if p2HitDT ~= nil then
        draw.text("JuggleLimit: " .. p2HitDT.JuggleLimit .. "\nJuggleAdd: " .. p2HitDT.JuggleAdd .. "\nJuggle1st: " .. p2HitDT.Juggle1st, 0.68 * w, 0.16 * h, rgba)
    end

end)
