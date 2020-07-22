-- params : ...
-- function num : 0 , upvalues : _ENV
BattleBuff = {}
local self = BattleBuff
require("BattleBuffMgr")
local BattleBuffMgr = BattleBuffMgr
local BattleBuffEffectCalType = BattleBuffEffectCalType
local BattleBuffEffectDependType = BattleBuffEffectDependType
local BattleBuffControlType = BattleBuffControlType
local BattleBuffEffectPosType = BattleBuffEffectPosType
local BattleDisplayEffect = BattleDisplayEffect
local BattleBuffOprType = BattleBuffOprType
local ipairs = ipairs
local t_insert = table.insert
local split = split
local tonumber = tonumber
local math = math
-- DECOMPILER ERROR at PC21: Confused about usage of register: R13 in 'UnsetPending'

BattleBuff.Initial = function(atkCard, defCards, buffId, targetId, skillConfig, ...)
  -- function num : 0_0 , upvalues : _ENV, t_insert, ipairs, BattleBuffOprType, BattleDisplayEffect, split, tonumber, BattleBuffEffectCalType, BattleBuffEffectDependType, math
  if atkCard then
    local battleBuff = {buffId = buffId, atkPos = atkCard:GetPosIndex(), curDefPos = 0, 
targetPosTable = {}
, activeCount = 0, totalCount = 0, shieldHp = 0, usedShieldHp = 0, sleepState = 0, buffTimeStamp = 0, targetId = targetId, targetCount = 0, 
summonCards = {}
, 
effectRounds = {}
, curRoundActive = false}
    battleBuff.Init = function(self, ...)
    -- function num : 0_0_0 , upvalues : _ENV, atkCard, targetId, defCards, t_insert, skillConfig
    local targetCards = (BattleChoose.GetTargetCardsByTargetId)(atkCard, targetId, defCards, true)
    local targetPosTable = self:GetTargetPosTable()
    for _,v in pairs(targetCards) do
      t_insert(targetPosTable, v:GetPosIndex())
      self.targetCount = self.targetCount + 1
    end
    self.totalCount = self:GetSettleRoundCnt()
    self.skillConfig = skillConfig
    self.targetId = targetId
  end

    battleBuff.GetBuffConfig = function(self, ...)
    -- function num : 0_0_1 , upvalues : _ENV
    local buffConfig = (TableData.GetBaseSkillBuffData)(self.buffId)
    return buffConfig
  end

    battleBuff.GetSkillId = function(self, ...)
    -- function num : 0_0_2
    if self.skillConfig then
      return (self.skillConfig).id
    end
  end

    battleBuff.IsNewBuff = function(self, atkInfo, ...)
    -- function num : 0_0_3 , upvalues : ipairs, BattleBuffOprType
    local allBuffTable = atkInfo.allBuffTable
    for _,v in ipairs(allBuffTable) do
      if v.type == BattleBuffOprType.NEW and (v.buff).curDefPos == self:GetCurDefPos() and (v.buff).buffId == self:GetBuffId() and self:GetActiveCount() == 0 and (v.buff).buffTimeStamp == self:GetBuffTimeStamp() and (v.buff).curDefPos == self:GetCurDefPos() and (v.buff).atkPos == self:GetAtkPos() then
        return true
      end
    end
    return false
  end

    battleBuff.GetTargetCard = function(self, targetId, ...)
    -- function num : 0_0_4 , upvalues : t_insert, _ENV
    local targetCards = {}
    local pos = nil
    if targetId == 1001 then
      pos = self:GetAtkPos()
    else
      if targetId == 1002 then
        pos = self:GetCurDefPos()
      end
    end
    if pos then
      t_insert(targetCards, (BattleData.GetCardInfoByPos)(pos))
    end
    return targetCards
  end

    battleBuff.GetBuffTimeStamp = function(self, ...)
    -- function num : 0_0_5
    return self.buffTimeStamp
  end

    battleBuff.SetBuffTimeStamp = function(self, buffTimeStamp, ...)
    -- function num : 0_0_6
    self.buffTimeStamp = buffTimeStamp
  end

    battleBuff.GetActiveCount = function(self, ...)
    -- function num : 0_0_7
    return self.activeCount
  end

    battleBuff.SetActiveCount = function(self, activeCount, ...)
    -- function num : 0_0_8
    self.activeCount = activeCount
  end

    battleBuff.GetSleepState = function(self, ...)
    -- function num : 0_0_9
    return self.sleepState
  end

    battleBuff.SetSleepState = function(self, sleepState, ...)
    -- function num : 0_0_10
    self.sleepState = sleepState
  end

    battleBuff.GetTotalCount = function(self, ...)
    -- function num : 0_0_11
    return self.totalCount
  end

    battleBuff.SetEffectTable = function(self, effectTable, ...)
    -- function num : 0_0_12
    self.effectTable = effectTable
  end

    battleBuff.GetEffectTable = function(self, ...)
    -- function num : 0_0_13 , upvalues : _ENV, ipairs, t_insert
    if self.effectTable then
      return self.effectTable
    else
      local effectTable = {}
      local atkCard = (BattleData.GetCardInfoByPos)(self.atkPos)
      local skillLevel = atkCard and (BattleSkill.GetSkillLevel)(atkCard:GetCardUid(), self:GetSkillId()) or 0
      local attrTable = (BattleBuffEffect.ParseEffectAttrValue)(self, skillLevel)
      for _,oneEffect in ipairs(attrTable) do
        t_insert(effectTable, {effectId = oneEffect.effectId, attributeId = 0, value = (oneEffect.base).value, realValue = (oneEffect.base).value})
      end
      return effectTable
    end
  end

    battleBuff.SetClearCount = function(self, clearCount, ...)
    -- function num : 0_0_14
    self.clearCount = clearCount
  end

    battleBuff.GetClearCount = function(self, ...)
    -- function num : 0_0_15
    return self.clearCount or 0
  end

    battleBuff.DealSpecialEffect = function(self, ...)
    -- function num : 0_0_16 , upvalues : _ENV, ipairs, BattleDisplayEffect
    local curDefPos = self:GetCurDefPos()
    local card = (BattleData.GetCardInfoByPos)(curDefPos)
    if card then
      local buffData = self:GetRealBuffInfo()
      local effectTable = buffData.effectTable
      for _,v in ipairs(effectTable) do
        local effectId = v.effectId
        local attributeId = v.attributeId
        local value = v.value
        if effectId == BattleDisplayEffect.SUMMON then
          self:DealSummonCard(value)
        end
      end
    end
  end

    battleBuff.DealSummonCard = function(self, summonType, ...)
    -- function num : 0_0_17 , upvalues : _ENV, ipairs, split, tonumber
    local BattleData = BattleData
    if summonType and summonType > 0 then
      local summonConfig = (TableData.GetSummonConfigByType)(summonType)
      if summonConfig and #summonConfig > 0 then
        local totalProp = 0
        for _,config in ipairs(summonConfig) do
          local random_prob = config.random_prob
          totalProp = totalProp + random_prob
          config.random_prob = totalProp
        end
        local random = (BattleData.GetRandomSeed)() * (totalProp) / 10000
        local random_monster_id, monster_pos = nil, nil
        for _,config in ipairs(summonConfig) do
          local monster_id = config.monster_id
          local random_prob = config.random_prob
          local random_pos = config.random_pos
          if random <= random_prob then
            random_monster_id = monster_id
            random_pos = split(random_pos, ":")
            for _,pos in ipairs(random_pos) do
              local posIndex = tonumber(pos)
              local card = (BattleData.GetCardInfoByPos)(posIndex)
              if card == nil or card:IsDead() == true then
                monster_pos = posIndex
                break
              end
            end
            break
          end
        end
        do
          if random_monster_id and monster_pos then
            if IsBattleServer == nil then
              print("召唤成功： monster_id", random_monster_id, "位置：", monster_pos)
            end
            ;
            (BattleData.AddSummonCardData)(random_monster_id, monster_pos)
            self:SetSummonCards({id = random_monster_id, value = monster_pos})
          end
        end
      end
    end
  end

    battleBuff.DealAttribute = function(self, ...)
    -- function num : 0_0_18 , upvalues : _ENV, ipairs, BattleDisplayEffect
    local BattleData = BattleData
    local active_forever = self:GetActiveForever()
    if active_forever == 1 then
      local curDefPos = self:GetCurDefPos()
      local card = (BattleData.GetCardInfoByPos)(curDefPos)
      if card then
        local buffData = self:GetRealBuffInfo()
        local effectTable = buffData.effectTable
        for _,v in ipairs(effectTable) do
          local effectId = v.effectId
          local attributeId = v.attributeId
          local value = v.value
          v.realValue = value
          if effectId == BattleDisplayEffect.DANDER_ABSORB then
            local dander = card:GetDander()
            if dander + v.realValue <= 0 then
              v.realValue = -dander
            end
            local dander_absorb = -v.realValue
            if dander_absorb > 0 then
              local atkCard = (BattleData.GetCardInfoByPos)(buffData.atkPos)
              if atkCard then
                atkCard:SetDander(atkCard:GetDander() + dander_absorb)
              end
            end
          end
          do
            do
              local realValue, absorbDamage, specialEffect = card:AddAttrValue(attributeId, v.realValue, effectId)
              if realValue ~= nil then
                v.realValue = realValue
              end
              v.absorbDamage = absorbDamage or 0
              if specialEffect then
                v.isInvincible = specialEffect.isInvincible
                v.isKeepAlive = specialEffect.isKeepAlive
              else
                v.isInvincible = false
                v.isKeepAlive = false
              end
              -- DECOMPILER ERROR at PC69: LeaveBlock: unexpected jumping out DO_STMT

            end
          end
        end
        self:SetEffectTable(effectTable)
      end
    end
  end

    battleBuff.NeedRemove = function(self, ...)
    -- function num : 0_0_19
    if self:GetTotalCount() <= self:GetActiveCount() then
      return true
    end
    local shieldHp = self:GetShieldHp()
    local usedShieldHp = self:GetUsedShieldHp()
    if shieldHp > 0 and shieldHp <= usedShieldHp then
      return true
    end
    local sleepState = self:GetSleepState()
    if sleepState == 1 then
      return true
    end
  end

    battleBuff.IsBuffImmune = function(self, newBuff, ...)
    -- function num : 0_0_20 , upvalues : _ENV, ipairs, tonumber
    local buffConfig = self:GetBuffConfig()
    if buffConfig then
      local immune_group = buffConfig.immune_group
      if immune_group and immune_group ~= "0" then
        local groupInfo = (Util.ParseConfigStr)(immune_group)
        for _,groupTypeInfo in ipairs(groupInfo) do
          local type = groupTypeInfo[1]
          local id = groupTypeInfo[2]
          if type and id then
            type = tonumber(type)
            id = tonumber(id)
            -- DECOMPILER ERROR at PC38: Unhandled construct in 'MakeBoolean' P1

            if type == 1 and newBuff:GetBuffId() == id then
              return true
            end
          end
          -- DECOMPILER ERROR at PC48: Unhandled construct in 'MakeBoolean' P1

          if type == 2 and (newBuff:GetBuffConfig()).type == id then
            return true
          end
          if type == 3 and (BattleBuff.IsBuffContainEffectId)(newBuff, id) == true then
            return true
          end
        end
      end
    end
    do
      return false
    end
  end

    battleBuff.SaveEffectRound = function(self, round, ...)
    -- function num : 0_0_21 , upvalues : _ENV
    if not round then
      round = BattleData.roundIndex
    end
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self.effectRounds)[round] = (self.effectRounds)[round] and (self.effectRounds)[round] + 1 or 1
    if IsBattleServer == nil then
      print("回合生效次数变化：", self:GetBuffLog(), "本回合已经生效次数：", (self.effectRounds)[round])
    end
  end

    battleBuff.SetCurRoundActive = function(self, curRoundActive, ...)
    -- function num : 0_0_22
    self.curRoundActive = curRoundActive
  end

    battleBuff.IsCurRoundActive = function(self, ...)
    -- function num : 0_0_23
    do return self.curRoundActive == true end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end

    battleBuff.IsCanEffect = function(self, round, isUpdateCount, ...)
    -- function num : 0_0_24 , upvalues : _ENV
    local GetTopHpCards = BattleChoose.GetTopHpCards
    local BattleData = BattleData
    if IsBattleServer == nil then
      print("判断是否生效：", self:GetBuffLog())
    end
    local config = self:GetBuffConfig()
    local deduction_condition = config.deduction_condition
    if deduction_condition and deduction_condition ~= 0 then
      local cardPos = self:GetCurDefPos()
      local card = (BattleData.GetCardInfoByPos)(cardPos)
      if card then
        if deduction_condition == 1001 then
          local minCards = GetTopHpCards(card, true, 6, true)
          if minCards and #minCards > 0 then
            (table.sort)(minCards, function(a, b, ...)
      -- function num : 0_0_24_0
      if a:GetMaxHp() >= b:GetMaxHp() then
        do return a:GetHp() / a:GetMaxHp() ~= b:GetHp() / b:GetMaxHp() end
        do return a:GetHp() / a:GetMaxHp() < b:GetHp() / b:GetMaxHp() end
        -- DECOMPILER ERROR: 4 unprocessed JMP targets
      end
    end
)
            local minCard = minCards[1]
            if minCard:GetHp() / minCard:GetMaxHp() < card:GetHp() / card:GetMaxHp() then
              print("血量百分比不是最低")
              return false
            else
              if card:GetHp() / card:GetMaxHp() == minCard:GetHp() / minCard:GetMaxHp() and minCard:GetMaxHp() < card:GetMaxHp() then
                print("血量不是最低")
                return false
              end
            end
          end
        else
          do
            if deduction_condition == 1002 then
              local maxCards = GetTopHpCards(card, true, 6)
              if maxCards and #maxCards > 0 then
                (table.sort)(maxCards, function(a, b, ...)
      -- function num : 0_0_24_1
      if b:GetMaxHp() >= a:GetMaxHp() then
        do return a:GetHp() / a:GetMaxHp() ~= b:GetHp() / b:GetMaxHp() end
        do return b:GetHp() / b:GetMaxHp() < a:GetHp() / a:GetMaxHp() end
        -- DECOMPILER ERROR: 4 unprocessed JMP targets
      end
    end
)
                local maxCard = maxCards[1]
                if card:GetHp() / card:GetMaxHp() < maxCard:GetHp() / maxCard:GetMaxHp() then
                  print("血量百分比不是最高")
                  return false
                else
                  if card:GetHp() / card:GetMaxHp() == maxCard:GetHp() / maxCard:GetMaxHp() and card:GetMaxHp() < maxCard:GetMaxHp() then
                    print("血量不是最高")
                    return false
                  end
                end
              end
            end
            do
              do
                print("找不到buff挂载的卡片")
                do return false end
                if isUpdateCount ~= true then
                  local random = (BattleData.GetRandomSeed)()
                  local config = self:GetBuffConfig()
                  local deduction_value = config.deduction_value
                  if deduction_value and deduction_value < random then
                    print("随机概率不足，无法生效")
                    return false
                  end
                end
                do
                  if not round then
                    round = BattleData.roundIndex
                  end
                  local config = self:GetBuffConfig()
                  local per_round_limit = config.per_round_limit or 0
                  if per_round_limit == 0 then
                    return true
                  end
                  if (self.effectRounds)[round] == nil or per_round_limit > 0 and (self.effectRounds)[round] < per_round_limit then
                    return true
                  end
                  print("超过了本回合的生效限制")
                  return false
                end
              end
            end
          end
        end
      end
    end
  end

    battleBuff.GetBuffId = function(self, ...)
    -- function num : 0_0_25
    return self.buffId
  end

    battleBuff.GetBuffName = function(self, ...)
    -- function num : 0_0_26
    local buffConfig = self:GetBuffConfig()
    if buffConfig then
      return buffConfig.name
    end
  end

    battleBuff.GetBuffDes = function(self, ...)
    -- function num : 0_0_27
    local buffConfig = self:GetBuffConfig()
    if buffConfig then
      return buffConfig.des
    end
  end

    battleBuff.GetBuffLog = function(self, ...)
    -- function num : 0_0_28 , upvalues : _ENV
    local buffConfig = self:GetBuffConfig()
    do
      local logTable = {"id:", self.buffId, " name:", not buffConfig or "未配置", " des:", not buffConfig.name and buffConfig.des or "未配置", " 施放者位置：", self:GetAtkPos(), " 挂载者位置：", self:GetCurDefPos()}
      do return (table.concat)(logTable) end
      do return "" end
    end
  end

    battleBuff.GetAtkPos = function(self, ...)
    -- function num : 0_0_29
    return self.atkPos
  end

    battleBuff.SetCurDefPos = function(self, pos, ...)
    -- function num : 0_0_30
    self.curDefPos = pos
  end

    battleBuff.GetCurDefPos = function(self, ...)
    -- function num : 0_0_31
    return self.curDefPos
  end

    battleBuff.GetTargetPosTable = function(self, ...)
    -- function num : 0_0_32
    return self.targetPosTable
  end

    battleBuff.SetSettleRoundType = function(self, settle_round_type, ...)
    -- function num : 0_0_33
    self.settle_round_type = settle_round_type
  end

    battleBuff.GetSettleRoundType = function(self, ...)
    -- function num : 0_0_34
    if self.settle_round_type then
      return self.settle_round_type
    end
    local buffConfig = self:GetBuffConfig()
    if buffConfig then
      return buffConfig.settle_round_type
    end
  end

    battleBuff.SetDeductionRoundType = function(self, deduction_round_type, ...)
    -- function num : 0_0_35
    self.deduction_round_type = deduction_round_type
  end

    battleBuff.GetDeductionRoundType = function(self, ...)
    -- function num : 0_0_36
    if self.deduction_round_type then
      return self.deduction_round_type
    end
    local buffConfig = self:GetBuffConfig()
    if buffConfig then
      return buffConfig.deduction_round_type
    end
  end

    battleBuff.GetSettleRoundCnt = function(self, ...)
    -- function num : 0_0_37
    local buffConfig = self:GetBuffConfig()
    if buffConfig then
      return buffConfig.settle_round_cnt
    end
  end

    battleBuff.GetActiveForever = function(self, ...)
    -- function num : 0_0_38
    local buffConfig = self:GetBuffConfig()
    if buffConfig then
      return buffConfig.active_forever
    end
  end

    battleBuff.SetSummonCards = function(self, summonCard, ...)
    -- function num : 0_0_39 , upvalues : t_insert
    t_insert(self.summonCards, summonCard)
  end

    battleBuff.GetSummonCards = function(self, ...)
    -- function num : 0_0_40
    return self.summonCards
  end

    battleBuff.GetRealBuffInfo = function(self, atkInfo, ...)
    -- function num : 0_0_41
    if self.buffData then
      local buffData = self.buffData
      buffData.activeCount = self:GetActiveCount()
      buffData.usedShieldHp = self:GetUsedShieldHp()
      buffData.buffTimeStamp = self:GetBuffTimeStamp()
      buffData.effectTable = self:GetEffectTable()
      buffData.summonCards = self:GetSummonCards()
      return buffData
    else
      do
        do return self:GetBuffInfo(atkInfo) end
      end
    end
  end

    battleBuff.GetBuffInfo = function(self, atkInfo, needCopy, ...)
    -- function num : 0_0_42 , upvalues : _ENV, ipairs, t_insert, BattleDisplayEffect, BattleBuffEffectCalType, BattleBuffEffectDependType, math
    local GetCardInfoByPos = BattleData.GetCardInfoByPos
    if self.buffData then
      local data = self.buffData
      local buffData = {buffId = data.buffId, atkPos = data.atkPos, curDefPos = data.curDefPos, activeCount = self:GetActiveCount(), totalCount = data.totalCount, settleRoundType = self:GetSettleRoundType(), deductionRoundType = self:GetDeductionRoundType(), activeForever = data.activeForever, shieldHp = data.shieldHp, usedShieldHp = self:GetUsedShieldHp(), buffTimeStamp = self:GetBuffTimeStamp()}
      if needCopy == true then
        buffData.effectTable = (Util.Copy)(self:GetEffectTable())
        buffData.summonCards = (Util.Copy)(self:GetSummonCards())
      else
        buffData.effectTable = self:GetEffectTable()
        buffData.summonCards = self:GetSummonCards()
      end
      return buffData
    end
    do
      local effectTable = {}
      local atkCard = GetCardInfoByPos(self:GetAtkPos())
      local defCard = GetCardInfoByPos(self:GetCurDefPos())
      local skillLevel = (BattleSkill.GetSkillLevel)(atkCard:GetCardUid(), self:GetSkillId()) or 0
      local attrTable = (BattleBuffEffect.ParseEffectAttrValue)(self, skillLevel)
      local ContainEffectId = BattleBuff.ContainEffectId
      local GetAtkDamage = BattleAtk.GetAtkDamage
      local GetCampDeadCount = BattleData.GetCampDeadCount
      for _,oneEffect in ipairs(attrTable) do
        if oneEffect.attributeId == 0 then
          t_insert(effectTable, {effectId = oneEffect.effectId, attributeId = 0, value = (oneEffect.base).value, realValue = (oneEffect.base).value})
        else
          local base = oneEffect.base
          local up = oneEffect.up
          local totalValue = 0
          local baseType = base.type
          local baseValue = base.value
          local baseDependType = base.dependType
          local upType = up.type
          local upValue = up.value
          do
            if oneEffect.effectId == BattleDisplayEffect.SHIELD then
              local isContain, buff, effect = ContainEffectId(atkCard, BattleDisplayEffect.SHIELD_UP)
              if isContain == true then
                totalValue = totalValue + effect.realValue
              end
            end
            do
              if oneEffect.effectId == BattleDisplayEffect.DAMAGE_PERSIST or oneEffect.effectId == BattleDisplayEffect.DAMAGE_REPEAT then
                local isContain, buff, effect = ContainEffectId(atkCard, BattleDisplayEffect.DAMAGE_PERSIST_UP)
                if isContain == true then
                  totalValue = totalValue + effect.realValue
                end
              end
              if baseType == BattleBuffEffectCalType.VALUE then
                totalValue = totalValue + baseValue
              else
                if baseType == BattleBuffEffectCalType.ATK_PER then
                  if baseDependType == BattleBuffEffectDependType.ATK_CARD then
                    totalValue = totalValue + (math.ceil)(atkCard:GetAtk(true) * baseValue / 10000)
                  else
                    if baseDependType == BattleBuffEffectDependType.DEF_CARD then
                      totalValue = totalValue + (math.ceil)(defCard:GetAtk(true) * baseValue / 10000)
                    end
                  end
                else
                  if baseType == BattleBuffEffectCalType.DEF_PER then
                    if baseDependType == BattleBuffEffectDependType.ATK_CARD then
                      totalValue = totalValue + (math.ceil)(atkCard:GetDef(true) * baseValue / 10000)
                    else
                      if baseDependType == BattleBuffEffectDependType.DEF_CARD then
                        totalValue = totalValue + (math.ceil)(defCard:GetDef(true) * baseValue / 10000)
                      end
                    end
                  else
                    if baseType == BattleBuffEffectCalType.HP_PER then
                      if baseDependType == BattleBuffEffectDependType.ATK_CARD then
                        totalValue = totalValue + (math.ceil)(atkCard:GetMaxHp(true) * baseValue / 10000)
                      else
                        if baseDependType == BattleBuffEffectDependType.DEF_CARD then
                          totalValue = totalValue + (math.ceil)(defCard:GetMaxHp(true) * baseValue / 10000)
                        end
                      end
                    else
                      if atkInfo and baseType == BattleBuffEffectCalType.HURT_PER then
                        local totalDamage = GetAtkDamage(atkInfo)
                        totalValue = totalValue + (math.ceil)((math.abs)(totalDamage) * baseValue / 10000)
                      else
                        do
                          if baseType == BattleBuffEffectCalType.ATK_BASED_TARGET_DEAD then
                            totalValue = totalValue + (math.ceil)((3 - self.targetCount) / self.targetCount * atkCard:GetAtk(true) * baseValue / 10000)
                          else
                            if baseType == BattleBuffEffectCalType.ATK_BASED_SELF_DEAD then
                              local count = GetCampDeadCount(atkCard:GetCampFlag())
                              totalValue = totalValue + (math.ceil)(count * atkCard:GetAtk(true) * baseValue / 10000)
                            else
                              do
                                if baseType == BattleBuffEffectCalType.ATK_BASED_ALL_DEAD then
                                  local count = GetCampDeadCount()
                                  totalValue = totalValue + (math.ceil)(count * atkCard:GetAtk(true) * baseValue / 10000)
                                else
                                  do
                                    if baseType == BattleBuffEffectCalType.ATK_BASED_TARGET_HP then
                                      local per = (math.floor)((1 - defCard:GetHp() / defCard:GetMaxHp(true)) / 0.1)
                                      totalValue = totalValue + (math.ceil)(per * atkCard:GetAtk(true) * baseValue / 10000)
                                    else
                                      do
                                        if atkInfo and baseType == BattleBuffEffectCalType.DAMAGE_BASED_TARGET_DEAD then
                                          local totalDamage = GetAtkDamage(atkInfo)
                                          totalValue = totalValue + (math.ceil)((math.abs)(totalDamage / self.targetCount) * baseValue / 10000)
                                        else
                                          do
                                            if baseType == BattleBuffEffectCalType.ATK_BASED_CLEAR_BUFF then
                                              totalValue = totalValue + (math.ceil)(self:GetClearCount() * atkCard:GetAtk(true) * baseValue / 10000)
                                            else
                                              if baseType == BattleBuffEffectCalType.SPD_PER then
                                                if baseDependType == BattleBuffEffectDependType.ATK_CARD then
                                                  totalValue = totalValue + (math.ceil)(atkCard:GetSpd(true) * baseValue / 10000)
                                                else
                                                  if baseDependType == BattleBuffEffectDependType.DEF_CARD then
                                                    totalValue = totalValue + (math.ceil)(defCard:GetSpd(true) * baseValue / 10000)
                                                  end
                                                end
                                              end
                                            end
                                            if upType == BattleBuffEffectCalType.VALUE then
                                              totalValue = totalValue + upValue
                                            else
                                              if upType == BattleBuffEffectCalType.ATK_PER then
                                                if baseDependType == BattleBuffEffectDependType.ATK_CARD then
                                                  totalValue = totalValue + (math.ceil)(atkCard:GetAtk(true) * upValue / 10000)
                                                else
                                                  if baseDependType == BattleBuffEffectDependType.DEF_CARD then
                                                    totalValue = totalValue + (math.ceil)(defCard:GetAtk(true) * upValue / 10000)
                                                  end
                                                end
                                              else
                                                if upType == BattleBuffEffectCalType.DEF_PER then
                                                  if baseDependType == BattleBuffEffectDependType.ATK_CARD then
                                                    totalValue = totalValue + (math.ceil)(atkCard:GetDef(true) * upValue / 10000)
                                                  else
                                                    if baseDependType == BattleBuffEffectDependType.DEF_CARD then
                                                      totalValue = totalValue + (math.ceil)(defCard:GetDef(true) * upValue / 10000)
                                                    end
                                                  end
                                                else
                                                  if upType == BattleBuffEffectCalType.HP_PER then
                                                    if baseDependType == BattleBuffEffectDependType.ATK_CARD then
                                                      totalValue = totalValue + (math.ceil)(atkCard:GetMaxHp(true) * upValue / 10000)
                                                    else
                                                      if baseDependType == BattleBuffEffectDependType.DEF_CARD then
                                                        totalValue = totalValue + (math.ceil)(defCard:GetMaxHp(true) * upValue / 10000)
                                                      end
                                                    end
                                                  else
                                                    if atkInfo and upType == BattleBuffEffectCalType.HURT_PER then
                                                      local totalDamage = GetAtkDamage(atkInfo)
                                                      totalValue = totalValue + (math.ceil)((math.abs)(totalDamage) * upValue / 10000)
                                                    else
                                                      do
                                                        if upType == BattleBuffEffectCalType.ATK_BASED_TARGET_DEAD then
                                                          totalValue = totalValue + (math.ceil)((3 - self.targetCount) / self.targetCount * atkCard:GetAtk(true) * upValue / 10000)
                                                        else
                                                          if upType == BattleBuffEffectCalType.ATK_BASED_SELF_DEAD then
                                                            local count = GetCampDeadCount(atkCard:GetCampFlag())
                                                            totalValue = totalValue + (math.ceil)(count * atkCard:GetAtk(true) * upValue / 10000)
                                                          else
                                                            do
                                                              if upType == BattleBuffEffectCalType.ATK_BASED_ALL_DEAD then
                                                                local count = GetCampDeadCount()
                                                                totalValue = totalValue + (math.ceil)(count * atkCard:GetAtk(true) * upValue / 10000)
                                                              else
                                                                do
                                                                  if upType == BattleBuffEffectCalType.ATK_BASED_TARGET_HP then
                                                                    local per = (math.floor)((1 - defCard:GetHp() / defCard:GetMaxHp(true)) / 0.1)
                                                                    totalValue = totalValue + (math.ceil)(per * atkCard:GetAtk() * upValue / 10000)
                                                                  else
                                                                    do
                                                                      if atkInfo and upType == BattleBuffEffectCalType.DAMAGE_BASED_TARGET_DEAD then
                                                                        local totalDamage = GetAtkDamage(atkInfo)
                                                                        totalValue = totalValue + (math.ceil)((math.abs)(totalDamage / self.targetCount) * upValue / 10000)
                                                                      else
                                                                        do
                                                                          do
                                                                            if upType == BattleBuffEffectCalType.ATK_BASED_CLEAR_BUFF then
                                                                              totalValue = totalValue + (math.ceil)(self:GetClearCount() * atkCard:GetAtk(true) * upValue / 10000)
                                                                            else
                                                                              if upType == BattleBuffEffectCalType.SPD_PER then
                                                                                if baseDependType == BattleBuffEffectDependType.ATK_CARD then
                                                                                  totalValue = totalValue + (math.ceil)(atkCard:GetSpd(true) * upValue / 10000)
                                                                                else
                                                                                  if baseDependType == BattleBuffEffectDependType.DEF_CARD then
                                                                                    totalValue = totalValue + (math.ceil)(defCard:GetSpd(true) * upValue / 10000)
                                                                                  end
                                                                                end
                                                                              end
                                                                            end
                                                                            if oneEffect.effectId == BattleDisplayEffect.SHIELD and oneEffect.attributeId == BattleCardAttributeID.HP and self:GetActiveForever() == 0 then
                                                                              self:SetShieldHp(totalValue)
                                                                            end
                                                                            t_insert(effectTable, {effectId = oneEffect.effectId, attributeId = oneEffect.attributeId, value = totalValue, realValue = totalValue})
                                                                            -- DECOMPILER ERROR at PC636: LeaveBlock: unexpected jumping out DO_STMT

                                                                            -- DECOMPILER ERROR at PC636: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                            -- DECOMPILER ERROR at PC636: LeaveBlock: unexpected jumping out IF_STMT

                                                                            -- DECOMPILER ERROR at PC636: LeaveBlock: unexpected jumping out DO_STMT

                                                                            -- DECOMPILER ERROR at PC636: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                            -- DECOMPILER ERROR at PC636: LeaveBlock: unexpected jumping out IF_STMT

                                                                            -- DECOMPILER ERROR at PC636: LeaveBlock: unexpected jumping out DO_STMT

                                                                            -- DECOMPILER ERROR at PC636: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                            -- DECOMPILER ERROR at PC636: LeaveBlock: unexpected jumping out IF_STMT

                                                                            -- DECOMPILER ERROR at PC636: LeaveBlock: unexpected jumping out DO_STMT

                                                                            -- DECOMPILER ERROR at PC636: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                            -- DECOMPILER ERROR at PC636: LeaveBlock: unexpected jumping out IF_STMT

                                                                            -- DECOMPILER ERROR at PC636: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                            -- DECOMPILER ERROR at PC636: LeaveBlock: unexpected jumping out IF_STMT

                                                                            -- DECOMPILER ERROR at PC636: LeaveBlock: unexpected jumping out DO_STMT

                                                                            -- DECOMPILER ERROR at PC636: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                            -- DECOMPILER ERROR at PC636: LeaveBlock: unexpected jumping out IF_STMT

                                                                            -- DECOMPILER ERROR at PC636: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                            -- DECOMPILER ERROR at PC636: LeaveBlock: unexpected jumping out IF_STMT

                                                                            -- DECOMPILER ERROR at PC636: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                            -- DECOMPILER ERROR at PC636: LeaveBlock: unexpected jumping out IF_STMT

                                                                            -- DECOMPILER ERROR at PC636: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                            -- DECOMPILER ERROR at PC636: LeaveBlock: unexpected jumping out IF_STMT

                                                                            -- DECOMPILER ERROR at PC636: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                            -- DECOMPILER ERROR at PC636: LeaveBlock: unexpected jumping out IF_STMT

                                                                            -- DECOMPILER ERROR at PC636: LeaveBlock: unexpected jumping out DO_STMT

                                                                            -- DECOMPILER ERROR at PC636: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                            -- DECOMPILER ERROR at PC636: LeaveBlock: unexpected jumping out IF_STMT

                                                                            -- DECOMPILER ERROR at PC636: LeaveBlock: unexpected jumping out DO_STMT

                                                                            -- DECOMPILER ERROR at PC636: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                            -- DECOMPILER ERROR at PC636: LeaveBlock: unexpected jumping out IF_STMT

                                                                            -- DECOMPILER ERROR at PC636: LeaveBlock: unexpected jumping out DO_STMT

                                                                            -- DECOMPILER ERROR at PC636: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                            -- DECOMPILER ERROR at PC636: LeaveBlock: unexpected jumping out IF_STMT

                                                                            -- DECOMPILER ERROR at PC636: LeaveBlock: unexpected jumping out DO_STMT

                                                                            -- DECOMPILER ERROR at PC636: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                            -- DECOMPILER ERROR at PC636: LeaveBlock: unexpected jumping out IF_STMT

                                                                            -- DECOMPILER ERROR at PC636: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                            -- DECOMPILER ERROR at PC636: LeaveBlock: unexpected jumping out IF_STMT

                                                                            -- DECOMPILER ERROR at PC636: LeaveBlock: unexpected jumping out DO_STMT

                                                                            -- DECOMPILER ERROR at PC636: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                            -- DECOMPILER ERROR at PC636: LeaveBlock: unexpected jumping out IF_STMT

                                                                            -- DECOMPILER ERROR at PC636: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                            -- DECOMPILER ERROR at PC636: LeaveBlock: unexpected jumping out IF_STMT

                                                                            -- DECOMPILER ERROR at PC636: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                            -- DECOMPILER ERROR at PC636: LeaveBlock: unexpected jumping out IF_STMT

                                                                            -- DECOMPILER ERROR at PC636: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                            -- DECOMPILER ERROR at PC636: LeaveBlock: unexpected jumping out IF_STMT

                                                                            -- DECOMPILER ERROR at PC636: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                            -- DECOMPILER ERROR at PC636: LeaveBlock: unexpected jumping out IF_STMT

                                                                            -- DECOMPILER ERROR at PC636: LeaveBlock: unexpected jumping out DO_STMT

                                                                            -- DECOMPILER ERROR at PC636: LeaveBlock: unexpected jumping out DO_STMT

                                                                            -- DECOMPILER ERROR at PC636: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                                                            -- DECOMPILER ERROR at PC636: LeaveBlock: unexpected jumping out IF_STMT

                                                                          end
                                                                        end
                                                                      end
                                                                    end
                                                                  end
                                                                end
                                                              end
                                                            end
                                                          end
                                                        end
                                                      end
                                                    end
                                                  end
                                                end
                                              end
                                            end
                                          end
                                        end
                                      end
                                    end
                                  end
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
      self:SetBuffTimeStamp(tostring((os.time)()))
      self:SetEffectTable(effectTable)
      local m = {buffId = self:GetBuffId(), atkPos = self:GetAtkPos(), curDefPos = self:GetCurDefPos(), activeCount = self:GetActiveCount(), totalCount = self:GetTotalCount(), settleRoundType = self:GetSettleRoundType(), deductionRoundType = self:GetDeductionRoundType(), activeForever = self:GetActiveForever(), shieldHp = self:GetShieldHp(), usedShieldHp = self:GetUsedShieldHp(), buffTimeStamp = self:GetBuffTimeStamp()}
      if needCopy == true then
        m.effectTable = (Util.Copy)(self:GetEffectTable())
        m.summonCards = (Util.Copy)(self:GetSummonCards())
      else
        m.effectTable = self:GetEffectTable()
        m.summonCards = self:GetSummonCards()
      end
      self.buffData = m
      return m
    end
  end

    battleBuff.SetShieldHp = function(self, hp, ...)
    -- function num : 0_0_43 , upvalues : _ENV
    self.shieldHp = hp
    local defCard = (BattleData.GetCardInfoByPos)(self:GetCurDefPos())
    if defCard then
      loge(" 新增护盾     " .. hp)
    end
  end

    battleBuff.GetShieldHp = function(self, ...)
    -- function num : 0_0_44
    return self.shieldHp
  end

    battleBuff.SetUsedShieldHp = function(self, hp, ...)
    -- function num : 0_0_45
    self.usedShieldHp = hp
  end

    battleBuff.GetUsedShieldHp = function(self, ...)
    -- function num : 0_0_46
    return self.usedShieldHp
  end

    battleBuff.GetAttributeValue = function(self, attributeId, ...)
    -- function num : 0_0_47 , upvalues : ipairs
    local value = 0
    local buffData = self:GetBuffInfo()
    if buffData then
      local effectTable = buffData.effectTable
      for _,v in ipairs(effectTable) do
        if v.attributeId == attributeId then
          value = value + v.value
        end
      end
    end
    do
      return value
    end
  end

    battleBuff.Destroy = function(self, ...)
    -- function num : 0_0_48 , upvalues : _ENV
    do
      if IsBattleServer == nil then
        local defCard = (BattleData.GetCardInfoByPos)(self:GetCurDefPos())
        if defCard then
          defCard:RemoveBuff(self, true)
        end
      end
      self = {}
      self.targetPosTable = {}
    end
  end

    battleBuff:Init()
    return battleBuff
  end
