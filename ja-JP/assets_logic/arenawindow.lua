-- params : ...
-- function num : 0 , upvalues : _ENV
require("Arena_ArenaByName")
local ArenaWindow = {}
local uis, contentPane, _rivalController = nil, nil, nil
local _rivalList = {}
local _countdown = nil
local _refreshing = false
local _originPos = {}
local _originOutlinePos = {}
local _originSelectedPos = {}
local _originPosY, _originOutlinePosY, _selectedOutLinePosY, _chosedPosY, _chosedOutlinePosY, _chosedSelectedOutlinePosY = nil, nil, nil, nil, nil, nil
local _currentChosed = 0
local argTable = {}
local CHOSED_MOVE_Y = 0.25
local MIDDLE_VERTICAL_INDEX = 6
local MIDDLE_MOVE_INDEX = 3
local REFRESH_MOVE_DURATION = 0.18
local REFRESH_WAIT_DURATION = 0.25
local DEFAULT_CHOOSE_INDEX = 1
local _changeAnim, _refreshAnim, _blueFlag, _redFlag, _refreshed, _needrefresh, _checkStatueTimer, _polygonClickChecker, _lastSelectedItem = nil, nil, nil, nil, nil, nil, nil, nil, nil
local FxManager = require("FxManager")
ArenaWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, ArenaWindow
  bridgeObj:SetView((WinResConfig.ArenaWindow).package, (WinResConfig.ArenaWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  contentPane:Center()
  uis = GetArena_ArenaUis(contentPane)
  ;
  (ArenaWindow.InitTopMenu)()
  ;
  (ArenaWindow.InitVariable)()
  ;
  (ArenaWindow.InitText)()
  ;
  (ArenaWindow.InitButtonEvent)()
  local winName = (WinResConfig.ArenaWindow).name
  ;
  (RedDotMgr.BindingUI)(winName, RedDotComID.Arena_RewardBox, uis.RewardBtn)
  ;
  (RedDotMgr.RefreshTreeUI)(winName)
  ;
  (ArenaWindow.RegisterGuide)()
  ;
  (LeanTween.delayedCall)(0.7, function(...)
    -- function num : 0_0_0 , upvalues : _ENV
    if UIMgr:IsWindowOpen((WinResConfig.ArenaWindow).name) == true then
      (BattleBackground.PreLoad)(0, (ProtoEnum.E_BATTLE_TYPE).ARENA)
    end
  end
)
  ;
  (LeanTween.delayedCall)(1, function(...)
    -- function num : 0_0_1 , upvalues : _ENV
    if UIMgr:IsWindowOpen((WinResConfig.ArenaWindow).name) == true then
      local myselfList = (Util.CovertRemoteFormationToLocal)((ArenaData.BaseData).arenaCardGroups)
      for _,cardId in pairs(myselfList) do
        (BattleResource.PreLoadCard)(cardId)
      end
    end
  end
)
end

ArenaWindow.RegisterGuide = function(...)
  -- function num : 0_1 , upvalues : _ENV, uis
  local winName = (WinResConfig.ArenaWindow).name
  local RegisterGuideAndControl = GuideData.RegisterGuideAndControl
  local ControlID = ControlID
  RegisterGuideAndControl(ControlID.Arena_Opponent, (uis.ChallengeListGrp).Number_05_Btn, winName)
  RegisterGuideAndControl(ControlID.Arena_Challenge, uis.BattleBtn, winName)
  RegisterGuideAndControl(ControlID.Arena_Reward, uis.RewardBtn, winName)
end

ArenaWindow.InitTopMenu = function(...)
  -- function num : 0_2 , upvalues : _ENV, uis
  local m = {}
  m.windowName = (WinResConfig.ArenaWindow).name
  m.Tip = ((TableData.gTable).BaseClientWordData)[60000006]
  m.model = uis.AssetStripGrp
  m.closeToWindow = (WinResConfig.AdventureWindow).name
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.SHOP_TOKEN}
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

ArenaWindow.InitVariable = function(...)
  -- function num : 0_3 , upvalues : _changeAnim, uis, _refreshAnim, _rivalList, _ENV, _polygonClickChecker
  _changeAnim = (uis.root):GetTransition("change")
  _refreshAnim = ((uis.ChallengeListGrp).root):GetTransition("refresh")
  _rivalList = {}
  local vertexModifier = nil
  for i = 1, ArenaData.DefauleRivalAmount do
    local index = i
    local eachItem = {}
    eachItem.root = (uis.ChallengeListGrp)["Number_0" .. tostring(i) .. "_Btn"]
    eachItem.Text = (eachItem.root):GetChild("Number_01_Txt")
    eachItem.Loader = (eachItem.root):GetChild("Number_01_Loader")
    eachItem.SmashBtn = (eachItem.root):GetChild("SweepBtn")
    -- DECOMPILER ERROR at PC50: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (eachItem.SmashBtn).text = (PUtil.get)(60000448)
    ;
    (table.insert)(_rivalList, eachItem)
  end
  _polygonClickChecker = GameObject("PolygonClickChecker")
  _polygonClickChecker:AddComponent(typeof(CS.PolygonClickChecker))
end

ArenaWindow.PlayFlagAnim = function(flag, ...)
  -- function num : 0_4 , upvalues : _ENV
  if flag then
    (SkeletonAnimationUtil.SetAnimation)(flag, 0, "in", false, function(...)
    -- function num : 0_4_0 , upvalues : flag, _ENV
    if flag then
      (SkeletonAnimationUtil.SetAnimation)(flag, 0, "idle", true)
    end
  end
)
  end
end

ArenaWindow.InitButtonEvent = function(...)
  -- function num : 0_5 , upvalues : uis, ArenaWindow
  (((uis.ChallengeListGrp).RefreshBtn).onClick):Add(ArenaWindow.ClickRefreshBtn)
  ;
  ((uis.BuyBtn).onClick):Add(ArenaWindow.ClickPurchaseBtn)
  ;
  ((uis.RecordBtn).onClick):Add(ArenaWindow.ClickRecordBtn)
  ;
  ((uis.DefenseFormationBtn).onClick):Add(ArenaWindow.ClickSetFormationBtn)
  ;
  ((uis.RewardBtn).onClick):Add(ArenaWindow.ClickRewardBtn)
  ;
  (((uis.MySelfGrp).RankingBtn).onClick):Add(ArenaWindow.ClickRankBtn)
  ;
  ((uis.BattleBtn).onClick):Add(ArenaWindow.ClickFightBtn)
  ;
  ((uis.SkipBtn).onClick):Add(ArenaWindow.ClickSkipBtn)
  ;
  ((uis.ShopBtn).onClick):Add(ArenaWindow.ClickShopBtn)
end

ArenaWindow.InitUIEffect = function(...)
  -- function num : 0_6 , upvalues : _ENV, uis, contentPane
  local holder = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_SPORTS, false, true)
  holder:SetXY((uis.Decorate_01_Image).x, (uis.Decorate_01_Image).y)
  contentPane:AddChild(holder)
  contentPane:SetChildIndex(holder, contentPane:GetChildIndex(uis.Decorate_01_Image))
