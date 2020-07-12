-- params : ...
-- function num : 0 , upvalues : _ENV
require("AdventureGame_BuildingCardChoiceWindowByName")
local BuildingCardChoiceWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local _buildingId, _totalFC, _enhance, _haveGuard, _guardInfo, _guardCard, _position, _cards = nil, nil, nil, nil, nil, nil, nil, nil
BuildingCardChoiceWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, _buildingId, _totalFC, _enhance, _haveGuard, _guardInfo, _guardCard, _position, _cards, uis, BuildingCardChoiceWindow
  bridgeObj:SetView((WinResConfig.BuildingCardChoiceWindow).package, (WinResConfig.BuildingCardChoiceWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  _buildingId = argTable[1]
  _totalFC = argTable[2]
  _enhance = (math.floor)((AdventureData.GetFCEnhanceEffect)(_totalFC) * 100)
  _haveGuard = argTable[3]
  if _haveGuard then
    _guardInfo = argTable[4]
    _guardCard = (CardData.GetCardData)(_guardInfo.id)
  else
    _position = argTable[4]
  end
  _cards = argTable[5]
  uis = GetAdventureGame_BuildingCardChoiceWindowUis(contentPane)
  ;
  (BuildingCardChoiceWindow.InitVariable)()
  ;
  (BuildingCardChoiceWindow.InitText)()
  ;
  (BuildingCardChoiceWindow.InitList)()
  ;
  (BuildingCardChoiceWindow.InitButtonEvent)()
end

BuildingCardChoiceWindow.InitVariable = function(...)
  -- function num : 0_1
end

BuildingCardChoiceWindow.InitText = function(...)
  -- function num : 0_2 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.BuildingCardChoiceGrp).SureBtn).text = (PUtil.get)(60000004)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.BuildingCardChoiceGrp).TitleTxt).text = (PUtil.get)(20000323)
end

BuildingCardChoiceWindow.InitList = function(...)
  -- function num : 0_3 , upvalues : uis, BuildingCardChoiceWindow
  ((uis.BuildingCardChoiceGrp).CardInfoList):SetVirtual()
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.BuildingCardChoiceGrp).CardInfoList).itemRenderer = BuildingCardChoiceWindow.RefreshCardItem
end

BuildingCardChoiceWindow.InitButtonEvent = function(...)
  -- function num : 0_4 , upvalues : uis, BuildingCardChoiceWindow
  (((uis.BuildingCardChoiceGrp).CloseBtn).onClick):Add(BuildingCardChoiceWindow.ClickCloseBtn)
  ;
  (((uis.BuildingCardChoiceGrp).SureBtn).onClick):Add(BuildingCardChoiceWindow.ClickCloseBtn)
end

BuildingCardChoiceWindow.InitEvent = function(...)
  -- function num : 0_5
end

BuildingCardChoiceWindow.RemoveEvent = function(...)
  -- function num : 0_6
end

BuildingCardChoiceWindow.OnShown = function(...)
  -- function num : 0_7 , upvalues : BuildingCardChoiceWindow
  (BuildingCardChoiceWindow.InitEvent)()
  ;
  (BuildingCardChoiceWindow.Init)()
end

BuildingCardChoiceWindow.OnHide = function(...)
  -- function num : 0_8
end

BuildingCardChoiceWindow.Init = function(...)
  -- function num : 0_9 , upvalues : uis, _cards
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.BuildingCardChoiceGrp).CardInfoList).numItems = #_cards
end

BuildingCardChoiceWindow.OnClose = function(...)
  -- function num : 0_10 , upvalues : BuildingCardChoiceWindow, uis, contentPane, argTable
  (BuildingCardChoiceWindow.RemoveEvent)()
  uis = nil
  contentPane = nil
  argTable = {}
end

