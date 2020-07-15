-- params : ...
-- function num : 0 , upvalues : _ENV
require("AdventureGame_AdventureGameByName")
local LayerChangeType = {None = 0, Finish = 1, Middle = 2}
local AdventureGameWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local LAYER_OFFSET = 2
local DICE_MODEL = "maoxian_touzi"
local REMOTE_DICE_MODEL = "maoxian_touzi_lanse"
local _nodes = {}
local _map, _swipe, _role = nil, nil, nil
local _roleOffset = {x = 0, y = 0}
local _mapYOffset = 45
local _markerYOffset = 20
local MOVE_TO_NEXT_BLOCK_COST_TIME = 0.4
local DRAG_MAP_STOP_DURATION = 0.2
local MAP_TWEEN_SPEED = 2000
local MAP_EXTRA_DISTANCE = 0
local _themeCardDes = {}
local _mapLimit, _forkNodes = nil, nil
local _currentDragStatue = true
local _shadow, _shadowOffset, _dice, _remoteDice, _currentMapPkg = nil, nil, nil, nil, nil
local _obstacles = {}
local _lastObstacle, _mapNameAnim, _startEffect, _finishEffect = nil, nil, nil, nil
AdventureGameWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, AdventureGameWindow
  bridgeObj:SetView((WinResConfig.AdventureGameWindow).package, (WinResConfig.AdventureGameWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetAdventureGame_AdventureGameUis(contentPane)
  ;
  (AdventureGameWindow.InitTopMenu)()
  ;
  (AdventureGameWindow.InitVariable)()
  ;
  (AdventureGameWindow.InitText)()
  ;
  (AdventureGameWindow.InitButtonEvent)()
  ;
  (AdventureGameWindow.BindingUI)()
  ;
  (AdventureGameWindow.InitFunctionControl)()
  ;
  (LeanTween.delayedCall)(0.6, function(...)
    -- function num : 0_0_0 , upvalues : _ENV
    local bg_path = (AdventureData.GetBattleBg)()
    ;
    (BattleResource.PreLoadByPath)(bg_path)
  end
)
  GuideSetDelayShow(contentPane)
end

AdventureGameWindow.InitFunctionControl = function(...)
  -- function num : 0_1 , upvalues : _ENV, uis
  local winName = (WinResConfig.AdventureGameWindow).name
  local RegisterGuideAndControl = GuideData.RegisterGuideAndControl
  local ControlID = ControlID
  RegisterGuideAndControl(ControlID.BigAdventure_PlayOne, uis.OnceBtn, winName)
end

AdventureGameWindow.BindingUI = function(...)
  -- function num : 0_2 , upvalues : _ENV, uis
  local winName = (WinResConfig.AdventureGameWindow).name
  local BindingUI = RedDotMgr.BindingUI
  local RedDotComID = RedDotComID
  BindingUI(winName, RedDotComID.BigAdventure_Wish, uis.VowBtn)
  BindingUI(winName, RedDotComID.BigAdventure_TarotCard, uis.TaroBtn)
  BindingUI(winName, RedDotComID.BigAdventure_InvestMgr, uis.BuildingBtn)
  BindingUI(winName, RedDotComID.BigAdventure_RiskER, uis.ThemeCardBtn)
  ;
  (RedDotMgr.RefreshTreeUI)(winName)
end

AdventureGameWindow.InitTopMenu = function(...)
  -- function num : 0_3 , upvalues : _ENV, uis
  local m = {}
  m.windowName = (WinResConfig.AdventureGameWindow).name
  m.Tip = (PUtil.get)(60000093)
  m.model = uis.AssetStripGrp
  m.closeToWindow = (WinResConfig.AdventureWindow).name
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.ENDURANCE}
  m.CloseBtnFun = function(...)
    -- function num : 0_3_0 , upvalues : _ENV
    (RedDotMgr.EliminateRedDot)((WinResConfig.AdventureGameWindow).name, RedDotComID.BigAdventure_RiskER)
  end

  m.BackBtnFun = m.CloseBtnFun
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

AdventureGameWindow.InitVariable = function(...)
  -- function num : 0_4 , upvalues : _mapNameAnim, uis, _shadow, _shadowOffset, _themeCardDes, AdventureGameWindow, _roleOffset
  _mapNameAnim = ((uis.SceneCutMove).root):GetTransition("move")
  _shadow = (uis.root):GetChild("ShadowImage")
  _shadowOffset = {x = (uis.CardLoader).x - _shadow.x, y = (uis.CardLoader).y - _shadow.y}
  _themeCardDes[1] = (AdventureGameWindow.InitThemeCardData)("One")
  _themeCardDes[2] = (AdventureGameWindow.InitThemeCardData)("Two")
  _themeCardDes[3] = (AdventureGameWindow.InitThemeCardData)("Three")
  _roleOffset.X = (uis.CardLoader).actualWidth * 0.5 - (uis.CardLoader).actualWidth * (uis.CardLoader).pivotX
  _roleOffset.Y = (uis.CardLoader).actualHeight - (uis.CardLoader).actualHeight * (uis.CardLoader).pivotY
end

AdventureGameWindow.InitThemeCardData = function(name, ...)
  -- function num : 0_5 , upvalues : uis
  local result = {}
  result.Root = (uis.ThemeCardBtn):GetChild(name)
  result.Text = (result.Root):GetChild("LabelTxt")
  return result
end

AdventureGameWindow.InitText = function(...)
  -- function num : 0_6 , upvalues : uis, _ENV
  ((uis.ThemeCardBtn):GetChild("WordTxt")).text = (PUtil.get)(60000434)
end

AdventureGameWindow.InitButtonEvent = function(...)
  -- function num : 0_7 , upvalues : uis, AdventureGameWindow
  ((uis.TenTimeBtn).onClick):Add(AdventureGameWindow.ClickMultiPlayBtn)
  ;
  ((uis.OnceBtn).onClick):Add(AdventureGameWindow.ClickPlayBtn)
  ;
  ((uis.BuildingBtn).onClick):Add(AdventureGameWindow.ClickBuildingBtn)
  ;
  ((uis.VowBtn).onClick):Add(AdventureGameWindow.ClickWishPointBtn)
  ;
  ((uis.TaroBtn).onClick):Add(AdventureGameWindow.ClickTarotBtn)
  ;
  ((uis.ControlBtn).onClick):Add(AdventureGameWindow.ClickCtrlDiceBtn)
  ;
  ((uis.EventBtn).onClick):Add(AdventureGameWindow.ClickUndoneEventBtn)
end

AdventureGameWindow.InitEvent = function(...)
  -- function num : 0_8
end

AdventureGameWindow.RemoveEvent = function(...)
  -- function num : 0_9
end

AdventureGameWindow.OnShown = function(...)
  -- function num : 0_10 , upvalues : AdventureGameWindow, _ENV
  (AdventureGameWindow.InitEvent)()
  ;
  (AdventureGameWindow.Init)()
  ;
  (AdventureGameWindow.CheckMildGuide)()
  ;
  (GuideMgr.PictureTriggerGuide)((WinResConfig.AdventureGameWindow).name)
end

AdventureGameWindow.CheckMildGuide = function(...)
  -- function num : 0_11 , upvalues : _ENV
  local times = (Util.GetIntPlayerSetting)(PlayerPrefsKeyName.ADVENTURE_MOVE_TIMES)
  if (ActorData.GetAssetCount)(AssetType.ENDURANCE) > 0 and AdventureData.LeftStep <= 0 and times < 2 then
    (GuideMgr.MildGuideTrigger)((WinResConfig.AdventureGameWindow).name)
  else
    ;
    (GuideMgr.CloseMildGuide)()
  end
end

AdventureGameWindow.OnHide = function(...)
  -- function num : 0_12
end

AdventureGameWindow.Init = function(...)
  -- function num : 0_13 , upvalues : _ENV, AdventureGameWindow
  (LuaSound.LoadAndPlayBGM)(1010005)
  ;
  (AdventureGameWindow.InitMap)((AdventureData.CurrentMapConfig).id)
  ;
  (AdventureGameWindow.InitRole)(AdventureData.CurrentNode)
  ;
  (AdventureGameWindow.FocusOnCharacter)()
  ;
  (AdventureGameWindow.RefreshCtrlDiceRedDot)()
  ;
  (AdventureGameWindow.InitThemeCard)()
  ;
  (AdventureGameWindow.RefreshUndoneEventBtnStatue)()
end

AdventureGameWindow.RefreshCtrlDiceRedDot = function(...)
  -- function num : 0_14 , upvalues : uis, _ENV
  if (AdventureData.CheckFreeCtrlDice)() then
    ((uis.ControlBtn):GetChild("RedDot")).visible = (Util.CheckCostResources)(PropType.ASSET .. ":" .. AssetType.ENDURANCE .. ":" .. (AdventureData.CurrentMapConfig).dice_cost, nil, nil, true)
  end
end

AdventureGameWindow.RefreshBuildingRedDot = function(...)
  -- function num : 0_15 , upvalues : uis, _ENV
  local redDot = (uis.BuildingBtn):GetChild("RedDot")
  if redDot.visible == false then
    if AdventureData.FirstGetBuildingInfoDaily then
      redDot.visible = (AdventureData.CheckBuildingRedDot)()
      -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

      AdventureData.FirstGetBuildingInfoDaily = false
    end
  end
end

AdventureGameWindow.InitThemeCard = function(...)
  -- function num : 0_16 , upvalues : _ENV, uis, AdventureGameWindow, _themeCardDes
  local cardId = (((TableData.gTable).BaseFixedData)[Const.THEME_CARD]).int_value
  local cardConfig = ((TableData.gTable).BaseCardData)[cardId]
  ;
  ((uis.ThemeCardBtn):GetChild("CardHeadLoader")).url = (CardMgr.GetHeadIconBattle)(cardConfig)
  ;
  ((uis.ThemeCardBtn):GetChild("CardNameLoader")).url = (Util.GetItemUrl)(cardConfig.name_pic)
  local config = ((TableData.gTable).BaseCardData)[cardId]
  ;
  ((uis.ThemeCardBtn).onClick):Set(function(...)
    -- function num : 0_16_0 , upvalues : AdventureGameWindow, cardId
    (AdventureGameWindow.ClickThemeCardBtn)(cardId)
  end
)
  local labels = split(config.card_label_show, ":")
  local count = #_themeCardDes
  local labelsCount = #labels
  for i = 1, count do
    -- DECOMPILER ERROR at PC55: Confused about usage of register: R10 in 'UnsetPending'

    ((_themeCardDes[i]).Root).visible = i <= labelsCount
    -- DECOMPILER ERROR at PC66: Confused about usage of register: R10 in 'UnsetPending'

    if i <= labelsCount then
      ((_themeCardDes[i]).Text).text = (PUtil.get)(tonumber(labels[i]))
    end
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

AdventureGameWindow.SetCharacterPosition = function(pos, ...)
  -- function num : 0_17 , upvalues : uis, _shadow, _shadowOffset
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  (uis.CardLoader).x = pos.x
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.CardLoader).y = pos.y
  _shadow.x = pos.x - _shadowOffset.x
  _shadow.y = pos.y - _shadowOffset.y
  _shadow:InvalidateBatchingState()
