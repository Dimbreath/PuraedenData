-- params : ...
-- function num : 0 , upvalues : _ENV
GuildData = {}
GuildBuildOperateType = {Donate = 1, AcquireRewards = 2}
GuildListType = {AllGuild = 1, SearchResult = 2, AppliedGuid = 3}
GuildRewardType = {Gold = 1, Diamond = 2, Currency = 3}
GuildRewardTypeId = {[GuildRewardType.Gold] = AssetType.GOLD, [GuildRewardType.Diamond] = AssetType.DIAMOND_BIND, [GuildRewardType.Currency] = AssetType.SHOP_TOKEN}
GuildMemberOperateType = {Transfer = 1, Promote = 2, Demote = 3, KickOut = 4, Fight = 5}
GuildBuildType = {Gold = 1, Diamond = 2, Ultra = 3}
GuildDetailPanelType = {Main = 1, SubInterface = 2, Building = 3}
-- DECOMPILER ERROR at PC51: Confused about usage of register: R0 in 'UnsetPending'

GuildData.CREATE_GUILD_COST = 72002030
-- DECOMPILER ERROR at PC53: Confused about usage of register: R0 in 'UnsetPending'

GuildData.DAILY_BUILD_LIMIT = 72002036
-- DECOMPILER ERROR at PC55: Confused about usage of register: R0 in 'UnsetPending'

GuildData.MODIFY_NAME_COST = 72002037
-- DECOMPILER ERROR at PC57: Confused about usage of register: R0 in 'UnsetPending'

GuildData.DEFAULT_BADGE_ID = 72002040
-- DECOMPILER ERROR at PC59: Confused about usage of register: R0 in 'UnsetPending'

GuildData.QUIT_GUILD_CD = 72002031
-- DECOMPILER ERROR at PC61: Confused about usage of register: R0 in 'UnsetPending'

GuildData.MAX_JOIN_CONDITION = 10000000
-- DECOMPILER ERROR at PC63: Confused about usage of register: R0 in 'UnsetPending'

GuildData.MAX_CHAT_AMOUNT = 50
-- DECOMPILER ERROR at PC65: Confused about usage of register: R0 in 'UnsetPending'

GuildData.GUILD_CHAT_SELF_ITEM = "Guild:OneSelfChat"
-- DECOMPILER ERROR at PC67: Confused about usage of register: R0 in 'UnsetPending'

GuildData.GUILD_CHAT_OTHER_ITEM = "Guild:OtherChat"
-- DECOMPILER ERROR at PC69: Confused about usage of register: R0 in 'UnsetPending'

GuildData.GUILD_CHAT_LOG_ITEM = "Guild:ChatInfo"
-- DECOMPILER ERROR at PC71: Confused about usage of register: R0 in 'UnsetPending'

GuildData.InGuild = false
-- DECOMPILER ERROR at PC74: Confused about usage of register: R0 in 'UnsetPending'

GuildData.GuildLevelConfig = {}
-- DECOMPILER ERROR at PC77: Confused about usage of register: R0 in 'UnsetPending'

GuildData.GuildList = {}
-- DECOMPILER ERROR at PC79: Confused about usage of register: R0 in 'UnsetPending'

GuildData.JoinTimeStamp = nil
-- DECOMPILER ERROR at PC81: Confused about usage of register: R0 in 'UnsetPending'

GuildData.BaseInfo = nil
-- DECOMPILER ERROR at PC83: Confused about usage of register: R0 in 'UnsetPending'

GuildData.OnlineCount = 0
-- DECOMPILER ERROR at PC85: Confused about usage of register: R0 in 'UnsetPending'

GuildData.Announcement = ""
-- DECOMPILER ERROR at PC88: Confused about usage of register: R0 in 'UnsetPending'

GuildData.LogInfos = {}
-- DECOMPILER ERROR at PC93: Confused about usage of register: R0 in 'UnsetPending'

GuildData.SelfPosition = (ProtoEnum.GUILD_POST).MEMBER_POST
-- DECOMPILER ERROR at PC96: Confused about usage of register: R0 in 'UnsetPending'