end

-- DECOMPILER ERROR at PC24: Confused about usage of register: R13 in 'UnsetPending'

BattleBuff.IsBuffImmune = function(battleCard, newBuff, ...)
  -- function num : 0_1 , upvalues : BattleBuffMgr, ipairs
  local buffTable = (BattleBuffMgr.GetBuffListByCardPos)(battleCard:GetPosIndex())
  if buffTable then
    for _,_buff in ipairs(buffTable) do
      if _buff:IsBuffImmune(newBuff) == true then
        return true
      end
    end
  end
  do
    return false
  end
end

-- DECOMPILER ERROR at PC27: Confused about usage of register: R13 in 'UnsetPending'

BattleBuff.IsTriggerConditionComplete = function(card, buff, atkInfo, ...)
  -- function num : 0_2 , upvalues : _ENV, math, ipairs, BattleBuffMgr
  local BuffTriggerCondition = BuffTriggerCondition
  local ceil = math.ceil
  local CompareNum = Util.CompareNum
  local E_BATTLE_TYPE = ProtoEnum.E_BATTLE_TYPE
  local BattleData = BattleData
  local buffConfig = buff:GetBuffConfig()
  local trigger_condition = buffConfig.trigger_condition
  local trigger_type = buffConfig.trigger_type
  local trigger_value = buffConfig.trigger_value
  local atkPos = buff:GetAtkPos()
  local atkCard = (BattleData.GetCardInfoByPos)(atkPos)
  local battleType = BattleData.battleType
  if trigger_condition > 0 then
    if trigger_condition == BuffTriggerCondition.BUFF_TARGET_HP_PER then
      local hpPer = ceil(10000 * card:GetHp() / card:GetMaxHp())
      if CompareNum(trigger_type, hpPer, trigger_value) == true then
        return true
      end
    else
      do
        do
          if trigger_condition == BuffTriggerCondition.SELF_HP_PER and atkCard then
            local hpPer = ceil(10000 * atkCard:GetHp() / atkCard:GetMaxHp())
            if CompareNum(trigger_type, hpPer, trigger_value) == true then
              return true
            end
          end
          if trigger_condition == BuffTriggerCondition.ATTACK_TARGET_HP_PER then
            local defCardsInfo = atkInfo.defCardsInfo
            for _,v in ipairs(defCardsInfo) do
              local defPos = v.defPos
              if defPos ~= atkPos then
                local defCard = (BattleData.GetCardInfoByPos)(defPos)
                if defCard then
                  local hpPer = ceil(10000 * defCard:GetHp() / defCard:GetMaxHp())
                  if CompareNum(trigger_type, hpPer, trigger_value) == true then
                    return true
                  end
                end
              end
            end
          else
            do
              if trigger_condition == BuffTriggerCondition.SELF_TARGET_DANDER then
                local dander_atk = atkCard:GetDander()
                local dander_def = card:GetDander()
                if CompareNum(trigger_type, dander_atk, dander_def) == true then
                  return true
                end
              else
                do
                  if trigger_condition == BuffTriggerCondition.TARGET_DANDER then
                    local dander = card:GetDander()
                    if CompareNum(trigger_type, dander, trigger_value) == true then
                      return true
                    end
                  else
                    do
                      if trigger_condition == BuffTriggerCondition.SELF_TARGET_ATK then
                        local atk_atk = atkCard:GetAtk()
                        local atk_def = card:GetAtk()
                        if CompareNum(trigger_type, atk_atk, atk_def) == true then
                          return true
                        end
                      else
                        do
                          if trigger_condition == BuffTriggerCondition.SELF_CAMP_CARD_ALIVE then
                            local needCardId = trigger_value
                            local needCard = (BattleData.GetCardByCampAndId)(needCardId, atkCard:GetCampFlag())
                            if needCard and needCard:IsDead() ~= true then
                              return true
                            end
                          else
                            do
                              if trigger_condition == BuffTriggerCondition.TARGET_HAVE_EFFECT then
                                local needEffectId = trigger_value
                                return (BattleBuff.ContainEffectId)(card, needEffectId)
                              else
                                do
                                  if trigger_condition == BuffTriggerCondition.TARGET_HAVE_BUFF_TYPE then
                                    local needBuffType = trigger_value
                                    local buffTable = (BattleBuffMgr.GetBuffListByCardAndType)(card, needBuffType)
                                    return not buffTable or #buffTable > 0
                                  elseif trigger_condition == BuffTriggerCondition.TARGET_HAVE_BUFF then
                                    local needBuff = trigger_value
                                    local buffTable = (BattleBuffMgr.GetBuffListByCardAndId)(card, needBuff)
                                    return not buffTable or #buffTable > 0
                                  elseif trigger_condition == BuffTriggerCondition.RANDOM then
                                    local random = (BattleData.GetRandomSeed)()
                                    if CompareNum(trigger_type, random, trigger_value) == true then
                                      return true
                                    end
                                  else
                                    local isPVE = trigger_condition == BuffTriggerCondition.BATTLE_TYPE_PVE
                                    if (trigger_condition == BuffTriggerCondition.BATTLE_TYPE_PLOT or isPVE == true) and battleType == E_BATTLE_TYPE.STORY then
                                      return true
                                    end
                                    if (trigger_condition == BuffTriggerCondition.BATTLE_TYPE_HERO or isPVE == true) and battleType == E_BATTLE_TYPE.HERO then
                                      return true
                                    end
                                    if (trigger_condition == BuffTriggerCondition.BATTLE_TYPE_DAILY or isPVE == true) and (battleType == E_BATTLE_TYPE.GOLD or battleType == E_BATTLE_TYPE.EXP or battleType == E_BATTLE_TYPE.EQUIPEXP) then
                                      return true
                                    end
                                    if (trigger_condition == BuffTriggerCondition.BATTLE_TYPE_TOWER or isPVE == true) and (battleType == E_BATTLE_TYPE.TOWER or battleType == E_BATTLE_TYPE.TOWER_ENCOUNTER) then
                                      return true
                                    end
                                    if (trigger_condition == BuffTriggerCondition.BATTLE_TYPE_EXPEDITION or isPVE == true) and battleType == E_BATTLE_TYPE.EXPEDITION then
                                      return true
                                    end
                                    if trigger_condition == BuffTriggerCondition.BATTLE_TYPE_ARENA and battleType == E_BATTLE_TYPE.ARENA then
                                      return true
                                    end
                                  end
                                  do return false end
                                  do return true end
                                  -- DECOMPILER ERROR: 22 unprocessed JMP targets
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC30: Confused about usage of register: R13 in 'UnsetPending'

