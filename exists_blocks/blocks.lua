---
--- Created by alex
--- DateTime: 18.01.2026 14:19
---


-- Добавь это перед вызовом main()
function create_default_blocks()
    if #all_blocks > 0 then return end  -- уже есть блоки — не создаём

    basic = words_array:create("Базовый уровень")
    basic:add("hello", "привет")
    basic:add("goodbye", "пока")
    basic:add("thank you", "спасибо")
    basic:add("please", "пожалуйста")
    basic:add("yes", "да")
    table.insert(all_blocks, basic)

    food = words_array:create("Еда и напитки")
    food:add("apple", "яблоко")
    food:add("water", "вода")
    food:add("bread", "хлеб")
    food:add("coffee", "кофе")
    food:add("milk", "молоко")
    table.insert(all_blocks, food)

    travel = words_array:create("Путешествия")
    travel:add("hotel", "отель")
    travel:add("ticket", "билет")
    travel:add("airport", "аэропорт")
    travel:add("passport", "паспорт")
    table.insert(all_blocks, travel)

    print("Созданы 3 готовых блока с базовыми словами!")
end

