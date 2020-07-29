-- params : ...
-- function num : 0 , upvalues : _ENV
HandBookService = {}
-- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

HandBookService.Init = function(...)
  -- function num : 0_0 , upvalues : _ENV
  (Net.AddListener)((Proto.MsgName).ResHandbookInit, HandBookService.ResHandBookInit)
  ;
  (Net.AddListener)((Proto.MsgName).ResSwitchCard, HandBookService.ResSwitchCard)
  ;
  (Net.AddListener)((Proto.MsgName).ResAdventureStoryChapter, HandBookService.ResAdventureStoryChapter)
  ;
  (Net.AddListener)((Proto.MsgName).ResAdventureStoryStage, HandBookService.ResAdventureStoryStage)
  ;
  (Net.AddListener)((Proto.MsgName).ResCGCopySummary, HandBookService.ResCGCopySummary)
  ;
  (Net.AddListener)((Proto.MsgName).ResCGCopyInfo, HandBookService.ResCGCopyInfo)
  ;
  (Net.AddListener)((Proto.MsgName).ResCGCopyStage, HandBookService.ResCGCopyStage)
  ;
  (Net.AddListener)((Proto.MsgName).ResInCGCopyStage, HandBookService.ResInCGCopyStage)
  ;
  (Net.AddListener)((Proto.MsgName).ResSettleCGCopyStage, HandBookService.ResSettleCGCopyStage)
  ;
  (Net.AddListener)((Proto.MsgName).ResStoryCopyGetCG, HandBookService.ResCGCopyGetCG)
  ;
  (Net.AddListener)((Proto.MsgName).ResCGList, HandBookService.ResCGList)
  ;
  (Net.AddListener)((Proto.MsgName).ResHandLetterList, HandBookService.ResHandLetterList)
  ;
  (Net.AddListener)((Proto.MsgName).ResSetHandbookCover, HandBookService.ResSetHandbookCover)
  ;
  (Net.AddListener)((Proto.MsgName).ResIntimacyInfo, HandBookService.ResIntimacyInfo)
  ;
  (Net.AddListener)((Proto.MsgName).ResActivateFetter, HandBookService.OnResActivateFetter)
end

-- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

HandBookService.OnReqHandBookInit = function(...)
  -- function num : 0_1 , upvalues : _ENV
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqHandbookInit, m, (Proto.MsgName).ResHandbookInit)
end

-- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

HandBookService.ResHandBookInit = function(msg, ...)
  -- function num : 0_2 , upvalues : _ENV
  (HandBookMgr.SetHandBookMain)(msg)
end

-- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

HandBookService.OnReqSwitchCard = function(currentID, direction, ...)
  -- function num : 0_3 , upvalues : _ENV
  local m = {}
  m.cardId = currentID
  m.direction = direction
  ;
  (Net.Send)((Proto.MsgName).ReqSwitchCard, m, (Proto.MsgName).ResSwitchCard)
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

HandBookService.ResSwitchCard = function(msg, ...)
  -- function num : 0_4 , upvalues : _ENV
  (HandBookMgr.SetHandBookMain)(msg)
end

local JumpToType = 0
local JumpToRecord = 0
-- DECOMPILER ERROR at PC21: Confused about usage of register: R2 in 'UnsetPending'

HandBookService.OnReqAdventureStoryChapter = function(type, storyType, record, ...)
  -- function num : 0_5 , upvalues : JumpToType, JumpToRecord, _ENV
  local m = {}
  m.battleType = type
  JumpToType = storyType
  JumpToRecord = record
  ;
  (Net.Send)((Proto.MsgName).ReqAdventureStoryChapter, m, (Proto.MsgName).ResAdventureStoryChapter)
end

-- DECOMPILER ERROR at PC24: Confused about usage of register: R2 in 'UnsetPending'

