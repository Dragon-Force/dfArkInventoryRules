local rule = ArkInventoryRules:NewModule( "df-ArkInventoryRules" )

function rule:OnEnable( )
	local registered
	registered = ArkInventoryRules.Register( self, "addon", rule.execute_addon )
end

function rule.execute_addon( ... )
	-- always check for the hyperlink and that it's an actual item, not a spell (pet/mount)
	if not ArkInventoryRules.Object.h or ArkInventoryRules.Object.class ~= "item" then
		return false
	end

	local fn = "addon"
	local ac = select( '#', ... )

	if ac == 0 then
		error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_NONE_SPECIFIED"], fn ), 0 )
	end

	for ax = 1, ac do -- loop through the supplied ... arguments
		local arg = select( ax, ... ) -- select the argument were going to work with

		if type( arg ) == "number" then
            arg = arg .. ""
			if not items_list[arg] then
                error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_IS_NOT"], fn, ax, "1-7" ), 0 )
            end
            local id = ArkInventoryRules.Object.info.id .. ""
            if items_list[arg][id] then
                return true
            end
		else
			error( string.format( ArkInventory.Localise["RULE_FAILED_ARGUMENT_IS_NOT"], fn, ax, string.format( "%s", ArkInventory.Localise["NUMBER"] ) ), 0 )
		end
	end

	-- always return false at the end
	return false

end
