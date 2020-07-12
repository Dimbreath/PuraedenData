-- params : ...
-- function num : 0 , upvalues : _ENV
TowerData = {}
TowerRewardChanceType = {Normal = 0, Rare = 1, SuperRare = 2}
-- DECOMPILER ERROR at PC8: Confused about usage of register: R0 in 'UnsetPending'

TowerData.TOWER_RESOURCES_PREFIX = "SkyTower"
-- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

TowerData.REWARD_ITEM_RESOURCE = "CommonResource:AllItemIcon"
-- DECOMPILER ERROR at PC12: Confused about usage of register: R0 in 'UnsetPending'

TowerData.REWARD_SEPARATOR = "Tower:CutLine"
-- DECOMPILER ERROR at PC14: Confused about usage of register: R0 in 'UnsetPending'

TowerData.EACH_LAYER_STAGES = 4
-- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

TowerData.BaseInfo = nil
-- DECOMPILER ERROR at PC18: Confused about usage of register: R0 in 'UnsetPending'

TowerData.FormationInfo = nil
-- DECOMPILER ERROR at PC21: Confused about usage of register: R0 in 'UnsetPending'

TowerData.TowerLayerData = {}
-- DECOMPILER ERROR at PC24: Confused about usage of register: R0 in 'UnsetPending'

TowerData.TowerStageData = {}
-- DECOMPILER ERROR at PC26: Confused about usage of register: R0 in 'UnsetPending'

TowerData.CurrentLucky = 0
-- DECOMPILER ERROR at PC28: Confused about usage of register: R0 in 'UnsetPending'

TowerData.CurrentLayer = 0
-- DECOMPILER ERROR at PC30: Confused about usage of register: R0 in 'UnsetPending'

TowerData.UnlockLayer = 0
-- DECOMPILER ERROR at PC33: Confused about usage of register: R0 in 'UnsetPending'

TowerData.UnlockStage = {}
-- DECOMPILER ERROR at PC36: Confused about usage of register: R0 in 'UnsetPending'

TowerData.TowerLayerNumber = {}
-- DECOMPILER ERROR at PC39: Confused about usage of register: R0 in 'UnsetPending'

TowerData.TowerStageNumber = {}
-- DECOMPILER ERROR at PC41: Confused about usage of register: R0 in 'UnsetPending'

TowerData.LastReqStageId = 0
-- DECOMPILER ERROR at PC43: Confused about usage of register: R0 in 'UnsetPending'

TowerData.HaveBounsLevel = false
-- DECOMPILER ERROR at PC45: Confused about usage of register: R0 in 'UnsetPending'

TowerData.BounsLevelData = nil
-- DECOMPILER ERROR at PC47: Confused about usage of register: R0 in 'UnsetPending'

TowerData.PopUpBounsLevel = false
-- DECOMPILER ERROR at PC50: Confused about usage of register: R0 in 'UnsetPending'

TowerData.InitData = function(...)
  -- function num : 0_0 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

  TowerData.TowerLayerData = {}
  local config, preConfig = nil, nil
  for k,v in pairs((TableData.gTable).BaseTowerData) do
    if v.pre == 0 then
      config = v
      break
    end
  end
  do
    repeat
      (table.insert)(TowerData.TowerLayerData, config.id)
      -- DECOMPILER ERROR at PC29: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (TowerData.TowerLayerNumber)[config.id] = #TowerData.TowerLayerData
      config = ((TableData.gTable).BaseTowerData)[config.next]
    until config == nil
    -- DECOMPILER ERROR at PC39: Confused about usage of register: R2 in 'UnsetPending'

    TowerData.TowerStageData = {}
    for k,v in pairs((TableData.gTable).BaseTowerStageData) do
      -- DECOMPILER ERROR at PC68: Confused about usage of register: R7 in 'UnsetPending'

      if (TowerData.TowerStageData)[v.tower_id] == nil and (v.pre == 0 or (((TableData.gTable).BaseTowerStageData)[v.pre]).tower_id ~= v.tower_id) then
        (TowerData.TowerStageData)[v.tower_id] = {}
        -- DECOMPILER ERROR at PC73: Confused about usage of register: R7 in 'UnsetPending'

        ;
        (TowerData.TowerStageNumber)[v.tower_id] = {}
        config = v
        repeat
          (table.insert)((TowerData.TowerStageData)[v.tower_id], config.id)
          -- DECOMPILER ERROR at PC93: Confused about usage of register: R7 in 'UnsetPending'

          ;
          ((TowerData.TowerStageNumber)[v.tower_id])[config.id] = #(TowerData.TowerStageData)[v.tower_id]
          config = ((TableData.gTable).BaseTowerStageData)[config.next]
        until config == nil or config.tower_id ~= v.tower_id
      end
    end
  end
end

-- DECOMPILER ERROR at PC53: Confused about usage of register: R0 in 'UnsetPending'