HandBookService.ResAdventureStoryChapter = function(msg, ...)
  -- function num : 0_6 , upvalues : _ENV, JumpToType, JumpToRecord
  local type = nil
  if msg.battleType == (ProtoEnum.E_BATTLE_TYPE).STORY then
    type = (HandBookMgr.AdventureStoryType).MainStory
    ;
    (HandBookMgr.HandleAdventureStoryChapter)(msg.chapterId, type)
  else
    if msg.battleType == (ProtoEnum.E_BATTLE_TYPE).HERO then
      type = (HandBookMgr.AdventureStoryType).HeroStory
    else
      if msg.battleType == (ProtoEnum.E_BATTLE_TYPE).ACTIVITY then
        type = (HandBookMgr.AdventureStoryType).Activity
        ;
        (HandBookMgr.HandleActivityStoryChapter)(msg.chapterId, type, JumpToType, JumpToRecord)
        JumpToType = 0
        JumpToRecord = 0
      else
        loge("返回章节类型错误")
        return 
      end
    end
  end
end

-- DECOMPILER ERROR at PC27: Confused about usage of register: R2 in 'UnsetPending'

HandBookService.OnReqAdventureStoryStage = function(chapterId, ...)
  -- function num : 0_7 , upvalues : _ENV
  local m = {}
  m.chapterId = chapterId
  ;
  (Net.Send)((Proto.MsgName).ReqAdventureStoryStage, m, (Proto.MsgName).ResAdventureStoryStage)
end

-- DECOMPILER ERROR at PC30: Confused about usage of register: R2 in 'UnsetPending'

HandBookService.ResAdventureStoryStage = function(msg, ...)
  -- function num : 0_8 , upvalues : _ENV
  (HandBookMgr.AdventureStoryStage)(msg.stageId)
  UIMgr:SendWindowMessage((WinResConfig.HandBookStoryPlotWindow).name, 1)
end

local mOpenType = nil
-- DECOMPILER ERROR at PC34: Confused about usage of register: R3 in 'UnsetPending'

HandBookService.OnReqCGCopySummary = function(type, isShow, ...)
  -- function num : 0_9 , upvalues : mOpenType, _ENV
  local m = {}
  m.type = type
  if not isShow then
    mOpenType = type
  else
    mOpenType = nil
  end
  ;
  (Net.Send)((Proto.MsgName).ReqCGCopySummary, m, (Proto.MsgName).ResCGCopySummary)
end

-- DECOMPILER ERROR at PC37: Confused about usage of register: R3 in 'UnsetPending'

HandBookService.ResCGCopySummary = function(msg, ...)
  -- function num : 0_10 , upvalues : _ENV, mOpenType
  (HandBookMgr.CGCopySummaryData)(msg.cgCopyList)
  if mOpenType then
    if UIMgr:IsWindowOpen((WinResConfig.HandBookCardPlotWindow).name) then
      UIMgr:SendWindowMessage((WinResConfig.HandBookCardPlotWindow).name, 1)
    else
      OpenWindow((WinResConfig.HandBookCardPlotWindow).name, UILayer.HUD, mOpenType)
    end
  end
end

-- DECOMPILER ERROR at PC40: Confused about usage of register: R3 in 'UnsetPending'

HandBookService.OnReqCGCopyInfo = function(cardID, ...)
  -- function num : 0_11 , upvalues : _ENV
  local m = {}
  m.cardId = cardID
  ;
  (Net.Send)((Proto.MsgName).ReqCGCopyInfo, m, (Proto.MsgName).ResCGCopyInfo)
end

-- DECOMPILER ERROR at PC43: Confused about usage of register: R3 in 'UnsetPending'

HandBookService.ResCGCopyInfo = function(msg, ...)
  -- function num : 0_12 , upvalues : _ENV
  (HandBookMgr.SetCardPlotBattleData)(msg)
  ;
  (RedDotMgr.EliminateRedDot)((WinResConfig.HandBookCardPlotWindow).name, RedDotComID.HandBook_Story_List, msg.cardId)
  if UIMgr:IsWindowOpen((WinResConfig.HandBookCardPlotBattleWindow).name) then
    UIMgr:SendWindowMessage((WinResConfig.HandBookCardPlotBattleWindow).name, 1)
  else
    OpenWindow((WinResConfig.HandBookCardPlotBattleWindow).name, UILayer.HUD, msg.cardId)
  end
