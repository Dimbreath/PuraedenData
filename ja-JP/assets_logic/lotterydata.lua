-- params : ...
-- function num : 0 , upvalues : _ENV
LotteryData = {
lotteryData = {}
, selectedLotteryIndex = 1, curCostType = 1, isFreshLine = false}
local ClickedType = {One = 1, Ten = 2}
-- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

LotteryData.SaveLotteryData = function(data, type, ...)
  -- function num : 0_0 , upvalues : _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  LotteryData.lotteryData = {type = 0, 
data = {}
}
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (LotteryData.lotteryData).type = type
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (LotteryData.lotteryData).data = data
end

-- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

LotteryData.GetLotteryData = function(...)
  -- function num : 0_1 , upvalues : _ENV
  return LotteryData.lotteryData
end

-- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

LotteryData.SubFreeNumber = function(lId, num, ...)
  -- function num : 0_2 , upvalues : _ENV, ClickedType
  print("=============删减免费抽卡次数", lId, num)
  local excelData = ((TableData.gTable).BaseLotteryData)[lId]
  local clickedType = excelData.mode
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R4 in 'UnsetPending'

  -- DECOMPILER ERROR at PC22: Unhandled construct in 'MakeBoolean' P1

  if clickedType == ClickedType.One and ((LotteryData.lotteryData).data).onceFreeNum > 0 then
    ((LotteryData.lotteryData).data).onceFreeNum = num
  end
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R4 in 'UnsetPending'

  if clickedType == ClickedType.Ten and ((LotteryData.lotteryData).data).moreFreeNum > 0 then
    ((LotteryData.lotteryData).data).moreFreeNum = num
  end
end

-- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

LotteryData.SetCDTime = function(lId, cdTime, ...)
  -- function num : 0_3 , upvalues : _ENV, ClickedType
  local excelData = ((TableData.gTable).BaseLotteryData)[lId]
  local clickedType = excelData.mode
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R4 in 'UnsetPending'

  if clickedType == ClickedType.One then
    ((LotteryData.lotteryData).data).onceCdTime = cdTime
  else
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R4 in 'UnsetPending'

    if clickedType == ClickedType.Ten then
      ((LotteryData.lotteryData).data).moreCdTime = cdTime
    end
  end
end

-- DECOMPILER ERROR at PC24: Confused about usage of register: R1 in 'UnsetPending'

LotteryData.SetDayState = function(state, ...)
  -- function num : 0_4 , upvalues : _ENV
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  ((LotteryData.lotteryData).data).dayLottery = state
end

-- DECOMPILER ERROR at PC27: Confused about usage of register: R1 in 'UnsetPending'

LotteryData.SaveSelectedLotteryIndex = function(index, ...)
  -- function num : 0_5 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  LotteryData.selectedLotteryIndex = index
end

-- DECOMPILER ERROR at PC30: Confused about usage of register: R1 in 'UnsetPending'

LotteryData.GetSelectedLotteryIndex = function(...)
  -- function num : 0_6 , upvalues : _ENV
  return LotteryData.selectedLotteryIndex
end

-- DECOMPILER ERROR at PC33: Confused about usage of register: R1 in 'UnsetPending'

LotteryData.SaveCurCostMode = function(index, ...)
  -- function num : 0_7 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  LotteryData.curCostType = index
end

-- DECOMPILER ERROR at PC36: Confused about usage of register: R1 in 'UnsetPending'

LotteryData.GetCurCostMode = function(...)
  -- function num : 0_8 , upvalues : _ENV
  return LotteryData.curCostType
end

-- DECOMPILER ERROR at PC39: Confused about usage of register: R1 in 'UnsetPending'

LotteryData.SubFreshSingleNum = function(num, ...)
  -- function num : 0_9 , upvalues : _ENV
  loge("------减少新手扭蛋单抽次数      " .. tostring(num))
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

  if ((LotteryData.lotteryData).data).onceSurplusNum then
    ((LotteryData.lotteryData).data).onceSurplusNum = ((LotteryData.lotteryData).data).onceSurplusNum - num
  end
end

-- DECOMPILER ERROR at PC42: Confused about usage of register: R1 in 'UnsetPending'

LotteryData.GetIsFreshLine = function(...)
  -- function num : 0_10 , upvalues : _ENV
  return LotteryData.isFreshLine
end

-- DECOMPILER ERROR at PC45: Confused about usage of register: R1 in 'UnsetPending'

LotteryData.SetIsFreshLine = function(isF, ...)
  -- function num : 0_11 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  LotteryData.isFreshLine = isF
end

-- DECOMPILER ERROR at PC48: Confused about usage of register: R1 in 'UnsetPending'

LotteryData.GetFreshSingleNum = function(...)
  -- function num : 0_12 , upvalues : _ENV
  return ((LotteryData.lotteryData).data).onceSurplusNum or 0
end

-- DECOMPILER ERROR at PC51: Confused about usage of register: R1 in 'UnsetPending'

LotteryData.SubFreshTenNum = function(num, ...)
  -- function num : 0_13 , upvalues : _ENV
  loge("------减少新手扭蛋十连次数      " .. tostring(num))
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

  if ((LotteryData.lotteryData).data).moreSurplusNum then
    ((LotteryData.lotteryData).data).moreSurplusNum = ((LotteryData.lotteryData).data).moreSurplusNum - num
  end
end

-- DECOMPILER ERROR at PC54: Confused about usage of register: R1 in 'UnsetPending'

LotteryData.GetFreshTenNum = function(...)
  -- function num : 0_14 , upvalues : _ENV
  return ((LotteryData.lotteryData).data).moreSurplusNum or 0
end

-- DECOMPILER ERROR at PC57: Confused about usage of register: R1 in 'UnsetPending'

LotteryData.CheckFreshHaveNum = function(...)
  -- function num : 0_15 , upvalues : _ENV
  local singleNum = (LotteryData.GetFreshSingleNum)()
  local tenNum = (LotteryData.GetFreshTenNum)()
  print("===========singleNum=", singleNum, tenNum)
  do return singleNum > 0 or tenNum > 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end


