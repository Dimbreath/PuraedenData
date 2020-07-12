-- params : ...
-- function num : 0 , upvalues : _ENV
BattleChoose = {}
local self = BattleChoose
local t_insert = table.insert
local t_remove = table.remove
local t_sort = table.sort
local ipairs = ipairs
local math = math
-- DECOMPILER ERROR at PC13: Confused about usage of register: R6 in 'UnsetPending'

BattleChoose.GetAtkTarget = function(atkCard, skillInfo, ...)
  -- function num : 0_0 , upvalues : self
  if not skillInfo or not (self.GetTargetCardsByTargetId)(atkCard, skillInfo.targetType, nil, nil, skillInfo) then
    return {}
  end
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R6 in 'UnsetPending'

BattleChoose.GetAssistCardList = function(atkCard, assistNum, notIncludeCannotMove, ...)
  -- function num : 0_1 , upvalues : self, _ENV, t_remove, ipairs, t_insert
  local returnCardTable = {}
  local cardTable = (self.GetRandomCards)(atkCard, true, 10, true, notIncludeCannotMove or true)
  for i = #cardTable, 1, -1 do
    local card = cardTable[i]
    if (BattleBuff.IsForbiddenAssistPassive)(card) == true then
      t_remove(cardTable, i)
    end
  end
  for i,v in ipairs(cardTable) do
    if i <= assistNum then
      t_insert(returnCardTable, v)
    end
  end
  return returnCardTable
end

-- DECOMPILER ERROR at PC19: Confused about usage of register: R6 in 'UnsetPending'

BattleChoose.GetCardsBySide = function(atkCard, isSameSide, notIncludeSelf, notIncludeCannotMove, ...)
  -- function num : 0_2 , upvalues : self, _ENV, ipairs, t_insert
  local cards = {}
  local cardList = nil
  if self.onlyChoosePos == true then
    cardList = self.allCardList
  else
    cardList = BattleData.allCardList
  end
  for i,v in ipairs(cardList) do
    -- DECOMPILER ERROR at PC42: Unhandled construct in 'MakeBoolean' P1

    -- DECOMPILER ERROR at PC42: Unhandled construct in 'MakeBoolean' P1

    if v:GetHp() > 0 and (notIncludeCannotMove ~= true or v:IsDisplayAlive() == true) and isSameSide == true and v:GetCampFlag() == atkCard:GetCampFlag() and (not notIncludeSelf or v:GetPosIndex() ~= atkCard:GetPosIndex()) then
      t_insert(cards, v)
    end
    -- DECOMPILER ERROR at PC55: Unhandled construct in 'MakeBoolean' P1

    if isSameSide == false and v:GetCampFlag() ~= atkCard:GetCampFlag() then
      t_insert(cards, v)
    end
    if isSameSide == nil and (not notIncludeSelf or v:GetPosIndex() ~= atkCard:GetPosIndex()) then
      t_insert(cards, v)
    end
  end
  return cards
end

-- DECOMPILER ERROR at PC22: Confused about usage of register: R6 in 'UnsetPending'

BattleChoose.GetCardsByCross = function(atkCard, isSameSide, ...)
  -- function num : 0_3 , upvalues : self, _ENV, ipairs, t_insert
  local cardList = nil
  if self.onlyChoosePos == true then
    cardList = self.allCardList
  else
    cardList = BattleData.allCardList
  end
  local cards = {}
  local targetPos = nil
  if isSameSide ~= true then
    local targetCard = (self.GetNormalAttackCard)(atkCard)
    targetPos = targetCard:GetPosIndex()
  else
    do
      targetPos = atkCard:GetPosIndex()
      for i,v in ipairs(cardList) do
        if v:GetHp() > 0 then
          local posIndex = v:GetPosIndex()
          -- DECOMPILER ERROR at PC57: Unhandled construct in 'MakeBoolean' P1

          if isSameSide == true and v:GetCampFlag() == atkCard:GetCampFlag() and (posIndex == targetPos or posIndex == targetPos - 1 or posIndex == targetPos + 1 or posIndex == targetPos + 10 or posIndex == targetPos - 10) then
            t_insert(cards, v)
          end
        end
        if v:GetCampFlag() ~= atkCard:GetCampFlag() and (posIndex == targetPos or posIndex == targetPos - 1 or posIndex == targetPos + 1 or posIndex == targetPos + 10 or posIndex == targetPos - 10) then
          t_insert(cards, v)
        end
      end
      return cards
    end
  end
