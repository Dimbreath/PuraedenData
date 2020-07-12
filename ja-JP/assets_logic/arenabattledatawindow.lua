-- params : ...
-- function num : 0 , upvalues : _ENV
require("Arena_BattleDataByName")
local ArenaBattleDataWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
ArenaBattleDataWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, ArenaBattleDataWindow
  bridgeObj:SetView((WinResConfig.ArenaBattleDataWindow).package, (WinResConfig.ArenaBattleDataWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  contentPane:Center()
  uis = GetArena_BattleDataUis(contentPane)
  ;
  (ArenaBattleDataWindow.InitVariable)()
  ;
  (ArenaBattleDataWindow.InitText)()
  ;
  (ArenaBattleDataWindow.InitButtonEvent)()
end

ArenaBattleDataWindow.InitVariable = function(...)
  -- function num : 0_1
end

ArenaBattleDataWindow.InitText = function(...)
  -- function num : 0_2
end

ArenaBattleDataWindow.InitButtonEvent = function(...)
  -- function num : 0_3
end

ArenaBattleDataWindow.InitEvent = function(...)
  -- function num : 0_4
end

ArenaBattleDataWindow.RemoveEvent = function(...)
  -- function num : 0_5
end

ArenaBattleDataWindow.OnShown = function(...)
  -- function num : 0_6 , upvalues : ArenaBattleDataWindow
  (ArenaBattleDataWindow.InitEvent)()
  ;
  (ArenaBattleDataWindow.Init)()
end

ArenaBattleDataWindow.OnHide = function(...)
  -- function num : 0_7 , upvalues : ArenaBattleDataWindow
  (ArenaBattleDataWindow.RemoveEvent)()
end

ArenaBattleDataWindow.Init = function(...)
  -- function num : 0_8
end

ArenaBattleDataWindow.OnClose = function(...)
  -- function num : 0_9 , upvalues : uis, contentPane
  uis = nil
  contentPane = nil
end

ArenaBattleDataWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_10
end

return ArenaBattleDataWindow