end

ArenaWindow.InitText = function(...)
  -- function num : 0_7 , upvalues : uis, _ENV
  (((uis.ChallengeListGrp).RefreshBtn):GetChild("RefreshBtnTxt")).text = (PUtil.get)(60000401)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.BattleBtn).text = (PUtil.get)(60000008)
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.TimeWordTxt).text = (PUtil.get)(60000419)
  ;
  ((uis.BuyBtn):GetChild("SurplusTxt")).text = (PUtil.get)(60000443)
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.MySelfGrp).BattleTxt).text = (PUtil.get)(60000235)
  -- DECOMPILER ERROR at PC44: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.EnemyGrp).BattleTxt).text = (PUtil.get)(60000235)
  -- DECOMPILER ERROR at PC50: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.SkipTxt).text = (PUtil.get)(60000363)
end

ArenaWindow.InitEvent = function(...)
  -- function num : 0_8
end

ArenaWindow.RemoveEvent = function(...)
  -- function num : 0_9
end

ArenaWindow.OnShown = function(...)
  -- function num : 0_10 , upvalues : _ENV, ArenaWindow
  (LuaSound.PlaySound)(LuaSound.ARENA_MAIN, SoundBank.OTHER)
  ;
  (ArenaWindow.InitEvent)()
  ;
  (ArenaWindow.Init)()
  if ArenaData.NeedShowTips then
    (Util.ShowGuideTips)(GuideTipsCheckPoint.AcquireArenaRank, (ArenaData.BaseData).rank)
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R0 in 'UnsetPending'

    ArenaData.NeedShowTips = false
  end
  ;
  (GuideMgr.PictureTriggerGuide)((WinResConfig.ArenaWindow).name)
end

ArenaWindow.OnHide = function(...)
  -- function num : 0_11
end

