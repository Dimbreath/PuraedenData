-- params : ...
-- function num : 0 , upvalues : _ENV
local TableData = {delayClear = false}
local require = require
local pairs = pairs
local package = package
local splitTableNameCache = TableData.splitTableNameCache
TableData.GetDataFromSplitTable = function(table_name, key, ...)
  -- function num : 0_0 , upvalues : _ENV, splitTableNameCache, TableData
  local t = _G[table_name]
  if not t then
    return nil
  end
  if t.maxId < key or key < t.minId then
    return nil
  end
  if not splitTableNameCache then
    splitTableNameCache = {}
  end
  splitTableNameCache[table_name] = key
  return (TableData.GetDataFromSplitTableByType)(table_name, key, 20)
end

TableData.GetDataFromSplitTableByType = function(tableName, key, clear_t, ...)
  -- function num : 0_1 , upvalues : _ENV, package, require
  local t = _G[tableName]
  local index = (math.floor)((key - t.minId) / t.step)
  local childTableName = tableName .. "Part" .. index
  if not t.childCache then
    t.childCache = {}
  end
  local child_t = (t.childCache)[childTableName]
  do
    if not child_t then
      local filepath = childTableName
      -- DECOMPILER ERROR at PC24: Confused about usage of register: R8 in 'UnsetPending'

      ;
      (package.loaded)[filepath] = nil
      require(filepath)
      child_t = _G[childTableName]
      -- DECOMPILER ERROR at PC33: Confused about usage of register: R8 in 'UnsetPending'

      ;
      (t.childCache)[childTableName] = _G[childTableName]
      -- DECOMPILER ERROR at PC35: Confused about usage of register: R8 in 'UnsetPending'

      _G[childTableName] = nil
    end
    do
      if child_t then
        local result = child_t[key]
        return result
      end
      return nil
    end
  end
end

TableData.SplitDataClear = function(timer, ...)
  -- function num : 0_2 , upvalues : TableData, splitTableNameCache, pairs, _ENV
  if TableData.delayClear == true then
    if not splitTableNameCache then
      return 
    end
    for table_name,v in pairs(splitTableNameCache) do
      local gt = _G[table_name]
      local is_clear = false
      if gt and gt.childCache then
        for k,t in pairs(gt.childCache) do
          -- DECOMPILER ERROR at PC27: Confused about usage of register: R13 in 'UnsetPending'

          if t.clear_timer == timer then
            (gt.childCache)[k] = nil
            is_clear = true
            break
          end
        end
      end
    end
  end
  do
    if not is_clear then
    end
  end
end

TableData.GetBaseMonsterData = function(id, ...)
  -- function num : 0_3 , upvalues : _ENV, require, TableData
  if BaseMonsterData == nil then
    require("BaseMonsterData")
  end
  if BaseMonsterData then
    if not BaseMonsterData.step then
      return BaseMonsterData[id]
    else
      return (TableData.GetDataFromSplitTable)("BaseMonsterData", id)
    end
  end
end

TableData.GetBaseStoryDialogueData = function(id, ...)
  -- function num : 0_4 , upvalues : _ENV, require, TableData
  if BaseStoryDialogueData == nil then
    require("BaseStoryDialogueData")
  end
  if BaseStoryDialogueData then
    if not BaseStoryDialogueData.step then
      return BaseStoryDialogueData[id]
    else
      return (TableData.GetDataFromSplitTable)("BaseStoryDialogueData", id)
    end
  end
end

TableData.GetBaseWordData = function(id, ...)
  -- function num : 0_5 , upvalues : _ENV, require, TableData
  if BaseWordData == nil then
    require("BaseWordData")
  end
  if BaseWordData then
    if not BaseWordData.step then
      return BaseWordData[id]
    else
      return (TableData.GetDataFromSplitTable)("BaseWordData", id)
    end
  end
end

TableData.GetBaseStoryWordData = function(id, ...)
  -- function num : 0_6 , upvalues : _ENV, require, TableData
  if BaseStoryWordData == nil then
    require("BaseStoryWordData")
  end
  if BaseStoryWordData then
    if not BaseStoryWordData.step then
      return BaseStoryWordData[id]
    else
      return (TableData.GetDataFromSplitTable)("BaseStoryWordData", id)
    end
  end
end

