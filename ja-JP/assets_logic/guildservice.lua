-- params : ...
-- function num : 0 , upvalues : _ENV
GuildService = {}
-- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

GuildService.Init = function(...)
  -- function num : 0_0 , upvalues : _ENV
  (Net.AddListener)((Proto.MsgName).ResGuildList, GuildService.RecvGuildList)
  ;
  (Net.AddListener)((Proto.MsgName).ResSearchGuild, GuildService.RecvSearchGuild)
  ;
  (Net.AddListener)((Proto.MsgName).ResJoinGuild, GuildService.RecvJoinGuild)
  ;
  (Net.AddListener)((Proto.MsgName).ResCreateGuild, GuildService.RecvCreateGuild)
  ;
  (Net.AddListener)((Proto.MsgName).ResGuildDetailInfo, GuildService.RecvGuildDetailInfo)
  ;
  (Net.AddListener)((Proto.MsgName).ResSetGuildInfo, GuildService.RecvSetGuildInfo)
  ;
  (Net.AddListener)((Proto.MsgName).ResDisbandGuild, GuildService.ResDisbandGuild)
  ;
  (Net.AddListener)((Proto.MsgName).ResQuitGuild, GuildService.RecvQuitGuild)
  ;
  (Net.AddListener)((Proto.MsgName).ResGuildMemberList, GuildService.RecvGuildMemberList)
  ;
  (Net.AddListener)((Proto.MsgName).ResSetGuildJob, GuildService.RecvSetGuildJob)
  ;
  (Net.AddListener)((Proto.MsgName).ResRemoveGuildMember, GuildService.RecvRemoveGuildMember)
  ;
  (Net.AddListener)((Proto.MsgName).ResGuildReview, GuildService.RecvGuildReview)
  ;
  (Net.AddListener)((Proto.MsgName).ResProcessApply, GuildService.ResProcessApply)
  ;
  (Net.AddListener)((Proto.MsgName).ResGuildRank, GuildService.RecvGuildRank)
  ;
  (Net.AddListener)((Proto.MsgName).ResGuildBaseInfo, GuildService.RecvGuildBaseInfo)
  ;
  (Net.AddListener)((Proto.MsgName).ResGuildBuildInit, GuildService.RecvGuildBuildInit)
  ;
  (Net.AddListener)((Proto.MsgName).ResGuildBuild, GuildService.RecvGuildBuild)
  ;
  (Net.AddListener)((Proto.MsgName).ResGuildGiftInit, GuildService.RecvGuildGiftInit)
  ;
  (Net.AddListener)((Proto.MsgName).ResGuildGiftGet, GuildService.RecvGuildGiftGet)
  ;
  (Net.AddListener)((Proto.MsgName).ResGuildGiftRank, GuildService.RecvGuildGiftRank)
  ;
  (Net.AddListener)((Proto.MsgName).ResGuildGameInit, GuildService.RecvGuildGameInit)
  ;
  (Net.AddListener)((Proto.MsgName).ResBeginGuildGame, GuildService.RecvBeginGuildGame)
  ;
  (Net.AddListener)((Proto.MsgName).ResGuildGamePlay, GuildService.RecvGuildGamePlay)
  ;
  (Net.AddListener)((Proto.MsgName).ResGuildGameReset, GuildService.RecvGuildGameReset)
  ;
  (Net.AddListener)((Proto.MsgName).ResGuildGameRecord, GuildService.RecvGuildGameRecord)
  ;
  (Net.AddListener)((Proto.MsgName).ResGuildLog, GuildService.RecvGuildLog)
  ;
  (Net.AddListener)((Proto.MsgName).ResSyncGuildData, GuildService.RecvSyncGuildData)
  ;
  (Net.AddListener)((Proto.MsgName).ResGuildPK, GuildService.RecvGuildPK)
  ;
  (Net.AddListener)((Proto.MsgName).ResSettleGuildPK, GuildService.RecvSettleGuildPK)
  ;
  (Net.AddListener)((Proto.MsgName).ResPlayerCards, GuildService.RecvPlayerCards)
  ;
  (Net.AddListener)((Proto.MsgName).ResGuildSummary, GuildService.RecvGuildSummary)
  ;
  (Net.AddListener)((Proto.MsgName).ResPopUpLevelUp, GuildService.ResPopUpLevelUp)
end

-- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

