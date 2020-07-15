-- params : ...
-- function num : 0 , upvalues : _ENV
local SkillParse = {isDisplayMask = false, isClearMask = false}
local atkCard = nil
local assistAtkCards = {}
local defCards = {}
local totalDefCards = {}
local atkInfo = nil
local hurtTableList = {}
local danderDefList = {}
local ShakeAnimPlay = require("ShakeAnimPlay")
if SimpleTimer then
  local setTimeout = SimpleTimer.setTimeout
end
local LayerMaskNames = LayerMaskNames
if CSLuaUtil then
  local ChangeLayer = CSLuaUtil.ChangeLayer
end
SkillParse.Init = function(atkEndCallBack, skillShowConfig, ...)
  -- function num : 0_0 , upvalues : SkillParse, atkInfo, _ENV, assistAtkCards, atkCard, defCards, hurtTableList, danderDefList, totalDefCards
  (SkillParse.Clear)()
  SkillParse.atkEndCallBack = atkEndCallBack
  SkillParse.curHitIndex = 1
  atkInfo = BattleAtk.curAtkInfo
  local assistInfo = atkInfo.assistAtkInfo
  for _,v in ipairs(assistInfo) do
    local atkCardUid = v.atkCardUid
    local card = (BattleData.GetCardInfoByUid)(atkCardUid)
    if card then
      (table.insert)(assistAtkCards, card)
    end
  end
  atkCard = (BattleData.GetCardInfoByUid)(atkInfo.atkCardUid)
  for _,defCardInfo in ipairs(atkInfo.defCardsInfo) do
    local defCardUid = defCardInfo.defCardUid
    local defCard = (BattleData.GetCardInfoByUid)(defCardUid)
    if defCardInfo.isCounter == false then
      (table.insert)(defCards, defCard)
    end
  end
  if #atkInfo.doubleAtkInfo > 0 then
    for _,doubleAtk in ipairs(atkInfo.doubleAtkInfo) do
      for _,defCardInfo in ipairs(doubleAtk.defCardsInfo) do
        local defCardUid = defCardInfo.defCardUid
        local defCard = (BattleData.GetCardInfoByUid)(defCardUid)
        if defCardInfo.isCounter == false then
          local isFind = false
          for i,v in ipairs(defCards) do
            if v:GetPosIndex() == defCard:GetPosIndex() then
              isFind = true
            end
          end
          if isFind == false then
            (table.insert)(defCards, defCard)
          end
        end
      end
    end
  end
  do
    if SkillScript then
      local count = SkillScript.totalHitCount
      local hurtSectionTable = {}
      if skillShowConfig and skillShowConfig.hurt_section then
        hurtSectionTable = split(skillShowConfig.hurt_section, ":")
        if #hurtSectionTable < count then
          for i = #hurtSectionTable + 1, count do
            hurtSectionTable[i] = 1
          end
        end
      else
        do
          for i = 1, count do
            hurtSectionTable[i] = 1
          end
          do
            local totalCount = 0
            for i,v in ipairs(hurtSectionTable) do
              totalCount = totalCount + v
            end
            hurtTableList = (BattleUtil.SplitHurt)(atkInfo.defCardsInfo, count, hurtSectionTable, totalCount)
          end
        end
      end
    end
  end
end

SkillParse.Clear = function(...)
  -- function num : 0_1 , upvalues : _ENV, SkillParse, danderDefList, hurtTableList, atkCard, assistAtkCards, defCards, totalDefCards, atkInfo
  loge(" SkillParse.Clear 清除")
  SkillParse.isUniqueSkill = false
  danderDefList = {}
  hurtTableList = {}
  SkillParse.atkEndCallBack = nil
  SkillParse.curHitIndex = 1
  atkCard = nil
  assistAtkCards = {}
  defCards = {}
  totalDefCards = {}
  atkInfo = nil
end

Move = function(...)
  -- function num : 0_2
end

CurveMove = function(...)
  -- function num : 0_3
end

DelayCall = function(delayTime, callback, ...)
  -- function num : 0_4 , upvalues : setTimeout
  if not delayTime then
    delayTime = 0
  end
  if delayTime > 100 then
    delayTime = delayTime / 1000
  end
  setTimeout(delayTime or 0, callback)
end

