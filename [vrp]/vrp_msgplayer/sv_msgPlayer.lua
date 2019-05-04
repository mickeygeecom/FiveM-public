
-- vrp_msgplayer by gEE
-- makes you able as admin to message a player by ID

local reqPermission = "admin.tickets" -- which vRP permission should be able to use this (not group)

local Proxy = module("vrp", "lib/Proxy")
local Tunnel = module("vrp", "lib/Tunnel")

vRP = Proxy.getInterface("vRP")

function sendpNotify(data)
    if data.quickErr then
        TriggerClientEvent("pNotify:SendNotification", data.sovs ,{text = data.besked, theme = "mint", type = "error", queue = "global", timeout = 3000, layout = "bottomRight",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
    elseif data then
        TriggerClientEvent("pNotify:SendNotification", data.sovs ,{text = data.besked, theme = "mint", type = data.type, queue = "global", timeout = data.timeout, layout = data.layout,animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
    end
end

vRP.registerMenuBuilder({"admin", function(add, data)
	local player = data.player
  
	local user_id = vRP.getUserId({player})
	if user_id ~= nil then
	  	local choices = {}
  
		-- user ask id
		if vRP.hasPermission({user_id, "admin.tickets"}) then
            choices["Send Besked"] = {function(player, choice)
                vRP.prompt({player,"Bruger ID: ","", function(player,andet_id)
                    if andet_id and andet_id ~= " " and tonumber(andet_id) then
                        if vRP.getUserSource({tonumber(andet_id)}) then
                            vRP.prompt({player,"Besked: ","", function(player,msg)
                                if msg and msg ~= "" then
                                    local beskedData = {
                                        sovs = vRP.getUserSource({tonumber(andet_id)}),
                                        timeout = 20000,
                                        type = "error",
                                        layout = "topCenter",
                                        besked = "<center><h1 style='font-family:Segoe UI;'>ADMIN BESKED:</h1><h2 style='font-family:Segoe UI;'>"..tostring(msg).."</h2><br/>// "..GetPlayerName(player)
                                    }
                                    local adminData = {
                                        sovs = player,
                                        timeout = 3000,
                                        type = "success",
                                        layout = "bottomRight",
                                        besked = "<h1 style='font-family:Segoe UI;'>Besked sendt til ID "..andet_id.."</h1>"
                                    }
                                    sendpNotify(beskedData)
                                    sendpNotify(adminData)
                                else
                                    sendpNotify({
                                        sovs = player,
                                        quickErr = true,
                                        besked = "<h1 style='font-family:Segoe UI;'>Du skal skrive en besked!</h1>"
                                    })
                                end
                            end})
                        else
                            sendpNotify({
                                sovs = player,
                                quickErr = true,
                                besked = "<h1 style='font-family:Segoe UI;'>Spilleren er desværre ikke i byen!</h1>"
                            })
                        end
                    else
                        sendpNotify({
                            sovs = player,
                            quickErr = true,
                            besked = "<h1 style='font-family:Segoe UI;'>Ugyldigt ID!</h1>"
                        })
                    end
                end})
            end,"Send en besked til en spillers skærm"}
		end

		add(choices)
	end
end})