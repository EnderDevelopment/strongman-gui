-- Strongman Simulator GUI

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Create a new GUI for each player
local function createGUI(player)
    local playerGui = Instance.new("ScreenGui")
    playerGui.Name = "StrongmanSimulatorGUI"
    playerGui.Parent = player:WaitForChild("PlayerGui")

    -- Create main frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 300, 0, 200)
    mainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
    mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    mainFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    mainFrame.Parent = playerGui

    -- Create title label
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "TitleLabel"
    titleLabel.Size = UDim2.new(1, 0, 0, 30)
    titleLabel.Position = UDim2.new(0, 0, 0, 0)
    titleLabel.Text = "Strongman Simulator"
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextScaled = true
    titleLabel.Parent = mainFrame

    -- Create start button
    local startButton = Instance.new("TextButton")
    startButton.Name = "StartButton"
    startButton.Size = UDim2.new(0.8, 0, 0, 40)
    startButton.Position = UDim2.new(0.1, 0, 0.3, 0)
    startButton.Text = "Start Game"
    startButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    startButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
    startButton.Parent = mainFrame

    -- Create score label
    local scoreLabel = Instance.new("TextLabel")
    scoreLabel.Name = "ScoreLabel"
    scoreLabel.Size = UDim2.new(0.8, 0, 0, 30)
    scoreLabel.Position = UDim2.new(0.1, 0, 0.6, 0)
    scoreLabel.Text = "Score: 0"
    scoreLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    scoreLabel.BackgroundTransparency = 1
    scoreLabel.TextScaled = true
    scoreLabel.Parent = mainFrame

    -- Create energy label
    local energyLabel = Instance.new("TextLabel")
    energyLabel.Name = "EnergyLabel"
    energyLabel.Size = UDim2.new(0.8, 0, 0, 30)
    energyLabel.Position = UDim2.new(0.1, 0, 0.7, 0)
    energyLabel.Text = "Energy: 100"
    energyLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    energyLabel.BackgroundTransparency = 1
    energyLabel.TextScaled = true
    energyLabel.Parent = mainFrame

    -- Create strength label
    local strengthLabel = Instance.new("TextLabel")
    strengthLabel.Name = "StrengthLabel"
    strengthLabel.Size = UDim2.new(0.8, 0, 0, 30)
    strengthLabel.Position = UDim2.new(0.1, 0, 0.8, 0)
    strengthLabel.Text = "Strength: 10"
    strengthLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    strengthLabel.BackgroundTransparency = 1
    strengthLabel.TextScaled = true
    strengthLabel.Parent = mainFrame

    -- Create workout button
    local workoutButton = Instance.new("TextButton")
    workoutButton.Name = "WorkoutButton"
    workoutButton.Size = UDim2.new(0.8, 0, 0, 40)
    workoutButton.Position = UDim2.new(0.1, 0, 0.4, 0)
    workoutButton.Text = "Fast Workout"
    workoutButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    workoutButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
    workoutButton.Parent = mainFrame

    -- Create remote event for communication
    local remoteEvent = Instance.new("RemoteEvent")
    remoteEvent.Name = "StrongmanSimulatorEvent"
    remoteEvent.Parent = ReplicatedStorage

    -- Handle client events
    remoteEvent.OnServerEvent:Connect(function(player, eventName, ...)
        local StrongmanSimulatorLogic = require(script.Parent.StrongmanSimulatorLogic)
        StrongmanSimulatorLogic:init(player)

        if eventName == "StartGame" then
            StrongmanSimulatorLogic:startGame()
        elseif eventName == "FastWorkout" then
            local success, energy, strength = StrongmanSimulatorLogic:fastWorkout()
            if success then
                remoteEvent:FireClient(player, "UpdateAttributes", energy, strength)
            end
        end
    end)
end

-- Create GUI for each player when they join
Players.PlayerAdded:Connect(createGUI)