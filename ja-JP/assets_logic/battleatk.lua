-- params : ...
-- function num : 0 , upvalues : _ENV
BattleAtk = {curAtkInfo = nil, defCardComplete = false, 
waitActionCardPosTable = {}
}
local self = BattleAtk
require("BattleBuffMgr")
local BattleBuffMgr = BattleBuffMgr
local BattleBuffSettleRoundType = BattleBuffSettleRoundType
local BattleBuffDeductionRoundType = BattleBuffDeductionRoundType
local ipairs = ipairs
local t_insert = table.insert
local split = split
local tonumber = tonumber
local value0 = (BattleUtil.GetValue0)()
local math = math
local TARGET_CARD = BattleAttackMovePosType.TARGET_CARD
if Util then
  local clone = Util.Copy
end
-- DECOMPILER ERROR at PC31: Confused about usage of register: R12 in 'UnsetPending'

BattleAtk.ClearAtkInfo = function(...)
  -- function num : 0_0 , upvalues : self
  self.curAtkInfo = nil
  self.waitActionCardPosTable = {}
end

-- DECOMPILER ERROR at PC34: Confused about usage of register: R12 in 'UnsetPending'

BattleAtk.InitAtkInfo = function(atkCard, defCards, skillConfig, withoutBuff, ...)
  -- function num : 0_1 , upvalues : TARGET_CARD, _ENV, ipairs, clone, BattleBuffMgr, value0, t_insert
  local atkInfo = {atkIndex = 0, 
allBuffTable = {}
, atkPos = 0, atkCardUid = "", hpAtk = 0, danderAtk = 0, atkCardUid = "", atkCardUid = "", skillId = 0, skillType = 0, 
doubleAtkInfo = {}
, 
assistAtkInfo = {}
, isAssist = false, isTreatment = false, 
defCardsInfo = {}
, isStrike = false, isFall = false, lastAtk = false, isDoubleAttack = false, moveCamera = false, atkFail = false, noAtkAction = false, targetSelf = false, movePosType = TARGET_CARD}
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R5 in 'UnsetPending'

  BattleData.atkIndex = BattleData.atkIndex + 1
  atkInfo.atkIndex = BattleData.atkIndex
  if skillConfig and withoutBuff ~= true then
    local buffTable = (BattleSkill.GetAllBuff)(atkCard, defCards, skillConfig)
    local GetCardInfoByPos = BattleData.GetCardInfoByPos
    for _,buff in ipairs(buffTable) do
      local targetPosTable = buff:GetTargetPosTable()
      for _,targetPos in ipairs(targetPosTable) do
        local targetCard = GetCardInfoByPos(targetPos)
        if targetCard and targetCard:IsDead() ~= true then
          local buffClone = clone(buff)
          buffClone:SetCurDefPos(targetCard:GetPosIndex())
          ;
          (BattleBuffMgr.AddTempBuffToList)(buffClone)
        end
      end
    end
  end
  do
    atkInfo.atkPos = atkCard and atkCard:GetPosIndex() or value0
    atkInfo.atkCardUid = atkCard and atkCard:GetCardUid() or ""
    atkInfo.hpAtk = value0
    atkInfo.danderAtk = value0
    atkInfo.skillId = skillConfig and skillConfig.id or value0
    atkInfo.skillType = skillConfig and skillConfig.type or value0
    atkInfo.isAssist = atkInfo.skillType == BattleSkillType.ASSIST
    if defCards then
      for _,defCard in ipairs(defCards) do
        local subAtkInfo = {defPos = defCard:GetPosIndex(), isSkillTarget = true, defCardUid = defCard:GetCardUid(), hpDef = value0, danderDef = value0, isDodge = false, isCrit = false, isBlock = false, absorbDamage = value0}
        t_insert(atkInfo.defCardsInfo, subAtkInfo)
      end
    end
    do return atkInfo end
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
  end
end

-- DECOMPILER ERROR at PC37: Confused about usage of register: R12 in 'UnsetPending'

