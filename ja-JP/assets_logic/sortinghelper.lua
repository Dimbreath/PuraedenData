-- params : ...
-- function num : 0 , upvalues : _ENV
local SortingHelper = {}
SortingHelper.Init = function(...)
  -- function num : 0_0
end

SortingHelper.SetOrderInLayer = function(gameObject, layerInt, force, ...)
  -- function num : 0_1 , upvalues : _ENV
  do
    if not layerInt then
      local layer = not gameObject or 0
    end
    ;
    (CSLuaUtil.SetChildrenOrderInLayer)(gameObject, layerInt, force)
    print("Error: GameObject is Nil")
  end
end

return SortingHelper

