-- params : ...
-- function num : 0 , upvalues : _ENV
BattleDataCount = {}
local self = BattleDataCount
require("BattleBuffMgr")
local BattleBuffMgr = BattleBuffMgr
local ipairs = ipairs
local pairs = pairs
local tonumber = tonumber
local t_insert = table.insert
if Util then
  local clone = Util.Copy
end
local math = math
local max = math.max
local min = math.min
local ceil = math.ceil
local abs = math.abs
local BattleBuffDeductionRoundType = BattleBuffDeductionRoundType
local BattleBuffSettleRoundType = BattleBuffSettleRoundType
local BattleDisplayEffect = BattleDisplayEffect
local BattleCardCamp = BattleCardCamp
local BattleSkillType = BattleSkillType
local BattleBuffOprType = BattleBuffOprType
local SkillParameterData = (TableData.gTable).BaseSkillParameterData
local gedang_diyu_xishu = tonumber((SkillParameterData[72100001]).data)
local pofang_diyu_xishu = tonumber((SkillParameterData[72100002]).data)
local mingzhong_shanbi_xishu = tonumber((SkillParameterData[72100003]).data)
local baoji_mianbao_xishu = tonumber((SkillParameterData[72100004]).data)
local baojilv_max = tonumber((SkillParameterData[72100005]).data)
local baojilv_min = tonumber((SkillParameterData[72100006]).data)
local baoji_kangbao_qiangdu_xishu = tonumber((SkillParameterData[72100007]).data)
local baoji_jiacheng_max = tonumber((SkillParameterData[72100008]).data)
local baoji_jiacheng_min = tonumber((SkillParameterData[72100009]).data)
local gedang_poji_xishu = tonumber((SkillParameterData[72100010]).data)
local gedanglv_max = tonumber((SkillParameterData[72100011]).data)
local gedanglv_min = tonumber((SkillParameterData[72100012]).data)
local gedang_poji_qiangdu_xishu = tonumber((SkillParameterData[72100013]).data)
local gedang_jiacheng_max = tonumber((SkillParameterData[72100014]).data)
local gedang_jiacheng_min = tonumber((SkillParameterData[72100015]).data)
local shanghai_jiacheng_min = tonumber((SkillParameterData[72100016]).data)
local shanghai_jiacheng_max = tonumber((SkillParameterData[72100017]).data)
local zengshang_mianshang_xishu = tonumber((SkillParameterData[72100018]).data)
local shanghai_fudong_max = tonumber((SkillParameterData[72100021]).data)
local shanghai_fudong_min = tonumber((SkillParameterData[72100022]).data)
local zhiliao_baoji_xishu = tonumber((SkillParameterData[72100023]).data)
local zhiliao_baojilv_max = tonumber((SkillParameterData[72100024]).data)
local zhiliao_baojilv_min = tonumber((SkillParameterData[72100025]).data)
local zhiliao_baoji_jiacheng_max = tonumber((SkillParameterData[72100026]).data)
local zhiliao_baoji_jiacheng_min = tonumber((SkillParameterData[72100027]).data)
local zhiliao_baoji_qiangdu_xishu = tonumber((SkillParameterData[72100028]).data)
local zhiliao_fudong_max = tonumber((SkillParameterData[72100029]).data)
local zhiliao_fudong_min = tonumber((SkillParameterData[72100030]).data)
-- DECOMPILER ERROR at PC145: Confused about usage of register: R47 in 'UnsetPending'

BattleDataCount.InsertPreBattleCount = function(...)
  -- function num : 0_0 , upvalues : _ENV, ipairs, BattleCardCamp, clone, BattleBuffMgr, tonumber, self, BattleBuffSettleRoundType, BattleBuffDeductionRoundType
  if IsBattleServer == nil then
    (BattleData.SaveBattleProcess)("战前buff处理")
  end
  local preBattleInfo = (BattleAtk.InitAtkInfo)()
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  BattleAtk.curAtkInfo = preBattleInfo
  local preBattleEvent = BattleData.preBattleEvent
  for _,event in ipairs(preBattleEvent) do
    local eventId = event.eventId
    local eventConfig = ((TableData.gTable).BaseBuffPreBattleData)[eventId]
    if eventConfig then
      local buffList = eventConfig.buff_list
      local atkCards = (BattleData.GetAliveCards)(BattleCardCamp.LEFT)
      if atkCards then
        local atkCard = atkCards[1]
        local buffTable = (BattleSkill.GetAllBuffByBuffList)(atkCard, {}, buffList)
        for _,buff in ipairs(buffTable) do
          local targetPosTable = buff:GetTargetPosTable()
          for _,targetPos in ipairs(targetPosTable) do
            local targetCard = (BattleData.GetCardInfoByPos)(targetPos)
            if targetCard and targetCard:IsDead() ~= true then
              local buffClone = clone(buff)
              buffClone:SetCurDefPos(targetCard:GetPosIndex())
              ;
              (BattleBuffMgr.AddTempBuffToList)(buffClone)
            end
          end
        end
      end
    end
  end
  local dealPreBuff = function(card, randomBuffs, ...)
    -- function num : 0_0_0 , upvalues : ipairs, _ENV, tonumber, clone, BattleBuffMgr
    for _,randomBuff in ipairs(randomBuffs) do
      local eventConfig = ((TableData.gTable).BaseBuffPreBattleData)[tonumber(randomBuff)]
      if eventConfig then
        local buffList = eventConfig.buff_list
        local atkCard = card
        local buffTable = (BattleSkill.GetAllBuffByBuffList)(atkCard, {}, buffList)
        for _,buff in ipairs(buffTable) do
          local targetPosTable = buff:GetTargetPosTable()
          for _,targetPos in ipairs(targetPosTable) do
            local targetCard = (BattleData.GetCardInfoByPos)(targetPos)
            if targetCard and targetCard:IsDead() ~= true then
              local buffClone = clone(buff)
              buffClone:SetCurDefPos(targetCard:GetPosIndex())
              ;
              (BattleBuffMgr.AddTempBuffToList)(buffClone)
            end
          end
        end
      end
    end
  end

  local allCard = (BattleData.GetAllCardList)()
  for _,v in ipairs(allCard) do
    if BattleData.curWave <= 1 then
      local equipInfo = v:GetEquipInfo()
      if equipInfo then
        for _,equip in ipairs(equipInfo) do
          local randomBuffs = equip.randomBuff
          dealPreBuff(v, randomBuffs)
        end
      end
    end
    do
      local cardConfig = v:GetCardConfig()
      do
        if cardConfig and cardConfig.passive_buff_list and cardConfig.passive_buff_list ~= "" then
          local randomBuffs = split(cardConfig.passive_buff_list, ",")
          loge("处理被动buff效果")
          dealPreBuff(v, randomBuffs)
        end
        -- DECOMPILER ERROR at PC123: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  ;
  (self.DealActiveBuff)(nil, preBattleInfo, BattleBuffSettleRoundType.BEFORE_BATTLE)
  ;
  (self.UpdateBuffCount)(preBattleInfo, BattleBuffDeductionRoundType.BEFORE_BATTLE)
  if IsBattleServer == nil then
    (BattleData.SaveBattleProcess)("战前buff处理结束")
  end
  return preBattleInfo
end

-- DECOMPILER ERROR at PC148: Confused about usage of register: R47 in 'UnsetPending'