TowerData.InitTowerData = function(data, ...)
  -- function num : 0_1 , upvalues : _ENV
  local count = #data
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R2 in 'UnsetPending'

  TowerData.BaseInfo = {}
  local eachData, subCount, actualCount, subData, noPass = nil, nil, nil, nil, nil
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R7 in 'UnsetPending'

  TowerData.UnlockLayer = 1
  for i = 1, count do
    eachData = data[i]
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R11 in 'UnsetPending'

    ;
    (TowerData.BaseInfo)[eachData.towerId] = {}
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R11 in 'UnsetPending'

    ;
    (TowerData.UnlockStage)[eachData.towerId] = 0
    noPass = true
    -- DECOMPILER ERROR at PC35: Confused about usage of register: R11 in 'UnsetPending'

    if TowerData.UnlockLayer < (TowerData.TowerLayerNumber)[eachData.towerId] then
      TowerData.UnlockLayer = (TowerData.TowerLayerNumber)[eachData.towerId]
    end
    subCount = #eachData.towerSatge
    for j = 1, subCount do
      subData = (eachData.towerSatge)[j]
      -- DECOMPILER ERROR at PC49: Confused about usage of register: R15 in 'UnsetPending'

      ;
      ((TowerData.BaseInfo)[eachData.towerId])[subData.towerStageId] = subData
      -- DECOMPILER ERROR at PC58: Confused about usage of register: R15 in 'UnsetPending'

      ;
      (TowerData.UnlockStage)[eachData.towerId] = (TowerData.UnlockStage)[eachData.towerId] + 1
    end
  end
  -- DECOMPILER ERROR at PC67: Confused about usage of register: R7 in 'UnsetPending'

  TowerData.CurrentLayer = (TowerData.TowerLayerData)[TowerData.UnlockLayer]
  ;
  (TowerData.InitLuckyInfo)()
end

-- DECOMPILER ERROR at PC56: Confused about usage of register: R0 in 'UnsetPending'

TowerData.InitLuckyInfo = function(...)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  TowerData.CurrentLucky = (CardData.GetFormationLucky)(TowerData.FormationInfo)
end

-- DECOMPILER ERROR at PC59: Confused about usage of register: R0 in 'UnsetPending'

TowerData.UpdateTowerData = function(data, ...)
  -- function num : 0_3 , upvalues : _ENV
  if data.towerStage == nil then
    return 
  end
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((TowerData.BaseInfo)[TowerData.CurrentLayer])[(data.towerStage).towerStageId] = data.towerStage
  if data.nextTowerStage ~= nil then
    local count = #(TowerData.TowerStageData)[TowerData.CurrentLayer]
    local layerId = nil
    for i = 1, count do
      if ((TowerData.TowerStageData)[TowerData.CurrentLayer])[i] == (data.nextTowerStage).towerStageId then
        layerId = TowerData.CurrentLayer
        break
      end
    end
    do
      -- DECOMPILER ERROR at PC47: Confused about usage of register: R3 in 'UnsetPending'

      if layerId == nil then
        TowerData.UnlockLayer = TowerData.UnlockLayer + 1
        layerId = (TowerData.TowerLayerData)[TowerData.UnlockLayer]
        -- DECOMPILER ERROR at PC56: Confused about usage of register: R3 in 'UnsetPending'

        ;
        (TowerData.BaseInfo)[layerId] = {}
        -- DECOMPILER ERROR at PC59: Confused about usage of register: R3 in 'UnsetPending'

        ;
        (TowerData.UnlockStage)[layerId] = 1
      else
        -- DECOMPILER ERROR at PC71: Confused about usage of register: R3 in 'UnsetPending'

        ;
        (TowerData.UnlockStage)[TowerData.CurrentLayer] = (TowerData.UnlockStage)[TowerData.CurrentLayer] + 1
      end
      -- DECOMPILER ERROR at PC78: Confused about usage of register: R3 in 'UnsetPending'

      ;
      ((TowerData.BaseInfo)[layerId])[(data.nextTowerStage).towerStageId] = data.nextTowerStage
      -- DECOMPILER ERROR at PC85: Confused about usage of register: R3 in 'UnsetPending'

      if (TowerData.UnlockStage)[layerId] == 1 then
        TowerData.CurrentLayer = layerId
      end
    end
  end
end

-- DECOMPILER ERROR at PC62: Confused about usage of register: R0 in 'UnsetPending'

TowerData.GetReward = function(layer, stage, ...)
  -- function num : 0_4 , upvalues : _ENV
  local detail, count = nil, nil
  local basicReward = {}
  local config = ((TableData.gTable).BaseTowerStageData)[stage]
  if (TowerData.BaseInfo)[layer] == nil or ((TowerData.BaseInfo)[layer])[stage] == nil or (((TowerData.BaseInfo)[layer])[stage]).isPass == false then
    detail = split(config.first_reward, ",")
    count = #detail
    for i = 1, count do
      (table.insert)(basicReward, (TowerData.GetRewardItem)(true, detail[i]))
    end
  end
  do
    detail = split(config.drop_show, ",")
    count = #detail
    local item = nil
    for i = 1, count do
      (table.insert)(basicReward, (TowerData.GetRewardItem)(false, detail[i]))
    end
    local luckyReward = {}
    detail = split(config.ext_drop_show, ",")
    count = #detail
    for i = 1, count do
      item = (TowerData.GetRewardItem)(false, detail[i], true)
      ;
      (table.insert)(luckyReward, item)
    end
    return basicReward, luckyReward
  end
