local colors = {
    logo_bottom = {0.35, 0.28, 0.22},
    bg          = {0.95, 0.92, 0.85},
    outline     = {0.71, 0.62, 0.49},
}

local font
local fontMain
local bgImage

local variables = {
    x = love.graphics.getWidth(),
    y = love.graphics.getHeight(),
    textBig   = "EMOANG3L",
    textSmall = "LANGUAGE TRAINER",
    thickness = 3,
}

function love.load()

    bgImage = love.graphics.newImage("include/image/graph_paper.png")
    font = love.graphics.newFont("include/fonts/CherryBombOne-Regular.ttf", 24)
    fontMain = love.graphics.newFont("include/fonts/Grandstander-Bold.ttf", 64)

    variables.x = love.graphics.getWidth()
    variables.y = love.graphics.getHeight()
end

function love.draw()
    love.graphics.clear(colors.bg)

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(bgImage, 0, 0, 0,
       0.14,       -- scale X
       0.14    -- scale Y
    )
    love.graphics.setBlendMode("alpha")

    love.graphics.setFont(fontMain)
    local tw_big = fontMain:getWidth(variables.textBig)
    local base_x_big = math.floor(variables.x / 2 - tw_big / 2)
    local base_y_big = 100  -- верхняя позиция (можно подвинуть выше/ниже)


    love.graphics.setColor(colors.outline)
    for dx = -variables.thickness, variables.thickness do
        for dy = -variables.thickness, variables.thickness do
            if dx ~= 0 or dy ~= 0 then
                love.graphics.print(variables.textBig, base_x_big + dx, base_y_big + dy)
            end
        end
    end


    love.graphics.setColor(colors.logo_bottom)
    love.graphics.print(variables.textBig, base_x_big, base_y_big)

    love.graphics.setFont(font)
    local tw_small = font:getWidth(variables.textSmall)
    local base_x_small = math.floor(variables.x / 2 - tw_small / 2)
    local base_y_small = base_y_big + 25

    love.graphics.setColor(colors.outline)
    for dx = -variables.thickness, variables.thickness do
        for dy = -variables.thickness, variables.thickness do
            if dx ~= 0 or dy ~= 0 then
                love.graphics.print(variables.textSmall, base_x_small + dx, base_y_small + dy)
            end
        end
    end

    love.graphics.setColor(colors.logo_bottom)
    love.graphics.print(variables.textSmall, base_x_small, base_y_small)

    love.graphics.setFont(love.graphics.newFont(16))
    love.graphics.setColor(0.5, 0.5, 0.5, 0.7)
    love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 10)
end

function love.resize(w, h)
    variables.x = w
    variables.y = h
end