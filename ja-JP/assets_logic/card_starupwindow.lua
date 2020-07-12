-- params : ...
-- function num : 0 , upvalues : _ENV
Card_StarUpWindow = {}
local _uis, refreshAnim, _attrChangePanel, _titleText, _attrChangeList, _teamBuffList, TouchScreenBtn, _upEffectTimer = nil, nil, nil, nil, nil, nil, nil, nil
-- DECOMPILER ERROR at PC5: Confused about usage of register: R8 in 'UnsetPending'

Card_StarUpWindow.Init = function(uiRoot, ...)
  -- function num : 0_0 , upvalues : _uis, refreshAnim, _ENV, TouchScreenBtn
  _uis = (uiRoot.PanelGrp).StarGrp
  refreshAnim = (_uis.root):GetTransition("refresh")
  refreshAnim.invalidateBatchingEveryFrame = true
  PlayUITrans(_uis.root, "refresh")
  TouchScreenBtn = uiRoot.TouchScreenBtn
  ;
  (Card_StarUpWindow.InitVariable)()
  ;
  (Card_StarUpWindow.InitText)()
  ;
  (Card_StarUpWindow.InitButtonEvent)()
  ;
  (Card_StarUpWindow.Refresh)()
  ;
  (Card_StarUpWindow.SetHeadInfo)()
end

-- DECOMPILER ERROR at PC8: Confused about usage of register: R8 in 'UnsetPending'

Card_StarUpWindow.Refresh = function(...)
  -- function num : 0_1 , upvalues : _uis, _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

  ((_uis.UpGrp).root).visible = false
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

  CardData.CurrentCardInfo = (CardData.GetCardData)((CardData.ReturnCardID)())
  ;
  (Card_StarUpWindow.RefreshStarInfo)()
  if (CardData.CurrentCardInfo).star < Const.MaxRoleStar then
    ((_uis.root):GetController("c1")).selectedIndex = 0
    ;
    (Card_StarUpWindow.RefreshCostInfo)()
  else
    ;
    ((_uis.root):GetController("c1")).selectedIndex = 1
  end
end

-- DECOMPILER ERROR at PC11: Confused about usage of register: R8 in 'UnsetPending'

Card_StarUpWindow.InitVariable = function(...)
  -- function num : 0_2 , upvalues : _uis
  _uis.StarNumberBar = (_uis.root):GetChild("StarNumberBar")
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (_uis.StarNumberTxt).UBBEnabled = true
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (_uis.NumberTxt).UBBEnabled = true
end

-- DECOMPILER ERROR at PC14: Confused about usage of register: R8 in 'UnsetPending'

Card_StarUpWindow.InitText = function(...)
  -- function num : 0_3 , upvalues : _uis, _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  (_uis.ButtonOneBtn).text = (PUtil.get)(20000030)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (_uis.ButtonTwoBtn).text = (PUtil.get)(60000060)
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (_uis.TitleTxt).text = (PUtil.get)(60000060)
end

-- DECOMPILER ERROR at PC17: Confused about usage of register: R8 in 'UnsetPending'

Card_StarUpWindow.InitButtonEvent = function(...)
  -- function num : 0_4 , upvalues : _uis, _ENV
  ((_uis.ButtonTwoBtn).onClick):Set(Card_StarUpWindow.ClickUpgradeStarBtn)
  ;
  ((_uis.ButtonOneBtn).onClick):Set(Card_StarUpWindow.ClickAcquireBtn)
  ;
  ((_uis.TipsBtn).onClick):Set(Card_StarUpWindow.ClickDetailBtn)
  ;
  ((_uis.StarDebrisChangeBtn).onClick):Set(Card_StarUpWindow.ClickStarDebrisChangeBtn)
end

-- DECOMPILER ERROR at PC20: Confused about usage of register: R8 in 'UnsetPending'

Card_StarUpWindow.OnClose = function(...)
  -- function num : 0_5 , upvalues : _attrChangePanel, _upEffectTimer, _uis
  if _attrChangePanel ~= nil then
    _attrChangePanel:Dispose()
    _attrChangePanel = nil
  end
  if _upEffectTimer ~= nil then
    _upEffectTimer:stop()
    _upEffectTimer = nil
  end
  _uis = nil
end

-- DECOMPILER ERROR at PC23: Confused about usage of register: R8 in 'UnsetPending'

Card_StarUpWindow.SetHeadInfo = function(...)
  -- function num : 0_6 , upvalues : _uis, _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

  ((_uis.HeadFrameGrp).LevelTxt).text = ""
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((_uis.HeadFrameGrp).StageTxt).text = ""
  for i = 1, Const.MaxRoleStar do
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R4 in 'UnsetPending'

    ((_uis.HeadFrameGrp)["Star_0" .. tostring(i) .. "_smallImage"]).visible = false
  end
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((_uis.HeadFrameGrp).IconLoader).url = (CardMgr.GetHeadIconSquareUrl)(CardData.CurrentCardInfo)
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((_uis.HeadFrameGrp).QualityCtrlCtr).selectedIndex = (CardData.CurrentCardInfo).intelligence + 1
end

