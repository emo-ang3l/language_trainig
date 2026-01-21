---
--- Created by alex
--- DateTime: 18.01.2026 14:17
---

all_blocks = {}

function main()


    menu()


    while true do
        local choice = io.read()
        if choice == "1" then
            print("Create: Введите название блока")
            local name = io.read()
            local new_block = words_array:create(name)
            table.insert(all_blocks, new_block)

            print("Блок «" .. name .. "» успешно создан!\n")
            print("Теперь заполните его словами!!!")
            while true do
                print("1:Заполнить")
                print("2:Закончить")
                local choice = io.read()
                if choice == "1" then
                    print("Введите английское слово")
                    local english = io.read()
                    print("Введите русское слово")
                    local russian = io.read()
                    if english ~= "" and russian ~= "" then
                        new_block:add(english, russian)
                        print("Слово добавлено ✓\n")
                        new_block:show()
                    else
                        print("Оба поля должны быть заполнены!\n")
                    end


                elseif choice == "2" then
                    break
                else
                    print("Введите 1 или 2")
                end
            end
            clear_screen()
            menu()
        end
        if choice == "2" then
            if #all_blocks == 0 then
                print("У тебя пока нет созданных блоков\n")
            else
                print("Доступные блоки для повторения:")
                print("--------------------------------")
                for i, block in ipairs(all_blocks) do
                    print(i .. ". " .. block.name .. " (" .. block:count() .. " слов)")
                    block:show()
                end
                print("--------------------------------\n")

                print("Выбери название блока:")
                local block_name = io.read():match("^%s*(.-)%s*$")  -- убираем лишние пробелы

                local selected_block = nil
                for _, block in ipairs(all_blocks) do
                    if block.name == block_name then
                        selected_block = block
                        break
                    end
                end

                if selected_block then
                    print("Выбран блок: " .. selected_block.name)
                    learning(selected_block)   -- ← передаём объект!
                else
                    print("Блок с названием '" .. block_name .. "' не найден\n")
                end
            end
            clear_screen()
            menu()
        end
        if choice == "3" then
            if #all_blocks == 0 then
                print("У тебя пока нет созданных блоков\n")
            else
                print("Доступные блоки для заполнения:")
                print("--------------------------------")
                for i, block in ipairs(all_blocks) do
                    print(i .. ". " .. block.name .. " (" .. block:count() .. " слов)")
                    block:show()
                end
                print("--------------------------------\n")

                print("Выбери название блока:")
                local block_name = io.read():match("^%s*(.-)%s*$")  -- убираем лишние пробелы

                local selected_block = nil
                for _, block in ipairs(all_blocks) do
                    if block.name == block_name then
                        selected_block = block
                        break
                    end
                end

                if selected_block then
                    print("Выбран блок: " .. selected_block.name)
                    print("Ввеите английское слово")
                    local eng = io.read()
                    print("Ввеите русское слово")
                    local rus = io.read()
                    selected_block:add(eng, rus)   -- ← передаём объект!
                else
                    print("Блок с названием '" .. block_name .. "' не найден\n")
                end
            end

            clear_screen()
            menu()
        end
        if choice == "4" then
            print("Exit")
            break
            clear_screen()
            menu()
        end
    end
end