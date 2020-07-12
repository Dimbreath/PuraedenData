-- params : ...
-- function num : 0 , upvalues : _ENV
BattleCard = {}
local FxManager, SortingHelper = nil, nil
if IsBattleServer == nil then
  FxManager = require("FxManager")
  SortingHelper = require("SortingHelper")
end
require("BattleBuffMgr")
local BattleBuffMgr = BattleBuffMgr
local BattleState = BattleState
local BattleCardState = BattleCardState
local BattleCardCamp = BattleCardCamp
local HurtNumType = HurtNumType
local BattleBuffEffectPosType = BattleBuffEffectPosType
local BattleEffectEnum = BattleEffectEnum
if not LeanTween then
  local LeanTween = {}
end
local delayedCall = LeanTween.delayedCall
local moveLocal = LeanTween.moveLocal
local tweenValue = LeanTween.value
local BattleCardFloatUpState = BattleCardFloatUpState
local Vector3 = CSLuaUtil and CSLuaUtil.Vector3 or Vector3
local ResHelper = ResHelper
if ResHelper then
  local InstantiateEffect = ResHelper.InstantiateEffect
end
if SimpleTimer then
  local setTimeout = SimpleTimer.setTimeout
end
local BattleCardPosition = BattleCardPosition
local BattleAttackType = BattleAttackType
local BattleDisplayEffect = BattleDisplayEffect
local BattleAttackMovePosType = BattleAttackMovePosType
if not SkeletonAnimationUtil then
  local SkeletonAnimationUtil = {}
end
local SetFlip = SkeletonAnimationUtil.SetFlip
local IsContainStatue = SkeletonAnimationUtil.IsContainStatue
local RemoveEvent = SkeletonAnimationUtil.RemoveEvent
local AddEvent = SkeletonAnimationUtil.AddEvent
local LayerMaskNames = LayerMaskNames
local BattleConfig = BattleConfig
if CSLuaUtil then
  local ChangeLayer = CSLuaUtil.ChangeLayer
end
local split = split
local BattleBuffDeductionRoundType = BattleBuffDeductionRoundType
local typeof = typeof
if LuaSound then
  local PlaySound = LuaSound.PlaySound
end
local BattleSkillType = BattleSkillType
local ipairs = ipairs
local t_insert = table.insert
local math = math
local baseCardData = (TableData.gTable).BaseCardData
local baseSkillShowData = (TableData.gTable).BaseSkillShowData
local baseSkillBuffEffectData = (TableData.gTable).BaseSkillBuffEffectData
-- DECOMPILER ERROR at PC92: Confused about usage of register: R41 in 'UnsetPending'

