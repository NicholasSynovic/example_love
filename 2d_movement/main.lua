function love.load()
    -- Loads data at the beginning of the game
    local wf = require 'windfield'
    World = wf.newWorld()

    Player= {} -- Set player to an empty table
    Player.x = 200  -- Player x coordinate
    Player.y = 200  -- Player y coordinate
    Player.speed = 10   -- Speed of the player

    Character = World:newRectangleCollider(Player.x, Player.y, 50, 50)
end

function love.update(dt)
    -- Updates every frame (put game logic here)
    -- dt = delta time (time between frame updates)
    if love.keyboard.isDown("d") then
        -- Move to the right
        Player.x = Player.x + Player.speed
    end
    
    if love.keyboard.isDown("a") then
        -- Move to the left
        Player.x = Player.x - Player.speed
    end
    
    if love.keyboard.isDown("w") then
        -- Move up
        Player.y = Player.y - Player.speed
    end
    
    if love.keyboard.isDown("s") then
        -- Move down
        Player.y = Player.y + Player.speed
    end

    World:update(dt)
end

function love.draw()
    -- Draws objects
    -- love.graphics.circle("line", Player.x, Player.y, 100)
    -- Draw a circle outline to player coordinates
    World:draw()
end
