-- params : ...
-- function num : 0 , upvalues : _ENV
BattleSkill = {}
local ipairs = ipairs
local pairs = pairs
local tonumber = tonumber
local t_insert = table.insert
local s_find = string.find
local split = split
-- DECOMPILER ERROR at PC12: Confused about usage of register: R6 in 'UnsetPending'

BattleSkill.GetAllBuff = function(atkCard, defCards, skillConfig, ...)
  -- function num : 0_0 , upvalues : _ENV
  if skillConfig == nil then
    return 
  end
  local buff_odds = skillConfig.buff_odds
  if buff_odds and buff_odds > 0 then
    local buff_list = skillConfig.buff_list
    local random = (BattleData.GetRandomSeed)()
    if random <= buff_odds then
      return (BattleSkill.GetAllBuffByBuffList)(atkCard, defCards, buff_list, skillConfig)
    end
  end
  do
    return {}
  end
end

-- DECOMPILER ERROR at PC15: Confused about usage of register: R6 in 'UnsetPending'

BattleSkill.GetAllBuffByBuffList = function(atkCard, defCards, buff_list, skillConfig, ...)
  -- function num : 0_1 , upvalues : s_find, split, ipairs, tonumber, t_insert, pairs, _ENV
  if s_find(buff_list, ":") == nil then
    return {}
  end
  local buffConfigTable = split(buff_list, ",")
  local buffTable = {}
  for _,buff_config in ipairs(buffConfigTable) do
    local buffInfoList = split(buff_config, ":")
    local groupId = tonumber(buffInfoList[1])
    local id = tonumber(buffInfoList[2])
    local targetId = tonumber(buffInfoList[3])
    local prob = tonumber(buffInfoList[4])
    if not buffTable[groupId] then
      do
        buffTable[groupId] = {}
        t_insert(buffTable[groupId], {id = id, targetId = targetId, prob = prob})
        -- DECOMPILER ERROR at PC45: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC45: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  local activeBuffTable = {}
  for groupId,groupBuffs in pairs(buffTable) do
    local totalProp = 0
    local random = (BattleData.GetRandomSeed)()
    for _,groupBuff in ipairs(groupBuffs) do
      if random <= totalProp + groupBuff.prob then
        local buff = (BattleBuff.Initial)(atkCard, defCards, groupBuff.id, groupBuff.targetId, skillConfig)
        t_insert(activeBuffTable, buff)
        break
      else
        do
          do
            totalProp = totalProp + groupBuff.prob
            -- DECOMPILER ERROR at PC80: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC80: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC80: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
  return activeBuffTable
end

-- DECOMPILER ERROR at PC18: Confused about usage of register: R6 in 'UnsetPending'

BattleSkill.GetBuffTableByType = function(buffTable, settleRoundType, ...)
  -- function num : 0_2 , upvalues : ipairs, t_insert
  local result_table = {}
  for _,oneBuff in ipairs(buffTable) do
    if oneBuff:GetSettleRoundType() == settleRoundType then
      t_insert(result_table, oneBuff)
    end
  end
  return result_table
end

-- DECOMPILER ERROR at PC21: Confused about usage of register: R6 in 'UnsetPending'

BattleSkill.IsAttackSkill = function(skillConfig, ...)
  -- function num : 0_3
  do return skillConfig.damage_rate > 0 or skillConfig.damage > 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC24: Confused about usage of register: R6 in 'UnsetPending'

BattleSkill.IsTreatmentSkill = function(skillConfig, ...)
  -- function num : 0_4
  do return skillConfig.damage_rate < 0 or skillConfig.damage < 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC27: Confused about usage of register: R6 in 'UnsetPending'

BattleSkill.IsNoAttackActionSkill = function(skillConfig, ...)
  -- function num : 0_5
  do return skillConfig.damage_rate == 0 and skillConfig.damage == 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC30: Confused about usage of register: R6 in 'UnsetPending'

BattleSkill.GetSkillLevel = function(cardUid, skillId, ...)
  -- function num : 0_6 , upvalues : ipairs, _ENV, pairs
  for _,v in ipairs(BattleData.allCardList) do
    if v:GetCardUid() == cardUid then
      for k,l in pairs(v:GetSkillInfo()) do
        if not l.value then
          do
            do return l.id ~= skillId or 0 end
            -- DECOMPILER ERROR at PC22: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC22: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC33: Confused about usage of register: R6 in 'UnsetPending'

BattleSkill.GetSkillShowId = function(fashionId, skillType, ...)
  -- function num : 0_7 , upvalues : _ENV
  if fashionId and skillType then
    local fashionConfig = ((TableData.gTable).BaseFashionData)[fashionId]
    if fashionConfig then
      if skillType == BattleSkillType.NORMAL then
        return fashionConfig.normal_atk_skill_show
      else
        if skillType == BattleSkillType.SMALL then
          return fashionConfig.special_skill_show
        else
          if skillType == BattleSkillType.SKILL then
            return fashionConfig.unique_skill_show
          else
            if skillType == BattleSkillType.ASSIST then
              return fashionConfig.assist_skill_show
            end
          end
        end
      end
    end
  end
end


