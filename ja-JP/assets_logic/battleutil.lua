-- params : ...
-- function num : 0 , upvalues : _ENV
BattleUtil = {}
local self = BattleUtil
local t_insert = table.insert
local ceil = math.ceil
local floor = math.floor
local ipairs = ipairs
-- DECOMPILER ERROR at PC12: Confused about usage of register: R5 in 'UnsetPending'

BattleUtil.GetValue0 = function(...)
  -- function num : 0_0
  local value_1 = 1
  value_1 = value_1 / value_1
  local value_0 = value_1 - value_1
  return value_0 - value_0
end

-- DECOMPILER ERROR at PC15: Confused about usage of register: R5 in 'UnsetPending'

BattleUtil.GetValue1 = function(...)
  -- function num : 0_1
  local value_1 = 1
  local value_check = 1
  value_1 = value_1 / value_1
  if value_check ~= value_1 then
    return 
  end
  return value_1
end

-- DECOMPILER ERROR at PC18: Confused about usage of register: R5 in 'UnsetPending'

BattleUtil.GetValue2 = function(...)
  -- function num : 0_2 , upvalues : self
  return (self.GetValue1)() + (self.GetValue1)()
end

-- DECOMPILER ERROR at PC21: Confused about usage of register: R5 in 'UnsetPending'

BattleUtil.GetValue3 = function(...)
  -- function num : 0_3 , upvalues : self
  return (self.GetValue1)() + (self.GetValue2)()
end

-- DECOMPILER ERROR at PC24: Confused about usage of register: R5 in 'UnsetPending'

BattleUtil.GetValue5 = function(...)
  -- function num : 0_4 , upvalues : self
  return (self.GetValue1)() + (self.GetValue1)() + (self.GetValue1)() + (self.GetValue1)() + (self.GetValue1)()
end

-- DECOMPILER ERROR at PC27: Confused about usage of register: R5 in 'UnsetPending'

BattleUtil.GetValue4 = function(...)
  -- function num : 0_5 , upvalues : self
  return (self.GetValue2)() + (self.GetValue2)()
end

-- DECOMPILER ERROR at PC30: Confused about usage of register: R5 in 'UnsetPending'

BattleUtil.GetValue6 = function(...)
  -- function num : 0_6 , upvalues : self
  return (self.GetValue4)() + (self.GetValue2)()
end

-- DECOMPILER ERROR at PC33: Confused about usage of register: R5 in 'UnsetPending'

BattleUtil.GetValue7 = function(...)
  -- function num : 0_7 , upvalues : self
  return (self.GetValue5)() + (self.GetValue2)()
end

-- DECOMPILER ERROR at PC36: Confused about usage of register: R5 in 'UnsetPending'

BattleUtil.GetValue10 = function(...)
  -- function num : 0_8 , upvalues : self
  return (self.GetValue2)() * (self.GetValue5)()
end

-- DECOMPILER ERROR at PC39: Confused about usage of register: R5 in 'UnsetPending'

BattleUtil.GetValue100 = function(...)
  -- function num : 0_9 , upvalues : self
  return (self.GetValue10)() * (self.GetValue10)()
end

-- DECOMPILER ERROR at PC42: Confused about usage of register: R5 in 'UnsetPending'

BattleUtil.GetValue1000 = function(...)
  -- function num : 0_10 , upvalues : self
  return (self.GetValue100)() * (self.GetValue10)()
end

-- DECOMPILER ERROR at PC45: Confused about usage of register: R5 in 'UnsetPending'

BattleUtil.GetValue10000 = function(...)
  -- function num : 0_11 , upvalues : self
  return (self.GetValue100)() * (self.GetValue100)()
end

-- DECOMPILER ERROR at PC48: Confused about usage of register: R5 in 'UnsetPending'

BattleUtil.GetValue1_ex = function(...)
  -- function num : 0_12 , upvalues : self
  return (self.GetValue1)() - (self.GetValue2)()
end

-- DECOMPILER ERROR at PC51: Confused about usage of register: R5 in 'UnsetPending'

BattleUtil.SplitHurt = function(defCardsInfo, totalCount, hurtSectionTable, totalPercent, ...)
  -- function num : 0_13 , upvalues : ipairs, _ENV, ceil, floor, t_insert
  local totalDefCards = {}
  local hurtTable = {}
  local hurtTableList = {}
  local danderDefList = {}
  local recordHp = 0
  local hpDef = 0
  local danderDef = 0
  local absorbDamage = 0
  for _,defCardInfo in ipairs(defCardsInfo) do
    recordHp = 0
    hurtTable = {}
    hpDef = defCardInfo.hpDef
    danderDef = defCardInfo.danderDef
    absorbDamage = defCardInfo.absorbDamage
    local card = (BattleData.GetCardInfoByPos)(defCardInfo.defPos)
    local displayHp = hpDef - absorbDamage
    for i = 1, totalCount do
      if i ~= totalCount then
        local _onceHp = nil
        if not hurtSectionTable[i] then
          do
            _onceHp = ceil(displayHp * (displayHp > 0 or 0) / totalPercent)
            _onceHp = floor(displayHp * (hurtSectionTable[i] or 0) / totalPercent)
            recordHp = recordHp + _onceHp
            if absorbDamage > 0 then
              if absorbDamage + _onceHp >= 0 then
                t_insert(hurtTable, {hurt = 0, absorb = -_onceHp})
              else
                t_insert(hurtTable, {hurt = absorbDamage + _onceHp, absorb = absorbDamage})
              end
              absorbDamage = absorbDamage + _onceHp
            else
              t_insert(hurtTable, {hurt = _onceHp, absorb = 0})
            end
            if absorbDamage > 0 then
              local leftHp = displayHp - (recordHp)
              if absorbDamage + leftHp >= 0 then
                t_insert(hurtTable, {hurt = 0, absorb = -leftHp})
              else
                t_insert(hurtTable, {hurt = absorbDamage + leftHp, absorb = absorbDamage})
              end
            else
              do
                do
                  t_insert(hurtTable, {hurt = displayHp - (recordHp), absorb = 0})
                  -- DECOMPILER ERROR at PC110: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC110: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                  -- DECOMPILER ERROR at PC110: LeaveBlock: unexpected jumping out IF_STMT

                  -- DECOMPILER ERROR at PC110: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC110: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC110: LeaveBlock: unexpected jumping out IF_STMT

                  -- DECOMPILER ERROR at PC110: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC110: LeaveBlock: unexpected jumping out IF_STMT

                end
              end
            end
          end
        end
      end
    end
    t_insert(hurtTableList, hurtTable)
    t_insert(danderDefList, danderDef)
    t_insert(totalDefCards, card)
  end
  return hurtTableList, danderDefList, totalDefCards
end