BattleAtk.InitSubAtkInfo = function(defCard, defCardsInfo, ...)
  -- function num : 0_2 , upvalues : ipairs, value0, t_insert
  local isFind = false
  for _,v in ipairs(defCardsInfo) do
    if v.defCardUid == defCard:GetCardUid() then
      isFind = true
      return v
    end
  end
  local subAtkInfo = {defPos = defCard:GetPosIndex(), defCardUid = defCard:GetCardUid(), hpDef = value0, danderDef = value0, isDodge = false, isCrit = false, isBlock = false, absorbDamage = value0, isInvincible = false, isKeepAlive = false, isCounter = false, shareDamageCardPos = 0, isSkillTarget = false}
  t_insert(defCardsInfo, subAtkInfo)
  return subAtkInfo
end

-- DECOMPILER ERROR at PC40: Confused about usage of register: R12 in 'UnsetPending'

BattleAtk.InsertBuffNoAtk = function(atkCard, atkFail, skillConfig, ...)
  -- function num : 0_3 , upvalues : _ENV, self, BattleBuffSettleRoundType, BattleBuffDeductionRoundType, t_insert
  local BattleDataCount = BattleDataCount
  local BattleSkillType = BattleSkillType
  local curTargetCards = (BattleChoose.GetAtkTarget)(atkCard, skillConfig)
  if #curTargetCards > 0 then
    local atkInfo = (self.InitAtkInfo)(atkCard, curTargetCards, skillConfig)
    self.curAtkInfo = atkInfo
    if atkFail == true then
      atkInfo.atkFail = true
    else
      atkInfo.atkFail = false
      atkInfo.noAtkAction = true
      atkInfo.danderAtk = atkCard:GetDanderAtk()
      if skillConfig.type == BattleSkillType.SKILL then
        atkInfo.danderAtk = atkInfo.danderAtk - atkCard:GetMaxDander()
      end
      atkCard:SetDander(atkCard:GetDander() + atkInfo.danderAtk)
    end
    if skillConfig.type == BattleSkillType.SKILL then
      (BattleDataCount.DealActiveBuff)(atkCard, atkInfo, BattleBuffSettleRoundType.BEFORE_SKILL)
      ;
      (BattleDataCount.UpdateBuffCount)(atkInfo, BattleBuffDeductionRoundType.BEFORE_SKILL)
      if atkCard:IsDead() ~= true then
        (BattleDataCount.DealActiveBuff)(atkCard, atkInfo, BattleBuffSettleRoundType.AFTER_SKILL)
        ;
        (BattleDataCount.UpdateBuffCount)(atkInfo, BattleBuffDeductionRoundType.AFTER_SKILL)
      end
      ;
      (BattleDataCount.UpdateBuffCount)(atkInfo, BattleBuffDeductionRoundType.AFTER_SKILL_ENEMY)
    else
      ;
      (BattleDataCount.DealActiveBuff)(atkCard, atkInfo, BattleBuffSettleRoundType.BEFORE_ATTACK)
      ;
      (BattleDataCount.UpdateBuffCount)(atkInfo, BattleBuffDeductionRoundType.BEFORE_ATTACK)
      if atkCard:IsDead() ~= true then
        (BattleDataCount.DealActiveBuff)(atkCard, atkInfo, BattleBuffSettleRoundType.AFTER_ATTACK)
        ;
        (BattleDataCount.UpdateBuffCount)(atkInfo, BattleBuffDeductionRoundType.AFTER_ATTACK)
      end
    end
    t_insert((BattleData.curRoundData).attackInfo, atkInfo)
  end
end

-- DECOMPILER ERROR at PC43: Confused about usage of register: R12 in 'UnsetPending'

BattleAtk.InsertPreRoundInfo = function(...)
  -- function num : 0_4 , upvalues : _ENV
  return (BattleDataCount.GetPreRoundCount)()
end

-- DECOMPILER ERROR at PC46: Confused about usage of register: R12 in 'UnsetPending'

