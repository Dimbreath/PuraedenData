-- params : ...
-- function num : 0 , upvalues : _ENV
BattleResultCount = {}
local self = BattleResultCount
local BattleState = BattleState
local ipairs = ipairs
local tonumber = tonumber
local math = math
local BattleCardCamp = BattleCardCamp
local t_insert = table.insert
local abs = math.abs
-- DECOMPILER ERROR at PC13: Confused about usage of register: R8 in 'UnsetPending'

BattleResultCount.InitResultCount = function(...)
  -- function num : 0_0 , upvalues : self
  self.isBattleWin = false
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R8 in 'UnsetPending'

BattleResultCount.IsWaveOver = function(cardDead, ...)
  -- function num : 0_1 , upvalues : self, _ENV, BattleState
  if (self.IsBattleWin)() == true then
    if cardDead == nil then
      (self.SaveWaveEndCardState)()
      ;
      (self.UpdateWaveBattleWin)(true)
    end
    local callBack = function(...)
    -- function num : 0_1_0 , upvalues : _ENV, self, cardDead, BattleState
    if BattleData.enemyMaxWave <= BattleData.enemyCurWave then
      self.isBattleWin = true
      if cardDead == nil then
        (BattleData.SetBattleState)(BattleState.BATTLE_OVER)
      end
      loge("战斗胜利")
    else
      if cardDead == nil then
        (BattleData.SetBattleState)(BattleState.CHANGE_WAVE)
      end
      loge("本波战斗胜利 达到胜利条件")
    end
  end

    -- DECOMPILER ERROR at PC19: Unhandled construct in 'MakeBoolean' P1

    if IsBattleServer == nil and cardDead == nil then
      local curWave = BattleData.enemyCurWave
      local monsterGroup = (BattleData.GetMonsterGroup)(curWave)
      ;
      (BattleData.SetBattleState)(BattleState.STORY_PLAY)
      OpenPlotPlay(monsterGroup, PlotPlayTriggerType.AFTER_ROUND_END, callBack, BattleData.battleType == (ProtoEnum.E_BATTLE_TYPE).CG)
    end
    callBack()
    -- DECOMPILER ERROR at PC49: Confused about usage of register: R2 in 'UnsetPending'

    if IsBattleServer == nil then
      BattlePlay.AssistCameraMove = false
      ;
      (Util.MoveCameraScreenCenter)()
    end
    return true, BattleData.enemyMaxWave <= BattleData.enemyCurWave
  end
  if (BattleData.IsOneSideDie)() then
    if cardDead == nil then
      (self.SaveWaveEndCardState)()
    end
    if (BattleData.IsSelfSideDie)() == true then
      self.isBattleWin = false
      if cardDead == nil then
        (self.UpdateWaveBattleWin)(false)
        ;
        (BattleData.SetBattleState)(BattleState.BATTLE_OVER)
      else
        -- DECOMPILER ERROR at PC92: Confused about usage of register: R1 in 'UnsetPending'

        if IsBattleServer == nil then
          BattlePlay.AssistCameraMove = false
          ;
          (Util.MoveCameraScreenCenter)()
        end
        return true, true
      end
      loge("战斗失败 己方全部死亡")
    elseif cardDead == nil then
      (self.UpdateWaveBattleWin)(true)
      local callBack = function(...)
    -- function num : 0_1_1 , upvalues : _ENV, BattleState
    (BattleData.SetBattleState)(BattleState.CHANGE_WAVE)
    loge("本波战斗胜利 敌方全部死亡")
  end

      if IsBattleServer == nil then
        local curWave = BattleData.enemyCurWave
        local monsterGroup = (BattleData.GetMonsterGroup)(curWave)
        ;
        (BattleData.SetBattleState)(BattleState.STORY_PLAY)
        OpenPlotPlay(monsterGroup, PlotPlayTriggerType.AFTER_ROUND_END, callBack, BattleData.battleType == (ProtoEnum.E_BATTLE_TYPE).CG)
      else
        callBack()
      end
    end
    -- DECOMPILER ERROR at PC144: Confused about usage of register: R1 in 'UnsetPending'

    if IsBattleServer == nil then
      BattlePlay.AssistCameraMove = false
      ;
      (Util.MoveCameraScreenCenter)()
    end
    return true
  end
  if cardDead == nil and BattleData.maxRound < BattleData.roundIndex then
    (self.SaveWaveEndCardState)()
    ;
    (self.UpdateWaveBattleWin)(false)
    self.isBattleWin = false
    ;
    (BattleData.SetBattleState)(BattleState.BATTLE_OVER)
    loge("战斗失败 超过最大回合数")
    -- DECOMPILER ERROR at PC175: Confused about usage of register: R1 in 'UnsetPending'

    if IsBattleServer == nil then
      BattlePlay.AssistCameraMove = false
      ;
      (Util.MoveCameraScreenCenter)()
    end
    return true
  end
  do return false end
  -- DECOMPILER ERROR: 18 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC19: Confused about usage of register: R8 in 'UnsetPending'

