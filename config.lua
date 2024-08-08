Config = Config or {}

Config.maxProps = 10 -- Maximum amount of props that will spawn per zone
Config.enableMaxProps = false -- true = enable maxProps limit / false = disables limit
Config.enableDebug = false -- true = enable debug messages / false = disable debug messages
Config.polyDebug = false -- true = enable poly debug / false = disable poly debug

-- EXAMPLE ZONES, CHANGE TO WHAT YOU NEED
Config.zoneInfo = {
    pinkcage = {
        polyInfo = {
            type = "custom", -- "circle" or "rectangle" or "custom", custom is for custom polygon using vector2 coords
            coords = {
                vector2(328.41662597656, -189.42219543457),
                vector2(347.90512084961, -196.81504821777),
                vector2(336.11190795898, -227.95924377441),
                vector2(306.11798095703, -216.42715454102),
                vector2(314.41293334961, -194.19380187988),
                vector2(324.84567260742, -198.19834899902)
            },
            maxZ = 62.086536407471, -- Maximum Z value for the zone
            minZ = 51.086536407471, -- Minimum Z value for the zone
            debug = Config.polyDebug,
        },
        props = {
            {prop = "prop_crate_01a", coords = vector4(322.33526611328, -210.83268737793, 54.086536407471, 224.94067382812), chosen = false, spawnChance = 1.0},
            {prop = "v_serv_cupboard_01", coords = vector4(327.33526611328, -210.83268737793, 54.086536407471, 224.94067382812), chosen = false, spawnChance = 1.0},
            {prop = "prop_train_ticket_02_tu", coords = vector4(323.36032104492, -205.75762939453, 54.086322784424, 68.03759765625), chosen = false, spawnChance = 1.0},
        },
    },
    worldarea = {
        polyInfo = {
            type = "box",
            coords = vector3(-44.357936859131, -169.36659240723, 66.561767578125),
            length = 25.0,
            width = 25.0,
            heading = 0.0,
            maxZ = 68.561767578125,
            minZ = 64.561767578125,
            debug = Config.polyDebug,
        },
        props = {
            {prop = "prop_cash_case_01", coords = vector4(-45.943393707275, -165.50543212891, 66.561706542969, 226.62448120117), chosen = false, spawnChance = 1.0},
            {prop = "prop_crate_01a", coords = vector4(-54.092948913574, -174.2557220459, 66.561706542969, 142.97152709961), chosen = false, spawnChance = 1.0},
            {prop = "prop_crate_01a", coords = vector4(-51.563987731934, -163.8840637207, 66.736236572266, 343.08126831055), chosen = false, spawnChance = 1.0},
            {prop = "prop_crate_01a", coords = vector4(-48.955211639404, -156.32258605957, 66.598159790039, 340.71911621094), chosen = false, spawnChance = 1.0},
            {prop = "prop_crate_01a", coords = vector4(-35.740436553955, -160.94538879395, 66.598159790039, 340.71911621094), chosen = false, spawnChance = 1.0},
            {prop = "prop_crate_01a", coords = vector4(-42.969047546387, -171.74176025391, 66.904670715332, 145.04943847656), chosen = false, spawnChance = 1.0},
            {prop = "prop_crate_01a", coords = vector4(-51.276672363281, -172.12446594238, 66.65673828125, 73.47420501709), chosen = false, spawnChance = 1.0},
            {prop = "prop_cash_case_01", coords = vector4(-42.802783966064, -172.82273864746, 70.330757141113, 339.75759887695), chosen = false, spawnChance = 1.0}, 
            {prop = "prop_cash_case_01", coords = vector4(-47.028030395508, -175.66624450684, 66.561714172363, 89.168090820312), chosen = false, spawnChance = 1.0}, 
            {prop = "prop_cash_case_01", coords = vector4(-40.041213989258, -157.06262207031, 66.561813354492, 343.48522949219), chosen = false, spawnChance = 1.0}, 
            {prop = "prop_cash_case_01", coords = vector4(-50.349967956543, -153.84161376953, 66.561798095703, 48.796199798584), chosen = false, spawnChance = 1.0}, 
        },
    },
    missionrow = {
        polyInfo = {
            type = "box",
            coords = vector3(441.0, -982.0, 30.0),
            length = 25.0,
            width = 25.0,
            heading = 0.0,
            maxZ = 35.0,
            minZ = 25.0,
            debug = Config.polyDebug,
        },
        props = {
            {prop = "prop_cash_case_01", coords = vector4(458.42364501953, -992.88220214844, 43.691463470459, 263.6877746582), chosen = false, spawnChance = 0.5},
            {prop = "prop_cash_case_01", coords = vector4(442.86968994141, -983.97711181641, 43.691650390625, 61.178001403809), chosen = false, spawnChance = 0.5},
        },
    },
    CircleZone = {
        polyInfo = {
            type = "circle",
            coords = vector3(-158.44511413574, -269.76025390625, 81.630805969238),
            radius = 10.0,
            maxZ = 10.0,
            minZ = 0.0,
            debug = Config.polyDebug,
        },
        props = {
            {prop = "vw_prop_vw_board_01a", coords = vector4(-158.44511413574, -269.76025390625, 81.630805969238), chosen = false, spawnChance = 1.0},
        },
    },
    GrapeSeedLootZone = {
        polyInfo = {
            type = "box",
            coords = vector3(1696.0, 4920.0, 30.0),
            length = 25.0,
            width = 25.0,
            heading = 0.0,
            maxZ = 35.0,
            minZ = 25.0,
            debug = Config.polyDebug,
        },
        props = {
            {prop = "bkr_prop_coke_boxeddoll", coords = vector4(1952.5942382812, 4652.87890625, 39.658634185791, 341.07217407227), chosen = false, spawnChance = 1.0},
            {prop = "bkr_prop_coke_boxeddoll", coords = vector4(1969.0178222656, 4640.6796875, 39.829086303711, 290.73147583008), chosen = false, spawnChance = 1.0},
            {prop = "v_res_fa_shoebox2", coords = vector4(1944.6500244141, 4652.4501953125, 39.611148834229, 75.693099975586), chosen = false, spawnChance = 1.0},
            {prop = "v_res_fa_shoebox2", coords = vector4(1967.9176025391, 4645.3686523438, 39.887943267822, 66.193382263184), chosen = false, spawnChance = 1.0},
            {prop = "v_res_fa_shoebox2", coords = vector4(1973.6225585938, 4647.55078125, 40.045841217041, 284.46197509766), chosen = false, spawnChance = 1.0},
            {prop = "v_res_fa_shoebox2", coords = vector4(1958.2059326172, 4642.3012695312, 39.691436767578, 102.35152435303), chosen = false, spawnChance = 1.0},
        },
    },
    FarmSz = {
        polyInfo = false,
        props = {
            {prop = "vw_prop_vw_board_01a", coords = vector4(-52.855316162109, 1953.8099365234, 189.18603515625, 351.72482299805), chosen = false, spawnChance = 1.0},
            {prop = "gr_prop_gr_bench_04a", coords = vector4(-49.538318634033, 1946.9858398438, 187.92601989746, 253.9401550293), chosen = false, spawnChance = 1.0},
        },
    }
}