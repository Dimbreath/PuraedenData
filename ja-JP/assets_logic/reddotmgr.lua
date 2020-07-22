-- params : ...
-- function num : 0 , upvalues : _ENV
RedDotMgr = {}
local winConList = {}
local RedDotList = {}
-- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

RedDotMgr.Init = function(...)
  -- function num : 0_0 , upvalues : _ENV
  local winName = (WinResConfig.HomeWindow).name
  ;
  (RedDotMgr.RegisterRootNode)(winName, RedDotComID.Home_Main, -1, "")
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.Home_Character, RedDotComID.Home_Main)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.Home_Talent, RedDotComID.Home_Main)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.Home_Equip, RedDotComID.Home_Main)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.Home_Adventure, RedDotComID.Home_Main)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.Home_Handbook, RedDotComID.Home_Main)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.Home_Shop, RedDotComID.Home_Main)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.Home_Union, RedDotComID.Home_Main)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.Home_Lottery, RedDotComID.Home_Main)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.Home_Task, RedDotComID.Home_Main)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.Home_Mail, RedDotComID.Home_Main)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.Home_Activity, RedDotComID.Home_Main)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.Home_AssetShop, RedDotComID.Home_Main)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.Home_SevenTask, RedDotComID.Home_Main)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.Home_Announcement, RedDotComID.Home_Main)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.Home_bag, RedDotComID.Home_Main)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.Home_Setting, RedDotComID.Home_Main)
  winName = (WinResConfig.ActorInfoWindow).name
  ;
  (RedDotMgr.RegisterRootNode)(winName, RedDotComID.Setting_Main, RedDotComID.Home_Setting, (WinResConfig.HomeWindow).name)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.Setting_Title, RedDotComID.Setting_Main)
  winName = (WinResConfig.TitleWindow).name
  ;
  (RedDotMgr.RegisterRootNode)(winName, RedDotComID.Title_Main, RedDotComID.Setting_Title, (WinResConfig.ActorInfoWindow).name)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.Title_List, RedDotComID.Title_Main)
  winName = (WinResConfig.TaskWindow).name
  ;
  (RedDotMgr.RegisterRootNode)(winName, RedDotComID.Task_Main, RedDotComID.Home_Task, (WinResConfig.HomeWindow).name)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.Task_Daily, RedDotComID.Task_Main)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.Task_Weekly, RedDotComID.Task_Main)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.Task_GrowUp, RedDotComID.Task_Main)
  winName = (WinResConfig.AnnouncementWindow).name
  ;
  (RedDotMgr.RegisterRootNode)(winName, RedDotComID.Announcement_Main, RedDotComID.Home_Announcement, (WinResConfig.HomeWindow).name)
  ;
  (RedDotMgr.RegisterNodeWithList)(winName, RedDotComID.Announcement_List, RedDotComID.Announcement_Main)
  winName = (WinResConfig.ShopWindow).name
  ;
  (RedDotMgr.RegisterRootNode)(winName, RedDotComID.Shop_Main, RedDotComID.Home_Shop, (WinResConfig.HomeWindow).name)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.Shop_Grocer, RedDotComID.Shop_Main)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.Shop_Mystical, RedDotComID.Shop_Main)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.Shop_Token, RedDotComID.Shop_Main)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.Shop_Expedition, RedDotComID.Shop_Main)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.Shop_Gift, RedDotComID.Shop_Main)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.Moon_Res, RedDotComID.Shop_Gift)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.Moon_Dia, RedDotComID.Shop_Gift)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.FREE_GIFT, RedDotComID.Shop_Gift)
  winName = (WinResConfig.AdventureWindow).name
  ;
  (RedDotMgr.RegisterRootNode)(winName, RedDotComID.Adventure_Main, RedDotComID.Home_Adventure, (WinResConfig.HomeWindow).name)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.Adventure_Story, RedDotComID.Adventure_Main)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.Adventure_Daily, RedDotComID.Adventure_Main)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.Adventure_Hero, RedDotComID.Adventure_Main)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.Adventure_Tower, RedDotComID.Adventure_Main)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.Adventure_Expedition, RedDotComID.Adventure_Main)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.Adventure_BigAdventure, RedDotComID.Adventure_Main)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.Adventure_Arena, RedDotComID.Adventure_Main)
  winName = (WinResConfig.ActivityMainWindow).name
  ;
  (RedDotMgr.RegisterRootNode)(winName, RedDotComID.Activity_Main, RedDotComID.Home_Activity, (WinResConfig.HomeWindow).name)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.Activity_Sign, RedDotComID.Activity_Main)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.Activity_Cake, RedDotComID.Activity_Main)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.Activity_SevenLogin, RedDotComID.Activity_Main)
  winName = (WinResConfig.GuildMainWindow).name
  ;
  (RedDotMgr.RegisterRootNode)(winName, RedDotComID.Guild_Main, RedDotComID.Home_Union, (WinResConfig.HomeWindow).name)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.Guild_ApplyPass, RedDotComID.Guild_Main)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.Guild_Detail, RedDotComID.Guild_Main)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.Guild_Construction, RedDotComID.Guild_Main)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.Guild_Guess, RedDotComID.Guild_Main)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.Guild_Gift, RedDotComID.Guild_Main)
  winName = (WinResConfig.GuildDetailWindow).name
  ;
  (RedDotMgr.RegisterRootNode)(winName, RedDotComID.Guild_Detail_Main, RedDotComID.Guild_Detail, (WinResConfig.GuildMainWindow).name)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.Guild_Detail_Apply, RedDotComID.Guild_Detail_Main)
  winName = (WinResConfig.LotteryWindow).name
  ;
  (RedDotMgr.RegisterRootNode)(winName, RedDotComID.Lottery_Main, RedDotComID.Home_Lottery, (WinResConfig.HomeWindow).name)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.Lottery_Character, RedDotComID.Lottery_Main)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.Lottery_Card, RedDotComID.Lottery_Main)
  winName = (WinResConfig.EquipmentWindow).name
  ;
  (RedDotMgr.RegisterRootNode)(winName, RedDotComID.Equipt_Main, RedDotComID.Home_Equip, (WinResConfig.HomeWindow).name)
  ;
  (RedDotMgr.RegisterNodeWithList)(winName, RedDotComID.Equipt_Role_List, RedDotComID.Equipt_Main)
  ;
  (RedDotMgr.RegisterNodeWithList)(winName, RedDotComID.Equipt_Equipment_List, RedDotComID.Equipt_Role_List)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.Equipt_Equipment, RedDotComID.Equipt_Equipment_List)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.Equipt_Weapon, RedDotComID.Equipt_Equipment)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.Equipt_Chest, RedDotComID.Equipt_Equipment)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.Equipt_Necklace, RedDotComID.Equipt_Equipment)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.Equipt_Ring, RedDotComID.Equipt_Equipment)
  ;
  (RedDotMgr.RegisterRootNode)((WinResConfig.MailWindow).name, RedDotComID.Mail_MainList, RedDotComID.Home_Mail, (WinResConfig.HomeWindow).name)
  winName = (WinResConfig.TalentMainWindow).name
  ;
  (RedDotMgr.RegisterRootNode)(winName, RedDotComID.Talent_Main, RedDotComID.Home_Talent, (WinResConfig.HomeWindow).name)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.Talent_UpLevel, RedDotComID.Talent_Main)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.Talent_UpStar, RedDotComID.Talent_Main)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.Talent_StarEnergy, RedDotComID.Talent_Main)
  winName = (WinResConfig.HandBookMainWindow).name
  ;
  (RedDotMgr.RegisterRootNode)(winName, RedDotComID.HandBook_Main, RedDotComID.Home_Handbook, (WinResConfig.HomeWindow).name)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.HandBook_Story, RedDotComID.HandBook_Main)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.HandBook_Album, RedDotComID.HandBook_Main)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.HandBook_Intimacy, RedDotComID.HandBook_Main)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.HandBook_Relation, RedDotComID.HandBook_Main)
  winName = (WinResConfig.HandBookCardPlotWindow).name
  ;
  (RedDotMgr.RegisterRootNode)(winName, RedDotComID.HandBook_Story_Main, RedDotComID.HandBook_Story, (WinResConfig.HandBookMainWindow).name)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.HandBook_Story_List, RedDotComID.HandBook_Story_Main)
  winName = (WinResConfig.HandBookAlbumWindow).name
  ;
  (RedDotMgr.RegisterRootNode)(winName, RedDotComID.HandBook_Collection_Main, RedDotComID.HandBook_Album, (WinResConfig.HandBookMainWindow).name)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.HandBook_Collection_Album, RedDotComID.HandBook_Collection_Main)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.HandBook_Collection_Album_Activity, RedDotComID.HandBook_Collection_Main)
  winName = (WinResConfig.ArenaWindow).name
  ;
  (RedDotMgr.RegisterRootNode)(winName, RedDotComID.Arena_Main, RedDotComID.Adventure_Arena, (WinResConfig.AdventureWindow).name)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.Arena_RewardBox, RedDotComID.Arena_Main)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.Arena_UseTimes, RedDotComID.Arena_Main)
  winName = (WinResConfig.ArenaRewardWindow).name
  ;
  (RedDotMgr.RegisterRootNode)(winName, RedDotComID.ArenaReward_Main, RedDotComID.Arena_RewardBox, (WinResConfig.ArenaWindow).name)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.ArenaReward_Integer, RedDotComID.ArenaReward_Main)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.ArenaReward_Career, RedDotComID.ArenaReward_Main)
  winName = (WinResConfig.AdventureGameWindow).name
  ;
  (RedDotMgr.RegisterRootNode)(winName, RedDotComID.BigAdventure_Main, RedDotComID.Adventure_BigAdventure, (WinResConfig.AdventureWindow).name)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.BigAdventure_Wish, RedDotComID.BigAdventure_Main)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.BigAdventure_TarotCard, RedDotComID.BigAdventure_Main)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.BigAdventure_InvestMgr, RedDotComID.BigAdventure_Main)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.BigAdventure_RiskER, RedDotComID.BigAdventure_Main)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.BigAdventure_Vit, RedDotComID.BigAdventure_Main)
  winName = (WinResConfig.ActivityCarnivalWindow).name
  ;
  (RedDotMgr.RegisterRootNode)(winName, RedDotComID.SevenTask_Main, RedDotComID.Home_SevenTask, (WinResConfig.HomeWindow).name)
  ;
  (RedDotMgr.RegisterNodeWithList)(winName, RedDotComID.SevenTask_BtnList, RedDotComID.SevenTask_Main)
  ;
  (RedDotMgr.RegisterNode)(winName, RedDotComID.SevenTask_GetBtn, RedDotComID.SevenTask_Main)