BattleAtk.InsetAttackFailInfo = function(atkCard, ...)
  -- function num : 0_5 , upvalues : _ENV, self, BattleBuffSettleRoundType, BattleBuffDeductionRoundType, t_insert
  local BattleDataCount = BattleDataCount
  local BattleData = BattleData
  if IsBattleServer == nil then
    (BattleData.SaveBattleProcess)("攻击失败")
  end
  local atkInfo = (self.InitAtkInfo)(atkCard, {})
  atkInfo.atkFail = true
  self.curAtkInfo = atkInfo
  ;
  (BattleDataCount.DealActiveBuff)(atkCard, atkInfo, BattleBuffSettleRoundType.BEFORE_ATTACK)
  ;
  (BattleDataCount.UpdateBuffCount)(atkInfo, BattleBuffDeductionRoundType.BEFORE_ATTACK)
  ;
  (BattleDataCount.DealActiveBuff)(atkCard, atkInfo, BattleBuffSettleRoundType.AFTER_ATTACK)
  ;
  (BattleDataCount.UpdateBuffCount)(atkInfo, BattleBuffDeductionRoundType.AFTER_ATTACK)
  t_insert((BattleData.curRoundData).attackInfo, atkInfo)
end

-- DECOMPILER ERROR at PC49: Confused about usage of register: R12 in 'UnsetPending'

BattleAtk.InsetNormalAttackInfo = function(atkCard, ...)
  -- function num : 0_6 , upvalues : _ENV, self, BattleBuffSettleRoundType, BattleBuffDeductionRoundType, t_insert, ipairs
  local BattleDataCount = BattleDataCount
  local BattleData = BattleData
  if IsBattleServer == nil then
    (BattleData.SaveBattleProcess)("攻击回合：" .. BattleData.atkIndex .. " 攻击者位置：" .. atkCard:GetPosIndex() .. " 攻击类型：普攻")
  end
  local skillConfig = atkCard:GetNormalAttackConfig()
  local curTargetCards = (BattleChoose.GetAtkTarget)(atkCard, skillConfig)
  if #curTargetCards > 0 then
    local defCard = curTargetCards[1]
    if defCard then
      local atkInfo = (self.InitAtkInfo)(atkCard, {defCard}, skillConfig)
      self.curAtkInfo = atkInfo
      ;
      (BattleDataCount.DealActiveBuff)(atkCard, atkInfo, BattleBuffSettleRoundType.BEFORE_ATTACK)
      ;
      (BattleDataCount.UpdateBuffCount)(atkInfo, BattleBuffDeductionRoundType.BEFORE_ATTACK)
      if atkCard:IsDead() ~= true then
        local defCardInfo = (BattleDataCount.GetNormalAtkDataCount)(atkCard, defCard, atkInfo, atkCard)
        ;
        (BattleDataCount.DealHitCritBuff)({defCardInfo}, atkInfo)
        do
          if (BattleBuff.IsAttackDouble)(atkCard) == true then
            local doubleAtkInfo = (self.InitAtkInfo)(atkCard, {defCard}, skillConfig, true)
            doubleAtkInfo.isDoubleAttack = true
            t_insert(atkInfo.doubleAtkInfo, doubleAtkInfo)
            ;
            (BattleDataCount.GetNormalAtkDataCount)(atkCard, defCard, doubleAtkInfo, atkCard, atkInfo)
          end
          ;
          (BattleDataCount.UpdateBuffCount)(atkInfo, BattleBuffDeductionRoundType.NOW)
          local assistCard = (self.IsAssistAtk)(atkCard)
          if #assistCard > 0 and defCard:IsDead() ~= true and #curTargetCards <= 1 then
            atkInfo.moveCamera = true
            for _,card in ipairs(assistCard) do
              if defCard:IsDead() ~= true then
                local assistSkillConfig = card:GetAssistSkillConfig()
                local oneAssistAtkInfo = (self.InitAtkInfo)(card, {defCard}, assistSkillConfig)
                t_insert(atkInfo.assistAtkInfo, oneAssistAtkInfo)
                ;
                (BattleDataCount.GetNormalAtkDataCount)(card, defCard, oneAssistAtkInfo, atkCard, atkInfo)
              end
            end
          end
          do
            do
              do
                if atkCard and atkCard:GetCampFlag() == defCard:GetCampFlag() then
                  atkInfo.targetSelf = true
                end
                if atkCard:IsDead() ~= true then
                  (BattleDataCount.DealActiveBuff)(atkCard, atkInfo, BattleBuffSettleRoundType.AFTER_ATTACK)
                  ;
                  (BattleDataCount.UpdateBuffCount)(atkInfo, BattleBuffDeductionRoundType.AFTER_ATTACK)
                end
                if defCard:IsDead() ~= true then
                  (BattleDataCount.UpdateBuffCount)(atkInfo, BattleBuffDeductionRoundType.AFTER_HIT)
                end
                ;
                (BattleDataCount.DealDamageBuff)(atkInfo)
                atkInfo.atkFail = true
                t_insert((BattleData.curRoundData).attackInfo, atkInfo)
                ;
                (self.InsetAttackFailInfo)(atkCard)
              end
            end
          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC52: Confused about usage of register: R12 in 'UnsetPending'

