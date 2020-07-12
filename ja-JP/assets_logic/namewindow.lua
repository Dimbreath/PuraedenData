-- params : ...
-- function num : 0 , upvalues : _ENV
require("Message_NamingWindowByName")
require("ActorInfoService")
local NameWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local _lastContent = nil
NameWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, NameWindow
  bridgeObj:SetView((WinResConfig.NameWindow).package, (WinResConfig.NameWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetMessage_NamingWindowUis(contentPane)
  ;
  (NameWindow.InitVariable)()
  ;
  (NameWindow.InitText)()
  ;
  (NameWindow.InitButtonEvent)()
  ;
  (NameWindow.ClickRandomBtn)()
  ;
  (LuaSound.PlaySound)(LuaSound.COMMON_POP_WIN, SoundBank.OTHER)
end

NameWindow.InitVariable = function(...)
  -- function num : 0_1 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.NamingGrp).NameTxt).promptText = "[color=" .. Const.GrayColor .. "]" .. (PUtil.get)(60000457) .. "[/color]"
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.NamingGrp).WordTxt).text = (PUtil.get)(60000317, Const.MAX_NAME_LENGTH)
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.NamingGrp).SureBtn).text = (PUtil.get)(60000004)
end

NameWindow.InitText = function(...)
  -- function num : 0_2
end

NameWindow.InitButtonEvent = function(...)
  -- function num : 0_3 , upvalues : uis, NameWindow
  (((uis.NamingGrp).SureBtn).onClick):Set(NameWindow.ClickConfirmBtn)
  ;
  (((uis.NamingGrp).RandomNameBtn).onClick):Set(NameWindow.ClickRandomBtn)
  ;
  (((uis.NamingGrp).NameTxt).onFocusIn):Set(NameWindow.FocusInText)
  ;
  (((uis.NamingGrp).NameTxt).onFocusOut):Set(NameWindow.FocusOutText)
  ;
  (((uis.NamingGrp).NameTxt).onChanged):Set(NameWindow.OnChangedText)
end

NameWindow.InitEvent = function(...)
  -- function num : 0_4
end

NameWindow.RemoveEvent = function(...)
  -- function num : 0_5
end

NameWindow.OnShown = function(...)
  -- function num : 0_6 , upvalues : NameWindow
  (NameWindow.InitEvent)()
  ;
  (NameWindow.Init)()
end

NameWindow.OnHide = function(...)
  -- function num : 0_7
end

NameWindow.Init = function(...)
  -- function num : 0_8 , upvalues : uis, _lastContent
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R0 in 'UnsetPending'

  (((uis.NamingGrp).NameTxt).inputTextField).RestrictRow = 0
  _lastContent = (uis.NamingGrp).NameTxt
end

NameWindow.OnClose = function(...)
  -- function num : 0_9 , upvalues : NameWindow, uis, contentPane, argTable, _ENV
  (NameWindow.RemoveEvent)()
  uis = nil
  contentPane = nil
  argTable = {}
  ;
  (GuideData.AbolishControlRefer)((WinResConfig.NameWindow).name)
end

NameWindow.FocusInText = function(...)
  -- function num : 0_10
end

NameWindow.FocusOutText = function(...)
  -- function num : 0_11
end

NameWindow.OnChangedText = function(...)
  -- function num : 0_12 , upvalues : _ENV, uis, _lastContent, NameWindow
  local left = Const.MAX_NAME_LENGTH - (Util.StrUnicodeLength)(((uis.NamingGrp).NameTxt).text)
  if left >= 0 then
    _lastContent = ((uis.NamingGrp).NameTxt).text
  else
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((uis.NamingGrp).NameTxt).text = _lastContent
  end
  ;
  (NameWindow.FocusInText)()
end

NameWindow.ClickRandomBtn = function(...)
  -- function num : 0_13 , upvalues : _ENV, uis
  local count = #(TableData.gTable).BaseNameData
  local firstName = (math.random)(1, count)
  local lastName = (math.random)(1, count)
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((uis.NamingGrp).NameTxt).text = (((TableData.gTable).BaseNameData)[firstName]).first_name .. (((TableData.gTable).BaseNameData)[lastName]).last_name
end

NameWindow.ClickConfirmBtn = function(...)
  -- function num : 0_14 , upvalues : uis, _ENV
  local name = ((uis.NamingGrp).NameTxt).text
  if (Util.NameCheck)(name, (PUtil.get)(60000377), Const.MIN_NAME_LENGTH, Const.MAX_NAME_LENGTH) == false then
    return 
  end
  local key = (LoginMgr.GetAccount)() .. "_NAME"
  ;
  (Util.SetPlayerSetting)(key, name)
  ;
  (OvertureMgr.SetProgress)(OVERTURE_PROGRESS.AFTER_NAME)
  ;
  (OvertureMgr.PlayOverture)()
end

NameWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_15 , upvalues : _ENV
  if msgId == (WindowMsgEnum.ActorInfo).E_MSG_SET_NEW_NICKNAME then
    UIMgr:CloseWindow((WinResConfig.NameWindow).name)
  end
end

return NameWindow

