fx_version 'adamant'
games {'gta5'}

author 'Lynxist'
description 'Loot Zones'
version '1.0'

ui_page 'html/index.html'

shared_scripts {
  'config.lua'
}

client_scripts {
	'@PolyZone/client.lua',
  '@PolyZone/BoxZone.lua',
  '@PolyZone/EntityZone.lua',
  '@PolyZone/CircleZone.lua',
  '@PolyZone/ComboZone.lua',
	"client/*.lua",
}

server_scripts {
  "server/*.lua",
}

