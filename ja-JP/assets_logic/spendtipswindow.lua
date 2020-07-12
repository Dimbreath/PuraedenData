-- params : ...
-- function num : 0 , upvalues : _ENV
require("Message_SpendTipsWindowByName")
local SpendTipsWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
SpendTipsWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, SpendTipsWindow
  bridgeObj:SetView((WinResConfig.SpendTipsWindow).package, (WinResConfig.SpendTipsWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetMessage_SpendTipsWindowUis(contentPane)
  ;
  (SpendTipsWindow.InitVariable)()
  ;
  (SpendTipsWindow.InitText)()
  ;
  (SpendTipsWindow.InitButtonEvent)()
end

SpendTipsWindow.InitVariable = function(...)
  -- function num : 0_1
end

SpendTipsWindow.InitText = function(...)
  -- function num : 0_2 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.SpendTips).TitleTxt).text = (PUtil.get)(60000481)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.SpendTips).TipsTxt).text = (PUtil.get)(60000482)
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.SpendTips).SpendA).SpendNameTxt).text = (PUtil.get)(60000483)
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.SpendTips).SpendB).SpendNameTxt).text = (PUtil.get)(60000483)
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.SpendTips).SureBtn).text = (PUtil.get)(60000004)
  -- DECOMPILER ERROR at PC43: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.SpendTips).BattleOutBtn).text = (PUtil.get)(60000005)
end

SpendTipsWindow.InitButtonEvent = function(...)
  -- function num : 0_3 , upvalues : uis, SpendTipsWindow
  (((uis.SpendTips).CloseBtn).onClick):Set(SpendTipsWindow.ClickCloseBtn)
  ;
  (((uis.SpendTips).ChoiceBtn).onClick):Set(SpendTipsWindow.ClickTipsBtn)
  ;
  (((uis.SpendTips).SureBtn).onClick):Set(SpendTipsWindow.ClickSureBtn)
  ;
  (((uis.SpendTips).BattleOutBtn).onClick):Set(SpendTipsWindow.ClickCancelBtn)
end

SpendTipsWindow.OnShown = function(...)
  -- function num : 0_4 , upvalues : SpendTipsWindow
  (SpendTipsWindow.Init)()
end

SpendTipsWindow.OnHide = function(...)
  -- function num : 0_5
end

SpendTipsWindow.OnClose = function(...)
  -- function num : 0_6 , upvalues : uis, contentPane, argTable
  uis = nil
  contentPane = nil
  argTable = {}
end

SpendTipsWindow.Init = function(...)
  -- function num : 0_7 , upvalues : uis, argTable, SpendTipsWindow
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.SpendTips).WordTxt).text = argTable[1]
  ;
  (SpendTipsWindow.RefreshCostInfo)()
end

SpendTipsWindow.RefreshCostInfo = function(...)
  -- function num : 0_8 , upvalues : argTable, uis, SpendTipsWindow
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

  if #argTable[2] == 1 then
    (((uis.SpendTips).SpendB).root).visible = false
    ;
    (SpendTipsWindow.SetSingleCost)((uis.SpendTips).SpendA, (argTable[2])[1])
  else
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (((uis.SpendTips).SpendB).root).visible = true
    ;
    (SpendTipsWindow.SetSingleCost)((uis.SpendTips).SpendA, (argTable[2])[1])
    ;
    (SpendTipsWindow.SetSingleCost)((uis.SpendTips).SpendB, (argTable[2])[2])
  end
end

SpendTipsWindow.SetSingleCost = function(com, cost, ...)
  -- function num : 0_9 , upvalues : _ENV
  PrintTable(cost)
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (com.HaveLoader).url = (Util.GetUrlFromItemID)(cost.Id, cost.Type)
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (com.SpendLoader).url = (Util.GetUrlFromItemID)(cost.Id, cost.Type)
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (com.SurplusLoader).url = (Util.GetUrlFromItemID)(cost.Id, cost.Type)
  local have = (ActorData.GetGoodsCount)(cost.Id, cost.Type)
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (com.HaveTxt).text = have
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (com.SpendTxt).text = cost.Amount
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (com.SurplusTxt).text = have - cost.Amount
end

SpendTipsWindow.ClickSureBtn = function(...)
  -- function num : 0_10 , upvalues : uis, _ENV, argTable
  if ((uis.SpendTips).ChoiceBtn).selected then
    (Util.SetPlayerSetting)(PlayerPrefsKeyName.IGNORE_DIAMOND_CONSUM_TIPS, "1")
  else
    ;
    (Util.SetPlayerSetting)(PlayerPrefsKeyName.IGNORE_DIAMOND_CONSUM_TIPS, "0")
  end
  UIMgr:CloseWindow((WinResConfig.SpendTipsWindow).name)
  UIMgr:HideGrabBloom((uis.root).displayObject)
  if argTable[3] ~= nil then
    (argTable[3])()
  end
end

SpendTipsWindow.ClickCancelBtn = function(...)
  -- function num : 0_11 , upvalues : _ENV, argTable
  UIMgr:CloseWindow((WinResConfig.SpendTipsWindow).name)
  if argTable[4] ~= nil then
    (argTable[4])()
  end
end

SpendTipsWindow.ClickCloseBtn = function(...)
  -- function num : 0_12 , upvalues : _ENV, argTable
  UIMgr:CloseWindow((WinResConfig.SpendTipsWindow).name)
  if argTable[4] ~= nil then
    (argTable[4])()
  end
end

SpendTipsWindow.ClickTipsBtn = function(...)
  -- function num : 0_13
end

SpendTipsWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_14
end

return SpendTipsWindow