end

AdventureGameWindow.InitMap = function(mapId, ...)
  -- function num : 0_18 , upvalues : _nodes, _map, _startEffect, uis, _finishEffect, _currentMapPkg, _ENV, _mapLimit, MAP_EXTRA_DISTANCE, _swipe, contentPane, AdventureGameWindow, DRAG_MAP_STOP_DURATION, _currentDragStatue, _shadow
  if _nodes.MapId == mapId then
    return 
  end
  _nodes = {}
  _nodes.MapId = mapId
  if _map ~= nil then
    if _startEffect ~= nil then
      (uis.root):AddChild(_startEffect)
    end
    if _finishEffect ~= nil then
      (uis.root):AddChild(_finishEffect)
    end
    _map:Dispose()
  end
  if _currentMapPkg ~= nil then
    UIMgr:RemovePackage(_currentMapPkg)
  end
  local config = ((TableData.gTable).BaseAdventureMapData)[mapId]
  _currentMapPkg = config.map_name
  UIMgr:LoadPackage(config.map_name)
  _map = (UIPackage.CreateObject)((WinResConfig.AdventureGameWindow).package, config.map_path)
  ;
  (uis.root):AddChild(_map)
  ;
  (uis.root):SetChildIndex(_map, (uis.root):GetChildIndex(uis.MapLoader))
  local Vector4 = (CS.UnityEngine).Vector4
  _mapLimit = Vector4(MAP_EXTRA_DISTANCE, MAP_EXTRA_DISTANCE, ResolutionHandler.Height - _map.height - MAP_EXTRA_DISTANCE, ResolutionHandler.Width - _map.width - MAP_EXTRA_DISTANCE)
  _swipe = (FairyGUI.SwipeGesture)(contentPane)
  contentPane.disableSound = true
  ;
  (_swipe.onMove):Add(function(...)
    -- function num : 0_18_0 , upvalues : AdventureGameWindow, _swipe
    (AdventureGameWindow.MoveMap)(_swipe.delta)
  end
)
  ;
  (_swipe.onEnd):Add(function(...)
    -- function num : 0_18_1 , upvalues : _ENV, _map, AdventureGameWindow, _swipe, DRAG_MAP_STOP_DURATION
    (LeanTween.value)((_map.displayObject).gameObject, function(value, ...)
      -- function num : 0_18_1_0 , upvalues : AdventureGameWindow
      (AdventureGameWindow.MoveMap)(value)
    end
, Vector2((_swipe.velocity).x, (_swipe.velocity).y) * 0.01, Vector2.zero, DRAG_MAP_STOP_DURATION)
  end
)
  ;
  (AdventureGameWindow.ChangeDragStatue)(_currentDragStatue)
  local config = ((TableData.gTable).BaseAdventureNodeData)[config.head_node]
  ;
  (AdventureGameWindow.InitNode)(1, config, "")
  _map:AddChild(_shadow)
  _map:AddChild(uis.CardLoader)
