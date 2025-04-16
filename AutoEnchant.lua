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
local rerollRemote = nil

-- Optional: Try to auto-detect remote
for _, v in pairs(getgc(true)) do
    if typeof(v) == "function" and getinfo(v).name == "RerollEnchant" then
        rerollRemote = v
        break
    end
end

-- Fallback (you can set it manually if needed)
-- rerollRemote = game:GetService("ReplicatedStorage"):WaitForChild("RerollEnchant")

OnButton.MouseButton1Click:Connect(function()
    if running or not rerollRemote then return end
    running = true
    print("🔄 Auto Enchant Started")

    spawn(function()
        while running do
            -- This assumes rerolling happens based on currently selected pet
            -- If not, you can modify it to accept a pet ID or name
            pcall(function()
                rerollRemote()
            end)
            wait(1.5) -- adjust if needed
        end
    end)
end)

OffButton.MouseButton1Click:Connect(function()
    running = false
    print("🛑 Auto Enchant Stopped")
end)