end

-- DECOMPILER ERROR at PC46: Confused about usage of register: R3 in 'UnsetPending'

HandBookService.OnReqCGCopyStage = function(stageId, ...)
  -- function num : 0_13 , upvalues : _ENV
  local m = {}
  m.stageId = stageId
  ;
  (Net.Send)((Proto.MsgName).ReqCGCopyStage, m, (Proto.MsgName).ResCGCopyStage)
end

-- DECOMPILER ERROR at PC49: Confused about usage of register: R3 in 'UnsetPending'

HandBookService.ResCGCopyStage = function(msg, ...)
  -- function num : 0_14 , upvalues : _ENV
  if UIMgr:IsWindowOpen((WinResConfig.RewardDisplayWindow).name) then
    UIMgr:CloseWindow((WinResConfig.RewardDisplayWindow).name)
  end
  local StageData = ((TableData.gTable).BaseHandbookStageData)[(msg.stageInfo).stageId]
  if StageData.cg_reward and tonumber(StageData.cg_reward) > 0 then
    (Util.ShowGuideTips)(GuideTipsCheckPoint.AcquireStoryRoleCG, (((TableData.gTable).BaseCardData)[StageData.card_id]).name)
    OpenWindow((WinResConfig.HandBookCGShowWindow).name, UILayer.HUD, tonumber(StageData.cg_reward), true, function(...)
    -- function num : 0_14_0 , upvalues : _ENV, StageData
    (HandBookService.OnReqCGCopyInfo)(StageData.card_id)
    ;
    (MessageMgr.OpenRewardByStr)(StageData.first_reward)
  end
)
  else
    ;
    (HandBookService.OnReqCGCopyInfo)(StageData.card_id)
    ;
    (MessageMgr.OpenRewardByStr)(StageData.first_reward)
  end
  ;
  (CardData.UpdateCardStageID)(StageData.card_id, (msg.stageInfo).stageId)
end

-- DECOMPILER ERROR at PC52: Confused about usage of register: R3 in 'UnsetPending'

HandBookService.OnReqInCGCopyStage = function(stageId, cardList, ...)
  -- function num : 0_15 , upvalues : _ENV
  local m = {}
  m.stageId = stageId
  m.cardList = (Util.CovertLoaclFormationToRemote)(cardList)
  ;
  (Net.Send)((Proto.MsgName).ReqInCGCopyStage, m, (Proto.MsgName).InitBattleData)
end

-- DECOMPILER ERROR at PC55: Confused about usage of register: R3 in 'UnsetPending'

HandBookService.ResInCGCopyStage = function(msg, ...)
  -- function num : 0_16
end

-- DECOMPILER ERROR at PC58: Confused about usage of register: R3 in 'UnsetPending'

HandBookService.OnReqSettleCGCopyStage = function(battleCompleteData, ...)
  -- function num : 0_17 , upvalues : _ENV
  local m = {}
  m.battleCompleteData = battleCompleteData
  ;
  (Net.Send)((Proto.MsgName).ReqSettleCGCopyStage, m, (Proto.MsgName).ResSettleCGCopyStage, function(...)
    -- function num : 0_17_0 , upvalues : _ENV, battleCompleteData
    (HandBookService.OnReqSettleCGCopyStage)(battleCompleteData)
  end
)
end

-- DECOMPILER ERROR at PC61: Confused about usage of register: R3 in 'UnsetPending'