ArenaWindow.UnloadCardTexture = function(...)
  -- function num : 0_12 , upvalues : _rivalList, _ENV
  local count = #_rivalList
  local pos = nil
  for i = 1, count do
    local item = _rivalList[i]
    if (item.Loader).texture ~= nil then
      (ResHelper.UnloadTexture)(((item.Loader).texture).nativeTexture)
    end
  end
end

ArenaWindow.Init = function(...)
  -- function num : 0_13 , upvalues : ArenaWindow, _blueFlag, _redFlag, uis, _ENV
  (ArenaWindow.InitSeasonEndTime)()
  ;
  (ArenaWindow.InitSelfInfo)()
  ;
  (ArenaWindow.RefreshSelfRank)()
  ;
  (ArenaWindow.InitChallengeTimes)()
  ;
  (ArenaWindow.RefreshRivalInfo)(true)
  ;
  (ArenaWindow.InitCountDown)()
  ;
  (ArenaWindow.PlayFlagAnim)(_blueFlag)
  ;
  (ArenaWindow.PlayFlagAnim)(_redFlag)
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.SkipBtn).selected = (Util.GetPlayerSetting)(PlayerPrefsKeyName.ARENA_SKIP_FORMATION) == Const.True
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

ArenaWindow.InitCountDown = function(...)
  -- function num : 0_14 , upvalues : _countdown, _ENV, ArenaWindow
  if _countdown ~= nil then
    _countdown:Stop()
  end
  print("日结算时间：" .. (os.date)("%Y/%m/%d/%H:%M:%S", ((ArenaData.BaseData).daySettleTime).bTime * 0.001) .. "至" .. (os.date)("%Y/%m/%d/%H:%M:%S", (((ArenaData.BaseData).daySettleTime).bTime + ((ArenaData.BaseData).daySettleTime).durationTime) * 0.001))
  print("赛季结算时间：" .. (os.date)("%Y/%m/%d/%H:%M:%S", ((ArenaData.BaseData).seasonSettleTime).bTime * 0.001) .. "至" .. (os.date)("%Y/%m/%d/%H:%M:%S", (((ArenaData.BaseData).seasonSettleTime).bTime + ((ArenaData.BaseData).seasonSettleTime).durationTime) * 0.001))
  print("开启时间：" .. (os.date)("%Y/%m/%d/%H:%M:%S", ((ArenaData.BaseData).openTime).bTime * 0.001) .. "至" .. (os.date)("%Y/%m/%d/%H:%M:%S", (((ArenaData.BaseData).openTime).bTime + ((ArenaData.BaseData).openTime).durationTime) * 0.001))
  print("新结算时间：" .. (os.date)("%Y/%m/%d/%H:%M:%S", ((ArenaData.BaseData).settleTime).bTime * 0.001) .. "至" .. (os.date)("%Y/%m/%d/%H:%M:%S", (((ArenaData.BaseData).settleTime).bTime + ((ArenaData.BaseData).settleTime).durationTime) * 0.001))
  if (ArenaData.CheckSettle)() then
    (ArenaWindow.DurationSettle)()
  else
    if (ArenaData.CheckOpen)() == false then
      if (ArenaData.CheckDayPass)() then
        (ArenaService.ReqArenaData)(ArenaRefreshDataType.CountDown)
      else
        ;
        (ArenaWindow.DurationNotOpen)()
      end
    else
      if (ArenaData.CheckCD)() then
        (ArenaWindow.DurationCD)()
      else
        ;
        (ArenaWindow.DurationNormalStatue)()
      end
    end
  end
end

ArenaWindow.DurationSettle = function(...)
  -- function num : 0_15 , upvalues : uis, _ENV, ArenaWindow
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  (uis.BattleBtn).text = (PUtil.get)(60000040)
  ;
  ((uis.BattleBtn).onClick):Clear()
  local settleTime = ((ArenaData.BaseData).settleTime).bTime + ((ArenaData.BaseData).settleTime).durationTime
  local time = settleTime * 0.001
  ;
  (ArenaWindow.CheckStatueTimer)(time)
end

ArenaWindow.DurationNotOpen = function(...)
  -- function num : 0_16 , upvalues : uis, _ENV, ArenaWindow
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  (uis.BattleBtn).text = (PUtil.get)(60000085)
  ;
  ((uis.BattleBtn).onClick):Clear()
  local openTime = ((ArenaData.BaseData).openTime).bTime * 0.001
  ;
  (ArenaWindow.CheckStatueTimer)(openTime)
end

