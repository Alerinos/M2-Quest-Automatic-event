-- Author Alerino
-- Version 1.0
-- Date 12.06.2020
-- Github https://github.com/Alerinos

quest event begin
    state start begin
        -- Komunikat
        when login begin
            local timestmp = os.time(os.date("!*t"))
           
            -- GM LEVEL
               -- 0 - player
               -- 1 - low_wizard
               -- 2 - wizard
               -- 3 - hight_wizard
               -- 4 - god
               -- 5 - implementor
            if pc.get_gm_level() >= 3 then
               send_letter("[GM] Event")
            end
           
            if game.get_event_flag("event_gold_bar") > 0 and game.get_event_flag("event_gold_bar_time") >= timestmp then
                notice("[EVENT] Gold Bar. It's still left "..secondsToTime(game.get_event_flag("event_gold_bar_time") - timestmp))
            end
            
            if game.get_event_flag("event_valentine") > 0 and game.get_event_flag("event_valentine_time") >= timestmp then
                notice("[EVENT] Valentine's Day. It's still left "..secondsToTime(game.get_event_flag("event_valentine_time") - timestmp))
            end
           
            if game.get_event_flag("event_moonlight") > 0 and game.get_event_flag("event_moonlight_time") >= timestmp then
               notice("[EVENT] "..item_name(50011)..". It's still left "..secondsToTime(game.get_event_flag("event_moonlight_time") - timestmp))
            end
           
            if game.get_event_flag("event_cards") > 0 and game.get_event_flag("event_cards_time") >= timestmp then
                notice("[EVENT] "..item_name(79505).." min. level 35. It's still left "..secondsToTime(game.get_event_flag("event_cards_time") - timestmp))
                cmdchat("cards icon")
            end
           
        end
        
        when kill with not npc.is_pc() begin
            local min = npc.get_level0() - 15
            local max = npc.get_level0() + 15
            local lvl = pc.get_level()
            local timestmp = os.time(os.date("!*t"))
        
            -- Szkatułka blasku
            if pc.get_map_index() ~= 1 and math.random(1000) <= game.get_event_flag("event_moonlight") and lvl >= min and lvl <= max and game.get_event_flag("event_moonlight_time") >= timestmp then
                pc.give_item2(50011)
            end
            
            -- Walentynki
            if pc.get_map_index() ~= 1 and math.random(1000) <= game.get_event_flag("event_valentine") and lvl >= min and lvl <= max and game.get_event_flag("event_valentine_time") >= timestmp then
                pc.give_item2(71146)
            end
        
            -- Sztabki
            if pc.get_map_index() ~= 1 and math.random(1000) <= game.get_event_flag("event_gold_bar") and lvl >= min and lvl <= max and game.get_event_flag("event_gold_bar_time") >= timestmp then
                local rand = math.random(1, 100)
                
                if rand >= 80 then
                    game.drop_item_with_ownership(80007)
                elseif rand >= 50 then
                    game.drop_item_with_ownership(80006)
                else
                    game.drop_item_with_ownership(80005)
                end
            end
            
            -- okey
            if lvl <= 35 and math.random(1000) <= game.get_event_flag("event_cards") and lvl >= min and lvl <= max and game.get_event_flag("event_cards_time") >= timestmp then
                pc.give_item2(79505)
                
                if pc.count_item(79505) >= 24 then
                    pc.remove_item(79505, 24)
                    pc.give_item2(79506)
                end
            end
        end
        
        
        when button or info begin
            local timestmp = os.time(os.date("!*t"))
            
            say("Event name")
            say("- moonlight")
            say("- valentine")
            say("- gold_bar")
            say("- cards")
            local name = input()
            
            say("Percent 0-1000, 10 = 1%")
            local percent = input()
        
            say("Day")
            local d = input()
            
            say("Month")
            local m = input()
            
            say("Hour")
            local h = input()
        
            local t = os.time({year=os.date("%Y"), month=m, day=d, hour=h, min=0, sec=0})
            
            say("Event: "..name)
            say("Percent "..(percent/10).."%")
            say("Valid until")
            say(d.."."..m.."."..os.date("%Y").." "..h..":00:00")
            say("It will end in "..secondsToTime(t - timestmp))
        
            if select("Accept", "Cancel") == 1 then
                game.set_event_flag("event_"..name, percent)
                game.set_event_flag("event_"..name.."_time", t)
                syschat("Active event")
                notice_all("The event has been activated. You must make a relog.")
            end
         
        end
    
        
    end
end