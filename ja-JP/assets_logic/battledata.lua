-- params : ...
-- function num : 0 , upvalues : _ENV
BattleData = {}
local self = BattleData
local PlayType = PlayType
local BattleCardCamp = BattleCardCamp
local ipairs = ipairs
local t_insert = table.insert
local t_remove = table.remove
local tonumber = tonumber
local math = math
-- DECOMPILER ERROR at PC14: Confused about usage of register: R8 in 'UnsetPending'

BattleData.SaveBattleData = function(data, endCallback, needLoad, ...)
  -- function num : 0_0 , upvalues : _ENV, self
  do
    if IsBattleServer == nil and OvertureMgr.isPlaying ~= true then
      local name = (WinResConfig.BattleUIWindow).name
      if UIMgr:IsWindowOpen(name) == true then
        return 
      end
    end
    -- DECOMPILER ERROR at PC22: Confused about usage of register: R3 in 'UnsetPending'

    if not endCallback then
      BattleData.endCallback = BattleData.endCallback
      -- DECOMPILER ERROR at PC28: Confused about usage of register: R3 in 'UnsetPending'

      BattleData.curBattleTime = (os.time)() * 1000
      do
        if IsBattleServer == nil and Game.testPackage ~= true then
          local str = PrintTable(data, "initData")
          ;
          ((CS.FileManager).WriteFile)("BattleInitData/BattleInitData" .. (LuaTime.GetStampStr)(BattleData.curBattleTime) .. ".txt", str)
        end
        self.saveChallengeSummarizeData = data.challengeSummarizeData
        self.receiveAllTeamCardState = data.allTeamCardState
        self.expeditionBattleData = data.expeditionBattleData
        if IsBattleServer == true then
          self.saveClientBattleData = data
        end
        if not data.battleData then
          data = (Util.Copy)(not data or data)
          local battleData = (Util.Copy)(data)
          if not data then
            local testBattleData = {}
          end
          if IsBattleServer == true then
            battleData.battleProcessData = {}
            self.battleData = battleData
          else
            self.battleData = data or testBattleData
          end
          ;
          (self.InitBattleData)(self.battleData)
          if IsBattleServer == true then
            self.saveBattleData = data
          end
          ;
          (BattleConfig.Init)()
          if IsBattleServer == nil then
            if BattleRoot == nil then
              BattleRoot = GameObject()
              if Game.isPad == true then
                (CSLuaUtil.SetGOScale)(BattleRoot, 0.75, 0.75, 1)
              end
              ;
              (((CS.UnityEngine).Object).DontDestroyOnLoad)(BattleRoot)
            end
            -- DECOMPILER ERROR at PC128: Confused about usage of register: R5 in 'UnsetPending'

            BattleRoot.name = "BattleRoot"
          end
          if needLoad ~= true and (IsBattleTest == true or IsBattleServer == true) then
            (BattleData.StartBattle)()
          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC17: Confused about usage of register: R8 in 'UnsetPending'

BattleData.StartBattle = function(...)
  -- function num : 0_1 , upvalues : self, _ENV
  (self.InitWaveInfo)()
  ;
  (self.InitCardData)()
  ;
  (BattleMgr.InitBattle)()
end

-- DECOMPILER ERROR at PC20: Confused about usage of register: R8 in 'UnsetPending'

BattleData.InitBattleData = function(data, ...)
  -- function num : 0_2 , upvalues : self, _ENV
  self.roundIndex = 0
  self.battleUid = data.battleUid
  self.stageId = data.stageId
  self.battleType = data.battleType
  self.atkIndex = 0
  self.allRandomSeedTable = (BattleData.CreateAllRandomSeedTable)(data)
  self.randomSeedTable = (Util.Copy)(self.allRandomSeedTable)
  self.usedRandomSeedTable = {}
  self.autoBattle = data.autoBattle
  self.selfCurWave = 1
  self.enemyCurWave = 1
  self.curWaveBossId = (BattleMgr.GetCurWaveBossId)()
  self.preBattleEvent = (BattleMgr.GetPreBattleEvent)(self.battleType, self.stageId, data)
  if not data.teamInfo or not (BattleData.UpdateTeamInfo)(data.teamInfo) then
    self.teamInfo = {}
    self.selfMaxWave = data.teamInfo and #(data.teamInfo).teamA or 0
    self.enemyMaxWave = data.teamInfo and #(data.teamInfo).teamB or 0
    if not data.teamInfo or not (data.teamInfo).teamAMatrix then
      self.teamAMatrix = {}
      if not data.teamInfo or not (data.teamInfo).teamBMatrix then
        self.teamBMatrix = {}
        if not data.teamInfo or not TalentData or not (TalentData.GetTalentTreeAllAttr)(self.teamAMatrix) then
          self.talentAttrTeamA = {}
          if not data.teamInfo or not TalentData or not (TalentData.GetTalentTreeAllAttr)(self.teamBMatrix) then
            self.talentAttrTeamB = {}
            if not data.teamInfo or not (data.teamInfo).teamAIntimacy then
              self.teamAIntimacy = {}
              if not data.teamInfo or not (data.teamInfo).teamBIntimacy then
                self.teamBIntimacy = {}
                if data.teamInfo then
                  self.intimacyAttrTeamA = (ActorData.GetIntimacyAttrTable)(self.teamAIntimacy)
                  if data.teamInfo then
                    self.intimacyAttrTeamB = (ActorData.GetIntimacyAttrTable)(self.teamBIntimacy)
                    if not data.teamInfo or not (data.teamInfo).teamACardStar then
                      self.teamACardStar = {}
                      if not data.teamInfo or not (data.teamInfo).teamBCardStar then
                        self.teamBCardStar = {}
                        if data.teamInfo then
                          self.cardStarTeamAttrTeamA = (ActorData.GetCardStarTeamAttrTable)(self.teamACardStar)
                          if data.teamInfo then
                            self.cardStarTeamAttrTeamB = (ActorData.GetCardStarTeamAttrTable)(self.teamBCardStar)
                            if not data.teamInfo or not (data.teamInfo).teamAFetter then
                              self.teamAFetter = {}
                              if not data.teamInfo or not (data.teamInfo).teamBFetter then
                                self.teamBFetter = {}
                                if data.teamInfo then
                                  self.fetterTeamAttrTeamA = (ActorData.GetFetterAttrTable)(self.teamAFetter)
                                  if data.teamInfo then
                                    self.fetterTeamAttrTeamB = (ActorData.GetFetterAttrTable)(self.teamBFetter)
                                    self.allCardList = {}
                                    self.allRoundData = {}
                                    self.curRoundData = {}
                                    self.skillAtkList = {}
                                    self.curAtkCard = nil
                                    if data == {} then
                                      self.curBattleState = BattleState.BATTLE_CLOSE
                                    else
                                      self.curBattleState = BattleState.BATTLE_INIT
                                    end
                                    self.damageDataTable = {}
                                    self.allBattleTeamCardState = {
teamA = {}
, 
teamB = {}
}
                                    self.battleProcessData = data.battleProcessData
                                    self.saveBattleData = {}
                                    self.serverBattleData = {}
                                    self.curPreBattleEventInfo = {}
                                    self.saveSkillIndexTable = nil
                                    if data == {} then
                                      self.receiveAllTeamCardState = nil
                                      self.expeditionBattleData = nil
                                      self.saveClientBattleData = {}
                                      self.saveChallengeSummarizeData = {}
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

