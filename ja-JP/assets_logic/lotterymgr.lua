-- params : ...
-- function num : 0 , upvalues : _ENV
LotteryMgr = {
LotteryBackGroundEffectsPool = {}
, 
BackGroundEffectsType = {Card_BackGround = UIEffectEnum.UI_GACHA_CANI, Coupon_BackGround = UIEffectEnum.UI_GACHA_CANI}
}
local self = LotteryMgr
-- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

LotteryMgr.AddBackGroundEffectsToPool = function(tag, effect, ...)
  -- function num : 0_0 , upvalues : _ENV, self
  local isExsit = false
  for index,value in ipairs(self.LotteryBackGroundEffectsPool) do
    if value.tag == tag then
      isExsit = true
      break
    end
  end
  do
    if isExsit == false then
      (table.insert)(self.LotteryBackGroundEffectsPool, {tag = tag, effect = effect})
    end
  end
end

-- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

LotteryMgr.GetBackGroundEffectFromPoolByTag = function(tag, ...)
  -- function num : 0_1 , upvalues : _ENV, self
  local effect = nil
  for index,value in ipairs(self.LotteryBackGroundEffectsPool) do
    if value.tag == tag then
      effect = value.effect
      break
    end
  end
  do
    return effect
  end
end

-- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

LotteryMgr.HideAllBackGroundEffects = function(...)
  -- function num : 0_2 , upvalues : _ENV, self
  for index,value in ipairs(self.LotteryBackGroundEffectsPool) do
    (value.effect):SetActive(false)
  end
end

-- DECOMPILER ERROR at PC24: Confused about usage of register: R1 in 'UnsetPending'

LotteryMgr.RemoveAllBackGroundEffectsFromPool = function(...)
  -- function num : 0_3 , upvalues : _ENV, self
  for index,value in ipairs(self.LotteryBackGroundEffectsPool) do
    if value.effect ~= nil then
      (ResHelper.DestroyGameObject)(value.effect)
    end
  end
  self.LotteryBackGroundEffectsPool = {}
end

-- DECOMPILER ERROR at PC27: Confused about usage of register: R1 in 'UnsetPending'

LotteryMgr.CheckAssetIsEnough = function(str, extraNum, ...)
  -- function num : 0_4 , upvalues : _ENV
  if extraNum == nil then
    extraNum = 0
  end
  local cost = split(str, ":")
  local costItemNum = (ActorData.GetGoodsCount)(cost[2], tonumber(cost[1])) or 0
  local costNeedNum = tonumber(cost[3])
  if costNeedNum > costItemNum + extraNum then
    do return costItemNum == nil, costItemNum end
    do return false, 0 end
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
  end
end

-- DECOMPILER ERROR at PC30: Confused about usage of register: R1 in 'UnsetPending'

LotteryMgr.SetCharacterCompBtnClick = function(comp, cardIds, ...)
  -- function num : 0_5 , upvalues : _ENV
  local ids = split(cardIds, ":")
  for index,value in ipairs(ids) do
    local btn = comp:GetChild("Card_0" .. tostring(index) .. "_Btn")
    do
      local id = tonumber(value)
      ;
      (btn.onClick):Add(function(...)
    -- function num : 0_5_0 , upvalues : _ENV, id
    OpenWindow("CardDetailsWindow", UILayer.HUD, id)
  end
)
    end
  end
end

local isFingerTouchEnable = false
local isClick = false
local boolSlider = 0
local fakeTotalSliderLength = 1600
local curSliderLength = 0
local animPercent = 0
local lastClickPosX = 0
local bookItem, lotteryEffect = nil, nil
local isAutoOpen = false
local callBackFunc, unlockEffect1, unlockEffect2, gachaCamera, gachaEndEffect = nil, nil, nil, nil, nil
local isEndEffectPlay = false
local lotteryData = nil
local effectType = 1
local tipsEffect = nil
-- DECOMPILER ERROR at PC47: Confused about usage of register: R20 in 'UnsetPending'

