-- params : ...
-- function num : 0 , upvalues : _ENV
AdventureService = {}
local _lasetReqOp = nil
-- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

AdventureService.Init = function(...)
  -- function num : 0_0 , upvalues : _ENV
  (Net.AddListener)((Proto.MsgName).ResAdventureInit, AdventureService.RecvAdventureInit)
  ;
  (Net.AddListener)((Proto.MsgName).ResPlayDice, AdventureService.RecvPlayDice)
  ;
  (Net.AddListener)((Proto.MsgName).ResWishReward, AdventureService.RecvWishReward)
  ;
  (Net.AddListener)((Proto.MsgName).ResAdventureBuilding, AdventureService.RecvAdventureBuilding)
  ;
  (Net.AddListener)((Proto.MsgName).ResAdventureEventReward, AdventureService.RecvAdventureEventReward)
  ;
  (Net.AddListener)((Proto.MsgName).ResInAdventureBattleEmba, AdventureService.RecvInAdventureBattleEmba)
  ;
  (Net.AddListener)((Proto.MsgName).ResInitAdventureBattleEmba, AdventureService.RecvInitAdventureBattleEmba)
  ;
  (Net.AddListener)((Proto.MsgName).ResSettleAdventureBattle, AdventureService.RecvSettleAdventureBattle)
end

-- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

AdventureService.ReqAdventureInit = function(...)
  -- function num : 0_1 , upvalues : _ENV
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqAdventureInit, m, (Proto.MsgName).ResAdventureInit)
end

-- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

AdventureService.RecvAdventureInit = function(msg, ...)
  -- function num : 0_2 , upvalues : _ENV
  (AdventureMgr.AfterRecvData)(msg)
end

-- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

AdventureService.ReqPlayDice = function(diceNum, nextNodeId, diceTime, chosedNodes, ...)
  -- function num : 0_3 , upvalues : _ENV
  local m = {}
  m.diceNum = diceNum
  m.nextNodeId = nextNodeId
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R5 in 'UnsetPending'

  if nextNodeId ~= nil then
    AdventureData.ChosedFork = nextNodeId
  end
  m.diceTime = diceTime
  m.chooseNodeIds = chosedNodes
  ;
  (Net.Send)((Proto.MsgName).ReqPlayDice, m, (Proto.MsgName).ResPlayDice)
end

-- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

AdventureService.RecvPlayDice = function(msg, ...)
  -- function num : 0_4 , upvalues : _ENV
  (AdventureMgr.RecvPlayDice)(msg)
end

-- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

AdventureService.ReqWishReward = function(type, rewardId, ...)
  -- function num : 0_5 , upvalues : _ENV
  local m = {}
  m.type = type
  m.rewardPoolId = rewardId
  ;
  (Net.Send)((Proto.MsgName).ReqWishReward, m, (Proto.MsgName).ResWishReward)
end

-- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'

AdventureService.RecvWishReward = function(msg, ...)
  -- function num : 0_6 , upvalues : _ENV
  (AdventureMgr.AfterMakeWish)(msg)
  if msg.type == AdventureWishType.Tarot then
    (RedDotMgr.EliminateRedDot)((WinResConfig.AdventureGameWindow).name, RedDotComID.BigAdventure_TarotCard)
  else
    if msg.type == AdventureWishType.Wish then
      (RedDotMgr.EliminateRedDot)((WinResConfig.AdventureGameWindow).name, RedDotComID.BigAdventure_Wish)
    end
  end
end

-- DECOMPILER ERROR at PC26: Confused about usage of register: R1 in 'UnsetPending'

AdventureService.ReqAdventureBuilding = function(type, common, adventureBuildId, operateType, ...)
  -- function num : 0_7 , upvalues : _lasetReqOp, _ENV
  local m = {}
  m.type = type
  m.common = common
  m.adventureBuildId = adventureBuildId
  m.operateType = operateType
  _lasetReqOp = type
  ;
  (Net.Send)((Proto.MsgName).ReqAdventureBuilding, m, (Proto.MsgName).ResAdventureBuilding)
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R5 in 'UnsetPending'

  if type == AdventureBuildingOperateType.Unlock then
    AdventureData.DealingEvent = common.id
  end
  if type == AdventureBuildingOperateType.RequestReward then
    (RedDotMgr.EliminateRedDot)((WinResConfig.AdventureGameWindow).name, RedDotComID.BigAdventure_InvestMgr)
  end
end

-- DECOMPILER ERROR at PC29: Confused about usage of register: R1 in 'UnsetPending'

AdventureService.RecvAdventureBuilding = function(msg, ...)
  -- function num : 0_8 , upvalues : _ENV, _lasetReqOp
  (AdventureData.InitBuildingInfo)(msg.buildings)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  AdventureData.FirstGetBuildingInfoDaily = msg.reqFirst
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  if AdventureData.OpeningBuildingUI then
    AdventureData.OpeningBuildingUI = false
    ;
    (AdventureMgr.OpenBuildingUI)()
  else
    UIMgr:SendWindowMessage((WinResConfig.BuildingUseWindow).name, (WindowMsgEnum.Adventure).E_MSG_REFRESH_BUILDING_STATUE, _lasetReqOp)
    UIMgr:SendWindowMessage((WinResConfig.BuildingShowWindow).name, (WindowMsgEnum.Adventure).E_MSG_REFRESH_BUILDING_STATUE)
    UIMgr:SendWindowMessage((WinResConfig.AdventureGameWindow).name, (WindowMsgEnum.Adventure).E_MSG_REFRESH_BUILDING_STATUE)
    ;
    (AdventureMgr.UndoneEventsChange)()
  end