-- DECOMPILER ERROR at PC23: Confused about usage of register: R8 in 'UnsetPending'

BattleData.UpdateTeamInfo = function(teamInfo, ...)
  -- function num : 0_3 , upvalues : _ENV, ipairs
  local cloneTeamInfo = (Util.Copy)(teamInfo)
  local teamA = cloneTeamInfo.teamA
  for _,team in ipairs(teamA) do
    for _,card in ipairs(team.teamCard) do
      if card.posIndex <= 3 then
        do
          card.posIndex = card.posIndex + 7
          -- DECOMPILER ERROR at PC20: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC20: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  local teamB = cloneTeamInfo.teamB
  for _,team in ipairs(teamB) do
    for _,card in ipairs(team.teamCard) do
      if card.posIndex <= 3 then
        card.posIndex = card.posIndex + 100
      else
        card.posIndex = card.posIndex + 107
      end
    end
  end
  return cloneTeamInfo
end

-- DECOMPILER ERROR at PC26: Confused about usage of register: R8 in 'UnsetPending'

BattleData.CreateAllRandomSeedTable = function(data, ...)
  -- function num : 0_4 , upvalues : ipairs, t_insert
  local allSeedTable = {}
  for index = 1, 5 do
    local serverTable = data["randomSeedTable" .. index]
    if serverTable then
      for _,seed in ipairs(serverTable) do
        t_insert(allSeedTable, seed)
      end
    end
  end
  return allSeedTable
end

-- DECOMPILER ERROR at PC29: Confused about usage of register: R8 in 'UnsetPending'

BattleData.ClearBattleData = function(...)
  -- function num : 0_5 , upvalues : self, ipairs, _ENV
  local allCardList = self.allCardList
  if allCardList then
    for _,v in ipairs(allCardList) do
      v:Destroy()
    end
  end
  do
    self.battleData = {}
    ;
    (BattleData.InitBattleData)({})
  end
end

-- DECOMPILER ERROR at PC32: Confused about usage of register: R8 in 'UnsetPending'

BattleData.InitWaveInfo = function(...)
  -- function num : 0_6 , upvalues : _ENV, self
  (BattleBuffMgr.InitBuffList)()
  ;
  (BattleData.InitSkillAtkListNextWave)()
  local selfCurWave = self.selfCurWave
  local enemyCurWave = self.enemyCurWave
  self.selfTeam = (self.GetTeamInfo)(true, selfCurWave)
  self.enemyTeam = (self.GetTeamInfo)(false, enemyCurWave)
  self.maxRound = (BattleData.GetMaxRound)(enemyCurWave)
  local curWave = selfCurWave + enemyCurWave - 1
  -- DECOMPILER ERROR at PC39: Confused about usage of register: R3 in 'UnsetPending'

  if not (self.battleProcessData)[curWave] then
    (self.battleProcessData)[curWave] = {curWave = curWave, selfCurWave = selfCurWave, enemyCurWave = enemyCurWave, 
roundData = {}
, 
preBattleEventInfo = {}
}
  end
  self.curWave = curWave
  if IsBattleServer == nil then
    (BattleData.SaveBattleProcess)((string.format)("第 %d 波", curWave))
  end
  self.allRoundData = ((self.battleProcessData)[curWave]).roundData
  -- DECOMPILER ERROR at PC58: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self.damageDataTable)[curWave] = {}
  ;
  (BattleResultCount.InitDamageDataTable)((self.damageDataTable)[curWave], self.selfTeam, self.enemyTeam)
end

-- DECOMPILER ERROR at PC35: Confused about usage of register: R8 in 'UnsetPending'

BattleData.GetStageId = function(...)
  -- function num : 0_7 , upvalues : self
  return self.stageId
end

-- DECOMPILER ERROR at PC38: Confused about usage of register: R8 in 'UnsetPending'

BattleData.GetSelfTeam = function(...)
  -- function num : 0_8 , upvalues : _ENV, BattleCardCamp
  return (BattleData.GetTeam)(BattleCardCamp.LEFT)
end

-- DECOMPILER ERROR at PC41: Confused about usage of register: R8 in 'UnsetPending'

