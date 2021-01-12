local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

mP = {}
Tunnel.bindInterface("nav-mechanic-production",mP)

-----------------------------------------------------------------------------------------------------------------------------------------
--[ ARRAY ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------

local categories = {
	{ item = "hardware" },
	{ item = "painting-tint" },
	{ item = "mechanic-kit" }
}

-----------------------------------------------------------------------------------------------------------------------------------
--[ EVENTOS ]----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------

RegisterServerEvent("mechanic-production")
AddEventHandler("mechanic-production",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(categories) do
			if item == v.item then
				if item == "hardware" then
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("peca-carro") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"plastico") >= 20 then
                            if vRP.getInventoryItemAmount(user_id,"cobre") >= 15 then
                                if vRP.getInventoryItemAmount(user_id,"aluminio") >= 8 then
                                    if vRP.getInventoryItemAmount(user_id,"caixa-vazia") >= 12 then
                                        if vRP.tryGetInventoryItem(user_id,"plastico",20) and vRP.tryGetInventoryItem(user_id,"cobre",15) and vRP.tryGetInventoryItem(user_id,"aluminio",8) and vRP.tryGetInventoryItem(user_id,"caixa-vazia",12) then
                                            TriggerClientEvent("close-nui",source)

                                            TriggerClientEvent("progress",source,10000,"Fabricando (Peças/Ferragens)")
                                            TriggerClientEvent("production-bench:posicao",source)
                                            vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                            SetTimeout(10000,function()
                                                vRPclient._stopAnim(source,false)
                                                vRP.giveInventoryItem(user_id,"peca-carro",1)
                                                TriggerClientEvent("Notify",source,"sucesso","Você fabricou uma <b>Peça de Carro</b>.")
                                            end)
                                        end
                                    else
                                        TriggerClientEvent("Notify",source,"negado","Você não tem <b>12x caixa(s)-vazia(s)</b> na mochila.")
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Você precisa de <b>8x alumínio(s)</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>15x cobre(s)</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você não tem <b>20x plástico(s)</b> na mochila.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço <b>insuficiente</b> na mochila.")
                    end 
                elseif item == "painting-tint" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("tinta-funilaria") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"solvente") >= 20 then
                            if vRP.getInventoryItemAmount(user_id,"pigmento") >= 15 then
                                if vRP.getInventoryItemAmount(user_id,"po-colorido") >= 8 then
                                    if vRP.getInventoryItemAmount(user_id,"caixa-vazia") >= 12 then
                                        if vRP.tryGetInventoryItem(user_id,"solvente",20) and vRP.tryGetInventoryItem(user_id,"pigmento",15) and vRP.tryGetInventoryItem(user_id,"po-colorido",8) and vRP.tryGetInventoryItem(user_id,"caixa-vazia",12) then
                                            TriggerClientEvent("close-nui",source)

                                            TriggerClientEvent("progress",source,10000,"Fabricando (Tinta de Funilaria)")
                                            TriggerClientEvent("production-bench:posicao",source)
                                            vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                            SetTimeout(10000,function()
                                                vRPclient._stopAnim(source,false)
                                                vRP.giveInventoryItem(user_id,"tinta-funilaria",1)
                                                TriggerClientEvent("Notify",source,"sucesso","Você fabricou uma <b>Lata de Tinta</b> para <b>funilaria</b>.")
                                            end)
                                        end
                                    else
                                        TriggerClientEvent("Notify",source,"negado","Você não tem <b>12x caixa(s)-vazia(s)</b> na mochila.")
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Você precisa de <b>8x pó(s)-colorido(s)</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>15x pigmento(s)</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você não tem <b>20x solvente(s)</b> na mochila.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço <b>insuficiente</b> na mochila.")
                    end 
                elseif item == "mechanic-kit" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("repair-kit") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"plastico") >= 5 then
                            if vRP.getInventoryItemAmount(user_id,"cobre") >= 5 then
                                if vRP.getInventoryItemAmount(user_id,"aluminio") >= 3 then
                                    if vRP.getInventoryItemAmount(user_id,"caixa-vazia") >= 7 then
                                        if vRP.tryGetInventoryItem(user_id,"plastico",5) and vRP.tryGetInventoryItem(user_id,"cobre",5) and vRP.tryGetInventoryItem(user_id,"aluminio",3) and vRP.tryGetInventoryItem(user_id,"caixa-vazia",7) then
                                            TriggerClientEvent("close-nui",source)

                                            TriggerClientEvent("progress",source,10000,"Produzindo (Mala de Ferramentas)")
                                            TriggerClientEvent("production-bench:posicao",source)
                                            vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                            SetTimeout(10000,function()
                                                vRPclient._stopAnim(source,false)
                                                vRP.giveInventoryItem(user_id,"repair-kit",1)
                                                TriggerClientEvent("Notify",source,"sucesso","Você fabricou uma <b>Mala de Ferramentas</b> para reparos.")
                                            end)
                                        end
                                    else
                                        TriggerClientEvent("Notify",source,"negado","Você não tem <b>7x caixa(s)-vazia(s)</b> na mochila.")
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Você precisa de <b>3x alumínio(s)</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Você precisa de <b>5x cobre(s)</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Você não tem <b>5x plástico(s)</b> na mochila.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Espaço <b>insuficiente</b> na mochila.")
                    end 
                end
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------
--[ FUNÇÃO DE PERMISSÃO ]----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------

function mP.checkPermissao()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"manager.permissao") then
        return true
    end
end