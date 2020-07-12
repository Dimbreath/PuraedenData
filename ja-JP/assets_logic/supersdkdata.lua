-- params : ...
-- function num : 0 , upvalues : _ENV
SuperSDKData = {}
local _ticket, _userId, _opId, _gameId = nil, nil, nil, nil
-- DECOMPILER ERROR at PC5: Confused about usage of register: R4 in 'UnsetPending'

SuperSDKData.Init = function(...)
  -- function num : 0_0 , upvalues : _ticket, _userId, _opId, _gameId
  _ticket = nil
  _userId = nil
  _opId = nil
  _gameId = nil
end

-- DECOMPILER ERROR at PC8: Confused about usage of register: R4 in 'UnsetPending'

SuperSDKData.SetLoginTicket = function(ticket, ...)
  -- function num : 0_1 , upvalues : _ticket
  _ticket = ticket
end

-- DECOMPILER ERROR at PC11: Confused about usage of register: R4 in 'UnsetPending'

SuperSDKData.GetLoginTicket = function(...)
  -- function num : 0_2 , upvalues : _ticket
  return _ticket
end

-- DECOMPILER ERROR at PC14: Confused about usage of register: R4 in 'UnsetPending'

SuperSDKData.SetLoginUserId = function(user_id, ...)
  -- function num : 0_3 , upvalues : _userId
  _userId = user_id
end

-- DECOMPILER ERROR at PC17: Confused about usage of register: R4 in 'UnsetPending'

SuperSDKData.GetLoginUserId = function(...)
  -- function num : 0_4 , upvalues : _userId
  return _userId
end

-- DECOMPILER ERROR at PC20: Confused about usage of register: R4 in 'UnsetPending'

SuperSDKData.SetLoginExtend = function(extend, ...)
  -- function num : 0_5 , upvalues : _ENV, _opId, _gameId
  if extend and extend ~= "" then
    local splitTable = split(extend, "|")
    if #splitTable > 0 then
      _opId = splitTable[1]
      _gameId = splitTable[2]
    end
  end
end

-- DECOMPILER ERROR at PC23: Confused about usage of register: R4 in 'UnsetPending'

SuperSDKData.GetLoginOpId = function(...)
  -- function num : 0_6 , upvalues : _opId
  return _opId
end

-- DECOMPILER ERROR at PC26: Confused about usage of register: R4 in 'UnsetPending'

SuperSDKData.GetLoginGameId = function(...)
  -- function num : 0_7 , upvalues : _gameId
  return _gameId
end

-- DECOMPILER ERROR at PC29: Confused about usage of register: R4 in 'UnsetPending'

SuperSDKData.AlreadyLogin = function(...)
  -- function num : 0_8 , upvalues : _ticket, _userId
  do return _ticket ~= nil and _userId ~= nil end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end


