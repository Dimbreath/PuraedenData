-- params : ...
-- function num : 0 , upvalues : _ENV
require("PlotDungeon_PlotDetailByName")
require("PlotDungeon_PlotDetailWindowByName")
local PlotDetailWindow = {}
local contentPane, uis, StageData, aimItemId, aimItemNum = nil, nil, nil, nil, nil
local isAimSweep = false
PlotDetailWindow.OnInit = function(bridge, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, uis, aimItemId, aimItemNum, isAimSweep, StageData, PlotDetailWindow
  bridge:SetView((WinResConfig.PlotDetailWindow).package, (WinResConfig.PlotDetailWindow).comName)
  contentPane = bridge.contentPane
  uis = GetPlotDungeon_PlotDetailWindowUis(contentPane)
  uis = uis.PlotDetail
  aimItemId = (bridge.argTable)[1]
  aimItemNum = (bridge.argTable)[2]
  if aimItemNum and aimItemId then
    isAimSweep = true
  else
    isAimSweep = false
  end
  StageData = ((TableData.gTable).BaseStageData)[(PlotDungeonMgr.GetSelectDungeon)()]
  -- DECOMPILER ERROR at PC46: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.PlotImageLoader).url = (Util.GetItemUrl)(StageData.battle_banner_show)
  ;
  (PlotDetailWindow.InitButton)()
  ;
  (PlotDetailWindow.InitTxt)()
  ;
  (PlotDetailWindow.InitPropList)()
  ;
  (PlotDetailWindow.InitFunctionControl)()
  ;
  (LeanTween.delayedCall)(0.6, function(...)
    -- function num : 0_0_0 , upvalues : _ENV, StageData
    if UIMgr:IsWindowOpen((WinResConfig.PlotDetailWindow).name) == false then
      return 
    end
    local battleType = (BattleData.GetBattleTypeByPlayType)(StageData.type)
    ;
    (BattleBackground.PreLoad)(StageData.id, battleType)
    local enemyList = (BattleData.GetMonsterList)(1, StageData.id, battleType)
    for _,monsterId in pairs(enemyList) do
      (BattleResource.PreLoadMonster)(monsterId)
    end
    local myselfList = (PlotDungeonMgr.InitSelfFormation)()
    for _,cardId in pairs(myselfList) do
      (BattleResource.PreLoadCard)(cardId)
    end
  end
)
end

PlotDetailWindow.InitFunctionControl = function(...)
  -- function num : 0_1 , upvalues : _ENV, uis
  local winName = (WinResConfig.PlotDetailWindow).name
  local RegisterGuideAndControl = GuideData.RegisterGuideAndControl
  local ControlID = ControlID
  RegisterGuideAndControl(ControlID.StageDetail_ChallengeBtn, uis.ChallengeBtn, winName)
  RegisterGuideAndControl(ControlID.StageDetail_SweepOneBtn, uis.sweepawayBtn, winName)
  RegisterGuideAndControl(ControlID.StageDetail_SweepTenBtn, uis.sweepaway10Btn, winName)
end

