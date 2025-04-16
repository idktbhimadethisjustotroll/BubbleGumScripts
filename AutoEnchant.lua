-- // GUI Setup
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local ToggleFrame = Instance.new("Frame", ScreenGui)
local OnButton = Instance.new("TextButton", ToggleFrame)
local OffButton = Instance.new("TextButton", ToggleFrame)

ScreenGui.Name = "AutoEnchantGUI"
ToggleFrame.Size = UDim2.new(0, 200, 0, 100)
ToggleFrame.Position = UDim2.new(0, 20, 0, 100)
ToggleFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ToggleFrame.BorderSizePixel = 0

OnButton.Size = UDim2.new(0.5, -5, 1, 0)
OnButton.Position = UDim2.new(0, 0, 0, 0)
OnButton.Text = "ON"
OnButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
OnButton.TextColor3 = Color3.new(1, 1, 1)
OnButton.Font = Enum.Font.SourceSansBold
OnButton.TextSize = 24

OffButton.Size = UDim2.new(0.5, -5, 1, 0)
OffButton.Position = UDim2.new(0.5, 5, 0, 0)
OffButton.Text = "OFF"
OffButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
OffButton.TextColor3 = Color3.new(1, 1, 1)
OffButton.Font = Enum.Font.SourceSansBold
OffButton.TextSize = 24

-- // Functionality
local running = false
local rerollButton = nil
local enchantText = nil  -- We'll use this to detect the enchant type

-- Find the reroll button (adjust this based on the button's location or name)
for _, obj in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
    if obj:IsA("TextButton") and obj.Text == "Reroll All" then  -- Adjust based on actual button text
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

OnButton.MouseButton1Click:Connect(function()
    if running then return end
    running = true
    print("🔄 Auto Enchant Started")

    spawn(function()
        while running do
            -- Simulate button click
            pcall(function()
                rerollButton.MouseButton1Click:Fire()  -- Simulating the click event
            end)

            -- Check if the enchant "Team Up V" is found
            if checkEnchant() then
                running = false  -- Stop the script
                print("🛑 Stopped after obtaining 'Team Up V' enchant.")
                break
            end

            wait(1.5) -- adjust the wait time as needed
        end
    end)
end)

OffButton.MouseButton1Click:Connect(function()
    running = false
    print("🛑 Auto Enchant Stopped")
end)
