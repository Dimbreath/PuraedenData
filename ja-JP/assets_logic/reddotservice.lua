-- params : ...
-- function num : 0 , upvalues : _ENV
RedDotService = {}
-- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

RedDotService.Init = function(...)
  -- function num : 0_0 , upvalues : _ENV
  (Net.AddListener)((Proto.MsgName).ResRedDotList, RedDotService.OnResRedDotList)
  ;
  (Net.AddListener)((Proto.MsgName).ResAddRedDot, RedDotService.OnResAddRedDot)
  ;
  (Net.AddListener)((Proto.MsgName).ResRemoveRedDot, RedDotService.OnResRemoveRedDot)
  ;
  (Net.AddListener)((Proto.MsgName).ResIntimacyLvChange, RedDotService.OnResIntimacyLvChange)
end

-- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

RedDotService.OnResRedDotList = function(msg, ...)
  -- function num : 0_1 , upvalues : _ENV
  for _,v in ipairs(msg.redDotList) do
    loge("接受初始化红点        " .. v.id)
  end
  ;
  (RedDotMgr.InitRedDotList)(msg.redDotList)
  loge("红点数据更新")
end

-- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

RedDotService.ReqRemoveRedDot = function(winName, id, param, ...)
  -- function num : 0_2 , upvalues : _ENV
  local node = RedDotManager:GetNodeByObj(winName, id)
  local RedDot = ((TableData.gTable).BaseRedDotData)[id]
  local isSatisfy = false
  if RedDot then
    isSatisfy = (RedDotService.SatisfyLevel)(RedDot.show_level_limit)
  end
  if not node or node.NodeValue == false and isSatisfy then
    return 
  end
  if id == RedDotComID.SevenTask_GetBtn or RedDotComID.SevenTask_BtnList == id then
    id = (ActivityMgr.GetOpenActivityByType)((ActivityMgr.ActivityType).SevenTask)
  end
  local m = {}
  local RedDotInfo = {}
  RedDotInfo.id = id
  RedDotInfo.params = {param}
  m.redDotList = {RedDotInfo}
  ;
  (Net.Send)((Proto.MsgName).ReqRemoveRedDot, m, (Proto.MsgName).ResRemoveRedDot)
  local par = param or 0
  loge("发送移除红点id: " .. id .. " 参数: " .. par)
end

-- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

RedDotService.OnResRemoveRedDot = function(msg, ...)
  -- function num : 0_3 , upvalues : _ENV
  if #msg.redDotList <= 0 then
    return 
  end
  for _,redDot in ipairs(msg.redDotList) do
    local redDotId = redDot.id
    local params = redDot.params
    if params and #params > 0 then
      for _,redDotParam in ipairs(params) do
        local par = redDotParam or 0
        loge("接受移除红点id: " .. redDotId .. " 参数: " .. par)
        local dotList = (RedDotMgr.GetRedDotList)()
        for i,v in ipairs(dotList) do
          if v.id == redDotId then
            if par and par > 0 and v.params then
              for i2,v2 in ipairs(v.params) do
                if v2 == par then
                  (table.remove)(v.params, i2)
                end
              end
            else
              do
                do
                  ;
                  (table.remove)(dotList, i)
                  -- DECOMPILER ERROR at PC66: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC66: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                  -- DECOMPILER ERROR at PC66: LeaveBlock: unexpected jumping out IF_STMT

                  -- DECOMPILER ERROR at PC66: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC66: LeaveBlock: unexpected jumping out IF_STMT

                end
              end
            end
          end
        end
      end
    else
      do
        loge("接受移除红点id: " .. redDotId)
        local dotList = (RedDotMgr.GetRedDotList)()
        for i,v in ipairs(dotList) do
          if v.id == redDotId then
            (table.remove)(dotList, i)
          end
        end
        do
          do
            ;
            (RedDotMgr.ProcessRedDot)(redDotId, params, false)
            -- DECOMPILER ERROR at PC99: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC99: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC99: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC99: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
  ;
  (RedDotMgr.RefreshOpenUI)()
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

RedDotService.ReqAddRedDot = function(id, param, ...)
  -- function num : 0_4
end

-- DECOMPILER ERROR at PC19: Confused about usage of register: R0 in 'UnsetPending'

RedDotService.OnResAddRedDot = function(msg, ...)
  -- function num : 0_5 , upvalues : _ENV
  for _,redDot in ipairs(msg.redDotList) do
    local redDotID = redDot.id
    local params = redDot.params
    local dotList = (RedDotMgr.GetRedDotList)()
    if params and #params > 0 then
      for _,param in ipairs(params) do
        local contain = false
        for _,v in ipairs(dotList) do
          if v.id == redDotID then
            (table.insert)(v.params, param)
            contain = true
          end
        end
        if not contain then
          local m = {}
          m.id = redDotID
          m.params = {param}
          ;
          (table.insert)(dotList, m)
        end
      end
    else
      do
        local contain = false
        for _,v in ipairs(dotList) do
          if v.id == redDotID then
            contain = true
          end
        end
        do
          do
            if not contain then
              local m = {}
              m.id = redDotID
              m.params = {}
              ;
              (table.insert)(dotList, m)
            end
            -- DECOMPILER ERROR at PC80: Confused about usage of register: R9 in 'UnsetPending'

            if redDotID == RedDotComID.Guild_Detail_Apply and GuildData ~= nil then
              GuildData.NeedUpdateApplyInfo = true
            end
            ;
            (RedDotMgr.ProcessRedDot)(redDotID, params, true)
            loge("接受增加id" .. redDotID .. "红点")
            -- DECOMPILER ERROR at PC93: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC93: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC93: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC93: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
  ;
  (SimpleTimer.setTimeout)(0.1, function(...)
    -- function num : 0_5_0 , upvalues : _ENV
    (RedDotMgr.RefreshOpenUI)()
  end
)
end

