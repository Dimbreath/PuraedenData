-- params : ...
-- function num : 0 , upvalues : _ENV
require("AdventureGame_TenTimeUIWindowByName")
local TenTimeUIWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local _costIndex = 1
local _totalCost = {Amount = 0}
local _begin, _width, _disCostImgToNumber = nil, nil, nil
TenTimeUIWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, TenTimeUIWindow
  bridgeObj:SetView((WinResConfig.TenTimeUIWindow).package, (WinResConfig.TenTimeUIWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetAdventureGame_TenTimeUIWindowUis(contentPane)
  ;
  (TenTimeUIWindow.InitVariable)()
  ;
  (TenTimeUIWindow.InitText)()
  ;
  (TenTimeUIWindow.InitList)()
  ;
  (TenTimeUIWindow.InitButtonEvent)()
end

TenTimeUIWindow.InitVariable = function(...)
  -- function num : 0_1 , upvalues : _disCostImgToNumber, uis, _begin, _width
  _disCostImgToNumber = ((uis.TenTimeUIGrp).SpendTxt).x - ((uis.TenTimeUIGrp).SpendLoader).x
  local bg = ((uis.TenTimeUIGrp).root):GetChild("Decorate_05_Image")
  _begin = bg.x
  _width = bg.width
end

TenTimeUIWindow.InitText = function(...)
  -- function num : 0_2 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.TenTimeUIGrp).SureBtn).text = (PUtil.get)(60000094)
end

TenTimeUIWindow.InitButtonEvent = function(...)
  -- function num : 0_3 , upvalues : uis, TenTimeUIWindow
  (((uis.TenTimeUIGrp).SureBtn).onClick):Add(TenTimeUIWindow.ClickConfirmBtn)
  ;
  (((uis.TenTimeUIGrp).CloseBtn).onClick):Add(TenTimeUIWindow.ClickCloseBtn)
end

TenTimeUIWindow.InitList = function(...)
  -- function num : 0_4 , upvalues : uis, TenTimeUIWindow
  ((uis.TenTimeUIGrp).EventList):SetVirtual()
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.TenTimeUIGrp).EventList).itemRenderer = TenTimeUIWindow.RefreshEventItem
end

TenTimeUIWindow.InitEvent = function(...)
  -- function num : 0_5
end

TenTimeUIWindow.RemoveEvent = function(...)
  -- function num : 0_6
end

TenTimeUIWindow.OnShown = function(...)
  -- function num : 0_7 , upvalues : TenTimeUIWindow
  (TenTimeUIWindow.InitEvent)()
  ;
  (TenTimeUIWindow.Init)()
end

TenTimeUIWindow.OnHide = function(...)
  -- function num : 0_8
end

TenTimeUIWindow.Init = function(...)
  -- function num : 0_9 , upvalues : TenTimeUIWindow
  (TenTimeUIWindow.RefreshList)()
end

TenTimeUIWindow.RefreshList = function(...)
  -- function num : 0_10 , upvalues : _costIndex, _totalCost, uis, argTable, TenTimeUIWindow
  _costIndex = 1
  _totalCost = {Amount = 0}
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.TenTimeUIGrp).EventList).numItems = #argTable[1]
  ;
  (TenTimeUIWindow.RefreshTotalCost)()
end

