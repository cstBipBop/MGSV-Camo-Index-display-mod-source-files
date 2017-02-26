local e={}
local TppDefine=TppDefine
local _=TppGameObject
local PlayerPartsType=PlayerPartsType
local PlayerCamoType=PlayerCamoType
local echo=TppUiCommand.AnnounceLogView

e.index={sight={}}
e.index.sight.camo={discovery=840,indis=390,dim=260,far=0}
e.index.sight.distance={
	day={contact=2,discovery=10,indis=20,dim=45,far=70,observe=200},
	night={contact=2,discovery=10,indis=15,dim=35,far=false,observe=false}
}
e.index.points={
	speed={idle=10,evade=0,walk=-10,crawl=-20,jog=-30,dash=-60},
	stance={prone=50,crouch=10,stand=0,fall=0,trash=0},
	material={bush=100,surface=50,cover=10,none=0},
	weather={fog=1.5,sandstorm=1.4,normal=1},
	time={day=0,night=0.5},
	light={night=10,shadow=10,ambient=-20,flare=-40,searchlight=-60},--need to figure out how to actually check these; maybe TppDamage checks?
	gun={suppressor=0,flash=-60}
}

--still need checks for:
	--player in stealth mode while prone (+10)
	--in shadow (+10)
	--material collision check for camo bonus instead of by location (+10)
	--get itemID of cbox for overriding fatigue camo when PlayerStatus.CBOX
	--is using parasite ability or stealth camo
	--collision check for in grass; half-body (+20) entire body (+30)
	--searchlight illumination (-60)
	--flare illumination (-40)
	--ambient lightsource illumination (-20)

	--USE_CHICKEN_CAP
	--USE_CHICK_CAP
	--USE_STEALTH
	--USE_INSTANT_STEALTH
	--USE_PARASITE_CAMO

	--CHARA_COLLISION_DATA
--

--exe misc
	--cloakEnabled
	--TppPlayer2
		--equip
	--TppPlayer2Parameter
		--clipCount
		--fireInterval
	--isLightOn
	--itemIndex
	--
--

