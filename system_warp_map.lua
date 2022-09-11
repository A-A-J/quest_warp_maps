--[[
by: coffee
url: https://discord.com/users/927741280946094131
date: 11-09-2022
des: These lines were created by coffee, the idea is that the player will be taken from one map to another with several sub-options displayed for example: empires and then when clicked it will show several empires
expl: The map information is included within the "listMaps" matrix, and the number of columns is 5. [Column 1 = map name] [Column 2 = Y] [Column 3 = X] [Column 4 = Level] [Column 5 = Submaps]
]]--
quest system_warp_map_coffee begin
    state start begin
        when 9012.click or 40002.use begin
			minHp = 12000
			if pc.get_hp() < minHp then syschat(string.format("[������]: ��� ������� �������� ��� ����� ���� ��� �� %s ��� ",math.floor(minHp/1000))) setskin(NOWINDOW) return end -- Convert it to a comment if your server is fully PVP
			local index = 0
			local saveNameListMaps = {}
			local listMaps = {
				{ "������������� ",					469300		,964200,	5, {
					{"���������� ������� - ������ "		,469300		,964200,	10},
					{"���������� ������� - ������ "		,353100		,882900,	5},
					{"���������� ������� - ���� "		,55700		,157900,	5},
					{"���������� ������� - ������� "	,145500		,240000,	5},
					{"���������� ������ - ������� "		,969600		,278400,	5},
					{"���������� ������ - ����� "		,863900		,246000,	5}
				}},
				{"��� ������� "						,3228300	,959000,	250	,false},
				{"��� ������ "						,241300		,1275500,	75	,{
					{"��� ������ - ����� ����� "			,10000		,1207800,	75},
					{"��� ������ - ����� ������ "		,241300		,1275500,	75},
					{"��� ������ - ����� ������ "		,180400		,1221100,	75}
				}},
				{"��� ������� "						,91700		,525300,	10	,{
					{"��� ������� - ������ ����� "		,92000	,525400,	10},
					{"��� ������� - ������ ������ "		,702400	,524100,	10},
					{"��� ������� - ������ ������ "		,51200	,563200,	75},
					{"��� ������� - ����� ������ "		,51200	,563200,	75}
				}},
				{"��� ����� "						,601000 	,684200,	75	,false},
				{"��� ����� "						,434400		,218600,	5	,false},
				{"��������� "						,436900		,215900,	5	,false},
				{"������ ������� "					,553600		,145000,	5	,false}
			}
			for i=1,table.getn(listMaps),1 do table.insert(saveNameListMaps,string.format("%s����� %s", listMaps[i][1], listMaps[i][4])) end
			table.insert(saveNameListMaps,"������ ")
			while index < 1 do
				say_title(mob_name(9012))
				say("���� �� ��� ������� ��![ENTER]")
				local indexMap = select_table(saveNameListMaps)
				if saveNameListMaps[indexMap] == "������ " then return end
				if pc.get_level() < listMaps[indexMap][4] then say_title(mob_name(9012)) say(string.format("���� �� %s[ENTER]�� ������ ����� ��� �� ���� ��� ����� %s[ENTER]�������� ��� %s[ENTER][ENTER][ENTER]", pc.getname(),listMaps[indexMap][4],listMaps[indexMap][1])) return end
				if listMaps[indexMap][5] != false then
					local saveNameListMapsOption = {}
					for ii=1, table.getn(listMaps[indexMap][5]),1 do table.insert(saveNameListMapsOption,listMaps[indexMap][5][ii][1]) end
					table.insert(saveNameListMapsOption,"������ ") table.insert(saveNameListMapsOption,"������ ")
					say_title(mob_name(9012))
					say(string.format("���� �� ��� ������� �� �� ����� %s[ENTER]", listMaps[indexMap][1]))
					local indexMapOption = select_table(saveNameListMapsOption)
					if saveNameListMapsOption[indexMapOption] == "������ " then return elseif saveNameListMapsOption[indexMapOption] != "������ " then
						if pc.get_level() < listMaps[indexMap][5][indexMapOption][4] then say_title(mob_name(9012)) say(string.format("���� �� %s[ENTER]�� ������ ����� ��� �� ���� ��� ����� %s[ENTER]�������� ��� %s[ENTER][ENTER][ENTER]", pc.getname(),listMaps[indexMap][5][indexMapOption][4],listMaps[indexMap][5][indexMapOption][1])) return end
						say_title(mob_name(9012)) say(string.format("���� ���� ��� ����� %s[ENTER][ENTER][ENTER][ENTER][ENTER][ENTER][ENTER]", saveNameListMapsOption[indexMapOption]))
						local optionWarp = select("�������� ", "������ ") if optionWarp == 1 then pc.warp( listMaps[indexMap][5][indexMapOption][2], listMaps[indexMap][5][indexMapOption][3]) else return end
						return
					else
						index = 0
					end
				else
					say_title(mob_name(9012)) say(string.format("���� ���� ��� ����� %s[ENTER][ENTER][ENTER][ENTER][ENTER][ENTER][ENTER]", listMaps[indexMap][1]))
					local optionWarp = select("�������� ", "������ ") if optionWarp == 1 then pc.warp( listMaps[indexMap][2], listMaps[indexMap][3]) else return end
				end
			end
		end
	end
end