local intimacyLvCard = {}
-- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'

RedDotService.CardIntimacyIsUp = function(cardID, ...)
  -- function num : 0_6 , upvalues : _ENV, intimacyLvCard
  for _,v in pairs(intimacyLvCard) do
    if v == cardID then
      return true
    end
  end
  return false
end

-- DECOMPILER ERROR at PC26: Confused about usage of register: R1 in 'UnsetPending'

RedDotService.ClearTempData = function(...)
  -- function num : 0_7 , upvalues : intimacyLvCard
  intimacyLvCard = {}
end

-- DECOMPILER ERROR at PC29: Confused about usage of register: R1 in 'UnsetPending'

RedDotService.OnResIntimacyLvChange = function(msg, ...)
  -- function num : 0_8 , upvalues : _ENV, intimacyLvCard
  loge(msg.cardId .. "增加亲密度" .. "亲密度等级: " .. msg.intimacyLv)
  ;
  (table.insert)(intimacyLvCard, msg.cardId)
  local formerLv = ((CardData.GetCardData)(msg.cardId)).intimacyLv
  local RoleData = ((TableData.gTable).BaseHandbookRoleData)[msg.cardId]
  local storyState = (RedDotService.ParseIntimacyIsUnlockInfo)(RoleData.story, formerLv, msg.intimacyLv)
  local voiceState = (RedDotService.ParseIntimacyIsUnlockInfo)(RoleData.voice, formerLv, msg.intimacyLv)
  ;
  (RedDotService.CheckGuideTips)(msg, storyState, voiceState)
  ;
  (CardData.SaveCardIntimacyLevel)(msg.cardId, msg.intimacyLv)
  local redDotData = (Util.GetPlayerSetting)(PlayerPrefsKeyName.INTIMACY_RED_DOT .. msg.cardId, "")
  local redDotData = split(redDotData, ":")
  if redDotData and #redDotData > 1 then
    local story = tonumber(redDotData[1])
    local voice = tonumber(redDotData[2])
    if story == 0 and storyState == 1 then
      loge(msg.cardId .. "增加亲密度背景故事红点" .. "亲密度等级:" .. msg.intimacyLv)
      story = 1
    end
    if voice == 0 and voiceState == 1 then
      loge(msg.cardId .. "增加亲密度语音红点" .. "亲密度等级:" .. msg.intimacyLv)
      voice = 1
    end
    redDotData = story .. ":" .. voice
  else
    do
      redDotData = storyState .. ":" .. voiceState
      ;
      (Util.SetPlayerSetting)(PlayerPrefsKeyName.INTIMACY_RED_DOT .. msg.cardId, redDotData)
      ;
      (RedDotMgr.SpecialIntimacyList)()
    end
  end
end

-- DECOMPILER ERROR at PC32: Confused about usage of register: R1 in 'UnsetPending'

RedDotService.CheckGuideTips = function(msg, storyState, voiceState, ...)
  -- function num : 0_9 , upvalues : _ENV
  local IntimacyUpData = ((TableData.gTable).BaseCardData)[msg.cardId]
  local intimacyType = IntimacyUpData.intimacy_grow_type
  local IntimacyUpData = (TableData.gTable).BaseIntimacyUpData
  local curRank, preRank = nil, nil
  for _,v in pairs(IntimacyUpData) do
    if v.level == msg.intimacyLv and v.type == tonumber(intimacyType) then
      curRank = v.rank
    else
      if v.level == msg.intimacyLv - 1 and v.type == tonumber(intimacyType) then
        preRank = v.rank
      end
    end
  end
  if preRank ~= nil and curRank ~= preRank then
    (Util.ShowGuideTips)(GuideTipsCheckPoint.AcquireFeelingTitle, (((TableData.gTable).BaseCardData)[msg.cardId]).name, (PUtil.get)(20000163 + curRank))
  end
  if storyState == 1 then
    (Util.ShowGuideTips)(GuideTipsCheckPoint.UnlockBackgroundStory, (((TableData.gTable).BaseCardData)[msg.cardId]).name)
  end
  if voiceState == 1 then
    (Util.ShowGuideTips)(GuideTipsCheckPoint.UnlockCV, (((TableData.gTable).BaseCardData)[msg.cardId]).name)
  end
end

-- DECOMPILER ERROR at PC35: Confused about usage of register: R1 in 'UnsetPending'

RedDotService.ParseIntimacyIsUnlockInfo = function(str, formerLv, lv, ...)
  -- function num : 0_10 , upvalues : _ENV
  local infoS = (Util.ParseConfigStr)(str)
  for _,v in ipairs(infoS) do
    local lockType = tonumber(v[2])
    local lockValue = tonumber(v[3])
    if lockType == 1 and lockValue <= lv and formerLv < lockValue then
      return 1
    end
  end
  return 0
end

-- DECOMPILER ERROR at PC38: Confused about usage of register: R1 in 'UnsetPending'

RedDotService.SatisfyLevel = function(str, ...)
  -- function num : 0_11 , upvalues : _ENV
  local level = (ActorData.GetLevel)()
  local configs = (Util.ParseConfigStr)(str)
  for _,v in ipairs(configs) do
    if tonumber(v[1]) <= level and level <= tonumber(v[2]) then
      return true
    end
  end
  return false
end

;
(RedDotService.Init)()

