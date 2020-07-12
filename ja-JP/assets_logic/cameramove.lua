-- params : ...
-- function num : 0 , upvalues : _ENV
local CameraMove = {}
CameraMove.GoNowCamera = function(camera, destPosition, moveTime, moveType, callBack, isRelative, ...)
  -- function num : 0_0 , upvalues : _ENV
  (CSLuaUtil.CameraMove)(camera, destPosition, moveTime, moveType, callBack, isRelative)
end

CameraMove.Back2OriginalPostion = function(...)
  -- function num : 0_1
end

CameraMove.SetBloom = function(camera, enable, ...)
  -- function num : 0_2 , upvalues : _ENV
  if camera then
    local anim = camera:GetComponent(typeof(CS.FastMobileBloom))
    if anim then
      anim.enabled = enable
    end
  end
end

return CameraMove

