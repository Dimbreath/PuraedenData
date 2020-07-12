-- params : ...
-- function num : 0 , upvalues : _ENV
GuildMgr = {}
local self = GuildMgr
local _couldReqGuildList = true
local _openGuildUI = false
local _openNonpartyUI = false
local _currentPanel = nil
local _requesting = false
-- DECOMPILER ERROR at PC10: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.OpenGuild = function(...)
  -- function num : 0_0 , upvalues : _ENV
  if (_G.next)(GuildData.GuildLevelConfig) == nil then
    (GuildData.InitGuildLevelConfig)()
  end
  if (_G.next)(GuildData.PositionRights) == nil then
    (GuildData.InitGuildPositionRights)()
  end
  if (ActorData.GetGuildID)() == 0 then
    (GuildMgr.TryEnterNonpartyWindow)()
  else
    ;
    (GuildMgr.OpenGuildMainUI)()
  end
end

-- DECOMPILER ERROR at PC13: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.TryEnterNonpartyWindow = function(...)
  -- function num : 0_1 , upvalues : _ENV, _openNonpartyUI
  if (_G.next)(GuildData.GuildList) == nil then
    _openNonpartyUI = true
    ;
    (GuildMgr.ReqGuildList)()
  else
    OpenWindow((WinResConfig.GuildNonpartyWindow).name, UILayer.HUD)
  end
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.OpenGuildMainUI = function(...)
  -- function num : 0_2 , upvalues : _openGuildUI, _ENV
  _openGuildUI = true
  ;
  (GuildService.ReqGuildDetailInfo)()
  ;
  (RedDotMgr.EliminateRedDot)((WinResConfig.GuildMainWindow).name, RedDotComID.Guild_ApplyPass)
end

-- DECOMPILER ERROR at PC19: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.InitGuildBaseInfo = function(...)
  -- function num : 0_3 , upvalues : _ENV
  if (_G.next)(GuildData.GuildLevelConfig) == nil then
    (GuildData.InitGuildLevelConfig)()
  end
  if (_G.next)(GuildData.PositionRights) == nil then
    (GuildData.InitGuildPositionRights)()
  end
  ;
  (GuildService.ReqGuildDetailInfo)()
end

-- DECOMPILER ERROR at PC22: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.ReqGuildList = function(...)
  -- function num : 0_4 , upvalues : _couldReqGuildList, _ENV
  if _couldReqGuildList == false then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000306))
    return false
  end
  _couldReqGuildList = false
  ;
  (SimpleTimer.setTimeout)(1, function(...)
    -- function num : 0_4_0 , upvalues : _couldReqGuildList
    _couldReqGuildList = true
  end
)
  ;
  (GuildService.ReqGuildList)()
  return true
end

-- DECOMPILER ERROR at PC25: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.RecvGuildList = function(msg, forceOpen, ...)
  -- function num : 0_5 , upvalues : _ENV, _openNonpartyUI
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R2 in 'UnsetPending'

  GuildData.MyApplyList = msg.applys
  local same = #GuildData.GuildList == #msg.guilds
  if same then
    local count = #GuildData.GuildList
    for i = 1, count do
      if ((GuildData.GuildList)[i]).id ~= ((msg.guilds)[i]).id or ((GuildData.GuildList)[i]).joinMinFc ~= ((msg.guilds)[i]).joinMinFc or ((GuildData.GuildList)[i]).leader ~= ((msg.guilds)[i]).leader or ((GuildData.GuildList)[i]).fc ~= ((msg.guilds)[i]).fc or ((GuildData.GuildList)[i]).activation ~= ((msg.guilds)[i]).activation or ((GuildData.GuildList)[i]).memberCount ~= ((msg.guilds)[i]).memberCount or ((GuildData.GuildList)[i]).level ~= ((msg.guilds)[i]).level then
        same = false
        break
      end
    end
  end
  -- DECOMPILER ERROR at PC89: Confused about usage of register: R3 in 'UnsetPending'

  GuildData.GuildList = msg.guilds
  -- DECOMPILER ERROR at PC93: Confused about usage of register: R3 in 'UnsetPending'

  GuildData.JoinTimeStamp = msg.cd / 1000
  if _openNonpartyUI or forceOpen then
    (GuideMgr.InGuideOpenWindow)((WinResConfig.GuildNonpartyWindow).name)
    _openNonpartyUI = false
  else
    (MessageMgr.SendCenterTips)((PUtil.get)(60000304))
    UIMgr:SendWindowMessage((WinResConfig.GuildNonpartyWindow).name, (WindowMsgEnum.Guild).E_MSG_REFRESH_GUILD_LIST, {Type = GuildListType.AllGuild, Same = same})
  end
  -- DECOMPILER ERROR: 7 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC28: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.RecvGuildDetailInfo = function(msg, ...)
  -- function num : 0_6 , upvalues : _ENV, _openGuildUI
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  GuildData.BaseInfo = msg.baseInfo
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

  if (GuildData.BaseInfo).icon == 0 then
    (GuildData.BaseInfo).icon = (((TableData.gTable).BaseFixedData)[GuildData.DEFAULT_BADGE_ID]).int_value
  end
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

  GuildData.OnlineCount = msg.onlineCount
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'

  GuildData.Announcement = msg.notice
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R1 in 'UnsetPending'

  GuildData.LogInfos = msg.logList
  local pos = {}
  local data = nil
  local count = #(GuildData.BaseInfo).members
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R4 in 'UnsetPending'

  GuildData.ViceLeaderCount = 0
  for i = 1, count do
    data = ((GuildData.BaseInfo).members)[i]
    pos[data.objectindex] = data.post
    -- DECOMPILER ERROR at PC56: Confused about usage of register: R8 in 'UnsetPending'

    if data.post == (ProtoEnum.GUILD_POST).VICE_LEADER_POST then
      GuildData.ViceLeaderCount = GuildData.ViceLeaderCount + 1
    end
    -- DECOMPILER ERROR at PC65: Confused about usage of register: R8 in 'UnsetPending'

    if data.objectindex == (ActorData.GetPlayerIndex)() then
      GuildData.SelfPosition = data.post
    end
  end
  -- DECOMPILER ERROR at PC69: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (GuildData.BaseInfo).members = pos
  if _openGuildUI then
    _openGuildUI = false
    if UIMgr:IsWindowOpen((WinResConfig.GuildNonpartyWindow).name) then
      UIMgr:CloseWindow((WinResConfig.GuildNonpartyWindow).name, true, true)
    end
    OpenWindow((WinResConfig.GuildMainWindow).name, UILayer.HUD, function(...)
    -- function num : 0_6_0 , upvalues : _ENV
    (ChatService.ReqGetGuildChat)()
  end
)
  end
end

-- DECOMPILER ERROR at PC31: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.ReqChangeGuildChatStatus = function(open, ...)
  -- function num : 0_7 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  GuildData.InGuild = open
  ;
  (ChatService.ReqSetRecvGuildChat)(open)
end

-- DECOMPILER ERROR at PC34: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.AfterOperateGuild = function(data, ...)
  -- function num : 0_8 , upvalues : _ENV
  if data.act == (ProtoEnum.GUILD_ACTION).APPLY_ACTION then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000313))
    ;
    (GuildData.AddItemToApplyList)(data.id)
    UIMgr:SendWindowMessage((WinResConfig.GuildNonpartyWindow).name, (WindowMsgEnum.Guild).E_MSG_REFRESH_GUILD_LIST)
  else
    if data.act == (ProtoEnum.GUILD_ACTION).CANCEL_ACTION then
      (MessageMgr.SendCenterTips)((PUtil.get)(60000314))
      ;
      (GuildData.RemoveItemFromApplyList)(data.id)
      UIMgr:SendWindowMessage((WinResConfig.GuildNonpartyWindow).name, (WindowMsgEnum.Guild).E_MSG_REFRESH_GUILD_LIST)
    else
      if data.act == (ProtoEnum.GUILD_ACTION).JOIN_ACTION then
        (ActorData.SetGuildID)(data.id)
        ;
        (GuildMgr.OpenGuildMainUI)()
        ;
        (SuperSDKUtil.SendAdGuildJoined)()
      end
    end
  end