BattleAtk.InsertSmallSkillInfo = function(atkCard, ...)
  -- function num : 0_7 , upvalues : _ENV, self, BattleBuffSettleRoundType, BattleBuffDeductionRoundType, t_insert, ipairs
  local BattleDataCount = BattleDataCount
  local BattleData = BattleData
  if IsBattleServer == nil then
    (BattleData.SaveBattleProcess)("攻击回合：" .. BattleData.atkIndex .. " 攻击者位置：" .. atkCard:GetPosIndex() .. " 攻击类型：小技能")
  end
  local skillConfig = atkCard:GetSmallSkillConfig()
  local curTargetCards = (BattleChoose.GetAtkTarget)(atkCard, skillConfig)
  if #curTargetCards > 0 then
    local atkInfo = (self.InitAtkInfo)(atkCard, curTargetCards, skillConfig)
    self.curAtkInfo = atkInfo
    atkInfo.moveCamera = true
    ;
    (BattleDataCount.DealActiveBuff)(atkCard, atkInfo, BattleBuffSettleRoundType.BEFORE_ATTACK)
    ;
    (BattleDataCount.UpdateBuffCount)(atkInfo, BattleBuffDeductionRoundType.BEFORE_ATTACK)
    if atkCard:IsDead() ~= true then
      local defCard = curTargetCards[1]
      local isTreatment = (BattleSkill.IsTreatmentSkill)(skillConfig)
      if isTreatment then
        (BattleDataCount.GetTreatmentCount)(atkCard, curTargetCards, atkInfo)
        ;
        (BattleDataCount.DealTreatDirectBuff)(atkCard, atkInfo)
      else
        local defCardInfoTable = (BattleDataCount.GetSkillDataCount)(atkCard, curTargetCards, atkInfo, atkCard)
        ;
        (BattleDataCount.DealHitCritBuff)(defCardInfoTable, atkInfo)
        if (BattleBuff.IsAttackDouble)(atkCard) == true then
          local doubleAtkInfo = (self.InitAtkInfo)(atkCard, curTargetCards, skillConfig, true)
          doubleAtkInfo.isDoubleAttack = true
          t_insert(atkInfo.doubleAtkInfo, doubleAtkInfo)
          ;
          (BattleDataCount.GetSkillDataCount)(atkCard, curTargetCards, doubleAtkInfo, atkCard)
        end
      end
      do
        ;
        (BattleDataCount.UpdateBuffCount)(atkInfo, BattleBuffDeductionRoundType.NOW)
        if isTreatment == false and #curTargetCards <= 1 then
          local assistCard = (self.IsAssistAtk)(atkCard)
          if #assistCard > 0 and defCard:IsDead() ~= true then
            for _,card in ipairs(assistCard) do
              if defCard:IsDead() ~= true then
                local assistSkillConfig = card:GetAssistSkillConfig()
                local oneAssistAtkInfo = (self.InitAtkInfo)(card, curTargetCards, assistSkillConfig)
                t_insert(atkInfo.assistAtkInfo, oneAssistAtkInfo)
                ;
                (BattleDataCount.GetNormalAtkDataCount)(card, defCard, oneAssistAtkInfo, atkCard, atkInfo)
              end
            end
          end
        end
        do
          do
            do
              if atkCard:IsDead() ~= true then
                (BattleDataCount.DealActiveBuff)(atkCard, atkInfo, BattleBuffSettleRoundType.AFTER_ATTACK)
                ;
                (BattleDataCount.UpdateBuffCount)(atkInfo, BattleBuffDeductionRoundType.AFTER_ATTACK)
              end
              ;
              (BattleDataCount.UpdateBuffCount)(atkInfo, BattleBuffDeductionRoundType.AFTER_HIT)
              ;
              (BattleDataCount.DealDamageBuff)(atkInfo)
              atkInfo.atkFail = true
              t_insert((BattleData.curRoundData).attackInfo, atkInfo)
              ;
              (self.InsetAttackFailInfo)(atkCard)
            end
          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC55: Confused about usage of register: R12 in 'UnsetPending'

