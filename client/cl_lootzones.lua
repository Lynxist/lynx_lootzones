local spawnedProps = {}
local propCounter = 0
local currentZone = ""
local areas = areas or {}
local spawnPoints = spawnPoints or {}

function initializeZones()
    for zoneName, zoneData in pairs(Config.zoneInfo) do
        createZone(zoneName, zoneData)
    end
end

function createZone(zoneName, zoneData)
    local polyInfo = zoneData.polyInfo
    local props = zoneData.props
    local zone

    if polyInfo then
        if polyInfo.type == "box" then
            zone = BoxZone:Create(polyInfo.coords, polyInfo.length, polyInfo.width, {
                name = zoneName,
                heading = polyInfo.heading,
                minZ = polyInfo.minZ,
                maxZ = polyInfo.maxZ,
                debugPoly = polyInfo.debug
            })
        elseif polyInfo.type == "circle" then
            zone = CircleZone:Create(polyInfo.coords, polyInfo.radius, {
                name = zoneName,
                minZ = polyInfo.minZ,
                maxZ = polyInfo.maxZ,
                debugPoly = polyInfo.debug
            })
        elseif polyInfo.type == "custom" then
            zone = PolyZone:Create(polyInfo.coords, {
                name = zoneName,
                minZ = polyInfo.minZ,
                maxZ = polyInfo.maxZ,
                debugPoly = polyInfo.debug
            })
        else
            if Config.enableDebug then
                print("Invalid zone type specified:", polyInfo.type)
            end
            return
        end
    else
        zone = {name = zoneName}
        if Config.enableDebug then
            print("Handling zone without polyInfo:", zoneName)
        end
    end

    areas[zoneName] = zone
    spawnPoints[zoneName] = props

    local function onPointInOut(isPointInside, point, lastPoint)
        if isPointInside then
            if Config.enableDebug then
                print("Entering zone:", zoneName)
            end
            TriggerEvent('lynx_lootzones:requestSpawnProps', zoneName)
        else
            if Config.enableDebug then
                print("Leaving zone:", zoneName)
            end
            TriggerEvent('lynx_lootzones:despawnProps', zoneName)
        end
    end

    if polyInfo then
        zone:onPointInOut(PolyZone.getPlayerPosition, onPointInOut)
    else
        if Config.enableDebug then
            print("Zone doesn't exist:", zoneName)
        end
    end
end

initializeZones()

local function shouldSpawn(chance)
    return math.random() <= chance
end

local function DespawnProps(zoneName)
    local points = spawnPoints[zoneName]
    if not points then
        if Config.enableDebug then
            print("Invalid zone specified for despawning loot")
        end
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
                if Config.enableDebug then
                    print("Prop handle not found or does not exist in game world:", propId)
                end
            end
            point.chosen = false
        end
    end
end

local function shuffleTable(t)
    local n = #t
    while n > 1 do
        local k = math.random(n)
        t[n], t[k] = t[k], t[n]
        n = n - 1
    end
    return t
end

local function SpawnProps(zoneName)
    local points = spawnPoints[zoneName]
    if not points then
        if Config.enableDebug then
            print("Invalid zone specified for spawning loot")
        end
        return
    end

    shuffleTable(points)

    local propsSpawned = 0
    for _, point in pairs(points) do
        if not point.chosen and shouldSpawn(point.spawnChance) then
            if Config.enableMaxProps and propsSpawned >= Config.maxProps then
                break
            end

            local propId = point.prop .. "_" .. point.coords.x .. "_" .. point.coords.y .. "_" .. point.coords.z
            local prop = CreateObject(GetHashKey(point.prop), point.coords.x, point.coords.y, point.coords.z, true, true, true)
            SetEntityHeading(prop, point.coords.w)
            FreezeEntityPosition(prop, true)
            spawnedProps[propId] = prop
            point.chosen = true
            propsSpawned = propsSpawned + 1
        end
    end
end

RegisterNetEvent('lynx_lootzones:requestSpawnProps')
AddEventHandler('lynx_lootzones:requestSpawnProps', function(zoneName)
    if zoneName then
        SpawnProps(zoneName)
    else
        if Config.enableDebug then
            print("No zone name provided")
        end
    end
end)

RegisterNetEvent('lynx_lootzones:despawnProps')
AddEventHandler('lynx_lootzones:despawnProps', function(zoneName)
    if zoneName then
        DespawnProps(zoneName)
    else
        if Config.enableDebug then
            print("No zone name provided")
        end
    end
end)