ArenaWindow.DurationCD = function(...)
  -- function num : 0_17 , upvalues : uis, ArenaWindow, _countdown, _ENV
  ((uis.BattleBtn).onClick):Set(ArenaWindow.ClickFightBtn)
  _countdown = (LuaTime.CountDown)((ArenaData.GetCurrentCD)() + 1, (uis.BattleBtn):GetChild("title"), function(...)
    -- function num : 0_17_0 , upvalues : ArenaWindow
    (ArenaWindow.InitCountDown)()
  end
)
end

ArenaWindow.DurationNormalStatue = function(...)
  -- function num : 0_18 , upvalues : uis, ArenaWindow, _ENV
  ((uis.BattleBtn).onClick):Set(ArenaWindow.ClickFightBtn)
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.BattleBtn).text = (PUtil.get)(60000008)
  local endtime = ((ArenaData.BaseData).openTime).bTime + ((ArenaData.BaseData).openTime).durationTime
  local time = ((ArenaData.BaseData).settleTime).bTime
  time = time * 0.001
  ;
  (ArenaWindow.CheckStatueTimer)(time)
end

ArenaWindow.CheckStatueTimer = function(time, ...)
  -- function num : 0_19 , upvalues : _checkStatueTimer, _ENV, ArenaWindow
  if _checkStatueTimer ~= nil then
    _checkStatueTimer:stop()
  end
  local leftTime = time - (LuaTime.GetTimeStamp)() + 1
  if leftTime > 0 then
    _checkStatueTimer = (SimpleTimer.setTimeout)(leftTime, function(...)
    -- function num : 0_19_0 , upvalues : ArenaWindow
    (ArenaWindow.InitCountDown)()
  end
)
  end
end

ArenaWindow.InitSeasonEndTime = function(...)
  -- function num : 0_20 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R0 in 'UnsetPending'

  (uis.TimeEndTxt).text = (os.date)("%Y-%m-%d", (((ArenaData.BaseData).seasonSettleTime).bTime + ((ArenaData.BaseData).seasonSettleTime).durationTime) * 0.001)
end

ArenaWindow.InitSelfInfo = function(...)
  -- function num : 0_21 , upvalues : uis, _ENV, ArenaWindow
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.MySelfGrp).NameTxt).text = (ActorData.GetNickName)()
  ;
  (ArenaWindow.InitSelfFc)()
  ;
  (Util.RecycleUIModel)(uis.MySelfLoader)
  ;
  (Util.CreateNo3rdSelfShowModel)(uis.MySelfLoader)
end

ArenaWindow.InitSelfFc = function(...)
  -- function num : 0_22 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.MySelfGrp).BattleNumberTxt).text = (Util.GetFCByFomation)((ArenaData.BaseData).arenaCardGroups)
end

ArenaWindow.InitChallengeTimes = function(...)
  -- function num : 0_23 , upvalues : _ENV, uis
  if (ArenaData.BaseData).surNum <= 0 then
    ((uis.BuyBtn):GetChild("NumberTxt")).text = "[color=" .. Const.RedColor .. "]" .. tostring((ArenaData.BaseData).surNum) .. "[/color]"
  else
    ;
    ((uis.BuyBtn):GetChild("NumberTxt")).text = "[color=" .. Const.GreenColor .. "]" .. tostring((ArenaData.BaseData).surNum) .. "[/color]"
  end
end

ArenaWindow.RefreshSelfRank = function(...)
  -- function num : 0_24 , upvalues : _ENV, uis
  (ArenaMgr.SetRank)((ArenaData.BaseData).rank, uis.MySelfGrp)
end

ArenaWindow.RefreshRivalInfo = function(firstTime, ...)
  -- function num : 0_25 , upvalues : ArenaWindow, DEFAULT_CHOOSE_INDEX
  (ArenaWindow.InitRivalInfo)()
  ;
  (ArenaWindow.ChoseRival)(DEFAULT_CHOOSE_INDEX, firstTime)
end

ArenaWindow.InitRivalInfo = function(...)
  -- function num : 0_26 , upvalues : _ENV, _rivalList, ArenaWindow
  if (ArenaData.BaseData).arenRival == nil then
    return 
  end
  local count = #_rivalList
  local config, pos = nil, nil
  for i = 1, count do
    local index = i
    do
      local item = _rivalList[i]
      local data = ((ArenaData.BaseData).arenRival)[i]
      -- DECOMPILER ERROR at PC23: Confused about usage of register: R10 in 'UnsetPending'

      ;
      (item.Text).text = "No." .. data.rank
      config = ((TableData.gTable).BaseFashionData)[data.fashionShow]
      -- DECOMPILER ERROR at PC34: Confused about usage of register: R10 in 'UnsetPending'

      ;
      (item.Loader).url = (Util.GetItemUrl)(config.head_icon_battle)
      ;
      ((item.root).onClick):Set(function(...)
    -- function num : 0_26_0 , upvalues : ArenaWindow, index
    (ArenaWindow.ChoseRival)(index)
  end
)
      ;
      ((item.SmashBtn).onClick):Set(ArenaWindow.ClickSmashBtn)
    end
  end
