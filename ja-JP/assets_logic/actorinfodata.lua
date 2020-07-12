-- params : ...
-- function num : 0 , upvalues : _ENV
ActorInfoData = {
headList = {}
, curSelectedHeadID = -1}
-- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

ActorInfoData.GetCurSelectedHeadID = function(...)
  -- function num : 0_0 , upvalues : _ENV
  return ActorInfoData.curSelectedHeadID
end

-- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

ActorInfoData.SortList = function(a, b, ...)
  -- function num : 0_1
  if b.id >= a.id then
    do return a.star ~= b.star end
    do return b.star < a.star end
    -- DECOMPILER ERROR: 4 unprocessed JMP targets
  end
end