BattleData.GetTeam = function(camp, ...)
  -- function num : 0_9 , upvalues : ipairs, self, t_insert, _ENV
  local return_team = {}
  for _,v in ipairs(self.allCardList) do
    if v:GetCampFlag() == camp then
      t_insert(return_team, v)
    end
  end
  ;
  (table.sort)(return_team, function(a, b, ...)
    -- function num : 0_9_0
    do return a:GetPosIndex() < b:GetPosIndex() end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  return return_team
end

-- DECOMPILER ERROR at PC44: Confused about usage of register: R8 in 'UnsetPending'

BattleData.GetTeamInfo = function(isSelf, curWave, ...)
  -- function num : 0_10 , upvalues : self
  local teamInfo = self.teamInfo
  local teamWave = nil
  if isSelf then
    teamWave = teamInfo.teamA
  else
    teamWave = teamInfo.teamB
  end
  if teamWave and (not teamWave[curWave] or teamWave[curWave]) then
    do return (teamWave[curWave]).teamCard, (teamWave[curWave]).monsterGroup end
  end
end

-- DECOMPILER ERROR at PC47: Confused about usage of register: R8 in 'UnsetPending'

BattleData.GetMaxRound = function(curWave, ...)
  -- function num : 0_11 , upvalues : self
  local teamInfo = self.teamInfo
  if teamInfo then
    local teamWave = (teamInfo.teamB)[curWave]
    if teamWave then
      do return teamWave.maxRound end
    end
  end
end

-- DECOMPILER ERROR at PC50: Confused about usage of register: R8 in 'UnsetPending'

BattleData.GetCardInfoByUid = function(uid, ...)
  -- function num : 0_12 , upvalues : self, ipairs
  local cardList = self.allCardList
  for _,v in ipairs(cardList) do
    if v:GetCardUid() == uid then
      return v
    end
  end
end

-- DECOMPILER ERROR at PC53: Confused about usage of register: R8 in 'UnsetPending'

BattleData.GetCardInfoByPos = function(posIndex, ...)
  -- function num : 0_13 , upvalues : self, ipairs
  local cardList = self.allCardList
  for _,v in ipairs(cardList) do
    if v:GetPosIndex() == posIndex then
      return v
    end
  end
end

-- DECOMPILER ERROR at PC56: Confused about usage of register: R8 in 'UnsetPending'

BattleData.GetCardInfoById = function(id, camp, ...)
  -- function num : 0_14 , upvalues : self, ipairs
  local cardList = self.allCardList
  for _,v in ipairs(cardList) do
    if v:GetCardId() == id and (camp == nil or camp == v:GetCampFlag()) then
      return v
    end
  end
end

-- DECOMPILER ERROR at PC59: Confused about usage of register: R8 in 'UnsetPending'

BattleData.GetCardByCampAndId = function(cardId, camp, ...)
  -- function num : 0_15 , upvalues : self, ipairs
  local cardList = self.allCardList
  for _,v in ipairs(cardList) do
    if v:GetCardId() == cardId and v:GetCampFlag() == camp then
      return v
    end
  end
end

-- DECOMPILER ERROR at PC62: Confused about usage of register: R8 in 'UnsetPending'

BattleData.InitCardData = function(isNextWave, ...)
  -- function num : 0_16 , upvalues : self, BattleCardCamp, t_remove, ipairs, t_insert, _ENV
  if isNextWave == true then
    for i = #self.allCardList, 1, -1 do
      local card = (self.allCardList)[i]
      if card then
        if card:GetCampFlag() == BattleCardCamp.RIGHT then
          t_remove(self.allCardList, i)
          card:Destroy()
        else
          if card:GetCampFlag() == BattleCardCamp.LEFT then
            card:ClearChangeWave()
          end
        end
      end
    end
  else
    do
      self.allCardList = {}
      local selfTeam = self.selfTeam
      local enemyTeam = self.enemyTeam
      if isNextWave == nil then
        for _,v in ipairs(selfTeam) do
          t_insert(self.allCardList, (BattleCard.Initial)(v))
        end
      end
      do
        for _,v in ipairs(enemyTeam) do
          t_insert(self.allCardList, (BattleCard.Initial)(v))
        end
        if isNextWave == nil then
          (BattleData.SaveCardInitDataFile)()
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC65: Confused about usage of register: R8 in 'UnsetPending'

BattleData.AddSummonCardData = function(monsterId, posIndex, ...)
  -- function num : 0_17 , upvalues : _ENV, ipairs, self, t_insert
  if monsterId == nil or posIndex == nil then
    return 
  end
  local mosterConfig = (TableData.GetBaseMonsterData)(monsterId)
  local cardData = {uid = "SummonCard" .. monsterId .. BattleData.atkIndex .. posIndex, posIndex = posIndex, 
cardInfo = {id = monsterId, fashionId = mosterConfig.unlock_fashion_id, 
skillInfo = {}
}
}
  local card = (BattleCard.Initial)(cardData)
  card:SetIsSummoned(true)
  card:SetIsAlreadyAtk(true, false)
  for i,v in ipairs(self.allCardList) do
    -- DECOMPILER ERROR at PC45: Confused about usage of register: R10 in 'UnsetPending'

    if v:GetPosIndex() == posIndex then
      (self.allCardList)[i] = card
      return 
    end
  end
  t_insert(self.allCardList, card)
end

-- DECOMPILER ERROR at PC68: Confused about usage of register: R8 in 'UnsetPending'

BattleData.SaveBattleProcess = function(str, ...)
  -- function num : 0_18 , upvalues : _ENV
  if IsBattleServer == nil and Game.testPackage ~= true then
    local time = (LuaTime.GetStampStr)(BattleData.curBattleTime)
    ;
    ((CS.FileManager).WriteFile)("BattleProcessData/BattleProcessData" .. time .. ".txt", tostring(str) .. "\n")
  end
end

-- DECOMPILER ERROR at PC71: Confused about usage of register: R8 in 'UnsetPending'

BattleData.SaveCardInitDataFile = function(...)
  -- function num : 0_19 , upvalues : _ENV, self, ipairs
  if IsBattleServer == nil and Game.testPackage ~= true then
    local allCardList = self.allCardList
    local str = ""
    for i,v in ipairs(allCardList) do
      str = str .. "位置 ：" .. v:GetPosIndex() .. "\n" .. PrintTable(v:GetAttributeLog(), "卡片数据 ：") .. "\n\n"
    end
    ;
    ((CS.FileManager).WriteFile)("BattleInitCardData/BattleInitCardData" .. (LuaTime.GetStampStr)(BattleData.curBattleTime) .. ".txt", str)
  end
end

-- DECOMPILER ERROR at PC74: Confused about usage of register: R8 in 'UnsetPending'

BattleData.AddCardInBattle = function(monsterId, ...)
  -- function num : 0_20 , upvalues : _ENV, t_insert, self
  local monsterConfig = (TableData.GetBaseMonsterData)(monsterId)
  if monsterConfig then
    local card = {}
    t_insert(self.allCardList, (BattleCard.Initial)(card))
  end
end

-- DECOMPILER ERROR at PC77: Confused about usage of register: R8 in 'UnsetPending'

BattleData.AddAutoSkill = function(...)
  -- function num : 0_21 , upvalues : _ENV, self, ipairs, BattleCardCamp
  if IsBattleServer == true then
    if self.saveBattleData and (self.saveBattleData).battleProcessData and #(self.saveBattleData).battleProcessData > 0 then
      local atkCardUid = (BattleData.GetSkillCardFromBattleData)()
      if atkCardUid then
        local card = (BattleData.GetCardInfoByUid)(atkCardUid)
        if card:IsDisplayAlive() and card:GetMaxDander() <= card:GetDander() and (BattleBuff.IsForbiddenSkill)(card) ~= true then
          local result = (self.AddSkillAtk)(card)
          if result == true then
            return 
          end
        end
      end
    else
      do
        local liveCards = (self.GetAliveCards)()
        for _,v in ipairs(liveCards) do
          if v:IsDisplayAlive() and v:GetMaxDander() <= v:GetDander() and (BattleBuff.IsForbiddenSkill)(v) ~= true then
            local result = (self.AddSkillAtk)(v)
            if result == true then
              return 
            end
          end
        end
        do
          do return  end
          local liveCards = (self.GetAliveCards)()
          for _,v in ipairs(liveCards) do
            if ((v:GetCampFlag() == BattleCardCamp.LEFT and BattleConfig.autoBattle == true) or v:GetCampFlag() == BattleCardCamp.RIGHT) and (BattleBuff.IsForbiddenSkill)(v) ~= true and v:IsDisplayAlive() and v:GetMaxDander() <= v:GetDander() then
              local success = (self.AddSkillAtk)(v)
              if BattleConfig.autoBattle == true and success == true then
                UIMgr:SendWindowMessage("BattleUIWindow", (WindowMsgEnum.BattleUIWindow).E_MSG_PLAY_SKILL_EFFECT, v)
                return 
              end
            end
          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC80: Confused about usage of register: R8 in 'UnsetPending'

BattleData.GetSkillCardFromBattleData = function(...)
  -- function num : 0_22 , upvalues : _ENV, self, ipairs
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  if BattleData.saveSkillIndexTable == nil then
    BattleData.saveSkillIndexTable = {}
    local battleData = self.saveBattleData
    if battleData then
      for _,waveData in ipairs(battleData.battleProcessData) do
        local curWave = waveData.curWave
        -- DECOMPILER ERROR at PC18: Confused about usage of register: R7 in 'UnsetPending'

        ;
        (BattleData.saveSkillIndexTable)[curWave] = {}
        local roundData = waveData.roundData
        for _,roundInfo in ipairs(roundData) do
          local attackInfo = roundInfo.attackInfo
          for _,oneAttackInfo in ipairs(attackInfo) do
            -- DECOMPILER ERROR at PC39: Confused about usage of register: R19 in 'UnsetPending'

            if oneAttackInfo.skillType == BattleSkillType.SKILL then
              ((BattleData.saveSkillIndexTable)[curWave])[oneAttackInfo.atkIndex] = oneAttackInfo.atkCardUid
            end
          end
        end
      end
    end
  end
  do
    local atkIndex = self.atkIndex
    local curWave = self.enemyCurWave
    if (BattleData.saveSkillIndexTable)[curWave] then
      local cardUid = ((BattleData.saveSkillIndexTable)[curWave])[atkIndex + 1]
      return cardUid
    end
  end
end

-- DECOMPILER ERROR at PC83: Confused about usage of register: R8 in 'UnsetPending'

BattleData.InitSkillAtkListNextWave = function(...)
  -- function num : 0_23 , upvalues : self, BattleCardCamp, t_remove
  if self.skillAtkList then
    for i = #self.skillAtkList, 1, -1 do
      local skillUnit = (self.skillAtkList)[i]
      if skillUnit and skillUnit.campFlag == BattleCardCamp.RIGHT then
        t_remove(self.skillAtkList, i)
      end
    end
  end
end

-- DECOMPILER ERROR at PC86: Confused about usage of register: R8 in 'UnsetPending'

BattleData.AddSkillAtk = function(battleCard, ...)
  -- function num : 0_24 , upvalues : self, ipairs, BattleCardCamp, _ENV, t_insert
  local maxCount = 1
  local skillAtkList = self.skillAtkList
  local leftCount = 0
  local rightCount = 0
  for _,v in ipairs(skillAtkList) do
    if v.campFlag == BattleCardCamp.LEFT then
      leftCount = leftCount + 1
    else
      if v.campFlag == BattleCardCamp.RIGHT then
        rightCount = rightCount + 1
      end
    end
  end
  local curCampFlag = battleCard:GetCampFlag()
  -- DECOMPILER ERROR at PC28: Unhandled construct in 'MakeBoolean' P1

  if curCampFlag == BattleCardCamp.LEFT and maxCount <= leftCount then
    return 
  end
  if curCampFlag == BattleCardCamp.RIGHT and maxCount <= rightCount then
    return 
  end
  if IsBattleServer == nil then
    print("当前释放技能： 位置：", battleCard:GetPosIndex())
  end
  local skillConfig = battleCard:GetSkillConfig()
  if skillConfig then
    if curCampFlag == BattleCardCamp.LEFT then
      t_insert(self.skillAtkList, {campFlag = BattleCardCamp.LEFT, cardUid = battleCard:GetCardUid(), skillConfig = skillConfig})
    else
      if curCampFlag == BattleCardCamp.RIGHT then
        t_insert(self.skillAtkList, 1, {campFlag = BattleCardCamp.RIGHT, cardUid = battleCard:GetCardUid(), skillConfig = skillConfig})
      end
    end
  end
  return true
end

-- DECOMPILER ERROR at PC89: Confused about usage of register: R8 in 'UnsetPending'

BattleData.GetCurSkillAtk = function(...)
  -- function num : 0_25 , upvalues : self, _ENV, BattleCardCamp, math
  for i = #self.skillAtkList, 1, -1 do
    local curSkill = (self.skillAtkList)[i]
    if curSkill then
      local cardUid = curSkill.cardUid
      local battleCard = (self.GetCardInfoByUid)(cardUid)
      local dander = battleCard:GetDander()
      local maxDander = battleCard:GetMaxDander()
      if battleCard:IsDisplayAlive() and maxDander <= dander and (BattleBuff.IsForbiddenSkill)(battleCard) ~= true then
        local curDander = dander - maxDander
        ;
        (self.RemoveCurSkillAtk)()
        do
          do
            if IsBattleServer == nil and battleCard:GetCampFlag() == BattleCardCamp.LEFT then
              local value = curDander / maxDander
              UIMgr:SendWindowMessage("BattleUIWindow", (WindowMsgEnum.BattleUIWindow).E_MSG_UPDATE_CARD_DANDER, {posIndex = battleCard:GetPosIndex(), targetValue = value, removeFullRage = true})
            end
            do return curSkill end
            do
              do
                if IsBattleServer == nil and battleCard:GetCampFlag() == BattleCardCamp.LEFT then
                  local value = (math.min)(100 * dander / maxDander, 100)
                  UIMgr:SendWindowMessage("BattleUIWindow", (WindowMsgEnum.BattleUIWindow).E_MSG_UPDATE_CARD_DANDER, {posIndex = battleCard:GetPosIndex(), targetValue = value, removeFullRage = true})
                end
                ;
                (BattleData.RemoveCurSkillAtk)(i)
                -- DECOMPILER ERROR at PC86: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC86: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC86: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC86: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC86: LeaveBlock: unexpected jumping out IF_STMT

                -- DECOMPILER ERROR at PC86: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC86: LeaveBlock: unexpected jumping out IF_STMT

              end
            end
          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC92: Confused about usage of register: R8 in 'UnsetPending'

BattleData.RemoveCurSkillAtk = function(index, ...)
  -- function num : 0_26 , upvalues : self, t_remove
  local skillAtkList = self.skillAtkList
  if skillAtkList and not index then
    t_remove(skillAtkList, #skillAtkList)
  end
end

-- DECOMPILER ERROR at PC95: Confused about usage of register: R8 in 'UnsetPending'

BattleData.GetAllCardList = function(...)
  -- function num : 0_27 , upvalues : self
  return self.allCardList
end

-- DECOMPILER ERROR at PC98: Confused about usage of register: R8 in 'UnsetPending'

BattleData.GetAliveCards = function(camp, ...)
  -- function num : 0_28 , upvalues : self, ipairs, t_insert
  local liveCards = {}
  local allCardList = self.allCardList
  for _,v in ipairs(allCardList) do
    -- DECOMPILER ERROR at PC19: Unhandled construct in 'MakeBoolean' P1

    if v:GetHp() > 0 and camp and v:GetCampFlag() == camp then
      t_insert(liveCards, v)
    end
    t_insert(liveCards, v)
  end
  return liveCards
end

-- DECOMPILER ERROR at PC101: Confused about usage of register: R8 in 'UnsetPending'

BattleData.GetDisplayAliveCards = function(camp, ...)
  -- function num : 0_29 , upvalues : self, ipairs, t_insert
  local liveCards = {}
  local allCardList = self.allCardList
  for _,v in ipairs(allCardList) do
    -- DECOMPILER ERROR at PC19: Unhandled construct in 'MakeBoolean' P1

    if v:IsDisplayAlive() == true and camp and v:GetCampFlag() == camp then
      t_insert(liveCards, v)
    end
    t_insert(liveCards, v)
  end
  return liveCards
end

-- DECOMPILER ERROR at PC104: Confused about usage of register: R8 in 'UnsetPending'

BattleData.GetWaitAtkCards = function(...)
  -- function num : 0_30 , upvalues : self, ipairs, t_insert
  local waitAtkCards = {}
  local allCardList = self:GetAllCardList()
  for _,v in ipairs(allCardList) do
    if v:GetHp() > 0 and v:GetIsReadyAtk() == false then
      t_insert(waitAtkCards, v)
    end
  end
  return waitAtkCards
end

-- DECOMPILER ERROR at PC107: Confused about usage of register: R8 in 'UnsetPending'

BattleData.GetCardsByCamp = function(camp, ...)
  -- function num : 0_31 , upvalues : self, ipairs, t_insert
  local allCards = self:GetAllCardList()
  local cards = {}
  for _,v in ipairs(allCards) do
    if v:GetCampFlag() == camp then
      t_insert(cards, v)
    end
  end
  return cards
end

-- DECOMPILER ERROR at PC110: Confused about usage of register: R8 in 'UnsetPending'

BattleData.IsOneSideDie = function(...)
  -- function num : 0_32 , upvalues : self, ipairs, BattleCardCamp
  local allCardList = self:GetAllCardList()
  local selfDie = true
  local enemyDie = true
  for _,v in ipairs(allCardList) do
    if v:GetHp() > 0 then
      if v:GetCampFlag() == BattleCardCamp.LEFT then
        selfDie = false
      else
        if v:GetCampFlag() == BattleCardCamp.RIGHT then
          enemyDie = false
        end
      end
    end
    if selfDie == false and enemyDie == false then
      return false
    end
  end
  return true
end

-- DECOMPILER ERROR at PC113: Confused about usage of register: R8 in 'UnsetPending'

BattleData.IsSelfSideDie = function(...)
  -- function num : 0_33 , upvalues : self, ipairs, BattleCardCamp
  local allCardList = self:GetAllCardList()
  local selfDie = true
  for _,v in ipairs(allCardList) do
    if v:GetHp() > 0 and v:GetCampFlag() == BattleCardCamp.LEFT then
      selfDie = false
    end
    if selfDie == false then
      return false
    end
  end
  return true
end

-- DECOMPILER ERROR at PC116: Confused about usage of register: R8 in 'UnsetPending'

BattleData.GetOrderCard = function(...)
  -- function num : 0_34 , upvalues : self, _ENV
  local cardList = (self.GetWaitAtkCards)()
  ;
  (table.sort)(cardList, BattleData.AtkOrderSort)
  return cardList
end

-- DECOMPILER ERROR at PC119: Confused about usage of register: R8 in 'UnsetPending'

BattleData.AtkOrderSort = function(a, b, ...)
  -- function num : 0_35
  if b:GetSpd() >= a:GetSpd() then
    do return a:GetSpd() == b:GetSpd() end
    if b:GetCampFlag() >= a:GetCampFlag() then
      do return a:GetCampFlag() == b:GetCampFlag() end
      do return a:GetPosIndex() < b:GetPosIndex() end
      -- DECOMPILER ERROR: 6 unprocessed JMP targets
    end
  end
end

-- DECOMPILER ERROR at PC122: Confused about usage of register: R8 in 'UnsetPending'

BattleData.GetCampByPosIndex = function(posIndex, ...)
  -- function num : 0_36 , upvalues : BattleCardCamp
  if posIndex < 100 then
    return BattleCardCamp.LEFT
  else
    return BattleCardCamp.RIGHT
  end
end

-- DECOMPILER ERROR at PC125: Confused about usage of register: R8 in 'UnsetPending'

BattleData.IsCurAtkCard = function(card, ...)
  -- function num : 0_37 , upvalues : _ENV
  local curCard = (BattleData.GetCurAtkCard)()
  if card:GetPosIndex() ~= curCard:GetPosIndex() then
    do return not curCard or not card end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

-- DECOMPILER ERROR at PC128: Confused about usage of register: R8 in 'UnsetPending'

BattleData.GetCurAtkCard = function(...)
  -- function num : 0_38 , upvalues : self, ipairs
  local allCardList = self.allCardList
  local curAtkCard = nil
  if allCardList then
    for _,v in ipairs(allCardList) do
      if v:GetHp() > 0 and v:GetIsReadyAtk() ~= true then
        if not curAtkCard then
          curAtkCard = v
        else
          if curAtkCard:GetSpd() < v:GetSpd() then
            curAtkCard = v
          else
            if v:GetSpd() == curAtkCard:GetSpd() then
              if curAtkCard:GetCampFlag() < v:GetCampFlag() then
                curAtkCard = v
              else
                if v:GetCampFlag() == curAtkCard:GetCampFlag() and v:GetPosIndex() < curAtkCard:GetPosIndex() then
                  curAtkCard = v
                end
              end
            end
          end
        end
      end
    end
  end
  do
    return curAtkCard
  end
end

-- DECOMPILER ERROR at PC131: Confused about usage of register: R8 in 'UnsetPending'

BattleData.GetCampDeadCount = function(camp, ...)
  -- function num : 0_39 , upvalues : self, ipairs
  local count = 0
  local allCardList = self.allCardList
  for i,card in ipairs(allCardList) do
    -- DECOMPILER ERROR at PC16: Unhandled construct in 'MakeBoolean' P1

    if card:GetHp() <= 0 and camp and camp == card:GetCampFlag() then
      count = count + 1
    end
    count = count + 1
  end
  return count
end

-- DECOMPILER ERROR at PC134: Confused about usage of register: R8 in 'UnsetPending'

BattleData.ClearAtkFlag = function(...)
  -- function num : 0_40 , upvalues : _ENV, self, ipairs
  loge("清除出手状态")
  local allCardList = self.allCardList
  if allCardList then
    for _,v in ipairs(allCardList) do
      v:ResetAtkFlag()
    end
  end
end

local random = math.random
-- DECOMPILER ERROR at PC138: Confused about usage of register: R9 in 'UnsetPending'

BattleData.GetRandomSeed = function(...)
  -- function num : 0_41 , upvalues : _ENV, random, self, t_remove, t_insert
  if IsBattleTest == true then
    return random(10000)
  end
  if self.randomSeedTable then
    local seed = (self.randomSeedTable)[1]
    t_remove(self.randomSeedTable, 1)
    t_insert(self.usedRandomSeedTable, seed)
    if #self.randomSeedTable <= 0 then
      self.randomSeedTable = (Util.Copy)(self.allRandomSeedTable)
    end
    return seed
  end
end

-- DECOMPILER ERROR at PC141: Confused about usage of register: R9 in 'UnsetPending'

BattleData.SetBattleState = function(curBattleState, ...)
  -- function num : 0_42 , upvalues : _ENV, self
  if IsBattleServer == true then
    (BattleMgr.PlayBattleState)(curBattleState)
  else
    self.curBattleState = curBattleState
  end
end

-- DECOMPILER ERROR at PC144: Confused about usage of register: R9 in 'UnsetPending'

BattleData.GetBattleState = function(...)
  -- function num : 0_43 , upvalues : self
  return self.curBattleState
end

-- DECOMPILER ERROR at PC147: Confused about usage of register: R9 in 'UnsetPending'

BattleData.GetMonsterList = function(wave, stageId, battleType, ...)
  -- function num : 0_44 , upvalues : _ENV, tonumber
  local list = {}
  local monsterGroup = (BattleData.GetMonsterGroup)(wave or 1, stageId, battleType)
  if monsterGroup then
    local config = ((TableData.gTable).BaseMonsterGroupData)[monsterGroup]
    local monsters = split(config.monster_list, ":")
    for i = 1, 6 do
      if tonumber(monsters[i]) == 0 then
        list[i] = nil
      else
        list[i] = tonumber(monsters[i])
      end
    end
  end
  do
    return list
  end
end

-- DECOMPILER ERROR at PC150: Confused about usage of register: R9 in 'UnsetPending'

BattleData.GetEmbattleType = function(playType, ...)
  -- function num : 0_45 , upvalues : _ENV, PlayType
  local E_EMBATTLE_TYPE = ProtoEnum.E_EMBATTLE_TYPE
  if playType == PlayType.CoinDungeon then
    return E_EMBATTLE_TYPE.EMBATTLE_GOLD
  else
    if playType == PlayType.RoleExpDungeon then
      return E_EMBATTLE_TYPE.EMBATTLE_EXP
    else
      if playType == PlayType.EquipmentExpDungeon then
        return E_EMBATTLE_TYPE.EMBATTLE_EQUIPEXP
      end
    end
  end
end

-- DECOMPILER ERROR at PC153: Confused about usage of register: R9 in 'UnsetPending'

BattleData.GetPlayTypeByEmbattleType = function(embattleType, ...)
  -- function num : 0_46 , upvalues : _ENV, PlayType
  local E_EMBATTLE_TYPE = ProtoEnum.E_EMBATTLE_TYPE
  if embattleType == E_EMBATTLE_TYPE.EMBATTLE_GOLD then
    return PlayType.CoinDungeon
  else
    if embattleType == E_EMBATTLE_TYPE.EMBATTLE_EXP then
      return PlayType.RoleExpDungeon
    else
      if embattleType == E_EMBATTLE_TYPE.EMBATTLE_EQUIPEXP then
        return PlayType.EquipmentExpDungeon
      end
    end
  end
end

-- DECOMPILER ERROR at PC156: Confused about usage of register: R9 in 'UnsetPending'

BattleData.GetPlayTypeByBattleType = function(battleType, ...)
  -- function num : 0_47 , upvalues : _ENV, PlayType
  local E_BATTLE_TYPE = ProtoEnum.E_BATTLE_TYPE
  if battleType == E_BATTLE_TYPE.STORY then
    return PlayType.PlotDungeon
  else
    if battleType == E_BATTLE_TYPE.HERO then
      return PlayType.HeroDungeon
    else
      if battleType == E_BATTLE_TYPE.EXP then
        return PlayType.RoleExpDungeon
      else
        if battleType == E_BATTLE_TYPE.EQUIPEXP then
          return PlayType.EquipmentExpDungeon
        else
          if battleType == E_BATTLE_TYPE.GOLD then
            return PlayType.CoinDungeon
          else
            if battleType == E_BATTLE_TYPE.ARENA then
              return PlayType.Arena
            else
              if battleType == E_BATTLE_TYPE.TOWER then
                return PlayType.Tower
              else
                if battleType == E_BATTLE_TYPE.TOWER_ENCOUNTER then
                  return PlayType.Tower
                else
                  if battleType == E_BATTLE_TYPE.EXPEDITION then
                    return PlayType.Expedition
                  else
                    if battleType == E_BATTLE_TYPE.ADVENTURE then
                      return PlayType.Adventure
                    else
                      if battleType == E_BATTLE_TYPE.CG then
                        return PlayType.CG
                      else
                        if battleType == E_BATTLE_TYPE.ACTIVITY then
                          return PlayType.ACTIVITY
                        else
                          if battleType == E_BATTLE_TYPE.GUILD_PK then
                            return PlayType.Guild
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

-- DECOMPILER ERROR at PC159: Confused about usage of register: R9 in 'UnsetPending'

BattleData.GetBattleTypeByPlayType = function(playType, ...)
  -- function num : 0_48 , upvalues : _ENV, PlayType
  local E_BATTLE_TYPE = ProtoEnum.E_BATTLE_TYPE
  if playType == PlayType.PlotDungeon then
    return E_BATTLE_TYPE.STORY
  else
    if playType == PlayType.HeroDungeon then
      return E_BATTLE_TYPE.HERO
    else
      if playType == PlayType.RoleExpDungeon then
        return E_BATTLE_TYPE.EXP
      else
        if playType == PlayType.EquipmentExpDungeon then
          return E_BATTLE_TYPE.EQUIPEXP
        else
          if playType == PlayType.CoinDungeon then
            return E_BATTLE_TYPE.GOLD
          else
            if playType == PlayType.Arena then
              return E_BATTLE_TYPE.ARENA
            else
              if playType == PlayType.Tower then
                return E_BATTLE_TYPE.TOWER
              else
                if playType == PlayType.Expedition then
                  return E_BATTLE_TYPE.EXPEDITION
                else
                  if playType == PlayType.Adventure then
                    return E_BATTLE_TYPE.ADVENTURE
                  else
                    if playType == PlayType.CG then
                      return E_BATTLE_TYPE.CG
                    else
                      if playType == PlayType.ACTIVITY then
                        return E_BATTLE_TYPE.ACTIVITY
                      else
                        if playType == PlayType.Guild then
                          return E_BATTLE_TYPE.GUILD_PK
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

-- DECOMPILER ERROR at PC162: Confused about usage of register: R9 in 'UnsetPending'

BattleData.GetMonsterGroup = function(wave, stageId, battleType, ...)
  -- function num : 0_49 , upvalues : self, _ENV, tonumber
  local battleType = battleType or self.battleType
  local stageId = stageId or self.stageId
  local E_BATTLE_TYPE = ProtoEnum.E_BATTLE_TYPE
  if battleType == E_BATTLE_TYPE.STORY or battleType == E_BATTLE_TYPE.HERO or battleType == E_BATTLE_TYPE.ACTIVITY then
    local stageConfig = ((TableData.gTable).BaseStageData)[stageId]
    if stageConfig then
      local monster_group_list = split(stageConfig.monster_group_list, ":")
      if monster_group_list then
        local monsterGroup = monster_group_list[wave]
        if monsterGroup then
          return tonumber(monsterGroup)
        end
      end
    end
  else
    do
      if battleType == E_BATTLE_TYPE.GOLD or battleType == E_BATTLE_TYPE.EXP or battleType == E_BATTLE_TYPE.EQUIPEXP then
        local stageConfig = ((TableData.gTable).BaseTrialStageData)[stageId]
        if stageConfig then
          local monster_group_list = split(stageConfig.monster_group_list, ":")
          if monster_group_list then
            local monsterGroup = monster_group_list[wave]
            if monsterGroup then
              return tonumber(monsterGroup)
            end
          end
        end
      else
        do
          if battleType == E_BATTLE_TYPE.TOWER then
            local stageConfig = ((TableData.gTable).BaseTowerStageData)[stageId]
            if stageConfig then
              local monster_group_list = split(stageConfig.monster_group_list, ":")
              if monster_group_list then
                local monsterGroup = monster_group_list[wave]
                if monsterGroup then
                  return tonumber(monsterGroup)
                end
              end
            end
          else
            do
              if battleType == E_BATTLE_TYPE.CG then
                local stageConfig = ((TableData.gTable).BaseHandbookStageData)[stageId]
                if stageConfig then
                  local monster_group_list = split(stageConfig.monster_group_list, ":")
                  if monster_group_list then
                    local monsterGroup = monster_group_list[wave]
                    if monsterGroup then
                      return tonumber(monsterGroup)
                    end
                  end
                end
              else
                do
                  if battleType == E_BATTLE_TYPE.EXPEDITION then
                    if self.monsterGroup and self.monsterGroup ~= 0 then
                      return self.monsterGroup
                    end
                    local stageConfig = ((TableData.gTable).BaseExpeditionStageData)[stageId]
                    if stageConfig then
                      local monster_group_list = split(stageConfig.monster_group_list, ":")
                      if monster_group_list then
                        local monsterGroup = monster_group_list[wave]
                        if monsterGroup then
                          return tonumber(monsterGroup)
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

-- DECOMPILER ERROR at PC165: Confused about usage of register: R9 in 'UnsetPending'

BattleData.GetBattleMapAndBGM = function(stageId, battleType, curWave, ...)
  -- function num : 0_50 , upvalues : self, _ENV
  if not battleType then
    battleType = self.battleType
  end
  if ExpeditionMgr and battleType == (ProtoEnum.E_BATTLE_TYPE).EXPEDITION then
    local mapId = (ExpeditionMgr.GetCurrentExpeditionId)()
    local config = ((TableData.gTable).BaseExpeditionData)[mapId]
    if config then
      return config.background_path, config.bgm_id
    end
  else
    do
      if battleType == (ProtoEnum.E_BATTLE_TYPE).ADVENTURE then
        return (AdventureData.GetBattleBg)(), (AdventureData.GetBattleBGM)()
      else
        if battleType == (ProtoEnum.E_BATTLE_TYPE).TOWER_ENCOUNTER then
          return (TowerData.GetCurrentTowerBGAndBGM)()
        end
      end
      if not curWave then
        local monsterGroup = (BattleData.GetMonsterGroup)(BattleData.enemyCurWave, stageId, battleType)
        local monsterGroupConfig = ((TableData.gTable).BaseMonsterGroupData)[monsterGroup]
        if monsterGroupConfig then
          return monsterGroupConfig.background_path, monsterGroupConfig.bgm_id
        else
          local playType = (BattleData.GetPlayTypeByBattleType)(battleType)
          local playConfig = (TableData.GetBasePlayConfigByType)(playType)
          if playConfig then
            return playConfig.background_path, playConfig.bgm_id
          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC168: Confused about usage of register: R9 in 'UnsetPending'

BattleData.GetChallengeType = function(battleType, ...)
  -- function num : 0_51 , upvalues : _ENV
  local E_BATTLE_TYPE = ProtoEnum.E_BATTLE_TYPE
  local E_CHALLENGE_TYPE = ProtoEnum.E_CHALLENGE_TYPE
  if battleType == E_BATTLE_TYPE.STORY then
    return E_CHALLENGE_TYPE.STORE_CHALLENGE
  else
    if battleType == E_BATTLE_TYPE.HERO then
      return E_CHALLENGE_TYPE.ELITE_CHALLENGE
    else
      if battleType == E_BATTLE_TYPE.GOLD then
        return E_CHALLENGE_TYPE.GOLD_CHALLENGE
      else
        if battleType == E_BATTLE_TYPE.EXP then
          return E_CHALLENGE_TYPE.EXP_CHALLENGE
        else
          if battleType == E_BATTLE_TYPE.EQUIPEXP then
            return E_CHALLENGE_TYPE.EQUIPEXP_CHALLENGE
          else
            if battleType == E_BATTLE_TYPE.ARENA then
              return E_CHALLENGE_TYPE.ARENA_CHALLENGE
            else
              if battleType == E_BATTLE_TYPE.TOWER then
                return E_CHALLENGE_TYPE.TOWER_CHALLENGE
              else
                if battleType == E_BATTLE_TYPE.EXPEDITION then
                  return E_CHALLENGE_TYPE.EXPEDITION_CHALLENGE
                else
                  if battleType == E_BATTLE_TYPE.CG then
                    return E_CHALLENGE_TYPE.CG_CHALLENGE
                  else
                    if battleType == E_BATTLE_TYPE.ADVENTURE then
                      return E_CHALLENGE_TYPE.ADVENTURE_CHALLENGE
                    else
                      if battleType == E_BATTLE_TYPE.GUILD_PK then
                        return E_CHALLENGE_TYPE.GUILD_PK_CHALLENGE
                      else
                        if battleType == E_BATTLE_TYPE.ACTIVITY then
                          return E_CHALLENGE_TYPE.ACTIVITY_CHALLENGE
                        else
                          if battleType == E_BATTLE_TYPE.TOWER_ENCOUNTER then
                            return E_CHALLENGE_TYPE.ENCOUNTER_CHALLENGE
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


