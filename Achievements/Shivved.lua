local _G = _G
local shivved_achievement = CreateFrame("Frame")
_G.achievements.Shivved = shivved_achievement

-- General info
shivved_achievement.name = "Shivved"
shivved_achievement.title = "Shivved"
shivved_achievement.class = "Rogue"
shivved_achievement.icon_path = "Interface\\Addons\\Hardcore\\Media\\icon_shivved.blp"
shivved_achievement.description =
	"Complete the Hardcore challenge without at any point equipping a melee weapon other than Daggers. "

-- Registers
function shivved_achievement:Register(fail_function_executor)
	shivved_achievement:RegisterEvent("PLAYER_EQUIPMENT_CHANGED")
	shivved_achievement.fail_function_executor = fail_function_executor
end

function shivved_achievement:Unregister()
	shivved_achievement:UnregisterEvent("PLAYER_EQUIPMENT_CHANGED")
	shivved_achievement.fail_function_executor = nil
end

-- Register Definitions
shivved_achievement:SetScript("OnEvent", function(self, event, ...)
	local arg = { ... }
	if event == "PLAYER_EQUIPMENT_CHANGED" then
		if arg[2] == true then
			return
		end
		local item_id = GetInventoryItemID("player", arg[1])
		local item_name, _, _, _, _, item_type, item_subtype, _, item_equip_loc, _, _ = GetItemInfo(item_id)
		print(item_equip_loc)
		if
			item_equip_loc == "INVTYPE_WEAPONMAINHAND"
			or item_equip_loc == "INVTYPE_WEAPONOFFHAND"
			or item_equip_loc == "INVTYPE_WEAPON"
		then
			if item_subtype ~= "Daggers" then
				Hardcore:Print("Equiped " .. item_name .. ".")
				shivved_achievement.fail_function_executor.Fail(shivved_achievement.name)
			end
		end
	end
end)