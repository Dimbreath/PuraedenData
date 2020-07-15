-- params : ...
-- function num : 0 , upvalues : _ENV
BattlePlay = {}
local self = BattlePlay
local UIMgr = UIMgr
local BattleState = BattleState
local BattleCardState = BattleCardState
local BattleConfig = BattleConfig
local BattleCardCamp = BattleCardCamp
local Vector3 = CSLuaUtil and CSLuaUtil.Vector3 or Vector3
local BattleBuffDeductionRoundType = BattleBuffDeductionRoundType
local BattleBuffSettleRoundType = BattleBuffSettleRoundType
local BattleCardFloatUpState = BattleCardFloatUpState
local BattleAttackType = BattleAttackType
local ipairs = ipairs
local math = math
-- DECOMPILER ERROR at PC24: Confused about usage of register: R13 in 'UnsetPending'

BattlePlay.CreateAllCard = function(...)
  -- function num : 0_0 , upvalues : _ENV, ipairs, self
  local cardList = (BattleData.GetAliveCards)()
  for _,card in ipairs(cardList) do
    if card:GetModel() == nil then
      card:CreateCard()
    end
  end
  ;
  (self.PlayAtkOrderShow)()
end

-- DECOMPILER ERROR at PC27: Confused about usage of register: R13 in 'UnsetPending'

BattlePlay.CreateCardInBattle = function(summonCard, ...)
  -- function num : 0_1 , upvalues : _ENV
  if summonCard then
    local pos = summonCard.value
    local card = (BattleData.GetCardInfoByPos)(pos)
    if card and card:GetModel() == nil then
      card:CreateCard()
    end
  end
end

-- DECOMPILER ERROR at PC30: Confused about usage of register: R13 in 'UnsetPending'

BattlePlay.ShowCardEnter = function(isChangeWave, ...)
  -- function num : 0_2 , upvalues : _ENV, BattleCardCamp, BattleConfig, Vector3, ipairs, math, BattleCardState
  local allCardList = (BattleData.GetAliveCards)(BattleCardCamp.LEFT)
  local moveTime = BattleConfig.nextWaveCardMoveTime
  local move = BattleConfig.nextWaveCardMoveX
  local battleCamera = Game.battleCamera
  local ShakeAnimPlay = require("ShakeAnimPlay")
  if BattleConfig.runIntoBattle == false then
    moveTime = 0
    move = 0
  else
    if isChangeWave == true then
      (ShakeAnimPlay.EnableShake)(battleCamera, false)
      ;
      (CSLuaUtil.SetGOLocalPos)(battleCamera, BattleConfig.battleCameraPosition - Vector3(BattleConfig.nextWaveCardMoveX, 0, 0))
      ;
      (BattleBackground.MoveLeft)(0)
    end
  end
  local maxTime = 0
  for i,v in ipairs(allCardList) do
    do
      local speedConfig = BattleRunSpeed[v:GetPosIndex()]
      local scaleSpeed = (math.random)(speedConfig.min, speedConfig.max)
      local curTime = moveTime * scaleSpeed / 10000
      maxTime = (math.max)(curTime, maxTime)
      v:ChangeState(BattleCardState.RUN, true)
      local model = v:GetModel()
      do
        if model then
          local position = v.position
          ;
          (CSLuaUtil.SetGOLocalPos)(model, Vector3(position.x - move, position.y, position.z))
          ;
          ((LeanTween.moveLocalX)(model, position.x, curTime)):setOnComplete(function(...)
    -- function num : 0_2_0 , upvalues : v, BattleCardState
    v:ChangeState(BattleCardState.IDLE, true)
  end
)
        end
        local shadow = v:GetShadow()
        if shadow then
          local position = v.position
          ;
          (CSLuaUtil.SetGOLocalPos)(shadow, Vector3(position.x - move, position.y, position.z))
          ;
          (LeanTween.moveLocalX)(shadow, position.x, curTime)
        end
      end
      do
        -- DECOMPILER ERROR at PC108: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  ;
  ((LeanTween.moveLocal)(battleCamera, BattleConfig.battleCameraPosition, 1.5)):setEaseOutCubic()
  if isChangeWave == true then
    (LeanTween.delayedCall)(maxTime, function(...)
    -- function num : 0_2_1 , upvalues : _ENV
    (BattlePlay.PlayAfterCardEnter)()
  end
)
  end
end

-- DECOMPILER ERROR at PC33: Confused about usage of register: R13 in 'UnsetPending'

BattlePlay.PlayAfterCardEnter = function(...)
  -- function num : 0_3 , upvalues : _ENV, BattleState
  local curWave = BattleData.enemyCurWave
  local monsterGroup = (BattleData.GetMonsterGroup)(curWave)
  OpenPlotPlay(monsterGroup, PlotPlayTriggerType.BEFORE_ROUND_START, function(...)
    -- function num : 0_3_0 , upvalues : _ENV, BattleState
    local ShakeAnimPlay = require("ShakeAnimPlay")
    ;
    (ShakeAnimPlay.EnableShake)(Game.battleCamera, true)
    ;
    (BattleData.SetBattleState)(BattleState.PRE_EVENT_BEGIN)
  end
, BattleData.battleType == (ProtoEnum.E_BATTLE_TYPE).CG)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC36: Confused about usage of register: R13 in 'UnsetPending'

BattlePlay.ShowCardMoveForward = function(...)
  -- function num : 0_4 , upvalues : _ENV, BattleCardCamp, ipairs, BattleCardState
  local allCardList = (BattleData.GetAliveCards)(BattleCardCamp.LEFT)
  for i,v in ipairs(allCardList) do
    v:ChangeState(BattleCardState.RUN, true)
  end
end

-- DECOMPILER ERROR at PC39: Confused about usage of register: R13 in 'UnsetPending'

BattlePlay.ShowCardStand = function(...)
  -- function num : 0_5 , upvalues : _ENV, ipairs, BattleCardState
  local allCardList = (BattleData.GetAliveCards)()
  for i,v in ipairs(allCardList) do
    v:ChangeState(BattleCardState.IDLE, true)
  end
end

-- DECOMPILER ERROR at PC42: Confused about usage of register: R13 in 'UnsetPending'

BattlePlay.ShowNextEnemyEnter = function(...)
  -- function num : 0_6 , upvalues : _ENV, BattleCardCamp, ipairs, BattleConfig
  local aliveCards = (BattleData.GetAliveCards)(BattleCardCamp.RIGHT)
  for i,v in ipairs(aliveCards) do
    local model = v:GetModel()
    do
      if model then
        local position = v.position
        ;
        (CSLuaUtil.SetGOLocalPos)(model, position.x + BattleConfig.nextWaveCardMoveX, position.y, position.z)
        ;
        (LeanTween.moveLocalX)(model, position.x, BattleConfig.nextWaveCardMoveTime)
      end
      local shadow = v:GetShadow()
      do
        if shadow then
          local position = v.position
          ;
          (CSLuaUtil.SetGOLocalPos)(shadow, position.x + BattleConfig.nextWaveCardMoveX, position.y, position.z)
          ;
          (LeanTween.moveLocalX)(shadow, position.x, BattleConfig.nextWaveCardMoveTime)
        end
        -- DECOMPILER ERROR at PC48: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
