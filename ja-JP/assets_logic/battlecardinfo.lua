-- params : ...
-- function num : 0 , upvalues : _ENV
BattleCardInfo = {}
if Util then
  local clone = Util.Copy
end
local pairs = pairs
local ipairs = ipairs
local t_insert = table.insert
local math = math
local baseCardData = (TableData.gTable).BaseCardData
local baseAttributeData = (TableData.gTable).BaseAttributeData
-- DECOMPILER ERROR at PC20: Confused about usage of register: R7 in 'UnsetPending'

BattleCardInfo.Initial = function(data, ...)
  -- function num : 0_0 , upvalues : _ENV, clone, pairs, baseAttributeData, baseCardData, t_insert, ipairs, math
  local battleCardInfo = {}
  battleCardInfo.Init = function(self, data, ...)
    -- function num : 0_0_0 , upvalues : _ENV, clone, pairs
    local BattleData = BattleData
    data = clone(data)
    for i,v in pairs(data.cardInfo) do
      data[i] = v
    end
    data.cardInfo = nil
    self:InitTestInfo(data)
    if data.posIndex > 100 then
      (CardData.InitCardAttr)(self, data, BattleData.battleType, {talentAllAttr = BattleData.talentAttrTeamB, intimacyAttrTable = BattleData.intimacyAttrTeamB, cardStarTeamAttrTable = BattleData.cardStarTeamAttrTeamB, fetterTeamAttrTable = BattleData.fetterTeamAttrTeamB})
    else
      ;
      (CardData.InitCardAttr)(self, data, BattleData.battleType, {talentAllAttr = BattleData.talentAttrTeamA, intimacyAttrTable = BattleData.intimacyAttrTeamA, cardStarTeamAttrTable = BattleData.cardStarTeamAttrTeamA, fetterTeamAttrTable = BattleData.fetterTeamAttrTeamA})
    end
    if self:GetMaxHp() < self:GetHp() and IsBattleServer == true then
      print_new("initial card error: hp > maxHp", self:GetPosIndex(), self:GetHp(), self:GetMaxHp())
    end
    if IsBattleServer == nil then
      print("卡片位置: ", self:GetPosIndex(), " 攻击: ", self:GetAtk(), " 防御: ", self:GetDef(), " 生命: ", self:GetHp())
    end
  end

  battleCardInfo.GetAttributeLog = function(self, ...)
    -- function num : 0_0_1 , upvalues : baseAttributeData, pairs
    local info = {}
    local baseAttributeData = baseAttributeData
    for _,v in pairs(baseAttributeData) do
      info[v.remark] = self[v.name]
    end
    return info
  end

  battleCardInfo.InitTestInfo = function(self, data, ...)
    -- function num : 0_0_2 , upvalues : _ENV, baseCardData, t_insert, ipairs
    if IsBattleTest ~= true then
      return 
    end
    local skillLevel = data.skillLevel
    if skillLevel then
      data.skillInfo = {}
      local cardId = data.id
      local config = baseCardData[cardId]
      if not config then
        config = (TableData.GetBaseMonsterData)(cardId)
      end
      if config then
        local specialSkillId = config.special_skill_id
        if not skillLevel[1] then
          t_insert(data.skillInfo, {id = specialSkillId, value = specialSkillId == 0 or 0})
          local uniqueSkillId = config.unique_skill_id
          if not skillLevel[2] then
            do
              t_insert(data.skillInfo, {id = uniqueSkillId, value = uniqueSkillId == 0 or 0})
              for i = 1, 10 do
                local passiveSkillId = config["passiveSkillId" .. i]
                if not skillLevel[i + 2] then
                  do
                    t_insert(data.skillInfo, {id = passiveSkillId, value = not passiveSkillId or passiveSkillId == 0 or 0})
                    -- DECOMPILER ERROR at PC69: LeaveBlock: unexpected jumping out IF_THEN_STMT

                    -- DECOMPILER ERROR at PC69: LeaveBlock: unexpected jumping out IF_STMT

                  end
                end
              end
              local equipBuff = data.equipBuff
              if equipBuff then
                self.equipInfoTest = {
[1] = {
randomBuff = {}
}
}
                for _,buff in ipairs(equipBuff) do
                  t_insert(((self.equipInfoTest)[1]).randomBuff, buff)
                end
              end
            end
          end
        end
      end
    end
  end

  battleCardInfo.Destroy = function(self, ...)
    -- function num : 0_0_3
    self = {}
  end

  battleCardInfo.GetCardId = function(self, ...)
    -- function num : 0_0_4
    return self.id
  end

  battleCardInfo.GetCardUid = function(self, ...)
    -- function num : 0_0_5
    return self.uid
  end

  battleCardInfo.GetPosIndex = function(self, ...)
    -- function num : 0_0_6
    return self.posIndex
  end

  battleCardInfo.GetLevel = function(self, ...)
    -- function num : 0_0_7
    return self.level
  end

  battleCardInfo.GetFashionId = function(self, ...)
    -- function num : 0_0_8
    return self.fashionId
  end

  battleCardInfo.GetHp = function(self, ...)
    -- function num : 0_0_9
    return self.hp
  end

  battleCardInfo.SetHp = function(self, hp, ...)
    -- function num : 0_0_10 , upvalues : _ENV, math
    if IsBattleServer == nil then
      print("改变血量 ： 位置：", self:GetPosIndex(), " 血量变化：", hp, " 实际变化：", (math.min)(hp, self:GetMaxHp()))
    end
    hp = (math.min)(hp, self:GetMaxHp())
    self.hp = hp
  end

  battleCardInfo.GetStar = function(self, ...)
    -- function num : 0_0_11
    return self.star
  end

  battleCardInfo.GetQuality = function(self, ...)
    -- function num : 0_0_12
    return self.quality
  end

  battleCardInfo.GetMaxHp = function(self, ...)
    -- function num : 0_0_13
    return self.max_hp
  end

  battleCardInfo.GetAtk = function(self, ...)
    -- function num : 0_0_14
    return self.atk
  end

  battleCardInfo.GetDef = function(self, ...)
    -- function num : 0_0_15
    return self.def
  end

  battleCardInfo.GetCrt = function(self, ...)
    -- function num : 0_0_16
    return self.crt
  end

  battleCardInfo.GetRec = function(self, ...)
    -- function num : 0_0_17
    return self.rec
  end

  battleCardInfo.GetBlk = function(self, ...)
    -- function num : 0_0_18
    return self.blk
  end

  battleCardInfo.GetReb = function(self, ...)
    -- function num : 0_0_19
    return self.reb
  end

  battleCardInfo.GetHit = function(self, ...)
    -- function num : 0_0_20
    return self.hit
  end

  battleCardInfo.GetEva = function(self, ...)
    -- function num : 0_0_21
    return self.eva
  end

  battleCardInfo.GetArp = function(self, ...)
    -- function num : 0_0_22
    return self.arp
  end

  battleCardInfo.GetRea = function(self, ...)
    -- function num : 0_0_23
    return self.rea
  end

  battleCardInfo.GetCrtInt = function(self, ...)
    -- function num : 0_0_24
    return self.crt_int
  end

  battleCardInfo.GetRecInt = function(self, ...)
    -- function num : 0_0_25
    return self.rec_int
  end

  battleCardInfo.GetBlkInt = function(self, ...)
    -- function num : 0_0_26
    return self.blk_int
  end

  battleCardInfo.GetRebInt = function(self, ...)
    -- function num : 0_0_27
    return self.rec_int
  end

  battleCardInfo.GetAddInt = function(self, ...)
    -- function num : 0_0_28
    return self.add_int
  end

  battleCardInfo.GetExdInt = function(self, ...)
    -- function num : 0_0_29
    return self.exd_int
  end

  battleCardInfo.GetArpInt = function(self, ...)
    -- function num : 0_0_30
    return self.arp_int
  end

  battleCardInfo.GetReaInt = function(self, ...)
    -- function num : 0_0_31
    return self.rea_int
  end

  battleCardInfo.GetSpd = function(self, ...)
    -- function num : 0_0_32
    return self.spd
  end

  battleCardInfo.GetLuck = function(self, ...)
    -- function num : 0_0_33
    return self.luck
  end

  battleCardInfo.GetMaxDander = function(self, ...)
    -- function num : 0_0_34
    return self.max_dander
  end

  battleCardInfo.GetMaxDanderLimit = function(self, ...)
    -- function num : 0_0_35
    if not self.max_dander_limit then
      return self:GetMaxDander()
    end
  end

  battleCardInfo.GetDander = function(self, ...)
    -- function num : 0_0_36
    return self.dander
  end

  battleCardInfo.SetDander = function(self, dander, ...)
    -- function num : 0_0_37 , upvalues : math, _ENV
    dander = (math.min)(dander, self:GetMaxDanderLimit())
    dander = (math.max)(dander, 0)
    self.dander = dander
    if IsBattleServer == nil then
      print("怒气变化：位置：", self:GetPosIndex(), " 怒气值：", dander)
    end
  end

  battleCardInfo.GetDanderRound = function(self, ...)
    -- function num : 0_0_38
    return self.dander_round
  end

  battleCardInfo.GetDanderAtk = function(self, ...)
    -- function num : 0_0_39
    return self.dander_atk
  end

  battleCardInfo.GetDanderHit = function(self, ...)
    -- function num : 0_0_40
    return self.dander_hit
  end

  battleCardInfo.GetDanderKill = function(self, ...)
    -- function num : 0_0_41
    return self.dander_kill
  end

  battleCardInfo.GetExtDamage = function(self, ...)
    -- function num : 0_0_42
    return self.ext_damage
  end

  battleCardInfo.GetExtDamageSub = function(self, ...)
    -- function num : 0_0_43
    return self.ext_damage_sub
  end

  battleCardInfo.GetTreatAdd = function(self, ...)
    -- function num : 0_0_44
    return self.treat_add
  end

  battleCardInfo.GetTreatSub = function(self, ...)
    -- function num : 0_0_45
    return self.treat_sub
  end

  battleCardInfo.GetBeTreatAdd = function(self, ...)
    -- function num : 0_0_46
    return self.be_treat_add
  end

  battleCardInfo.GetBeTreatSub = function(self, ...)
    -- function num : 0_0_47
    return self.be_treat_sub
  end

  battleCardInfo.GetAtkEvaProb = function(self, ...)
    -- function num : 0_0_48
    return self.atk_eva_prob
  end

  battleCardInfo.GetSkillEvaProb = function(self, ...)
    -- function num : 0_0_49
    return self.skill_eva_prob
  end

  battleCardInfo.GetCrtProp = function(self, ...)
    -- function num : 0_0_50
    return self.crt_prob or 0
  end

  battleCardInfo.GetBlkProp = function(self, ...)
    -- function num : 0_0_51
    return self.blk_prob or 0
  end

  battleCardInfo.GetSkillInfo = function(self, ...)
    -- function num : 0_0_52
    return self.skillInfo
  end

  battleCardInfo.GetEquipInfo = function(self, ...)
    -- function num : 0_0_53 , upvalues : _ENV
    if IsBattleTest == true then
      return self.equipInfoTest
    else
      return self.equipInfo
    end
  end

  battleCardInfo.AddAttrValue = function(self, attributeId, value, effectId, ...)
    -- function num : 0_0_54 , upvalues : _ENV, baseAttributeData
    if (BattleBuff.IsAddIntoDamage)(effectId) == true then
      loge("伤害已加入总伤害")
      return nil
    end
    local SaveBattleProcess = BattleData.SaveBattleProcess
    local attrConfig = baseAttributeData[attributeId]
    local BattleCardAttributeID = BattleCardAttributeID
    if attrConfig then
      local curValue = self[attrConfig.name]
      if IsBattleServer == nil then
        print("属性变化：", (CardData.GetAttrRemarkById)(attributeId), " 位置：", self:GetPosIndex(), " 当前值：", curValue, " 增加量：", value)
      end
      if curValue then
        if attributeId == BattleCardAttributeID.HP then
          local card = ((BattleData.GetCardInfoByPos)(self:GetPosIndex()))
          local realDamage, absorbDamage, specialEffect = nil, nil, nil
          if value < 0 then
            realDamage = (BattleBuff.DealRealHpLoss)(card, -value)
            value = -realDamage
            if IsBattleServer == nil then
              SaveBattleProcess("\tbuff伤害 位置：" .. self:GetPosIndex() .. " 变化值：" .. value)
            end
          else
            if value > 0 then
              if (BattleBuff.IsForbiddenTreatment)(card) then
                value = 0
                if IsBattleServer == nil then
                  SaveBattleProcess("\tbuff加血（封疗） 位置：" .. self:GetPosIndex() .. " 变化值：" .. value)
                end
              else
                if IsBattleServer == nil then
                  SaveBattleProcess("\tbuff加血 位置：" .. self:GetPosIndex() .. " 变化值：" .. value)
                end
              end
            end
          end
          self:SetHp(curValue + value)
          return value, absorbDamage, specialEffect
        else
          do
            -- DECOMPILER ERROR at PC114: Overwrote pending register: R10 in 'AssignReg'

            if attributeId == BattleCardAttributeID.DANDER then
              self:SetDander(absorbDamage)
              -- DECOMPILER ERROR at PC121: Overwrote pending register: R11 in 'AssignReg'

              if IsBattleServer == nil then
                SaveBattleProcess("\tbuff改变怒气 位置：" .. self:GetPosIndex() .. " 变化值：" .. value)
              end
            else
              self[attrConfig.name] = curValue + value
              if IsBattleServer == nil then
                SaveBattleProcess("\tbuff属性变化 位置：" .. self:GetPosIndex() .. " 属性变化：" .. (CardData.GetAttrRemarkById)(attributeId) .. " 变化值：" .. value)
              end
            end
            self[attrConfig.name] = value
          end
        end
      end
    end
  end

  battleCardInfo:Init(data)
  return battleCardInfo
end