end

ArenaWindow.ChoseRival = function(index, firstTime, ...)
  -- function num : 0_27 , upvalues : _lastSelectedItem, _rivalList, _needrefresh, _ENV, _changeAnim, ArenaWindow
  if _lastSelectedItem ~= nil and _lastSelectedItem.uid == ((_rivalList[index]).root).uid and _needrefresh == false then
    return 
  end
  local tipsIn, tipsOut = nil, nil
  if _lastSelectedItem ~= nil then
    tipsIn = _lastSelectedItem:GetTransition("TipsOut")
    if tipsIn.playing then
      tipsIn:Stop()
    end
    ;
    (_lastSelectedItem:GetTransition("TipsOut")):Play()
    ;
    (_lastSelectedItem:GetController("c1")).selectedIndex = 0
  end
  _lastSelectedItem = (_rivalList[index]).root
  if (ArenaData.BaseData).rank ~= 0 and (ArenaData.BaseData).rank < (((ArenaData.BaseData).arenRival)[index]).rank then
    (_lastSelectedItem:GetController("c1")).selectedIndex = 1
  end
  tipsOut = _lastSelectedItem:GetTransition("TipsOut")
  if tipsOut.playing then
    tipsOut:Stop()
  end
  ;
  (_lastSelectedItem:GetTransition("TipsIn")):Play()
  -- DECOMPILER ERROR at PC82: Confused about usage of register: R4 in 'UnsetPending'

  ArenaData.CurrentRivalData = ((ArenaData.BaseData).arenRival)[index]
  if not firstTime then
    _changeAnim:Play()
  end
  if firstTime then
    (ArenaWindow.InitCurrentRivalInfo)()
  else
    ;
    (SimpleTimer.setTimeout)(0.17, function(...)
    -- function num : 0_27_0 , upvalues : ArenaWindow
    (ArenaWindow.InitCurrentRivalInfo)()
  end
)
  end
  _needrefresh = false
end

ArenaWindow.PlayChoseAnim = function(index, chose, ...)
  -- function num : 0_28 , upvalues : _ENV, _currentChosed, _refreshing, _rivalList, _originPosY, _originOutlinePosY, _selectedOutLinePosY, _chosedPosY, _chosedOutlinePosY, _chosedSelectedOutlinePosY, _changeAnim, ArenaWindow
  if (ArenaData.BaseData).arenRival == nil then
    return 
  end
  if _currentChosed == index then
    return 
  end
  if (_currentChosed == 0 or _currentChosed ~= index) and _refreshing == false then
    do
      if _currentChosed ~= 0 then
        local lastChosed = _currentChosed
        do
          (LeanTween.moveY)(((((_rivalList[lastChosed]).Loader).displayObject).cachedTransform).gameObject, _originPosY, 0.2)
          ;
          (LeanTween.moveY)(((((_rivalList[lastChosed]).Bg).displayObject).cachedTransform).gameObject, _originPosY, 0.2)
          ;
          (LeanTween.moveY)(((((_rivalList[lastChosed]).Image).displayObject).cachedTransform).gameObject, _originOutlinePosY, 0.2)
          ;
          (LeanTween.moveY)(((((_rivalList[lastChosed]).Selected).displayObject).cachedTransform).gameObject, _selectedOutLinePosY, 0.2)
          ;
          (((LeanTween.value)(1, 0, 0.2)):setOnUpdate(function(x, ...)
    -- function num : 0_28_0 , upvalues : _rivalList, lastChosed
    -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

    ((_rivalList[lastChosed]).Selected).alpha = x
  end
)):setOnComplete(function(...)
    -- function num : 0_28_1 , upvalues : _rivalList, lastChosed
    -- DECOMPILER ERROR at PC3: Confused about usage of register: R0 in 'UnsetPending'

    ((_rivalList[lastChosed]).Selected).visible = false
  end
)
        end
      end
      _currentChosed = index
      ;
      (LeanTween.moveY)(((((_rivalList[_currentChosed]).Loader).displayObject).cachedTransform).gameObject, _chosedPosY, 0.2)
      ;
      (LeanTween.moveY)(((((_rivalList[_currentChosed]).Bg).displayObject).cachedTransform).gameObject, _chosedPosY, 0.2)
      ;
      (LeanTween.moveY)(((((_rivalList[_currentChosed]).Image).displayObject).cachedTransform).gameObject, _chosedOutlinePosY, 0.2)
      ;
      (LeanTween.moveY)(((((_rivalList[_currentChosed]).Selected).displayObject).cachedTransform).gameObject, _chosedSelectedOutlinePosY, 0.2)
      -- DECOMPILER ERROR at PC124: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((_rivalList[_currentChosed]).Selected).visible = true
      ;
      ((LeanTween.value)(0, 1, 0.2)):setOnUpdate(function(x, ...)
    -- function num : 0_28_2 , upvalues : _rivalList, _currentChosed
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

    if _rivalList[_currentChosed] ~= nil then
      ((_rivalList[_currentChosed]).Selected).alpha = x
    end
  end
)
      if chose then
        _changeAnim:Play()
        ;
        (ArenaWindow.ChoseRival)(index)
      end
    end
  end
