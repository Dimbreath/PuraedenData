-- params : ...
-- function num : 0 , upvalues : _ENV
HandBookData = {
fetterData = {}
, 
allReadyFetterList = {}
, curClickedFetterTreeId = nil}
local self = HandBookData
-- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

HandBookData.CheckFetterData = function(fetterList, ...)
  -- function num : 0_0 , upvalues : _ENV, self
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  if fetterList then
    HandBookData.allReadyFetterList = fetterList
  end
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self.fetterData).fetterTree = {}
  for k,v in pairs((TableData.gTable).BaseCardFetterShowData) do
    (table.insert)((self.fetterData).fetterTree, {treeId = v.fetter_tree_ids, 
allCardsIds = {}
, 
allFetterIds = {}
, 
allReadyFetterIds = {}
, 
canFetterIds = {}
})
  end
  for k,v in ipairs((self.fetterData).fetterTree) do
    local showData = ((TableData.gTable).BaseCardFetterShowData)[k]
    local allFetIds = split(showData.fetter_ids, ":")
    local allCdIds = split(showData.card_ids, ":")
    for index,value in ipairs(allFetIds) do
      (table.insert)(v.allFetterIds, tonumber(value))
    end
    for index,value in ipairs(allCdIds) do
      (table.insert)(v.allCardsIds, tonumber(value))
    end
    for index,value in ipairs(v.allFetterIds) do
      local tmpId = (HandBookData.CheckIsAllReadyFetterByFetterId)(value, HandBookData.allReadyFetterList)
      if tmpId then
        (table.insert)(v.allReadyFetterIds, tmpId)
      end
    end
    local baseCanFetterIds = (HandBookData.GetBaseCanFetterId)(v.allFetterIds, v.allReadyFetterIds)
    for index,value in ipairs(baseCanFetterIds) do
      local canFetter = true
      local fetterData = ((TableData.gTable).BaseCardFetterData)[value]
      local isAllCardsGet = (HandBookData.CheckIsGetAllCars)(v.allCardsIds)
      if canFetter then
        canFetter = isAllCardsGet
      end
      if canFetter and canFetter then
        canFetter = (HandBookData.CheckIsStarQualitySatisfy)(value, v.allCardsIds)
      end
      if canFetter then
        (table.insert)(v.canFetterIds, value)
      end
    end
  end
  local canActice = false
  for k,v in ipairs((self.fetterData).fetterTree) do
    if #v.canFetterIds > 0 then
      canActice = true
      break
    end
  end
  do
    print("-------HandBook_Relation--canActice", canActice)
    ;
    (RedDotMgr.ProcessRedDot)(RedDotComID.HandBook_Relation, nil, canActice)
    ;
    (RedDotMgr.RefreshTreeUI)((WinResConfig.HandBookMainWindow).name)
    ;
    (HandBookData.SortAllRelationTree)((self.fetterData).fetterTree)
  end
end

-- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

HandBookData.GetCanActiveBySingleCardId = function(cardId, ...)
  -- function num : 0_1 , upvalues : _ENV, self
  local canActice = false
  for k,v in ipairs((self.fetterData).fetterTree) do
    local cardIds = v.allCardsIds
    for n,m in ipairs(cardIds) do
      if m == cardId and #v.canFetterIds > 0 then
        canActice = true
        return canActice
      end
    end
  end
  return canActice
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

HandBookData.CheckIsStarQualitySatisfy = function(fetterId, cardIds, ...)
  -- function num : 0_2 , upvalues : _ENV
  local fetterData = ((TableData.gTable).BaseCardFetterData)[fetterId]
  local star = fetterData.star
  local quality = fetterData.quality
  local isSatisfy = true
  for index,value in ipairs(cardIds) do
    local cardData = (CardData.GetCardData)(value)
    if star <= cardData.star and quality <= cardData.quality then
      isSatisfy = true
    else
      isSatisfy = false
    end
  end
  do
    if isSatisfy ~= false then
      return isSatisfy
    end
  end
end

-- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

HandBookData.CheckIsGetAllCars = function(cards, ...)
  -- function num : 0_3 , upvalues : _ENV
  local isSatisfy = true
  for index,value in ipairs(cards) do
    if isSatisfy then
      isSatisfy = (CardData.IsObtained)(value)
    end
  end
  do
    if isSatisfy ~= false then
      return isSatisfy
    end
  end
end