PlotDetailWindow.InitTxt = function(...)
  -- function num : 0_2 , upvalues : uis, _ENV, StageData
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  (uis.DropDisplayTxt).text = (PUtil.get)(20000001)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.sweepawayBtn).text = (PUtil.get)(20000004)
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.sweepaway10Btn).text = (PUtil.get)(20000005)
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.ChallengeBtn).text = (PUtil.get)(20000003)
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.titilenameTxt).text = (PUtil.get)(20000336)
  local Once = (PlotDungeonMgr.IsOnlyOnceState)(StageData.id)
  local stageType = (PlotDungeonMgr.GetStageChapterType)(StageData.id)
  local nameTxt = StageData.name
  -- DECOMPILER ERROR at PC47: Confused about usage of register: R3 in 'UnsetPending'

  if Once and stageType == DungeonType.HeroDungeon then
    (uis.NumberTxt).text = StageData.name
  else
    -- DECOMPILER ERROR at PC56: Confused about usage of register: R3 in 'UnsetPending'

    if nameTxt then
      (uis.NumberTxt).text = StageData.remark .. "  " .. nameTxt
    else
      -- DECOMPILER ERROR at PC60: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (uis.NumberTxt).text = StageData.remark
    end
  end
  -- DECOMPILER ERROR at PC66: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (uis.vitalityTxt).text = (PUtil.get)(20000006)
  -- DECOMPILER ERROR at PC73: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (uis.vitalitynumberTxt).text = (ActorData.GetAssetCount)(AssetType.PHYSICAL)
  -- DECOMPILER ERROR at PC82: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (uis.vitalitynumber_01_Txt).text = (ActorData.GetAssetCount)(AssetType.PHYSICAL) - StageData.need_vit
  -- DECOMPILER ERROR at PC88: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (uis.recommendedcombatTxt).text = (PUtil.get)(20000007)
  -- DECOMPILER ERROR at PC91: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (uis.recommendedcombatmumberTxt).text = StageData.fc
  -- DECOMPILER ERROR at PC97: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (uis.mycombatTxt).text = (PUtil.get)(20000008)
  -- DECOMPILER ERROR at PC102: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (uis.mycombatnumberTxt).text = (ActorData.GetFc)()
  -- DECOMPILER ERROR at PC111: Confused about usage of register: R3 in 'UnsetPending'

  if Const.NoShowAmount <= tonumber(StageData.challenge_num) then
    (uis.challengenumberTxt).visible = false
    -- DECOMPILER ERROR at PC113: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (uis.BattleImage).visible = false
  else
    -- DECOMPILER ERROR at PC122: Confused about usage of register: R3 in 'UnsetPending'

    if Once then
      (uis.challengenumberTxt).text = (PUtil.get)(20000086)
    else
      local canChange = (PlotDungeonMgr.CanChangeTimesDungeon)()
      -- DECOMPILER ERROR at PC135: Confused about usage of register: R4 in 'UnsetPending'

      if canChange > 0 then
        (uis.challengenumberTxt).text = (PUtil.get)(20000372, canChange)
      else
        -- DECOMPILER ERROR at PC143: Confused about usage of register: R4 in 'UnsetPending'

        ;
        (uis.challengenumberTxt).text = (PUtil.get)(20000373, canChange)
      end
    end
  end
end