end

-- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

RedDotMgr.InitRedDotList = function(data, ...)
  -- function num : 0_1 , upvalues : RedDotList
  RedDotList = data
end

-- DECOMPILER ERROR at PC12: Confused about usage of register: R2 in 'UnsetPending'

RedDotMgr.GetRedDotList = function(...)
  -- function num : 0_2 , upvalues : RedDotList
  return RedDotList
end

-- DECOMPILER ERROR at PC15: Confused about usage of register: R2 in 'UnsetPending'

RedDotMgr.GetContainRedDot = function(redID, ...)
  -- function num : 0_3 , upvalues : _ENV, RedDotList
  for _,v in ipairs(RedDotList) do
    if v.id == redID then
      return true
    end
  end
  return false
end

local StoryData = {}
-- DECOMPILER ERROR at PC19: Confused about usage of register: R3 in 'UnsetPending'

RedDotMgr.StoryPlotData = function(...)
  -- function num : 0_4 , upvalues : StoryData
  return StoryData
end

-- DECOMPILER ERROR at PC22: Confused about usage of register: R3 in 'UnsetPending'

RedDotMgr.IsContainStoryPlotData = function(id, ...)
  -- function num : 0_5 , upvalues : _ENV, StoryData
  for _,v in ipairs(StoryData) do
    if tonumber(v) == tonumber(id) then
      return true
    end
  end
  return false