e.cloth={
	green={
		PlayerCamoType.OLIVEDRAB,
		PlayerCamoType.WOODLAND,
		PlayerCamoType.C23,
		PlayerCamoType.C24,
		PlayerCamoType.C29,
		PlayerCamoType.C30,
		PlayerCamoType.C16,
		PlayerCamoType.C19,
		PlayerCamoType.C20,
		PlayerCamoType.C22,
		PlayerCamoType.C26,
		PlayerCamoType.C28,
		PlayerCamoType.C31,
		PlayerCamoType.C56,
		PlayerCamoType.C57,
		PlayerCamoType.C58,
		PlayerCamoType.C59,
		PlayerCamoType.C60
	},
	desert={
		PlayerCamoType.FOXTROT
	},
	mix={
		PlayerCamoType.PANTHER,
		PlayerCamoType.SANDSTORM,
		PlayerCamoType.MGS3,
		PlayerCamoType.MGS3_NAKED,
		PlayerCamoType.EVA,
		PlayerCamoType.EVA_OPEN
	},
	red={
		PlayerCamoType.GOLDTIGER
	},
	wet={
		PlayerCamoType.WETWORK,
		PlayerCamoType.ARBANBLUE,
		PlayerCamoType.C27,
		PlayerCamoType.C17,
		PlayerCamoType.C32
	},
	rock={
		PlayerCamoType.TIGERSTRIPE,
		PlayerCamoType.C35,
		PlayerCamoType.C18,
		PlayerCamoType.C25,
		PlayerCamoType.C33
	},
	urban={
		PlayerCamoType.SQUARE,
		PlayerCamoType.ARBANGRAY,
		PlayerCamoType.C38,
		PlayerCamoType.C39,
		PlayerCamoType.C42,
		PlayerCamoType.C46,
		PlayerCamoType.C49,
		PlayerCamoType.C52,
		PlayerCamoType.C36,
		PlayerCamoType.C37,
		PlayerCamoType.C40,
		PlayerCamoType.C41,
		PlayerCamoType.C43,
		PlayerCamoType.C44,
		PlayerCamoType.C45,
		PlayerCamoType.C47,
		PlayerCamoType.C48,
		PlayerCamoType.C50,
		PlayerCamoType.C51,
		PlayerCamoType.C53,
		PlayerCamoType.C54,
		PlayerCamoType.C55
	},
	vehicle={PlayerCamoType.SPLITTER},
	night={PlayerCamoType.BLACK}
}
e.parts={
	used={
		PlayerPartsType.NORMAL,
		PlayerPartsType.NORMAL_SCARF,
		PlayerPartsType.NAKED
	},
	other={
		PlayerPartsType.HOSPITAL,
		PlayerPartsType.AVATAR_EDIT_MAN
	},
}
e.vehicle={
	mbt={Vehicle.type.EASTERN_TRACKED_TANK,Vehicle.type.WESTERN_TRACKED_TANK},
	ifv={Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE,Vehicle.type.WESTERN_WHEELED_ARMORED_VEHICLE},
	truck={Vehicle.type.EASTERN_TRUCK,Vehicle.type.WESTERN_TRUCK},
	jeep={Vehicle.type.EASTERN_LIGHT_VEHICLE,Vehicle.type.WESTERN_LIGHT_VEHICLE}
}
e.debug={}
e.debugTable={}
e.debugTable.playerStatus={
	'STAND',--standing; false if HORSE_STAND; true when ON_VEHICLE
	'SQUAT',--crouching or doing cbox slide
	'CRAWL',--prone or when CBOX_EVADE
	'NORMAL_ACTION',--true for most generic on-foot movement-related actions including STOP; false when ON_VEHICLE or ON_HORSE or CBOX
	'PARALLEL_MOVE',--aiming
	'IDLE',
	'GUN_FIRE',--true even with suppressor; GUN_FIRE and GUN_FIRE_SUPPRESSOR not true with player vehicle weapons
	'GUN_FIRE_SUPPRESSOR',--true when discharge with suppressor; GUN_FIRE also true when this
	'STOP',--when idle on foot or cbox; true when CBOX_EVADE; always true if ON_VEHICLE; 
	'WALK',--slow speed
	'RUN',--default speed
	'DASH',--fast speed
	'ON_HORSE',--piloting D-Horse
	'ON_VEHICLE',--piloting vehicle
	'ON_HELICOPTER',
	'HORSE_STAND',
	'HORSE_HIDE_R',
	'HORSE_HIDE_L',
	'HORSE_IDLE',--HORSE_[speed] also used for D-Walker
	'HORSE_TROT',--slow speed
	'HORSE_CANTER',--default speed
	'HORSE_GALLOP',--fast speed
	'BINOCLE',--using int-scope
	'SUBJECT',--first-person camera
	'INTRUDE',
	'LFET_STOCK',
	'CUTIN',--placing guard in something (probably dev typo for PUT_IN)
	'DEAD',
	'DEAD_FRESH',
	'NEAR_DEATH',
	'NEAR_DEAD',
	'FALL',
	'CBOX',--true while in cbox and not sliding and not CBOX_EVADE
	'CBOX_EVADE',--crawling out of cbox; CBOX false if true
	'TRASH_BOX',
	'TRASH_BOX_HALF_OPEN',
	'INJURY_LOWER',
	'INJURY_UPPER',
	'CURE',
	'CQC_CONTINUOUS',
	'BEHIND',--pressed against cover/wall
	'ENABLE_TARGET_MARKER_CHECK',
	'UNCONSCIOUS',
	'PARTS_ACTIVE',--seems to always be true when deployed or in ACC
	'CARRY',
	'CURTAIN',
	'VOLGIN_CHASE'
}
e.debugTable.buttons={
	'DECIDE',
	'STANCE',
	'DASH',
	'HOLD',
	'FIRE',
	'RIDE_ON',
	'RIDE_OFF',
	'ACTION',
	'MOVE_ACTION',
	'JUMP',
	'RELOAD',
	'STOCK',
	'ZOOM_CHANGE',
	'VEHICLE_CHANGE_SIGHT',
	'MB_DEVICE',
	'CALL',
	'INTERROGATE',
	'SUBJECT',
	'UP',
	'PRIMARY_WEAPON',
	'DOWN',
	'SECONDARY_WEAPON',
	'LEFT',
	'RIGHT',
	'VEHICLE_LIGHT_SWITCH',
	'VEHICLE_TOGGLE_WEAPON',
	'CQC',
	'SIDE_ROLL',
	'LIGHT_SWITCH',
	'EVADE',
	'VEHICLE_FIRE',
	'VEHICLE_CALL',
	'VEHICLE_DASH',
	'BUTTON_PLACE_MARKER',
	'PLACE_MARKER',
	'ESCAPE'
}

