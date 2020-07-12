-- params : ...
-- function num : 0 , upvalues : _ENV
CardFetterService = {}
-- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

CardFetterService.Init = function(...)
  -- function num : 0_0 , upvalues : _ENV
  (Net.AddListener)((Proto.MsgName).ResActivateFetter, CardFetterService.OnResActivateFetter)
end

-- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

CardFetterService.ReqActivateFetter = function(id, ...)
  -- function num : 0_1 , upvalues : _ENV
  print("417激活羁绊   ", id)
  local send = {id = id}
  ;
  (Net.Send)((Proto.MsgName).ReqActivateFetter, send, (Proto.MsgName).ResActivateFetter)
end

-- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

CardFetterService.OnResActivateFetter = function(msg, ...)
  -- function num : 0_2 , upvalues : _ENV
  print("417激活羁绊返回   ", msg.id)
end

;
(CardFetterService.Init)()

