-- params : ...
-- function num : 0 , upvalues : _ENV
require("Adventure_AdventureWindowByName")
local AdventureWindow = {}
SwipeGesture = FairyGUI.SwipeGesture
local uis, Swipe = nil, nil
local middleMax = 0
local middleMin = 0
local endVelocity = 0
local canMove = true
local cloudHolder = nil
local SFXoffset = (Vector2(10, -200))
local DailyDungeonTips = nil
local isNight = false
AdventureWindow.OnInit = function(bridge, ...)
  -- function num : 0_0 , upvalues : _ENV, canMove, uis, AdventureWindow, isNight, Swipe, endVelocity, middleMin, cloudHolder, DailyDungeonTips
  bridge:SetView((WinResConfig.AdventureWindow).package, (WinResConfig.AdventureWindow).comName)
  canMove = true
  uis = GetAdventure_AdventureWindowUis(bridge.contentPane)
  ;
  (AdventureWindow.InitAssetStrip)()
  ;
  (AdventureWindow.InitBtn)()
  local hour = tonumber((os.date)("%H"))
  isNight = hour >= 18 or hour < 6
  Swipe = SwipeGesture(bridge.contentPane)
  ;
  (Swipe.onMove):Add(function(...)
    -- function num : 0_0_0 , upvalues : canMove, AdventureWindow, Swipe
    if canMove then
      (AdventureWindow.MoveBg)((Swipe.delta).x)
    end
  end
)
  ;
  (Swipe.onEnd):Add(function(...)
    -- function num : 0_0_1 , upvalues : canMove, endVelocity, Swipe
    if canMove then
      endVelocity = (Swipe.velocity).x
    end
  end
)
  ;
  (UpdateMgr.AddUpdateHandler)(AdventureWindow.Update)
  ;
  ((uis.root):GetTransition("in")).invalidateBatchingEveryFrame = true
  local nearWidth = ((uis.NearComp).root).width
  local scale = (ResolutionHandler.AdaptOffset).X + DesignScreen.width
  middleMin = scale - nearWidth + 50
  -- DECOMPILER ERROR at PC65: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (bridge.contentPane).fairyBatching = false
  ;
  (AdventureWindow.RegisterGuide)()
  ;
  (AdventureWindow.BindingUI)()
  if not isNight then
    cloudHolder = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_ADVENTURE_CLOUD, false, true)
    cloudHolder.scale = Vector2(1.1, 1)
    cloudHolder.xy = Vector2(((uis.BackComp).root).width / 2, (GRoot.inst).height / 2 + 100)
    ;
    ((uis.BackComp).root):AddChildAt(cloudHolder, 3)
  end
  ;
  (LuaSound.LoadAndPlayBGM)(1010002)
  DailyDungeonTips = ((uis.MiddleComp).ExperimentIconBtn):GetChild("DailyDungeonTips")
  if (FunctionControlMgr.GetFunctionState)(ControlID.Adventure_Daily) then
    if (GuideMgr.IsInMainGuide)() and (GuideMgr.GuideId)() == 78100008 then
      DailyDungeonTips.visible = false
      return 
    end
    ld("DailyDungeon")
    if #DailyDungeonData.trialDataTable <= 0 then
      (DailyDungeonService.ReqInitData)(function(...)
    -- function num : 0_0_2 , upvalues : AdventureWindow
    (AdventureWindow.SetDailyShow)()
  end
)
    else
      (AdventureWindow.SetDailyShow)()
    end
  else
    DailyDungeonTips.visible = false
  end
  ;
  (AdventureWindow.SetLightOrDark)()
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

AdventureWindow.SetMultipleShow = function(challengeList, obj, ...)
  -- function num : 0_1 , upvalues : _ENV
  local multiPle = obj:GetChild("Tips")
  if not multiPle then
    return 
  end
  local isOpen = false
  for _,v in ipairs(challengeList) do
    local state = (ActivityMgr.GetMultipleIsOpenByChallengeType)(v)
    if not isOpen then
      isOpen = state
    end
  end
  multiPle.visible = isOpen
end