BattleAtk.InsertSkillInfo = function(curSkill, ...)
  -- function num : 0_8 , upvalues : _ENV, self, BattleBuffSettleRoundType, BattleBuffDeductionRoundType, t_insert
  local BattleDataCount = BattleDataCount
  local BattleData = BattleData
  local cardUid = curSkill.cardUid
  local skillConfig = curSkill.skillConfig
  local atkCard = (BattleData.GetCardInfoByUid)(cardUid)
  if IsBattleServer == nil then
    (BattleData.SaveBattleProcess)("攻击回合：" .. BattleData.atkIndex .. " 攻击者位置：" .. atkCard:GetPosIndex() .. " 攻击类型：必杀技")
  end
  local curTargetCards = (BattleChoose.GetAtkTarget)(atkCard, skillConfig)
  if #curTargetCards > 0 then
    local atkInfo = (self.InitAtkInfo)(atkCard, curTargetCards, skillConfig)
    self.curAtkInfo = atkInfo
    ;
    (BattleDataCount.DealActiveBuff)(atkCard, atkInfo, BattleBuffSettleRoundType.BEFORE_SKILL)
    ;
    (BattleDataCount.UpdateBuffCount)(atkInfo, BattleBuffDeductionRoundType.BEFORE_SKILL)
    if atkCard:IsDead() ~= true then
      if (BattleSkill.IsTreatmentSkill)(skillConfig) then
        (BattleDataCount.GetTreatmentCount)(atkCard, curTargetCards, atkInfo)
        ;
        (BattleDataCount.DealTreatDirectBuff)(atkCard, atkInfo)
      else
        local defCardInfoTable = (BattleDataCount.GetSkillDataCount)(atkCard, curTargetCards, atkInfo, atkCard)
        ;
        (BattleDataCount.DealHitCritBuff)(defCardInfoTable, atkInfo)
      end
    else
      do
        do
          atkInfo.atkFail = true
          if atkCard:IsDead() ~= true then
            (BattleDataCount.DealActiveBuff)(atkCard, atkInfo, BattleBuffSettleRoundType.AFTER_SKILL)
            ;
            (BattleDataCount.UpdateBuffCount)(atkInfo, BattleBuffDeductionRoundType.AFTER_SKILL)
          end
          ;
          (BattleDataCount.UpdateBuffCount)(atkInfo, BattleBuffDeductionRoundType.AFTER_SKILL_ENEMY)
          ;
          (BattleDataCount.UpdateBuffCount)(atkInfo, BattleBuffDeductionRoundType.AFTER_HIT)
          ;
          (BattleDataCount.DealDamageBuff)(atkInfo)
          t_insert((BattleData.curRoundData).attackInfo, atkInfo)
          ;
          (self.InsetAttackFailInfo)(atkCard)
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC58: Confused about usage of register: R12 in 'UnsetPending'

BattleAtk.GetIsUseSmallSkill = function(atkCard, ...)
  -- function num : 0_9 , upvalues : _ENV, split, tonumber
  if BattleConfig.onlySmallSkill == true then
    return true
  end
  if (BattleBuff.IsForbiddenSmall)(atkCard) == true then
    return false
  end
  local cardConfig = (CardData.GetBaseConfig)(atkCard:GetCardId())
  if cardConfig then
    local random = (BattleData.GetRandomSeed)()
    local special_skill_ratio = split(cardConfig.special_skill_ratio, ":")
    local type = tonumber(special_skill_ratio[1])
    local value = tonumber(special_skill_ratio[2])
    if random > value then
      do return type ~= 1 end
      do
        if type == 2 then
          local roundIndex = BattleData.roundIndex
          for i = 2, #special_skill_ratio do
            if roundIndex == tonumber(special_skill_ratio[i]) then
              return true
            end
          end
          return false
        end
        -- DECOMPILER ERROR: 4 unprocessed JMP targets
      end
    end
  end
