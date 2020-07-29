-- params : ...
-- function num : 0 , upvalues : _ENV
require("CardPop_CardGetShowByName")
local CardGetShowWindow = {}
local uis, contentPane, controller = nil, nil, nil
local argTable = {}
local cardID = nil
local isLottery = false
local moveConfig = nil
local isAutoClose = false
local isHave = false
local oriPosX, oriPosY, oriScale, fashionData = nil, nil, nil, nil
local isSkip = false
local isTheLast = false
local isTheFirst = false
local picesNum = 0
local showModel = nil
local FxManager = require("FxManager")
local lastClickIndex = 1
local fxMainEffect = nil
CardGetShowWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, lastClickIndex, fxMainEffect, cardID, isLottery, moveConfig, isAutoClose, isHave, picesNum, isTheLast, isTheFirst, CardGetShowWindow
  bridgeObj:SetView((WinResConfig.CardGetShowWindow).package, (WinResConfig.CardGetShowWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  contentPane:Center()
  uis = GetCardPop_CardGetShowUis(contentPane)
  ;
  (GuideData.RegisterGuideAndControl)(ControlID.GetCard_SureBtn, (uis.CardGetShowEffectGrp).EffcetLoader, (WinResConfig.CardGetShowWindow).name)
  lastClickIndex = 1
  fxMainEffect = nil
  if argTable[1] then
    cardID = argTable[1]
  else
    cardID = (CardData.ReturnCardID)()
  end
  if argTable[2] then
    isLottery = argTable[2]
  end
  if argTable[3] then
    moveConfig = argTable[3]
  end
  if argTable[4] then
    isAutoClose = argTable[4]
  end
  if argTable[5] then
    isHave = argTable[5]
  end
  if argTable[6] then
    picesNum = argTable[6]
  end
  if argTable[7] then
    isTheLast = argTable[7]
  else
    isTheLast = false
  end
  if argTable[8] then
    isTheFirst = argTable[8]
  else
    isTheFirst = false
  end
  local excelData = ((TableData.gTable).BaseCardData)[cardID]
  isTheFirst = not isTheFirst or excelData.intelligence < 2
  -- DECOMPILER ERROR at PC101: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((uis.WhiteEffect).root).visible = isTheFirst
  if isTheFirst then
    (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_LOTTERY_FIRST_EFFECT, false, (uis.WhiteEffect).root, (Vector2(((uis.WhiteEffect).root).width * 0.5, ((uis.WhiteEffect).root).height * 0.5)), nil, 1, true)
    ;
    (SimpleTimer.setTimeout)(1, function(...)
    -- function num : 0_0_0 , upvalues : uis
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

    ((uis.WhiteEffect).root).visible = false
  end
)
    ;
    (SimpleTimer.setTimeout)(0.1, function(...)
    -- function num : 0_0_1 , upvalues : CardGetShowWindow
    (CardGetShowWindow.ClassicInit)()
  end
)
  else
    (CardGetShowWindow.ClassicInit)()
  end
  ;
  (Util.RegistCaptureScreenShot)((uis.Information).ShotBtn, (uis.Information).LogoImage, (uis.Information).CodeImage, 1334, 750)
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

CardGetShowWindow.ClassicInit = function(...)
  -- function num : 0_1 , upvalues : uis, isAutoClose, isHave, isTheLast, _ENV, isLottery, CardGetShowWindow
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.CardGetShowEffectGrp).SkipBtn).visible = (isAutoClose or isHave) and not isTheLast
  ;
  (((uis.CardGetShowEffectGrp).EffcetLoader).onClick):Clear()
  ;
  (((uis.CardGetShowEffectGrp).SkipBtn).onClick):Add(function(...)
    -- function num : 0_1_0 , upvalues : isAutoClose, uis, isHave, _ENV
    isAutoClose = true
    -- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((uis.CardGetShowEffectGrp).SkipBtn).visible = false
    if isHave then
      (SimpleTimer.setTimeout)(1.5, function(...)
      -- function num : 0_1_0_0 , upvalues : _ENV
      UIMgr:CloseWindow((WinResConfig.CardGetShowWindow).name, true, true)
      UIMgr:SendWindowMessage((WinResConfig.LotteryWindow).name, (WindowMsgEnum.Lottery).E_MSG_ONCLOSE_NEWGET, {})
    end
)
    else
      UIMgr:CloseWindow((WinResConfig.CardGetShowWindow).name, true, true)
      UIMgr:SendWindowMessage((WinResConfig.LotteryWindow).name, (WindowMsgEnum.Lottery).E_MSG_ONCLOSE_NEWGET, {})
    end
    UIMgr:SendWindowMessage((WinResConfig.LotteryWindow).name, (WindowMsgEnum.Lottery).E_MSG_ONCLICKCARDGET_SKIPBTN, {})
  end
)
  ;
  (((uis.CardGetShowEffectGrp).EffcetLoader).onClick):Clear()
  if isLottery then
    (((uis.CardGetShowEffectGrp).EffcetLoader).onClick):Add(function(...)
    -- function num : 0_1_1 , upvalues : isAutoClose, isHave, _ENV
    if isAutoClose == false then
      if isHave then
        UIMgr:CloseWindow((WinResConfig.CardGetShowWindow).name, true, true)
        UIMgr:SendWindowMessage((WinResConfig.LotteryWindow).name, (WindowMsgEnum.Lottery).E_MSG_ONCLOSE_NEWGET, {})
      else
        local isFreshLine = (LotteryData.GetIsFreshLine)()
        if isFreshLine then
          (LotteryData.SetIsFreshLine)(false)
          UIMgr:CloseToWindow((WinResConfig.HomeWindow).name)
        else
          UIMgr:CloseWindow((WinResConfig.CardGetShowWindow).name, true, true)
          UIMgr:SendWindowMessage((WinResConfig.LotteryWindow).name, (WindowMsgEnum.Lottery).E_MSG_ONCLOSE_NEWGET, {})
        end
      end
    else
      do
        if not isHave then
          UIMgr:CloseWindow((WinResConfig.CardGetShowWindow).name, true, true)
          UIMgr:SendWindowMessage((WinResConfig.LotteryWindow).name, (WindowMsgEnum.Lottery).E_MSG_ONCLOSE_NEWGET, {})
        end
      end
    end
  end
)
  else
    (((uis.CardGetShowEffectGrp).EffcetLoader).onClick):Add(function(...)
    -- function num : 0_1_2 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.CardGetShowWindow).name)
  end
)
  end
  ;
  (CardGetShowWindow.RefreshDetailInfo)()
  ;
  (LuaSound.PlaySound)(LuaSound.CARD_GET_SHOW, SoundBank.OTHER)
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

