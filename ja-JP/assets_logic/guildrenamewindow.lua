-- params : ...
-- function num : 0 , upvalues : _ENV
require("Guild_RenameWindowByName")
local GuildRenameWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
GuildRenameWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, GuildRenameWindow
  bridgeObj:SetView((WinResConfig.GuildRenameWindow).package, (WinResConfig.GuildRenameWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetGuild_RenameWindowUis(contentPane)
  ;
  (GuildRenameWindow.InitVariable)()
  ;
  (GuildRenameWindow.InitText)()
  ;
  (GuildRenameWindow.InitButtonEvent)()
end

GuildRenameWindow.InitVariable = function(...)
  -- function num : 0_1
end

GuildRenameWindow.InitText = function(...)
  -- function num : 0_2 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R0 in 'UnsetPending'

  (((uis.RenameGrp).InputNameTxt).inputTextField).RestrictRow = 0
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.RenameGrp).InputNameTxt).inputTextField).promptText = "[color=" .. Const.GrayColor .. "]" .. (PUtil.get)(60000456) .. "[/color]"
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.RenameGrp).titilenameTxt).text = (PUtil.get)(60000286)
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.RenameGrp).SureBtn).text = (PUtil.get)(60000004)
  -- DECOMPILER ERROR at PC38: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.RenameGrp).WordTxt).text = (PUtil.get)(60000496)
end

GuildRenameWindow.InitButtonEvent = function(...)
  -- function num : 0_3 , upvalues : uis, GuildRenameWindow
  (((uis.RenameGrp).SureBtn).onClick):Add(GuildRenameWindow.ClickRenameBtn)
  ;
  (((uis.RenameGrp).CloseBtn).onClick):Add(GuildRenameWindow.ClickCloseBtn)
end

GuildRenameWindow.InitEvent = function(...)
  -- function num : 0_4
end

GuildRenameWindow.RemoveEvent = function(...)
  -- function num : 0_5
end

GuildRenameWindow.OnShown = function(...)
  -- function num : 0_6 , upvalues : GuildRenameWindow
  (GuildRenameWindow.InitEvent)()
  ;
  (GuildRenameWindow.Init)()
end

GuildRenameWindow.OnHide = function(...)
  -- function num : 0_7
end

GuildRenameWindow.Init = function(...)
  -- function num : 0_8 , upvalues : GuildRenameWindow
  (GuildRenameWindow.InitRenameCost)()
end

GuildRenameWindow.OnClose = function(...)
  -- function num : 0_9 , upvalues : GuildRenameWindow, uis, contentPane, argTable
  (GuildRenameWindow.RemoveEvent)()
  uis = nil
  contentPane = nil
  argTable = {}
end

GuildRenameWindow.InitRenameCost = function(...)
  -- function num : 0_10 , upvalues : _ENV, uis
  (Util.SetCurrencyWithConfig)((((TableData.gTable).BaseFixedData)[GuildData.MODIFY_NAME_COST]).array_value, (uis.RenameGrp).SpendLoader, (uis.RenameGrp).SpendTxt)
end

GuildRenameWindow.ClickRenameBtn = function(...)
  -- function num : 0_11 , upvalues : _ENV, uis
  (GuildMgr.ReqChangeGuildName)(((uis.RenameGrp).InputNameTxt).text)
end

GuildRenameWindow.ClickCloseBtn = function(...)
  -- function num : 0_12 , upvalues : _ENV
  UIMgr:CloseWindow((WinResConfig.GuildRenameWindow).name)
end

GuildRenameWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_13
end

return GuildRenameWindow