HandBookService.ResSettleCGCopyStage = function(msg, ...)
  -- function num : 0_18 , upvalues : _ENV
  if msg.success then
    local m = {}
    do
      m.BattleType = (ProtoEnum.E_BATTLE_TYPE).CG
      m.FirstGoods = (Util.GoodsObjectToItemDataModel)(msg.firstGoods)
      local btn3 = {}
      btn3.btnTxt = (PUtil.get)(20000025)
      local StageData = ((TableData.gTable).BaseHandbookStageData)[(msg.stageInfo).stageId]
      btn3.fun = function(...)
    -- function num : 0_18_0 , upvalues : _ENV, StageData
    if UIMgr:IsWindowOpen((WinResConfig.BattleUIWindow).name) == true then
      ld("Battle", function(...)
      -- function num : 0_18_0_0 , upvalues : _ENV
      (BattleMgr.CloseBattle)()
    end
)
      UIMgr:SetOnShownComplete((WinResConfig.HandBookCardPlotBattleWindow).name, function(...)
      -- function num : 0_18_0_1 , upvalues : _ENV, StageData
      (HandBookService.OnReqCGCopyInfo)(StageData.card_id)
    end
)
    end
  end

      m.btn2 = btn3
      ;
      (CommonWinMgr.OpenBattleSettleConvergeWindow)(m)
      ;
      (CardData.UpdateCardStageID)(StageData.card_id, (msg.stageInfo).stageId)
    end
  else
    do
      local m = {}
      m.BattleType = (ProtoEnum.E_BATTLE_TYPE).CG
      ;
      (CommonWinMgr.OpenBattleFailConvergeWindow)(m)
    end
  end
end

-- DECOMPILER ERROR at PC64: Confused about usage of register: R3 in 'UnsetPending'

HandBookService.OnReqCGCopyGetCG = function(...)
  -- function num : 0_19 , upvalues : _ENV
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqStoryCopyGetCG, m, (Proto.MsgName).ResStoryCopyGetCG)
end

-- DECOMPILER ERROR at PC67: Confused about usage of register: R3 in 'UnsetPending'

HandBookService.ResCGCopyGetCG = function(msg, ...)
  -- function num : 0_20
end

local isPlot = false
-- DECOMPILER ERROR at PC71: Confused about usage of register: R4 in 'UnsetPending'

HandBookService.OnReqCGList = function(plot, ...)
  -- function num : 0_21 , upvalues : isPlot, _ENV
  isPlot = plot
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqCGList, m, (Proto.MsgName).ResCGList)
end

-- DECOMPILER ERROR at PC74: Confused about usage of register: R4 in 'UnsetPending'

HandBookService.ResCGList = function(msg, ...)
  -- function num : 0_22 , upvalues : isPlot, _ENV
  if isPlot then
    OpenWindow((WinResConfig.CGPreviewWindow).name, UILayer.HUD, 1, msg.CGList)
  else
    ;
    (HandBookMgr.SetAlbumData)(msg.CGList)
  end
end

-- DECOMPILER ERROR at PC77: Confused about usage of register: R4 in 'UnsetPending'

HandBookService.OnReqHandLetterList = function(...)
  -- function num : 0_23 , upvalues : _ENV
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqHandLetterList, m, (Proto.MsgName).ResHandLetterList)
end

-- DECOMPILER ERROR at PC80: Confused about usage of register: R4 in 'UnsetPending'

HandBookService.ResHandLetterList = function(msg, ...)
  -- function num : 0_24 , upvalues : _ENV
  (HandBookMgr.SetLetterData)(msg.letterList)
end

-- DECOMPILER ERROR at PC83: Confused about usage of register: R4 in 'UnsetPending'

HandBookService.OnReqOpenCG = function(id, ...)
  -- function num : 0_25 , upvalues : _ENV
  local m = {}
  m.CGId = id
  ;
  (Net.Send)((Proto.MsgName).ReqOpenCG, m)
end

-- DECOMPILER ERROR at PC86: Confused about usage of register: R4 in 'UnsetPending'

HandBookService.OnReqOpenLetter = function(id, ...)
  -- function num : 0_26 , upvalues : _ENV
  local m = {}
  m.letterId = id
  ;
  (Net.Send)((Proto.MsgName).ReqOpenLetter, m)
end

-- DECOMPILER ERROR at PC89: Confused about usage of register: R4 in 'UnsetPending'

HandBookService.OnReqSetHandbookCover = function(cardID, ...)
  -- function num : 0_27 , upvalues : _ENV
  local m = {}
  m.cardId = cardID
  ;
  (Net.Send)((Proto.MsgName).ReqSetHandbookCover, m)
