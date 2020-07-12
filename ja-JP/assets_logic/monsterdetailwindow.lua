-- params : ...
-- function num : 0 , upvalues : _ENV
require("Tower_MonsterByName")
local MonsterDetailWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local DEFAULT_STAGE_WAVE = 1
local ROLE_ZOOM_SCALE = 15
local ROLE_ZOOM_LARGE_SCALE = 20
local _switchAnim, _currentMonsterId, _currentSkillId, _skillGrp = nil, nil, nil, nil
local _selfPlatform = {}
local _monsterPlatform = {}
local _currentStage, _currentWave, _currentGroupIds, _setStageItem, _stageLockChecker, _lockAction, _getStageTip, _formation, _getMonsterGroups, _lastPageItem = nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
MonsterDetailWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, MonsterDetailWindow
  bridgeObj:SetView((WinResConfig.MonsterDetailWindow).package, (WinResConfig.MonsterDetailWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetTower_MonsterUis(contentPane)
  ;
  (MonsterDetailWindow.InitTopMenu)()
  ;
  (MonsterDetailWindow.InitVariable)()
  ;
  (MonsterDetailWindow.InitText)()
  ;
  (MonsterDetailWindow.InitList)()
  ;
  (MonsterDetailWindow.InitButtonEvent)()
end

MonsterDetailWindow.InitTopMenu = function(...)
  -- function num : 0_1 , upvalues : _ENV, uis
  local m = {}
  m.windowName = (WinResConfig.MonsterDetailWindow).name
  m.Tip = (PUtil.get)(60000092)
  m.model = uis.AssetStripGrp
  m.closeToWindow = (WinResConfig.AdventureWindow).name
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.SPIRIT}
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

MonsterDetailWindow.InitVariable = function(...)
  -- function num : 0_2 , upvalues : _switchAnim, uis
  _switchAnim = ((uis.FormationGrp).root):GetTransition("Switch")
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.AttackList).draggable = false
end

MonsterDetailWindow.InitText = function(...)
  -- function num : 0_3 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  (uis.LineupTxt).text = (PUtil.get)(60000364)
  ;
  ((uis.LeftBtn):GetChild("WordTxt")).text = (PUtil.get)(60000493)
  ;
  ((uis.RightBtn):GetChild("WordTxt")).text = (PUtil.get)(60000494)
end

MonsterDetailWindow.InitList = function(...)
  -- function num : 0_4 , upvalues : uis, MonsterDetailWindow
  (uis.LayerList):SetVirtual()
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.LayerList).itemRenderer = MonsterDetailWindow.RefreshStageItem
end

MonsterDetailWindow.InitButtonEvent = function(...)
  -- function num : 0_5 , upvalues : uis, MonsterDetailWindow
  ((uis.LeftBtn).onClick):Add(MonsterDetailWindow.ClickLeftBtn)
  ;
  ((uis.RightBtn).onClick):Add(MonsterDetailWindow.ClickRightBtn)
end

MonsterDetailWindow.InitEvent = function(...)
  -- function num : 0_6
end

MonsterDetailWindow.RemoveEvent = function(...)
  -- function num : 0_7
end

MonsterDetailWindow.OnShown = function(...)
  -- function num : 0_8 , upvalues : MonsterDetailWindow
  (MonsterDetailWindow.InitEvent)()
  ;
  (MonsterDetailWindow.Init)()
end

MonsterDetailWindow.OnHide = function(...)
  -- function num : 0_9
end

MonsterDetailWindow.Init = function(...)
  -- function num : 0_10 , upvalues : _currentStage, argTable, _formation, _setStageItem, _stageLockChecker, _getStageTip, _getMonsterGroups, _lockAction, uis, MonsterDetailWindow
  _currentStage = argTable[1]
  _formation = argTable[2]
  _setStageItem = argTable[4]
  _stageLockChecker = argTable[5]
  _getStageTip = argTable[6]
  _getMonsterGroups = argTable[7]
  _lockAction = argTable[8]
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.LayerList).numItems = argTable[3]
  ;
  (MonsterDetailWindow.RefreshStageInfo)()
  ;
  (MonsterDetailWindow.RefreshPageList)()
end