end

-- DECOMPILER ERROR at PC37: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.PreSearchGuild = function(guildName, ...)
  -- function num : 0_9 , upvalues : _ENV
  if (Util.StringIsNullOrEmpty)(guildName) then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000302))
    return 
  end
  ;
  (GuildService.ReqSearchGuild)(guildName)
end

-- DECOMPILER ERROR at PC40: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.RecvSearchGuild = function(data, ...)
  -- function num : 0_10 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  GuildData.SearchResultList = data.guildInfo
  if #GuildData.SearchResultList == 0 then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000303))
  end
  UIMgr:SendWindowMessage((WinResConfig.GuildNonpartyWindow).name, (WindowMsgEnum.Guild).E_MSG_REFRESH_GUILD_LIST, {Type = GuildListType.SearchResult})
end

-- DECOMPILER ERROR at PC43: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.PreCreateGuild = function(guildName, ...)
  -- function num : 0_11 , upvalues : _ENV
  if (Util.NameCheck)(guildName, (PUtil.get)(60000215), Const.MIN_NAME_LENGTH, Const.MAX_NAME_LENGTH) == false then
    return 
  end
  ;
  (MessageMgr.OpenCostResConfirmWindow)(60000525, (((TableData.gTable).BaseFixedData)[GuildData.CREATE_GUILD_COST]).array_value, function(...)
    -- function num : 0_11_0 , upvalues : _ENV, guildName
    (GuildService.ReqCreateGuild)(guildName)
  end
, nil, nil, true)
end

-- DECOMPILER ERROR at PC46: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.ReqImmediatelyJoin = function(data, ...)
  -- function num : 0_12 , upvalues : _ENV
  if (LuaTime.GetTimeStamp)() < GuildData.JoinTimeStamp then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000290, (LuaTime.GetLeftTimeStr)(GuildData.JoinTimeStamp, true)))
    return 
  end
  if data.memberCount == (((TableData.gTable).BaseGuildLevelUpData)[(GuildData.GuildLevelConfig)[data.level]]).max_member then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000396))
    return 
  end
  ;
  (GuildService.ReqImmediatelyJoin)(data.id)
end

-- DECOMPILER ERROR at PC49: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.ReqApplyGuild = function(id, ...)
  -- function num : 0_13 , upvalues : _ENV
  if (LuaTime.GetTimeStamp)() < GuildData.JoinTimeStamp then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000290, (LuaTime.GetLeftTimeStr)(GuildData.JoinTimeStamp, true)))
    return 
  end
  ;
  (GuildService.ReqApplyJoin)(id)
end

-- DECOMPILER ERROR at PC52: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.QuickJoinGuild = function(...)
  -- function num : 0_14 , upvalues : _ENV
  if (LuaTime.GetTimeStamp)() < GuildData.JoinTimeStamp then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000290, (LuaTime.GetLeftTimeStr)(GuildData.JoinTimeStamp, true)))
    return 
  end
  local count = #GuildData.GuildList
  local data, maxCount = nil, nil
  for i = 1, count do
    data = (GuildData.GuildList)[i]
    maxCount = (((TableData.gTable).BaseGuildLevelUpData)[(GuildData.GuildLevelConfig)[data.level]]).max_member
    if ((GuildData.GuildList)[i]).joinMinFc == 0 and data.memberCount < maxCount then
      (GuildService.ReqImmediatelyJoin)(((GuildData.GuildList)[i]).id)
      return 
    end
  end
  ;
  (MessageMgr.SendCenterTips)((PUtil.get)(60000217))
end

-- DECOMPILER ERROR at PC55: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.PreOpenGuildRewardStatus = function(...)
  -- function num : 0_15 , upvalues : _ENV
  if (_G.next)(GuildData.RewardData) == nil then
    (GuildData.InitRewardData)()
  end
  if (_G.next)(GuildData.RewardStatus) == nil then
    (GuildService.ReqGuildGiftInit)()
  else
    OpenWindow((WinResConfig.GuildWelfareWindow).name, UILayer.HUD)
  end
end

-- DECOMPILER ERROR at PC58: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.RecvGuildRewardStatus = function(msg, ...)
  -- function num : 0_16 , upvalues : _ENV
  local count = #msg.posAndType
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R2 in 'UnsetPending'

  GuildData.RewardStatus = {}
  local hideRedNode = true
  for i = 1, count do
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R7 in 'UnsetPending'

    (GuildData.RewardStatus)[((msg.posAndType)[i]).pos] = (msg.posAndType)[i]
    if not ((msg.posAndType)[i]).isDraw then
      hideRedNode = false
    end
  end
  if UIMgr:IsWindowOpen((WinResConfig.GuildWelfareWindow).name) then
    if hideRedNode then
      (RedDotMgr.EliminateRedDot)((WinResConfig.GuildMainWindow).name, RedDotComID.Guild_Gift)
    end
    UIMgr:SendWindowMessage((WinResConfig.GuildWelfareWindow).name, (WindowMsgEnum.Guild).E_MSG_REFRESH_WELFARE_STATUS)
  else
    OpenWindow((WinResConfig.GuildWelfareWindow).name, UILayer.HUD)
  end
end

-- DECOMPILER ERROR at PC61: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.ViewGuildMemeber = function(memberInfo, ...)
  -- function num : 0_17 , upvalues : _ENV
  memberInfo.Rights = (GuildMgr.GetSpecifyRights)(GuildData.SelfPosition, memberInfo.objectindex, memberInfo.post)
  if (GuildData.MemberCards)[memberInfo.objectindex] == nil then
    (GuildService.ReqPlayerCards)(memberInfo.objectindex)
  else
    OpenWindow((WinResConfig.GuildPlayerInfoWindow).name, UILayer.HUD, memberInfo, (GuildData.MemberCards)[memberInfo.objectindex])
  end
end

-- DECOMPILER ERROR at PC64: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.RecvMemberCards = function(data, ...)
  -- function num : 0_18 , upvalues : _ENV
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  (GuildData.MemberCards)[data.objectIndex] = data.cardList
  OpenWindow((WinResConfig.GuildPlayerInfoWindow).name, UILayer.HUD, (GuildData.MemberList)[(GuildData.MemberList)[data.objectIndex]], data.cardList)
end

