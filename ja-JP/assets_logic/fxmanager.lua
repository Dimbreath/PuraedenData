-- params : ...
-- function num : 0 , upvalues : _ENV
local FxManager = {}
local Vector3 = Vector3
local shutterEffect = nil
local fxConfigCache = {}
FxManager.GetFxConfigData = function(self, fxName, gameObject, ...)
  -- function num : 0_0 , upvalues : fxConfigCache, _ENV
  local obj = gameObject
  if not fxConfigCache[fxName] then
    if not obj then
      obj = (ResHelper.InstantiateModel)(fxName)
    end
    local dataConfig = {name = fxName}
    if obj then
      local eh = obj:GetComponent(typeof(CS.SkillEffectsHelper))
      if eh then
        local readConfigs = {
{key = "flipX", type = "bool", default = true}
, 
{key = "flipXZ", type = "bool", default = false}
, 
{key = "flipSimpleX", type = "bool", default = true}
, 
{key = "rotationY", type = "bool", default = false}
}
        for i,v in ipairs(readConfigs) do
          if v.type == "int" then
            if eh[v.key] and eh[v.key] >= 0 then
              dataConfig[v.key] = eh[v.key]
            else
              if v.default then
                dataConfig[v.key] = v.default
              end
            end
          else
            -- DECOMPILER ERROR at PC80: Unhandled construct in 'MakeBoolean' P1

            if v.type == "bool" and eh[v.key] == nil and v.default then
              dataConfig[v.key] = v.default
            end
          end
          dataConfig[v.key] = eh[v.key]
          if v.type == "string" then
            if eh[v.key] and eh[v.key] ~= "" then
              dataConfig[v.key] = eh[v.key]
            else
              if v.default then
                dataConfig[v.key] = v.default
              end
            end
          end
        end
      end
    else
      do
        local format = "Can not load skill effect data, id is %d"
        do
          do
            local msg = (string.format)(format, fxName)
            loge(msg)
            fxConfigCache[fxName] = dataConfig
            return fxConfigCache[fxName], obj
          end
        end
      end
    end
  end
end

FxManager.PlayShackCameraEffect = function(self, fxName, gameObject, ...)
  -- function num : 0_1 , upvalues : _ENV
  local config, obj = self:GetFxConfigData(fxName, gameObject)
  if config and obj then
    local shakeAnim = config.shakeAnim
    if shakeAnim ~= "" then
      local ShakeAnimPlay = require("ShakeAnimPlay")
      if Game.battleCamera then
        (ShakeAnimPlay.PlayShake)("shake000_horizon", Game.battleCamera)
      end
    end
  end
end

FxManager.PlayFx = function(self, ...)
  -- function num : 0_2
end

FxManager.PlayTimeLine = function(self, obj, ...)
  -- function num : 0_3 , upvalues : _ENV
  local mDirector = obj:GetComponent(typeof(((CS.UnityEngine).Playables).PlayableDirector))
  if mDirector then
    mDirector:Play()
    return mDirector.duration
  end
end

FxManager.StopTimeLine = function(self, obj, ...)
  -- function num : 0_4 , upvalues : _ENV
  local mDirector = obj:GetComponent(typeof(((CS.UnityEngine).Playables).PlayableDirector))
  if mDirector then
    mDirector:Stop()
  end
end

FxManager.OverturnTimeline = function(self, ...)
  -- function num : 0_5
end

