-- params : ...
-- function num : 0 , upvalues : _ENV
TalentData = {curTreeId = 0, 
talentTreeDatas = {}
, 
allTalentTreeLv = {}
, 
talentAllAttr = {}
, 
callBackInfo = {}
}
-- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

TalentData.SaveFazhenCallBackInfo = function(fazhenId, bgEffects, btn, ...)
  -- function num : 0_0 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R3 in 'UnsetPending'

  TalentData.callBackInfo = {}
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (TalentData.callBackInfo).fazhenId = fazhenId
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (TalentData.callBackInfo).bgEffects = bgEffects
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (TalentData.callBackInfo).btn = btn
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

TalentData.ReturnFazhenCallBackInfo = function(...)
  -- function num : 0_1 , upvalues : _ENV
  return TalentData.callBackInfo
end

-- DECOMPILER ERROR at PC19: Confused about usage of register: R0 in 'UnsetPending'

TalentData.TalentDataInit = function(data, ...)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  TalentData.talentTreeDatas = {}
  for index,value in pairs(data) do
    (table.insert)(TalentData.talentTreeDatas, value)
  end
  ;
  (TalentData.TalentAllAttrInit)()
end

-- DECOMPILER ERROR at PC22: Confused about usage of register: R0 in 'UnsetPending'

TalentData.GetTalentDataByTalentId = function(id, ...)
  -- function num : 0_3 , upvalues : _ENV
  local data = {}
  for index,value in ipairs(TalentData.talentTreeDatas) do
    if value.id == id then
      data = value
    end
  end
  return data
end

-- DECOMPILER ERROR at PC25: Confused about usage of register: R0 in 'UnsetPending'

TalentData.GetCurShowTalentTree = function(...)
  -- function num : 0_4 , upvalues : _ENV
  local curTreeId = 71100001
  local length = #TalentData.talentTreeDatas
  if (TalentData.talentTreeDatas)[length] then
    curTreeId = ((TalentData.talentTreeDatas)[length]).id
  end
  return curTreeId
end

-- DECOMPILER ERROR at PC28: Confused about usage of register: R0 in 'UnsetPending'

TalentData.GetFaZhenInfo = function(treeId, fazhenId, ...)
  -- function num : 0_5 , upvalues : _ENV
  local fazhenData = {}
  for index,value in pairs(((TalentData.GetTalentDataByTalentId)(treeId)).matrixInfo) do
    if fazhenId == value.id then
      fazhenData = value
    end
  end
  return fazhenData
end

-- DECOMPILER ERROR at PC31: Confused about usage of register: R0 in 'UnsetPending'

TalentData.GetFaZhenState = function(treeId, fazhenId, ...)
  -- function num : 0_6 , upvalues : _ENV
  local treeData = (TalentData.GetTalentDataByTalentId)(treeId)
  local isOpen = (((TableData.gTable).BaseMatrixData)[fazhenId]).open == 1
  local state = 0
  if isOpen then
    state = 0
  else
    state = 3
  end
  for index,value in ipairs(treeData.matrixInfo) do
    if value.id == fazhenId then
      print("fazhenId,curNode", fazhenId, value.curNode)
      if value.curNode == 0 then
        state = 1
      else
        local nodeExcelData = ((TableData.gTable).BaseMatrixNodeData)[value.curNode]
        if nodeExcelData.next == 0 then
          state = 2
        else
          state = 1
        end
      end
    end
  end
  do return state end
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC34: Confused about usage of register: R0 in 'UnsetPending'

TalentData.GetPointGrpByFzIdAndCurNode = function(fazhenId, curNode, ...)
  -- function num : 0_7 , upvalues : _ENV
  local points = {}
  local pre = "713"
  local middle = ((string.sub)(tostring(fazhenId), 7, 8))
  local last, level = nil, nil
  if curNode == 0 then
    level = 1
  else
    level = (((TableData.gTable).BaseMatrixNodeData)[curNode]).show_level
  end
  local tmp = tostring((level - 1) * 7 + 1)
  local tmp_len = (string.len)(tmp)
  last = tmp
  for i = 1, 3 - tmp_len do
    last = "0" .. last
  end
  local final = tonumber(pre .. middle .. last)
  if final + 6 == curNode then
    local next = (((TableData.gTable).BaseMatrixNodeData)[curNode]).next
  end
  if next == 0 then
    do
      final = final + 7
      ;
      (table.insert)(points, final)
      for i = 1, 6 do
        (table.insert)(points, final + i)
      end
      return points
    end
  end
end

-- DECOMPILER ERROR at PC37: Confused about usage of register: R0 in 'UnsetPending'

TalentData.SaveActivePoint = function(treeId, fazhenId, nodeId, ...)
  -- function num : 0_8 , upvalues : _ENV
  for i,v in pairs(TalentData.talentTreeDatas) do
    if treeId == v.id then
      for n,m in ipairs(v.matrixInfo) do
        if fazhenId == m.id then
          print("储存已激活节点", fazhenId, nodeId)
          m.curNode = nodeId
          local nodeData = ((TableData.gTable).BaseMatrixNodeData)[m.curNode]
          ;
          (TalentData.AddTalentAllAttr)(nodeData.add_attr_show)
          break
        end
      end
    end
  end
  ;
  (CardData.UpdateAllCardAttr)()
