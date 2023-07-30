local keys = {}
AddEventHandler("entityCreating", function (entity)
    if GetEntityType(entity) ~= 2 then return end
    local owner = NetworkGetFirstEntityOwner(entity)
    Wait(500)
    if DoesEntityExist(entity) then
        local ped = GetPedInVehicleSeat(entity, -1)
        if IsPedAPlayer(ped) then
            owner = NetworkGetEntityOwner(ped)
        end
    end
    keys[entity] = true
    exports.ox_inventory:AddItem(owner, "carkey", 1, {plate = GetVehicleNumberPlateText(entity)})
end)
CreateThread(function ()
    while true do
        Wait(500)
        for key, value in pairs(GetAllVehicles()) do
            if not keys[value] then
                -- vehicle created by server
                if NetworkGetFirstEntityOwner(value) == -1 then
                    local owner = NetworkGetEntityOwner(value)
                    if owner ~= -1 then
                        keys[value] = true
                        exports.ox_inventory:AddItem(owner, "carkey", 1, {plate = GetVehicleNumberPlateText(value)})
                    end
                end
            end
        end
    end
end)