end

ArenaWindow.InitCurrentRivalInfo = function(...)
  -- function num : 0_29 , upvalues : uis, _ENV, FxManager
  if (uis.EnemyLoader).CurrentResType ~= ((FairyGUI.GLoader).ResType).Texture then
    (Util.RecycleUIModel)(uis.EnemyLoader)
  end
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.EnemyGrp).NameTxt).text = (ArenaData.CurrentRivalData).name
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.EnemyGrp).BattleNumberTxt).text = (ArenaData.GetFC)(ArenaData.CurrentRivalData)
  ;
  (ArenaMgr.SetRank)((ArenaData.CurrentRivalData).rank, uis.EnemyGrp)
  local obj = (Util.CreateShowModel)((ActorMgr.GetCanShowFashion)((ArenaData.CurrentRivalData).fashionShow), uis.EnemyLoader)
  FxManager:SetShutterEffect(obj, (uis.EnemyLoader).image)
end

ArenaWindow.OnClose = function(...)
  -- function num : 0_30 , upvalues : _ENV, _polygonClickChecker, ArenaWindow, uis, _countdown, _checkStatueTimer, _currentChosed, contentPane, _rivalList, _lastSelectedItem
  (GameObject.Destroy)(_polygonClickChecker)
  ;
  (ArenaWindow.RemoveEvent)()
  ;
  (CommonWinMgr.RemoveAssets)((WinResConfig.ArenaWindow).name)
  ;
  (GuideData.AbolishControlRefer)((WinResConfig.ArenaWindow).name)
  ;
  (Util.RecycleUIModel)(uis.MySelfLoader)
  ;
  (Util.RecycleUIModel)(uis.EnemyLoader, true)
  if _countdown ~= nil then
    _countdown:Stop()
  end
  if _checkStatueTimer ~= nil then
    _checkStatueTimer:stop()
  end
  _currentChosed = 0
  uis = nil
  contentPane = nil
  _rivalList = {}
  _lastSelectedItem = nil
end

ArenaWindow.ClickRefreshBtn = function(...)
  -- function num : 0_31 , upvalues : _refreshing, _needrefresh, _ENV
  if _refreshing then
    return 
  end
  _needrefresh = (ArenaMgr.TryRefreshRival)()
end

ArenaWindow.PlayRefreshAnim = function(...)
  -- function num : 0_32 , upvalues : _ENV, _refreshAnim, _refreshed
  (LuaSound.PlaySound)(LuaSound.ARENA_MAIN, SoundBank.OTHER)
  _refreshAnim:Play(function(...)
    -- function num : 0_32_0 , upvalues : _refreshed
    _refreshed = false
  end
)
  _refreshed = true
end

