-- Workout Mechanics Module

local WorkoutMechanics = {}

-- Player attributes
local playerAttributes = {}

-- Initialize player attributes
function WorkoutMechanics:init(player)
    playerAttributes[player] = {
        energy = 100,
        strength = 10,
        workoutCooldown = 0
    }
end

-- Fast workout function
function WorkoutMechanics:fastWorkout(player)
    local attributes = playerAttributes[player]
    if attributes.energy >= 20 and attributes.workoutCooldown <= 0 then
        attributes.energy = attributes.energy - 20
        attributes.strength = attributes.strength + 5
        attributes.workoutCooldown = 60 -- 1 minute cooldown
        return true, attributes.energy, attributes.strength
    end
    return false, attributes.energy, attributes.strength
end

-- Regenerate energy over time
function WorkoutMechanics:regenerateEnergy(player)
    local attributes = playerAttributes[player]
    if attributes.energy < 100 then
        attributes.energy = math.min(attributes.energy + 1, 100)
    end
    return attributes.energy
end

-- Update cooldown
function WorkoutMechanics:updateCooldown(player, deltaTime)
    local attributes = playerAttributes[player]
    if attributes.workoutCooldown > 0 then
        attributes.workoutCooldown = math.max(attributes.workoutCooldown - deltaTime, 0)
    end
    return attributes.workoutCooldown
end

return WorkoutMechanics