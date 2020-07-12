-- params : ...
-- function num : 0 , upvalues : _ENV
BattleBuffMgr = {
tempBuffList = {}
, 
buffList = {}
, 
playBackBuffDataList = {}
}
local t_remove = table.remove
local t_insert = table.insert
local ipairs = ipairs
local split = split
local tonumber = tonumber
local self = BattleBuffMgr
-- DECOMPILER ERROR at PC18: Confused about usage of register: R6 in 'UnsetPending'

BattleBuffMgr.InitBuffList = function(...)
  -- function num : 0_0 , upvalues : ipairs, self
  local allPosTable = {1, 2, 3, 11, 12, 13, 101, 102, 103, 111, 112, 113}
  for _,pos in ipairs(allPosTable) do
    (self.ClearCardBuff)(pos)
  end
  self.tempBuffList = {}
  self.buffList = {}
  self.playBackBuffDataList = {}
end

-- DECOMPILER ERROR at PC21: Confused about usage of register: R6 in 'UnsetPending'

BattleBuffMgr.ClearCardBuff = function(pos, ...)
  -- function num : 0_1 , upvalues : self, t_remove, _ENV
  local buffList = (self.GetTempBuffList)()
  for i = #buffList, 1, -1 do
    local v = buffList[i]
    if v then
      local curDefPos = v:GetCurDefPos()
      if curDefPos == pos then
        t_remove(buffList, i)
        v:Destroy()
      end
    end
  end
  local buffList = (self.GetBuffList)()
  for i = #buffList, 1, -1 do
    local v = buffList[i]
    if v then
      local curDefPos = v:GetCurDefPos()
      if curDefPos == pos then
        local card = (BattleData.GetCardInfoByPos)(curDefPos)
        if card then
          (BattleBuff.PlayBuffRemove)(card, v:GetBuffInfo())
        end
        t_remove(buffList, i)
        v:Destroy()
      end
    end
  end
  local buffList = (self.GetBuffPlayBackList)()
  for i = #buffList, 1, -1 do
    local v = buffList[i]
    if v then
      local curDefPos = v.curDefPos
      if curDefPos == pos then
        local card = (BattleData.GetCardInfoByPos)(curDefPos)
        if card then
          (BattleBuff.PlayBuffRemove)(card, v)
        end
        t_remove(buffList, i)
      end
    end
  end
end

-- DECOMPILER ERROR at PC24: Confused about usage of register: R6 in 'UnsetPending'

BattleBuffMgr.AddTempBuffToList = function(buff, ...)
  -- function num : 0_2 , upvalues : _ENV, t_insert, self
  if buff then
    if IsBattleServer == nil then
      print("新增临时buff:", buff:GetBuffLog())
    end
    t_insert(self.tempBuffList, buff)
  end
end

-- DECOMPILER ERROR at PC27: Confused about usage of register: R6 in 'UnsetPending'

BattleBuffMgr.RemoveTempBuffFromList = function(buff, ...)
  -- function num : 0_3 , upvalues : self, ipairs, _ENV, t_remove
  local tempBuffList = (self.GetTempBuffList)()
  for i,v in ipairs(tempBuffList) do
    if v == buff then
      if IsBattleServer == nil then
        print("删除临时buff:", buff:GetBuffLog())
      end
      t_remove(tempBuffList, i)
      return 
    end
  end
end

-- DECOMPILER ERROR at PC30: Confused about usage of register: R6 in 'UnsetPending'

BattleBuffMgr.GetTempBuffList = function(...)
  -- function num : 0_4 , upvalues : self
  return self.tempBuffList
end

-- DECOMPILER ERROR at PC33: Confused about usage of register: R6 in 'UnsetPending'

BattleBuffMgr.AddBuffToList = function(buff, ...)
  -- function num : 0_5 , upvalues : _ENV, t_insert, self
  if buff then
    buff:GetBuffInfo(BattleAtk.curAtkInfo)
    if IsBattleServer == nil then
      print("新增buff:", buff:GetBuffLog())
      PrintTable(buff:GetBuffInfo(), "详细信息 BuffInfo:")
    end
    t_insert(self.buffList, buff)
  end
