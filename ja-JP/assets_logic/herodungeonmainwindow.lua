-- params : ...
-- function num : 0 , upvalues : _ENV
require("HeroDungeon_HeroDungeonMainWindowByName")
require("HeroDungeon_HeroPlotMap001ByName")
require("HeroDungeon_HeroDungeonMonsterByName")
local Sweep_type = {WithoutSweep = 0, AllowSweep = 1}
local contentPane = nil
local uis = {}
local HeroDungeonMainWindow = {}
local ChapterData = nil
local currentStageBox = 0
local stageIdConnexionNum = {}
local CloudList, ComBg, ComLogo, BgPosX, LogoPosX = nil, nil, nil, nil, nil
local CloudSpeed = 20
local isMove = false
HeroDungeonMainWindow.OnInit = function(bridge, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, uis, HeroDungeonMainWindow, ChapterData, currentStageBox
  bridge:SetView((WinResConfig.HeroDungeonMainWindow).package, (WinResConfig.HeroDungeonMainWindow).comName)
  contentPane = bridge.contentPane
  uis = GetHeroDungeon_HeroDungeonMainWindowUis(contentPane)
  ;
  (HeroDungeonMainWindow.InitAssetStrip)()
  local currentChapter = (PlotDungeonMgr.GetSelectChapter)()
  ChapterData = ((TableData.gTable).BaseChapterData)[currentChapter]
  ;
  (HeroDungeonMainWindow.InitStageList)(true)
  ;
  (HeroDungeonMainWindow.RefreshChapterBox)()
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.NameTxt).text = ChapterData.name
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.SweepBtn).text = (PUtil.get)(20000053)
  ;
  ((uis.SweepBtn).onClick):Set(function(...)
    -- function num : 0_0_0 , upvalues : _ENV
    OpenWindow((WinResConfig.FastSweepWindow).name, UILayer.HUD)
  end
)
  ;
  ((uis.RewardBtn).onClick):Set(function(...)
    -- function num : 0_0_1 , upvalues : _ENV, currentStageBox
    local stage = ((TableData.gTable).BaseStageData)[currentStageBox]
    if not stage then
      return 
    end
    local boxState = (PlotDungeonMgr.GetAppendixState)(currentStageBox)
    if boxState == AppendixBoxState.NoCondition then
      local btnData = {}
      btnData.btnTxt = (PUtil.get)(30)
      btnData.fun = function(...)
      -- function num : 0_0_1_0 , upvalues : _ENV
      UIMgr:CloseWindow((WinResConfig.RewardDisplayWindow).name)
    end

      ;
      (MessageMgr.OpenRewardWindow)(stage.ext_reward, btnData, stage.id, (PUtil.get)(20000044), (PUtil.get)(20000291))
    else
      do
        if boxState == AppendixBoxState.Unclaimed then
          local btnData = {}
          btnData.btnTxt = (PUtil.get)(20000010)
          btnData.fun = function(...)
      -- function num : 0_0_1_1 , upvalues : _ENV, stage
      (PlotDungeonService.ReqGetAppendixBox)(stage.id)
    end

          ;
          (MessageMgr.OpenRewardWindow)(stage.ext_reward, btnData, stage.id, (PUtil.get)(20000045))
        end
      end
    end
  end
)
  -- DECOMPILER ERROR at PC49: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.HeroPlotMapList).scrollItemToViewOnClick = false
  ;
  (((uis.HeroPlotMapList).scrollPane).onScroll):Add(HeroDungeonMainWindow.OnScrollView)
  ;
  (HeroDungeonMainWindow.InitFunctionControl)()
  GuideSetDelayShow(contentPane)
end

HeroDungeonMainWindow.InitFunctionControl = function(...)
  -- function num : 0_1 , upvalues : _ENV, uis
  local winName = (WinResConfig.HeroDungeonMainWindow).name
  local RegisterGuideAndControl = GuideData.RegisterGuideAndControl
  local ControlID = ControlID
  RegisterGuideAndControl(ControlID.HeroChapterSage_OneOne, uis.HeroPlotMapList, winName)