LotteryMgr.PlayLotteryEffects = function(_callBack, para, ...)
  -- function num : 0_6 , upvalues : isFingerTouchEnable, isClick, boolSlider, curSliderLength, animPercent, isAutoOpen, isEndEffectPlay, callBackFunc, lotteryData, _ENV, lotteryEffect, tipsEffect, gachaCamera, bookItem, effectType
  isFingerTouchEnable = false
  isClick = false
  boolSlider = 0
  curSliderLength = 0
  animPercent = 0
  isAutoOpen = false
  isEndEffectPlay = false
  callBackFunc = _callBack
  lotteryData = para
  local effect = ((CS.PostManager).Instance):ReturnLotteryPrefab()
  effect:SetActive(true)
  lotteryEffect = effect
  tipsEffect = ((effect.transform):Find("jiantou")).gameObject
  ;
  (LuaSound.PlaySound)(LuaSound.LOTTERY_ONE, SoundBank.OTHER)
  gachaCamera = ((effect.transform):Find("GachaCamera")).gameObject
  ;
  (Util.PlayAnimation)(gachaCamera, "FX_ui_Gacha_carmera_ani")
  local cameraTime = (Util.GetClipLength)(gachaCamera, "FX_ui_Gacha_carmera_ani")
  bookItem = ((effect.transform):Find("gacha_book")).gameObject
  local bookIdleTime = (Util.GetClipLength)(bookItem, "idle2")
  for index,value in ipairs((para.data).goods) do
    if value.type == PropType.CARD then
      local cardData = ((TableData.gTable).BaseCardData)[value.id]
      local intelligence = cardData.intelligence
      if effectType < intelligence then
        effectType = intelligence
      end
    end
  end
  ;
  (LotteryMgr.ShowWhichColor)()
  ;
  (Util.PlayAnimation)(bookItem, "idle2")
  ;
  (SimpleTimer.setTimeout)(cameraTime, function(...)
    -- function num : 0_6_0 , upvalues : _ENV, tipsEffect
    (UpdateMgr.AddUpdateHandler)(LotteryMgr.Update)
    tipsEffect:SetActive(true)
  end
)
  ;
  (SimpleTimer.setTimeout)(cameraTime + 0.3, function(...)
    -- function num : 0_6_1 , upvalues : isFingerTouchEnable
    isFingerTouchEnable = true
  end
)
end

local lerpLength = 200
-- DECOMPILER ERROR at PC51: Confused about usage of register: R21 in 'UnsetPending'

