-- params : ...
-- function num : 0 , upvalues : _ENV
require("Talent_AttributeUp_AByName")
TalentStarUpAttrWindow = {}
local uis = nil
local argTable = {}
local contentPane = nil
local curStarLvl = 0
local curTreeId = 0
local isEnableClose = false
local leanTweenDelayId, leanTweenValueId = nil, nil
-- DECOMPILER ERROR at PC14: Confused about usage of register: R8 in 'UnsetPending'

TalentStarUpAttrWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, curStarLvl, curTreeId, isEnableClose
  bridgeObj:SetView((WinResConfig.TalentStarUpAttrWindow).package, (WinResConfig.TalentStarUpAttrWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  contentPane:Center()
  uis = GetTalent_AttributeUp_AUis(contentPane)
  curStarLvl = argTable[1]
  curTreeId = argTable[2]
  isEnableClose = false
  ;
  (SimpleTimer.setTimeout)(1, function(...)
    -- function num : 0_0_0 , upvalues : isEnableClose
    isEnableClose = true
  end
)
  ;
  ((uis.TouchScreenBtn).onClick):Add(function(...)
    -- function num : 0_0_1 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.TalentStarUpAttrWindow).name)
  end
)
  ;
  (TalentStarUpAttrWindow.RefreshWindow)()
end

-- DECOMPILER ERROR at PC17: Confused about usage of register: R8 in 'UnsetPending'

TalentStarUpAttrWindow.RefreshWindow = function(...)
  -- function num : 0_1 , upvalues : _ENV, uis, contentPane, curStarLvl, curTreeId
  (Util.PlayUIEffect)(uis, contentPane, 1)
  local lastStarLvl = curStarLvl - 1
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.Level_Before_Txt).text = lastStarLvl
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.Level_After_Txt).text = curStarLvl
  local lastData = (TalentStarUpAttrWindow.GetStarUpData)(lastStarLvl, curTreeId)
  local curData = (TalentStarUpAttrWindow.GetStarUpData)(curStarLvl, curTreeId)
  local lastAttr = (TalentStarUpAttrWindow.CheckAdd_Attr)(lastData.add_attr)
  local curAttr = (TalentStarUpAttrWindow.CheckAdd_Attr)(curData.add_attr)
  ;
  (uis.AttribteList):RemoveChildrenToPool()
  for i,v in ipairs(lastAttr) do
    local skillPrefab = (uis.AttribteList):AddItemFromPool()
    local nameTxt = skillPrefab:GetChild("A_NameTxt")
    nameTxt.text = (((TableData.gTable).BaseAttributeData)[v.id]).display_name
    local number1 = skillPrefab:GetChild("A_02_NumberTxt")
    local number2 = skillPrefab:GetChild("A_01_NumberTxt")
    number1.text = v.value
    number2.text = (curAttr[i]).value
  end
  local numTxt = uis.PowerNumberTxt
  numTxt.text = (ActorData.fcChangeList).preFc
  ;
  (SimpleTimer.setTimeout)(0.5, function(...)
    -- function num : 0_1_0 , upvalues : _ENV, numTxt
    ((LeanTween.value)((ActorData.fcChangeList).preFc, (ActorData.fcChangeList).newFc, 0.4)):setOnUpdate(function(value, ...)
      -- function num : 0_1_0_0 , upvalues : numTxt, _ENV
      if numTxt then
        local num = (math.ceil)(value)
        numTxt.text = num
      end
    end
)
  end
)
end

-- DECOMPILER ERROR at PC20: Confused about usage of register: R8 in 'UnsetPending'

TalentStarUpAttrWindow.CheckAdd_Attr = function(str, ...)
  -- function num : 0_2 , upvalues : _ENV
  local t = {}
  for i,j in ipairs(split(str, ",")) do
    local attr = split(j, ":")
    ;
    (table.insert)(t, {id = tonumber(attr[2]), value = tonumber(attr[3])})
  end
  return t
end

-- DECOMPILER ERROR at PC23: Confused about usage of register: R8 in 'UnsetPending'

TalentStarUpAttrWindow.OnClose = function(...)
  -- function num : 0_3 , upvalues : uis, argTable, contentPane, _ENV
  uis = nil
  argTable = {}
  contentPane = nil
  ;
  (CommonWinMgr.OpenCommonFcUp)()
end

-- DECOMPILER ERROR at PC26: Confused about usage of register: R8 in 'UnsetPending'

TalentStarUpAttrWindow.GetStarUpData = function(star, treeId, ...)
  -- function num : 0_4 , upvalues : _ENV
  local data = nil
  local growType = (((TableData.gTable).BaseTalentTreeData)[treeId]).star_grow_type
  for k,v in pairs((TableData.gTable).BaseTalentTreeStarUpData) do
    if v.type == growType and v.star == star then
      data = v
    end
  end
  return data
end

return TalentStarUpAttrWindow