BattleBuff.IsBuffReset = function(battleCard, buff, ...)
  -- function num : 0_3 , upvalues : _ENV, BattleBuffMgr, ipairs
  local clone = Util.Copy
  local BattleDataCount = BattleDataCount
  local BattleBuffDeductionRoundType = BattleBuffDeductionRoundType
  local isReset, canAdd = false, false
  local buffConfig = buff:GetBuffConfig()
  if buffConfig then
    local count = (BattleBuffMgr.GetBuffCountById)(battleCard, buffConfig.id)
    if buffConfig.resetting_round == 1 then
      if count > 0 then
        isReset = true
        canAdd = false
      else
        isReset = false
        canAdd = true
      end
    else
      isReset = false
      canAdd = false
      local overlay_num = buffConfig.overlay_num
      if overlay_num > 0 then
        if overlay_num <= count then
          canAdd = false
          local overlay_buff_list = buffConfig.overlay_buff_list
          if overlay_buff_list and overlay_buff_list ~= "" and overlay_buff_list ~= "0" then
            local newBuffTable = (BattleSkill.GetAllBuffByBuffList)(nil, {}, overlay_buff_list)
            for _,newBuff in ipairs(newBuffTable) do
              local targetCards = buff:GetTargetCard(newBuff.targetId)
              for _,card in ipairs(targetCards) do
                if card and card:IsDead() ~= true then
                  local buffClone = clone(newBuff)
                  buffClone:SetCurDefPos(card:GetPosIndex())
                  buffClone.atkPos = buff.atkPos
                  local canAdd = (BattleDataCount.DealAddBuff)(card, buffClone)
                  if canAdd == true then
                    local deductionRoundType = buffClone:GetDeductionRoundType()
                    if deductionRoundType == BattleBuffDeductionRoundType.NOW then
                      (BattleDataCount.RealUpdateBuffCount)(buffClone, nil, true)
                    end
                  end
                end
              end
            end
          end
        else
          do
            do
              canAdd = true
              canAdd = true
              return isReset, canAdd
            end
          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC33: Confused about usage of register: R13 in 'UnsetPending'