LotteryMgr.Update = function(...)
  -- function num : 0_7 , upvalues : isFingerTouchEnable, _ENV, lastClickPosX, isClick, tipsEffect, unlockEffect1, unlockEffect2, lerpLength, isAutoOpen, curSliderLength, animPercent, fakeTotalSliderLength, bookItem, gachaCamera, isEndEffectPlay, gachaEndEffect, callBackFunc, lotteryEffect
  if isFingerTouchEnable then
    if (Input.GetMouseButtonDown)(0) then
      lastClickPosX = (Input.mousePosition).x
      isClick = true
      tipsEffect:SetActive(false)
      unlockEffect1:SetActive(true)
      unlockEffect2:SetActive(true)
    end
    if (Input.GetMouseButtonUp)(0) then
      isClick = false
      tipsEffect:SetActive(true)
      unlockEffect2:SetActive(false)
    end
    do
      if (Input.GetMouseButton)(0) then
        local detalMove = -(Input.mousePosition).x + lastClickPosX
        if lerpLength < detalMove then
          detalMove = lerpLength
          isFingerTouchEnable = false
          tipsEffect:SetActive(false)
          isAutoOpen = true
          ;
          (LuaSound.PlaySound)(LuaSound.LOTTERY_FLIP_BOOK, SoundBank.OTHER)
          return 
        end
        curSliderLength = curSliderLength + detalMove
        animPercent = curSliderLength / fakeTotalSliderLength
        if fakeTotalSliderLength * 0.25 < curSliderLength then
          curSliderLength = fakeTotalSliderLength
          isFingerTouchEnable = false
          isAutoOpen = true
          ;
          (LuaSound.PlaySound)(LuaSound.LOTTERY_FLIP_BOOK, SoundBank.OTHER)
        end
        if curSliderLength < 0 then
          curSliderLength = 0
        end
        if animPercent > 1 then
          animPercent = 1
        end
        if animPercent < 0 then
          animPercent = 0
        end
        lastClickPosX = (Input.mousePosition).x
        ;
        (Util.PlayAnimationWithNormalLizedTime)(bookItem, "open", animPercent)
        ;
        (LotteryMgr.SetAllParticleAlpha)(unlockEffect1, animPercent)
        ;
        (LotteryMgr.SetAllParticleAlpha)(unlockEffect2, animPercent)
        ;
        (Util.PlayAnimationWithNormalLizedTime)(gachaCamera, "FX_ui_Gacha_carmera_press_ani", animPercent)
      end
      if isClick == false and animPercent > 0 then
        curSliderLength = curSliderLength - 3 / animPercent
        if curSliderLength < 0 then
          curSliderLength = 0
        end
        animPercent = curSliderLength / fakeTotalSliderLength
        ;
        (Util.PlayAnimationWithNormalLizedTime)(bookItem, "open", animPercent)
        ;
        (LotteryMgr.SetAllParticleAlpha)(unlockEffect1, animPercent)
        ;
        (LotteryMgr.SetAllParticleAlpha)(unlockEffect2, animPercent)
        ;
        (Util.PlayAnimationWithNormalLizedTime)(gachaCamera, "FX_ui_Gacha_carmera_press_ani", animPercent)
      end
      if isAutoOpen then
        if unlockEffect1.activeSelf == false then
          unlockEffect1:SetActive(true)
          unlockEffect2:SetActive(true)
        end
        animPercent = animPercent + 0.01
        if isEndEffectPlay == false and animPercent > 0.7 then
          isEndEffectPlay = true
          gachaEndEffect:SetActive(true)
          ;
          (SimpleTimer.setTimeout)(3.7, function(...)
    -- function num : 0_7_0 , upvalues : callBackFunc
    callBackFunc()
  end
)
          ;
          (SimpleTimer.setTimeout)(3.8, function(...)
    -- function num : 0_7_1 , upvalues : gachaEndEffect, _ENV, lotteryEffect
    gachaEndEffect:SetActive(false)
    ;
    (LotteryMgr.ResetCardQualityEffects)()
    lotteryEffect:SetActive(false)
  end
)
          ;
          (SimpleTimer.setTimeout)(0.1, function(...)
    -- function num : 0_7_2 , upvalues : _ENV, animPercent, unlockEffect1, unlockEffect2
    (((LeanTween.value)(animPercent, 0, 0.8)):setOnUpdate(function(value, ...)
      -- function num : 0_7_2_0 , upvalues : _ENV, unlockEffect1, unlockEffect2
      (LotteryMgr.SetAllParticleAlpha)(unlockEffect1, value)
      ;
      (LotteryMgr.SetAllParticleAlpha)(unlockEffect2, value)
    end
)):setOnComplete(function(...)
      -- function num : 0_7_2_1 , upvalues : unlockEffect1, unlockEffect2
      unlockEffect1:SetActive(false)
      unlockEffect2:SetActive(false)
    end
)
  end
)
        end
        if animPercent >= 1 then
          (Util.SetAnimationSpeed)(bookItem, 1)
          ;
          (Util.SetAnimationSpeed)(gachaCamera, 1)
          ;
          (UpdateMgr.RemoveUpdateHandler)(LotteryMgr.Update)
          isAutoOpen = false
        else
          ;
          (Util.PlayAnimationWithNormalLizedTime)(bookItem, "open", animPercent)
          ;
          (LotteryMgr.SetAllParticleAlpha)(unlockEffect1, animPercent)
          ;
          (LotteryMgr.SetAllParticleAlpha)(unlockEffect2, animPercent)
          ;
          (Util.PlayAnimationWithNormalLizedTime)(gachaCamera, "FX_ui_Gacha_carmera_press_ani", animPercent)
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC54: Confused about usage of register: R21 in 'UnsetPending'