end

AdventureGameWindow.ChangeMap = function(mapId, NodeId, callback, ...)
  -- function num : 0_19 , upvalues : uis, _shadow, AdventureGameWindow
  (uis.root):AddChild(_shadow)
  ;
  (uis.root):AddChild(uis.CardLoader)
  ;
  (AdventureGameWindow.InitMap)(mapId)
  ;
  (AdventureGameWindow.InitRole)(NodeId)
  ;
  (AdventureGameWindow.FocusOnCharacter)()
  ;
  (AdventureGameWindow.PlayMapNameAnim)(mapId)
  if callback ~= nil then
    callback()
  end
end

AdventureGameWindow.PlayMapNameAnim = function(mapId, ...)
  -- function num : 0_20 , upvalues : uis, _ENV, _mapNameAnim
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  (((uis.SceneCutMove).SceneCut).c1Ctr).selectedIndex = (((TableData.gTable).BaseAdventureMapData)[mapId]).type
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.SceneCutMove).root).visible = true
  _mapNameAnim:Play(function(...)
    -- function num : 0_20_0 , upvalues : uis
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

    ((uis.SceneCutMove).root).visible = false
  end
)
end

AdventureGameWindow.MoveMap = function(delta, ...)
  -- function num : 0_21 , upvalues : AdventureGameWindow, _map
  (AdventureGameWindow.SetMapPos)(_map.x + delta.x, _map.y + delta.y)