end

-- DECOMPILER ERROR at PC45: Confused about usage of register: R13 in 'UnsetPending'

BattlePlay.PlayBuffPreBattle = function(callBack, ...)
  -- function num : 0_7 , upvalues : _ENV, self, BattleBuffDeductionRoundType, BattleBuffSettleRoundType, math
  local curPreBattleEventInfo = BattleData.curPreBattleEventInfo
  local updateBuffCount = (self.PlayBuff)(curPreBattleEventInfo, nil, BattleBuffDeductionRoundType.BEFORE_BATTLE, BattleBuffSettleRoundType.BEFORE_BATTLE)
  ;
  (SimpleTimer.setTimeout)((math.min)(updateBuffCount * 0.1, 0.3), function(...)
    -- function num : 0_7_0 , upvalues : _ENV, callBack
    if (BattleMgr.IsInBattle)() == true and callBack then
      callBack()
    end
  end
)
end

local totalDamage = 0
-- DECOMPILER ERROR at PC49: Confused about usage of register: R14 in 'UnsetPending'

BattlePlay.PlayBuffBeforeAtk = function(...)
  -- function num : 0_8 , upvalues : _ENV, BattleState, self, BattleBuffDeductionRoundType, BattleBuffSettleRoundType
  (BattleData.SetBattleState)(BattleState.BUFF_BEFORE_ATTACK_ING)
  if IsBattleServer == nil then
    local atkInfo = BattleAtk.curAtkInfo
    local skillType = atkInfo.skillType
    local atkCard = (BattleData.GetCardInfoByUid)(atkInfo.atkCardUid)
    local updateBuffCount = 0
    if skillType == BattleSkillType.SKILL then
      updateBuffCount = (self.PlayBuff)(atkInfo, atkCard, BattleBuffDeductionRoundType.BEFORE_SKILL, BattleBuffSettleRoundType.BEFORE_SKILL)
    else
      updateBuffCount = (self.PlayBuff)(atkInfo, atkCard, BattleBuffDeductionRoundType.BEFORE_ATTACK, BattleBuffSettleRoundType.BEFORE_ATTACK)
    end
    ;
    (SimpleTimer.setTimeout)(updateBuffCount > 0 and 0.3 or 0.1, function(...)
    -- function num : 0_8_0 , upvalues : _ENV, BattleState
    if (BattleMgr.IsInBattle)() == true then
      (BattleData.SetBattleState)(BattleState.PLAY_ATTACK)
    end
  end
)
  else
    do
      ;
      (BattleData.SetBattleState)(BattleState.PLAY_ATTACK)
    end
  end
end

-- DECOMPILER ERROR at PC52: Confused about usage of register: R14 in 'UnsetPending'

BattlePlay.PlayBuffAfterAtk = function(...)
  -- function num : 0_9 , upvalues : _ENV, BattleState, self, BattleBuffDeductionRoundType, BattleBuffSettleRoundType, math, BattleConfig
  (BattleData.SetBattleState)(BattleState.BUFF_AFTER_ATTACK_ING)
  if IsBattleServer == nil then
    loge("处理出手后buff结算")
    self.AssistCameraMove = false
    ;
    (Util.MoveCameraScreenCenter)()
    local atkInfo = BattleAtk.curAtkInfo
    local skillType = atkInfo.skillType
    local atkCard = (BattleData.GetCardInfoByUid)(atkInfo.atkCardUid)
    local updateBuffCount = 0
    if skillType == BattleSkillType.SKILL then
      updateBuffCount = (self.PlayBuff)(atkInfo, atkCard, BattleBuffDeductionRoundType.AFTER_SKILL, BattleBuffSettleRoundType.AFTER_SKILL)
    else
      updateBuffCount = (self.PlayBuff)(atkInfo, atkCard, BattleBuffDeductionRoundType.AFTER_ATTACK, BattleBuffSettleRoundType.AFTER_ATTACK)
    end
    local time = (math.min)(updateBuffCount * 0.1, 0.3) + BattleConfig.nextAttackWaitTime
    loge("处理出手后buff结算时间：" .. time)
    ;
    (SimpleTimer.setTimeout)((math.min)(updateBuffCount * 0.1, 0.3) + BattleConfig.nextAttackWaitTime, function(...)
    -- function num : 0_9_0 , upvalues : _ENV, BattleState
    loge("处理出手后buff结算   完成")
    if (BattleMgr.IsInBattle)() == true then
      (BattleData.SetBattleState)(BattleState.BUFF_AFTER_ATTACK_END)
    end
  end
)
  else
    do
      ;
      (BattleData.SetBattleState)(BattleState.PLAY_ATTACK)
    end
  end
end

-- DECOMPILER ERROR at PC54: Confused about usage of register: R14 in 'UnsetPending'

BattlePlay.curStrikeIndex = 1
-- DECOMPILER ERROR at PC57: Confused about usage of register: R14 in 'UnsetPending'

