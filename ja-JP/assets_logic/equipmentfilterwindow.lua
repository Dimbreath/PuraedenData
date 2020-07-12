-- params : ...
-- function num : 0 , upvalues : _ENV
require("Equipt_EquiptScreenWindowByName")
local EquipmentFilterWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local _equipmentTypePanel, _equipmentIntelligenceList, _equipmentAttributesList, _equipmentBuffsList, _equipmentAttributeAmountList = nil, nil, nil, nil, nil
local _filterStatus = {}
EquipmentFilterWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, EquipmentFilterWindow
  bridgeObj:SetView((WinResConfig.EquipmentFilterWindow).package, (WinResConfig.EquipmentFilterWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetEquipt_EquiptScreenWindowUis(contentPane)
  ;
  (EquipmentFilterWindow.InitVariable)()
  ;
  (EquipmentFilterWindow.InitText)()
  ;
  (EquipmentFilterWindow.InitButtonEvent)()
end

EquipmentFilterWindow.InitVariable = function(...)
  -- function num : 0_1
end

EquipmentFilterWindow.InitText = function(...)
  -- function num : 0_2 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.EquiptLevelGrp).titilenameTxt).text = (PUtil.get)(60000325)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.EquiptLevelGrp).SureBtn).text = (PUtil.get)(60000004)
end

EquipmentFilterWindow.InitButtonEvent = function(...)
  -- function num : 0_3 , upvalues : uis, EquipmentFilterWindow
  (((uis.EquiptLevelGrp).CloseBtn).onClick):Set(EquipmentFilterWindow.ClickCloseBtn)
  ;
  (((uis.EquiptLevelGrp).SureBtn).onClick):Set(EquipmentFilterWindow.ClickFilterBtn)
end

EquipmentFilterWindow.InitEvent = function(...)
  -- function num : 0_4
end

EquipmentFilterWindow.RemoveEvent = function(...)
  -- function num : 0_5
end

EquipmentFilterWindow.OnShown = function(...)
  -- function num : 0_6 , upvalues : EquipmentFilterWindow
  (EquipmentFilterWindow.InitEvent)()
  ;
  (EquipmentFilterWindow.Init)()
end

EquipmentFilterWindow.OnHide = function(...)
  -- function num : 0_7
end

EquipmentFilterWindow.Init = function(...)
  -- function num : 0_8 , upvalues : _filterStatus, uis, EquipmentFilterWindow
  _filterStatus = {}
  ;
  ((uis.EquiptLevelGrp).ScreenList):RemoveChildrenToPool()
  ;
  (EquipmentFilterWindow.InitEquipmentTypeFilter)()
  ;
  (EquipmentFilterWindow.InitEquipmentIntelligenceFilter)()
  ;
  (EquipmentFilterWindow.InitEquipmentAttributeFilter)()
  ;
  (EquipmentFilterWindow.InitEquipmentBuffFilter)()
  ;
  (EquipmentFilterWindow.InitEquipmentAttributeAmountFilter)()
end

EquipmentFilterWindow.InitEquipmentTypeFilter = function(...)
  -- function num : 0_9 , upvalues : _filterStatus, _ENV, uis, _equipmentTypePanel, EquipmentFilterWindow
  _filterStatus[EquiptFilterType.Type] = {}
  local grp = ((uis.EquiptLevelGrp).ScreenList):AddItemFromPool((UIPackage.GetItemURL)((WinResConfig.EquipmentWindow).package, EquiptData.EQUIPMENT_TYPE_FILTER_RESOURCE))
  ;
  (grp:GetChild("NameTxt")).text = (PUtil.get)(60000326)
  _equipmentTypePanel = grp:GetChild("EquiptPanelGrp")
  ;
  (EquipmentFilterWindow.InitTypeBtn)("CleanUp_01_Btn", (PUtil.get)(60000327), EquiptType.Normal)
  ;
  (EquipmentFilterWindow.InitTypeBtn)("CleanUp_02_Btn", (PUtil.get)(60000328), EquiptType.Privilege)
  ;
  (EquipmentFilterWindow.InitTypeBtn)("CleanUp_03_Btn", (PUtil.get)(60000329), EquiptType.Activity)
end

EquipmentFilterWindow.InitTypeBtn = function(btnName, nameTxt, equiptType, ...)
  -- function num : 0_10 , upvalues : _equipmentTypePanel, _filterStatus, _ENV
  local btn = _equipmentTypePanel:GetChild(btnName)
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (_filterStatus[EquiptFilterType.Type])[equiptType] = ((((EquiptData.Filters)[EquiptSetType.Change]).FilterType)[EquiptFilterType.Type])[equiptType] ~= nil
  ;
  (btn:GetChild("NameTxt")).text = nameTxt
  btn.selected = (_filterStatus[EquiptFilterType.Type])[equiptType]
  ;
  (btn.onClick):Set(function(...)
    -- function num : 0_10_0 , upvalues : _filterStatus, _ENV, equiptType
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

    (_filterStatus[EquiptFilterType.Type])[equiptType] = not (_filterStatus[EquiptFilterType.Type])[equiptType]
  end
)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