end

-- DECOMPILER ERROR at PC25: Confused about usage of register: R6 in 'UnsetPending'

BattleChoose.GetCardsByAround = function(atkCard, isSameSide, ...)
  -- function num : 0_4 , upvalues : self, _ENV, ipairs, t_insert
  local cardList = nil
  if self.onlyChoosePos == true then
    cardList = self.allCardList
  else
    cardList = BattleData.allCardList
  end
  local cards = {}
  local targetPos = nil
  if isSameSide ~= true then
    if atkCard:GetPosIndex() <= 100 or not atkCard:GetPosIndex() - 100 then
      targetPos = atkCard:GetPosIndex() + 100
      targetPos = atkCard:GetPosIndex()
      for i,v in ipairs(cardList) do
        if v:GetHp() > 0 then
          local posIndex = v:GetPosIndex()
          -- DECOMPILER ERROR at PC75: Unhandled construct in 'MakeBoolean' P1

          if isSameSide == true and v:GetCampFlag() == atkCard:GetCampFlag() and (posIndex == targetPos or posIndex == targetPos - 1 or posIndex == targetPos + 1 or posIndex == targetPos + 10 or posIndex == targetPos - 10 or posIndex == targetPos - 11 or posIndex == targetPos + 11 or posIndex == targetPos - 9 or posIndex == targetPos + 9) then
            t_insert(cards, v)
          end
        end
        if v:GetCampFlag() ~= atkCard:GetCampFlag() and (posIndex == targetPos or posIndex == targetPos - 1 or posIndex == targetPos + 1 or posIndex == targetPos + 10 or posIndex == targetPos - 10 or posIndex == targetPos - 11 or posIndex == targetPos + 11 or posIndex == targetPos - 9 or posIndex == targetPos + 9) then
          t_insert(cards, v)
        end
      end
      return cards
    end
  end
end

-- DECOMPILER ERROR at PC28: Confused about usage of register: R6 in 'UnsetPending'

BattleChoose.GetRandomCardsByAround = function(atkCard, isSameSide, randomNum, ...)
  -- function num : 0_5 , upvalues : _ENV
  local cardList = (BattleChoose.GetCardsByAround)(atkCard, isSameSide)
  local cards = (BattleChoose.GetRandomCards)(nil, nil, randomNum, true, nil, cardList)
  return cards
end

-- DECOMPILER ERROR at PC31: Confused about usage of register: R6 in 'UnsetPending'

BattleChoose.GetFrontCards = function(atkCard, isSameSide, notIncludeSelf, ...)
  -- function num : 0_6 , upvalues : self, ipairs, t_insert
  local cardList = (self.GetCardsBySide)(atkCard, isSameSide, notIncludeSelf)
  local cards = {}
  for i,v in ipairs(cardList) do
    local posIndex = v:GetPosIndex()
    if (posIndex > 0 and posIndex < 4) or posIndex > 100 and posIndex < 104 then
      t_insert(cards, v)
    end
  end
  return cards
end

-- DECOMPILER ERROR at PC34: Confused about usage of register: R6 in 'UnsetPending'

BattleChoose.GetBehindCards = function(atkCard, isSameSide, notIncludeSelf, ...)
  -- function num : 0_7 , upvalues : self, ipairs, t_insert
  local cardList = (self.GetCardsBySide)(atkCard, isSameSide, notIncludeSelf)
  local cards = {}
  for i,v in ipairs(cardList) do
    local posIndex = v:GetPosIndex()
    if (posIndex > 10 and posIndex < 14) or posIndex > 110 and posIndex < 114 then
      t_insert(cards, v)
    end
  end
  return cards
end

