local kmh = 3.6
local mph = 2.23693629
local carspeed = 0

local driftmode = true -- on/off speed
local speed = kmh -- or mph
local drift_speed_limit = 120.0
local toggle = 244 -- shift gauche

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if IsControlJustPressed(1, 244) then
            driftmode = not driftmode
            if driftmode then
                TriggerEvent("chatMessage", 'Mode Drift', { 255,255,255}, '^2Activé')
            else
                TriggerEvent("chatMessage", 'Mode Drift', { 255,255,255}, '^1Désactivé')
            end
        end
        if driftmode then
            if IsPedInAnyVehicle(GetPed(), false) then
                CarSpeed = GetEntitySpeed(GetCar()) * speed
                if GetPedInVehicleSeat(GetCar(), -1) == GetPed() then
                    if CarSpeed <= drift_speed_limit then  
                        if IsControlPressed(1, 21) then
                            SetVehicleReduceGrip(GetCar(), true)        
                        else        
                            SetVehicleReduceGrip(GetCar(), false)
                        end
                    end
                end
            end
        end
    end
end)

function GetPed() return GetPlayerPed(-1) end
function GetCar() return GetVehiclePedIsIn(GetPlayerPed(-1),false) end