BattleDataCount.GetPreRoundCount = function(...)
  -- function num : 0_1 , upvalues : _ENV, ipairs, self, BattleBuffSettleRoundType, BattleBuffDeductionRoundType
  local curRound = BattleData.roundIndex
  local liveCards = (BattleData.GetAliveCards)()
  local preRoundInfo = (BattleAtk.InitAtkInfo)()
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'

  BattleAtk.curAtkInfo = preRoundInfo
  preRoundInfo.defCardsInfo = {}
  local defCardInfo = preRoundInfo.defCardsInfo
  for _,v in ipairs(liveCards) do
    local cardConfig = v:GetCardConfig()
    if cardConfig then
      local dander = v:GetDanderRound()
      if curRound <= 1 then
        dander = 0
      end
      local subAtkInfo = (BattleAtk.InitSubAtkInfo)(v, defCardInfo)
      subAtkInfo.defPos = v:GetPosIndex()
      subAtkInfo.defCardUid = v:GetCardUid()
      subAtkInfo.danderDef = dander
      v:SetDander(v:GetDander() + subAtkInfo.danderDef)
    end
  end
  ;
  (self.DealActiveBuff)(nil, preRoundInfo, BattleBuffSettleRoundType.BEFORE_ROUND)
  ;
  (self.UpdateBuffCount)(preRoundInfo, BattleBuffDeductionRoundType.BEFORE_ROUND)
  if curRound > 1 then
    (self.UpdateBuffCount)(preRoundInfo, BattleBuffDeductionRoundType.BEFORE_ROUND_SINCE_2)
  end
  ;
  (self.UpdateBuffCount)(preRoundInfo, BattleBuffDeductionRoundType.BEFORE_ROUND_DELAY)
  return preRoundInfo
end

-- DECOMPILER ERROR at PC151: Confused about usage of register: R47 in 'UnsetPending'

BattleDataCount.DealActiveBuff = function(atkCard, atkInfo, settle_round_type, ...)
  -- function num : 0_2 , upvalues : BattleBuffMgr, ipairs, t_insert, _ENV, BattleBuffSettleRoundType, self, BattleBuffDeductionRoundType, BattleDisplayEffect
  local tempBuffList = (BattleBuffMgr.GetTempBuffList)()
  local buffListBackUp = {}
  for i,v in ipairs(tempBuffList) do
    t_insert(buffListBackUp, v)
  end
  for _,tempBuff in ipairs(buffListBackUp) do
    if tempBuff then
      local settleRoundType = tempBuff:GetSettleRoundType()
      local defCardPos = tempBuff:GetCurDefPos()
      local card = (BattleData.GetCardInfoByPos)(defCardPos)
      -- DECOMPILER ERROR at PC62: Unhandled construct in 'MakeBoolean' P3

      -- DECOMPILER ERROR at PC62: Unhandled construct in 'MakeBoolean' P3

      if settleRoundType == settle_round_type or ((settle_round_type == BattleBuffSettleRoundType.BEFORE_ATTACK and settleRoundType == BattleBuffSettleRoundType.BEFORE_ACTION) or settle_round_type ~= BattleBuffSettleRoundType.AFTER_ATTACK or settle_round_type ~= BattleBuffSettleRoundType.BEFORE_SKILL or settle_round_type ~= BattleBuffSettleRoundType.AFTER_SKILL or settleRoundType == BattleBuffSettleRoundType.AFTER_ACTION) then
        if card:IsDead() ~= true then
          local canAdd = (self.DealAddBuff)(card, tempBuff, atkInfo)
          if canAdd == true then
            local deductionRoundType = tempBuff:GetDeductionRoundType()
            if deductionRoundType == BattleBuffDeductionRoundType.NOW then
              (self.RealUpdateBuffCount)(tempBuff, atkInfo, true)
            end
            if atkCard then
              if (BattleBuff.IsBuffContainEffectId)(tempBuff, BattleDisplayEffect.ATTRACT) == true then
                (self.DealAttractBuff)(atkCard, atkInfo)
              end
              if (BattleBuff.IsBuffContainEffectId)(tempBuff, BattleDisplayEffect.TREATMENT_EXTRA) == true then
                (self.DealTreatDirectBuff)(atkCard, atkInfo)
              end
              if (BattleBuff.IsBuffContainEffectId)(tempBuff, BattleDisplayEffect.DAMAGE_PERSIST) == true or (BattleBuff.IsBuffContainEffectId)(tempBuff, BattleDisplayEffect.DAMAGE_PERCENT) == true or (BattleBuff.IsBuffContainEffectId)(tempBuff, BattleDisplayEffect.DAMAGE_REPEAT) == true then
                (self.DealActiveDamageBuff)(atkCard, atkInfo)
              end
            end
          end
        end
        do
          do
            ;
            (BattleBuffMgr.RemoveTempBuffFromList)(tempBuff)
            -- DECOMPILER ERROR at PC126: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC126: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC126: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC126: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC126: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
  buffListBackUp = {}
end

-- DECOMPILER ERROR at PC154: Confused about usage of register: R47 in 'UnsetPending'

BattleDataCount.DealAttractBuff = function(atkCard, atkInfo, ...)
  -- function num : 0_3 , upvalues : self, BattleBuffDeductionRoundType
  (self.UpdateEquipBuff)(atkCard:GetPosIndex(), BattleBuffDeductionRoundType.AFTER_ATTRACT, atkInfo)
end

-- DECOMPILER ERROR at PC157: Confused about usage of register: R47 in 'UnsetPending'

BattleDataCount.DealTreatDirectBuff = function(atkCard, atkInfo, ...)
  -- function num : 0_4 , upvalues : self, BattleBuffDeductionRoundType
  (self.UpdateEquipBuff)(atkCard:GetPosIndex(), BattleBuffDeductionRoundType.AFTER_TREAT_DIRECT, atkInfo)
end

-- DECOMPILER ERROR at PC160: Confused about usage of register: R47 in 'UnsetPending'

BattleDataCount.DealHitCritBuff = function(defCardInfoTable, atkInfo, ...)
  -- function num : 0_5 , upvalues : ipairs, self, BattleBuffDeductionRoundType
  for _,subAtkInfo in ipairs(defCardInfoTable) do
    if subAtkInfo.isCrit == true then
      local defCardPos = subAtkInfo.defPos
      ;
      (self.UpdateEquipBuff)(defCardPos, BattleBuffDeductionRoundType.AFTER_CRIT, atkInfo)
    end
  end
end

-- DECOMPILER ERROR at PC163: Confused about usage of register: R47 in 'UnsetPending'

BattleDataCount.DealDamageBuff = function(atkInfo, ...)
  -- function num : 0_6 , upvalues : _ENV, pairs, self, BattleBuffDeductionRoundType, ipairs
  local totalDamage = (BattleAtk.GetAllCardDamage)(atkInfo)
  for pos,damage in pairs(totalDamage) do
    local card = (BattleData.GetCardInfoByPos)(pos)
    if card:IsDead() == false then
      local maxHp = card:GetMaxHp()
      if 0.2 * maxHp < damage then
        (self.UpdateEquipBuff)(pos, BattleBuffDeductionRoundType.DAMAGE_20_PER, atkInfo)
      end
    else
      do
        ;
        (self.UpdateEquipBuff)(pos, BattleBuffDeductionRoundType.DAMAGE_DEAD, atkInfo)
        local liveCards = (BattleData.GetAliveCards)(card:GetCampFlag())
        for _,partner in ipairs(liveCards) do
          (self.UpdateEquipBuff)(partner:GetPosIndex(), BattleBuffDeductionRoundType.PARTNER_DEAD, atkInfo)
        end
        do
          -- DECOMPILER ERROR at PC49: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC49: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC49: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC166: Confused about usage of register: R47 in 'UnsetPending'

BattleDataCount.DealDamageKill = function(atkCard, atkInfo, ...)
  -- function num : 0_7 , upvalues : self, BattleBuffDeductionRoundType
  (self.UpdateEquipBuff)(atkCard:GetPosIndex(), BattleBuffDeductionRoundType.DAMAGE_KILL, atkInfo)
end

-- DECOMPILER ERROR at PC169: Confused about usage of register: R47 in 'UnsetPending'

BattleDataCount.DealActiveDamageBuff = function(atkCard, atkInfo, ...)
  -- function num : 0_8 , upvalues : self, BattleBuffDeductionRoundType
  (self.UpdateEquipBuff)(atkCard:GetPosIndex(), BattleBuffDeductionRoundType.DAMAGE_BUFF_ACTIVE, atkInfo)
end

-- DECOMPILER ERROR at PC172: Confused about usage of register: R47 in 'UnsetPending'