GuildService.ReqGuildList = function(...)
  -- function num : 0_1 , upvalues : _ENV
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqGuildList, m, (Proto.MsgName).ResGuildList)
end

-- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

GuildService.RecvGuildList = function(msg, ...)
  -- function num : 0_2 , upvalues : _ENV
  (GuildMgr.RecvGuildList)(msg.info)
end

-- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

GuildService.ReqSearchGuild = function(guildName, ...)
  -- function num : 0_3 , upvalues : _ENV
  local m = {}
  m.guildName = guildName
  ;
  (Net.Send)((Proto.MsgName).ReqSearchGuild, m, (Proto.MsgName).ResSearchGuild)
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

GuildService.RecvSearchGuild = function(msg, ...)
  -- function num : 0_4 , upvalues : _ENV
  (GuildMgr.RecvSearchGuild)(msg)
end

-- DECOMPILER ERROR at PC19: Confused about usage of register: R0 in 'UnsetPending'

GuildService.ReqImmediatelyJoin = function(guildId, ...)
  -- function num : 0_5 , upvalues : _ENV
  (GuildService.ReqJoinGuild)(guildId, (ProtoEnum.GUILD_ACTION).JOIN_ACTION)
end

-- DECOMPILER ERROR at PC22: Confused about usage of register: R0 in 'UnsetPending'

GuildService.ReqApplyJoin = function(guildId, ...)
  -- function num : 0_6 , upvalues : _ENV
  (GuildService.ReqJoinGuild)(guildId, (ProtoEnum.GUILD_ACTION).APPLY_ACTION)
end

-- DECOMPILER ERROR at PC25: Confused about usage of register: R0 in 'UnsetPending'

GuildService.ReqCancelJoin = function(guildId, ...)
  -- function num : 0_7 , upvalues : _ENV
  (GuildService.ReqJoinGuild)(guildId, (ProtoEnum.GUILD_ACTION).CANCEL_ACTION)
end

-- DECOMPILER ERROR at PC28: Confused about usage of register: R0 in 'UnsetPending'

GuildService.ReqJoinGuild = function(guildId, action, ...)
  -- function num : 0_8 , upvalues : _ENV
  local m = {}
  m.id = guildId
  m.act = action
  ;
  (Net.Send)((Proto.MsgName).ReqJoinGuild, m, (Proto.MsgName).ResJoinGuild)
end

-- DECOMPILER ERROR at PC31: Confused about usage of register: R0 in 'UnsetPending'

GuildService.RecvJoinGuild = function(msg, ...)
  -- function num : 0_9 , upvalues : _ENV
  (GuildMgr.AfterOperateGuild)(msg)
end

-- DECOMPILER ERROR at PC34: Confused about usage of register: R0 in 'UnsetPending'

GuildService.ReqCreateGuild = function(guildName, ...)
  -- function num : 0_10 , upvalues : _ENV
  local m = {}
  m.guildName = guildName
  ;
  (Net.Send)((Proto.MsgName).ReqCreateGuild, m, (Proto.MsgName).ResCreateGuild)
end

-- DECOMPILER ERROR at PC37: Confused about usage of register: R0 in 'UnsetPending'

GuildService.RecvCreateGuild = function(msg, ...)
  -- function num : 0_11 , upvalues : _ENV
  (ActorData.SetGuildID)(msg.id)
  ;
  (GuildMgr.OpenGuildMainUI)()
end

local OpenGuess = false
-- DECOMPILER ERROR at PC41: Confused about usage of register: R1 in 'UnsetPending'

GuildService.ReqGuildDetailInfo = function(isGuess, ...)
  -- function num : 0_12 , upvalues : OpenGuess, _ENV
  OpenGuess = isGuess or false
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqGuildDetailInfo, m, (Proto.MsgName).ResGuildDetailInfo)
end

-- DECOMPILER ERROR at PC44: Confused about usage of register: R1 in 'UnsetPending'

GuildService.RecvGuildDetailInfo = function(msg, ...)
  -- function num : 0_13 , upvalues : _ENV, OpenGuess
  (GuildMgr.RecvGuildDetailInfo)(msg)
  if OpenGuess then
    (GuildService.ReqGuildGameInit)()
  end
  OpenGuess = false
end

-- DECOMPILER ERROR at PC47: Confused about usage of register: R1 in 'UnsetPending'