end

local HeroData = {}
-- DECOMPILER ERROR at PC26: Confused about usage of register: R4 in 'UnsetPending'

RedDotMgr.HeroPlotData = function(...)
  -- function num : 0_6 , upvalues : HeroData
  return HeroData
end

-- DECOMPILER ERROR at PC29: Confused about usage of register: R4 in 'UnsetPending'

RedDotMgr.IsContainHeroPlotData = function(id, ...)
  -- function num : 0_7 , upvalues : _ENV, HeroData
  for _,v in ipairs(HeroData) do
    if tonumber(v) == tonumber(id) then
      return true
    end
  end
  return false
end

local HandBookStory = {}
-- DECOMPILER ERROR at PC33: Confused about usage of register: R5 in 'UnsetPending'

RedDotMgr.HandBookStory = function(...)
  -- function num : 0_8 , upvalues : HandBookStory
  return HandBookStory
end

local HandBook_Intimacy = {}
-- DECOMPILER ERROR at PC37: Confused about usage of register: R6 in 'UnsetPending'

RedDotMgr.HandBookIntimacyList = function(...)
  -- function num : 0_9 , upvalues : HandBook_Intimacy
  return HandBook_Intimacy
end

local Title_RedList = {}
-- DECOMPILER ERROR at PC41: Confused about usage of register: R7 in 'UnsetPending'

