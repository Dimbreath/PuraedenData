-- params : ...
-- function num : 0 , upvalues : _ENV
SlotsData = {}
-- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

SlotsData.SlotType = {ACTIVITY_SLOT = 1}
local self = SlotsData
-- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

SlotsData.SlotRound = function(round, ...)
  -- function num : 0_0 , upvalues : self
  if round == nil then
    return self.round
  else
    self.round = round
  end
end

-- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

SlotsData.ChangeRound = function(round, ...)
  -- function num : 0_1 , upvalues : self
  if round == nil then
    return self.roundChange
  else
    self.roundChange = round
  end
end

-- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

SlotsData.ChangeTotalRound = function(round, ...)
  -- function num : 0_2 , upvalues : self
  if round == nil then
    return self.roundTotalChange
  else
    self.roundTotalChange = round
  end
end

-- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

SlotsData.GetCurrentType = function(...)
  -- function num : 0_3 , upvalues : _ENV
  return (SlotsData.SlotType).ACTIVITY_SLOT
end

-- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

SlotsData.CanReset = function(reset, ...)
  -- function num : 0_4 , upvalues : self
  if reset == nil then
    return self.Reset
  else
    self.Reset = reset
  end
end

-- DECOMPILER ERROR at PC24: Confused about usage of register: R1 in 'UnsetPending'

SlotsData.GetItemData = function(data, ...)
  -- function num : 0_5 , upvalues : self
  self.ItemData = data
end

-- DECOMPILER ERROR at PC27: Confused about usage of register: R1 in 'UnsetPending'

SlotsData.SetRoundItemData = function(Items, ...)
  -- function num : 0_6 , upvalues : _ENV, self
  local isContain = false
  for _,v in ipairs(self.ItemData) do
    if v.round == Items.round then
      v.data = Items.data
      isContain = true
    end
  end
  if not isContain then
    (table.insert)(self.ItemData, Items)
  end
end

-- DECOMPILER ERROR at PC30: Confused about usage of register: R1 in 'UnsetPending'

SlotsData.GetItemTimes = function(round, poolId, ...)
  -- function num : 0_7 , upvalues : _ENV, self
  local mData = nil
  for _,v in ipairs(self.ItemData) do
    if v.round == round then
      mData = v.data
    end
  end
  if mData == -1 then
    return -1
  end
  if mData == nil then
    return 0
  end
  for _,v in ipairs(mData) do
    if v.SlotsPoolId == poolId then
      return v.GetNum
    end
  end
  return 0
end


