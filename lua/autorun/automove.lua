if CLIENT then
	local AutomoveToggle = false
	local AutomoveMode = 0

	concommand.Add("automove", function (ply, cmd)
		AutomoveToggle = !AutomoveToggle
	end )
	concommand.Add("automove_mode", function (ply, cmd)
		if AutomoveMode == 0 then
			AutomoveMode = 1
			ply:PrintMessage(HUD_PRINTCENTER, "Automove Mode = Sprint")
		elseif AutomoveMode == 1 then
			AutomoveMode = 2
			ply:PrintMessage(HUD_PRINTCENTER, "Automove Mode = Walk")
		elseif AutomoveMode == 2 then
			AutomoveMode = 0
			ply:PrintMessage(HUD_PRINTCENTER, "Automove Mode = Run")
		end
	end )

	hook.Add( "StartCommand", "Automove", function( ply, cmd )
		
		if AutomoveToggle == true then
			if not ply:IsPlayer() or !ply:Alive() then return end
			
			if AutomoveMode == 0 then
				cmd:SetForwardMove( ply:GetWalkSpeed() )
				if ply:KeyDown( 512 ) then
					cmd:SetSideMove( -ply:GetWalkSpeed() )
				elseif ply:KeyDown ( 1024 ) then
					cmd:SetSideMove( ply:GetWalkSpeed() )
				end
			elseif AutomoveMode == 1 then
				cmd:SetForwardMove( ply:GetRunSpeed() )
				cmd:AddKey(IN_SPEED)
				if ply:KeyDown( 512 ) then
					cmd:SetSideMove( -ply:GetRunSpeed() )
				elseif ply:KeyDown ( 1024 ) then
					cmd:SetSideMove( ply:GetRunSpeed() )
				end
			elseif AutomoveMode == 2 then
				cmd:SetForwardMove( ply:GetSlowWalkSpeed() )
				if ply:KeyDown( 512 ) then
					cmd:SetSideMove( -ply:GetSlowWalkSpeed() )
				elseif ply:KeyDown ( 1024 ) then
					cmd:SetSideMove( ply:GetSlowWalkSpeed() )
				end
			end
		else
			return
		end
	end )
end