RedDotMgr.TitleRedList = function(...)
  -- function num : 0_10 , upvalues : Title_RedList
  return Title_RedList
end

-- DECOMPILER ERROR at PC44: Confused about usage of register: R7 in 'UnsetPending'

RedDotMgr.InitRedDotData = function(...)
  -- function num : 0_11 , upvalues : _ENV, RedDotList
  for _,v in ipairs(RedDotList) do
    (RedDotMgr.ProcessRedDot)(v.id, v.params, true)
  end
  ;
  (RedDotMgr.SpecialIntimacyList)()
end

-- DECOMPILER ERROR at PC47: Confused about usage of register: R7 in 'UnsetPending'

RedDotMgr.SpecialIntimacyList = function(...)
  -- function num : 0_12 , upvalues : HandBook_Intimacy, _ENV
  HandBook_Intimacy = {}
  local cardList = (CardData.GetObtainedCardList)()
  for _,v in ipairs(cardList) do
    local redDot = (Util.GetPlayerSetting)(PlayerPrefsKeyName.INTIMACY_RED_DOT .. v.id, "")
    redDot = split(redDot, ":")
    if redDot and #redDot > 1 and (tonumber(redDot[1]) == 1 or tonumber(redDot[2]) == 1) then
      (table.insert)(HandBook_Intimacy, v.id)
    end
  end
  local isOpen = (FunctionControlMgr.GetFunctionState)(ControlID.HandBook_Intimacy)
  if isOpen then
    local node = RedDotManager:GetNodeByObj((WinResConfig.HandBookMainWindow).name, RedDotComID.HandBook_Intimacy)
    if #HandBook_Intimacy <= 0 then
      do
        node.NodeValue = not node
        -- DECOMPILER ERROR: 2 unprocessed JMP targets
      end
    end
  end
end

-- DECOMPILER ERROR at PC50: Confused about usage of register: R7 in 'UnsetPending'

RedDotMgr.RemoveIntimacyInfoRedDot = function(cardID, story, voice, ...)
  -- function num : 0_13 , upvalues : _ENV
  local redDot = (Util.GetPlayerSetting)(PlayerPrefsKeyName.INTIMACY_RED_DOT .. cardID, "")
  if redDot == "" then
    return 
  end
  redDot = split(redDot, ":")
  local str = ""
  if story then
    redDot[1] = "0"
  end
  if voice then
    redDot[2] = "0"
  end
  str = redDot[1] .. ":" .. redDot[2]
  ;
  (Util.SetPlayerSetting)(PlayerPrefsKeyName.INTIMACY_RED_DOT .. cardID, str)
  ;
  (RedDotMgr.SpecialIntimacyList)()
end

-- DECOMPILER ERROR at PC53: Confused about usage of register: R7 in 'UnsetPending'