GuildService.ReqSetGuildInfo = function(type, value, ...)
  -- function num : 0_14 , upvalues : _ENV
  local m = {}
  m.setType = type
  m.setValue = tostring(value)
  ;
  (Net.Send)((Proto.MsgName).ReqSetGuildInfo, m, (Proto.MsgName).ResSetGuildInfo)
end

-- DECOMPILER ERROR at PC50: Confused about usage of register: R1 in 'UnsetPending'

GuildService.RecvSetGuildInfo = function(msg, ...)
  -- function num : 0_15 , upvalues : _ENV
  (GuildMgr.RecvChangeGuildName)(msg)
end

-- DECOMPILER ERROR at PC53: Confused about usage of register: R1 in 'UnsetPending'

GuildService.ReqDisbandGuild = function(...)
  -- function num : 0_16 , upvalues : _ENV
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqDisbandGuild, m, (Proto.MsgName).ResDisbandGuild)
end

-- DECOMPILER ERROR at PC56: Confused about usage of register: R1 in 'UnsetPending'

GuildService.ResDisbandGuild = function(msg, ...)
  -- function num : 0_17 , upvalues : _ENV
  (GuildMgr.RecvQuitGuild)(msg.info)
end

-- DECOMPILER ERROR at PC59: Confused about usage of register: R1 in 'UnsetPending'

GuildService.ReqQuitGuild = function(...)
  -- function num : 0_18 , upvalues : _ENV
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqQuitGuild, m, (Proto.MsgName).ResQuitGuild)
end

-- DECOMPILER ERROR at PC62: Confused about usage of register: R1 in 'UnsetPending'

GuildService.RecvQuitGuild = function(msg, ...)
  -- function num : 0_19 , upvalues : _ENV
  (GuildMgr.RecvQuitGuild)(msg.info)
end

-- DECOMPILER ERROR at PC65: Confused about usage of register: R1 in 'UnsetPending'

GuildService.ReqGuildMemberList = function(...)
  -- function num : 0_20 , upvalues : _ENV
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqGuildMemberList, m, (Proto.MsgName).ResGuildMemberList)
end

-- DECOMPILER ERROR at PC68: Confused about usage of register: R1 in 'UnsetPending'

GuildService.RecvGuildMemberList = function(msg, ...)
  -- function num : 0_21 , upvalues : _ENV
  (GuildMgr.RecvMemberList)(msg.memberList)
end

-- DECOMPILER ERROR at PC71: Confused about usage of register: R1 in 'UnsetPending'

GuildService.ReqSetGuildJob = function(roleId, position, ...)
  -- function num : 0_22 , upvalues : _ENV
  local m = {}
  m.objectIndex = roleId
  m.newPost = position
  ;
  (Net.Send)((Proto.MsgName).ReqSetGuildJob, m, (Proto.MsgName).ResSetGuildJob)
end

-- DECOMPILER ERROR at PC74: Confused about usage of register: R1 in 'UnsetPending'

GuildService.RecvSetGuildJob = function(msg, ...)
  -- function num : 0_23 , upvalues : _ENV
  (GuildMgr.RecvChangeMemberPosition)(msg)
end

-- DECOMPILER ERROR at PC77: Confused about usage of register: R1 in 'UnsetPending'

GuildService.ReqRemoveGuildMember = function(roleId, ...)
  -- function num : 0_24 , upvalues : _ENV
  local m = {}
  m.objectIndex = roleId
  ;
  (Net.Send)((Proto.MsgName).ReqRemoveGuildMember, m, (Proto.MsgName).ResRemoveGuildMember)
end

-- DECOMPILER ERROR at PC80: Confused about usage of register: R1 in 'UnsetPending'

GuildService.RecvRemoveGuildMember = function(msg, ...)
  -- function num : 0_25 , upvalues : _ENV
  (GuildMgr.RecvKickOutMember)(msg)
end

-- DECOMPILER ERROR at PC83: Confused about usage of register: R1 in 'UnsetPending'

GuildService.ReqGuildReview = function(...)
  -- function num : 0_26 , upvalues : _ENV
  local m = {}
  m.objectIndex = roleId
  ;
  (Net.Send)((Proto.MsgName).ReqGuildReview, m, (Proto.MsgName).ResGuildReview)
end

-- DECOMPILER ERROR at PC86: Confused about usage of register: R1 in 'UnsetPending'

