-- params : ...
-- function num : 0 , upvalues : _ENV
require("Card_StarUpPropertyByName")
local StarUpPropertyWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
StarUpPropertyWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, StarUpPropertyWindow
  bridgeObj:SetView((WinResConfig.StarUpPropertyWindow).package, (WinResConfig.StarUpPropertyWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  contentPane:Center()
  uis = GetCard_StarUpPropertyUis(contentPane)
  ;
  (LuaSound.PlaySound)(LuaSound.COMMON_SHOW_REWARD, SoundBank.OTHER)
  ;
  (StarUpPropertyWindow.InitVariable)()
  ;
  (StarUpPropertyWindow.InitText)()
  ;
  (StarUpPropertyWindow.InitButtonEvent)()
  ;
  (GuideData.RegisterGuideAndControl)(ControlID.Wake_Sure, uis.TouchScreenBtn, (WinResConfig.StarUpPropertyWindow).name)
  local holder = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_UNLOCK_PANEL, true)
  holder:SetXY(((uis.ResultImageGrp).root).x + ((uis.ResultImageGrp).root).width * 0.5, ((uis.ResultImageGrp).root).y + ((uis.ResultImageGrp).root).height * 0.5)
  contentPane:AddChild(holder)
end

StarUpPropertyWindow.InitVariable = function(...)
  -- function num : 0_1
end

StarUpPropertyWindow.InitText = function(...)
  -- function num : 0_2 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  (uis.ALLTxt).text = (PUtil.get)(60000386)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.TipsTxt).text = (PUtil.get)(33)
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.PowerWordTxt).text = (PUtil.get)(60000235)
end

StarUpPropertyWindow.InitButtonEvent = function(...)
  -- function num : 0_3 , upvalues : uis, StarUpPropertyWindow
  ((uis.TouchScreenBtn).onClick):Add(StarUpPropertyWindow.ClickBlankBtn)
end

StarUpPropertyWindow.InitEvent = function(...)
  -- function num : 0_4
end

StarUpPropertyWindow.RemoveEvent = function(...)
  -- function num : 0_5
end

StarUpPropertyWindow.OnShown = function(...)
  -- function num : 0_6 , upvalues : StarUpPropertyWindow
  (StarUpPropertyWindow.InitEvent)()
  ;
  (StarUpPropertyWindow.Init)()
end

StarUpPropertyWindow.OnHide = function(...)
  -- function num : 0_7 , upvalues : StarUpPropertyWindow
  (StarUpPropertyWindow.RemoveEvent)()
end

StarUpPropertyWindow.Init = function(...)
  -- function num : 0_8 , upvalues : _ENV, uis, contentPane, argTable
  (Util.PlayUIEffect)(uis, contentPane, 1)
  ;
  (uis.StarList):RemoveChildrenToPool()
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.TipsTxt).text = (PUtil.get)(33)
  local count = (CardData.CurrentCardInfo).star
  ;
  (LuaSound.PlaySound)(LuaSound.COMMON_SHOW_REWARD, SoundBank.OTHER)
  for i = 1, count do
    local item = (uis.StarList):AddItemFromPool()
    do
      if i == count then
        (SimpleTimer.setTimeout)(0.02, function(...)
    -- function num : 0_8_0 , upvalues : _ENV, contentPane, item, uis, count
    local holder = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_STAR, true)
    contentPane:AddChild(holder)
    local pos = {x = 0, y = 0}
    local starWidth = (item.width + (uis.StarList).lineGap) * count - (uis.StarList).lineGap
    pos.x = (item.parent).x + ((uis.StarList).width - starWidth) * 0.5 + starWidth - item.width * 0.5
    pos.y = (item.parent).y + (uis.StarList).height * 0.5
    holder:SetXY(pos.x, pos.y)
  end
)
      end
    end
  end
  local numTxt = uis.PowerNumberTxt
  local cardId = (CardData.CurrentCardInfo).id
  local fcChangeInfo = (CardData.fcChangeList)[cardId]
  if fcChangeInfo then
    numTxt.text = fcChangeInfo.preFc
    ;
    (SimpleTimer.setTimeout)(0.5, function(...)
    -- function num : 0_8_1 , upvalues : fcChangeInfo, _ENV, numTxt
    if fcChangeInfo then
      ((LeanTween.value)(fcChangeInfo.preFc, fcChangeInfo.newFc, 0.4)):setOnUpdate(function(value, ...)
      -- function num : 0_8_1_0 , upvalues : numTxt, _ENV
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
  local count = #CardData.StarUpProperty
  local config = nil
  for i = 1, count do
    config = ((TableData.gTable).BaseAttributeData)[(CardData.StarUpProperty)[i]]
    local name = config.name
    name = (string.gsub)(name, "max_", "")
    -- DECOMPILER ERROR at PC86: Confused about usage of register: R11 in 'UnsetPending'

    ;
    (uis[name:upper() .. "Txt"]).text = config.display_name
    -- DECOMPILER ERROR at PC94: Confused about usage of register: R11 in 'UnsetPending'

    ;
    (uis[name:upper() .. "Number_01_Txt"]).text = (argTable[1])[name]
    -- DECOMPILER ERROR at PC102: Confused about usage of register: R11 in 'UnsetPending'

    ;
    (uis[name:upper() .. "Number_02_Txt"]).text = (argTable[2])[name]
  end
  config = ((TableData.gTable).BaseCardStarUpData)[(argTable[2]).id * 100 + (argTable[2]).star]
  local teamBuff = (split(config.team_add_attr, ","))
  local data = nil
  local str = ""
  count = #teamBuff
  for i = 1, count do
    data = split(teamBuff[i], ":")
    config = ((TableData.gTable).BaseAttributeData)[tonumber(data[2])]
    str = str .. config.display_name .. data[3]
    if i ~= count then
      str = str .. (PUtil.get)(60000387)
    end
  end
  -- DECOMPILER ERROR at PC151: Confused about usage of register: R9 in 'UnsetPending'

  ;
  (uis.ALLNumber_01_Txt).text = str
end

StarUpPropertyWindow.ClickBlankBtn = function(...)
  -- function num : 0_9 , upvalues : _ENV, argTable
  local config = ((TableData.gTable).BaseCardStarUpData)[(argTable[2]).id * 100 + (argTable[2]).star]
  UIMgr:CloseWindow((WinResConfig.StarUpPropertyWindow).name)
  if config.skill_level_number ~= 0 then
    (CardData.SaveHowManySkillGetFromQ)({(CardData.CurrentCardInfo)["passiveSkillId" .. config.skill_level_number]})
    ;
    (CardData.SaveHowManyFashionGetFromQ)({})
    OpenWindow((WinResConfig.SkillGetGrpWindow).name, UILayer.HUD, (CardData.CurrentCardInfo).id)
  else
    UIMgr:SendWindowMessage((WinResConfig.CardWindow).name, (WindowMsgEnum.CardWindow).E_MSG_CARD_STAR_UP_EFFECT)
    ;
    (CommonWinMgr.OpenCommonFcUp)((CardData.CurrentCardInfo).id)
    UIMgr:SendWindowMessage("CardWindow", (WindowMsgEnum.CardWindow).E_MSG_CARD_STARUP_TRUE, {})
  end
end

StarUpPropertyWindow.OnClose = function(...)
  -- function num : 0_10 , upvalues : uis, contentPane, _ENV
  uis = nil
  contentPane = nil
  ;
  (GuideData.AbolishControlRefer)((WinResConfig.StarUpPropertyWindow).name)
end

StarUpPropertyWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_11
end

return StarUpPropertyWindow

