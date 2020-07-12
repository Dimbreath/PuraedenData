-- params : ...
-- function num : 0 , upvalues : _ENV
EquiptMgr = {}
local _detailPanelPool = {}
-- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.OpenEquipmentWindow = function(type, arg, ...)
  -- function num : 0_0 , upvalues : _ENV
  if (FunctionControlMgr.GetFunctionState)(ControlID.Home_EquipBtn, true) then
    OpenWindow((WinResConfig.EquipmentWindow).name, UILayer.HUD, type, arg)
  end
end

-- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.InitEquipmentsInBag = function(equipments, ...)
  -- function num : 0_1 , upvalues : _ENV
  (EquiptData.ClearEquipData)()
  ;
  (EquiptData.StoreEquipments)(equipments)
end

-- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.AcquireEquipments = function(equipments, ...)
  -- function num : 0_2 , upvalues : _ENV
  if #equipments == 0 then
    return 
  end
  ;
  (EquiptData.AcquireEquipments)(equipments)
end

-- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.LoseEquipments = function(equipmentIds, ...)
  -- function num : 0_3 , upvalues : _ENV
  if #equipmentIds == 0 then
    return 
  end
  ;
  (EquiptData.LoseEquipments)(equipmentIds)
  ;
  (EquiptData.FilteringEquiptSet)(EquiptSetType.Change)
  ;
  (EquiptData.FilteringEquiptSet)(EquiptSetType.Decompose)
  ;
  (EquiptData.FilteringEquiptSet)(EquiptSetType.Identify)
  UIMgr:SendWindowMessage((WinResConfig.EquipmentWindow).name, (WindowMsgEnum.Equipt).E_MSG_REFRESH_EQUIPMENT_TO_DECOMPOSE)
end

-- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.AfterEquipChange = function(msg, ...)
  -- function num : 0_4 , upvalues : _ENV
  local roleInfo, count, equipInfo, oldEquip = nil, nil, nil, nil
  if msg.cardId == (EquiptData.CurrentRoleData).id then
    roleInfo = EquiptData.CurrentRoleData
  else
    if msg.cardId ~= 0 then
      roleInfo = (CardData.GetCardData)(msg.cardId)
    else
      roleInfo = (CardData.GetCardData)(msg.sourceCardId)
    end
  end
  local isPutOn = false
  local equipmentType = nil
  if (Util.StringIsNullOrEmpty)(msg.replaceEquipIndex) then
    if msg.sourceCardId == 0 then
      equipmentType = (EquiptMgr.PutOnEquipment)(roleInfo, msg.sourceEquipIndex)
      isPutOn = true
    else
      ;
      (EquiptMgr.PutOffEquipment)(roleInfo, msg.sourceEquipIndex)
    end
  else
    if msg.sourceCardId == 0 then
      (EquiptMgr.PutOffEquipment)(roleInfo, msg.replaceEquipIndex)
      equipmentType = (EquiptMgr.PutOnEquipment)(roleInfo, msg.sourceEquipIndex)
      isPutOn = true
    end
  end
  ;
  (EquiptData.FilteringEquiptSet)(EquiptSetType.Change)
  ;
  (EquiptData.UpdateCardSuitInfo)(roleInfo.id)
  ;
  (CardData.ResetCardData)(roleInfo)
  if (CommonWinMgr.OpenCommonFcUp)(roleInfo.id) == false and isPutOn then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000390))
  end
  UIMgr:SendWindowMessage((WinResConfig.EquipmentWindow).name, (WindowMsgEnum.Equipt).E_MSG_REFRESH_EQUIPMENT, equipmentType)
end

-- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.PutOnEquipment = function(roleData, equipId, ...)
  -- function num : 0_5 , upvalues : _ENV
  (LuaSound.PlaySound)(LuaSound.EQUIP_ON, SoundBank.OTHER)
  ;
  (EquiptData.HandelAvailablePartsData)(equipId, nil, false)
  ;
  (EquiptData.HandleEquiptObjectIndexData)(EquiptData.AvailableEquipmentsInBag, equipId, false)
  ;
  (EquiptData.HandleEquiptObjectIndexData)(EquiptData.EquipmentsToDecompose, equipId, false)
  local equipInfo = (EquiptData.Equipments)[(EquiptData.Equipments)[equipId]]
  local config = ((TableData.gTable).BaseEquipData)[equipInfo.id]
  ;
  (EquiptData.HandelAvailablePartsData)(equipId, equipInfo.id, false)
  ;
  (EquiptData.HandleEquiptData)(EquiptData.Equipments, equipInfo, false)
  if equipInfo ~= nil then
    (table.insert)(roleData.equipInfo, equipInfo)
    return config.type
  else
    loge("equipment:" .. msg.sourceEquipIndex .. " not found")
  end
