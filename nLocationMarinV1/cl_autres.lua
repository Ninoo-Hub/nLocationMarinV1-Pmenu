ESX = nil


Citizen.CreateThread(function()
    while ESX == nil do
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	Citizen.Wait(0)
    end
end)

local blips = {
    {title="Location Jet", colour=0, id=459, x = -757.39, y = -1367.37, z = 1.59},
}

Citizen.CreateThread(function()
    for _, info in pairs(blips) do
        info.blip = AddBlipForCoord(info.x, info.y, info.z)
        SetBlipSprite(info.blip, info.id)
        SetBlipDisplay(info.blip, 4)
        SetBlipScale(info.blip, 0.7)
        SetBlipColour(info.blip, info.colour)
        SetBlipAsShortRange(info.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(info.title)
        EndTextCommandSetBlipName(info.blip)
    end
end)

function DrawMissionText(msg, time)
    ClearPrints()
    SetTextEntry_2('STRING')
    AddTextComponentString(msg)
    DrawSubtitleTimed(time, 1)
  end

local nLoc = {

        Base = {  Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {228, 233, 228}, Title = "Location Marin",  Blocked = false },
        Data = { currentMenu = "Location Marin", "" },
        Events = {
             onSelected = function(self, _, btn, CMenu, menuData, currentButton, currentSlt, result)
                if btn.name == "Moto Marine" then
                    OpenMenu('Moto Marine')
                 elseif btn.name == "Bateaux" then
                        OpenMenu('Bateaux')
                    elseif btn.name == "Sous-Marin" then
                        OpenMenu('Sous-Marin')
                 elseif btn.name == "Jet-Ski" then
                      TriggerServerEvent('nLoc:buy', 200, "seashark", "Jet-Ski")
                      ESX.ShowNotification('Vous venez de sortir un Jet-Ski ~r~sans-permis ~w~!')
                      Citizen.Wait(1)
                      spawnCar("seashark")
                 elseif btn.name == "Bateaux Luxe" then
                      TriggerServerEvent('nLoc:buy', 200, "Jetmax", "Bateaux Luxe")
                      ESX.ShowNotification('Vous venez de sortir un Jet-Ski ~r~sans-permis ~w~!')
                      Citizen.Wait(1)
                      spawnCar("Jetmax")
                 elseif btn.name == "Bateaux Ancien" then
                    TriggerServerEvent('nLoc:buy', 200, "Speeder", "Bateaux Ancien")
                    ESX.ShowNotification('Vous venez de sortir un Jet-Ski ~r~sans-permis ~w~!')
                    Citizen.Wait(1)
                    spawnCar("Speeder")
                elseif btn.name == "Bateaux Visite" then
                    TriggerServerEvent('nLoc:buy', 200, "Suntrap", "Bateaux Visite")
                    ESX.ShowNotification('Vous venez de sortir un Jet-Ski ~r~sans-permis ~w~!')
                    Citizen.Wait(1)
                    spawnCar("Suntrap")
                elseif btn.name == "Sous-Marin Léger" then
                    TriggerServerEvent('nLoc:buy', 200, "Submersible", "Sous-Marin Léger")
                    ESX.ShowNotification('Vous venez de sortir un Jet-Ski ~r~sans-permis ~w~!')
                    Citizen.Wait(1)
                    spawnCar("Submersible2")
                elseif btn.name == "Sous-Marin Explorateur" then
                    TriggerServerEvent('nLoc:buy', 200, "Submersible2", "Sous-Marin Explorateur")
                    ESX.ShowNotification('Vous venez de sortir un Jet-Ski ~r~sans-permis ~w~!')
                    Citizen.Wait(1)
                    spawnCar("Submersible2")



                    

            end
      end,
  },

    Menu = {
        ["Location Marin"] = {
            b = {
                {name = "Moto Marine", ask = "→", askX = true},
                {name = "Bateaux", ask = "→", askX = true},
                {name = "Sous-Marin", ask = "→", askX = true},
            }
        },
       
        ["Bateaux"] = {
            b = {
                {name = "Bateaux Luxe", ask = "~g~200$", askX = true},
                {name = "~b~-----------------------------------------------------------------------", ask = "", askX = true},                
                {name = "Bateaux Ancien", ask = "~g~200$", askX = true},
                {name = "~b~-----------------------------------------------------------------------", ask = "", askX = true},                
                {name = "Bateaux Visite", ask = "~g~200$", askX = true},

            }
        },

        ["Moto Marine"] = {
            b = {
                {name = "Jet-Ski", ask = "~g~200$", askX = true},

            }
        },

        ["Sous-Marin"] = {
            b = {
                {name = "Sous-Marin Léger", ask = "~g~200$", askX = true},
                {name = "~b~-----------------------------------------------------------------------", ask = "", askX = true},                
                {name = "Sous-Marin Explorateur", ask = "~g~200$", askX = true},

            }
        },

    }
}


spawnCar = function(car)
    local car = GetHashKey(car)
    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(0)
    end
     Vehicle = CreateVehicle(car, -754.68, -1368.80, 1.59, 236.83, true, false)
    SetEntityAsMissionEntity(Vehicle, true, true)
    SetVehicleNumberPlateText(Vehicle, "Location")
end

local aLoc = {
    { x = -757.39, y = -1367.37, z = 1.59},

}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k, v in pairs(aLoc) do
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, aLoc[k].x, aLoc[k].y, aLoc[k].z)
            DrawMarker(29, v.x, v.y, 44.28, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 66, 238, 13,  155, false, true, 2, true, nil, nil, false)
            if dist <= 1.5 then
				ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour parler avec le Vendeur")
                if IsControlJustPressed(1,51) then
                    Citizen.Wait(500) 
                    DrawMissionText("~g~[Vendeur]~s~ Bonjour !", 1200)
                    Citizen.Wait(1050)
                    DrawMissionText("~b~[Vous]~s~ Bonjour, Monsieur ", 1400)
                    Citizen.Wait(1050)
                DrawMissionText("~g~[Vendeur]~s~ Comment puis-je vous aider ?", 4000)
                Citizen.Wait(2500)
                    DrawMissionText("~b~[Vous]~s~ J'aimerais louer un véhicule marin", 4000)
                    Citizen.Wait(3050)
                    DrawMissionText("~g~[Vendeur]~s~ Pas de probleme ! J'ai ce qu'il faut pour vous", 3500)
                    Citizen.Wait(2050)
                    DrawMissionText("~g~[Vendeur]~s~ Voici les Véhicules que je vous propose", 2600)
                    CreateMenu(nLoc)
                    Citizen.Wait(40000)
				end
            end
        end
    end
