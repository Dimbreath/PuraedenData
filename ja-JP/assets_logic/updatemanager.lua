-- params : ...
-- function num : 0 , upvalues : _ENV
local LuaUpdateMgr = (CS.LuaUpdateManager).Singleton
require("Handler")
local updateHandler = GetNewHandler()
local UpdateManager = {}
UpdateManager.AddUpdateHandler = function(func, tableobj, ...)
  -- function num : 0_0 , upvalues : updateHandler
  updateHandler:AddHandle(1, func, tableobj)
end

UpdateManager.RemoveUpdateHandler = function(func, ...)
  -- function num : 0_1 , upvalues : updateHandler
  updateHandler:RemoveHandle(1, func)
end

UpdateManager.AddLateUpdateHandler = function(func, tableobj, ...)
  -- function num : 0_2 , upvalues : updateHandler
  updateHandler:AddHandle(2, func, tableobj)
end

UpdateManager.RemoveLateUpdateHandler = function(func, ...)
  -- function num : 0_3 , upvalues : updateHandler
  updateHandler:RemoveHandle(2, func)
end

UpdateManager.AddFixedUpdateHandler = function(func, tableobj, ...)
  -- function num : 0_4 , upvalues : updateHandler
  updateHandler:AddHandle(3, func, tableobj)
end

UpdateManager.RemoveFixedUpdateHandler = function(func, ...)
  -- function num : 0_5 , upvalues : updateHandler
  updateHandler:RemoveHandle(3, func)
end

UpdateManager.ClearAll = function(...)
  -- function num : 0_6 , upvalues : updateHandler
  (updateHandler.RemoveAllHandle)(1)
  ;
  (updateHandler.RemoveAllHandle)(2)
  ;
  (updateHandler.RemoveAllHandle)(3)
end

local Update = function(...)
  -- function num : 0_7 , upvalues : updateHandler
  updateHandler:RunId(1)
end

local LateUpdate = function(...)
  -- function num : 0_8 , upvalues : updateHandler
  updateHandler:RunId(2)
end

local FixedUpdate = function(...)
  -- function num : 0_9 , upvalues : updateHandler
  updateHandler:RunId(3)
end

LuaUpdateMgr:InitLua(Update, FixedUpdate, LateUpdate)
return UpdateManager

