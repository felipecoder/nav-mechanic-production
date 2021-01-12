local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

--[ CONNECTION ]----------------------------------------------------------------------------------------------------------------

mP = Tunnel.getInterface("nav-mechanic-production")

--[ VARIABLES ]-----------------------------------------------------------------------------------------------------------------

local menuactive = false

local productionBench = {
	{ ['x'] = -227.91, ['y'] = -1329.44, ['z'] = 30.9 }
}

--[ MENU | FUNCTION ]-----------------------------------------------------------------------------------------------------------

function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		SetNuiFocus(true,true)
		TransitionToBlurred(1000)
		SendNUIMessage({ showmenu = true })
	else
		SetNuiFocus(false)
		TransitionFromBlurred(1000)
		SendNUIMessage({ hidemenu = true })
	end
end

-------------------------------------------------------------------------------------------------
--[ BOTÕES ]-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------

RegisterNUICallback("ButtonClick",function(data,cb)
	if data == "production-hardware" then
		TriggerServerEvent("mechanic-production","hardware")

	elseif data == "production-painting-tint" then
		TriggerServerEvent("mechanic-production","painting-tint")

	elseif data == "production-mechanic-kit" then
		TriggerServerEvent("mechanic-production","mechanic-kit")


	elseif data == "fechar" then
		ToggleActionMenu()
		onmenu = false
	end
end)

RegisterNetEvent("production-bench:posicao")
AddEventHandler("production-bench:posicao", function()
	local ped = PlayerPedId()
	SetEntityHeading(ped,91.0)
	SetEntityCoords(ped,-227.45,-1327.19,30.9-1,false,false,false,false)
end)

RegisterNetEvent("close-nui")
AddEventHandler("close-nui", function()
	ToggleActionMenu()
	onmenu = false
end)

--[ OPEN MONEY WASH MENU | THREAD ]-------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		local idle = 1000
		for k,v in pairs(productionBench) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			local productionBench = productionBench[k]
			
			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), productionBench.x, productionBench.y, productionBench.z, true ) <= 1.5 and not menuactive then
				DrawText3D(productionBench.x, productionBench.y, productionBench.z, "PRESSIONE ~y~E~w~ PARA ACESSAR O ~y~MENU~w~ DE ~y~LAVAGEM~w~")
			end

			if distance < 5.1 then
				DrawMarker(23, productionBench.x, productionBench.y, productionBench.z-0.97, 0, 0, 0, 0, 0, 0, 0.7, 0.7, 0.5, 255, 215, 0, 180, 0, 0, 0, 0)
				idle = 5
				if distance <= 1.2 then
					if IsControlJustPressed(0,38) then
						ToggleActionMenu()
					end
				end
			end
		end
		Citizen.Wait(idle)
	end
end)

--[ TEXT | FUNCTION ]--------------------------------------------------------------------------------------------------------------------

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.28, 0.28)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.005+ factor, 0.03, 41, 11, 41, 68)
end