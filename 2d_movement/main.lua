function love.load()
	-- Loads data at the beginning of the game
	local wf = require("windfield")
	World = wf.newWorld(0, 500)

	Player = {} -- Set player to an empty table
	Player.x = 200 -- Player x coordinate
	Player.y = 200 -- Player y coordinate
	Player.speed = 10 -- Speed of the player
	Player.inAir = false

	Platform = {}
	Platform.length = 200
	Platform.width = 100

	Character = World:newRectangleCollider(Player.x, Player.y, 50, 50)
	Left_Platform = World:newRectangleCollider(100, 400, Platform.length, Platform.width)
	Right_Platform = World:newRectangleCollider(400, 400, Platform.length, Platform.width)

	Left_Platform:setType("static")
	Right_Platform:setType("static")
end

function love.keypressed(key)
	if key == "w" then
		Character:applyLinearImpulse(0, -1500)
	end
end

function love.update(dt)
	-- Updates every frame (put game logic here)
	-- dt = delta time (time between frame updates)

	if love.keyboard.isDown("d") then
		-- Move to the right
		Character:applyForce(-1000, 0)
	end

	if love.keyboard.isDown("a") then
		-- Move to the left
		Character:applyForce(1000, 0)
	end

	World:update(dt)
end

function love.draw()
	-- Draws objects
	-- love.graphics.circle("line", Player.x, Player.y, 100)
	-- Draw a circle outline to player coordinates
	World:draw()
end
