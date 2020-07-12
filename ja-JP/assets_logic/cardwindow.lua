-- params : ...
-- function num : 0 , upvalues : _ENV
require("Card_LevelUpWindow")
require("Card_StageUpWindow")
require("Card_SkillUpWindow")
require("Card_StarUpWindow")
require("Card_CardWindowByName")
require("Card_LevelGrpByName")
require("Card_MessageGrpByName")
require("Card_PanelByName")
require("Card_PropertyBtnByName")
require("Card_SkillGrpByName")
require("Card_StageGrpByName")
require("Card_StarGrpByName")
require("Card_YangChengBtnByName")
require("CardInfoWindow")
local CardWindow = {}
local uis, contentPane = nil, nil
local cardData = {}
local excelData = {}
local argTable = {}
local panelPageInt = 2
local PanelType = {LevelGrp = 1, StageGrp = 2, StarGrp = 3, SkillGrp = 4}
local curPageType = PanelType.StageGrp
local PanelUI = {}
local FxManager = require("FxManager")
local concatCards = {}
local controller, shutterCount = nil, nil
CardWindow.ReInitData = function(...)
  -- function num : 0_0
end

CardWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_1 , upvalues : _ENV, contentPane, uis, controller, argTable, CardWindow
  bridgeObj:SetView((WinResConfig.CardWindow).package, (WinResConfig.CardWindow).comName)
  contentPane = bridgeObj.contentPane
  contentPane:Center()
  uis = GetCard_CardWindowUis(contentPane)
  controller = uis.c1Ctr
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.TouchScreenBtn).visible = false
  if bridgeObj.argTable then
    argTable = bridgeObj.argTable
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R1 in 'UnsetPending'

    if argTable[1] then
      ((uis.PanelGrp).c1Ctr).selectedIndex = argTable[1]
    else
      -- DECOMPILER ERROR at PC36: Confused about usage of register: R1 in 'UnsetPending'

      ;
      ((uis.PanelGrp).c1Ctr).selectedIndex = 0
    end
    if argTable[2] then
      controller.selectedIndex = argTable[2]
    else
      controller.selectedIndex = 0
    end
  end
  local m = {}
  m.windowName = (WinResConfig.CardWindow).name
  m.Tip = (PUtil.get)(9)
  m.model = uis.AssetStripGrp
  m.closeToWindow = (WinResConfig.HomeWindow).name
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.PHYSICAL}
  if (ActorData.GetLevel)() == 5 then
    m.isSelfClose = true
    m.BackBtnFun = function(...)
    -- function num : 0_1_0 , upvalues : _ENV
    UIMgr:CloseToWindow((WinResConfig.HomeWindow).name)
  end

    m.CloseBtnFun = m.BackBtnFun
  end
  ;
  (CommonWinMgr.RegisterAssets)(m)
  ;
  ((uis.PictureLoader).onClick):Clear()
  ;
  ((uis.PictureLoader).onClick):Add(function(...)
    -- function num : 0_1_1 , upvalues : _ENV
    OpenWindow((WinResConfig.CardChoiceWindow).name, UILayer.HUD)
  end
)
  ;
  (CardWindow.WindowsBasicRefresh)(true)
  ;
  (CardWindow.SetRoleScrollView)()
  ;
  (CardService.ReqGetLikeCard)()
  ;
  (((uis.CardInfoGrp).CommentBtn).onClick):Set(function(...)
    -- function num : 0_1_2 , upvalues : _ENV
    local cardID = (CardData.ReturnCardID)()
    ;
    (CardService.ReqGetCardChat)(cardID, 1)
  end
)
  ;
  (CardWindow.RegisterGuide)()
  ;
  (LuaSound.PlaySound)(LuaSound.COMMON_PANEL_IN, SoundBank.OTHER)
end