ChangeAtkState = function(delayTime, state, loop, ...)
  -- function num : 0_5 , upvalues : atkCard, setTimeout
  if not delayTime then
    delayTime = 0
  end
  if delayTime > 100 then
    delayTime = delayTime / 1000
  end
  local callback = function(...)
    -- function num : 0_5_0 , upvalues : atkCard, state, loop
    if atkCard then
      atkCard:ChangeState(state, loop, nil, true, "0")
    end
  end

  if delayTime == 0 then
    callback()
  else
    setTimeout(delayTime or 0, callback)
  end
end

ChangeDefState = function(delayTime, state, lastAtk, hitEffect, ...)
  -- function num : 0_6 , upvalues : totalDefCards, _ENV, hurtTableList, SkillParse, atkInfo, setTimeout
  if not delayTime then
    delayTime = 0
  end
  if delayTime > 100 then
    delayTime = delayTime / 1000
  end
  if totalDefCards and #totalDefCards > 0 then
    local callback = function(...)
    -- function num : 0_6_0 , upvalues : _ENV, totalDefCards, hurtTableList, SkillParse, atkInfo, hitEffect, lastAtk, setTimeout
    for i,defCard in ipairs(totalDefCards) do
      do
        local hurtTable = hurtTableList[i]
        local hurtData = hurtTable[SkillParse.curHitIndex]
        if atkInfo then
          local isTreatment = not hurtData or atkInfo.isTreatment
        end
        defCard:ChangeHp(hurtData, atkInfo, nil, nil, #hurtTable <= SkillParse.curHitIndex, SkillParse.curHitIndex)
        if SkillParse.curHitIndex == 1 then
          (BattlePlay.PlayBuff)(atkInfo, nil, nil, BattleBuffSettleRoundType.BEFORE_ATTACK, BattlePlaySettleRoundType.FIRST_ATTACK)
          if isTreatment ~= true then
            (AudioManager.PlayBattleVoice)(defCard:GetFashionId(), CVAudioType.HitBubble)
          end
        end
        defCard:PlayHitEffect(atkInfo, true, nil, nil, hitEffect)
        if #hurtTable <= SkillParse.curHitIndex then
          if lastAtk then
            loge("-------------技能最后一下伤害")
            setTimeout(0.4, function(...)
      -- function num : 0_6_0_0 , upvalues : defCard
      defCard:DealAfterAtk()
    end
)
          end
          if SkillParse.atkEndCallBack then
            (SkillParse.atkEndCallBack)()
            SkillParse.atkEndCallBack = nil
          end
        end
      end
    end
    SkillParse.curHitIndex = SkillParse.curHitIndex + 1
    -- DECOMPILER ERROR: 4 unprocessed JMP targets
  end

    if delayTime == 0 then
      callback()
    else
      setTimeout(delayTime or 0, callback)
    end
  end
end

CameraShake = function(delayTime, animName, ...)
  -- function num : 0_7 , upvalues : _ENV, ShakeAnimPlay, setTimeout
  if not delayTime then
    delayTime = 0
  end
  if delayTime > 100 then
    delayTime = delayTime / 1000
  end
  local callback = function(...)
    -- function num : 0_7_0 , upvalues : _ENV, ShakeAnimPlay, animName
    local camera = Game.battleCamera
    if camera then
      (ShakeAnimPlay.PlayShake)(animName, camera)
    end
  end

  if delayTime == 0 then
    callback()
  else
    setTimeout(delayTime or 0, callback)
  end
end

ShowSkillName = function(...)
  -- function num : 0_8
end

MoveAtkCard = function(delayTime, position, interval, ...)
  -- function num : 0_9 , upvalues : _ENV, atkCard, setTimeout
  if delayTime == 0 then
    interval = 0.1
  end
  if not delayTime then
    delayTime = 0
  end
  if delayTime > 100 then
    delayTime = delayTime / 1000
  end
  if position and position.y == 0 then
    position = position + BattleConfig.cardPositionOff
  end
  local callback = function(...)
    -- function num : 0_9_0 , upvalues : atkCard, position, _ENV, interval
    if position == nil and atkCard:GetCampFlag() == BattleCardCamp.RIGHT then
      if not interval then
        (Util.MoveTo)(atkCard:GetModel(), atkCard:GetFlipPosition(), not atkCard or 0.4)
        ;
        (Util.MoveTo)(atkCard:GetModel(), position or atkCard.position, interval or 0.4)
      end
    end
  end

  if delayTime == 0 then
    callback()
  else
    setTimeout(delayTime or 0, callback)
  end
end

RotationAtkCard = function(delayTime, rotation, ...)
  -- function num : 0_10 , upvalues : atkCard, _ENV, setTimeout
  if not delayTime then
    delayTime = 0
  end
  if delayTime > 100 then
    delayTime = delayTime / 1000
  end
  local callback = function(...)
    -- function num : 0_10_0 , upvalues : atkCard, rotation, _ENV
    if atkCard then
      if rotation == nil then
        local battleCamera = Game.battleCamera
        local cameraRotation = (battleCamera.transform).localEulerAngles
        ;
        (CSLuaUtil.SetGOLocalEuler)(atkCard:GetModel(), cameraRotation.x, 0, 0)
      else
        do
          ;
          (CSLuaUtil.SetGOLocalEuler)(atkCard:GetModel(), rotation.x, rotation.y, rotation.z)
        end
      end
    end
  end

  if delayTime == 0 then
    callback()
  else
    setTimeout(delayTime or 0, callback)
  end
end

local GetDefPositionOff = function(targetPosition, ...)
  -- function num : 0_11 , upvalues : defCards, _ENV
  if defCards then
    local minDis, card = nil, nil
    local startX, startZ = 0, 0
    for _,v in ipairs(defCards) do
      local pos = v.position
      if minDis == nil then
        minDis = pos.x - startX ^ 2 + pos.z - startZ ^ 2
        card = v
      else
        if pos.x - startX ^ 2 + pos.z - startZ ^ 2 < minDis then
          minDis = pos.x - startX ^ 2 + pos.z - startZ ^ 2
          card = v
        end
      end
    end
    if card then
      return card.position
    end
  end
end

MoveDefCard = function(delayTime, position, interval, ...)
  -- function num : 0_12 , upvalues : _ENV, defCards, GetDefPositionOff, setTimeout
  if not delayTime then
    delayTime = 0
  end
  if delayTime > 100 then
    delayTime = delayTime / 1000
  end
  if position and position.y == 0 then
    position = position + BattleConfig.cardPositionOff
  end
  local callback = function(...)
    -- function num : 0_12_0 , upvalues : defCards, GetDefPositionOff, position, _ENV, interval
    if defCards then
      local posOff = GetDefPositionOff(position)
      for _,card in ipairs(defCards) do
        if position == nil and card:GetCampFlag() == BattleCardCamp.LEFT then
          if not interval then
            (Util.MoveTo)(card:GetModel(), card:GetFlipPosition(), not card or 0.4)
            local ratio = 1
            if card:GetPosIndex() < 100 then
              ratio = -1
            end
            do
              if not position or not card.position - posOff + Vector3(position.x * ratio, position.y, position.z) then
                local targetPosition = card.position
              end
              if card:GetCampFlag() == BattleCardCamp.LEFT then
                targetPosition.x = -targetPosition.x
              end
              ;
              (Util.MoveTo)(card:GetModel(), targetPosition, interval or 0.4)
              -- DECOMPILER ERROR at PC73: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC73: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC73: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC73: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    end
  end

  if delayTime == 0 then
    callback()
  else
    setTimeout(delayTime or 0, callback)
  end
end

MoveDefCardFront = function(delayTime, position, interval, ...)
  -- function num : 0_13 , upvalues : _ENV, defCards, setTimeout
  if not delayTime then
    delayTime = 0
  end
  if delayTime > 100 then
    delayTime = delayTime / 1000
  end
  if not position then
    position = BattleConfig.positionZero
  end
  local callback = function(...)
    -- function num : 0_13_0 , upvalues : defCards, _ENV, position, interval
    if defCards then
      for _,card in ipairs(defCards) do
        if card then
          local ratio = 1
          if card:GetPosIndex() < 100 then
            ratio = -1
          end
          if not interval then
            do
              (Util.MoveTo)(card:GetModel(), card:GetCampFrontPosition(true) - Vector3(position.x * ratio, position.y, position.z), card:GetCampFlag() ~= BattleCardCamp.LEFT or 0.4)
              ;
              (Util.MoveTo)(card:GetModel(), card:GetCampFrontPosition() + Vector3(position.x * ratio, position.y, position.z), interval or 0.4)
              -- DECOMPILER ERROR at PC59: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC59: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC59: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC59: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    end
  end

  if delayTime == 0 then
    callback()
  else
    setTimeout(delayTime or 0, callback)
  end
end

SetAtkCardActive = function(delayTime, active, ...)
  -- function num : 0_14 , upvalues : atkCard, setTimeout
  if not delayTime then
    delayTime = 0
  end
  if delayTime > 100 then
    delayTime = delayTime / 1000
  end
  local callback = function(...)
    -- function num : 0_14_0 , upvalues : atkCard, active
    if atkCard then
      atkCard:SetVisible(active)
    end
  end

  if delayTime == 0 then
    callback()
  else
    setTimeout(delayTime or 0, callback)
  end
end

SetDefCardsActive = function(delayTime, active, notIncludeAtkCard, ...)
  -- function num : 0_15 , upvalues : defCards, _ENV, atkCard, setTimeout
  if not delayTime then
    delayTime = 0
  end
  if delayTime > 100 then
    delayTime = delayTime / 1000
  end
  local callback = function(...)
    -- function num : 0_15_0 , upvalues : defCards, _ENV, notIncludeAtkCard, atkCard, active
    if defCards then
      for _,defCard in ipairs(defCards) do
        if notIncludeAtkCard == true and defCard:GetPosIndex() == atkCard:GetPosIndex() then
          do
            defCard:SetVisible(active)
            -- DECOMPILER ERROR at PC21: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC21: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end

  if delayTime == 0 then
    callback()
  else
    setTimeout(delayTime or 0, callback)
  end
end

HideUICamera = function(delayTime, ...)
  -- function num : 0_16 , upvalues : _ENV, setTimeout
  if delayTime > 100 then
    delayTime = delayTime / 1000
  end
  local callback = function(...)
    -- function num : 0_16_0 , upvalues : _ENV
    (Util.SetCameraActive)(Game.uiCamera, false)
  end

  if delayTime == 0 then
    callback()
  else
    setTimeout(delayTime or 0, callback)
  end
end

ShowUICamera = function(delayTime, ...)
  -- function num : 0_17 , upvalues : _ENV, setTimeout
  if not delayTime then
    delayTime = 0
  end
  if delayTime > 100 then
    delayTime = delayTime / 1000
  end
  local callback = function(...)
    -- function num : 0_17_0 , upvalues : _ENV
    (Util.SetCameraActive)(Game.uiCamera, true)
  end

  if delayTime == 0 then
    callback()
  else
    setTimeout(delayTime or 0, callback)
  end
end

local PlayEffect = function(card, effectName, ...)
  -- function num : 0_18 , upvalues : _ENV, LayerMaskNames, setTimeout
  if card and effectName then
    local eff = (ResHelper.InstantiateEffect)(effectName)
    do
      if eff then
        (CSLuaUtil.SetParent)(eff, card:GetModel())
        ;
        (CSLuaUtil.SetGOLocalPos)(eff, 0, 0, 0)
        ;
        (BattlePlay.SetLayer)(eff)
        ;
        (SortingHelper.SetOrderInLayer)(eff, self.sortingOrder)
      end
      ;
      (CSLuaUtil.SetParent)(eff, BattleRoot)
      ;
      (BattlePlay.SetLayer)(eff, LayerMaskNames.SKILL_EFFECT)
      ;
      (SortingHelper.SetOrderInLayer)(eff, card.sortingOrder)
      local time = (LuaEffect.GetEffectDuration)(eff)
      setTimeout(time, function(...)
    -- function num : 0_18_0 , upvalues : _ENV, eff, card
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

PlayAtkEffect = function(delayTime, effectName, ...)
  -- function num : 0_19 , upvalues : PlayEffect, atkCard, setTimeout
  if not delayTime then
    delayTime = 0
  end
  if delayTime > 100 then
    delayTime = delayTime / 1000
  end
  if delayTime == 0 then
    PlayEffect(atkCard, effectName)
  else
    setTimeout(delayTime or 0, function(...)
    -- function num : 0_19_0 , upvalues : PlayEffect, atkCard, effectName
    PlayEffect(atkCard, effectName)
  end
)
  end
end

PlayADefEffect = function(delayTime, effectName, ...)
  -- function num : 0_20 , upvalues : _ENV, defCards, PlayEffect, setTimeout
  if not delayTime then
    delayTime = 0
  end
  if delayTime > 100 then
    delayTime = delayTime / 1000
  end
  if delayTime == 0 then
    for _,card in ipairs(defCards) do
      PlayEffect(card, effectName)
    end
  else
    do
      setTimeout(delayTime or 0, function(...)
    -- function num : 0_20_0 , upvalues : _ENV, defCards, PlayEffect, effectName
    for _,card in ipairs(defCards) do
      PlayEffect(card, effectName)
    end
  end
)
    end
  end
end

local IsJoinAttack = function(card, ...)
  -- function num : 0_21 , upvalues : atkCard, assistAtkCards, _ENV, defCards
  if card then
    local position = card:GetPosIndex()
    if atkCard and position == atkCard:GetPosIndex() then
      return true
    end
    if assistAtkCards then
      for _,card in ipairs(assistAtkCards) do
        if position == card:GetPosIndex() then
          return true
        end
      end
    end
    do
      if defCards then
        for _,card in ipairs(defCards) do
          if position == card:GetPosIndex() then
            return true
          end
        end
      end
      do
        return false
      end
    end
  end
end

local UpdateAllCardHpBarVisible = function(visible, ...)
  -- function num : 0_22 , upvalues : atkCard, _ENV
  if atkCard then
    local allCard = (BattleData.GetAllCardList)()
    for _,card in ipairs(allCard) do
      if card:IsDisplayAlive() == true then
        card:UpdateHeadInfoVisible(visible)
      end
    end
  end
end

local UpdateAllCardFlip = function(visible, ...)
  -- function num : 0_23 , upvalues : atkCard, _ENV, SkillParse
  if atkCard:GetCampFlag() ~= BattleCardCamp.RIGHT or SkillParse.isUniqueSkill ~= true then
    local needFlip = not atkCard
    local allCard = (BattleData.GetAllCardList)()
    for _,card in ipairs(allCard) do
      if needFlip == true then
        card:FlipPositionAndFace(not visible)
      end
    end
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
  end
end

local UpdateAllCardColor = function(visible, ...)
  -- function num : 0_24 , upvalues : atkCard, _ENV
  if atkCard then
    local allCard = (BattleData.GetAllCardList)()
    for _,card in ipairs(allCard) do
      if card:GetModel() then
        if visible == true then
          (SkeletonAnimationUtil.SetColor)(card:GetModel())
        else
          ;
          (SkeletonAnimationUtil.SetColor)(card:GetModel(), 0.5, 0.5, 0.5)
        end
      end
    end
  end
end

local ChangeCardsLayer = function(layer, alpha, ...)
  -- function num : 0_25 , upvalues : LayerMaskNames, UpdateAllCardHpBarVisible, UpdateAllCardFlip, UpdateAllCardColor, _ENV, ChangeLayer, atkCard, assistAtkCards, defCards
  if layer == LayerMaskNames.SKILL_HIGHLIGHT then
    UpdateAllCardHpBarVisible(false)
    UpdateAllCardFlip(false)
    UpdateAllCardColor(false)
  else
    if layer == LayerMaskNames.MODEL then
      UpdateAllCardHpBarVisible(true)
      UpdateAllCardFlip(true)
      UpdateAllCardColor(true)
    end
  end
  local allCards = (BattleData.GetAllCardList)()
  for i,v in ipairs(allCards) do
    if v:GetModel() then
      ChangeLayer((v:GetModel()).transform, layer)
      if alpha == 1 then
        v:SetVisible(false)
      end
    end
  end
  if atkCard and atkCard:GetModel() then
    atkCard:SetVisible(true)
    atkCard:UpdateHeadInfoVisible(true)
    ;
    (SkeletonAnimationUtil.SetColor)(atkCard:GetModel())
  end
  if assistAtkCards then
    for _,card in ipairs(assistAtkCards) do
      if card:GetModel() then
        card:SetVisible(true)
        card:UpdateHeadInfoVisible(true)
        ;
        (SkeletonAnimationUtil.SetColor)(card:GetModel())
      end
    end
  end
  do
    if defCards then
      for _,defCard in ipairs(defCards) do
        if defCard:GetModel() then
          defCard:SetVisible(true)
          defCard:UpdateHeadInfoVisible(true)
          ;
          (SkeletonAnimationUtil.SetColor)(defCard:GetModel())
        end
      end
    end
  end
end

local curAlpha = 0
DisplaySkillMask = function(delayTime, alpha, ...)
  -- function num : 0_26 , upvalues : SkillParse, _ENV, curAlpha, ChangeCardsLayer, LayerMaskNames, setTimeout
  if not delayTime then
    delayTime = 0
  end
  if delayTime > 100 then
    delayTime = delayTime / 1000
  end
  local callback = function(...)
    -- function num : 0_26_0 , upvalues : SkillParse, _ENV, alpha, curAlpha, ChangeCardsLayer, LayerMaskNames
    if SkillParse.isDisplayMask == true then
      return 
    end
    ;
    (Util.SetCameraActive)(Game.skillCamera, true)
    SkillParse.isDisplayMask = true
    local battleCamera = Game.battleCamera
    if battleCamera then
      local skillMask = (battleCamera.transform):GetChild(0)
      if skillMask then
        if SkillParse.isClearMask == true then
          (LeanTween.cancel)(skillMask.gameObject)
          SkillParse.isClearMask = false
        end
        ;
        (skillMask.gameObject):SetActive(true)
        local targetAlpha = alpha or 0.7
        do
          local time = 0.1
          if targetAlpha == 1 then
            time = 0
            ;
            (BattleBackground.SetBgShow)(false)
          end
          local maskMat = (skillMask.gameObject):GetComponent(typeof((CS.UnityEngine).Renderer))
          ;
          ((LeanTween.value)(skillMask.gameObject, function(value, ...)
      -- function num : 0_26_0_0 , upvalues : maskMat
      ((maskMat.sharedMaterials)[0]):SetFloat("_Alpha", value)
    end
, 0, targetAlpha, time)):setOnComplete(function(...)
      -- function num : 0_26_0_1 , upvalues : SkillParse
      SkillParse.isDisplayMask = false
    end
)
          curAlpha = targetAlpha
        end
      end
    end
    do
      ChangeCardsLayer(LayerMaskNames.SKILL_HIGHLIGHT, alpha)
    end
  end

  if delayTime == 0 then
    callback()
  else
    setTimeout(delayTime or 0, callback)
  end
end

ClearSkillMask = function(delayTime, isCloseBattle, lastTime, timelineEndCall, ...)
  -- function num : 0_27 , upvalues : SkillParse, _ENV, curAlpha, ChangeCardsLayer, LayerMaskNames, setTimeout
  if not delayTime then
    delayTime = 0
  end
  if delayTime > 100 then
    delayTime = delayTime / 1000
  end
  local callback = function(...)
    -- function num : 0_27_0 , upvalues : SkillParse, isCloseBattle, _ENV, lastTime, curAlpha, ChangeCardsLayer, LayerMaskNames, timelineEndCall
    if SkillParse.isClearMask == true and isCloseBattle ~= true then
      return 
    end
    SkillParse.isClearMask = true
    local battleCamera = Game.battleCamera
    do
      if battleCamera then
        local skillMask = (battleCamera.transform):GetChild(0)
        do
          if skillMask then
            (BattleBackground.SetBgShow)(true)
            if SkillParse.isDisplayMask == true then
              (LeanTween.cancel)(skillMask.gameObject)
              SkillParse.isDisplayMask = false
            end
            ;
            (LeanTween.value)(skillMask.gameObject, function(value, ...)
      -- function num : 0_27_0_0 , upvalues : _ENV
      local allCard = (BattleData.GetAllCardList)()
      for _,card in ipairs(allCard) do
        if card:IsDisplayAlive() == true then
          card:SetVisible(true)
          local model = card:GetModel()
          if model ~= nil then
            (SkeletonAnimationUtil.SetColor)(model, value, value, value, true)
          end
        end
      end
    end
, 0.5, 1, lastTime or 0.3)
            local maskMat = (skillMask.gameObject):GetComponent(typeof((CS.UnityEngine).Renderer))
            ;
            ((LeanTween.value)(skillMask.gameObject, function(value, ...)
      -- function num : 0_27_0_1 , upvalues : maskMat
      ((maskMat.sharedMaterials)[0]):SetFloat("_Alpha", value)
    end
, curAlpha, 0, lastTime or 0.3)):setOnComplete(function(...)
      -- function num : 0_27_0_2 , upvalues : _ENV, ChangeCardsLayer, LayerMaskNames, SkillParse, skillMask, timelineEndCall
      (Util.SetCameraActive)(Game.skillCamera, false)
      ChangeCardsLayer(LayerMaskNames.MODEL)
      SkillParse.isClearMask = false
      ;
      (skillMask.gameObject):SetActive(false)
      ;
      (SkillParse.Clear)()
      if timelineEndCall then
        timelineEndCall()
      end
    end
)
          end
        end
      end
      skillMask = SkillScript
      if skillMask then
        skillMask = UIMgr
        skillMask(skillMask, (WinResConfig.BattleUIWindow).name, (WindowMsgEnum.BattleUIWindow).E_MSG_SHOW_UNIQUE_UI, {interval = lastTime})
      end
    end
  end

  if delayTime == 0 then
    callback()
  else
    setTimeout(delayTime or 0, callback)
  end
end

return SkillParse

