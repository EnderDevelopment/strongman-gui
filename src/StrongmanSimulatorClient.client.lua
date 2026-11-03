-- Strongman Simulator Client Script

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui"):WaitForChild("StrongmanSimulatorGUI")
local mainFrame = playerGui:WaitForChild("MainFrame")

local scoreLabel = mainFrame:WaitForChild("ScoreLabel")
local energyLabel = mainFrame:WaitForChild("EnergyLabel")
local strengthLabel = mainFrame:WaitForChild("StrengthLabel")

local remoteEvent = ReplicatedStorage:WaitForChild("StrongmanSimulatorEvent")

-- Handle server events
remoteEvent.OnClientEvent:Connect(function(eventName, ...)
    if eventName == "UpdateScore" then
        local score = ...
        scoreLabel.Text = "Score: " .. score
    elseif eventName == "UpdateAttributes" then
        local energy, strength = ...
        energyLabel.Text = "Energy: " .. energy
        strengthLabel.Text = "Strength: " .. strength
    end
end)

-- Connect button click events
mainFrame.StartButton.MouseButton1Click:Connect(function()
    remoteEvent:FireServer("StartGame")
end)

mainFrame.WorkoutButton.MouseButton1Click:Connect(function()
    remoteEvent:FireServer("FastWorkout")
end)