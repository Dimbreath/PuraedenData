-- params : ...
-- function num : 0 , upvalues : _ENV
require("Talent_AttributeUp_BByName")
TalentEnergyUpAttrWindow = {}
local uis = nil
local argTable = {}
local contentPane = nil
local curTreeId = 0
local isEnableClose = false
-- DECOMPILER ERROR at PC12: Confused about usage of register: R5 in 'UnsetPending'

TalentEnergyUpAttrWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, curTreeId, isEnableClose
  bridgeObj:SetView((WinResConfig.TalentEnergyUpAttrWindow).package, (WinResConfig.TalentEnergyUpAttrWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  contentPane:Center()
  uis = GetTalent_AttributeUp_BUis(contentPane)
  curTreeId = argTable[1]
  ;
  (SimpleTimer.setTimeout)(1, function(...)
    -- function num : 0_0_0 , upvalues : isEnableClose
    isEnableClose = true
  end
)
  ;
  ((uis.TouchScreenBtn).onClick):Add(function(...)
    -- function num : 0_0_1 , upvalues : isEnableClose, _ENV
    if isEnableClose then
      UIMgr:CloseWindow((WinResConfig.TalentEnergyUpAttrWindow).name)
    end
  end
)
  ;
  (TalentEnergyUpAttrWindow.RefreshWindow)()
end

-- DECOMPILER ERROR at PC15: Confused about usage of register: R5 in 'UnsetPending'

TalentEnergyUpAttrWindow.RefreshWindow = function(...)
  -- function num : 0_1 , upvalues : _ENV, uis, contentPane, curTreeId
  (Util.PlayUIEffect)(uis, contentPane, 1)
  local curEnergyLvl = (TalentData.GetTalentTreeEnergyById)(curTreeId)
  local lastEnergyLvl = curEnergyLvl - 1
  local curEnergyData = (TalentEnergyUpAttrWindow.GetEnergyData)(curTreeId, curEnergyLvl)
  local lastEnergyData = (TalentEnergyUpAttrWindow.GetEnergyData)(curTreeId, lastEnergyLvl)
  print("curTreeId", curTreeId, "curEnergyLvl", curEnergyLvl, "lastEnergyLvl", lastEnergyLvl, curEnergyData.add_level)
  ;
  (uis.TalentSkillList):RemoveChildrenToPool()
  local addTalents = split(curEnergyData.add_level, ",")
  for i,v in ipairs(addTalents) do
    local strs = split(v, ":")
    local talentId = tonumber(strs[1])
    local skillPrefab = GetTalent_TalentSkillUis((uis.TalentSkillList):AddItemFromPool())
    local talentData = ((TableData.gTable).BaseTalentData)[talentId]
    -- DECOMPILER ERROR at PC62: Confused about usage of register: R14 in 'UnsetPending'

    ;
    (skillPrefab.IconLoader).url = (Util.GetResUrl)(talentData.icon)
    -- DECOMPILER ERROR at PC64: Confused about usage of register: R14 in 'UnsetPending'

    ;
    (skillPrefab.c1Ctr).selectedIndex = 1
    local talentLvl = (TalentData.GetTalentLevel)(talentId)
    local isLock = (TalentData.GetIsTalentLock)(talentId)
    if not curEnergyData.show_add_level then
      do
        local extraLvl = (TalentData.GetExtraTalentLvl)(strs[1], curEnergyData.ext_level)
        -- DECOMPILER ERROR at PC87: Confused about usage of register: R17 in 'UnsetPending'

        ;
        (skillPrefab.IconLoader).grayed = (Util.GrayLoader)(skillPrefab.IconLoader, isLock)
        -- DECOMPILER ERROR at PC90: Confused about usage of register: R17 in 'UnsetPending'

        ;
        (skillPrefab.NameTxt).text = talentData.name
        -- DECOMPILER ERROR at PC101: Confused about usage of register: R17 in 'UnsetPending'

        ;
        (skillPrefab.LevelTxt).text = talentLvl .. "[color=#45ff76]" .. "(" .. extraLvl .. ")" .. "[/color]" .. "/" .. talentData.max_level
        -- DECOMPILER ERROR at PC102: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC102: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  ;
  (uis.AttribteList):RemoveChildrenToPool()
  if not curEnergyData.show_add_level then
    local curShow = split(curEnergyData.ext_level, ",")
    if not lastEnergyData.show_add_level then
      local lastShow = split(lastEnergyData.ext_level, ",")
      for i,v in ipairs(curShow) do
        local talentId = tonumber((split(v, ":"))[1])
        local newTalentLvl = tonumber((split(v, ":"))[2])
        local oldTalentLvl = tonumber((split(lastShow[i], ":"))[2])
        local talentData = ((TableData.gTable).BaseTalentData)[talentId]
        local add_attr = split(talentData.add_attr, ",")
        if newTalentLvl ~= oldTalentLvl then
          for j,k in ipairs(add_attr) do
            local attr = split(k, ":")
            local skillPrefab = (uis.AttribteList):AddItemFromPool()
            local nameTxt = skillPrefab:GetChild("A_NameTxt")
            nameTxt.text = (((TableData.gTable).BaseAttributeData)[tonumber(attr[2])]).display_name
            local number1 = skillPrefab:GetChild("A_02_NumberTxt")
            local number2 = skillPrefab:GetChild("A_01_NumberTxt")
            number1.text = tonumber(attr[3]) * ((TalentData.GetTalentLevel)(talentId) + oldTalentLvl)
            number2.text = tonumber(attr[3]) * ((TalentData.GetTalentLevel)(talentId) + newTalentLvl)
          end
        end
      end
      local numTxt = uis.PowerNumberTxt
      if ActorData.fcChangeList then
        (LeanTween.delayedCall)(0.5, function(...)
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
    end
  end
end

-- DECOMPILER ERROR at PC18: Confused about usage of register: R5 in 'UnsetPending'

TalentEnergyUpAttrWindow.GetEnergyData = function(treeId, curCradDebris, ...)
  -- function num : 0_2 , upvalues : _ENV
  local id = (TalentData.GetTreeEnergyId)(treeId, curCradDebris)
  local data = (TableData.GetBaseTalentTreeEnergyUpData)(id)
  return data
end

-- DECOMPILER ERROR at PC21: Confused about usage of register: R5 in 'UnsetPending'

TalentEnergyUpAttrWindow.OnClose = function(...)
  -- function num : 0_3 , upvalues : uis, argTable, contentPane, _ENV
  uis = nil
  argTable = {}
  contentPane = nil
  ;
  (CommonWinMgr.OpenCommonFcUp)()
  UIMgr:SendWindowMessage((WinResConfig.TalentMainWindow).name, (WindowMsgEnum.Talent).E_MSG_TALENT_ENERGYUP_AFTER_CLOSE, {})
end

return TalentEnergyUpAttrWindow