GuildData.MemberList = {}
-- DECOMPILER ERROR at PC99: Confused about usage of register: R0 in 'UnsetPending'

GuildData.GuildApplyList = {}
-- DECOMPILER ERROR at PC102: Confused about usage of register: R0 in 'UnsetPending'

GuildData.MyApplyList = {}
-- DECOMPILER ERROR at PC105: Confused about usage of register: R0 in 'UnsetPending'

GuildData.SearchResultList = {}
-- DECOMPILER ERROR at PC108: Confused about usage of register: R0 in 'UnsetPending'

GuildData.RewardStatus = {}
-- DECOMPILER ERROR at PC111: Confused about usage of register: R0 in 'UnsetPending'

GuildData.RewardData = {}
-- DECOMPILER ERROR at PC114: Confused about usage of register: R0 in 'UnsetPending'

GuildData.ShowChats = {}
-- DECOMPILER ERROR at PC117: Confused about usage of register: R0 in 'UnsetPending'

GuildData.ExpressionList = {}
-- DECOMPILER ERROR at PC120: Confused about usage of register: R0 in 'UnsetPending'

GuildData.ExpressionGroup = {}
-- DECOMPILER ERROR at PC122: Confused about usage of register: R0 in 'UnsetPending'

GuildData.OFTEN_TYPE_KEY = -1
-- DECOMPILER ERROR at PC124: Confused about usage of register: R0 in 'UnsetPending'

GuildData.OFTEN_TYPE_MAX_NUM = 10
-- DECOMPILER ERROR at PC127: Confused about usage of register: R0 in 'UnsetPending'

GuildData.PositionRights = {}
-- DECOMPILER ERROR at PC129: Confused about usage of register: R0 in 'UnsetPending'

GuildData.BuildingInfo = nil
-- DECOMPILER ERROR at PC132: Confused about usage of register: R0 in 'UnsetPending'

GuildData.BuildConfig = {}
-- DECOMPILER ERROR at PC135: Confused about usage of register: R0 in 'UnsetPending'

GuildData.VigourConfig = {}
-- DECOMPILER ERROR at PC138: Confused about usage of register: R0 in 'UnsetPending'

GuildData.GuildGiftRank = {}
-- DECOMPILER ERROR at PC141: Confused about usage of register: R0 in 'UnsetPending'

GuildData.BadgeConfig = {}
-- DECOMPILER ERROR at PC143: Confused about usage of register: R0 in 'UnsetPending'

GuildData.NeedUpdateMemberInfo = true
-- DECOMPILER ERROR at PC145: Confused about usage of register: R0 in 'UnsetPending'

GuildData.NeedUpdateApplyInfo = true
-- DECOMPILER ERROR at PC147: Confused about usage of register: R0 in 'UnsetPending'

GuildData.ViceLeaderCount = 0
-- DECOMPILER ERROR at PC149: Confused about usage of register: R0 in 'UnsetPending'

GuildData.KickOutMemberName = ""
-- DECOMPILER ERROR at PC152: Confused about usage of register: R0 in 'UnsetPending'

GuildData.MemberCards = {}
-- DECOMPILER ERROR at PC155: Confused about usage of register: R0 in 'UnsetPending'

GuildData.AddItemToApplyList = function(id, ...)
  -- function num : 0_0 , upvalues : _ENV
  local count = #GuildData.GuildList
  local data = nil
  for i = 1, count do
    if ((GuildData.GuildList)[i]).id == id then
      data = (GuildData.GuildList)[i]
      break
    end
  end
  do
    if data == nil then
      count = #GuildData.SearchResultList
      for i = 1, count do
        if ((GuildData.SearchResultList)[i]).id == id then
          data = (GuildData.SearchResultList)[i]
          break
        end
      end
    end
    do
      if data == nil then
        return 
      end
      count = #GuildData.MyApplyList
      for i = 1, count do
        if ((GuildData.MyApplyList)[i]).id == id then
          return false
        end
      end
      ;
      (table.insert)(GuildData.MyApplyList, data)
      return true
    end
  end