AdventureWindow.SetLightOrDark = function(...)
  -- function num : 0_2 , upvalues : isNight, _ENV, uis
  local selectIndex = 0
  if isNight then
    selectIndex = 1
  end
  ChangeUIController((uis.MiddleComp).root, "Time", selectIndex)
  ChangeUIController((uis.NearComp).root, "Time", selectIndex)
  ChangeUIController((uis.BackComp).root, "Time", selectIndex)
  ChangeUIController((uis.MiddleComp).ExperimentIconBtn, "Time", selectIndex)
  ChangeUIController((uis.MiddleComp).MapWorkshopIconBtn, "Time", selectIndex)
  ChangeUIController((uis.MiddleComp).ExpeditionIconBtn, "Time", selectIndex)
  ChangeUIController((uis.MiddleComp).AdventureIconBtn, "Time", selectIndex)
  ChangeUIController((uis.MiddleComp).ArenaIconBtn, "Time", selectIndex)
  ChangeUIController((uis.MiddleComp).HeroBtn, "Time", selectIndex)
  ChangeUIController((uis.MiddleComp).RichIconBtn, "Time", selectIndex)
end

local dailyType = {PlayType.RoleExpDungeon, PlayType.CoinDungeon, PlayType.EquipmentExpDungeon}
local functionID = {ControlID.Daily_Medical, ControlID.Daily_Gold, ControlID.Daily_Crystal}
AdventureWindow.SetDailyShow = function(...)
  -- function num : 0_3 , upvalues : dailyType, _ENV, functionID, DailyDungeonTips, AdventureWindow
  local remainTime = 0
  local index = 0
  for i = 1, 3 do
    local type = dailyType[i]
    local functionState = (FunctionControlMgr.GetFunctionState)(functionID[i], false)
    remainTime = (DailyDungeonData.GetRemainChallengeTime)(type)
    if remainTime > 0 and functionState then
      index = i
      break
    end
  end
  do
    if index > 0 then
      DailyDungeonTips.visible = true
      ;
      (DailyDungeonTips:GetChild("WordTxt")).text = (AdventureWindow.GetDailyNameByType)(dailyType[index]) .. " " .. remainTime
    else
      DailyDungeonTips.visible = false
    end
  end
end

AdventureWindow.GetDailyNameByType = function(type, ...)
  -- function num : 0_4 , upvalues : _ENV
  if type == PlayType.RoleExpDungeon then
    return (PUtil.get)(40002002)
  else
    if type == PlayType.CoinDungeon then
      return (PUtil.get)(40002001)
    else
      if type == PlayType.EquipmentExpDungeon then
        return (PUtil.get)(40002003)
      end
    end
  end
end

AdventureWindow.BindingUI = function(...)
  -- function num : 0_5 , upvalues : _ENV, uis
  local winName = (WinResConfig.AdventureWindow).name
  local BindingUI = RedDotMgr.BindingUI
  local RedDotComID = RedDotComID
  BindingUI(winName, RedDotComID.Adventure_Story, (uis.MiddleComp).AdventureIconBtn)
  BindingUI(winName, RedDotComID.Adventure_Daily, (uis.MiddleComp).ExperimentIconBtn)
  BindingUI(winName, RedDotComID.Adventure_Hero, (uis.MiddleComp).HeroBtn)
  BindingUI(winName, RedDotComID.Adventure_Tower, (uis.MiddleComp).MapWorkshopIconBtn)
  BindingUI(winName, RedDotComID.Adventure_Expedition, (uis.MiddleComp).ExpeditionIconBtn)
  BindingUI(winName, RedDotComID.Adventure_BigAdventure, (uis.MiddleComp).RichIconBtn)
  BindingUI(winName, RedDotComID.Adventure_Arena, (uis.MiddleComp).ArenaIconBtn)
  ;
  (RedDotMgr.RefreshTreeUI)(winName)
end