RedDotMgr.ProcessRedDot = function(id, params, IsAdd, ...)
  -- function num : 0_14 , upvalues : _ENV, StoryData, HeroData, HandBookStory, Title_RedList
  local logStr = ""
  if IsAdd then
    logStr = "增加"
  else
    logStr = "移除"
  end
  if (ActivityMgr.GetActivityIsOpenByID)(id) then
    local activityData = ((TableData.gTable).BaseActivityData)[id]
    if activityData == nil then
      loge("红点系统log:未在活动表中找到" .. id)
      return 
    end
    if activityData.type == (ActivityMgr.ActivityType).SevenTask then
      local node = RedDotManager:GetNodeByObj((WinResConfig.ActivityCarnivalWindow).name, RedDotComID.SevenTask_GetBtn)
      if node and (RedDotMgr.IsContainKey)(params, id) then
        node.NodeValue = IsAdd
      end
      local groupList = split(activityData.task_group, ":")
      local listNode = RedDotManager:GetNodeByObj((WinResConfig.ActivityCarnivalWindow).name, RedDotComID.SevenTask_BtnList)
      local listValue = listNode.NodeValueList
      local valueS = {}
      for i,v in pairs(listValue) do
        valueS[i + 1] = v
      end
      for i,v in ipairs(groupList) do
        if (RedDotMgr.IsContainKey)(params, v) then
          if IsAdd then
            valueS[i] = true
          else
            valueS[i] = false
          end
        else
          if valueS[i] == nil then
            valueS[i] = false
          end
        end
      end
      listNode.NodeValueList = valueS
    else
    end
  else
    do
      if activityData.type == (ActivityMgr.ActivityType).ActivityDungeon then
        if id == RedDotComID.Shop_Main then
          for _,v in ipairs(params) do
            local node = RedDotManager:GetNodeByObj((WinResConfig.ShopWindow).name, v)
            if node then
              loge(logStr .. "商店红点ID" .. v)
              node.NodeValue = IsAdd
            end
          end
        else
          do
            if id == RedDotComID.Adventure_Story then
              local node = RedDotManager:GetNodeByObj((WinResConfig.AdventureWindow).name, RedDotComID.Adventure_Story)
              if IsAdd then
                for _,v in ipairs(params) do
                  if not (RedDotMgr.IsContainStoryPlotData)(v) then
                    loge(logStr .. "剧情副本ID" .. v)
                    ;
                    (table.insert)(StoryData, v)
                  end
                end
              else
                do
                  for _,v in ipairs(params) do
                    loge(logStr .. "剧情副本ID" .. v)
                    for i,v2 in ipairs(StoryData) do
                      if v == v2 then
                        (table.remove)(StoryData, i)
                      end
                    end
                  end
                  do
                    do
                      if StoryData and #StoryData > 0 then
                        node.NodeValue = true
                      else
                        node.NodeValue = false
                      end
                      if UIMgr:IsWindowOpen((WinResConfig.PlotPlayWindow).name) then
                        UIMgr:SendWindowMessage((WinResConfig.PlotPlayWindow).name, (WindowMsgEnum.PlotPlayWindow).E_MSG_CHECK_RED_DOT)
                      end
                      if id == RedDotComID.Adventure_Hero then
                        local node = RedDotManager:GetNodeByObj((WinResConfig.AdventureWindow).name, RedDotComID.Adventure_Hero)
                        if IsAdd then
                          for _,v in ipairs(params) do
                            if not (RedDotMgr.IsContainHeroPlotData)(v) then
                              loge(logStr .. "英雄副本ID" .. v)
                              ;
                              (table.insert)(HeroData, v)
                            end
                          end
                        else
                          do
                            for _,v in ipairs(params) do
                              loge(logStr .. "英雄副本ID" .. v)
                              for i,v2 in ipairs(HeroData) do
                                if v == v2 then
                                  (table.remove)(HeroData, i)
                                end
                              end
                            end
                            do
                              do
                                if HeroData and #HeroData > 0 then
                                  node.NodeValue = true
                                else
                                  node.NodeValue = false
                                end
                                if id == RedDotComID.Equipt_Role_List then
                                  local node = RedDotManager:GetNodeByObj((WinResConfig.HomeWindow).name, id)
                                  if node then
                                    loge(logStr .. "装备角色列表ID" .. id)
                                    node.NodeValueList = params
                                  end
                                else
                                  do
                                    if id == RedDotComID.Equipt_Equipment_List then
                                      local node = RedDotManager:GetNodeByObj((WinResConfig.EquipmentWindow).name, id)
                                      if node then
                                        loge(logStr .. "装备列表ID" .. id)
                                        node.NodeValueList = params
                                      end
                                    else
                                      do
                                        if id == RedDotComID.Announcement_List then
                                          local node = RedDotManager:GetNodeByObj((WinResConfig.AnnouncementWindow).name, id)
                                          if node then
                                            loge(logStr .. "公告列表ID" .. id)
                                            node.NodeValueList = params
                                          end
                                        else
                                          do
                                            if id == RedDotComID.HandBook_Story_List then
                                              local node = RedDotManager:GetNodeByObj((WinResConfig.HandBookCardPlotWindow).name, RedDotComID.HandBook_Story_List)
                                              if node then
                                                if IsAdd then
                                                  for _,v in ipairs(params) do
                                                    (table.insert)(HandBookStory, v)
                                                  end
                                                else
                                                  do
                                                    for _,v in ipairs(params) do
                                                      for i,v2 in ipairs(HandBookStory) do
                                                        if v == v2 then
                                                          (table.remove)(HandBookStory, i)
                                                        end
                                                      end
                                                    end
                                                    do
                                                      do
                                                        if HandBookStory and #HandBookStory > 0 then
                                                          node.NodeValue = true
                                                        else
                                                          node.NodeValue = false
                                                        end
                                                        if UIMgr:IsWindowOpen((WinResConfig.HandBookCardPlotWindow).name) then
                                                          UIMgr:SendWindowMessage((WinResConfig.HandBookCardPlotWindow).name, 2)
                                                        end
                                                        if id == RedDotComID.Title_List then
                                                          local node = RedDotManager:GetNodeByObj((WinResConfig.TitleWindow).name, RedDotComID.Title_List)
                                                          if node then
                                                            (RedDotMgr.ListProcessor)(Title_RedList, params, IsAdd)
                                                          end
                                                          loge("称号红点更新")
                                                          if Title_RedList and #Title_RedList > 0 then
                                                            node.NodeValue = true
                                                          else
                                                            node.NodeValue = false
                                                          end
                                                          if UIMgr:IsWindowOpen((WinResConfig.TitleWindow).name) then
                                                            UIMgr:SendWindowMessage((WinResConfig.TitleWindow).name, (WindowMsgEnum.Title).E_MSG_RED_DOT)
                                                          end
                                                        else
                                                          do
                                                            do
                                                              local node = RedDotManager:GetNodeByObj((WinResConfig.HomeWindow).name, id)
                                                              if node then
                                                                loge(logStr .. "普通红点ID" .. id)
                                                                node.NodeValue = IsAdd
                                                              end
                                                              if id == RedDotComID.FREE_GIFT then
                                                                UIMgr:SendWindowMessage((WinResConfig.ShopWindow).name, (WindowMsgEnum.ShopWindow).E_MSG_CLEAR_FREEGIFTREDDOT)
                                                              end
                                                            end
                                                          end
                                                        end
                                                      end
                                                    end
                                                  end
                                                end
                                              end
                                            end
                                          end
                                        end
                                      end
                                    end
                                  end
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC56: Confused about usage of register: R7 in 'UnsetPending'