-- DECOMPILER ERROR at PC37: Confused about usage of register: R6 in 'UnsetPending'

BattleChoose.GetCardHaveEffect = function(atkCard, effectId, isSameSide, ...)
  -- function num : 0_8 , upvalues : self, ipairs, _ENV, t_insert
  local cardList = (self.GetCardsBySide)(atkCard, isSameSide)
  local cards = {}
  for i,v in ipairs(cardList) do
    if (BattleBuff.ContainEffectId)(v, effectId) == true then
      t_insert(cards, v)
    end
  end
  return cards
end

-- DECOMPILER ERROR at PC40: Confused about usage of register: R6 in 'UnsetPending'

BattleChoose.GetNormalAttackCard = function(atkCard, ...)
  -- function num : 0_9 , upvalues : self, t_insert, ipairs
  local otherCards = (self.GetCardsBySide)(atkCard, false)
  local posIndex = atkCard:GetPosIndex()
  local addPos = posIndex > 100 and 0 or 100
  local tPos = posIndex % 10
  local posLst = {}
  for i = 1, tPos do
    t_insert(posLst, tPos - i + 1 + addPos)
  end
  for i = tPos + 1, 3 do
    t_insert(posLst, i + addPos)
  end
  for i = 1, tPos do
    t_insert(posLst, tPos - i + 1 + 10 + addPos)
  end
  for i = tPos + 1, 3 do
    t_insert(posLst, i + 10 + addPos)
  end
  for k,v in ipairs(posLst) do
    for i,card in ipairs(otherCards) do
      if card:GetPosIndex() == v and card:GetHp() > 0 then
        return card
      end
    end
  end
end

-- DECOMPILER ERROR at PC43: Confused about usage of register: R6 in 'UnsetPending'

BattleChoose.GetAttackCardBehind = function(atkCard, ...)
  -- function num : 0_10 , upvalues : self, t_insert, ipairs
  local otherCards = (self.GetCardsBySide)(atkCard, false)
  local posIndex = atkCard:GetPosIndex()
  local addPos = posIndex > 100 and 0 or 100
  local tPos = posIndex % 10
  local posLst = {}
  for i = 1, tPos do
    t_insert(posLst, tPos - i + 1 + 10 + addPos)
  end
  for i = tPos + 1, 3 do
    t_insert(posLst, i + 10 + addPos)
  end
  for i = 1, tPos do
    t_insert(posLst, tPos - i + 1 + addPos)
  end
  for i = tPos + 1, 3 do
    t_insert(posLst, i + addPos)
  end
  for k,v in ipairs(posLst) do
    for i,card in ipairs(otherCards) do
      if card:GetPosIndex() == v and card:GetHp() > 0 then
        return card
      end
    end
  end
end

-- DECOMPILER ERROR at PC46: Confused about usage of register: R6 in 'UnsetPending'

BattleChoose.GetVerticalCards = function(atkCard, isSameSide, notIncludeSelf, ...)
  -- function num : 0_11 , upvalues : self, _ENV, ipairs, t_insert
  local cardList = nil
  if self.onlyChoosePos == true then
    cardList = self.allCardList
  else
    cardList = BattleData.allCardList
  end
  local cards = {}
  local targetPos = nil
  if isSameSide ~= true then
    local targetCard = (self.GetNormalAttackCard)(atkCard)
    targetPos = targetCard:GetPosIndex()
  else
    do
      targetPos = atkCard:GetPosIndex()
      for _,v in ipairs(cardList) do
        if v:GetHp() > 0 then
          local posIndex = v:GetPosIndex()
          -- DECOMPILER ERROR at PC55: Unhandled construct in 'MakeBoolean' P1

          -- DECOMPILER ERROR at PC55: Unhandled construct in 'MakeBoolean' P1

          -- DECOMPILER ERROR at PC55: Unhandled construct in 'MakeBoolean' P1

          if isSameSide == true and v:GetCampFlag() == atkCard:GetCampFlag() and (posIndex == targetPos + 10 or posIndex == targetPos - 10 or posIndex == targetPos) and notIncludeSelf == true and targetPos ~= posIndex then
            t_insert(cards, v)
          end
        end
        t_insert(cards, v)
        if v:GetCampFlag() ~= atkCard:GetCampFlag() and (posIndex == targetPos + 10 or posIndex == targetPos - 10 or posIndex == targetPos) then
          t_insert(cards, v)
        end
      end
      return cards
    end
  end
