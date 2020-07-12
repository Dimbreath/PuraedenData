-- params : ...
-- function num : 0 , upvalues : _ENV
require("Tower_TowerByName")
local BIG_SIZE = 0.44
local SMALL_SIZE = 0.3
local BIG_NAME_SIZE = 1
local SMALL_NAME_SIZE = 0.8
local HIGH_NAME_POS = 512
local LOW_NAME_POS = 462
local BG_ZOOM_IN_SCALE = 1.25
local BG_MOVE_DOWN_DISTANCE = 80
local BG_HORIZONTAL_MAX = 850
local BG_HORIZONTAL_MIN = 517
local TowerWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local _checkDis, _totalDis, _bgTotalMoveDis, _chosed = nil, nil, nil, nil
local _playingAnim = false
local _bg = {}
local _openFromClose = nil
TowerWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, _openFromClose, uis, TowerWindow
  bridgeObj:SetView((WinResConfig.TowerWindow).package, (WinResConfig.TowerWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  _openFromClose = bridgeObj.OpenFromClose
  contentPane:Center()
  uis = GetTower_TowerUis(contentPane)
  ;
  (TowerWindow.InitTopMenu)()
  ;
  (TowerWindow.InitList)()
  ;
  (TowerWindow.InitVariable)()
  ;
  (TowerWindow.InitText)()
  ;
  (TowerWindow.InitButtonEvent)()
  ;
  (TowerWindow.InitUIEffect)()
  GuideSetDelayShow(contentPane)
end

TowerWindow.InitTopMenu = function(...)
  -- function num : 0_1 , upvalues : _ENV, uis, _playingAnim, _chosed, TowerWindow
  local m = {}
  m.windowName = (WinResConfig.TowerWindow).name
  m.Tip = (PUtil.get)(60000092)
  m.model = uis.AssetStripGrp
  m.closeToWindow = (WinResConfig.AdventureWindow).name
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.SPIRIT}
  m.BackBtnFun = function(...)
    -- function num : 0_1_0 , upvalues : _playingAnim, _chosed, _ENV, uis, TowerWindow
    if _playingAnim then
      return 
    end
    if _chosed == -1 then
      UIMgr:CloseWindow((WinResConfig.TowerWindow).name)
    else
      ;
      (uis.LayerList):TraversalItem(function(index, item, ...)
      -- function num : 0_1_0_0 , upvalues : TowerWindow
      (TowerWindow.PlayingChosingAnim)(index, item, false)
    end
)
    end
  end

  m.CloseBtnFun = function(...)
    -- function num : 0_1_1 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.TowerWindow).name)
  end

  m.isSelfClose = true
  m.activityIds = (Util.GetActivityIds)(76000030)
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

TowerWindow.InitVariable = function(...)
  -- function num : 0_2 , upvalues : _checkDis, uis, _totalDis, _ENV, _bgTotalMoveDis, BG_HORIZONTAL_MIN, BG_HORIZONTAL_MAX, _bg
  _checkDis = ((uis.LayerList).ItemSize).x + (uis.LayerList).columnGap
  _totalDis = _checkDis * (#TowerData.TowerLayerData - 1)
  _bgTotalMoveDis = BG_HORIZONTAL_MIN - BG_HORIZONTAL_MAX + (ResolutionHandler.AdaptOffset).X * 2
  _bg[1] = {Com = (uis.BlackMaskGrp).root, Pos = ((uis.BlackMaskGrp).root).x, OriginY = ((uis.BlackMaskGrp).root).y}
end

TowerWindow.InitText = function(...)
  -- function num : 0_3
end

TowerWindow.InitList = function(...)
  -- function num : 0_4 , upvalues : uis, _ENV, TowerWindow
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R0 in 'UnsetPending'

  (uis.LayerList).columnGap = (uis.LayerList).columnGap - (ResolutionHandler.Width - DesignScreen.width)
  ;
  (uis.LayerList):SetItemSize(Vector2(ResolutionHandler.Width, ResolutionHandler.Height))
  ;
  (uis.LayerList):SetVirtual()
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.LayerList).itemRenderer = TowerWindow.RefreshLayerItem
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.LayerList).itemProvider = TowerWindow.GetLayerItem
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.LayerList).itemScrollHandler = TowerWindow.SetLayerItemSize
end

