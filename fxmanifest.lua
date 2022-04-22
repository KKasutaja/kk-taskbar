-- Fx Data
fx_version   'cerulean'
lua54        'yes'
game         'gta5'

-- Resource Data
name         'kk-taskbar'
version      '1.0.0'
license      'GPL-3.0-or-later'
author       'KKasutaja'
repository   'https://github.com/kkasutaja/kk-taskbar'
description  'Taskbar system for FiveM'

-- Script Files
dependencies {
    'ox_lib'
}

shared_script '@ox_lib/init.lua'

server_script 'server.lua'
client_script 'client.lua'