GuildService.RecvGuildReview = function(msg, ...)
  -- function num : 0_27 , upvalues : _ENV
  (GuildMgr.RecvGuildReview)(msg.applyList)
end

-- DECOMPILER ERROR at PC89: Confused about usage of register: R1 in 'UnsetPending'

GuildService.ReqProcessApply = function(type, roleIds, ...)
  -- function num : 0_28 , upvalues : _ENV
  local m = {}
  m.act = type
  m.objectIndex = roleIds
  ;
  (Net.Send)((Proto.MsgName).ReqProcessApply, m, (Proto.MsgName).ResProcessApply)
end

-- DECOMPILER ERROR at PC92: Confused about usage of register: R1 in 'UnsetPending'

GuildService.ResProcessApply = function(msg, ...)
  -- function num : 0_29 , upvalues : _ENV
  (GuildMgr.RecvProcessApply)(msg)
end

-- DECOMPILER ERROR at PC95: Confused about usage of register: R1 in 'UnsetPending'

GuildService.ReqGuildRank = function(...)
  -- function num : 0_30 , upvalues : _ENV
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqGuildRank, m, (Proto.MsgName).ResGuildRank)
end

-- DECOMPILER ERROR at PC98: Confused about usage of register: R1 in 'UnsetPending'

GuildService.RecvGuildRank = function(msg, ...)
  -- function num : 0_31 , upvalues : _ENV
  OpenWindow((WinResConfig.GuildRankingWindow).name, UILayer.HUD, msg.guildRankList, msg.myGuildRank)
end

-- DECOMPILER ERROR at PC101: Confused about usage of register: R1 in 'UnsetPending'

GuildService.ReqGuildBaseInfo = function(...)
  -- function num : 0_32 , upvalues : _ENV
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqGuildBaseInfo, m, (Proto.MsgName).ResGuildBaseInfo)
end

-- DECOMPILER ERROR at PC104: Confused about usage of register: R1 in 'UnsetPending'

GuildService.RecvGuildBaseInfo = function(msg, ...)
  -- function num : 0_33
end

-- DECOMPILER ERROR at PC107: Confused about usage of register: R1 in 'UnsetPending'

GuildService.ReqGuildBuildInit = function(...)
  -- function num : 0_34 , upvalues : _ENV
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqGuildBuildInit, m, (Proto.MsgName).ResGuildBuildInit)
end

-- DECOMPILER ERROR at PC110: Confused about usage of register: R1 in 'UnsetPending'

GuildService.RecvGuildBuildInit = function(msg, ...)
  -- function num : 0_35 , upvalues : _ENV
  (GuildMgr.RecvGuildBuildingInfo)(msg.buildingGuild)
end

-- DECOMPILER ERROR at PC113: Confused about usage of register: R1 in 'UnsetPending'

GuildService.ReqGuildBuild = function(type, param, ...)
  -- function num : 0_36 , upvalues : _ENV
  local m = {}
  m.type = type
  m.param = param
  ;
  (Net.Send)((Proto.MsgName).ReqGuildBuild, m, (Proto.MsgName).ResGuildBuild)
end

-- DECOMPILER ERROR at PC116: Confused about usage of register: R1 in 'UnsetPending'

GuildService.RecvGuildBuild = function(msg, ...)
  -- function num : 0_37 , upvalues : _ENV
  (GuildMgr.RecvGuildBuild)(msg)
end

-- DECOMPILER ERROR at PC119: Confused about usage of register: R1 in 'UnsetPending'

GuildService.ReqGuildGiftInit = function(...)
  -- function num : 0_38 , upvalues : _ENV
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqGuildGiftInit, m, (Proto.MsgName).ResGuildGiftInit)
end

-- DECOMPILER ERROR at PC122: Confused about usage of register: R1 in 'UnsetPending'

GuildService.RecvGuildGiftInit = function(msg, ...)
  -- function num : 0_39 , upvalues : _ENV
  (GuildMgr.RecvGuildRewardStatus)(msg)
end

-- DECOMPILER ERROR at PC125: Confused about usage of register: R1 in 'UnsetPending'

GuildService.ReqGuildGiftGet = function(pos, ...)
  -- function num : 0_40 , upvalues : _ENV
  local m = {}
  m.pos = pos
  ;
  (Net.Send)((Proto.MsgName).ReqGuildGiftGet, m, (Proto.MsgName).ResGuildGiftGet)