end

HeroDungeonMainWindow.CheckPassProcess = function(...)
  -- function num : 0_2 , upvalues : _ENV, currentStageBox, ChapterData
  local stage = ((TableData.gTable).BaseStageData)[currentStageBox]
  if not stage then
    return 
  end
  local chapterID = ChapterData.id
  local boxState = (PlotDungeonMgr.GetAppendixState)(currentStageBox)
  if boxState == AppendixBoxState.Unclaimed and (Util.IsPrepareLevelUpWindow)() and not (FunctionControlMgr.IsPrepareFunctionOpenWindow)() then
    UIMgr:SetOnHideComplete((WinResConfig.PlayerLevelUpWindow).name, function(...)
    -- function num : 0_2_0 , upvalues : _ENV, chapterID, currentStageBox
    OpenWindow((WinResConfig.PlotChapterFinshWindow).name, UILayer.HUD1, chapterID, currentStageBox)
  end
)
  end
  OpenWindow((WinResConfig.PlotChapterFinshWindow).name, UILayer.HUD1, chapterID, currentStageBox)
end

HeroDungeonMainWindow.Update = function(...)
  -- function num : 0_3 , upvalues : CloudList, isMove
  if not CloudList or isMove then
  end
end

HeroDungeonMainWindow.OnScrollView = function(...)
  -- function num : 0_4
end

HeroDungeonMainWindow.InitBg = function(...)
  -- function num : 0_5 , upvalues : uis, isMove, HeroDungeonMainWindow, ComBg, _ENV, ComLogo, BgPosX, LogoPosX
  local PlotMap = (uis.HeroPlotMapList):GetChildAt(0)
  local bg = PlotMap:GetChild("Effect_1_Grp")
  local cloud = PlotMap:GetChild("Effect_3_Grp")
  cloud.width = bg.width
  local cloudList = cloud:GetChild("EffectList")
  isMove = true
  cloudList.width = bg.width
  cloudList.touchable = false
  cloudList:SetVirtualAndLoop()
  cloudList.itemRenderer = HeroDungeonMainWindow.CloudRender
  cloudList.numItems = 2
  ComBg = bg:GetChild("n1")
  ComBg.pivot = Vector2(0.5, 0.5)
  ComLogo = PlotMap:GetChild("Effect_2_Grp")
  BgPosX = ComBg.x
  LogoPosX = ComLogo.x
  ComBg.width = ComBg.width + 200
  BgPosX = ComBg.x
  return cloudList
end

local lastPos = 0
HeroDungeonMainWindow.MoveBg = function(dis, ...)
  -- function num : 0_6 , upvalues : ComBg, BgPosX, ComLogo, LogoPosX, isMove, lastPos, CloudList, _ENV, CloudSpeed
  ComBg.x = BgPosX + dis / 2
  ComLogo.x = LogoPosX + dis
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'

  if isMove then
    if lastPos - dis < 0 then
      (CloudList.scrollPane).posX = (CloudList.scrollPane).posX + Time.deltaTime * CloudSpeed * 10
    else
      -- DECOMPILER ERROR at PC34: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (CloudList.scrollPane).posX = (CloudList.scrollPane).posX - Time.deltaTime * CloudSpeed * 10
    end
  end
  lastPos = dis
end

HeroDungeonMainWindow.CloudRender = function(dex, obj, ...)
  -- function num : 0_7
end

HeroDungeonMainWindow.GetAlreadyPass = function(...)
  -- function num : 0_8 , upvalues : _ENV, ChapterData
  local StagesStr = split(ChapterData.stages, ":")
  for i = 1, #StagesStr do
    local stateId = StagesStr[i]
    if not (PlotDungeonMgr.IsPassDungeon)(tonumber(stateId)) then
      return i
    end
  end
  return #StagesStr
end