AdventureWindow.RegisterGuide = function(...)
  -- function num : 0_6 , upvalues : _ENV, uis
  local winName = (WinResConfig.AdventureWindow).name
  local RegisterGuideAndControl = GuideData.RegisterGuideAndControl
  local ControlID = ControlID
  RegisterGuideAndControl(ControlID.Adventure_Plot, (uis.MiddleComp).AdventureIconBtn, winName)
  RegisterGuideAndControl(ControlID.Adventure_Hero, (uis.MiddleComp).HeroBtn, winName)
  RegisterGuideAndControl(ControlID.Adventure_Daily, (uis.MiddleComp).ExperimentIconBtn, winName)
  RegisterGuideAndControl(ControlID.Adventure_Arena, (uis.MiddleComp).ArenaIconBtn, winName)
  RegisterGuideAndControl(ControlID.Adventure_Tower, (uis.MiddleComp).MapWorkshopIconBtn, winName)
  RegisterGuideAndControl(ControlID.Adventure_Expedition, (uis.MiddleComp).ExpeditionIconBtn, winName)
  RegisterGuideAndControl(ControlID.Adventure_Rich, (uis.MiddleComp).RichIconBtn, winName)
  RegisterGuideAndControl(ControlID.Adventure_Back, (uis.AssetStrip).BackBtn, winName)
end

AdventureWindow.Update = function(...)
  -- function num : 0_7 , upvalues : _ENV, endVelocity, AdventureWindow
  if (math.abs)(endVelocity) > 10 then
    endVelocity = (Umath.Lerp)(endVelocity, 0, Time.deltaTime * 5)
    ;
    (AdventureWindow.MoveBg)(endVelocity / 25)
  end
  if (Input.GetKey)(KeyCode.Z) and (Input.GetKeyDown)(KeyCode.C) then
    UIMgr:SetOnShownComplete((WinResConfig.HomeWindow).name, function(...)
    -- function num : 0_7_0 , upvalues : _ENV
    OpenWindow((WinResConfig.FunctionOpenWindow).name, UILayer.HUD1, 200203)
  end
)
    UIMgr:CloseToWindow((WinResConfig.HomeWindow).name)
  end
end

AdventureWindow.MoveBg = function(dis, ...)
  -- function num : 0_8 , upvalues : uis, middleMax, middleMin, cloudHolder
  if middleMax < ((uis.NearComp).root).x + dis * 0.8 then
    dis = (middleMax - ((uis.NearComp).root).x) * 1.25
  end
  if ((uis.NearComp).root).x + dis * 0.8 < middleMin then
    dis = (middleMin - ((uis.NearComp).root).x) * 1.25
  end
  ;
  ((uis.MiddleComp).MapWorkshopIconBtn):InvalidateBatchingState()
  -- DECOMPILER ERROR at PC39: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.BackComp).root).x = ((uis.BackComp).root).x + dis * 0.1
  -- DECOMPILER ERROR at PC47: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.MiddleComp).root).x = ((uis.MiddleComp).root).x + dis * 0.3
  -- DECOMPILER ERROR at PC55: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.NearComp).root).x = ((uis.NearComp).root).x + dis * 0.5
  if cloudHolder then
    cloudHolder.x = cloudHolder.x + dis * 0.1
  end
end