CardWindow.RegisterGuide = function(...)
  -- function num : 0_2 , upvalues : _ENV, uis
  local RegisterGuideAndControl = GuideData.RegisterGuideAndControl
  local winName = (WinResConfig.CardWindow).name
  local ControlID = ControlID
  RegisterGuideAndControl(ControlID.Card_Strength, (uis.PanelGrp).LevelBtn, winName)
  RegisterGuideAndControl(ControlID.Card_Break, (uis.PanelGrp).StageBtn, winName)
  RegisterGuideAndControl(ControlID.Card_Wake, (uis.PanelGrp).StarBtn, winName)
  RegisterGuideAndControl(ControlID.Card_Talent, (uis.PanelGrp).SkillBtn, winName)
  RegisterGuideAndControl(ControlID.Card_Detail, uis.PropertyBtn, winName)
  RegisterGuideAndControl(ControlID.Card_ExpMedical, (((uis.PanelGrp).LevelGrp).ItemOneGrp).root, winName)
  RegisterGuideAndControl(ControlID.Card_Close, (uis.AssetStripGrp).CloseBtn, winName)
  RegisterGuideAndControl(ControlID.Card_Comment, (uis.CardInfoGrp).CommentBtn, winName)
  RegisterGuideAndControl(ControlID.Card_BreakBtn, ((uis.PanelGrp).StageGrp).ButtonTwoBtn, winName)
  RegisterGuideAndControl(ControlID.Card_WakeBtn, ((uis.PanelGrp).StarGrp).ButtonTwoBtn, winName)
  RegisterGuideAndControl(ControlID.Card_TalentList, (((uis.PanelGrp).SkillGrp).SkillEffectGrp).SkillList, winName)
end

CardWindow.WindowsBasicRefresh = function(isCreatSpine, ...)
  -- function num : 0_3 , upvalues : _ENV, cardData, excelData, uis, CardWindow
  local cardID = (CardData.ReturnCardID)()
  cardData = {}
  cardData = (CardData.GetCardData)(cardID)
  excelData = {}
  excelData = ((TableData.gTable).BaseCardData)[cardData.id]
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.PictureLoader).url = nil
  ;
  (CardWindow.CustomPropInit)(isCreatSpine)
  ;
  (CardWindow.AssetStripGrpPropInit)()
  ;
  (CardWindow.MessageGrpPropInit)()
  ;
  (CardWindow.PanelGrpPropInit)()
  ;
  (CardWindow.CheckEachButtonRedDot)()
end

local selectedIndex = nil
local minLength = 0
local maxLength = 0
CardWindow.SetRoleScrollView = function(...)
  -- function num : 0_4 , upvalues : _ENV, uis, controller, CardWindow
  (CardMgr.SetButtomRoleList)(uis.CardHeadList, function(index, data, ...)
    -- function num : 0_4_0 , upvalues : _ENV, controller, CardWindow
    if index ~= (CardData.GetCardIndex)() then
      (CardData.SaveCurClickCardID)(data.id)
      ;
      (CardData.SaveCurClickCardIndex)(index)
      if controller.selectedIndex == 0 then
        (CardWindow.WindowsBasicRefresh)(true)
      else
        ;
        (CardInfoWindow.RefreshWindow)()
        ;
        (CardInfoWindow.SetPictureLoader)()
      end
      ;
      (AudioManager.DisposeCurAudioAndBubble)(true)
    end
  end
, (CardData.GetCardIndex)(), uis.LeftBtn, uis.RightBtn, (WinResConfig.CardWindow).name)
end

