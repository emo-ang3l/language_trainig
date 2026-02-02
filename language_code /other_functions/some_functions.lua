---
--- Created by alex
--- DateTime: 18.01.2026 14:14
---

function clear_screen()
    os.execute("clear")  -- macOS / Linux
    -- os.execute("cls") -- для Windows раскомментировать
end

function learning(test)
    local cnt = test:count()
    while cnt ~= 0 do
        local eng,rus = test:get_random_pair()
        print(eng .. " ")
        print("Введите первод")
        local check_word = io.read():lower()
        if check_word == rus:lower() then
            cnt = cnt - 1
            print("Nice")
        else
            print("Неправильно")
        end
    end
end

function menu()
    print("Hello, в нашем приложении ты сможешь выучить или повторить слова")
    print("Выбери, что тебе подходит")
    print("═══════════════════════════════════════")
    print("1. Создать новый блок")
    print("2. Повторить имеющиеся блоки")
    print("3. Добавить слова")
    print("4. Выйти")
    print("═══════════════════════════════════════")
    io.write("Ввод -> ")
end