BattleDataCount.DealOneAliveEnemyBuff = function(atkCard, atkInfo, ...)
  -- function num : 0_9 , upvalues : _ENV, abs, self, BattleBuffDeductionRoundType
  local camp = atkCard:GetCampFlag()
  local liveCards = (BattleData.GetAliveCards)(abs(1 - camp))
  if liveCards and #liveCards == 1 then
    (self.UpdateEquipBuff)(atkCard:GetPosIndex(), BattleBuffDeductionRoundType.ONE_ENEMY_ALIVE, atkInfo)
  end
end

-- DECOMPILER ERROR at PC175: Confused about usage of register: R47 in 'UnsetPending'

BattleDataCount.DealControlEnemyBuff = function(atkCard, atkInfo, ...)
  -- function num : 0_10 , upvalues : _ENV, abs, ipairs, self, BattleBuffDeductionRoundType
  local camp = atkCard:GetCampFlag()
  local liveCards = (BattleData.GetAliveCards)(abs(1 - camp))
  if liveCards then
    for _,card in ipairs(liveCards) do
      if (BattleBuff.ContainBuffGroup)(card, 40) == true then
        (self.UpdateEquipBuff)(atkCard:GetPosIndex(), BattleBuffDeductionRoundType.ENEMY_CONTROL, atkInfo)
      end
    end
  end
end

-- DECOMPILER ERROR at PC178: Confused about usage of register: R47 in 'UnsetPending'

BattleDataCount.UpdateEquipBuff = function(pos, deductionRoundType, atkInfo, ...)
  -- function num : 0_11 , upvalues : BattleBuffMgr, ipairs, self
  local buffList = (BattleBuffMgr.GetBuffListByCardPos)(pos)
  for _,buff in ipairs(buffList) do
    local deduction_round_type = buff:GetDeductionRoundType()
    if deductionRoundType == deduction_round_type then
      (self.RealUpdateBuffCount)(buff, atkInfo)
    end
  end
end

-- DECOMPILER ERROR at PC181: Confused about usage of register: R47 in 'UnsetPending'

BattleDataCount.DealAddBuff = function(card, tempBuff, atkInfo, ...)
  -- function num : 0_12 , upvalues : _ENV, t_insert, BattleBuffOprType, BattleBuffMgr, ipairs, self
  if not atkInfo then
    atkInfo = BattleAtk.curAtkInfo
  end
  local allBuffTable = (BattleAtk.curAtkInfo).allBuffTable
  if (BattleBuff.IsTriggerConditionComplete)(card, tempBuff, atkInfo) == false then
    print("buff挂载条件不足")
  else
    if (BattleBuff.IsBuffImmune)(card, tempBuff) == true then
      t_insert(allBuffTable, {buff = tempBuff:GetBuffInfo(atkInfo, true), type = BattleBuffOprType.IMMUNE})
      if IsBattleServer == nil then
        print("buff被免疫 ", tempBuff:GetBuffLog())
        ;
        (BattleData.SaveBattleProcess)("  buff被免疫 " .. tempBuff:GetBuffLog())
      end
    else
      local isReset, canAdd = (BattleBuff.IsBuffReset)(card, tempBuff)
      if canAdd ~= false then
        do
          local resetBuffTable = (BattleBuffMgr.ResetAllSameBuff)(card, tempBuff, not isReset)
          if #resetBuffTable > 0 then
            for _,v in ipairs(resetBuffTable) do
              t_insert(allBuffTable, {buff = v:GetBuffInfo(atkInfo, true), type = BattleBuffOprType.RESET})
              if IsBattleServer == nil then
                print("重置相同的buff ", v:GetBuffLog())
                ;
                (BattleData.SaveBattleProcess)("  重置buff " .. v:GetBuffLog())
              end
            end
          end
          if canAdd then
            (BattleBuffMgr.AddBuffToList)(tempBuff)
            t_insert(allBuffTable, {buff = tempBuff:GetBuffInfo(atkInfo, true), type = BattleBuffOprType.NEW})
            if IsBattleServer == nil then
              (BattleData.SaveBattleProcess)("  新增buff " .. tempBuff:GetBuffLog())
            end
            ;
            (BattleBuffMgr.DealClearBuff)(card, tempBuff)
            ;
            (self.DealExtraBuffList)(tempBuff, atkInfo, "settle_buff_list")
            return true
          end
          -- DECOMPILER ERROR: 5 unprocessed JMP targets
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC184: Confused about usage of register: R47 in 'UnsetPending'

BattleDataCount.UpdateBuffCount = function(atkInfo, deduction_round_type, ...)
  -- function num : 0_13 , upvalues : BattleBuffMgr, ipairs, t_insert, _ENV, BattleBuffDeductionRoundType, BattleBuffSettleRoundType, self
  local buffList = (BattleBuffMgr.GetBuffList)()
  local idStr = ""
  do
    if idStr ~= "" then
      local strTable = {}
      for _,v in ipairs(buffList) do
        t_insert(strTable, " \n")
        t_insert(strTable, "位置：")
        t_insert(strTable, v:GetCurDefPos())
        t_insert(strTable, "  ")
        t_insert(strTable, v:GetBuffLog())
      end
      print("当前已经挂载的buff：", (table.concat)(strTable))
    end
    local buffListBackUp = {}
    for i,v in ipairs(buffList) do
      t_insert(buffListBackUp, v)
    end
    for _,buff in ipairs(buffListBackUp) do
      if buff then
        local isNew = buff:IsNewBuff(atkInfo)
      end
      -- DECOMPILER ERROR at PC105: Unhandled construct in 'MakeBoolean' P1

      if deduction_round_type ~= BattleBuffDeductionRoundType.NOW and isNew == true and buff:GetDeductionRoundType() ~= buff:GetSettleRoundType() and (buff:GetDeductionRoundType() ~= BattleBuffDeductionRoundType.AFTER_ACTION or buff:GetSettleRoundType() == BattleBuffSettleRoundType.AFTER_ATTACK or buff:GetSettleRoundType() ~= BattleBuffSettleRoundType.AFTER_SKILL) then
        if (buff:GetDeductionRoundType() == BattleBuffDeductionRoundType.AFTER_ATTACK or buff:GetDeductionRoundType() == BattleBuffDeductionRoundType.AFTER_SKILL) and buff:GetSettleRoundType() == BattleBuffSettleRoundType.AFTER_ACTION then
          local defPos = buff:GetCurDefPos()
          local defCard = (BattleData.GetCardInfoByPos)(defPos)
          do
            local deductionRoundType = buff:GetDeductionRoundType()
            -- DECOMPILER ERROR at PC165: Unhandled construct in 'MakeBoolean' P3

            -- DECOMPILER ERROR at PC165: Unhandled construct in 'MakeBoolean' P3

            -- DECOMPILER ERROR at PC165: Unhandled construct in 'MakeBoolean' P3

            if defCard and defCard:IsDead() ~= true and (deductionRoundType == deduction_round_type or ((deductionRoundType == BattleBuffDeductionRoundType.BEFORE_ACTION and deduction_round_type == BattleBuffDeductionRoundType.BEFORE_ATTACK) or deductionRoundType ~= BattleBuffDeductionRoundType.AFTER_ACTION or deductionRoundType ~= BattleBuffDeductionRoundType.BEFORE_ACTION or deductionRoundType ~= BattleBuffDeductionRoundType.AFTER_ACTION or deductionRoundType ~= BattleBuffDeductionRoundType.BEFORE_ROUND_3 or deduction_round_type ~= BattleBuffDeductionRoundType.BEFORE_ROUND or BattleData.roundIndex == 3)) then
              if deduction_round_type == BattleBuffDeductionRoundType.BEFORE_ROUND or deduction_round_type == BattleBuffDeductionRoundType.BEFORE_ROUND_SINCE_2 or deduction_round_type == BattleBuffDeductionRoundType.BEFORE_ROUND_DELAY then
                (self.RealUpdateBuffCount)(buff, atkInfo)
              else
                if (deduction_round_type == BattleBuffDeductionRoundType.BEFORE_ATTACK or deduction_round_type == BattleBuffDeductionRoundType.BEFORE_SKILL or deduction_round_type == BattleBuffDeductionRoundType.BEFORE_ATTACK or deduction_round_type == BattleBuffDeductionRoundType.AFTER_ATTACK or deduction_round_type == BattleBuffDeductionRoundType.AFTER_SKILL or deduction_round_type == BattleBuffDeductionRoundType.AFTER_ACTION or deduction_round_type == BattleBuffDeductionRoundType.AFTER_TREAT_DIRECT) and (BattleAtk.IsAtkCardByPos)(atkInfo, defPos) then
                  (self.RealUpdateBuffCount)(buff, atkInfo)
                end
              end
            end
            if deduction_round_type == BattleBuffDeductionRoundType.AFTER_SKILL_ENEMY and (BattleAtk.IsDefCampByPos)(atkInfo, defPos) then
              (self.RealUpdateBuffCount)(buff, atkInfo)
            end
            if deduction_round_type == BattleBuffDeductionRoundType.AFTER_HIT and (BattleAtk.IsDefCardByPos)(atkInfo, defPos) then
              (self.RealUpdateBuffCount)(buff, atkInfo)
            end
            if deduction_round_type == BattleBuffDeductionRoundType.NOW then
              (self.RealUpdateBuffCount)(buff, atkInfo)
            end
            -- DECOMPILER ERROR at PC237: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC237: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC237: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC237: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
    buffListBackUp = {}
  end