-- DECOMPILER ERROR at PC67: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.GetSpecifyRights = function(selfPosition, target, targetPosition, ...)
  -- function num : 0_19 , upvalues : _ENV
  local rights = {}
  if target ~= (ActorData.GetPlayerIndex)() then
    local rightConfig = ((TableData.gTable).BaseGuildJobData)[(GuildData.PositionRights)[selfPosition]]
    if rightConfig.transfer_guild > 0 then
      (table.insert)(rights, {type = GuildMemberOperateType.Transfer})
    end
    if rightConfig.promotion == 1 and targetPosition < selfPosition then
      for i = selfPosition - 2, targetPosition, -1 do
        (table.insert)(rights, {type = GuildMemberOperateType.Promote, value = i + 1})
      end
    end
    do
      if rightConfig.downgrade == 1 and targetPosition < selfPosition then
        for i = targetPosition - 1, 1, -1 do
          (table.insert)(rights, {type = GuildMemberOperateType.Demote, value = i})
        end
      end
      do
        do
          if rightConfig.remove_member == 1 and targetPosition < selfPosition then
            (table.insert)(rights, {type = GuildMemberOperateType.KickOut})
          end
          ;
          (table.insert)(rights, {type = GuildMemberOperateType.Fight})
          return rights
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC70: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.ChangeMemberPosition = function(operateType, memberInfo, position, ...)
  -- function num : 0_20 , upvalues : _ENV
  if (GuildData.MemberList)[memberInfo.objectindex] == nil then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000318))
    return 
  end
  if position == (ProtoEnum.GUILD_POST).VICE_LEADER_POST then
    local config = ((TableData.gTable).BaseGuildLevelUpData)[(GuildData.GuildLevelConfig)[(GuildData.BaseInfo).level]]
    if config.max_vice_leader <= GuildData.ViceLeaderCount then
      local found = false
      local targetConfig = nil
      local count = #GuildData.GuildLevelConfig
      for i = (GuildData.BaseInfo).level + 1, count do
        targetConfig = ((TableData.gTable).BaseGuildLevelUpData)[(GuildData.GuildLevelConfig)[i]]
        if config.max_vice_leader < targetConfig.max_vice_leader then
          found = true
          break
        end
      end
      do
        do
          if found then
            (MessageMgr.SendCenterTips)((PUtil.get)(60000308, targetConfig.level))
          else
            ;
            (MessageMgr.SendCenterTips)((PUtil.get)(60000307))
          end
          do return  end
          ;
          (GuildService.ReqSetGuildJob)(memberInfo.objectindex, position)
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC73: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.RecvChangeMemberPosition = function(data, ...)
  -- function num : 0_21 , upvalues : _ENV
  (GuildMgr.UpdateMemberPosition)(data.objectIndex, data.newPost, true)
end

-- DECOMPILER ERROR at PC76: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.UpdateMemberPosition = function(roleId, position, showTips, ...)
  -- function num : 0_22 , upvalues : _ENV
  if ((GuildData.BaseInfo).members)[roleId] == position then
    return 
  end
  if position < ((GuildData.BaseInfo).members)[roleId] and showTips then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000245, ((GuildData.MemberList)[(GuildData.MemberList)[roleId]]).name, (GuildData.GetPositionName)(position)))
  else
    if showTips then
      (MessageMgr.SendCenterTips)((PUtil.get)(60000244, ((GuildData.MemberList)[(GuildData.MemberList)[roleId]]).name, (GuildData.GetPositionName)(position)))
    end
    if position == (ProtoEnum.GUILD_POST).LEADER_POST then
      for k,v in pairs((GuildData.BaseInfo).members) do
        -- DECOMPILER ERROR at PC76: Confused about usage of register: R8 in 'UnsetPending'

        if v == (ProtoEnum.GUILD_POST).LEADER_POST then
          ((GuildData.BaseInfo).members)[k] = (ProtoEnum.GUILD_POST).ELDER_POST
          -- DECOMPILER ERROR at PC93: Confused about usage of register: R8 in 'UnsetPending'

          if (_G.next)(GuildData.MemberList) ~= nil then
            ((GuildData.MemberList)[(GuildData.MemberList)[k]]).post = (ProtoEnum.GUILD_POST).ELDER_POST
          end
          break
        end
      end
      do
        -- DECOMPILER ERROR at PC108: Confused about usage of register: R3 in 'UnsetPending'

        if GuildData.SelfPosition == (ProtoEnum.GUILD_POST).LEADER_POST then
          GuildData.SelfPosition = (ProtoEnum.GUILD_POST).ELDER_POST
        else
          -- DECOMPILER ERROR at PC116: Confused about usage of register: R3 in 'UnsetPending'

          if roleId == (ActorData.GetPlayerIndex)() then
            GuildData.SelfPosition = position
          end
        end
        -- DECOMPILER ERROR at PC133: Confused about usage of register: R3 in 'UnsetPending'

        if (_G.next)(GuildData.MemberList) ~= nil then
          (GuildData.BaseInfo).leader = ((GuildData.MemberList)[(GuildData.MemberList)[roleId]]).name
        end
        ;
        (GuildMgr.RefreshGuildLeader)()
        -- DECOMPILER ERROR at PC150: Confused about usage of register: R3 in 'UnsetPending'

        if ((GuildData.BaseInfo).members)[roleId] == (ProtoEnum.GUILD_POST).VICE_LEADER_POST then
          GuildData.ViceLeaderCount = GuildData.ViceLeaderCount - 1
        else
          -- DECOMPILER ERROR at PC161: Confused about usage of register: R3 in 'UnsetPending'

          if position == (ProtoEnum.GUILD_POST).VICE_LEADER_POST then
            GuildData.ViceLeaderCount = GuildData.ViceLeaderCount + 1
          end
        end
        -- DECOMPILER ERROR at PC168: Confused about usage of register: R3 in 'UnsetPending'

        if roleId == (ActorData.GetPlayerIndex)() then
          GuildData.SelfPosition = position
        end
        -- DECOMPILER ERROR at PC172: Confused about usage of register: R3 in 'UnsetPending'

        ;
        ((GuildData.BaseInfo).members)[roleId] = position
        -- DECOMPILER ERROR at PC186: Confused about usage of register: R3 in 'UnsetPending'

        if (_G.next)(GuildData.MemberList) ~= nil then
          ((GuildData.MemberList)[(GuildData.MemberList)[roleId]]).post = position
        end
        UIMgr:SendWindowMessage((WinResConfig.GuildPlayerInfoWindow).name, (WindowMsgEnum.Guild).E_MSG_REFRESH_MEMBER_RIGHTS, (GuildMgr.GetSpecifyRights)(GuildData.SelfPosition, roleId, position))
        UIMgr:SendWindowMessage((WinResConfig.GuildDetailWindow).name, (WindowMsgEnum.Guild).E_MSG_REFRESH_GUILD_MEMBER, true)
        UIMgr:SendWindowMessage((WinResConfig.GuildDetailWindow).name, (WindowMsgEnum.Guild).E_MSG_REFRESH_MEMBER_RIGHTS)
      end
    end
  end
end

-- DECOMPILER ERROR at PC79: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.KickOutMember = function(memberInfo, ...)
  -- function num : 0_23 , upvalues : _ENV
  if (GuildData.MemberList)[memberInfo.objectindex] == nil then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000318))
    return 
  end
  ;
  (MessageMgr.OpenConfirmWindow)((PUtil.get)(60000502, memberInfo.name), function(...)
    -- function num : 0_23_0 , upvalues : _ENV, memberInfo
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

    GuildData.KickOutMemberName = memberInfo.name
    ;
    (GuildService.ReqRemoveGuildMember)(memberInfo.objectindex)
  end
)
end

-- DECOMPILER ERROR at PC82: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.RecvKickOutMember = function(msg, ...)
  -- function num : 0_24 , upvalues : _ENV
  if (Util.StringIsNullOrEmpty)(GuildData.KickOutMemberName) == false then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000246, GuildData.KickOutMemberName))
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

    GuildData.KickOutMemberName = ""
  end
  UIMgr:CloseWindow((WinResConfig.GuildPlayerInfoWindow).name)
  UIMgr:SendWindowMessage((WinResConfig.GuildDetailWindow).name, (WindowMsgEnum.Guild).E_MSG_REFRESH_GUILD_MEMBER, true)
  ;
  (GuildMgr.RefreshMemberCount)()
end