MonsterDetailWindow.OnClose = function(...)
  -- function num : 0_11 , upvalues : _ENV, MonsterDetailWindow, uis, contentPane, argTable, _currentMonsterId, _lastPageItem
  (CommonWinMgr.RemoveAssets)((WinResConfig.MonsterDetailWindow).name)
  ;
  (MonsterDetailWindow.RemoveEvent)()
  uis = nil
  contentPane = nil
  argTable = {}
  _currentMonsterId = nil
  _lastPageItem = nil
end

MonsterDetailWindow.RefreshPageList = function(...)
  -- function num : 0_12 , upvalues : uis, _currentGroupIds, MonsterDetailWindow
  (uis.WaveList):RemoveChildrenToPool()
  local totalWave = #_currentGroupIds
  if totalWave > 1 then
    for i = 1, totalWave do
      (MonsterDetailWindow.RefreshPageItem)(i, (uis.WaveList):AddItemFromPool())
    end
  end
end

MonsterDetailWindow.RefreshStageItem = function(index, item, ...)
  -- function num : 0_13 , upvalues : _setStageItem, _currentStage, _stageLockChecker, MonsterDetailWindow, uis, _lockAction
  index = index + 1
  local id = _setStageItem(index, item)
  item.selected = _currentStage == id
  ;
  (item.onClick):Clear()
  if _stageLockChecker(index) then
    (item:GetController("c1")).selectedIndex = 0
    ;
    (item.onClick):Set(function(...)
    -- function num : 0_13_0 , upvalues : id, _currentStage, MonsterDetailWindow, uis
    if id == _currentStage then
      return 
    end
    _currentStage = id
    ;
    (MonsterDetailWindow.InitEnemyFormation)()
    ;
    (uis.LayerList):RefreshVirtualList()
    ;
    (MonsterDetailWindow.RefreshPageList)()
    ;
    (MonsterDetailWindow.PlaySwitchAnim)()
  end
)
    item.touchable = true
  else
    (item:GetController("c1")).selectedIndex = 1
    if _lockAction ~= nil then
      (item.onClick):Set(function(...)
    -- function num : 0_13_1 , upvalues : _lockAction, index
    _lockAction(index)
  end
)
    else
      item.touchable = false
    end
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

MonsterDetailWindow.RefreshPageItem = function(index, item, ...)
  -- function num : 0_14 , upvalues : _currentWave, _lastPageItem, MonsterDetailWindow
  if index == _currentWave then
    (item:GetController("c1")).selectedIndex = 1
    _lastPageItem = item
  else
    ;
    (item:GetController("c1")).selectedIndex = 0
  end
  ;
  (item.onClick):Set(function(...)
    -- function num : 0_14_0 , upvalues : index, _currentWave, MonsterDetailWindow, item
    if index == _currentWave then
      return 
    end
    _currentWave = index
    ;
    (MonsterDetailWindow.RefreshChosedPage)(item)
    ;
    (MonsterDetailWindow.PlaySwitchAnim)()
  end
)
end

MonsterDetailWindow.RefreshChosedPage = function(item, ...)
  -- function num : 0_15 , upvalues : uis, _currentWave, _lastPageItem
  if item == nil then
    item = (uis.WaveList):GetChildAt(_currentWave - 1)
  end
  ;
  (_lastPageItem:GetController("c1")).selectedIndex = 0
  ;
  (item:GetController("c1")).selectedIndex = 1
  _lastPageItem = item
end

MonsterDetailWindow.RefreshStageInfo = function(...)
  -- function num : 0_16 , upvalues : uis, _getStageTip, _currentStage, MonsterDetailWindow
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

  (uis.LineupWordTxt).text = _getStageTip(_currentStage)
  ;
  (MonsterDetailWindow.RefreshSelfFormation)()
  ;
  (MonsterDetailWindow.InitEnemyFormation)(true)
end