BattleBuff.PlayBuffActive = function(card, buffData, ...)
  -- function num : 0_4 , upvalues : ipairs, _ENV, BattleBuffEffectPosType
  if card and buffData then
    local effectTable = buffData.effectTable
    local buffId = buffData.buffId
    local buffTimeStamp = buffData.buffTimeStamp
    for _,v in ipairs(effectTable) do
      local effectId = v.effectId
      if (BattleBuff.IsShield)(effectId) == true then
        card:SetTotalShield(buffData.shieldHp)
      end
      card:PlayBuffEffect(BattleBuffEffectPosType.BLOOD, effectId, buffId, buffTimeStamp, buffData)
      card:PlayBuffEffect(BattleBuffEffectPosType.HEAD, effectId, buffId, buffTimeStamp, buffData)
      card:PlayBuffEffect(BattleBuffEffectPosType.BODY, effectId, buffId, buffTimeStamp, buffData)
      card:PlayBuffEffect(BattleBuffEffectPosType.AROUND, effectId, buffId, buffTimeStamp, buffData)
      card:PlayBuffEffect(BattleBuffEffectPosType.WORD, effectId, buffId, buffTimeStamp, buffData)
      card:SetControlType(effectId, true)
    end
  end
end

-- DECOMPILER ERROR at PC36: Confused about usage of register: R13 in 'UnsetPending'