TowerWindow.InitButtonEvent = function(...)
  -- function num : 0_5 , upvalues : uis, TowerWindow
  ((uis.MonsterBtn).onClick):Add(TowerWindow.ClickMonsterDetailBtn)
  ;
  ((uis.LeftBtn).onClick):Add(TowerWindow.ClickLeftBtn)
  ;
  ((uis.RightBtn).onClick):Add(TowerWindow.ClickRightBtn)
  ;
  (((uis.LayerList).scrollPane).onScrollEnd):Add(TowerWindow.RefreshSwitchLayerBtn)
  ;
  ((uis.BattleBtn).onClick):Add(TowerWindow.ClickBounsBtn)
end

TowerWindow.InitFunctionControl = function(...)
  -- function num : 0_6 , upvalues : _ENV, uis
  local winName = (WinResConfig.TowerWindow).name
  local RegisterGuideAndControl = GuideData.RegisterGuideAndControl
  local ControlID = ControlID
  RegisterGuideAndControl(ControlID.Tower_OneChapter, (uis.LayerList):GetChildAt(0), winName)
  RegisterGuideAndControl(ControlID.Tower_OneOne, ((uis.LayerList):GetChildAt(0)):GetChild("Battle_01"), winName)
end

TowerWindow.InitUIEffect = function(...)
  -- function num : 0_7 , upvalues : _ENV, BG_HORIZONTAL_MAX, contentPane, _bg, uis
  local addEffect = function(name, layer, middle, ...)
    -- function num : 0_7_0 , upvalues : _ENV, BG_HORIZONTAL_MAX, contentPane, _bg
    local holder = (LuaEffect.AddUIEffect)(name, false, true)
    if middle then
      holder:SetXY(DesignScreen.width * 0.5 + (ResolutionHandler.AdaptOffset).X, DesignScreen.height * 0.5 + (ResolutionHandler.AdaptOffset).Y)
    else
      holder:SetXY(BG_HORIZONTAL_MAX, DesignScreen.height * 0.5 + (ResolutionHandler.AdaptOffset).Y)
    end
    contentPane:AddChild(holder)
    contentPane:SetChildIndex(holder, layer)
    ;
    (table.insert)(_bg, {Com = holder, Pos = holder.x, OriginY = holder.y})
  end

  addEffect(UIEffectEnum.UI_SKYTOWER_BACK, contentPane:GetChildIndex(uis.BackgroundEffectLoader), true)
  addEffect(UIEffectEnum.UI_SKYTOWER_CLOUD3, contentPane:GetChildIndex(uis.BackgroundEffectLoader), true)
  addEffect(UIEffectEnum.UI_SKYTOWER_CLOUD1, contentPane:GetChildIndex((uis.AssetStripGrp).root))
  addEffect(UIEffectEnum.UI_SKYTOWER_CLOUD2, contentPane:GetChildIndex((uis.AssetStripGrp).root))
end

TowerWindow.InitEvent = function(...)
  -- function num : 0_8
end

TowerWindow.RemoveEvent = function(...)
  -- function num : 0_9
end

TowerWindow.OnShown = function(...)
  -- function num : 0_10 , upvalues : TowerWindow
  (TowerWindow.InitEvent)()
  ;
  (TowerWindow.Init)()
  ;
  (TowerWindow.InitFunctionControl)()
end

TowerWindow.OnHide = function(...)
  -- function num : 0_11 , upvalues : TowerWindow
  (TowerWindow.RemoveEvent)()
end

TowerWindow.Init = function(...)
  -- function num : 0_12 , upvalues : _ENV, _openFromClose, _chosed, uis, TowerWindow
  (LuaSound.LoadAndPlayBGM)(1040011)
  if _openFromClose == false then
    _chosed = -1
  end
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R0 in 'UnsetPending'

  if TowerData.PopUpBounsLevel then
    TowerData.PopUpBounsLevel = false
    ;
    (TowerMgr.OpenBounsLevel)()
  end
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.LayerList).scrollPane).touchEffect = not (GuideMgr.IsInMainGuide)()
  ;
  (LuaSound.PlaySound)(LuaSound.COMMON_SLIDE_2, SoundBank.OTHER)
  ;
  (TowerWindow.RefreshBounsBtn)()
  ;
  (TowerWindow.RefreshLayer)()
end