MonsterDetailWindow.RefreshSelfFormation = function(...)
  -- function num : 0_17 , upvalues : _formation, _selfPlatform, uis, _ENV, ROLE_ZOOM_SCALE
  local count = #_formation
  local grp, data, carddata = nil, nil, nil
  local formationPos = {}
  _selfPlatform = {}
  for i = 1, count do
    data = _formation[i]
    formationPos[data.value] = data.id
    if data.id ~= 0 then
      grp = (uis.FormationGrp)["Self_0" .. tostring(data.value) .. "_Grp"]
      ;
      (Util.RecycleUIModel)(grp.CardLoader)
      -- DECOMPILER ERROR at PC30: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (grp.c1Ctr).selectedIndex = 0
      -- DECOMPILER ERROR at PC32: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (grp.c2Ctr).selectedIndex = 0
      -- DECOMPILER ERROR at PC34: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (grp.c3Ctr).selectedIndex = 0
      carddata = (CardData.GetCardData)(data.id)
      _selfPlatform[data.id] = grp
      if carddata then
        (Util.ShowUIModelByFashionId)(carddata.id, carddata.quality, carddata.fashionId, grp.CardLoader, true, function(model, ...)
    -- function num : 0_17_0 , upvalues : _ENV, ROLE_ZOOM_SCALE
    (SkeletonAnimationUtil.SetAnimation)(model, 0, BattleCardState.IDLE, true)
    ;
    (CSLuaUtil.SetGOScale)(model, ROLE_ZOOM_SCALE, ROLE_ZOOM_SCALE, ROLE_ZOOM_SCALE)
  end
)
      end
    end
  end
  for i = 1, Const.FormationMaxCount do
    if formationPos[i] == 0 then
      grp = (uis.FormationGrp)["Self_0" .. tostring(i) .. "_Grp"]
      ;
      (Util.RecycleUIModel)(grp.CardLoader)
      -- DECOMPILER ERROR at PC75: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (grp.c1Ctr).selectedIndex = 0
      -- DECOMPILER ERROR at PC77: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (grp.c2Ctr).selectedIndex = 0
      -- DECOMPILER ERROR at PC79: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (grp.c3Ctr).selectedIndex = 1
    end
  end
end

MonsterDetailWindow.InitEnemyFormation = function(refresh, ...)
  -- function num : 0_18 , upvalues : _currentWave, DEFAULT_STAGE_WAVE, _currentGroupIds, _ENV, _getMonsterGroups, _currentStage, MonsterDetailWindow
  _currentWave = DEFAULT_STAGE_WAVE
  _currentGroupIds = split(_getMonsterGroups(_currentStage), ":")
  if refresh then
    (MonsterDetailWindow.RefreshEnemyFormation)(tonumber(_currentGroupIds[_currentWave]))
    ;
    (MonsterDetailWindow.RefreshWaveInfo)(_currentWave)
  end
end

MonsterDetailWindow.RefreshEnemyFormation = function(groupId, ...)
  -- function num : 0_19 , upvalues : _ENV, _monsterPlatform, uis, ROLE_ZOOM_SCALE, MonsterDetailWindow
  local monsters = split((((TableData.gTable).BaseMonsterGroupData)[groupId]).monster_list, ":")
  local count = #monsters
  local monsterConfig, grp = nil, nil
  _monsterPlatform = {}
  local defaultMonsterId = nil
  for i = 1, count do
    local index = i
    do
      grp = (uis.FormationGrp)["Enemy_0" .. tostring(i) .. "_Grp"]
      ;
      (Util.RecycleUIModel)(grp.CardLoader)
      ;
      ((grp.root).onClick):Clear()
      -- DECOMPILER ERROR at PC35: Confused about usage of register: R11 in 'UnsetPending'

      ;
      (grp.c1Ctr).selectedIndex = 1
      -- DECOMPILER ERROR at PC37: Confused about usage of register: R11 in 'UnsetPending'

      ;
      (grp.c2Ctr).selectedIndex = 0
      local monsterId = tonumber(monsters[i])
      if monsterId ~= 0 then
        _monsterPlatform[monsterId] = {Component = grp, Index = i}
        -- DECOMPILER ERROR at PC48: Confused about usage of register: R12 in 'UnsetPending'

        ;
        (grp.c3Ctr).selectedIndex = 0
        local config = (TableData.GetBaseMonsterData)(monsterId)
        ;
        (Util.ShowUIModelByFashionId)(monsterId, 0, config.unlock_fashion_id, grp.CardLoader, true, function(model, ...)
    -- function num : 0_19_0 , upvalues : _ENV, ROLE_ZOOM_SCALE
    (SkeletonAnimationUtil.SetFlip)(model, true, false)
    ;
    (SkeletonAnimationUtil.SetAnimation)(model, 0, BattleCardState.IDLE, true)
    ;
    (CSLuaUtil.SetGOScale)(model, ROLE_ZOOM_SCALE, ROLE_ZOOM_SCALE, ROLE_ZOOM_SCALE)
  end
)
        ;
        ((grp.root).onClick):Add(function(...)
    -- function num : 0_19_1 , upvalues : MonsterDetailWindow, monsterId
    (MonsterDetailWindow.RefreshMonsterDetail)(monsterId)
  end
)
      else
        do
          do
            -- DECOMPILER ERROR at PC69: Confused about usage of register: R12 in 'UnsetPending'

            ;
            (grp.c3Ctr).selectedIndex = 1
            if not defaultMonsterId and monsterId ~= 0 then
              defaultMonsterId = monsterId
            end
          end
          -- DECOMPILER ERROR at PC76: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC76: LeaveBlock: unexpected jumping out IF_STMT

          -- DECOMPILER ERROR at PC76: LeaveBlock: unexpected jumping out DO_STMT

        end
      end
    end
  end
  ;
  (MonsterDetailWindow.RefreshMonsterDetail)(defaultMonsterId)
