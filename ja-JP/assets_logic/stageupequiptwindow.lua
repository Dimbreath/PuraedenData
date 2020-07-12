-- params : ...
-- function num : 0 , upvalues : _ENV
require("Card_StageUpEquiptByName")
local StageUpEquiptWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
StageUpEquiptWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, StageUpEquiptWindow
  bridgeObj:SetView((WinResConfig.StageUpEquiptWindow).package, (WinResConfig.StageUpEquiptWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  contentPane:Center()
  uis = GetCard_StageUpEquiptUis(contentPane)
  ;
  (StageUpEquiptWindow.InitVariable)()
  ;
  (StageUpEquiptWindow.InitText)()
  ;
  (StageUpEquiptWindow.InitButtonEvent)()
  ;
  (StageUpEquiptWindow.InitUIEffect)()
end

StageUpEquiptWindow.InitVariable = function(...)
  -- function num : 0_1
end

StageUpEquiptWindow.InitText = function(...)
  -- function num : 0_2
end

StageUpEquiptWindow.InitButtonEvent = function(...)
  -- function num : 0_3 , upvalues : uis, StageUpEquiptWindow
  ((uis.TouchScreenBtn).onClick):Add(StageUpEquiptWindow.ClickBlankBtn)
end

StageUpEquiptWindow.InitEvent = function(...)
  -- function num : 0_4
end

StageUpEquiptWindow.RemoveEvent = function(...)
  -- function num : 0_5
end

StageUpEquiptWindow.OnShown = function(...)
  -- function num : 0_6 , upvalues : StageUpEquiptWindow
  (StageUpEquiptWindow.InitEvent)()
  ;
  (StageUpEquiptWindow.Init)()
end

StageUpEquiptWindow.OnHide = function(...)
  -- function num : 0_7 , upvalues : StageUpEquiptWindow
  (StageUpEquiptWindow.RemoveEvent)()
end

StageUpEquiptWindow.InitUIEffect = function(...)
  -- function num : 0_8 , upvalues : _ENV, uis, contentPane
  local holder = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_UNLOCK, true)
  holder:SetXY((uis.Decorate_11_Image).x + (uis.Decorate_11_Image).width * 0.5, (uis.Decorate_11_Image).y + (uis.Decorate_11_Image).height * 0.5)
  contentPane:AddChild(holder)
end

StageUpEquiptWindow.Init = function(...)
  -- function num : 0_9 , upvalues : uis, _ENV, argTable
  (((uis.EquiptIconBigGrp).root):GetController("c3")).selectedIndex = 1
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.EquiptIconBigGrp).NameTxt).text = (EquiptData.GetPartName)(argTable[2])
end

StageUpEquiptWindow.OnClose = function(...)
  -- function num : 0_10 , upvalues : _ENV, uis, contentPane
  UIMgr:SendWindowMessage((WinResConfig.CardWindow).name, (WindowMsgEnum.CardWindow).E_MSG_CARD_STAR_UP_EFFECT)
  ;
  (CommonWinMgr.OpenCommonFcUp)((CardData.CurrentCardInfo).id)
  uis = nil
  contentPane = nil
end

StageUpEquiptWindow.ClickBlankBtn = function(...)
  -- function num : 0_11 , upvalues : _ENV
  UIMgr:CloseWindow((WinResConfig.StageUpEquiptWindow).name)
end

StageUpEquiptWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_12
end

return StageUpEquiptWindow

