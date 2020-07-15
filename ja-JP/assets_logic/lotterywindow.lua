-- params : ...
-- function num : 0 , upvalues : _ENV
require("Lottery_LotteryByName")
require("LotteryWindow_Card")
require("LotteryWindow_Coupon")
require("LotteryWindow_Fresh")
require("LotteryWindow_Sure")
require("LotteryWindow_Activity")
require("LotteryWindow_Activity2")
local LotteryType = {Card = 1, Equip = 2, Coupon = 3, Fresh = 4, ShilianBiChu = 6, HuoDongUp = 7, HuoDongUp2 = 8}
local lotteryType = LotteryType.Fresh
local LotteryWindow = {}
local uis, contentPane, drawResult = nil, nil, nil
local cardIndex = 1
local cardResults = {}
local isAutoPlay = false
local timeLineTimer = nil
local FxManager = require("FxManager")
local noviceLottery = false
local video = (CS.VideoManager).Instance
local UI_LOTTERY_REWARD_TEXT, UI_LOTTERY_REWARD_END = nil, nil
local lotteryBtns = {}
LotteryWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, uis, LotteryWindow, LotteryType
  bridgeObj:SetView((WinResConfig.LotteryWindow).package, (WinResConfig.LotteryWindow).comName)
  contentPane = bridgeObj.contentPane
  contentPane:Center()
  uis = GetLottery_LotteryUis(contentPane)
  ;
  (LotteryWindow.ClassicInit)(true)
  ;
  (LotteryWindow.BindingUI)()
  ;
  (LotteryWindow.InitFunctionControl)()
  ResHelper = CS.ResHelper
  ;
  (ResHelper.ClearAllCache)()
  if (ActorData.GetLotteryActivityNum)(LotteryType.HuoDongUp) then
    (LotteryWindow_Activity.PreLoadFxMain)(uis)
  end
  if (ActorData.GetLotteryActivityNum)(LotteryType.HuoDongUp2) then
    (LotteryWindow_Activity2.PreLoadFxMain)(uis)
  end
end

LotteryWindow.BindingUI = function(...)
  -- function num : 0_1 , upvalues : _ENV, lotteryBtns, LotteryType
  local winName = (WinResConfig.LotteryWindow).name
  if lotteryBtns[LotteryType.Card] then
    (RedDotMgr.BindingUI)(winName, RedDotComID.Lottery_Character, lotteryBtns[LotteryType.Card])
  end
  if lotteryBtns[LotteryType.Coupon] then
    (RedDotMgr.BindingUI)(winName, RedDotComID.Lottery_Card, lotteryBtns[LotteryType.Coupon])
  end
  ;
  (RedDotMgr.RefreshTreeUI)(winName)
end

LotteryWindow.InitFunctionControl = function(...)
  -- function num : 0_2 , upvalues : _ENV, lotteryBtns, LotteryType, uis
  local winName = (WinResConfig.LotteryWindow).name
  local RegisterGuideAndControl = GuideData.RegisterGuideAndControl
  local ControlID = ControlID
  RegisterGuideAndControl(ControlID.Lottery_Part, lotteryBtns[LotteryType.Card], winName)
  RegisterGuideAndControl(ControlID.Lottery_Card, lotteryBtns[LotteryType.Coupon], winName)
  RegisterGuideAndControl(ControlID.Lottery_NoviceSingle, ((uis.LotteryPanelGrp).GetCha_NewCardGrp).OneTimeBtn, winName)
  RegisterGuideAndControl(ControlID.Lottery_NoviceTen, ((uis.LotteryPanelGrp).GetCha_NewCardGrp).TenTimeBtn, winName)
  RegisterGuideAndControl(ControlID.Lottery_Back, (uis.AssetStripGrp).BackBtn, winName)
end