PlotDetailWindow.InitButton = function(...)
  -- function num : 0_3 , upvalues : _ENV, uis, StageData, isAimSweep, aimItemId, aimItemNum
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R0 in 'UnsetPending'

  if not (PlotDungeonMgr.CurrentIsPassDungeon)() or not (FunctionControlMgr.GetFunctionState)(ControlID.StageDetail_SweepOneBtn, false) then
    (uis.c1Ctr).selectedIndex = 0
  else
    -- DECOMPILER ERROR at PC31: Confused about usage of register: R0 in 'UnsetPending'

    if (PlotDungeonMgr.GetStageChapterType)(StageData.id) == DungeonType.HeroDungeon or (PlotDungeonMgr.ActivityDungeonIsHero)(StageData.id) then
      (uis.c1Ctr).selectedIndex = 2
    else
      local tenSweep = (FunctionControlMgr.GetFunctionState)(ControlID.StageDetail_SweepTenBtn, false)
      -- DECOMPILER ERROR at PC42: Confused about usage of register: R1 in 'UnsetPending'

      if tenSweep then
        (uis.c1Ctr).selectedIndex = 1
      else
        -- DECOMPILER ERROR at PC45: Confused about usage of register: R1 in 'UnsetPending'

        ;
        (uis.c1Ctr).selectedIndex = 3
      end
    end
  end
  do
    ;
    ((uis.ChallengeBtn).onClick):Add(function(...)
    -- function num : 0_3_0 , upvalues : _ENV, StageData
    if (PlotDungeonMgr.CurrentIsPassDungeon)() then
      (EquiptMgr.CheckShowEquipBagConfirm)(EquiptAcquireType.Dungeon, function(...)
      -- function num : 0_3_0_0 , upvalues : _ENV
      (PlotDungeonMgr.OnClickChallengeDungeon)()
      ;
      (Util.SetOnClickDelay)(0.5)
    end
, StageData.drop_show)
    else
      ;
      (EquiptMgr.CheckShowEquipBagConfirm)(EquiptAcquireType.Dungeon, function(...)
      -- function num : 0_3_0_1 , upvalues : _ENV
      (PlotDungeonMgr.OnClickChallengeDungeon)()
      ;
      (Util.SetOnClickDelay)(0.5)
    end
, StageData.first_reward, StageData.drop_show)
    end
  end
)
    ;
    ((uis.sweepawayBtn).onClick):Add(function(...)
    -- function num : 0_3_1 , upvalues : isAimSweep, _ENV, StageData, aimItemId, aimItemNum
    if isAimSweep then
      (PlotDungeonMgr.StartSweep)(StageData.id, 1, aimItemId, aimItemNum)
    else
      ;
      (PlotDungeonMgr.StartSweep)(StageData.id, 1, nil)
    end
    ;
    (Util.SetOnClickDelay)(0.5)
  end
)
    ;
    ((uis.sweepaway10Btn).onClick):Add(function(...)
    -- function num : 0_3_2 , upvalues : isAimSweep, _ENV, StageData, aimItemId, aimItemNum
    if isAimSweep then
      (PlotDungeonMgr.StartSweep)(StageData.id, 10, aimItemId, aimItemNum)
    else
      ;
      (PlotDungeonMgr.StartSweep)(StageData.id, 10, nil)
    end
    ;
    (Util.SetOnClickDelay)(0.5)
  end
)
    ;
    ((uis.CloseBtn).onClick):Add(function(...)
    -- function num : 0_3_3 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.PlotDetailWindow).name)
  end
)
  end
end

PlotDetailWindow.OnShown = function(...)
  -- function num : 0_4 , upvalues : _ENV
  (GuideMgr.CheckIsTriggerGuide)((WinResConfig.PlotDetailWindow).name)
end

PlotDetailWindow.OnHide = function(...)
  -- function num : 0_5
end

PlotDetailWindow.OnClose = function(...)
  -- function num : 0_6 , upvalues : _ENV, contentPane, uis, StageData
  (GuideData.AbolishControlRefer)((WinResConfig.PlotDetailWindow).name)
  contentPane = nil
  uis = nil
  StageData = nil
end

PlotDetailWindow.InitPropList = function(...)
  -- function num : 0_7 , upvalues : uis, _ENV, StageData
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

  (uis.Prop1List).numItems = 0
  if not (PlotDungeonMgr.CurrentIsPassDungeon)() then
    local first_drop_show = StageData.first_drop_show
    local firstConfigs = (Util.ParseConfigStr)(first_drop_show)
    for _,v in ipairs(firstConfigs) do
      if v[2] then
        local Frame = (Util.CreateFrame)(v[2], false, v[3], true)
        ;
        (uis.Prop1List):AddChild(Frame)
      end
    end
  end
  do
    local drop_show = StageData.drop_show
    local configs = (Util.ParseConfigStr)(drop_show)
    for _,v in pairs(configs) do
      if v[2] then
        local Frame = (Util.CreateFrame)(v[2])
        ;
        (uis.Prop1List):AddChild(Frame)
      end
    end
  end
end

PlotDetailWindow.InitFirstPassList = function(...)
  -- function num : 0_8 , upvalues : uis, StageData, _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

  (uis.Prop2List).numItems = 0
  local first_reward = StageData.first_reward
  local configs = (Util.ParseConfigStr)(first_reward)
  local isPass = (PlotDungeonMgr.CurrentIsPassDungeon)()
  for _,v in ipairs(configs) do
    local Frame = (Util.CreateFrame)(v[2], isPass, v[3])
    ;
    (uis.Prop2List):AddChild(Frame)
  end
end

PlotDetailWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_9
  if msgId ~= 1 or msgId == 2 then
  end
end

return PlotDetailWindow

