appId = "940840855957291018"
device = require("api.spec.devicepreset").pc
require("api.spec.mouse")
if device.noclick then
    if device.console then
        mouse.device="stick"
    else
        mouse.device="touch"
    end
else
    mouse.device="mouse"
end
if device.padonly then
    joymode = true
end
joysticks = love.joystick.getJoysticks()[1]
---@diagnostic disable-next-line: undefined-field
function love.load()
    require("api.mathutil")
    if not device.console then
        discordRPC = require("api.3rd.discordRPC")
        lume = require("api.3rd.lume")
        lurker = require("api.3rd.lurker")
        require("api.3rd.donut")
        donut = Donut.init(10, 10)
        fps = donut.add("FPS")
        xdebug=donut.add("X")
        ydebug=donut.add("Y")
    end
    joymode = device.padonly
    for i = 1,2 do
        math.randomseed(os.time());math.random();math.random();math.random()
    end
    mapx=50000
    mapy=50000
    require("loadapi")
    loading=true
    title=true
    fulltogg=true
    local devtf=""
    if device.device=="3DS" then
        devtf = "t3x"
    else
        devtf = "png"
    end
    titleimg = love.graphics.newImage("res/factoryicn."..devtf)
    crtkeypress=true
    if not device.console then
    discordRPC.initialize(appId, true)
    gameversionstr = "Alpha 7 EXPERIMENT"
    detl = "detail will added soon..."
    presencetitle = {
        state = "In Titlescreen",
        details = "Waiting for game to start",
        largeImageKey = "500icon",
        largeImageText= gameversionstr,
        smallImageKey = "titlescreen",
        smallImageText = "cannot load detail"
    }
    presencegame = {
        state = "Playing Game",
        details = "Singleplayer",
        largeImageKey = "500icon",
        largeImageText= gameversionstr,
        smallImageKey = detl
    }

    nextPresenceUpdate = 0
    discordRPC.ready = function (userId, username, discriminator, avatar)
        print(string.format("Discord: ready (%s, %s, %s, %s)", userId, username, discriminator, avatar))
    end
    discordRPC.disconnected = function(errorCode, message)
        print(string.format("Discord: disconnected (%d: %s)", errorCode, message))
    end
    
    discordRPC.errored = function(errorCode, message)
        print(string.format("Discord: error (%d: %s)", errorCode, message))
    end
    
    discordRPC.joinGame = function(joinSecret)
        print(string.format("Discord: join (%s)", joinSecret))
    end
    
    discordRPC.spectateGame = function(spectateSecret)
        print(string.format("Discord: spectate (%s)", spectateSecret))
    end
    
    discordRPC.joinRequest = function(userId, username, discriminator, avatar)
        print(string.format("Discord: join request (%s, %s, %s, %s)", userId, username, discriminator, avatar))
        discordRPC.respond(userId, "yes")
    end
end
    loadergame()
    require("Asys")
end
function love.quit()
    if not device.console then
        discordRPC.shutdown()
    end
end