CardWindow.RefreshCardList = function(...)
  -- function num : 0_5 , upvalues : concatCards, _ENV
  concatCards = {}
  concatCards = (CardData.GetObtainedCardList)()
  ;
  (CardMgr.RefreshCardList)(#concatCards)
end

CardWindow.CustomPropInit = function(isCreatSpine, ...)
  -- function num : 0_6 , upvalues : uis, _ENV, excelData, cardData, shutterCount, FxManager, controller
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  (uis.JueseNameLoader).url = (Util.GetItemUrl)(excelData.name_pic)
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  if isCreatSpine then
    (uis.PictureLoader).alpha = 0
    ;
    (Util.RecycleUIModel)(uis.PictureLoader)
    local isStatic = (Util.GetPlayerSetting)(cardData.id .. "Static", "0")
    do
      local fashionConfig = (CardData.GetFashionConfig)(cardData)
      print("get fashionId", fashionConfig.id, cardData.id)
      do
        local obj = nil
        if isStatic == "0" then
          obj = (Util.CreateShowModel)(fashionConfig.id, uis.PictureLoader, false, nil, nil, true)
          ;
          ((uis.PictureLoader).image):SetSkipFairyBatching(true)
        else
          local t_Object = (Util.ShowUIModel)(fashionConfig.show_texture, uis.PictureLoader)
          obj = t_Object
          ;
          (Util.UpdateShowTextureByConfig)(t_Object, fashionConfig)
        end
        do
          if shutterCount ~= nil then
            shutterCount:stop()
            shutterCount = nil
          end
          shutterCount = (SimpleTimer.setTimeout)(0.001, function(...)
    -- function num : 0_6_0 , upvalues : uis, FxManager, obj, _ENV, fashionConfig
    -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

    (uis.PictureLoader).alpha = 1
    FxManager:SetShutterEffect(obj, (uis.PictureLoader).image)
    ;
    (CardInfoWindow.SetFashionId)(fashionConfig.id)
  end
)
        end
        ;
        ((uis.PropertyBtn).onClick):Clear()
        ;
        ((uis.PropertyBtn).onClick):Add(function(...)
    -- function num : 0_6_1 , upvalues : controller, _ENV, uis
    controller.selectedIndex = 1
    ;
    (CardInfoWindow.Init)(uis)
  end
)
        -- DECOMPILER ERROR at PC86: Confused about usage of register: R1 in 'UnsetPending'

        ;
        (uis.c2Ctr).selectedIndex = cardData.intelligence - 1
        ;
        (CardMgr.SetIntelligenceEffect)(cardData.intelligence, (uis.PictureEffect).root)
      end
    end
  end
end

CardWindow.AssetStripGrpPropInit = function(...)
  -- function num : 0_7 , upvalues : uis, CardWindow, _ENV
  (((uis.AssetStripGrp).BackBtn).onClick):Add(CardWindow.OnClickBackButton)
  ;
  (((uis.AssetStripGrp).CloseBtn).onClick):Add(CardWindow.OnClickCloseButton)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.AssetStripGrp).FunctionNameTxt).text = (PUtil.get)(9)
end

CardWindow.OnClickBackButton = function(...)
  -- function num : 0_8 , upvalues : _ENV
  UIMgr:CloseWindow("CardWindow")
end

CardWindow.OnClickCloseButton = function(...)
  -- function num : 0_9 , upvalues : _ENV
  UIMgr:CloseToWindow()
end

CardWindow.MessageGrpPropInit = function(...)
  -- function num : 0_10 , upvalues : uis, _ENV, excelData, cardData, CardWindow
  local props = {(uis.MessageGrp).One, (uis.MessageGrp).Two, (uis.MessageGrp).Three}
  local propsTxt = {((uis.MessageGrp).One).LabelTxt, ((uis.MessageGrp).Two).LabelTxt, ((uis.MessageGrp).Three).LabelTxt}
  local selfLabel = split(excelData.card_label_show, ":")
  for i = 1, #props do
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R7 in 'UnsetPending'

    ((props[i]).root).visible = false
  end
  for i = 1, #selfLabel do
    -- DECOMPILER ERROR at PC37: Confused about usage of register: R7 in 'UnsetPending'

    ((props[i]).root).visible = true
    -- DECOMPILER ERROR at PC45: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (propsTxt[i]).text = (PUtil.get)(tonumber(selfLabel[i]))
  end
  -- DECOMPILER ERROR at PC53: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((uis.MessageGrp).BattleOneTxt).text = (PUtil.get)(7)
  -- DECOMPILER ERROR at PC57: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((uis.MessageGrp).BattleTwoTxt).text = cardData.fc
  ;
  ((uis.PropertyBtn).onClick):Add(CardWindow.ShowCharaPainting)
end