LotteryWindow.ClassicInit = function(...)
  -- function num : 0_3 , upvalues : uis, _ENV, lotteryType, LotteryWindow
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.GechaCardEffectGrp).root).visible = false
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.LotteryPanelGrp).BgImage).visible = false
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.StartWord).root).visible = false
  local uiMap = (uis.StartWord).root
  local holder = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_LOTTERYDIALOG_SHOW, false, false)
  holder:SetXY(uiMap.width / 2, uiMap.height / 2)
  uiMap:AddChild(holder)
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.TouchScreenBtn).visible = false
  local m = {}
  m.windowName = (WinResConfig.LotteryWindow).name
  m.Tip = (PUtil.get)(84)
  m.model = uis.AssetStripGrp
  m.closeToWindow = (WinResConfig.HomeWindow).name
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD}
  ;
  (CommonWinMgr.RegisterAssets)(m)
  ;
  (((uis.LotteryPanelGrp).ProbabilityBtn):GetChild("WordTxt")).text = (PUtil.get)(187)
  ;
  (((uis.LotteryPanelGrp).ProbabilityBtn).onClick):ClearCallFunc()
  ;
  (((uis.LotteryPanelGrp).ProbabilityBtn).onClick):Add(function(...)
    -- function num : 0_3_0 , upvalues : _ENV, lotteryType
    OpenWindow("LotteryProbabilityWindow", UILayer.HUD, lotteryType)
  end
)
  ;
  (LotteryWindow.LotteryButtonRefresh)()
end

