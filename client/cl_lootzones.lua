local spawnedProps = {} -- Maintain a table to store spawned prop objects
local propCounter = 0
local currentZone = ""

local spawnPoints = {
    pinkcage = { 
        {prop = "prop_crate_01a", coords = vector4(322.33526611328, -210.83268737793, 54.086536407471, 224.94067382812), chosen = false, spawnChance = 1.0},
        {prop = "v_serv_cupboard_01", coords = vector4(327.33526611328, -210.83268737793, 54.086536407471, 224.94067382812), chosen = false, spawnChance = 1.0},
        {prop = "prop_train_ticket_02_tu", coords = vector4(323.36032104492, -205.75762939453, 54.086322784424, 68.03759765625), chosen = false, spawnChance = 1.0},
    },

    worldarea = {
        {prop = "prop_cash_case_01", coords = vector4(-45.943393707275, -165.50543212891, 66.561706542969, 226.62448120117), chosen = false, spawnChance = 0.1},
        {prop = "prop_crate_01a", coords = vector4(-54.092948913574, -174.2557220459, 66.561706542969, 142.97152709961), chosen = false, spawnChance = 0.5},
        {prop = "prop_crate_01a", coords = vector4(-51.563987731934, -163.8840637207, 66.736236572266, 343.08126831055), chosen = false, spawnChance = 0.5},
        {prop = "prop_crate_01a", coords = vector4(-48.955211639404, -156.32258605957, 66.598159790039, 340.71911621094), chosen = false, spawnChance = 0.5},
        {prop = "prop_crate_01a", coords = vector4(-35.740436553955, -160.94538879395, 66.598159790039, 340.71911621094), chosen = false, spawnChance = 0.5},
        {prop = "prop_crate_01a", coords = vector4(-42.969047546387, -171.74176025391, 66.904670715332, 145.04943847656), chosen = false, spawnChance = 0.5},
        {prop = "prop_crate_01a", coords = vector4(-51.276672363281, -172.12446594238, 66.65673828125, 73.47420501709), chosen = false, spawnChance = 0.5},
        {prop = "prop_cash_case_01", coords = vector4(-45.943393707275, -165.50543212891, 66.561706542969, 226.62448120117), chosen = false, spawnChance = 0.1}, 
    },

    missionrow = {
        {prop = "prop_cash_case_01", coords = vector4(458.42364501953, -992.88220214844, 43.691463470459, 263.6877746582), chosen = false, spawnChance = 0.5},
        {prop = "prop_cash_case_01", coords = vector4(442.86968994141, -983.97711181641, 43.691650390625, 61.178001403809), chosen = false, spawnChance = 0.5},
    },

    chickenplant = {
        {prop = "bkr_prop_coke_boxeddoll", coords = vector4(-76.128, 6219.421, 30.102, 147.0), chosen = false, spawnChance = 1.0},
        {prop = "bkr_prop_coke_boxeddoll", coords = vector4(-85.904365539551, 6215.7670898438, 31.090082168579, 314.98208618164), chosen = false, spawnChance = 1.0},
        {prop = "bkr_prop_coke_boxeddoll", coords = vector4(-102.6345672607422, 6190.6005859375, 31.90433120727539, -133.42002868652344), chosen = false, spawnChance = 1.0},
        {prop = "bkr_prop_coke_boxeddoll", coords = vector4(-112.2668914794922, 6178.49658203125, 30.01919555664062, -101.42002868652344), chosen = false, spawnChance = 1.0},
        {prop = "bkr_prop_coke_boxeddoll", coords = vector4(-130.60897827148438, 6168.27978515625, 30.01354026794433, -13.42002868652344), chosen = false, spawnChance = 1.0},
    },

    PaletoSafeZone = {
        {prop = "bkr_prop_coke_boxeddoll", coords = vector4(1509.5487060546875, 6325.36279296875, 24.068452835083, -175.3), chosen = false, spawnChance = 1.0},
        {prop = "vw_prop_vw_board_01a", coords = vector4(1508.7353515625, 6343.1484375, 22.933725357056, 22.1842956543), chosen = false, spawnChance = 1.0},
    },

    GrapeSeedLootZone = {
        {prop = "bkr_prop_coke_boxeddoll", coords = vector4(1952.5942382812, 4652.87890625, 39.658634185791, 341.07217407227), chosen = false, spawnChance = 1.0},
        {prop = "bkr_prop_coke_boxeddoll", coords = vector4(1969.0178222656, 4640.6796875, 39.829086303711, 290.73147583008), chosen = false, spawnChance = 1.0},
        {prop = "v_res_fa_shoebox2", coords = vector4(1944.6500244141, 4652.4501953125, 39.611148834229, 75.693099975586), chosen = false, spawnChance = 1.0},
        {prop = "v_res_fa_shoebox2", coords = vector4(1967.9176025391, 4645.3686523438, 39.887943267822, 66.193382263184), chosen = false, spawnChance = 1.0},
        {prop = "v_res_fa_shoebox2", coords = vector4(1973.6225585938, 4647.55078125, 40.045841217041, 284.46197509766), chosen = false, spawnChance = 1.0},
        {prop = "v_res_fa_shoebox2", coords = vector4(1958.2059326172, 4642.3012695312, 39.691436767578, 102.35152435303), chosen = false, spawnChance = 1.0},
    }
}

local pinkCageZone = PolyZone:Create({
    vector2(328.41662597656, -189.42219543457),
    vector2(347.90512084961, -196.81504821777),
    vector2(336.11190795898, -227.95924377441),
    vector2(306.11798095703, -216.42715454102),
    vector2(314.41293334961, -194.19380187988),
    vector2(324.84567260742, -198.19834899902)
}, {
    name="pinkcage",
    minZ=51.0,
    maxZ=62.0,
    debugGrid=false,
    gridDivisions=25
})

local worldAreaZone = BoxZone:Create(vector3(-44.357936859131, -169.36659240723, 66.561767578125), 25.0, 25.0, {
    name="worldarea",
    offset={0.0, 0.0, 0.0},
    scale={1.0, 1.0, 1.0},
    debugPoly=false,
})

local missionRowZone = BoxZone:Create(vector3(449.82775878906, -987.00140380859, 43.69165802002), 25.0, 25.0, {
    name="missionrow",
    offset={0.0, 0.0, 0.0},
    scale={1.0, 1.0, 1.0},
    debugPoly=false,
})

local chickenplant = BoxZone:Create(vector3(-119.05735778809, 6202.3295898438, 37.756645202637), 50.0, 300.0, {
    name="chickenplant",
    heading = 221.3296661377,
    offset={0.0, 0.0, 0.0},
    scale={1.0, 1.0, 1.0},
    debugPoly=false,
})

local GrapeSeedLootZone = BoxZone:Create(vector3(1950.2634277344, 4652.6635742188, 40.59928894043), 50.0, 50.0, {
    name="GrapeSeedLootZone",
    minZ = 38.0,
    maxZ = 42.0,
    heading = 231.10426330566,
    offset={0.0, 0.0, 0.0},
    scale={1.0, 1.0, 1.0},
    debugPoly=false,
})

local areas = {
    pinkcage = pinkCageZone,
    worldarea = worldAreaZone,
    missionrow = missionRowZone,
    chickenplant = chickenplant,
    PaletoSafeZone = PaletoSafeZone,
    GrapeSeedLootZone = GrapeSeedLootZone
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