end

-- DECOMPILER ERROR at PC49: Confused about usage of register: R6 in 'UnsetPending'

BattleChoose.GetHorizontalCards = function(atkCard, isSameSide, ...)
  -- function num : 0_12 , upvalues : self, _ENV, ipairs, t_insert
  local cardList = nil
  if self.onlyChoosePos == true then
    cardList = self.allCardList
  else
    cardList = BattleData.allCardList
  end
  local cards = {}
  local targetPos = nil
  if isSameSide ~= true then
    local targetCard = (self.GetNormalAttackCard)(atkCard)
    targetPos = targetCard:GetPosIndex()
  else
    do
      targetPos = atkCard:GetPosIndex()
      for i,v in ipairs(cardList) do
        if v:GetHp() > 0 then
          local posIndex = v:GetPosIndex()
          -- DECOMPILER ERROR at PC57: Unhandled construct in 'MakeBoolean' P1

          if isSameSide == true and v:GetCampFlag() == atkCard:GetCampFlag() and (posIndex == targetPos or posIndex == targetPos - 1 or posIndex == targetPos + 1 or posIndex == targetPos + 2 or posIndex == targetPos - 2) then
            t_insert(cards, v)
          end
        end
        if v:GetCampFlag() ~= atkCard:GetCampFlag() and (posIndex == targetPos or posIndex == targetPos - 1 or posIndex == targetPos + 1 or posIndex == targetPos + 2 or posIndex == targetPos - 2) then
          t_insert(cards, v)
        end
      end
      return cards
    end
  end
end

-- DECOMPILER ERROR at PC52: Confused about usage of register: R6 in 'UnsetPending'

BattleChoose.GetTopDanderCards = function(atkCard, isSameSide, topNum, isReverse, ...)
  -- function num : 0_13 , upvalues : self, ipairs, _ENV, t_sort, t_insert
  if self.onlyChoosePos == true then
    return {}
  end
  local cards = {}
  local cardList = (self.GetCardsBySide)(atkCard, isSameSide)
  for _,v in ipairs(cardList) do
    v.tempRandom = (BattleData.GetRandomSeed)()
  end
  t_sort(cardList, function(a, b, ...)
    -- function num : 0_13_0 , upvalues : isReverse
    if a.tempRandom >= b.tempRandom then
      do return a:GetDander() ~= b:GetDander() end
      if a:GetDander() >= b:GetDander() then
        do return not isReverse end
        do return b:GetDander() < a:GetDander() end
        -- DECOMPILER ERROR: 6 unprocessed JMP targets
      end
    end
  end
)
  if not topNum then
    topNum = 6
  end
  for i = 1, topNum do
    if cardList[i] then
      t_insert(cards, cardList[i])
    end
  end
  return cards
end

-- DECOMPILER ERROR at PC55: Confused about usage of register: R6 in 'UnsetPending'

BattleChoose.GetTopHpCards = function(atkCard, isSameSide, topNum, isReverse, notIncludeSelf, ...)
  -- function num : 0_14 , upvalues : self, ipairs, _ENV, t_sort, t_insert
  if self.onlyChoosePos == true then
    return {}
  end
  local cards = {}
  local cardList = (self.GetCardsBySide)(atkCard, isSameSide, notIncludeSelf)
  for _,v in ipairs(cardList) do
    v.tempRandom = (BattleData.GetRandomSeed)()
  end
  t_sort(cardList, function(a, b, ...)
    -- function num : 0_14_0 , upvalues : isReverse
    if a.tempRandom >= b.tempRandom then
      do return a:GetHp() / a:GetMaxHp() ~= b:GetHp() / b:GetMaxHp() end
      if a:GetHp() / a:GetMaxHp() >= b:GetHp() / b:GetMaxHp() then
        do return not isReverse end
        do return b:GetHp() / b:GetMaxHp() < a:GetHp() / a:GetMaxHp() end
        -- DECOMPILER ERROR: 6 unprocessed JMP targets
      end
    end
  end
)
  if not topNum then
    topNum = 6
  end
  for i = 1, topNum do
    if cardList[i] then
      t_insert(cards, cardList[i])
    end
  end
  return cards