TowerWindow.RefreshLayer = function(...)
  -- function num : 0_13 , upvalues : uis, _ENV, _openFromClose, _chosed, TowerWindow
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

  (uis.LayerList).numItems = #TowerData.TowerLayerData
  ;
  (uis.LayerList):SpecifyScrollPos(0.5, 0.5)
  ;
  (uis.LayerList):ScrollToView((TowerData.TowerLayerNumber)[TowerData.CurrentLayer] - 1, false)
  if _openFromClose and _chosed ~= -1 then
    if _chosed ~= (TowerData.TowerLayerNumber)[TowerData.CurrentLayer] - 1 then
      _chosed = (TowerData.TowerLayerNumber)[TowerData.CurrentLayer] - 1
    end
    ;
    (TowerWindow.SetChosedItem)()
    ;
    (TowerWindow.RefreshSwitchLayerBtn)()
  else
    ;
    (TowerWindow.RefreshSwitchLayerBtn)()
  end
end

TowerWindow.RefreshBounsBtn = function(...)
  -- function num : 0_14 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R0 in 'UnsetPending'

  (uis.BattleBtn).visible = TowerData.HaveBounsLevel
end

TowerWindow.RefreshSwitchLayerBtn = function(...)
  -- function num : 0_15 , upvalues : _ENV, uis
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R0 in 'UnsetPending'

  TowerData.CurrentLayer = (TowerData.TowerLayerData)[((uis.LayerList).scrollPane).SpecifyIndex + 1]
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.LeftBtn).visible = (TowerData.TowerLayerNumber)[TowerData.CurrentLayer] ~= 1
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.RightBtn).visible = (TowerData.TowerLayerNumber)[TowerData.CurrentLayer] ~= #TowerData.TowerLayerData
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

TowerWindow.OnClose = function(...)
  -- function num : 0_16 , upvalues : _ENV, uis, contentPane, argTable, _bg
  (CommonWinMgr.RemoveAssets)((WinResConfig.TowerWindow).name)
  ;
  (GuideData.AbolishControlRefer)((WinResConfig.TowerWindow).name)
  uis = nil
  contentPane = nil
  argTable = {}
  _bg = {}
end

TowerWindow.SetLayerItemSize = function(list, ...)
  -- function num : 0_17 , upvalues : uis, _chosed, _ENV, _checkDis, BIG_SIZE, SMALL_SIZE, HIGH_NAME_POS, LOW_NAME_POS, BIG_NAME_SIZE, SMALL_NAME_SIZE, _bg, _totalDis, _bgTotalMoveDis
  (uis.LayerList):TraversalItem(function(subIndex, subItem, ...)
    -- function num : 0_17_0 , upvalues : _chosed, uis, _ENV, _checkDis, BIG_SIZE, SMALL_SIZE, HIGH_NAME_POS, LOW_NAME_POS, BIG_NAME_SIZE, SMALL_NAME_SIZE
    if subIndex == _chosed then
      return 
    end
    local pos = ((uis.LayerList).scrollPane).scrollingPosX - subItem.x
    local percent = (math.abs)(pos) / _checkDis
    ;
    (subItem:GetChild("Layer")).scale = Vector2.one * (Umath.Lerp)(BIG_SIZE, SMALL_SIZE, percent)
    local layerNumber = subItem:GetChild("LayerNumber")
    local posY = (Umath.Lerp)(HIGH_NAME_POS, LOW_NAME_POS, percent)
    if (math.abs)(HIGH_NAME_POS - posY) < 0.5 then
      posY = HIGH_NAME_POS
    end
    layerNumber.y = posY
    layerNumber.scale = Vector2.one * (Umath.Lerp)(BIG_NAME_SIZE, SMALL_NAME_SIZE, percent)
  end
)
  local count = #_bg
  for i = 1, count do
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R6 in 'UnsetPending'

    ((_bg[i]).Com).x = (_bg[i]).Pos + (math.abs)(((uis.LayerList).scrollPane).scrollingPosX) / _totalDis * _bgTotalMoveDis
  end
  local show = ((uis.LayerList).scrollPane).SpecifyIndex + 1 <= TowerData.UnlockLayer
  -- DECOMPILER ERROR at PC42: Confused about usage of register: R3 in 'UnsetPending'

  if (uis.MonsterBtn).visible ~= show then
    (uis.MonsterBtn).visible = show
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

TowerWindow.GetLayerItem = function(index, ...)
  -- function num : 0_18 , upvalues : _ENV
  local config = ((TableData.gTable).BaseTowerData)[(TowerData.TowerLayerData)[index + 1]]
  return (Util.GetItemUrl)(config.tower_icon)