BattleResultCount.SaveWaveEndCardState = function(...)
  -- function num : 0_2 , upvalues : _ENV, ipairs, BattleCardCamp, t_insert
  local curWave = BattleData.enemyCurWave
  local allCard = (BattleData.GetAllCardList)()
  local teamA = (BattleData.allBattleTeamCardState).teamA
  local teamB = (BattleData.allBattleTeamCardState).teamB
  local curTeamA = {}
  curTeamA.waveNum = curWave
  curTeamA.cardState = {}
  local curTeamB = {}
  curTeamB.waveNum = curWave
  curTeamB.cardState = {}
  for i,v in ipairs(allCard) do
    local oneCard = {}
    oneCard.id = v:GetCardId()
    local pos = v:GetPosIndex()
    pos = pos % 100
    if pos > 10 then
      pos = pos - 7
    end
    oneCard.uid = v:GetCardUid()
    oneCard.pos = pos
    oneCard.supHp = v:GetHp()
    oneCard.supDander = v:GetDander()
    if v:GetCampFlag() == BattleCardCamp.LEFT then
      t_insert(curTeamA.cardState, oneCard)
    else
      if v:GetCampFlag() == BattleCardCamp.RIGHT then
        t_insert(curTeamB.cardState, oneCard)
      end
    end
  end
  t_insert(teamA, curTeamA)
  t_insert(teamB, curTeamB)
end

-- DECOMPILER ERROR at PC22: Confused about usage of register: R8 in 'UnsetPending'

BattleResultCount.IsBattleWin = function(...)
  -- function num : 0_3 , upvalues : self, _ENV, tonumber
  local winCondition = (self.GetWinCondition)()
  -- DECOMPILER ERROR at PC9: Unhandled construct in 'MakeBoolean' P1

  if winCondition == nil and (self.IsEnemyAllDead)() == true then
    return true
  end
  -- DECOMPILER ERROR at PC20: Unhandled construct in 'MakeBoolean' P1

  if winCondition == BattleWinConditionType.ENEMY_BEHIND_DEAD and (self.IsEnemyBehindDead)() == true then
    return true
  end
  if (string.sub)(winCondition, 0, 1) == BattleWinConditionType.CARD_HP_PERCENT then
    local stringTable = split(winCondition, ":")
    local cardId = stringTable[2]
    local percent = stringTable[3]
    local action = stringTable[4]
    if cardId and percent then
      local card = (BattleData.GetCardInfoById)(tonumber(cardId))
      if card:GetHp() / card:GetMaxHp() > percent / 10000 then
        do
          local result = not card
          do return result, {action = action, posIndex = card:GetPosIndex()} end
          -- DECOMPILER ERROR: 2 unprocessed JMP targets
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC25: Confused about usage of register: R8 in 'UnsetPending'

BattleResultCount.GetWinCondition = function(...)
  -- function num : 0_4 , upvalues : _ENV
  local battleType = BattleData.battleType
  local stageId = BattleData.stageId
  local winCondition = nil
  if battleType == (ProtoEnum.E_BATTLE_TYPE).EQUIPEXP then
    local stageConfig = ((TableData.gTable).BaseTrialStageData)[stageId]
    if stageConfig then
      winCondition = stageConfig.win_condition
    end
  else
    do
      do
        if battleType == (ProtoEnum.E_BATTLE_TYPE).STORY then
          local stageConfig = ((TableData.gTable).BaseStageData)[stageId]
          if stageConfig then
            winCondition = stageConfig.win_condition
          end
        end
        return winCondition
      end
    end
  end
end

-- DECOMPILER ERROR at PC28: Confused about usage of register: R8 in 'UnsetPending'

BattleResultCount.IsEnemyBehindDead = function(...)
  -- function num : 0_5 , upvalues : _ENV, BattleCardCamp, ipairs
  local aliveCards = (BattleData.GetAliveCards)(BattleCardCamp.RIGHT)
  for _,v in ipairs(aliveCards) do
    if v:GetPosIndex() > 103 then
      return false
    end
  end
  return true
end

-- DECOMPILER ERROR at PC31: Confused about usage of register: R8 in 'UnsetPending'

BattleResultCount.IsEnemyAllDead = function(...)
  -- function num : 0_6 , upvalues : _ENV, BattleCardCamp
  local aliveCards = (BattleData.GetAliveCards)(BattleCardCamp.RIGHT)
  if #aliveCards <= 0 then
    return true
  end
end

-- DECOMPILER ERROR at PC34: Confused about usage of register: R8 in 'UnsetPending'

BattleResultCount.GetRealTotalDamage = function(...)
  -- function num : 0_7 , upvalues : self, _ENV, BattleCardCamp, ipairs
  local totalDamage = 0
  local totalHp = 0
  local winCondition = (self.GetWinCondition)()
  local includeEnemyPos = {[101] = 1, [102] = 1, [103] = 1, [111] = 1, [112] = 1, [113] = 1}
  if winCondition == BattleWinConditionType.ENEMY_BEHIND_DEAD then
    includeEnemyPos = {[111] = 1, [112] = 1, [113] = 1}
  end
  local enemyCardTable = (BattleData.GetCardsByCamp)(BattleCardCamp.RIGHT)
  for _,card in ipairs(enemyCardTable) do
    if includeEnemyPos[card:GetPosIndex()] then
      local curHp = card:GetHp()
      local maxHp = card:GetMaxHp()
      if curHp <= 0 then
        totalDamage = totalDamage + maxHp
      else
        totalDamage = totalDamage + (maxHp - curHp)
      end
      totalHp = totalHp + maxHp
    end
  end
  return totalDamage, totalHp