end

-- DECOMPILER ERROR at PC187: Confused about usage of register: R47 in 'UnsetPending'

BattleDataCount.DealExtraBuffList = function(buff, atkInfo, buff_list_type, ...)
  -- function num : 0_14 , upvalues : _ENV, ipairs, t_insert, clone, self, BattleBuffDeductionRoundType
  local buffConfig = buff:GetBuffConfig()
  local curDefPos = buff:GetCurDefPos()
  local defCard = (BattleData.GetCardInfoByPos)(curDefPos)
  local buff_list = buffConfig[buff_list_type]
  if buff_list and buff_list ~= "" and buff_list ~= "0" then
    loge("buff生效扣次数时 触发新buff")
    local realDefCardsInfo = (BattleAtk.GetRealDefCard)(atkInfo.defCardsInfo)
    local defCards = {}
    for _,cardInfo in ipairs(realDefCardsInfo) do
      local card = (BattleData.GetCardInfoByPos)(cardInfo.defPos)
      t_insert(defCards, card)
    end
    local newBuffTable = (BattleSkill.GetAllBuffByBuffList)(defCard, defCards, buff_list)
    for _,newBuff in ipairs(newBuffTable) do
      local targetId = newBuff.targetId
      local targetCards = {}
      if targetId == 1001 or targetId == 1002 then
        targetCards = buff:GetTargetCard(newBuff.targetId)
      else
        local targetPosTable = newBuff:GetTargetPosTable()
        for _,pos in ipairs(targetPosTable) do
          t_insert(targetCards, (BattleData.GetCardInfoByPos)(pos))
        end
      end
      do
        for _,card in ipairs(targetCards) do
          if card and card:IsDead() ~= true then
            local buffClone = clone(newBuff)
            buffClone:SetCurDefPos(card:GetPosIndex())
            buffClone.atkPos = buff.atkPos
            local canAdd = (self.DealAddBuff)(card, buffClone, atkInfo)
            if canAdd == true then
              local deductionRoundType = buffClone:GetDeductionRoundType()
              if deductionRoundType == BattleBuffDeductionRoundType.NOW then
                (self.RealUpdateBuffCount)(buffClone, atkInfo, true)
              end
            end
          end
        end
        do
          -- DECOMPILER ERROR at PC111: LeaveBlock: unexpected jumping out DO_STMT

        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC190: Confused about usage of register: R47 in 'UnsetPending'

BattleDataCount.RealUpdateBuffCount = function(buff, atkInfo, notRemove, ...)
  -- function num : 0_15 , upvalues : _ENV, t_insert, BattleBuffOprType, BattleBuffMgr, self
  if not atkInfo then
    atkInfo = BattleAtk.curAtkInfo
  end
  PrintTable(atkInfo, "  -----    ")
  local allBuffTable = (BattleAtk.curAtkInfo).allBuffTable
  local curActiveCount = buff:GetActiveCount()
  local maxActiveCount = buff:GetTotalCount()
  if curActiveCount < maxActiveCount then
    local isCanEffect = buff:IsCanEffect()
    if isCanEffect == true then
      do
        loge("buff未生效")
        do return  end
        if IsBattleServer == nil then
          (BattleData.SaveBattleProcess)("  更新buff 已生效次数：" .. buff:GetActiveCount() + 1 .. " 总次数：" .. buff:GetTotalCount())
        end
        buff:DealAttribute()
        buff:SetActiveCount(curActiveCount + 1)
        buff:DealSpecialEffect()
        t_insert(allBuffTable, {buff = buff:GetBuffInfo(atkInfo, true), type = BattleBuffOprType.UPDATE})
        if IsBattleServer == nil then
          print("更新buff生效回合 ", buff:GetBuffLog())
          PrintTable(buff:GetBuffInfo())
        end
        if notRemove == nil and buff:NeedRemove() == true then
          (Util.InsertTable)(allBuffTable, {buff = buff:GetBuffInfo(atkInfo, true), type = BattleBuffOprType.DELETE}, true)
          if IsBattleServer == nil then
            (BattleData.SaveBattleProcess)("  移除buff " .. buff:GetBuffLog())
          end
          ;
          (BattleBuffMgr.RemoveBuffFromList)(buff)
        end
        ;
        (self.DealExtraBuffList)(buff, atkInfo, "deduction_buff_list")
      end
    end
  end
end

-- DECOMPILER ERROR at PC193: Confused about usage of register: R47 in 'UnsetPending'

BattleDataCount.ClearNoUsedBuffCount = function(...)
  -- function num : 0_16 , upvalues : BattleBuffMgr
  local buffList = (BattleBuffMgr.GetBuffList)()
  for i = #buffList, 1, -1 do
    local buff = buffList[i]
    if buff:NeedRemove() == true then
      (BattleBuffMgr.RemoveBuffFromList)(buff)
    end
  end
end

-- DECOMPILER ERROR at PC196: Confused about usage of register: R47 in 'UnsetPending'

