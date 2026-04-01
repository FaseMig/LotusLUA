local L0 = require 'ffi'
local L1 = require 'bit'
local L2 = require "vector"
local L3 = require "gamesense/antiaim_funcs" or error "https://gamesense.pub/forums/viewtopic.php?id=29665"
local L4 = require "gamesense/surface"
local L5 = require "gamesense/base64" or error("Base64 library required")
local L6 = require "gamesense/clipboard" or error("Clipboard library required")

local L7, L8, L9, L10, L11, L12, L13, L14, L15 = require, pcall, ipairs, pairs, unpack, tonumber, tostring, toticks, totime

local L16 = { new = L0.new, typeof = L0.typeof, cast = L0.cast, cdef = L0.cdef, sizeof = L0.sizeof, string = L0.string }
local L17 = { loadstring = panorama.loadstring, open = panorama.open }
local L18 = { get = plist.get, set = plist.set }
local L19 = { export = config.export, import = config.import, load = config.load }
local L20 = { flush = database.flush, read = database.read, write = database.write }
local L21 = { arshift = L1.arshift, band = L1.band, bnot = L1.bnot, bor = L1.bor, bswap = L1.bswap, bxor = L1.bxor, lshift = L1.lshift, rol = L1.rol, ror = L1.ror, rshift = L1.rshift, tobit = L1.tobit, tohex = L1.tohex }
local L22 = { byte = string.byte, char = string.char, find = string.find, format = string.format, gmatch = string.gmatch, gsub = string.gsub, len = string.len, lower = string.lower, match = string.match, rep = string.rep, reverse = string.reverse, sub = string.sub, upper = string.upper }
local L23 = { abs = math.abs, acos = math.acos, asin = math.asin, atan = math.atan, atan2 = math.atan2, ceil = math.ceil, cos = math.cos, cosh = math.cosh, deg = math.deg, exp = math.exp, floor = math.floor, fmod = math.fmod, frexp = math.frexp, ldexp = math.ldexp, log = math.log, log10 = math.log10, max = math.max, min = math.min, modf = math.modf, pow = math.pow, rad = math.rad, random = math.random, randomseed = math.randomseed, sin = math.sin, sinh = math.sinh, sqrt = math.sqrt, tan = math.tan, tanh = math.tanh, pi = math.pi }
local L24 = { get = ui.get, is_menu_open = ui.is_menu_open, menu_size = ui.menu_size, menu_position = ui.menu_position, mouse_position = ui.mouse_position, name = ui.name, new_button = ui.new_button, new_checkbox = ui.new_checkbox, new_color_picker = ui.new_color_picker, new_combobox = ui.new_combobox, new_hotkey = ui.new_hotkey, new_label = ui.new_label, new_listbox = ui.new_listbox, new_multiselect = ui.new_multiselect, new_slider = ui.new_slider, new_string = ui.new_string, new_textbox = ui.new_textbox, reference = ui.reference, set = ui.set, set_callback = ui.set_callback, set_visible = ui.set_visible, update = ui.update }
local L25 = { blur = renderer.blur, circle = renderer.circle, circle_outline = renderer.circle_outline, gradient = renderer.gradient, indicator = renderer.indicator, line = renderer.line, load_jpg = renderer.load_jpg, load_png = renderer.load_png, load_rgba = renderer.load_rgba, load_svg = renderer.load_svg, measure_text = renderer.measure_text, rectangle = renderer.rectangle, text = renderer.text, texture = renderer.texture, triangle = renderer.triangle, world_to_screen = renderer.world_to_screen }
local L26 = { absoluteframetime = globals.absoluteframetime, chokedcommands = globals.chokedcommands, commandack = globals.commandack, curtime = globals.curtime, framecount = globals.framecount, frametime = globals.frametime, lastoutgoingcommand = globals.lastoutgoingcommand, mapname = globals.mapname, maxplayers = globals.maxplayers, oldcommandack = globals.oldcommandack, realtime = globals.realtime, tickcount = globals.tickcount, tickinterval = globals.tickinterval }
local L27 = { get_all = entity.get_all, get_bounding_box = entity.get_bounding_box, get_classname = entity.get_classname, get_esp_data = entity.get_esp_data, get_game_rules = entity.get_game_rules, get_local_player = entity.get_local_player, get_origin = entity.get_origin, get_player_name = entity.get_player_name, get_player_resource = entity.get_player_resource, get_player_weapon = entity.get_player_weapon, get_players = entity.get_players, get_prop = entity.get_prop, get_steam64 = entity.get_steam64, hitbox_position = entity.hitbox_position, is_alive = entity.is_alive, is_dormant = entity.is_dormant, is_enemy = entity.is_enemy, new_prop = entity.new_prop, set_prop = entity.set_prop }
local L28 = { camera_angles = _G.client.camera_angles, camera_position = _G.client.camera_position, color_log = _G.client.color_log, create_interface = _G.client.create_interface, current_threat = _G.client.current_threat, delay_call = _G.client.delay_call, draw_debug_text = _G.client.draw_debug_text, draw_hitboxes = _G.client.draw_hitboxes, error_log = _G.client.error_log, exec = _G.client.exec, eye_position = _G.client.eye_position, find_signature = _G.client.find_signature, fire_event = _G.client.fire_event, get_cvar = _G.client.get_cvar, get_model_name = _G.client.get_model_name, key_state = _G.client.key_state, latency = _G.client.latency, log = _G.client.log, random_float = _G.client.random_float, random_int = _G.client.random_int, real_latency = _G.client.real_latency, register_esp_flag = _G.client.register_esp_flag, reload_active_scripts = _G.client.reload_active_scripts, request_full_update = _G.client.request_full_update, scale_damage = _G.client.scale_damage, screen_size = _G.client.screen_size, set_clan_tag = _G.client.set_clan_tag, set_event_callback = _G.client.set_event_callback, system_time = _G.client.system_time, timestamp = _G.client.timestamp, trace_bullet = _G.client.trace_bullet, trace_line = _G.client.trace_line, unix_time = _G.client.unix_time, unset_event_callback = _G.client.unset_event_callback, update_player_list = _G.client.update_player_list, userid_to_entindex = _G.client.userid_to_entindex, visible = _G.client.visible }

local L29 = L16.typeof('void***')
local L30 = L28.create_interface('client.dll', 'VClientEntityList003') or error('VClientEntityList003 wasnt found', 2)
local L31 = L16.cast(L29, L30) or error('rawientitylist is nil', 2)
local L32 = L16.cast('void*(__thiscall*)(void*, int)', L31[0][3]) or error('get_client_entity is nil', 2)
local L33 = L16.cast('void*(__thiscall*)(void*, int)', L31[0][0]) or error('get_client_networkable_t is nil', 2)

L16.cdef([[
    struct animation_layer_t {
        char  pad_0000[20];
        uint32_t m_nOrder;
        uint32_t m_nSequence;
        float m_flPrevCycle;
        float m_flWeight;
        float m_flWeightDeltaRate;
        float m_flPlaybackRate;
        float m_flCycle;
        void *m_pOwner;
        char  pad_0038[4];
    };
    struct animstate_t1 {
        char pad[ 3 ];
        char m_bForceWeaponUpdate;
        char pad1[ 91 ];
        void* m_pBaseEntity;
        void* m_pActiveWeapon;
        void* m_pLastActiveWeapon;
        float m_flLastClientSideAnimationUpdateTime;
        int m_iLastClientSideAnimationUpdateFramecount;
        float m_flAnimUpdateDelta;
        float m_flEyeYaw;
        float m_flPitch;
        float m_flGoalFeetYaw;
        float m_flCurrentFeetYaw;
        float m_flCurrentTorsoYaw;
        float m_flUnknownVelocityLean;
        float m_flLeanAmount;
        char pad2[ 4 ];
        float m_flFeetCycle;
        float m_flFeetYawRate;
        char pad3[ 4 ];
        float m_fDuckAmount;
        float m_fLandingDuckAdditiveSomething;
        char pad4[ 4 ];
        float m_vOriginX;
        float m_vOriginY;
        float m_vOriginZ;
        float m_vLastOriginX;
        float m_vLastOriginY;
        float m_vLastOriginZ;
        float m_vVelocityX;
        float m_vVelocityY;
        char pad5[ 4 ];
        float m_flUnknownFloat1;
        char pad6[ 8 ];
        float m_flUnknownFloat2;
        float m_flUnknownFloat3;
        float m_flUnknown;
        float m_flSpeed2D;
        float m_flUpVelocity;
        float m_flSpeedNormalized;
        float m_flFeetSpeedForwardsOrSideWays;
        float m_flFeetSpeedUnknownForwardOrSideways;
        float m_flTimeSinceStartedMoving;
        float m_flTimeSinceStoppedMoving;
        bool m_bOnGround;
        bool m_bInHitGroundAnimation;
        char m_pad[2];
        float m_flJumpToFall;
        float m_flTimeSinceInAir;
        float m_flLastOriginZ;
        float m_flHeadHeightOrOffsetFromHittingGroundAnimation;
        float m_flStopToFullRunningFraction;
        char pad7[ 4 ];
        float m_flMagicFraction;
        char pad8[ 60 ];
        float m_flWorldForce;
        char pad9[ 462 ];
        float m_flMaxYaw;
    };
]])

local lotus_combo = ui.new_combobox("lua", "B", "Lotus resolver", "off", "desync", "advanced")

local advanced_settings = {
    smooth_factor = ui.new_slider("lua", "B", "Advanced smooth", 1, 100, 65, true, "%"),
    delta_threshold = ui.new_slider("lua", "B", "Advanced delta threshold", 1, 90, 40, true, "°"),
    pitch_check = ui.new_checkbox("lua", "B", "Advanced pitch check"),
    multi_shot = ui.new_checkbox("lua", "B", "Advanced multi-shot tracking"),
    passive_scan = ui.new_checkbox("lua", "B", "Passive head scan"),
    scan_time = ui.new_slider("lua", "B", "Passive scan time", 1, 10, 3, true, "0.1s")
}

local presets = {
    jitter = {
        smooth_factor = 45,
        delta_threshold = 25,
        pitch_check = true,
        multi_shot = true,
        passive_scan = true,
        scan_time = 2
    },
    low_desync = {
        smooth_factor = 35,
        delta_threshold = 20,
        pitch_check = true,
        multi_shot = true,
        passive_scan = true,
        scan_time = 1
    },
    high_desync = {
        smooth_factor = 60,
        delta_threshold = 40,
        pitch_check = true,
        multi_shot = true,
        passive_scan = true,
        scan_time = 3
    }
}

local preset_combo = ui.new_combobox("lua", "B", "--- Preset ---", "Jitter", "Low Desync", "High Desync")

local preset_ui = {
    combo = preset_combo,
    load_btn = ui.new_button("lua", "B", "Load Preset", function()
        local selected = ui.get(preset_combo)
        local preset_name = string.lower(string.gsub(selected, " ", "_"))
        if presets[preset_name] then
            load_preset(preset_name)
        end
    end)
}

local L71 = { cur = {}, prev = {}, pre_prev = {}, pre_pre_prev = {} }
local L72 = {}
local L73 = {}
for i = 1, 64 do
    L73[i] = { stand = {}, stand_type = {}, run = {}, run_type = {}, air = {}, air_type = {}, duck = {}, duck_type = {} }
