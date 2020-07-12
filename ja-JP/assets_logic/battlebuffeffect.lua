-- params : ...
-- function num : 0 , upvalues : _ENV
BattleBuffEffect = {}
local ipairs = ipairs
local t_insert = table.insert
local split = split
local tonumber = tonumber
local skillBuffEffectData = (TableData.gTable).BaseSkillBuffEffectData
local ipairs = ipairs
-- DECOMPILER ERROR at PC13: Confused about usage of register: R6 in 'UnsetPending'

BattleBuffEffect.ParseEffectAttrValue = function(buff, skillLevel, ...)
  -- function num : 0_0 , upvalues : _ENV, ipairs, tonumber, skillBuffEffectData, t_insert
  local ParseConfigStr = Util.ParseConfigStr
  if not skillLevel then
    skillLevel = 0
  end
  local buffConfig = buff:GetBuffConfig()
  local value = buffConfig.value
  local valueUp = buffConfig.value_up
  local effectTable = ParseConfigStr(value)
  local effectUpTable = ParseConfigStr(valueUp)
  local allEffectTable = {}
  for index,effect in ipairs(effectTable) do
    local effectId = tonumber(effect[1])
    local effectCalType = tonumber(effect[2])
    local effectCalValue = tonumber(effect[3])
    local effectDepend = tonumber(effect[4])
    local effectConfig = skillBuffEffectData[effectId]
    local effectUp = effectUpTable[index]
    local oneEffectValue = {effectId = effectId, attributeId = effectConfig.attribute_id, 
base = {type = effectCalType, value = effectCalValue, dependType = effectDepend}
, 
up = {type = tonumber(effectUp[1]), value = ((not effectUp[1] or effectUp[2]) and tonumber(effectUp[2]) * skillLevel or 0) + (effectUp[3] and tonumber(effectUp[3]) or 0)}
}
    t_insert(allEffectTable, oneEffectValue)
  end
  return allEffectTable
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R6 in 'UnsetPending'

BattleBuffEffect.ParseControlType = function(effectId, ...)
  -- function num : 0_1 , upvalues : skillBuffEffectData, split
  if effectId then
    local effectConfig = skillBuffEffectData[effectId]
    if effectConfig then
      local control_type = effectConfig.control_type
      if control_type and control_type ~= "0" and control_type ~= "" then
        return split(control_type, ":")
      end
    end
  end
  do
    return {}
  end
end

-- DECOMPILER ERROR at PC19: Confused about usage of register: R6 in 'UnsetPending'

BattleBuffEffect.ContainControlType = function(effectId, type, ...)
  -- function num : 0_2 , upvalues : _ENV, ipairs, tonumber
  local typeTable = (BattleBuffEffect.ParseControlType)(effectId)
  if #typeTable <= 0 then
    return false
  end
  for _,v in ipairs(typeTable) do
    if tonumber(v) == type then
      return true
    end
  end
  return false
end


