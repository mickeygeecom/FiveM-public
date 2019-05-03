
-- Release by gEE
-- github: https://github.com/mickeygeecom/FiveM-public

dependency "vrp"
dependency "pNotify"

client_scripts{
  'lib/Proxy.lua',
  'lib/Tunnel.lua',
}

server_scripts{
  '@vrp/lib/utils.lua',
  'sv_msgPlayer.lua'
}

--[[
        ______ ______
       |  ____|  ____|
   __ _| |__  | |__
  / _` |  __| |  __|
 | (_| | |____| |____
  \__, |______|______|
   __/ |
  |___/
  ]]