BattleBuff.PlayBuffReset = function(card, buffData, ...)
  -- function num : 0_5 , upvalues : ipairs, _ENV
  if card and buffData then
    local effectTable = buffData.effectTable
    for _,v in ipairs(effectTable) do
      local effectId = v.effectId
      if (BattleBuff.IsShield)(effectId) == true then
        card:SetTotalShield(v.realValue)
      end
    end
  end
end

-- DECOMPILER ERROR at PC39: Confused about usage of register: R13 in 'UnsetPending'

BattleBuff.PlayBuffUpdate = function(card, buffData, ...)
  -- function num : 0_6 , upvalues : _ENV, ipairs, math, BattleDisplayEffect, BattleBuffEffectPosType
  local BattleCardAttributeID = BattleCardAttributeID
  local BattleData = BattleData
  local BattleBuff = BattleBuff
  if card and buffData then
    local effectTable = buffData.effectTable
    local activeForever = buffData.activeForever
    if activeForever == 1 then
      for _,v in ipairs(effectTable) do
        local effectId = v.effectId
        local attributeId = v.attributeId
        local value = v.value
        local realValue = v.realValue
        if attributeId == BattleCardAttributeID.HP then
          if not realValue then
            local changeHp = (BattleBuff.IsAddIntoDamage)(effectId) == true or value
          end
          card:ChangeHp({oriValue = value, hurt = changeHp, absorb = v.absorbDamage}, nil, true, v, true)
          if buffData.atkPos ~= 0 and (changeHp < 0 or v.absorbDamage > 0) then
            local atkCard = (BattleData.GetCardInfoByPos)(buffData.atkPos)
            ;
            (BattleResultCount.UpdateDamageDataBuff)(atkCard, card, (math.abs)(changeHp) + v.absorbDamage)
          end
        else
          do
            if attributeId == BattleCardAttributeID.DANDER then
              if effectId == BattleDisplayEffect.DANDER_ABSORB then
                local dander_absorb = -realValue
                if dander_absorb > 0 then
                  local atkCard = (BattleData.GetCardInfoByPos)(buffData.atkPos)
                  if atkCard then
                    atkCard:ChangeDander(dander_absorb)
                  end
                end
              end
              do
                do
                  card:ChangeDander(value)
                  -- DECOMPILER ERROR at PC83: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC83: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC83: LeaveBlock: unexpected jumping out IF_STMT

                  -- DECOMPILER ERROR at PC83: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC83: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                  -- DECOMPILER ERROR at PC83: LeaveBlock: unexpected jumping out IF_STMT

                end
              end
            end
          end
        end
      end
    else
      if (BattleBuff.IsBuffContainEffectId)(buffData, BattleDisplayEffect.SUMMON) == true then
        local summonCards = buffData.summonCards
        if #summonCards > 0 then
          for _,summonCard in ipairs(summonCards) do
            (BattlePlay.CreateCardInBattle)(summonCard)
            UIMgr:SendWindowMessage((WinResConfig.BattleUIWindow).name, (WindowMsgEnum.BattleUIWindow).E_MSG_REFRESH_ORDER_LINE, summonCard.value)
          end
        end
      end
    end
    do
      card:UpdateBuffEffect(BattleBuffEffectPosType.BLOOD, nil, buffData)
      card:UpdateBuffEffect(BattleBuffEffectPosType.HEAD, nil, buffData)
      card:UpdateBuffEffect(BattleBuffEffectPosType.BODY, nil, buffData)
      card:UpdateBuffEffect(BattleBuffEffectPosType.AROUND, nil, buffData)
    end
  end
