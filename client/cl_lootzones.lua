local spawnedProps = {} -- Maintain a table to store spawned prop objects
local propCounter = 0
local currentZone = ""

local spawnPoints = {
    
    exampleArea1 = { -- spawnChance = 1.0 will spawn the items 100% of the time so you can set your individual chance of each one spawning 
        {prop = "prop_cash_case_01", coords = vector4(331.70751953125, -215.68487548828, 54.086318969727, 228.74983215332), chosen = false, spawnChance = 0.1},
        {prop = "prop_crate_01a", coords = vector4(335.28161621094, -209.70533752441, 54.086318969727, 326.85119628906), chosen = false, spawnChance = 0.5},
        {prop = "prop_crate_01a", coords = vector4(331.86953735352, -206.45750427246, 54.086315155029, 42.112773895264), chosen = false, spawnChance = 0.5},
        {prop = "prop_crate_01a", coords = vector4(324.82968139648, -207.65657043457, 54.086307525635, 95.828804016113), chosen = false, spawnChance = 0.5},
        {prop = "prop_crate_01a", coords = vector4(320.1201171875, -213.07258605957, 54.087089538574, 132.46125793457), chosen = false, spawnChance = 0.5},
        {prop = "prop_crate_01a", coords = vector4(315.1311340332, -204.4298248291, 54.086311340332, 31.616144180298), chosen = false, spawnChance = 0.5},
        {prop = "prop_crate_01a", coords = vector4(309.53094482422, -217.14372253418, 58.014095306396, 154.29228210449), chosen = false, spawnChance = 0.5},
        {prop = "prop_cash_case_01", coords = vector4(314.20846557617, -218.64999389648, 58.019229888916, 250.05809020996), chosen = false, spawnChance = 0.1}, 
    },

    exampleArea2 = {
        {prop = "prop_cash_case_01", coords = vector4(-463.82418823242, -53.164043426514, 43.515449523926, 333.9384765625), chosen = false, spawnChance = 0.5},
        {prop = "prop_cash_case_01", coords = vector4(-468.12646484375, -60.379241943359, 43.5133934021, 144.77444458008), chosen = false, spawnChance = 0.5},
    },

}

local exampleArea1Zone = BoxZone:Create(vector3(323.33282470703, -214.51341247559, 54.08618927002), 25.0, 25.0, { -- 25.0, 25.0 is length and width of the box zone adjust to your needs, i'd suggest making it 2x or 3x bigger than the area you're spawning just so items do appear out of nowhere
    name="exampleArea1",
    heading = 336.55322265625,
    minZ = 52.08618927002,
    maxZ = 59.08618927002,
    debugPoly=false,
})

local exampleArea2Zone = BoxZone:Create(vector3(-468.06741333008, -56.979221343994, 44.513347625732), 25.0, 25.0, {
    name="exampleArea2",
    heading = 55.118343353271,
    minZ = 42.513347625732,
    maxZ = 46.513347625732,
    debugPoly=false,
})

local areas = {
    exampleArea1 = exampleArea1Zone,
    exampleArea2 = exampleArea2Zone,
}

RegisterNetEvent('lynx_lootzones:spawnPropsInPaletoSafeZone')
AddEventHandler('lynx_lootzones:spawnPropsInPaletoSafeZone', function()
    TriggerEvent('requestSpawnProps', 'PaletoSafeZone')
end)

RegisterNetEvent('lynx_lootzones:despawnPropsInPaletoSafeZone')
AddEventHandler('lynx_lootzones:despawnPropsInPaletoSafeZone', function()
    TriggerEvent('despawnProps', 'PaletoSafeZone')
end)

RegisterCommand('zzone', function()
    print(currentZone)
end)

local function shouldSpawn(chance)
    return math.random() <= chance
end

-- Citizen.CreateThread(function()
--     while true do
--         local plyPed = PlayerPedId()
--         local coord = GetEntityCoords(plyPed)
        
--         for zoneName, polyZone in pairs(areas) do
--             if polyZone:isPointInside(coord) then
--                 TriggerEvent('requestSpawnProps', zoneName)
--             end
--         end
        
--         Citizen.Wait(500)
--     end
-- end)

Citizen.CreateThread(function()
    while true do
        local plyPed = PlayerPedId()
        local coord = GetEntityCoords(plyPed)
        local newZone = ""

        for zoneName, polyZone in pairs(areas) do
            if polyZone:isPointInside(coord) then
                newZone = zoneName
                break
            end
        end

        if newZone ~= currentZone then
            if currentZone ~= "" then
                print("Leaving zone:", currentZone)
                TriggerEvent('despawnProps', currentZone)
            end

            if newZone ~= "" then
                print("Entering zone:", newZone)
                TriggerEvent('requestSpawnProps', newZone)
            end

            currentZone = newZone
        end

        Citizen.Wait(500)
    end
end)


local function DespawnProps(zoneName)
    local points = spawnPoints[zoneName]
    if not points then
        print("Invalid zone specified for despawning loot")
        return
    end

    for _, point in pairs(points) do
        if point.chosen then
            local propId = point.prop .. "_" .. point.coords.x .. "_" .. point.coords.y .. "_" .. point.coords.z
            local propHandle = spawnedProps[propId]
            if propHandle and DoesEntityExist(propHandle) then
                DeleteEntity(propHandle)
                spawnedProps[propId] = nil
            else
                print("Prop handle not found or does not exist in game world:", propId)
            end
            point.chosen = false
        end
    end
end

local function SpawnProps(zoneName)
    local points = spawnPoints[zoneName]
    if not points then
        print("Invalid zone specified for spawning loot")
        return
    end

    for _, point in pairs(points) do
        if not point.chosen and shouldSpawn(point.spawnChance) then
            local propId = point.prop .. "_" .. point.coords.x .. "_" .. point.coords.y .. "_" .. point.coords.z
            local prop = CreateObject(GetHashKey(point.prop), point.coords.x, point.coords.y, point.coords.z, true, true, true)
            SetEntityHeading(prop, point.coords.w)
            FreezeEntityPosition(prop, true)
            spawnedProps[propId] = prop
            point.chosen = true
        end
    end
end

RegisterNetEvent('requestSpawnProps')
AddEventHandler('requestSpawnProps', function(areaName)
    if areaName then
        SpawnProps(areaName)
    end
end)

RegisterNetEvent('despawnProps')
AddEventHandler('despawnProps', function(areaName)
    if areaName then
        DespawnProps(areaName)
    end
end)