LotteryWindow.LotteryButtonRefresh = function(...)
  -- function num : 0_4 , upvalues : noviceLottery, _ENV, uis, LotteryType, lotteryBtns, lotteryType, LotteryWindow
  noviceLottery = (ActorData.GetNoviceLottery)()
  ;
  ((uis.LotteryPanelGrp).ButtonList):RemoveChildrenToPool()
  local btnTab = {}
  ;
  (table.insert)(btnTab, LotteryType.Coupon)
  if noviceLottery then
    (table.insert)(btnTab, LotteryType.Fresh)
  else
    ;
    (table.insert)(btnTab, LotteryType.Card)
    if (ActorData.GetLotteryActivityNum)(LotteryType.HuoDongUp) then
      (table.insert)(btnTab, LotteryType.HuoDongUp)
    end
    if (ActorData.GetLotteryActivityNum)(LotteryType.HuoDongUp2) then
      (table.insert)(btnTab, LotteryType.HuoDongUp2)
    end
  end
  if (ActorData.GetLotteryActivityNum)(LotteryType.ShilianBiChu) then
    (table.insert)(btnTab, LotteryType.ShilianBiChu)
  end
  ;
  (table.sort)(btnTab, function(a, b, ...)
    -- function num : 0_4_0 , upvalues : _ENV
    do return (((TableData.gTable).BaseLotteryShowData)[a]).sort < (((TableData.gTable).BaseLotteryShowData)[b]).sort end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  lotteryBtns = {}
  local isStillChooseThisType = false
  for index,value in ipairs(btnTab) do
    do
      local showData = ((TableData.gTable).BaseLotteryShowData)[value]
      if lotteryType == value then
        do
          isStillChooseThisType = true
          do break end
          -- DECOMPILER ERROR at PC82: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC82: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  for index,value in ipairs(btnTab) do
    local showData = ((TableData.gTable).BaseLotteryShowData)[value]
    if index == 1 and isStillChooseThisType == false then
      lotteryType = value
    end
    local button = ((uis.LotteryPanelGrp).ButtonList):AddItemFromPool((UIPackage.GetItemURL)("Lottery", showData.button_asset))
    lotteryBtns[value] = button
    -- DECOMPILER ERROR at PC113: Confused about usage of register: R9 in 'UnsetPending'

    if value == lotteryType then
      ((uis.LotteryPanelGrp).ButtonList).selectedIndex = index - 1
      -- DECOMPILER ERROR at PC117: Confused about usage of register: R9 in 'UnsetPending'

      ;
      ((uis.LotteryPanelGrp).c1Ctr).selectedIndex = showData.selected_index
      ;
      (LotteryWindow.RefreshLotteryPanel)()
    end
    ;
    (button.onClick):Set(function(...)
    -- function num : 0_4_1 , upvalues : lotteryType, value, uis, index, showData, LotteryWindow
    if lotteryType == value then
      return 
    end
    lotteryType = value
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((uis.LotteryPanelGrp).ButtonList).selectedIndex = index - 1
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((uis.LotteryPanelGrp).c1Ctr).selectedIndex = showData.selected_index
    ;
    (LotteryWindow.RefreshLotteryPanel)()
  end
)
  end
end

LotteryWindow.RefreshLotteryPanel = function(...)
  -- function num : 0_5 , upvalues : lotteryType, LotteryType, LotteryWindow, _ENV
  if ((((((lotteryType == LotteryType.Fresh and lotteryType ~= LotteryType.Card) or lotteryType == LotteryType.Coupon) and lotteryType ~= LotteryType.Equip) or lotteryType == LotteryType.HuoDongUp) and lotteryType ~= LotteryType.HuoDongUp2) or lotteryType == LotteryType.ShilianBiChu) then
    (LotteryWindow.SetAssetType)()
    ;
    (LotteryWindow.SetLotteryDate)(lotteryType)
    ;
    (LotteryService.ReqLotteryInit)(lotteryType)
  end
end

LotteryWindow.SetLotteryDate = function(lType, ...)
  -- function num : 0_6 , upvalues : _ENV, uis
  local beginTime, endTime = (ActorData.GetActivityLotteryTime)(lType)
  local isShow = beginTime ~= -1 and beginTime ~= nil
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (((uis.LotteryPanelGrp).Time).root).visible = isShow
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R4 in 'UnsetPending'

  if isShow then
    (((uis.LotteryPanelGrp).Time).StartTxt).text = (PUtil.get)(221) .. (LuaTime.GetFormatTimeStr)("%Y-%m-%d %H:%M", beginTime)
    -- DECOMPILER ERROR at PC43: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (((uis.LotteryPanelGrp).Time).EndTxt).text = (PUtil.get)(222) .. (LuaTime.GetFormatTimeStr)("%Y-%m-%d %H:%M", endTime)
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

LotteryWindow.OnClose = function(...)
  -- function num : 0_7 , upvalues : uis, contentPane, lotteryType, LotteryType, cardIndex, isAutoPlay, timeLineTimer, lotteryBtns, UI_LOTTERY_REWARD_TEXT, _ENV, UI_LOTTERY_REWARD_END
  uis = nil
  contentPane = nil
  lotteryType = nil
  lotteryType = LotteryType.Fresh
  cardIndex = nil
  isAutoPlay = false
  timeLineTimer = nil
  lotteryBtns = {}
  if UI_LOTTERY_REWARD_TEXT ~= nil then
    (ResHelper.DestroyGameObject)(UI_LOTTERY_REWARD_TEXT)
    UI_LOTTERY_REWARD_TEXT = nil
  end
  if UI_LOTTERY_REWARD_END ~= nil then
    (ResHelper.DestroyGameObject)(UI_LOTTERY_REWARD_END)
    UI_LOTTERY_REWARD_END = nil
  end
  ;
  (LotteryMgr.RemoveAllBackGroundEffectsFromPool)()
  ;
  (GuideData.AbolishControlRefer)((WinResConfig.LotteryWindow).name)
  ;
  (CommonWinMgr.RemoveAssets)((WinResConfig.LotteryWindow).name)
  ;
  (LotteryWindow_Coupon.OnClose)()
  ;
  (LotteryWindow_Fresh.OnClose)()
  ;
  (LotteryWindow_Card.OnClose)()
  ;
  (LotteryWindow_Sure.OnClose)()
  ;
  (LotteryWindow_Activity.OnClose)()
  ;
  (LotteryWindow_Activity2.OnClose)()
  ;
  (ResHelper.ClearAllCache)()
end

LotteryWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_8 , upvalues : _ENV, lotteryType, LotteryType, uis, LotteryWindow, drawResult, cardIndex, cardResults, isAutoPlay
  local windowMsgEnum = WindowMsgEnum.Lottery
  if msgId == windowMsgEnum.E_MSG_LOTTERY_INIT then
    (LotteryData.SaveLotteryData)(para.data, lotteryType)
    if lotteryType == LotteryType.Card then
      (LotteryWindow_Card.RefreshWindow)(uis)
      ;
      (LotteryWindow_Card.ReceiveInitData)()
    else
      if lotteryType == LotteryType.Coupon then
        (LotteryWindow_Coupon.RefreshWindow)(uis)
        ;
        (LotteryWindow_Coupon.ReceiveInitData)()
      else
        if lotteryType == LotteryType.Fresh then
          (LotteryWindow_Fresh.RefreshWindow)(uis)
          ;
          (LotteryWindow_Fresh.ReceiveInitData)()
        else
          if lotteryType == LotteryType.ShilianBiChu then
            (LotteryWindow_Sure.RefreshWindow)(uis)
          else
            if lotteryType == LotteryType.HuoDongUp then
              (LotteryWindow_Activity.RefreshWindow)(uis)
            else
              if lotteryType == LotteryType.HuoDongUp2 then
                (LotteryWindow_Activity2.RefreshWindow)(uis)
              end
            end
          end
        end
      end
    end
  else
    if msgId == windowMsgEnum.E_MSG_LOTTERY_DRAW then
      if lotteryType == LotteryType.Card then
        (LotteryWindow_Card.ReceiveDrawedData)(para)
      else
        if lotteryType == LotteryType.Coupon then
          (LotteryWindow_Coupon.ReceiveDrawedData)(para)
        else
          if lotteryType == LotteryType.Fresh then
            (LotteryWindow_Fresh.ReceiveDrawedData)(para)
          else
            if lotteryType == LotteryType.ShilianBiChu then
              (LotteryWindow_Sure.ReceiveDrawedData)(para)
            else
              if lotteryType == LotteryType.HuoDongUp then
                (LotteryWindow_Activity.ReceiveDrawedData)(para)
              else
                if lotteryType == LotteryType.HuoDongUp2 then
                  (LotteryWindow_Activity2.ReceiveDrawedData)(para)
                end
              end
            end
          end
        end
      end
      local randomCard = (Util.Shuffle)((para.data).goods)
      ;
      (LotteryWindow.BubbleSortGoods)(randomCard)
      -- DECOMPILER ERROR at PC138: Confused about usage of register: R4 in 'UnsetPending'

      ;
      (para.data).goods = randomCard
      drawResult = para
      -- DECOMPILER ERROR at PC141: Confused about usage of register: R4 in 'UnsetPending'

      ;
      (uis.TouchScreenBtn).visible = true
    else
      do
        -- DECOMPILER ERROR at PC147: Confused about usage of register: R3 in 'UnsetPending'

        if msgId == windowMsgEnum.E_MSG_LOTTERY_REWARDCLOSE then
          (uis.TouchScreenBtn).visible = false
          -- DECOMPILER ERROR at PC150: Confused about usage of register: R3 in 'UnsetPending'

          ;
          ((uis.StartWord).root).visible = false
          -- DECOMPILER ERROR at PC153: Confused about usage of register: R3 in 'UnsetPending'

          ;
          ((uis.LotteryPanelGrp).BgImage).visible = false
        else
        end
        if msgId ~= windowMsgEnum.E_MSG_THE_ENDOFTHE_FRESH or msgId == windowMsgEnum.E_MSG_LOTTERY_DRAW_ANIMATION_END then
          cardIndex = 1
          cardResults = {}
          isAutoPlay = false
          ;
          (LotteryWindow.ShowCardProcess)(drawResult)
          -- DECOMPILER ERROR at PC173: Confused about usage of register: R3 in 'UnsetPending'

          ;
          ((uis.LotteryPanelGrp).BgImage).visible = true
        else
          if msgId == windowMsgEnum.E_MSG_ONCLOSE_NEWGET then
            if cardIndex < #cardResults then
              cardIndex = cardIndex + 1
              ;
              (LotteryWindow.RunCardResultEffect)(cardIndex)
            else
              loge("已到最后一个 直接显示结果")
              if lotteryType == LotteryType.Card then
                (LotteryWindow_Card.ShowResult)(drawResult)
              else
                if lotteryType == LotteryType.Fresh then
                  (LotteryWindow_Fresh.ShowResult)(drawResult)
                  local isHaveNum = (LotteryData.CheckFreshHaveNum)()
                  if not isHaveNum then
                    (LotteryWindow.ClassicInit)()
                  end
                else
                  do
                    if lotteryType == LotteryType.Coupon then
                      (LotteryWindow_Coupon.ShowResult)(drawResult)
                    else
                      if lotteryType == LotteryType.ShilianBiChu then
                        (LotteryWindow_Sure.ShowResult)(drawResult)
                        ;
                        (LotteryWindow.ClassicInit)()
                      else
                        if lotteryType == LotteryType.HuoDongUp then
                          (LotteryWindow_Activity.ShowResult)(drawResult)
                          ;
                          (LotteryWindow.ClassicInit)()
                        else
                          if lotteryType == LotteryType.HuoDongUp2 then
                            (LotteryWindow_Activity2.ShowResult)(drawResult)
                            ;
                            (LotteryWindow.ClassicInit)()
                          end
                        end
                      end
                    end
                    -- DECOMPILER ERROR at PC261: Confused about usage of register: R3 in 'UnsetPending'

                    ;
                    ((uis.GechaCardEffectGrp).root).visible = false
                    if msgId == windowMsgEnum.E_MSG_ONCLICKCARDGET_SKIPBTN then
                      isAutoPlay = true
                      -- DECOMPILER ERROR at PC270: Confused about usage of register: R3 in 'UnsetPending'

                      ;
                      ((uis.GechaCardEffectGrp).SkipBtn).visible = false
                    else
                      if msgId == windowMsgEnum.E_MSG_REFRESHLOTTERYLIST then
                        (LotteryWindow.ClassicInit)()
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

LotteryWindow.ShowCardProcess = function(para, isShowFirst, ...)
  -- function num : 0_9 , upvalues : _ENV, cardResults, uis, LotteryWindow, cardIndex
  for index,value in ipairs((para.data).goods) do
    if value.type == PropType.CARD then
      local cardData = ((TableData.gTable).BaseCardData)[value.id]
      local isHave = value.value == 0
      ;
      (table.insert)(cardResults, {id = value.id, intelligence = cardData.intelligence, isHave = isHave, picesNum = value.value})
    end
  end
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((uis.GechaCardEffectGrp).root).visible = true
  -- DECOMPILER ERROR at PC39: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((uis.GechaCardEffectGrp).SkipBtn).visible = true
  ;
  (LotteryWindow.RunCardResultEffect)(cardIndex)
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

LotteryWindow.RunCardResultEffect = function(index, ...)
  -- function num : 0_10 , upvalues : cardResults, lotteryType, LotteryType, _ENV, drawResult, uis, isAutoPlay, UI_LOTTERY_REWARD_END, UI_LOTTERY_REWARD_TEXT, video, LotteryWindow
  if #cardResults < 1 then
    if lotteryType == LotteryType.Card then
      (LotteryWindow_Card.ShowResult)(drawResult)
    else
      if lotteryType == LotteryType.Coupon then
        (LotteryWindow_Coupon.ShowResult)(drawResult)
      else
        if lotteryType == LotteryType.Fresh then
          (LotteryWindow_Fresh.ShowResult)(drawResult)
        end
      end
    end
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((uis.GechaCardEffectGrp).root).visible = false
    isAutoPlay = false
    return 
  end
  ;
  (AudioManager.DisposeCurAudioAndBubble)()
  if UI_LOTTERY_REWARD_END ~= nil then
    (ResHelper.DestroyGameObject)(UI_LOTTERY_REWARD_END)
    UI_LOTTERY_REWARD_END = nil
  end
  local cardInfo = cardResults[index]
  -- DECOMPILER ERROR at PC58: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((uis.GechaCardEffectGrp).SkipBtn).visible = (not isAutoPlay and cardInfo.isHave)
  local isShouldPlay = cardInfo.isHave == false or isAutoPlay == false
  -- DECOMPILER ERROR at PC76: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((uis.StartWord).root).visible = not isShouldPlay or cardInfo.intelligence > 1
  if isShouldPlay and cardInfo.intelligence > 1 then
    local cardExcelData = ((TableData.gTable).BaseCardData)[cardInfo.id]
    do
      -- DECOMPILER ERROR at PC91: Confused about usage of register: R4 in 'UnsetPending'

      ((uis.StartWord).c1Ctr).selectedIndex = cardExcelData.intelligence - 1
      -- DECOMPILER ERROR at PC98: Confused about usage of register: R4 in 'UnsetPending'

      ;
      ((uis.StartWord).LinesLoader).url = (Util.GetItemUrl)(cardExcelData.lottery_dialogue)
      if UI_LOTTERY_REWARD_TEXT == nil then
        local holder, effect_Txt = (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_LOTTERY_REWARD_TEXT, false, (uis.StartWord).root, (Vector2(((uis.StartWord).root).width * 0.5, ((uis.StartWord).root).height * 0.5)), nil, 1, false)
        UI_LOTTERY_REWARD_TEXT = effect_Txt
      else
        UI_LOTTERY_REWARD_TEXT:SetActive(true)
      end
      if cardExcelData.lottery_show then
        video:PreLoadVideo(cardExcelData.lottery_show)
      end
      local fairyGuiTime = (SimpleTimer.setTimeout)(3, function(...)
    -- function num : 0_10_0 , upvalues : _ENV, uis, UI_LOTTERY_REWARD_END, LotteryWindow, index
    local holder, effect_Txt = (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_LOTTERY_REWARD_END, false, (uis.StartWord).root, (Vector2(((uis.StartWord).root).width * 0.5, ((uis.StartWord).root).height * 0.5)), nil, 1, true)
    UI_LOTTERY_REWARD_END = effect_Txt
    ;
    (SimpleTimer.setTimeout)(0.5, function(...)
      -- function num : 0_10_0_0 , upvalues : LotteryWindow, index
      (LotteryWindow.PlayTimeLineOrCameraMove)(index)
    end
)
  end
)
      local trans = PlayUITrans((uis.StartWord).root, "in")
      ;
      (((uis.GechaCardEffectGrp).EffcetLoader).onClick):ClearCallFunc()
      ;
      (((uis.GechaCardEffectGrp).EffcetLoader).onClick):Add(function(...)
    -- function num : 0_10_1 , upvalues : cardInfo, trans, fairyGuiTime, _ENV
    if cardInfo.isHave then
      trans:Stop(true, true)
      if fairyGuiTime ~= nil then
        fairyGuiTime:Comp()
        fairyGuiTime = nil
      end
    else
      print("第一次获得  不能跳过独白")
    end
  end
)
      ;
      (((uis.GechaCardEffectGrp).SkipBtn).onClick):ClearCallFunc()
      ;
      (((uis.GechaCardEffectGrp).SkipBtn).onClick):Add(function(...)
    -- function num : 0_10_2 , upvalues : isAutoPlay, uis, cardInfo, trans, fairyGuiTime, _ENV
    isAutoPlay = true
    -- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((uis.GechaCardEffectGrp).SkipBtn).visible = false
    if cardInfo.isHave then
      trans:Stop(true, true)
      if fairyGuiTime ~= nil then
        fairyGuiTime:Comp()
        fairyGuiTime = nil
      end
    else
      print("第一次获得  不能跳过独白")
    end
  end
)
    end
  else
    (LotteryWindow.PlayTimeLineOrCameraMove)(index)
  end
  -- DECOMPILER ERROR: 10 unprocessed JMP targets
end

LotteryWindow.PlayTimeLineOrCameraMove = function(index, ...)
  -- function num : 0_11 , upvalues : cardResults, _ENV, isAutoPlay, video, uis, UI_LOTTERY_REWARD_TEXT, UI_LOTTERY_REWARD_END
  local isTheLast = #cardResults == index
  local isTheFirst = index == 1
  local cardInfo = cardResults[index]
  local cardExcelData = ((TableData.gTable).BaseCardData)[cardInfo.id]
  if cardExcelData.lottery_show then
    if cardInfo.isHave == false or isAutoPlay == false then
      video:PlayVideo(uis.VideoLoader, cardExcelData.lottery_show, function(...)
    -- function num : 0_11_0 , upvalues : _ENV, cardInfo, isAutoPlay, isTheLast, isTheFirst, uis
    OpenWindow("CardGetShowWindow", UILayer.HUD, cardInfo.id, true, nil, isAutoPlay, cardInfo.isHave, cardInfo.picesNum, isTheLast, isTheFirst)
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (uis.VideoLoader).visible = false
  end
, function(...)
    -- function num : 0_11_1 , upvalues : _ENV, uis, UI_LOTTERY_REWARD_TEXT, UI_LOTTERY_REWARD_END
    (SimpleTimer.setTimeout)(0.05, function(...)
      -- function num : 0_11_1_0 , upvalues : uis, UI_LOTTERY_REWARD_TEXT, UI_LOTTERY_REWARD_END
      -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

      ((uis.StartWord).root).visible = false
      UI_LOTTERY_REWARD_TEXT:SetActive(false)
      UI_LOTTERY_REWARD_END:SetActive(false)
    end
)
  end
)
      -- DECOMPILER ERROR at PC33: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (uis.VideoLoader).visible = true
      ;
      (((uis.GechaCardEffectGrp).EffcetLoader).onClick):ClearCallFunc()
      ;
      (((uis.GechaCardEffectGrp).EffcetLoader).onClick):Add(function(...)
    -- function num : 0_11_2 , upvalues : cardInfo, video, uis, _ENV
    if cardInfo.isHave then
      video:StopVideo(uis.VideoLoader, true)
    else
      print("第一次获得  不能跳过timeline")
    end
  end
)
      ;
      (((uis.GechaCardEffectGrp).SkipBtn).onClick):ClearCallFunc()
      ;
      (((uis.GechaCardEffectGrp).SkipBtn).onClick):Add(function(...)
    -- function num : 0_11_3 , upvalues : isAutoPlay, uis, cardInfo, video, _ENV
    isAutoPlay = true
    -- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((uis.GechaCardEffectGrp).SkipBtn).visible = false
    if cardInfo.isHave then
      video:StopVideo(uis.VideoLoader, true)
    else
      print("第一次获得  不能跳过timeline")
    end
  end
)
    else
      print("已获得 并且开启自动跳过timeline")
      OpenWindow("CardGetShowWindow", UILayer.HUD, cardInfo.id, true, nil, isAutoPlay, cardInfo.isHave, cardInfo.picesNum, isTheLast, isTheFirst)
    end
  else
    local moveConfig = ((TableData.gTable).BaseLotteryCameraShowData)[cardExcelData.lottery_camera_id]
    OpenWindow("CardGetShowWindow", UILayer.HUD, cardInfo.id, true, nil, isAutoPlay, cardInfo.isHave, cardInfo.picesNum, isTheLast, isTheFirst)
    -- DECOMPILER ERROR at PC94: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((uis.StartWord).root).visible = false
  end
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

LotteryWindow.BubbleSortGoods = function(tab, ...)
  -- function num : 0_12
  local length = #tab
  for i = 1, #tab do
    for j = i + 1, #tab do
      if (tab[i]).id == (tab[j]).id and (tab[i]).value < (tab[j]).value then
        tab[i] = tab[j]
      end
    end
  end
  return tab
end

LotteryWindow.SetAssetType = function(...)
  -- function num : 0_13 , upvalues : _ENV, lotteryType, LotteryType, uis
  local moneyTypes = {}
  local excelData = ((TableData.gTable).BaseLotteryShowData)[lotteryType]
  local assetIds = split(excelData.asset_ids, ":")
  for index,value in ipairs(assetIds) do
    (table.insert)(moneyTypes, tonumber(value))
  end
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R3 in 'UnsetPending'

  if lotteryType == LotteryType.Card then
    ((uis.AssetStripGrp).FunctionNameTxt).text = (PUtil.get)(84)
  else
    -- DECOMPILER ERROR at PC45: Confused about usage of register: R3 in 'UnsetPending'

    if lotteryType == LotteryType.Coupon then
      ((uis.AssetStripGrp).FunctionNameTxt).text = (PUtil.get)(85)
    else
      -- DECOMPILER ERROR at PC57: Confused about usage of register: R3 in 'UnsetPending'

      if lotteryType == LotteryType.Equip then
        ((uis.AssetStripGrp).FunctionNameTxt).text = (PUtil.get)(86)
      else
        -- DECOMPILER ERROR at PC69: Confused about usage of register: R3 in 'UnsetPending'

        if lotteryType == LotteryType.Fresh then
          ((uis.AssetStripGrp).FunctionNameTxt).text = (PUtil.get)(184)
        else
          -- DECOMPILER ERROR at PC81: Confused about usage of register: R3 in 'UnsetPending'

          if lotteryType == LotteryType.ShilianBiChu then
            ((uis.AssetStripGrp).FunctionNameTxt).text = (PUtil.get)(219)
          else
            -- DECOMPILER ERROR at PC93: Confused about usage of register: R3 in 'UnsetPending'

            if lotteryType == LotteryType.HuoDongUp then
              ((uis.AssetStripGrp).FunctionNameTxt).text = (PUtil.get)(220)
            else
              -- DECOMPILER ERROR at PC105: Confused about usage of register: R3 in 'UnsetPending'

              if lotteryType == LotteryType.HuoDongUp2 then
                ((uis.AssetStripGrp).FunctionNameTxt).text = (PUtil.get)(220)
              else
              end
            end
          end
        end
      end
    end
  end
  if lotteryType == LotteryType.Other then
    (CommonWinMgr.ChangeAssetsType)((WinResConfig.LotteryWindow).name, moneyTypes)
  end
end

return LotteryWindow