function e.playerPressed(button)
	if (bit.band(PlayerVars.scannedButtonsDirect,PlayerPad[button])==PlayerPad[button]) then
		return true
	end
	return false
end

function e.playerStatus(status)
	if PlayerInfo.AndCheckStatus{PlayerStatus[status]} then
		return true
	end
	return false
end

function e.debug:buttonsOrStatus(check)
	if not self or not check then return end
	local t={}
	if check=='buttons' then
		for i=1,#self do
			t[self[i]]=e.playerPressed(self[i])
		end
		for k,v in pairs(t) do
			if v then
				echo(k..'=='..tostring(v))
			end
		end
		return
	elseif check=='status' then
		for i=1,#self do
			t[self[i]]=e.playerStatus(self[i])
		end
		for k,v in pairs(t) do
			if v then
				echo(k..'='..tostring(v))
			end
		end
		return
	end
	return
end

function e.checkCamouflage(camo)
	local t=e.cloth
	local s={'green','desert','mix','red','wet','rock','urban','vehicle','night'}
	for i=1,#s do
		for _,v in ipairs(t[s[i]]) do
			if camo==v then
				return s[i]
			end
		end
	end
	return 'none'
end

function e.checkParts(part,camo)
	for i=1,#e.parts.used do
		if part==e.parts.used[i] then
			return e.checkCamouflage(camo)
		end
	end
	return 'other'
end

function e.checkTime(gameTime)
	if gameTime=='night' then
		return true
	end
	return false
end

function e.checkWeather(weather)
	if weather==TppDefine.WEATHER.FOGGY then
		return 'fog'
	elseif weather==TppDefine.WEATHER.SANDSTORM then
		return 'sandstorm'
	end
	return 'normal'
end
--[[
function e.checkMaterialCollision()
	local a=TppPlaced.GetCaptureCageInfo()
	for t,a in pairs(a)do
		local a,e,t,t=TppPlayer.EvaluateCaptureCage(a.x,a.z,a.grade,a.material)
		if a.material then
			if type(a.material)=={} then
				for k,v in pairs(a.material) do
					echo(k..' = '..v)
				end
			elseif type(a.material)==0 or type(a.material)=='' then
				echo(a.material)
			end
		end
	end
end]]

function e.checkLocation(location)
	if location==TppDefine.LOCATION_ID.AFGH then
		return 'AFGH'
	elseif location==TppDefine.LOCATION_ID.MAFR then
		return 'MAFR'
	elseif location==TppDefine.LOCATION_ID.MTBS or location==TppDefine.LOCATION_ID.MBQF then
		return 'MTBS'
	end
	echo('invalid result in checkLocation(): '..tostring(location))
	return 'other'
end

function e.checkMission(missionCode)
	if missionCode==30010 or missionCode==30020 then
		return true
	end
	return false
end

