-- params : ...
-- function num : 0 , upvalues : _ENV
local LuaEffect = {}
LuaEffect.AddUIEffect = function(effectName, PlayOverIsDestroy, DisableIsDestroy, localEulerAngles, scale, ...)
  -- function num : 0_0 , upvalues : _ENV
  local holder = (((FairyGUI.UIObjectFactory).NewObject)((FairyGUI.ObjectType).Graph))
  local effect = nil
  if effectName then
    effect = (ResHelper.InstantiateEffect)(effectName)
    if effect then
      if localEulerAngles then
        (CSLuaUtil.SetGOLocalEuler)(effect, localEulerAngles.x, localEulerAngles.y, localEulerAngles.z)
      end
      if scale then
        (CSLuaUtil.SetGOScale)(effect, scale, scale, scale, true)
      end
      local wrapper = (FairyGUI.GoWrapper)(effect)
      wrapper.DestroyAction = function(go, ...)
    -- function num : 0_0_0 , upvalues : _ENV
    (ResHelper.DestroyGameObject)(go, false)
  end

      local goWrapper = ((wrapper.cachedTransform).gameObject):GetOrAddComponent(typeof(CS.GoWrapperTools))
      goWrapper.goWrapper = wrapper
      goWrapper.DisableIsDestroy = DisableIsDestroy
      goWrapper.PlayOverIsDestroy = PlayOverIsDestroy
      wrapper.supportStencil = true
      holder:SetNativeObject(wrapper)
    end
  end
  do
    return holder, effect
  end
end

LuaEffect.CreateEffectToObj = function(effectName, PlayOverIsDestroy, parent, pos, localEulerAngles, scale, DisableIsDestroy, ...)
  -- function num : 0_1 , upvalues : LuaEffect
  local holder, effect = (LuaEffect.AddUIEffect)(effectName, PlayOverIsDestroy, DisableIsDestroy, localEulerAngles, scale)
  holder.xy = pos
  parent:AddChild(holder)
  return holder, effect
end

LuaEffect.PlayEffectByHolder = function(holder, parent, pos, childPos, ...)
  -- function num : 0_2 , upvalues : _ENV
  if not holder then
    return 
  end
  holder.visible = true
  local sfx = (((holder.displayObject).cachedTransform):GetChild(0)):GetComponentInChildren(typeof((CS.UnityEngine).ParticleSystem), true)
  if sfx then
    sfx:Play(true)
  end
  if pos then
    holder.xy = pos
  end
  holder.name = "mSfx"
  if parent then
    if childPos then
      parent:AddChildAt(holder, childPos)
    else
      parent:AddChild(holder)
    end
  end
end

LuaEffect.DestroyEffect = function(holder, ...)
  -- function num : 0_3 , upvalues : _ENV
  if not holder or not (holder.displayObject).cachedTransform then
    return 
  end
  ;
  (ResHelper.DestroyGameObject)(((holder.displayObject).cachedTransform).gameObject, false)
end

LuaEffect.AddNotDeletedUIEffect = function(effectName, localEulerAngles, scale, ...)
  -- function num : 0_4 , upvalues : _ENV
  local effect = nil
  local holder = ((FairyGUI.UIObjectFactory).NewObject)((FairyGUI.ObjectType).Graph)
  if effectName then
    effect = (ResHelper.InstantiateEffect)(effectName)
    if effect then
      (CSLuaUtil.SetGOLocalPos)(effect, 0, 0, 0)
      if localEulerAngles then
        (CSLuaUtil.SetGOLocalEuler)(effect, localEulerAngles.x, localEulerAngles.y, localEulerAngles.z)
      end
      if scale then
        (CSLuaUtil.SetGOScale)(effect, scale, scale, scale, true)
      end
      local wrapper = (FairyGUI.GoWrapper)(effect)
      wrapper.DestroyAction = function(go, ...)
    -- function num : 0_4_0 , upvalues : _ENV
    (ResHelper.DestroyGameObject)(go, true)
  end

      wrapper.supportStencil = true
      holder:SetNativeObject(wrapper)
    end
  end
  do
    return holder, effect
  end
end

LuaEffect.GetEffectDuration = function(gameObject, ...)
  -- function num : 0_5 , upvalues : _ENV
  local time = (CSLuaUtil.ParticleSystemLength)(gameObject)
  do
    if time <= 0 then
      local animator = gameObject:GetComponentInChildren(typeof((CS.UnityEngine).Animator), true)
      if animator then
        time = (animator:GetCurrentAnimatorStateInfo(0)).length
      end
    end
    return time
  end
end

return LuaEffect

