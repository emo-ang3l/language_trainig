-- main.lua (графическая версия LÖVE)

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

-- Кнопки меню
local buttons = {}
local buttonW, buttonH, buttonRadius = 160, 33, 17
local baseY = 320
local buttonTexts = {"START", "ADD", "lEARN", "EXIT"}
local yOffsets    = {-50, 0, 50, 100}

-- Состояния и данные
local currentState = "menu"
local inputText = ""
local inputField = nil          -- "block_name", "english", "russian"
local currentBlock = nil        -- текущий объект блока
local all_blocks = {}           -- массив объектов блоков

-- ── Класс WordBlock (аналог words_array из твоего кода) ─────────────────────
local WordBlock = {}
WordBlock.__index = WordBlock

function WordBlock:create(name)
    local self = setmetatable({}, WordBlock)
    self.name = name
    self.words = {}  -- { {eng="cat", rus="кошка"}, ... }
    return self
end

function WordBlock:add(eng, rus)
    if eng and rus and eng ~= "" and rus ~= "" then
        table.insert(self.words, {eng = eng, rus = rus})
    end
end

function WordBlock:count()
    return #self.words
end

function WordBlock:show()
    -- для отладки в консоль
    print("Блок: " .. self.name .. " (" .. self:count() .. " слов)")
    for i, w in ipairs(self.words) do
        print("  " .. i .. ". " .. w.eng .. " → " .. w.rus)
    end
end

-- ── Сохранение / загрузка ────────────────────────────────────────────────────
function saveBlocks()
    local t = {}
    for _, block in ipairs(all_blocks) do
        table.insert(t, {
            name = block.name,
            words = block.words
        })
    end
    love.filesystem.write("blocks.lua", "return " .. tableToString(t))
end

function loadBlocks()
    if love.filesystem.getInfo("blocks.lua") then
        local chunk = love.filesystem.load("blocks.lua")
        local data = chunk()
        all_blocks = {}
        for _, d in ipairs(data or {}) do
            local b = WordBlock:create(d.name)
            b.words = d.words or {}
            table.insert(all_blocks, b)
        end
    end
end

function tableToString(t, indent)
    indent = indent or ""
    local s = "{\n"
    for i, v in ipairs(t) do
        s = s .. indent .. "  " .. tableToString(v, indent .. "  ") .. ",\n"
    end
    for k, v in pairs(t) do
        if type(k) ~= "number" then
            local key = type(k) == "string" and "[\"" .. k .. "\"]" or "[" .. tostring(k) .. "]"
            s = s .. indent .. "  " .. key .. " = " .. tableToString(v, indent .. "  ") .. ",\n"
        end
    end
    s = s .. indent .. "}"
    return s
end

function love.load()
    bgImageFile = love.graphics.newImage("include/image/img.png")
    bgImage = love.graphics.newImage("include/image/graph_paper.png")
    fontLogo = love.graphics.newFont("include/fonts/CherryBombOne-Regular.ttf", 30)
    font = love.graphics.newFont("include/fonts/CherryBombOne-Regular.ttf", 35)
    fontMain = love.graphics.newFont("include/fonts/Grandstander-Bold.ttf", 80)

    variables.x = love.graphics.getWidth()
    variables.y = love.graphics.getHeight()

    loadBlocks()

    -- кнопки
    for i, text in ipairs(buttonTexts) do
        local btn = {}
        btn.text = text
        btn.x = math.floor(variables.x / 2 - buttonW / 2)
        btn.y = baseY + yOffsets[i]
        btn.w = buttonW
        btn.h = buttonH
        btn.scale = 1.0
        btn.target = 1.0
        table.insert(buttons, btn)
    end
end

function love.update(dt)
    local mx, my = love.mouse.getPosition()
    local lerpSpeed = 12

    if currentState == "menu" then
        for _, btn in ipairs(buttons) do
            local hovered = mx >= btn.x and mx <= btn.x + btn.w and my >= btn.y and my <= btn.y + btn.h
            btn.target = hovered and 1.14 or 1.0
            btn.scale = btn.scale + (btn.target - btn.scale) * lerpSpeed * dt
        end
    end
end

function love.textinput(t)
    if inputField then
        inputText = inputText .. t
    end
end