TenTimeUIWindow.RefreshTotalCost = function(...)
  -- function num : 0_11 , upvalues : _totalCost, uis, _ENV, _width, _disCostImgToNumber, _begin
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  if _totalCost.Amount == 0 then
    ((uis.TenTimeUIGrp).SpendLoader).visible = false
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((uis.TenTimeUIGrp).SpendTxt).visible = false
  else
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((uis.TenTimeUIGrp).SpendLoader).visible = true
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((uis.TenTimeUIGrp).SpendTxt).visible = true
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((uis.TenTimeUIGrp).SpendLoader).url = (Util.GetUrlFromItemID)(_totalCost.Id, _totalCost.Type)
    -- DECOMPILER ERROR at PC38: Confused about usage of register: R0 in 'UnsetPending'

    if _totalCost.Amount < (ActorData.GetGoodsCount)(_totalCost.Id, _totalCost.Type) then
      ((uis.TenTimeUIGrp).SpendTxt).text = (math.ceil)(_totalCost.Amount)
    else
      -- DECOMPILER ERROR at PC52: Confused about usage of register: R0 in 'UnsetPending'

      ;
      ((uis.TenTimeUIGrp).SpendTxt).text = "[color=" .. Const.RedColor .. "]" .. (math.ceil)(_totalCost.Amount) .. "[/color]"
    end
    local begin = (_width - ((uis.TenTimeUIGrp).SpendTxt).width - _disCostImgToNumber) * 0.5
    -- DECOMPILER ERROR at PC65: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((uis.TenTimeUIGrp).SpendLoader).x = _begin + begin
    -- DECOMPILER ERROR at PC72: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((uis.TenTimeUIGrp).SpendTxt).x = _begin + begin + _disCostImgToNumber
  end
end

TenTimeUIWindow.ClickConfirmBtn = function(...)
  -- function num : 0_12 , upvalues : _ENV, TenTimeUIWindow
  (AdventureMgr.PlayMultiDice)()
  ;
  (TenTimeUIWindow.ClickCloseBtn)()
end

TenTimeUIWindow.RefreshEventItem = function(index, item, ...)
  -- function num : 0_13 , upvalues : argTable, _ENV, TenTimeUIWindow, _costIndex
  local data = (argTable[1])[index + 1]
  local config = ((TableData.gTable).BaseAdventureEventData)[data.EventId]
  ;
  (item:GetController("c1")).selectedIndex = (AdventureData.EVENT_ICON_INDEX)[config.event_icon]
  do
    if config.type == AdventureEventType.Building then
      local buildingConfig = ((TableData.gTable).BaseAdventureBuildingData)[tonumber(config.parameter)]
      ;
      ((item:GetChild("BuildingGrp")):GetController("c1")).selectedIndex = tonumber(buildingConfig.icon_path)
    end
    if (AdventureData.ChosedEvent)[data.NodeId] == nil then
      (TenTimeUIWindow.SetEventCost)(item, (AdventureData.ChosedEventCost)[AdventureData.ChosedEventAmount + 1])
    else
      ;
      (TenTimeUIWindow.SetEventCost)(item, (AdventureData.ChosedEventCost)[_costIndex], true)
      _costIndex = _costIndex + 1
    end
    ;
    (item.onClick):Set(function(...)
    -- function num : 0_13_0 , upvalues : item, _ENV, data, TenTimeUIWindow
    (item:GetChild("ChoiceBtn")).selected = (AdventureMgr.ChooseBuilding)(data)
    ;
    (TenTimeUIWindow.RefreshList)()
  end
)
  end
end

TenTimeUIWindow.SetEventCost = function(item, cost, needAdd, ...)
  -- function num : 0_14 , upvalues : _ENV, _totalCost
  local costInfo = split(cost, ":")
  _totalCost.Type = tonumber(costInfo[1])
  _totalCost.Id = tonumber(costInfo[2])
  ;
  (item:GetChild("SpendLoader")).url = (Util.GetUrlFromItemID)(_totalCost.Id, _totalCost.Type)
  ;
  (item:GetChild("SpendNumberTxt")).text = costInfo[3]
  if needAdd then
    _totalCost.Amount = _totalCost.Amount + costInfo[3]
  end
end

TenTimeUIWindow.OnClose = function(...)
  -- function num : 0_15 , upvalues : TenTimeUIWindow, _ENV, uis, contentPane, argTable
  (TenTimeUIWindow.RemoveEvent)()
  ;
  (AdventureData.ResetChosedEvent)()
  uis = nil
  contentPane = nil
  argTable = {}
end

TenTimeUIWindow.ClickCloseBtn = function(...)
  -- function num : 0_16 , upvalues : _ENV
  UIMgr:CloseWindow((WinResConfig.TenTimeUIWindow).name)
end

TenTimeUIWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_17
end

return TenTimeUIWindow

