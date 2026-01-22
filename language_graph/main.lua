local colors = {
    logo_bottom = {0.35, 0.28, 0.22},
    bg          = {0.95, 0.92, 0.85},
    outline     = {0.71, 0.62, 0.49},
}

local font
local fontMain
local bgImage
local bgImageFile

local variables = {
    x = love.graphics.getWidth(),
    y = love.graphics.getHeight(),
    textBig   = "EMOANG3L",
    textSmall = "LANGUAGE TRAINER",
    thickness = 3,
}

function love.load()
    bgImageFile = love.graphics.newImage("include/image/img.png")
    bgImage = love.graphics.newImage("include/image/graph_paper.png")
    font = love.graphics.newFont("include/fonts/CherryBombOne-Regular.ttf", 24)
    fontMain = love.graphics.newFont("include/fonts/Grandstander-Bold.ttf", 64)

    variables.x = love.graphics.getWidth()
    variables.y = love.graphics.getHeight()
end

function love.draw()
    love.graphics.clear(colors.bg)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(bgImageFile, 12, 0, 0, 0.1, 0.1)




    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(bgImage, 0, 0, 0,
       0.14,       -- scale X
       0.14    -- scale Y
    )

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



    --плашки
    local radius = 26
    local pw = 150                  -- ширина плашки
    local ph = 40               -- высота плашки
    local px = math.floor(variables.x / 2 - pw / 2)   -- центр по горизонтали
    local py = 320


    love.graphics.setColor(colors.outline, 1)     -- тёмно-коричневый / твой стиль
    love.graphics.rectangle("fill", px, py, pw, ph, radius, radius)

    -- Обводка
    love.graphics.setLineWidth(5)                   -- толщина 4–8 обычно хорошо
    love.graphics.setColor(colors.logo_bottom, 1)       -- золотисто-жёлтая
    love.graphics.rectangle("line", px, py, pw, ph, radius, radius)

    -- Текст внутри плашки
    love.graphics.setFont(font)                     -- или fontMain, если хочешь крупнее
    love.graphics.setColor(colors.logo_bottom)        -- светлый текст
    love.graphics.printf(
        "ADD",
        px,                                     -- левая граница = левая граница плашки
        py + (ph - font:getHeight()) / 2,       -- вертикально по центру плашки
        pw,                                     -- ширина области = ширина плашки
        "center"
    )
--
    love.graphics.setColor(colors.outline, 1)     -- тёмно-коричневый / твой стиль
    love.graphics.rectangle("fill", px, py+60, pw, ph, radius, radius)

    -- Обводка
    love.graphics.setLineWidth(5)                   -- толщина 4–8 обычно хорошо
    love.graphics.setColor(colors.logo_bottom, 1)       -- золотисто-жёлтая
    love.graphics.rectangle("line", px, py+60, pw, ph, radius, radius)

    -- Текст внутри плашки
    love.graphics.setFont(font)                     -- или fontMain, если хочешь крупнее
    love.graphics.setColor(colors.logo_bottom)        -- светлый текст
    love.graphics.printf(
        "lEARN",
        px,                                     -- левая граница = левая граница плашки
        py + 60 + (ph - font:getHeight()) / 2,       -- вертикально по центру плашки
        pw,                                     -- ширина области = ширина плашки
        "center"
    )

    love.graphics.setColor(colors.outline, 1)     -- тёмно-коричневый / твой стиль
    love.graphics.rectangle("fill", px, py - 60, pw, ph, radius, radius)

    -- Обводка
    love.graphics.setLineWidth(5)                   -- толщина 4–8 обычно хорошо
    love.graphics.setColor(colors.logo_bottom, 1)       -- золотисто-жёлтая
    love.graphics.rectangle("line", px, py - 60, pw, ph, radius, radius)

    -- Текст внутри плашки
    love.graphics.setFont(font)                     -- или fontMain, если хочешь крупнее
    love.graphics.setColor(colors.logo_bottom)        -- светлый текст
    love.graphics.printf(
        "START",
        px,                                     -- левая граница = левая граница плашки
        py - 60 + (ph - font:getHeight()) / 2,       -- вертикально по центру плашки
        pw,                                     -- ширина области = ширина плашки
        "center"
    )
    love.graphics.setColor(colors.outline, 1)     -- тёмно-коричневый / твой стиль
    love.graphics.rectangle("fill", px, py + 120, pw, ph, radius, radius)

    -- Обводка
    love.graphics.setLineWidth(5)                   -- толщина 4–8 обычно хорошо
    love.graphics.setColor(colors.logo_bottom, 1)       -- золотисто-жёлтая
    love.graphics.rectangle("line", px, py + 120, pw, ph, radius, radius)

    -- Текст внутри плашки
    love.graphics.setFont(font)                     -- или fontMain, если хочешь крупнее
    love.graphics.setColor(colors.logo_bottom)        -- светлый текст
    love.graphics.printf(
        "EXIT",
        px,                                     -- левая граница = левая граница плашки
        py + 120 + (ph - font:getHeight()) / 2,       -- вертикально по центру плашки
        pw,                                     -- ширина области = ширина плашки
        "center"
    )

    love.graphics.setFont(love.graphics.newFont(16))
    love.graphics.setColor(0.5, 0.5, 0.5, 0.7)
    love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 10)
end

function love.resize(w, h)
    variables.x = w
    variables.y = h
end