AdventureWindow.OnShown = function(...)
  -- function num : 0_9 , upvalues : _ENV, uis, SFXoffset, isNight, AdventureWindow, canMove
  (GuideMgr.MildGuideTrigger)((WinResConfig.AdventureWindow).name)
  local centerPos = Vector2(((uis.MiddleComp).root).width / 2, ((uis.MiddleComp).root).height / 2) + SFXoffset
  local sfxName = UIEffectEnum.UI_ADVENTURE_BG
  if isNight then
    sfxName = UIEffectEnum.UI_ADVENTURE_BG_NIGHT
  end
  ;
  (LuaEffect.CreateEffectToObj)(sfxName, true, (uis.MiddleComp).root, centerPos)
  for i = ControlID.Adventure_Plot, ControlID.Adventure_Rich do
    if (FunctionControlMgr.GetFunctionState)(i, false) == true then
      if (AdventureWindow.AniIsPlay)(i) then
        local control = (GuideData.GetGuideControl)(i)
        for _,v in ipairs(control) do
          PlayUITrans(v, "in")
        end
      else
        do
          local control = (GuideData.GetGuideControl)(i)
          for _,v in ipairs(control) do
            PlayUITrans(v, "open")
          end
          do
            local aniStr = (Util.GetPlayerSetting)(PlayerPrefsKeyName.ADVENTURE_UNLOCK_ANI, "")
            ;
            (Util.SetPlayerSetting)(PlayerPrefsKeyName.ADVENTURE_UNLOCK_ANI, aniStr .. ":" .. i)
            -- DECOMPILER ERROR at PC95: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC95: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC95: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC95: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC95: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
  if UIMgr:IsWindowOpen((WinResConfig.GuideWindow).name) then
    canMove = false
  end
  ;
  (AdventureWindow.SetMultipleShow)({(ProtoEnum.E_CHALLENGE_TYPE).STORE_CHALLENGE}, (uis.MiddleComp).AdventureIconBtn)
  ;
  (AdventureWindow.SetMultipleShow)({(ProtoEnum.E_CHALLENGE_TYPE).GOLD_CHALLENGE, (ProtoEnum.E_CHALLENGE_TYPE).EXP_CHALLENGE, (ProtoEnum.E_CHALLENGE_TYPE).EQUIPEXP_CHALLENGE}, (uis.MiddleComp).ExperimentIconBtn)
  ;
  (AdventureWindow.SetMultipleShow)({(ProtoEnum.E_CHALLENGE_TYPE).TOWER_CHALLENGE}, (uis.MiddleComp).MapWorkshopIconBtn)
  ;
  (AdventureWindow.SetMultipleShow)({(ProtoEnum.E_CHALLENGE_TYPE).EXPEDITION_CHALLENGE}, (uis.MiddleComp).ExpeditionIconBtn)
  ;
  (AdventureWindow.SetMultipleShow)({(ProtoEnum.E_CHALLENGE_TYPE).ARENA_CHALLENGE}, (uis.MiddleComp).ArenaIconBtn)
  ;
  (AdventureWindow.SetMultipleShow)({(ProtoEnum.E_CHALLENGE_TYPE).ELITE_CHALLENGE}, (uis.MiddleComp).HeroBtn)
  ;
  (AdventureWindow.SetMultipleShow)({(ProtoEnum.E_CHALLENGE_TYPE).ADVENTURE_CHALLENGE}, (uis.MiddleComp).RichIconBtn)
end

AdventureWindow.AniIsPlay = function(id, ...)
  -- function num : 0_10 , upvalues : _ENV
  local aniStr = (Util.GetPlayerSetting)(PlayerPrefsKeyName.ADVENTURE_UNLOCK_ANI, "")
  local yetPlay = split(aniStr, ":")
  for _,v in ipairs(yetPlay) do
    if tonumber(v) == id then
      return true
    end
  end
end

AdventureWindow.IsRequest = function(...)
  -- function num : 0_11
end