FxManager.Overturn = function(self, obj, ...)
  -- function num : 0_6 , upvalues : FxManager, Vector3, _ENV
  if obj then
    local selfScale = (obj.transform).localScale
    local config = FxManager:GetFxConfigData(obj.name, obj)
    if config then
      if config.flipX == false then
        return 
      end
      -- DECOMPILER ERROR at PC28: Confused about usage of register: R4 in 'UnsetPending'

      if config.flipXZ == true then
        (obj.transform).localScale = Vector3(selfScale.x, selfScale.y, (math.abs)(selfScale.z) * -1)
        local selfEulerAngles = (obj.transform).localEulerAngles
        -- DECOMPILER ERROR at PC37: Confused about usage of register: R5 in 'UnsetPending'

        ;
        (obj.transform).localEulerAngles = Vector3(selfEulerAngles.x, 180, selfEulerAngles.z)
        return 
      end
      do
        -- DECOMPILER ERROR at PC52: Confused about usage of register: R4 in 'UnsetPending'

        if config.flipSimpleX == true then
          (obj.transform).localScale = Vector3((math.abs)(selfScale.x) * -1, selfScale.y, selfScale.z)
          return 
        end
        do
          if config.rotationY == true then
            local selfEulerAngles = (obj.transform).localEulerAngles
            -- DECOMPILER ERROR at PC65: Confused about usage of register: R5 in 'UnsetPending'

            ;
            (obj.transform).localEulerAngles = Vector3(selfEulerAngles.x, 180, selfEulerAngles.z)
            return 
          end
          -- DECOMPILER ERROR at PC77: Confused about usage of register: R4 in 'UnsetPending'

          ;
          (obj.transform).localScale = Vector3((math.abs)(selfScale.x) * -1, selfScale.y, selfScale.z)
        end
      end
    end
  end
end

FxManager.ResetFx = function(self, obj, ...)
  -- function num : 0_7 , upvalues : _ENV
  if obj then
    (CSLuaUtil.SetGOScale)(obj, 1, 1, 1)
    ;
    (CSLuaUtil.SetGOLocalEuler)(obj, 0, 0, 0)
  end
end

FxManager.SetParticleSpeed = function(self, speed, ptcs, ...)
  -- function num : 0_8
  for i = 0, ptcs.Length - 1 do
    local particle = ptcs[i]
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (particle.main).simulationSpeed = speed
  end
end

FxManager.SetShutterEffect = function(self, obj, image, rotate, ...)
  -- function num : 0_9 , upvalues : _ENV, shutterEffect
  if (Util.IsNil)(obj) then
    return 
  end
  local materials = (obj:GetComponent(typeof((CS.UnityEngine).MeshRenderer))).materials
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R5 in 'UnsetPending'

  if image then
    (image.graphics).skipResetMat = true
  end
  local count = materials.Length - 1
  for i = 0, count do
    local mat = materials[i]
    mat:SetFloat("_StencilComp", 4)
    mat:SetFloat("_Stencil", 2)
  end
  local sa = obj:GetComponent(typeof(((CS.Spine).Unity).SkeletonAnimation))
  if (Util.IsNil)(shutterEffect) then
    local holder, effect = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_CHANGECARD_SHUTTER, true, true)
    shutterEffect = effect
  else
    do
      shutterEffect:SetActive(false)
      local anim = shutterEffect:GetComponent(typeof((CS.UnityEngine).Animator))
      ;
      (CSLuaUtil.SetAnimatorController)(anim, "Effects/Animation/shutterAnimator")
      shutterEffect.layer = 5
      ;
      ((shutterEffect:GetComponent(typeof((CS.UnityEngine).MeshRenderer))).material):SetFloat("_Cutoff", 1.1)
      -- DECOMPILER ERROR at PC92: Confused about usage of register: R8 in 'UnsetPending'

      ;
      (shutterEffect.transform).parent = (obj.transform).parent
      -- DECOMPILER ERROR at PC98: Confused about usage of register: R8 in 'UnsetPending'

      ;
      (shutterEffect.transform).localPosition = ((CS.UnityEngine).Vector3).zero
      -- DECOMPILER ERROR at PC107: Confused about usage of register: R8 in 'UnsetPending'

      ;
      (shutterEffect.transform).localEulerAngles = ((CS.UnityEngine).Vector3)(0, 0, -28)
      if sa then
        sa:SetMaterial(materials)
      else
        ;
        (obj:GetComponent(typeof((CS.UnityEngine).MeshRenderer))).materials = materials
      end
      shutterEffect:SetActive(true)
    end
  end
end

FxManager.DestroyShutterEffect = function(self, ...)
  -- function num : 0_10 , upvalues : shutterEffect, _ENV
  if shutterEffect ~= nil then
    (ResHelper.DestroyGameObject)(shutterEffect, true)
    shutterEffect = nil
  end
end

return FxManager