end

TowerWindow.RefreshLayerItem = function(index, item, ...)
  -- function num : 0_19 , upvalues : _ENV, uis, _chosed, TowerWindow
  (item.onClick):Clear()
  local layer = item:GetChild("Layer")
  local layerTitle = item:GetChild("LayerNumber")
  if TowerData.UnlockLayer < index + 1 then
    (item:GetController("c2")).selectedIndex = 1
    ;
    (layer:GetController("c1")).selectedIndex = 1
    ;
    (layerTitle:GetController("c1")).selectedIndex = 1
    ;
    (item.onClick):Set(function(...)
    -- function num : 0_19_0 , upvalues : _ENV, index
    (TowerMgr.CheckTowerLayerLockReason)(index + 1)
  end
)
  else
    ;
    (item:GetController("c2")).selectedIndex = 0
    ;
    (layer:GetController("c1")).selectedIndex = 0
    ;
    (layerTitle:GetController("c1")).selectedIndex = 0
    local config = ((TableData.gTable).BaseTowerData)[(TowerData.TowerLayerData)[index + 1]]
    ;
    (layerTitle:GetChild("NameLoader")).url = (Util.GetItemUrl)(config.name_icon)
    ;
    (item.onClick):Set(function(...)
    -- function num : 0_19_1 , upvalues : uis, index, _chosed, TowerWindow
    if ((uis.LayerList).scrollPane).SpecifyIndex ~= index then
      (uis.LayerList):ScrollToView(index, true)
    else
      if _chosed == -1 then
        _chosed = index
        ;
        (TowerWindow.SetChosedItem)(true)
      end
    end
  end
)
  end
end

TowerWindow.SetChosedItem = function(anim, ...)
  -- function num : 0_20 , upvalues : uis, TowerWindow
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  ((uis.LayerList).scrollPane).touchEffect = false
  ;
  (uis.LayerList):TraversalItem(function(subIndex, subItem, ...)
    -- function num : 0_20_0 , upvalues : anim, TowerWindow
    if anim then
      (TowerWindow.PlayingChosingAnim)(subIndex, subItem, true)
    else
      ;
      (TowerWindow.ChosingImmediately)(subIndex, subItem, true)
    end
  end
)
end

TowerWindow.PlayingChosingAnim = function(index, item, chose, ...)
  -- function num : 0_21 , upvalues : _chosed, _playingAnim, _ENV, TowerWindow, uis, _bg, BG_ZOOM_IN_SCALE, BG_MOVE_DOWN_DISTANCE, BIG_SIZE, SMALL_SIZE
  if chose then
    if index == _chosed then
      _playingAnim = true
      ;
      (item:GetTransition("LayerNumberOut")):Play(function(...)
    -- function num : 0_21_0 , upvalues : _playingAnim
    _playingAnim = false
  end
)
      ;
      (item:GetController("c1")).selectedIndex = 1
      local layer = item:GetChild("Layer")
      do
        ((layer:TweenScale(Vector2.one, 0.5)):SetEase((FairyGUI.EaseType).QuadOut)):OnUpdate(function(...)
    -- function num : 0_21_1 , upvalues : layer
    layer:InvalidateBatchingState()
  end
)
        ;
        (item:GetTransition("BattleIn")):Play()
        ;
        (TowerWindow.RefreshLayerDetail)(index, item)
      end
    else
      do
        ;
        (item:TweenFade(0, 0.33)):OnComplete(function(...)
    -- function num : 0_21_2 , upvalues : item
    item.visible = false
  end
)
        ;
        (uis.LeftBtn):TweenFade(0, 0.33)
        ;
        (uis.RightBtn):TweenFade(0, 0.33)
        local count = #_bg
        for i = 1, count do
          (((_bg[i]).Com):TweenScale(Vector2.one * BG_ZOOM_IN_SCALE, 0.5)):SetEase((FairyGUI.EaseType).QuadOut)
          ;
          (((_bg[i]).Com):TweenMoveY(((_bg[i]).Com).y + BG_MOVE_DOWN_DISTANCE, 0.5)):SetEase((FairyGUI.EaseType).QuadOut)
        end
        do
          if index == _chosed then
            _playingAnim = true
            ;
            (item:GetTransition("LayerNumberIn")):Play(function(...)
    -- function num : 0_21_3 , upvalues : _playingAnim, _chosed, uis
    _playingAnim = false
    _chosed = -1
    -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((uis.LayerList).scrollPane).touchEffect = true
  end
)
            ;
            (item:GetController("c1")).selectedIndex = 0
            local layer = item:GetChild("Layer")
            ;
            ((layer:TweenScale(Vector2.one * BIG_SIZE, 0.5)):SetEase((FairyGUI.EaseType).QuadOut)):OnUpdate(function(...)
    -- function num : 0_21_4 , upvalues : layer
    layer:InvalidateBatchingState()
  end
)
            ;
            (item:GetTransition("BattleOut")):Play()
          else
            do
              ;
              (item:GetChild("Layer")).scale = Vector2.one * SMALL_SIZE
              item.visible = true
              item:TweenFade(1, 0.25)
              ;
              (uis.LeftBtn):TweenFade(1, 0.25)
              ;
              (uis.RightBtn):TweenFade(1, 0.25)
              local count = #_bg
              for i = 1, count do
                (((_bg[i]).Com):TweenScale(Vector2.one, 0.5)):SetEase((FairyGUI.EaseType).QuadOut)
                ;
                (((_bg[i]).Com):TweenMoveY(((_bg[i]).Com).y - BG_MOVE_DOWN_DISTANCE, 0.5)):SetEase((FairyGUI.EaseType).QuadOut)
              end
            end
          end
        end
      end
    end
  end
