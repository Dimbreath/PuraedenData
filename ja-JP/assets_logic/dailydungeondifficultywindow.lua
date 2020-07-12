-- params : ...
-- function num : 0 , upvalues : _ENV
require("DailyDungeon_BattleDifficultyByName")
local DailyDungeonDifficultyWindow = {}
local uis, contentPane, curTrialType, curSelectDifficultIndex, curSelectStageId = nil, nil, nil, nil, nil
DailyDungeonDifficultyWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, uis, curTrialType, curSelectDifficultIndex, DailyDungeonDifficultyWindow
  bridgeObj:SetView((WinResConfig.DailyDungeonDifficultyWindow).package, (WinResConfig.DailyDungeonDifficultyWindow).comName)
  contentPane = bridgeObj.contentPane
  contentPane:Center()
  uis = GetDailyDungeon_BattleDifficultyUis(contentPane)
  curTrialType = DailyDungeonMgr.curSelectTrialType
  curSelectDifficultIndex = nil
  ;
  (DailyDungeonDifficultyWindow.InitAssetStrip)()
  ;
  (DailyDungeonDifficultyWindow.InitBtnTextAndFunc)()
  ;
  (DailyDungeonDifficultyWindow.UpdatePanelInfo)()
  ;
  (DailyDungeonDifficultyWindow.RegisterGuide)()
  ;
  (LuaSound.PlaySound)(LuaSound.COMMON_SLIDE_2, SoundBank.OTHER)
end

DailyDungeonDifficultyWindow.RegisterGuide = function(...)
  -- function num : 0_1 , upvalues : _ENV, uis
  local RegisterGuideAndControl = GuideData.RegisterGuideAndControl
  local ControlID = ControlID
  local winName = (WinResConfig.DailyDungeonDifficultyWindow).name
  RegisterGuideAndControl(ControlID.Daily_Sweep, uis.SweepBtn, winName)
  RegisterGuideAndControl(ControlID.Daily_GoldOne, uis.LevelList, winName)
  RegisterGuideAndControl(ControlID.Daily_MedicalOne, uis.LevelList, winName)
end

DailyDungeonDifficultyWindow.InitBtnTextAndFunc = function(...)
  -- function num : 0_2 , upvalues : _ENV, curTrialType, uis, DailyDungeonDifficultyWindow
  local config = (DailyDungeonData.GetTrialConfigByType)(curTrialType)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.BuffWordTxt).text = config.tips
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.SweepBtn).text = (PUtil.get)(40002004)
  local keyStr = "trial" .. curTrialType .. "skipFormation"
  local skipFormationBtn = uis.SkipFormationBtn
  ;
  (skipFormationBtn.onClick):Set(function(...)
    -- function num : 0_2_0 , upvalues : _ENV, skipFormationBtn, keyStr
    if (DailyDungeonData.IsCardInfoEmptyByType)() == true then
      (MessageMgr.SendCenterTips)((PUtil.get)(40002006))
      skipFormationBtn.selected = false
      return 
    end
    ;
    (Util.SetPlayerSetting)(keyStr, tostring(skipFormationBtn.selected))
  end
)
  ;
  ((uis.SweepBtn).onClick):Set(DailyDungeonDifficultyWindow.OnClickSweepBtn)
end

DailyDungeonDifficultyWindow.UpdatePanelInfo = function(...)
  -- function num : 0_3 , upvalues : _ENV, curTrialType, DailyDungeonDifficultyWindow
  local trialDataList = (DailyDungeonData.GetTrialDataListByType)(curTrialType)
  ;
  (DailyDungeonDifficultyWindow.UpdateLevelList)(trialDataList)
  ;
  (DailyDungeonDifficultyWindow.UpdateChallengeTime)()
  ;
  (DailyDungeonDifficultyWindow.UpdateSkipButton)()
end