end

-- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.PutOffEquipment = function(roleData, equipId, ...)
  -- function num : 0_6 , upvalues : _ENV
  local count = #roleData.equipInfo
  local oldEquip, index = nil, nil
  for i = 1, count do
    oldEquip = (roleData.equipInfo)[i]
    if oldEquip.objectIndex == equipId then
      oldEquip.SortedAttr = (EquiptData.GetSortedAttrs)(oldEquip)
      ;
      (table.sort)(oldEquip.randomBuff, function(x, y, ...)
    -- function num : 0_6_0
    do return x < y end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
      ;
      (EquiptData.HandelAvailablePartsData)(equipId, oldEquip.id, true)
      ;
      (EquiptData.HandleEquiptObjectIndexData)(EquiptData.AvailableEquipmentsInBag, equipId, true)
      ;
      (EquiptData.HandleEquiptObjectIndexData)(EquiptData.EquipmentsToDecompose, equipId, true)
      ;
      (EquiptData.HandleEquiptData)(EquiptData.Equipments, oldEquip, true)
      ;
      (table.remove)(roleData.equipInfo, i)
      break
    end
  end
end

-- DECOMPILER ERROR at PC26: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.CheckIdentifyEquipmentsFull = function(...)
  -- function num : 0_7 , upvalues : _ENV
  if (((TableData.gTable).BaseFixedData)[EquiptData.MAX_IDENTIFY_AMOUNT]).int_value <= #EquiptData.ReadyToIdentify then
    return true
  else
    return false
  end
end

-- DECOMPILER ERROR at PC29: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.HandleEquipmentToIdentify = function(equipInfo, add, notRefresh, ...)
  -- function num : 0_8 , upvalues : _ENV
  local costInfo = split((((TableData.gTable).BaseEquipData)[equipInfo.id]).identify_cost, ",")
  local costCount = #costInfo
  local cost, id, value = nil, nil, nil
  ;
  (EquiptData.HandleEquiptData)(EquiptData.ReadyToIdentify, equipInfo, add)
  if add then
    for i = 1, costCount do
      cost = split(costInfo[i], ":")
      id = tonumber(cost[2])
      value = tonumber(cost[3])
      -- DECOMPILER ERROR at PC50: Confused about usage of register: R12 in 'UnsetPending'

      if (EquiptData.IdentifyCost)[id] == nil then
        (EquiptData.IdentifyCost)[id] = {Value = 0, Type = tonumber(cost[1])}
      end
      -- DECOMPILER ERROR at PC59: Confused about usage of register: R12 in 'UnsetPending'

      ;
      ((EquiptData.IdentifyCost)[id]).Value = ((EquiptData.IdentifyCost)[id]).Value + value
    end
  else
    do
      for i = 1, costCount do
        cost = split(costInfo[i], ":")
        id = tonumber(cost[2])
        value = tonumber(cost[3])
        -- DECOMPILER ERROR at PC92: Confused about usage of register: R12 in 'UnsetPending'

        if (EquiptData.IdentifyCost)[id] ~= nil then
          ((EquiptData.IdentifyCost)[id]).Value = ((EquiptData.IdentifyCost)[id]).Value - value
        end
      end
      do
        if not notRefresh then
          UIMgr:SendWindowMessage((WinResConfig.EquipmentWindow).name, (WindowMsgEnum.Equipt).E_MSG_REFRESH_EQUIPMENT_TO_IDENTIFY)
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC32: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.ChangeFilterSortType = function(setType, ...)
  -- function num : 0_9 , upvalues : _ENV
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

  if ((EquiptData.Filters)[setType]).SortType == EquiptSortType.Increase then
    ((EquiptData.Filters)[setType]).SortType = EquiptSortType.Decrease
  else
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((EquiptData.Filters)[setType]).SortType = EquiptSortType.Increase
  end
  ;
  (EquiptData.SortEquipmentSet)(setType)
  UIMgr:SendWindowMessage((WinResConfig.EquipmentWindow).name, (WindowMsgEnum.Equipt).E_MSG_REFRESH_EQUIPMENT_IN_BAG)
end

-- DECOMPILER ERROR at PC35: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.AfterFilterChanged = function(setType, ...)
  -- function num : 0_10 , upvalues : _ENV
  (EquiptData.FilteringEquiptSet)(setType)
  if setType == EquiptSetType.Decompose then
    UIMgr:SendWindowMessage((WinResConfig.EquipmentWindow).name, (WindowMsgEnum.Equipt).E_MSG_DISABLE_ALL_DECOMPOSE)
  end
  UIMgr:SendWindowMessage((WinResConfig.EquipmentWindow).name, (WindowMsgEnum.Equipt).E_MSG_REFRESH_EQUIPMENT_IN_BAG)
end

-- DECOMPILER ERROR at PC38: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.FilterChangeEquipments = function(data, ...)
  -- function num : 0_11 , upvalues : _ENV
  (EquiptData.ResetFilters)(EquiptSetType.Change)
  for k,v in pairs(data) do
    for subK,subV in pairs(v) do
      if subV then
        (EquiptData.ChangeFilter)(EquiptSetType.Change, k, subK, true)
      end
    end
  end
  ;
  (EquiptData.FilteringEquiptSet)(EquiptSetType.Change)
  UIMgr:SendWindowMessage((WinResConfig.EquipmentWindow).name, (WindowMsgEnum.Equipt).E_MSG_REFRESH_EQUIPMENT_IN_BAG)
end

-- DECOMPILER ERROR at PC41: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.ResetChangeFilter = function(...)
  -- function num : 0_12 , upvalues : _ENV
  (EquiptData.ResetFilters)(EquiptSetType.Change)
  ;
  (EquiptMgr.AfterFilterChanged)(EquiptSetType.Change)
end

-- DECOMPILER ERROR at PC44: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.ResetDecomposeFilter = function(...)
  -- function num : 0_13 , upvalues : _ENV
  (EquiptData.ResetFilters)(EquiptSetType.Decompose)
  ;
  (EquiptMgr.AfterFilterChanged)(EquiptSetType.Decompose)
end

-- DECOMPILER ERROR at PC47: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.ResetIdentifyFilter = function(...)
  -- function num : 0_14 , upvalues : _ENV
  (EquiptData.ResetFilters)(EquiptSetType.Identify)
  ;
  (EquiptMgr.AfterFilterChanged)(EquiptSetType.Identify)
end

-- DECOMPILER ERROR at PC50: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.ResetFilter = function(setType, ...)
  -- function num : 0_15 , upvalues : _ENV
  (EquiptData.ResetFilters)(setType)
  ;
  (EquiptMgr.AfterFilterChanged)(setType)
end

-- DECOMPILER ERROR at PC53: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.ChangeFilter = function(setType, filterType, arg1, arg2, ...)
  -- function num : 0_16 , upvalues : _ENV
  (EquiptData.ChangeFilter)(setType, filterType, arg1, arg2)
  ;
  (EquiptMgr.AfterFilterChanged)(setType)
end

-- DECOMPILER ERROR at PC56: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.SetAllEquipToDecomposeOrNot = function(decompose, ...)
  -- function num : 0_17 , upvalues : _ENV
  if decompose then
    local equipments = ((EquiptData.Filters)[EquiptSetType.Decompose]).Result
    local count = #equipments
    local config, equipInfo = nil, nil
    for i = 1, count do
      equipInfo = (EquiptData.Equipments)[(EquiptData.Equipments)[equipments[i]]]
      -- DECOMPILER ERROR at PC27: Confused about usage of register: R9 in 'UnsetPending'

      if equipInfo.lock == false then
        (EquiptData.ReadyToDecompose)[equipInfo.objectIndex] = true
        config = ((TableData.gTable).BaseEquipData)[equipInfo.id]
        -- DECOMPILER ERROR at PC41: Confused about usage of register: R9 in 'UnsetPending'

        if Const.AdvanceEquipIntelligence <= config.intelligence then
          (EquiptData.AdvanceEquiptToDecompose)[equipInfo.objectIndex] = true
        end
      end
    end
  else
    do
      ;
      (EquiptData.ResetDecomposeData)()
    end
  end
end

-- DECOMPILER ERROR at PC59: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.ChangeEquipDecomposeStatue = function(equipID, configID, add, ...)
  -- function num : 0_18 , upvalues : _ENV
  local config = ((TableData.gTable).BaseEquipData)[configID]
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R4 in 'UnsetPending'

  if add then
    (EquiptData.ReadyToDecompose)[equipID] = true
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R4 in 'UnsetPending'

    if Const.AdvanceEquipIntelligence <= config.intelligence then
      (EquiptData.AdvanceEquiptToDecompose)[equipID] = true
    end
  else
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (EquiptData.ReadyToDecompose)[equipID] = nil
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R4 in 'UnsetPending'

    if Const.AdvanceEquipIntelligence <= config.intelligence then
      (EquiptData.AdvanceEquiptToDecompose)[equipID] = nil
    end
  end
end

-- DECOMPILER ERROR at PC62: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.TryDecomposeEquips = function(...)
  -- function num : 0_19 , upvalues : _ENV
  local equips = {}
  for k,v in pairs(EquiptData.ReadyToDecompose) do
    (table.insert)(equips, k)
  end
  if #equips == 0 then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000070))
    return 
  end
  if (_G.next)(EquiptData.AdvanceEquiptToDecompose) ~= nil then
    (MessageMgr.OpenConfirmWindow)((PUtil.get)(60000078), function(...)
    -- function num : 0_19_0 , upvalues : _ENV, equips
    (EquiptService.ReqDestroyEquip)(equips)
  end
, nil, (PUtil.get)(60000079))
  else
    ;
    (EquiptService.ReqDestroyEquip)(equips)
  end
end

-- DECOMPILER ERROR at PC65: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.SetAllEquipToIdentifyOrNot = function(identify, ...)
  -- function num : 0_20 , upvalues : _ENV
  if identify then
    local equipments = ((EquiptData.Filters)[EquiptSetType.Identify]).Result
    local count = #equipments
    local config, equipInfo = nil, nil
    for i = 1, count do
      equipInfo = (EquiptData.Equipments)[(EquiptData.Equipments)[equipments[i]]]
      if (EquiptData.ReadyToIdentify)[equipments[i]] == nil then
        (EquiptMgr.HandleEquipmentToIdentify)(equipInfo, true, true)
      end
    end
    do
      if not (EquiptMgr.CheckIdentifyEquipmentsFull)() then
        do
          UIMgr:SendWindowMessage((WinResConfig.EquipmentWindow).name, (WindowMsgEnum.Equipt).E_MSG_REFRESH_EQUIPMENT_TO_IDENTIFY)
          ;
          (EquiptMgr.ResetIdentifyData)()
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC68: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.TryIdentifyEquips = function(...)
  -- function num : 0_21 , upvalues : _ENV
  if EquiptData.Identifying then
    return 
  end
  local count = #EquiptData.ReadyToIdentify
  if count == 0 then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000324))
    return 
  end
  local costStr = ""
  for k,v in pairs(EquiptData.IdentifyCost) do
    costStr = costStr .. v.Type .. ":" .. k .. ":" .. v.Value .. ","
  end
  costStr = (string.sub)(costStr, 1, -2)
  if not (Util.CheckCostResources)(costStr) then
    return 
  end
  local equipments = {}
  for i = 1, count do
    (table.insert)(equipments, ((EquiptData.ReadyToIdentify)[i]).objectIndex)
  end
  -- DECOMPILER ERROR at PC63: Confused about usage of register: R3 in 'UnsetPending'

  EquiptData.Identifying = true
  ;
  (SimpleTimer.setTimeout)(1, function(...)
    -- function num : 0_21_0 , upvalues : _ENV
    -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

    EquiptData.Identifying = false
  end
)
  ;
  (EquiptService.ReqIdentifyEquip)(equipments)
