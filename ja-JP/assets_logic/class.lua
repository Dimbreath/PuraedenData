-- params : ...
-- function num : 0 , upvalues : _ENV
class = function(classname, super, ...)
  -- function num : 0_0 , upvalues : _ENV
  local superType = (type(super))
  -- DECOMPILER ERROR at PC3: Overwrote pending register: R3 in 'AssignReg'

  local cls = .end
  if superType ~= "function" and superType ~= "table" then
    super, superType = nil
  end
  if superType == "function" or super and super.__ctype == 1 then
    cls = {}
    if superType == "table" then
      for k,v in pairs(super) do
        cls[k] = v
      end
      cls.__create = super.__create
      cls.super = super
    else
      cls.__create = super
    end
    cls.ctor = function(...)
    -- function num : 0_0_0
  end

    cls.__cname = classname
    cls.__ctype = 1
    cls.new = function(...)
    -- function num : 0_0_1 , upvalues : cls, _ENV
    local instance = (cls.__create)(...)
    for k,v in pairs(cls) do
      instance[k] = v
    end
    instance.class = cls
    instance:ctor(...)
    return instance
  end

  else
    if super then
      cls = clone(super)
      cls.super = super
    else
      cls = {ctor = function(...)
    -- function num : 0_0_2
  end
}
    end
    cls.__cname = classname
    cls.__ctype = 2
    cls.__index = cls
    cls.new = function(...)
    -- function num : 0_0_3 , upvalues : _ENV, cls
    local instance = setmetatable({}, cls)
    instance.class = cls
    instance:ctor(...)
    return instance
  end

  end
  return cls
end