end

-- DECOMPILER ERROR at PC128: Confused about usage of register: R1 in 'UnsetPending'

GuildService.RecvGuildGiftGet = function(msg, ...)
  -- function num : 0_41 , upvalues : _ENV
  (GuildMgr.RecvGuildGiftGet)(msg)
end

-- DECOMPILER ERROR at PC131: Confused about usage of register: R1 in 'UnsetPending'

GuildService.ReqGuildGiftRank = function(type, ...)
  -- function num : 0_42 , upvalues : _ENV
  local m = {}
  m.type = type
  ;
  (Net.Send)((Proto.MsgName).ReqGuildGiftRank, m, (Proto.MsgName).ResGuildGiftRank)
end

-- DECOMPILER ERROR at PC134: Confused about usage of register: R1 in 'UnsetPending'

GuildService.RecvGuildGiftRank = function(msg, ...)
  -- function num : 0_43 , upvalues : _ENV
  (GuildMgr.RecvGuildGiftRank)(msg)
end

-- DECOMPILER ERROR at PC137: Confused about usage of register: R1 in 'UnsetPending'

GuildService.RecvGuildLog = function(msg, ...)
  -- function num : 0_44 , upvalues : _ENV
  (GuildMgr.RecvNewLog)(msg.log)
end

-- DECOMPILER ERROR at PC140: Confused about usage of register: R1 in 'UnsetPending'

GuildService.RecvSyncGuildData = function(msg, ...)
  -- function num : 0_45 , upvalues : _ENV
  (GuildMgr.SyncGuildData)(msg)
end

-- DECOMPILER ERROR at PC143: Confused about usage of register: R1 in 'UnsetPending'

GuildService.ReqGuildPK = function(id, serverId, ...)
  -- function num : 0_46 , upvalues : _ENV
  local m = {}
  m.memberIndex = id
  m.serverId = serverId
  ;
  (Net.Send)((Proto.MsgName).ReqGuildPK, m, (Proto.MsgName).ResGuildPK)
end

-- DECOMPILER ERROR at PC146: Confused about usage of register: R1 in 'UnsetPending'

GuildService.RecvGuildPK = function(msg, ...)
  -- function num : 0_47 , upvalues : _ENV
  (GuildMgr.EnterSetFormation)(msg)
end

-- DECOMPILER ERROR at PC149: Confused about usage of register: R1 in 'UnsetPending'

GuildService.ReqInGuildPK = function(cards, ...)
  -- function num : 0_48 , upvalues : _ENV
  local m = {}
  m.cardGroup = cards
  ;
  (Net.Send)((Proto.MsgName).ReqInGuildPK, m)
end

-- DECOMPILER ERROR at PC152: Confused about usage of register: R1 in 'UnsetPending'

GuildService.ReqSettleGuildPK = function(data, ...)
  -- function num : 0_49 , upvalues : _ENV
  local m = {}
  m.battleCompleteData = data
  ;
  (Net.Send)((Proto.MsgName).ReqSettleGuildPK, m, (Proto.MsgName).ResSettleGuildPK, function(...)
    -- function num : 0_49_0 , upvalues : _ENV, data
    (GuildService.ReqSettleGuildPK)(data)
  end
)
end

-- DECOMPILER ERROR at PC155: Confused about usage of register: R1 in 'UnsetPending'

GuildService.RecvSettleGuildPK = function(msg, ...)
  -- function num : 0_50 , upvalues : _ENV
  (GuildMgr.AfterBattle)(msg)
end

-- DECOMPILER ERROR at PC158: Confused about usage of register: R1 in 'UnsetPending'

GuildService.ReqPlayerCards = function(id, ...)
  -- function num : 0_51 , upvalues : _ENV
  local m = {}
  m.objectIndex = id
  ;
  (Net.Send)((Proto.MsgName).ReqPlayerCards, m, (Proto.MsgName).ResPlayerCards)
end

-- DECOMPILER ERROR at PC161: Confused about usage of register: R1 in 'UnsetPending'

GuildService.RecvPlayerCards = function(msg, ...)
  -- function num : 0_52 , upvalues : _ENV
  (GuildMgr.RecvMemberCards)(msg)
end

-- DECOMPILER ERROR at PC164: Confused about usage of register: R1 in 'UnsetPending'