end

-- DECOMPILER ERROR at PC158: Confused about usage of register: R0 in 'UnsetPending'

GuildData.RemoveItemFromApplyList = function(id, ...)
  -- function num : 0_1 , upvalues : _ENV
  local count = #GuildData.MyApplyList
  for i = 1, count do
    if ((GuildData.MyApplyList)[i]).id == id then
      (table.remove)(GuildData.MyApplyList, i)
      return true
    end
  end
  return false
end

-- DECOMPILER ERROR at PC161: Confused about usage of register: R0 in 'UnsetPending'

GuildData.InitRewardData = function(...)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

  GuildData.RewardData = {}
  local range = nil
  for k,v in pairs((TableData.gTable).BaseGuildGiftData) do
    range = split(v.level_range, ":")
    for i = tonumber(range[1]), tonumber(range[2]) do
      -- DECOMPILER ERROR at PC31: Confused about usage of register: R10 in 'UnsetPending'

      if (GuildData.RewardData)[i] == nil then
        (GuildData.RewardData)[i] = {}
      end
      -- DECOMPILER ERROR at PC36: Confused about usage of register: R10 in 'UnsetPending'

      ;
      ((GuildData.RewardData)[i])[v.type] = v
    end
  end
end

-- DECOMPILER ERROR at PC164: Confused about usage of register: R0 in 'UnsetPending'