end

-- DECOMPILER ERROR at PC36: Confused about usage of register: R6 in 'UnsetPending'

BattleBuffMgr.RemoveBuffFromList = function(buff, ...)
  -- function num : 0_6 , upvalues : self, ipairs, _ENV, t_remove
  local buffList = (self.GetBuffList)()
  for i,v in ipairs(buffList) do
    if v == buff then
      if IsBattleServer == nil then
        print("删除buff:", buff:GetBuffLog())
        PrintTable(buff:GetBuffInfo(), "详细信息 BuffInfo:")
      end
      t_remove(buffList, i)
      return 
    end
  end
end

-- DECOMPILER ERROR at PC39: Confused about usage of register: R6 in 'UnsetPending'

BattleBuffMgr.GetBuffList = function(...)
  -- function num : 0_7 , upvalues : self
  return self.buffList
end

-- DECOMPILER ERROR at PC42: Confused about usage of register: R6 in 'UnsetPending'

BattleBuffMgr.AddBuffToPlayBackList = function(buffData, ...)
  -- function num : 0_8 , upvalues : _ENV, t_insert, self
  if buffData and BattleConfig.isPlayBack == true then
    t_insert(self.playBackBuffDataList, buffData)
  end
end

-- DECOMPILER ERROR at PC45: Confused about usage of register: R6 in 'UnsetPending'

BattleBuffMgr.RemoveBuffFromPlayBackList = function(buffData, ...)
  -- function num : 0_9 , upvalues : _ENV, self, ipairs, t_remove
  PrintTable(buffData, "移除回放buff")
  local buffList = (self.GetBuffPlayBackList)()
  for i,v in ipairs(buffList) do
    if v.buffTimeStamp == buffData.buffTimeStamp and v.buffId == buffData.buffId and v.atkPos == buffData.atkPos and v.curDefPos == buffData.curDefPos then
      t_remove(buffList, i)
      log("移除")
      return 
    end
  end
end

-- DECOMPILER ERROR at PC48: Confused about usage of register: R6 in 'UnsetPending'

BattleBuffMgr.GetBuffPlayBackList = function(...)
  -- function num : 0_10 , upvalues : self
  return self.playBackBuffDataList
end

-- DECOMPILER ERROR at PC51: Confused about usage of register: R6 in 'UnsetPending'

BattleBuffMgr.GetBuffListByCardPos = function(pos, includeInactive, ...)
  -- function num : 0_11 , upvalues : self, ipairs, t_insert
  local list = {}
  local buffList = (self.GetBuffList)()
  for _,v in ipairs(buffList) do
    local curDefPos = v:GetCurDefPos()
    if curDefPos == pos then
      local sleepState = v:GetSleepState()
      if sleepState ~= 1 or includeInactive == true then
        t_insert(list, v)
      end
    end
  end
  return list
end

-- DECOMPILER ERROR at PC54: Confused about usage of register: R6 in 'UnsetPending'

BattleBuffMgr.GetBuffListByCardAndId = function(card, buffId, ...)
  -- function num : 0_12 , upvalues : self, ipairs, t_insert
  local list = {}
  local buffList = (self.GetBuffList)()
  local pos = card:GetPosIndex()
  for _,v in ipairs(buffList) do
    local curDefPos = v:GetCurDefPos()
    if curDefPos == pos and v.buffId == buffId then
      t_insert(list, v)
    end
  end
  return list
end

-- DECOMPILER ERROR at PC57: Confused about usage of register: R6 in 'UnsetPending'