end

-- DECOMPILER ERROR at PC42: Confused about usage of register: R13 in 'UnsetPending'

BattleBuff.PlayBuffRemove = function(card, buffData, ...)
  -- function num : 0_7 , upvalues : ipairs, BattleBuffEffectPosType, _ENV
  if card and buffData then
    local effectTable = buffData.effectTable
    local buffId = buffData.buffId
    local buffTimeStamp = buffData.buffTimeStamp
    for _,v in ipairs(effectTable) do
      local effectId = v.effectId
      card:RemoveBuffEffect(BattleBuffEffectPosType.BLOOD, effectId, buffId, buffTimeStamp)
      card:RemoveBuffEffect(BattleBuffEffectPosType.HEAD, effectId, buffId, buffTimeStamp)
      card:RemoveBuffEffect(BattleBuffEffectPosType.BODY, effectId, buffId, buffTimeStamp)
      card:RemoveBuffEffect(BattleBuffEffectPosType.AROUND, effectId, buffId, buffTimeStamp)
      card:SetControlType(effectId, false)
      if (BattleBuff.IsShield)(effectId) == true then
        card:SetCurShield(buffData.usedShieldHp - buffData.shieldHp)
      end
    end
  end
end

-- DECOMPILER ERROR at PC45: Confused about usage of register: R13 in 'UnsetPending'

BattleBuff.DealRealHpLoss = function(defCard, damage, isRoundAtk, damageAdd, ...)
  -- function num : 0_8 , upvalues : _ENV, BattleBuffMgr, self, BattleBuffOprType, ipairs, math, BattleDisplayEffect
  local totalDamage = 0
  local absorbDamage = 0
  local specialEffect = {isKeepAlive = false, isInvincible = false}
  local atkInfo = BattleAtk.curAtkInfo
  if damage <= 0 then
    local isHurt = not defCard
    local buffTable = (BattleBuffMgr.GetBuffListByCardPos)(defCard:GetPosIndex())
    if isHurt == true then
      local isSleep, sleepBuff = (self.IsRemoveAnyAttack)(defCard)
      if isSleep == true then
        defCard:SetIsSleep(false)
        if sleepBuff then
          do
            do
              if atkInfo then
                local allBuffTable = atkInfo.allBuffTable
                ;
                (Util.InsertTable)(allBuffTable, {buff = sleepBuff:GetBuffInfo(atkInfo, true), type = BattleBuffOprType.DELETE}, true)
              end
              if IsBattleServer == true then
                (BattleBuffMgr.RemoveBuffFromList)(sleepBuff)
              else
                sleepBuff:SetSleepState(1)
              end
              local damageReduceTotal = 0
              local damageExtraAdd = 0
              for _,buff in ipairs(buffTable) do
                local isCanEffect = buff:IsCanEffect()
                local buffData = buff:GetBuffInfo()
                local effectTable = buffData.effectTable
                for _,v in ipairs(effectTable) do
                  local effectId = v.effectId
                  local attributeId = v.attributeId
                  local value = v.value
                  if (self.IsAddIntoDamage)(effectId) == true and isRoundAtk == true and isCanEffect == true then
                    buff:SetCurRoundActive(true)
                    damageExtraAdd = damageExtraAdd + value
                  end
                  if isHurt == true then
                    if (self.IsInvincible)(effectId) == true and isCanEffect == true then
                      buff:SetCurRoundActive(true)
                      specialEffect.isInvincible = true
                    end
                    if ((self.IsDamageReduce)(effectId) == true or (self.IsDamageAdd)(effectId) == true) and isCanEffect == true then
                      buff:SetCurRoundActive(true)
                      damageReduceTotal = damageReduceTotal + value
                    end
                    if (self.IsResist)(effectId) == true and isCanEffect == true then
                      buff:SetCurRoundActive(true)
                      damageReduceTotal = 10000
                    end
                  end
                end
              end
              if atkInfo and isHurt == true then
                local atkPos = atkInfo.atkPos
                local atkBuffTable = (BattleBuffMgr.GetBuffListByCardPos)(atkPos)
                for _,buff in ipairs(atkBuffTable) do
                  local isCanEffect = buff:IsCanEffect()
                  local buffData = buff:GetBuffInfo()
                  local effectTable = buffData.effectTable
                  for _,v in ipairs(effectTable) do
                    local effectId = v.effectId
                    local attributeId = v.attributeId
                    local value = v.value
                    if (self.IsDeadly)(effectId) == true and isRoundAtk == true and isCanEffect == true then
                      buff:SetCurRoundActive(true)
                      if defCard:GetHp() / defCard:GetMaxHp() > 0.5 then
                        damageExtraAdd = damageExtraAdd + value
                      end
                    end
                  end
                end
              end
              if specialEffect.isInvincible == true then
                if IsBattleServer == nil then
                  print("无敌抵挡伤害： ", "被攻击位置:", defCard:GetPosIndex())
                end
                return 0, damage, specialEffect
              end
              if damageExtraAdd ~= 0 then
                if IsBattleServer == nil then
                  print("             --------------额外伤害:", damageExtraAdd)
                end
                damage = damage - (damageExtraAdd)
              end
              if damageReduceTotal ~= 0 then
                if IsBattleServer == nil then
                  print("             --------------免伤/增伤效果值:", damageReduceTotal)
                end
                damage = (math.ceil)((damage) * (math.max)(0, 10000 - damageReduceTotal) / 10000)
              end
              if isHurt == true and damage < 0 then
                damage = 0
              elseif isHurt == false and damage > 0 then
                damage = 0
              end
              if damageAdd then
                damage = damage * damageAdd
              end
              totalDamage = damage
              if isHurt == true then
                for _,v in ipairs(buffTable) do
                  local shieldHp = v:GetShieldHp()
                  local usedShieldHp = v:GetUsedShieldHp()
                  local leftShieldHp = shieldHp - usedShieldHp
                  if shieldHp > 0 and leftShieldHp > 0 then
                    if leftShieldHp < damage then
                      v:SetUsedShieldHp(shieldHp)
                      damage = damage - leftShieldHp
                      if IsBattleServer == nil then
                        print("被攻击位置:", defCard:GetPosIndex(), " 实际造成伤害：", damage, " 护盾抵挡伤害：", totalDamage - (damage), " 护盾剩余血量：", leftShieldHp - totalDamage + (damage))
                      end
                    else
                      v:SetUsedShieldHp(v:GetUsedShieldHp() + (damage))
                      damage = 0
                      if IsBattleServer == nil then
                        print("被攻击位置:", defCard:GetPosIndex(), " 实际造成伤害：", damage, " 护盾抵挡伤害：", totalDamage - damage, " 护盾剩余血量：", leftShieldHp - totalDamage + damage)
                      end
                      break
                    end
                  end
                end
              end
              absorbDamage = totalDamage - damage
              do
                if (BattleBuff.ContainEffectId)(defCard, BattleDisplayEffect.KEEP_ALIVE) == true then
                  local curCardHp = defCard:GetHp()
                  if curCardHp < damage then
                    damage = curCardHp - 1
                    specialEffect.isKeepAlive = true
                  end
                end
                do return damage, absorbDamage, specialEffect end
                -- DECOMPILER ERROR: 26 unprocessed JMP targets
              end
            end
          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC48: Confused about usage of register: R13 in 'UnsetPending'

BattleBuff.RemoveShieldBuff = function(card, force, ...)
  -- function num : 0_9 , upvalues : _ENV, BattleDisplayEffect, BattleBuffMgr, ipairs
  if card then
    if BattleConfig.isPlayBack == true then
      (BattleBuff.RemoveBuffPlayback)(card, BattleDisplayEffect.SHIELD)
    end
    local buffTable = (BattleBuffMgr.GetBuffListByCardPos)(card:GetPosIndex())
    for _,buff in ipairs(buffTable) do
      local shieldHp = buff:GetShieldHp()
      local usedShieldHp = buff:GetUsedShieldHp()
      if shieldHp > 0 then
        local remove = false
        if force then
          remove = true
        else
          if shieldHp <= usedShieldHp then
            remove = true
          end
        end
        if remove then
          loge("   移除护盾特效    ")
          card:RemoveBuff(buff, true)
          ;
          (BattleBuffMgr.RemoveBuffFromList)(buff)
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC51: Confused about usage of register: R13 in 'UnsetPending'

BattleBuff.RemoveSleepBuff = function(card, force, ...)
  -- function num : 0_10 , upvalues : _ENV, BattleDisplayEffect, BattleBuffMgr, ipairs
  if card then
    if BattleConfig.isPlayBack == true then
      (BattleBuff.RemoveBuffPlayback)(card, BattleDisplayEffect.SLEEP)
    end
    local buffTable = (BattleBuffMgr.GetBuffListByCardPos)(card:GetPosIndex(), true)
    for _,buff in ipairs(buffTable) do
      local sleepState = buff:GetSleepState()
      local remove = false
      if force then
        remove = true
      else
        if sleepState == 1 then
          remove = true
        end
      end
      if remove then
        loge("   移除催眠特效    ")
        card:RemoveBuff(buff, true)
        ;
        (BattleBuffMgr.RemoveBuffFromList)(buff)
      end
    end
  end