end)

Citizen.CreateThread(function()
    local hash = GetHashKey("mp_g_m_pros_01")

    while not HasModelLoaded(hash) do
        RequestModel(hash)
        Wait(20)
    end


    ped = CreatePed("PED_TYPE_CIVMALE", "mp_g_m_pros_01",-757.39,  -1367.37,  0.59, 137.59588, false, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetEntityInvincible(ped, true)
    FreezeEntityPosition(ped, true)


end)

print("^1======================================================================^1")
print("^2[^4Script Location Marin by^2] ^7: ^2 Ninoo#9999^2")
print( "^1Version ^2v1" )
print("^1======================================================================^1")

--Thank you for not changing the name to put yours and tell everyone that it was you who created the script
 --Merci de pas changer le nom pour mettre le votre et dire a tout le monde que c'est vous qui avais crée le script

  -- --------------------------------------------------------------------------  FR  -------------------------------------------------------------------------------------------------------

 --En cas de probleme ou d'erreur :

 --Mon discord : https://discord.gg/9jUAAwb

 --Mon discord Perso : Ninoo#9999

  -- --------------------------------------------------------------------------  ENG  -------------------------------------------------------------------------------------------------------

  --In case of problem or error :

  --My discord server : https://discord.gg/9jUAAwb

  ----My discord  : Ninoo#9999
