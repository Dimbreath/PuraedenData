-- params : ...
-- function num : 0 , upvalues : _ENV
require("CardPop_PiceGetShowByName")
local PiceGetShowWindow = {}
local uis, contentPane, controller = nil, nil, nil
local argTable = {}
local cardID = nil
local moveIndex = 1
local isMoving = false
local oriPosX, oriPosY, oriScale, fashionData = nil, nil, nil, nil
local isSkip = false
local picesNum = 0
local clickEnable = false
local showModel = nil
local cards = {}
local cardIndex = 1
local callBack = nil
local isCardTable = false
local video = (CS.VideoManager).Instance
local FxManager = (require("FxManager"))
local UI_LOTTERY_REWARD_TEXT, UI_LOTTERY_REWARD_END = nil, nil
local lastClickIndex = 1
local fxMainEffect = nil
PiceGetShowWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, cardID, picesNum, cards, callBack, cardIndex, lastClickIndex, fxMainEffect, clickEnable, isCardTable, PiceGetShowWindow
  bridgeObj:SetView((WinResConfig.PiceGetShowWindow).package, (WinResConfig.PiceGetShowWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  contentPane:Center()
  uis = GetCardPop_PiceGetShowUis(contentPane)
  if argTable[1] then
    cardID = argTable[1]
  else
    cardID = (CardData.ReturnCardID)()
  end
  if argTable[2] then
    picesNum = argTable[2]
  end
  if argTable[3] then
    cards = argTable[3]
  end
  if argTable[4] then
    callBack = argTable[4]
  end
  cardIndex = 1
  lastClickIndex = 1
  fxMainEffect = nil
  -- DECOMPILER ERROR at PC52: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.CardGetShowEffectGrp).SkipBtn).visible = false
  ;
  (((uis.CardGetShowEffectGrp).EffcetLoader).onClick):Clear()
  ;
  (((uis.CardGetShowEffectGrp).EffcetLoader).onClick):Add(function(...)
    -- function num : 0_0_0 , upvalues : clickEnable, isCardTable, cardIndex, cards, cardID, PiceGetShowWindow, callBack, _ENV
    if clickEnable then
      if isCardTable then
        cardIndex = cardIndex + 1
        if cardIndex <= #cards then
          cardID = (cards[cardIndex]).id
          ;
          (PiceGetShowWindow.CardLines)()
        else
          local callback = callBack
          UIMgr:CloseWindow((WinResConfig.PiceGetShowWindow).name)
          callback()
        end
      else
        do
          UIMgr:CloseWindow((WinResConfig.PiceGetShowWindow).name)
        end
      end
    end
  end
)
  local uiMap = (uis.StartWord).root
  local holder = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_LOTTERYDIALOG_SHOW, false, false)
  holder:SetXY(uiMap.width / 2, uiMap.height / 2)
  uiMap:AddChild(holder)
  local uiMap2 = (uis.CardGetShowEffectGrp).root
  local holder2 = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_LOTTERY_SPINE_PARTICLE, false, false)
  holder2:SetXY(uiMap2.width / 2, uiMap2.height / 2)
  uiMap2:AddChild(holder2)
  if #cards >= 1 then
    isCardTable = true
    cardID = (cards[cardIndex]).id
    if (cards[cardIndex]).isHave then
      picesNum = tonumber((split((((TableData.gTable).BaseCardData)[cardID]).debris_goods, ":"))[3])
    else
      picesNum = 0
    end
  else
    isCardTable = false
  end
  ;
  (PiceGetShowWindow.CardLines)()
  ;
  (Util.RegistCaptureScreenShot)((uis.Information).ShotBtn, (uis.Information).LogoImage, (uis.Information).CodeImage, 1334, 750)
end

