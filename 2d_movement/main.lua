function love.load()
    _ = love.window.setMode(640, 480)

    local wf = require("windfield")
    World = wf.newWorld(0, 500)
    World:addCollisionClass("Platform")

    Player = {} -- Set player to an empty table
    Player.x = 80 -- Player x coordinate
    Player.y = 350 -- Player y coordinate
    Player.speed = 10 -- Speed of the player
    Player.inAir = true -- Check to see if the charachter is jumping

    Platform = {}
    Platform.length = 100
    Platform.width = 25

    Character = World:newRectangleCollider(Player.x, Player.y, 50, 50)
    Left_Platform =
        World:newRectangleCollider(40, 400, Platform.length, Platform.width)
    Right_Platform =
        World:newRectangleCollider(500, 400, Platform.length, Platform.width)

    Left_Platform:setType("static")
    Left_Platform:setCollisionClass("Platform")
    Right_Platform:setType("static")
    Right_Platform:setCollisionClass("Platform")
end

function love.update(dt)
    if Character:enter("Platform") then
        Player.inAir = false
    end

    if Character:exit("Platform") then
        Player.inAir = true
    end

    if love.keyboard.isDown("w") and Player.inAir == false then
        Character:applyLinearImpulse(0, -1500)
    end

    if love.keyboard.isDown("d") then
        Character:applyForce(1000, 0)
    end

    if love.keyboard.isDown("a") then
        Character:applyForce(-1000, 0)
    end

    World:update(dt)
end

function love.draw()
    World:draw()
end