GuildService.ExternalOpenGuess = function(...)
  -- function num : 0_53 , upvalues : _ENV
  if GuildData.BaseInfo == nil then
    (GuildService.ReqGuildDetailInfo)(true)
  else
    ;
    (GuildService.ReqGuildGameInit)()
  end
end

-- DECOMPILER ERROR at PC167: Confused about usage of register: R1 in 'UnsetPending'

GuildService.ReqGuildGameInit = function(...)
  -- function num : 0_54 , upvalues : _ENV
  local m = {}
  m.type = GuessCupType.Guild
  ;
  (Net.Send)((Proto.MsgName).ReqGuildGameInit, m, (Proto.MsgName).ResGuildGameInit)
end

-- DECOMPILER ERROR at PC170: Confused about usage of register: R1 in 'UnsetPending'

GuildService.RecvGuildGameInit = function(msg, ...)
  -- function num : 0_55 , upvalues : _ENV
  if msg.type ~= GuessCupType.Guild then
    return 
  end
  ;
  (GuildMgr.InitGuessData)(msg)
  local maxTimes = (GuildMgr.GetGuessMaxTime)()
  local roundTimes = msg.num
  if msg.guessCapsState == 2 and roundTimes < maxTimes then
    (GuildService.ReqBeginGuildGame)()
  else
    OpenWindow((WinResConfig.GuildGuessWindow).name, UILayer.HUD)
  end
end

-- DECOMPILER ERROR at PC173: Confused about usage of register: R1 in 'UnsetPending'

GuildService.ReqBeginGuildGame = function(...)
  -- function num : 0_56 , upvalues : _ENV
  local m = {}
  m.type = GuessCupType.Guild
  ;
  (Net.Send)((Proto.MsgName).ReqBeginGuildGame, m, (Proto.MsgName).ResBeginGuildGame)
end

-- DECOMPILER ERROR at PC176: Confused about usage of register: R1 in 'UnsetPending'

GuildService.RecvBeginGuildGame = function(msg, ...)
  -- function num : 0_57 , upvalues : _ENV
  if msg.type ~= GuessCupType.Guild then
    return 
  end
  ;
  (GuildMgr.ResetRoundReward)(msg.num)
  ;
  (GuildMgr.GetGuessTimes)(msg.guessCapNum)
  ;
  (GuildMgr.GetGuessRoundTimes)(msg.num)
  ;
  (GuildMgr.GetGuessIsCovered)(msg.guessCapsState)
  ;
  (GuildMgr.GetGuessOpenList)({})
  if UIMgr:IsWindowOpen((WinResConfig.GuildGuessWindow).name) then
    UIMgr:SendWindowMessage((WinResConfig.GuildGuessWindow).name, 1)
  else
    OpenWindow((WinResConfig.GuildGuessWindow).name, UILayer.HUD)
  end
end

-- DECOMPILER ERROR at PC179: Confused about usage of register: R1 in 'UnsetPending'

GuildService.ReqGuildGamePlay = function(operateType, pos, guessNum, ...)
  -- function num : 0_58 , upvalues : _ENV
  local m = {}
  m.type = GuessCupType.Guild
  m.operType = operateType
  m.capPos = pos
  m.guessNum = guessNum
  ;
  (Net.Send)((Proto.MsgName).ReqGuildGamePlay, m, (Proto.MsgName).ResGuildGamePlay)
end

-- DECOMPILER ERROR at PC182: Confused about usage of register: R1 in 'UnsetPending'

