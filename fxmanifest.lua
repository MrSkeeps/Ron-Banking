fx_version 'bodacious'

games { 'gta5' }

client_scripts {

    'config.lua',

    'client.lua'

}

server_script '@mysql-async/lib/MySQL.lua'

server_script 'server.lua'

server_export 'updateLast'

ui_page 'ui/index.html'

files {
    
    'ui/*'
    
}