RedDotMgr.IsContainKey = function(list, key, ...)
  -- function num : 0_15 , upvalues : _ENV
  for _,v in pairs(list) do
    if tonumber(v) == tonumber(key) then
      return true
    end
  end
  return false
end

-- DECOMPILER ERROR at PC59: Confused about usage of register: R7 in 'UnsetPending'

RedDotMgr.ListProcessor = function(list, params, isAdd, ...)
  -- function num : 0_16 , upvalues : _ENV
  if isAdd then
    for _,v in ipairs(params) do
      local isContain = false
      for _,v2 in ipairs(list) do
        if v == v2 then
          isContain = true
          break
        end
      end
      do
        do
          if not isContain then
            (table.insert)(list, v)
          end
          -- DECOMPILER ERROR at PC24: LeaveBlock: unexpected jumping out DO_STMT

        end
      end
    end
  else
    for _,v in ipairs(params) do
      for i,v2 in ipairs(list) do
        if v == v2 then
          (table.remove)(list, i)
        end
      end
    end
  end
  do
    return list
  end
end

-- DECOMPILER ERROR at PC62: Confused about usage of register: R7 in 'UnsetPending'

RedDotMgr.RegisterRootNode = function(winName, key, parentKey, parentWinName, ...)
  -- function num : 0_17 , upvalues : _ENV
  local baseData = (TableData.gTable).BaseWindowNameData
  local maxDot = 100
  for _,v in pairs(baseData) do
    if v.window_name == winName then
      maxDot = v.red_dot_max
    end
  end
  RedDotManager:RegisterRootNode(winName, key, parentWinName, parentKey, maxDot)
end

-- DECOMPILER ERROR at PC65: Confused about usage of register: R7 in 'UnsetPending'