end

AdventureGameWindow.SetMapPos = function(posX, posY, ...)
  -- function num : 0_22 , upvalues : _map, _mapLimit
  if _map == nil then
    return 
  end
  if _mapLimit.x < posX then
    posX = _mapLimit.x
  else
    if posX < _mapLimit.w then
      posX = _mapLimit.w
    end
  end
  if posY < _mapLimit.z then
    posY = _mapLimit.z
  else
    if _mapLimit.y < posY then
      posY = _mapLimit.y
    end
  end
  _map.x = posX
  _map.y = posY
  _map:InvalidateBatchingState()
end

AdventureGameWindow.InitNode = function(index, config, suffix, ...)
  -- function num : 0_23 , upvalues : _nodes, _map, _ENV, AdventureGameWindow, _startEffect, _finishEffect
  local spot = nil
  while 1 do
    while 1 do
      _nodes[config.id] = {}
      -- DECOMPILER ERROR at PC15: Confused about usage of register: R4 in 'UnsetPending'

      ;
      (_nodes[config.id]).Node = _map:GetChild((string.format)("%d%s", index, suffix))
      spot = ((_nodes[config.id]).Node):GetChild("SpotImage")
      -- DECOMPILER ERROR at PC30: Confused about usage of register: R4 in 'UnsetPending'

      ;
      (_nodes[config.id]).Offset = {x = spot.x, y = spot.y}
      -- DECOMPILER ERROR at PC39: Confused about usage of register: R4 in 'UnsetPending'

      ;
      (_nodes[config.id]).Effect = ((_nodes[config.id]).Node):GetChild("Position")
      -- DECOMPILER ERROR at PC43: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((_nodes[config.id]).Effect).visible = false
      -- DECOMPILER ERROR at PC52: Confused about usage of register: R4 in 'UnsetPending'

      ;
      (_nodes[config.id]).Anim = ((_nodes[config.id]).Effect):GetTransition("in")
      if config.type == AdventureNodeType.ForkBegin then
        index = index + 1
        local next = split(config.next, ":")
        local count = #next
        local subIndex = nil
        local orginIndex = index
        for i = 1, count do
          subIndex = (AdventureGameWindow.InitNode)(orginIndex, ((TableData.gTable).BaseAdventureNodeData)[tonumber(next[i])], suffix .. (string.format)("_%c", i + 64))
          if index < subIndex then
            index = subIndex
          end
        end
        -- DECOMPILER ERROR at PC92: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC92: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
    if config.type == AdventureNodeType.Begin then
      if _startEffect == nil then
        _startEffect = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_ADVENTUREGAME_START_NODE)
      end
      _map:AddChildAt(_startEffect, _map:GetChildIndex((_nodes[config.id]).Node) + 1)
      _startEffect:SetXY(((_nodes[config.id]).Node).x + ((_nodes[config.id]).Node).width * 0.5, ((_nodes[config.id]).Node).y + 20)
    else
      if config.type == AdventureNodeType.End then
        if _finishEffect == nil then
          _finishEffect = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_ADVENTUREGAME_FINISH_NODE)
        end
        _map:AddChildAt(_finishEffect, _map:GetChildIndex((_nodes[config.id]).Node) + 1)
        _finishEffect:SetXY(((_nodes[config.id]).Node).x + ((_nodes[config.id]).Node).width * 0.5, ((_nodes[config.id]).Node).y + 20)
        break
      else
      end
    end
    if config.type ~= AdventureNodeType.ForkEnd then
      index = index + 1
      config = ((TableData.gTable).BaseAdventureNodeData)[tonumber(config.next)]
      -- DECOMPILER ERROR at PC195: LeaveBlock: unexpected jumping out IF_THEN_STMT

      -- DECOMPILER ERROR at PC195: LeaveBlock: unexpected jumping out IF_STMT

    end
  end
  return index
end