BattleBuffMgr.GetBuffListByCardAndType = function(card, type, ...)
  -- function num : 0_13 , upvalues : self, ipairs, t_insert
  local list = {}
  local buffList = (self.GetBuffList)()
  local pos = card:GetPosIndex()
  for _,v in ipairs(buffList) do
    local curDefPos = v:GetCurDefPos()
    if curDefPos == pos and (v:GetBuffConfig()).type == type then
      t_insert(list, v)
    end
  end
  return list
end

-- DECOMPILER ERROR at PC60: Confused about usage of register: R6 in 'UnsetPending'

BattleBuffMgr.GetBuffCountById = function(card, buffId, ...)
  -- function num : 0_14 , upvalues : self, ipairs
  local count = 0
  local buffList = (self.GetBuffList)()
  for _,v in ipairs(buffList) do
    if v:GetBuffId() == buffId and v:GetCurDefPos() == card:GetPosIndex() then
      count = count + 1
    end
  end
  return count
end

-- DECOMPILER ERROR at PC63: Confused about usage of register: R6 in 'UnsetPending'

BattleBuffMgr.ResetAllSameBuff = function(card, tempBuff, isReplace, ...)
  -- function num : 0_15 , upvalues : self, ipairs, _ENV, t_insert
  local resetBuffTable = {}
  local buffList = (self.GetBuffList)()
  for _,v in ipairs(buffList) do
    if v:GetBuffId() == tempBuff:GetBuffId() and v:GetCurDefPos() == card:GetPosIndex() then
      do
        do
          if (BattleBuff.IsBuffContainEffectId)(v, BattleDisplayEffect.SHIELD) then
            local effectTable = v:GetEffectTable()
            for _,effect in ipairs(effectTable) do
              if (BattleBuff.IsShield)(effect.effectId) then
                effect.realValue = v:GetUsedShieldHp()
              end
            end
            v:SetEffectTable(effectTable)
          end
          v:SetUsedShieldHp(0)
          v:SetActiveCount(0)
          if isReplace == true and IsBattleServer == nil then
            print("替换相同的buff ", tempBuff:GetBuffLog())
          end
          t_insert(resetBuffTable, v)
          -- DECOMPILER ERROR at PC67: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC67: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC67: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  return resetBuffTable
end

-- DECOMPILER ERROR at PC66: Confused about usage of register: R6 in 'UnsetPending'

BattleBuffMgr.GetShieldInfo = function(posIndex, ...)
  -- function num : 0_16 , upvalues : self, ipairs
  local buffList = (self.GetBuffList)()
  for _,v in ipairs(buffList) do
    local buffData = v:GetBuffInfo()
    if v:GetCurDefPos() == posIndex then
      return v
    end
  end
end

-- DECOMPILER ERROR at PC69: Confused about usage of register: R6 in 'UnsetPending'

BattleBuffMgr.GetBuffDataByDetailId = function(buffId, posIndex, timeStamp, ...)
  -- function num : 0_17 , upvalues : self, ipairs
  local buffList = (self.GetBuffList)()
  for _,v in ipairs(buffList) do
    local buffData = v:GetBuffInfo()
    if v:GetBuffId() == buffId and v:GetCurDefPos() == posIndex and buffData.buffTimeStamp == timeStamp then
      return v
    end
  end
end

-- DECOMPILER ERROR at PC72: Confused about usage of register: R6 in 'UnsetPending'

