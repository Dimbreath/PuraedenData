-- params : ...
-- function num : 0 , upvalues : _ENV
local require = require
local pb = require("pb")
local protoc = require("Protoc")
Proto = require("Proto")
;
(pb.option)("enum_as_value")
;
(pb.option)("use_default_values")
assert(protoc:load(Proto.Schema))
local ResendPak = require("ResendPak")
require("handler")
local SocketMgr = (CS.LuaSocketManager).Singleton
local Net = {defaultConnectTimeout = 5, isConnect = false, isReconnect = false, isReconnectOk = false, retryNum = 0, retryMaxNum = 5}
local handler = GetNewHandler()
local onceListenerTable = {}
Net.LuaMsgDispatcher = function(msgid, data, ...)
  -- function num : 0_0 , upvalues : _ENV, handler, require, pb, onceListenerTable
  log("处理消息, msgId:" .. msgid .. ", msgName:" .. ((Proto.MsgNameByID)[msgid] or "不存在"))
  local msgHands = (handler.handles)[msgid]
  if msgHands == nil then
    logw("lua消息处理table为空：" .. msgid)
    return 
  end
  local hands = msgHands.table
  if not hands then
    return 
  end
  if #hands == 0 then
    return 
  end
  local MsgWaiterObj = require("MsgWaiter")
  if msgid ~= (Proto.MsgIdByName).ResAlert then
    (MsgWaiterObj.ReceiveMsg)(msgid)
  end
  if data ~= nil then
    local msg = (pb.decode)((Proto.MsgNameByID)[msgid], data)
    handler:RunHandles(hands, msg)
  else
    do
      logw("解析pb数据为空:" .. msgid)
      handler:RunHandles(hands, {})
      if onceListenerTable[msgid] and #onceListenerTable[msgid] > 0 then
        for i = #onceListenerTable[msgid], 1, -1 do
          local listener = (onceListenerTable[msgid])[i]
          if listener then
            local handle = listener.handle
            local tableObj = listener.tableObj
            if handle then
              handle(tableObj)
            end
          end
          do
            do
              ;
              (table.remove)(onceListenerTable[msgid], i)
              -- DECOMPILER ERROR at PC93: LeaveBlock: unexpected jumping out DO_STMT

            end
          end
        end
      end
    end
  end
end

Net.AddOnceListener = function(msgName, handle, tableObj, ...)
  -- function num : 0_1 , upvalues : _ENV, onceListenerTable
  if handle == nil then
    loge("注册lua net处理失败，函数为空,消息名-->>" .. msgName)
    return 
  end
  local id = (Proto.MsgIdByName)[msgName]
  if id == nil then
    loge("无效消息名-->>" .. msgName)
    return 
  end
  if not onceListenerTable[id] then
    onceListenerTable[id] = {}
  end
  ;
  (table.insert)(onceListenerTable[id], {handle = handle, param = tableObj})
end

Net.Send = function(msgName, msg, waitMsgName, timeoutCallback, ...)
  -- function num : 0_2 , upvalues : _ENV, pb, Net, ResendPak, SocketMgr
  if not msg then
    msg = {}
  end
  PrintTable(msg, msgName, "lua发送消息")
  local data = (pb.encode)(msgName, msg)
  local msgId = (Proto.MsgIdByName)[msgName]
  if (Net.IsConnect)() == false then
    (ResendPak.AddResendPak)(msgId, data)
  else
    SocketMgr:Send(msgId, data)
  end
  if waitMsgName then
    MsgWaiter(waitMsgName, msgName, timeoutCallback)
  end
end

Net.AddListener = function(msgName, handle, tableObj, ...)
  -- function num : 0_3 , upvalues : _ENV, handler
  if handle == nil then
    loge("注册lua net处理失败，函数为空,消息名-->>" .. msgName)
    return 
  end
  local id = (Proto.MsgIdByName)[msgName]
  if id == nil then
    loge("无效消息名-->>" .. msgName)
    return 
  end
  handler:AddHandle(id, handle, tableObj)