end

local L147 = {}
local L648 = false
local L649 = {}
local L650 = {}
local L651 = {}
local L652 = {}

local L90 = { ["debug"] = {} }
L90["debug"][5] = ui.new_checkbox("lua", "B", "Whitelist on shot only")
L90["debug"][6] = ui.new_hotkey("lua", "B", "On shot bind", true)

local L127 = {
    plist = {
        reset = ui.reference("Players", "Players", "Reset all")
    }
}

local function L138(yaw)
    while yaw > 180 do yaw = yaw - 360 end
    while yaw < -180 do yaw = yaw + 360 end
    return yaw
end

local function calculate_angle(from, to)
    local delta = to - from
    local yaw = L23.atan(delta.y / delta.x) * 180 / L23.pi
    if delta.x >= 0 then yaw = yaw + 180 end
    return L138(yaw)
end

local function check_hitbox_visible(ent, hitbox)
    local lp = L27.get_local_player()
    if not lp then 
        return false 
    end
    local hx, hy, hz = L27.hitbox_position(ent, hitbox)
    if not hx or not hy or not hz then 
        return false 
    end
    local hb_pos = L2(hx, hy, hz)
    local success, result = pcall(function()
        return L28.visible(hb_pos)
    end)
    if not success then
        return false
    end
    return result == true or result == ent
end

local function find_available_head_hitbox(ent)
    local head_hitboxes = { 0, 1, 2, 3, 4, 5, 6 }
    local priorities = { 0, 1, 6, 2, 3, 4, 5 }
    for _, hb in L9(priorities) do
        if check_hitbox_visible(ent, hb) then
            return hb
        end
    end
    return nil
end

function load_preset(preset_name)
    local preset = presets[preset_name]
    if not preset then
        client.color_log(255, 0, 0, "[Lotus] Пресет не найден: " .. preset_name)
        return
    end
    ui.set(advanced_settings.smooth_factor, preset.smooth_factor)
    ui.set(advanced_settings.delta_threshold, preset.delta_threshold)
    ui.set(advanced_settings.pitch_check, preset.pitch_check)
    ui.set(advanced_settings.multi_shot, preset.multi_shot)
    ui.set(advanced_settings.passive_scan, preset.passive_scan)
    ui.set(advanced_settings.scan_time, preset.scan_time)
    client.color_log(0, 255, 0, "[Lotus] Пресет '" .. preset_name .. "' загружен!")
end

local function L503(simtime)
    return L23.floor(0.5 + simtime / L26.tickinterval())
end

local L647 = function(local_player)
    local players = L27.get_players(true)
    if #players == 0 then
        L71 = { cur = {}, prev = {}, pre_prev = {}, pre_pre_prev = {} }
        return
    end
    for _, ent in L9(players) do
        if L27.is_alive(ent) and not L27.is_dormant(ent) then
            local simtime = L503(L27.get_prop(ent, "m_flSimulationTime"))
            if L71.cur[ent] == nil or simtime - L71.cur[ent].simtime >= 1 then
                L71.pre_pre_prev[ent] = L71.pre_prev[ent]
                L71.pre_prev[ent] = L71.prev[ent]
                L71.prev[ent] = L71.cur[ent]
                local local_origin = L2(L27.get_prop(local_player, "m_vecOrigin"))
                local eye_angles = L2(L27.get_prop(ent, "m_angEyeAngles"))
                local origin = L2(L27.get_prop(ent, "m_vecOrigin"))
                local yaw = L23.floor(L138(eye_angles.y - calculate_angle(local_origin, origin)))
                local yaw_backwards = L23.floor(L138(calculate_angle(local_origin, origin)))
                local duck = L27.get_prop(ent, "m_flDuckAmount")
                local on_ground = L21.band(L27.get_prop(ent, "m_fFlags"), 1) == 1
                local speed = L2(L27.get_prop(ent, 'm_vecVelocity')):length2d()
                local stance = on_ground and (duck == 1 and "duck" or (speed > 1.2 and "running" or "standing")) or "air"
                local weapon = L27.get_player_weapon(ent)
                local last_shot = weapon and L27.get_prop(weapon, "m_fLastShotTime") or 0
                L71.cur[ent] = {
                    id = ent,
                    origin = L2(L27.get_origin(ent)),
                    pitch = eye_angles.x,
                    yaw = yaw,
                    yaw_backwards = yaw_backwards,
                    simtime = simtime,
                    stance = stance,
                    esp_flags = L27.get_esp_data(ent).flags or 0,
                    last_shot_time = last_shot
                }
            end
        end
    end
end