-- DECOMPILER ERROR at PC85: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.RemoveMember = function(memberId, online, ...)
  -- function num : 0_25 , upvalues : _ENV
  if ((GuildData.BaseInfo).members)[memberId] == nil then
    return 
  end
  -- DECOMPILER ERROR at PC38: Confused about usage of register: R2 in 'UnsetPending'

  if ((GuildData.BaseInfo).members)[memberId] ~= nil and ((GuildData.BaseInfo).members)[((GuildData.BaseInfo).members)[memberId]] ~= nil then
    (GuildData.BaseInfo).fc = (GuildData.BaseInfo).fc - (((GuildData.BaseInfo).members)[((GuildData.BaseInfo).members)[memberId]]).fc
  end
  -- DECOMPILER ERROR at PC52: Confused about usage of register: R2 in 'UnsetPending'

  if ((GuildData.BaseInfo).members)[memberId] == (ProtoEnum.GUILD_POST).VICE_LEADER_POST then
    GuildData.ViceLeaderCount = GuildData.ViceLeaderCount - 1
  end
  -- DECOMPILER ERROR at PC59: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (GuildData.BaseInfo).memberCount = (GuildData.BaseInfo).memberCount - 1
  -- DECOMPILER ERROR at PC66: Confused about usage of register: R2 in 'UnsetPending'

  if online then
    GuildData.OnlineCount = GuildData.OnlineCount - 1
  end
  -- DECOMPILER ERROR at PC70: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((GuildData.BaseInfo).members)[memberId] = nil
  -- DECOMPILER ERROR at PC73: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (GuildData.MemberList)[memberId] = nil
  local count = #GuildData.MemberList
  local index = nil
  for i = 1, count do
    -- DECOMPILER ERROR at PC98: Confused about usage of register: R8 in 'UnsetPending'

    if memberId == ((GuildData.MemberList)[i]).objectindex then
      (GuildData.BaseInfo).fc = (GuildData.BaseInfo).fc - ((GuildData.MemberList)[i]).fc
      ;
      (table.remove)(GuildData.MemberList, i)
      count = count - 1
      index = i
      break
    end
  end
  do
    for i = index, count do
      -- DECOMPILER ERROR at PC119: Confused about usage of register: R8 in 'UnsetPending'

      (GuildData.MemberList)[((GuildData.MemberList)[i]).objectindex] = i
    end
    UIMgr:SendWindowMessage((WinResConfig.GuildDetailWindow).name, (WindowMsgEnum.Guild).E_MSG_REFRESH_GUILD_MEMBER)
  end
end

-- DECOMPILER ERROR at PC88: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.ReqGuildBuildingInfo = function(needInit, ...)
  -- function num : 0_26 , upvalues : _ENV, _requesting
  if needInit then
    (GuildMgr.InitGuildBaseInfo)()
  end
  if (_G.next)(GuildData.BuildConfig) == nil then
    (GuildData.InitBuildConfig)()
  end
  if (_G.next)(GuildData.VigourConfig) == nil then
    (GuildData.InitVigourConfig)()
  end
  _requesting = false
  ;
  (GuildService.ReqGuildBuildInit)()
end

-- DECOMPILER ERROR at PC91: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.RecvGuildBuildingInfo = function(data, ...)
  -- function num : 0_27 , upvalues : _ENV
  (GuildData.UpdateGuildBuildingInfo)(data)
  OpenWindow((WinResConfig.GuildBuildingWindow).name, UILayer.HUD)
end

-- DECOMPILER ERROR at PC94: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.ReqGuildBuild = function(type, cost, ...)
  -- function num : 0_28 , upvalues : _ENV, _requesting
  if (((TableData.gTable).BaseFixedData)[GuildData.DAILY_BUILD_LIMIT]).int_value <= (GuildData.BuildingInfo).buildingNum then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000249))
    return 
  end
  if _requesting then
    return 
  end
  _requesting = true
  ;
  (MessageMgr.OpenCostResConfirmWindow)(60000404, cost, function(...)
    -- function num : 0_28_0 , upvalues : _ENV, type
    (GuildService.ReqGuildBuild)(GuildBuildOperateType.Donate, type)
  end
, function(...)
    -- function num : 0_28_1 , upvalues : _requesting
    _requesting = false
  end
)
end

-- DECOMPILER ERROR at PC97: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.RecvGuildBuild = function(data, ...)
  -- function num : 0_29 , upvalues : _ENV, _requesting
  (GuildData.UpdateGuildBuildingInfo)(data.buildingGuild, data.type)
  local count = #data.goods
  for i = 1, count do
    (MessageMgr.OpenItemBuyTipsWindowBySingle)({id = ((data.goods)[i]).id, Num = ((data.goods)[i]).value})
  end
  if data.type == GuildBuildOperateType.Donate then
    local guildExp = {}
    guildExp.id = AssetType.GUILD_TOKEN
    guildExp.Num = (((TableData.gTable).BaseGuildBuildData)[(GuildData.BuildConfig)[data.param]]).guild_exp
    ;
    (MessageMgr.OpenItemBuyTipsWindowBySingle)(guildExp)
  else
    do
      if data.type == GuildBuildOperateType.AcquireRewards then
        loge("recv:" .. data.param)
        -- DECOMPILER ERROR at PC62: Confused about usage of register: R2 in 'UnsetPending'

        ;
        ((GuildData.BuildingInfo).RewardStatus)[data.param] = true
      end
      _requesting = false
      UIMgr:SendWindowMessage((WinResConfig.GuildBuildingWindow).name, (WindowMsgEnum.Guild).E_MSG_REFRESH_BUILD_INFO)
    end
  end
end

-- DECOMPILER ERROR at PC100: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.RecvGuildGiftGet = function(data, ...)
  -- function num : 0_30 , upvalues : _ENV
  local count = #data.goods
  for i = 1, count do
    (MessageMgr.OpenItemBuyTipsWindowBySingle)({id = ((data.goods)[i]).id, Num = ((data.goods)[i]).value})
  end
  ;
  (GuildService.ReqGuildGiftInit)()
end

-- DECOMPILER ERROR at PC103: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.RecvGuildGiftRank = function(data, ...)
  -- function num : 0_31 , upvalues : _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  GuildData.GuildGiftRank = {RankList = data.rank, SelfRank = 0}
  local count = #data.rank
  for i = 1, count do
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R6 in 'UnsetPending'

    if (((data.rank)[i]).memberInfo).objectindex == (ActorData.GetPlayerIndex)() then
      (GuildData.GuildGiftRank).SelfRank = i
      break
    end
  end
  do
    OpenWindow((WinResConfig.GuildWelfareRankingWindow).name, UILayer.HUD)
  end
end

-- DECOMPILER ERROR at PC106: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.ReqGetGuildVigourGift = function(id, ...)
  -- function num : 0_32 , upvalues : _ENV
  if ((GuildData.BuildingInfo).RewardStatus)[id] then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000250))
    return 
  end
  loge("id:" .. id)
  ;
  (GuildService.ReqGuildBuild)(GuildBuildOperateType.AcquireRewards, id)
end

-- DECOMPILER ERROR at PC109: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.ReqChangeGuildName = function(name, ...)
  -- function num : 0_33 , upvalues : _ENV
  if (Util.NameCheck)(name, (PUtil.get)(60000215), Const.MIN_NAME_LENGTH, Const.MAX_NAME_LENGTH) == false then
    return 
  end
  ;
  (MessageMgr.OpenCostResConfirmWindow)(60000405, (((TableData.gTable).BaseFixedData)[GuildData.MODIFY_NAME_COST]).array_value, function(...)
    -- function num : 0_33_0 , upvalues : _ENV, name
    (GuildService.ReqSetGuildInfo)((ProtoEnum.GUILD_SET).NAME_SET, name)
  end
, nil, nil, true, name)
end