DailyDungeonDifficultyWindow.UpdateLevelList = function(trialDataList, ...)
  -- function num : 0_4 , upvalues : _ENV, curTrialType, uis, curSelectStageId, DailyDungeonDifficultyWindow, curSelectDifficultIndex
  if not trialDataList then
    trialDataList = (DailyDungeonData.GetTrialDataListByType)(curTrialType)
  end
  local levelList = uis.LevelList
  local defaultTrial = nil
  ;
  (LuaSound.PlaySound)(LuaSound.COMMON_LIST_ANIM, SoundBank.OTHER)
  for index,oneTrial in ipairs(trialDataList) do
    do
      do
        local hand = levelList:AddItemFromPool(UIMgr:GetItemUrl("DailyDungeon", "Dungeon_" .. curTrialType .. "_Btn"))
        local isOpen = oneTrial.isOpen
        ChangeUIController(hand, "c2", index - 1)
        local id = oneTrial.id
        local txt = hand:GetChild("NumberTxt")
        if txt then
          txt.text = index
        end
        local dungeon = hand:GetChild("Dungeon")
        if dungeon then
          dungeon.alpha = 0
        end
        local ProgressTxt = hand:GetChild("ProgressTxt")
        if ProgressTxt then
          local schedule = (DailyDungeonData.GetTrialStageSchedule)(id)
          local num = (math.floor)((schedule or 0) / 100)
          if num > 0 then
            ProgressTxt.text = num .. "%"
          else
            ProgressTxt.text = ""
          end
        end
        do
          local stageConfig = ((TableData.gTable).BaseTrialStageData)[id]
          PlayUITrans(hand, "in", function(...)
    -- function num : 0_4_0 , upvalues : _ENV, index, trialDataList, stageConfig, id
    if UIMgr:IsWindowOpen((WinResConfig.DailyDungeonDifficultyWindow).name) and index == #trialDataList then
      local battleType = (BattleData.GetBattleTypeByPlayType)(stageConfig.type)
      ;
      (BattleBackground.PreLoad)(id, battleType)
      local enemyList = (BattleData.GetMonsterList)(1, id, battleType)
      for _,monsterId in pairs(enemyList) do
        (BattleResource.PreLoadMonster)(monsterId)
      end
      local myselfList = (DailyDungeonMgr.InitSelfFormation)()
      for _,cardId in pairs(myselfList) do
        (BattleResource.PreLoadCard)(cardId)
      end
    end
  end
, index * 0.05)
          if isOpen == true and (Util.CheckCondition)(stageConfig.open_condition, true) then
            ChangeUIController(hand, "c1", 0)
            hand.touchable = true
            ;
            (hand.onClick):Set(function(...)
    -- function num : 0_4_1 , upvalues : curSelectStageId, oneTrial, _ENV, DailyDungeonDifficultyWindow
    curSelectStageId = oneTrial.id
    -- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

    DailyDungeonMgr.curSelectStageId = curSelectStageId
    ;
    (DailyDungeonDifficultyWindow.OnClickBattleBtn)()
  end
)
            curSelectDifficultIndex = (math.max)(index, curSelectDifficultIndex or 1)
            defaultTrial = oneTrial
          else
            ChangeUIController(hand, "c1", 1)
            hand.changeStateOnClick = false
            ;
            (hand.onClick):Set(function(...)
    -- function num : 0_4_2 , upvalues : _ENV, oneTrial
    (Util.CheckCondition)(oneTrial.open_condition)
  end
)
          end
        end
        -- DECOMPILER ERROR at PC125: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  if curSelectDifficultIndex and defaultTrial then
    levelList:ScrollToView(curSelectDifficultIndex - 1)
  end
end

DailyDungeonDifficultyWindow.UpdateChallengeTime = function(...)
  -- function num : 0_5 , upvalues : _ENV, curTrialType, uis
  local trialData = (DailyDungeonData.GetTrialDataByType)(curTrialType)
  local basePlayConfig = (TableData.GetBasePlayConfigByType)(curTrialType)
  local battleNumberTxt = uis.BattleNumberTxt
  if trialData and basePlayConfig and battleNumberTxt then
    local remainTime = (trialData.trial).num
    local totalTime = basePlayConfig.free_times
    if remainTime <= 0 then
      battleNumberTxt.color = ((CS.UnityEngine).Color).red
    end
    battleNumberTxt.text = remainTime .. "/" .. totalTime
  end
end

DailyDungeonDifficultyWindow.UpdateSkipButton = function(...)
  -- function num : 0_6 , upvalues : uis, _ENV, curTrialType
  local skipFormationTxt = uis.SkipFormationTxt
  if skipFormationTxt then
    skipFormationTxt.text = (PUtil.get)(60000363)
  end
  local skipFormationBtn = uis.SkipFormationBtn
  local keyStr = "trial" .. curTrialType .. "skipFormation"
  local saveSkip = (Util.GetPlayerSetting)(keyStr)
  if saveSkip == tostring(true) and (DailyDungeonData.IsCardInfoEmptyByType)() == false then
    skipFormationBtn.selected = true
  end
end

DailyDungeonDifficultyWindow.OnClickSweepBtn = function(...)
  -- function num : 0_7 , upvalues : _ENV
  if (DailyDungeonData.IsCardInfoEmptyByType)() == true then
    (MessageMgr.SendCenterTips)((PUtil.get)(40002006))
    return 
  end
  OpenWindow((WinResConfig.DailyDungeonSweepWindow).name, UILayer.HUD)
end