function e.checkGunfire()
	if e.playerStatus('GUN_FIRE') and not e.playerStatus('GUN_FIRE_SUPPRESSOR') then
		return true
	end
	return false
end

function e.debug:updateVars()
	if not self or #self<2 then return end
	for i=1,(#self-1) do
		echo(self[i])
	end
end

function e.checkCboxType()
	--if vars.weapons[TppDefine.WEAPONSLOT.PRIMARY_BACK]==TppEquip.EQP_None then
end

function e.checkStatus()
	local speed='dash'
	local stance='stand'
	local ride='none'
	local is=e.playerStatus

	if is('STOP') or is('HORSE_IDLE') or is('IDLE') then
		speed='idle'
	elseif is('WALK') or is('HORSE_TROT') then
		speed='walk'
	elseif is('RUN') or is('HORSE_CANTER') then
		speed='jog'
	end

	if is('CRAWL') then
		stance='prone'
	elseif is('SQUAT') or is('HORSE_HIDE_L') or is('HORSE_HIDE_R') then
		stance='crouch'
	end

	if is('ON_HORSE') then
		ride='horse'
	elseif is('HORSE_IDLE') or is('HORSE_TROT') or is('HORSE_CANTER') or is('HORSE_GALLOP') then
		ride='dwalker'
	elseif is('ON_VEHICLE') then
		ride='vehicle'
	elseif is('ON_HELICOPTER') then
		ride='helicopter'
	elseif stance=='stand' then
		if is('FALL') then
			stance='fall'
		end
	elseif stance=='crouch' or stance=='prone' then
		if speed=='dash' then
			speed='jog'
		end
	elseif is('CBOX') then
		ride='cbox'
	elseif is('DASH') and is('SQUAT') then
		ride='cbox'
	end

	if is('CARRY') and not is('CUTIN') then
		ride='carry'
	end

	return ride,stance,speed
end

function e.calculate(ci)
	if ci then
		local n=e.index.sight.camo
		if ci<n.far then
			ci=(n.far-200)
		else
			ci=(ci-200)
		end
		ci=(math.floor((ci/(n.discovery-200))*1000)/10)
		echo('CI: '..ci..'%')
	end
	return
end

function e.Update()
	if e.playerPressed('RELOAD') then
		if ((Time.GetRawElapsedTimeSinceStartUp()-e.buttonHold)>1) then
			--echo('press')
			e.buttonHold=Time.GetRawElapsedTimeSinceStartUp()
			local vars=vars
			local guardPhase=vars.playerPhase
			--local playerXYZ=Vector3(vars.playerPosX,vars.playerPosY,vars.playerPosZ) or false
			local camo=e.checkParts(vars.playerPartsType,vars.playerCamoType)--str
			--local material=e.checkMaterialCollision()
			--echo(tostring(material))
			local gameTime=e.checkTime(TppClock.GetTimeOfDay())--str
			local weather=e.checkWeather(vars.weather)--str
			local location=e.checkLocation(vars.locationCode)--str
			local ride,stance,speed=e.checkStatus()
			local gunfire=e.checkGunfire()--bool
			local inCover=e.playerStatus('BEHIND')--bool
			local freeroam=e.checkMission(vars.missionCode)--bool

			e.debug.updateVars({
			--	'camo: '..camo,
			--	'part: '..part,
			--	'time: '..gameTime,
			--	'weather: '..weather,
			--	'location: '..location,
			--	'ride: '..tostring(ride),
				--'enclosed: '..tostring(enclosed),
			--	'move: '..tostring(move),
			--	'stance: '..stance,
			--	'speed: '..speed,
			--	'gunfire: '..tostring(gunfire),
			--	'freeroam: '..tostring(freeroam),
			--	'mCode: '..tostring(vars.missionCode),
			--	'missionCode: '..tostring(missionCode),
				'-'
			})
			--e.debug.buttonsOrStatus(e.debugTable.playerStatus,'status')

			local ci=200--camo index base value
			local n=e.index.sight.camo.discovery--max; 840

			local p=e.index.points
			if gameTime then
				n=n*p.time.night
				n=n*p.weather[weather]
				ci=n
				if camo=='night' then
					ci=ci+p.material.surface
				end
			else
				n=ci
				n=n*p.weather[weather]
				ci=n
			end
			if gunfire then
				ci=ci+p.gun.flash
			end
			ci=ci+p.stance[stance]
			--ci=ci+p.speed[speed]
			--n=nil
			--echo('prior to calculate()')
			if ride=='helicopter' then
				ci=ci+p.speed[speed]
				if guardPhase==_.PHASE_STEALTH then
					e.calculate(ci)
				else
					e.calculate(n.far)
				end
				return
			end

			if freeroam and ride=='vehicle' then
				ci=ci+p.speed[speed]
				if guardPhase~=_.PHASE_COMBAT then
					if camo=='vehicle' then
						e.calculate(n.discovery)
					else
						e.calculate(n.indis)
					end
				else
					if camo=='vehicle' then
						ci=ci+p.material.surface
					end
					e.calculate(ci)
				end
				return
			end

			if ride=='dwalker' then
				if camo=='vehicle' then
					ci=ci+p.material.surface
				end
				if stance=='stand' then
					ci=ci+p.speed[speed]
				else
					if speed=='idle' then
						ci=ci+p.speed[speed]
					else
						ci=ci+p.speed.walk
					end
				end
				e.calculate(ci)
				return
			end

			if ride=='cbox' then
				if guardPhase~=_.PHASE_COMBAT then
					if speed=='idle' and (stance=='prone' or stance=='crouch') then
						e.calculate(n.discovery)
						return
					end
				end
			end

			if speed=='idle' then
				ci=ci+p.speed.idle
			elseif stance=='stand' then
				ci=ci+p.speed[speed]
			elseif stance=='crouch' then
				ci=ci+p.speed[speed]
			else
				ci=ci+p.speed[speed]
			end

			if inCover then
				ci=ci+p.material.cover
			end

			if camo~='none' and camo~='other' then
				if camo~='black' and camo~='vehicle' then
					if location=='AFGH' then
						if camo=='desert' or camo=='mix' or camo=='rock' or camo=='wet' or camo=='urban' then
							ci=ci+p.material.surface
						end
					elseif location=='MAFR' then
						ci=ci+p.material.surface
					elseif location=='MTBS' then
						if camo=='urban' then
							ci=ci+p.material.surface
						end
					end
				elseif camo=='vehicle' and ride=='vehicle' then
					ci=ci+p.material.surface
				end
			elseif ride=='carry' then
				ci=ci+p.material.surface
			end
			e.calculate(ci)
			--echo('after calculate()')
			return
		end
	else
		e.buttonHold=Time.GetRawElapsedTimeSinceStartUp()
	end
end
--[[
To do:
	- CBOX: check current equipped item itemID when PlayerStatus.CBOX and when doing cbox slide to override fatigue camo with cbox camo type
Limitations:
	- Camo surface bonus being given if material type exists at location rather than by catching player collision with material. Need to experiment with getting info from Capture Cage functions.
	- Player illumination not checked. Might be able to do partial with OnDamage() ATK_Flashlight and ATK_FlashlightAttack
	- No status check for prone stealth mode. Might be possible by keeping track of action button press
	- No status check for vehicle weapon discharge. Need to add vehicle fire button press to calculation. Will still need to get ammo count at some point.
	- Free Roam enclosed vehicle bonus being given for piloting any deployable vehicle. Need to figure out how to detect player vehicle name to differentiate.
	- No status check for vehicle speed. PlayerStatus always returns STOP.
	- Hiding in truck cabin is not checked. PlayerStatus always STAND in vehicles. Button could be checked but would still need to detect player vehicle name.
	- Stealth Camouflage and parasite abilities not factored into index.
]]
return e
