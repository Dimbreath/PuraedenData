-- params : ...
-- function num : 0 , upvalues : _ENV
require("Guild_DissolutionWindowByName")
local GuildDissolveWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
GuildDissolveWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, GuildDissolveWindow
  bridgeObj:SetView((WinResConfig.GuildDissolveWindow).package, (WinResConfig.GuildDissolveWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetGuild_DissolutionWindowUis(contentPane)
  ;
  (GuildDissolveWindow.InitVariable)()
  ;
  (GuildDissolveWindow.InitText)()
  ;
  (GuildDissolveWindow.InitButtonEvent)()
end

GuildDissolveWindow.InitVariable = function(...)
  -- function num : 0_1
end

GuildDissolveWindow.InitText = function(...)
  -- function num : 0_2 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.DissolutionTipsGrp).titilenameTxt).text = (PUtil.get)(60000287)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.DissolutionTipsGrp).WordTxt).text = (PUtil.get)(60000288)
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.DissolutionTipsGrp).InputNameTxt).promptText = "[color=" .. Const.GrayColor .. "]" .. (PUtil.get)(60000495) .. "[/color]"
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.DissolutionTipsGrp).SureBtn).text = (PUtil.get)(60000004)
end

GuildDissolveWindow.InitButtonEvent = function(...)
  -- function num : 0_3 , upvalues : uis, GuildDissolveWindow
  (((uis.DissolutionTipsGrp).SureBtn).onClick):Add(GuildDissolveWindow.ClickConfirmBtn)
  ;
  (((uis.DissolutionTipsGrp).CloseBtn).onClick):Add(GuildDissolveWindow.ClickCloseBtn)
end

GuildDissolveWindow.InitEvent = function(...)
  -- function num : 0_4
end

GuildDissolveWindow.RemoveEvent = function(...)
  -- function num : 0_5
end

GuildDissolveWindow.OnShown = function(...)
  -- function num : 0_6 , upvalues : GuildDissolveWindow
  (GuildDissolveWindow.InitEvent)()
  ;
  (GuildDissolveWindow.Init)()
end

GuildDissolveWindow.OnHide = function(...)
  -- function num : 0_7
end

GuildDissolveWindow.Init = function(...)
  -- function num : 0_8
end

GuildDissolveWindow.OnClose = function(...)
  -- function num : 0_9 , upvalues : GuildDissolveWindow, uis, contentPane, argTable
  (GuildDissolveWindow.RemoveEvent)()
  uis = nil
  contentPane = nil
  argTable = {}
end

GuildDissolveWindow.ClickCloseBtn = function(...)
  -- function num : 0_10 , upvalues : _ENV
  UIMgr:CloseWindow((WinResConfig.GuildDissolveWindow).name)
end

GuildDissolveWindow.ClickConfirmBtn = function(...)
  -- function num : 0_11 , upvalues : _ENV, uis
  (GuildMgr.ReqDissolveGuild)(((uis.DissolutionTipsGrp).InputNameTxt).text)
end

GuildDissolveWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_12
end

return GuildDissolveWindow