BuildingCardChoiceWindow.RefreshCardItem = function(index, item, ...)
  -- function num : 0_11 , upvalues : _ENV, _cards, _enhance, _totalFC, _haveGuard, _guardCard, _guardInfo, _buildingId, BuildingCardChoiceWindow, _position
  local data = (CardData.GetCardData)(_cards[index + 1])
  ;
  (Util.SetHeadFrame)(item:GetChild("HeadFrameGrp"), data)
  ;
  (item:GetChild("CardNameTxt")).text = data.name
  ;
  (item:GetChild("BattleNumberTxt")).text = data.fc
  ;
  (item:GetChild("RateNumberTxt")).text = (string.format)("%d", _enhance) .. "%"
  ;
  (item:GetChild("RateWordTxt")).text = (PUtil.get)(60000109)
  ;
  (item:GetChild("BattleWordTxt")).text = (PUtil.get)(60000235)
  ;
  (item:GetChild("UesingTxt")).text = (PUtil.get)(60000492)
  local statue = item:GetChild("ArrowNumberGrp")
  local fc = _totalFC + data.fc
  if _haveGuard then
    fc = fc - _guardCard.fc
  end
  local rate = (math.floor)((AdventureData.GetFCEnhanceEffect)(fc) * 100)
  if rate ~= _enhance then
    statue.visible = true
    ;
    (statue:GetChild("NumberTxt")).text = tostring(rate) .. "%"
    if _enhance < rate then
      (statue:GetController("c1")).selectedIndex = 0
    else
      ;
      (statue:GetController("c1")).selectedIndex = 1
    end
  else
    statue.visible = false
  end
  if _haveGuard then
    if _guardInfo.id == data.id then
      (item:GetController("c1")).selectedIndex = 0
      local btn = item:GetChild("CancelBtn")
      btn.text = (PUtil.get)(60000099)
      ;
      (btn.onClick):Set(function(...)
    -- function num : 0_11_0 , upvalues : _ENV, _guardInfo, _buildingId, BuildingCardChoiceWindow
    (AdventureService.ReqAdventureBuilding)(AdventureBuildingOperateType.DeployCard, _guardInfo, _buildingId, AdventureDeployType.Recall)
    ;
    (BuildingCardChoiceWindow.ClickCloseBtn)()
  end
)
    else
      do
        ;
        (item:GetController("c1")).selectedIndex = 1
        do
          local btn = item:GetChild("ChoiceBtn")
          btn.text = (PUtil.get)(60000098)
          ;
          (btn.onClick):Set(function(...)
    -- function num : 0_11_1 , upvalues : rate, _enhance, _ENV, data, _guardInfo, _buildingId, BuildingCardChoiceWindow
    if _enhance <= rate then
      (AdventureService.ReqAdventureBuilding)(AdventureBuildingOperateType.DeployCard, {id = data.id, value = _guardInfo.value}, _buildingId, AdventureDeployType.Deploy)
      ;
      (BuildingCardChoiceWindow.ClickCloseBtn)()
    else
      OpenWindow((WinResConfig.BuildingSureWindow).name, UILayer.HUD, _guardInfo.id, data.id, _enhance, rate, function(...)
      -- function num : 0_11_1_0 , upvalues : _ENV, data, _guardInfo, _buildingId, BuildingCardChoiceWindow
      (AdventureService.ReqAdventureBuilding)(AdventureBuildingOperateType.DeployCard, {id = data.id, value = _guardInfo.value}, _buildingId, AdventureDeployType.Deploy)
      ;
      (BuildingCardChoiceWindow.ClickCloseBtn)()
    end
)
    end
  end
)
          ;
          (item:GetController("c1")).selectedIndex = 1
          local btn = item:GetChild("ChoiceBtn")
          btn.text = (PUtil.get)(60000098)
          ;
          (btn.onClick):Set(function(...)
    -- function num : 0_11_2 , upvalues : _ENV, data, _position, _buildingId, BuildingCardChoiceWindow
    (AdventureService.ReqAdventureBuilding)(AdventureBuildingOperateType.DeployCard, {id = data.id, value = _position}, _buildingId, AdventureDeployType.Deploy)
    ;
    (BuildingCardChoiceWindow.ClickCloseBtn)()
  end
)
        end
      end
    end
  end
end

BuildingCardChoiceWindow.ClickCloseBtn = function(...)
  -- function num : 0_12 , upvalues : _ENV
  UIMgr:CloseWindow((WinResConfig.BuildingCardChoiceWindow).name)
end

BuildingCardChoiceWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_13
end

return BuildingCardChoiceWindow