AdventureGameWindow.InitObstacles = function(...)
  -- function num : 0_24 , upvalues : _obstacles, _map, _ENV
  _obstacles = {}
  local obstacle = nil
  local index = 1
  while 1 do
    obstacle = _map:GetChild("Obstacle" .. tostring(index))
    if obstacle ~= nil then
      (table.insert)(_obstacles, obstacle)
      index = index + 1
      -- DECOMPILER ERROR at PC21: LeaveBlock: unexpected jumping out IF_THEN_STMT

      -- DECOMPILER ERROR at PC21: LeaveBlock: unexpected jumping out IF_STMT

    end
  end
end

AdventureGameWindow.InitRole = function(nodeId, ...)
  -- function num : 0_25 , upvalues : _ENV, AdventureGameWindow, _nodes, _role, uis
  loge("初始位置:" .. tostring(nodeId))
  ;
  (AdventureGameWindow.SetCharacterPosition)((AdventureGameWindow.GetCharPosAtNode)(_nodes[nodeId]))
  if _role == nil then
    (Util.CreateSelfMiniModel)(uis.CardLoader, function(model, ...)
    -- function num : 0_25_0 , upvalues : _role, AdventureGameWindow, nodeId
    _role = model
    ;
    (AdventureGameWindow.SetDefaultCharacterDirection)(nodeId)
  end
)
  end
end

AdventureGameWindow.GetCharPosAtNode = function(nodeInfo, ...)
  -- function num : 0_26 , upvalues : _roleOffset
  return {x = (nodeInfo.Node).x + (nodeInfo.Offset).x - _roleOffset.X, y = (nodeInfo.Node).y + (nodeInfo.Offset).y - _roleOffset.Y}
end

AdventureGameWindow.SetRoleLayer = function(belowObstacle, obstacle, ...)
  -- function num : 0_27 , upvalues : _map, _shadow, uis
  if belowObstacle then
    local index = _map:GetChildIndex(obstacle)
    _map:SetChildIndex(_shadow, index)
    _map:SetChildIndex(uis.CardLoader, index)
  else
    do
      _map:SetChildIndex(_shadow, _map.numChildren - 1)
      _map:SetChildIndex(uis.CardLoader, _map.numChildren - 1)
    end
  end
end

AdventureGameWindow.DealEventIconLayer = function(compnent, ...)
  -- function num : 0_28 , upvalues : AdventureGameWindow, _map
  local obstacle = (AdventureGameWindow.GetInteractObstacles)(compnent)
  if obstacle ~= nil then
    local index = _map:GetChildIndex(obstacle)
    _map:SetChildIndex(compnent, index - 2)
  else
    do
      _map:SetChildIndex(compnent, _map.numChildren - 1)
    end
  end
end

AdventureGameWindow.GetInteractObstacles = function(component, ...)
  -- function num : 0_29 , upvalues : _obstacles, AdventureGameWindow
  local count = #_obstacles
  local target = {}
  target.x = component.x + component.width * 0.5
  target.y = component.y + component.height * 0.5
  target.width = component.width
  target.height = component.height
  for i = 1, count do
    if (AdventureGameWindow.CheckSingleObstacle)(target, _obstacles[i]) then
      return _obstacles[i]
    end
  end
end

AdventureGameWindow.CheckSingleObstacle = function(target, obstacle, ...)
  -- function num : 0_30 , upvalues : _ENV
  local obstacleCenter = {}
  obstacleCenter.x = obstacle.x + obstacle.width * 0.5
  obstacleCenter.y = obstacle.y + obstacle.height * 0.5
  do return (math.abs)(target.x - obstacleCenter.x) < (target.width + obstacle.width) * 0.5 and (math.abs)(target.y - obstacleCenter.y) < (target.height + obstacle.height) * 0.5 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

AdventureGameWindow.RefreshUndoneEventBtnStatue = function(...)
  -- function num : 0_31 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R0 in 'UnsetPending'

  (uis.EventBtn).visible = #AdventureData.UndoneEvent > 0
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

AdventureGameWindow.OnClose = function(...)
  -- function num : 0_32 , upvalues : _ENV, AdventureGameWindow, uis, _currentDragStatue, _lastObstacle, _role, contentPane, argTable, _map, _nodes, _obstacles, _themeCardDes, _currentMapPkg, _startEffect, _finishEffect
  (GuideData.AbolishControlRefer)((WinResConfig.AdventureGameWindow).name)
  ;
  (RedDotMgr.RemoveUIRefer)((WinResConfig.AdventureGameWindow).name)
  ;
  (AdventureGameWindow.RemoveEvent)()
  ;
  (CommonWinMgr.RemoveAssets)((WinResConfig.AdventureGameWindow).name)
  ;
  (Util.RecycleUIModel)(uis.CardLoader, true)
  ;
  (AdventureMgr.QuitWhenMoving)()
  ;
  (AdventureGameWindow.RecycleDice)()
  _currentDragStatue = true
  _lastObstacle = nil
  _role = nil
  uis = nil
  contentPane = nil
  argTable = {}
  _map:Dispose()
  _map = nil
  _nodes = {}
  _obstacles = {}
  _nodes = {}
  _themeCardDes = {}
  if _currentMapPkg ~= nil then
    UIMgr:RemovePackage(_currentMapPkg)
    _currentMapPkg = nil
  end
  if _startEffect ~= nil then
    _startEffect:Dispose()
    _startEffect = nil
  end
  if _finishEffect ~= nil then
    _finishEffect:Dispose()
    _finishEffect = nil
  end