end

-- DECOMPILER ERROR at PC92: Confused about usage of register: R4 in 'UnsetPending'

HandBookService.ResSetHandbookCover = function(msg, ...)
  -- function num : 0_28 , upvalues : _ENV
  local card = (CardData.GetCardData)(msg.cardId)
  ;
  (MessageMgr.SendCenterTips)(card.name .. "已成为手账管理员")
end

-- DECOMPILER ERROR at PC95: Confused about usage of register: R4 in 'UnsetPending'

HandBookService.OnReqIntimacyInfo = function(cardID, isInitList, ...)
  -- function num : 0_29 , upvalues : _ENV
  if (FunctionControlMgr.GetFunctionState)(ControlID.HandBook_Intimacy, true) == false then
    return 
  end
  local m = {}
  m.cardId = cardID
  if isInitList then
    (HandBookService.OnReqCGCopySummary)((HandBookMgr.CardPlotWinType).Intimacy, true)
  end
  ;
  (Net.Send)((Proto.MsgName).ReqIntimacyInfo, m, (Proto.MsgName).ResIntimacyInfo)
end

-- DECOMPILER ERROR at PC98: Confused about usage of register: R4 in 'UnsetPending'

HandBookService.ResIntimacyInfo = function(msg, ...)
  -- function num : 0_30 , upvalues : _ENV
  (HandBookMgr.IntimacyCardData)(msg)
  if msg.isSync then
    local intimacyLv = ((CardData.GetCardData)(msg.cardId)).intimacyLv
    if intimacyLv ~= msg.lv then
      (CardData.SaveCardIntimacyLevel)(msg.cardId, msg.lv)
    end
    UIMgr:SendWindowMessage((WinResConfig.HandBookIntimacyWindow).name, (WindowMsgEnum.HandBookIntimacyWindow).SHOW_CARD_LEVEL_INFORMATION)
  else
    do
      if UIMgr:IsWindowOpen((WinResConfig.HandBookIntimacyWindow).name) then
        UIMgr:SendWindowMessage((WinResConfig.HandBookIntimacyWindow).name, (WindowMsgEnum.HandBookIntimacyWindow).SHOW_CARD_INFORMATION)
      else
        OpenWindow((WinResConfig.HandBookIntimacyWindow).name, UILayer.HUD, msg.cardId)
      end
    end
  end
end

-- DECOMPILER ERROR at PC101: Confused about usage of register: R4 in 'UnsetPending'

HandBookService.OnReqUseIntimacyItem = function(itemID, cardID, count, ...)
  -- function num : 0_31 , upvalues : _ENV
  if not count then
    count = 1
  end
  local m = {}
  m.propIndex = (ActorData.GetItemObjectIndex)(itemID)
  m.count = count
  m.cardId = cardID
  ;
  (Net.Send)((Proto.MsgName).ReqUseProp, m, (Proto.MsgName).ResUseProp)
end

-- DECOMPILER ERROR at PC104: Confused about usage of register: R4 in 'UnsetPending'

HandBookService.ReqActivateFetter = function(id, ...)
  -- function num : 0_32 , upvalues : _ENV
  print("请求激活羁绊  ", id)
  local m = {}
  m.id = id
  ;
  (Net.Send)((Proto.MsgName).ReqActivateFetter, m, (Proto.MsgName).ResActivateFetter)
end

-- DECOMPILER ERROR at PC107: Confused about usage of register: R4 in 'UnsetPending'

HandBookService.OnResActivateFetter = function(msg, ...)
  -- function num : 0_33 , upvalues : _ENV
  print("激活羁绊返回  ", msg.id)
  ;
  (HandBookData.SetFetterDataByFetterTreeId)(msg.id)
  ;
  (CardData.SaveFetter)()
  ;
  (CommonWinMgr.OpenCommonFcUp)()
  UIMgr:SendWindowMessage((WinResConfig.HandBookRelationWindow).name, (WindowMsgEnum.HandBookIntimacyWindow).RELATION_ACTIVETION)
end

;
(HandBookService.Init)()

