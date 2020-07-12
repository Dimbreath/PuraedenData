-- params : ...
-- function num : 0 , upvalues : _ENV
require("CardPop_NewCardGetByName")
local NewCardGetWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local cardId = nil
local fashionIds = {}
local holder, showModel = nil, nil
local FxManager = require("FxManager")
NewCardGetWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, cardId, fashionIds, NewCardGetWindow
  bridgeObj:SetView((WinResConfig.NewCardGetWindow).package, (WinResConfig.NewCardGetWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  contentPane:Center()
  uis = GetCardPop_NewCardGetUis(contentPane)
  cardId = argTable[1]
  if argTable[2] then
    fashionIds = argTable[2]
  end
  ;
  (LuaSound.PlaySound)(LuaSound.COMMON_SHOW_REWARD, SoundBank.OTHER)
  ;
  (NewCardGetWindow.RefreshWindow)()
  ;
  (Util.RegistCaptureScreenShot)((uis.Information).ShotBtn, (uis.Information).LogoImage, (uis.Information).CodeImage, 1334, 750)
end

NewCardGetWindow.RefreshWindow = function(...)
  -- function num : 0_1 , upvalues : _ENV, cardId, uis, fashionIds, holder, contentPane, showModel, NewCardGetWindow, FxManager
  local excelData = ((TableData.gTable).BaseCardData)[cardId]
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.TipsTxt).text = (PUtil.get)(33)
  ;
  ((uis.TouchScreenBtn).onClick):Clear()
  ;
  ((uis.TouchScreenBtn).onClick):Set(function(...)
    -- function num : 0_1_0 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.NewCardGetWindow).name)
  end
)
  ;
  (GuideData.RegisterGuideAndControl)(ControlID.Card_GetShow, uis.TouchScreenBtn, (WinResConfig.NewCardGetWindow).name)
  local fashionId = tonumber(fashionIds[1])
  local fashionData = ((TableData.gTable).BaseFashionData)[fashionId]
  if fashionData.type <= 2 then
    (CardService.ReqSetFashion)(cardId, fashionId)
  end
  ;
  (Util.RecycleUIModel)(uis.CardLoader)
  -- DECOMPILER ERROR at PC52: Confused about usage of register: R3 in 'UnsetPending'

  if fashionData.show_cg ~= nil then
    (uis.c2Ctr).selectedIndex = 0
    local effect = nil
    holder = (LuaEffect.AddNotDeletedUIEffect)(fashionData.show_cg, Vector3.zero, 1)
    holder:SetXY(contentPane.width / 2, contentPane.height / 2)
    contentPane:AddChildAt(holder, 0)
    if effect then
      showModel = effect:GetComponentInChildren(typeof(((CS.Spine).Unity).SkeletonAnimation))
    end
  else
    do
      -- DECOMPILER ERROR at PC87: Overwrote pending register: R3 in 'AssignReg'

      -- DECOMPILER ERROR at PC89: Confused about usage of register: R3 in 'UnsetPending'

      effect.selectedIndex = excelData.intelligence
      ;
      (NewCardGetWindow.SetIntelligenceEffect)(excelData.intelligence)
      do
        local obj = (Util.CreateShowModel)(fashionId, uis.CardLoader, true, false, true)
        if fashionData.type <= 2 then
          FxManager:SetShutterEffect(obj, (uis.CardLoader).image, Vector3(0, 0, -28))
        end
        ;
        (AudioManager.DisposeCurAudioAndBubble)()
        ;
        (AudioManager.PlayBubbleAndVoice)(true, true, fashionId, CVAudioType.UnLockBubble, uis.CardLoader, uis)
        ;
        (Util.ShowGuideTips)(GuideTipsCheckPoint.AcquireCharacterCG, excelData.name)
      end
    end
  end
end

NewCardGetWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_2 , upvalues : _ENV
  local windowMsgEnum = WindowMsgEnum.CardWindow
  if msgId == windowMsgEnum.E_MSG_CARD_SETFASHIONID then
    (CardData.SaveFashionID)(para.cardId, para.fashionId)
    local showCardId = (((TableData.gTable).BaseFashionData)[(ActorData.GetFashionShow)()]).card_id
    local newFashionData = ((TableData.gTable).BaseFashionData)[para.fashionId]
    local getCardId = newFashionData.card_id
    if showCardId == getCardId then
      (CardService.ReqSetMainCover)(para.fashionId)
      if newFashionData.show_spine ~= nil then
        (Util.SetPlayerSetting)(PlayerPrefsKeyName.MAIN_SHOW_STATIC, "0")
      end
    end
    print("save fashionID", para.fashionId)
    UIMgr:SendWindowMessage("CardWindow", (WindowMsgEnum.CardWindow).E_MSG_CARD_CHOICESELECTCARDLIST, {})
  end
end

NewCardGetWindow.SetIntelligenceEffect = function(intelligence, ...)
  -- function num : 0_3 , upvalues : _ENV, uis
  if intelligence == 1 then
    local holder, effect = (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_LOTTERY_CARDGET_BLUE, false, (uis.CardGetEffect).root, (Vector2(((uis.CardGetEffect).root).width * 0.5, ((uis.CardGetEffect).root).height * 0.5)), nil, 1, true)
    ;
    (((effect.transform):Find("FX_gachaend_blue_grp/light_up")).gameObject):SetActive(false)
  else
    do
      if intelligence == 2 then
        local holder, effect = (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_LOTTERY_CARDGET_VIOLET, false, (uis.CardGetEffect).root, (Vector2(((uis.CardGetEffect).root).width * 0.5, ((uis.CardGetEffect).root).height * 0.5)), nil, 1, true)
        ;
        (((effect.transform):Find("FX_gachaend_violet_grp/light_up")).gameObject):SetActive(false)
      else
        do
          if intelligence == 3 then
            local holder, effect = (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_LOTTERY_CARDGET_GOLD, false, (uis.CardGetEffect).root, (Vector2(((uis.CardGetEffect).root).width * 0.5, ((uis.CardGetEffect).root).height * 0.5)), nil, 1, true)
            ;
            (((effect.transform):Find("FX_gachaend_gold_grp/light_up")).gameObject):SetActive(false)
          end
        end
      end
    end
  end
end

NewCardGetWindow.OnClose = function(...)
  -- function num : 0_4 , upvalues : _ENV, cardId, uis, contentPane, argTable, holder, showModel
  if isfromStageUp then
    (CommonWinMgr.OpenCommonFcUp)(cardId)
    UIMgr:SendWindowMessage("CardWindow", (WindowMsgEnum.CardWindow).E_MSG_CARD_STAGEUP_TRUE, {})
  end
  ;
  (AudioManager.DisposeCurAudioAndBubble)()
  ;
  (Util.RecycleUIModel)(uis.CardLoader)
  uis = nil
  contentPane = nil
  argTable = nil
  cardId = nil
  isfromStageUp = false
  if holder then
    (LuaEffect.DestroyEffect)(holder)
    holder = nil
  end
  showModel = nil
  ;
  (GuideData.AbolishControlRefer)((WinResConfig.NewCardGetWindow).name)
end

return NewCardGetWindow