end

MonsterDetailWindow.RefreshWaveInfo = function(wave, ...)
  -- function num : 0_20 , upvalues : uis, _currentGroupIds
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (uis.WaveTxt).text = wave
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.LeftBtn).visible = wave ~= 1
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.RightBtn).visible = wave ~= #_currentGroupIds
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

MonsterDetailWindow.ClickLeftBtn = function(...)
  -- function num : 0_21 , upvalues : _switchAnim, _currentWave, MonsterDetailWindow
  if _switchAnim.playing then
    return 
  end
  _currentWave = _currentWave - 1
  ;
  (MonsterDetailWindow.RefreshChosedPage)()
  ;
  (MonsterDetailWindow.PlaySwitchAnim)()
end

MonsterDetailWindow.ClickRightBtn = function(...)
  -- function num : 0_22 , upvalues : _switchAnim, _currentWave, MonsterDetailWindow
  if _switchAnim.playing then
    return 
  end
  _currentWave = _currentWave + 1
  ;
  (MonsterDetailWindow.RefreshChosedPage)()
  ;
  (MonsterDetailWindow.PlaySwitchAnim)()
end

MonsterDetailWindow.PlaySwitchAnim = function(...)
  -- function num : 0_23 , upvalues : _switchAnim, _ENV, MonsterDetailWindow, _currentGroupIds, _currentWave
  if _switchAnim.playing then
    _switchAnim:Stop()
  end
  _switchAnim:Play()
  ;
  (SimpleTimer.setTimeout)(_switchAnim._totalDuration / 2, function(...)
    -- function num : 0_23_0 , upvalues : MonsterDetailWindow, _ENV, _currentGroupIds, _currentWave
    (MonsterDetailWindow.RefreshEnemyFormation)(tonumber(_currentGroupIds[_currentWave]))
    ;
    (MonsterDetailWindow.RefreshWaveInfo)(_currentWave)
  end
)
end