BattleDataCount.GetNormalAtkDataCount = function(atkCard, defCard, atkInfo, mainAtkCard, mainAtkInfo, ...)
  -- function num : 0_17 , upvalues : self, _ENV, ceil, shanghai_fudong_min, shanghai_fudong_max, max
  atkInfo.defCardsInfo = {}
  ;
  (self.DealOneAliveEnemyBuff)(atkCard, atkInfo)
  ;
  (self.DealControlEnemyBuff)(atkCard, atkInfo)
  local isDoubleAttack = atkInfo.isDoubleAttack
  local killCount = 0
  local defHpBeforeAtk = defCard:GetHp()
  local gongji_A = atkCard:GetAtk()
  local isAssist = atkInfo.isAssist
  local defCardsInfo = atkInfo.defCardsInfo
  local defCardInfo = (BattleAtk.InitSubAtkInfo)(defCard, defCardsInfo)
  local damage = 0
  local atkCardConfig = atkCard:GetCardConfig()
  local defCardConfig = defCard:GetCardConfig()
  local zengshang_A = atkCard:GetExtDamage()
  local jianshang_B = defCard:GetExtDamageSub()
  local realDefHp = defCard:GetHp()
  local is_shanbi = (self.PanDingShanBi)(atkCard, defCard, atkInfo)
  if is_shanbi then
    defCardInfo.isDodge = true
    defCardInfo.isSkillTarget = true
    if IsBattleServer == nil then
      (BattleData.SaveBattleProcess)("    闪避")
    end
  else
    if (BattleBuff.IsDirectKill)(defCard) then
      defCardInfo.isSkillTarget = true
      defCardInfo.hpDef = -defCard:GetHp()
      if defHpBeforeAtk > 0 then
        killCount = killCount + 1
      end
      realDefHp = 0
      if IsBattleServer == nil then
        (BattleData.SaveBattleProcess)("    斩杀 ，位置：" .. defCard:GetPosIndex())
      end
    else
      local fangyu_B, is_pofang = (self.PanDingPoFang)(atkCard, defCard)
      local baoji_jiacheng, gedang_jiangdi = (self.PanDingBaoJiGeDang)(atkCard, defCard)
      local shanghai_jiacheng = (self.PanDingShangHaiJiaCheng)(atkCard, defCard)
      local kezhi_xishu = (self.PanDingKeZhi)(atkCard, defCard)
      local random_seed = (BattleData.GetRandomSeed)()
      local random_hurt = ceil(shanghai_fudong_min + (shanghai_fudong_max - shanghai_fudong_min) * random_seed / 10000)
      damage = max(random_hurt, ceil((gongji_A - fangyu_B) * (10000 + baoji_jiacheng + gedang_jiangdi + shanghai_jiacheng + kezhi_xishu) / 10000 + (zengshang_A - jianshang_B)))
      if BattleData.printBattleData == true then
        loge("   计算伤害   ")
        logw("受击方位置：" .. defCard:GetPosIndex())
        logw("shanghai_fudong_min  " .. shanghai_fudong_min)
        logw("shanghai_fudong_max  " .. shanghai_fudong_max)
        logw("random_hurt  " .. random_hurt)
        logw("gongji_A  " .. gongji_A)
        logw("fangyu_B  " .. fangyu_B)
        logw("baoji_jiacheng  " .. baoji_jiacheng)
        logw("gedang_jiangdi  " .. gedang_jiangdi)
        logw("shanghai_jiacheng  " .. shanghai_jiacheng)
        logw("kezhi_xishu  " .. kezhi_xishu)
      end
      if isAssist == true then
        random_seed = (BattleData.GetRandomSeed)()
        random_hurt = ceil(shanghai_fudong_min + (shanghai_fudong_max - shanghai_fudong_min) * random_seed / 10000)
        local skillConfig = atkCard:GetAssistSkillConfig()
        damage = max(random_hurt, ceil(damage * skillConfig.damage_rate / 10000) + skillConfig.damage)
      end
      do
        local realDamage, absorbDamage, specialEffect = (BattleBuff.DealRealHpLoss)(defCard, damage, isAssist ~= true)
        damage = realDamage
        local isInvincible = specialEffect.isInvincible
        local isKeepAlive = specialEffect.isKeepAlive
        local skillId = atkInfo.skillId
        local skillConfig = (TableData.GetBaseSkillData)(skillId)
        local defFashion = defCard:GetFashionConfig()
        if skillConfig and defFashion.air_show ~= 0 then
          local random = (BattleData.GetRandomSeed)()
          local strike_prob = skillConfig.strike_prob
          if strike_prob > 0 and random <= strike_prob then
            atkInfo.isStrike = true
          end
        end
        defCardInfo.isCrit = baoji_jiacheng > 0
        defCardInfo.isBlock = gedang_jiangdi < 0
        defCardInfo.absorbDamage = absorbDamage + defCardInfo.absorbDamage
        defCardInfo.isInvincible = isInvincible
        defCardInfo.isKeepAlive = isKeepAlive
        defCardInfo.isSkillTarget = true
        do
          local isDamageShare, damageShareBuff = (BattleBuff.IsDamageShare)(defCard)
          if isDamageShare == true then
            local card, value = (BattleBuff.GetDamageShareInfo)(damageShareBuff)
            if value > 0 and (BattleBuff.IsCardCanShareDamage)(card) == true then
              local assistCardHpBeforeAtk = card:GetHp()
              local realBeShareDamage = ceil(realDamage * (10000 - value) / 10000)
              local shareDamage = realDamage - realBeShareDamage
              realDamage = realBeShareDamage
              local defCardInfo = (BattleAtk.InitSubAtkInfo)(card, defCardsInfo)
              local realShareDamage, absorbDamage, specialEffect = (BattleBuff.DealRealHpLoss)(card, shareDamage)
              defCardInfo.hpDef = -realShareDamage + defCardInfo.hpDef
              defCardInfo.absorbDamage = absorbDamage + defCardInfo.absorbDamage
              defCardInfo.isInvincible = specialEffect.isInvincible
              defCardInfo.isKeepAlive = specialEffect.isKeepAlive
              defCardInfo.shareDamageCardPos = defCard:GetPosIndex()
              card:SetHp(card:GetHp() - realShareDamage, atkCard:GetPosIndex())
              if card:GetHp() <= 0 and assistCardHpBeforeAtk > 0 then
                killCount = killCount + 1
              end
              if IsBattleServer == nil then
                (BattleData.SaveBattleProcess)("    援护，援护者：" .. card:GetPosIndex(), " 被援护者：" .. defCard:GetPosIndex())
              end
            end
          end
          defCardInfo.hpDef = -realDamage + defCardInfo.hpDef
          realDefHp = defCard:GetHp() - realDamage
          if realDefHp <= 0 and defHpBeforeAtk > 0 then
            killCount = killCount + 1
          end
          local danderAtk = 0
          local danderDef = 0
          local danderMainAtk = 0
          if isAssist == true then
            if killCount > 0 then
              danderMainAtk = (killCount) * mainAtkCard:GetDanderKill()
              mainAtkInfo.danderAtk = mainAtkInfo.danderAtk + danderMainAtk
            end
            danderAtk = atkCardConfig.dander_atk_assist
            danderDef = defCardConfig.dander_hit_assist
          else
            -- DECOMPILER ERROR at PC369: Unhandled construct in 'MakeBoolean' P1

            if isDoubleAttack == true and killCount > 0 then
              danderAtk = (killCount) * atkCard:GetDanderKill()
            end
          end
          if killCount > 0 then
            danderAtk = atkCard:GetDanderAtk() + (killCount) * atkCard:GetDanderKill()
          else
            danderAtk = atkCard:GetDanderAtk()
          end
          danderDef = defCardConfig.dander_hit
          atkInfo.danderAtk = danderAtk
          atkCard:SetDander(atkCard:GetDander() + atkInfo.danderAtk)
          if danderMainAtk > 0 then
            mainAtkCard:SetDander(mainAtkCard:GetDander() + danderMainAtk)
          end
          defCardInfo.danderDef = danderDef
          defCard:SetDander(defCard:GetDander() + defCardInfo.danderDef)
          local countValue = (BattleBuff.GetCounterValue)(defCard)
          if countValue > 0 and damage ~= 0 then
            local defCardInfo = (BattleAtk.InitSubAtkInfo)(atkCard, defCardsInfo)
            local counterDamage = ceil(damage * countValue / 10000)
            local realCounterDamage, absorbDamage, specialEffect = (BattleBuff.DealRealHpLoss)(atkCard, counterDamage)
            defCardInfo.hpDef = -realCounterDamage
            defCardInfo.absorbDamage = absorbDamage
            defCardInfo.isInvincible = specialEffect.isInvincible
            defCardInfo.isKeepAlive = specialEffect.isKeepAlive
            defCardInfo.isCounter = true
            atkCard:SetHp(atkCard:GetHp() + defCardInfo.hpDef, defCard:GetPosIndex())
            if IsBattleServer == nil then
              (BattleData.SaveBattleProcess)("    反伤，伤害：" .. defCardInfo.hpDef)
            end
          end
          defCard:SetHp(realDefHp, atkCard:GetPosIndex())
          if killCount > 0 and mainAtkCard then
            for i = 1, killCount do
              (self.DealDamageKill)(mainAtkCard, atkInfo)
            end
          end
          do return defCardInfo end
          -- DECOMPILER ERROR: 16 unprocessed JMP targets
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC199: Confused about usage of register: R47 in 'UnsetPending'