function love.keypressed(key)
    if inputField then
        if key == "backspace" then
            inputText = inputText:sub(1, -2)
        elseif key == "return" then
            local trimmed = inputText:match("^%s*(.-)%s*$") or ""
            if trimmed == "" then return end

            if currentState == "create_block" and inputField == "block_name" then
                local exists = false
                for _, b in ipairs(all_blocks) do
                    if b.name == trimmed then exists = true break end
                end
                if not exists then
                    currentBlock = WordBlock:create(trimmed)
                    table.insert(all_blocks, currentBlock)
                    currentState = "fill_block"
                    inputField = "english"
                    inputText = ""
                    saveBlocks()
                end
            elseif currentState == "fill_block" then
                if inputField == "english" then
                    currentWord = trimmed
                    inputText = ""
                    inputField = "russian"
                elseif inputField == "russian" then
                    currentBlock:add(currentWord, trimmed)
                    inputText = ""
                    inputField = "english"
                    currentWord = ""
                    saveBlocks()
                end
            end
        elseif key == "escape" then
            currentState = "menu"
            inputText = ""
            inputField = nil
            currentBlock = nil
            currentWord = ""
            saveBlocks()
        end
    end
end

function love.mousepressed(mx, my, btn)
    if btn ~= 1 then return end

    if currentState == "menu" then
        for _, b in ipairs(buttons) do
            if mx >= b.x and mx <= b.x + b.w and my >= b.y and my <= b.y + b.h then
                if b.text == "START" then
                    currentState = "create_block"
                    inputField = "block_name"
                    inputText = ""
                elseif b.text == "EXIT" then
                    love.event.quit()
                end
            end
        end
    end
end

function love.draw()
    love.graphics.clear(colors.bg)
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(bgImageFile, 12, 0, 0, 0.1, 0.1)
    love.graphics.draw(bgImage, 0, 0, 0, 0.14, 0.14)

    -- логотип
    love.graphics.setFont(fontMain)
    local tw = fontMain:getWidth(variables.textBig)
    local bx = math.floor(variables.x / 2 - tw / 2)
    local by = 100

    love.graphics.setColor(colors.outline)
    for dx = -variables.thickness, variables.thickness do
        for dy = -variables.thickness, variables.thickness do
            if dx ~= 0 or dy ~= 0 then
                love.graphics.print(variables.textBig, bx + dx, by + dy)
            end
        end
    end
    love.graphics.setColor(colors.logo_bottom)
    love.graphics.print(variables.textBig, bx, by)

    love.graphics.setFont(fontLogo)
    tw = fontLogo:getWidth(variables.textSmall)
    bx = math.floor(variables.x / 2 - tw / 2)
    love.graphics.setColor(colors.outline)
    for dx = -variables.thickness, variables.thickness do
        for dy = -variables.thickness, variables.thickness do
            if dx ~= 0 or dy ~= 0 then
                love.graphics.print(variables.textSmall, bx + dx, by + 30 + dy)
            end
        end
    end
    love.graphics.setColor(colors.logo_bottom)
    love.graphics.print(variables.textSmall, bx, by + 30)

    -- кнопки меню
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
            local ty = (btn.h - font:getHeight()) / 2 - 3
            love.graphics.printf(btn.text, 0, ty, btn.w, "center")

            love.graphics.pop()
        end
    end

    -- экраны ввода
    love.graphics.setFont(font)
    love.graphics.setColor(colors.logo_bottom)

    if currentState == "create_block" then
        love.graphics.printf("Название блока:", 0, 260, variables.x, "center")
        love.graphics.printf(inputText .. "_", 0, 300, variables.x, "center")
        love.graphics.printf("Enter — создать   Esc — назад", 0, 350, variables.x, "center")

    elseif currentState == "fill_block" then
        love.graphics.printf("Блок: " .. currentBlock.name, 0, 220, variables.x, "center")

        if inputField == "english" then
            love.graphics.printf("Английское слово:", 0, 260, variables.x, "center")
            love.graphics.printf(inputText .. "_", 0, 300, variables.x, "center")
        elseif inputField == "russian" then
            love.graphics.printf("Русский перевод для \"" .. currentWord .. "\":", 0, 260, variables.x, "center")
            love.graphics.printf(inputText .. "_", 0, 300, variables.x, "center")
        end

        love.graphics.printf("Enter — добавить   Esc — завершить", 0, 350, variables.x, "center")
    end

    -- FPS
    love.graphics.setFont(love.graphics.newFont(16))
    love.graphics.setColor(0.5,0.5,0.5,0.7)
    love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 10)
end

function love.resize(w, h)
    variables.x = w
    variables.y = h
    for i, btn in ipairs(buttons) do
        btn.x = math.floor(w / 2 - buttonW / 2)
        btn.y = baseY + yOffsets[i]
    end
end