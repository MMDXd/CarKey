CreateThread(function ()
    while true do
        Wait(800)
        local ped = PlayerPedId()
        if IsPedInAnyVehicle(ped) then
            local vehicle = GetVehiclePedIsIn(ped)
            if GetPedInVehicleSeat(vehicle, -1) == ped then
                local plate = GetVehicleNumberPlateText(vehicle)
                local count = exports.ox_inventory:Search("count", "carkey", {plate = plate})
                if count <= 0 then
                    SetVehicleEngineOn(vehicle, false, true, true)
                    Entity(vehicle).state:set("engineoff", true, true)
                elseif count > 0 and Entity(vehicle).state.engineoff then
                    SetVehicleEngineOn(vehicle, true, false, false)
                    Entity(vehicle).state:set("engineoff", false, true)
                end
            end
        end
    end
end)