end

TowerWindow.ChosingImmediately = function(index, item, chose, ...)
  -- function num : 0_22 , upvalues : _chosed, _ENV, TowerWindow, uis, _bg, BG_ZOOM_IN_SCALE, BG_MOVE_DOWN_DISTANCE, BIG_SIZE
  local setChild = function(name, alpha, ...)
    -- function num : 0_22_0 , upvalues : item
    (item:GetChild(name)).alpha = alpha
  end

  if chose then
    if index == _chosed then
      (item:GetController("c1")).selectedIndex = 1
      ;
      (item:GetChild("Layer")).scale = Vector2.one
      ;
      (item:GetChild("LayerNumber")).alpha = 0
      setChild("1", 1)
      setChild("2", 1)
      setChild("3", 1)
      setChild("4", 1)
      ;
      (TowerWindow.RefreshLayerDetail)(index, item)
    else
      item.alpha = 0
      item.visible = false
    end
    -- DECOMPILER ERROR at PC44: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (uis.LeftBtn).alpha = 0
    -- DECOMPILER ERROR at PC46: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (uis.RightBtn).alpha = 0
    local count = #_bg
    for i = 1, count do
      -- DECOMPILER ERROR at PC59: Confused about usage of register: R9 in 'UnsetPending'

      ((_bg[i]).Com).scale = Vector2.one * BG_ZOOM_IN_SCALE
      -- DECOMPILER ERROR at PC66: Confused about usage of register: R9 in 'UnsetPending'

      ;
      ((_bg[i]).Com).y = (_bg[i]).OriginY + BG_MOVE_DOWN_DISTANCE
    end
  else
    do
      if index == _chosed then
        (item:GetController("c1")).selectedIndex = 0
        ;
        (item:GetChild("LayerNumber")).alpha = 1
        setChild("1", 0)
        setChild("2", 0)
        setChild("3", 0)
        setChild("4", 0)
        ;
        (item:GetChild("Layer")).scale = Vector2.one * BIG_SIZE
      else
        item.visible = true
        item.alpha = 1
      end
      -- DECOMPILER ERROR at PC108: Confused about usage of register: R4 in 'UnsetPending'

      ;
      (uis.LeftBtn).aplha = 1
      -- DECOMPILER ERROR at PC110: Confused about usage of register: R4 in 'UnsetPending'

      ;
      (uis.RightBtn).aplha = 1
      local count = #_bg
      for i = 1, count do
        -- DECOMPILER ERROR at PC121: Confused about usage of register: R9 in 'UnsetPending'

        ((_bg[i]).Com).scale = Vector2.one
        -- DECOMPILER ERROR at PC128: Confused about usage of register: R9 in 'UnsetPending'

        ;
        ((_bg[i]).Com).y = (_bg[i]).OriginY - BG_MOVE_DOWN_DISTANCE
      end
    end
  end
end

