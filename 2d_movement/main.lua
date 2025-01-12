function love.load()
    -- Load files
    local windowConfig = require("config")
    local playerConfig = require("player")
    local platformConfig = require("platforms")
    local wf = require("windfield")

    -- Configure window
    Font = love.graphics.newFont("fonts/roboto.ttf", 15, "normal", 10)
    windowConfig.SetWindowSize(640, 480)

    -- Instantiate physics world
    World = wf.newWorld(0, 500)
    World:addCollisionClass("Left_Platform")
    World:addCollisionClass("Right_Platform")

    -- Instantiate platforms
    local lpc = platformConfig.Left_Platform
    local rpc = platformConfig.Right_Platform

    local lp = World:newRectangleCollider(
        lpc.spawnX,
        lpc.spawnY,
        lpc.length,
        lpc.width
    )
    local rp = World:newRectangleCollider(
        rpc.spawnX,
        rpc.spawnY,
        rpc.length,
        rpc.width
    )

    -- Configure platforms
    lp:setType("static")
    lp:setCollisionClass("Left_Platform")
    rp:setType("static")
    rp:setCollisionClass("Right_Platform")

    -- Instantiate player
    Player = playerConfig.Player
    Character = World:newRectangleCollider(
        Player.spawnX,
        Player.spawnY,
        Player.length,
        Player.width
    )

    -- Instantiate score
    CurrentPlatform = -1
    Score = 0
end

function love.update(dt)
    if Character:enter("Left_Platform") then
        CurrentPlatform = -1
        Player.inAir = false
    end

    if Character:enter("Right_Platform") then
        CurrentPlatform = 1
        Player.inAir = false
    end

    if Character:exit("Left_Platform") or Character:exit("Right_Platform") then
        Player.inAir = true
    end

    if love.keyboard.isDown("w") and Player.inAir == false then
        Character:applyLinearImpulse(0, -1000)
    end

    if love.keyboard.isDown("d") then
        Character:applyForce(1000, 0)
    end

    if love.keyboard.isDown("a") then
        Character:applyForce(-1000, 0)
    end

    if CurrentPlatform ~= Player.platform then
        Score = Score + 1
        Player.platform = CurrentPlatform
    end

    World:update(dt)
end

function love.draw()
    love.graphics.print(Score, Font, 290, 40, 0, 10)
    World:draw()
end