BattlePlay.PlayAtk = function(...)
  -- function num : 0_10 , upvalues : _ENV, BattleState, ipairs, BattleAttackType, totalDamage, UIMgr, math, self
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

  BattlePlay.curStrikeIndex = 1
  local atkInfo = BattleAtk.curAtkInfo
  ;
  (BattleData.SetBattleState)(BattleState.PLAY_ATTACK_ING)
  local atkCard = (BattleData.GetCardInfoByUid)(atkInfo.atkCardUid)
  if atkCard == nil then
    loge("战斗异常，找不到攻击者")
    return 
  end
  print("攻击位：", atkInfo.atkPos)
  ;
  (BattleResultCount.UpdateDamageDataAtk)(atkInfo)
  if IsBattleServer == true then
    (BattleData.SetBattleState)(BattleState.CHANGE_ATTACK)
    return 
  end
  local atkFail = atkInfo.atkFail
  if atkFail == true then
    atkInfo.defCardsInfo = {}
    atkInfo.assistAtkInfo = {}
  end
  PrintTable(atkInfo, "本次攻击数据：")
  if atkCard:IsDisplayAlive() == true then
    (BattleAtk.SetWaitActionCardState)(atkCard:GetPosIndex(), false)
  end
  for _,v in ipairs(atkInfo.assistAtkInfo) do
    local atkCardUid = v.atkCardUid
    local assistAtkCard = (BattleData.GetCardInfoByUid)(atkCardUid)
    if assistAtkCard:IsDisplayAlive() == true then
      (BattleAtk.SetWaitActionCardState)(assistAtkCard:GetPosIndex(), false)
    end
  end
  local isCrit = false
  for _,v in ipairs(atkInfo.defCardsInfo) do
    local defCardUid = v.defCardUid
    local defCard = (BattleData.GetCardInfoByUid)(defCardUid)
    if defCard:IsDisplayAlive() == true then
      (BattleAtk.SetWaitActionCardState)(defCard:GetPosIndex(), false)
    end
    if v.isCrit == true then
      isCrit = true
    end
  end
  local skillId = atkInfo.skillId
  local skillType = atkInfo.skillType
  local skillConfig = ((TableData.GetBaseSkillData)(skillId))
  do
    local skillShowConfig = nil
    if skillConfig then
      local fashionId = atkCard:GetFashionId()
      local showId = (BattleSkill.GetSkillShowId)(fashionId, skillType)
      skillShowConfig = ((TableData.gTable).BaseSkillShowData)[showId]
    end
    do
      local attackType = BattleAttackType.STAND
      if skillShowConfig then
        attackType = skillShowConfig.move_type
      end
      local noAtkAction = atkInfo.noAtkAction
      if noAtkAction == true or atkFail == true then
        attackType = BattleAttackType.STAND
      end
      local noMove = noAtkAction or atkFail
      local targetSelf = atkInfo.targetSelf
      if targetSelf == true and attackType ~= BattleAttackType.STAND then
        attackType = BattleAttackType.JUMP
      end
      local isTreatment = atkInfo.isTreatment
      if isTreatment then
        attackType = BattleAttackType.STAND
      end
      totalDamage = 0
      local atkEndCallBack = function(...)
    -- function num : 0_10_0 , upvalues : atkInfo, atkCard, totalDamage, UIMgr, _ENV, isCrit, math
    if atkInfo and atkCard and totalDamage < 0 then
      UIMgr:SendWindowMessage("BattleUIWindow", (WindowMsgEnum.BattleUIWindow).E_MSG_SHOW_DAMAGE, {camp = atkCard:GetCampFlag(), isCrit = isCrit, totalDamage = (math.abs)(totalDamage)})
    end
  end

      local allEndCallBack = function(...)
    -- function num : 0_10_1 , upvalues : _ENV, skillType, UIMgr, atkCard, BattleState
    loge("整个攻击动作完成")
    if skillType ~= BattleSkillType.SKILL then
      UIMgr:SendWindowMessage("BattleUIWindow", (WindowMsgEnum.BattleUIWindow).E_MSG_RESET_ORDER_LINE, atkCard:GetPosIndex())
    end
    ;
    (BattleData.SetBattleState)(BattleState.BUFF_AFTER_ATTACK)
    local SkillParse = require("SkillParse")
    ClearSkillMask()
  end

      if skillConfig and skillConfig.move_pos_type and OvertureMgr.isPlaying ~= true then
        atkInfo.movePosType = skillConfig.move_pos_type
      else
        if skillShowConfig and OvertureMgr.isPlaying ~= true then
          atkInfo.movePosType = skillShowConfig.move_pos_type
        end
      end
      local realDefCardsInfo = (BattleAtk.GetRealDefCard)(atkInfo.defCardsInfo)
      if #realDefCardsInfo == 1 then
        local defCardInfo = realDefCardsInfo[1]
        local defCardUid = defCardInfo.defCardUid
        local defCard = (BattleData.GetCardInfoByUid)(defCardUid)
        local assistAtkInfo = atkInfo.assistAtkInfo
        if defCard then
          if #assistAtkInfo > 0 then
            (self.PlayAssistAtk)(attackType, atkCard, defCard, atkInfo, atkEndCallBack, allEndCallBack)
          else
            if #atkInfo.doubleAtkInfo > 0 then
              atkInfo.isStrike = false
              atkInfo.lastAtk = true
              -- DECOMPILER ERROR at PC210: Confused about usage of register: R20 in 'UnsetPending'

              if (atkInfo.doubleAtkInfo)[1] then
                ((atkInfo.doubleAtkInfo)[1]).lastAtk = true
                -- DECOMPILER ERROR at PC214: Confused about usage of register: R20 in 'UnsetPending'

                ;
                ((atkInfo.doubleAtkInfo)[1]).movePosType = atkInfo.movePosType
                local defCard_double = (BattleData.GetCardInfoByUid)(((((atkInfo.doubleAtkInfo)[1]).defCardsInfo)[1]).defCardUid)
                ;
                (self.StartPlay)(attackType, atkCard, {defCard}, atkInfo, function(...)
    -- function num : 0_10_2 , upvalues : _ENV, atkCard, self, attackType, defCard_double, atkInfo, atkEndCallBack, allEndCallBack
    ShowHurtNum(HurtNumType.DOUBLE_ATTACK, 0, atkCard)
    ;
    (self.StartPlay)(attackType, atkCard, {defCard_double}, (atkInfo.doubleAtkInfo)[1], atkEndCallBack, allEndCallBack)
  end
)
              end
            else
              do
                do
                  atkInfo.lastAtk = true
                  ;
                  (self.StartPlay)(attackType, atkCard, {defCard}, atkInfo, atkEndCallBack, allEndCallBack)
                  UIMgr:SendWindowMessage("BattleUIWindow", (WindowMsgEnum.BattleUIWindow).E_MSG_SHOW_SKILL_INFO, {atkCard = atkCard, skillType = atkInfo.skillType})
                  totalDamage = totalDamage + defCardInfo.hpDef
                  if #realDefCardsInfo > 1 then
                    atkInfo.lastAtk = true
                    local defCards = {}
                    for _,v in ipairs(realDefCardsInfo) do
                      local defCardUid = v.defCardUid
                      local defCard = (BattleData.GetCardInfoByUid)(defCardUid)
                      ;
                      (table.insert)(defCards, defCard)
                      totalDamage = totalDamage + v.hpDef
                    end
                    ;
                    (self.StartPlay)(attackType, atkCard, defCards, atkInfo, atkEndCallBack, allEndCallBack)
                  else
                    do
                      atkInfo.lastAtk = true
                      ;
                      (self.StartPlay)(attackType, atkCard, {}, atkInfo, atkEndCallBack, allEndCallBack)
                      UIMgr:SendWindowMessage("BattleUIWindow", (WindowMsgEnum.BattleUIWindow).E_MSG_SHOW_SKILL_INFO, {atkCard = atkCard, skillType = atkInfo.skillType})
                      totalDamage = totalDamage
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

local curAssistIndex = 0
-- DECOMPILER ERROR at PC61: Confused about usage of register: R15 in 'UnsetPending'

BattlePlay.PlayAssistAtk = function(attackType, atkCard, defCard, atkInfo, atkEndCallBack, allEndCallBack, ...)
  -- function num : 0_11 , upvalues : curAssistIndex, totalDamage, _ENV, self, UIMgr
  local assistAtkInfo = atkInfo.assistAtkInfo
  local defCardInfo = (atkInfo.defCardsInfo)[1]
  curAssistIndex = 1
  totalDamage = totalDamage + defCardInfo.hpDef
  local nextAssistAtkInfo = assistAtkInfo[curAssistIndex]
  local card = (BattleData.GetCardInfoByPos)(nextAssistAtkInfo.atkPos)
  local _, moveType = (self.GetNextAttackTime)(nextAssistAtkInfo, card, defCard)
  if #atkInfo.doubleAtkInfo > 0 then
    atkInfo.isStrike = false
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R12 in 'UnsetPending'

    ;
    ((atkInfo.doubleAtkInfo)[1]).movePosType = atkInfo.movePosType
    local defCard_double = (BattleData.GetCardInfoByUid)(((((atkInfo.doubleAtkInfo)[1]).defCardsInfo)[1]).defCardUid)
    do
      (self.StartPlay)(attackType, atkCard, {defCard}, atkInfo, function(...)
    -- function num : 0_11_0 , upvalues : _ENV, atkCard, self, attackType, defCard_double, atkInfo, moveType, defCard, assistAtkInfo, atkEndCallBack, allEndCallBack
    ShowHurtNum(HurtNumType.DOUBLE_ATTACK, 0, atkCard)
    ;
    (self.StartPlay)(attackType, atkCard, {defCard_double}, (atkInfo.doubleAtkInfo)[1], function(...)
      -- function num : 0_11_0_0 , upvalues : self, moveType, atkCard, defCard, assistAtkInfo, atkEndCallBack, allEndCallBack
      self.AssistCameraMove = true
      ;
      (self.PlayOneAssistAtk)(moveType, atkCard, defCard, assistAtkInfo, atkEndCallBack, allEndCallBack)
    end
)
  end
)
    end
  else
    do
      ;
      (self.StartPlay)(attackType, atkCard, {defCard}, atkInfo, function(...)
    -- function num : 0_11_1 , upvalues : self, moveType, atkCard, defCard, assistAtkInfo, atkEndCallBack, allEndCallBack
    self.AssistCameraMove = true
    ;
    (self.PlayOneAssistAtk)(moveType, atkCard, defCard, assistAtkInfo, atkEndCallBack, allEndCallBack)
  end
)
      UIMgr:SendWindowMessage("BattleUIWindow", (WindowMsgEnum.BattleUIWindow).E_MSG_SHOW_SKILL_INFO, {atkCard = atkCard, skillType = atkInfo.skillType})
    end
  end