BattleDataCount.GetSkillDataCount = function(atkCard, defCards, atkInfo, mainAtkCard, ...)
  -- function num : 0_18 , upvalues : self, _ENV, BattleSkillType, ceil, ipairs, shanghai_fudong_min, shanghai_fudong_max, max, t_insert
  atkInfo.defCardsInfo = {}
  ;
  (self.DealOneAliveEnemyBuff)(atkCard, atkInfo)
  ;
  (self.DealControlEnemyBuff)(atkCard, atkInfo)
  local isDoubleAttack = atkInfo.isDoubleAttack
  local skillLevel = (BattleSkill.GetSkillLevel)(atkCard:GetCardUid(), atkInfo.skillId) or 0
  local defCardsInfo = atkInfo.defCardsInfo
  local gongji_A = atkCard:GetAtk()
  local uniqueSkillDamageAdd = 0
  local skillConfig = (TableData.GetBaseSkillData)(atkInfo.skillId)
  if skillConfig.type == BattleSkillType.SKILL then
    uniqueSkillDamageAdd = (BattleBuff.GetUniqueSkillDamageAdd)(atkCard)
    print("必杀技伤害加成百分比：", uniqueSkillDamageAdd / 100, "%")
  end
  local base_skill_damage = ceil(skillConfig.damage * (1 + skillConfig.damage_up * skillLevel / 10000) + gongji_A * (skillConfig.damage_rate + skillConfig.damage_rate_up * skillLevel) / 10000)
  local danderAtk = 0
  if skillConfig.type ~= BattleSkillType.SKILL and isDoubleAttack ~= true then
    danderAtk = danderAtk + atkCard:GetDanderAtk()
  end
  local defCardInfoTable = {}
  local killCount = 0
  for _,defCard in ipairs(defCards) do
    local defCardInfo = (BattleAtk.InitSubAtkInfo)(defCard, defCardsInfo)
    local damage = 0
    local defHpBeforeAtk = defCard:GetHp()
    local is_shanbi = (self.PanDingShanBi)(atkCard, defCard, atkInfo, true)
    local realDefHp = defCard:GetHp()
    if is_shanbi then
      defCardInfo.isSkillTarget = true
      defCardInfo.isDodge = true
      if IsBattleServer == nil then
        (BattleData.SaveBattleProcess)("    闪避")
      end
    else
      if (BattleBuff.IsDirectKill)(defCard) then
        defCardInfo.isSkillTarget = true
        defCardInfo.hpDef = -defCard:GetHp()
        if defHpBeforeAtk > 0 then
          killCount = killCount + 1
        end
        realDefHp = 0
        if IsBattleServer == nil then
          (BattleData.SaveBattleProcess)("    斩杀 ，位置：" .. defCard:GetPosIndex())
        end
      else
        local zengshang_A = atkCard:GetExtDamage()
        local jianshang_B = defCard:GetExtDamageSub()
        local fangyu_B, is_pofang = (self.PanDingPoFang)(atkCard, defCard)
        local baoji_jiacheng, gedang_jiangdi = (self.PanDingBaoJiGeDang)(atkCard, defCard)
        local shanghai_jiacheng = (self.PanDingShangHaiJiaCheng)(atkCard, defCard)
        local kezhi_xishu = (self.PanDingKeZhi)(atkCard, defCard)
        local random_seed = (BattleData.GetRandomSeed)()
        local random_hurt = ceil(shanghai_fudong_min + (shanghai_fudong_max - shanghai_fudong_min) * random_seed / 10000)
        if BattleData.printBattleData == true then
          loge("   计算伤害   ")
          logw("受击方位置：" .. defCard:GetPosIndex())
          logw("base_skill_damage  " .. base_skill_damage)
          logw("fangyu_B  " .. fangyu_B)
          logw("baoji_jiacheng  " .. baoji_jiacheng)
          logw("gedang_jiangdi  " .. gedang_jiangdi)
          logw("shanghai_jiacheng  " .. shanghai_jiacheng)
          logw("kezhi_xishu  " .. kezhi_xishu)
        end
        damage = max(random_hurt, ceil((base_skill_damage - fangyu_B) * (10000 + baoji_jiacheng + gedang_jiangdi + shanghai_jiacheng + kezhi_xishu) / 10000 + (zengshang_A - jianshang_B)))
        if uniqueSkillDamageAdd ~= 0 or not 1 then
          local realDamage, absorbDamage, specialEffect = (BattleBuff.DealRealHpLoss)(defCard, damage, true, uniqueSkillDamageAdd / 10000)
          damage = realDamage
          local isInvincible = specialEffect.isInvincible
          local isKeepAlive = specialEffect.isKeepAlive
          local skillId = atkInfo.skillId
          local skillConfig = (TableData.GetBaseSkillData)(skillId)
          local defFashion = defCard:GetFashionConfig()
          if skillConfig and defFashion.air_show ~= 0 then
            local random = (BattleData.GetRandomSeed)()
            local strike_prob = skillConfig.strike_prob
            if strike_prob > 0 and random <= strike_prob then
              atkInfo.isStrike = true
            end
          end
          do
            defCardInfo.isCrit = baoji_jiacheng > 0
            defCardInfo.isBlock = gedang_jiangdi < 0
            defCardInfo.absorbDamage = absorbDamage + defCardInfo.absorbDamage
            defCardInfo.isInvincible = isInvincible
            defCardInfo.isKeepAlive = isKeepAlive
            defCardInfo.isSkillTarget = true
            do
              local isDamageShare, damageShareBuff = (BattleBuff.IsDamageShare)(defCard)
              if isDamageShare == true then
                local card, value = (BattleBuff.GetDamageShareInfo)(damageShareBuff)
                if value > 0 and (BattleBuff.IsCardCanShareDamage)(card) == true then
                  local assistCardHpBeforeAtk = card:GetHp()
                  local realBeShareDamage = ceil(realDamage * (10000 - value) / 10000)
                  local shareDamage = realDamage - realBeShareDamage
                  realDamage = realBeShareDamage
                  local defCardInfo = (BattleAtk.InitSubAtkInfo)(card, defCardsInfo)
                  local realShareDamage, absorbDamage, specialEffect = (BattleBuff.DealRealHpLoss)(card, shareDamage)
                  defCardInfo.hpDef = -realShareDamage + defCardInfo.hpDef
                  defCardInfo.absorbDamage = absorbDamage + defCardInfo.absorbDamage
                  defCardInfo.isInvincible = specialEffect.isInvincible
                  defCardInfo.isKeepAlive = specialEffect.isKeepAlive
                  defCardInfo.shareDamageCardPos = defCard:GetPosIndex()
                  card:SetHp(card:GetHp() - realShareDamage, atkCard:GetPosIndex())
                  if card:GetHp() <= 0 and assistCardHpBeforeAtk > 0 then
                    killCount = killCount + 1
                  end
                  if IsBattleServer == nil then
                    (BattleData.SaveBattleProcess)("    援护，援护者：" .. card:GetPosIndex(), " 被援护者：" .. defCard:GetPosIndex())
                  end
                end
              end
              defCardInfo.hpDef = -realDamage + defCardInfo.hpDef
              realDefHp = defCard:GetHp() - realDamage
              if realDefHp <= 0 and defHpBeforeAtk > 0 then
                killCount = killCount + 1
              end
              local danderDef = 0
              if isDoubleAttack ~= true then
                danderDef = defCard:GetDanderHit()
              end
              defCardInfo.danderDef = danderDef
              defCard:SetDander(defCard:GetDander() + defCardInfo.danderDef)
              do
                local countValue = (BattleBuff.GetCounterValue)(defCard)
                if countValue > 0 and damage ~= 0 then
                  local defCardInfo = (BattleAtk.InitSubAtkInfo)(atkCard, defCardsInfo)
                  local counterDamage = ceil(damage * countValue / 10000)
                  local realCounterDamage, absorbDamage, specialEffect = (BattleBuff.DealRealHpLoss)(atkCard, counterDamage)
                  defCardInfo.hpDef = defCardInfo.hpDef - realCounterDamage
                  defCardInfo.absorbDamage = defCardInfo.absorbDamage + absorbDamage
                  defCardInfo.isInvincible = specialEffect.isInvincible
                  defCardInfo.isKeepAlive = specialEffect.isKeepAlive
                  defCardInfo.isCounter = true
                  atkCard:SetHp(atkCard:GetHp() - realCounterDamage, defCard:GetPosIndex())
                  if IsBattleServer == nil then
                    (BattleData.SaveBattleProcess)("    反伤，伤害：" .. defCardInfo.hpDef)
                  end
                end
                defCard:SetHp(realDefHp, atkCard:GetPosIndex())
                t_insert(defCardInfoTable, defCardInfo)
                -- DECOMPILER ERROR at PC431: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC431: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC431: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC431: LeaveBlock: unexpected jumping out IF_STMT

                -- DECOMPILER ERROR at PC431: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                -- DECOMPILER ERROR at PC431: LeaveBlock: unexpected jumping out IF_STMT

                -- DECOMPILER ERROR at PC431: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                -- DECOMPILER ERROR at PC431: LeaveBlock: unexpected jumping out IF_STMT

              end
            end
          end
        end
      end
    end
  end
  if killCount > 0 then
    danderAtk = danderAtk + (killCount) * atkCard:GetDanderKill()
  end
  if skillConfig.type == BattleSkillType.SKILL then
    danderAtk = danderAtk - atkCard:GetMaxDander()
  end
  atkInfo.danderAtk = danderAtk
  atkCard:SetDander(atkCard:GetDander() + (danderAtk))
  if killCount > 0 and mainAtkCard then
    for i = 1, killCount do
      (self.DealDamageKill)(mainAtkCard, atkInfo)
    end
  end
  do return defCardInfoTable end
  -- DECOMPILER ERROR: 11 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC202: Confused about usage of register: R47 in 'UnsetPending'

