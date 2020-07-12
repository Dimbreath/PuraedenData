-- params : ...
-- function num : 0 , upvalues : _ENV
require("Card_StageUpPropertyByName")
StageUpPropertyWindow = {}
local uis = nil
local paraData = {}
local contentPane = nil
-- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

StageUpPropertyWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, uis
  bridgeObj:SetView((WinResConfig.StageUpPropertyWindow).package, (WinResConfig.StageUpPropertyWindow).comName)
  contentPane = bridgeObj.contentPane
  contentPane:Center()
  uis = GetCard_StageUpPropertyUis(contentPane)
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.AttackTxt).text = (PUtil.get)(6)
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.DefenseTxt).text = (PUtil.get)(1)
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.HpTxt).text = (PUtil.get)(35)
  -- DECOMPILER ERROR at PC40: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.SpeedTxt).text = (PUtil.get)(36)
  -- DECOMPILER ERROR at PC46: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.MfTxt).text = (PUtil.get)(55)
  -- DECOMPILER ERROR at PC52: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.TipsTxt).text = (PUtil.get)(33)
  -- DECOMPILER ERROR at PC58: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.PowerWordTxt).text = (PUtil.get)(7)
  ;
  (LuaSound.PlaySound)(LuaSound.COMMON_SHOW_REWARD, SoundBank.OTHER)
  ;
  (GuideData.RegisterGuideAndControl)(ControlID.Break_Sure, uis.TouchScreenBtn, (WinResConfig.StageUpPropertyWindow).name)
  ;
  ((uis.TouchScreenBtn).onClick):Add(function(...)
    -- function num : 0_0_0 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.StageUpPropertyWindow).name)
  end
)
  local holder = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_UNLOCK_PANEL, true)
  holder:SetXY(((uis.ResultImageGrp).root).x + ((uis.ResultImageGrp).root).width * 0.5, ((uis.ResultImageGrp).root).y + ((uis.ResultImageGrp).root).height * 0.5)
  contentPane:AddChild(holder)
end

-- DECOMPILER ERROR at PC13: Confused about usage of register: R3 in 'UnsetPending'

StageUpPropertyWindow.RefreshWindowData = function(data, ...)
  -- function num : 0_1 , upvalues : _ENV, uis, contentPane, paraData
  (Util.PlayUIEffect)(uis, contentPane, 1)
  paraData = {}
  paraData = data
  local cardData = data.cardData
  local upStageData = data.upStageData
  local preUpStageData = (CardMgr.GetBaseCardQualityData)(upStageData.quality, upStageData.id)
  local levelShow = split(preUpStageData.level_show, ":")
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (uis.c1Ctr).selectedIndex = tonumber(levelShow[1])
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (uis.StageNumberTxt).text = upStageData.quality
  local numTxt = uis.PowerNumberTxt
  local cardId = cardData.id
  local fcChangeInfo = (CardData.fcChangeList)[cardId]
  if fcChangeInfo then
    (LeanTween.delayedCall)(0.1, function(...)
    -- function num : 0_1_0 , upvalues : fcChangeInfo, _ENV, numTxt
    if fcChangeInfo then
      ((LeanTween.value)(fcChangeInfo.preFc, fcChangeInfo.newFc, 0.4)):setOnUpdate(function(value, ...)
      -- function num : 0_1_0_0 , upvalues : numTxt, _ENV
      if numTxt then
        local num = (math.ceil)(value)
        numTxt.text = num
      end
    end
)
    end
  end
)
  end
  -- DECOMPILER ERROR at PC42: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (uis.AttackNumber_01_Txt).text = cardData.atk
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (uis.AttackNumber_02_Txt).text = upStageData.atk
  -- DECOMPILER ERROR at PC48: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (uis.DefenseNumber_01_Txt).text = cardData.def
  -- DECOMPILER ERROR at PC51: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (uis.DefenseNumber_02_Txt).text = upStageData.def
  -- DECOMPILER ERROR at PC54: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (uis.HpNumber_01_Txt).text = cardData.hp
  -- DECOMPILER ERROR at PC57: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (uis.HpNumber_02_Txt).text = upStageData.hp
  -- DECOMPILER ERROR at PC60: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (uis.SpeedNumber_01_Txt).text = cardData.spd
  -- DECOMPILER ERROR at PC63: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (uis.SpeedNumber_02_Txt).text = upStageData.spd
  -- DECOMPILER ERROR at PC66: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (uis.MfNumber_01_Txt).text = cardData.luck
  -- DECOMPILER ERROR at PC69: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (uis.MfNumber_02_Txt).text = upStageData.luck
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R3 in 'UnsetPending'

StageUpPropertyWindow.OnClose = function(...)
  -- function num : 0_2 , upvalues : _ENV, paraData, uis, contentPane
  local fashionTable = (CardData.GetHowManyFashionGetFromQ)()
  local skillTable = (CardData.GetHowManySkillGetFromQ)()
  if #skillTable > 0 then
    OpenWindow("SkillGetGrpWindow", UILayer.HUD, (paraData.cardData).id)
  else
    if #fashionTable > 0 then
      OpenWindow("NewCardGetWindow", UILayer.HUD, (paraData.cardData).id, fashionTable)
    else
      print("CommonWinMgr.OpenCommonFcUp(paraData.cardData.id)", (paraData.cardData).id)
      ;
      (CommonWinMgr.OpenCommonFcUp)((paraData.cardData).id)
      UIMgr:SendWindowMessage("CardWindow", (WindowMsgEnum.CardWindow).E_MSG_CARD_STAGEUP_TRUE, {})
    end
  end
  uis = nil
  paraData = {}
  contentPane = nil
  ;
  (GuideData.AbolishControlRefer)((WinResConfig.StageUpPropertyWindow).name)
end

-- DECOMPILER ERROR at PC19: Confused about usage of register: R3 in 'UnsetPending'

StageUpPropertyWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_3 , upvalues : _ENV
  local windowMsgEnum = WindowMsgEnum.CardWindow
  if msgId == windowMsgEnum.E_MSG_CARD_STAGEUPPROPERTY then
    (StageUpPropertyWindow.RefreshWindowData)(para)
  end
end

-- DECOMPILER ERROR at PC22: Confused about usage of register: R3 in 'UnsetPending'

StageUpPropertyWindow.PlayUIEffect = function(...)
  -- function num : 0_4 , upvalues : _ENV, uis, contentPane
  local holder = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_UNLOCK, true)
  holder:SetXY(((uis.ResultImageGrp).root).x + ((uis.ResultImageGrp).root).width * 0.5, ((uis.ResultImageGrp).root).y)
  contentPane:AddChild(holder)
end

return StageUpPropertyWindow