EquipmentFilterWindow.InitEquipmentIntelligenceFilter = function(...)
  -- function num : 0_11 , upvalues : _ENV, _filterStatus, uis, _equipmentIntelligenceList, EquipmentFilterWindow
  (EquiptData.InitMaxIntelligence)()
  _filterStatus[EquiptFilterType.Intelligence] = {}
  local grp = ((uis.EquiptLevelGrp).ScreenList):AddItemFromPool((UIPackage.GetItemURL)((WinResConfig.EquipmentWindow).package, EquiptData.EQUIPMENT_INTELLIGENCE_FILTER_RESOURCE))
  ;
  (grp:GetChild("NameTxt")).text = (PUtil.get)(60000330)
  _equipmentIntelligenceList = grp:GetChild("StageList")
  _equipmentIntelligenceList:RemoveChildrenToPool()
  local item = nil
  local itemSize = 0
  for i = 1, EquiptData.MaxIntelligence do
    item = _equipmentIntelligenceList:AddItemFromPool()
    itemSize = item.height
    ;
    (EquipmentFilterWindow.RefreshIntelligenceItem)(i, item)
  end
  _equipmentIntelligenceList.height = (itemSize + _equipmentIntelligenceList.lineGap) * (math.ceil)(EquiptData.MaxIntelligence / _equipmentIntelligenceList.columnCount) - _equipmentIntelligenceList.lineGap
end

EquipmentFilterWindow.RefreshIntelligenceItem = function(index, item, ...)
  -- function num : 0_12 , upvalues : _filterStatus, _ENV
  (item:GetController("c1")).selectedIndex = 4
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (_filterStatus[EquiptFilterType.Intelligence])[index] = ((((EquiptData.Filters)[EquiptSetType.Change]).FilterType)[EquiptFilterType.Intelligence])[index] ~= nil
  ;
  (item:GetChild("WordTxt")).text = tostring(index)
  item.selected = (_filterStatus[EquiptFilterType.Intelligence])[index]
  ;
  (item.onClick):Set(function(...)
    -- function num : 0_12_0 , upvalues : _filterStatus, _ENV, index, item
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

    (_filterStatus[EquiptFilterType.Intelligence])[index] = not (_filterStatus[EquiptFilterType.Intelligence])[index]
    item.selected = (_filterStatus[EquiptFilterType.Intelligence])[index]
  end
)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

EquipmentFilterWindow.InitEquipmentAttributeFilter = function(...)
  -- function num : 0_13 , upvalues : _ENV, _filterStatus, uis, _equipmentAttributesList, EquipmentFilterWindow
  (EquiptData.InitEquiptAttributes)()
  _filterStatus[EquiptFilterType.Attributes] = {}
  local grp = ((uis.EquiptLevelGrp).ScreenList):AddItemFromPool((UIPackage.GetItemURL)((WinResConfig.EquipmentWindow).package, EquiptData.EQUIPMENT_FILTER_RESOURCE))
  ;
  (grp:GetChild("NameTxt")).text = (PUtil.get)(60000331)
  _equipmentAttributesList = grp:GetChild("SecondaryList")
  _equipmentAttributesList:RemoveChildrenToPool()
  local item = nil
  local itemSize = 0
  local count = #EquiptData.Attributes
  for i = 1, count do
    item = _equipmentAttributesList:AddItemFromPool()
    itemSize = item.height
    ;
    (EquipmentFilterWindow.RefreshAttributeItem)(i, item)
  end
  _equipmentAttributesList.height = (itemSize + _equipmentAttributesList.lineGap) * (math.ceil)(count / _equipmentAttributesList.columnCount) - _equipmentAttributesList.lineGap
end

EquipmentFilterWindow.RefreshAttributeItem = function(index, item, ...)
  -- function num : 0_14 , upvalues : _ENV, _filterStatus
  local data = (EquiptData.Attributes)[index]
  local config = ((TableData.gTable).BaseAttributeData)[data]
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (_filterStatus[EquiptFilterType.Attributes])[data] = ((((EquiptData.Filters)[EquiptSetType.Change]).FilterType)[EquiptFilterType.Attributes])[data] ~= nil
  ;
  (item:GetChild("NameTxt")).text = config.display_name
  item.selected = (_filterStatus[EquiptFilterType.Attributes])[data]
  ;
  (item.onClick):Set(function(...)
    -- function num : 0_14_0 , upvalues : _filterStatus, _ENV, data, item
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

    (_filterStatus[EquiptFilterType.Attributes])[data] = not (_filterStatus[EquiptFilterType.Attributes])[data]
    item.selected = (_filterStatus[EquiptFilterType.Attributes])[data]
  end
)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

