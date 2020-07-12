-- params : ...
-- function num : 0 , upvalues : _ENV
local csEventID = CS.EventID
EventID = {DoQuset = 6000100}
setmetatable(EventID, {__index = function(t, k, ...)
  -- function num : 0_0 , upvalues : csEventID
  local value = csEventID[k]
  if value ~= nil then
    t[k] = value
    return value
  end
end
})