end

AdventureGameWindow.ChangeDiceBtnStatue = function(enable, ...)
  -- function num : 0_33 , upvalues : uis
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (uis.OnceBtn).touchable = enable
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.TenTimeBtn).touchable = enable
end

AdventureGameWindow.ClickPlayBtn = function(...)
  -- function num : 0_34 , upvalues : _ENV
  (AdventureMgr.TryPlaySingleDice)()
end

AdventureGameWindow.ClickMultiPlayBtn = function(...)
  -- function num : 0_35 , upvalues : _ENV
  (AdventureMgr.TryPlayMultiDice)()
end

AdventureGameWindow.ClickBuildingBtn = function(...)
  -- function num : 0_36 , upvalues : _ENV
  (AdventureMgr.TryOpenBuildingShow)()
end

AdventureGameWindow.ClickThemeCardBtn = function(cardId, ...)
  -- function num : 0_37 , upvalues : _ENV
  if AdventureData.LeftStep > 0 then
    return 
  end
  OpenWindow("CardDetailsWindow", UILayer.HUD, cardId)
  ;
  (RedDotMgr.EliminateRedDot)((WinResConfig.AdventureGameWindow).name, RedDotComID.BigAdventure_RiskER)
end

AdventureGameWindow.ClickCtrlDiceBtn = function(...)
  -- function num : 0_38 , upvalues : _ENV
  (AdventureMgr.TryCtrlDice)()
end

AdventureGameWindow.ClickWishPointBtn = function(...)
  -- function num : 0_39 , upvalues : _ENV
  (AdventureMgr.EnterMakeWish)()
end

AdventureGameWindow.ClickUndoneEventBtn = function(...)
  -- function num : 0_40 , upvalues : _ENV
  if AdventureData.LeftStep > 0 then
    return 
  end
  OpenWindow((WinResConfig.UnMakeEventWindow).name, UILayer.HUD)
end

AdventureGameWindow.ClickTarotBtn = function(...)
  -- function num : 0_41 , upvalues : _ENV
  (AdventureMgr.OpenTarotUI)()
end

AdventureGameWindow.ChangeDragStatue = function(enable, ...)
  -- function num : 0_42 , upvalues : _swipe, _currentDragStatue
  _swipe:Enable(enable)
  _currentDragStatue = enable
end

AdventureGameWindow.SetDefaultCharacterDirection = function(nodeId, ...)
  -- function num : 0_43 , upvalues : _ENV, AdventureGameWindow
  if nodeId == nil then
    nodeId = AdventureData.CurrentNode
  end
  local config = ((TableData.gTable).BaseAdventureNodeData)[nodeId]
  if config.type ~= AdventureNodeType.End and config.type ~= AdventureNodeType.ForkBegin then
    (AdventureGameWindow.SetCharacterDirection)(tonumber(config.next))
  end
end

AdventureGameWindow.SetCharacterDirection = function(nodeId, ...)
  -- function num : 0_44 , upvalues : _nodes, uis, _ENV, _role
  local c = ((_nodes[nodeId]).Node).x
  if ((_nodes[nodeId]).Node).x < (uis.CardLoader).x then
    (SkeletonAnimationUtil.SetFlip)(_role, true, false)
  else
    ;
    (SkeletonAnimationUtil.SetFlip)(_role, false, false)
  end
end

AdventureGameWindow.MoveToNode = function(nodeId, callBack, ...)
  -- function num : 0_45 , upvalues : AdventureGameWindow, _nodes, uis, MOVE_TO_NEXT_BLOCK_COST_TIME, _ENV, _mapYOffset
  (AdventureGameWindow.SetCharacterDirection)(nodeId)
  local destinationInfo = (AdventureGameWindow.GetCharPosAtNode)(_nodes[nodeId])
  destinationInfo.width = (uis.CardLoader).width
  destinationInfo.height = (uis.CardLoader).height
  local pos = (AdventureGameWindow.GetCharPosAtNode)(_nodes[nodeId])
  ;
  ((((uis.CardLoader):TweenMove(pos, MOVE_TO_NEXT_BLOCK_COST_TIME)):SetEase((FairyGUI.EaseType).Linear)):OnUpdate(function(...)
    -- function num : 0_45_0 , upvalues : AdventureGameWindow, _ENV, uis, _mapYOffset
    (AdventureGameWindow.SetMapPos)(ResolutionHandler.Width * 0.5 - (uis.CardLoader).width * 0.5 - (uis.CardLoader).x, ResolutionHandler.Height * 0.5 - (uis.CardLoader).height * 0.5 - (uis.CardLoader).y - _mapYOffset)
  end
)):OnComplete(function(...)
    -- function num : 0_45_1 , upvalues : _ENV, AdventureGameWindow, _nodes, nodeId, callBack
    (LuaSound.PlaySound)(LuaSound.ADVENTURE_STEP, SoundBank.OTHER)
    ;
    (AdventureGameWindow.StopNodeAnim)(_nodes[nodeId])
    callBack()
  end
)
end