end

-- DECOMPILER ERROR at PC58: Confused about usage of register: R6 in 'UnsetPending'

BattleChoose.GetTopAtkCards = function(atkCard, isSameSide, topNum, isReverse, ...)
  -- function num : 0_15 , upvalues : self, ipairs, _ENV, t_sort, t_insert
  if self.onlyChoosePos == true then
    return {}
  end
  local cards = {}
  local cardList = (self.GetCardsBySide)(atkCard, isSameSide)
  for _,v in ipairs(cardList) do
    v.tempRandom = (BattleData.GetRandomSeed)()
  end
  t_sort(cardList, function(a, b, ...)
    -- function num : 0_15_0 , upvalues : isReverse
    if a.tempRandom >= b.tempRandom then
      do return a:GetAtk() ~= b:GetAtk() end
      if a:GetAtk() >= b:GetAtk() then
        do return not isReverse end
        do return b:GetAtk() < a:GetAtk() end
        -- DECOMPILER ERROR: 6 unprocessed JMP targets
      end
    end
  end
)
  if not topNum then
    topNum = 6
  end
  for i = 1, topNum do
    if cardList[i] then
      t_insert(cards, cardList[i])
    end
  end
  return cards
end

-- DECOMPILER ERROR at PC61: Confused about usage of register: R6 in 'UnsetPending'

BattleChoose.GetTopDefCards = function(atkCard, isSameSide, topNum, isReverse, ...)
  -- function num : 0_16 , upvalues : self, ipairs, _ENV, t_sort, t_insert
  if self.onlyChoosePos == true then
    return {}
  end
  local cards = {}
  local cardList = (self.GetCardsBySide)(atkCard, isSameSide)
  for _,v in ipairs(cardList) do
    v.tempRandom = (BattleData.GetRandomSeed)()
  end
  t_sort(cardList, function(a, b, ...)
    -- function num : 0_16_0 , upvalues : isReverse
    if a.tempRandom >= b.tempRandom then
      do return a:GetDef() ~= b:GetDef() end
      if a:GetDef() >= b:GetDef() then
        do return not isReverse end
        do return b:GetDef() < a:GetDef() end
        -- DECOMPILER ERROR: 6 unprocessed JMP targets
      end
    end
  end
)
  if not topNum then
    topNum = 6
  end
  for i = 1, topNum do
    if cardList[i] then
      t_insert(cards, cardList[i])
    end
  end
  return cards
end

-- DECOMPILER ERROR at PC64: Confused about usage of register: R6 in 'UnsetPending'