end

-- DECOMPILER ERROR at PC61: Confused about usage of register: R12 in 'UnsetPending'

BattleAtk.IsAssistAtk = function(atkCard, ...)
  -- function num : 0_10 , upvalues : _ENV, split, tonumber, ipairs, t_insert
  if atkCard:IsDead() == true then
    return {}
  end
  if (BattleBuff.IsForbiddenAssist)(atkCard) == true then
    return {}
  end
  local cardConfig = atkCard:GetCardConfig()
  local assist_skill_ratio = split(cardConfig.assist_skill_ratio, ":")
  local randomNum = (BattleData.GetRandomSeed)()
  local totalRatio = 0
  local assistNum = 0
  for i = 1, #assist_skill_ratio do
    totalRatio = totalRatio + tonumber(assist_skill_ratio[i])
    if randomNum <= totalRatio then
      assistNum = i - 1
      break
    end
  end
  do
    if BattleConfig.autoAssist == true then
      assistNum = 6
    end
    local maxAssistCards = (BattleChoose.GetAssistCardList)(atkCard, assistNum)
    local isContain, buff, effect = (BattleBuff.ContainEffectId)(atkCard, BattleDisplayEffect.FORCE_ASSIST)
    if isContain == true and effect then
      local value = effect.value
      if value ~= 0 and value ~= -1 then
        local card = (BattleData.GetCardInfoById)(value, atkCard:GetCampFlag())
        if card and card:IsDead() ~= true then
          local isFind = false
          for _,v in ipairs(maxAssistCards) do
            if v:GetCardId() == value then
              isFind = true
              break
            end
          end
          do
            do
              do
                if isFind == false then
                  t_insert(maxAssistCards, card)
                end
                if value == -1 then
                  maxAssistCards = (BattleChoose.GetAssistCardList)(atkCard, 6, false)
                end
                return maxAssistCards
              end
            end
          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC64: Confused about usage of register: R12 in 'UnsetPending'

BattleAtk.GetHpByPos = function(atkInfo, pos, ...)
  -- function num : 0_11 , upvalues : ipairs
  if atkInfo and pos then
    local defCardsInfo = atkInfo.defCardsInfo
    for _,defCardInfo in ipairs(defCardsInfo) do
      if defCardInfo.defPos == pos then
        return defCardInfo.hpDef
      end
    end
  end
  do
    return 0
  end
end

-- DECOMPILER ERROR at PC67: Confused about usage of register: R12 in 'UnsetPending'

BattleAtk.IsDefCampByPos = function(atkInfo, pos, ...)
  -- function num : 0_12 , upvalues : math
  do
    if atkInfo then
      local atkPos = atkInfo.atkPos
      return (math.abs)(atkPos - pos) > 50
    end
    do return false end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

-- DECOMPILER ERROR at PC70: Confused about usage of register: R12 in 'UnsetPending'

BattleAtk.IsAtkCardByPos = function(atkInfo, pos, ...)
  -- function num : 0_13
  do
    if atkInfo then
      local atkPos = atkInfo.atkPos
      return atkPos == pos
    end
    do return false end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

-- DECOMPILER ERROR at PC73: Confused about usage of register: R12 in 'UnsetPending'

BattleAtk.IsDefCardByPos = function(atkInfo, pos, ...)
  -- function num : 0_14 , upvalues : ipairs
  if atkInfo then
    local defCardsInfo = atkInfo.defCardsInfo
    if defCardsInfo then
      for _,defCardInfo in ipairs(defCardsInfo) do
        if defCardInfo.defPos == pos then
          return true
        end
      end
    end
  end
  do
    return false
  end
end

-- DECOMPILER ERROR at PC76: Confused about usage of register: R12 in 'UnsetPending'