BattleDataCount.PanDingPoFang = function(atkCard, defCard, ...)
  -- function num : 0_19 , upvalues : ceil, gedang_diyu_xishu, _ENV, pofang_diyu_xishu, max
  local pofang_A = atkCard:GetArp()
  local diyu_B = defCard:GetRea()
  local pofang_qiangdu_A = atkCard:GetArpInt()
  local diyu_qiangdu_B = defCard:GetReaInt()
  local fangyu_B = (defCard:GetDef())
  local pofanglv = nil
  if diyu_B < pofang_A then
    pofanglv = ceil((pofang_A - diyu_B) / (pofang_A - diyu_B + gedang_diyu_xishu) * 10000)
  else
    pofanglv = 0
  end
  local random = (BattleData.GetRandomSeed)()
  if BattleData.printBattleData == true then
    loge("   计算破防   ")
    logw("受击方位置：" .. defCard:GetPosIndex())
    logw("pofang_A  " .. pofang_A)
    logw("diyu_B  " .. diyu_B)
    logw("xishu_gedang_poji  " .. gedang_diyu_xishu)
    logw("pofanglv  " .. pofanglv)
    logw("当前随机数：  " .. random)
    logw("fangyu_B  " .. fangyu_B)
    logw("pofang_qiangdu_A  " .. pofang_qiangdu_A)
    logw("diyu_qiangdu_B  " .. diyu_qiangdu_B)
    logw("xishu_pofang_diyu  " .. pofang_diyu_xishu)
  end
  local is_pofang = random <= pofanglv
  if is_pofang then
    fangyu_B = max(0, fangyu_B * (1 - (pofang_qiangdu_A - diyu_qiangdu_B) / (pofang_qiangdu_A - diyu_qiangdu_B + pofang_diyu_xishu)))
  end
  do return fangyu_B, is_pofang end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC205: Confused about usage of register: R47 in 'UnsetPending'

BattleDataCount.PanDingShanBi = function(atkCard, defCard, atkInfo, isSkill, ...)
  -- function num : 0_20 , upvalues : ceil, mingzhong_shanbi_xishu, _ENV
  local shanbi_B = defCard:GetEva()
  local mingzhong_A = atkCard:GetHit()
  local ewai_gongji_shanbilv = 0
  local defCardConfig = defCard:GetCardConfig()
  if isSkill then
    ewai_gongji_shanbilv = defCardConfig.skill_eva_prob
  else
    ewai_gongji_shanbilv = defCardConfig.atk_eva_prob
  end
  local shanbilv = nil
  if mingzhong_A < shanbi_B then
    shanbilv = ceil(((shanbi_B - mingzhong_A) / (shanbi_B - mingzhong_A + mingzhong_shanbi_xishu) + ewai_gongji_shanbilv) * 10000)
  else
    shanbilv = 0
  end
  if (BattleBuff.IsForbiddenAttackHit)(atkCard, atkInfo) then
    shanbilv = 10000
  else
    if (BattleBuff.IsForbiddenDefendDodge)(defCard, atkInfo) then
      shanbilv = 0
    end
  end
  local random = (BattleData.GetRandomSeed)()
  if BattleData.printBattleData == true then
    loge("   计算闪避  ")
    logw("受击方位置：" .. defCard:GetPosIndex())
    logw("shanbi_B  " .. shanbi_B)
    logw("mingzhong_A  " .. mingzhong_A)
    logw("mingzhong_shanbi_xishu  " .. mingzhong_shanbi_xishu)
    logw("ewai_gongji_shanbilv  " .. ewai_gongji_shanbilv)
    logw("当前随机数：  " .. random)
  end
  local is_shanbi = random <= shanbilv
  do return is_shanbi end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC208: Confused about usage of register: R47 in 'UnsetPending'

BattleDataCount.PanDingBaoJiGeDang = function(atkCard, defCard, ...)
  -- function num : 0_21 , upvalues : ceil, baoji_mianbao_xishu, min, baojilv_max, max, baojilv_min, _ENV, gedang_poji_xishu, gedanglv_max, gedanglv_min, baoji_jiacheng_max, baoji_jiacheng_min, baoji_kangbao_qiangdu_xishu, gedang_jiacheng_max, gedang_jiacheng_min, gedang_poji_qiangdu_xishu
  local baoji_A = atkCard:GetCrt()
  local kangbao_B = (defCard:GetRec())
  local baojilv = nil
  if kangbao_B < baoji_A then
    baojilv = ceil((baoji_A - kangbao_B) / (baoji_A - kangbao_B + baoji_mianbao_xishu) * 10000)
  else
    baojilv = 0
  end
  local jueduibaojilv_A = atkCard:GetCrtProp()
  baojilv = min(baojilv_max, max(baojilv_min, baojilv)) + jueduibaojilv_A
  if (BattleBuff.IsCritPersist)(atkCard) == true then
    baojilv = 10000
  else
    if (BattleBuff.IsRecPersist)(defCard) == true then
      baojilv = 0
    end
  end
  local gedang_B = defCard:GetBlk()
  local poji_A = (atkCard:GetReb())
  local gedanglv = nil
  if poji_A < gedang_B then
    gedanglv = ceil((gedang_B - poji_A) / (gedang_B - poji_A + gedang_poji_xishu) * 10000)
  else
    gedanglv = 0
  end
  local jueduigedanglv_B = defCard:GetCrtProp()
  gedanglv = min(gedanglv_max, max(gedanglv_min, gedanglv)) + jueduigedanglv_B
  if (BattleBuff.IsRebPersist)(atkCard) == true then
    gedanglv = 0
  else
    if (BattleBuff.IsForbiddenBlock)(defCard) == true then
      gedanglv = 0
    else
      if (BattleBuff.IsBlockPersist)(defCard) == true then
        gedanglv = 10000
      end
    end
  end
  local baoji_jiacheng = 0
  local gedang_jiangdi = 0
  local baoji_qiangdu_A = atkCard:GetCrtInt()
  local kangbao_qiangdu_B = defCard:GetRecInt()
  local gedang_qiangdu_B = defCard:GetBlkInt()
  local poji_qiangdu_A = atkCard:GetRebInt()
  local random_num = (BattleData.GetRandomSeed)()
  if BattleData.printBattleData == true then
    loge("当前随机数：   " .. random_num)
    loge("   计算暴击加成   ")
    logw("受击方位置：" .. defCard:GetPosIndex())
    logw("baojilv  " .. baojilv)
    logw("baoji_jiacheng_max  " .. baoji_jiacheng_max)
    logw("baoji_jiacheng_min  " .. baoji_jiacheng_min)
    logw("baoji_qiangdu_A  " .. baoji_qiangdu_A)
    logw("kangbao_qiangdu_B  " .. kangbao_qiangdu_B)
    logw("baoji_kangbao_qiangdu_xishu  " .. baoji_kangbao_qiangdu_xishu)
    loge("   计算格挡加成   ")
    logw("受击方位置：" .. defCard:GetPosIndex())
    logw("gedanglv  " .. gedanglv)
    logw("gedang_jiacheng_max  " .. gedang_jiacheng_max)
    logw("gedang_jiacheng_min  " .. gedang_jiacheng_min)
    logw("gedang_qiangdu_B  " .. gedang_qiangdu_B)
    logw("poji_qiangdu_A  " .. poji_qiangdu_A)
    logw("gedang_poji_xishu  " .. gedang_poji_qiangdu_xishu)
  end
  if baojilv + gedanglv <= 10000 then
    if random_num <= baojilv then
      baoji_jiacheng = min(baoji_jiacheng_max, max(baoji_jiacheng_min, ceil(10000 * (baoji_qiangdu_A - kangbao_qiangdu_B) / (baoji_qiangdu_A - kangbao_qiangdu_B + baoji_kangbao_qiangdu_xishu))))
    else
      if random_num <= baojilv + gedanglv then
        gedang_jiangdi = -min(gedang_jiacheng_max, max(gedang_jiacheng_min, ceil(10000 * (gedang_qiangdu_B - poji_qiangdu_A) / (gedang_qiangdu_B - poji_qiangdu_A + gedang_poji_qiangdu_xishu))))
      end
    end
  else
    if random_num <= baojilv then
      baoji_jiacheng = min(baoji_jiacheng_max, max(baoji_jiacheng_min, ceil(10000 * (baoji_qiangdu_A - kangbao_qiangdu_B) / (baoji_qiangdu_A - kangbao_qiangdu_B + baoji_kangbao_qiangdu_xishu))))
    else
      gedang_jiangdi = -min(gedang_jiacheng_max, max(gedang_jiacheng_min, ceil(10000 * (gedang_qiangdu_B - poji_qiangdu_A) / (gedang_qiangdu_B - poji_qiangdu_A + gedang_poji_qiangdu_xishu))))
    end
  end
  return baoji_jiacheng, gedang_jiangdi