end

-- DECOMPILER ERROR at PC54: Confused about usage of register: R13 in 'UnsetPending'

BattleBuff.RemoveBuffPlayback = function(card, removeEffectId, ...)
  -- function num : 0_11 , upvalues : BattleBuffMgr, ipairs, _ENV
  local buffTable = (BattleBuffMgr.GetBuffPlayBackList)()
  for i = #buffTable, 1, -1 do
    local buffData = buffTable[i]
    local defPos = buffData.curDefPos
    if defPos == card:GetPosIndex() then
      local effectTable = buffData.effectTable
      for _,effect in ipairs(effectTable) do
        if effect.effectId == removeEffectId then
          (BattleBuff.PlayBuffRemove)(card, buffData)
          ;
          (table.remove)(buffTable, i)
          break
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC57: Confused about usage of register: R13 in 'UnsetPending'

BattleBuff.IsBuffBlind = function(card, atkInfo, ...)
  -- function num : 0_12 , upvalues : self
  if card then
    if atkInfo and atkInfo.isAssist == true then
      return false
    end
    return (self.IsForbiddenAttackHit)(card)
  end
  return false
end

-- DECOMPILER ERROR at PC60: Confused about usage of register: R13 in 'UnsetPending'

BattleBuff.IsBuffSilent = function(card, atkInfo, ...)
  -- function num : 0_13 , upvalues : self
  if card then
    if atkInfo and atkInfo.isAssist == true then
      return false
    end
    return (self.IsForbiddenSkill)(card)
  end
  return false
end

-- DECOMPILER ERROR at PC63: Confused about usage of register: R13 in 'UnsetPending'

BattleBuff.IsBuffEnchantment = function(card, atkInfo, ...)
  -- function num : 0_14 , upvalues : self
  if card then
    if atkInfo and atkInfo.isAssist == true then
      return false
    end
    if (self.IsForbiddenSkill)(card) and (self.IsForbiddenSmall)(card) and (self.IsForbiddenAssist)(card) then
      do return (self.IsTargetSelf)(card) end
      return false
    end
  end
end

-- DECOMPILER ERROR at PC66: Confused about usage of register: R13 in 'UnsetPending'

BattleBuff.IsBuffConfusion = function(card, atkInfo, ...)
  -- function num : 0_15 , upvalues : self
  if card then
    if atkInfo and atkInfo.isAssist == true then
      return false
    end
    if (self.IsForbiddenSkill)(card) and (self.IsForbiddenSmall)(card) and (self.IsForbiddenAssist)(card) then
      do return (self.IsTargetRandom)(card) end
      return false
    end
  end
end

-- DECOMPILER ERROR at PC69: Confused about usage of register: R13 in 'UnsetPending'

BattleBuff.IsBuffStun = function(card, atkInfo, ...)
  -- function num : 0_16 , upvalues : self
  if card then
    if atkInfo and atkInfo.isAssist == true then
      return false
    end
    if (self.IsForbiddenNormal)(card) and (self.IsForbiddenSmall)(card) and (self.IsForbiddenSkill)(card) and (self.IsForbiddenAssistPassive)(card) then
      do return (self.IsForbiddenBlock)(card) end
      return false
    end
  end
end

-- DECOMPILER ERROR at PC72: Confused about usage of register: R13 in 'UnsetPending'

BattleBuff.IsBuffSleep = function(card, atkInfo, ...)
  -- function num : 0_17 , upvalues : self
  if card then
    if atkInfo and atkInfo.isAssist == true then
      return false
    end
    if (self.IsForbiddenNormal)(card) and (self.IsForbiddenSmall)(card) and (self.IsForbiddenSkill)(card) and (self.IsForbiddenAssistPassive)(card) and (self.IsForbiddenDefendDodge)(card) then
      do return (self.IsRemoveAnyAttack)(card) end
      return false
    end
  end
end

-- DECOMPILER ERROR at PC75: Confused about usage of register: R13 in 'UnsetPending'

BattleBuff.IsBuffParalysis = function(card, atkInfo, ...)
  -- function num : 0_18 , upvalues : self
  if card then
    if atkInfo and atkInfo.isAssist == true then
      return false
    end
    if (self.IsForbiddenNormal)(card) and (self.IsForbiddenSmall)(card) then
      do return (self.IsForbiddenAssistPassive)(card) end
      return false
    end
  end
end

-- DECOMPILER ERROR at PC78: Confused about usage of register: R13 in 'UnsetPending'

BattleBuff.IsForbiddenNormal = function(card, ...)
  -- function num : 0_19 , upvalues : self, BattleBuffControlType
  return (self.ContainControlType)(card, BattleBuffControlType.FORBIDDEN_NORMAL)
end

-- DECOMPILER ERROR at PC81: Confused about usage of register: R13 in 'UnsetPending'

BattleBuff.IsForbiddenSmall = function(card, ...)
  -- function num : 0_20 , upvalues : self, BattleBuffControlType
  return (self.ContainControlType)(card, BattleBuffControlType.FORBIDDEN_SMALL)
end

-- DECOMPILER ERROR at PC84: Confused about usage of register: R13 in 'UnsetPending'

BattleBuff.IsForbiddenSkill = function(card, ...)
  -- function num : 0_21 , upvalues : self, BattleBuffControlType
  return (self.ContainControlType)(card, BattleBuffControlType.FORBIDDEN_SKILL)
end

-- DECOMPILER ERROR at PC87: Confused about usage of register: R13 in 'UnsetPending'

BattleBuff.IsForbiddenAssist = function(card, ...)
  -- function num : 0_22 , upvalues : self, BattleBuffControlType
  return (self.ContainControlType)(card, BattleBuffControlType.FORBIDDEN_ASSIST)
end

-- DECOMPILER ERROR at PC90: Confused about usage of register: R13 in 'UnsetPending'

BattleBuff.IsForbiddenAssistPassive = function(card, ...)
  -- function num : 0_23 , upvalues : self, BattleBuffControlType
  return (self.ContainControlType)(card, BattleBuffControlType.FORBIDDEN_ASSIST_PASSIVE)
end

-- DECOMPILER ERROR at PC93: Confused about usage of register: R13 in 'UnsetPending'

BattleBuff.IsForbiddenBlock = function(card, ...)
  -- function num : 0_24 , upvalues : self, BattleBuffControlType
  return (self.ContainControlType)(card, BattleBuffControlType.FORBIDDEN_BLOCK)
end

-- DECOMPILER ERROR at PC96: Confused about usage of register: R13 in 'UnsetPending'

BattleBuff.IsForbiddenAttackHit = function(card, ...)
  -- function num : 0_25 , upvalues : self, BattleBuffControlType
  return (self.ContainControlType)(card, BattleBuffControlType.FORBIDDEN_ATTACK_HIT)
end

-- DECOMPILER ERROR at PC99: Confused about usage of register: R13 in 'UnsetPending'

BattleBuff.IsForbiddenDefendDodge = function(card, ...)
  -- function num : 0_26 , upvalues : self, BattleBuffControlType
  return (self.ContainControlType)(card, BattleBuffControlType.FORBIDDEN_DEFEND_DODGE)
end

-- DECOMPILER ERROR at PC102: Confused about usage of register: R13 in 'UnsetPending'

BattleBuff.IsTargetForce = function(card, ...)
  -- function num : 0_27 , upvalues : self, BattleBuffControlType
  return (self.ContainControlType)(card, BattleBuffControlType.TARGET_FORCE)
end

-- DECOMPILER ERROR at PC105: Confused about usage of register: R13 in 'UnsetPending'

BattleBuff.IsTargetRandom = function(card, ...)
  -- function num : 0_28 , upvalues : self, BattleBuffControlType
  return (self.ContainControlType)(card, BattleBuffControlType.TARGET_RANDOM)
end

-- DECOMPILER ERROR at PC108: Confused about usage of register: R13 in 'UnsetPending'

BattleBuff.IsTargetSelf = function(card, ...)
  -- function num : 0_29 , upvalues : self, BattleBuffControlType
  return (self.ContainControlType)(card, BattleBuffControlType.TARGET_SELF)
end

-- DECOMPILER ERROR at PC111: Confused about usage of register: R13 in 'UnsetPending'

BattleBuff.IsRemoveAnyAttack = function(card, ...)
  -- function num : 0_30 , upvalues : self, BattleBuffControlType
  return (self.ContainControlType)(card, BattleBuffControlType.REMOVE_ANY_ATTACK)
end

-- DECOMPILER ERROR at PC114: Confused about usage of register: R13 in 'UnsetPending'

BattleBuff.IsForbiddenTreatment = function(card, ...)
  -- function num : 0_31 , upvalues : self, BattleBuffControlType
  return (self.ContainControlType)(card, BattleBuffControlType.FORBIDDEN_TREATMENT)
end

-- DECOMPILER ERROR at PC117: Confused about usage of register: R13 in 'UnsetPending'

BattleBuff.ContainControlType = function(card, controlType, ...)
  -- function num : 0_32 , upvalues : _ENV, BattleBuffMgr, ipairs
  local ContainControlType = BattleBuffEffect.ContainControlType
  if card and controlType then
    local buffTable = nil
    if BattleConfig.isPlayBack == true then
      buffTable = (BattleBuffMgr.GetBuffPlayBackList)()
      for _,v in ipairs(buffTable) do
        if v.curDefPos == card:GetPosIndex() then
          local effectTable = v.effectTable
          for _,effect in ipairs(effectTable) do
            if ContainControlType(effect.effectId, controlType) then
              return true, v
            end
          end
        end
      end
    else
      do
        buffTable = (BattleBuffMgr.GetBuffList)()
        for _,v in ipairs(buffTable) do
          if v:GetCurDefPos() == card:GetPosIndex() then
            local buffData = v:GetBuffInfo()
            local effectTable = buffData.effectTable
            for _,effect in ipairs(effectTable) do
              if ContainControlType(effect.effectId, controlType) then
                return true, v
              end
            end
          end
        end
        do
          return false
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC120: Confused about usage of register: R13 in 'UnsetPending'