BattleChoose.GetRandomCards = function(atkCard, isSameSide, randomNum, notIncludeSelf, notIncludeCannotMove, cardsList, ...)
  -- function num : 0_17 , upvalues : self, ipairs, _ENV, t_sort, t_insert
  if self.onlyChoosePos == true then
    return {}
  end
  local cards = {}
  if not cardsList then
    local cardList = (self.GetCardsBySide)(atkCard, isSameSide, notIncludeSelf, notIncludeCannotMove)
  end
  for i,v in ipairs(cardList) do
    v.tempRandom = (BattleData.GetRandomSeed)()
  end
  t_sort(cardList, function(a, b, ...)
    -- function num : 0_17_0
    do return a.tempRandom < b.tempRandom end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  if not randomNum then
    randomNum = 6
  end
  for i = 1, randomNum do
    if cardList[i] then
      t_insert(cards, cardList[i])
    end
  end
  return cards
end

-- DECOMPILER ERROR at PC67: Confused about usage of register: R6 in 'UnsetPending'

BattleChoose.GetTargetPosByTargetId = function(atkPos, targetId, allCardPos, ...)
  -- function num : 0_18 , upvalues : self, ipairs, _ENV, t_insert
  self.onlyChoosePos = true
  self.allCardList = {}
  local atkCard = nil
  for _,pos in ipairs(allCardPos) do
    if pos <= 100 or not BattleCardCamp.RIGHT then
      local campFlag = BattleCardCamp.LEFT
    end
    local card = {posIndex = pos, campFlag = campFlag}
    card.GetPosIndex = function(self, ...)
    -- function num : 0_18_0
    return self.posIndex
  end

    card.GetCampFlag = function(self, ...)
    -- function num : 0_18_1
    return self.campFlag
  end

    card.GetHp = function(self, ...)
    -- function num : 0_18_2
    return 100
  end

    card.IsDisplayAlive = function(self, ...)
    -- function num : 0_18_3
    return true
  end

    if atkPos == pos then
      atkCard = card
    end
    t_insert(self.allCardList, card)
  end
  local targetCards = (BattleChoose.GetTargetCardsByTargetId)(atkCard, targetId)
  self.onlyChoosePos = false
  self.allCardList = {}
  return targetCards
end

-- DECOMPILER ERROR at PC70: Confused about usage of register: R6 in 'UnsetPending'

BattleChoose.GetTargetCardsByTargetId = function(atkCard, targetId, defCards, isBuff, skillConfig, ...)
  -- function num : 0_19 , upvalues : self, t_insert, math, _ENV
  local targetCards = {}
  local switch = {[1000] = function(...)
    -- function num : 0_19_0 , upvalues : self, targetCards, defCards
    if self.onlyChoosePos == true then
      targetCards = {}
      return 
    end
    targetCards = defCards
  end
, [2001] = function(...)
    -- function num : 0_19_1 , upvalues : self, atkCard, t_insert, targetCards
    local card = (self.GetNormalAttackCard)(atkCard)
    t_insert(targetCards, card)
  end
, [2002] = function(...)
    -- function num : 0_19_2 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetCardsBySide)(atkCard, false)
  end
, [2003] = function(...)
    -- function num : 0_19_3 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetCardsByCross)(atkCard, false)
  end
, [2004] = function(...)
    -- function num : 0_19_4 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetCardsByAround)(atkCard, false)
  end
, [2005] = function(...)
    -- function num : 0_19_5 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetFrontCards)(atkCard, false)
    if #targetCards == 0 then
      targetCards = (self.GetBehindCards)(atkCard, false)
    end
  end
, [2006] = function(...)
    -- function num : 0_19_6 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetBehindCards)(atkCard, false)
    if #targetCards == 0 then
      targetCards = (self.GetFrontCards)(atkCard, false)
    end
  end
, [2007] = function(...)
    -- function num : 0_19_7 , upvalues : self, atkCard, t_insert, targetCards
    local card = (self.GetAttackCardBehind)(atkCard)
    t_insert(targetCards, card)
  end
, [2008] = function(...)
    -- function num : 0_19_8 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetVerticalCards)(atkCard, false)
  end
, [2009] = function(...)
    -- function num : 0_19_9 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetHorizontalCards)(atkCard, false)
  end
, [2111] = function(...)
    -- function num : 0_19_10 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetTopDanderCards)(atkCard, false, 1)
  end
, [2112] = function(...)
    -- function num : 0_19_11 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetTopDanderCards)(atkCard, false, 2)
  end
, [2113] = function(...)
    -- function num : 0_19_12 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetTopDanderCards)(atkCard, false, 3)
  end
, [2120] = function(...)
    -- function num : 0_19_13 , upvalues : math, _ENV, targetCards, self, atkCard
    local randomNum = (math.ceil)((BattleData.GetRandomSeed)() * 6 / 10000)
    targetCards = (self.GetRandomCards)(atkCard, false, randomNum)
  end
, [2121] = function(...)
    -- function num : 0_19_14 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetRandomCards)(atkCard, false, 1)
  end
, [2122] = function(...)
    -- function num : 0_19_15 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetRandomCards)(atkCard, false, 2)
  end
, [2123] = function(...)
    -- function num : 0_19_16 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetRandomCards)(atkCard, false, 3)
  end