-- DECOMPILER ERROR at PC26: Confused about usage of register: R8 in 'UnsetPending'

Card_StarUpWindow.RefreshStarInfo = function(...)
  -- function num : 0_7 , upvalues : _uis, _ENV
  (_uis.StarList):RemoveChildrenToPool()
  local count = (CardData.CurrentCardInfo).star
  for i = 1, count do
    (_uis.StarList):AddItemFromPool()
  end
end

-- DECOMPILER ERROR at PC29: Confused about usage of register: R8 in 'UnsetPending'

Card_StarUpWindow.RefreshCostInfo = function(...)
  -- function num : 0_8 , upvalues : _ENV, _uis
  local config = ((TableData.gTable).BaseCardStarUpData)[(CardData.CurrentCardInfo).id * 100 + (CardData.CurrentCardInfo).star]
  if config and config.next_cost ~= "0" then
    local costs = split(config.next_cost, ",")
    local count = #costs
    local eachCost = nil
    for i = 1, count do
      eachCost = split(costs[i], ":")
      -- DECOMPILER ERROR at PC44: Confused about usage of register: R8 in 'UnsetPending'

      if tonumber(eachCost[2]) == AssetType.GOLD then
        (CardData.CurrentUpgradeStarCost).currency = tonumber(eachCost[3])
      else
        -- DECOMPILER ERROR at PC51: Confused about usage of register: R8 in 'UnsetPending'

        ;
        (CardData.CurrentUpgradeStarCost).pieces = tonumber(eachCost[3])
      end
    end
    -- DECOMPILER ERROR at PC57: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (_uis.NumberTxt).text = (CardData.CurrentUpgradeStarCost).currency
    -- DECOMPILER ERROR at PC77: Confused about usage of register: R4 in 'UnsetPending'

    if (ActorData.GetAssetCount)(AssetType.GOLD) < (CardData.CurrentUpgradeStarCost).currency then
      (_uis.NumberTxt).text = "[color=" .. Const.RedColor .. "]" .. (_uis.NumberTxt).text .. "[/color]"
    end
    local have = (ActorData.GetCardPieceInfo)((CardData.CurrentCardInfo).id)
    local str = tostring(have.haveNum)
    if have.haveNum < (CardData.CurrentUpgradeStarCost).pieces then
      str = "[color=" .. Const.RedColor .. "]" .. str .. "[/color]"
    end
    local cardData = ((TableData.gTable).BaseCardData)[(CardData.CurrentCardInfo).id]
    local piecesId = tonumber((split(cardData.recruit_cost, ":"))[2])
    -- DECOMPILER ERROR at PC123: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (_uis.CardPicesLoader).url = (Util.GetItemUrl)((((TableData.gTable).BasePropData)[piecesId]).icon)
    -- DECOMPILER ERROR at PC133: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (_uis.StarNumberTxt).text = str .. "/" .. tostring((CardData.CurrentUpgradeStarCost).pieces)
    -- DECOMPILER ERROR at PC141: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (_uis.StarNumberBar).value = have.haveNum / (CardData.CurrentUpgradeStarCost).pieces * 100
  end
end

-- DECOMPILER ERROR at PC32: Confused about usage of register: R8 in 'UnsetPending'

Card_StarUpWindow.ShowStarUpEffect = function(afterEffect, ...)
  -- function num : 0_9 , upvalues : _upEffectTimer, _uis, _ENV, TouchScreenBtn
  if _upEffectTimer ~= nil then
    _upEffectTimer:stop()
  end
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((_uis.UpGrp).root).visible = true
  _upEffectTimer = (SimpleTimer.setTimeout)(2, function(...)
    -- function num : 0_9_0 , upvalues : _uis, _upEffectTimer
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

    ((_uis.UpGrp).root).visible = false
    _upEffectTimer = nil
  end
)
  local holder = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_UPSTAR, true, true)
  holder:SetXY(((_uis.HeadFrameGrp).root).x + ((_uis.HeadFrameGrp).root).width * 1.25 * 0.5, ((_uis.HeadFrameGrp).root).y + ((_uis.HeadFrameGrp).root).height * 1.25 * 0.5)
  ;
  (_uis.root):AddChild(holder)
  holder = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_UPSTAR_BLOODSTRIP, true, true)
  ;
  (LuaSound.PlaySound)(LuaSound.CARD_STAR_UP_FLASH, SoundBank.OTHER)
  holder:SetXY((_uis.StarNumberBar).width / 2, (_uis.StarNumberBar).height / 2)
  ;
  (_uis.StarNumberBar):AddChild(holder)
  TouchScreenBtn.visible = true
  ;
  (SimpleTimer.setTimeout)(1, function(...)
    -- function num : 0_9_1 , upvalues : TouchScreenBtn, afterEffect
    TouchScreenBtn.visible = false
    if afterEffect ~= nil then
      afterEffect()
    end
  end
)
end