AdventureWindow.InitBtn = function(...)
  -- function num : 0_12 , upvalues : uis, AdventureWindow, _ENV
  (((uis.MiddleComp).AdventureIconBtn).onClick):Set(function(...)
    -- function num : 0_12_0 , upvalues : AdventureWindow, _ENV
    (AdventureWindow.OnClickRequestService)(function(...)
      -- function num : 0_12_0_0 , upvalues : _ENV
      (PlotDungeonService.ReqStoryInfo)((ProtoEnum.E_CHALLENGE_TYPE).STORE_CHALLENGE)
    end
)
  end
)
  ;
  (((uis.MiddleComp).ArenaIconBtn).onClick):Set(function(...)
    -- function num : 0_12_1 , upvalues : AdventureWindow, _ENV
    (AdventureWindow.OnClickRequestService)(function(...)
      -- function num : 0_12_1_0 , upvalues : _ENV
      ld("Arena", function(...)
        -- function num : 0_12_1_0_0 , upvalues : _ENV
        (ArenaMgr.TryOpenArenaUI)()
      end
)
    end
)
  end
)
  ;
  (((uis.MiddleComp).ExperimentIconBtn).onClick):Set(function(...)
    -- function num : 0_12_2 , upvalues : AdventureWindow, _ENV
    (AdventureWindow.OnClickRequestService)(function(...)
      -- function num : 0_12_2_0 , upvalues : _ENV
      ld("DailyDungeon", function(...)
        -- function num : 0_12_2_0_0 , upvalues : _ENV
        (DailyDungeonService.ReqInitData)()
      end
)
    end
)
  end
)
  ;
  (((uis.MiddleComp).RichIconBtn).onClick):Set(function(...)
    -- function num : 0_12_3 , upvalues : _ENV
    print("RichIcon")
    ld("Adventure", function(...)
      -- function num : 0_12_3_0 , upvalues : _ENV
      (AdventureMgr.TryOpenAdventureUI)()
    end
)
  end
)
  ;
  (((uis.MiddleComp).ExpeditionIconBtn).onClick):Set(function(...)
    -- function num : 0_12_4 , upvalues : _ENV
    print("ExpeditionIcon")
    ld("Expedition", function(...)
      -- function num : 0_12_4_0 , upvalues : _ENV
      (ExpeditionService.OnReqExpeditionData)()
    end
)
  end
)
  ;
  (((uis.MiddleComp).HeroBtn).onClick):Set(function(...)
    -- function num : 0_12_5 , upvalues : AdventureWindow, _ENV
    (AdventureWindow.PrepareHeroAsset)()
    ;
    (AdventureWindow.OnClickRequestService)(function(...)
      -- function num : 0_12_5_0 , upvalues : _ENV
      (PlotDungeonService.ReqStoryInfo)((ProtoEnum.E_CHALLENGE_TYPE).ELITE_CHALLENGE)
    end
)
  end
)
  ;
  (((uis.MiddleComp).MapWorkshopIconBtn).onClick):Set(function(...)
    -- function num : 0_12_6 , upvalues : _ENV
    ld("Tower", function(...)
      -- function num : 0_12_6_0 , upvalues : _ENV
      (TowerMgr.TryOpenTowerUI)()
    end
)
  end
)
end

AdventureWindow.OnClickRequestService = function(fun, ...)
  -- function num : 0_13 , upvalues : _ENV
  (Util.SetOnClickDelay)(0.1)
  if fun then
    fun()
  end
end

AdventureWindow.PrepareHeroAsset = function(...)
  -- function num : 0_14 , upvalues : _ENV
  local resList = {}
  local chapterData = (TableData.gTable).BaseChapterData
  for _,v in pairs(chapterData) do
    if v.type == (ProtoEnum.E_CHALLENGE_TYPE).ELITE_CHALLENGE then
      local show_spine = (CardMgr.GetShowSpineBundle)(v.book_show)
      ;
      (table.insert)(resList, show_spine)
    end
  end
  ;
  (Util.PreloadResource)(resList)
end

AdventureWindow.OnHide = function(...)
  -- function num : 0_15
end

AdventureWindow.OnClose = function(...)
  -- function num : 0_16 , upvalues : _ENV, cloudHolder, AdventureWindow, uis, Swipe, DailyDungeonTips
  (LuaEffect.DestroyEffect)(cloudHolder)
  cloudHolder = nil
  ;
  (RedDotMgr.RemoveUIRefer)((WinResConfig.AdventureWindow).name)
  ;
  (GuideData.AbolishControlRefer)((WinResConfig.AdventureWindow).name)
  ;
  (CommonWinMgr.RemoveAssets)((WinResConfig.AdventureWindow).name)
  ;
  (UpdateMgr.RemoveUpdateHandler)(AdventureWindow.Update)
  uis = nil
  Swipe = nil
  DailyDungeonTips = nil
end

AdventureWindow.InitAssetStrip = function(...)
  -- function num : 0_17 , upvalues : _ENV, uis
  local m = {}
  m.windowName = (WinResConfig.AdventureWindow).name
  m.Tip = (PUtil.get)(20000052)
  m.model = uis.AssetStrip
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.PHYSICAL}
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

AdventureWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_18
end

return AdventureWindow