TowerWindow.RefreshLayerDetail = function(index, item, ...)
  -- function num : 0_23 , upvalues : _ENV, TowerWindow
  index = index + 1
  local count = #(TowerData.TowerStageData)[TowerData.CurrentLayer]
  for i = 1, count do
    (TowerWindow.RefreshStageItem)(i, item:GetChild("Battle_0" .. tostring(i)), item:GetChild("Line_0" .. tostring(i)))
  end
end

TowerWindow.RefreshStageItem = function(index, item, line, ...)
  -- function num : 0_24 , upvalues : _ENV
  local config = ((TableData.gTable).BaseTowerStageData)[((TowerData.TowerStageData)[TowerData.CurrentLayer])[index]]
  local data = ((TowerData.BaseInfo)[TowerData.CurrentLayer])[config.id]
  ;
  (item.onClick):Clear()
  ;
  (item:GetChild("BattleNumberTxt")).text = tostring((TowerData.TowerLayerNumber)[TowerData.CurrentLayer]) .. "-" .. tostring(index)
  local tipsInfo = split(config.stage_icon, ",")
  local tipList = item:GetChild("EquiptIconList")
  tipList:SetVirtual()
  tipList.itemRenderer = function(subIndex, subItem, ...)
    -- function num : 0_24_0 , upvalues : _ENV, tipsInfo
    (subItem:GetChild("n0")).url = (Util.GetItemUrl)(tipsInfo[subIndex + 1])
  end

  tipList.numItems = #tipsInfo
  if data ~= nil and index <= (TowerData.UnlockStage)[TowerData.CurrentLayer] then
    if data.isPass then
      (item:GetController("c1")).selectedIndex = 0
      ;
      (line:GetController("c1")).selectedIndex = 0
    else
      ;
      (item:GetController("c1")).selectedIndex = 1
      ;
      (line:GetController("c1")).selectedIndex = 1
    end
    ;
    (item.onClick):Set(function(...)
    -- function num : 0_24_1 , upvalues : _ENV, config
    (LuaSound.PlaySound)(LuaSound.COMMON_POP_WIN, SoundBank.OTHER)
    OpenWindow((WinResConfig.TowerChallengeWindow).name, UILayer.HUD, config.id)
  end
)
  else
    ;
    (item:GetController("c1")).selectedIndex = 2
    ;
    (line:GetController("c1")).selectedIndex = 2
    ;
    (item.onClick):Set(function(...)
    -- function num : 0_24_2 , upvalues : _ENV
    (MessageMgr.SendCenterTips)((PUtil.get)(60000091))
  end
)
  end
end

TowerWindow.ClickSkipBtn = function(...)
  -- function num : 0_25 , upvalues : uis, _ENV
  if (uis.ChoiceBtn).selected then
    (Util.SetPlayerSetting)(PlayerPrefsKeyName.TOWER_SKIP_FORMATION, Const.True)
  else
    ;
    (Util.SetPlayerSetting)(PlayerPrefsKeyName.TOWER_SKIP_FORMATION, Const.False)
  end
end

TowerWindow.ClickMonsterDetailBtn = function(...)
  -- function num : 0_26 , upvalues : _ENV
  (TowerMgr.OpenTowerMonsterDetailWindow)()
end

TowerWindow.ClickLeftBtn = function(...)
  -- function num : 0_27 , upvalues : _playingAnim, _chosed, _ENV, uis
  if _playingAnim or _chosed ~= -1 then
    return 
  end
  loge("index:" .. (TowerData.TowerLayerNumber)[TowerData.CurrentLayer] - 2)
  ;
  (uis.LayerList):ScrollToView((TowerData.TowerLayerNumber)[TowerData.CurrentLayer] - 2, true)
end

TowerWindow.ClickRightBtn = function(...)
  -- function num : 0_28 , upvalues : _playingAnim, _chosed, _ENV, uis
  if _playingAnim or _chosed ~= -1 then
    return 
  end
  loge("index:" .. (TowerData.TowerLayerNumber)[TowerData.CurrentLayer])
  ;
  (uis.LayerList):ScrollToView((TowerData.TowerLayerNumber)[TowerData.CurrentLayer], true)
end

TowerWindow.ClickBounsBtn = function(...)
  -- function num : 0_29 , upvalues : _ENV
  (TowerMgr.OpenBounsLevel)()
end

TowerWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_30 , upvalues : _ENV, TowerWindow
  if msgId == (WindowMsgEnum.Tower).E_MSG_REFRESH_BOUNS_STATUS then
    (TowerWindow.RefreshBounsBtn)()
  end
end

return TowerWindow