GuildData.InitVigourConfig = function(...)
  -- function num : 0_3 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

  GuildData.VigourConfig = {}
  local range = nil
  for k,v in pairs((TableData.gTable).BaseGuildActiveRewardData) do
    range = split(v.level_range, ":")
    for i = tonumber(range[1]), tonumber(range[2]) do
      -- DECOMPILER ERROR at PC31: Confused about usage of register: R10 in 'UnsetPending'

      if (GuildData.VigourConfig)[i] == nil then
        (GuildData.VigourConfig)[i] = {}
      end
      ;
      (table.insert)((GuildData.VigourConfig)[i], {Id = v.id, Type = v.type, Value = v.value, Rewards = v.rewards})
    end
  end
  local count = #GuildData.VigourConfig
  for i = 1, count do
    (table.sort)((GuildData.VigourConfig)[i], function(x, y, ...)
    -- function num : 0_3_0
    do return x.Value < y.Value end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  end
end

-- DECOMPILER ERROR at PC167: Confused about usage of register: R0 in 'UnsetPending'

GuildData.InitShowChats = function(chatData, ...)
  -- function num : 0_4 , upvalues : _ENV
  local chatCount = #chatData
  local logCount = #GuildData.LogInfos
  local chatIndex = 1
  local logIndex = logCount
  local chatItem, logItem = nil, nil
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R7 in 'UnsetPending'

  GuildData.ShowChats = {}
  local maxCount, maxIndex = nil, nil
  if GuildData.MAX_CHAT_AMOUNT < chatCount + logCount then
    maxCount = GuildData.MAX_CHAT_AMOUNT
  else
    maxCount = chatCount + logCount
  end
  maxIndex = maxCount
  while 1 do
    while 1 do
      while 1 do
        if maxIndex > 0 then
          chatItem = chatData[chatIndex]
          logItem = (GuildData.LogInfos)[logIndex]
          -- DECOMPILER ERROR at PC37: Confused about usage of register: R9 in 'UnsetPending'

          if chatItem ~= nil and (logItem == nil or logItem.time <= chatItem.time) then
            (GuildData.ShowChats)[maxIndex] = chatItem
            maxIndex = maxIndex - 1
            chatIndex = chatIndex + 1
            -- DECOMPILER ERROR at PC40: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC40: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC40: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC40: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
      -- DECOMPILER ERROR at PC51: Confused about usage of register: R9 in 'UnsetPending'

      if logItem ~= nil then
        if logItem.logType == (ProtoEnum.GUILD_LOG).JOIN_LOG then
          (GuildData.ShowChats)[maxIndex] = logItem
          maxIndex = maxIndex - 1
        end
        logIndex = logIndex - 1
        -- DECOMPILER ERROR at PC54: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC54: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  if chatItem == nil then
    if logItem == nil or maxIndex > 0 then
      for i = 1, maxCount - (maxIndex) do
        -- DECOMPILER ERROR at PC72: Confused about usage of register: R13 in 'UnsetPending'

        (GuildData.ShowChats)[i] = (GuildData.ShowChats)[i + (maxIndex)]
      end
      for i = maxCount - (maxIndex) + 1, maxCount do
        -- DECOMPILER ERROR at PC81: Confused about usage of register: R13 in 'UnsetPending'

        (GuildData.ShowChats)[i] = nil
      end
    end
  end
end

-- DECOMPILER ERROR at PC170: Confused about usage of register: R0 in 'UnsetPending'

GuildData.InitEmojiList = function(...)
  -- function num : 0_5 , upvalues : _ENV
  if #GuildData.ExpressionList <= 0 then
    (table.insert)(GuildData.ExpressionGroup, {id = GuildData.OFTEN_TYPE_KEY, name = (PUtil.get)(20000318)})
    local mStr = (Util.GetPlayerSetting)(PlayerPrefsKeyName.GUILD_CHAT_OFTEN, "")
    local content = (Util.ParseConfigStr)(mStr)
    ;
    (table.sort)(content, function(a, b, ...)
    -- function num : 0_5_0 , upvalues : _ENV
    do return tonumber(b[2]) < tonumber(a[2]) end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    local length = (math.min)(GuildData.OFTEN_TYPE_MAX_NUM, #content)
    -- DECOMPILER ERROR at PC45: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (GuildData.ExpressionList)[GuildData.OFTEN_TYPE_KEY] = {}
    for i = 1, length do
      local id = tonumber((content[i])[1])
      local configData = ((TableData.gTable).BaseGuildExpressionData)[id]
      if configData then
        (table.insert)((GuildData.ExpressionList)[GuildData.OFTEN_TYPE_KEY], configData)
      end
    end
    local configData = (TableData.gTable).BaseGuildExpressionData
    for _,v in pairs(configData) do
      -- DECOMPILER ERROR at PC87: Confused about usage of register: R9 in 'UnsetPending'

      if not (GuildData.ExpressionList)[v.group_id] then
        (GuildData.ExpressionList)[v.group_id] = {}
      end
      ;
      (table.insert)((GuildData.ExpressionList)[v.group_id], v)
      if not (GuildData.IsContainExpressionGroup)(v.group_id) then
        (table.insert)(GuildData.ExpressionGroup, {id = v.group_id, name = v.remark})
      end
    end
    ;
    (table.sort)(GuildData.ExpressionGroup, function(a, b, ...)
    -- function num : 0_5_1
    do return a.id < b.id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  end
end

-- DECOMPILER ERROR at PC173: Confused about usage of register: R0 in 'UnsetPending'

GuildData.AddEmojiToOftenList = function(id, ...)
  -- function num : 0_6 , upvalues : _ENV
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  if not (GuildData.ExpressionList)[GuildData.OFTEN_TYPE_KEY] then
    (GuildData.ExpressionList)[GuildData.OFTEN_TYPE_KEY] = {}
  end
  local mStr = (Util.GetPlayerSetting)(PlayerPrefsKeyName.GUILD_CHAT_OFTEN, "")
  local content = (Util.ParseConfigStr)(mStr)
  local str = ""
  local isContain = false
  for _,v in ipairs(content) do
    if #v > 1 then
      local mID = tonumber(v[1])
      local mNum = tonumber(v[2])
      if mID == id then
        v[2] = mNum + 1
        isContain = true
      end
      if str == "" then
        str = v[1] .. ":" .. v[2]
      else
        str = str .. "," .. v[1] .. ":" .. v[2]
      end
    end
  end
  if not isContain then
    if str == "" then
      str = id .. ":" .. 1
    else
      str = str .. "," .. id .. ":" .. 1
    end
  end
  ;
  (Util.SetPlayerSetting)(PlayerPrefsKeyName.GUILD_CHAT_OFTEN, str)
  content = (Util.ParseConfigStr)(str)
  ;
  (table.sort)(content, function(a, b, ...)
    -- function num : 0_6_0 , upvalues : _ENV
    do return tonumber(b[2]) < tonumber(a[2]) end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  local length = (math.min)(GuildData.OFTEN_TYPE_MAX_NUM, #content)
  -- DECOMPILER ERROR at PC100: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (GuildData.ExpressionList)[GuildData.OFTEN_TYPE_KEY] = {}
  for i = 1, length do
    local id = tonumber((content[i])[1])
    local configData = ((TableData.gTable).BaseGuildExpressionData)[id]
    if configData then
      (table.insert)((GuildData.ExpressionList)[GuildData.OFTEN_TYPE_KEY], configData)
    end
  end
end

-- DECOMPILER ERROR at PC176: Confused about usage of register: R0 in 'UnsetPending'

GuildData.IsContainExpressionGroup = function(id, ...)
  -- function num : 0_7 , upvalues : _ENV
  for _,v in ipairs(GuildData.ExpressionGroup) do
    if v.id == id then
      return true
    end
  end
  return false
end

-- DECOMPILER ERROR at PC179: Confused about usage of register: R0 in 'UnsetPending'

GuildData.InitMemberList = function(memberList, ...)
  -- function num : 0_8 , upvalues : _ENV
  (table.sort)(memberList, function(x, y, ...)
    -- function num : 0_8_0
    if x.post == y.post then
      if y.fc >= x.fc then
        do return x.onlineTime ~= 0 or y.onlineTime ~= 0 end
        do return y.post < x.post end
        if x.onlineTime == 0 and y.onlineTime > 0 then
          return true
        elseif y.onlineTime == 0 and x.onlineTime > 0 then
          return false
        else
          return y.onlineTime < x.onlineTime
        end
        -- DECOMPILER ERROR: 8 unprocessed JMP targets
      end
    end
  end
)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  GuildData.MemberList = memberList
  local count = #memberList
  local data = nil
  for i = 1, count do
    data = (GuildData.MemberList)[i]
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (GuildData.MemberList)[data.objectindex] = i
  end
end

-- DECOMPILER ERROR at PC182: Confused about usage of register: R0 in 'UnsetPending'

GuildData.InitGuildPositionRights = function(...)
  -- function num : 0_9 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

  GuildData.PositionRights = {}
  for k,v in pairs((TableData.gTable).BaseGuildJobData) do
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R5 in 'UnsetPending'

    (GuildData.PositionRights)[v.level] = k
  end
end

-- DECOMPILER ERROR at PC185: Confused about usage of register: R0 in 'UnsetPending'

GuildData.GetPositionName = function(position, ...)
  -- function num : 0_10 , upvalues : _ENV
  return (PUtil.get)(60000223 + position)
end

-- DECOMPILER ERROR at PC188: Confused about usage of register: R0 in 'UnsetPending'

GuildData.GetPositionUIIndex = function(position, ...)
  -- function num : 0_11 , upvalues : _ENV
  if position == (ProtoEnum.GUILD_POST).LEADER_POST then
    return 0
  else
    if position == (ProtoEnum.GUILD_POST).VICE_LEADER_POST then
      return 1
    else
      return 2
    end
  end
end

-- DECOMPILER ERROR at PC191: Confused about usage of register: R0 in 'UnsetPending'

GuildData.InitGuildLevelConfig = function(...)
  -- function num : 0_12 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

  GuildData.GuildLevelConfig = {}
  for k,v in pairs((TableData.gTable).BaseGuildLevelUpData) do
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R5 in 'UnsetPending'

    (GuildData.GuildLevelConfig)[v.level] = k
  end
end

-- DECOMPILER ERROR at PC194: Confused about usage of register: R0 in 'UnsetPending'

GuildData.InitBuildConfig = function(...)
  -- function num : 0_13 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

  GuildData.BuildConfig = {}
  for k,v in pairs((TableData.gTable).BaseGuildBuildData) do
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R5 in 'UnsetPending'

    (GuildData.BuildConfig)[v.type] = k
  end
end

-- DECOMPILER ERROR at PC197: Confused about usage of register: R0 in 'UnsetPending'

GuildData.InitGuildBadgeConfig = function(...)
  -- function num : 0_14 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

  GuildData.BadgeConfig = {}
  for k,v in pairs((TableData.gTable).BaseGuildBadgeData) do
    (table.insert)(GuildData.BadgeConfig, k)
  end
end

-- DECOMPILER ERROR at PC200: Confused about usage of register: R0 in 'UnsetPending'

GuildData.UpdateGuildBuildingInfo = function(data, appendType, ...)
  -- function num : 0_15 , upvalues : _ENV
  if appendType ~= nil then
    if appendType == 1 then
      local count = #data.record
      for i = 1, count do
        (table.insert)((GuildData.BuildingInfo).record, (data.record)[i])
      end
    else
      do
        local count = #data.yetRewardType
        for i = 1, count do
          (table.insert)((GuildData.BuildingInfo).yetRewardType, (data.yetRewardType)[i])
        end
        do
          -- DECOMPILER ERROR at PC38: Confused about usage of register: R2 in 'UnsetPending'

          ;
          (GuildData.BuildingInfo).buildingPlan = data.buildingPlan
          -- DECOMPILER ERROR at PC42: Confused about usage of register: R2 in 'UnsetPending'

          ;
          (GuildData.BuildingInfo).buildingNum = data.buildingNum
          -- DECOMPILER ERROR at PC45: Confused about usage of register: R2 in 'UnsetPending'

          GuildData.BuildingInfo = data
          local count = #(GuildData.BuildingInfo).yetRewardType
          local RewardStatus = {}
          for i = 1, count do
            RewardStatus[((GuildData.BuildingInfo).yetRewardType)[i]] = true
          end
          -- DECOMPILER ERROR at PC63: Confused about usage of register: R4 in 'UnsetPending'

          ;
          (GuildData.BuildingInfo).RewardStatus = RewardStatus
          if (((TableData.gTable).BaseFixedData)[GuildData.DAILY_BUILD_LIMIT]).int_value <= (GuildData.BuildingInfo).buildingNum and not (GuildData.CheckBuildingRewardAvailable)() then
            (RedDotMgr.EliminateRedDot)((WinResConfig.GuildMainWindow).name, RedDotComID.Guild_Construction)
          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC203: Confused about usage of register: R0 in 'UnsetPending'

GuildData.CheckBuildingRewardAvailable = function(...)
  -- function num : 0_16 , upvalues : _ENV
  local vigourConfig = (GuildData.VigourConfig)[(GuildData.BaseInfo).dayFixationLevel]
  local maxVigour = (vigourConfig[#vigourConfig]).Value
  local vigour = (GuildData.BuildingInfo).buildingPlan
  if maxVigour < vigour then
    vigour = maxVigour
  end
  local count = #vigourConfig
  for i = 1, count do
    local data = vigourConfig[i]
    if ((GuildData.BuildingInfo).RewardStatus)[data.Id] == nil and data.Value <= vigour then
      return true
    end
  end
  return false
end

-- DECOMPILER ERROR at PC206: Confused about usage of register: R0 in 'UnsetPending'

GuildData.GetSelfRights = function(...)
  -- function num : 0_17 , upvalues : _ENV
  return ((TableData.gTable).BaseGuildJobData)[(GuildData.PositionRights)[GuildData.SelfPosition]]
end

-- DECOMPILER ERROR at PC209: Confused about usage of register: R0 in 'UnsetPending'

GuildData.GetGuildIcon = function(icon, ...)
  -- function num : 0_18 , upvalues : _ENV
  if icon == 0 then
    icon = (((TableData.gTable).BaseFixedData)[GuildData.DEFAULT_BADGE_ID]).int_value
  end
  return (Util.GetItemUrl)((((TableData.gTable).BaseGuildBadgeData)[icon]).icon)
end