MonsterDetailWindow.RefreshMonsterDetail = function(monsterId, ...)
  -- function num : 0_24 , upvalues : _currentMonsterId, _monsterPlatform, _ENV, uis, ROLE_ZOOM_SCALE, _currentSkillId, _skillGrp, MonsterDetailWindow
  if _currentMonsterId == monsterId then
    return 
  end
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R1 in 'UnsetPending'

  if _monsterPlatform[_currentMonsterId] ~= nil then
    (((_monsterPlatform[_currentMonsterId]).Component).c2Ctr).selectedIndex = 0
  end
  _currentMonsterId = monsterId
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((_monsterPlatform[_currentMonsterId]).Component).c2Ctr).selectedIndex = 1
  ;
  (Util.RecycleUIModel)(uis.CardLoader)
  local config = (TableData.GetBaseMonsterData)(monsterId)
  ;
  (Util.ShowUIModelByFashionId)(monsterId, 0, config.unlock_fashion_id, uis.CardLoader, true, function(model, ...)
    -- function num : 0_24_0 , upvalues : _ENV, ROLE_ZOOM_SCALE
    (SkeletonAnimationUtil.SetFlip)(model, true, false)
    ;
    (SkeletonAnimationUtil.SetAnimation)(model, 0, BattleCardState.IDLE, true)
    ;
    (CSLuaUtil.SetGOScale)(model, ROLE_ZOOM_SCALE, ROLE_ZOOM_SCALE, ROLE_ZOOM_SCALE)
  end
)
  -- DECOMPILER ERROR at PC38: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.MonsterNameTxt).text = config.name
  ;
  (uis.LabelList):RemoveChildrenToPool()
  if (Util.StringIsNullOrEmpty)(config.card_label_show) == false then
    local labels = split(config.card_label_show, ":")
    local count = #labels
    local item = nil
    for i = 1, count do
      item = (uis.LabelList):AddItemFromPool()
      ;
      (item:GetChild("WordTxt")).text = (PUtil.get)(tonumber(labels[i]))
    end
  end
  do
    ;
    (split(config.skill_show, ":"))
    local skills = nil
    local item, skillId = nil, nil
    local count = #skills
    for i = count, 1, -1 do
      skillId = tonumber(skills[i])
      if skillId ~= 0 then
        _currentSkillId = skillId
        break
      end
    end
    do
      _skillGrp = {}
      ;
      (uis.AttackList):RemoveChildrenToPool()
      for i = 1, count do
        skillId = tonumber(skills[i])
        if skillId ~= 0 then
          item = (uis.AttackList):AddItemFromPool()
          ;
          (MonsterDetailWindow.InitSkillPanel)(item, skillId, i - 1)
        end
      end
    end
  end
end

MonsterDetailWindow.ShowMonsterSkillTargets = function(skillId, ...)
  -- function num : 0_25 , upvalues : _skillGrp, _currentSkillId, _ENV, _monsterPlatform, _currentMonsterId, _formation, uis
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  (_skillGrp[_currentSkillId]).selected = false
  _currentSkillId = skillId
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (_skillGrp[skillId]).selected = true
  local targetFomation = (BattleChoose.GetTargetPosByTargetId)((Util.GetEnemyBattlePosByPos)((_monsterPlatform[_currentMonsterId]).Index), ((TableData.GetBaseSkillData)(_currentSkillId)).targetType, (Util.GetAllFomation)(_formation, _monsterPlatform))
  targetFomation = (Util.CoverBattleFormation2SelfFormation)(targetFomation)
  local usedPos = {}
  local count = #targetFomation
  for i = 1, count do
    -- DECOMPILER ERROR at PC46: Confused about usage of register: R8 in 'UnsetPending'

    (((uis.FormationGrp)["Self_0" .. tostring((targetFomation[i]).value) .. "_Grp"]).c2Ctr).selectedIndex = 2
    usedPos[(targetFomation[i]).value] = true
  end
  for i = 1, Const.FormationMaxCount do
    -- DECOMPILER ERROR at PC68: Confused about usage of register: R8 in 'UnsetPending'

    if usedPos[i] == nil then
      (((uis.FormationGrp)["Self_0" .. tostring(i) .. "_Grp"]).c2Ctr).selectedIndex = 0
    end
  end
end

MonsterDetailWindow.InitSkillPanel = function(grp, skillId, type, ...)
  -- function num : 0_26 , upvalues : _skillGrp, _ENV, _currentSkillId, MonsterDetailWindow
  _skillGrp[skillId] = grp
  local config = (TableData.GetBaseSkillData)(skillId)
  ;
  (grp:GetChild("WordTxt")).text = config.remark
  ;
  (grp:GetChild("NameTxt")).text = (string.format)((PUtil.get)(60000366 + type) .. "·", config.name)
  ;
  (grp:GetController("c1")).selectedIndex = type
  grp.selected = skillId == _currentSkillId
  ;
  (grp.onClick):Set(function(...)
    -- function num : 0_26_0 , upvalues : MonsterDetailWindow, skillId
    (MonsterDetailWindow.ShowMonsterSkillTargets)(skillId)
  end
)
  if skillId == _currentSkillId then
    (MonsterDetailWindow.ShowMonsterSkillTargets)(skillId)
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

MonsterDetailWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_27
end

return MonsterDetailWindow