BattleCard.Initial = function(data, ...)
  -- function num : 0_0 , upvalues : BattleCardCamp, BattleCardState, BattleCardFloatUpState, _ENV, baseCardData, Vector3, BattleConfig, ResHelper, SetFlip, ChangeLayer, LayerMaskNames, BattleCardPosition, math, InstantiateEffect, BattleEffectEnum, SortingHelper, setTimeout, BattleAttackMovePosType, baseSkillShowData, BattleSkillType, IsContainStatue, ipairs, BattleBuffDeductionRoundType, RemoveEvent, HurtNumType, split, SkeletonAnimationUtil, AddEvent, FxManager, moveLocal, typeof, BattleState, baseSkillBuffEffectData, BattleBuffEffectPosType, BattleBuffMgr, t_insert, BattleDisplayEffect, BattleAttackType, delayedCall, tweenValue
  local battleCard = {}
  local isReadyAtk = false
  local campFlag = BattleCardCamp.LEFT
  local enemyCampFlag = BattleCardCamp.RIGHT
  local defaultState = BattleCardState.IDLE
  local curState = ""
  local floatUpState = BattleCardFloatUpState.NONE
  local isSummoned = false
  local foePos = nil
  local foeDamage = 0
  local totalShield = 0
  local curShield = 0
  local buffTable = {}
  local atkInfo = {}
  local model, headInfo, shadow, flagNextAttack = nil, nil, nil, nil
  local cardInfo = {}
  local bloodBuffEffectTable = {}
  local headBuffEffectTable = {}
  local bodyBuffEffectTable = {}
  local aroundBuffEffectTable = {}
  local bulletIndex = 1
  local alreayDisplayDie = false
  local cardConfig, normalSkillConfig, smallSkillConfig, uniqueSkillConfig, assistSkillConfig, fashionConfig = nil, nil, nil, nil, nil, nil
  battleCard.ClearChangeWave = function(self, ...)
    -- function num : 0_0_0 , upvalues : foePos, foeDamage
    foePos = nil
    foeDamage = 0
  end

  battleCard.SetIsSummoned = function(self, flag, ...)
    -- function num : 0_0_1 , upvalues : isSummoned
    isSummoned = flag
  end

  battleCard.GetIsSummoned = function(self, ...)
    -- function num : 0_0_2 , upvalues : isSummoned
    return isSummoned
  end

  battleCard.SetFoePos = function(self, pos, damage, ...)
    -- function num : 0_0_3 , upvalues : foeDamage, foePos
    if foeDamage < damage then
      foePos = pos
      foeDamage = damage
    end
  end

  battleCard.GetFoePos = function(self, ...)
    -- function num : 0_0_4 , upvalues : foePos
    return foePos
  end

  battleCard.ClearShield = function(self, ...)
    -- function num : 0_0_5 , upvalues : totalShield, curShield
    totalShield = 0
    curShield = 0
  end

  battleCard.SetTotalShield = function(self, value, ...)
    -- function num : 0_0_6 , upvalues : _ENV, totalShield, curShield
    if IsBattleServer == nil then
      if value + curShield <= totalShield then
        totalShield = curShield + value
        self:SetCurShield(value)
      end
    end
  end

  battleCard.GetTotalShield = function(self, ...)
    -- function num : 0_0_7 , upvalues : _ENV, totalShield
    if IsBattleServer == nil then
      return totalShield
    end
  end

  battleCard.SetCurShield = function(self, value, ...)
    -- function num : 0_0_8 , upvalues : _ENV, curShield, headInfo
    if IsBattleServer == nil then
      if value < 0 then
        loge(" 护盾减少    " .. value)
      else
        if value > 0 then
          loge(" 护盾增加    " .. value)
        end
      end
      curShield = curShield + value
      if headInfo then
        headInfo:UpdateShield(curShield, self:GetTotalShield())
      end
    end
  end

  battleCard.GetCurShield = function(self, ...)
    -- function num : 0_0_9 , upvalues : _ENV, curShield
    if IsBattleServer == nil then
      return curShield
    end
  end

  battleCard.Init = function(self, data, ...)
    -- function num : 0_0_10 , upvalues : alreayDisplayDie, cardInfo, _ENV, campFlag, BattleCardCamp, enemyCampFlag
    alreayDisplayDie = false
    cardInfo = (BattleCardInfo.Initial)(data)
    if self:GetPosIndex() > 100 then
      campFlag = BattleCardCamp.RIGHT
      enemyCampFlag = BattleCardCamp.LEFT
    end
    self.isStun = false
    self.isSilent = false
    self.isSleep = false
    self.fashionId = cardInfo:GetFashionId()
    self.isSkillHideHpBar = false
  end

  battleCard.GetAttributeLog = function(self, ...)
    -- function num : 0_0_11 , upvalues : cardInfo
    if cardInfo then
      return cardInfo:GetAttributeLog()
    end
  end

  battleCard.SetIsSkillHideHpBar = function(self, isSkillHideHpBar, ...)
    -- function num : 0_0_12
    self.isSkillHideHpBar = isSkillHideHpBar
  end

  battleCard.GetIsSkillHideHpBar = function(self, ...)
    -- function num : 0_0_13
    return self.isSkillHideHpBar
  end

  battleCard.SetIsAlreadyAtk = function(self, isAtk, isNext, ...)
    -- function num : 0_0_14 , upvalues : isReadyAtk, headInfo, flagNextAttack
    isReadyAtk = isAtk
    if headInfo then
      headInfo:UpdateAtkFlag(isAtk, isNext)
    end
    if flagNextAttack then
      if isNext == true then
        flagNextAttack:SetActive(true)
      else
        flagNextAttack:SetActive(false)
      end
    end
  end

  battleCard.ResetAtkFlag = function(self, ...)
    -- function num : 0_0_15
    self:SetIsAlreadyAtk(false)
  end

  battleCard.GetCardConfig = function(self, ...)
    -- function num : 0_0_16 , upvalues : cardConfig, baseCardData, _ENV
    do
      if cardConfig == nil then
        local cardId = self:GetCardId()
        cardConfig = baseCardData[cardId]
        if cardConfig == nil then
          cardConfig = (TableData.GetBaseMonsterData)(cardId)
        end
      end
      return cardConfig
    end
  end

  battleCard.IsBoss = function(self, ...)
    -- function num : 0_0_17 , upvalues : BattleCardCamp, _ENV
    if self:GetCampFlag() == BattleCardCamp.RIGHT and self:GetCardId() == BattleData.curWaveBossId then
      return true
    end
  end

  battleCard.GetMonsterType = function(self, ...)
    -- function num : 0_0_18 , upvalues : _ENV
    local cardId = self:GetCardId()
    local config = (TableData.GetBaseMonsterData)(cardId)
    if config and config then
      do return config.type end
    end
  end

  battleCard.GetNormalAttackConfig = function(self, ...)
    -- function num : 0_0_19 , upvalues : normalSkillConfig, _ENV
    if normalSkillConfig == nil then
      local cardConfig = self:GetCardConfig()
      if cardConfig then
        local normal_atk_skill_id = cardConfig.normal_atk_skill_id
        normalSkillConfig = (TableData.GetBaseSkillData)(normal_atk_skill_id)
      end
    end
    do
      return normalSkillConfig
    end
  end

  battleCard.GetSmallSkillConfig = function(self, ...)
    -- function num : 0_0_20 , upvalues : smallSkillConfig, _ENV
    if smallSkillConfig == nil then
      local cardConfig = self:GetCardConfig()
      if cardConfig then
        local special_skill_id = cardConfig.special_skill_id
        smallSkillConfig = (TableData.GetBaseSkillData)(special_skill_id)
      end
    end
    do
      return smallSkillConfig
    end
  end

  battleCard.GetSkillConfig = function(self, ...)
    -- function num : 0_0_21 , upvalues : uniqueSkillConfig, _ENV
    if uniqueSkillConfig == nil then
      local cardConfig = self:GetCardConfig()
      if cardConfig then
        local unique_skill_id = cardConfig.unique_skill_id
        uniqueSkillConfig = (TableData.GetBaseSkillData)(unique_skill_id)
      end
    end
    do
      return uniqueSkillConfig
    end
  end

  battleCard.GetAssistSkillConfig = function(self, ...)
    -- function num : 0_0_22 , upvalues : assistSkillConfig, _ENV
    if assistSkillConfig == nil then
      local cardConfig = self:GetCardConfig()
      if cardConfig then
        local assist_skill_id = cardConfig.assist_skill_id
        assistSkillConfig = (TableData.GetBaseSkillData)(assist_skill_id)
      end
    end
    do
      return assistSkillConfig
    end
  end

  battleCard.GetFashionConfig = function(self, ...)
    -- function num : 0_0_23 , upvalues : fashionConfig, _ENV
    do
      if fashionConfig == nil then
        local fashionId = self:GetFashionId()
        if fashionId then
          fashionConfig = ((TableData.gTable).BaseFashionData)[fashionId]
        end
      end
      return fashionConfig
    end
  end

  battleCard.GetBulletStartPosition = function(self, ...)
    -- function num : 0_0_24 , upvalues : BattleCardCamp, Vector3
    local position = self.curPosition
    if self:GetCampFlag() == BattleCardCamp.LEFT then
      return position + Vector3(4, 6, 0)
    else
      return position + Vector3(-4, 6, 0)
    end
  end

  battleCard.GetBulletEndPosition = function(self, ...)
    -- function num : 0_0_25 , upvalues : Vector3
    local position = self.curPosition
    return position + Vector3(0, 6, 0)
  end

  battleCard.SetCurPosition = function(self, curPosition, ...)
    -- function num : 0_0_26
    self.curPosition = curPosition
  end

  battleCard.GetCurPosition = function(self, ...)
    -- function num : 0_0_27
    return self.curPosition
  end

  battleCard.CreateCard = function(self, ...)
    -- function num : 0_0_28 , upvalues : BattleConfig, _ENV, model, ResHelper, campFlag, BattleCardCamp, SetFlip, ChangeLayer, LayerMaskNames, BattleCardPosition, math, defaultState, headInfo, shadow, InstantiateEffect, BattleEffectEnum, SortingHelper, flagNextAttack, isSummoned
    local BattleConfig = BattleConfig
    local scale = BattleConfig.cardScale
    local spdName = (CardMgr.GetSpdBundle)({fashionId = self.fashionId, id = self:GetCardId(), quality = self:GetQuality()})
    model = (ResHelper.InstantiateModel)(spdName)
    ;
    (CSLuaUtil.SetParent)(model, BattleRoot)
    if campFlag == BattleCardCamp.RIGHT then
      SetFlip(model, true, false)
    else
      SetFlip(model, false, false)
    end
    local fashion = self:GetFashionConfig()
    if fashion and fashion.scale then
      scale = scale * fashion.scale / 10000
    end
    ;
    (CSLuaUtil.SetGOScale)(model, scale, scale, scale)
    ChangeLayer(model.transform, LayerMaskNames.MODEL)
    self.position = (BattleCardPosition[self:GetPosIndex()]).pos + BattleConfig.cardPositionOff
    ;
    (CSLuaUtil.SetGOLocalPos)(model, self.position)
    self.curPosition = self.position
    local battleCamera = Game.battleCamera
    local cameraRotation = (battleCamera.transform).localEulerAngles
    ;
    (CSLuaUtil.SetGOLocalEuler)(model, cameraRotation.x, 0, 0)
    self.sortingOrder = BattleConfig.sortingOrderInit + (math.floor)(self:GetPosIndex() % 10) * 10
    local campFlag = self:GetCampFlag()
    self.frontPos = self.position + BattleConfig.frontPosXOff
    self.behindPos = self.position - BattleConfig.frontPosXOff
    self.frontPos_far_1 = self.position + BattleConfig.frontPosXOff_far_1
    self.behindPos_far_1 = self.position - BattleConfig.frontPosXOff_far_1
    self.frontPos_far_2 = self.position + BattleConfig.frontPosXOff_far_2
    self.behindPos_far_2 = self.position - BattleConfig.frontPosXOff_far_2
    self.damageSharePos = self.position + BattleConfig.damageShareFrontPosXOff
    if campFlag == BattleCardCamp.RIGHT then
      self.frontPos = self.position - BattleConfig.frontPosXOff
      self.behindPos = self.position + BattleConfig.frontPosXOff
      self.frontPos_far_1 = self.position - BattleConfig.frontPosXOff_far_1
      self.behindPos_far_1 = self.position + BattleConfig.frontPosXOff_far_1
      self.frontPos_far_2 = self.position - BattleConfig.frontPosXOff_far_2
      self.behindPos_far_2 = self.position + BattleConfig.frontPosXOff_far_2
      self.damageSharePos = self.position - BattleConfig.damageShareFrontPosXOff
    end
    self:ChangeState(defaultState, true, nil, campFlag == BattleCardCamp.RIGHT)
    headInfo = (BattleCardHeadInfo.BindInfo)(self)
    self:UpdateHeadInfoVisible()
    self:SetSortingOrder(self.sortingOrder)
    local monsterType = self:GetMonsterType()
    if monsterType then
      headInfo:SetMonsterType(monsterType)
    end
    shadow = InstantiateEffect(BattleEffectEnum.COMMON_SHADOW)
    ;
    (CSLuaUtil.SetParent)(shadow, BattleRoot)
    ;
    (CSLuaUtil.SetGOLocalPos)(shadow, model)
    ;
    (SortingHelper.SetOrderInLayer)(shadow, BattleConfig.sortingOrderInit)
    flagNextAttack = InstantiateEffect(BattleEffectEnum.COMMON_LEAD)
    ChangeLayer(flagNextAttack.transform, LayerMaskNames.DEFAULT)
    flagNextAttack:SetActive(false)
    ;
    (CSLuaUtil.SetParent)(flagNextAttack, BattleRoot)
    ;
    (CSLuaUtil.SetGOLocalPos)(flagNextAttack, model)
    ;
    (SortingHelper.SetOrderInLayer)(flagNextAttack, BattleConfig.sortingOrderInit + 1)
    if isSummoned == false then
      self:ResetAtkFlag()
    end
    self:PlayCreateEffect()
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
  end

  battleCard.PlayCreateEffect = function(self, ...)
    -- function num : 0_0_29 , upvalues : InstantiateEffect, _ENV, SortingHelper, setTimeout, ResHelper
    local config = self:GetCardConfig()
    if config.summon_effect then
      local eff = InstantiateEffect(config.summon_effect)
      do
        (CSLuaUtil.SetParent)(eff, BattleRoot)
        ;
        (BattlePlay.SetLayer)(eff)
        ;
        (SortingHelper.SetOrderInLayer)(eff, self.sortingOrder)
        ;
        (CSLuaUtil.SetGOLocalPos)(eff, self.position)
        local time = (LuaEffect.GetEffectDuration)(eff)
        setTimeout(time, function(...)
      -- function num : 0_0_29_0 , upvalues : _ENV, eff, SortingHelper, self, ResHelper
      if (BattleMgr.IsInBattle)() == false then
        return 
      end
      if eff then
        (SortingHelper.SetOrderInLayer)(eff, -self.sortingOrder)
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

  battleCard.GetHitTargetPosition = function(self, targetCard, targetSelf, ...)
    -- function num : 0_0_30 , upvalues : BattleAttackMovePosType, BattleConfig, _ENV, atkInfo, BattleCardCamp, Vector3
    local targetPosition, shadowPosition = nil, nil
    if self.movePosType == BattleAttackMovePosType.SCREEN_CENTER then
      targetPosition = BattleConfig.cardPositionOff
      shadowPosition = targetPosition
    else
      if self.movePosType == BattleAttackMovePosType.TARGET_CARD or self.movePosType == BattleAttackMovePosType.TARGET_CARD_FAR_1 or self.movePosType == BattleAttackMovePosType.TARGET_CARD_FAR_2 then
        local campFlag = (targetCard:GetCampFlag())
        local nextTime, position = nil, nil
        if targetCard:IsFloatUp() == true then
          nextTime = (BattlePlay.GetNextAttackTime)(atkInfo, self, targetCard, true)
          position = (BattlePlay.GetCardPosition)(targetCard, nextTime)
          if position.y <= (targetCard.position).y then
            nextTime = (BattlePlay.GetNextAttackTime)(atkInfo, self, targetCard, false)
            position = (BattlePlay.GetCardPosition)(targetCard, nextTime)
          end
        else
          nextTime = (BattlePlay.GetNextAttackTime)(atkInfo, self, targetCard, false)
          position = (BattlePlay.GetCardPosition)(targetCard, nextTime)
        end
        local scale = 1
        if targetSelf == true then
          scale = -1
        end
        local off = BattleConfig.frontPosXOff
        shadowPosition = targetCard.frontPos
        if targetSelf == true then
          shadowPosition = targetCard.behindPos
        end
        if self.movePosType == BattleAttackMovePosType.TARGET_CARD_FAR_1 then
          off = BattleConfig.frontPosXOff_far_1
          shadowPosition = targetCard.frontPos_far_1
          if targetSelf == true then
            shadowPosition = targetCard.behindPos_far_1
          end
        else
          if self.movePosType == BattleAttackMovePosType.TARGET_CARD_FAR_2 then
            off = BattleConfig.frontPosXOff_far_2
            shadowPosition = targetCard.frontPos_far_2
            if targetSelf == true then
              shadowPosition = targetCard.behindPos_far_2
            end
          end
        end
        if campFlag == BattleCardCamp.RIGHT then
          targetPosition = position - off * scale
        else
          targetPosition = position + off * scale
        end
      else
        do
          if self.movePosType == BattleAttackMovePosType.TARGET_CARD_LINE then
            local targetPosIndex = targetCard:GetPosIndex()
            local index = targetPosIndex % 10
            targetPosition = (2 - index) * Vector3(0, 0, 25) + BattleConfig.cardPositionOff
            shadowPosition = targetPosition
          end
          do
            return targetPosition, shadowPosition
          end
        end
      end
    end
  end

  battleCard.GetDamageSharePosition = function(self, targetCard, ...)
    -- function num : 0_0_31
    return targetCard.damageSharePos
  end

  battleCard.SetAttackType = function(self, attackType, ...)
    -- function num : 0_0_32
    self.attackType = attackType
  end

  battleCard.SetMovePosType = function(self, movePosType, ...)
    -- function num : 0_0_33
    self.movePosType = movePosType
  end

  battleCard.RunToTargetCard = function(self, targetCards, atkEndCallBack, allEndCallBack, ...)
    -- function num : 0_0_34 , upvalues : BattleCardState, shadow, _ENV, flagNextAttack, battleCard, model, atkInfo
    local targetCard = targetCards[1]
    if not targetCard and allEndCallBack then
      allEndCallBack()
    end
    do return  end
    self:ChangeState(BattleCardState.RUN, true)
    local targetPosition, shadowPosition = self:GetHitTargetPosition(targetCard)
    if shadow then
      (Util.MoveTo)(shadow, shadowPosition)
    end
    if flagNextAttack then
      (Util.MoveTo)(flagNextAttack, shadowPosition)
    end
    if self.curPosition == targetPosition then
      self.curPosition = targetPosition
      self:SetSortingOrder(targetCard.sortingOrder + 2)
      battleCard:Attack(targetCards, atkEndCallBack, allEndCallBack)
    else
      ;
      (Util.MoveTo)(model, targetPosition, nil, function(...)
      -- function num : 0_0_34_0 , upvalues : self, targetPosition, targetCard, battleCard, targetCards, atkEndCallBack, allEndCallBack
      self.curPosition = targetPosition
      self:SetSortingOrder(targetCard.sortingOrder + 2)
      battleCard:Attack(targetCards, atkEndCallBack, allEndCallBack)
    end
, atkInfo.moveCamera)
    end
  end

  battleCard.JumpToTargetCard = function(self, targetCards, atkEndCallBack, allEndCallBack, ...)
    -- function num : 0_0_35 , upvalues : atkInfo, _ENV, model, BattleCardState, shadow, flagNextAttack, battleCard
    local targetCard = targetCards[1]
    if not targetCard and allEndCallBack then
      allEndCallBack()
    end
    do return  end
    local targetSelf = atkInfo.targetSelf
    local localPosition = (CSLuaUtil.GetGOLocalPos)(model)
    local curPosX = localPosition.x
    local targetPosition, shadowPosition = self:GetHitTargetPosition(targetCard, targetSelf)
    local targetPosX = targetPosition.x
    if targetSelf == true then
      if targetPosX <= curPosX then
        self:ChangeState(BattleCardState.JUMP_F, true)
      else
        self:ChangeState(BattleCardState.JUMP_B, true)
      end
    else
      self:ChangeState(BattleCardState.JUMP_F, true)
    end
    if shadow then
      (Util.JumpTo)(shadow, shadowPosition, nil, nil, 0)
    end
    if flagNextAttack then
      (Util.JumpTo)(flagNextAttack, shadowPosition, nil, nil, 0)
    end
    local targetFloat = (targetCard.position).y < targetPosition.y
    if self.curPosition == targetPosition then
      self.curPosition = targetPosition
      self:SetSortingOrder(targetCard.sortingOrder + 2)
      battleCard:Attack(targetCards, atkEndCallBack, allEndCallBack, targetFloat)
    else
      (Util.JumpTo)(model, targetPosition, nil, function(...)
      -- function num : 0_0_35_0 , upvalues : self, targetPosition, targetCard, battleCard, targetCards, atkEndCallBack, allEndCallBack, targetFloat
      self.curPosition = targetPosition
      self:SetSortingOrder(targetCard.sortingOrder + 2)
      battleCard:Attack(targetCards, atkEndCallBack, allEndCallBack, targetFloat)
    end
, nil, atkInfo.moveCamera)
    end
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
  end

  battleCard.JumpToDamageShareCard = function(self, targetCard, callBack, ...)
    -- function num : 0_0_36 , upvalues : _ENV, model, BattleCardState, shadow, flagNextAttack
    local targetPosition = self:GetDamageSharePosition(targetCard)
    local localPosition = (CSLuaUtil.GetGOLocalPos)(model)
    local curPosX = localPosition.x
    local targetPosX = targetPosition.x
    if targetPosX <= curPosX then
      self:ChangeState(BattleCardState.JUMP_F, true)
    else
      self:ChangeState(BattleCardState.JUMP_B, true)
    end
    if shadow then
      (Util.JumpTo)(shadow, targetPosition, nil, nil, 0)
    end
    if flagNextAttack then
      (Util.JumpTo)(flagNextAttack, targetPosition, nil, nil, 0)
    end
    ;
    (Util.JumpTo)(model, targetPosition, nil, function(...)
      -- function num : 0_0_36_0 , upvalues : self, targetPosition, targetCard, callBack
      self.curPosition = targetPosition
      self:Stand()
      self:SetSortingOrder(targetCard.sortingOrder + 1)
      if callBack then
        callBack()
      end
    end
)
  end

  battleCard.FlashToTargetCard = function(self, targetCards, atkEndCallBack, allEndCallBack, ...)
    -- function num : 0_0_37 , upvalues : _ENV, battleCard, setTimeout, BattleConfig, model, shadow, flagNextAttack
    local targetCard = targetCards[1]
    if not targetCard and allEndCallBack then
      allEndCallBack()
    end
    do return  end
    ;
    (BattlePlay.PlayFlashEffect)(self)
    local targetPosition, shadowPosition = self:GetHitTargetPosition(targetCard)
    if self.curPosition == targetPosition then
      self.curPosition = targetPosition
      self:SetSortingOrder(targetCard.sortingOrder + 2)
      battleCard:Attack(targetCards, atkEndCallBack, allEndCallBack)
    else
      setTimeout(BattleConfig.flashInterval, function(...)
      -- function num : 0_0_37_0 , upvalues : _ENV, model, targetPosition, self, shadow, shadowPosition, flagNextAttack, targetCard, battleCard, targetCards, atkEndCallBack, allEndCallBack
      (CSLuaUtil.SetGOLocalPos)(model, targetPosition)
      self.curPosition = targetPosition
      if shadow then
        (CSLuaUtil.SetGOLocalPos)(shadow, shadowPosition)
      end
      if flagNextAttack then
        (CSLuaUtil.SetGOLocalPos)(flagNextAttack, shadowPosition)
      end
      self:SetSortingOrder(targetCard.sortingOrder + 2)
      battleCard:Attack(targetCards, atkEndCallBack, allEndCallBack)
    end
)
    end
  end

  battleCard.SetVisible = function(self, visible, ...)
    -- function num : 0_0_38 , upvalues : model, shadow
    if model then
      model:SetActive(visible)
    end
    if shadow then
      shadow:SetActive(visible)
    end
  end

  battleCard.GetAttackSpdAndEffect = function(self, atkInfo, targetCards, targetFloat, ...)
    -- function num : 0_0_39 , upvalues : BattleCardState, _ENV, baseSkillShowData, BattleSkillType, IsContainStatue, model
    local atkFail = atkInfo.atkFail
    if atkFail then
      return BattleCardState.IDLE
    end
    local skillId = atkInfo.skillId
    local skillConfig = (TableData.GetBaseSkillData)(skillId)
    local skillType = skillConfig.type
    local fashionId = self:GetFashionId()
    local show_id = (BattleSkill.GetSkillShowId)(fashionId, skillType)
    local skillShowConfig = baseSkillShowData[show_id]
    local isTargetFloat = false
    local targetCard = targetCards[1]
    if targetCard ~= nil then
      isTargetFloat = targetFloat
      print("敌方是否被击飞：", tostring(isTargetFloat), " 位置：", targetCard:GetPosIndex())
    end
    local attackSpd = BattleCardState.ATTACK
    local effect_name = skillShowConfig.effect_attack
    local effect_name_target = skillShowConfig.effect_attack_target
    local bullet_config = nil
    if skillShowConfig.bullet_effect and skillShowConfig.bullet_effect ~= "" then
      bullet_config = {bullet_effect = skillShowConfig.bullet_effect, bullet_fly_time_scale = skillShowConfig.bullet_fly_time_scale}
    end
    local isTreatment = atkInfo.isTreatment
    if skillConfig.type == BattleSkillType.SMALL then
      attackSpd = BattleCardState.SKILL
      effect_name = skillShowConfig.effect_attack
    else
      if skillConfig.type == BattleSkillType.SKILL then
        attackSpd = BattleCardState.UNIQUE_SKILL
        effect_name = skillShowConfig.effect_attack
      else
      end
    end
    if ((isTreatment == true and not isTargetFloat) or (IsContainStatue(model, BattleCardState.ATTACK_AIR) and BattleCardState.ATTACK_AIR) or not skillShowConfig.effect_attack_air) then
      effect_name_target = nil
    end
    return attackSpd, effect_name, effect_name_target, bullet_config, skillShowConfig
  end

  battleCard.Attack = function(self, targetCards, atkEndCallBack, allEndCallBack, targetFloat, ...)
    -- function num : 0_0_40 , upvalues : atkInfo, _ENV, BattleSkillType, ipairs, BattleBuffDeductionRoundType, RemoveEvent, model, HurtNumType, setTimeout, baseSkillShowData, split, SkeletonAnimationUtil, math, bulletIndex, AddEvent
    local hurtTableList, danderDefList = nil, nil
    local totalDefCards = {}
    local skillId = atkInfo.skillId
    local skillConfig = ((TableData.GetBaseSkillData)(skillId))
    local skillType = nil
    if skillConfig then
      skillType = skillConfig.type
      if skillType == BattleSkillType.ASSIST then
        ShowBuffWord(BattleBuffWordType.ASSIST, self)
      end
    end
    local attackSpd, effect_name, effect_name_target, bullet_config, skillShowConfig = self:GetAttackSpdAndEffect(atkInfo, targetCards, targetFloat)
    if effect_name then
      self:PlayAtkEffect(effect_name)
    end
    do
      if skillShowConfig then
        local skill_sound = skillShowConfig.skill_sound
        if targetFloat == true then
          skill_sound = skillShowConfig.skill_sound_air
        end
        if skill_sound and skill_sound ~= "" then
          (BattlePlay.PlaySkillSound)(skill_sound, targetCards)
        end
      end
      if effect_name_target then
        for _,targetCard in ipairs(targetCards) do
          targetCard:PlayAtkEffect(effect_name_target, true, true)
        end
      end
      do
        local noAtkAction = atkInfo.noAtkAction
        local atkFail = atkInfo.atkFail
        if atkFail ~= true then
          local fashionId = self:GetFashionId()
          if skillType == BattleSkillType.NORMAL then
            (AudioManager.PlayBattleVoice)(fashionId, CVAudioType.AttackBubble)
          else
            if skillType == BattleSkillType.SKILL then
              local showId = (BattleSkill.GetSkillShowId)(fashionId, skillConfig.type)
              local showConfig = ((TableData.gTable).BaseSkillShowData)[showId]
              local card_show = showConfig.card_show
            end
          end
        end
        if card_show and card_show ~= 0 then
          do
            (AudioManager.PlayBattleVoice)(fashionId, CVAudioType.UniqueSkillBubble)
            local attackCallBack = function(...)
      -- function num : 0_0_40_0 , upvalues : _ENV, self, atkInfo, atkEndCallBack, allEndCallBack, ipairs, totalDefCards, danderDefList, BattleBuffDeductionRoundType
      loge("出手结束 位置：  " .. self:GetPosIndex())
      local nextIsDouble = false
      if atkInfo.isDoubleAttack == false and #atkInfo.doubleAtkInfo > 0 then
        nextIsDouble = true
      end
      if atkEndCallBack then
        atkEndCallBack()
      end
      if nextIsDouble == true then
        return 
      end
      self:MoveBack(function(...)
        -- function num : 0_0_40_0_0 , upvalues : self, allEndCallBack
        self:DealAfterAtk()
        if allEndCallBack then
          allEndCallBack()
        end
      end
)
      self:ChangeDander(atkInfo.danderAtk)
      for i,targetCard in ipairs(totalDefCards) do
        if danderDefList then
          targetCard:ChangeDander(danderDefList[i])
        end
        if targetCard:GetPosIndex() ~= self:GetPosIndex() then
          (BattlePlay.PlayBuff)(atkInfo, targetCard, BattleBuffDeductionRoundType.AFTER_HIT)
        end
      end
    end

            local lastAttackEventCallback = function(...)
      -- function num : 0_0_40_1 , upvalues : self, RemoveEvent, model
      self:ClearHurtInfo()
      RemoveEvent(model, self.AttackEvent)
    end

            if noAtkAction == true then
              loge("noAtkAction")
              self:ChangeState(attackSpd, false, function(...)
      -- function num : 0_0_40_2 , upvalues : attackCallBack, self
      if attackCallBack then
        attackCallBack()
      end
      self:DealAfterAtk()
    end
)
              return 
            end
            if atkFail == true then
              loge("atkFail")
              if self:IsDisplayAlive() == true then
                ShowHurtNum(HurtNumType.MOVE_FAIL, 0, self)
                setTimeout(0.6, function(...)
      -- function num : 0_0_40_3 , upvalues : attackCallBack, self
      if attackCallBack then
        attackCallBack()
        self:DealAfterAtk()
      end
    end
)
              else
                if atkEndCallBack then
                  atkEndCallBack()
                end
                self:DealAfterAtk()
                if allEndCallBack then
                  allEndCallBack()
                end
              end
              return 
            end
            self:ChangeState(attackSpd, false, function(...)
      -- function num : 0_0_40_4 , upvalues : attackCallBack
      if attackCallBack then
        attackCallBack()
      end
    end
)
            local defCardsInfo = atkInfo.defCardsInfo
            local fashionId = self:GetFashionId()
            local showId = (BattleSkill.GetSkillShowId)(fashionId, skillType)
            local showConfig = baseSkillShowData[showId]
            local hurtSection = showConfig.hurt_section
            local hurtSectionTable = split(hurtSection, ":")
            local count = (SkeletonAnimationUtil.GetEventCount)(model, "attack", attackSpd)
            if count == 0 and bullet_config then
              count = (SkeletonAnimationUtil.GetEventCount)(model, "bullet", attackSpd)
            end
            local realSectionCount = (math.min)(count, #hurtSectionTable)
            local totalPercent = 0
            for i = 1, realSectionCount do
              totalPercent = totalPercent + (hurtSectionTable[i] or 0)
            end
            hurtTableList = (BattleUtil.SplitHurt)(defCardsInfo, realSectionCount, hurtSectionTable, totalPercent)
            self.hurtInfo = {hurtIndex = 1, targetCards = totalDefCards, hurtTableList = hurtTableList, atkInfo = atkInfo, lastAttackEventCallback = lastAttackEventCallback, bullet_config = bullet_config}
            bulletIndex = 1
            loge("  AddEvent   ")
            AddEvent(model, self.AttackEvent)
          end
        end
      end
    end
  end

  battleCard.GetFlyTime = function(self, targetCard, ...)
    -- function num : 0_0_41
    local flyTime = 0.3
    local startPosIndex = self:GetPosIndex()
    local endPosIndex = targetCard:GetPosIndex()
    if self.curPosition ~= self.position then
      flyTime = 0.15
      return flyTime
    end
    if startPosIndex % 100 < 10 and endPosIndex % 100 < 10 then
      flyTime = 0.2
    else
      if (startPosIndex % 100 < 10 and endPosIndex % 100 > 10) or startPosIndex % 100 > 10 and endPosIndex % 100 < 10 then
        flyTime = 0.25
      else
        if startPosIndex % 100 > 10 and endPosIndex % 100 > 10 then
          flyTime = 0.3
        end
      end
    end
    return flyTime
  end

  battleCard.AttackEvent = function(trackEntry, event, ...)
    -- function num : 0_0_42 , upvalues : battleCard, split, ipairs, bulletIndex, setTimeout, _ENV, atkInfo, BattleSkillType, BattleConfig, BattleCardFloatUpState
    if (event.Data).Name ~= "attack_sound" or (event.Data).Name == "bullet" then
      local hurtInfo = battleCard.hurtInfo
      if hurtInfo then
        local bullet_config = hurtInfo.bullet_config
      end
      if hurtInfo then
        local targetCards = hurtInfo.targetCards
      end
      if bullet_config then
        local bullet_effect = bullet_config.bullet_effect
        local bullet_fly_time_scale = bullet_config.bullet_fly_time_scale
        if bullet_effect and bullet_effect ~= "0" then
          bullet_effect = split(bullet_effect, "|")
          for i,targetCard in ipairs(targetCards) do
            local bullet_fly_time = battleCard:GetFlyTime(targetCard) * bullet_fly_time_scale / 10000
            if not bullet_effect[bulletIndex] then
              do
                battleCard:PlayBulletEffect(bullet_effect[#bullet_effect], targetCard:GetBulletEndPosition(), bullet_fly_time)
                setTimeout(bullet_fly_time, function(...)
      -- function num : 0_0_42_0 , upvalues : _ENV, battleCard, trackEntry
      if (BattleMgr.IsInBattle)() == false then
        return 
      end
      ;
      (battleCard.AttackEvent)(trackEntry, {
Data = {Name = "attack"}
})
    end
)
                -- DECOMPILER ERROR at PC55: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC55: LeaveBlock: unexpected jumping out IF_STMT

              end
            end
          end
        end
      end
      do
        do
          bulletIndex = bulletIndex + 1
          if (event.Data).Name == "attack" then
            loge("攻击者位置：" .. battleCard:GetPosIndex())
            local atkInfo = atkInfo
            do
              local lastAtk = atkInfo.lastAtk
              local hurtInfo = battleCard.hurtInfo
              if hurtInfo then
                local callBack = hurtInfo.callBack
              end
              if hurtInfo then
                local lastAttackEventCallback = hurtInfo.lastAttackEventCallback
              end
              if not hurtInfo or not hurtInfo.targetCards then
                local targetCards = {}
              end
              if hurtInfo then
                local hurtTableList = hurtInfo.hurtTableList
              end
              local isTreatment = atkInfo.isTreatment
              for i,targetCard in ipairs(targetCards) do
                local hurtTable = hurtTableList[i]
                local hurtData = hurtTable[hurtInfo.hurtIndex]
                if hurtData then
                  local hurtHp = hurtData.hurt
                  if #hurtTable > hurtInfo.hurtIndex then
                    do
                      targetCard:ChangeHp(hurtData, hurtInfo.atkInfo, nil, nil, atkInfo.skillType ~= BattleSkillType.ASSIST)
                      targetCard:ChangeHp(hurtData, hurtInfo.atkInfo, nil, nil, #hurtTable <= hurtInfo.hurtIndex, hurtInfo.hurtIndex)
                      targetCard.speedUp = nil
                      if hurtInfo.hurtIndex == 1 then
                        (BattlePlay.PlayBuff)(atkInfo, nil, nil, BattleBuffSettleRoundType.BEFORE_ATTACK, BattlePlaySettleRoundType.FIRST_ATTACK)
                      end
                      targetCard:PlayHitEffect(atkInfo, false, hurtInfo.hurtIndex, event.String)
                      if #hurtTable <= hurtInfo.hurtIndex then
                        if not atkInfo or atkInfo.atkCardUid ~= targetCard:GetCardUid() then
                          if isTreatment == false then
                            if not BattleConfig.autoStrike then
                              local isStrike = atkInfo.isStrike
                            end
                            if isStrike then
                              targetCard:FloatUp(atkInfo.lastAtk)
                            elseif lastAtk then
                              if targetCard:GetFloatUpState() == BattleCardFloatUpState.NONE then
                                setTimeout(0.4, function(...)
      -- function num : 0_0_42_1 , upvalues : targetCard
      targetCard:DealAfterAtk()
    end
)
                              elseif atkInfo.isFall then
                                targetCard:FloatDown(true)
                              else
                                targetCard:FloatUp(true)
                              end
                            elseif targetCard:IsFloatUp() == true then
                              targetCard:FloatUp(false)
                            end
                          else
                            (BattleAtk.SetWaitActionCardState)(targetCard:GetPosIndex(), true)
                          end
                        end
                        if callBack then
                          log("攻击结束回调")
                          callBack()
                          callBack = nil
                        end
                        if lastAttackEventCallback then
                          log("本次出手最后一次攻击结束 攻击者位置：" .. battleCard:GetPosIndex())
                          lastAttackEventCallback()
                          lastAttackEventCallback = nil
                        end
                      end
                      -- DECOMPILER ERROR at PC229: LeaveBlock: unexpected jumping out IF_THEN_STMT

                      -- DECOMPILER ERROR at PC229: LeaveBlock: unexpected jumping out IF_STMT

                      -- DECOMPILER ERROR at PC229: LeaveBlock: unexpected jumping out IF_THEN_STMT

                      -- DECOMPILER ERROR at PC229: LeaveBlock: unexpected jumping out IF_STMT

                    end
                  end
                end
              end
              if hurtInfo then
                do
                  hurtInfo.hurtIndex = hurtInfo.hurtIndex + 1
                  -- DECOMPILER ERROR at PC236: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC236: LeaveBlock: unexpected jumping out IF_STMT

                end
              end
            end
          end
          -- DECOMPILER ERROR: 16 unprocessed JMP targets
        end
      end
    end
  end

  battleCard.PlayBulletEffect = function(self, effect_name, targetPosition, flyTime, ...)
    -- function num : 0_0_43 , upvalues : InstantiateEffect, _ENV, campFlag, BattleCardCamp, FxManager, SortingHelper, math, moveLocal, ResHelper
    if effect_name == nil or effect_name == "" then
      return 
    end
    local eff = InstantiateEffect(effect_name)
    ;
    (CSLuaUtil.SetParent)(eff, BattleRoot)
    ;
    (BattlePlay.SetLayer)(eff)
    if campFlag == BattleCardCamp.LEFT then
      FxManager:ResetFx(eff)
    else
      FxManager:Overturn(eff)
    end
    ;
    (SortingHelper.SetOrderInLayer)(eff, self.sortingOrder)
    ;
    (CSLuaUtil.SetGOLocalPos)(eff, self:GetBulletStartPosition())
    local curPosition = self.curPosition
    local rotationY = (math.atan)((targetPosition.z - curPosition.z) / (targetPosition.x - curPosition.x))
    ;
    (CSLuaUtil.SetGOLocalEuler)(eff, 0, -rotationY * 180 / math.pi, 0)
    ;
    (moveLocal(eff, targetPosition, flyTime)):setOnComplete(function(...)
      -- function num : 0_0_43_0 , upvalues : _ENV, eff, SortingHelper, self, ResHelper
      if (BattleMgr.IsInBattle)() == false then
        return 
      end
      if eff then
        (SortingHelper.SetOrderInLayer)(eff, -self.sortingOrder)
        local FxManager = require("FxManager")
        FxManager:ResetFx(eff)
        ;
        (ResHelper.DestroyGameObject)(eff)
      end
    end
)
  end

  battleCard.PlayAtkEffect = function(self, effect_name, isOverturn, originPosition, ...)
    -- function num : 0_0_44 , upvalues : InstantiateEffect, _ENV, campFlag, BattleCardCamp, FxManager, SortingHelper, model, setTimeout, ResHelper
    if effect_name == nil or effect_name == "" then
      return 
    end
    local eff = InstantiateEffect(effect_name)
    ;
    (CSLuaUtil.SetParent)(eff, BattleRoot)
    ;
    (BattlePlay.SetLayer)(eff)
    if campFlag == BattleCardCamp.LEFT then
      if isOverturn == true then
        FxManager:Overturn(eff)
      else
        FxManager:ResetFx(eff)
      end
    else
      if isOverturn ~= true then
        FxManager:Overturn(eff)
      else
        FxManager:ResetFx(eff)
      end
    end
    ;
    (SortingHelper.SetOrderInLayer)(eff, self.sortingOrder)
    if originPosition == true then
      (CSLuaUtil.SetGOLocalPos)(eff, self.position)
    else
      ;
      (CSLuaUtil.SetGOLocalPos)(eff, model)
    end
    local time = (LuaEffect.GetEffectDuration)(eff)
    setTimeout(time, function(...)
      -- function num : 0_0_44_0 , upvalues : _ENV, eff, SortingHelper, self, ResHelper
      if (BattleMgr.IsInBattle)() == false then
        return 
      end
      if eff then
        (SortingHelper.SetOrderInLayer)(eff, -self.sortingOrder)
        local FxManager = require("FxManager")
        FxManager:ResetFx(eff)
        ;
        (ResHelper.DestroyGameObject)(eff)
      end
    end
)
  end

  battleCard.PlayHitEffect = function(self, atkInfo, isUniqueSkill, hurtIndex, soundString, hitEffect, ...)
    -- function num : 0_0_45 , upvalues : BattleSkillType, _ENV, baseSkillShowData, split, InstantiateEffect, LayerMaskNames, ipairs, BattleEffectEnum, campFlag, BattleCardCamp, FxManager, SortingHelper, BattleConfig, model, setTimeout, ResHelper
    local skillType = atkInfo.skillType
    do
      if skillType == BattleSkillType.NORMAL or skillType == BattleSkillType.ASSIST then
        local ShakeAnimPlay = require("ShakeAnimPlay")
        ;
        (ShakeAnimPlay.PlayShake)("shake000", Game.battleCamera)
      end
      local atkCard = ((BattleData.GetCardInfoByPos)(atkInfo.atkPos))
      local hitEffectStrTable = nil
      local skillId = atkInfo.skillId
      local skillConfig = (TableData.GetBaseSkillData)(skillId)
      local skillType = skillConfig.type
      local fashionId = atkCard:GetFashionId()
      local showId = (BattleSkill.GetSkillShowId)(fashionId, skillType)
      local skillShowConfig = baseSkillShowData[showId]
      local hitEffectStr = nil
      do
        if skillShowConfig then
          if skillShowConfig.effect_attack_hit and skillShowConfig.effect_attack_hit ~= "" then
            hitEffectStrTable = split(skillShowConfig.effect_attack_hit, "|")
            if #hitEffectStrTable > 1 then
              if not hitEffectStrTable[hurtIndex] then
                hitEffectStr = hitEffectStrTable[#hitEffectStrTable]
                hitEffectStr = skillShowConfig.effect_attack_hit
                loge(showId)
                loge(self:IsFloatUp())
                loge(skillShowConfig.effect_attack_air_hit)
                if self:IsFloatUp() == true and skillShowConfig.effect_attack_air_hit and skillShowConfig.effect_attack_air_hit ~= "" then
                  hitEffectStr = skillShowConfig.effect_attack_air_hit
                end
                if ((isUniqueSkill and not hitEffect and SkillScript and SkillScript.hitEffect) or hitEffectStr) and hitEffectStr ~= "none" then
                  local eff = InstantiateEffect(hitEffectStr)
                  ;
                  (CSLuaUtil.SetParent)(eff, BattleRoot)
                  if isUniqueSkill then
                    (CSLuaUtil.ChangeLayer)(eff.transform, LayerMaskNames.SKILL_EFFECT)
                  else
                    ;
                    (BattlePlay.SetLayer)(eff)
                  end
                  local isBlock = false
                  local defCardsInfo = atkInfo.defCardsInfo
                  for i,v in ipairs(defCardsInfo) do
                    if v.defPos == self:GetPosIndex() then
                      isBlock = v.isBlock
                      break
                    end
                  end
                  do
                    if isBlock then
                      hitEffectStr = BattleEffectEnum.COMMON_BLOCK
                    end
                    if campFlag == BattleCardCamp.RIGHT then
                      FxManager:ResetFx(eff)
                    else
                      FxManager:Overturn(eff)
                    end
                    if isUniqueSkill == true then
                      (SortingHelper.SetOrderInLayer)(eff, BattleConfig.uniqueSkillHitOrder)
                    else
                      ;
                      (SortingHelper.SetOrderInLayer)(eff, self.sortingOrder)
                    end
                    ;
                    (CSLuaUtil.SetGOLocalPos)(eff, model)
                    if atkInfo.isAssist == true then
                      FxManager:PlayShackCameraEffect(hitEffectStr, eff)
                    end
                    local time = (LuaEffect.GetEffectDuration)(eff)
                    setTimeout(time, function(...)
      -- function num : 0_0_45_0 , upvalues : _ENV, eff, isUniqueSkill, SortingHelper, BattleConfig, self, FxManager, ResHelper
      if (BattleMgr.IsInBattle)() == false then
        return 
      end
      if (Util.IsNil)(eff) == false then
        if isUniqueSkill == true then
          (SortingHelper.SetOrderInLayer)(eff, -BattleConfig.uniqueSkillHitOrder)
        else
          ;
          (SortingHelper.SetOrderInLayer)(eff, -self.sortingOrder)
        end
        FxManager:ResetFx(eff)
        ;
        (ResHelper.DestroyGameObject)(eff)
      end
    end
)
                  end
                end
              end
            end
          end
        end
      end
    end
  end

  battleCard.PlayDownSmokeEffect = function(self, ...)
    -- function num : 0_0_46 , upvalues : InstantiateEffect, BattleEffectEnum, _ENV, campFlag, BattleCardCamp, FxManager, SortingHelper, model, BattleConfig, setTimeout, ResHelper
    local eff = InstantiateEffect(BattleEffectEnum.COMMON_FALLDOWN_SMOKE)
    ;
    (CSLuaUtil.SetParent)(eff, BattleRoot)
    if campFlag == BattleCardCamp.RIGHT then
      FxManager:ResetFx(eff)
    else
      FxManager:Overturn(eff)
    end
    ;
    (SortingHelper.SetOrderInLayer)(eff, self.sortingOrder)
    local position = (CSLuaUtil.GetGOLocalPos)(model)
    ;
    (CSLuaUtil.SetGOLocalPos)(eff, position + BattleConfig.smokeOff)
    local time = (LuaEffect.GetEffectDuration)(eff)
    setTimeout(time, function(...)
      -- function num : 0_0_46_0 , upvalues : _ENV, eff, SortingHelper, self, FxManager, ResHelper
      if (BattleMgr.IsInBattle)() == false then
        return 
      end
      if eff then
        (SortingHelper.SetOrderInLayer)(eff, -self.sortingOrder)
        FxManager:ResetFx(eff)
        ;
        (ResHelper.DestroyGameObject)(eff)
      end
    end
)
  end

  battleCard.PlayRunSmokeEffect = function(self, ...)
    -- function num : 0_0_47 , upvalues : InstantiateEffect, BattleEffectEnum, _ENV, campFlag, BattleCardCamp, FxManager, SortingHelper, model, setTimeout, ResHelper
    local eff = InstantiateEffect(BattleEffectEnum.COMMON_RUN_SMOKE)
    ;
    (CSLuaUtil.SetParent)(eff, BattleRoot)
    if campFlag == BattleCardCamp.LEFT then
      FxManager:ResetFx(eff)
    else
      FxManager:Overturn(eff)
    end
    ;
    (SortingHelper.SetOrderInLayer)(eff, self.sortingOrder)
    ;
    (CSLuaUtil.SetGOLocalPos)(eff, model)
    local time = (LuaEffect.GetEffectDuration)(eff)
    setTimeout(time, function(...)
      -- function num : 0_0_47_0 , upvalues : _ENV, eff, SortingHelper, self, FxManager, ResHelper
      if (BattleMgr.IsInBattle)() == false then
        return 
      end
      if eff then
        (SortingHelper.SetOrderInLayer)(eff, -self.sortingOrder)
        FxManager:ResetFx(eff)
        ;
        (ResHelper.DestroyGameObject)(eff)
      end
    end
)
  end

  battleCard.PlayCommonSkillEffect = function(self, callBack, ...)
    -- function num : 0_0_48 , upvalues : _ENV, InstantiateEffect, BattleEffectEnum, ChangeLayer, LayerMaskNames, campFlag, BattleCardCamp, FxManager, SortingHelper, model, BattleCardState, ResHelper
    local SkillParse = require("SkillParse")
    ;
    (SkillParse.Init)()
    DisplaySkillMask(0, 0.5)
    local eff = InstantiateEffect(BattleEffectEnum.COMMON_FLASH)
    ;
    (CSLuaUtil.SetParent)(eff, BattleRoot)
    ChangeLayer(eff.transform, LayerMaskNames.SKILL_HIGHLIGHT)
    if campFlag == BattleCardCamp.LEFT then
      FxManager:ResetFx(eff)
    else
      FxManager:Overturn(eff)
    end
    ;
    (SortingHelper.SetOrderInLayer)(eff, self.sortingOrder)
    ;
    (CSLuaUtil.SetGOLocalPos)(eff, model)
    self:ChangeState(BattleCardState.PREPARE, false, function(...)
      -- function num : 0_0_48_0 , upvalues : _ENV, callBack, eff, SortingHelper, self, FxManager, ResHelper
      if (BattleMgr.IsInBattle)() == false then
        return 
      end
      if callBack then
        callBack()
      end
      if eff then
        (SortingHelper.SetOrderInLayer)(eff, -self.sortingOrder)
        FxManager:ResetFx(eff)
        ;
        (ResHelper.DestroyGameObject)(eff)
      end
    end
)
  end

  battleCard.PlayRandomNumSpine = function(self, spineName, num, ...)
    -- function num : 0_0_49 , upvalues : ResHelper, _ENV, SortingHelper, model, ChangeLayer, LayerMaskNames, SkeletonAnimationUtil
    local spine = (ResHelper.InstantiateModel)(spineName)
    ;
    (CSLuaUtil.SetParent)(spine, BattleRoot)
    ;
    (SortingHelper.SetOrderInLayer)(spine, self.sortingOrder)
    ;
    (CSLuaUtil.SetGOLocalPos)(spine, model)
    ChangeLayer(spine.transform, LayerMaskNames.SKILL_HIGHLIGHT)
    ;
    (SkeletonAnimationUtil.SetAnimation)(spine, 0, tostring(num), false, function(...)
      -- function num : 0_0_49_0 , upvalues : ResHelper, spine
      (ResHelper.DestroyGameObject)(spine, false)
    end
)
  end

  battleCard.FlipPositionAndFace = function(self, isFlip, ...)
    -- function num : 0_0_50 , upvalues : model, SetFlip, BattleCardCamp, headInfo
    do
      if model then
        local selfCamp = self:GetCampFlag()
        if isFlip then
          self:SetPosition(self:GetFlipPosition())
          SetFlip(model, selfCamp == BattleCardCamp.LEFT, false)
          if headInfo then
            headInfo:Flip(true)
          end
        else
          self:SetPosition(self.position)
          SetFlip(model, selfCamp == BattleCardCamp.RIGHT, false)
          if headInfo then
            headInfo:Flip(false)
          end
        end
      end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end

  battleCard.GetFlipPosition = function(self, posIndex, ...)
    -- function num : 0_0_51 , upvalues : BattleCardPosition, BattleConfig
    if not posIndex then
      local selfIndex = self:GetPosIndex()
    end
    if selfIndex > 100 then
      return (BattleCardPosition[selfIndex - 100]).pos + BattleConfig.cardPositionOff
    else
      return (BattleCardPosition[selfIndex + 100]).pos + BattleConfig.cardPositionOff
    end
  end

  battleCard.GetCampFrontPosition = function(self, isFlip, ...)
    -- function num : 0_0_52 , upvalues : BattleCardPosition, BattleConfig
    local selfIndex = self:GetPosIndex()
    if selfIndex % 100 > 10 then
      local index = selfIndex - 10
      if isFlip == true then
        return self:GetFlipPosition(index)
      else
        return (BattleCardPosition[index]).pos + BattleConfig.cardPositionOff
      end
    else
      do
        if isFlip == true then
          return self:GetFlipPosition(selfIndex)
        else
          return self.position
        end
      end
    end
  end

  battleCard.PlayUniqueSkillEffect = function(self, skillId, callBack, atkEndCallBack, allEndCallBack, defCards, ...)
    -- function num : 0_0_53 , upvalues : InstantiateEffect, BattleEffectEnum, _ENV, BattleCardState, campFlag, BattleCardCamp, FxManager, SortingHelper
    local effPrepare = InstantiateEffect(BattleEffectEnum.COMMON_SKILL_FLASH)
    ;
    (CSLuaUtil.SetParent)(effPrepare, BattleRoot)
    if self.waitUniqueSkillEffect == nil then
      self:ChangeState(BattleCardState.PREPARE, true)
    end
    if campFlag == BattleCardCamp.LEFT then
      FxManager:ResetFx(effPrepare)
    else
      FxManager:Overturn(effPrepare)
    end
    ;
    (SortingHelper.SetOrderInLayer)(effPrepare, self.sortingOrder)
    ;
    (CSLuaUtil.SetParent)(effPrepare, BattleRoot)
    ;
    (CSLuaUtil.SetGOLocalPos)(effPrepare, self.position)
    ;
    (BattlePlay.ShowSkillCard)(skillId, self:GetPosIndex(), function(...)
      -- function num : 0_0_53_0 , upvalues : _ENV, self, callBack, atkEndCallBack, allEndCallBack, effPrepare, defCards
      if (BattleMgr.IsInBattle)() == false then
        return 
      end
      UIMgr:SendWindowMessage((WinResConfig.BattleUIWindow).name, (WindowMsgEnum.BattleUIWindow).E_MSG_HIDE_UNIQUE_UI)
      self:PlayUniqueSkill(callBack, atkEndCallBack, allEndCallBack, effPrepare, defCards)
    end
)
  end

  battleCard.PlayUniqueSkill = function(self, callBack, atkEndCallBack, allEndCallBack, effPrepare, defCards, ...)
    -- function num : 0_0_54 , upvalues : _ENV, baseSkillShowData, BattleCardState, SortingHelper, ResHelper, shadow, flagNextAttack, setTimeout, InstantiateEffect, typeof, BattleCardCamp, Vector3, BattleConfig, FxManager, atkInfo, ipairs, BattleBuffDeductionRoundType, BattleState
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R6 in 'UnsetPending'

    BattleAtk.waitActionCardPosTable = {}
    local skillId = (BattleAtk.curAtkInfo).skillId
    local skillConfig = (TableData.GetBaseSkillData)(skillId)
    local skillType = skillConfig.type
    local fashionId = self:GetFashionId()
    local showId = (BattleSkill.GetSkillShowId)(fashionId, skillType)
    local skillShowConfig = baseSkillShowData[showId]
    local scriptPath = skillShowConfig.effect_attack
    if scriptPath == nil or scriptPath == "" or scriptPath and (string.find)(scriptPath, "SkillScript") == nil then
      self:ChangeState(BattleCardState.UNIQUE_SKILL, false, function(...)
      -- function num : 0_0_54_0 , upvalues : _ENV, SortingHelper, effPrepare, self, ResHelper, callBack
      -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

      BattleMgr.startRecord = false
      ;
      (SortingHelper.SetOrderInLayer)(effPrepare, -self.sortingOrder)
      ;
      (ResHelper.DestroyGameObject)(effPrepare)
      if callBack then
        callBack()
      end
    end
)
      return 
    end
    if skillShowConfig then
      local skill_sound = skillShowConfig.skill_sound
      if skill_sound and skill_sound ~= "" then
        (BattlePlay.PlaySkillSound)(skill_sound, defCards)
      end
      local card_show = skillShowConfig.card_show
    end
    if card_show and card_show ~= 0 then
      do
        (AudioManager.PlayBattleVoice)(fashionId, CVAudioType.UniqueSkillBubble)
        shadow:SetActive(false)
        flagNextAttack:SetActive(false)
        local time = (LuaEffect.GetEffectDuration)(effPrepare)
        setTimeout(time, function(...)
      -- function num : 0_0_54_1 , upvalues : _ENV, SortingHelper, effPrepare, self, ResHelper
      if (BattleMgr.IsInBattle)() == false then
        return 
      end
      ;
      (SortingHelper.SetOrderInLayer)(effPrepare, -self.sortingOrder)
      ;
      (ResHelper.DestroyGameObject)(effPrepare)
    end
)
        self:SetIsSkillHideHpBar(true)
        SkillScript = require(scriptPath)
        local SkillParse = require("SkillParse")
        ;
        (SkillParse.Init)(nil, skillShowConfig)
        SkillParse.isUniqueSkill = true
        local timelineName = SkillScript.timelineName
        local eff = InstantiateEffect(timelineName)
        ;
        (LuaSound.ResetVideoSound)(eff)
        ;
        (CSLuaUtil.SetParent)(eff, BattleRoot)
        local vp = eff:GetComponentInChildren(typeof(((CS.UnityEngine).Video).VideoPlayer), true)
        local clipName = timelineName
        local needRemove = false
        local cameraBattleRight = nil
        if self:GetCampFlag() == BattleCardCamp.RIGHT then
          (Util.SetCameraActive)(Game.battleRightCamera, true)
          cameraBattleRight = (Game.battleRightCamera):GetComponentInChildren(typeof(Camera))
          ;
          (BattleCameraMgr.mirrorCamera)(true)
          clipName = timelineName .. "_flip"
          ;
          (Util.SetCameraCullingMask)(Game.battleCamera, 0)
        end
        if vp and vp.clip == nil then
          needRemove = true
          vp.clip = (ResHelper.LoadVideo)(clipName)
          if vp.canSetPlaybackSpeed == true then
            vp.playbackSpeed = Time.timeScale
          end
        end
        local camera = eff:GetComponentInChildren(typeof(Camera), true)
        if camera then
          camera:ResetProjectionMatrix()
          local launch = (CS.Launch).Singleton
          launch.TimelineCamera = camera
          camera.allowHDR = false
          camera.allowMSAA = false
          camera.forceIntoRenderTexture = false
          camera.allowDynamicResolution = false
        end
        do
          local cameraSkill = (Game.skillCamera):GetComponentInChildren(typeof(Camera))
          if cameraSkill then
            cameraSkill:ResetProjectionMatrix()
          end
          local cameraSkillRole = (Game.skillRoleCamera):GetComponentInChildren(typeof(Camera))
          if cameraSkillRole then
            cameraSkillRole:ResetProjectionMatrix()
          end
          local cameraSkillBg = (Game.skillBgCamera):GetComponentInChildren(typeof(Camera))
          if cameraSkillBg then
            cameraSkillBg:ResetProjectionMatrix()
          end
          do
            if self:GetCampFlag() == BattleCardCamp.RIGHT then
              local Matrix4x4 = (CS.UnityEngine).Matrix4x4
              if cameraSkill then
                cameraSkill.projectionMatrix = cameraSkill.projectionMatrix * (Matrix4x4.Scale)(Vector3(-1, 1, 1))
              end
              if cameraSkillRole then
                cameraSkillRole.projectionMatrix = cameraSkillRole.projectionMatrix * (Matrix4x4.Scale)(Vector3(-1, 1, 1))
              end
              if cameraSkillBg then
                cameraSkillBg.projectionMatrix = cameraSkillBg.projectionMatrix * (Matrix4x4.Scale)(Vector3(-1, 1, 1))
              end
            end
            ;
            (SortingHelper.SetOrderInLayer)(eff, BattleConfig.skillTimelineOrderInit + BattleConfig.sortingOrderInit)
            ;
            (CSLuaUtil.SetGOLocalPos)(eff, 0, 0 + (BattleConfig.cardPositionOff).y, 0)
            local timeline = nil
            local playable = eff:GetComponentInChildren(typeof(((CS.UnityEngine).Playables).PlayableDirector), true)
            if playable then
              timeline = playable.transform
            end
            local battleCamera = Game.battleCamera
            local skillCamera = Game.skillCamera
            local TimelineHelper = CS.TimelineHelper
            local timelineObject = timeline.gameObject
            ;
            (TimelineHelper.SetBinding)(timelineObject, "BattleCameraTrack", Game.battleCamera)
            ;
            (TimelineHelper.SetBinding)(timelineObject, "SkillCameraTrack", Game.skillCamera)
            local time = FxManager:PlayTimeLine(timeline)
            print("000000000000000000  time:", time)
            self:ChangeDander(atkInfo.danderAtk, true)
            ;
            (SimpleTimer.setTimeout)(time - 0.033, function(...)
      -- function num : 0_0_54_2 , upvalues : _ENV, eff
      if (BattleMgr.IsInBattle)() == false then
        return 
      end
      if eff then
        eff:SetActive(false)
      end
    end
)
            local timelineEndCall = function(...)
      -- function num : 0_0_54_3 , upvalues : _ENV, eff, vp, needRemove, ResHelper, camera, TimelineHelper, timelineObject, SortingHelper, BattleConfig, shadow, cameraSkill, cameraSkillRole, cameraSkillBg, atkEndCallBack, self, atkInfo, ipairs, BattleBuffDeductionRoundType, SkillParse, allEndCallBack, BattleState
      if (BattleMgr.IsInBattle)() == false then
        return 
      end
      -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

      BattleMgr.startRecord = false
      if eff then
        eff:SetActive(false)
      end
      if vp then
        vp.targetCamera = nil
        if needRemove == true then
          local clip = vp.clip
          vp.clip = nil
          ;
          (ResHelper.UnloadVideo)(clip)
        end
      end
      do
        if camera then
          camera:ResetProjectionMatrix()
          local launch = (CS.Launch).Singleton
          launch.TimelineCamera = nil
        end
        do
          if eff then
            (BattleMgr.ResetCameraAnimator)()
            ;
            (TimelineHelper.SetBinding)(timelineObject, "BattleCameraTrack", nil)
            ;
            (TimelineHelper.SetBinding)(timelineObject, "SkillCameraTrack", nil)
            ;
            (SortingHelper.SetOrderInLayer)(eff, -(BattleConfig.skillTimelineOrderInit + BattleConfig.sortingOrderInit))
            ;
            (ResHelper.DestroyGameObject)(eff)
          end
          if shadow then
            shadow:SetActive(true)
          end
          ;
          (Util.SetCameraActive)(Game.battleRightCamera, false)
          ;
          (BattleCameraMgr.mirrorCamera)(false)
          ;
          (Util.SetCameraCullingMask)(Game.battleCamera, BattleConfig.originBattleCameraCullingMask)
          if cameraSkill then
            cameraSkill:ResetProjectionMatrix()
          end
          if cameraSkillRole then
            cameraSkillRole:ResetProjectionMatrix()
          end
          if cameraSkillBg then
            cameraSkillBg:ResetProjectionMatrix()
          end
          if atkEndCallBack then
            atkEndCallBack()
          end
          self:SetAllBuffEffectVisible(true)
          self:SetIsSkillHideHpBar(false)
          self:UpdateHeadInfoVisible(true)
          if not atkInfo.defCardsInfo then
            local defCardsInfo = {}
          end
          for _,cardInfo in ipairs(defCardsInfo) do
            local targetCard = (BattleData.GetCardInfoByPos)(cardInfo.defPos)
            if targetCard then
              targetCard:ChangeDander(cardInfo.danderDef)
            end
            if cardInfo.defPos ~= self:GetPosIndex() then
              (BattlePlay.PlayBuff)(atkInfo, targetCard, BattleBuffDeductionRoundType.AFTER_HIT)
            end
          end
          if SkillParse then
            (SkillParse.Clear)()
          end
          SkillScript = nil
          if allEndCallBack then
            allEndCallBack()
          end
          self:DealAfterAtk()
          ;
          (BattleData.SetBattleState)(BattleState.BUFF_AFTER_ATTACK)
        end
      end
    end

            ;
            (SkillScript.Play)(time, timelineEndCall)
          end
        end
      end
    end
  end

  battleCard.PlayWaitUniqueSkillEffect = function(self, ...)
    -- function num : 0_0_55 , upvalues : _ENV, InstantiateEffect, BattleEffectEnum, campFlag, BattleCardCamp, FxManager, model, SortingHelper, curState, BattleCardState
    if not BattleAtk.curAtkInfo then
      local atkInfo = {}
    end
    if self.waitUniqueSkillEffect == nil then
      local scale = 1
      local eff = InstantiateEffect(BattleEffectEnum.COMMON_GATHERING)
      if campFlag == BattleCardCamp.LEFT then
        FxManager:ResetFx(eff)
      else
        FxManager:Overturn(eff)
      end
      ;
      (CSLuaUtil.SetParent)(eff, model)
      ;
      (CSLuaUtil.SetGOLocalPos)(eff, 0, 0, 0)
      ;
      (BattlePlay.SetLayer)(eff)
      ;
      (SortingHelper.SetOrderInLayer)(eff, self.sortingOrder)
      self.waitUniqueSkillEffect = eff
    end
    do
      if curState ~= BattleCardState.IDLE then
        return 
      end
      self:ChangeState(BattleCardState.PREPARE, true)
    end
  end

  battleCard.RemoveWaitUniqueSkillEffect = function(self, ...)
    -- function num : 0_0_56 , upvalues : SortingHelper, FxManager, ResHelper
    local eff = self.waitUniqueSkillEffect
    if eff then
      (SortingHelper.SetOrderInLayer)(eff, -self.sortingOrder)
      FxManager:ResetFx(eff)
      ;
      (ResHelper.DestroyGameObject)(eff)
      self.waitUniqueSkillEffect = nil
    end
  end

  battleCard.PlayBuffEffect = function(self, effectPosType, effectId, buffId, buffTimeStamp, buffData, ...)
    -- function num : 0_0_57 , upvalues : _ENV, baseSkillBuffEffectData, BattleBuffEffectPosType, bloodBuffEffectTable, bodyBuffEffectTable, headBuffEffectTable, aroundBuffEffectTable, BattleBuffMgr, InstantiateEffect, campFlag, BattleCardCamp, FxManager, model, ChangeLayer, SortingHelper, ipairs, t_insert
    if IsBattleServer == true then
      return 
    end
    local effectConfig = baseSkillBuffEffectData[effectId]
    if effectConfig then
      local effectPath, saveEffectTable = nil, nil
      local priority = 0
      if effectPosType == BattleBuffEffectPosType.BLOOD then
        saveEffectTable = bloodBuffEffectTable
        effectPath = effectConfig.icon_path
        priority = effectConfig.icon_priority
      else
        if effectPosType == BattleBuffEffectPosType.BODY then
          saveEffectTable = bodyBuffEffectTable
          effectPath = effectConfig.effect_body_path
          priority = effectConfig.effect_body_priority
        else
          if effectPosType == BattleBuffEffectPosType.HEAD then
            saveEffectTable = headBuffEffectTable
            effectPath = effectConfig.effect_head_path
            priority = effectConfig.effect_head_priority
          else
            if effectPosType == BattleBuffEffectPosType.AROUND then
              saveEffectTable = aroundBuffEffectTable
              effectPath = effectConfig.effect_around_path
              priority = effectConfig.effect_around_priority
            else
              if effectPosType == BattleBuffEffectPosType.WORD then
                effectPath = effectConfig.words_path
              end
            end
          end
        end
      end
      if effectPath and effectPath ~= "" and effectPath ~= "0" then
        local buff = (BattleBuffMgr.GetBuffDataByDetailId)(buffId, self:GetPosIndex(), buffTimeStamp)
        if effectPosType == BattleBuffEffectPosType.WORD then
          ShowBuffWord(effectPath, self)
        else
          if effectPosType ~= BattleBuffEffectPosType.BLOOD then
            if buff and buff:NeedRemove() == true then
              return 
            end
            local eff = InstantiateEffect(effectPath)
            ;
            (CSLuaUtil.SetParent)(eff, BattleRoot)
            if campFlag == BattleCardCamp.RIGHT then
              FxManager:Overturn(eff)
            end
            ;
            (CSLuaUtil.SetParent)(eff, model)
            ;
            (CSLuaUtil.SetGOLocalPos)(eff, 0, 0, 0)
            local LayerMask = (CS.UnityEngine).LayerMask
            ChangeLayer(eff.transform, (LayerMask.LayerToName)(model.layer))
            ;
            (SortingHelper.SetOrderInLayer)(eff, self.sortingOrder)
            local isFind = false
            for _,v in ipairs(saveEffectTable) do
              if v.effectId == effectId and v.buffTimeStamp == buffTimeStamp and v.buffId == buffId then
                t_insert(v.effectTable, eff)
                isFind = true
                break
              end
            end
            do
              do
                if isFind == false then
                  t_insert(saveEffectTable, {effectId = effectId, 
effectTable = {eff}
, priority = priority, buffId = buffId, buffTimeStamp = buffTimeStamp})
                end
                if buff and buff:NeedRemove() == true then
                  return 
                end
                do
                  local buffEffect = {effectId = effectId, effectPath = effectPath, priority = priority, buffId = buffId, buffTimeStamp = buffTimeStamp}
                  t_insert(saveEffectTable, buffEffect)
                  self:UpdateBuffEffect(effectPosType, nil, buffData)
                end
              end
            end
          end
        end
      end
    end
  end

  battleCard.RemoveBuffEffect = function(self, effectPosType, effectId, buffId, buffTimeStamp, ...)
    -- function num : 0_0_58 , upvalues : _ENV, baseSkillBuffEffectData, BattleBuffEffectPosType, bloodBuffEffectTable, bodyBuffEffectTable, headBuffEffectTable, aroundBuffEffectTable, ipairs, SortingHelper, ResHelper
    if IsBattleServer == true then
      return 
    end
    local effectConfig = baseSkillBuffEffectData[effectId]
    if effectConfig then
      local saveEffectTable = nil
      if effectPosType == BattleBuffEffectPosType.BLOOD then
        saveEffectTable = bloodBuffEffectTable
      else
        if effectPosType == BattleBuffEffectPosType.BODY then
          saveEffectTable = bodyBuffEffectTable
        else
          if effectPosType == BattleBuffEffectPosType.HEAD then
            saveEffectTable = headBuffEffectTable
          else
            if effectPosType == BattleBuffEffectPosType.AROUND then
              saveEffectTable = aroundBuffEffectTable
            end
          end
        end
      end
      for i,v in ipairs(saveEffectTable) do
        if v.effectId == effectId and v.buffId == buffId and v.buffTimeStamp == buffTimeStamp then
          local effectTable = v.effectTable
          if effectTable then
            for _,eff in ipairs(effectTable) do
              (SortingHelper.SetOrderInLayer)(eff, -self.sortingOrder)
              ;
              (ResHelper.DestroyGameObject)(eff)
            end
          end
          do
            do
              ;
              (table.remove)(saveEffectTable, i)
              do break end
              -- DECOMPILER ERROR at PC63: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC63: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC63: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
      self:UpdateBuffEffect(effectPosType)
    end
  end

  battleCard.UpdateBuffEffect = function(self, effectPosType, visible, buffData, ...)
    -- function num : 0_0_59 , upvalues : _ENV, BattleBuffEffectPosType, bloodBuffEffectTable, bodyBuffEffectTable, headBuffEffectTable, aroundBuffEffectTable, headInfo, ipairs, BattleDisplayEffect
    if IsBattleServer == true then
      return 
    end
    if visible == nil then
      visible = true
    end
    if buffData then
      local activeCount = buffData.activeCount
    end
    if buffData then
      local totalCount = buffData.totalCount
    end
    local saveEffectTable = nil
    local displayCount = 0
    if effectPosType == BattleBuffEffectPosType.BLOOD then
      saveEffectTable = bloodBuffEffectTable
      displayCount = 3
    else
      if effectPosType == BattleBuffEffectPosType.BODY then
        saveEffectTable = bodyBuffEffectTable
        displayCount = 1
      else
        if effectPosType == BattleBuffEffectPosType.HEAD then
          saveEffectTable = headBuffEffectTable
          displayCount = 1
        else
          if effectPosType == BattleBuffEffectPosType.AROUND then
            saveEffectTable = aroundBuffEffectTable
            displayCount = 1
          end
        end
      end
    end
    if saveEffectTable then
      (table.sort)(saveEffectTable, function(a, b, ...)
      -- function num : 0_0_59_0
      do return a.priority < b.priority end
      -- DECOMPILER ERROR: 1 unprocessed JMP targets
    end
)
      local count = 1
      if effectPosType == BattleBuffEffectPosType.BLOOD and headInfo then
        headInfo:UpdateBuff(saveEffectTable)
      end
    end
    for i,v in ipairs(saveEffectTable) do
      local effectTable = v.effectTable
      local effectId = v.effectId
      for _,effect in ipairs(effectTable) do
        do
          do
            if effectId == BattleDisplayEffect.RESIST and buffData and (BattleBuff.IsBuffContainEffectId)(buffData, effectId) then
              local com1 = (effect.transform):Find("FX_common_Shield_1")
              if totalCount - activeCount == 1 and com1 and com1.gameObject then
                (com1.gameObject):SetActive(false)
              end
            end
            if totalCount - activeCount == 2 and com1 and com1.gameObject then
              (com1.gameObject):SetActive(true)
            end
            if count <= displayCount and visible == true then
              effect:SetActive(true)
              count = count + 1
            else
              effect:SetActive(false)
            end
            -- DECOMPILER ERROR at PC120: LeaveBlock: unexpected jumping out DO_STMT

          end
        end
      end
    end
    do
      UIMgr:SendWindowMessage("BattleUIWindow", (WindowMsgEnum.BattleUIWindow).E_MSG_UPDATE_BOTTOM_HEAD, {posIndex = self:GetPosIndex()})
    end
  end

  battleCard.SetAllBuffEffectVisible = function(self, visible, ...)
    -- function num : 0_0_60 , upvalues : BattleBuffEffectPosType, ipairs
    local effectPosTypeTable = {BattleBuffEffectPosType.AROUND, BattleBuffEffectPosType.BODY, BattleBuffEffectPosType.HEAD}
    for _,effectPosType in ipairs(effectPosTypeTable) do
      self:UpdateBuffEffect(effectPosType, visible)
    end
  end

  battleCard.DealAfterAtk = function(self, notSetActionState, callBack, ...)
    -- function num : 0_0_61 , upvalues : _ENV, curState, BattleCardState, BattleCardFloatUpState
    loge("处理伤害结算")
    print("阵位：", self:GetPosIndex(), " 剩余血量：", self:GetDisPlayHp())
    self:MoveBackDamageShareCard()
    if self:GetDisPlayHp() <= 0 then
      print("已死亡，阵位：", self:GetPosIndex())
      self:Die()
    else
      if curState == BattleCardState.FALL_DOWN then
        self:ChangeState(BattleCardState.UP, false, function(...)
      -- function num : 0_0_61_0 , upvalues : curState, BattleCardState, self, callBack, notSetActionState, _ENV
      if curState == BattleCardState.UP then
        self:Stand()
        if callBack then
          callBack()
        end
        if notSetActionState ~= true then
          (BattleAtk.SetWaitActionCardState)(self:GetPosIndex(), true)
        end
      end
    end
)
      else
        if self:GetFloatUpState() == BattleCardFloatUpState.NONE then
          self:Stand()
          if callBack then
            callBack()
          end
          if notSetActionState ~= true then
            (BattleAtk.SetWaitActionCardState)(self:GetPosIndex(), true)
          end
        end
      end
    end
  end

  battleCard.MoveBackDamageShareCard = function(self, ...)
    -- function num : 0_0_62 , upvalues : _ENV, BattleAttackType
    local pos = self.damageShareCardPos
    if pos then
      local card = (BattleData.GetCardInfoByPos)(pos)
      do
        if card then
          card:DealAfterAtk(nil, function(...)
      -- function num : 0_0_62_0 , upvalues : card, BattleAttackType
      card:MoveBack(function(...)
        -- function num : 0_0_62_0_0
      end
, BattleAttackType.JUMP)
    end
)
        end
        self.damageShareCardPos = nil
      end
    end
  end

  battleCard.ClearHurtInfo = function(self, ...)
    -- function num : 0_0_63
    self.hurtInfo = nil
  end

  battleCard.SmokeEvent = function(trackEntry, event, ...)
    -- function num : 0_0_64 , upvalues : battleCard
    if (event.Data).Name == "smoke" then
      battleCard:PlayDownSmokeEffect()
    end
  end

  battleCard.RunSmokeEvent = function(trackEntry, event, ...)
    -- function num : 0_0_65 , upvalues : battleCard
    if (event.Data).Name == "run" then
      battleCard:PlayRunSmokeEffect()
    end
  end

  battleCard.FloatUp = function(self, lastAtk, ...)
    -- function num : 0_0_66 , upvalues : _ENV, BattleConfig
    local curStrikeIndex = BattlePlay.curStrikeIndex
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

    if not (BattleConfig.floatUpBaseSpeed)[curStrikeIndex] then
      BattlePlay.curCommonSpeedUp = (BattleConfig.floatUpBaseSpeed)[#BattleConfig.floatUpBaseSpeed]
      -- DECOMPILER ERROR at PC21: Confused about usage of register: R3 in 'UnsetPending'

      if not (BattleConfig.imitateGravityAcceleration)[curStrikeIndex] then
        BattlePlay.curCommonGravityAcceleration = (BattleConfig.imitateGravityAcceleration)[#BattleConfig.imitateGravityAcceleration]
        local cardConfig = self:GetCardConfig()
        self.speedUp = BattlePlay.curCommonSpeedUp * (cardConfig.attack_up_speed_scale or 10000) / 10000
        if lastAtk == true then
          self.floatCallBack = function(...)
      -- function num : 0_0_66_0 , upvalues : self
      self:DealAfterAtk()
    end

        end
        -- DECOMPILER ERROR at PC39: Confused about usage of register: R4 in 'UnsetPending'

        BattlePlay.curStrikeIndex = curStrikeIndex + 1
      end
    end
  end

  battleCard.FloatDown = function(self, lastAtk, ...)
    -- function num : 0_0_67 , upvalues : _ENV
    self.speedUp = -BattlePlay.curCommonSpeedUp / 2
    if lastAtk == true then
      self.floatCallBack = function(...)
      -- function num : 0_0_67_0 , upvalues : self
      self:DealAfterAtk()
    end

    end
  end

  battleCard.MoveBack = function(self, callBack, attackType, ...)
    -- function num : 0_0_68 , upvalues : model, campFlag, BattleCardCamp, BattleAttackType, SetFlip, BattleCardState, shadow, _ENV, flagNextAttack, atkInfo, setTimeout, BattleConfig, delayedCall
    local go = model
    local position = self.position
    if not attackType then
      local attackType = self.attackType
    end
    local curFlipX = nil
    if campFlag == BattleCardCamp.RIGHT then
      curFlipX = true
    else
      curFlipX = false
    end
    if attackType == BattleAttackType.RUN then
      SetFlip(model, not curFlipX, false)
      self:ChangeState(BattleCardState.RUN, true)
      if shadow then
        (Util.MoveTo)(shadow, position)
      end
      if flagNextAttack then
        (Util.MoveTo)(flagNextAttack, position)
      end
      ;
      (Util.MoveTo)(go, position, nil, function(...)
      -- function num : 0_0_68_0 , upvalues : self, position, SetFlip, model, curFlipX, callBack
      self.curPosition = position
      self:ResetSortingOrder()
      SetFlip(model, curFlipX, false)
      self:Stand()
      self:SetAllBuffEffectVisible(true)
      if callBack then
        callBack()
      end
    end
)
    else
      if attackType == BattleAttackType.JUMP then
        local targetSelf = atkInfo.targetSelf
        local localPosition = (CSLuaUtil.GetGOLocalPos)(model)
        local curPosX = localPosition.x
        local targetPosX = position.x
        local isBehind = false
        if targetSelf == true then
          if targetPosX <= curPosX then
            self:ChangeState(BattleCardState.JUMP_F, true)
          else
            self:ChangeState(BattleCardState.JUMP_B, true)
            isBehind = true
          end
        else
          self:ChangeState(BattleCardState.JUMP_B, true)
        end
        if shadow then
          (Util.JumpTo)(shadow, position, nil, nil, 0)
        end
        if flagNextAttack then
          (Util.JumpTo)(flagNextAttack, position, nil, nil, 0)
        end
        ;
        (Util.JumpTo)(go, position, nil, function(...)
      -- function num : 0_0_68_1 , upvalues : self, position, callBack
      self.curPosition = position
      self:ResetSortingOrder()
      self:Stand()
      self:SetAllBuffEffectVisible(true)
      if callBack then
        callBack()
      end
    end
)
      else
        do
          if attackType == BattleAttackType.FLASH then
            (BattlePlay.PlayFlashEffect)(self)
            setTimeout(BattleConfig.flashInterval, function(...)
      -- function num : 0_0_68_2 , upvalues : _ENV, go, position, self, shadow, flagNextAttack, delayedCall, BattleConfig, callBack
      (CSLuaUtil.SetGOLocalPos)(go, position)
      self.curPosition = position
      if shadow then
        (CSLuaUtil.SetGOLocalPos)(shadow, position)
      end
      if flagNextAttack then
        (CSLuaUtil.SetGOLocalPos)(flagNextAttack, position)
      end
      self:ResetSortingOrder()
      self:Stand()
      self:SetAllBuffEffectVisible(true)
      delayedCall(BattleConfig.maxMoveInterval - BattleConfig.flashInterval, function(...)
        -- function num : 0_0_68_2_0 , upvalues : callBack
        if callBack then
          callBack()
        end
      end
)
    end
)
          else
            if attackType == BattleAttackType.STAND then
              self:Stand()
              self:SetAllBuffEffectVisible(true)
              delayedCall(BattleConfig.maxMoveInterval, function(...)
      -- function num : 0_0_68_3 , upvalues : callBack
      if callBack then
        callBack()
      end
    end
)
            end
          end
        end
      end
    end
  end

  battleCard.SetPosition = function(self, position, ...)
    -- function num : 0_0_69 , upvalues : model, _ENV
    if model then
      (CSLuaUtil.SetGOLocalPos)(model, position)
    end
  end

  battleCard.Stand = function(self, ...)
    -- function num : 0_0_70 , upvalues : BattleCardState
    self:ChangeState(BattleCardState.IDLE, true)
  end

  battleCard.ChangeHp = function(self, hurtData, atkInfo, isBuffHurt, effect, showAttackEndEffect, curHitIndex, ...)
    -- function num : 0_0_71 , upvalues : ipairs, battleCard, HurtNumType, headInfo, _ENV, tweenValue, delayedCall, curState, BattleCardState
    local hurtHp = hurtData.hurt
    local absorb = hurtData.absorb
    local oriValue = hurtData.oriValue
    local isInvincible = false
    local isCrit = false
    local isDodge = false
    local isBlock = false
    local isCounter = false
    local isKeepAlive = false
    local absorbDamage = 0
    if not atkInfo or not atkInfo.defCardsInfo then
      local defCardsInfo = {}
    end
    if isBuffHurt == true and effect then
      absorbDamage = effect.absorbDamage
      isKeepAlive = effect.isKeepAlive
      isInvincible = effect.isInvincible
    else
      for _,defCardInfo in ipairs(defCardsInfo) do
        do
          if defCardInfo.defCardUid == battleCard:GetCardUid() then
            do
              isCrit = defCardInfo.isCrit
              isDodge = defCardInfo.isDodge
              isBlock = defCardInfo.isBlock
              isInvincible = defCardInfo.isInvincible
              isCounter = defCardInfo.isCounter
              absorbDamage = defCardInfo.absorbDamage
              isKeepAlive = defCardInfo.isKeepAlive
              -- DECOMPILER ERROR at PC41: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC41: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    end
    local isTreatment = nil
    if oriValue <= 0 and hurtHp <= 0 then
      isTreatment = isBuffHurt ~= true
      isTreatment = (atkInfo and atkInfo.isTreatment) or hurtHp > 0
      local hurtNumType = HurtNumType.NOR_HURT
      if isCrit == true then
        hurtNumType = HurtNumType.CRI_HURT
      end
      if isTreatment == true then
        hurtNumType = HurtNumType.NOR_TREATMENT
      end
      if isDodge == true then
        hurtNumType = HurtNumType.MISS_HURT
      end
      if isBuffHurt == true then
        hurtNumType = HurtNumType.BUFF_HURT
      end
      if hurtHp ~= 0 and headInfo then
        headInfo:UpdateHp(self, hurtHp)
      end
      if self:IsDisplayAlive() == false and showAttackEndEffect == true then
        local _, attackEnd = (BattleResultCount.IsWaveOver)(true)
        if attackEnd == true then
          local timeScale = Time.timeScale
          ;
          (tweenValue(Time.timeScale, 0.3, 0.3)):setOnUpdate(function(x, ...)
      -- function num : 0_0_71_0 , upvalues : _ENV
      -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

      Time.timeScale = x
    end
)
          delayedCall(0.85, function(...)
      -- function num : 0_0_71_1 , upvalues : tweenValue, timeScale, _ENV
      (tweenValue(0.3, timeScale, 0.3)):setOnUpdate(function(x, ...)
        -- function num : 0_0_71_1_0 , upvalues : _ENV
        -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

        Time.timeScale = x
      end
)
    end
)
        end
      end
      if hurtHp < 0 then
        if absorb ~= 0 then
          ShowHurtNum(HurtNumType.ABSORB_HURT, absorb, self)
        end
        local selfFloatState = (self:IsFloatUp())
        local targetState = nil
        if selfFloatState then
          if curState == BattleCardState.FLOAT_UP then
            targetState = BattleCardState.FLOAT_DOWN
          else
            targetState = BattleCardState.FLOAT_UP
          end
        elseif curState == BattleCardState.HIT_1 then
          targetState = BattleCardState.HIT_2
        else
          targetState = BattleCardState.HIT_1
        end
        if isBlock == true then
          if selfFloatState ~= true then
            targetState = BattleCardState.DEFENCE
          end
          hurtNumType = HurtNumType.BLOCK_HURT
        end
        ShowHurtNum(hurtNumType, hurtHp, self)
        if not atkInfo or self:GetCardUid() ~= atkInfo.atkCardUid or isBuffHurt == true then
          self:ChangeState(targetState, false, function(...)
      -- function num : 0_0_71_2 , upvalues : self, _ENV
      if self:GetDisPlayHp() <= 0 then
        print("已死亡，buff导致 阵位：", self:GetPosIndex())
        self:Die()
      end
    end
)
        else
          if curHitIndex == 1 and self:IsDead() == false then
            (AudioManager.PlayBattleVoice)(self:GetFashionId(), CVAudioType.HitBubble)
          end
          self:ChangeState(targetState, false, function(...)
      -- function num : 0_0_71_3 , upvalues : self
      self:Stand()
    end
, true)
        end
        ;
        (BattleBuff.RemoveShieldBuff)(self)
      elseif hurtHp > 0 then
        hurtNumType = HurtNumType.NOR_TREATMENT
        ShowHurtNum(hurtNumType, hurtHp, self)
      elseif isDodge == false then
        if isKeepAlive == true then
          hurtNumType = HurtNumType.KEEP_ALIVE
        elseif isInvincible == true then
          hurtNumType = HurtNumType.INVINCIBLE
        elseif absorb ~= 0 then
          hurtNumType = HurtNumType.ABSORB_HURT
          ShowHurtNum(hurtNumType, absorb, self)
        elseif isTreatment == true then
          hurtNumType = HurtNumType.UNTREATMENT
        else
          hurtNumType = HurtNumType.RESIST
        end
      end
      -- DECOMPILER ERROR at PC246: Unhandled construct in 'MakeBoolean' P1

      if (isCounter ~= true or absorb ~= 0 or hurtNumType == HurtNumType.ABSORB_HURT) and curHitIndex == 1 and self:IsDead() == false then
        (AudioManager.PlayBattleVoice)(self:GetFashionId(), CVAudioType.HitBubble)
      end
      ShowHurtNum(hurtNumType, hurtHp, self)
      if hurtHp <= 0 and isDodge == false then
        (BattleBuff.RemoveSleepBuff)(self)
      end
      if IsBattleServer == nil then
        if self:GetDisPlayHp() <= 0 and headInfo then
          headInfo:Destroy()
          headInfo = nil
        end
        self:SetCurShield(-absorb)
      end
      -- DECOMPILER ERROR: 35 unprocessed JMP targets
    end
  end

  battleCard.IsFloatUp = function(self, ...)
    -- function num : 0_0_72 , upvalues : BattleCardFloatUpState
    local floatUpState = self:GetFloatUpState()
    do return floatUpState == BattleCardFloatUpState.FLOAT end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end

  battleCard.ChangeDander = function(self, dander, removeFullRage, ...)
    -- function num : 0_0_73 , upvalues : headInfo, BattleConfig
    local hurtInfo = headInfo
    if hurtInfo then
      hurtInfo:UpdateDander(self, dander, removeFullRage)
    else
      if BattleConfig.isPlayBack == true then
        self:SetDander(self:GetDander() + dander)
      end
    end
  end

  battleCard.Die = function(self, ...)
    -- function num : 0_0_74 , upvalues : BattleBuffMgr, _ENV, alreayDisplayDie, headInfo, curState, BattleCardState
    (BattleBuffMgr.ClearCardBuff)(self:GetPosIndex())
    if IsBattleServer == nil then
      if alreayDisplayDie == true then
        loge("已经播过死亡动画")
        return 
      end
      if headInfo then
        headInfo:Destroy()
        headInfo = nil
      end
      loge("播放死亡动画 当前状态：" .. curState)
      ;
      (AudioManager.PlayBattleVoice)(self:GetFashionId(), CVAudioType.DeathBubble)
      alreayDisplayDie = true
      if curState == BattleCardState.FALL_DOWN then
        self:PlayDieEffect()
        self:Destroy()
        ;
        (BattleAtk.SetWaitActionCardState)(self:GetPosIndex(), true)
      else
        self:ChangeState(BattleCardState.DIE, false, function(curState, ...)
      -- function num : 0_0_74_0 , upvalues : _ENV, self, BattleCardState
      print(" -位置：" .. self:GetPosIndex() .. "死亡后状态：", curState)
      if curState == BattleCardState.DIE then
        self:PlayDieEffect()
        self:Destroy()
      end
      ;
      (BattleAtk.SetWaitActionCardState)(self:GetPosIndex(), true)
    end
)
      end
      UIMgr:SendWindowMessage((WinResConfig.BattleUIWindow).name, (WindowMsgEnum.BattleUIWindow).E_MSG_RESET_ORDER_LINE, self:GetPosIndex())
    end
  end

  battleCard.PlayDieEffect = function(self, ...)
    -- function num : 0_0_75 , upvalues : model, campFlag, BattleCardCamp, InstantiateEffect, BattleEffectEnum, _ENV, SortingHelper, setTimeout, FxManager, ResHelper
    if model == nil then
      return 
    end
    local eff = nil
    if campFlag == BattleCardCamp.RIGHT then
      eff = InstantiateEffect(BattleEffectEnum.COMMON_ENEMY_DIE)
    else
      eff = InstantiateEffect(BattleEffectEnum.COMMON_PARTY_DIE)
    end
    if eff == nil then
      return 
    end
    ;
    (CSLuaUtil.SetParent)(eff, BattleRoot)
    ;
    (SortingHelper.SetOrderInLayer)(eff, self.sortingOrder)
    ;
    (CSLuaUtil.SetGOLocalPos)(eff, self.position)
    local time = (LuaEffect.GetEffectDuration)(eff)
    setTimeout(time, function(...)
      -- function num : 0_0_75_0 , upvalues : _ENV, eff, SortingHelper, self, FxManager, ResHelper
      if (BattleMgr.IsInBattle)() == false then
        return 
      end
      if eff then
        (SortingHelper.SetOrderInLayer)(eff, -self.sortingOrder)
        FxManager:ResetFx(eff)
        ;
        (ResHelper.DestroyGameObject)(eff)
      end
    end
)
  end

  battleCard.UpdateHeadInfoVisible = function(self, visible, ...)
    -- function num : 0_0_76 , upvalues : headInfo, BattleConfig
    if (BattleConfig.IsHideBattleHeadInfo)() ~= false then
      local saveVisible = not headInfo
      local isSkillHideHpBar = self:GetIsSkillHideHpBar()
      if isSkillHideHpBar == true then
        headInfo:UpdateVisible(false)
      else
        headInfo:UpdateVisible(saveVisible)
        if saveVisible == true and visible ~= nil then
          headInfo:UpdateVisible(visible)
        end
      end
      do
        local saveVisible = (BattleConfig.IsHideBattleHeadInfo)() == false
        headInfo:UpdateBuffVisible(saveVisible)
        saveVisible = (BattleConfig.IsHideAttackInfo)() == false
        headInfo:UpdateAttackVisible(saveVisible)
        saveVisible = (BattleConfig.IsHideHpInfo)() == false
        headInfo:UpdateHpVisible(saveVisible)
        -- DECOMPILER ERROR: 7 unprocessed JMP targets
      end
    end
  end

  battleCard.Destroy = function(self, ...)
    -- function num : 0_0_77 , upvalues : shadow, ResHelper, flagNextAttack, headInfo, cardInfo, bloodBuffEffectTable, bodyBuffEffectTable, headBuffEffectTable, aroundBuffEffectTable, atkInfo, cardConfig, normalSkillConfig, smallSkillConfig, uniqueSkillConfig, assistSkillConfig, fashionConfig, model, SkeletonAnimationUtil
    self:RemoveWaitUniqueSkillEffect()
    if shadow then
      (ResHelper.DestroyGameObject)(shadow, false)
      shadow = nil
    end
    if flagNextAttack then
      (ResHelper.DestroyGameObject)(flagNextAttack, false)
      flagNextAttack = nil
    end
    if headInfo then
      headInfo:Destroy()
      headInfo = nil
    end
    if cardInfo then
      cardInfo:Destroy()
    end
    bloodBuffEffectTable = {}
    bodyBuffEffectTable = {}
    headBuffEffectTable = {}
    aroundBuffEffectTable = {}
    atkInfo = {}
    cardConfig = nil
    normalSkillConfig = nil
    smallSkillConfig = nil
    uniqueSkillConfig = nil
    assistSkillConfig = nil
    fashionConfig = nil
    if model then
      (SkeletonAnimationUtil.SetColor)(model, 1, 1, 1)
      local trans = nil
      local transform = model.transform
      local count = transform.childCount
      if count > 0 then
        for i = count - 1, 0, -1 do
          trans = transform:GetChild(i)
          if trans.name ~= "HeadInfo" then
            (ResHelper.DestroyGameObject)(trans.gameObject)
          end
        end
      end
      do
        model:SetActive(false)
        ;
        (ResHelper.DestroyGameObject)(model)
        model = nil
      end
    end
  end

  battleCard.ShowTalk = function(self, txt, ...)
    -- function num : 0_0_78 , upvalues : headInfo
    if txt and headInfo then
      headInfo:ShowTalk(txt)
    end
  end

  battleCard.ChangeState = function(self, state, is_loop, callBack, updateNow, mixDuration, ...)
    -- function num : 0_0_79 , upvalues : model, curState, BattleCardState, _ENV, SkeletonAnimationUtil, RemoveEvent, AddEvent
    local go = model
    if go then
      if curState == state and callBack == nil then
        return 
      end
      if curState == BattleCardState.DIE and state ~= curState then
        return 
      end
      -- DECOMPILER ERROR at PC30: Confused about usage of register: R7 in 'UnsetPending'

      if state == BattleCardState.ATTACK or state == BattleCardState.ATTACK_AIR or state == BattleCardState.SKILL or state == BattleCardState.UNIQUE_SKILL then
        BattleMgr.startRecord = true
      else
        -- DECOMPILER ERROR at PC45: Confused about usage of register: R7 in 'UnsetPending'

        if curState == BattleCardState.ATTACK or curState == BattleCardState.ATTACK_AIR or curState == BattleCardState.SKILL then
          BattleMgr.startRecord = false
        end
      end
      if state == BattleCardState.IDLE then
        if self:GetIsStun() == true or self:GetIsSleep() == true then
          state = BattleCardState.STUN
        else
          if self.waitUniqueSkillEffect ~= nil then
            state = BattleCardState.PREPARE
            self:PlayWaitUniqueSkillEffect()
          end
        end
      end
      curState = state
      ;
      (SkeletonAnimationUtil.SetAnimation)(go, 0, curState, is_loop, function(...)
      -- function num : 0_0_79_0 , upvalues : callBack, curState
      if callBack then
        callBack(curState)
      end
    end
, updateNow or false, mixDuration)
      RemoveEvent(model, self.SmokeEvent)
      if is_loop ~= true then
        AddEvent(model, self.SmokeEvent)
      end
      RemoveEvent(model, self.RunSmokeEvent)
      AddEvent(model, self.RunSmokeEvent)
    end
  end

  battleCard.RemoveBuff = function(self, buff, removeEffect, ...)
    -- function num : 0_0_80 , upvalues : BattleBuffMgr, _ENV
    if removeEffect == true then
      (BattleBuffMgr.RemoveBuffFromPlayBackList)(buff:GetBuffInfo())
      ;
      (BattleBuff.PlayBuffRemove)(self, buff:GetBuffInfo())
    end
  end

  battleCard.IsDisplayAlive = function(self, ...)
    -- function num : 0_0_81
    if self:GetDisPlayHp() <= 0 then
      return false
    end
    return true
  end

  battleCard.IsDead = function(self, ...)
    -- function num : 0_0_82
    do return self:GetHp() <= 0 end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end

  battleCard.GetCardId = function(self, ...)
    -- function num : 0_0_83 , upvalues : cardInfo
    return cardInfo:GetCardId()
  end

  battleCard.GetCardUid = function(self, ...)
    -- function num : 0_0_84 , upvalues : cardInfo
    return cardInfo:GetCardUid()
  end

  battleCard.GetPosIndex = function(self, ...)
    -- function num : 0_0_85 , upvalues : cardInfo
    return cardInfo:GetPosIndex()
  end

  battleCard.GetLevel = function(self, ...)
    -- function num : 0_0_86 , upvalues : cardInfo
    return cardInfo:GetLevel()
  end

  battleCard.GetFashionId = function(self, ...)
    -- function num : 0_0_87 , upvalues : cardInfo
    return cardInfo:GetFashionId()
  end

  battleCard.GetDisPlayHp = function(self, ...)
    -- function num : 0_0_88 , upvalues : headInfo
    if headInfo then
      return headInfo.lastHp
    else
      return self:GetHp()
    end
  end

  battleCard.GetHp = function(self, ...)
    -- function num : 0_0_89 , upvalues : cardInfo
    return cardInfo:GetHp()
  end

  battleCard.SetHp = function(self, hp, pos, ...)
    -- function num : 0_0_90 , upvalues : cardInfo
    if pos then
      local oriHp = cardInfo:GetHp()
      local hpChange = oriHp - hp
      if hpChange > 0 then
        self:SetFoePos(pos, hpChange)
      end
    end
    do
      cardInfo:SetHp(hp)
    end
  end

  battleCard.GetStar = function(self, ...)
    -- function num : 0_0_91 , upvalues : cardInfo
    return cardInfo:GetStar()
  end

  battleCard.GetQuality = function(self, ...)
    -- function num : 0_0_92 , upvalues : cardInfo
    return cardInfo:GetQuality()
  end

  battleCard.GetMaxHp = function(self, baseAttr, ...)
    -- function num : 0_0_93 , upvalues : cardInfo
    if baseAttr ~= true or not cardInfo:GetMaxHp() then
      return cardInfo:GetMaxHp() + self:GetBuffAttr("maxHp")
    end
  end

  battleCard.GetAtk = function(self, baseAttr, ...)
    -- function num : 0_0_94 , upvalues : cardInfo
    if baseAttr ~= true or not cardInfo:GetAtk() then
      return cardInfo:GetAtk() + self:GetBuffAttr("atk")
    end
  end

  battleCard.GetDef = function(self, baseAttr, ...)
    -- function num : 0_0_95 , upvalues : cardInfo
    if baseAttr ~= true or not cardInfo:GetDef() then
      return cardInfo:GetDef() + self:GetBuffAttr("def")
    end
  end

  battleCard.GetCrt = function(self, baseAttr, ...)
    -- function num : 0_0_96 , upvalues : cardInfo
    if baseAttr ~= true or not cardInfo:GetCrt() then
      return cardInfo:GetCrt() + self:GetBuffAttr("crt")
    end
  end

  battleCard.GetRec = function(self, baseAttr, ...)
    -- function num : 0_0_97 , upvalues : cardInfo
    if baseAttr ~= true or not cardInfo:GetRec() then
      return cardInfo:GetRec() + self:GetBuffAttr("rec")
    end
  end

  battleCard.GetBlk = function(self, baseAttr, ...)
    -- function num : 0_0_98 , upvalues : cardInfo
    if baseAttr ~= true or not cardInfo:GetBlk() then
      return cardInfo:GetBlk() + self:GetBuffAttr("blk")
    end
  end

  battleCard.GetReb = function(self, baseAttr, ...)
    -- function num : 0_0_99 , upvalues : cardInfo
    if baseAttr ~= true or not cardInfo:GetReb() then
      return cardInfo:GetReb() + self:GetBuffAttr("reb")
    end
  end

  battleCard.GetHit = function(self, baseAttr, ...)
    -- function num : 0_0_100 , upvalues : cardInfo
    if baseAttr ~= true or not cardInfo:GetHit() then
      return cardInfo:GetHit() + self:GetBuffAttr("hit")
    end
  end

  battleCard.GetEva = function(self, baseAttr, ...)
    -- function num : 0_0_101 , upvalues : cardInfo
    if baseAttr ~= true or not cardInfo:GetEva() then
      return cardInfo:GetEva() + self:GetBuffAttr("eva")
    end
  end

  battleCard.GetArp = function(self, baseAttr, ...)
    -- function num : 0_0_102 , upvalues : cardInfo
    if baseAttr ~= true or not cardInfo:GetArp() then
      return cardInfo:GetArp() + self:GetBuffAttr("arp")
    end
  end

  battleCard.GetRea = function(self, baseAttr, ...)
    -- function num : 0_0_103 , upvalues : cardInfo
    if baseAttr ~= true or not cardInfo:GetRea() then
      return cardInfo:GetRea() + self:GetBuffAttr("rea")
    end
  end

  battleCard.GetCrtInt = function(self, baseAttr, ...)
    -- function num : 0_0_104 , upvalues : cardInfo
    if baseAttr ~= true or not cardInfo:GetCrtInt() then
      return cardInfo:GetCrtInt() + self:GetBuffAttr("ctr_int")
    end
  end

  battleCard.GetRecInt = function(self, baseAttr, ...)
    -- function num : 0_0_105 , upvalues : cardInfo
    if baseAttr ~= true or not cardInfo:GetRecInt() then
      return cardInfo:GetRecInt() + self:GetBuffAttr("rec_int")
    end
  end

  battleCard.GetBlkInt = function(self, baseAttr, ...)
    -- function num : 0_0_106 , upvalues : cardInfo
    if baseAttr ~= true or not cardInfo:GetBlkInt() then
      return cardInfo:GetBlkInt() + self:GetBuffAttr("blk_int")
    end
  end

  battleCard.GetRebInt = function(self, baseAttr, ...)
    -- function num : 0_0_107 , upvalues : cardInfo
    if baseAttr ~= true or not cardInfo:GetRecInt() then
      return cardInfo:GetRecInt() + self:GetBuffAttr("reb_int")
    end
  end

  battleCard.GetAddInt = function(self, baseAttr, ...)
    -- function num : 0_0_108 , upvalues : cardInfo
    if baseAttr ~= true or not cardInfo:GetAddInt() then
      return cardInfo:GetAddInt() + self:GetBuffAttr("add_int")
    end
  end

  battleCard.GetExdInt = function(self, baseAttr, ...)
    -- function num : 0_0_109 , upvalues : cardInfo
    if baseAttr ~= true or not cardInfo:GetExdInt() then
      return cardInfo:GetExdInt() + self:GetBuffAttr("exd_int")
    end
  end

  battleCard.GetArpInt = function(self, baseAttr, ...)
    -- function num : 0_0_110 , upvalues : cardInfo
    if baseAttr ~= true or not cardInfo:GetArpInt() then
      return cardInfo:GetArpInt() + self:GetBuffAttr("arp_int")
    end
  end

  battleCard.GetReaInt = function(self, baseAttr, ...)
    -- function num : 0_0_111 , upvalues : cardInfo
    if baseAttr ~= true or not cardInfo:GetReaInt() then
      return cardInfo:GetReaInt() + self:GetBuffAttr("rea_int")
    end
  end

  battleCard.GetSpd = function(self, baseAttr, ...)
    -- function num : 0_0_112 , upvalues : cardInfo
    if baseAttr ~= true or not cardInfo:GetSpd() then
      return cardInfo:GetSpd() + self:GetBuffAttr("spd")
    end
  end

  battleCard.GetLuck = function(self, baseAttr, ...)
    -- function num : 0_0_113 , upvalues : cardInfo
    if baseAttr ~= true or not cardInfo:GetLuck() then
      return cardInfo:GetLuck() + self:GetBuffAttr("luck")
    end
  end

  battleCard.GetMaxDander = function(self, baseAttr, ...)
    -- function num : 0_0_114 , upvalues : cardInfo
    if baseAttr ~= true or not cardInfo:GetMaxDander() then
      return cardInfo:GetMaxDander() + self:GetBuffAttr("max_dander")
    end
  end

  battleCard.GetMaxDanderLimit = function(self, ...)
    -- function num : 0_0_115 , upvalues : cardInfo
    return cardInfo:GetMaxDanderLimit()
  end

  battleCard.GetDisPlayDander = function(self, ...)
    -- function num : 0_0_116 , upvalues : headInfo
    if headInfo then
      return headInfo.lastDander
    else
      return self:GetDander()
    end
  end

  battleCard.GetDander = function(self, ...)
    -- function num : 0_0_117 , upvalues : cardInfo
    return cardInfo:GetDander()
  end

  battleCard.SetDander = function(self, dander, ...)
    -- function num : 0_0_118 , upvalues : cardInfo
    cardInfo:SetDander(dander)
  end

  battleCard.GetDanderRound = function(self, baseAttr, ...)
    -- function num : 0_0_119 , upvalues : cardInfo
    if baseAttr ~= true or not cardInfo:GetDanderRound() then
      return cardInfo:GetDanderRound() + self:GetBuffAttr("dander_round")
    end
  end

  battleCard.GetDanderAtk = function(self, baseAttr, ...)
    -- function num : 0_0_120 , upvalues : cardInfo
    if baseAttr ~= true or not cardInfo:GetDanderAtk() then
      return cardInfo:GetDanderAtk() + self:GetBuffAttr("dander_atk")
    end
  end

  battleCard.GetDanderHit = function(self, baseAttr, ...)
    -- function num : 0_0_121 , upvalues : cardInfo
    if baseAttr ~= true or not cardInfo:GetDanderHit() then
      return cardInfo:GetDanderHit() + self:GetBuffAttr("dander_hit")
    end
  end

  battleCard.GetDanderKill = function(self, baseAttr, ...)
    -- function num : 0_0_122 , upvalues : cardInfo
    if baseAttr ~= true or not cardInfo:GetDanderKill() then
      return cardInfo:GetDanderKill() + self:GetBuffAttr("dander_kill")
    end
  end

  battleCard.GetExtDamage = function(self, baseAttr, ...)
    -- function num : 0_0_123 , upvalues : cardInfo
    if baseAttr ~= true or not cardInfo:GetExtDamage() then
      return cardInfo:GetExtDamage() + self:GetBuffAttr("ext_damage")
    end
  end

  battleCard.GetExtDamageSub = function(self, baseAttr, ...)
    -- function num : 0_0_124 , upvalues : cardInfo
    if baseAttr ~= true or not cardInfo:GetExtDamageSub() then
      return cardInfo:GetExtDamageSub() + self:GetBuffAttr("ext_damage_sub")
    end
  end

  battleCard.GetTreatAdd = function(self, baseAttr, ...)
    -- function num : 0_0_125 , upvalues : cardInfo
    if baseAttr ~= true or not cardInfo:GetTreatAdd() then
      return cardInfo:GetTreatAdd() + self:GetBuffAttr("treat_add")
    end
  end

  battleCard.GetTreatSub = function(self, baseAttr, ...)
    -- function num : 0_0_126 , upvalues : cardInfo
    if baseAttr ~= true or not cardInfo:GetTreatSub() then
      return cardInfo:GetTreatSub() + self:GetBuffAttr("treat_sub")
    end
  end

  battleCard.GetBeTreatAdd = function(self, baseAttr, ...)
    -- function num : 0_0_127 , upvalues : cardInfo
    if baseAttr ~= true or not cardInfo:GetBeTreatAdd() then
      return cardInfo:GetBeTreatAdd() + self:GetBuffAttr("be_treat_add")
    end
  end

  battleCard.GetBeTreatSub = function(self, baseAttr, ...)
    -- function num : 0_0_128 , upvalues : cardInfo
    if baseAttr ~= true or not cardInfo:GetBeTreatSub() then
      return cardInfo:GetBeTreatSub() + self:GetBuffAttr("be_treat_sub")
    end
  end

  battleCard.GetAtkEvaProb = function(self, baseAttr, ...)
    -- function num : 0_0_129 , upvalues : cardInfo
    if baseAttr ~= true or not cardInfo:GetAtkEvaProb() then
      return cardInfo:GetAtkEvaProb() + self:GetBuffAttr("atk_eva_prob")
    end
  end

  battleCard.GetSkillEvaProb = function(self, baseAttr, ...)
    -- function num : 0_0_130 , upvalues : cardInfo
    if baseAttr ~= true or not cardInfo:GetSkillEvaProb() then
      return cardInfo:GetSkillEvaProb() + self:GetBuffAttr("skill_eva_prob")
    end
  end

  battleCard.GetCrtProp = function(self, baseAttr, ...)
    -- function num : 0_0_131 , upvalues : cardInfo
    if baseAttr ~= true or not cardInfo:GetCrtProp() then
      return cardInfo:GetCrtProp() + self:GetBuffAttr("crt_prob")
    end
  end

  battleCard.GetBlkProp = function(self, baseAttr, ...)
    -- function num : 0_0_132 , upvalues : cardInfo
    if baseAttr ~= true or not cardInfo:GetBlkProp() then
      return cardInfo:GetBlkProp() + self:GetBuffAttr("blk_prob")
    end
  end

  battleCard.GetSkillInfo = function(self, ...)
    -- function num : 0_0_133 , upvalues : cardInfo
    return cardInfo:GetSkillInfo()
  end

  battleCard.GetEquipInfo = function(self, ...)
    -- function num : 0_0_134 , upvalues : cardInfo
    return cardInfo:GetEquipInfo()
  end

  battleCard.AddAttrValue = function(self, ...)
    -- function num : 0_0_135 , upvalues : cardInfo
    return cardInfo:AddAttrValue(...)
  end

  battleCard.GetBuffAttr = function(self, name, ...)
    -- function num : 0_0_136 , upvalues : _ENV, BattleBuffMgr, ipairs
    local totalValue = 0
    local attributeId = (CardData.GetAttrIdByName)(name)
    if attributeId then
      local selfPos = self:GetPosIndex()
      local buffTable = (BattleBuffMgr.GetBuffList)()
      for _,v in ipairs(buffTable) do
        local defPos = v:GetCurDefPos()
        if defPos == selfPos then
          totalValue = totalValue + v:GetAttributeValue(attributeId)
        end
      end
      if totalValue ~= 0 and IsBattleServer == nil then
        print("buff带来的属性变化，属性:", (CardData.GetAttrRemarkById)(attributeId), " value:", totalValue)
        ;
        (BattleData.SaveBattleProcess)("   buff带来的属性变化，属性:" .. (CardData.GetAttrRemarkById)(attributeId) .. " value:" .. totalValue)
      end
    end
    do
      return totalValue
    end
  end

  battleCard.GetIsReadyAtk = function(self, ...)
    -- function num : 0_0_137 , upvalues : isReadyAtk
    return isReadyAtk
  end

  battleCard.GetCampFlag = function(self, ...)
    -- function num : 0_0_138 , upvalues : campFlag
    return campFlag
  end

  battleCard.GetEnemyCampFlag = function(self, ...)
    -- function num : 0_0_139 , upvalues : enemyCampFlag
    return enemyCampFlag
  end

  battleCard.GetCurState = function(self, ...)
    -- function num : 0_0_140 , upvalues : curState
    return curState
  end

  battleCard.GetBuffTable = function(self, ...)
    -- function num : 0_0_141 , upvalues : buffTable
    return buffTable
  end

  battleCard.GetCardInfo = function(self, ...)
    -- function num : 0_0_142 , upvalues : cardInfo
    return cardInfo
  end

  battleCard.SetAtkInfo = function(self, info, ...)
    -- function num : 0_0_143 , upvalues : atkInfo
    atkInfo = info
  end

  battleCard.GetAtkInfo = function(self, ...)
    -- function num : 0_0_144 , upvalues : atkInfo
    return atkInfo
  end

  battleCard.SetFloatUpState = function(self, state, ...)
    -- function num : 0_0_145 , upvalues : floatUpState
    floatUpState = state
  end

  battleCard.GetFloatUpState = function(self, ...)
    -- function num : 0_0_146 , upvalues : floatUpState
    return floatUpState
  end

  battleCard.GetModel = function(self, ...)
    -- function num : 0_0_147 , upvalues : model
    return model
  end

  battleCard.GetShadow = function(self, ...)
    -- function num : 0_0_148 , upvalues : shadow
    return shadow
  end

  battleCard.GetFlagNextAttack = function(self, ...)
    -- function num : 0_0_149 , upvalues : flagNextAttack
    return flagNextAttack
  end

  battleCard.GetHeadInfo = function(self, ...)
    -- function num : 0_0_150 , upvalues : headInfo
    return headInfo
  end

  battleCard.SetSortingOrder = function(self, sortingOrder, ...)
    -- function num : 0_0_151 , upvalues : model, SkeletonAnimationUtil
    do
      if model then
        local rd = (SkeletonAnimationUtil.GetSkeletonRender)(model)
        if rd then
          rd.sortingOrder = sortingOrder
        end
      end
      self.sortingOrder = sortingOrder
    end
  end

  battleCard.ResetSortingOrder = function(self, ...)
    -- function num : 0_0_152 , upvalues : BattleConfig, math
    self:SetSortingOrder(BattleConfig.sortingOrderInit + (math.floor)(self:GetPosIndex() % 10) * 10)
  end

  battleCard.SetIsStun = function(self, isStun, ...)
    -- function num : 0_0_153
    self.isStun = isStun
  end

  battleCard.GetIsStun = function(self, ...)
    -- function num : 0_0_154
    return self.isStun
  end

  battleCard.SetIsSilent = function(self, isSilent, ...)
    -- function num : 0_0_155
    self.isSilent = isSilent
  end

  battleCard.GetIsSilent = function(self, ...)
    -- function num : 0_0_156
    return self.isSilent
  end

  battleCard.SetIsSleep = function(self, isSleep, ...)
    -- function num : 0_0_157
    self.isSleep = isSleep
  end

  battleCard.GetIsSleep = function(self, ...)
    -- function num : 0_0_158
    return self.isSleep
  end

  battleCard.SetControlType = function(self, effectId, value, ...)
    -- function num : 0_0_159 , upvalues : BattleDisplayEffect, curState, BattleCardState
    if effectId == BattleDisplayEffect.STUN then
      self:SetIsStun(value)
      -- DECOMPILER ERROR at PC15: Unhandled construct in 'MakeBoolean' P1

      if value == true and curState == BattleCardState.IDLE then
        self:ChangeState(BattleCardState.STUN, true)
      end
      if curState == BattleCardState.STUN then
        self:Stand()
      end
    else
      if effectId == BattleDisplayEffect.SILENT then
        self:SetIsSilent(value)
      else
        if effectId == BattleDisplayEffect.SLEEP then
          self:SetIsSleep(value)
          -- DECOMPILER ERROR at PC46: Unhandled construct in 'MakeBoolean' P1

          if value == true and curState == BattleCardState.IDLE then
            self:ChangeState(BattleCardState.STUN, true)
          end
        end
      end
    end
    if curState == BattleCardState.STUN then
      self:Stand()
    end
  end

  battleCard.UpdateAtkOrder = function(self, atkOrder, ...)
    -- function num : 0_0_160 , upvalues : headInfo
    if headInfo then
      headInfo:UpdateAtkOrderTxt(atkOrder)
    end
  end

  battleCard:Init(data)
  return battleCard
end


