---
--- Created by alex
--- DateTime: 18.01.2026 12:36
---

words_array = {}
words_array.__index = words_array

function words_array:create(name)
    local self = setmetatable({}, words_array)
    self.name = name or "Без названия"
    self.words = {}
    return self
end

function words_array:add(english, russian)
    self.words[english:lower()] = russian:lower()
end

function words_array:show()
    print("Блок: " .. self.name)
    if next(self.words) == nil then
        print("    (пока пусто)")
        return
    end

    for eng, rus in pairs(self.words) do
        print("  " .. eng .. " → " .. rus)
    end
end

function words_array:count()
    local count = 0
    for _ in pairs(self.words) do
        count = count + 1
    end
    print(count)
    return count
end

function words_array:get_random_pair()
    local list = {}   -- временный массив

    -- собираем все пары в массив
    for eng, rus in pairs(self.words) do
        table.insert(list, {eng, rus})
    end

    if #list == 0 then
        return nil
    end

    local random_index = math.random(1, #list)
    local pair = list[random_index]

    return pair[1], pair[2]   -- english, russian
end