DailyDungeonDifficultyWindow.OnClickBattleBtn = function(...)
  -- function num : 0_8 , upvalues : DailyDungeonDifficultyWindow, _ENV, curSelectStageId, curTrialType
  if (DailyDungeonDifficultyWindow.CheckChallengeTime)() ~= true then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000025))
    return 
  end
  local stageId = curSelectStageId
  local keyStr = "trial" .. curTrialType .. "skipFormation"
  local saveSkip = (Util.GetPlayerSetting)(keyStr)
  if saveSkip == tostring(true) and (DailyDungeonData.IsCardInfoEmptyByType)() == false then
    local cardInfo = (DailyDungeonData.GetChallengeCardInfo)(curTrialType)
    do
      (DailyDungeonService.ReqInTrial)(cardInfo, stageId, false)
    end
  else
    do
      local enemyList, stageData = (DailyDungeonMgr.InitEnemyFormation)(stageId)
      local btnData = {}
      btnData.btnTxt = (PUtil.get)(20000021)
      btnData.fun = DailyDungeonMgr.StartChallenge
      local formationData = {}
      formationData.enemyList = enemyList
      formationData.myselfList = (DailyDungeonMgr.InitSelfFormation)()
      formationData.BtnData = btnData
      formationData.formationType = FormationType.Basic
      formationData.backFun = function(cards, ...)
    -- function num : 0_8_0 , upvalues : _ENV, curTrialType
    (DailyDungeonMgr.ReqSaveFormation)(cards, (BattleData.GetEmbattleType)(curTrialType))
  end

      formationData.closeFun = function(cards, ...)
    -- function num : 0_8_1 , upvalues : _ENV, curTrialType
    (DailyDungeonMgr.ReqSaveFormation)(cards, (BattleData.GetEmbattleType)(curTrialType))
  end

      formationData.battleType = (BattleData.GetBattleTypeByPlayType)(stageData.type)
      formationData.stageId = stageId
      ;
      (Util.SetDelayCall)(function(...)
    -- function num : 0_8_2 , upvalues : _ENV, formationData
    (MessageMgr.OpenFormationWindow)(formationData)
  end
)
    end
  end
end

DailyDungeonDifficultyWindow.CheckChallengeTime = function(...)
  -- function num : 0_9 , upvalues : _ENV, curTrialType
  local remainTime = (DailyDungeonData.GetRemainChallengeTime)(curTrialType)
  if remainTime > 0 then
    return true
  end
end

DailyDungeonDifficultyWindow.OnShown = function(...)
  -- function num : 0_10
end

DailyDungeonDifficultyWindow.OnHide = function(...)
  -- function num : 0_11
end

DailyDungeonDifficultyWindow.OnClose = function(...)
  -- function num : 0_12 , upvalues : uis, _ENV, contentPane
  local levelList = uis.LevelList
  if levelList then
    (levelList.itemPool):Clear()
  end
  ;
  (GuideData.AbolishControlRefer)((WinResConfig.DailyDungeonDifficultyWindow).name)
  uis = nil
  contentPane = nil
  ;
  (CommonWinMgr.RemoveAssets)((WinResConfig.DailyDungeonDifficultyWindow).name)
end

DailyDungeonDifficultyWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_13 , upvalues : _ENV, DailyDungeonDifficultyWindow
  if msgId == (WindowMsgEnum.DailyDungeonDifficultyWindow).E_MSG_UPDATE_CHALLENGE then
    (DailyDungeonDifficultyWindow.UpdateChallengeTime)()
  end
end

DailyDungeonDifficultyWindow.GetAssetActivityId = function(...)
  -- function num : 0_14 , upvalues : curTrialType, _ENV
  if curTrialType == PlayType.CoinDungeon then
    return (Util.GetActivityIds)(76000010)
  else
    if curTrialType == PlayType.RoleExpDungeon then
      return (Util.GetActivityIds)(76000011)
    else
      if curTrialType == PlayType.EquipmentExpDungeon then
        return (Util.GetActivityIds)(76000012)
      end
    end
  end
end

DailyDungeonDifficultyWindow.InitAssetStrip = function(...)
  -- function num : 0_15 , upvalues : _ENV, curTrialType, DailyDungeonDifficultyWindow, uis
  local m = {}
  m.windowName = (WinResConfig.DailyDungeonDifficultyWindow).name
  m.Tip = (DailyDungeonMgr.GetAssetTip)(curTrialType)
  m.activityIds = (DailyDungeonDifficultyWindow.GetAssetActivityId)()
  m.model = uis.AssetStripGrp
  m.closeToWindow = (WinResConfig.AdventureWindow).name
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.PHYSICAL}
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

return DailyDungeonDifficultyWindow