CardGetShowWindow.RefreshDetailInfo = function(...)
  -- function num : 0_2 , upvalues : _ENV, cardID, uis, CardGetShowWindow, FxManager, lastClickIndex, isHave, isAutoClose, moveConfig
  local excelData = ((TableData.gTable).BaseCardData)[cardID]
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.CVNameLoader).url = (Util.GetItemUrl)(excelData.cv_pic)
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.NameLoader).url = (Util.GetItemUrl)(excelData.name_pic)
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.c2Ctr).selectedIndex = excelData.intelligence
  ;
  (CardGetShowWindow.SetIntelligenceEffect)(excelData.intelligence)
  local fashionIds = split(excelData.fashion_ids, ":")
  local fashionId = tonumber(fashionIds[1])
  ;
  (AudioManager.DisposeCurAudioAndBubble)()
  ;
  (AudioManager.PlayBubbleAndVoice)(false, true, fashionId, CVAudioType.UnLockBubble, uis.CardLoader, uis)
  ;
  (Util.RecycleUIModel)(uis.CardLoader)
  local obj = (Util.CreateShowModel)(fashionId, uis.CardLoader, true, false, true)
  FxManager:SetShutterEffect(obj, (uis.CardLoader).image, Vector3(0, 0, -28))
  for i = 1, 3 do
    do
      local btn = (uis.root):GetChild("Cothes_" .. tostring(i) .. "_Btn")
      ;
      (btn.onClick):ClearCallFunc()
      ;
      (btn.onClick):Add(function(...)
    -- function num : 0_2_0 , upvalues : lastClickIndex, i, CardGetShowWindow, fashionIds, excelData
    if lastClickIndex ~= i then
      (CardGetShowWindow.ChangeFashion)(i, fashionIds, excelData)
      lastClickIndex = i
    end
  end
)
    end
  end
  -- DECOMPILER ERROR at PC92: Confused about usage of register: R4 in 'UnsetPending'

  if isHave then
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
    -- DECOMPILER ERROR at PC114: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((uis.Repeat).c1Ctr).selectedIndex = piceIndex
    -- DECOMPILER ERROR at PC118: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (((uis.RepeatTips).Repeat).c1Ctr).selectedIndex = piceIndex
    local imgUrl = nil
    local piecesId = tonumber((split(excelData.recruit_cost, ":"))[2])
    imgUrl = (Util.GetItemUrl)((((TableData.gTable).BasePropData)[piecesId]).icon)
    -- DECOMPILER ERROR at PC139: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (((uis.RepeatTips).Repeat).IconLoader).url = imgUrl
    -- DECOMPILER ERROR at PC142: Confused about usage of register: R8 in 'UnsetPending'

    ;
    ((uis.Repeat).IconLoader).url = imgUrl
  else
    do
      -- DECOMPILER ERROR at PC145: Confused about usage of register: R4 in 'UnsetPending'

      ;
      (uis.c1Ctr).selectedIndex = 0
      PlayUITrans(uis.root, "in")
      local uiMap = (uis.CardGetShowEffectGrp).root
      local holder = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_LOTTERY_SPINE_PARTICLE, false, false)
      holder:SetXY(uiMap.width / 2, uiMap.height / 2)
      uiMap:AddChild(holder)
      if isAutoClose and isHave then
        (SimpleTimer.setTimeout)(1.5, function(...)
    -- function num : 0_2_1 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.CardGetShowWindow).name, true, true)
    UIMgr:SendWindowMessage((WinResConfig.LotteryWindow).name, (WindowMsgEnum.Lottery).E_MSG_ONCLOSE_NEWGET, {})
  end
)
      end
      if moveConfig == nil and not isHave then
        (Util.ShowGuideTips)(GuideTipsCheckPoint.AcquireCharacter, (((TableData.gTable).BaseCardData)[cardID]).name)
      end
      local fashionData = ((TableData.gTable).BaseFashionData)[fashionId]
      ;
      (CardGetShowWindow.GetUnlockText)(fashionData)
    end
  end