end

-- DECOMPILER ERROR at PC40: Confused about usage of register: R0 in 'UnsetPending'

TalentData.AddNewMatrixInfo = function(treeId, info, ...)
  -- function num : 0_9 , upvalues : _ENV
  for i,v in pairs(TalentData.talentTreeDatas) do
    if treeId == v.id then
      (table.insert)(v.matrixInfo, info)
    end
  end
end

-- DECOMPILER ERROR at PC43: Confused about usage of register: R0 in 'UnsetPending'

TalentData.SaveActiveSeal = function(treeId, fazhenId, sealType, sealId, ...)
  -- function num : 0_10 , upvalues : _ENV
  for i,v in pairs(TalentData.talentTreeDatas) do
    if treeId == v.id then
      for n,m in ipairs(v.matrixInfo) do
        if fazhenId == m.id then
          for j,k in ipairs(m.sealInfo) do
            if k.id == sealType then
              k.value = sealId
              local sealData = ((TableData.gTable).BaseMatrixSealData)[sealId]
              ;
              (TalentData.AddTalentAllAttr)(sealData.add_attr_show)
              if sealData.next_type > 0 then
                print("下一个封印已开启 封印类型", sealData.next_type)
                ;
                (table.insert)(m.sealInfo, {id = sealData.next_type, value = 0})
              end
              break
            end
          end
        end
      end
    end
  end
  ;
  (CardData.UpdateAllCardAttr)()
end

-- DECOMPILER ERROR at PC46: Confused about usage of register: R0 in 'UnsetPending'

TalentData.GetTalentTreeAllAttr = function(teamMatrix, ...)
  -- function num : 0_11 , upvalues : _ENV
  do
    if teamMatrix then
      local attrTable = {
{id = 81050003, value = 0}
, 
{id = 81050004, value = 0}
, 
{id = 81050002, value = 0}
, 
{id = 81050005, value = 0}
, 
{id = 81050006, value = 0}
, 
{id = 81050007, value = 0}
, 
{id = 81050008, value = 0}
}
      ;
      (TalentData.TalentAllAttrInit)(teamMatrix, attrTable)
      return attrTable
    end
    return TalentData.talentAllAttr
  end
end

-- DECOMPILER ERROR at PC49: Confused about usage of register: R0 in 'UnsetPending'

TalentData.TalentAllAttrInit = function(teamMatrix, attrTable, ...)
  -- function num : 0_12 , upvalues : _ENV
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R2 in 'UnsetPending'

  if teamMatrix == nil and attrTable == nil then
    TalentData.talentAllAttr = {
{id = 81050003, value = 0}
, 
{id = 81050004, value = 0}
, 
{id = 81050002, value = 0}
, 
{id = 81050005, value = 0}
, 
{id = 81050006, value = 0}
, 
{id = 81050007, value = 0}
, 
{id = 81050008, value = 0}
}
  end
  if not teamMatrix then
    local talentData = TalentData.talentTreeDatas
  end
  for i,v in pairs(talentData) do
    for n,m in pairs(v.matrixInfo) do
      do
        if m.curNode ~= 0 then
          local nodeData = ((TableData.gTable).BaseMatrixNodeData)[m.curNode]
          ;
          (TalentData.AddTalentAllAttr)(nodeData.add_attr, attrTable)
        end
        for j,k in pairs(m.sealInfo) do
          if k.value ~= 0 then
            local sealData = ((TableData.gTable).BaseMatrixSealData)[k.value]
            ;
            (TalentData.AddTalentAllAttr)(sealData.add_attr, attrTable)
          end
        end
        do
          -- DECOMPILER ERROR at PC73: LeaveBlock: unexpected jumping out DO_STMT

        end
      end
    end
  end
  if teamMatrix == nil then
    (CardData.UpdateAllCardAttr)()
  end
end

-- DECOMPILER ERROR at PC52: Confused about usage of register: R0 in 'UnsetPending'

TalentData.AddTalentAllAttr = function(str, attrTable, ...)
  -- function num : 0_13 , upvalues : _ENV
  local attrs = split(str, ",")
  for index,value in ipairs(attrs) do
    local attr = split(value, ":")
    local attrId = tonumber(attr[2])
    local attrNum = tonumber(attr[3])
    if not attrTable then
      attrTable = TalentData.talentAllAttr
    end
    for j,k in ipairs(attrTable) do
      if attrId == k.id then
        k.value = k.value + attrNum
        break
      end
    end
  end
end

-- DECOMPILER ERROR at PC55: Confused about usage of register: R0 in 'UnsetPending'

TalentData.ReturnNewestNodeId = function(...)
  -- function num : 0_14 , upvalues : _ENV
  local newestNodeId = 0
  local length = #TalentData.talentTreeDatas
  if (TalentData.talentTreeDatas)[length] then
    local matrixInfo = ((TalentData.talentTreeDatas)[length]).matrixInfo
    for key,value in pairs(matrixInfo) do
      newestNodeId = value.curNode
    end
  end
  do
    return newestNodeId
  end
end