LotteryMgr.ShowWhichColor = function(...)
  -- function num : 0_8 , upvalues : effectType, gachaEndEffect, lotteryEffect, unlockEffect1, unlockEffect2, _ENV
  if effectType == 1 then
    gachaEndEffect = ((lotteryEffect.transform):Find("FX_gacha_end_eff_blue")).gameObject
    unlockEffect1 = ((lotteryEffect.transform):Find("FX_ui_openbook_blue")).gameObject
    unlockEffect2 = ((lotteryEffect.transform):Find("gacha_book/Bone001/Bone021/blue_light")).gameObject
  else
    if effectType == 2 then
      gachaEndEffect = ((lotteryEffect.transform):Find("FX_gacha_end_eff_purple")).gameObject
      unlockEffect1 = ((lotteryEffect.transform):Find("FX_ui_openbook_purple")).gameObject
      unlockEffect2 = ((lotteryEffect.transform):Find("gacha_book/Bone001/Bone021/purple_light")).gameObject
    else
      if effectType == 3 then
        gachaEndEffect = ((lotteryEffect.transform):Find("FX_gacha_end_eff_gold")).gameObject
        unlockEffect1 = ((lotteryEffect.transform):Find("FX_ui_openbook_glod")).gameObject
        unlockEffect2 = ((lotteryEffect.transform):Find("gacha_book/Bone001/Bone021/gold_light")).gameObject
      end
    end
  end
  effectType = 1
  unlockEffect1:SetActive(false)
  unlockEffect2:SetActive(false)
  ;
  (LotteryMgr.ResetCardQualityEffects)()
end

-- DECOMPILER ERROR at PC57: Confused about usage of register: R21 in 'UnsetPending'

LotteryMgr.SetAllParticleAlpha = function(item, alpha, ...)
  -- function num : 0_9 , upvalues : _ENV
  if alpha >= 0.05 then
    alpha = 2.5 * alpha - 0.125
  else
    alpha = 0
  end
  local renderS = item:GetComponentsInChildren(typeof((CS.UnityEngine).Renderer))
  local count = renderS.Length
  for i = 0, count - 1 do
    local materials = (renderS[i]).materials
    local countm = materials.Length - 1
    for j = 0, countm do
      local mat = materials[j]
      local _Color = ((renderS[i]).material):GetColor("_Color")
      mat:SetColor("_Color", ((CS.UnityEngine).Color)(_Color.r, _Color.g, _Color.b, alpha))
    end
  end
end

-- DECOMPILER ERROR at PC60: Confused about usage of register: R21 in 'UnsetPending'

LotteryMgr.ResetCardQualityEffects = function(...)
  -- function num : 0_10 , upvalues : lotteryEffect, _ENV
  local eb1 = ((lotteryEffect.transform):Find("FX_ui_openbook_blue")).gameObject
  local eb2 = ((lotteryEffect.transform):Find("gacha_book/Bone001/Bone021/blue_light")).gameObject
  local ep1 = ((lotteryEffect.transform):Find("FX_ui_openbook_purple")).gameObject
  local ep2 = ((lotteryEffect.transform):Find("gacha_book/Bone001/Bone021/purple_light")).gameObject
  local eg1 = ((lotteryEffect.transform):Find("FX_ui_openbook_glod")).gameObject
  local eg2 = ((lotteryEffect.transform):Find("gacha_book/Bone001/Bone021/gold_light")).gameObject
  ;
  (LotteryMgr.SetAllParticleAlpha)(eb1, 0)
  ;
  (LotteryMgr.SetAllParticleAlpha)(eb2, 0)
  ;
  (LotteryMgr.SetAllParticleAlpha)(ep1, 0)
  ;
  (LotteryMgr.SetAllParticleAlpha)(ep2, 0)
  ;
  (LotteryMgr.SetAllParticleAlpha)(eg1, 0)
  ;
  (LotteryMgr.SetAllParticleAlpha)(eg2, 0)
end