ArenaWindow.CardMoveAnim = function(component, from, to, moveTo, delay, func, ...)
  -- function num : 0_33 , upvalues : _ENV, REFRESH_MOVE_DURATION
  local go = ((component.displayObject).cachedTransform).gameObject
  ;
  (((((LeanTween.move)(go, moveTo, REFRESH_MOVE_DURATION)):setDelay(delay)):setOnComplete(function(...)
    -- function num : 0_33_0 , upvalues : func
    if func ~= nil then
      func()
    end
  end
)):setOnUpdate(function(...)
    -- function num : 0_33_1 , upvalues : component
    component:InvalidateBatchingState()
  end
)):setEaseInOutQuad()
  ;
  (((LeanTween.value)(go, function(x, ...)
    -- function num : 0_33_2 , upvalues : go, _ENV
    (go:GetComponentInChildren(typeof(CS.VertexModifier))).TopLeftOffset = x
  end
, from.TopLeft, to.TopLeft, REFRESH_MOVE_DURATION)):setDelay(delay)):setEaseInOutQuad()
  ;
  (((LeanTween.value)(go, function(x, ...)
    -- function num : 0_33_3 , upvalues : go, _ENV
    (go:GetComponentInChildren(typeof(CS.VertexModifier))).TopRightOffset = x
  end
, from.TopRight, to.TopRight, REFRESH_MOVE_DURATION)):setDelay(delay)):setEaseInOutQuad()
  ;
  (((LeanTween.value)(go, function(x, ...)
    -- function num : 0_33_4 , upvalues : go, _ENV
    (go:GetComponentInChildren(typeof(CS.VertexModifier))).BottomLeftOffset = x
  end
, from.BottomLeft, to.BottomLeft, REFRESH_MOVE_DURATION)):setDelay(delay)):setEaseInOutQuad()
  ;
  (((LeanTween.value)(go, function(x, ...)
    -- function num : 0_33_5 , upvalues : go, _ENV
    (go:GetComponentInChildren(typeof(CS.VertexModifier))).BottomRightOffset = x
  end
, from.BottomRight, to.BottomRight, REFRESH_MOVE_DURATION)):setDelay(delay)):setEaseInOutQuad()
end

ArenaWindow.ClickPurchaseBtn = function(...)
  -- function num : 0_34 , upvalues : _ENV
  (MessageMgr.OpenBuyTimesWindow)(BuyTimesType.Arena, (ArenaData.BaseData).buyNum, function(times, ...)
    -- function num : 0_34_0 , upvalues : _ENV
    (ArenaService.ReqArenaBuyNum)(times)
  end
, 60000521)
end

ArenaWindow.ClickRecordBtn = function(...)
  -- function num : 0_35 , upvalues : _ENV
  (ArenaService.ReqArenaRecord)()
end

ArenaWindow.ClickSetFormationBtn = function(...)
  -- function num : 0_36 , upvalues : _ENV
  local formationData = {}
  local btnData = {}
  btnData.btnTxt = (PUtil.get)(60000026)
  btnData.fun = ArenaService.ReqArenaGuardCardGroups
  formationData.myselfList = (Util.CovertRemoteFormationToLocal)((ArenaData.BaseData).guardCardGroups)
  formationData.BtnData = btnData
  formationData.formationType = FormationType.Single
  formationData.battleType = (ProtoEnum.E_BATTLE_TYPE).ARENA
  formationData.closeFun = function(formation, ...)
    -- function num : 0_36_0 , upvalues : _ENV
    (ArenaMgr.BeforeCloseFormation)(formation, function(...)
      -- function num : 0_36_0_0 , upvalues : _ENV
      UIMgr:CloseToWindow((WinResConfig.AdventureWindow).name)
    end
)
  end

  formationData.backFun = function(formation, ...)
    -- function num : 0_36_1 , upvalues : _ENV
    (ArenaMgr.BeforeCloseFormation)(formation, function(...)
      -- function num : 0_36_1_0 , upvalues : _ENV
      UIMgr:CloseWindow((WinResConfig.FormationWindow).name)
    end
)
  end

  formationData.isSelfClose = true
  ;
  (MessageMgr.OpenFormationWindow)(formationData)
end

ArenaWindow.ClickRewardBtn = function(...)
  -- function num : 0_37 , upvalues : _ENV
  (ArenaMgr.OpenRewardUI)()
end

ArenaWindow.ClickRankBtn = function(...)
  -- function num : 0_38 , upvalues : _ENV
  (ArenaMgr.TryOpenRankUI)()
end

ArenaWindow.ClickSmashBtn = function(...)
  -- function num : 0_39 , upvalues : _ENV
  if (ArenaMgr.PreChallengeCheck)(ArenaRefreshDataType.Smash) == false then
    return 
  end
  ;
  (ArenaMgr.ReqChallengePlayer)((ArenaData.CurrentRivalData).rank, true, (ArenaData.BaseData).arenaCardGroups)
end

ArenaWindow.ClickSkipBtn = function(...)
  -- function num : 0_40 , upvalues : uis, _ENV
  if (uis.SkipBtn).selected then
    (Util.SetPlayerSetting)(PlayerPrefsKeyName.ARENA_SKIP_FORMATION, Const.True)
  else
    ;
    (Util.SetPlayerSetting)(PlayerPrefsKeyName.ARENA_SKIP_FORMATION, Const.False)
  end
end