end

Net.RemoveListener = function(msgName, handle, tableObj, ...)
  -- function num : 0_4 , upvalues : _ENV, handler
  local id = (Proto.MsgIdByName)[msgName]
  if id == nil then
    loge("无效消息名-->>" .. msgName)
    return 
  end
  handler:RemoveHandle(id, handle, tableObj)
end

Net.OnConnected = function(...)
  -- function num : 0_5 , upvalues : _ENV, Net, ResendPak, require
  loge("socket连接上")
  Net.isConnect = true
  Net.retryNum = 0
  ;
  (ResendPak.Reset)()
  local isReconnect = Net.isReconnect
  if Net.isReconnect then
    Net.isReconnect = false
    Net.isReconnectOk = true
    ;
    (ResendPak.ConnectServerOk)()
    local MsgWaiterObj = require("MsgWaiter")
    ;
    (MsgWaiterObj.Reset)()
  end
  do
    ;
    (LoginService.ReqLogin)(isReconnect)
    -- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'

    LoginMgr.canTouch = true
  end
end

Net.OnDisConnect = function(...)
  -- function num : 0_6 , upvalues : _ENV, Net, ResendPak, require
  loge("Net.OnDisConnect")
  Net.isConnect = false
  ;
  (ResendPak.Reset)()
  if Net.isReconnect then
    Net.isReconnect = false
    local MsgWaiterObj = require("MsgWaiter")
    ;
    (MsgWaiterObj.PromptMsgTimeout)(1)
  end
  do
    if LoginMgr.canTouch == false then
      (MessageMgr.SendCenterTips)((PUtil.get)(40000012))
    end
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R0 in 'UnsetPending'

    LoginMgr.canTouch = true
  end
end

Net.OnError = function(...)
  -- function num : 0_7 , upvalues : _ENV, Net, ResendPak, require
  loge("Net.OnError")
  Net.isConnect = false
  ;
  (ResendPak.Reset)()
  if Net.isReconnect then
    Net.isReconnect = false
    local MsgWaiterObj = require("MsgWaiter")
    ;
    (MsgWaiterObj.PromptMsgTimeout)(1)
  end
  do
    if LoginMgr.canTouch == false then
      (MessageMgr.SendCenterTips)((PUtil.get)(40000012))
    end
    -- DECOMPILER ERROR at PC28: Confused about usage of register: R0 in 'UnsetPending'

    LoginMgr.canTouch = true
  end
end

Net.ReConnect = function(...)
  -- function num : 0_8 , upvalues : Net, _ENV
  Net.retryNum = Net.retryNum + 1
  if Net.retryMaxNum <= Net.retryNum then
    Net.retryNum = 0
    ;
    (LoginMgr.ReturnToLoginWindow)()
    return 
  end
  Net.isReconnect = true
  local urlInfo = (LoginMgr.GetRandomUrl)()
  local ip = Net.ip
  local port = Net.port
  if urlInfo then
    ip = urlInfo.ip
    port = urlInfo.port
  end
  ;
  (Net.Connect)(ip, port)
end

Net.IsConnect = function(...)
  -- function num : 0_9 , upvalues : Net
  return Net.isConnect
end

Net.IsReConnect = function(...)
  -- function num : 0_10 , upvalues : Net
  return Net.isReconnect
end

Net.Connect = function(ip, port, timeout, ...)
  -- function num : 0_11 , upvalues : Net, SocketMgr
  Net.ip = ip
  Net.port = port
  SocketMgr:Connect(ip, port, timeout or Net.defaultConnectTimeout)
end

Net.Init = function(...)
  -- function num : 0_12 , upvalues : SocketMgr, Net
  SocketMgr:InitLua(Net.LuaMsgDispatcher, Net.OnConnected, Net.OnDisConnect, Net.OnError)
end

Net.Close = function(...)
  -- function num : 0_13 , upvalues : SocketMgr
  if SocketMgr then
    SocketMgr:Close()
  end
end

;
(Net.Init)()
return Net