PiceGetShowWindow.CardLines = function(...)
  -- function num : 0_1 , upvalues : clickEnable, uis, _ENV, cardID, UI_LOTTERY_REWARD_TEXT, video, UI_LOTTERY_REWARD_END, PiceGetShowWindow
  clickEnable = false
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.StartWord).root).visible = false
  local cardExcelData = ((TableData.gTable).BaseCardData)[cardID]
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.StartWord).c1Ctr).selectedIndex = cardExcelData.intelligence - 1
  if UI_LOTTERY_REWARD_TEXT == nil then
    local holder, effect_Txt = (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_LOTTERY_REWARD_TEXT, false, (uis.StartWord).root, (Vector2(((uis.StartWord).root).width * 0.5, ((uis.StartWord).root).height * 0.5)), nil, 1, false)
    UI_LOTTERY_REWARD_TEXT = effect_Txt
  else
    do
      UI_LOTTERY_REWARD_TEXT:SetActive(true)
      -- DECOMPILER ERROR at PC50: Confused about usage of register: R1 in 'UnsetPending'

      if cardExcelData.intelligence > 1 then
        ((uis.StartWord).root).visible = true
        -- DECOMPILER ERROR at PC57: Confused about usage of register: R1 in 'UnsetPending'

        ;
        ((uis.StartWord).LinesLoader).url = (Util.GetItemUrl)(cardExcelData.lottery_dialogue)
        if cardExcelData.lottery_show then
          video:PreLoadVideo(cardExcelData.lottery_show)
        end
        local trans = PlayUITrans((uis.StartWord).root, "in", function(...)
    -- function num : 0_1_0 , upvalues : UI_LOTTERY_REWARD_END, _ENV, uis, PiceGetShowWindow
    if UI_LOTTERY_REWARD_END == nil then
      local holder, effect_Txt = (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_LOTTERY_REWARD_END, false, (uis.StartWord).root, (Vector2(((uis.StartWord).root).width * 0.5, ((uis.StartWord).root).height * 0.5)), nil, 1, false)
      UI_LOTTERY_REWARD_END = effect_Txt
    else
      do
        UI_LOTTERY_REWARD_END:SetActive(true)
        ;
        (SimpleTimer.setTimeout)(0.3, function(...)
      -- function num : 0_1_0_0 , upvalues : PiceGetShowWindow
      (PiceGetShowWindow.CheckIsHaveVideo)()
    end
)
      end
    end
  end
)
      else
        do
          ;
          (PiceGetShowWindow.CheckIsHaveVideo)()
        end
      end
    end
  end
end

