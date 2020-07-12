-- params : ...
-- function num : 0 , upvalues : _ENV
require("AdventureGame_ControlChoiceWindowByName")
local ControlChoiceWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local _diceBtn = {}
local _selectIndex = 1
ControlChoiceWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, ControlChoiceWindow
  bridgeObj:SetView((WinResConfig.ControlChoiceWindow).package, (WinResConfig.ControlChoiceWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetAdventureGame_ControlChoiceWindowUis(contentPane)
  ;
  (ControlChoiceWindow.InitVariable)()
  ;
  (ControlChoiceWindow.InitText)()
  ;
  (ControlChoiceWindow.InitButtonEvent)()
end

ControlChoiceWindow.InitVariable = function(...)
  -- function num : 0_1 , upvalues : _diceBtn, uis, _ENV
  _diceBtn[1] = (uis.ControlChoiceGrp).OneBtn
  _diceBtn[2] = (uis.ControlChoiceGrp).TwoBtn
  _diceBtn[3] = (uis.ControlChoiceGrp).ThreeBtn
  _diceBtn[4] = (uis.ControlChoiceGrp).FourBtn
  _diceBtn[5] = (uis.ControlChoiceGrp).FiveBtn
  _diceBtn[6] = (uis.ControlChoiceGrp).SixBtn
  for i = 1, AdventureData.MAX_DICE_NUMBER do
    (((_diceBtn[i]):GetChild("n5")):GetController("c1")).selectedIndex = i - 1
  end
end

ControlChoiceWindow.InitText = function(...)
  -- function num : 0_2 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.ControlChoiceGrp).TitleTxt).text = (PUtil.get)(60000465)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.ControlChoiceGrp).SureBtn).text = (PUtil.get)(60000004)
end

ControlChoiceWindow.InitButtonEvent = function(...)
  -- function num : 0_3 , upvalues : uis, ControlChoiceWindow, _ENV, _diceBtn
  (((uis.ControlChoiceGrp).CloseBtn).onClick):Add(ControlChoiceWindow.ClickCloseBtn)
  ;
  (((uis.ControlChoiceGrp).SureBtn).onClick):Add(ControlChoiceWindow.ClickConfirmBtn)
  for i = 1, AdventureData.MAX_DICE_NUMBER do
    local index = i
    do
      ((_diceBtn[i]).onClick):Add(function(...)
    -- function num : 0_3_0 , upvalues : ControlChoiceWindow, index
    (ControlChoiceWindow.ClickDiceBtn)(index)
  end
)
    end
  end
end

ControlChoiceWindow.InitEvent = function(...)
  -- function num : 0_4
end

ControlChoiceWindow.RemoveEvent = function(...)
  -- function num : 0_5
end

ControlChoiceWindow.OnShown = function(...)
  -- function num : 0_6 , upvalues : ControlChoiceWindow
  (ControlChoiceWindow.InitEvent)()
  ;
  (ControlChoiceWindow.Init)()
end

ControlChoiceWindow.OnHide = function(...)
  -- function num : 0_7
end

ControlChoiceWindow.Init = function(...)
  -- function num : 0_8 , upvalues : _selectIndex, ControlChoiceWindow
  _selectIndex = 1
  ;
  (ControlChoiceWindow.RefreshCostInfo)()
end

ControlChoiceWindow.RefreshCostInfo = function(...)
  -- function num : 0_9 , upvalues : _ENV, uis
  local cost = split(AdventureData.CtrlDiceCost, ":")
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  if tonumber(cost[3]) == 0 then
    ((uis.ControlChoiceGrp).Spend_A_Loader).url = nil
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((uis.ControlChoiceGrp).Spend_A_Txt).text = (PUtil.get)(20000281)
  else
    ;
    (Util.SetCurrencyWithConfig)(AdventureData.CtrlDiceCost, (uis.ControlChoiceGrp).Spend_A_Loader, (uis.ControlChoiceGrp).Spend_A_Txt)
  end
end

ControlChoiceWindow.OnClose = function(...)
  -- function num : 0_10 , upvalues : ControlChoiceWindow, uis, contentPane, argTable
  (ControlChoiceWindow.RemoveEvent)()
  uis = nil
  contentPane = nil
  argTable = {}
end

ControlChoiceWindow.ClickCloseBtn = function(...)
  -- function num : 0_11 , upvalues : _ENV
  UIMgr:CloseWindow((WinResConfig.ControlChoiceWindow).name)
end

ControlChoiceWindow.ClickConfirmBtn = function(...)
  -- function num : 0_12 , upvalues : ControlChoiceWindow, _ENV, _selectIndex
  (ControlChoiceWindow.ClickCloseBtn)()
  ;
  (AdventureMgr.PlayCtrlDice)(_selectIndex)
end

ControlChoiceWindow.ClickDiceBtn = function(number, ...)
  -- function num : 0_13 , upvalues : uis, _selectIndex
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  ((uis.ControlChoiceGrp).c1Ctr).selectedIndex = number - 1
  _selectIndex = number
end

ControlChoiceWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_14
end

return ControlChoiceWindow