BattleBuffMgr.DealClearBuff = function(targetCard, newBuff, ...)
  -- function num : 0_18 , upvalues : _ENV, ipairs
  local BattleBuffDeductionRoundType = BattleBuffDeductionRoundType
  local BattleDataCount = BattleDataCount
  local clone = Util.Copy
  if newBuff then
    local buffConfig = newBuff:GetBuffConfig()
    if buffConfig then
      local clean_buff_group = buffConfig.clean_buff_group
      local clean_add_buff = buffConfig.clean_add_buff
      if clean_buff_group and clean_buff_group ~= "" and clean_buff_group ~= "0" then
        local isClear, clearCount = (BattleBuffMgr.CleanBuffGroup)(targetCard, clean_buff_group, newBuff)
        if isClear and clean_add_buff and clean_add_buff ~= "0" and clean_add_buff ~= "" then
          print("清除buff，数量：", clearCount, "清除后新增buff：", clean_add_buff)
          local newBuffTable = (BattleSkill.GetAllBuffByBuffList)(nil, {}, clean_add_buff)
          for _,buff in ipairs(newBuffTable) do
            local targetCards = newBuff:GetTargetCard(buff.targetId)
            for _,card in ipairs(targetCards) do
              if card and card:IsDead() ~= true then
                local buffClone = clone(buff)
                buffClone:SetClearCount(clearCount)
                buffClone:SetCurDefPos(card:GetPosIndex())
                buffClone.atkPos = newBuff.atkPos
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
      end
    end
  end
end

-- DECOMPILER ERROR at PC75: Confused about usage of register: R6 in 'UnsetPending'

BattleBuffMgr.CleanBuffGroup = function(targetCard, buffGroup, newBuff, ...)
  -- function num : 0_19 , upvalues : split, _ENV, tonumber, ipairs
  local isClear = false
  local clearCount = 0
  local split = split
  local BattleBuffMgr = BattleBuffMgr
  local BattleBuffOprType = BattleBuffOprType
  local tonumber = tonumber
  local ParseConfigStr = Util.ParseConfigStr
  if targetCard and buffGroup and newBuff then
    local settleRoundType = newBuff:GetSettleRoundType()
    local deductionRoundType = newBuff:GetDeductionRoundType()
    local atkInfo = BattleAtk.curAtkInfo
    if atkInfo then
      local allBuffTable = atkInfo.allBuffTable
      local buffGroup = split(buffGroup, ";")
      if buffGroup[2] then
        local clearLimit = tonumber(buffGroup[2])
      end
      local buffGroups = split(buffGroup[1], "|")
      for _,oneBuffGroup in ipairs(buffGroups) do
        local clearBuffTable = ParseConfigStr(oneBuffGroup)
        for _,v in ipairs(clearBuffTable) do
          local needBreak = false
          local type = tonumber(v[1])
          local value = (tonumber(v[2]))
          local buffTable = nil
          if type == 1 then
            buffTable = (BattleBuffMgr.GetBuffListByCardAndId)(targetCard, value)
          else
            buffTable = (BattleBuffMgr.GetBuffListByCardAndType)(targetCard, value)
          end
          if buffTable and #buffTable > 0 then
            for _,buff in ipairs(buffTable) do
              buff:SetSettleRoundType(settleRoundType)
              buff:SetDeductionRoundType(deductionRoundType)
              if IsBattleServer == nil then
                PrintTable(buff:GetBuffInfo(atkInfo), "净化删除的buff：")
              end
              ;
              (BattleBuffMgr.RemoveBuffFromList)(buff)
              ;
              (Util.InsertTable)(allBuffTable, {buff = buff:GetBuffInfo(atkInfo, true), type = BattleBuffOprType.DELETE}, true)
              isClear = true
              clearCount = clearCount + 1
              if clearLimit and clearLimit <= clearCount then
                needBreak = true
                break
              end
            end
          end
        end
      end
    end
  end
  do
    if needBreak == true or isClear ~= true then
      return isClear, clearCount
    end
  end
end

-- DECOMPILER ERROR at PC78: Confused about usage of register: R6 in 'UnsetPending'

BattleBuffMgr.SetAllBuffRoundActive = function(state, ...)
  -- function num : 0_20 , upvalues : _ENV, ipairs
  local allBuff = (BattleBuffMgr.GetBuffList)()
  if state == false then
    for _,buff in ipairs(allBuff) do
      buff:SetCurRoundActive(false)
    end
  else
    do
      for _,buff in ipairs(allBuff) do
        if buff:IsCurRoundActive() == true then
          buff:SaveEffectRound()
        end
      end
    end
  end
end