BattleBuff.IsAddIntoDamage = function(effectId, ...)
  -- function num : 0_33 , upvalues : BattleDisplayEffect
  do return effectId == BattleDisplayEffect.DAMAGE_EXTRA end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC123: Confused about usage of register: R13 in 'UnsetPending'

BattleBuff.IsDeadly = function(effectId, ...)
  -- function num : 0_34 , upvalues : BattleDisplayEffect
  do return effectId == BattleDisplayEffect.DEADLY end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC126: Confused about usage of register: R13 in 'UnsetPending'

BattleBuff.IsDamageReduce = function(effectId, ...)
  -- function num : 0_35 , upvalues : BattleDisplayEffect
  do return effectId == BattleDisplayEffect.DAMAGE_REDUCE or effectId == BattleDisplayEffect.HIT_DAMAGE_CHANGE end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC129: Confused about usage of register: R13 in 'UnsetPending'

BattleBuff.IsDamageAdd = function(effectId, ...)
  -- function num : 0_36 , upvalues : BattleDisplayEffect
  do return effectId == BattleDisplayEffect.STAMP or effectId == BattleDisplayEffect.ATTACK_DAMAGE_CHANGE end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC132: Confused about usage of register: R13 in 'UnsetPending'

BattleBuff.IsResist = function(effectId, ...)
  -- function num : 0_37 , upvalues : BattleDisplayEffect
  do return effectId == BattleDisplayEffect.RESIST end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC135: Confused about usage of register: R13 in 'UnsetPending'

BattleBuff.IsInvincible = function(effectId, ...)
  -- function num : 0_38 , upvalues : BattleDisplayEffect
  do return effectId == BattleDisplayEffect.INVINCIBLE end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC138: Confused about usage of register: R13 in 'UnsetPending'

BattleBuff.IsKeepAlive = function(effectId, ...)
  -- function num : 0_39 , upvalues : BattleDisplayEffect
  do return effectId == BattleDisplayEffect.KEEP_ALIVE end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC141: Confused about usage of register: R13 in 'UnsetPending'

BattleBuff.IsShield = function(effectId, ...)
  -- function num : 0_40 , upvalues : BattleDisplayEffect
  do return effectId == BattleDisplayEffect.SHIELD end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC144: Confused about usage of register: R13 in 'UnsetPending'

BattleBuff.IsDamageShare = function(card, ...)
  -- function num : 0_41 , upvalues : self, BattleDisplayEffect
  if card then
    return (self.ContainEffectId)(card, BattleDisplayEffect.DAMAGE_SHARE)
  end
  return false
end

-- DECOMPILER ERROR at PC147: Confused about usage of register: R13 in 'UnsetPending'

BattleBuff.IsAttackDouble = function(card, ...)
  -- function num : 0_42 , upvalues : self, BattleDisplayEffect
  if card then
    return (self.ContainEffectId)(card, BattleDisplayEffect.DOUBLE_ATTACK)
  end
  return false
end

-- DECOMPILER ERROR at PC150: Confused about usage of register: R13 in 'UnsetPending'

BattleBuff.IsBuffInvincible = function(card, ...)
  -- function num : 0_43 , upvalues : self, BattleDisplayEffect
  if card then
    return (self.ContainEffectId)(card, BattleDisplayEffect.INVINCIBLE)
  end
  return false
end

-- DECOMPILER ERROR at PC153: Confused about usage of register: R13 in 'UnsetPending'

BattleBuff.IsBlockPersist = function(card, ...)
  -- function num : 0_44 , upvalues : self, BattleDisplayEffect
  if card then
    return (self.ContainEffectId)(card, BattleDisplayEffect.BLOCK_PERSIST)
  end
  return false
end

-- DECOMPILER ERROR at PC156: Confused about usage of register: R13 in 'UnsetPending'

BattleBuff.IsCritPersist = function(card, ...)
  -- function num : 0_45 , upvalues : self, BattleDisplayEffect
  if card then
    return (self.ContainEffectId)(card, BattleDisplayEffect.CRIT_PERSIST)
  end
  return false
end

-- DECOMPILER ERROR at PC159: Confused about usage of register: R13 in 'UnsetPending'

BattleBuff.IsRebPersist = function(card, ...)
  -- function num : 0_46 , upvalues : self, BattleDisplayEffect
  if card then
    return (self.ContainEffectId)(card, BattleDisplayEffect.REB_PERSIST)
  end
  return false
end

-- DECOMPILER ERROR at PC162: Confused about usage of register: R13 in 'UnsetPending'

BattleBuff.IsRecPersist = function(card, ...)
  -- function num : 0_47 , upvalues : self, BattleDisplayEffect
  if card then
    return (self.ContainEffectId)(card, BattleDisplayEffect.REC_PERSIST)
  end
  return false
end

-- DECOMPILER ERROR at PC165: Confused about usage of register: R13 in 'UnsetPending'

BattleBuff.IsDirectKill = function(card, ...)
  -- function num : 0_48 , upvalues : self, BattleDisplayEffect
  if card then
    return (self.ContainEffectId)(card, BattleDisplayEffect.DIRECT_KILL)
  end
  return false
end

-- DECOMPILER ERROR at PC168: Confused about usage of register: R13 in 'UnsetPending'

BattleBuff.IsAttract = function(card, ...)
  -- function num : 0_49 , upvalues : _ENV, BattleDisplayEffect
  do
    if card then
      local isAttract, buff = (BattleBuff.ContainEffectId)(card, BattleDisplayEffect.ATTRACT)
      return isAttract, buff
    end
    return false
  end
end

-- DECOMPILER ERROR at PC171: Confused about usage of register: R13 in 'UnsetPending'

BattleBuff.GetCounterValue = function(card, ...)
  -- function num : 0_50 , upvalues : BattleBuffMgr, ipairs, BattleDisplayEffect
  local totalValue = 0
  if card then
    local buffTable = (BattleBuffMgr.GetBuffList)()
    for _,v in ipairs(buffTable) do
      if v:GetCurDefPos() == card:GetPosIndex() then
        local buffData = v:GetBuffInfo()
        local effectTable = buffData.effectTable
        for _,effect in ipairs(effectTable) do
          if effect.effectId == BattleDisplayEffect.COUNTER then
            totalValue = totalValue + effect.value
          end
        end
      end
    end
  end
  do
    return totalValue
  end
end

-- DECOMPILER ERROR at PC174: Confused about usage of register: R13 in 'UnsetPending'

BattleBuff.GetDamageShareInfo = function(buff, ...)
  -- function num : 0_51 , upvalues : ipairs, BattleDisplayEffect, _ENV
  local value = 0
  local buffData = buff:GetBuffInfo()
  local atkPos = buff:GetAtkPos()
  local effectTable = buffData.effectTable
  for _,effect in ipairs(effectTable) do
    if effect.effectId == BattleDisplayEffect.DAMAGE_SHARE then
      value = value + effect.value
    end
  end
  local card = (BattleData.GetCardInfoByPos)(atkPos)
  if card == nil or card:IsDead() == true then
    return nil, 0
  end
  return card, value
end

-- DECOMPILER ERROR at PC177: Confused about usage of register: R13 in 'UnsetPending'

BattleBuff.IsCardCanShareDamage = function(card, ...)
  -- function num : 0_52 , upvalues : _ENV
  if (BattleBuff.IsBuffSleep)(card) == true or (BattleBuff.IsBuffStun)(card) == true or (BattleBuff.IsBuffParalysis)(card) == true then
    return false
  end
  return true
end

-- DECOMPILER ERROR at PC180: Confused about usage of register: R13 in 'UnsetPending'

BattleBuff.ContainEffectId = function(card, effectId, ...)
  -- function num : 0_53 , upvalues : BattleBuffMgr, ipairs
  if card and effectId then
    local buffTable = (BattleBuffMgr.GetBuffList)()
    for _,v in ipairs(buffTable) do
      if v:GetCurDefPos() == card:GetPosIndex() then
        local buffData = v:GetBuffInfo()
        local effectTable = buffData.effectTable
        for _,effect in ipairs(effectTable) do
          if effect.effectId == effectId then
            return true, v, effect
          end
        end
      end
    end
  end
  do
    return false
  end
end

-- DECOMPILER ERROR at PC183: Confused about usage of register: R13 in 'UnsetPending'

BattleBuff.ContainBuffGroup = function(card, type, ...)
  -- function num : 0_54 , upvalues : BattleBuffMgr, ipairs
  if card and type then
    local buffTable = (BattleBuffMgr.GetBuffList)()
    for _,v in ipairs(buffTable) do
      local config = v:GetBuffConfig()
      if config.type == type and v:GetCurDefPos() == card:GetPosIndex() then
        return true
      end
    end
  end
  do
    return false
  end
end

-- DECOMPILER ERROR at PC186: Confused about usage of register: R13 in 'UnsetPending'

BattleBuff.IsBuffContainEffectId = function(buff, effectId, ...)
  -- function num : 0_55 , upvalues : ipairs
  if buff and effectId then
    local effectTable = nil
    if buff.GetEffectTable then
      effectTable = buff:GetEffectTable()
    else
      effectTable = buff.effectTable
    end
    for _,effect in ipairs(effectTable) do
      if effect.effectId == effectId then
        return true
      end
    end
  end
  do
    return false
  end
end

-- DECOMPILER ERROR at PC189: Confused about usage of register: R13 in 'UnsetPending'

BattleBuff.GetUniqueSkillDamageAdd = function(atkCard, ...)
  -- function num : 0_56 , upvalues : BattleBuffMgr, ipairs, BattleDisplayEffect
  local totalAddPercent = 0
  local buffTable = BattleBuffMgr.buffList
  for _,buff in ipairs(buffTable) do
    if buff:GetCurDefPos() == atkCard:GetPosIndex() then
      local buffData = buff:GetBuffInfo()
      local effectTable = buffData.effectTable
      for _,effect in ipairs(effectTable) do
        if effect.effectId == BattleDisplayEffect.UNIQUESKILL_DAMAGE_ADD then
          totalAddPercent = totalAddPercent + effect.value
        end
      end
    end
  end
  return totalAddPercent
end