CardWindow.PanelGrpPropInit = function(...)
  -- function num : 0_11 , upvalues : uis, CardWindow, panelPageInt, _ENV, PanelUI
  (((uis.PanelGrp).LevelBtn).onClick):Add(function(...)
    -- function num : 0_11_0 , upvalues : CardWindow, panelPageInt, uis
    (CardWindow.DisposeAllButtoTrans)()
    panelPageInt = 1
    -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((uis.PanelGrp).c1Ctr).selectedIndex = 1
    ;
    (CardWindow.PanelGrpRefresh)()
  end
)
  ;
  (((uis.PanelGrp).LevelBtn):GetChild("NameTxt")).text = (PUtil.get)(10)
  ;
  (((uis.PanelGrp).StageBtn).onClick):Add(function(...)
    -- function num : 0_11_1 , upvalues : CardWindow, panelPageInt, uis
    (CardWindow.DisposeAllButtoTrans)()
    panelPageInt = 2
    -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((uis.PanelGrp).c1Ctr).selectedIndex = 0
    ;
    (CardWindow.PanelGrpRefresh)()
  end
)
  ;
  (((uis.PanelGrp).StageBtn):GetChild("NameTxt")).text = (PUtil.get)(16)
  ;
  (((uis.PanelGrp).StarBtn).onClick):Add(function(...)
    -- function num : 0_11_2 , upvalues : CardWindow, panelPageInt, uis
    (CardWindow.DisposeAllButtoTrans)()
    panelPageInt = 3
    -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((uis.PanelGrp).c1Ctr).selectedIndex = 2
    ;
    (CardWindow.PanelGrpRefresh)()
  end
)
  ;
  (((uis.PanelGrp).StarBtn):GetChild("NameTxt")).text = (PUtil.get)(17)
  ;
  (((uis.PanelGrp).SkillBtn).onClick):Add(function(...)
    -- function num : 0_11_3 , upvalues : CardWindow, panelPageInt, uis
    (CardWindow.DisposeAllButtoTrans)()
    panelPageInt = 4
    -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((uis.PanelGrp).c1Ctr).selectedIndex = 3
    ;
    (CardWindow.PanelGrpRefresh)()
  end
)
  ;
  (((uis.PanelGrp).SkillBtn):GetChild("NameTxt")).text = (PUtil.get)(18)
  ;
  (table.insert)(PanelUI, (uis.PanelGrp).LevelGrp)
  ;
  (table.insert)(PanelUI, (uis.PanelGrp).StageGrp)
  ;
  (table.insert)(PanelUI, (uis.PanelGrp).SkillGrp)
  ;
  (table.insert)(PanelUI, (uis.PanelGrp).StarGrp)
  ;
  (CardWindow.LevelUpGroupInit)()
  ;
  (CardWindow.StageGroupInit)()
  ;
  (CardWindow.SkillGroupInit)()
  ;
  (CardWindow.StarGroupInit)()
end

CardWindow.DisposeAllButtoTrans = function(...)
  -- function num : 0_12 , upvalues : _ENV, uis
  DisposeTrans((uis.PanelGrp).LevelBtn, "YangChengIn")
  DisposeTrans((uis.PanelGrp).LevelBtn, "YangChengOut")
  DisposeTrans((uis.PanelGrp).StageBtn, "YangChengIn")
  DisposeTrans((uis.PanelGrp).StageBtn, "YangChengOut")
  DisposeTrans((uis.PanelGrp).StarBtn, "YangChengIn")
  DisposeTrans((uis.PanelGrp).StarBtn, "YangChengOut")
  DisposeTrans((uis.PanelGrp).SkillBtn, "YangChengIn")
  DisposeTrans((uis.PanelGrp).SkillBtn, "YangChengOut")
end

CardWindow.PanelGrpRefresh = function(...)
  -- function num : 0_13 , upvalues : curPageType, panelPageInt, PanelType, CardWindow
  if curPageType == panelPageInt then
    return 
  end
  if panelPageInt == PanelType.LevelGrp then
    (CardWindow.LevelUpGroupInit)()
    curPageType = PanelType.LevelGrp
  else
    if panelPageInt == PanelType.StageGrp then
      curPageType = PanelType.StageGrp
      ;
      (CardWindow.StageGroupInit)()
    else
      if panelPageInt == PanelType.SkillGrp then
        curPageType = PanelType.SkillGrp
        ;
        (CardWindow.SkillGroupInit)()
      else
        if panelPageInt == PanelType.StarGrp then
          curPageType = PanelType.StarGrp
          ;
          (CardWindow.StarGroupInit)()
        end
      end
    end
  end
end

CardWindow.LevelUpGroupInit = function(...)
  -- function num : 0_14 , upvalues : _ENV, uis
  (Card_LevelUpWindow.Init)(uis)
