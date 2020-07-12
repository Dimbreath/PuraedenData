-- params : ...
-- function num : 0 , upvalues : _ENV
local SocketMgr = (CS.LuaSocketManager).Singleton
local ResendPak = {m_send_data = nil, isReconnect = false, connectTime = nil, connectNeedTime = 5, retryNum = 1, 
needResendPakTable = {}
}
ResendPak.AddResendPak = function(msgId, data, ...)
  -- function num : 0_0 , upvalues : _ENV, ResendPak
  (table.insert)(ResendPak.needResendPakTable, {id = msgId, data = data})
end

ResendPak.ClearResendPak = function(...)
  -- function num : 0_1 , upvalues : ResendPak
  ResendPak.needResendPakTable = {}
end

ResendPak.Resend = function(...)
  -- function num : 0_2 , upvalues : _ENV, ResendPak, SocketMgr
  loge("---------重连后发送未成功发送的消息")
  local tempTable = (Util.Copy)(ResendPak.needResendPakTable)
  ;
  (ResendPak.ClearResendPak)()
  for i,v in ipairs(tempTable) do
    loge("重发id:" .. v.id)
    SocketMgr:Send(v.id, v.data)
  end
  local MsgWaiterObj = require("MsgWaiter")
  ;
  (MsgWaiterObj.DealTimeoutFunc)()
  loge("---------发送结束")
end

ResendPak.DoReconnect = function(...)
  -- function num : 0_3 , upvalues : _ENV, ResendPak
  loge(" [net close] ResendPak.isReconnect ")
  if ResendPak.isReconnect == true then
    return 
  end
  ResendPak.isReconnect = true
  ;
  (ResendPak.StartConnectServer)()
end

ResendPak.Reset = function(...)
  -- function num : 0_4 , upvalues : ResendPak
  ResendPak.isReconnect = false
  ;
  (ResendPak.ClearTime)()
end

ResendPak.StartConnectServer = function(...)
  -- function num : 0_5 , upvalues : _ENV
  loge(" [net close] start_to_connect_server ")
  if UIMgr:IsWindowOpen((WinResConfig.MsgWaitingWindow).name) == false then
    OpenWindow((WinResConfig.MsgWaitingWindow).name, UILayer.God)
  end
  ;
  (Net.ReConnect)()
end

ResendPak.ClearTime = function(...)
  -- function num : 0_6 , upvalues : ResendPak
  if ResendPak.connectTime ~= nil then
    (ResendPak.connectTime):stop()
    ResendPak.connectTime = nil
  end
end

ResendPak.ConnectServerOk = function(...)
  -- function num : 0_7 , upvalues : _ENV, ResendPak
  loge(" [net close] ResendPak.connect_server_ok ResendPak.is_reconnent = " .. tostring(ResendPak.isReconnect))
  UIMgr:CloseWindow((WinResConfig.MsgWaitingWindow).name)
  if ResendPak.isReconnect == true then
    ResendPak.isReconnect = false
    ;
    (ResendPak.ClearTime)()
  end
end

return ResendPak