end

-- DECOMPILER ERROR at PC211: Confused about usage of register: R47 in 'UnsetPending'

BattleDataCount.PanDingShangHaiJiaCheng = function(atkCard, defCard, ...)
  -- function num : 0_22 , upvalues : _ENV, shanghai_jiacheng_min, zengshang_mianshang_xishu, max, ceil, min, shanghai_jiacheng_max
  local zengshang_qiangdu_A = atkCard:GetAddInt()
  local mianshang_qiangdu_B = defCard:GetExdInt()
  local shanghai_jiacheng = 0
  if BattleData.printBattleData == true then
    loge("   计算伤害加成   ")
    logw("受击方位置：" .. defCard:GetPosIndex())
    logw("shanghai_jiacheng_min  " .. shanghai_jiacheng_min)
    logw("mianshang_qiangdu_B  " .. mianshang_qiangdu_B)
    logw("zengshang_mianshang_xishu  " .. zengshang_mianshang_xishu)
  end
  if zengshang_qiangdu_A < mianshang_qiangdu_B then
    shanghai_jiacheng = max(shanghai_jiacheng_min, ceil(10000 * (zengshang_qiangdu_A - mianshang_qiangdu_B) / (mianshang_qiangdu_B - zengshang_qiangdu_A + zengshang_mianshang_xishu)))
  else
    shanghai_jiacheng = min(shanghai_jiacheng_max, ceil(10000 * (zengshang_qiangdu_A - mianshang_qiangdu_B) / (zengshang_qiangdu_A - mianshang_qiangdu_B + zengshang_mianshang_xishu)))
  end
  return shanghai_jiacheng
end

-- DECOMPILER ERROR at PC214: Confused about usage of register: R47 in 'UnsetPending'

BattleDataCount.PanDingKeZhi = function(atkCard, defCard, ...)
  -- function num : 0_23
  return 0
end

-- DECOMPILER ERROR at PC217: Confused about usage of register: R47 in 'UnsetPending'

BattleDataCount.GetTreatmentCount = function(atkCard, defCards, atkInfo, ...)
  -- function num : 0_24 , upvalues : _ENV, ceil, zhiliao_baoji_xishu, min, zhiliao_baojilv_max, max, zhiliao_baojilv_min, zhiliao_baoji_jiacheng_max, zhiliao_baoji_jiacheng_min, zhiliao_baoji_qiangdu_xishu, BattleSkillType, ipairs, zhiliao_fudong_min, zhiliao_fudong_max
  atkInfo.defCardsInfo = {}
  local defCardsInfo = atkInfo.defCardsInfo
  local gongji_A = atkCard:GetAtk()
  local skillId = atkInfo.skillId
  local skillConfig = (TableData.GetBaseSkillData)(skillId)
  local skillLevel = (BattleSkill.GetSkillLevel)(atkCard:GetCardUid(), skillId) or 0
  local base_treatment = skillConfig.damage * (1 + skillConfig.damage_up * skillLevel / 10000)
  local base_treatment_per = skillConfig.damage_rate + skillConfig.damage_rate_up * skillLevel
  local baoji_A = atkCard:GetCrt()
  local baoji_qiangdu_A = atkCard:GetCrtInt()
  local baojilv = ceil(baoji_A / (baoji_A + zhiliao_baoji_xishu) * 10000)
  baojilv = min(zhiliao_baojilv_max, max(zhiliao_baojilv_min, baojilv))
  local baoji_jiacheng = nil
  local random_num = (BattleData.GetRandomSeed)()
  if random_num <= baojilv then
    baoji_jiacheng = min(zhiliao_baoji_jiacheng_max, max(zhiliao_baoji_jiacheng_min, baoji_qiangdu_A / (baoji_qiangdu_A + zhiliao_baoji_qiangdu_xishu) * 10000))
  else
    baoji_jiacheng = 0
  end
  local danderAtk = atkCard:GetDanderAtk()
  if skillConfig.type == BattleSkillType.SKILL then
    danderAtk = danderAtk - atkCard:GetMaxDander()
  end
  atkInfo.danderAtk = danderAtk
  atkCard:SetDander(atkCard:GetDander() + atkInfo.danderAtk)
  atkInfo.isTreatment = true
  local atkTreatAdd = atkCard:GetTreatAdd()
  local atkTreatSub = atkCard:GetTreatSub()
  for _,defCard in ipairs(defCards) do
    local random_seed = (BattleData.GetRandomSeed)()
    local random_treatment = ceil(-zhiliao_fudong_min + (-zhiliao_fudong_max + zhiliao_fudong_min) * random_seed / 10000)
    local defBeTreatAdd = defCard:GetBeTreatAdd()
    local defBeTreatSub = defCard:GetBeTreatSub()
    local treatment = min(random_treatment, base_treatment + gongji_A * (base_treatment_per + atkTreatAdd - atkTreatSub) * (10000 + defBeTreatAdd - defBeTreatSub) / 100000000)
    local defCardInfo = (BattleAtk.InitSubAtkInfo)(defCard, defCardsInfo)
    if (BattleBuff.IsForbiddenTreatment)(defCard) then
      defCardInfo.hpDef = 0
      defCardInfo.isCrit = false
    else
      local realTreatment = (BattleBuff.DealRealHpLoss)(defCard, treatment, true)
      defCardInfo.hpDef = ceil(-realTreatment)
      defCard:SetHp(defCard:GetHp() + defCardInfo.hpDef, atkCard:GetPosIndex())
      defCardInfo.isCrit = baoji_jiacheng > 0
    end
    defCardInfo.danderDef = 0
    defCardInfo.isSkillTarget = true
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC220: Confused about usage of register: R47 in 'UnsetPending'

BattleDataCount.GetAtkDanderCount = function(atkInfo, ...)
  -- function num : 0_25
  local atkPos = atkInfo.atkPos
end


