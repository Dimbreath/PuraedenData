-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActorInfo_RenameWindowByName")
local RenameWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local _lastContent = nil
RenameWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, RenameWindow
  bridgeObj:SetView((WinResConfig.RenameWindow).package, (WinResConfig.RenameWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetActorInfo_RenameWindowUis(contentPane)
  ;
  (RenameWindow.InitVariable)()
  ;
  (RenameWindow.InitText)()
  ;
  (RenameWindow.InitButtonEvent)()
end

RenameWindow.InitVariable = function(...)
  -- function num : 0_1
end

RenameWindow.InitText = function(...)
  -- function num : 0_2 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.RenameGrp).NameTxt).promptText = "[color=" .. Const.GrayColor .. "]" .. (PUtil.get)(60000457) .. "[/color]"
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.RenameGrp).TitleTxt).text = (PUtil.get)(60000375)
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.RenameGrp).WordTxt).text = (PUtil.get)(60000317, Const.MAX_NAME_LENGTH)
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.RenameGrp).SureBtn).text = (PUtil.get)(60000004)
end

RenameWindow.InitButtonEvent = function(...)
  -- function num : 0_3 , upvalues : uis, RenameWindow
  (((uis.RenameGrp).CloseBtn).onClick):Add(RenameWindow.ClickCloseBtn)
  ;
  (((uis.RenameGrp).SureBtn).onClick):Add(RenameWindow.ClickConfirmBtn)
  ;
  (((uis.RenameGrp).NameTxt).onChanged):Add(RenameWindow.OnChangedText)
end

RenameWindow.InitEvent = function(...)
  -- function num : 0_4
end

RenameWindow.RemoveEvent = function(...)
  -- function num : 0_5
end

RenameWindow.OnShown = function(...)
  -- function num : 0_6 , upvalues : RenameWindow
  (RenameWindow.InitEvent)()
  ;
  (RenameWindow.Init)()
end

RenameWindow.OnHide = function(...)
  -- function num : 0_7
end

RenameWindow.Init = function(...)
  -- function num : 0_8 , upvalues : uis, _lastContent, _ENV
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R0 in 'UnsetPending'

  (((uis.RenameGrp).NameTxt).inputTextField).RestrictRow = 0
  _lastContent = (uis.RenameGrp).NameTxt
  ;
  (Util.SetCurrencyWithConfig)((((TableData.gTable).BaseFixedData)[ActorData.MODIFY_NAME_COST]).array_value, (uis.RenameGrp).SpendLoader, (uis.RenameGrp).SpendTxt)
end

RenameWindow.OnClose = function(...)
  -- function num : 0_9 , upvalues : RenameWindow, uis, contentPane, argTable
  (RenameWindow.RemoveEvent)()
  uis = nil
  contentPane = nil
  argTable = {}
end

RenameWindow.OnChangedText = function(...)
  -- function num : 0_10 , upvalues : _ENV, uis, _lastContent
  local left = Const.MAX_NAME_LENGTH - (Util.StrUnicodeLength)(((uis.RenameGrp).NameTxt).text)
  if left >= 0 then
    _lastContent = ((uis.RenameGrp).NameTxt).text
  else
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((uis.RenameGrp).NameTxt).text = _lastContent
  end
end

RenameWindow.ClickCloseBtn = function(...)
  -- function num : 0_11 , upvalues : _ENV
  UIMgr:CloseWindow((WinResConfig.RenameWindow).name)
end

RenameWindow.ClickConfirmBtn = function(...)
  -- function num : 0_12 , upvalues : uis, _ENV
  local name = ((uis.RenameGrp).NameTxt).text
  if (Util.NameCheck)(name, (PUtil.get)(60000377), Const.MIN_NAME_LENGTH, Const.MAX_NAME_LENGTH) == false then
    return 
  end
  if name == (ActorData.GetNickName)() then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000380))
    return 
  end
  name = (Util.ReplaceSpace)(name)
  ;
  (MessageMgr.OpenCostResConfirmWindow)(60000524, (((TableData.gTable).BaseFixedData)[ActorData.MODIFY_NAME_COST]).array_value, function(...)
    -- function num : 0_12_0 , upvalues : _ENV, name
    (ActorInfoService.ReqSet)((ProtoEnum.E_SET_TYPE).NICK_NAME, name)
  end
, nil, nil, true)
end

RenameWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_13 , upvalues : _ENV, RenameWindow
  if msgId == (WindowMsgEnum.ActorInfo).E_MSG_SET_NEW_NICKNAME then
    (RenameWindow.ClickCloseBtn)()
  end
end

return RenameWindow

