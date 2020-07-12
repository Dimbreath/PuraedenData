-- params : ...
-- function num : 0 , upvalues : _ENV
local ObjectPoolManager = ((CS.ObjectPoolManager).GetInstance)()
local ObjectPoolMgr = {}
ObjectPoolMgr.GetObj = function(objName, resType, ...)
  -- function num : 0_0 , upvalues : ObjectPoolManager
  return ObjectPoolManager:GetObj(objName, resType)
end

ObjectPoolMgr.RecycleObj = function(obj, notChangeLayer, ...)
  -- function num : 0_1 , upvalues : _ENV, ObjectPoolManager
  if notChangeLayer ~= true then
    (CSLuaUtil.ChangeLayer)(obj.transform, LayerMaskNames.DEFAULT)
  end
  return ObjectPoolManager:RecycleObj(obj)
end

ObjectPoolMgr.ClearPool = function(notClearAssets, ...)
  -- function num : 0_2 , upvalues : ObjectPoolManager
  return ObjectPoolManager:ClearPool(notClearAssets)
end

return ObjectPoolMgr