end

-- DECOMPILER ERROR at PC32: Confused about usage of register: R1 in 'UnsetPending'

AdventureService.ReqAdventureEventReward = function(nodeId, type, mustWin, rewards, ...)
  -- function num : 0_9 , upvalues : _ENV
  local m = {}
  m.nodeId = nodeId
  m.type = type
  m.mustWin = mustWin
  m.rewardPoolIds = rewards
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R5 in 'UnsetPending'

  AdventureData.MiniGameRewardID = rewards
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R5 in 'UnsetPending'

  AdventureData.DealingEvent = nodeId
  ;
  (Net.Send)((Proto.MsgName).ReqAdventureEventReward, m, (Proto.MsgName).ResAdventureEventReward)
end

-- DECOMPILER ERROR at PC35: Confused about usage of register: R1 in 'UnsetPending'

AdventureService.RecvAdventureEventReward = function(msg, ...)
  -- function num : 0_10 , upvalues : _ENV
  (AdventureMgr.AfterShowResult)()
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  AdventureData.UndoneEvent = msg.undoneEvent
  ;
  (AdventureMgr.UndoneEventsChange)()
end

-- DECOMPILER ERROR at PC38: Confused about usage of register: R1 in 'UnsetPending'

AdventureService.ReqInitAdventureBattleEmba = function(nodeId, ...)
  -- function num : 0_11 , upvalues : _ENV
  local m = {}
  m.nodeId = nodeId
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  AdventureData.BattleNode = nodeId
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  AdventureData.DealingEvent = nodeId
  ;
  (Net.Send)((Proto.MsgName).ReqInitAdventureBattleEmba, m, (Proto.MsgName).ResInitAdventureBattleEmba)
end

-- DECOMPILER ERROR at PC41: Confused about usage of register: R1 in 'UnsetPending'

AdventureService.RecvInitAdventureBattleEmba = function(msg, ...)
  -- function num : 0_12 , upvalues : _ENV
  (AdventureMgr.EnterSetFormation)(msg)
end

-- DECOMPILER ERROR at PC44: Confused about usage of register: R1 in 'UnsetPending'

AdventureService.ReqInAdventureBattleEmba = function(nodeId, mustWin, cards, ...)
  -- function num : 0_13 , upvalues : _ENV
  local m = {}
  m.nodeId = nodeId
  m.mustWin = mustWin
  m.myCards = cards
  ;
  (Net.Send)((Proto.MsgName).ReqInAdventureBattleEmba, m, (Proto.MsgName).ResInAdventureBattleEmba)
end

-- DECOMPILER ERROR at PC47: Confused about usage of register: R1 in 'UnsetPending'

AdventureService.RecvInAdventureBattleEmba = function(msg, ...)
  -- function num : 0_14
end

-- DECOMPILER ERROR at PC50: Confused about usage of register: R1 in 'UnsetPending'

AdventureService.ReqSettleAdventureBattle = function(data, ...)
  -- function num : 0_15 , upvalues : _ENV
  local m = {}
  m.battleCompleteData = data
  ;
  (Net.Send)((Proto.MsgName).ReqSettleAdventureBattle, m, (Proto.MsgName).ResSettleAdventureBattle, function(...)
    -- function num : 0_15_0 , upvalues : _ENV, data
    (AdventureService.ReqSettleAdventureBattle)(data)
  end
)
end

-- DECOMPILER ERROR at PC53: Confused about usage of register: R1 in 'UnsetPending'

AdventureService.RecvSettleAdventureBattle = function(msg, ...)
  -- function num : 0_16 , upvalues : _ENV
  (AdventureMgr.AfterBattle)(msg)
  ;
  (AdventureMgr.UndoneEventsChange)()
end

-- DECOMPILER ERROR at PC56: Confused about usage of register: R1 in 'UnsetPending'

AdventureService.ReqGetChat = function(...)
  -- function num : 0_17 , upvalues : _ENV
  (ChatService.ReqGetBulletScreenChat)()
end

-- DECOMPILER ERROR at PC59: Confused about usage of register: R1 in 'UnsetPending'

AdventureService.RecvGetChat = function(msg, ...)
  -- function num : 0_18 , upvalues : _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  AdventureData.TaroChatData = (Util.Shuffle)(msg.chatData)
  OpenWindow((WinResConfig.TaroRewardChoiceWindow).name, UILayer.HUD)
end

-- DECOMPILER ERROR at PC62: Confused about usage of register: R1 in 'UnsetPending'

AdventureService.ReqSetChat = function(content, size, speed, color, ...)
  -- function num : 0_19 , upvalues : _ENV
  local bulletScreen = {}
  bulletScreen.size = size
  bulletScreen.speed = speed
  bulletScreen.color = color
  ;
  (ChatService.ReqSetBulletScreen)(content, bulletScreen)
end

-- DECOMPILER ERROR at PC65: Confused about usage of register: R1 in 'UnsetPending'

AdventureService.RecvSetChat = function(msg, ...)
  -- function num : 0_20 , upvalues : _ENV
  (AdventureData.PushScreenBulletContent)(msg.chatData, true)
  UIMgr:SendWindowMessage((WinResConfig.TaroRewardChoiceWindow).name, (WindowMsgEnum.Adventure).E_MSG_AFTER_SEND_SCREEN_BULLET)
end

;
(AdventureService.Init)()

