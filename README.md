quest system_warp_map_coffee begin
    state start begin
        when 9012.click or 40002.use begin
			minHp = 15000
			if pc.get_hp() < minHp then syschat(string.format("[System]:Sorry, you can't navigate because the blood level is less than %s thousand",math.floor(minHp/1000))) setskin(NOWINDOW) return end -- Convert it to a comment if your server is fully PVP
			local index = 0
			local saveNameListMaps = {}
			local listMaps = {
				{ "Empires",			469300		,964200,	5, {
					{"Shinsoo-Yongan"		,469300		,964200,	10},
					{"Shinsoo-Yayang"		,353100		,882900,	5},
					{"Chunjo-Joan"			,55700		,157900,	5},
					{"Chunjo-Bokjung"		,145500		,240000,	5},
					{"Jinno-Pyungmoo"		,969600		,278400,	5},
					{"Jinno-Bakra"			,863900		,246000,	5}
				}},
				{"Land Boss"			,3228300	,959000,	250	,false},
				{"Grotto Exile"			,241300		,1275500,	75	,{
					{"Grotto-V1"			,10000		,1207800,	75},
					{"Grotto-V2"			,241300		,1275500,	75},
					{"Grotto-Boss"			,180400		,1221100,	75}
				}},
				{"Spider Dungeons"		,91700		,525300,	10	,{
					{"Spider-V1"			,92000	,525400,	10},
					{"Spider-V2"			,702400	,524100,	10},
					{"Spider-V3"			,51200	,563200,	75},
					{"Spider-Boss"			,51200	,563200,	75}
				}},
				{"Doyyumhwan"			,601000 	,684200,	75	,false},
				{"Mount Sohan"			,434400		,218600,	5	,false},
				{"Hwang Temple"					,553600		,145000,	5	,false}
			}
			for i=1,table.getn(listMaps),1 do table.insert(saveNameListMaps,string.format("%s %s", listMaps[i][1], listMaps[i][4])) end
			table.insert(saveNameListMaps,"Exit")
			while index < 1 do
				say_title(mob_name(9012))
				say("Choose what you want to go to![ENTER]")
				local indexMap = select_table(saveNameListMaps)
				if saveNameListMaps[indexMap] == "Exit" then return end
				if pc.get_level() < listMaps[indexMap][4] then say_title(mob_name(9012)) say(string.format("Sorry %s[ENTER]Your level is low you must be at least %s[ENTER] to move to %s[ENTER][ENTER][ENTER]", pc.getname(),listMaps[indexMap][4],listMaps[indexMap][1])) return end
				if listMaps[indexMap][5] != false then
					local saveNameListMapsOption = {}
					for ii=1, table.getn(listMaps[indexMap][5]),1 do table.insert(saveNameListMapsOption,listMaps[indexMap][5][ii][1]) end
					table.insert(saveNameListMapsOption,"back") table.insert(saveNameListMapsOption,"Exit")
					say_title(mob_name(9012))
					say(string.format("Choose what you want to go to in the list %s[ENTER]", listMaps[indexMap][1]))
					local indexMapOption = select_table(saveNameListMapsOption)
					if saveNameListMapsOption[indexMapOption] == "Exit" then return elseif saveNameListMapsOption[indexMapOption] != "back" then
						if pc.get_level() < listMaps[indexMap][5][indexMapOption][4] then say_title(mob_name(9012)) say(string.format("Sorry %s[ENTER]Your level is low you must be at least %s[ENTER] to move to %s[ENTER][ENTER][ENTER]", pc.getname(),listMaps[indexMap][5][indexMapOption][4],listMaps[indexMap][5][indexMapOption][1])) return end
						say_title(mob_name(9012)) say(string.format("You will be taken to the %s map [ENTER][ENTER][ENTER][ENTER][ENTER][ENTER][ENTER]", saveNameListMapsOption[indexMapOption]))
						local optionWarp = select("Go", "Exit") if optionWarp == 1 then pc.warp( listMaps[indexMap][5][indexMapOption][2], listMaps[indexMap][5][indexMapOption][3]) else return end
						return
					else
						index = 0
					end
				else
					say_title(mob_name(9012)) say(string.format("You will be taken to the %s map [ENTER][ENTER][ENTER][ENTER][ENTER][ENTER][ENTER]", listMaps[indexMap][1]))
					local optionWarp = select("Go", "Exit") if optionWarp == 1 then pc.warp( listMaps[indexMap][2], listMaps[indexMap][3]) else return end
				end
			end
		end
	end
end