-- DECOMPILER ERROR at PC112: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.ReqChangeBadge = function(index, ...)
  -- function num : 0_34 , upvalues : _ENV
  if index == 0 then
    return 
  end
  ;
  (GuildService.ReqSetGuildInfo)((ProtoEnum.GUILD_SET).ICON_SET, (((TableData.gTable).BaseGuildBadgeData)[(GuildData.BadgeConfig)[index]]).id)
end

-- DECOMPILER ERROR at PC115: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.ReqChangeAnnouncement = function(text, ...)
  -- function num : 0_35 , upvalues : _ENV
  if (Util.TextLegalCheck)(text) == false then
    return 
  end
  ;
  (GuildService.ReqSetGuildInfo)((ProtoEnum.GUILD_SET).NOTICE_SET, text)
end

-- DECOMPILER ERROR at PC118: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.RecvChangeGuildName = function(data, ...)
  -- function num : 0_36 , upvalues : _ENV, _currentPanel
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  if data.setType == (ProtoEnum.GUILD_SET).NAME_SET then
    (GuildData.BaseInfo).name = data.setValue
    ;
    (GuildMgr.InitGuildNameInfo)(_currentPanel)
    UIMgr:CloseWindow((WinResConfig.GuildRenameWindow).name)
  else
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R1 in 'UnsetPending'

    if data.setType == (ProtoEnum.GUILD_SET).ICON_SET then
      (GuildData.BaseInfo).icon = tonumber(data.setValue)
      ;
      (GuildMgr.InitChangeIconBtn)(_currentPanel)
      UIMgr:CloseWindow((WinResConfig.GuildBadgeWindow).name)
    else
      -- DECOMPILER ERROR at PC52: Confused about usage of register: R1 in 'UnsetPending'

      if data.setType == (ProtoEnum.GUILD_SET).NOTICE_SET then
        GuildData.Announcement = data.setValue
      else
        -- DECOMPILER ERROR at PC63: Confused about usage of register: R1 in 'UnsetPending'

        if data.setType == (ProtoEnum.GUILD_SET).COND_SET then
          (GuildData.BaseInfo).joinMinFc = data.setValue
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC121: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.TryDissolveGuild = function(...)
  -- function num : 0_37 , upvalues : _ENV
  (MessageMgr.OpenConfirmWindow)((PUtil.get)(60000276), function(...)
    -- function num : 0_37_0 , upvalues : _ENV
    OpenWindow((WinResConfig.GuildDissolveWindow).name, UILayer.HUD)
  end
)
end

-- DECOMPILER ERROR at PC124: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.ReqDissolveGuild = function(text, ...)
  -- function num : 0_38 , upvalues : _ENV
  if text ~= (PUtil.get)(60000498) then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000289))
    return 
  end
  ;
  (GuildService.ReqDisbandGuild)()
end

-- DECOMPILER ERROR at PC127: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.ReqQuitGuild = function(...)
  -- function num : 0_39 , upvalues : _ENV
  local quitCD = (((TableData.gTable).BaseFixedData)[GuildData.QUIT_GUILD_CD]).int_value
  ;
  (MessageMgr.OpenConfirmWindow)((PUtil.get)(60000275, (LuaTime.GetLeftTimeString)(-quitCD, true)), function(...)
    -- function num : 0_39_0 , upvalues : _ENV
    (GuildService.ReqQuitGuild)()
  end
)
end

-- DECOMPILER ERROR at PC130: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.RecvQuitGuild = function(info, ...)
  -- function num : 0_40 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  GuildData.GuildList = {}
  if UIMgr:IsWindowOpen((WinResConfig.GuildDetailWindow).name) then
    UIMgr:CloseWindow((WinResConfig.GuildDetailWindow).name, true, true)
    UIMgr:CloseWindow((WinResConfig.GuildMainWindow).name, true, true)
  end
  ;
  (ActorData.SetGuildID)(0)
  ;
  (GuildMgr.RecvGuildList)(info, true)
  ;
  (GuildMgr.DisposeAllRedDot)()
end

-- DECOMPILER ERROR at PC133: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.DisposeAllRedDot = function(...)
  -- function num : 0_41 , upvalues : _ENV
  local data = {
redDotList = {}
}
  ;
  (table.insert)(data.redDotList, {id = RedDotComID.Guild_ApplyPass})
  ;
  (table.insert)(data.redDotList, {id = RedDotComID.Guild_Construction})
  ;
  (table.insert)(data.redDotList, {id = RedDotComID.Guild_Guess})
  ;
  (table.insert)(data.redDotList, {id = RedDotComID.Guild_Gift})
  ;
  (table.insert)(data.redDotList, {id = RedDotComID.Guild_Detail_Apply})
  ;
  (RedDotService.OnResRemoveRedDot)(data)
end

-- DECOMPILER ERROR at PC136: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.ShowMemberList = function(...)
  -- function num : 0_42 , upvalues : _ENV
  if GuildData.NeedUpdateMemberInfo then
    (GuildService.ReqGuildMemberList)()
  else
    UIMgr:SendWindowMessage((WinResConfig.GuildDetailWindow).name, (WindowMsgEnum.Guild).E_MSG_REFRESH_GUILD_MEMBER)
  end
end

-- DECOMPILER ERROR at PC139: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.RecvMemberList = function(data, ...)
  -- function num : 0_43 , upvalues : _ENV
  (GuildData.InitMemberList)(data)
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  GuildData.NeedUpdateMemberInfo = false
  UIMgr:SendWindowMessage((WinResConfig.GuildDetailWindow).name, (WindowMsgEnum.Guild).E_MSG_REFRESH_GUILD_MEMBER)
end

-- DECOMPILER ERROR at PC142: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.ShowGuildApplyList = function(...)
  -- function num : 0_44 , upvalues : _ENV
  if GuildData.NeedUpdateApplyInfo then
    (GuildService.ReqGuildReview)()
  else
    UIMgr:SendWindowMessage((WinResConfig.GuildDetailWindow).name, (WindowMsgEnum.Guild).E_MSG_REFRESH_GUILD_APPLY)
  end
end

-- DECOMPILER ERROR at PC145: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.RecvGuildReview = function(data, ...)
  -- function num : 0_45 , upvalues : _ENV
  (table.sort)(data, function(x, y, ...)
    -- function num : 0_45_0
    do return x.applyTime < y.applyTime end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  GuildData.GuildApplyList = data
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  GuildData.NeedUpdateApplyInfo = false
  UIMgr:SendWindowMessage((WinResConfig.GuildDetailWindow).name, (WindowMsgEnum.Guild).E_MSG_REFRESH_GUILD_APPLY)
end

-- DECOMPILER ERROR at PC148: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.ReqSetGuildJoinCondition = function(value, ...)
  -- function num : 0_46 , upvalues : _ENV
  if value == nil or value < 0 then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000281))
    return 
  end
  value = (math.floor)(value)
  ;
  (GuildService.ReqSetGuildInfo)((ProtoEnum.GUILD_SET).COND_SET, value)
end