AdventureGameWindow.ShowDestination = function(show, ...)
  -- function num : 0_46 , upvalues : _ENV, _nodes
  local count = #AdventureData.PassingNode
  local node = nil
  for i = 1, count do
    node = _nodes[(AdventureData.PassingNode)[i]]
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R7 in 'UnsetPending'

    if node ~= nil then
      do
        (node.Effect).visible = true
        ;
        (node.Anim):Play(-1, 0.1 * (i - 1), nil)
        -- DECOMPILER ERROR at PC23: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC23: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
end

AdventureGameWindow.StopNodeAnim = function(node, ...)
  -- function num : 0_47 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (node.Effect).visible = false
  ;
  (node.Anim):Stop()
  ;
  (table.remove)(AdventureData.PassingNode, 1)
end

AdventureGameWindow.ChangeRoleStatue = function(run, ...)
  -- function num : 0_48 , upvalues : _ENV, _role
  local sa = (SkeletonAnimationUtil.GetSkeletonAnimation)(_role)
  if run then
    if sa.AnimationName == BattleCardState.RUN then
      return 
    end
    ;
    (SkeletonAnimationUtil.SetAnimation)(_role, 0, BattleCardState.RUN, true)
  else
    if sa.AnimationName == BattleCardState.IDLE then
      return 
    end
    ;
    (SkeletonAnimationUtil.SetAnimation)(_role, 0, BattleCardState.IDLE, true)
  end
end

AdventureGameWindow.PlayNodeAnim = function(nodeId, callback, ...)
  -- function num : 0_49 , upvalues : _ENV, _map, uis, _nodes
  local config = ((TableData.gTable).BaseAdventureNodeData)[nodeId]
  if config.event_id ~= 0 then
    local icon = tonumber(config.note_icon) + 1
    config = ((TableData.gTable).BaseAdventureEventData)[config.event_id]
    if config.type == AdventureEventType.Gold then
      local holder = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_ADVENTUREGAME_GAIN_COIN, true, true)
      _map:AddChildAt(holder, _map:GetChildIndex(uis.CardLoader))
      holder:SetXY(((_nodes[nodeId]).Node).x + ((_nodes[nodeId]).Node).width * 0.5, ((_nodes[nodeId]).Node).y - ((_nodes[nodeId]).Node).height * 0.5)
    end
  end
end

AdventureGameWindow.FocusOnCharacter = function(tween, callBack, ...)
  -- function num : 0_50 , upvalues : _ENV, uis, _mapYOffset, _map, AdventureGameWindow, MAP_TWEEN_SPEED
  if tween then
    local target = Vector2(ResolutionHandler.Width * 0.5 - (uis.CardLoader).width * 0.5 - (uis.CardLoader).x, ResolutionHandler.Height * 0.5 - (uis.CardLoader).height * 0.5 - (uis.CardLoader).y - _mapYOffset)
    local dis = (math.abs)(_map.x - target.x) + (math.abs)(_map.y - target.y)
    ;
    ((LeanTween.value)((_map.displayObject).gameObject, function(value, ...)
    -- function num : 0_50_0 , upvalues : AdventureGameWindow
    (AdventureGameWindow.SetMapPos)(value.x, value.y)
  end
, Vector2(_map.x, _map.y), target, dis / MAP_TWEEN_SPEED)):setOnComplete(callBack)
  else
    do
      ;
      (AdventureGameWindow.SetMapPos)(ResolutionHandler.Width * 0.5 - (uis.CardLoader).width * 0.5 - (uis.CardLoader).x, ResolutionHandler.Height * 0.5 - (uis.CardLoader).height * 0.5 - (uis.CardLoader).y - _mapYOffset)
    end
  end
end

AdventureGameWindow.ShowChooseFork = function(nodes, ...)
  -- function num : 0_51 , upvalues : _forkNodes, _ENV, _nodes
  _forkNodes = nodes
  local count = #_forkNodes
  for i = 1, count do
    local nodeId = tonumber(_forkNodes[i])
    do
      (((_nodes[nodeId]).Node).onClick):Add(function(...)
    -- function num : 0_51_0 , upvalues : count, _nodes, nodeId, _ENV
    for i = 1, count do
      (((_nodes[nodeId]).Node).onClick):Clear()
    end
    ;
    (AdventureService.ReqPlayDice)(nil, nodeId)
  end
)
    end
  end
end