BattleAtk.SetWaitActionCardState = function(pos, actionComplete, ...)
  -- function num : 0_15 , upvalues : self, ipairs, t_insert
  local waitActionCardPosTable = self.waitActionCardPosTable
  if actionComplete == false then
    for i,v in ipairs(waitActionCardPosTable) do
      if v.pos == pos then
        v.actionComplete = false
        return 
      end
    end
    t_insert(waitActionCardPosTable, {pos = pos, actionComplete = actionComplete})
  else
    for i,v in ipairs(waitActionCardPosTable) do
      if v.pos == pos and v.actionComplete == false then
        v.actionComplete = true
        return 
      end
    end
  end
end

-- DECOMPILER ERROR at PC79: Confused about usage of register: R12 in 'UnsetPending'

BattleAtk.GetRealDefCard = function(defCardsInfo, ...)
  -- function num : 0_16 , upvalues : ipairs, t_insert
  local realDefCardInfos = {}
  for i,v in ipairs(defCardsInfo) do
    if v.isSkillTarget == true then
      t_insert(realDefCardInfos, v)
    end
  end
  return realDefCardInfos
end

-- DECOMPILER ERROR at PC82: Confused about usage of register: R12 in 'UnsetPending'

BattleAtk.GetAtkDamage = function(atkInfo, ...)
  -- function num : 0_17 , upvalues : ipairs
  local totalDamage = 0
  local defCardsInfo = atkInfo.defCardsInfo
  local atkPos = atkInfo.atkPos
  for i,v in ipairs(defCardsInfo) do
    if v.defPos ~= atkPos then
      totalDamage = totalDamage + v.hpDef
    end
  end
  return totalDamage
end

-- DECOMPILER ERROR at PC85: Confused about usage of register: R12 in 'UnsetPending'

BattleAtk.GetAllCardDamage = function(atkInfo, ...)
  -- function num : 0_18 , upvalues : _ENV, ipairs
  local damageTable = {}
  local defCardsInfo = atkInfo.defCardsInfo
  local allBuffTable = atkInfo.allBuffTable
  local assistAtkInfo = atkInfo.assistAtkInfo
  local doubleAtkInfo = atkInfo.doubleAtkInfo
  local hpId = BattleCardAttributeID.HP
  local buffUpdate = BattleBuffOprType.UPDATE
  for _,v in ipairs(defCardsInfo) do
    local pos = v.defPos
    local hpDef = v.hpDef
    if not damageTable[pos] or not damageTable[pos] - hpDef then
      do
        damageTable[pos] = -hpDef
        -- DECOMPILER ERROR at PC24: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC24: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  for _,doubleAtk in ipairs(doubleAtkInfo) do
    for _,v in ipairs(doubleAtk.defCardsInfo) do
      local pos = v.defPos
      local hpDef = v.hpDef
      if not damageTable[pos] or not damageTable[pos] - hpDef then
        do
          damageTable[pos] = -hpDef
          -- DECOMPILER ERROR at PC45: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC45: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  for _,buff in ipairs(allBuffTable) do
    if buff.type == buffUpdate then
      local effectTable = buff.effectTable
      local pos = buff.curDefPos
      if buff.activeForever == 1 then
        for _,effect in ipairs(effectTable) do
          if (BattleBuff.IsAddIntoDamage)(effect.effectId) ~= true and effect.attributeId == hpId then
            if not damageTable[pos] or not damageTable[pos] + effect.realValue then
              do
                damageTable[pos] = effect.realValue
                -- DECOMPILER ERROR at PC84: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC84: LeaveBlock: unexpected jumping out IF_STMT

                -- DECOMPILER ERROR at PC84: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC84: LeaveBlock: unexpected jumping out IF_STMT

              end
            end
          end
        end
      end
    end
  end
  for _,assistAtk in ipairs(assistAtkInfo) do
    for _,v in ipairs(assistAtk.defCardsInfo) do
      local pos = v.defPos
      local hpDef = v.hpDef
      if not damageTable[pos] or not damageTable[pos] - hpDef then
        do
          damageTable[pos] = -hpDef
          -- DECOMPILER ERROR at PC107: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC107: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  return damageTable
end