RedDotMgr.RegisterNode = function(winName, key, parentKey, ...)
  -- function num : 0_18 , upvalues : _ENV
  local baseData = ((TableData.gTable).BaseRedDotData)[key]
  if not baseData then
    loge("红点系统log:注册失败" .. key .. "未在BaseRedDotData表中找到")
    return 
  end
  RedDotManager:RegisterNode(winName, key, parentKey, baseData.priority, baseData.show_level_limit, baseData.pass_level_limit)
end

-- DECOMPILER ERROR at PC68: Confused about usage of register: R7 in 'UnsetPending'

RedDotMgr.RegisterNodeWithList = function(winName, key, parentKey, ...)
  -- function num : 0_19 , upvalues : _ENV
  local baseData = ((TableData.gTable).BaseRedDotData)[key]
  if not baseData then
    loge("红点系统log:注册失败" .. key .. "未在BaseRedDotData表中找到")
    return 
  end
  RedDotManager:RegisterNodeWithList(winName, key, parentKey, baseData.priority, baseData.show_level_limit, baseData.pass_level_limit)
end

-- DECOMPILER ERROR at PC71: Confused about usage of register: R7 in 'UnsetPending'

RedDotMgr.RefreshTreeUI = function(winName, ...)
  -- function num : 0_20 , upvalues : _ENV
  RedDotManager:RefreshTreeUI(winName)
end

-- DECOMPILER ERROR at PC74: Confused about usage of register: R7 in 'UnsetPending'

RedDotMgr.RefreshOpenUI = function(...)
  -- function num : 0_21 , upvalues : _ENV
  local var = UIMgr:GetAllOpenWindow()
  for i = 0, var.Count - 1 do
    local uiLayer = UIMgr:GetOpenWindowLayer(var[i])
    if uiLayer == UILayer.HUD then
      loge("refresh.." .. var[i])
      ;
      (RedDotMgr.RefreshTreeUI)(var[i])
    end
  end
end

-- DECOMPILER ERROR at PC77: Confused about usage of register: R7 in 'UnsetPending'

RedDotMgr.BindingUI = function(winName, comId, ui, isList, ...)
  -- function num : 0_22 , upvalues : _ENV, winConList
  local ss = RedDotManager:GetNodeByObj(winName, comId)
  if ss then
    if isList then
      ss:BindingUI(ui)
    else
      local redDot = ui:GetChild("RedDot")
      if redDot then
        ss:BindingUI(redDot)
      else
        loge("红点log:未找到" .. comId .. "绑定的控件")
      end
    end
    do
      do
        local list = winConList[winName]
        if not list then
          list = {}
          winConList[winName] = list
        end
        ;
        (table.insert)(list, ss)
        loge(winName .. comId .. "未找到该节点")
      end
    end
  end
end

-- DECOMPILER ERROR at PC80: Confused about usage of register: R7 in 'UnsetPending'

RedDotMgr.RemoveUIRefer = function(winName, ...)
  -- function num : 0_23 , upvalues : winConList, _ENV
  local ids = winConList[winName]
  if ids then
    for _,v in ipairs(ids) do
      v:RemoveBindUI()
      v = nil
    end
    winConList[winName] = nil
  end
end

-- DECOMPILER ERROR at PC83: Confused about usage of register: R7 in 'UnsetPending'

RedDotMgr.EliminateRedDot = function(winName, id, param, ...)
  -- function num : 0_24 , upvalues : _ENV
  (RedDotService.ReqRemoveRedDot)(winName, id, param)
end

-- DECOMPILER ERROR at PC86: Confused about usage of register: R7 in 'UnsetPending'

RedDotMgr.CheckTalentStarEnergy = function(...)
  -- function num : 0_25 , upvalues : _ENV
  local allDebris = (ActorData.GetPropsTypeData)(PropItemType.CHARACTER_DEBRIS)
  local maxStarCard = (CardData.GetMaxStarCards)()
  local count = 0
  for _,j in ipairs(maxStarCard) do
    for _,m in ipairs(allDebris) do
      local propData = ((TableData.gTable).BasePropData)[m.id]
      if propData.effect_value == j.id then
        count = count + m.count
      end
    end
  end
  if count <= 0 then
    (RedDotMgr.EliminateRedDot)((WinResConfig.TalentMainWindow).name, RedDotComID.Talent_StarEnergy)
  end
end

;
(RedDotMgr.Init)()