end

CardWindow.StageGroupInit = function(...)
  -- function num : 0_15 , upvalues : _ENV, uis
  (Card_StageUpWindow.Init)(uis)
end

CardWindow.SkillGroupInit = function(...)
  -- function num : 0_16 , upvalues : _ENV, uis
  (Card_SkillUpWindow.Init)(uis)
end

CardWindow.StarGroupInit = function(...)
  -- function num : 0_17 , upvalues : _ENV, uis
  (Card_StarUpWindow.Init)(uis)
end

CardWindow.CheckEachButtonRedDot = function(...)
  -- function num : 0_18 , upvalues : uis, _ENV, cardData
  (((uis.PanelGrp).LevelBtn):GetChild("RedDot")).visible = (CardData.CheckAllHeroLevelUpRedPoint)(cardData.id)
  ;
  (((uis.PanelGrp).StageBtn):GetChild("RedDot")).visible = (CardData.CheckAllHeroStageUpRedPoint)(cardData.id)
  ;
  (((uis.PanelGrp).StarBtn):GetChild("RedDot")).visible = (CardData.CheckAllHeroStarUpRedPoint)(cardData.id)
  ;
  (((uis.PanelGrp).SkillBtn):GetChild("RedDot")).visible = (CardData.CheckAllHeroSkillUpRedPoint)(cardData.id)
end

CardWindow.OnShown = function(...)
  -- function num : 0_19
end

CardWindow.OnHide = function(...)
  -- function num : 0_20
end

CardWindow.OnClose = function(...)
  -- function num : 0_21 , upvalues : _ENV, uis, shutterCount, contentPane, PanelUI, concatCards, controller
  (GuideData.AbolishControlRefer)((WinResConfig.CardWindow).name)
  ;
  (Util.RecycleUIModel)(uis.PictureLoader)
  ;
  (ActorService.SetShowTeamFcChange)(true)
  ;
  (Card_LevelUpWindow.OnClose)()
  ;
  (Card_StageUpWindow.OnClose)()
  ;
  (Card_SkillUpWindow.OnClose)()
  ;
  (Card_StarUpWindow.OnClose)()
  ;
  (CommonWinMgr.RemoveAssets)((WinResConfig.CardWindow).name)
  ;
  (AudioManager.DisposeCurAudioAndBubble)()
  ;
  (CardMgr.ClearIntelligenceEffectsPool)()
  uis = nil
  if shutterCount ~= nil then
    shutterCount:stop()
    shutterCount = nil
  end
  contentPane = nil
  PanelUI = {}
  concatCards = {}
  controller = nil
end

CardWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_22 , upvalues : _ENV, CardWindow, cardData, uis, controller, excelData, panelPageInt, PanelType
  local windowMsgEnum = WindowMsgEnum.CardWindow
  if msgId == windowMsgEnum.E_MSG_CARD_LEVELUP then
    (CardWindow.CheckEachButtonRedDot)()
    ;
    (Card_LevelUpWindow.ResLevelInfo)(para, CardWindow.RefreshCardList)
  else
    if msgId == windowMsgEnum.E_MSG_CARD_STAGEUP then
      (CardWindow.CheckEachButtonRedDot)()
      ;
      (Card_StageUpWindow.ResStageInfo)(para, CardWindow.RefreshCardList)
    else
      if msgId == windowMsgEnum.E_MSG_CARD_SKILLUP then
        (CardWindow.CheckEachButtonRedDot)()
        ;
        (Card_SkillUpWindow.ResStageInfo)(para)
        ;
        (CardWindow.RefreshCardList)()
      else
        if msgId == windowMsgEnum.E_MSG_CARD_GOODCHANGE then
          (Card_LevelUpWindow.ResGoodChange)(CardWindow.RefreshCardList)
        else
          if msgId == windowMsgEnum.E_MSG_CARD_REFRESHCARDLISTBUTTOM then
            (CardWindow.RefreshCardList)()
          else
            if msgId == windowMsgEnum.E_MSG_CARD_STARUP then
              (CardWindow.CheckEachButtonRedDot)()
              ;
              (Card_StarUpWindow.Refresh)()
              ;
              (Card_StarUpWindow.ShowStarUpEffect)(para)
              cardData = (CardData.GetCardData)((CardData.ReturnCardID)())
              -- DECOMPILER ERROR at PC72: Confused about usage of register: R3 in 'UnsetPending'

              ;
              ((uis.MessageGrp).BattleTwoTxt).text = cardData.fc
              ;
              (CardWindow.RefreshCardList)()
            else
              if msgId == windowMsgEnum.E_MSG_CARD_AFTER_EXCHANGE then
                (Card_StarUpWindow.RefreshCostInfo)()
                ;
                (Card_StageUpWindow.SetMaterialInfo)()
                ;
                (Card_LevelUpWindow.UpdateItem)()
              else
              end
            end
          end
        end
      end
    end
  end
  if msgId ~= windowMsgEnum.E_MSG_CARD_USE_EXP_PROP or msgId == windowMsgEnum.E_MSG_CARD_CHOICESELECTCARDLIST then
    if controller.selectedIndex == 1 then
      (CardInfoWindow.OnChoiceSelectCardBack)()
    end
    ;
    (CardWindow.SetRoleScrollView)()
    ;
    (Card_StageUpWindow.RefreshWindow)()
    ;
    (CardWindow.CustomPropInit)(true)
    ;
    (CardMgr.ChangeCardListTag)((WinResConfig.CardWindow).name)
  else
    if msgId == windowMsgEnum.E_MSG_CARD_CLOSECARDCHOICE then
      cardData = (CardData.GetCardData)((CardData.ReturnCardID)())
      excelData = ((TableData.gTable).BaseCardData)[cardData.id]
      -- DECOMPILER ERROR at PC134: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (uis.PictureLoader).url = nil
      if controller.selectedIndex == 0 then
        (CardWindow.WindowsBasicRefresh)(true)
      else
        ;
        (CardInfoWindow.RefreshWindow)()
        ;
        (CardInfoWindow.SetPictureLoader)()
      end
      ;
      (CardWindow.SetRoleScrollView)()
      ;
      (CardMgr.ChangeCardListTag)((WinResConfig.CardWindow).name)
    else
      if msgId == windowMsgEnum.E_MSG_CARD_CLOSECARDINFO then
        (CardWindow.WindowsBasicRefresh)(false)
      else
        if msgId == windowMsgEnum.E_MSG_CARD_CHOICEWINDOWSELECT then
          (CardInfoWindow.RefreshWindow)()
          ;
          (CardInfoWindow.SetPictureLoader)()
        else
        end
      end
    end
  end
  if msgId ~= windowMsgEnum.E_MSG_CARD_LEVELUP_TRUE or msgId == windowMsgEnum.E_MSG_CARD_STAGEUP_TRUE then
    local fashionConfig = (CardData.GetFashionConfig)(cardData)
    ;
    (AudioManager.PlayBubbleAndVoice)(true, true, fashionConfig.id, CVAudioType.QualityUpBubble, uis.PictureLoader, uis)
  else
    do
      if msgId == windowMsgEnum.E_MSG_CARD_STARUP_TRUE then
        local fashionConfig = (CardData.GetFashionConfig)(cardData)
        ;
        (AudioManager.PlayBubbleAndVoice)(true, true, fashionConfig.id, CVAudioType.StarUpBubble, uis.PictureLoader, uis)
      else
        do
          if msgId == (WindowMsgEnum.NETBrokenReconnect).E_MSG_RECONNECT_Ok then
            if panelPageInt == PanelType.LevelGrp then
              (Card_LevelUpWindow.LevelUpGroupRefresh)(true)
            else
              if panelPageInt == PanelType.StageGrp then
                (Card_StageUpWindow.RefreshWindow)()
              else
                if panelPageInt == PanelType.SkillGrp then
                  (Card_SkillUpWindow.RefreshWindow)(true)
                else
                  if panelPageInt == PanelType.StarGrp then
                    (Card_StarUpWindow.Refresh)()
                  end
                end
              end
            end
          else
            if msgId == (WindowMsgEnum.CardWindow).E_MSG_CARD_SWEEP_END then
              (CardWindow.CheckEachButtonRedDot)()
              ;
              (Card_StarUpWindow.Refresh)()
            end
          end
        end
      end
    end
  end
end

return CardWindow