, [2124] = function(...)
    -- function num : 0_19_17 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetRandomCards)(atkCard, false, 4)
  end
, [2125] = function(...)
    -- function num : 0_19_18 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetRandomCards)(atkCard, false, 5)
  end
, [2126] = function(...)
    -- function num : 0_19_19 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetRandomCards)(atkCard, false, 6)
  end
, [2127] = function(...)
    -- function num : 0_19_20 , upvalues : self, targetCards, atkCard
    if self.onlyChoosePos == true then
      targetCards = {}
      return 
    end
    targetCards = (self.GetBehindCards)(atkCard, false)
    if #targetCards == 0 then
      targetCards = (self.GetFrontCards)(atkCard, false)
    end
    targetCards = (self.GetRandomCards)(atkCard, false, 1, nil, nil, targetCards)
  end
, [2128] = function(...)
    -- function num : 0_19_21 , upvalues : self, targetCards, atkCard
    if self.onlyChoosePos == true then
      targetCards = {}
      return 
    end
    targetCards = (self.GetBehindCards)(atkCard, false)
    if #targetCards == 0 then
      targetCards = (self.GetFrontCards)(atkCard, false)
    end
    targetCards = (self.GetRandomCards)(atkCard, false, 2, nil, nil, targetCards)
  end
, [2131] = function(...)
    -- function num : 0_19_22 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetTopHpCards)(atkCard, false, 1)
  end
, [2132] = function(...)
    -- function num : 0_19_23 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetTopHpCards)(atkCard, false, 2)
  end
, [2133] = function(...)
    -- function num : 0_19_24 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetTopHpCards)(atkCard, false, 3)
  end
, [2141] = function(...)
    -- function num : 0_19_25 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetTopHpCards)(atkCard, false, 1, true)
  end
, [2142] = function(...)
    -- function num : 0_19_26 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetTopHpCards)(atkCard, false, 2, true)
  end
, [2151] = function(...)
    -- function num : 0_19_27 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetTopDefCards)(atkCard, false, 1)
  end
, [2161] = function(...)
    -- function num : 0_19_28 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetTopAtkCards)(atkCard, false, 1)
  end
, [2171] = function(...)
    -- function num : 0_19_29 , upvalues : targetCards, _ENV, atkCard
    targetCards = (BattleChoose.GetRandomCardsByAround)(atkCard, false, 1)
  end
, [3001] = function(...)
    -- function num : 0_19_30 , upvalues : t_insert, targetCards, atkCard
    t_insert(targetCards, atkCard)
  end
, [3002] = function(...)
    -- function num : 0_19_31 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetCardsByCross)(atkCard, true)
  end
, [3003] = function(...)
    -- function num : 0_19_32 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetCardsByAround)(atkCard, true)
  end
, [3004] = function(...)
    -- function num : 0_19_33 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetCardsBySide)(atkCard, true)
  end
, [3005] = function(...)
    -- function num : 0_19_34 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetFrontCards)(atkCard, true)
    if #targetCards == 0 then
      targetCards = (self.GetBehindCards)(atkCard, true)
    end
  end
, [3006] = function(...)
    -- function num : 0_19_35 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetBehindCards)(atkCard, true)
    if #targetCards == 0 then
      targetCards = (self.GetFrontCards)(atkCard, true)
    end
  end
, [3007] = function(...)
    -- function num : 0_19_36 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetVerticalCards)(atkCard, true)
  end
, [3008] = function(...)
    -- function num : 0_19_37 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetHorizontalCards)(atkCard, true)
  end
, [3009] = function(...)
    -- function num : 0_19_38 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetVerticalCards)(atkCard, true, true)
  end
, [3011] = function(...)
    -- function num : 0_19_39 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetTopHpCards)(atkCard, true, 1, true)
  end
, [3012] = function(...)
    -- function num : 0_19_40 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetTopHpCards)(atkCard, true, 2, true)
  end
, [3013] = function(...)
    -- function num : 0_19_41 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetTopHpCards)(atkCard, true, 3, true)
  end