GuildService.RecvGuildGamePlay = function(msg, ...)
  -- function num : 0_59 , upvalues : _ENV
  if msg.type ~= GuessCupType.Guild then
    return 
  end
  ;
  (GuildMgr.GetGuessTimes)(msg.guessCapNum)
  ;
  (GuildMgr.GetGuessIsCovered)(msg.guessCapsState)
  ;
  (GuildMgr.GetGuessOpenList)(msg.openCaps)
  ;
  (GuildMgr.GetGuessRoundTimes)(msg.num)
  if msg.operType == GuessCupOperateType.Once then
    (MessageMgr.OpenItemBuyTipsWindowByGoodsObj)(((msg.reward)[1]).reward)
    ;
    (GuildMgr.UpdateRoundReward)((msg.reward)[1])
    UIMgr:SendWindowMessage((WinResConfig.GuildGuessWindow).name, 2, {msg.capPos, (((msg.reward)[1]).reward)[1]})
    UIMgr:SendWindowMessage((WinResConfig.GuildGuessWindow).name, 1, true)
  else
    if msg.operType == GuessCupOperateType.All then
      UIMgr:CloseWindow((WinResConfig.GuildGuessOneKeyWindow).name)
      OpenWindow((WinResConfig.GuildGuessResultWindow).name, UILayer.HUD, msg.reward)
      ;
      (GuildMgr.UpdateRoundReward)((msg.reward)[#msg.reward])
      UIMgr:SendWindowMessage((WinResConfig.GuildGuessWindow).name, 1)
    end
  end
  local maxRound = (GuildMgr.GetGuessMaxTime)()
  local times = (GuildMgr.GetGuessRoundTimes)()
  if maxRound <= times and msg.guessCapNum > 0 then
    (RedDotMgr.EliminateRedDot)((WinResConfig.GuildMainWindow).name, RedDotComID.Guild_Guess)
  end
end

-- DECOMPILER ERROR at PC185: Confused about usage of register: R1 in 'UnsetPending'

GuildService.ReqGuildGameReset = function(...)
  -- function num : 0_60 , upvalues : _ENV
  local m = {}
  m.type = GuessCupType.Guild
  ;
  (Net.Send)((Proto.MsgName).ReqGuildGameReset, m, (Proto.MsgName).ResGuildGameReset)
end

-- DECOMPILER ERROR at PC188: Confused about usage of register: R1 in 'UnsetPending'

GuildService.RecvGuildGameReset = function(msg, ...)
  -- function num : 0_61 , upvalues : _ENV
  if msg.type ~= GuessCupType.Guild then
    return 
  end
  ;
  (GuildMgr.GetGuessTimes)(msg.guessCapNum)
  ;
  (GuildMgr.GetGuessIsCovered)(msg.guessCapsState)
  ;
  (GuildMgr.GetGuessGoods)(msg.goods)
  ;
  (GuildMgr.GetGuessOpenList)({})
  ;
  (GuildService.ReqBeginGuildGame)()
  UIMgr:SendWindowMessage((WinResConfig.GuildGuessWindow).name, 3)
end

-- DECOMPILER ERROR at PC191: Confused about usage of register: R1 in 'UnsetPending'

GuildService.ReqGuildGameRecord = function(...)
  -- function num : 0_62 , upvalues : _ENV
  local m = {}
  m.type = GuessCupType.Guild
  ;
  (Net.Send)((Proto.MsgName).ReqGuildGameRecord, m, (Proto.MsgName).ResGuildGameRecord)
end

-- DECOMPILER ERROR at PC194: Confused about usage of register: R1 in 'UnsetPending'

GuildService.RecvGuildGameRecord = function(msg, ...)
  -- function num : 0_63 , upvalues : _ENV
  if msg.type ~= GuessCupType.Guild then
    return 
  end
  OpenWindow((WinResConfig.GuildGuessRecordWindow).name, UILayer.HUD, msg.record, msg.specialReward)
end

-- DECOMPILER ERROR at PC197: Confused about usage of register: R1 in 'UnsetPending'

GuildService.ReqGuildSummary = function(...)
  -- function num : 0_64 , upvalues : _ENV
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqGuildSummary, m, (Proto.MsgName).ResGuildSummary)
end

-- DECOMPILER ERROR at PC200: Confused about usage of register: R1 in 'UnsetPending'

GuildService.RecvGuildSummary = function(msg, ...)
  -- function num : 0_65 , upvalues : _ENV
  UIMgr:SendWindowMessage((WinResConfig.ActorInfoWindow).name, (WindowMsgEnum.Guild).E_MSG_REFRESH_GUILD_NAME, msg.name)
end

-- DECOMPILER ERROR at PC203: Confused about usage of register: R1 in 'UnsetPending'

GuildService.ResPopUpLevelUp = function(msg, ...)
  -- function num : 0_66 , upvalues : _ENV
  loge("工会升级")
  ;
  (SimpleTimer.setTimeout)(0.5, function(...)
    -- function num : 0_66_0 , upvalues : msg, _ENV
    if msg.level > 1 then
      OpenWindow((WinResConfig.GuildLevelUpWindow).name, UILayer.HUD, msg.level)
    end
  end
)
end

;
(GuildService.Init)()