ArenaWindow.ClickShopBtn = function(...)
  -- function num : 0_41 , upvalues : _ENV
  ld("Shop", function(...)
    -- function num : 0_41_0 , upvalues : _ENV
    (ShopMgr.ExternalGotoShop)(ShopType.TokenShop)
  end
)
end

ArenaWindow.ClickFightBtn = function(...)
  -- function num : 0_42 , upvalues : _ENV, uis
  if (ArenaMgr.PreChallengeCheck)(ArenaRefreshDataType.Challenge) == false then
    return 
  end
  if (uis.SkipBtn).selected then
    (ArenaMgr.ReqChallengePlayer)((ArenaData.CurrentRivalData).rank, false, (ArenaData.BaseData).arenaCardGroups)
  else
    local formationData = {}
    local btnData = {}
    btnData.btnTxt = (PUtil.get)(20000021)
    btnData.fun = function(formation, ...)
    -- function num : 0_42_0 , upvalues : _ENV
    (ArenaMgr.ReqChallengePlayer)((ArenaData.CurrentRivalData).rank, false, (Util.CovertLoaclFormationToRemote)(formation))
  end

    formationData.myselfList = (Util.CovertRemoteFormationToLocal)((ArenaData.BaseData).arenaCardGroups)
    if (ArenaData.CurrentRivalData).isPlayer then
      formationData.otherPlayerList = (ArenaData.CovertArenaRivalFormationToLocalPlayer)((ArenaData.CurrentRivalData).cardGroups, (ArenaData.CurrentRivalData).fc)
    else
      formationData.FCFactor = (ArenaData.CurrentRivalData).fc
      formationData.enemyList = (ArenaData.CovertArenaRivalFormationToLocal)((ArenaData.CurrentRivalData).cardGroups)
    end
    formationData.BtnData = btnData
    formationData.battleType = (ProtoEnum.E_BATTLE_TYPE).ARENA
    formationData.formationType = FormationType.Basic
    formationData.closeFun = function(formation, ...)
    -- function num : 0_42_1 , upvalues : _ENV
    (ArenaMgr.BeforeCloseFormation)(formation, function(...)
      -- function num : 0_42_1_0 , upvalues : _ENV
      UIMgr:CloseToWindow((WinResConfig.AdventureWindow).name)
    end
, true)
  end

    formationData.backFun = function(formation, ...)
    -- function num : 0_42_2 , upvalues : _ENV
    (ArenaMgr.BeforeCloseFormation)(formation, function(...)
      -- function num : 0_42_2_0 , upvalues : _ENV
      UIMgr:CloseWindow((WinResConfig.FormationWindow).name)
    end
, true)
  end

    formationData.isSelfClose = true
    ;
    (MessageMgr.OpenFormationWindow)(formationData)
  end
end

ArenaWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_43 , upvalues : _ENV, _needrefresh, ArenaWindow
  if msgId == (WindowMsgEnum.Arena).E_MSG_REFRESH_RIVAL then
    _needrefresh = true
    ;
    (ArenaWindow.PlayRefreshAnim)()
    ;
    (ArenaWindow.RefreshSelfRank)()
    ;
    (ArenaWindow.RefreshRivalInfo)(false)
  else
    if msgId == (WindowMsgEnum.Arena).E_MSG_REFRESH_CHALLENGE_TIMES then
      (ArenaWindow.InitChallengeTimes)()
    else
      if msgId == (WindowMsgEnum.Arena).E_MSG_REFRESH_INFO then
        (ArenaWindow.Init)()
      else
        if msgId == (WindowMsgEnum.Arena).E_MSG_REFRESH_SELF_RANK then
          (ArenaWindow.RefreshSelfRank)()
        else
          if msgId == (WindowMsgEnum.Arena).E_MSG_REFRESH_CHALLENGE_CD then
            (ArenaWindow.InitCountDown)()
          else
            if msgId == (WindowMsgEnum.Arena).E_MSG_CHALLENGE then
              (ArenaWindow.ClickFightBtn)()
            else
              if msgId == (WindowMsgEnum.Arena).E_MSG_SMASH then
                (ArenaWindow.ClickSmashBtn)()
              else
                if msgId == (WindowMsgEnum.Arena).E_MSG_REFRESH_FC then
                  (ArenaWindow.InitSelfFc)()
                else
                  if msgId == (WindowMsgEnum.NETBrokenReconnect).E_MSG_RECONNECT_Ok then
                    (ArenaWindow.Init)()
                    ;
                    (ArenaData.CheckCareerRewardRedDot)()
                    ;
                    (ArenaData.CheckDailyRewardRedDot)()
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

return ArenaWindow