-- DECOMPILER ERROR at PC35: Confused about usage of register: R8 in 'UnsetPending'

Card_StarUpWindow.ClickAcquireBtn = function(...)
  -- function num : 0_10 , upvalues : _ENV
  (Util.ShowGetWay)(((ActorData.GetCardPieceInfo)((CardData.CurrentCardInfo).id)).id, nil, (CardData.CurrentUpgradeStarCost).pieces)
end

-- DECOMPILER ERROR at PC38: Confused about usage of register: R8 in 'UnsetPending'

Card_StarUpWindow.ClickUpgradeStarBtn = function(...)
  -- function num : 0_11 , upvalues : _ENV
  (CardMgr.TryUpgradeCardStar)()
end

-- DECOMPILER ERROR at PC41: Confused about usage of register: R8 in 'UnsetPending'

Card_StarUpWindow.ClickDetailBtn = function(...)
  -- function num : 0_12 , upvalues : _ENV
  (Card_StarUpWindow.ShowAttrChangePanel)()
end

-- DECOMPILER ERROR at PC44: Confused about usage of register: R8 in 'UnsetPending'

Card_StarUpWindow.ClickStarDebrisChangeBtn = function(...)
  -- function num : 0_13 , upvalues : _ENV
  OpenWindow((WinResConfig.StarDebrisChangeGrpWindow).name, UILayer.HUD, CardData.CurrentCardInfo)
end

-- DECOMPILER ERROR at PC47: Confused about usage of register: R8 in 'UnsetPending'

Card_StarUpWindow.ShowAttrChangePanel = function(...)
  -- function num : 0_14 , upvalues : _attrChangePanel, _ENV
  if _attrChangePanel == nil then
    (Card_StarUpWindow.InitAttrChangePanel)()
  end
  ;
  (Card_StarUpWindow.RefreshAttrChangePanel)()
  ;
  (GRoot.inst):AddCustomPopups(_attrChangePanel, function(...)
    -- function num : 0_14_0 , upvalues : _attrChangePanel
    _attrChangePanel.visible = false
  end
)
  _attrChangePanel.visible = true
end

-- DECOMPILER ERROR at PC50: Confused about usage of register: R8 in 'UnsetPending'

Card_StarUpWindow.InitAttrChangePanel = function(...)
  -- function num : 0_15 , upvalues : _attrChangePanel, _ENV, _uis, _titleText, _attrChangeList, _teamBuffList
  _attrChangePanel = (UIPackage.CreateObject)((WinResConfig.CardWindow).package, CardData.STAR_UPGRADE_ATTR_CHANGE_PANEL)
  ;
  (((_uis.root).parent).root):AddChild(_attrChangePanel)
  _attrChangePanel.x = (((_uis.root).parent).x - _attrChangePanel.width) * 0.5
  _attrChangePanel.y = ((_uis.root).height - _attrChangePanel.height) * 0.5 + ((_uis.root).parent).y
  ;
  (_attrChangePanel:GetChild("Word_02_Txt")).text = (PUtil.get)(60000386)
  _titleText = _attrChangePanel:GetChild("Word_01_Txt")
  _attrChangeList = _attrChangePanel:GetChild("Attribute_01_List")
  _teamBuffList = _attrChangePanel:GetChild("Attribute_02_List")
  _attrChangeList:SetVirtual()
  _teamBuffList:SetVirtual()
end

-- DECOMPILER ERROR at PC53: Confused about usage of register: R8 in 'UnsetPending'

Card_StarUpWindow.RefreshAttrChangePanel = function(...)
  -- function num : 0_16 , upvalues : _titleText, _ENV, _attrChangeList, _teamBuffList
  _titleText.text = (PUtil.get)(60000074, (CardData.CurrentCardInfo).star + 1)
  local nextData = (CardData.GetNextStarCardData)(CardData.CurrentCardInfo)
  _attrChangeList.itemRenderer = function(index, item, ...)
    -- function num : 0_16_0 , upvalues : _ENV, nextData
    local config = ((TableData.gTable).BaseAttributeData)[(CardData.StarUpProperty)[index + 1]]
    ;
    (item:GetChild("n1")).text = config.display_name
    ;
    (item:GetChild("n2")).text = (CardData.CurrentCardInfo)[config.name]
    ;
    (item:GetChild("n4")).text = nextData[config.name]
  end

  _attrChangeList.numItems = #CardData.StarUpProperty
  local config = ((TableData.gTable).BaseCardStarUpData)[nextData.id * 100 + nextData.star]
  local teamBuff = split(config.team_add_attr, ",")
  _teamBuffList.itemRenderer = function(index, item, ...)
    -- function num : 0_16_1 , upvalues : _ENV, teamBuff
    local data = split(teamBuff[index + 1], ":")
    local subConfig = ((TableData.gTable).BaseAttributeData)[tonumber(data[2])]
    ;
    (item:GetChild("NameTxt")).text = subConfig.display_name
    ;
    (item:GetChild("NumberTxt")).text = data[3]
  end

  _teamBuffList.numItems = #teamBuff
end


