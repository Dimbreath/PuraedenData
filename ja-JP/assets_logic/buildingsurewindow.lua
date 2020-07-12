-- params : ...
-- function num : 0 , upvalues : _ENV
require("AdventureGame_BuildingSureWindowByName")
local BuildingSureWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
BuildingSureWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, BuildingSureWindow
  bridgeObj:SetView((WinResConfig.BuildingSureWindow).package, (WinResConfig.BuildingSureWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetAdventureGame_BuildingSureWindowUis(contentPane)
  ;
  (BuildingSureWindow.InitVariable)()
  ;
  (BuildingSureWindow.InitText)()
  ;
  (BuildingSureWindow.InitButtonEvent)()
end

BuildingSureWindow.InitVariable = function(...)
  -- function num : 0_1
end

BuildingSureWindow.InitText = function(...)
  -- function num : 0_2 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.BuildingSureGrp).TitleTxt).text = (PUtil.get)(60000444)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.BuildingSureGrp).SureBtn).text = (PUtil.get)(60000004)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.BuildingSureGrp).CancelBtn).text = (PUtil.get)(60000005)
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.BuildingSureGrp).RateWord_A_Txt).text = (PUtil.get)(60000429)
end

BuildingSureWindow.InitButtonEvent = function(...)
  -- function num : 0_3 , upvalues : uis, BuildingSureWindow
  (((uis.BuildingSureGrp).CloseBtn).onClick):Add(BuildingSureWindow.ClickCloseBtn)
  ;
  (((uis.BuildingSureGrp).SureBtn).onClick):Add(BuildingSureWindow.ClickConfirmBtn)
  ;
  (((uis.BuildingSureGrp).CancelBtn).onClick):Add(BuildingSureWindow.ClickCloseBtn)
end

BuildingSureWindow.InitEvent = function(...)
  -- function num : 0_4
end

BuildingSureWindow.RemoveEvent = function(...)
  -- function num : 0_5
end

BuildingSureWindow.OnShown = function(...)
  -- function num : 0_6 , upvalues : BuildingSureWindow
  (BuildingSureWindow.InitEvent)()
  ;
  (BuildingSureWindow.Init)()
end

BuildingSureWindow.OnHide = function(...)
  -- function num : 0_7
end

BuildingSureWindow.Init = function(...)
  -- function num : 0_8 , upvalues : _ENV, argTable, uis
  local originCard = (CardData.GetCardData)(argTable[1])
  ;
  (Util.SetHeadFrame)(((uis.BuildingSureGrp).Head_A_Grp).root, originCard)
  local replaceCard = (CardData.GetCardData)(argTable[2])
  ;
  (Util.SetHeadFrame)(((uis.BuildingSureGrp).Head_B_Grp).root, replaceCard)
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R2 in 'UnsetPending'

  if argTable[3] ~= argTable[4] then
    (((uis.BuildingSureGrp).ArrowNumberGrp).root).visible = true
    -- DECOMPILER ERROR at PC40: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (((uis.BuildingSureGrp).ArrowNumberGrp).NumberTxt).text = (string.format)("%d", argTable[4]) .. "%"
    -- DECOMPILER ERROR at PC48: Confused about usage of register: R2 in 'UnsetPending'

    if argTable[4] < argTable[3] then
      (((uis.BuildingSureGrp).ArrowNumberGrp).c1Ctr).selectedIndex = 1
    else
      -- DECOMPILER ERROR at PC53: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (((uis.BuildingSureGrp).ArrowNumberGrp).c1Ctr).selectedIndex = 0
    end
  else
    -- DECOMPILER ERROR at PC58: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (((uis.BuildingSureGrp).ArrowNumberGrp).root).visible = false
  end
  -- DECOMPILER ERROR at PC68: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((uis.BuildingSureGrp).RateNumber_A_Txt).text = (string.format)("%d", argTable[3]) .. "%"
end

BuildingSureWindow.OnClose = function(...)
  -- function num : 0_9 , upvalues : BuildingSureWindow, uis, contentPane, argTable
  (BuildingSureWindow.RemoveEvent)()
  uis = nil
  contentPane = nil
  argTable = {}
end

BuildingSureWindow.ClickConfirmBtn = function(...)
  -- function num : 0_10 , upvalues : argTable, BuildingSureWindow
  (argTable[5])()
  ;
  (BuildingSureWindow.ClickCloseBtn)()
end

BuildingSureWindow.ClickCloseBtn = function(...)
  -- function num : 0_11 , upvalues : _ENV
  UIMgr:CloseWindow((WinResConfig.BuildingSureWindow).name)
end

BuildingSureWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_12
end

return BuildingSureWindow

