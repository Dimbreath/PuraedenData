-- params : ...
-- function num : 0 , upvalues : _ENV
ChatService = {}
-- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

ChatService.Init = function(...)
  -- function num : 0_0 , upvalues : _ENV
  (Net.AddListener)((Proto.MsgName).ResSetChat, ChatService.RecvSetChat)
  ;
  (Net.AddListener)((Proto.MsgName).ResSetAccpetChat, ChatService.RecvSetAccpectChat)
  ;
  (Net.AddListener)((Proto.MsgName).ResGetChat, ChatService.RecvGetChat)
end

-- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

ChatService.ReqSetBulletScreen = function(content, bsData, ...)
  -- function num : 0_1 , upvalues : _ENV
  (ChatService.ReqSetChat)((ProtoEnum.CHAT_TYPE).BULLET_CHAT, (ProtoEnum.CHAT_SUB_TYPE).ADVENTURE_BULLET, nil, content, bsData)
end

-- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

ChatService.ReqSetGuildChat = function(content, emoji, ...)
  -- function num : 0_2 , upvalues : _ENV
  (ChatService.ReqSetChat)((ProtoEnum.CHAT_TYPE).GUILD_CHAT, nil, emoji, content)
end

-- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

ChatService.ReqSetCardComment = function(content, cardID, ...)
  -- function num : 0_3 , upvalues : _ENV
  (ChatService.ReqSetChat)((ProtoEnum.CHAT_TYPE).CARD_CHAT, nil, nil, content, nil, tostring(cardID))
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

ChatService.ReqSetChat = function(type, subType, image, content, bsData, target, ...)
  -- function num : 0_4 , upvalues : _ENV
  if subType == nil then
    subType = (ProtoEnum.CHAT_SUB_TYPE).DEFAULT_SUB_CHAT
  end
  local m = {}
  m.chatType = type
  m.chatSubType = subType
  m.image = image
  m.content = content
  m.bulletScreenData = bsData
  m.target = target
  ;
  (Net.Send)((Proto.MsgName).ReqSetChat, m, (Proto.MsgName).ResSetChat)
end

-- DECOMPILER ERROR at PC19: Confused about usage of register: R0 in 'UnsetPending'

ChatService.RecvSetChat = function(msg, ...)
  -- function num : 0_5 , upvalues : _ENV
  if msg.chatType == (ProtoEnum.CHAT_TYPE).BULLET_CHAT and msg.chatSubType == (ProtoEnum.CHAT_SUB_TYPE).ADVENTURE_BULLET then
    (AdventureService.RecvSetChat)(msg)
  else
    if msg.chatType == (ProtoEnum.CHAT_TYPE).GUILD_CHAT then
      (GuildMgr.RecvNewChat)(msg.chatData)
    else
      if msg.chatType == (ProtoEnum.CHAT_TYPE).CARD_CHAT then
        (CardMgr.AddSelfComment)(msg.chatData)
      end
    end
  end
end

-- DECOMPILER ERROR at PC22: Confused about usage of register: R0 in 'UnsetPending'

ChatService.ReqSetRecvGuildChat = function(acceptable, ...)
  -- function num : 0_6 , upvalues : _ENV
  (ChatService.ReqSetAccpetChat)((ProtoEnum.CHAT_TYPE).GUILD_CHAT, nil, acceptable)
end

-- DECOMPILER ERROR at PC25: Confused about usage of register: R0 in 'UnsetPending'

ChatService.ReqSetAccpetChat = function(type, subType, acceptable, ...)
  -- function num : 0_7 , upvalues : _ENV
  if subType == nil then
    subType = (ProtoEnum.CHAT_SUB_TYPE).DEFAULT_SUB_CHAT
  end
  local m = {}
  m.chatType = type
  m.chatSubType = subType
  m.isAccpet = acceptable
  ;
  (Net.Send)((Proto.MsgName).ReqSetAccpetChat, m, (Proto.MsgName).ResSetAccpetChat)
end

-- DECOMPILER ERROR at PC28: Confused about usage of register: R0 in 'UnsetPending'

ChatService.RecvSetAccpectChat = function(msg, ...)
  -- function num : 0_8
end

-- DECOMPILER ERROR at PC31: Confused about usage of register: R0 in 'UnsetPending'

ChatService.ReqGetBulletScreenChat = function(...)
  -- function num : 0_9 , upvalues : _ENV
  (ChatService.ReqGetChat)((ProtoEnum.CHAT_TYPE).BULLET_CHAT, (ProtoEnum.CHAT_SUB_TYPE).ADVENTURE_BULLET)
end

-- DECOMPILER ERROR at PC34: Confused about usage of register: R0 in 'UnsetPending'

ChatService.ReqGetGuildChat = function(...)
  -- function num : 0_10 , upvalues : _ENV
  (ChatService.ReqGetChat)((ProtoEnum.CHAT_TYPE).GUILD_CHAT)
end

-- DECOMPILER ERROR at PC37: Confused about usage of register: R0 in 'UnsetPending'

ChatService.ReqGetChat = function(type, subType, ...)
  -- function num : 0_11 , upvalues : _ENV
  if subType == nil then
    subType = (ProtoEnum.CHAT_SUB_TYPE).DEFAULT_SUB_CHAT
  end
  local m = {}
  m.chatType = type
  m.chatSubType = subType
  ;
  (Net.Send)((Proto.MsgName).ReqGetChat, m, (Proto.MsgName).ResGetChat)
end

-- DECOMPILER ERROR at PC40: Confused about usage of register: R0 in 'UnsetPending'

ChatService.RecvGetChat = function(msg, ...)
  -- function num : 0_12 , upvalues : _ENV
  if msg.chatType == (ProtoEnum.CHAT_TYPE).BULLET_CHAT and msg.chatSubType == (ProtoEnum.CHAT_SUB_TYPE).ADVENTURE_BULLET then
    (AdventureService.RecvGetChat)(msg)
  else
    if msg.chatType == (ProtoEnum.CHAT_TYPE).GUILD_CHAT then
      (GuildMgr.RecvGuildChat)(msg)
    end
  end
end

;
(ChatService.Init)()