HeroDungeonMainWindow.SetListInitPos = function(...)
  -- function num : 0_9 , upvalues : _ENV, uis, HeroDungeonMainWindow
  local pos = (PlotDungeonMgr.RecodeHeroDungeonPos)()
  if pos and pos >= 0 then
    ((uis.HeroPlotMapList).scrollPane):SetPosX(pos, false)
    return 
  end
  pos = (HeroDungeonMainWindow.GetAlreadyPass)()
  local PlotMap = (uis.HeroPlotMapList):GetChildAt(0)
  local obj = (Util.GetGroupDate)(PlotMap, PlotMap:GetChild("MonsterGrp"), pos)
  if obj then
    local pos = obj.x - DesignScreen.width / 2
    local offsetX = (Umath.Clamp)(pos, 0, 100000)
    -- DECOMPILER ERROR at PC44: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((uis.HeroPlotMapList).scrollPane).posX = offsetX
  else
    do
      -- DECOMPILER ERROR at PC54: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((uis.HeroPlotMapList).scrollPane).posX = ((uis.MapList).HeroPlotMapList).viewWidth + DesignScreen.width
    end
  end
end

HeroDungeonMainWindow.RefreshChapterBox = function(...)
  -- function num : 0_10 , upvalues : uis, currentStageBox, ChapterData, _ENV, HeroDungeonMainWindow
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

  (uis.RewardBtn).visible = false
  currentStageBox = 0
  if ChapterData then
    local stages = split(ChapterData.stages, ":")
    for _,v in ipairs(stages) do
      local boxState = (PlotDungeonMgr.GetAppendixState)(v)
      -- DECOMPILER ERROR at PC28: Confused about usage of register: R7 in 'UnsetPending'

      if boxState == AppendixBoxState.NoCondition or boxState == AppendixBoxState.Unclaimed then
        (uis.RewardBtn).visible = true
        currentStageBox = tonumber(v)
        ;
        ((uis.RewardBtn):GetChild("RedDot")).visible = boxState == AppendixBoxState.Unclaimed
        ;
        (HeroDungeonMainWindow.CheckPassProcess)()
        return 
      end
    end
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

HeroDungeonMainWindow.InitStageList = function(initPos, ...)
  -- function num : 0_11 , upvalues : stageIdConnexionNum, uis, _ENV, ChapterData, HeroDungeonMainWindow
  local PlotMap = nil
  stageIdConnexionNum = {}
  if (uis.HeroPlotMapList).numItems == 0 then
    local bgRes = ((Util.ParseConfigStr)(ChapterData.bg_res))[1]
    PlotMap = UIMgr:CreateObject(bgRes[1], bgRes[2])
    ;
    (uis.HeroPlotMapList):AddChild(PlotMap)
  else
    do
      PlotMap = (uis.HeroPlotMapList):GetChildAt(0)
      local already = (HeroDungeonMainWindow.GetAlreadyPass)()
      for i = 1, 30 do
        local StageModel = (Util.GetGroupDate)(PlotMap, PlotMap:GetChild("MonsterGrp"), i)
        local LineModel = (Util.GetGroupDate)(PlotMap, PlotMap:GetChild("LineGrp"), i)
        if StageModel then
          StageModel.visible = false
        end
      end
      if ChapterData then
        local stages = split(ChapterData.stages, ":")
        for i,v in ipairs(stages) do
          local StageModel = (Util.GetGroupDate)(PlotMap, PlotMap:GetChild("MonsterGrp"), i)
          ;
          (HeroDungeonMainWindow.SetStageShowing)(StageModel, v, i)
          stageIdConnexionNum[tonumber(v)] = i
          StageModel.visible = true
        end
      end
      do
        if initPos then
          (HeroDungeonMainWindow.SetListInitPos)()
        end
        ;
        (Util.SetTransition)({PlotMap})
      end
    end
  end
end