end

-- DECOMPILER ERROR at PC71: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.RecvIdentifyEquips = function(equipmentList, ...)
  -- function num : 0_22 , upvalues : _ENV
  (LuaSound.PlaySound)(LuaSound.EQUIP_IDENTIFY, SoundBank.OTHER)
  ;
  (EquiptMgr.ResetIdentifyData)()
  local data = nil
  local count = #equipmentList
  for i = 1, count do
    data = equipmentList[i]
    data.SortedAttr = (EquiptData.GetSortedAttrs)(data)
    ;
    (table.sort)(data.randomBuff, function(x, y, ...)
    -- function num : 0_22_0
    do return x < y end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (EquiptData.NewEquipments)[data.objectIndex] = true
    -- DECOMPILER ERROR at PC37: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (EquiptData.Equipments)[(EquiptData.Equipments)[data.objectIndex]] = data
    ;
    (EquiptData.HandelAvailablePartsData)(data.objectIndex, data.id, true)
    ;
    (EquiptData.HandleEquiptObjectIndexData)(EquiptData.AvailableEquipmentsInBag, data.objectIndex, true)
    ;
    (EquiptData.HandleEquiptObjectIndexData)(EquiptData.UnidentifiedEquipments, data.objectIndex, false)
  end
  ;
  (EquiptData.FilteringEquiptSet)(EquiptSetType.Identify)
  UIMgr:SendWindowMessage((WinResConfig.EquipmentWindow).name, (WindowMsgEnum.Equipt).E_MSG_PLAY_IDENTIFY_EFFECT, function(...)
    -- function num : 0_22_1 , upvalues : _ENV
    UIMgr:SendWindowMessage((WinResConfig.EquipmentWindow).name, (WindowMsgEnum.Equipt).E_MSG_REFRESH_EQUIPMENT_IN_BAG)
    UIMgr:SendWindowMessage((WinResConfig.EquipmentWindow).name, (WindowMsgEnum.Equipt).E_MSG_REFRESH_ALL_CHOOSE_BTN)
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R0 in 'UnsetPending'

    EquiptData.Identifying = false
    ;
    (MessageMgr.SendCenterTips)((PUtil.get)(60000337))
  end
)
end

-- DECOMPILER ERROR at PC74: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.ResetIdentifyData = function(...)
  -- function num : 0_23 , upvalues : _ENV
  (EquiptData.ResetIdentifyCost)()
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  EquiptData.ReadyToIdentify = {}
end

-- DECOMPILER ERROR at PC77: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.GetDetailPanel = function(...)
  -- function num : 0_24 , upvalues : _detailPanelPool, _ENV
  local panelGrp = nil
  if #_detailPanelPool == 0 then
    local panel = (UIPackage.CreateObject)("Equipt", "EquiptPop")
    panelGrp = GetEquipt_EquiptPopUis(panel)
    panelGrp.PopImage = (panelGrp.root):GetChild("n33")
  else
    do
      panelGrp = (table.remove)(_detailPanelPool, #_detailPanelPool)
      -- DECOMPILER ERROR at PC28: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (panelGrp.root).visible = true
      return panelGrp
    end
  end
end

-- DECOMPILER ERROR at PC80: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.RecyclePanel = function(panel, ...)
  -- function num : 0_25 , upvalues : _ENV, _detailPanelPool
  if panel == nil then
    return 
  end
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (panel.root).visible = false
  ;
  (table.insert)(_detailPanelPool, panel)
end

-- DECOMPILER ERROR at PC83: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.SetEquipDetailPanel = function(panel, equipInfo, equipConfig, type, cardID, srcEquipInfo, ...)
  -- function num : 0_26 , upvalues : _ENV
  if equipInfo == nil then
    return 
  end
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R6 in 'UnsetPending'

  if EquiptData.EquipPanelBottomBlankSize == 0 then
    EquiptData.EquipPanelBottomBlankSize = (panel.root).height - (panel.ReplaceBtn).y - (panel.ReplaceBtn).height * 0.5
  end
  if equipConfig == nil then
    equipConfig = ((TableData.gTable).BaseEquipData)[equipInfo.id]
  end
  ;
  (EquiptMgr.SetDetailBasicInfo)(panel, equipInfo, equipConfig, cardID)
  local bottomGComponent, percent = (EquiptMgr.SetDetailStatue)(equipInfo, panel, type)
  ;
  (EquiptMgr.SetAttrs)(panel, equipInfo, srcEquipInfo)
  ;
  (EquiptMgr.CheckPopListSize)(panel, bottomGComponent, percent)
end

-- DECOMPILER ERROR at PC86: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.CheckPopListSize = function(panel, bottomGComponent, percent, ...)
  -- function num : 0_27 , upvalues : _ENV
  local size = bottomGComponent.y + bottomGComponent.height * percent + EquiptData.EquipPanelBottomBlankSize
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R4 in 'UnsetPending'

  if EquiptData.MAX_EQUIP_PANEL_SIZE < size then
    (panel.PopList).height = (panel.PopList).height - (size - EquiptData.MAX_EQUIP_PANEL_SIZE)
  end
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (panel.PopImage).height = size
end

-- DECOMPILER ERROR at PC89: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.SetPanelSize = function(panel, bottomGComponent, ...)
  -- function num : 0_28 , upvalues : _ENV
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  (panel.PopImage).height = bottomGComponent.y + bottomGComponent.height + EquiptData.EquipPanelBottomBlankSize
end

-- DECOMPILER ERROR at PC92: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.SetDetailBasicInfo = function(panel, equipInfo, equipConfig, cardID, ...)
  -- function num : 0_29 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R4 in 'UnsetPending'

  (panel.NameTxt).text = equipConfig.name
  ;
  (Util.SetEquipFrame)((panel.EquiptIcon).root, equipInfo)
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R4 in 'UnsetPending'

  if equipConfig.card_id > 1 then
    (panel.ExclusiveTxt).text = (((TableData.gTable).BaseCardData)[equipConfig.card_id]).name .. (PUtil.get)(60000061)
  else
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (panel.ExclusiveTxt).text = ""
  end
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (panel.LockBtn).selected = equipInfo.lock
  ;
  ((panel.LockBtn).onClick):Set(function(...)
    -- function num : 0_29_0 , upvalues : _ENV, equipInfo, cardID, panel
    (EquiptService.ReqLockEquip)(equipInfo.objectIndex, cardID, (panel.LockBtn).selected)
  end
)
end

-- DECOMPILER ERROR at PC95: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.SetDetailStatue = function(equipInfo, panel, type, ...)
  -- function num : 0_30 , upvalues : _ENV
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R3 in 'UnsetPending'

  if equipInfo.identify == false or type == EquiptDetailPanelType.NoButton then
    (panel.ReplaceBtn).visible = false
    return panel.PopList, 1
  else
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (panel.ReplaceBtn).visible = true
    return panel.ReplaceBtn, 0.5
  end
end

-- DECOMPILER ERROR at PC98: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.SetAttrs = function(panel, equipInfo, srcEquipInfo, ...)
  -- function num : 0_31 , upvalues : _ENV
  (panel.PopList):RemoveChildrenToPool()
  local height = ((panel.PopList).margin).top
  if equipInfo.identify then
    height = height + (EquiptMgr.SetDetailAttrs)(panel.PopList, equipInfo, srcEquipInfo)
    height = height + (EquiptMgr.SetBuffAttrs)(panel.PopList, equipInfo)
  end
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (panel.PopList).height = height
end

-- DECOMPILER ERROR at PC101: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.SetDetailAttrs = function(list, equipInfo, srcEquipInfo, ...)
  -- function num : 0_32 , upvalues : _ENV
  local attrInfo = {}
  local height = 0
  if srcEquipInfo ~= nil then
    local equipAttr = (EquiptMgr.GetEquipmentAttrs)(equipInfo)
    local srcEquipAttr = (EquiptMgr.GetEquipmentAttrs)(srcEquipInfo)
    for k,v in pairs(equipAttr) do
      if srcEquipAttr[k] == nil then
        attrInfo[k] = EquiptAttrStatusType.New
      else
        if srcEquipAttr[k] < v then
          attrInfo[k] = EquiptAttrStatusType.Promote
        else
          if v < srcEquipAttr[k] then
            attrInfo[k] = EquiptAttrStatusType.Demote
          end
        end
      end
    end
  end
  do
    local datas = {}
    local item, config, itemSize, attrs, attrId = nil, nil, nil, nil, nil
    if equipInfo.mainAttrId ~= 0 then
      height = (EquiptMgr.AddSeperater)(list, 60000445) + list.lineGap
      height = height + (EquiptMgr.AddSingleAttr)(list, equipInfo.mainAttrId, attrInfo)
    end
    local count = #equipInfo.randomAttrId
    for i = 1, count do
      (table.insert)(datas, (equipInfo.randomAttrId)[i])
    end
    ;
    (table.sort)(datas, EquiptData.SortEquiptAttr)
    local count = #datas
    for i = 1, count do
      height = height + list.lineGap
      if i == 1 then
        height = height + (EquiptMgr.AddSeperater)(list, 60000446) + list.lineGap
      end
      height = height + (EquiptMgr.AddSingleAttr)(list, datas[i], attrInfo)
    end
    return height
  end
end

-- DECOMPILER ERROR at PC104: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.AddSeperater = function(list, content, ...)
  -- function num : 0_33 , upvalues : _ENV
  local seperater = list:AddItemFromPool((UIPackage.GetItemURL)((WinResConfig.EquipmentWindow).package, EquiptData.LINE_A_RESOURCE))
  ;
  (seperater:GetChild("n32")).text = (PUtil.get)(content)
  return seperater.height
end

-- DECOMPILER ERROR at PC107: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.GetEquipmentAttrs = function(equipInfo, ...)
  -- function num : 0_34 , upvalues : _ENV
  local result = {}
  local config, attrs = nil, nil
  if equipInfo.mainAttrId ~= 0 then
    config = ((TableData.gTable).BaseEquipAttributeData)[equipInfo.mainAttrId]
    attrs = split(config.value, ":")
    result[tonumber(attrs[2])] = tonumber(attrs[3])
  end
  local count = #equipInfo.randomAttrId
  for i = 1, count do
    config = ((TableData.gTable).BaseEquipAttributeData)[(equipInfo.randomAttrId)[i]]
    attrs = split(config.value, ":")
    if result[tonumber(attrs[2])] == nil then
      result[tonumber(attrs[2])] = tonumber(attrs[3])
    else
      result[tonumber(attrs[2])] = result[tonumber(attrs[2])] + tonumber(attrs[3])
    end
  end
  return result
end

-- DECOMPILER ERROR at PC110: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.AddSingleAttr = function(list, equipAttrId, attrInfo, ...)
  -- function num : 0_35 , upvalues : _ENV
  local item, config, attrs, attrId = nil, nil, nil, nil
  config = ((TableData.gTable).BaseEquipAttributeData)[equipAttrId]
  attrs = split(config.value, ":")
  attrId = tonumber(attrs[2])
  local item = list:AddItemFromPool((UIPackage.GetItemURL)((WinResConfig.EquipmentWindow).package, EquiptData.LIST_A_RESOURCE))
  ;
  (item:GetController("c1")).selectedIndex = EquiptData.MAX_ATTR_QUALITY_AMOUNT - config.level
  if status == nil then
    (item:GetController("c2")).selectedIndex = EquiptAttrStatusType.Normal
  else
    ;
    (item:GetController("c2")).selectedIndex = attrInfo[attrId]
  end
  local attrConfig = ((TableData.gTable).BaseAttributeData)[attrId]
  if attrConfig.type ~= 0 then
    (item:GetChild("NameTxt")).text = "[color=" .. EquiptAttrColor[attrConfig.type] .. "]" .. attrConfig.display_name .. "[/color]"
    ;
    (item:GetChild("NumberTxt")).text = "[color=" .. EquiptAttrColor[attrConfig.type] .. "]" .. attrs[3] .. "[/color]"
  else
    ;
    (item:GetChild("NameTxt")).text = attrConfig.display_name
    ;
    (item:GetChild("NumberTxt")).text = attrs[3]
  end
  return item.height
end

-- DECOMPILER ERROR at PC113: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.SetBuffAttrs = function(list, equipInfo, ...)
  -- function num : 0_36 , upvalues : _ENV
  local count = #equipInfo.randomBuff
  local item, config = nil, nil
  local height = 0
  for i = 1, count do
    height = height + list.lineGap
    if i == 1 then
      height = height + (EquiptMgr.AddSeperater)(list, 60000447) + list.lineGap
    end
    height = height + (EquiptMgr.AddSingleBuff)(list, (equipInfo.randomBuff)[i])
  end
  return height
end

-- DECOMPILER ERROR at PC116: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.AddSingleBuff = function(list, id, ...)
  -- function num : 0_37 , upvalues : _ENV
  local item = list:AddItemFromPool((UIPackage.GetItemURL)((WinResConfig.EquipmentWindow).package, EquiptData.LIST_B_RESOURCE))
  local config = ((TableData.gTable).BaseBuffPreBattleData)[id]
  ;
  (item:GetChild("WordTxt")).text = config.remark
  return item.height
end

-- DECOMPILER ERROR at PC119: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.TryUpgradeEquipment = function(equipInfo, cardId, expCost, coinCost, ...)
  -- function num : 0_38 , upvalues : _ENV
  if (Util.CheckAssetByType)(coinCost, AssetType.GOLD) == false then
    return 
  end
  if (Util.CheckAssetByType)(expCost, AssetType.EQUIP_EXP) == false then
    return 
  end
  ;
  (EquiptService.ReqLevelUpEquip)(equipInfo.objectIndex, cardId, 1)
end

-- DECOMPILER ERROR at PC122: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.TryFullyUpgradeEquipment = function(equipInfo, equipConfig, cardId, ...)
  -- function num : 0_39 , upvalues : _ENV
  local maxLevel = ((EquiptData.UpgradeConfig)[equipConfig.grow_type]).MaxLevel
  local coinCost = 0
  local expCost = 0
  local cost = nil
  for i = equipInfo.level, maxLevel do
    cost = ((EquiptData.UpgradeConfig)[equipConfig.grow_type])[i]
    coinCost = coinCost + cost.next_gold
    expCost = expCost + cost.next_exp
  end
  if (Util.CheckAssetByType)(coinCost, AssetType.GOLD) == false then
    return 
  end
  if (Util.CheckAssetByType)(expCost, AssetType.EQUIP_EXP) == false then
    return 
  end
  local times = maxLevel - equipInfo.level
  ;
  (EquiptService.ReqLevelUpEquip)(equipInfo.objectIndex, cardId, times)
end

-- DECOMPILER ERROR at PC125: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.CheckShowEquipBagConfirm = function(acquireType, callback, ...)
  -- function num : 0_40 , upvalues : _ENV
  local args = {...}
  local rewards = {}
  local rewardsInfo, eachReward, count, config = nil, nil, nil, nil
  local haveEquips = false
  if args[1] ~= nil and args[1] == true then
    haveEquips = true
  else
    for k,v in pairs(args) do
      if type(v) == "table" then
        for subk,subv in pairs(v) do
          subv.RewardType = 1
          ;
          (table.insert)(rewards, subv)
        end
      else
        do
          rewardsInfo = split(v, ",")
          count = #rewardsInfo
          for i = 1, count do
            eachReward = split(rewardsInfo[i], ":")
            -- DECOMPILER ERROR at PC70: Unhandled construct in 'MakeBoolean' P1

            if #eachReward == 3 and tonumber(eachReward[1]) == PropType.EQUIP then
              (table.insert)(rewards, {RewardType = 1, Id = tonumber(eachReward[2])})
            end
            -- DECOMPILER ERROR at PC91: Unhandled construct in 'MakeBoolean' P1

            if #eachReward == 2 and tonumber(eachReward[1]) == PropType.EQUIP then
              (table.insert)(rewards, {RewardType = 1, Id = tonumber(eachReward[2])})
            end
            if #eachReward == 1 then
              (table.insert)(rewards, {RewardType = 2, GroupId = tonumber(eachReward[1])})
            end
          end
          do
            -- DECOMPILER ERROR at PC107: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC107: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC107: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
    count = #rewards
    for i = 1, count do
      -- DECOMPILER ERROR at PC126: Unhandled construct in 'MakeBoolean' P1

      if (rewards[i]).RewardType == 1 and ((TableData.gTable).BaseEquipData)[(rewards[i]).Id] ~= nil then
        haveEquips = true
        break
      end
      if (rewards[i]).RewardType == 2 then
        config = ((TableData.gTable).BaseDropGroupData)[(rewards[i]).GroupId]
        if config ~= nil and config.equips ~= "0" then
          haveEquips = true
          break
        end
      end
    end
  end
  do
    if haveEquips or haveEquips then
      if EquiptData.MaxBagSlots <= #EquiptData.Equipments then
        if acquireType == EquiptAcquireType.Shop then
          (MessageMgr.OpenConfirmWindow)((PUtil.get)(60000345), function(...)
    -- function num : 0_40_0 , upvalues : _ENV
    (EquiptMgr.OpenEquipmentWindow)(EquiptOpenType.Decompose)
  end
)
        else
          if acquireType == EquiptAcquireType.Gift then
            (MessageMgr.OpenConfirmWindow)((PUtil.get)(60000346), function(...)
    -- function num : 0_40_1 , upvalues : _ENV
    (EquiptMgr.OpenEquipmentWindow)(EquiptOpenType.Decompose)
  end
)
          else
            if acquireType == EquiptAcquireType.Lottory then
              (MessageMgr.OpenConfirmWindow)((PUtil.get)(60000347), function(...)
    -- function num : 0_40_2 , upvalues : _ENV
    (EquiptMgr.OpenEquipmentWindow)(EquiptOpenType.Decompose)
  end
)
            else
              ;
              (MessageMgr.OpenConfirmWindow)((PUtil.get)(60000077), function(...)
    -- function num : 0_40_3 , upvalues : _ENV
    (EquiptMgr.OpenEquipmentWindow)(EquiptOpenType.Decompose)
  end
, callback, (PUtil.get)(60000003), (PUtil.get)(60000072), (PUtil.get)(60000008))
            end
          end
        end
        return true
      else
        if callback ~= nil then
          callback()
        end
        return false
      end
    else
      if callback ~= nil then
        callback()
      end
      return false
    end
  end
end

-- DECOMPILER ERROR at PC128: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.TryChangeEquipment = function(id, carId, equipType, ...)
  -- function num : 0_41 , upvalues : _ENV
  (EquiptService.ReqPutOnEquip)(id, 0, carId)
end

-- DECOMPILER ERROR at PC131: Confused about usage of register: R1 in 'UnsetPending'

EquiptMgr.InitEquiptMainRedDot = function(...)
  -- function num : 0_42 , upvalues : _ENV
  local data, show = (EquiptData.GetRedDotList)()
  if show then
    (RedDotMgr.ProcessRedDot)(RedDotComID.Equipt_Role_List, data, true)
  else
    ;
    (RedDotMgr.ProcessRedDot)(RedDotComID.Equipt_Role_List, data, false)
  end
end