local L672 = function(local_player)
    if not L27.is_alive(local_player) then
        L648 = false
        L651 = {}
        return
    end
    local players = L27.get_players(true)
    if #players == 0 then return end
    for _, ent in L9(players) do
        if L27.is_alive(ent) and not L27.is_dormant(ent) then
            if L71.cur[ent] and L71.prev[ent] and L71.pre_prev[ent] and L71.pre_pre_prev[ent] then
                if not L651[ent] then
                    L651[ent] = {
                        no_shot_time = 0,
                        last_check = L26.curtime(),
                        active = false,
                        target_hitbox = nil
                    }
                end
                local L653 = nil
                local L657 = L23.abs(L138(L71.cur[ent].yaw - L71.prev[ent].yaw))
                local L658 = L138(L71.cur[ent].yaw - L71.prev[ent].yaw)
                local is_onshot = false
                if L71.cur[ent].last_shot_time then
                    local time_diff = L26.curtime() - L71.cur[ent].last_shot_time
                    local ticks = time_diff / L26.tickinterval()
                    is_onshot = ticks <= L23.floor(0.2 / L26.tickinterval())
                end
                if L24.get(lotus_combo) == "desync" then
                    L648 = true
                    local cur_yaw   = L71.cur[ent].yaw
                    local prev_yaw  = L71.prev[ent].yaw
                    local pre_yaw   = L71.pre_prev[ent].yaw
                    local pre_pre_yaw = L71.pre_pre_prev[ent].yaw
                    local diff1 = L138(cur_yaw - prev_yaw)
                    local diff2 = L138(cur_yaw - pre_yaw)
                    local diff3 = L138(prev_yaw - pre_pre_yaw)
                    local diff4 = L138(prev_yaw - pre_yaw)
                    local diff5 = L138(pre_yaw - pre_pre_yaw)
                    local diff6 = L138(pre_pre_yaw - cur_yaw)
                    if is_onshot and
                       L23.abs(L23.abs(L71.cur[ent].pitch) - L23.abs(L71.prev[ent].pitch)) > 30 and
                       L71.cur[ent].pitch < L71.prev[ent].pitch then
                        L653 = "ON SHOT"
                    elseif L23.abs(L71.cur[ent].pitch) > 60 then
                        if L657 > 30 and L23.abs(diff2) < 15 and L23.abs(diff3) < 15 then
                            L653 = "[!!]"
                        elseif L23.abs(diff1) > 15 or L23.abs(diff4) > 15 or L23.abs(diff5) > 15 or L23.abs(diff6) > 15 then
                            L653 = "[!!!]"
                        end
                    end
                    if L24.get(L90["debug"][5]) and L24.get(L90["debug"][6]) then
                        L18.set(ent, "Add to whitelist", L653 ~= "ON SHOT")
                    else
                        L18.set(ent, "Add to whitelist", false)
                    end
                    if L147[ent] and L653 then
                        local stance = L71.cur[ent].stance
                        if stance == "standing" and #L73[ent].stand < 20 then
                            table.insert(L73[ent].stand_type, L653)
                            if (L653 == "[!!!]" and L657 > 5) or L653 == "[!!]" then
                                table.insert(L73[ent].stand, L657)
                            end
                        elseif stance == "running" and #L73[ent].run < 20 then
                            table.insert(L73[ent].run_type, L653)
                            if (L653 == "[!!!]" and L657 > 5) or L653 == "[!!]" then
                                table.insert(L73[ent].run, L657)
                            end
                        end
                    end
                    if L71.cur[ent].pitch >= 78 and L71.prev[ent].pitch >= 78 then
                        if L653 == "[!!!]" or L653 == "[!!]" then
                            if L653 == "[!!]" then
                                if L138(cur_yaw - prev_yaw) > 0 then
                                    L18.set(ent, "Force body yaw", true)
                                    L18.set(ent, "Force body yaw value", 60)
                                else
                                    L18.set(ent, "Force body yaw", true)
                                    L18.set(ent, "Force body yaw value", -60)
                                end
                            elseif L653 == "[!!!]" then
                                L18.set(ent, "Force body yaw", true)
                                L18.set(ent, "Force body yaw value", cur_yaw < 0 and 60 or -60)
                            end
                        else
                            L18.set(ent, "Force body yaw", false)
                            L18.set(ent, "Force body yaw value", 0)
                        end
                    end
                elseif L24.get(lotus_combo) == "advanced" then
                    L648 = true
                    if not L649[ent] then
                        L649[ent] = {
                            yaw_history = {},
                            pitch_history = {},
                            shot_history = {},
                            confidence = 50,
                            last_yaw_change = 0,
                            jitter_detected = false,
                            jitter_count = 0,
                            last_force_yaw = 0,
                            flip_count = 0,
                            fakepitch_detected = false,
                            defensive_detected = false
                        }
                    end
                    local adv = L649[ent]
                    local scan = L651[ent]
                    local cur_yaw = L71.cur[ent].yaw
                    local cur_pitch = L71.cur[ent].pitch
                    local prev_yaw = L71.prev[ent].yaw
                    local cur_yaw_change = L23.abs(L138(cur_yaw - prev_yaw))
                    table.insert(adv.yaw_history, {yaw = cur_yaw, change = cur_yaw_change, time = L26.curtime()})
                    table.insert(adv.pitch_history, cur_pitch)
                    if is_onshot then
                        table.insert(adv.shot_history, L26.curtime())
                    end
                    if #adv.yaw_history > 3 then
                        table.remove(adv.yaw_history, 1)
                    end
                    if #adv.pitch_history > 3 then
                        table.remove(adv.pitch_history, 1)
                    end
                    if #adv.shot_history > 3 then
                        table.remove(adv.shot_history, 1)
                    end
                    if #adv.yaw_history >= 2 then
                        local last_data = adv.yaw_history[#adv.yaw_history]
                        local prev_data = adv.yaw_history[#adv.yaw_history - 1]
                        local prev_change = prev_data.change
                        local cur_change = last_data.change
                        local prev_sign = prev_yaw - L71.pre_prev[ent].yaw
                        local cur_sign = cur_yaw - prev_yaw
                        local is_flip = (prev_sign > 5 and cur_sign < -5) or (prev_sign < -5 and cur_sign > 5)
                        if is_flip then
                            adv.flip_count = adv.flip_count + 1
                        else
                            adv.flip_count = L23.max(0, adv.flip_count - 1)
                        end
                        adv.jitter_detected = adv.flip_count >= 2
                        if adv.jitter_detected then
                            adv.confidence = 100
                            local predicted_yaw = 0
                            if cur_sign > 0 then
                                predicted_yaw = -58
                            else
                                predicted_yaw = 58
                            end
                            L18.set(ent, "Force body yaw", true)
                            L18.set(ent, "Force body yaw value", predicted_yaw)
                            L653 = "JITTER"
                            adv.last_force_yaw = predicted_yaw
                        elseif cur_change > 25 then
                            adv.confidence = L23.min(adv.confidence + 10, 80)
                            local force_yaw = cur_sign > 0 and -50 or 50
                            L18.set(ent, "Force body yaw", true)
                            L18.set(ent, "Force body yaw value", force_yaw)
                            L653 = "JITTER"
                            adv.last_force_yaw = force_yaw
                        else
                            adv.confidence = L23.max(adv.confidence - 2, 30)
                        end
                    end
                    if #adv.pitch_history >= 2 then
                        local cur_pitch_val = adv.pitch_history[#adv.pitch_history]
                        local prev_pitch_val = adv.pitch_history[#adv.pitch_history - 1]
                        local pitch_diff = L23.abs(cur_pitch_val - prev_pitch_val)
                        if pitch_diff > 35 then
                            adv.fakepitch_detected = true
                            adv.confidence = 100
                            if cur_pitch_val > 0 then
                                L18.set(ent, "Force body yaw", true)
                                L18.set(ent, "Force body yaw value", -54)
                            else
                                L18.set(ent, "Force body yaw", true)
                                L18.set(ent, "Force body yaw value", 54)
                            end
                            L653 = "FAKEPITCH"
                        else
                            adv.fakepitch_detected = false
                        end
                    end
                    local speed = L2(L27.get_prop(ent, 'm_vecVelocity')):length2d()
                    local is_moving = speed > 50
                    if is_moving and #adv.yaw_history >= 2 and L23.abs(cur_pitch) < 30 then
                        local cur_backwards = L71.cur[ent].yaw_backwards
                        local prev_backwards = L71.prev[ent].yaw_backwards
                        if cur_backwards and prev_backwards then
                            local move_diff = L23.abs(L138(cur_backwards - prev_backwards))
                            if move_diff > 90 then
                                adv.defensive_detected = true
                                adv.confidence = 100
                                local force_yaw = L138(cur_yaw + 90)
                                L18.set(ent, "Force body yaw", true)
                                L18.set(ent, "Force body yaw value", 58)
                                L653 = "DEFENSIVE"
                            else
                                adv.defensive_detected = false
                            end
                        end
                    else
                        adv.defensive_detected = false
                    end
                    local scan_time_limit = L24.get(advanced_settings.scan_time) * 0.1
                    local passive_enabled = L24.get(advanced_settings.passive_scan)
                    if passive_enabled then
                        local cur_time = L26.curtime()
                        local time_since_check = cur_time - scan.last_check
                        local duck_amount = L27.get_prop(ent, "m_flDuckAmount")
                        local velocity_x, velocity_y = L27.get_prop(ent, "m_vecVelocity")
                        local speed_val = math.sqrt(velocity_x * velocity_x + velocity_y * velocity_y)
                        local on_ground = bit.band(L27.get_prop(ent, "m_fFlags"), 1) == 1
                        local is_air_duck = not on_ground and duck_amount > 0.5
                        local is_running = speed_val > 100
                        local has_clear_head_shot = check_hitbox_visible(ent, 0)
                        local has_clear_chest_shot = check_hitbox_visible(ent, 2) or check_hitbox_visible(ent, 3)
                        local is_safe_head_enemy = is_air_duck and is_running and not has_clear_head_shot
                        if is_safe_head_enemy then
                            scan.active = true
                            scan.no_shot_time = scan_time_limit
                            if not scan.target_hitbox then
                                if check_hitbox_visible(ent, 2) then
                                    scan.target_hitbox = 2
                                elseif check_hitbox_visible(ent, 3) then
                                    scan.target_hitbox = 3
                                elseif check_hitbox_visible(ent, 6) then
                                    scan.target_hitbox = 6
                                elseif check_hitbox_visible(ent, 1) then
                                    scan.target_hitbox = 1
                                end
                            end
                            if scan.target_hitbox then
                                L18.set(ent, "Force body yaw", false)
                                L18.set(ent, "Force body yaw value", 0)
                                L18.set(ent, "Head hitbox", scan.target_hitbox)
                                L653 = "SCAN"
                            end
                        elseif has_clear_head_shot then
                            scan.no_shot_time = 0
                            scan.active = false
                            scan.target_hitbox = nil
                        elseif not has_clear_head_shot and has_clear_chest_shot then
                            scan.no_shot_time = scan.no_shot_time + time_since_check
                            if scan.no_shot_time >= scan_time_limit then
                                scan.active = true
                                if not scan.target_hitbox then
                                    if check_hitbox_visible(ent, 2) then
                                        scan.target_hitbox = 2
                                    elseif check_hitbox_visible(ent, 3) then
                                        scan.target_hitbox = 3
                                    end
                                end
                                if scan.target_hitbox then
                                    L18.set(ent, "Force body yaw", false)
                                    L18.set(ent, "Force body yaw value", 0)
                                    L18.set(ent, "Head hitbox", scan.target_hitbox)
                                    L653 = "SCAN"
                                end
                            end
                        else
                            scan.no_shot_time = 0
                            scan.active = false
                            scan.target_hitbox = nil
                        end
                        scan.last_check = cur_time
                    end
                    if adv and L24.get(advanced_settings.multi_shot) and #adv.shot_history >= 2 then
                        local recent_shot = adv.shot_history[#adv.shot_history]
                        local prev_shot = adv.shot_history[#adv.shot_history - 1]
                        if recent_shot - prev_shot < 0.4 then
                            adv.confidence = 100
                        end
                    end
                    if adv and L24.get(advanced_settings.pitch_check) then
                        if L23.abs(cur_pitch) > 70 or L23.abs(cur_pitch) < 10 then
                            adv.confidence = L23.min(adv.confidence + 10, 100)
                        end
                    end
                elseif L24.get(lotus_combo) == "off" and L648 then
                    L24.set(L127.plist.reset, true)
                    L18.set(ent, "Force body yaw", false)
                    L18.set(ent, "Force body yaw value", 0)
                    L648 = false
                    L649[ent] = nil
                end
                L72[ent] = { anti_aim_type = L653, yaw_delta = L658 }
            end
        end
    end
end

L28.register_esp_flag("lotus", 255, 255, 255, function(ent)
    if L24.get(lotus_combo) ~= "off" and L72[ent] and L72[ent].anti_aim_type then
        local mode = L24.get(lotus_combo)
        local aatype = L72[ent].anti_aim_type
        if mode == "desync" then
            return true, "\affffffc8" .. L22.upper(aatype)
        elseif mode == "advanced" then
            if aatype == "JITTER" then
                return true, "\a00ff00ff" .. aatype
            elseif aatype == "FAKEPITCH" then
                return true, "\a00ffff00" .. aatype
            elseif aatype == "DEFENSIVE" then
                return true, "\a0080ff80" .. aatype
            elseif aatype == "PITCH" then
                return true, "\a0080ffff" .. aatype
            elseif aatype == "ADV" then
                return true, "\a00ffffff" .. aatype
            elseif aatype == "SCAN" then
                return true, "\aff0000ff" .. aatype
            end
        end
    end
    return false
end)

L24.set_callback(lotus_combo, function()
    if L24.get(lotus_combo) == "off" then
        L24.set(L127.plist.reset, true)
        L649 = {}
        L651 = {}
        L652 = {}
    end
end)

local clan_tag_anim = {
    text = ".lotus",
    current = "",
    state = "typing",
    timer = 0,
    frame = 0,
    delay = 0.167
}

local function update_clan_tag()
    local current_time = L26.realtime()
    if clan_tag_anim.state == "typing" then
        if clan_tag_anim.frame < #clan_tag_anim.text then
            if current_time - clan_tag_anim.timer >= clan_tag_anim.delay then
                clan_tag_anim.frame = clan_tag_anim.frame + 1
                clan_tag_anim.current = string.sub(clan_tag_anim.text, 1, clan_tag_anim.frame)
                L28.set_clan_tag(clan_tag_anim.current)
                clan_tag_anim.timer = current_time
            end
        else
            clan_tag_anim.state = "waiting"
            clan_tag_anim.timer = current_time
        end
    elseif clan_tag_anim.state == "waiting" then
        if current_time - clan_tag_anim.timer >= 2 then
            clan_tag_anim.state = "deleting"
            clan_tag_anim.timer = current_time
        end
    elseif clan_tag_anim.state == "deleting" then
        if clan_tag_anim.frame > 0 then
            if current_time - clan_tag_anim.timer >= clan_tag_anim.delay then
                clan_tag_anim.frame = clan_tag_anim.frame - 1
                clan_tag_anim.current = string.sub(clan_tag_anim.text, 1, clan_tag_anim.frame)
                L28.set_clan_tag(clan_tag_anim.current)
                clan_tag_anim.timer = current_time
            end
        else
            clan_tag_anim.state = "paused"
            clan_tag_anim.timer = current_time
        end
    elseif clan_tag_anim.state == "paused" then
        if current_time - clan_tag_anim.timer >= 0.5 then
            clan_tag_anim.state = "typing"
            clan_tag_anim.frame = 0
            clan_tag_anim.current = ""
            clan_tag_anim.timer = current_time
        end
    end
end

local function on_paint_clantag()
    update_clan_tag()
end

L28.set_event_callback("paint", on_paint_clantag)

local DURATION = 5.0
local hitlog_queue = { }
local hitlog_max_entries = 8
local shot_history = { }
local max_shot_history = 16
local hitlog_settings = {
    enabled = ui.new_checkbox("lua", "B", "Log Aimbot Shots")
}
local hitlog_color_hit = { r = 0, g = 255, b = 0 }
local hitlog_color_miss = { r = 255, g = 98, b = 98 }
local hitlog_color_spread = { r = 255, g = 225, b = 115 }
local hitlog_color_unregistered = { r = 100, g = 100, b = 255 }

local function get_color(self)
    return self.r, self.g, self.b
end

hitlog_color_hit.rawget = get_color
hitlog_color_miss.rawget = get_color
hitlog_color_spread.rawget = get_color
hitlog_color_unregistered.rawget = get_color

local hitgroup_names = {
    [0] = "body",
    [1] = "head",
    [2] = "chest",
    [3] = "stomach",
    [4] = "left arm",
    [5] = "right arm",
    [6] = "left leg",
    [7] = "right leg",
    [8] = "neck",
    [10] = "gear"
}

local function get_backtrack_info(ent)
    if not ent then return nil end
    for i = 1, #shot_history do
        local shot = shot_history[i]
        if shot.target == ent then
            local current_tick = L26.tickcount()
            local backtrack_ticks = current_tick - shot.tick
            return {
                ticks = backtrack_ticks,
                tick = shot.tick,
                hitgroup = shot.hitgroup or 0
            }
        end
    end
    return nil
end

local function replacement(s, col_a, col_b)
    local hex_a = string.format("%02x%02x%02x", unpack(col_a))
    local hex_b = string.format("%02x%02x%02x", unpack(col_b))
    local repl = string.format("\a%s%%1\a%s", hex_a, hex_b)
    local result = string.gsub(s, "${(.-)}", repl)
    return result
end

local function add_hitlog(r, g, b, a, text)
    table.insert(hitlog_queue, {
        r = r,
        g = g,
        b = b,
        a = a,
        msg = text,
        time = L26.realtime(),
        duration = DURATION,
        alpha = 0.0
    })
    if #hitlog_queue > hitlog_max_entries then
        table.remove(hitlog_queue, 1)
    end
end

local function create_event_info(action, hitgroup, ent, damage, hitchance)
    local name = L27.get_player_name(ent) or "Unknown"
    local hitgroup_name = hitgroup_names[hitgroup] or "body"
    local backtrack_info = get_backtrack_info(ent)
    local history_ticks = backtrack_info and backtrack_info.ticks or 0
    local parts = { action }
    table.insert(parts, " ${")
    table.insert(parts, name)
    table.insert(parts, "'s}")
    table.insert(parts, " in the ${")
    table.insert(parts, hitgroup_name)
    table.insert(parts, "}")
    table.insert(parts, " for ${")
    table.insert(parts, tostring(damage))
    table.insert(parts, "}")
    local has_hc = hitchance and hitchance > 0
    local has_history = history_ticks > 0
    if has_hc or has_history then
        table.insert(parts, " (")
        if has_hc then
            table.insert(parts, "hc: ${")
            table.insert(parts, tostring(hitchance))
            table.insert(parts, "%}")
        end
        if has_hc and has_history then
            table.insert(parts, " · ")
        end
        if has_history then
            table.insert(parts, "history: ${")
            table.insert(parts, tostring(history_ticks))
            table.insert(parts, "t}")
        end
        table.insert(parts, ")")
    end
    return table.concat(parts)
end

local function create_miss_info(reason, ent, hitchance)
    if reason == "?" then
        reason = "correction"
    end
    local name = ent and L27.get_player_name(ent) or "Unknown"
    local hitgroup_name = hitgroup_names[0] or "head"
    local backtrack_info = get_backtrack_info(ent)
    local history_ticks = backtrack_info and backtrack_info.ticks or 0
    local recorded_hitgroup = backtrack_info and backtrack_info.hitgroup or 0
    hitgroup_name = hitgroup_names[recorded_hitgroup] or "head"
    local parts = { "Missed ${" }
    table.insert(parts, name)
    table.insert(parts, "'s ${")
    table.insert(parts, hitgroup_name)
    table.insert(parts, "} due to ${")
    table.insert(parts, reason)
    table.insert(parts, "}")
    local has_hc = hitchance and hitchance > 0
    local has_history = history_ticks > 0
    if has_hc or has_history then
        table.insert(parts, " (")
        if has_hc then
            table.insert(parts, "hc: ${")
            table.insert(parts, tostring(hitchance))
            table.insert(parts, "%}")
        end
        if has_hc and has_history then
            table.insert(parts, " · ")
        end
        if has_history then
            table.insert(parts, "history: ${")
            table.insert(parts, tostring(history_ticks))
            table.insert(parts, "t}")
        end
        table.insert(parts, ")")
    end
    return table.concat(parts)
end

local function push_hitlog(action, hitgroup, ent, damage, hitchance)
    local msg = create_event_info(action, hitgroup, ent, damage, hitchance)
    local r, g, b = hitlog_color_hit:rawget()
    add_hitlog(r, g, b, 255, msg)
    local name = L27.get_player_name(ent) or "Unknown"
    local hitgroup_name = hitgroup_names[hitgroup] or "body"
    local backtrack_info = get_backtrack_info(ent)
    local history_ticks = backtrack_info and backtrack_info.ticks or 0
    local console_parts = { action, " ", name, "'s" }
    table.insert(console_parts, " in the ")
    table.insert(console_parts, hitgroup_name)
    table.insert(console_parts, " for ")
    table.insert(console_parts, tostring(damage))
    table.insert(console_parts, " damage")
    local has_hc = hitchance and hitchance > 0
    local has_history = history_ticks > 0
    if has_hc or has_history then
        table.insert(console_parts, " (")
        if has_hc then
            table.insert(console_parts, "hc: ")
            table.insert(console_parts, tostring(hitchance))
            table.insert(console_parts, "%")
        end
        if has_hc and has_history then
            table.insert(console_parts, " · ")
        end
        if has_history then
            table.insert(console_parts, "history: ")
            table.insert(console_parts, tostring(history_ticks))
            table.insert(console_parts, "t")
        end
        table.insert(console_parts, ")")
    end
    client.color_log(r, g, b, "[Lotus] " .. table.concat(console_parts))
end

local function push_misslog(reason, ent, hitchance)
    local msg = create_miss_info(reason, ent, hitchance)
    local r, g, b
    if reason == "spread" then
        r, g, b = hitlog_color_spread:rawget()
    elseif reason == "death" or reason == "unregistered shot" then
        r, g, b = hitlog_color_unregistered:rawget()
    else
        r, g, b = hitlog_color_miss:rawget()
    end
    add_hitlog(r, g, b, 255, msg)
    local name = ent and L27.get_player_name(ent) or "Unknown"
    if reason == "?" then reason = "correction" end
    local backtrack_info = get_backtrack_info(ent)
    local history_ticks = backtrack_info and backtrack_info.ticks or 0
    local recorded_hitgroup = backtrack_info and backtrack_info.hitgroup or 0
    local hitgroup_name = hitgroup_names[recorded_hitgroup] or "head"
    local console_parts = { "Missed ", name, "'s ", hitgroup_name, " due to ", reason }
    local has_hc = hitchance and hitchance > 0
    local has_history = history_ticks > 0
    if has_hc or has_history then
        table.insert(console_parts, " (")
        if has_hc then
            table.insert(console_parts, "hc: ")
            table.insert(console_parts, tostring(hitchance))
            table.insert(console_parts, "%")
        end
        if has_hc and has_history then
            table.insert(console_parts, " · ")
        end
        if has_history then
            table.insert(console_parts, "history: ")
            table.insert(console_parts, tostring(history_ticks))
            table.insert(console_parts, "t")
        end
        table.insert(console_parts, ")")
    end
    client.color_log(r, g, b, "[Lotus] " .. table.concat(console_parts))
end

local function on_aim_fire(e)
    local lp = L27.get_local_player()
    if not lp then return end
    local attacker = L28.userid_to_entindex(e.userid)
    if attacker ~= lp then return end
    local target = e.target
    if not target then return end
    table.insert(shot_history, {
        target = target,
        tick = L26.tickcount(),
        hitchance = e.hitchance or 0,
        hitgroup = e.hitgroup or 0
    })
    if #shot_history > max_shot_history then
        table.remove(shot_history, 1)
    end
end

local function interp(current, target, rate)
    if current < target then
        return math.min(current + rate, target)
    else
        return math.max(current - rate, target)
    end
end

local function update_hitlogs()
    local dt = L26.frametime()
    for i = #hitlog_queue, 1, -1 do
        local data = hitlog_queue[i]
        data.duration = math.max(0, data.duration - dt)
        data.alpha = interp(data.alpha, data.duration > 0 and 1.0 or 0.0, 0.045)
        if data.alpha <= 0 then
            table.remove(hitlog_queue, i)
        end
    end
end

local function draw_hitlogs()
    if not L24.get(hitlog_settings.enabled) then return end
    local flags = "t"
    local pos_x = 8
    local pos_y = 5
    for i = 1, #hitlog_queue do
        local log = hitlog_queue[i]
        local r, g, b, a = log.r, log.g, log.b, log.a
        local alpha = a * log.alpha
        local text = log.msg
        text = replacement(text, { r, g, b, 255 }, { 255, 255, 255, 255 })
        local text_w, text_h = L25.measure_text(flags, 0, 0, text)
        L25.text(flags, pos_x + 1, pos_y + 1, 0, 0, 0, alpha, text)
        L25.text(flags, pos_x, pos_y, 255, 255, 255, alpha, text)
        pos_y = pos_y + text_h + 1
    end
end

local function on_pre_frame() end

local function on_post_frame()
    update_hitlogs()
    draw_hitlogs()
end

local function on_player_hurt(e)
    if not L24.get(hitlog_settings.enabled) then return end
    local me = L27.get_local_player()
    if not me then return end
    local userid = L28.userid_to_entindex(e.userid)
    local attacker = L28.userid_to_entindex(e.attacker)
    local weapon = e.weapon
    local damage = e.dmg_health
    local hitgroup = e.hitgroup
    if userid == me or attacker ~= me then return end
    local action
    if weapon == "knife" then
        action = "Knifed"
    elseif weapon == "hegrenade" then
        action = "Naded"
    else
        action = "Hit"
    end
    push_hitlog(action, hitgroup, userid, damage, nil)
end

local function on_aim_miss(e)
    if not L24.get(hitlog_settings.enabled) then return end
    local reason = e.reason or "?"
    local target = e.target
    local hitchance = e.hitchance or 0
    push_misslog(reason, target, hitchance)
end

L28.set_event_callback("paint_ui", on_pre_frame)
L28.set_event_callback("paint_ui", update_hitlogs)
L28.set_event_callback("paint_ui", on_post_frame)
L28.set_event_callback("aim_miss", on_aim_miss)
L28.set_event_callback("aim_fire", on_aim_fire)
L28.set_event_callback("player_hurt", on_player_hurt)

ui.new_button("lua", "B", "Test Hitlog", function()
    local r, g, b = hitlog_color_hit:rawget()
    add_hitlog(r, g, b, 255, "Test ${hitlog} with ${backtrack} [12t]!")
    client.color_log(r, g, b, "[Lotus] Hitlog test!")
end)

local fps_optimize = {
    enabled = ui.new_checkbox("lua", "B", "FPS Optimize"),
    always_on = ui.new_checkbox("lua", "B", "FPS Optimize - Always on"),
    detections = ui.new_multiselect("lua", "B", "FPS Optimize - Detections", { "Peeking", "Hit flag" }),
    list = ui.new_multiselect("lua", "B", "FPS Optimize - Optimizations", {
        "Blood", "Bloom", "Decals", "Shadows", "Sprites", 
        "Particles", "Ropes", "Dynamic lights", "Map details", "Weapon effects"
    })
}

local fps_optimize_state = {
    changed = false,
    original_values = {}
}

local fps_optimize_tree = {
    ["Blood"] = { { convar = "violence_hblood", value = 0 } },
    ["Bloom"] = { { convar = "mat_disable_bloom", value = 1 } },
    ["Decals"] = { { convar = "r_drawdecals", value = 0 } },
    ["Shadows"] = {
        { convar = "r_shadows", value = 0 },
        { convar = "cl_csm_static_prop_shadows", value = 0 },
        { convar = "cl_csm_shadows", value = 0 },
        { convar = "cl_csm_world_shadows", value = 0 },
        { convar = "cl_foot_contact_shadows", value = 0 },
        { convar = "cl_csm_viewmodel_shadows", value = 0 },
        { convar = "cl_csm_rope_shadows", value = 0 },
        { convar = "cl_csm_sprite_shadows", value = 0 },
        { convar = "cl_csm_translucent_shadows", value = 0 },
        { convar = "cl_csm_entity_shadows", value = 0 },
        { convar = "cl_csm_world_shadows_in_viewmodelcascad", value = 0 }
    },
    ["Sprites"] = { { convar = "r_drawsprites", value = 0 } },
    ["Particles"] = { { convar = "r_drawparticles", value = 0 } },
    ["Ropes"] = { { convar = "r_drawropes", value = 0 } },
    ["Dynamic lights"] = { { convar = "mat_disable_fancy_blending", value = 1 } },
    ["Map details"] = {
        { convar = "func_break_max_pieces", value = 0 },
        { convar = "props_break_max_pieces", value = 0 }
    },
    ["Weapon effects"] = {
        { convar = "muzzleflash_light", value = 0 },
        { convar = "r_drawtracers_firstperson", value = 0 }
    }
}

local function fps_restore_convars()
    if not fps_optimize_state.changed then return end
    for convar_name, original_value in pairs(fps_optimize_state.original_values) do
        client.set_cvar(convar_name, tostring(original_value))
    end
    fps_optimize_state.original_values = {}
    fps_optimize_state.changed = false
end

local function fps_update_convars()
    if fps_optimize_state.changed then return end
    local selected = ui.get(fps_optimize.list)
    for i = 1, #selected do
        local category = selected[i]
        local items = fps_optimize_tree[category]
        if items then
            for j = 1, #items do
                local item = items[j]
                local convar_name = item.convar
                if fps_optimize_state.original_values[convar_name] == nil then
                    fps_optimize_state.original_values[convar_name] = client.get_cvar(convar_name)
                    client.set_cvar(convar_name, tostring(item.value))
                end
            end
        end
    end
    fps_optimize_state.changed = true
end

local function fps_should_update()
    if ui.get(fps_optimize.always_on) then return true end
    local detections = ui.get(fps_optimize.detections)
    for i = 1, #detections do
        local detection = detections[i]
        if detection == "Peeking" then
            local lp = L27.get_local_player()
            if lp and L27.is_alive(lp) then
                local velocity_x, velocity_y = L27.get_prop(lp, "m_vecVelocity")
                local speed = math.sqrt(velocity_x * velocity_x + velocity_y * velocity_y)
                if speed > 100 then return true end
            end
        elseif detection == "Hit flag" then
            local enemies = L27.get_players(true)
            for j = 1, #enemies do
                local enemy = enemies[j]
                local esp_data = L27.get_esp_data(enemy)
                if esp_data and esp_data.flags then
                    if bit and bit.band(esp_data.flags, bit.lshift(1, 11)) ~= 0 then
                        return true
                    end
                end
            end
        end
    end
    return false
end

local function on_fps_optimize_shutdown()
    fps_restore_convars()
end

local function on_fps_optimize_frame()
    if not ui.get(fps_optimize.enabled) then return end
    if not fps_should_update() then
        fps_restore_convars()
        return
    end
    fps_update_convars()
end

local function on_fps_optimize_enabled()
    local value = ui.get(fps_optimize.enabled)
    if not value then
        fps_restore_convars()
        L28.unset_event_callback("shutdown", on_fps_optimize_shutdown)
        L28.unset_event_callback("pre_render", on_fps_optimize_frame)
    else
        L28.set_event_callback("shutdown", on_fps_optimize_shutdown)
        L28.set_event_callback("pre_render", on_fps_optimize_frame)
    end
end

L24.set_callback(fps_optimize.enabled, on_fps_optimize_enabled)
ui.new_button("lua", "B", "FPS Optimize - Restore", fps_restore_convars)

local function on_net_update()
    local lp = L27.get_local_player()
    if not lp then return end
    L647(lp)
    L672(lp)
end

L28.set_event_callback("net_update_end", on_net_update)
print("Lotus Resolver успешно загружен")

local mb_entity = {
    get_local_player = entity.get_local_player,
    is_alive = entity.is_alive,
    set_prop = entity.set_prop,
    get_origin = entity.get_origin
}

local mb_ui = {
    get = ui.get,
    new_checkbox = ui.new_checkbox,
    new_slider = ui.new_slider,
    new_combobox = ui.new_combobox,
    new_label = ui.new_label
}

local mb_globals = {
    tickcount = globals.tickcount,
    realtime = globals.realtime,
    curtime = globals.curtime
}

local mb_client = {
    set_event_callback = client.set_event_callback,
    color_log = client.color_log
}

local mb_math = {
    sin = math.sin,
    cos = math.cos,
    random = math.random,
    randomseed = math.randomseed,
    floor = math.floor,
    abs = math.abs,
    min = math.min,
    max = math.max,
    pi = math.pi
}

local mb_pcall = pcall

local mb_script_state = {
    roll_system = {
        current_roll_value = 0.0,
        current_roll_degrees = 0.0,
        roll_direction = 1,
        smooth_transition = 0.0
    },
    roll_compensation = {
        compensation_active = false,
        smooth_compensation_x = 0.0,
        smooth_compensation_y = 0.0,
        player_moving = false,
        standing_ticks = 0
    },
    move_noise = {
        is_standing = false,
        standing_tick_count = 0
    },
    head_control = {
        manual_active = false,
        current_pitch = 0.0,
        current_yaw = 0.0
    },
    is_initialized = false
}

local mb_ui_elements = {}

local mb_log_colors = {
    red = 255,
    green = 140,
    blue = 0,
    white_red = 255,
    white_green = 255,
    white_blue = 255
}

local function mb_initialize_random_seed_expanded()
    local current_real_time_value = mb_globals.realtime()
    local time_in_milliseconds = current_real_time_value * 1000.0
    local rounded_time_ms = mb_math.floor(time_in_milliseconds)
    local current_tick_count_value = mb_globals.tickcount()
    local current_server_time = mb_globals.curtime()
    local server_time_scaled = mb_math.floor(current_server_time * 1000.0)
    local unique_seed_value = rounded_time_ms + current_tick_count_value + server_time_scaled
    mb_math.randomseed(unique_seed_value)
    for i = 1, 10 do mb_math.random() end
end

mb_initialize_random_seed_expanded()

local mb_menu_section_name = "Other"
local mb_menu_group_prefix = "Matrix Breaker V11 [REAL ROLL 55°]"

mb_ui_elements.config_master_switch_handle = mb_ui.new_checkbox(
    "AA", mb_menu_section_name, "[" .. mb_menu_group_prefix .. "] ENABLE CHAOS SYSTEM")

mb_ui.new_label("AA", mb_menu_section_name, "--- REAL ROLL SYSTEM (55°) ---")

mb_ui_elements.config_roll_enable_handle = mb_ui.new_checkbox("AA", mb_menu_section_name, "Enable Real Roll on Model")
mb_ui_elements.config_roll_intensity_handle = mb_ui.new_slider("AA", mb_menu_section_name, "Roll Intensity (Degrees)", 0, 90, 55)
mb_ui_elements.config_roll_speed_handle = mb_ui.new_slider("AA", mb_menu_section_name, "Roll Switch Speed", 1, 500, 120)
mb_ui_elements.config_roll_smoothness_handle = mb_ui.new_slider("AA", mb_menu_section_name, "Roll Transition Smoothness", 0, 100, 30)
mb_ui_elements.config_roll_random_dir_handle = mb_ui.new_checkbox("AA", mb_menu_section_name, "Random Roll Direction")
mb_ui_elements.config_roll_jitter_enable_handle = mb_ui.new_checkbox("AA", mb_menu_section_name, "Add Roll Jitter")
mb_ui_elements.config_roll_jitter_speed_handle = mb_ui.new_slider("AA", mb_menu_section_name, "Roll Jitter Speed", 1, 500, 200)
mb_ui_elements.config_roll_legs_apply_handle = mb_ui.new_checkbox("AA", mb_menu_section_name, "Apply Roll to Legs")
mb_ui_elements.config_roll_arms_apply_handle = mb_ui.new_checkbox("AA", mb_menu_section_name, "Apply Roll to Arms")
mb_ui_elements.config_roll_spine_apply_handle = mb_ui.new_checkbox("AA", mb_menu_section_name, "Apply Roll to Spine")

mb_ui.new_label("AA", mb_menu_section_name, "--- ROLL COMPENSATION SYSTEM ---")

mb_ui_elements.config_roll_compensation_enable_handle = mb_ui.new_checkbox("AA", mb_menu_section_name, "Enable Roll Compensation")
mb_ui_elements.config_roll_compensation_strength_handle = mb_ui.new_slider("AA", mb_menu_section_name, "Compensation Strength", 0, 100, 75)
mb_ui_elements.config_roll_compensation_threshold_handle = mb_ui.new_slider("AA", mb_menu_section_name, "Movement Detection Threshold", 1, 50, 15)
mb_ui_elements.config_roll_compensation_delay_handle = mb_ui.new_slider("AA", mb_menu_section_name, "Compensation Delay (Ticks)", 0, 50, 5)
mb_ui_elements.config_roll_compensation_smoothness_handle = mb_ui.new_slider("AA", mb_menu_section_name, "Compensation Smoothness", 0, 100, 40)
mb_ui_elements.config_roll_compensation_standstill_only_handle = mb_ui.new_checkbox("AA", mb_menu_section_name, "Compensate Only When Standing")
mb_ui_elements.config_roll_compensation_while_moving_handle = mb_ui.new_checkbox("AA", mb_menu_section_name, "Compensate While Moving")
mb_ui_elements.config_roll_compensation_move_strength_handle = mb_ui.new_slider("AA", mb_menu_section_name, "Moving Compensation Strength", 0, 100, 40)
mb_ui_elements.config_roll_compensation_sidemove_handle = mb_ui.new_checkbox("AA", mb_menu_section_name, "Compensate Sidemove")
mb_ui_elements.config_roll_compensation_forward_handle = mb_ui.new_checkbox("AA", mb_menu_section_name, "Compensate Forwardmove")

mb_ui.new_label("AA", mb_menu_section_name, "--- LIMBS ANTI-RESOLVER ---")
mb_ui_elements.config_legs_break_mode_handle = mb_ui.new_combobox("AA", mb_menu_section_name, "Leg Break Mode", {"Static Invert", "Rapid Teleport", "Sine Wave Glitch", "Random Noise"})
mb_ui_elements.config_arms_distort_force_handle = mb_ui.new_slider("AA", mb_menu_section_name, "Arm Distortion Force", 0, 200, 120)

mb_ui.new_label("AA", mb_menu_section_name, "--- MOVEMENT PACKET NOISE ---")
mb_ui_elements.config_move_noise_enable_handle = mb_ui.new_checkbox("AA", mb_menu_section_name, "Inject Move Noise")
mb_ui_elements.config_move_noise_strength_handle = mb_ui.new_slider("AA", mb_menu_section_name, "Move Noise Strength", 0, 1000, 5)
mb_ui_elements.config_move_noise_standstill_threshold_handle = mb_ui.new_slider("AA", mb_menu_section_name, "Move Noise Standstill Threshold", 1, 50, 10)
mb_ui_elements.config_move_noise_standstill_delay_handle = mb_ui.new_slider("AA", mb_menu_section_name, "Move Noise Standstill Delay", 0, 100, 10)

mb_ui.new_label("AA", mb_menu_section_name, "--- ANTI-BRUTE VISUAL EMULATION ---")
mb_ui_elements.config_anti_brute_enable_handle = mb_ui.new_checkbox("AA", mb_menu_section_name, "Enable Visual Anti-Brute Jitter")
mb_ui_elements.config_anti_brute_speed_handle = mb_ui.new_slider("AA", mb_menu_section_name, "Brute Force Simulation Speed", 1, 500, 120)
mb_ui_elements.config_anti_brute_intensity_handle = mb_ui.new_slider("AA", mb_menu_section_name, "Pose Switch Intensity", 0, 200, 150)
mb_ui_elements.config_anti_brute_invert_chance_handle = mb_ui.new_slider("AA", mb_menu_section_name, "Random Invert Chance (%)", 0, 100, 30)

mb_ui.new_label("AA", mb_menu_section_name, "--- BODY INVERSION LOGIC ---")
mb_ui_elements.config_desync_force_handle = mb_ui.new_slider("AA", mb_menu_section_name, "Fake Desync Force", 0, 200, 150)
mb_ui_elements.config_desync_jitter_speed_handle = mb_ui.new_slider("AA", mb_menu_section_name, "Desync Side Switch Speed", 1, 100, 45)
mb_ui_elements.config_desync_phase_offset_handle = mb_ui.new_slider("AA", mb_menu_section_name, "Phase Offset Randomness", 0, 100, 50)

mb_ui.new_label("AA", mb_menu_section_name, "--- HEAD POSITION BREAKER ---")
mb_ui_elements.config_head_opposite_dir_handle = mb_ui.new_checkbox("AA", mb_menu_section_name, "Force Head Opposite Direction")
mb_ui_elements.config_head_shake_intensity_handle = mb_ui.new_slider("AA", mb_menu_section_name, "Head Shake Intensity", 0, 300, 200)
mb_ui_elements.config_head_shake_speed_handle = mb_ui.new_slider("AA", mb_menu_section_name, "Head Shake Frequency", 1, 500, 150)

mb_ui.new_label("AA", mb_menu_section_name, "--- MANUAL HEAD CONTROL ---")
mb_ui_elements.config_manual_head_enable_handle = mb_ui.new_checkbox("AA", mb_menu_section_name, "Enable Manual Head Control")
mb_ui_elements.config_manual_head_pitch_handle = mb_ui.new_slider("AA", mb_menu_section_name, "Manual Head Pitch (Up/Down)", -100, 100, 0)
mb_ui_elements.config_manual_head_yaw_handle = mb_ui.new_slider("AA", mb_menu_section_name, "Manual Head Yaw (Left/Right)", -100, 100, 0)
mb_ui_elements.config_manual_head_force_handle = mb_ui.new_slider("AA", mb_menu_section_name, "Manual Head Force Strength", 0, 100, 100)
mb_ui_elements.config_head_preset_handle = mb_ui.new_combobox("AA", mb_menu_section_name, "Head Direction Preset", {"None", "Look Up", "Look Down", "Look Left", "Look Right", "Look Back", "Default"})
mb_ui_elements.config_head_preset_auto_handle = mb_ui.new_checkbox("AA", mb_menu_section_name, "Auto Switch Head Presets")
mb_ui_elements.config_head_preset_speed_handle = mb_ui.new_slider("AA", mb_menu_section_name, "Preset Switch Speed", 1, 500, 100)

local function mb_break_pose_parameter_aggressive(entity_index, pose_parameter_index, input_value)
    if entity_index == nil then return end
    local is_entity_alive = mb_entity.is_alive(entity_index)
    if is_entity_alive == false then return end
    if pose_parameter_index < 0 or pose_parameter_index > 20 then return end
    local final_clamped_value = input_value
    local max_limit, min_limit = 1.0, 0.0
    if final_clamped_value > max_limit then final_clamped_value = max_limit end
    if final_clamped_value < min_limit then final_clamped_value = min_limit end
    local status, error_message = mb_pcall(mb_entity.set_prop, entity_index, "m_flPoseParameter", final_clamped_value, pose_parameter_index)
    if status == false then return end
end

local function mb_get_raw_slider_value(slider_handle)
    local value = mb_ui.get(slider_handle)
    return value
end

local function mb_get_head_preset_value(preset_name, pitch_or_yaw)
    if preset_name == "Look Up" then return pitch_or_yaw == "pitch" and 80.0 or 0.0
    elseif preset_name == "Look Down" then return pitch_or_yaw == "pitch" and -80.0 or 0.0
    elseif preset_name == "Look Left" then return pitch_or_yaw == "pitch" and 0.0 or -80.0
    elseif preset_name == "Look Right" then return pitch_or_yaw == "pitch" and 0.0 or 80.0
    elseif preset_name == "Look Back" then return pitch_or_yaw == "pitch" and 0.0 or 100.0
    elseif preset_name == "Default" then return pitch_or_yaw == "pitch" and 0.0 or 0.0
    else return nil end
end

local function mb_calculate_final_head_value(base_value, manual_value, force_strength, is_manual_enabled)
    local force_norm = force_strength / 100.0
    if is_manual_enabled == true then
        return (base_value * (1.0 - force_norm)) + (manual_value * force_norm)
    else
        return base_value
    end
end

local function mb_convert_manual_head_to_pose(manual_value, is_pitch)
    local pose_value = (manual_value + 100.0) / 200.0
    return mb_math.max(0.0, mb_math.min(1.0, pose_value))
end

local function mb_apply_manual_head_control(local_player_index, is_manual_enabled, manual_pitch_raw, manual_yaw_raw, force_strength, preset_name, is_preset_auto, preset_speed_norm, current_tick_count)
    mb_script_state.head_control.manual_active = is_manual_enabled
    local preset_pitch_value = mb_get_head_preset_value(preset_name, "pitch")
    local preset_yaw_value = mb_get_head_preset_value(preset_name, "yaw")
    
    if is_preset_auto == true and preset_pitch_value ~= nil then
        local auto_cycle = mb_math.sin(current_tick_count * preset_speed_norm)
        if auto_cycle > 0.7 then preset_pitch_value, preset_yaw_value = 80.0, 0.0
        elseif auto_cycle < -0.7 then preset_pitch_value, preset_yaw_value = -80.0, 0.0
        elseif auto_cycle > 0.3 then preset_pitch_value, preset_yaw_value = 0.0, -80.0
        elseif auto_cycle < -0.3 then preset_pitch_value, preset_yaw_value = 0.0, 80.0 end
    end
    
    local manual_pitch_value, manual_yaw_value = manual_pitch_raw, manual_yaw_raw
    if preset_name ~= "None" and preset_pitch_value ~= nil then
        manual_pitch_value, manual_yaw_value = preset_pitch_value, preset_yaw_value
    end
    
    local pitch_pose = mb_convert_manual_head_to_pose(manual_pitch_value, true)
    local yaw_pose = mb_convert_manual_head_to_pose(manual_yaw_value, false)
    
    mb_script_state.head_control.current_pitch, mb_script_state.head_control.current_yaw = pitch_pose, yaw_pose
    
    if is_manual_enabled == true then
        local force_norm = force_strength / 100.0
        mb_script_state.head_control.current_pitch = mb_script_state.head_control.current_pitch * force_norm + pitch_pose * (1.0 - force_norm)
        mb_script_state.head_control.current_yaw = mb_script_state.head_control.current_yaw * force_norm + yaw_pose * (1.0 - force_norm)
        mb_break_pose_parameter_aggressive(local_player_index, 12, mb_script_state.head_control.current_pitch)
        mb_break_pose_parameter_aggressive(local_player_index, 11, mb_script_state.head_control.current_yaw)
        return true
    end
    return false
end

local function mb_calculate_roll_value_degrees(tick_count, intensity_degrees, speed, smoothness, random_dir, jitter_enable, jitter_speed)
    local intensity_norm = intensity_degrees / 90.0
    local speed_norm = speed / 100.0
    local base_roll = mb_math.sin(tick_count * speed_norm) * intensity_norm
    
    if jitter_enable == true then
        local jitter_speed_norm = jitter_speed / 100.0
        local jitter_tick = mb_math.floor(tick_count / (10.0 - jitter_speed_norm * 9.0))
        local jitter_side = jitter_tick % 2 == 0 and 1 or -1
        if mb_math.random() < 0.25 then jitter_side = jitter_side * -1 end
        base_roll = base_roll + (jitter_side * intensity_norm * 0.3)
    end
    
    if smoothness > 0 then
        local smoothness_norm = smoothness / 100.0
        mb_script_state.roll_system.smooth_transition = mb_script_state.roll_system.smooth_transition + (base_roll - mb_script_state.roll_system.smooth_transition) * (1.0 - smoothness_norm)
        base_roll = mb_script_state.roll_system.smooth_transition
    end
    
    if random_dir == true then
        if mb_math.random() < 0.02 then mb_script_state.roll_system.roll_direction = mb_script_state.roll_system.roll_direction * -1 end
        base_roll = base_roll * mb_script_state.roll_system.roll_direction
    end
    
    mb_script_state.roll_system.current_roll_value = base_roll
    mb_script_state.roll_system.current_roll_degrees = base_roll * 90.0
    return base_roll
end

local function mb_apply_roll_to_model(local_player_index, roll_value_normalized, intensity_degrees, apply_legs, apply_arms, apply_spine)
    if local_player_index == nil then return end
    local is_player_alive = mb_entity.is_alive(local_player_index)
    if is_player_alive == false then return end
    local pose_val = (roll_value_normalized + 1.0) / 2.0
    pose_val = mb_math.max(0.0, mb_math.min(1.0, pose_val))
    mb_break_pose_parameter_aggressive(local_player_index, 14, pose_val)
    if apply_legs == true then
        mb_break_pose_parameter_aggressive(local_player_index, 0, pose_val * 0.5)
        mb_break_pose_parameter_aggressive(local_player_index, 7, pose_val * 0.3)
    end
    if apply_arms == true then
        mb_break_pose_parameter_aggressive(local_player_index, 3, 0.5 + (roll_value_normalized * 0.2))
        mb_break_pose_parameter_aggressive(local_player_index, 8, 0.5 - (roll_value_normalized * 0.2))
        mb_break_pose_parameter_aggressive(local_player_index, 9, pose_val * 0.7)
    end
    if apply_spine == true then
        mb_break_pose_parameter_aggressive(local_player_index, 6, pose_val * 0.8)
    end
end

local function mb_is_player_moving(cmd, threshold)
    return math.abs(cmd.forwardmove) + math.abs(cmd.sidemove) > threshold
end

local function mb_calculate_roll_compensation(roll_value, compensation_strength, smoothness, is_moving, move_strength)
    local strength_norm = compensation_strength / 100.0
    local smoothness_norm = smoothness / 100.0
    local move_strength_norm = move_strength / 100.0
    local base_compensation_x = -roll_value * strength_norm * 15.0
    local base_compensation_y = -roll_value * strength_norm * 5.0
    if is_moving == true then
        base_compensation_x = base_compensation_x * move_strength_norm
        base_compensation_y = base_compensation_y * move_strength_norm
    end
    mb_script_state.roll_compensation.smooth_compensation_x = mb_script_state.roll_compensation.smooth_compensation_x + (base_compensation_x - mb_script_state.roll_compensation.smooth_compensation_x) * (1.0 - smoothness_norm)
    mb_script_state.roll_compensation.smooth_compensation_y = mb_script_state.roll_compensation.smooth_compensation_y + (base_compensation_y - mb_script_state.roll_compensation.smooth_compensation_y) * (1.0 - smoothness_norm)
    return mb_script_state.roll_compensation.smooth_compensation_x, mb_script_state.roll_compensation.smooth_compensation_y
end

local function mb_apply_compensation_to_command(cmd, comp_x, comp_y, is_moving, standstill_only, do_sidemove, do_forward)
    if standstill_only == true and is_moving == true then return end
    if do_sidemove == true then cmd.sidemove = cmd.sidemove + comp_x end
    if do_forward == true then cmd.forwardmove = cmd.forwardmove + comp_y * 0.3 end
end

local function mb_is_player_standing_for_noise(cmd, threshold, required_ticks)
    local total_movement = math.abs(cmd.forwardmove) + math.abs(cmd.sidemove)
    local is_standing = total_movement <= threshold
    if is_standing == true then
        mb_script_state.move_noise.standing_tick_count = mb_script_state.move_noise.standing_tick_count + 1
    else
        mb_script_state.move_noise.standing_tick_count = 0
    end
    mb_script_state.move_noise.is_standing = is_standing
    return is_standing and mb_script_state.move_noise.standing_tick_count >= required_ticks
end

local function mb_pre_render_logic()
    local is_master_enabled = mb_ui.get(mb_ui_elements.config_master_switch_handle)
    if is_master_enabled == false then return end
    local local_player_index = mb_entity.get_local_player()
    if local_player_index == nil then return end
    local is_player_alive = mb_entity.is_alive(local_player_index)
    if is_player_alive == false then return end
    local current_tick_count = mb_globals.tickcount()
    local current_real_time = mb_globals.realtime()
    local remainder_ticks = current_tick_count % 16
    if remainder_ticks == 0 then mb_initialize_random_seed_expanded() end
    
    local is_roll_enabled = mb_ui.get(mb_ui_elements.config_roll_enable_handle)
    local roll_intensity_raw = mb_get_raw_slider_value(mb_ui_elements.config_roll_intensity_handle)
    local roll_speed_raw = mb_get_raw_slider_value(mb_ui_elements.config_roll_speed_handle)
    local roll_smoothness_raw = mb_get_raw_slider_value(mb_ui_elements.config_roll_smoothness_handle)
    local roll_random_dir = mb_ui.get(mb_ui_elements.config_roll_random_dir_handle)
    local roll_jitter_enable = mb_ui.get(mb_ui_elements.config_roll_jitter_enable_handle)
    local roll_jitter_speed_raw = mb_get_raw_slider_value(mb_ui_elements.config_roll_jitter_speed_handle)
    local roll_legs_apply = mb_ui.get(mb_ui_elements.config_roll_legs_apply_handle)
    local roll_arms_apply = mb_ui.get(mb_ui_elements.config_roll_arms_apply_handle)
    local roll_spine_apply = mb_ui.get(mb_ui_elements.config_roll_spine_apply_handle)
    
    local roll_value = 0.0
    if is_roll_enabled == true then
        roll_value = mb_calculate_roll_value_degrees(current_tick_count, roll_intensity_raw, roll_speed_raw, roll_smoothness_raw, roll_random_dir, roll_jitter_enable, roll_jitter_speed_raw)
    end
    if is_roll_enabled == true then
        mb_apply_roll_to_model(local_player_index, roll_value, roll_intensity_raw, roll_legs_apply, roll_arms_apply, roll_spine_apply)
    end
    
    local is_roll_compensation_enabled = mb_ui.get(mb_ui_elements.config_roll_compensation_enable_handle)
    mb_script_state.roll_compensation.compensation_active = is_roll_compensation_enabled and is_roll_enabled
    
    local is_anti_brute_enabled = mb_ui.get(mb_ui_elements.config_anti_brute_enable_handle)
    local anti_brute_speed_raw = mb_get_raw_slider_value(mb_ui_elements.config_anti_brute_speed_handle)
    local anti_brute_speed_norm = anti_brute_speed_raw / 20.0
    local anti_brute_int_raw = mb_get_raw_slider_value(mb_ui_elements.config_anti_brute_intensity_handle)
    local anti_brute_int_norm = anti_brute_int_raw / 100.0
    local invert_chance_raw = mb_get_raw_slider_value(mb_ui_elements.config_anti_brute_invert_chance_handle)
    local invert_chance_norm = invert_chance_raw / 100.0
    local desync_force_raw = mb_get_raw_slider_value(mb_ui_elements.config_desync_force_handle)
    local desync_force_norm = desync_force_raw / 100.0
    local desync_speed_raw = mb_get_raw_slider_value(mb_ui_elements.config_desync_jitter_speed_handle)
    local desync_speed_norm = desync_speed_raw / 20.0
    local phase_offset_raw = mb_get_raw_slider_value(mb_ui_elements.config_desync_phase_offset_handle)
    local phase_offset_norm = phase_offset_raw / 100.0
    local is_head_opposite = mb_ui.get(mb_ui_elements.config_head_opposite_dir_handle)
    local head_shake_int_raw = mb_get_raw_slider_value(mb_ui_elements.config_head_shake_intensity_handle)
    local head_shake_int_norm = head_shake_int_raw / 100.0
    local head_shake_spd_raw = mb_get_raw_slider_value(mb_ui_elements.config_head_shake_speed_handle)
    local head_shake_spd_norm = head_shake_spd_raw / 20.0
    local legs_mode_string = mb_ui.get(mb_ui_elements.config_legs_break_mode_handle)
    local arms_distort_raw = mb_get_raw_slider_value(mb_ui_elements.config_arms_distort_force_handle)
    local arms_distort_norm = arms_distort_raw / 100.0
    local is_manual_head_enabled = mb_ui.get(mb_ui_elements.config_manual_head_enable_handle)
    local manual_head_pitch_raw = mb_get_raw_slider_value(mb_ui_elements.config_manual_head_pitch_handle)
    local manual_head_yaw_raw = mb_get_raw_slider_value(mb_ui_elements.config_manual_head_yaw_handle)
    local manual_head_force_raw = mb_get_raw_slider_value(mb_ui_elements.config_manual_head_force_handle)
    local head_preset_name = mb_ui.get(mb_ui_elements.config_head_preset_handle)
    local is_head_preset_auto = mb_ui.get(mb_ui_elements.config_head_preset_auto_handle)
    local head_preset_speed_raw = mb_get_raw_slider_value(mb_ui_elements.config_head_preset_speed_handle)
    local head_preset_speed_norm = head_preset_speed_raw / 100.0
    
    local manual_head_applied = mb_apply_manual_head_control(local_player_index, is_manual_head_enabled, manual_head_pitch_raw, manual_head_yaw_raw, manual_head_force_raw, head_preset_name, is_head_preset_auto, head_preset_speed_norm, current_tick_count)
    
    local brute_force_modifier = 0.0
    local is_inverted_this_tick = false
    if is_anti_brute_enabled == true then
        local random_chance = mb_math.random()
        if random_chance < invert_chance_norm then
            is_inverted_this_tick = true
            brute_force_modifier = -1.0
        else
            brute_force_modifier = mb_math.sin(current_tick_count * anti_brute_speed_norm) * anti_brute_int_norm
            local noise_layer = (mb_math.random() * 2.0 - 1.0) * anti_brute_int_norm
            brute_force_modifier = brute_force_modifier + noise_layer
        end
    end
    
    local base_yaw_value = 0.5
    local oscillation_factor = mb_math.sin(current_tick_count * desync_speed_norm + (phase_offset_norm * mb_math.pi))
    local desync_offset = oscillation_factor * desync_force_norm
    if is_anti_brute_enabled == true then desync_offset = desync_offset + (brute_force_modifier * 0.5) end
    local final_body_yaw_value = base_yaw_value + desync_offset
    final_body_yaw_value = (final_body_yaw_value + 1.0) / 2.0
    if manual_head_applied == false or is_manual_head_enabled == false then
        mb_break_pose_parameter_aggressive(local_player_index, 11, final_body_yaw_value)
    end
    local spine_twist_value = desync_offset * 0.8
    spine_twist_value = (spine_twist_value + 1.0) / 2.0
    mb_break_pose_parameter_aggressive(local_player_index, 6, spine_twist_value)
    
    if manual_head_applied == false then
        local final_head_pitch_value = 0.0
        local final_head_yaw_value = 0.0
        if is_head_opposite == true then
            final_head_yaw_value = base_yaw_value - desync_offset
            local head_noise = (mb_math.random() * 2.0) - 1.0
            local head_osc = mb_math.cos(current_tick_count * head_shake_spd_norm) * head_shake_int_norm
            final_head_yaw_value = final_head_yaw_value + head_osc + (head_noise * 0.5)
            final_head_pitch_value = (mb_math.sin(current_tick_count * 0.5) * head_shake_int_norm) + (mb_math.random() * 0.2)
        else
            local head_noise = (mb_math.random() * 2.0) - 1.0
            local head_osc = mb_math.sin(current_tick_count * head_shake_spd_norm) * head_shake_int_norm
            final_head_yaw_value = base_yaw_value + head_osc + (head_noise * 0.8)
            final_head_pitch_value = head_osc * 0.5
        end
        if is_anti_brute_enabled == true and is_inverted_this_tick then
            final_head_yaw_value = final_head_yaw_value * -1.5
            final_head_pitch_value = 1.0 - final_head_pitch_value
        end
        if is_manual_head_enabled == true then
            final_head_pitch_value = mb_calculate_final_head_value(final_head_pitch_value, manual_head_pitch_raw / 100.0, manual_head_force_raw, is_manual_head_enabled)
            final_head_yaw_value = mb_calculate_final_head_value(final_head_yaw_value, manual_head_yaw_raw / 100.0, manual_head_force_raw, is_manual_head_enabled)
        end
        final_head_pitch_value = (final_head_pitch_value + 1.0) / 2.0
        final_head_yaw_value = (final_head_yaw_value + 1.0) / 2.0
        mb_break_pose_parameter_aggressive(local_player_index, 12, final_head_pitch_value)
        mb_break_pose_parameter_aggressive(local_player_index, 11, final_head_yaw_value)
    end
    
    local final_legs_value = 0.0
    if legs_mode_string == "Static Invert" then final_legs_value = 0.0 
    elseif legs_mode_string == "Rapid Teleport" then
        local tick_remainder = current_tick_count % 3
        if tick_remainder == 0 then final_legs_value = 1.0 elseif tick_remainder == 1 then final_legs_value = 0.0 else final_legs_value = 0.5 end
    elseif legs_mode_string == "Sine Wave Glitch" then final_legs_value = (mb_math.sin(current_tick_count * 5.0) + 1.0) / 2.0
    elseif legs_mode_string == "Random Noise" then final_legs_value = mb_math.random() end
    if is_anti_brute_enabled == true then final_legs_value = final_legs_value + (brute_force_modifier * 0.1) end
    final_legs_value = mb_math.max(0.0, mb_math.min(1.0, final_legs_value))
    mb_break_pose_parameter_aggressive(local_player_index, 0, final_legs_value)
    mb_break_pose_parameter_aggressive(local_player_index, 7, final_legs_value * 0.5)
    
    local arm_noise = (mb_math.random() * 2.0) - 1.0
    local arm_osc = mb_math.cos(current_tick_count * 2.5) * arms_distort_norm
    local final_arms_value = (arm_osc + (arm_noise * arms_distort_norm) + 1.0) / 2.0
    if is_anti_brute_enabled == true and is_inverted_this_tick then final_arms_value = 1.0 - final_arms_value end
    final_arms_value = mb_math.max(0.0, mb_math.min(1.0, final_arms_value))
    mb_break_pose_parameter_aggressive(local_player_index, 3, final_arms_value)
    mb_break_pose_parameter_aggressive(local_player_index, 8, 1.0 - final_arms_value)
    mb_break_pose_parameter_aggressive(local_player_index, 9, final_arms_value * 0.7)
    
    local noise_iteration = 1
    local max_pose_params = 14
    while noise_iteration <= max_pose_params do
        local micro_noise = (mb_math.random() * 0.5) - 0.25
        if is_anti_brute_enabled == true then micro_noise = micro_noise + (brute_force_modifier * 0.3) end
        micro_noise = (micro_noise + 1.0) / 2.0
        micro_noise = mb_math.max(0.0, mb_math.min(1.0, micro_noise))
        if noise_iteration ~= 11 and noise_iteration ~= 12 and noise_iteration ~= 0 and noise_iteration ~= 6 and noise_iteration ~= 14 then
             mb_break_pose_parameter_aggressive(local_player_index, noise_iteration, micro_noise)
        end
        noise_iteration = noise_iteration + 1
    end
end

local function mb_setup_command_callback(cmd)
    local is_master_enabled = mb_ui.get(mb_ui_elements.config_master_switch_handle)
    if is_master_enabled == false then return end
    local local_player_index = mb_entity.get_local_player()
    if local_player_index == nil then return end
    local is_player_alive = mb_entity.is_alive(local_player_index)
    if is_player_alive == false then return end
    local current_tick_count = mb_globals.tickcount()
    
    local is_roll_compensation_enabled = mb_ui.get(mb_ui_elements.config_roll_compensation_enable_handle)
    local is_roll_enabled = mb_ui.get(mb_ui_elements.config_roll_enable_handle)
    
    if is_roll_compensation_enabled == true and is_roll_enabled == true then
        local roll_comp_strength_raw = mb_get_raw_slider_value(mb_ui_elements.config_roll_compensation_strength_handle)
        local roll_comp_threshold_raw = mb_get_raw_slider_value(mb_ui_elements.config_roll_compensation_threshold_handle)
        local roll_comp_delay_raw = mb_get_raw_slider_value(mb_ui_elements.config_roll_compensation_delay_handle)
        local roll_comp_smoothness_raw = mb_get_raw_slider_value(mb_ui_elements.config_roll_compensation_smoothness_handle)
        local roll_comp_standstill_only = mb_ui.get(mb_ui_elements.config_roll_compensation_standstill_only_handle)
        local roll_comp_while_moving = mb_ui.get(mb_ui_elements.config_roll_compensation_while_moving_handle)
        local roll_comp_move_strength_raw = mb_get_raw_slider_value(mb_ui_elements.config_roll_compensation_move_strength_handle)
        local roll_comp_sidemove = mb_ui.get(mb_ui_elements.config_roll_compensation_sidemove_handle)
        local roll_comp_forward = mb_ui.get(mb_ui_elements.config_roll_compensation_forward_handle)
        local roll_intensity_raw = mb_get_raw_slider_value(mb_ui_elements.config_roll_intensity_handle)
        local roll_speed_raw = mb_get_raw_slider_value(mb_ui_elements.config_roll_speed_handle)
        local roll_smoothness_raw = mb_get_raw_slider_value(mb_ui_elements.config_roll_smoothness_handle)
        local roll_random_dir = mb_ui.get(mb_ui_elements.config_roll_random_dir_handle)
        local roll_jitter_enable = mb_ui.get(mb_ui_elements.config_roll_jitter_enable_handle)
        local roll_jitter_speed_raw = mb_get_raw_slider_value(mb_ui_elements.config_roll_jitter_speed_handle)
        
        local roll_value = mb_calculate_roll_value_degrees(current_tick_count, roll_intensity_raw, roll_speed_raw, roll_smoothness_raw, roll_random_dir, roll_jitter_enable, roll_jitter_speed_raw)
        local is_moving = mb_is_player_moving(cmd, roll_comp_threshold_raw)
        mb_script_state.roll_compensation.player_moving = is_moving
        if is_moving == false then
            mb_script_state.roll_compensation.standing_ticks = mb_script_state.roll_compensation.standing_ticks + 1
        else
            mb_script_state.roll_compensation.standing_ticks = 0
        end
        local delay_passed = mb_script_state.roll_compensation.standing_ticks >= roll_comp_delay_raw
        local comp_x, comp_y = mb_calculate_roll_compensation(roll_value, roll_comp_strength_raw, roll_comp_smoothness_raw, is_moving, roll_comp_move_strength_raw)
        local should_compensate = false
        if roll_comp_standstill_only == true then
            if is_moving == false and delay_passed == true then should_compensate = true end
        elseif roll_comp_while_moving == true then
            should_compensate = true
        else
            if is_moving == false and delay_passed == true then should_compensate = true end
        end
        if should_compensate == true then
            mb_apply_compensation_to_command(cmd, comp_x, comp_y, is_moving, roll_comp_standstill_only, roll_comp_sidemove, roll_comp_forward)
            mb_script_state.roll_compensation.compensation_active = true
        else
            mb_script_state.roll_compensation.compensation_active = false
        end
    end
    
    local is_move_noise_enabled = mb_ui.get(mb_ui_elements.config_move_noise_enable_handle)
    if is_move_noise_enabled == false then return end
    local move_noise_standstill_threshold = mb_get_raw_slider_value(mb_ui_elements.config_move_noise_standstill_threshold_handle)
    local move_noise_standstill_delay = mb_get_raw_slider_value(mb_ui_elements.config_move_noise_standstill_delay_handle)
    local is_standing_for_noise = mb_is_player_standing_for_noise(cmd, move_noise_standstill_threshold, move_noise_standstill_delay)
    if is_standing_for_noise == false then return end
    local move_noise_strength = mb_get_raw_slider_value(mb_ui_elements.config_move_noise_strength_handle)
    if move_noise_strength <= 0 then return end
    local random_noise_val = (mb_math.random() * move_noise_strength * 2.0) - move_noise_strength
    cmd.sidemove = cmd.sidemove + random_noise_val
    local random_noise_forward = (mb_math.random() * move_noise_strength * 2.0) - move_noise_strength
    cmd.forwardmove = cmd.forwardmove + random_noise_forward
end

local function mb_shutdown_callback()
    mb_client.color_log(mb_log_colors.white_red, mb_log_colors.white_green, mb_log_colors.white_blue, "[Matrix Breaker V11] System shutting down...")
end

local function combined_prerender_callback()
    if on_fps_optimize_frame then on_fps_optimize_frame() end
    mb_pre_render_logic()
end

L28.set_event_callback("pre_render", combined_prerender_callback)
L28.set_event_callback("setup_command", mb_setup_command_callback)

local original_shutdown = on_fps_optimize_shutdown
L28.set_event_callback("shutdown", function()
    if original_shutdown then original_shutdown() end
    mb_shutdown_callback()
end)

local watermark = {
    text = ".lotus",
    x = nil, y = nil,
    alpha = 0, target_alpha = 220,
    pulse_speed = 0.015, pulse_offset = 0,
    float_offset = 0, float_speed = 0.8,
    colors = {
        primary = {r = 195, g = 85, b = 255},
        secondary = {r = 255, g = 120, b = 195},
        glow = {r = 120, g = 60, b = 255},
        shadow = {r = 30, g = 15, b = 50}
    }
}

local function draw_beautiful_watermark()
    local sw, sh = client.screen_size()
    watermark.x = sw - 180
    watermark.y = 25 + watermark.float_offset
    watermark.pulse_offset = watermark.pulse_offset + watermark.pulse_speed
    local pulse = math.sin(watermark.pulse_offset) * 25
    local current_alpha = math.min(255, math.max(0, watermark.target_alpha + pulse))
    watermark.float_offset = math.sin(globals.realtime() * watermark.float_speed) * 2
    local gradient_t = (math.sin(globals.realtime() * 1.5) + 1) / 2
    local r = watermark.colors.primary.r + (watermark.colors.secondary.r - watermark.colors.primary.r) * gradient_t
    local g = watermark.colors.primary.g + (watermark.colors.secondary.g - watermark.colors.primary.g) * gradient_t
    local b = watermark.colors.primary.b + (watermark.colors.secondary.b - watermark.colors.primary.b) * gradient_t
    for i = 1, 4 do
        L25.text("t", watermark.x + i, watermark.y + i, 
            watermark.colors.shadow.r, watermark.colors.shadow.g, watermark.colors.shadow.b, 
            current_alpha * (0.25 - i * 0.05), watermark.text)
    end
    for i = 1, 2 do
        L25.text("t", watermark.x, watermark.y, 
            watermark.colors.glow.r, watermark.colors.glow.g, watermark.colors.glow.b, 
            current_alpha * 0.15, watermark.text)
    end
    L25.text("t", watermark.x, watermark.y, r, g, b, current_alpha, watermark.text)
    local text_w, text_h = L25.measure_text("t", 0, 0, watermark.text)
    L25.gradient(watermark.x, watermark.y + text_h + 3, text_w, 2, 
        r, g, b, current_alpha * 0.8, 
        r, g, b, 0)
    L25.circle(watermark.x - 8, watermark.y + text_h/2, 2, 
        watermark.colors.secondary.r, watermark.colors.secondary.g, watermark.colors.secondary.b, current_alpha)
end

local original_paint_ui_callback = nil
L28.set_event_callback("paint_ui", function()
    if on_pre_frame then on_pre_frame() end
    if update_hitlogs then update_hitlogs() end
    if on_post_frame then on_post_frame() end
    draw_beautiful_watermark()
end)

mb_script_state.is_initialized = true-- lotus watermark
local wm={{ "LOTUS v9.7",138,43,226 },{ " | ",80,80,80 },{ "MAX PROT",255,80,80 },{ " | ",80,80,80 },{ "UNDETECTED",80,255,80 }}
local wa,wf=0,true
client.set_event_callback("paint_ui",function()
local sw=client.screen_size()
if wf then wa=wa+10 if wa>=255 then wa=255 wf=false end end
local x=sw-10
for i=1,#wm do local t,r,g,b=wm[i][1],wm[i][2],wm[i][3],wm[i][4] local w=renderer.measure_text("t",0,0,t) renderer.text("t",x+1,11,0,0,0,wa*0.4,t) x=x+w end
x=sw-10
for i=1,#wm do local t,r,g,b=wm[i][1],wm[i][2],wm[i][3],wm[i][4] local w=renderer.measure_text("t",0,0,t) renderer.text("t",x,10,r,g,b,wa,t) x=x+w end
end)