-- DECOMPILER ERROR at PC151: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.ReqProcessApply = function(type, data, ...)
  -- function num : 0_47 , upvalues : _ENV
  if type == (ProtoEnum.GUILD_APPLY).PASS_APPLY then
    local levelConfig = ((TableData.gTable).BaseGuildLevelUpData)[(GuildData.GuildLevelConfig)[(GuildData.BaseInfo).level]]
    if levelConfig.max_member <= (GuildData.BaseInfo).memberCount then
      (MessageMgr.SendCenterTips)((PUtil.get)(60000315))
      return 
    end
    local applyCount = #data
    if applyCount > 1 and levelConfig.max_member < (GuildData.BaseInfo).memberCount + applyCount then
      local listData = (Util.Copy)(GuildData.GuildApplyList)
      ;
      (table.sort)(listData, function(x, y, ...)
    -- function num : 0_47_0
    do return y.fc < x.fc end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
      data = {}
      applyCount = levelConfig.max_member - (GuildData.BaseInfo).memberCount
      for i = 1, applyCount do
        (table.insert)(data, (listData[i]).objectindex)
      end
    end
  end
  do
    ;
    (GuildService.ReqProcessApply)(type, data)
  end
end

-- DECOMPILER ERROR at PC154: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.RecvProcessApply = function(data, ...)
  -- function num : 0_48 , upvalues : _ENV
  local count = #data.objectIndex
  local ids = {}
  for i = 1, count do
    ids[(data.objectIndex)[i]] = true
  end
  count = #GuildData.GuildApplyList
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R3 in 'UnsetPending'

  if data.act == (ProtoEnum.GUILD_APPLY).PASS_APPLY then
    GuildData.NeedUpdateMemberInfo = true
  end
  local index = 1
  while 1 do
    -- DECOMPILER ERROR at PC48: Confused about usage of register: R4 in 'UnsetPending'

    if index <= count then
      if ids[((GuildData.GuildApplyList)[index]).objectindex] then
        if data.act == (ProtoEnum.GUILD_APPLY).PASS_APPLY then
          (GuildData.BaseInfo).fc = (GuildData.BaseInfo).fc + ((GuildData.GuildApplyList)[index]).fc
          -- DECOMPILER ERROR at PC59: Confused about usage of register: R4 in 'UnsetPending'

          if ((GuildData.GuildApplyList)[index]).onlineTime == 0 then
            GuildData.OnlineCount = GuildData.OnlineCount + 1
          end
        end
        ;
        (table.remove)(GuildData.GuildApplyList, index)
        count = count - 1
        index = index - 1
      end
      index = index + 1
      -- DECOMPILER ERROR at PC69: LeaveBlock: unexpected jumping out IF_THEN_STMT

      -- DECOMPILER ERROR at PC69: LeaveBlock: unexpected jumping out IF_STMT

    end
  end
  UIMgr:SendWindowMessage((WinResConfig.GuildDetailWindow).name, (WindowMsgEnum.Guild).E_MSG_REFRESH_GUILD_APPLY, true)
  ;
  (GuildMgr.RefreshMemberCount)()
end

-- DECOMPILER ERROR at PC157: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.SyncGuildData = function(data, ...)
  -- function num : 0_49 , upvalues : _ENV, _currentPanel
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  (GuildData.BaseInfo).level = data.level
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (GuildData.BaseInfo).exp = data.exp
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (GuildData.BaseInfo).activation = data.activation
  ;
  (GuildMgr.InitLevelInfo)(_currentPanel)
  ;
  (GuildMgr.InitVigourInfo)(_currentPanel)
end

-- DECOMPILER ERROR at PC160: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.ReqGuildPK = function(id, serverId, ...)
  -- function num : 0_50 , upvalues : _ENV
  if (GuildData.MemberList)[id] == nil then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000318))
    return 
  end
  ;
  (GuildService.ReqGuildPK)(id, serverId)
end

-- DECOMPILER ERROR at PC163: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.EnterSetFormation = function(data, ...)
  -- function num : 0_51 , upvalues : _ENV
  local btnData = {}
  btnData.btnTxt = (PUtil.get)(20000021)
  btnData.fun = function(cards, ...)
    -- function num : 0_51_0 , upvalues : _ENV
    (GuildService.ReqInGuildPK)((Util.CovertLoaclFormationToRemote)(cards))
  end

  local formationData = {}
  formationData.formationType = FormationType.Basic
  formationData.otherPlayerList = (Util.CovertRivalCardStateToLocal)(data.rivalCardGroup)
  formationData.myselfList = (Util.CovertRemoteFormationToLocal)(data.ownCardGroup)
  formationData.battleType = (ProtoEnum.E_BATTLE_TYPE).GUILD_PK
  formationData.BtnData = btnData
  ;
  (MessageMgr.OpenFormationWindow)(formationData)
end

-- DECOMPILER ERROR at PC166: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.AfterBattle = function(msg, ...)
  -- function num : 0_52 , upvalues : _ENV
  if msg.success then
    local m = {}
    m.BattleType = (ProtoEnum.E_BATTLE_TYPE).GUILD_PK
    ;
    (CommonWinMgr.OpenBattleSettleConvergeWindow)(m)
  else
    do
      local m = {}
      m.BattleType = (ProtoEnum.E_BATTLE_TYPE).GUILD_PK
      ;
      (CommonWinMgr.OpenBattleFailConvergeWindow)(m)
    end
  end
end

-- DECOMPILER ERROR at PC169: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.InitGuildBasicInfoPanel = function(panel, panelType, ...)
  -- function num : 0_53 , upvalues : _currentPanel, _ENV
  _currentPanel = panel
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (_currentPanel.c1Ctr).selectedIndex = panelType - 1
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (panel.NameTxt).text = (PUtil.get)(60000267)
  ;
  (GuildMgr.InitChangeIconBtn)(panel)
  ;
  (GuildMgr.InitGuildNameInfo)(panel)
  ;
  (GuildMgr.InitLevelInfo)(panel)
  ;
  (GuildMgr.InitAnnouncement)(panel)
  if panelType == GuildDetailPanelType.Building then
    (GuildMgr.InitBuildingLog)(panel)
  else
    ;
    (GuildMgr.InitChangeNameBtn)(panel)
    ;
    (GuildMgr.InitVigourInfo)(panel)
    ;
    (GuildMgr.InitPowerInfo)(panel)
    ;
    (GuildMgr.InitGuildLeaderInfo)(panel)
    ;
    (GuildMgr.InitMemberCountInfo)(panel)
    if panelType == GuildDetailPanelType.Main then
      (GuildMgr.InitDetailBtn)(panel)
    else
      ;
      (GuildMgr.InitQuitBtn)(panel)
    end
  end
end

-- DECOMPILER ERROR at PC172: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.RefreshGuildLeader = function(...)
  -- function num : 0_54 , upvalues : _ENV, _currentPanel
  (GuildMgr.InitChangeIconBtn)(_currentPanel)
  ;
  (GuildMgr.InitAnnouncement)(_currentPanel)
  if (_currentPanel.c1Ctr).selectedIndex + 1 ~= GuildDetailPanelType.Building then
    (GuildMgr.InitChangeNameBtn)(_currentPanel)
    ;
    (GuildMgr.InitGuildLeaderInfo)(_currentPanel)
    if (_currentPanel.c1Ctr).selectedIndex + 1 == GuildDetailPanelType.SubInterface then
      (GuildMgr.InitQuitBtn)(_currentPanel)
    end
  end
end

-- DECOMPILER ERROR at PC175: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.RefreshMemberCount = function(...)
  -- function num : 0_55 , upvalues : _ENV, _currentPanel
  (GuildMgr.InitPowerInfo)(_currentPanel)
  ;
  (GuildMgr.InitMemberCountInfo)(_currentPanel)
end

-- DECOMPILER ERROR at PC178: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.InitDetailBtn = function(panel, isDetail, ...)
  -- function num : 0_56 , upvalues : _ENV
  if not isDetail then
    isDetail = false
  end
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  if isDetail then
    (panel.DetailsBtn).text = (PUtil.get)(78)
    ;
    ((panel.DetailsBtn).onClick):Set(GuildMgr.ClickGuildDetailBtn)
  else
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (panel.DetailsBtn).text = (PUtil.get)(78)
    ;
    ((panel.DetailsBtn).onClick):Set(GuildMgr.ClickGuildDetailBtn)
  end
end