EquipmentFilterWindow.InitEquipmentBuffFilter = function(...)
  -- function num : 0_15 , upvalues : _ENV, _filterStatus, uis, _equipmentBuffsList, EquipmentFilterWindow
  (EquiptData.InitEquiptBuff)()
  _filterStatus[EquiptFilterType.Buff] = {}
  local grp = ((uis.EquiptLevelGrp).ScreenList):AddItemFromPool((UIPackage.GetItemURL)((WinResConfig.EquipmentWindow).package, EquiptData.EQUIPMENT_FILTER_RESOURCE))
  ;
  (grp:GetChild("NameTxt")).text = (PUtil.get)(60000332)
  _equipmentBuffsList = grp:GetChild("SecondaryList")
  _equipmentBuffsList:RemoveChildrenToPool()
  local item = nil
  local itemSize = 0
  local count = #EquiptData.Buffs
  for i = 1, count do
    item = _equipmentBuffsList:AddItemFromPool()
    itemSize = item.height
    ;
    (EquipmentFilterWindow.RefreshBuffItem)(i, item)
  end
  _equipmentBuffsList.height = (itemSize + _equipmentBuffsList.lineGap) * (math.ceil)(count / _equipmentBuffsList.columnCount) - _equipmentBuffsList.lineGap
end

EquipmentFilterWindow.RefreshBuffItem = function(index, item, ...)
  -- function num : 0_16 , upvalues : _ENV, _filterStatus
  local data = (EquiptData.Buffs)[index]
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (_filterStatus[EquiptFilterType.Buff])[index] = ((((EquiptData.Filters)[EquiptSetType.Change]).FilterType)[EquiptFilterType.Buff])[index] ~= nil
  ;
  (item:GetChild("NameTxt")).text = (PUtil.get)(data)
  item.selected = (_filterStatus[EquiptFilterType.Buff])[index]
  ;
  (item.onClick):Set(function(...)
    -- function num : 0_16_0 , upvalues : _filterStatus, _ENV, index, item
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

    (_filterStatus[EquiptFilterType.Buff])[index] = not (_filterStatus[EquiptFilterType.Buff])[index]
    item.selected = (_filterStatus[EquiptFilterType.Buff])[index]
  end
)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

EquipmentFilterWindow.InitEquipmentAttributeAmountFilter = function(...)
  -- function num : 0_17 , upvalues : _filterStatus, _ENV, uis, _equipmentAttributeAmountList, EquipmentFilterWindow
  _filterStatus[EquiptFilterType.AttributeAmount] = {}
  local grp = ((uis.EquiptLevelGrp).ScreenList):AddItemFromPool((UIPackage.GetItemURL)((WinResConfig.EquipmentWindow).package, EquiptData.EQUIPMENT_FILTER_RESOURCE))
  ;
  (grp:GetChild("NameTxt")).text = (PUtil.get)(60000331)
  _equipmentAttributeAmountList = grp:GetChild("SecondaryList")
  _equipmentAttributeAmountList:RemoveChildrenToPool()
  local item = nil
  local itemSize = 0
  for i = 1, EquiptData.MAX_ATTRIBUTE_AMOUNT do
    item = _equipmentAttributeAmountList:AddItemFromPool()
    itemSize = item.height
    ;
    (EquipmentFilterWindow.RefreshAttributeAmountItem)(i, item)
  end
  _equipmentAttributeAmountList.height = (itemSize + _equipmentAttributeAmountList.lineGap) * (math.ceil)(EquiptData.MAX_ATTRIBUTE_AMOUNT / _equipmentAttributeAmountList.columnCount) - _equipmentAttributeAmountList.lineGap
end

EquipmentFilterWindow.RefreshAttributeAmountItem = function(index, item, ...)
  -- function num : 0_18 , upvalues : _filterStatus, _ENV
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'

  (_filterStatus[EquiptFilterType.AttributeAmount])[index] = ((((EquiptData.Filters)[EquiptSetType.Change]).FilterType)[EquiptFilterType.AttributeAmount])[index] ~= nil
  ;
  (item:GetChild("NameTxt")).text = (PUtil.get)(60000334, index)
  item.selected = (_filterStatus[EquiptFilterType.AttributeAmount])[index]
  ;
  (item.onClick):Set(function(...)
    -- function num : 0_18_0 , upvalues : _filterStatus, _ENV, index, item
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

    (_filterStatus[EquiptFilterType.AttributeAmount])[index] = not (_filterStatus[EquiptFilterType.AttributeAmount])[index]
    item.selected = (_filterStatus[EquiptFilterType.AttributeAmount])[index]
  end
)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

EquipmentFilterWindow.ClickCloseBtn = function(...)
  -- function num : 0_19 , upvalues : _ENV
  UIMgr:CloseWindow((WinResConfig.EquipmentFilterWindow).name)
end

EquipmentFilterWindow.ClickFilterBtn = function(...)
  -- function num : 0_20 , upvalues : _ENV, _filterStatus, EquipmentFilterWindow
  (EquiptMgr.FilterChangeEquipments)(_filterStatus)
  ;
  (EquipmentFilterWindow.ClickCloseBtn)()
end

EquipmentFilterWindow.OnClose = function(...)
  -- function num : 0_21 , upvalues : EquipmentFilterWindow, uis, contentPane, argTable
  (EquipmentFilterWindow.RemoveEvent)()
  uis = nil
  contentPane = nil
  argTable = {}
end

EquipmentFilterWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_22
end

return EquipmentFilterWindow