PiceGetShowWindow.RefreshDetailInfo = function(excelData, ...)
  -- function num : 0_2 , upvalues : _ENV, uis, PiceGetShowWindow, FxManager, lastClickIndex, UI_LOTTERY_REWARD_TEXT, UI_LOTTERY_REWARD_END, clickEnable, picesNum
  (LuaSound.PlaySound)(LuaSound.CARD_GET_SHOW, SoundBank.OTHER)
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.CVNameLoader).url = (Util.GetItemUrl)(excelData.cv_pic)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.NameLoader).url = (Util.GetItemUrl)(excelData.name_pic)
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.c2Ctr).selectedIndex = excelData.intelligence
  ;
  (PiceGetShowWindow.SetIntelligenceEffect)(excelData.intelligence)
  local fashionIds = split(excelData.fashion_ids, ":")
  local fashionId = fashionIds[1]
  ;
  (AudioManager.DisposeCurAudioAndBubble)()
  ;
  (AudioManager.PlayBubbleAndVoice)(false, true, tonumber(fashionId), CVAudioType.UnLockBubble, uis.CardLoader, uis)
  ;
  (Util.RecycleUIModel)(uis.CardLoader)
  local obj = (Util.CreateShowModel)(tonumber(fashionId), uis.CardLoader, true, false, true)
  FxManager:SetShutterEffect(obj, (uis.CardLoader).image)
  for i = 1, 3 do
    do
      local btn = (uis.root):GetChild("Cothes_" .. tostring(i) .. "_Btn")
      ;
      (btn.onClick):ClearCallFunc()
      ;
      (btn.onClick):Add(function(...)
    -- function num : 0_2_0 , upvalues : lastClickIndex, i, PiceGetShowWindow, fashionIds, excelData
    if lastClickIndex ~= i then
      (PiceGetShowWindow.ChangeFashion)(i, fashionIds, excelData)
      lastClickIndex = i
    end
  end
)
    end
  end
  local trans = (uis.root):GetTransition("show")
  trans.invalidateBatchingEveryFrame = true
  -- DECOMPILER ERROR at PC94: Confused about usage of register: R5 in 'UnsetPending'

  ;
  ((uis.StartWord).root).visible = false
  if UI_LOTTERY_REWARD_TEXT then
    UI_LOTTERY_REWARD_TEXT:SetActive(false)
  end
  if UI_LOTTERY_REWARD_END then
    UI_LOTTERY_REWARD_END:SetActive(false)
  end
  PlayUITrans(uis.root, "show", function(...)
    -- function num : 0_2_1 , upvalues : clickEnable
    clickEnable = true
  end
)
  -- DECOMPILER ERROR at PC118: Confused about usage of register: R5 in 'UnsetPending'

  if picesNum > 0 then
    (uis.c1Ctr).selectedIndex = 1
    local piceIndex = 0
    local piceNum = tonumber((split(excelData.debris_goods, ":"))[3])
    if piceNum == 5 then
      piceIndex = 0
    else
      if piceNum == 15 then
        piceIndex = 1
      else
        if piceNum == 40 then
          piceIndex = 2
        end
      end
    end
    -- DECOMPILER ERROR at PC140: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((uis.Repeat).c1Ctr).selectedIndex = piceIndex
    -- DECOMPILER ERROR at PC144: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (((uis.RepeatTips).Repeat).c1Ctr).selectedIndex = piceIndex
    local imgUrl = nil
    local piecesId = tonumber((split(excelData.recruit_cost, ":"))[2])
    imgUrl = (Util.GetItemUrl)((((TableData.gTable).BasePropData)[piecesId]).icon)
    -- DECOMPILER ERROR at PC165: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (((uis.RepeatTips).Repeat).IconLoader).url = imgUrl
    -- DECOMPILER ERROR at PC168: Confused about usage of register: R9 in 'UnsetPending'

    ;
    ((uis.Repeat).IconLoader).url = imgUrl
  else
    do
      -- DECOMPILER ERROR at PC171: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (uis.c1Ctr).selectedIndex = 0
      local fashionData = ((TableData.gTable).BaseFashionData)[tonumber(fashionId)]
      ;
      (PiceGetShowWindow.GetUnlockText)(fashionData)
    end
  end
end

PiceGetShowWindow.GetUnlockText = function(fashionConfig, ...)
  -- function num : 0_3 , upvalues : _ENV, uis
  if fashionConfig and fashionConfig.loterry_bubble_ids then
    local unlock_bubble_ids = fashionConfig.loterry_bubble_ids
    if unlock_bubble_ids then
      local bubbleConfig = ((TableData.gTable).BaseFashionBubbleData)[tonumber(unlock_bubble_ids)]
      -- DECOMPILER ERROR at PC17: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (uis.WordTxt).text = bubbleConfig.bubble_text
    end
  end
end

PiceGetShowWindow.CheckIsHaveVideo = function(...)
  -- function num : 0_4 , upvalues : _ENV, cardID, uis, video, PiceGetShowWindow
  local excelData = ((TableData.gTable).BaseCardData)[cardID]
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  if excelData.lottery_show then
    (uis.VideoLoader).visible = true
    video:PlayVideo(uis.VideoLoader, excelData.lottery_show, function(...)
    -- function num : 0_4_0 , upvalues : PiceGetShowWindow, excelData, uis
    (PiceGetShowWindow.RefreshDetailInfo)(excelData)
    -- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (uis.VideoLoader).visible = false
  end
)
  else
    ;
    (PiceGetShowWindow.RefreshDetailInfo)(excelData)
  end
end