end

-- DECOMPILER ERROR at PC64: Confused about usage of register: R15 in 'UnsetPending'

BattlePlay.PlayOneAssistAtk = function(attackType, atkCard, defCard, assistAtkInfo, atkEndCallBack, allEndCallBack, ...)
  -- function num : 0_12 , upvalues : curAssistIndex, _ENV, totalDamage, self, BattleCardFloatUpState, BattleAttackType, UIMgr
  local info = assistAtkInfo[curAssistIndex]
  local assistAtkCard = (BattleData.GetCardInfoByUid)(info.atkCardUid)
  local defCardInfo = (info.defCardsInfo)[1]
  totalDamage = totalDamage + defCardInfo.hpDef
  if curAssistIndex == #assistAtkInfo then
    info.lastAtk = true
  end
  local nextAssistAtkInfo = assistAtkInfo[curAssistIndex + 1]
  local _, moveType = nil, nil
  do
    if nextAssistAtkInfo then
      local card = (BattleData.GetCardInfoByPos)(nextAssistAtkInfo.atkPos)
      _ = (self.GetNextAttackTime)(nextAssistAtkInfo, card, defCard)
    end
    local assistAtkConfig = assistAtkCard:GetAssistSkillConfig()
    local fashionId = assistAtkCard:GetFashionId()
    local showId = (BattleSkill.GetSkillShowId)(fashionId, assistAtkConfig.type)
    local skillShowConfig = ((TableData.gTable).BaseSkillShowData)[showId]
    attackType = skillShowConfig.move_type
    if assistAtkConfig and assistAtkConfig.move_pos_type then
      info.movePosType = assistAtkConfig.move_pos_type
    else
      info.movePosType = skillShowConfig.move_pos_type
    end
    local targetFloatState = defCard:GetFloatUpState()
    if targetFloatState == BattleCardFloatUpState.FLOAT and attackType == BattleAttackType.RUN then
      attackType = BattleAttackType.JUMP
    end
    ;
    (self.StartPlay)(attackType, assistAtkCard, {defCard}, info, function(...)
    -- function num : 0_12_0 , upvalues : self, moveType, atkCard, defCard, assistAtkInfo, atkEndCallBack, allEndCallBack
    (self.PlayOneAssistAtk)(moveType, atkCard, defCard, assistAtkInfo, atkEndCallBack, allEndCallBack)
  end
, (((curAssistIndex == #assistAtkInfo and atkEndCallBack) or curAssistIndex == #assistAtkInfo) and allEndCallBack))
    UIMgr:SendWindowMessage("BattleUIWindow", (WindowMsgEnum.BattleUIWindow).E_MSG_SHOW_SKILL_INFO, {atkCard = assistAtkCard, skillType = info.skillType})
    curAssistIndex = curAssistIndex + 1
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

-- DECOMPILER ERROR at PC67: Confused about usage of register: R15 in 'UnsetPending'

BattlePlay.UpdateCardFloat = function(...)
  -- function num : 0_13 , upvalues : _ENV, ipairs, BattleCardFloatUpState, BattleCardState, self, BattleConfig, Vector3
  local allCard = (BattleData.GetAllCardList)()
  for i,v in ipairs(allCard) do
    do
      if v.speedUp ~= nil then
        v:SetFloatUpState(BattleCardFloatUpState.FLOAT)
        local curPosition = v:GetCurPosition()
        local targetY = curPosition.y + v.speedUp
        if v.speedUp > 0 then
          v:ChangeState(BattleCardState.FLOAT_UP, true)
        else
          if v.speedUp <= 0 then
            v:ChangeState(BattleCardState.FLOAT_DOWN, true)
          end
        end
        if self.AssistCameraMove == true then
          local position = v.position
          if targetY <= position.y then
            targetY = position.y
            v.speedUp = nil
            -- DECOMPILER ERROR at PC43: Confused about usage of register: R9 in 'UnsetPending'

            BattlePlay.curStrikeIndex = 1
            v:SetFloatUpState(BattleCardFloatUpState.NONE)
            v:ChangeState(BattleCardState.FALL_DOWN, false, function(...)
    -- function num : 0_13_0 , upvalues : _ENV, v, BattleCardState
    if (BattleMgr.IsInBattle)() == true and v:GetCurState() == BattleCardState.FALL_DOWN then
      if v:IsDisplayAlive() == false then
        local callBack = v.floatCallBack
        if callBack then
          callBack()
          v.floatCallBack = nil
        end
      else
        do
          v:ChangeState(BattleCardState.UP, false, function(...)
      -- function num : 0_13_0_0 , upvalues : _ENV, v, BattleCardState
      if (BattleMgr.IsInBattle)() == true and v:GetCurState() == BattleCardState.UP then
        local callBack = v.floatCallBack
        if callBack then
          callBack()
          v.floatCallBack = nil
        end
      end
    end
)
        end
      end
    end
  end
)
          end
          local targetZ = curPosition.z + (targetY - curPosition.y) * BattleConfig.ratio
          do
            local newCurPosition = Vector3(curPosition.x, targetY, targetZ)
            v:SetPosition(newCurPosition)
            v:SetCurPosition(newCurPosition)
            if v.speedUp then
              v.speedUp = v.speedUp - self.curCommonGravityAcceleration
            end
            -- DECOMPILER ERROR at PC77: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC77: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC77: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC77: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC70: Confused about usage of register: R15 in 'UnsetPending'

BattlePlay.GetCardPosition = function(card, delayTime, ...)
  -- function num : 0_14 , upvalues : _ENV, self, Vector3, BattleConfig
  local v0 = card.speedUp
  local nowPosition = card:GetCurPosition()
  local oriPosition = card.position
  if v0 then
    local t = delayTime / Time.fixedDeltaTime
    local dis = v0 * t - self.curCommonGravityAcceleration * t * t / 2
    local endY = nowPosition.y + dis
    if endY <= oriPosition.y then
      return oriPosition
    else
      return Vector3(nowPosition.x, endY, nowPosition.z + dis * BattleConfig.ratio)
    end
  else
    do
      do return nowPosition end
    end
  end
end

-- DECOMPILER ERROR at PC73: Confused about usage of register: R15 in 'UnsetPending'

BattlePlay.GetNextAttackTime = function(atkInfo, card, defCard, targetFloat, ...)
  -- function num : 0_15 , upvalues : _ENV, BattleAttackType, BattleConfig
  local attackSpd, effect_name, effect_name_target, bullet_config = card:GetAttackSpdAndEffect(atkInfo, {defCard}, targetFloat)
  local attackTimeTable = nil
  local firstAttackTime = 0
  if bullet_config then
    attackTimeTable = (SkeletonAnimationUtil.GetEventTimeList)(card:GetModel(), "bullet", attackSpd)
    firstAttackTime = attackTimeTable[0] + card:GetFlyTime(defCard) * bullet_config.bullet_fly_time_scale / 10000
  else
    attackTimeTable = (SkeletonAnimationUtil.GetEventTimeList)(card:GetModel(), "attack", attackSpd)
    firstAttackTime = attackTimeTable[0]
  end
  local moveType = nil
  local skillConfig = card:GetAssistSkillConfig()
  if skillConfig then
    local fashionId = card:GetFashionId()
    local showId = (BattleSkill.GetSkillShowId)(fashionId, skillConfig.type)
    local skillShowConfig = ((TableData.gTable).BaseSkillShowData)[showId]
    if skillShowConfig then
      moveType = skillShowConfig.move_type
      if moveType == BattleAttackType.JUMP then
        firstAttackTime = firstAttackTime + BattleConfig.maxMoveInterval
      else
        if moveType == BattleAttackType.FLASH then
          firstAttackTime = firstAttackTime + BattleConfig.flashInterval
        end
      end
    end
  end
  do
    return firstAttackTime, moveType
  end
end

-- DECOMPILER ERROR at PC76: Confused about usage of register: R15 in 'UnsetPending'

BattlePlay.StartPlay = function(attackType, atkCard, defCards, atkInfo, atkEndCallBack, allEndCallBack, ...)
  -- function num : 0_16 , upvalues : self, BattleAttackType, _ENV
  atkCard:SetAtkInfo(atkInfo)
  atkCard:SetAttackType(attackType)
  atkCard:SetMovePosType(atkInfo.movePosType)
  atkCard:SetAllBuffEffectVisible(false)
  local callBack = function(...)
    -- function num : 0_16_0 , upvalues : self, atkInfo, attackType, BattleAttackType, atkCard, defCards, atkEndCallBack, allEndCallBack
    (self.PlayDamageShareMove)(atkInfo)
    if attackType == BattleAttackType.RUN then
      atkCard:RunToTargetCard(defCards, atkEndCallBack, allEndCallBack)
    else
      if attackType == BattleAttackType.JUMP then
        atkCard:JumpToTargetCard(defCards, atkEndCallBack, allEndCallBack)
      else
        if attackType == BattleAttackType.STAND then
          atkCard:Attack(defCards, atkEndCallBack, allEndCallBack)
        else
          if attackType == BattleAttackType.FLASH then
            atkCard:FlashToTargetCard(defCards, atkEndCallBack, allEndCallBack)
          end
        end
      end
    end
  end

  local skillId = atkInfo.skillId
  local skillConfig = (TableData.GetBaseSkillData)(skillId)
  local skillType = atkInfo.skillType
  if atkInfo.atkFail ~= true and (skillType == BattleSkillType.SMALL or atkInfo.isDoubleAttack == true) then
    atkCard:PlayCommonSkillEffect(callBack)
  else
    if atkInfo.atkFail ~= true and skillType == BattleSkillType.SKILL and skillConfig then
      local fashionId = atkCard:GetFashionId()
      local showId = (BattleSkill.GetSkillShowId)(fashionId, skillType)
      local skillShowConfig = ((TableData.gTable).BaseSkillShowData)[showId]
      local scriptPath = skillShowConfig.effect_attack
      local oriSkillConfig = atkCard:GetSkillConfig()
      if oriSkillConfig.special_type ~= BattleSkillSpecialType.COPY and (scriptPath == nil or scriptPath == "" or not scriptPath or (string.find)(scriptPath, "SkillScript") == nil) then
        atkCard:PlayCommonSkillEffect(function(...)
    -- function num : 0_16_1 , upvalues : _ENV, skillId, atkCard, callBack
    (BattlePlay.ShowSkillCard)(skillId, atkCard:GetPosIndex(), callBack)
  end
)
      else
        atkCard:PlayUniqueSkillEffect(skillId, callBack, atkEndCallBack, allEndCallBack, defCards)
      end
    end
  end
  do
    callBack()
    if skillConfig.extra_spine then
      atkCard:PlayRandomNumSpine(skillConfig.extra_spine, #defCards)
    end
    if skillConfig and (skillType == BattleSkillType.SMALL or skillType == BattleSkillType.SKILL) and atkInfo.atkFail ~= true then
      local fashionId = atkCard:GetFashionId()
      if skillType == BattleSkillType.SMALL then
        (AudioManager.PlayBattleVoice)(fashionId, CVAudioType.SkillBubble)
      end
      local showId = (BattleSkill.GetSkillShowId)(fashionId, skillType)
      local skillShowConfig = ((TableData.gTable).BaseSkillShowData)[showId]
      local camera_id = skillShowConfig.camera_id
      if camera_id and camera_id ~= 0 then
        (BattleCameraMgr.MoveCamera)(camera_id, atkCard, defCards[1])
      end
    end
  end
end

-- DECOMPILER ERROR at PC79: Confused about usage of register: R15 in 'UnsetPending'

BattlePlay.ShowSkillCard = function(skillId, posIndex, callBack, ...)
  -- function num : 0_17 , upvalues : _ENV, UIMgr
  local skillConfig = (TableData.GetBaseSkillData)(skillId)
  local card = (BattleData.GetCardInfoByPos)(posIndex)
  if card then
    local fashionId = card:GetFashionId()
    local showId = (BattleSkill.GetSkillShowId)(fashionId, skillConfig.type)
    local showConfig = ((TableData.gTable).BaseSkillShowData)[showId]
    local fashionId = showConfig.card_show
    if fashionId and fashionId ~= 0 then
      UIMgr:SendWindowMessage((WinResConfig.BattleUIWindow).name, (WindowMsgEnum.BattleUIWindow).E_MSG_PLAY_SKILL_CARD, {fashionId = fashionId, posIndex = posIndex, callBack = callBack})
    else
      callBack()
    end
  else
    do
      callBack()
    end
  end
end

-- DECOMPILER ERROR at PC82: Confused about usage of register: R15 in 'UnsetPending'

BattlePlay.PlayDamageShareMove = function(atkInfo, ...)
  -- function num : 0_18 , upvalues : ipairs, _ENV
  local defCardsInfo = atkInfo.defCardsInfo
  for _,v in ipairs(defCardsInfo) do
    if v.shareDamageCardPos ~= 0 then
      local targetCard = (BattleData.GetCardInfoByPos)(v.shareDamageCardPos)
      local needMoveCard = (BattleData.GetCardInfoByPos)(v.defPos)
      if needMoveCard and targetCard then
        targetCard.damageShareCardPos = v.defPos
        needMoveCard:JumpToDamageShareCard(targetCard, function(...)
    -- function num : 0_18_0
  end
)
      end
    end
  end
end

-- DECOMPILER ERROR at PC85: Confused about usage of register: R15 in 'UnsetPending'

BattlePlay.PlayPreRoundInfo = function(...)
  -- function num : 0_19 , upvalues : _ENV, BattleState, ipairs, self, BattleBuffDeductionRoundType, BattleBuffSettleRoundType
  local curRound = BattleData.roundIndex
  ;
  (BattleData.SetBattleState)(BattleState.PRE_ROUND_PLAYING)
  local preRoundInfo = (BattleData.curRoundData).preRoundInfo
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  BattleAtk.curAtkInfo = preRoundInfo
  PrintTable(preRoundInfo, " 大回合前数据： ")
  local defCardsInfo = preRoundInfo.defCardsInfo
  for _,v in ipairs(defCardsInfo) do
    local pos = v.defPos
    local card = (BattleData.GetCardInfoByPos)(pos)
    if card and card:IsDisplayAlive() == true then
      if v.danderDef and v.danderDef ~= 0 then
        print("大回合前回怒 位置：", pos, " 回复值：", v.danderDef)
        card:ChangeDander(v.danderDef)
      end
      if v.hpDef and (v.hpDef ~= 0 or v.absorbDamage ~= 0) then
        print("大回合前回血 位置：", pos, " 回复值：", v.hpDef)
        card:ChangeHp({hurt = v.hpDef, absorb = v.absorbDamage}, nil, nil, nil, true)
      end
    end
  end
  local allBuffTable = preRoundInfo.allBuffTable
  local updateCount = 0
  for i,v in ipairs(allBuffTable) do
    if v.type == BattleBuffOprType.UPDATE then
      updateCount = updateCount + 1
    end
  end
  local playBuffInfo = (Util.Copy)(preRoundInfo)
  ;
  (self.PlayBuff)(playBuffInfo, nil, BattleBuffDeductionRoundType.BEFORE_ROUND, BattleBuffSettleRoundType.BEFORE_ROUND)
  if curRound > 1 then
    (self.PlayBuff)(playBuffInfo, nil, BattleBuffDeductionRoundType.BEFORE_ROUND_SINCE_2, BattleBuffSettleRoundType.BEFORE_ROUND)
    if curRound == 3 then
      (self.PlayBuff)(playBuffInfo, nil, BattleBuffDeductionRoundType.BEFORE_ROUND_3, BattleBuffSettleRoundType.BEFORE_ROUND)
    end
  end
  ;
  (self.PlayBuff)(playBuffInfo, nil, BattleBuffDeductionRoundType.BEFORE_ROUND_DELAY, BattleBuffSettleRoundType.BEFORE_ROUND)
  if updateCount > 0 then
    (SimpleTimer.setTimeout)(0.8, function(...)
    -- function num : 0_19_0 , upvalues : _ENV, BattleState
    (BattleData.SetBattleState)(BattleState.CHANGE_ATTACK)
  end
)
  else
    ;
    (BattleData.SetBattleState)(BattleState.CHANGE_ATTACK)
  end
  ;
  (self.PlayAtkOrderShow)()
end

-- DECOMPILER ERROR at PC88: Confused about usage of register: R15 in 'UnsetPending'

BattlePlay.PlayAtkOrderShow = function(...)
  -- function num : 0_20 , upvalues : _ENV, ipairs
  local allLiveCard = (BattleData.GetAliveCards)()
  ;
  (table.sort)(allLiveCard, BattleData.AtkOrderSort)
  for i,v in ipairs(allLiveCard) do
    v:UpdateAtkOrder(i)
  end
end

-- DECOMPILER ERROR at PC91: Confused about usage of register: R15 in 'UnsetPending'

BattlePlay.PlayBuff = function(atkInfo, targetCard, deductionRoundType, settleRoundType, playSettleRoundType, ...)
  -- function num : 0_21 , upvalues : BattleBuffDeductionRoundType, BattleBuffSettleRoundType, ipairs, BattleConfig, _ENV
  local allBuffTable = atkInfo.allBuffTable
  local updateBuffCount = 0
  local deductionRoundType2, deductionRoundType3, settleRoundType2, card = nil, nil, nil, nil
  local noVerificationCard = false
  if deductionRoundType == BattleBuffDeductionRoundType.BEFORE_ROUND or deductionRoundType == BattleBuffDeductionRoundType.BEFORE_ROUND_SINCE_2 or deductionRoundType == BattleBuffDeductionRoundType.BEFORE_BATTLE or deductionRoundType == BattleBuffDeductionRoundType.BEFORE_ROUND_3 or deductionRoundType == BattleBuffDeductionRoundType.BEFORE_ROUND_DELAY then
    noVerificationCard = true
  end
  if deductionRoundType == BattleBuffDeductionRoundType.BEFORE_ATTACK then
    deductionRoundType2 = BattleBuffDeductionRoundType.BEFORE_ACTION
  else
    if deductionRoundType == BattleBuffDeductionRoundType.AFTER_ATTACK then
      deductionRoundType2 = BattleBuffDeductionRoundType.AFTER_ACTION
    else
      if deductionRoundType == BattleBuffDeductionRoundType.BEFORE_SKILL then
        deductionRoundType2 = BattleBuffDeductionRoundType.BEFORE_ACTION
      else
        if deductionRoundType == BattleBuffDeductionRoundType.AFTER_SKILL then
          deductionRoundType2 = BattleBuffDeductionRoundType.AFTER_SKILL_ENEMY
          deductionRoundType3 = BattleBuffDeductionRoundType.AFTER_ACTION
        end
      end
    end
  end
  if settleRoundType == BattleBuffSettleRoundType.BEFORE_ATTACK then
    settleRoundType2 = BattleBuffSettleRoundType.BEFORE_ACTION
  else
    if settleRoundType == BattleBuffSettleRoundType.AFTER_ATTACK then
      settleRoundType2 = BattleBuffSettleRoundType.AFTER_ACTION
    else
      if settleRoundType == BattleBuffSettleRoundType.BEFORE_SKILL then
        settleRoundType2 = BattleBuffSettleRoundType.BEFORE_ACTION
      else
        if settleRoundType == BattleBuffSettleRoundType.AFTER_SKILL then
          settleRoundType2 = BattleBuffSettleRoundType.AFTER_ACTION
        end
      end
    end
  end
  for _,v in ipairs(allBuffTable) do
    if v.isDeal ~= true or BattleConfig.isPlayBack == true then
      local buffData = v.buff
      local type = v.type
      if settleRoundType then
        local buffConfig = (TableData.GetBaseSkillBuffData)(buffData.buffId)
        local play_settle_round_type = buffConfig.play_settle_round_type
        -- DECOMPILER ERROR at PC93: Unhandled construct in 'MakeBoolean' P1

        if type == BattleBuffOprType.NEW and (playSettleRoundType == nil or play_settle_round_type == playSettleRoundType) and (buffData.settleRoundType == settleRoundType or buffData.settleRoundType == settleRoundType2) then
          local curDefPos = buffData.curDefPos
          local card = (BattleData.GetCardInfoByPos)(curDefPos)
          if card then
            v.isDeal = true
            ;
            (BattleBuff.PlayBuffActive)(card, buffData)
            ;
            (BattleBuffMgr.AddBuffToPlayBackList)(buffData)
          end
        end
      end
      do
        -- DECOMPILER ERROR at PC121: Unhandled construct in 'MakeBoolean' P1

        if type == BattleBuffOprType.IMMUNE and (buffData.settleRoundType == settleRoundType or buffData.settleRoundType == settleRoundType2) then
          local curDefPos = buffData.curDefPos
          local card = (BattleData.GetCardInfoByPos)(curDefPos)
          if card then
            v.isDeal = true
            ShowHurtNum(HurtNumType.IMMUNE, 0, card)
          end
        end
        do
          if type == BattleBuffOprType.RESET and (playSettleRoundType == nil or play_settle_round_type == playSettleRoundType) and (buffData.settleRoundType == settleRoundType or buffData.settleRoundType == settleRoundType2) then
            local curDefPos = buffData.curDefPos
            local card = (BattleData.GetCardInfoByPos)(curDefPos)
            if card then
              v.isDeal = true
              ;
              (BattleBuff.PlayBuffReset)(card, buffData)
            end
          end
          do
            if deductionRoundType then
              if type == BattleBuffOprType.UPDATE then
                local tempDeductionRoundType = nil
                if buffData.deductionRoundType == BattleBuffDeductionRoundType.NOW then
                  if buffData.settleRoundType == BattleBuffSettleRoundType.BEFORE_ATTACK then
                    tempDeductionRoundType = BattleBuffDeductionRoundType.BEFORE_ATTACK
                  else
                    if buffData.settleRoundType == BattleBuffSettleRoundType.AFTER_ATTACK then
                      tempDeductionRoundType = BattleBuffDeductionRoundType.AFTER_ATTACK
                    else
                      if buffData.settleRoundType == BattleBuffSettleRoundType.BEFORE_SKILL then
                        tempDeductionRoundType = BattleBuffDeductionRoundType.BEFORE_SKILL
                      else
                        if buffData.settleRoundType == BattleBuffSettleRoundType.AFTER_SKILL then
                          tempDeductionRoundType = BattleBuffDeductionRoundType.AFTER_SKILL
                        else
                          if buffData.settleRoundType == BattleBuffSettleRoundType.BEFORE_ROUND then
                            tempDeductionRoundType = BattleBuffDeductionRoundType.BEFORE_ROUND
                          end
                        end
                      end
                    end
                  end
                  -- DECOMPILER ERROR at PC228: Unhandled construct in 'MakeBoolean' P3

                  if tempDeductionRoundType == deductionRoundType or ((buffData.settleRoundType == BattleBuffDeductionRoundType.BEFORE_ACTION and deductionRoundType == BattleBuffDeductionRoundType.BEFORE_ATTACK) or buffData.settleRoundType == BattleBuffDeductionRoundType.AFTER_ACTION and (deductionRoundType == BattleBuffDeductionRoundType.AFTER_ATTACK or deductionRoundType == BattleBuffDeductionRoundType.AFTER_SKILL)) then
                    local tempCard = (BattleData.GetCardInfoByPos)(buffData.curDefPos)
                    if tempCard then
                      v.isDeal = true
                      updateBuffCount = updateBuffCount + 1
                      ;
                      (BattleBuff.PlayBuffUpdate)(tempCard, buffData)
                    end
                  end
                else
                  do
                    if buffData.deductionRoundType == deductionRoundType or buffData.deductionRoundType == deductionRoundType2 or buffData.deductionRoundType == deductionRoundType3 then
                      local curDefPos = buffData.curDefPos
                      if noVerificationCard == true then
                        if not targetCard then
                          do
                            card = (BattleData.GetCardInfoByPos)(curDefPos)
                            card = targetCard
                            if card:GetPosIndex() == curDefPos then
                              v.isDeal = true
                              updateBuffCount = updateBuffCount + 1
                              ;
                              (BattleBuff.PlayBuffUpdate)(card, buffData)
                            end
                            if noVerificationCard == true then
                              card:DealAfterAtk(true)
                            end
                            if type == BattleBuffOprType.DELETE then
                              local tempDeductionRoundType = nil
                              if buffData.deductionRoundType == BattleBuffDeductionRoundType.NOW then
                                if buffData.settleRoundType == BattleBuffSettleRoundType.BEFORE_ATTACK then
                                  tempDeductionRoundType = BattleBuffDeductionRoundType.BEFORE_ATTACK
                                else
                                  if buffData.settleRoundType == BattleBuffSettleRoundType.AFTER_ATTACK then
                                    tempDeductionRoundType = BattleBuffDeductionRoundType.AFTER_ATTACK
                                  else
                                    if buffData.settleRoundType == BattleBuffSettleRoundType.BEFORE_SKILL then
                                      tempDeductionRoundType = BattleBuffDeductionRoundType.BEFORE_SKILL
                                    else
                                      if buffData.settleRoundType == BattleBuffSettleRoundType.AFTER_SKILL then
                                        tempDeductionRoundType = BattleBuffDeductionRoundType.AFTER_SKILL
                                      end
                                    end
                                  end
                                end
                                -- DECOMPILER ERROR at PC334: Unhandled construct in 'MakeBoolean' P3

                                if tempDeductionRoundType == deductionRoundType or ((buffData.settleRoundType == BattleBuffDeductionRoundType.BEFORE_ACTION and deductionRoundType == BattleBuffDeductionRoundType.BEFORE_ATTACK) or buffData.settleRoundType == BattleBuffDeductionRoundType.AFTER_ACTION and (deductionRoundType == BattleBuffDeductionRoundType.AFTER_ATTACK or deductionRoundType == BattleBuffDeductionRoundType.AFTER_SKILL)) then
                                  local tempCard = (BattleData.GetCardInfoByPos)(buffData.curDefPos)
                                  if tempCard then
                                    v.isDeal = true
                                    ;
                                    (BattleBuffMgr.RemoveBuffFromPlayBackList)(buffData)
                                    ;
                                    (BattleBuff.PlayBuffRemove)(tempCard, buffData)
                                  end
                                end
                              else
                                do
                                  if buffData.deductionRoundType == deductionRoundType or buffData.deductionRoundType == deductionRoundType2 or buffData.deductionRoundType == deductionRoundType3 then
                                    local curDefPos = buffData.curDefPos
                                    if noVerificationCard == true then
                                      if not targetCard then
                                        do
                                          card = (BattleData.GetCardInfoByPos)(curDefPos)
                                          card = targetCard
                                          if card:GetPosIndex() == curDefPos then
                                            v.isDeal = true
                                            ;
                                            (BattleBuffMgr.RemoveBuffFromPlayBackList)(buffData)
                                            ;
                                            (BattleBuff.PlayBuffRemove)(card, buffData)
                                          end
                                          -- DECOMPILER ERROR at PC382: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                          -- DECOMPILER ERROR at PC382: LeaveBlock: unexpected jumping out IF_STMT

                                          -- DECOMPILER ERROR at PC382: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                          -- DECOMPILER ERROR at PC382: LeaveBlock: unexpected jumping out IF_STMT

                                          -- DECOMPILER ERROR at PC382: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                          -- DECOMPILER ERROR at PC382: LeaveBlock: unexpected jumping out IF_STMT

                                          -- DECOMPILER ERROR at PC382: LeaveBlock: unexpected jumping out DO_STMT

                                          -- DECOMPILER ERROR at PC382: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                          -- DECOMPILER ERROR at PC382: LeaveBlock: unexpected jumping out IF_STMT

                                          -- DECOMPILER ERROR at PC382: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                          -- DECOMPILER ERROR at PC382: LeaveBlock: unexpected jumping out IF_STMT

                                          -- DECOMPILER ERROR at PC382: LeaveBlock: unexpected jumping out DO_STMT

                                          -- DECOMPILER ERROR at PC382: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                          -- DECOMPILER ERROR at PC382: LeaveBlock: unexpected jumping out IF_STMT

                                          -- DECOMPILER ERROR at PC382: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                          -- DECOMPILER ERROR at PC382: LeaveBlock: unexpected jumping out IF_STMT

                                          -- DECOMPILER ERROR at PC382: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                          -- DECOMPILER ERROR at PC382: LeaveBlock: unexpected jumping out IF_STMT

                                          -- DECOMPILER ERROR at PC382: LeaveBlock: unexpected jumping out DO_STMT

                                          -- DECOMPILER ERROR at PC382: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                                          -- DECOMPILER ERROR at PC382: LeaveBlock: unexpected jumping out IF_STMT

                                          -- DECOMPILER ERROR at PC382: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                          -- DECOMPILER ERROR at PC382: LeaveBlock: unexpected jumping out IF_STMT

                                          -- DECOMPILER ERROR at PC382: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                          -- DECOMPILER ERROR at PC382: LeaveBlock: unexpected jumping out IF_STMT

                                          -- DECOMPILER ERROR at PC382: LeaveBlock: unexpected jumping out DO_STMT

                                          -- DECOMPILER ERROR at PC382: LeaveBlock: unexpected jumping out DO_STMT

                                          -- DECOMPILER ERROR at PC382: LeaveBlock: unexpected jumping out DO_STMT

                                          -- DECOMPILER ERROR at PC382: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                          -- DECOMPILER ERROR at PC382: LeaveBlock: unexpected jumping out IF_STMT

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
  return updateBuffCount
end

-- DECOMPILER ERROR at PC94: Confused about usage of register: R15 in 'UnsetPending'

BattlePlay.PlayEnd = function(...)
  -- function num : 0_22 , upvalues : _ENV
  log("    出手结束")
  ;
  (BattleAtk.ClearAtkInfo)()
  ;
  (BattleMgr.InitCurAtkInfo)()
end

-- DECOMPILER ERROR at PC97: Confused about usage of register: R15 in 'UnsetPending'

BattlePlay.PlayBattleWin = function(callBack, ...)
  -- function num : 0_23
  if callBack then
    callBack()
  end
end

-- DECOMPILER ERROR at PC100: Confused about usage of register: R15 in 'UnsetPending'

BattlePlay.ClearAllPlayRes = function(...)
  -- function num : 0_24
end

-- DECOMPILER ERROR at PC103: Confused about usage of register: R15 in 'UnsetPending'

BattlePlay.PlayFlashEffect = function(card, ...)
  -- function num : 0_25 , upvalues : _ENV
  local SortingHelper = require("SortingHelper")
  if card then
    local model = card:GetModel()
    do
      local eff = (ResHelper.InstantiateEffect)(BattleEffectEnum.COMMON_TELEPORT)
      ;
      (CSLuaUtil.SetParent)(eff, model)
      ;
      (SortingHelper.SetOrderInLayer)(eff, card.sortingOrder)
      ;
      (BattlePlay.SetLayer)(eff)
      ;
      (CSLuaUtil.SetGOLocalPos)(eff, 0, 0, 0)
      local time = (LuaEffect.GetEffectDuration)(eff)
      ;
      (SimpleTimer.setTimeout)(time, function(...)
    -- function num : 0_25_0 , upvalues : _ENV, eff, SortingHelper, card
    if (BattleMgr.IsInBattle)() == false then
      return 
    end
    if eff then
      (SortingHelper.SetOrderInLayer)(eff, -card.sortingOrder)
      local FxManager = require("FxManager")
      FxManager:ResetFx(eff)
      ;
      (ResHelper.DestroyGameObject)(eff)
    end
  end
)
    end
  end
end

-- DECOMPILER ERROR at PC106: Confused about usage of register: R15 in 'UnsetPending'

BattlePlay.SetLayer = function(eff, layer, ...)
  -- function num : 0_26 , upvalues : _ENV
  if eff and eff.transform then
    local skillCamera = Game.skillCamera
    if skillCamera and skillCamera.activeSelf == true then
      if not layer then
        (CSLuaUtil.ChangeLayer)(eff.transform, LayerMaskNames.SKILL_HIGHLIGHT)
        ;
        (CSLuaUtil.ChangeLayer)(eff.transform, LayerMaskNames.DEFAULT)
      end
    end
  end
end

-- DECOMPILER ERROR at PC109: Confused about usage of register: R15 in 'UnsetPending'

BattlePlay.PlaySkillSound = function(soundStr, hitCardList, ...)
  -- function num : 0_27 , upvalues : _ENV, math, ipairs
  if IsBattleServer == true then
    return 
  end
  if soundStr and hitCardList then
    local atkInfo = BattleAtk.curAtkInfo
    if not atkInfo or not atkInfo.defCardsInfo then
      local defCardsInfo = {}
    end
    local config = (TableData.gTable).BaseSoundPathData
    local idStrTable = split(soundStr, ":")
    local callback = function(play_frame, path, bank, ...)
    -- function num : 0_27_0 , upvalues : math, _ENV
    local frame = (math.max)(0, play_frame - 10)
    ;
    (SimpleTimer.setTimeout)(frame * 0.01666, function(...)
      -- function num : 0_27_0_0 , upvalues : _ENV, bank, path
      if (BattleMgr.IsInBattle)() == false then
        return 
      end
      ;
      (LuaSound.PlaySound)("event:/Skill/" .. bank .. "/" .. path, bank)
    end
)
  end

    for _,id in ipairs(idStrTable) do
      local soundConfig = config[tonumber(id)]
      if soundConfig then
        local play_frame = soundConfig.play_frame
        local path = soundConfig.path
        local bank = soundConfig.bank
        if (string.find)(path, "_hit_") then
          for _,card in ipairs(hitCardList) do
            local isDodge = false
            for _,defCardInfo in ipairs(defCardsInfo) do
              if defCardInfo.defCardUid == card:GetCardUid() then
                isDodge = defCardInfo.isDodge
              end
            end
            if isDodge == false then
              callback(play_frame, path, bank)
            end
          end
        else
          do
            do
              callback(play_frame, path, bank)
              -- DECOMPILER ERROR at PC76: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC76: LeaveBlock: unexpected jumping out IF_ELSE_STMT

              -- DECOMPILER ERROR at PC76: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC76: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC76: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    end
  end
end