-- DECOMPILER ERROR at PC181: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.InitQuitBtn = function(panel, ...)
  -- function num : 0_57 , upvalues : _ENV
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  if GuildData.SelfPosition == (ProtoEnum.GUILD_POST).LEADER_POST then
    (panel.OutBtn).text = (PUtil.get)(60000273)
    ;
    ((panel.OutBtn).onClick):Set(GuildMgr.TryDissolveGuild)
  else
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (panel.OutBtn).text = (PUtil.get)(60000274)
    ;
    ((panel.OutBtn).onClick):Set(GuildMgr.ReqQuitGuild)
  end
end

-- DECOMPILER ERROR at PC184: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.ClickGuildDetailBtn = function(...)
  -- function num : 0_58 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

  GuildData.NeedUpdateMemberInfo = true
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R0 in 'UnsetPending'

  GuildData.NeedUpdateApplyInfo = true
  OpenWindow((WinResConfig.GuildDetailWindow).name, UILayer.HUD)
end

-- DECOMPILER ERROR at PC187: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.InitBuildingLog = function(panel, ...)
  -- function num : 0_59 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ((panel.ContentGrp).WordTxt).text = (PUtil.get)(60000270)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

  if #(GuildData.BuildingInfo).record == 0 then
    ((panel.ContentGrp).c1Ctr).selectedIndex = 0
    -- DECOMPILER ERROR at PC22: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((panel.ContentGrp).AnimationTxt).text = (PUtil.get)(60000271)
    ;
    (Util.SetNotFoundEffect)((panel.ContentGrp).AnimationLoader)
  else
    -- DECOMPILER ERROR at PC31: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((panel.ContentGrp).c1Ctr).selectedIndex = 1
    ;
    ((panel.ContentGrp).BadgeTipsList):SetVirtual()
    local count = #(GuildData.BuildingInfo).record
    do
      -- DECOMPILER ERROR at PC43: Confused about usage of register: R2 in 'UnsetPending'

      ((panel.ContentGrp).BadgeTipsList).itemRenderer = function(index, item, ...)
    -- function num : 0_59_0 , upvalues : _ENV, count
    local data = ((GuildData.BuildingInfo).record)[count - index]
    print(data.type)
    ;
    (item:GetChild("PlayerNameTxt")).text = data.pName
    local config = ((TableData.gTable).BaseGuildBuildData)[(GuildData.BuildConfig)[data.type]]
    local cost = split(config.cost, ":")
    local imgStr = "<img src=\'" .. (Util.GetUrlFromItemID)(tonumber(cost[2]), tonumber(cost[1])) .. "\' "
    imgStr = imgStr .. "width=\'22\' height=\'22\'/>"
    imgStr = imgStr .. "[color=" .. Const.GreenColor .. "]" .. tostring(cost[3]) .. "[/color]"
    ;
    (item:GetChild("BuildWordTxt")).text = (PUtil.get)(60000272, imgStr)
    ;
    (item:GetChild("n14")).visible = index + 1 ~= count
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end

      -- DECOMPILER ERROR at PC46: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((panel.ContentGrp).BadgeTipsList).numItems = count
    end
  end
end

-- DECOMPILER ERROR at PC190: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.InitChangeIconBtn = function(panel, ...)
  -- function num : 0_60 , upvalues : _ENV
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  ((panel.GuildIconGrp).GuildIconLoader).url = (GuildData.GetGuildIcon)((GuildData.BaseInfo).icon)
  if ((GuildData.GetSelfRights)()).change_badge == 1 then
    (((panel.GuildIconGrp).GuildIconLoader).onClick):Set(function(...)
    -- function num : 0_60_0 , upvalues : _ENV
    if (_G.next)(GuildData.BadgeConfig) == nil then
      (GuildData.InitGuildBadgeConfig)()
    end
    OpenWindow((WinResConfig.GuildBadgeWindow).name, UILayer.HUD)
  end
)
  else
    ;
    (((panel.GuildIconGrp).GuildIconLoader).onClick):Clear()
  end
end

-- DECOMPILER ERROR at PC193: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.InitChangeNameBtn = function(panel, ...)
  -- function num : 0_61 , upvalues : _ENV
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  (panel.GuildNameBtn).visible = ((GuildData.GetSelfRights)()).change_name == 1
  ;
  ((panel.GuildNameBtn).onClick):Set(GuildMgr.ClickChangeNameBtn)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC196: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.ClickChangeNameBtn = function(...)
  -- function num : 0_62 , upvalues : _ENV
  OpenWindow((WinResConfig.GuildRenameWindow).name, UILayer.HUD)
end

-- DECOMPILER ERROR at PC199: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.InitGuildNameInfo = function(panel, ...)
  -- function num : 0_63 , upvalues : _ENV
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  (panel.GuildNameTxt).text = (GuildData.BaseInfo).name
end

-- DECOMPILER ERROR at PC202: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.InitLevelInfo = function(panel, ...)
  -- function num : 0_64 , upvalues : _ENV
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  (panel.LevelTxt).text = (GuildData.BaseInfo).level
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

  if (GuildData.GuildLevelConfig)[(GuildData.BaseInfo).level + 1] == nil then
    (panel.ExpTxt).text = (PUtil.get)(60000262)
    ;
    ((panel.root):GetChild("LevelBar")).value = 100
  else
    local config = ((TableData.gTable).BaseGuildLevelUpData)[(GuildData.GuildLevelConfig)[(GuildData.BaseInfo).level]]
    -- DECOMPILER ERROR at PC47: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (panel.ExpTxt).text = tostring((GuildData.BaseInfo).exp) .. "/" .. tostring(config.next_exp)
    ;
    ((panel.root):GetChild("LevelBar")).value = (GuildData.BaseInfo).exp / config.next_exp * 100
  end
end

-- DECOMPILER ERROR at PC205: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.InitVigourInfo = function(panel, ...)
  -- function num : 0_65 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ((panel.ActiveGrp).NameTxt).text = (PUtil.get)(60000259)
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((panel.ActiveGrp).c1Ctr).selectedIndex = 0
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((panel.ActiveGrp).WordTxt).text = (GuildData.BaseInfo).activation
end

-- DECOMPILER ERROR at PC208: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.InitPowerInfo = function(panel, ...)
  -- function num : 0_66 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ((panel.BattleTxt).NameTxt).text = (PUtil.get)(109)
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((panel.BattleTxt).c1Ctr).selectedIndex = 1
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((panel.BattleTxt).WordTxt).text = (GuildData.BaseInfo).fc
end

-- DECOMPILER ERROR at PC211: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.InitGuildLeaderInfo = function(panel, ...)
  -- function num : 0_67 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ((panel.BossGrp).NameTxt).text = (PUtil.get)(60000208)
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((panel.BossGrp).c1Ctr).selectedIndex = 2
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((panel.BossGrp).WordTxt).text = (GuildData.BaseInfo).leader
end

-- DECOMPILER ERROR at PC214: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.InitMemberCountInfo = function(panel, ...)
  -- function num : 0_68 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ((panel.NumberTxt).NameTxt).text = (PUtil.get)(60000260)
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((panel.NumberTxt).c1Ctr).selectedIndex = 3
  local levelConfig = ((TableData.gTable).BaseGuildLevelUpData)[(GuildData.GuildLevelConfig)[(GuildData.BaseInfo).level]]
  -- DECOMPILER ERROR at PC43: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((panel.NumberTxt).WordTxt).text = tostring((GuildData.BaseInfo).memberCount) .. "/" .. tostring(levelConfig.max_member) .. "  [color=" .. Const.GreenColor .. "](" .. (PUtil.get)(60000261, GuildData.OnlineCount) .. ")"
end