-- DECOMPILER ERROR at PC22: Confused about usage of register: R1 in 'UnsetPending'

HandBookData.GetBaseCanFetterId = function(allIds, allReadyIds, ...)
  -- function num : 0_4 , upvalues : _ENV
  local baseCanId = {}
  for index,value in ipairs(allIds) do
    local isAllReadyFetter = false
    for i,j in ipairs(allReadyIds) do
      if j == value then
        isAllReadyFetter = true
        break
      end
    end
    do
      do
        if isAllReadyFetter == false then
          (table.insert)(baseCanId, value)
        end
        -- DECOMPILER ERROR at PC23: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  return baseCanId
end

-- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'

HandBookData.CheckIsAllReadyFetterByFetterId = function(fetterId, fetterList, ...)
  -- function num : 0_5 , upvalues : _ENV
  for index,value in ipairs(fetterList) do
    if value == fetterId then
      return fetterId
    end
  end
end

-- DECOMPILER ERROR at PC28: Confused about usage of register: R1 in 'UnsetPending'

HandBookData.GetFetterDataByFetterTreeId = function(treeId, ...)
  -- function num : 0_6 , upvalues : _ENV, self
  for index,value in ipairs((self.fetterData).fetterTree) do
    if treeId == value.treeId then
      return value
    end
  end
end

-- DECOMPILER ERROR at PC31: Confused about usage of register: R1 in 'UnsetPending'

HandBookData.GetAllInfo = function(...)
  -- function num : 0_7 , upvalues : self
  return (self.fetterData).fetterTree
end

-- DECOMPILER ERROR at PC34: Confused about usage of register: R1 in 'UnsetPending'

HandBookData.SaveAllInfo = function(tab, ...)
  -- function num : 0_8 , upvalues : self
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  if tab then
    (self.fetterData).fetterTree = tab
  end
end

-- DECOMPILER ERROR at PC37: Confused about usage of register: R1 in 'UnsetPending'

HandBookData.GetRelationInfoById = function(treeId, ...)
  -- function num : 0_9 , upvalues : _ENV, self
  for index,value in ipairs((self.fetterData).fetterTree) do
    if value.treeId == treeId then
      return value
    end
  end
end

-- DECOMPILER ERROR at PC40: Confused about usage of register: R1 in 'UnsetPending'

HandBookData.GetRelationIndexById = function(treeId, ...)
  -- function num : 0_10 , upvalues : _ENV, self
  local indexX = 1
  for index,value in ipairs((self.fetterData).fetterTree) do
    if value.treeId == treeId then
      return indexX
    end
    indexX = indexX + 1
  end
end

-- DECOMPILER ERROR at PC43: Confused about usage of register: R1 in 'UnsetPending'

HandBookData.SortAllRelationTree = function(tab, ...)
  -- function num : 0_11 , upvalues : _ENV
  (table.sort)(tab, function(a, b, ...)
    -- function num : 0_11_0
    if a.treeId >= b.treeId then
      do return #a.canFetterIds ~= #b.canFetterIds end
      do return #b.canFetterIds < #a.canFetterIds end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
end

-- DECOMPILER ERROR at PC46: Confused about usage of register: R1 in 'UnsetPending'

HandBookData.SetFetterDataByFetterTreeId = function(newFetId, ...)
  -- function num : 0_12 , upvalues : _ENV
  (table.insert)(HandBookData.allReadyFetterList, newFetId)
  ;
  (HandBookData.CheckFetterData)()
end

-- DECOMPILER ERROR at PC49: Confused about usage of register: R1 in 'UnsetPending'

HandBookData.GetAllActivationFetterId = function(...)
  -- function num : 0_13 , upvalues : _ENV
  if not HandBookData.allReadyFetterList then
    return {}
  end
end

-- DECOMPILER ERROR at PC52: Confused about usage of register: R1 in 'UnsetPending'

HandBookData.SaveCurClickedFetterTreeId = function(baseId, ...)
  -- function num : 0_14 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  HandBookData.curClickedFetterTreeId = baseId
end

-- DECOMPILER ERROR at PC55: Confused about usage of register: R1 in 'UnsetPending'

HandBookData.GetCurClickedFetterTreeId = function(...)
  -- function num : 0_15 , upvalues : _ENV, self
  if not HandBookData.curClickedFetterTreeId then
    return (((self.fetterData).fetterTree)[1]).treeId
  end
end