end

-- DECOMPILER ERROR at PC65: Confused about usage of register: R0 in 'UnsetPending'

TowerData.GetRewardItem = function(first, data, lucky, ...)
  -- function num : 0_5 , upvalues : _ENV
  local item = {}
  item.First = first
  local info = split(data, ":")
  item.Id = tonumber(info[2])
  item.Type = tonumber(info[1])
  item.LuckyCondition = 0
  item.Lucky = lucky or false
  local value = tonumber(info[3])
  if first then
    item.Amount = value
  else
    -- DECOMPILER ERROR at PC32: Unhandled construct in 'MakeBoolean' P1

    if lucky and TowerData.CurrentLucky < value then
      item.LuckyCondition = value
    end
  end
  item.Chance = value
  return item
end

-- DECOMPILER ERROR at PC68: Confused about usage of register: R0 in 'UnsetPending'

TowerData.GetActualReward = function(data, ...)
  -- function num : 0_6 , upvalues : _ENV
  local basicReward = {}
  local extraReward = {}
  local firstReward = {}
  local goods = {}
  local count, eachData = nil, nil
  if data.isFirst then
    count = #data.firstGoods
    for i = 1, count do
      eachData = (data.firstGoods)[i]
      if eachData.type == PropType.EQUIP or goods[eachData.id] == nil then
        (table.insert)(firstReward, (TowerData.GetActualRewardItem)(true, eachData.id, eachData.value, eachData.type))
        goods[eachData.id] = #firstReward
      else
        -- DECOMPILER ERROR at PC49: Confused about usage of register: R11 in 'UnsetPending'

        ;
        (firstReward[goods[eachData.id]]).Amount = (firstReward[goods[eachData.id]]).Amount + eachData.value
      end
    end
  end
  do
    ;
    (table.sort)(firstReward, TowerData.Sort)
    goods = {}
    local basicGoods = {}
    count = #data.basicGoods
    for i = 1, count do
      eachData = (data.basicGoods)[i]
      if eachData.type == PropType.EQUIP or goods[eachData.id] == nil then
        (table.insert)(basicGoods, (TowerData.GetActualRewardItem)(false, eachData.id, eachData.value, eachData.type))
        goods[eachData.id] = #basicGoods
      else
        -- DECOMPILER ERROR at PC101: Confused about usage of register: R12 in 'UnsetPending'

        ;
        (basicGoods[goods[eachData.id]]).Amount = (basicGoods[goods[eachData.id]]).Amount + eachData.value
      end
    end
    ;
    (table.sort)(basicGoods, TowerData.Sort)
    count = #basicGoods
    for i = 1, count do
      (table.insert)(basicReward, basicGoods[i])
    end
    goods = {}
    count = #data.extGoods
    local eachData = nil
    for i = 1, count do
      eachData = (data.extGoods)[i]
      if eachData.type == PropType.EQUIP or goods[eachData.id] == nil then
        (table.insert)(extraReward, (TowerData.GetActualRewardItem)(false, eachData.id, eachData.value, eachData.type))
        goods[eachData.id] = #extraReward
      else
        -- DECOMPILER ERROR at PC164: Confused about usage of register: R13 in 'UnsetPending'

        ;
        (extraReward[goods[eachData.id]]).Amount = (extraReward[goods[eachData.id]]).Amount + eachData.value
      end
    end
    ;
    (table.sort)(extraReward, TowerData.Sort)
    return basicReward, extraReward, firstReward
  end
end

-- DECOMPILER ERROR at PC71: Confused about usage of register: R0 in 'UnsetPending'

TowerData.Sort = function(x, y, ...)
  -- function num : 0_7 , upvalues : _ENV
  local xWeight = x.Type
  if xWeight == PropType.ITEM then
    xWeight = 2
  else
    if xWeight == PropType.ASSET then
      xWeight = 1
    end
  end
  local yWeight = y.Type
  if yWeight == PropType.ITEM then
    yWeight = 2
  else
    if yWeight == PropType.ASSET then
      yWeight = 1
    end
  end
  if xWeight == yWeight and x.Type == PropType.EQUIP then
    local xConfig = ((TableData.gTable).BaseEquipData)[x.Id]
    local yConfig = ((TableData.gTable).BaseEquipData)[y.Id]
    return yConfig.star < xConfig.star
  else
    return yWeight < xWeight
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC74: Confused about usage of register: R0 in 'UnsetPending'

TowerData.GetActualRewardItem = function(first, id, amount, type, ...)
  -- function num : 0_8
  local item = {}
  item.First = first
  item.Id = id
  item.Amount = amount
  item.Type = type
  return item
end

-- DECOMPILER ERROR at PC77: Confused about usage of register: R0 in 'UnsetPending'

TowerData.GetCurrentTowerBGAndBGM = function(...)
  -- function num : 0_9 , upvalues : _ENV
  local config = ((TableData.gTable).BaseTowerData)[TowerData.CurrentLayer]
  return config.background_path, config.bgm_id
end

;
(TowerData.InitData)()