PiceGetShowWindow.ChangeFashion = function(index, fashionIds, excelData, ...)
  -- function num : 0_5 , upvalues : _ENV, uis, fxMainEffect, contentPane, PiceGetShowWindow, FxManager
  local fashionId = tonumber(fashionIds[index])
  local fashionData = ((TableData.gTable).BaseFashionData)[fashionId]
  ;
  (Util.RecycleUIModel)(uis.CardLoader)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R5 in 'UnsetPending'

  if fashionData.show_cg ~= nil then
    (uis.c2Ctr).selectedIndex = 0
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((uis.CardGetEffect).root).visible = false
    if fxMainEffect == nil then
      local effect = nil
      fxMainEffect = (LuaEffect.AddNotDeletedUIEffect)(fashionData.show_cg, Vector3.zero, 1)
      fxMainEffect:SetXY(contentPane.width / 2, contentPane.height / 2)
      contentPane:AddChildAt(fxMainEffect, 0)
    else
      do
        fxMainEffect.visible = true
        -- DECOMPILER ERROR at PC47: Overwrote pending register: R5 in 'AssignReg'

        if effect ~= nil then
          fxMainEffect.visible = false
        end
        -- DECOMPILER ERROR at PC58: Confused about usage of register: R5 in 'UnsetPending'

        if ((uis.CardGetEffect).root).visible == false then
          ((uis.CardGetEffect).root).visible = true
          ;
          (PiceGetShowWindow.SetIntelligenceEffect)(excelData.intelligence)
        end
        -- DECOMPILER ERROR at PC64: Confused about usage of register: R5 in 'UnsetPending'

        ;
        (uis.c2Ctr).selectedIndex = excelData.intelligence
        do
          local obj = (Util.CreateShowModel)(fashionId, uis.CardLoader, true, false, true)
          if fashionData.type ~= 3 then
            FxManager:SetShutterEffect(obj, (uis.CardLoader).image)
          end
          -- DECOMPILER ERROR at PC92: Confused about usage of register: R5 in 'UnsetPending'

          if fashionData.unlock_remark then
            ((uis.PicExplain).WordTxt).text = (PUtil.get)(186, fashionData.unlock_remark)
          end
          ;
          (PiceGetShowWindow.GetUnlockText)(fashionData)
        end
      end
    end
  end
end

PiceGetShowWindow.SetIntelligenceEffect = function(intelligence, ...)
  -- function num : 0_6 , upvalues : _ENV, uis
  local effect = nil
  if intelligence == 1 then
    (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_LOTTERY_CARDGET_BLUE, false, (uis.CardGetEffect).root, (Vector2(((uis.CardGetEffect).root).width * 0.5, ((uis.CardGetEffect).root).height * 0.5)), nil, 1, true)
  else
    if intelligence == 2 then
      (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_LOTTERY_CARDGET_VIOLET, false, (uis.CardGetEffect).root, (Vector2(((uis.CardGetEffect).root).width * 0.5, ((uis.CardGetEffect).root).height * 0.5)), nil, 1, true)
    else
      if intelligence == 3 then
        (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_LOTTERY_CARDGET_GOLD, false, (uis.CardGetEffect).root, (Vector2(((uis.CardGetEffect).root).width * 0.5, ((uis.CardGetEffect).root).height * 0.5)), nil, 1, true)
      end
    end
  end
end

PiceGetShowWindow.OnClose = function(...)
  -- function num : 0_7 , upvalues : _ENV, uis, contentPane, controller, argTable, moveIndex, isMoving, fashionData, isSkip, picesNum, clickEnable, cards, callBack, fxMainEffect, UI_LOTTERY_REWARD_TEXT, UI_LOTTERY_REWARD_END, showModel
  (AudioManager.DisposeCurAudioAndBubble)()
  uis = nil
  contentPane = nil
  controller = nil
  argTable = nil
  moveIndex = 1
  isMoving = false
  fashionData = nil
  isSkip = false
  picesNum = 0
  clickEnable = false
  cards = {}
  callBack = nil
  if fxMainEffect then
    (LuaEffect.DestroyEffect)(fxMainEffect)
    fxMainEffect = nil
  end
  if UI_LOTTERY_REWARD_TEXT ~= nil then
    (ResHelper.DestroyGameObject)(UI_LOTTERY_REWARD_TEXT)
    UI_LOTTERY_REWARD_TEXT = nil
  end
  if UI_LOTTERY_REWARD_END ~= nil then
    (ResHelper.DestroyGameObject)(UI_LOTTERY_REWARD_END)
    UI_LOTTERY_REWARD_END = nil
  end
  ;
  (HandBookData.CheckFetterData)()
  showModel = nil
end

PiceGetShowWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_8
end

return PiceGetShowWindow

