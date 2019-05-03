
-- vrp_msgplayer by gEE
-- makes you able as admin to message a player by ID

local reqPermission = "admin.menu" -- which vRP permission should be able to use this (not group)

local Proxy = module("vrp", "lib/Proxy")
local Tunnel = module("vrp", "lib/Tunnel")

vRP = Proxy.getInterface("vRP")

RegisterCommand("msg", function(source, args, ...)
    local s = s
    local target_id = tonumber(args[1])

    if vRP.getUsers({target_id}) then

      local user_id = vRP.getUserId({s})
          if vRP.hasPermission({user_id, reqPermission}) then
              if args[2] and tonumber(target_id) then
                      local target = vRP.getUsers({target_id})
                      local b = ...
                      b = b:gsub("msg "..target_id,"")
                      TriggerClientEvent("pNotify:SendNotification", target ,{text = ({"<center><h1 style='font-family:Segoe UI;'>ADMIN BESKED:<h2 style='font-family:Segoe UI;'>"..b.."<br/>// "..GetPlayerName(s)}), theme = "mint", type = "error", queue = "error", timeout = 20000, layout = "topCenter",animation = {open = "gta_effects_fade_in", close = "gta_effects_fade_out"}})
                      TriggerClientEvent('chatMessage', s, "SYSTEM", {255, 0, 0}, "Besked sendt til ID "..target_id..":\n"..b)
              else
                TriggerClientEvent('chatMessage', s, "SYSTEM", {255, 0, 0}, "Du skal skrive et spiller ID.\n\n /msg [ID] [besked]")
              end
          else
              TriggerClientEvent('chatMessage', s, "SYSTEM", {255, 0, 0}, "Du har ikke adgang til denne kommando.")
          end
    else
        TriggerClientEvent('chatMessage', s, "SYSTEM", {255, 0, 0}, "Spilleren er ikke i byen.")
    end

end)