TableData.GetBaseSkillData = function(id, ...)
  -- function num : 0_7 , upvalues : _ENV, require, TableData
  if BaseSkillData == nil then
    require("BaseSkillData")
  end
  if BaseSkillData then
    if not BaseSkillData.step then
      return BaseSkillData[id]
    else
      return (TableData.GetDataFromSplitTable)("BaseSkillData", id)
    end
  end
end

TableData.GetBaseSkillBuffData = function(id, ...)
  -- function num : 0_8 , upvalues : _ENV, require, TableData
  if BaseSkillBuffData == nil then
    require("BaseSkillBuffData")
  end
  if BaseSkillBuffData then
    if not BaseSkillBuffData.step then
      return BaseSkillBuffData[id]
    else
      return (TableData.GetDataFromSplitTable)("BaseSkillBuffData", id)
    end
  end
end

TableData.GetBaseTalentTreeEnergyUpData = function(id, ...)
  -- function num : 0_9 , upvalues : _ENV, require, TableData
  if BaseTalentTreeEnergyUpData == nil then
    require("BaseTalentTreeEnergyUpData")
  end
  if BaseTalentTreeEnergyUpData then
    if not BaseTalentTreeEnergyUpData.step then
      return BaseTalentTreeEnergyUpData[id]
    else
      return (TableData.GetDataFromSplitTable)("BaseTalentTreeEnergyUpData", id)
    end
  end
end

local globalTableNameKeys = TableData.globalTableNameKeys
local globalTableCache = TableData.globalTableCache
TableData.gTable = {}
setmetatable(TableData.gTable, {__index = function(t, key, ...)
  -- function num : 0_10 , upvalues : TableData
  return (TableData.GetBaseData)(key)
end
})
TableData.GetBaseData = function(t_name, ...)
  -- function num : 0_11 , upvalues : globalTableNameKeys, globalTableCache, _ENV, TableData, package, require
  if not globalTableNameKeys then
    globalTableNameKeys = {}
    globalTableCache = {}
  end
  local t_data = globalTableCache[t_name]
  -- DECOMPILER ERROR at PC16: Unhandled construct in 'MakeBoolean' P1

  if t_data and IsBattleServer == nil then
    (TableData.resetBaseDataTimer)(t_name, 15)
  end
  do return t_data end
  local filepath = t_name
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (package.loaded)[filepath] = nil
  require(filepath)
  local t_data = _G[t_name]
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R4 in 'UnsetPending'

  if t_data then
    _G[t_name] = nil
    globalTableCache[t_name] = t_data
    return t_data
  end
  loge((string.format)("TableData.get_base_data failed. t_name not exist. filepath:%s t_name:%s", filepath, t_name))
end

TableData.resetBaseDataTimer = function(t_name, dt, ...)
  -- function num : 0_12
end

TableData.delayClearBaseData = function(timer, ...)
  -- function num : 0_13
end

TableData.clearAllBaseData = function(...)
  -- function num : 0_14 , upvalues : _ENV, globalTableNameKeys, globalTableCache
  logw((string.format)("TableData.clearAllBaseData"))
  globalTableNameKeys = {}
  globalTableCache = {}
end

TableData.GetBasePlayConfigByType = function(type, ...)
  -- function num : 0_15 , upvalues : pairs, TableData, _ENV
  for _,v in pairs((TableData.gTable).BasePlayData) do
    if v.type == type then
      return (Util.Copy)(v)
    end
  end
end

TableData.GetExpeditionMonsterConfig = function(selfMaxFc, ...)
  -- function num : 0_16 , upvalues : TableData, pairs, _ENV
  if selfMaxFc > 0 then
    local allConfig = (TableData.gTable).BaseExpeditionMonsterData
    for _,v in pairs(allConfig) do
      local fcRange = split(v.fc_range, ":")
      if tonumber(fcRange[1]) <= selfMaxFc and selfMaxFc <= tonumber(fcRange[2]) then
        return v
      end
    end
  end
  do
    return 
  end
end

TableData.GetSummonConfigByType = function(type, ...)
  -- function num : 0_17 , upvalues : TableData, pairs, _ENV
  local configResult = {}
  local allConfig = (TableData.gTable).BaseSkillSummonData
  if allConfig then
    for i,v in pairs(allConfig) do
      if v.group == type then
        (table.insert)(configResult, (Util.Copy)(v))
      end
    end
  end
  do
    ;
    (table.sort)(configResult, function(a, b, ...)
    -- function num : 0_17_0
    do return a.id < b.id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    return configResult
  end
end

return TableData