HeroDungeonMainWindow.SetStageShowing = function(HeroMonster, stageID, pos, ...)
  -- function num : 0_12 , upvalues : _ENV, Sweep_type, uis
  local stageData = ((TableData.gTable).BaseStageData)[tonumber(stageID)]
  if not stageData then
    return 
  end
  local model = GetHeroDungeon_HeroDungeonMonsterUis(HeroMonster)
  local isPass = (PlotDungeonMgr.IsPassDungeon)(stageID)
  local canChange = (PlotDungeonMgr.IsCanChallenge)(stageID, false)
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R7 in 'UnsetPending'

  if canChange then
    (model.c2Ctr).selectedIndex = 0
  else
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (model.c2Ctr).selectedIndex = 1
  end
  -- DECOMPILER ERROR at PC38: Confused about usage of register: R7 in 'UnsetPending'

  if (PlotDungeonMgr.GetCanChangeTimesDungeon)(stageID) > 0 and isPass then
    (model.c1Ctr).selectedIndex = 0
  else
    -- DECOMPILER ERROR at PC41: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (model.c1Ctr).selectedIndex = 1
  end
  if stageData.sweep_type == Sweep_type.AllowSweep then
    local monsterModel = (model.CharacterLoader).Model
    if not monsterModel then
      monsterModel = (Util.CreateMiniModelByPath)(model.CharacterLoader, stageData.monster_icon, function(model, ...)
    -- function num : 0_12_0 , upvalues : _ENV
    (SkeletonAnimationUtil.SetFlip)(model, true, false)
  end
)
    end
    -- DECOMPILER ERROR at PC62: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (model.Btn).text = (PUtil.get)(60000007)
    ;
    ((model.Btn).onClick):Set(function(...)
    -- function num : 0_12_1 , upvalues : _ENV, stageData
    (PlotDungeonMgr.StartSweep)(stageData.id, 1)
  end
)
    -- DECOMPILER ERROR at PC79: Confused about usage of register: R8 in 'UnsetPending'

    if (PlotDungeonMgr.IsPassDungeon)(stageData.id) then
      (model.ChallengeTimeTxt).text = (PUtil.get)(20000056)
      -- DECOMPILER ERROR at PC81: Confused about usage of register: R8 in 'UnsetPending'

      ;
      (model.ChallengeTimeTxt).width = 100
      local times = (PlotDungeonMgr.GetCanChangeTimesDungeon)(stageData.id)
      -- DECOMPILER ERROR at PC91: Confused about usage of register: R9 in 'UnsetPending'

      if times <= 0 then
        (model.ChallengeNumberTxt).color = Const.LackColorRGB
      end
      -- DECOMPILER ERROR at PC93: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (model.ChallengeNumberTxt).text = times
    else
      do
        do
          -- DECOMPILER ERROR at PC100: Confused about usage of register: R8 in 'UnsetPending'

          ;
          (model.ChallengeTimeTxt).text = (PUtil.get)(20000057)
          -- DECOMPILER ERROR at PC102: Confused about usage of register: R8 in 'UnsetPending'

          ;
          (model.ChallengeTimeTxt).width = 120
          -- DECOMPILER ERROR at PC104: Confused about usage of register: R8 in 'UnsetPending'

          ;
          (model.ChallengeNumberTxt).visible = false
          -- DECOMPILER ERROR at PC107: Confused about usage of register: R8 in 'UnsetPending'

          ;
          (model.MonsterNumberTxt).text = stageData.remark
          local isPass = (PlotDungeonMgr.IsPassDungeon)(stageData.id)
          -- DECOMPILER ERROR at PC115: Confused about usage of register: R8 in 'UnsetPending'

          ;
          (model.CharacterLoader).visible = not isPass
          -- DECOMPILER ERROR at PC124: Confused about usage of register: R8 in 'UnsetPending'

          if not isPass then
            (model.CharacterLoader).url = UIMgr:GetItemUrl("HeroDungeon", "Animation")
            local com = (model.CharacterLoader).component
            local conIndex = stageData.type - 1
            if stageData.type == 4 then
              conIndex = 1
            end
            ;
            (com:GetController("c1")).selectedIndex = conIndex
            local gray = ((CS.UnityEngine).Color)(Const.GrayRColor / 255, Const.GrayRColor / 255, Const.GrayRColor / 255)
            if canChange then
              (com:GetChild("BattleImage")).color = Const.WhiteColorRGB
              ;
              (com:GetChild("StoryImage")).color = Const.WhiteColorRGB
              ;
              (com:GetChild("RewardBoxImage")).color = Const.WhiteColorRGB
            else
              ;
              (com:GetChild("BattleImage")).color = gray
              ;
              (com:GetChild("StoryImage")).color = gray
              ;
              (com:GetChild("RewardBoxImage")).color = gray
            end
            local trans = com:GetTransition("inopen")
            if trans then
              if (PlotDungeonMgr.IsCanChallenge)(stageData.id, false) then
                trans:Play(10000, 0, nil)
              else
                trans:Stop()
              end
            end
          end
          do
            ;
            ((model.CharacterLoader).onClick):Set(function(...)
    -- function num : 0_12_2 , upvalues : _ENV, stageID, uis
    if (PlotDungeonMgr.CheckSatisfyContent)(stageID) then
      (PlotDungeonMgr.OnClickStage)(stageID, false)
      ;
      (PlotDungeonMgr.RecodeHeroDungeonPos)(((uis.HeroPlotMapList).scrollPane).posX)
    end
  end
)
            local isFirst = (PlotDungeonMgr.IsFirstChallengeStage)(stageID)
            -- DECOMPILER ERROR at PC214: Confused about usage of register: R8 in 'UnsetPending'

            ;
            ((model.ChoiceGrp).root).visible = isFirst
          end
        end
      end
    end
  end