-- DECOMPILER ERROR at PC217: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.InitAnnouncement = function(panel, ...)
  -- function num : 0_69 , upvalues : _ENV
  (panel.NoticeList):RemoveChildrenToPool()
  local item = (panel.NoticeList):AddItemFromPool()
  local text = item:GetChild("NoticeTxt")
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R3 in 'UnsetPending'

  if ((GuildData.GetSelfRights)()).change_notice == 1 then
    (panel.Decorate_04_Image).visible = true
    text.touchable = true
    ;
    (text.onFocusIn):Set(function(...)
    -- function num : 0_69_0 , upvalues : _ENV, text
    if (Util.StringIsNullOrEmpty)(GuildData.Announcement) then
      text.text = ""
    end
  end
)
    ;
    (text.onFocusOut):Set(function(...)
    -- function num : 0_69_1 , upvalues : text, _ENV
    if text.text ~= GuildData.Announcement then
      (GuildMgr.ReqChangeAnnouncement)(text.text)
    end
    if (Util.StringIsNullOrEmpty)(text.text) then
      text.text = (PUtil.get)(60000310)
    end
  end
)
    ;
    ((panel.NoticeList).onClick):Set(function(...)
    -- function num : 0_69_2 , upvalues : text
    text:RequestFocus()
  end
)
  else
    -- DECOMPILER ERROR at PC33: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (panel.Decorate_04_Image).visible = false
    text.touchable = false
    ;
    (text.onFocusIn):Clear()
    ;
    (text.onFocusOut):Clear()
    ;
    ((panel.NoticeList).onClick):Clear()
  end
  if (Util.StringIsNullOrEmpty)(GuildData.Announcement) == false then
    text.text = GuildData.Announcement
  else
    text.text = (PUtil.get)(60000310)
  end
end

-- DECOMPILER ERROR at PC220: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.RecvNewLog = function(log, ...)
  -- function num : 0_70 , upvalues : _ENV
  if log.logType ~= (ProtoEnum.GUILD_LOG).DOWNGRADE_LOG then
    (table.insert)(GuildData.LogInfos, log)
  end
  if log.logType == (ProtoEnum.GUILD_LOG).PROMOTION_LOG or log.logType == (ProtoEnum.GUILD_LOG).DOWNGRADE_LOG then
    (GuildMgr.UpdateMemberPosition)(log.objectindex, tonumber(log.param))
  else
    -- DECOMPILER ERROR at PC44: Confused about usage of register: R1 in 'UnsetPending'

    if log.logType == (ProtoEnum.GUILD_LOG).JOIN_LOG then
      (GuildData.BaseInfo).memberCount = (GuildData.BaseInfo).memberCount + 1
      -- DECOMPILER ERROR at PC54: Confused about usage of register: R1 in 'UnsetPending'

      if tonumber(log.param) == 1 then
        GuildData.OnlineCount = GuildData.OnlineCount + 1
      end
      -- DECOMPILER ERROR at PC62: Confused about usage of register: R1 in 'UnsetPending'

      ;
      ((GuildData.BaseInfo).members)[log.objectindex] = (ProtoEnum.GUILD_POST).MEMBER_POST
      -- DECOMPILER ERROR at PC64: Confused about usage of register: R1 in 'UnsetPending'

      GuildData.NeedUpdateMemberInfo = true
      ;
      (GuildMgr.RecvNewChat)(log)
    else
      if log.logType == (ProtoEnum.GUILD_LOG).QUIT_LOG then
        (GuildMgr.RemoveMember)(log.objectindex, true)
      else
        if tonumber(log.param) ~= 1 then
          (GuildMgr.RemoveMember)(log.objectindex, log.logType ~= (ProtoEnum.GUILD_LOG).OUT_LOG)
          UIMgr:SendWindowMessage((WinResConfig.GuildDetailWindow).name, (WindowMsgEnum.Guild).E_MSG_REFRESH_GUILD_LOG)
          ;
          (GuildMgr.RefreshMemberCount)()
          -- DECOMPILER ERROR: 2 unprocessed JMP targets
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC223: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.RecvGuildChat = function(msg, ...)
  -- function num : 0_71 , upvalues : _ENV
  (GuildData.InitShowChats)(msg.chatData)
  UIMgr:SendWindowMessage((WinResConfig.GuildMainWindow).name, (WindowMsgEnum.Guild).E_MSG_INIT_GUILD_CHAT)
end

-- DECOMPILER ERROR at PC226: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.RecvNewChat = function(chatData, ...)
  -- function num : 0_72 , upvalues : _ENV
  if GuildData.MAX_CHAT_AMOUNT <= #GuildData.ShowChats then
    (table.remove)(GuildData.ShowChats, 1)
  end
  ;
  (table.insert)(GuildData.ShowChats, chatData)
  UIMgr:SendWindowMessage((WinResConfig.GuildMainWindow).name, (WindowMsgEnum.Guild).E_MSG_INIT_GUILD_CHAT)
end

self.CupType = {Covered = 1, Demonstrate = 2}
-- DECOMPILER ERROR at PC233: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.GetGuessMaxTime = function(...)
  -- function num : 0_73 , upvalues : _ENV
  local level = (GuildData.BaseInfo).level
  local config = (TableData.gTable).BaseGuildLevelUpData
  for _,v in pairs(config) do
    if v.level == level then
      return v.lottery_times
    end
  end
end

-- DECOMPILER ERROR at PC236: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.InitGuessData = function(data, ...)
  -- function num : 0_74 , upvalues : self
  self.GuessData = data
  self.RoundReward = data.reward
end

-- DECOMPILER ERROR at PC239: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.UpdateRoundReward = function(data, ...)
  -- function num : 0_75 , upvalues : self, _ENV
  if data.round == (self.RoundReward).round then
    for _,v in ipairs(data.reward) do
      (table.insert)((self.RoundReward).reward, v)
    end
  else
    do
      self.RoundReward = data
    end
  end
end

-- DECOMPILER ERROR at PC242: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.ResetRoundReward = function(round, ...)
  -- function num : 0_76 , upvalues : self
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  (self.RoundReward).reward = {}
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.RoundReward).round = round
end

-- DECOMPILER ERROR at PC245: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.GetRoundReward = function(...)
  -- function num : 0_77 , upvalues : self
  return self.RoundReward
end

-- DECOMPILER ERROR at PC248: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.GetGuessTimes = function(times, ...)
  -- function num : 0_78 , upvalues : self
  if times == nil then
    return (self.GuessData).guessCapNum
  else
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self.GuessData).guessCapNum = times
  end
end

-- DECOMPILER ERROR at PC251: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.GetGuessRoundTimes = function(times, ...)
  -- function num : 0_79 , upvalues : self
  if times == nil then
    return (self.GuessData).num
  else
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self.GuessData).num = times
  end
end

-- DECOMPILER ERROR at PC254: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.GetGuessIsCovered = function(covered, ...)
  -- function num : 0_80 , upvalues : self
  if (self.GuessData).guessCapsState ~= (self.CupType).Covered then
    do return covered ~= nil end
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self.GuessData).guessCapsState = covered
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
  end
end

-- DECOMPILER ERROR at PC257: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.GetGuessGoods = function(goods, ...)
  -- function num : 0_81 , upvalues : self
  if goods == nil then
    return (self.GuessData).goods
  else
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self.GuessData).goods = goods
  end
end

-- DECOMPILER ERROR at PC260: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.GetGuessOpenList = function(opens, ...)
  -- function num : 0_82 , upvalues : self
  if opens == nil then
    return (self.GuessData).openCaps
  else
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (self.GuessData).openCaps = opens
  end
end

-- DECOMPILER ERROR at PC263: Confused about usage of register: R6 in 'UnsetPending'

GuildMgr.GetCupsIsOpen = function(index, ...)
  -- function num : 0_83 , upvalues : _ENV, self
  for _,v in ipairs((self.GuessData).openCaps) do
    if v == index then
      return true
    end
  end
  return false
end