, [3016] = function(...)
    -- function num : 0_19_42 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetTopHpCards)(atkCard, true, 1, true, true)
  end
, [3017] = function(...)
    -- function num : 0_19_43 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetFrontCards)(atkCard, true, true)
  end
, [3018] = function(...)
    -- function num : 0_19_44 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetBehindCards)(atkCard, true, true)
  end
, [3019] = function(...)
    -- function num : 0_19_45 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetCardsBySide)(atkCard, true, true)
  end
, [3021] = function(...)
    -- function num : 0_19_46 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetTopDanderCards)(atkCard, true, 1, true)
  end
, [3022] = function(...)
    -- function num : 0_19_47 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetTopDanderCards)(atkCard, true, 2, true)
  end
, [3023] = function(...)
    -- function num : 0_19_48 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetTopDanderCards)(atkCard, true, 3, true)
  end
, [3031] = function(...)
    -- function num : 0_19_49 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetRandomCards)(atkCard, true, 1)
  end
, [3032] = function(...)
    -- function num : 0_19_50 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetRandomCards)(atkCard, true, 2)
  end
, [3033] = function(...)
    -- function num : 0_19_51 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetRandomCards)(atkCard, true, 3)
  end
, [3034] = function(...)
    -- function num : 0_19_52 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetRandomCards)(atkCard, true, 1, true)
  end
, [3041] = function(...)
    -- function num : 0_19_53 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetTopHpCards)(atkCard, true, 1)
  end
, [4001] = function(...)
    -- function num : 0_19_54 , upvalues : targetCards, self, atkCard
    targetCards = (self.GetRandomCards)(atkCard, nil, 1, true)
  end
, [5002] = function(...)
    -- function num : 0_19_55 , upvalues : atkCard, _ENV, t_insert, targetCards
    local pos = atkCard:GetFoePos()
    if pos then
      local card = (BattleData.GetCardInfoByPos)(pos)
      if card and card:IsDead() ~= true then
        t_insert(targetCards, card)
      end
    end
  end
, [5003] = function(...)
    -- function num : 0_19_56 , upvalues : _ENV, atkCard, targetCards, self, t_insert
    local cards = (BattleChoose.GetCardHaveEffect)(atkCard, BattleDisplayEffect.OFFER_REWARD, false)
    if #cards > 0 then
      targetCards = cards
    else
      local card = (self.GetNormalAttackCard)(atkCard)
      t_insert(targetCards, card)
    end
  end
, [5005] = function(...)
    -- function num : 0_19_57 , upvalues : _ENV, atkCard, targetCards, self, t_insert
    local cards = (BattleChoose.GetCardHaveEffect)(atkCard, BattleDisplayEffect.FOCUS_ATTACK, false)
    if #cards > 0 then
      targetCards = cards
    else
      local card = (self.GetNormalAttackCard)(atkCard)
      t_insert(targetCards, card)
    end
  end
}
  if self.onlyChoosePos ~= true and isBuff ~= true and (BattleSkill.IsAttackSkill)(skillConfig) == true then
    local isAttract, buff = (BattleBuff.IsAttract)(atkCard)
    if isAttract == true then
      local atkPos = buff:GetAtkPos()
      local card = (BattleData.GetCardInfoByPos)(atkPos)
      if card and card:IsDead() ~= true then
        t_insert(targetCards, card)
        return targetCards
      end
    end
    do
      if (BattleBuff.IsBuffEnchantment)(atkCard) then
        targetId = 3034
      else
        if (BattleBuff.IsBuffConfusion)(atkCard) then
          targetId = 4001
        else
          if targetId ~= 5005 and (skillConfig.type == BattleSkillType.NORMAL or skillConfig.type == BattleSkillType.SMALL) then
            local cards = (BattleChoose.GetCardHaveEffect)(atkCard, BattleDisplayEffect.FOCUS_ATTACK, false)
            if #cards > 0 then
              targetCards = cards
              return targetCards
            end
          end
        end
      end
      do
        local func = switch[targetId]
        if func then
          func()
        end
        return targetCards
      end
    end
  end
end