end

-- DECOMPILER ERROR at PC37: Confused about usage of register: R8 in 'UnsetPending'

BattleResultCount.InitDamageDataTable = function(curDamageTable, selfTeam, enemyTeam, ...)
  -- function num : 0_8 , upvalues : ipairs, _ENV, t_insert
  curDamageTable.SelfCardData = {}
  curDamageTable.EnemyCardData = {}
  curDamageTable.isSelfSuccess = nil
  for _,card in ipairs(selfTeam) do
    local cloneCard = (Util.Copy)(card)
    if cloneCard.posIndex > 3 then
      cloneCard.posIndex = cloneCard.posIndex - 7
    end
    t_insert(curDamageTable.SelfCardData, {CardData = cloneCard, DamageNum = 0, HurtNum = 0})
  end
  for _,card in ipairs(enemyTeam) do
    local cloneCard = (Util.Copy)(card)
    cloneCard.posIndex = cloneCard.posIndex - 100
    if cloneCard.posIndex > 3 then
      cloneCard.posIndex = cloneCard.posIndex - 7
    end
    t_insert(curDamageTable.EnemyCardData, {CardData = cloneCard, DamageNum = 0, HurtNum = 0})
  end
end

-- DECOMPILER ERROR at PC40: Confused about usage of register: R8 in 'UnsetPending'

BattleResultCount.UpdateWaveBattleWin = function(isWin, ...)
  -- function num : 0_9 , upvalues : _ENV
  local curWave = BattleData.enemyCurWave
  local waveDamageDataTable = (BattleData.damageDataTable)[curWave]
  if waveDamageDataTable then
    waveDamageDataTable.isSelfSuccess = isWin
  end
end

-- DECOMPILER ERROR at PC43: Confused about usage of register: R8 in 'UnsetPending'

BattleResultCount.UpdateDamageDataBuff = function(atkCard, defCard, damageNum, ...)
  -- function num : 0_10 , upvalues : _ENV, ipairs, math
  local curWave = BattleData.enemyCurWave
  local waveDamageDataTable = (BattleData.damageDataTable)[curWave]
  if atkCard and defCard and waveDamageDataTable and damageNum then
    local uid = atkCard:GetCardUid()
    local defUid = defCard:GetCardUid()
    for _,v in ipairs(waveDamageDataTable.SelfCardData) do
      if (v.CardData).uid == uid then
        v.DamageNum = (math.ceil)(v.DamageNum + damageNum)
      end
      if (v.CardData).uid == defUid then
        v.HurtNum = (math.ceil)(v.HurtNum + damageNum)
      end
    end
    for _,v in ipairs(waveDamageDataTable.EnemyCardData) do
      if (v.CardData).uid == uid then
        v.DamageNum = (math.ceil)(v.DamageNum + damageNum)
      end
      if (v.CardData).uid == defUid then
        v.HurtNum = (math.ceil)(v.HurtNum + damageNum)
      end
    end
  end
end

-- DECOMPILER ERROR at PC46: Confused about usage of register: R8 in 'UnsetPending'

BattleResultCount.UpdateDamageDataAtk = function(atkInfo, ...)
  -- function num : 0_11 , upvalues : _ENV, ipairs, self, abs
  local atkCard = (BattleData.GetCardInfoByUid)(atkInfo.atkCardUid)
  for _,v in ipairs(atkInfo.defCardsInfo) do
    if v.hpDef < 0 or v.absorbDamage > 0 then
      local defCard = (BattleData.GetCardInfoByUid)(v.defCardUid)
      ;
      (self.UpdateDamageDataBuff)(atkCard, defCard, abs(v.hpDef) + v.absorbDamage)
    end
  end
  for _,v in ipairs(atkInfo.assistAtkInfo) do
    local atkCardUid = v.atkCardUid
    local assistAtkCard = (BattleData.GetCardInfoByUid)(atkCardUid)
    for _,defInfo in ipairs(v.defCardsInfo) do
      if defInfo.hpDef < 0 or defInfo.absorbDamage > 0 then
        local defCard = (BattleData.GetCardInfoByUid)(defInfo.defCardUid)
        ;
        (self.UpdateDamageDataBuff)(assistAtkCard, defCard, abs(defInfo.hpDef) + defInfo.absorbDamage)
      end
    end
  end
end

-- DECOMPILER ERROR at PC49: Confused about usage of register: R8 in 'UnsetPending'

BattleResultCount.GetBattleDamageData = function(...)
  -- function num : 0_12 , upvalues : _ENV
  if not BattleData.damageDataTable then
    return {}
  end
end


