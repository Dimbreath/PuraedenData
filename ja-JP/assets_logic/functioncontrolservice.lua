-- params : ...
-- function num : 0 , upvalues : _ENV
FunctionControlService = {}
-- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

FunctionControlService.Init = function(...)
  -- function num : 0_0 , upvalues : _ENV
  (Net.AddListener)((Proto.MsgName).ResFunctionList, FunctionControlService.OnResFunctionList)
  ;
  (Net.AddListener)((Proto.MsgName).ResOpenFunction, FunctionControlService.OnResOpenFunction)
end

-- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

FunctionControlService.OnResFunctionList = function(msg, ...)
  -- function num : 0_1 , upvalues : _ENV
  (FunctionControlMgr.InitFunction)(msg)
end

-- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

FunctionControlService.OnResOpenFunction = function(msg, ...)
  -- function num : 0_2 , upvalues : _ENV
  for _,v in ipairs(msg.newFuncId) do
    print("新开启的功能id              " .. v)
    ;
    (FunctionControlMgr.OpenFunction)(v)
  end
end

;
(FunctionControlService.Init)()

