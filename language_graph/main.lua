local colors = {
    logo_bottom = {0.35, 0.28, 0.22},
    bg          = {0.95, 0.92, 0.85},
    outline     = {0.71, 0.62, 0.49},
}


local font, fontLogo, fontMain
local bgImage, bgImageFile

local variables = {
    x = love.graphics.getWidth(),
    y = love.graphics.getHeight(),
    textBig   = "EMOANG3L",
    textSmall = "LANGUAGE TRAINER",
    thickness = 3,
}

local currentState = "menu"
local inputText = ""

-- ── Кнопки ───────────────────────────────────────────────
local buttons = {}
local buttonW = 160
local buttonH = 33
local buttonRadius = 17
local baseY = 320
local spacing = 50

local buttonTexts = {"START", "ADD", "lEARN", "EXIT"}
local yOffsets = {-50, 0, 50, 100}   -- порядок как в твоём коде

function love.load()
    bgImageFile = love.graphics.newImage("include/image/img.png")
    bgImage     = love.graphics.newImage("include/image/graph_paper.png")


    fontLogo = love.graphics.newFont("include/fonts/CherryBombOne-Regular.ttf", 30)
    font     = love.graphics.newFont("include/fonts/CherryBombOne-Regular.ttf", 35)
    fontMain = love.graphics.newFont("include/fonts/Grandstander-Bold.ttf", 80)

    variables.x = love.graphics.getWidth()
    variables.y = love.graphics.getHeight()

    -- Создаём кнопки один раз
    for i, text in ipairs(buttonTexts) do
        local btn = {}
        btn.text     = text
        btn.x        = math.floor(variables.x / 2 - buttonW / 2)
        btn.y        = baseY + yOffsets[i]
        btn.w        = buttonW
        btn.h        = buttonH
        btn.scale    = 1.0
        btn.target   = 1.0
        table.insert(buttons, btn)
    end
end

function love.update(dt)
    local mx, my = love.mouse.getPosition()
    local lerpSpeed = 12   -- 8–15 — комфортный диапазон

    for _, btn in ipairs(buttons) do
        -- наведение?
        if mx >= btn.x and mx <= btn.x + btn.w and
           my >= btn.y and my <= btn.y + btn.h then
            btn.target = 1.14     -- можно 1.12, 1.15, 1.2 — поэкспериментируй
        else
            btn.target = 1.0
        end

        -- плавный переход
        btn.scale = btn.scale + (btn.target - btn.scale) * lerpSpeed * dt
    end
end

function love.draw()
    love.graphics.clear(colors.bg)
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(bgImageFile, 12, 0, 0, 0.1, 0.1)

    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(bgImage, 0, 0, 0, 0.14, 0.14)

    -- Логотип всегда виден (можно убрать, если хочешь чистый экран ввода)
    love.graphics.setFont(fontMain)
    local tw_big = fontMain:getWidth(variables.textBig)
    local bx = math.floor(variables.x / 2 - tw_big / 2)
    local by = 100

    love.graphics.setColor(colors.outline)
    for dx = -variables.thickness, variables.thickness, 1 do
        for dy = -variables.thickness, variables.thickness, 1 do
            if dx ~= 0 or dy ~= 0 then
                love.graphics.print(variables.textBig, bx + dx, by + dy)
            end
        end
    end
    love.graphics.setColor(colors.logo_bottom)
    love.graphics.print(variables.textBig, bx, by)

    love.graphics.setFont(fontLogo)
    local tw_small = fontLogo:getWidth(variables.textSmall)
    local bx_small = math.floor(variables.x / 2 - tw_small / 2)
    local by_small = by + 30

    love.graphics.setColor(colors.outline)
    for dx = -variables.thickness, variables.thickness, 1 do
        for dy = -variables.thickness, variables.thickness, 1 do
            if dx ~= 0 or dy ~= 0 then
                love.graphics.print(variables.textSmall, bx_small + dx, by_small + dy)
            end
        end
    end
    love.graphics.setColor(colors.logo_bottom)
    love.graphics.print(variables.textSmall, bx_small, by_small)

    -- Кнопки только в меню
    if currentState == "menu" then
        love.graphics.setFont(font)
        for _, btn in ipairs(buttons) do
            love.graphics.push()
            love.graphics.translate(btn.x + btn.w/2, btn.y + btn.h/2)
            love.graphics.scale(btn.scale, btn.scale)
            love.graphics.translate(-btn.w/2, -btn.h/2)

            love.graphics.setColor(colors.outline)
            love.graphics.rectangle("fill", 0, 0, btn.w, btn.h, buttonRadius, buttonRadius)

            love.graphics.setLineWidth(3)
            love.graphics.setColor(colors.logo_bottom)
            love.graphics.rectangle("line", 0, 0, btn.w, btn.h, buttonRadius, buttonRadius)

            love.graphics.setColor(colors.logo_bottom)
            local textY = (btn.h - font:getHeight()) / 2 - 3
            love.graphics.printf(btn.text, 0, textY, btn.w, "center")

            love.graphics.pop()
        end
    end

    -- Экран ввода названия блока (START)
    if currentState == "create_block" then
        love.graphics.setFont(font)
        love.graphics.setColor(colors.logo_bottom)

        local prompt = "Enter deck name: " .. inputText .. "_"
        love.graphics.printf(prompt, 0, 300, variables.x, "center")

        love.graphics.printf("Press Enter to confirm, Esc to cancel",
                             0, 350, variables.x, "center")
    end

    -- FPS
    love.graphics.setFont(love.graphics.newFont(16))
    love.graphics.setColor(0.5,0.5,0.5,0.7)
    love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 10)
end

function love.resize(w, h)
    variables.x = w
    variables.y = h

    -- обновляем позиции кнопок при изменении окна
    for i, btn in ipairs(buttons) do
        btn.x = math.floor(w / 2 - buttonW / 2)
        btn.y = baseY + yOffsets[i]
    end
end

function love.mousepressed(mx, my, button)
    if button ~= 1 then return end   -- реагируем только на левую кнопку мыши
    if currentState == "menu" then
        for _, btn in ipairs(buttons) do
            -- проверяем, попал ли клик внутрь прямоугольника кнопки
            if mx >= btn.x and mx <= btn.x + btn.w and
               my >= btn.y and my <= btn.y + btn.h then

                if btn.text == "START" then
                    currentState = "create_block"
                end
                if btn.text == "ADD" then
                    love.event.quit()          -- ← закрываем игру
                end
                if btn.text == "LEARN" then
                    love.event.quit()          -- ← закрываем игру
                end
                if btn.text == "EXIT" then
                    love.event.quit()          -- ← закрываем игру
                end
            end
        end
    end
end

--функция тескта---------------------------
function love.textinput(t)
    if currentState == "create_block" then
        inputText = inputText .. t
    end
end

function love.keypressed(key)
    if currentState == "create_block" then
        if key == "backspace" then
            inputText = inputText:sub(1, -2)   -- удаляем последний символ
        elseif key == "return" then
            if inputText ~= "" then
                -- здесь позже создадим блок
                print("Создан блок: " .. inputText)   -- пока просто вывод в консоль
                currentState = "menu"                 -- возвращаемся в меню
                inputText = ""
            end
        elseif key == "escape" then
            currentState = "menu"
            inputText = ""
        end
    end
end

