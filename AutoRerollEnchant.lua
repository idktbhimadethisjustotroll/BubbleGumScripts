-- Functionality to Auto-Reroll
local running = false
local rerollButton = nil
local enchantText = nil  -- We'll use this to detect the enchant type

-- Find the reroll button (now searching in PlayerGui instead of ReplicatedStorage)
for _, obj in pairs(game.Players.LocalPlayer.PlayerGui:GetDescendants()) do
    if obj:IsA("TextButton") and obj.Text == "Reroll All" then
        rerollButton = obj
        print("Found Reroll Button!")
        break
    end
end

if not rerollButton then
    warn("Could not find 'Reroll All' button!")
    return
end

-- Find the enchant text (adjust this based on your game's UI)
local function checkEnchant()
    -- You should replace this with the proper method of getting the currently equipped enchant.
    -- Example: Search for a TextLabel or TextButton with the enchantment name.
    enchantText = game:GetService("PlayerGui"):FindFirstChild("EnchantLabel")  -- Change the path as necessary
    if enchantText then
        print("Current enchant: " .. enchantText.Text)  -- Debugging print statement
        if enchantText.Text == "Team Up V" then
            return true  -- Team Up V found, auto-stop
        end
    end
    return false
end

-- Start rerolling automatically when detected
spawn(function()
    while true do
        if rerollButton then
            -- Start rerolling automatically if it's not already running
            if not running then
                running = true
                print("🔄 Auto Reroll Started")

                -- Continue rerolling
                while running do
                    -- Simulate button click more reliably
                    pcall(function()
                        rerollButton:Click()  -- More direct button click simulation
                    end)

                    -- Add a small delay after clicking
                    wait(2)  -- Adjust the wait time as needed to ensure the reroll is triggered

                    -- Stop rerolling when "Team Up V" is found
                    if checkEnchant() then
                        running = false
                        print("🛑 Stopped after obtaining 'Team Up V' enchant.")
                    end

                    wait(1.5)  -- Adjust the wait time as needed
                end
            end
        end

        -- Check if a different pet enchant is selected, restart rerolling if needed
        if not checkEnchant() and running then
            print("🔄 Restarting rerolling because a different pet was selected without 'Team Up V'.")
            running = false
        end

        wait(1)  -- Check every second if rerolling should continue or restart
    end
end)