AdventureGameWindow.PlayDiceAnim = function(number, remote, callback, ...)
  -- function num : 0_52 , upvalues : _dice, _ENV, uis, DICE_MODEL, _map
  local dice = nil
  if _dice == nil then
    _dice = {}
    local aLoader = (FairyGUI.GLoader)()
    aLoader:SetSize((uis.OnceBtn).width, (uis.OnceBtn).height)
    ;
    (uis.root):AddChild(aLoader)
    _dice.Model = (Util.ShowUIModel)(DICE_MODEL, aLoader)
    _dice.Loader = aLoader
  end
  do
    dice = _dice
    -- DECOMPILER ERROR at PC43: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (dice.Loader).xy = Vector2((uis.CardLoader).x + _map.x + (uis.CardLoader).width * 0.5, (uis.CardLoader).y + _map.y - 90)
    -- DECOMPILER ERROR at PC45: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (dice.Loader).visible = true
    ;
    (LuaSound.PlaySound)(LuaSound.ADVENTURE_THROW_DICE, SoundBank.OTHER)
    local sa = (dice.Model):GetComponent(typeof(((CS.Spine).Unity).SkeletonAnimation))
    sa:ClearState()
    ;
    (SkeletonAnimationUtil.SetAnimation)(dice.Model, 0, tostring(number), false, function(...)
    -- function num : 0_52_0 , upvalues : dice, callback
    -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

    (dice.Loader).visible = false
    if callback ~= nil then
      callback()
    end
  end
, true)
  end
end

AdventureGameWindow.RecycleDice = function(...)
  -- function num : 0_53 , upvalues : _remoteDice, _dice
  if _remoteDice ~= nil then
    (_remoteDice.Loader):Dispose()
    _remoteDice = nil
  end
  if _dice ~= nil then
    (_dice.Loader):Dispose()
    _dice = nil
  end
end

AdventureGameWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_54 , upvalues : _ENV, AdventureGameWindow, _nodes
  if msgId == (WindowMsgEnum.Adventure).E_MSG_CHANGE_STATUE then
    (AdventureGameWindow.ChangeRoleStatue)(para.Move)
    if para.SetDir then
      (AdventureGameWindow.SetDefaultCharacterDirection)()
    end
    if para.Move == false and para.SetDir == true then
      (AdventureGameWindow.CheckMildGuide)()
    end
  else
    if msgId == (WindowMsgEnum.Adventure).E_MSG_ROLE_MOVE then
      (AdventureGameWindow.MoveToNode)(para.NodeId, para.Callback)
    else
      if msgId == (WindowMsgEnum.Adventure).E_MSG_NODE_ANIM then
        (AdventureGameWindow.PlayNodeAnim)(para.NodeId, para.Callback)
      else
        if msgId == (WindowMsgEnum.Adventure).E_MSG_CHANGE_MAP then
          (AdventureGameWindow.ChangeMap)(para.MapId, para.NodeId, para.Callback)
        else
          if msgId == (WindowMsgEnum.Adventure).E_MSG_REFRESH_UNDONE_EVENT then
            (AdventureGameWindow.RefreshUndoneEventBtnStatue)()
          else
            if msgId == (WindowMsgEnum.Adventure).E_MSG_CHANGE_DRAG_STATUE then
              (AdventureGameWindow.ChangeDragStatue)(para)
              ;
              (AdventureGameWindow.ChangeDiceBtnStatue)(para)
              ;
              (AdventureGameWindow.CheckMildGuide)()
            else
              if msgId == (WindowMsgEnum.Adventure).E_MSG_SHOW_CHOOSE_FORK then
                (AdventureGameWindow.ShowChooseFork)(para)
              else
                if msgId == (WindowMsgEnum.Adventure).E_MSG_SHOW_DESTINATION_MARKER then
                  (AdventureGameWindow.ShowDestination)()
                else
                  if msgId == (WindowMsgEnum.Adventure).E_MSG_PLAY_DICE_ANIM then
                    (AdventureGameWindow.PlayDiceAnim)(para.Number, para.Remote, para.Callback)
                  else
                    if msgId == (WindowMsgEnum.Adventure).E_MSG_FOCUS_ON_CHARACTER then
                      (AdventureGameWindow.FocusOnCharacter)(true, para)
                    else
                      if msgId == (WindowMsgEnum.Adventure).E_MSG_FINISH_NODE_ANIM then
                        (AdventureGameWindow.StopNodeAnim)(_nodes[AdventureData.CurrentMoveNode])
                      else
                        if msgId == (WindowMsgEnum.NETBrokenReconnect).E_MSG_RECONNECT_Ok then
                          (AdventureMgr.TryRefreshData)()
                        else
                          if msgId == (WindowMsgEnum.Adventure).E_MSG_REFRESH then
                            (AdventureGameWindow.Init)()
                          else
                            if msgId == (WindowMsgEnum.Adventure).E_MSG_REFRESH_CTRL_REDDOT then
                              (AdventureGameWindow.RefreshCtrlDiceRedDot)()
                            else
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
        end
      end
    end
  end
  if msgId == (WindowMsgEnum.Adventure).E_MSG_REFRESH_BUILDING_STATUE then
  end
end

return AdventureGameWindow

