-- params : ...
-- function num : 0 , upvalues : _ENV
local ShakeAnimPlay = {}
local Animator = (CS.UnityEngine).Animator
local data, callback = nil, nil
local time = 0
local testData = ""
ShakeAnimPlay.Init = function(...)
  -- function num : 0_0
end

ShakeAnimPlay.CheckData = function(...)
  -- function num : 0_1
end

ShakeAnimPlay.OnStart = function(...)
  -- function num : 0_2
end

ShakeAnimPlay.OnPlaying = function(...)
  -- function num : 0_3
end

ShakeAnimPlay.EndPlay = function(...)
  -- function num : 0_4
end

ShakeAnimPlay.PlayShake = function(animName, camera, ...)
  -- function num : 0_5 , upvalues : _ENV, Animator
  if animName and animName ~= "" then
    local anim = camera:GetComponent(typeof(Animator))
    if anim then
      local stateId = (Animator.StringToHash)(animName)
      local hasState = anim:HasState(0, stateId)
      if not hasState then
        print("PlayShake, do not has anim state " .. animName)
      end
      anim:Play(animName, 0, 0)
    end
  end
end

ShakeAnimPlay.EnableShake = function(camera, enable, ...)
  -- function num : 0_6 , upvalues : _ENV, Animator
  if camera then
    local anim = camera:GetComponent(typeof(Animator))
    if anim then
      anim.enabled = enable
    end
  end
end

return ShakeAnimPlay