end

HeroDungeonMainWindow.OnShown = function(...)
  -- function num : 0_13
end

HeroDungeonMainWindow.OnHide = function(...)
  -- function num : 0_14
end

HeroDungeonMainWindow.OnClose = function(...)
  -- function num : 0_15 , upvalues : _ENV, uis, CloudList, ComBg, ComLogo, BgPosX, LogoPosX, contentPane
  (GuideData.AbolishControlRefer)((WinResConfig.HeroDungeonMainWindow).name)
  ;
  (CommonWinMgr.RemoveAssets)((WinResConfig.HeroDungeonMainWindow).name)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.HeroPlotMapList).numItems = 0
  CloudList = nil
  ComBg = nil
  ComLogo = nil
  BgPosX = nil
  LogoPosX = nil
  contentPane = nil
  uis = nil
end

HeroDungeonMainWindow.InitAssetStrip = function(...)
  -- function num : 0_16 , upvalues : _ENV, uis, ChapterData
  local m = {}
  m.windowName = (WinResConfig.HeroDungeonMainWindow).name
  m.Tip = (PUtil.get)(20000038)
  m.model = uis.AssetStrip
  m.closeToWindow = (WinResConfig.AdventureWindow).name
  m.BackBtnFun = function(...)
    -- function num : 0_16_0 , upvalues : _ENV, ChapterData
    (PlotDungeonMgr.RecodeHeroDungeonPos)(-1)
    ;
    (PlotDungeonMgr.SetBackHeroChapter)(ChapterData.id)
  end

  m.CloseBtnFun = function(...)
    -- function num : 0_16_1 , upvalues : _ENV
    (PlotDungeonMgr.RecodeHeroDungeonPos)(-1)
  end

  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.PHYSICAL}
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

HeroDungeonMainWindow.HandleMessage = function(msgId, ...)
  -- function num : 0_17 , upvalues : _ENV, HeroDungeonMainWindow
  if msgId == (WindowMsgEnum.PlotPlayWindow).E_MSG_ENEMY_REFRESH then
    (HeroDungeonMainWindow.RefreshChapterBox)()
    ;
    (HeroDungeonMainWindow.InitStageList)(false)
  end
  if msgId == (WindowMsgEnum.PlotPlayWindow).E_MSG_SET_LIST then
    (HeroDungeonMainWindow.InitStageList)(true)
  end
  if msgId == (WindowMsgEnum.HeroDungeonMainWindow).E_MSG_REFRESH then
    (HeroDungeonMainWindow.InitStageList)(false)
  end
end

return HeroDungeonMainWindow