end

CardGetShowWindow.GetUnlockText = function(fashionConfig, ...)
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

CardGetShowWindow.SetIntelligenceEffect = function(intelligence, ...)
  -- function num : 0_4 , upvalues : _ENV, uis
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

CardGetShowWindow.ChangeFashion = function(index, fashionIds, excelData, ...)
  -- function num : 0_5 , upvalues : _ENV, uis, fxMainEffect, contentPane, FxManager, CardGetShowWindow
  local fashionId = tonumber(fashionIds[index])
  local fashionData = ((TableData.gTable).BaseFashionData)[fashionId]
  ;
  (Util.RecycleUIModel)(uis.CardLoader)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R5 in 'UnsetPending'

  if fashionData.show_cg ~= nil then
    (uis.c2Ctr).selectedIndex = 0
    if fxMainEffect == nil then
      local effect = nil
      fxMainEffect = (LuaEffect.AddNotDeletedUIEffect)(fashionData.show_cg, Vector3.zero, 1)
      fxMainEffect:SetXY(contentPane.width / 2, contentPane.height / 2)
      contentPane:AddChildAt(fxMainEffect, contentPane:GetChildIndex(uis.CardLoader))
    else
      do
        fxMainEffect.visible = true
        -- DECOMPILER ERROR at PC47: Overwrote pending register: R5 in 'AssignReg'

        if effect ~= nil then
          fxMainEffect.visible = false
        end
        -- DECOMPILER ERROR at PC53: Confused about usage of register: R5 in 'UnsetPending'

        ;
        (uis.c2Ctr).selectedIndex = excelData.intelligence
        do
          local obj = (Util.CreateShowModel)(fashionId, uis.CardLoader, true, false, true)
          if fashionData.type ~= 3 then
            FxManager:SetShutterEffect(obj, (uis.CardLoader).image, Vector3(0, 0, -28))
          end
          -- DECOMPILER ERROR at PC86: Confused about usage of register: R5 in 'UnsetPending'

          if fashionData.unlock_remark then
            ((uis.PicExplain).WordTxt).text = (PUtil.get)(186, fashionData.unlock_remark)
          end
          ;
          (CardGetShowWindow.GetUnlockText)(fashionData)
        end
      end
    end
  end
end

CardGetShowWindow.ClearHolder = function(...)
  -- function num : 0_6 , upvalues : fxMainEffect, _ENV
  if fxMainEffect then
    (LuaEffect.DestroyEffect)(fxMainEffect)
    fxMainEffect = nil
  end
end

CardGetShowWindow.OnClose = function(...)
  -- function num : 0_7 , upvalues : _ENV, uis, contentPane, controller, argTable, isLottery, moveConfig, isAutoClose, isHave, fashionData, isSkip, picesNum, showModel, CardGetShowWindow, FxManager
  (AudioManager.DisposeCurAudioAndBubble)()
  uis = nil
  contentPane = nil
  controller = nil
  argTable = nil
  isLottery = false
  moveConfig = nil
  isAutoClose = false
  isHave = false
  fashionData = nil
  isSkip = false
  picesNum = 0
  showModel = nil
  ;
  (CardGetShowWindow.ClearHolder)()
  ;
  (GuideData.AbolishControlRefer)((WinResConfig.CardGetShowWindow).name)
  FxManager:DestroyShutterEffect()
end

CardGetShowWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_8
end

return CardGetShowWindow

