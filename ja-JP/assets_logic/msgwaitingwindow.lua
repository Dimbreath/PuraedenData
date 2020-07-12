-- params : ...
-- function num : 0 , upvalues : _ENV
require("Loading_NetCheckByName")
local MsgWaitingWindow = {}
local uis, contentPane, waitTimer = nil, nil, nil
local isCloseGuide = false
MsgWaitingWindow.ReInitData = function(...)
  -- function num : 0_0
end

MsgWaitingWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_1 , upvalues : _ENV, contentPane, uis, isCloseGuide, waitTimer, MsgWaitingWindow
  bridgeObj:SetView((WinResConfig.MsgWaitingWindow).package, (WinResConfig.MsgWaitingWindow).comName)
  contentPane = bridgeObj.contentPane
  contentPane:Center()
  uis = GetLoading_NetCheckUis(contentPane)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.ConnectTxt).text = ""
  contentPane.alpha = 0
  isCloseGuide = false
  waitTimer = (SimpleTimer.setTimeout)(2.5, MsgWaitingWindow.LaterShow)
end

MsgWaitingWindow.LaterShow = function(...)
  -- function num : 0_2 , upvalues : _ENV, isCloseGuide, contentPane
  (GuideMgr.SetGuideShow)(false)
  isCloseGuide = true
  if contentPane then
    contentPane.alpha = 1
  end
end

MsgWaitingWindow.UpdateConnectTxt = function(text, ...)
  -- function num : 0_3 , upvalues : uis
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (uis.ConnectTxt).text = text
end

MsgWaitingWindow.OnShown = function(...)
  -- function num : 0_4
end

MsgWaitingWindow.OnHide = function(...)
  -- function num : 0_5
end

MsgWaitingWindow.OnClose = function(...)
  -- function num : 0_6 , upvalues : isCloseGuide, _ENV, uis, contentPane, waitTimer
  if isCloseGuide then
    (GuideMgr.SetGuideShow)(true)
  end
  isCloseGuide = false
  uis = nil
  contentPane = nil
  if waitTimer then
    waitTimer:stop()
    waitTimer = nil
  end
end

MsgWaitingWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_7 , upvalues : _ENV, MsgWaitingWindow
  if msgId == (WindowMsgEnum.MsgWaitingWindow).E_MSG_UPDATE_TXT then
    (MsgWaitingWindow.UpdateConnectTxt)(para)
  end
end

return MsgWaitingWindow

