-- params : ...
-- function num : 0 , upvalues : _ENV
DailyDungeonMgr = {curSelectTrialType = nil, curSelectStageId = nil}
-- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

DailyDungeonMgr.OpenDailyDungeonChapterList = function(...)
  -- function num : 0_0 , upvalues : _ENV
  if #DailyDungeonData.trialDataTable <= 0 then
    (DailyDungeonService.ReqInitData)(function(...)
    -- function num : 0_0_0 , upvalues : _ENV
    OpenWindow((WinResConfig.DailyDungeonChapterListWindow).name, UILayer.HUD)
  end
)
  else
    OpenWindow((WinResConfig.DailyDungeonChapterListWindow).name, UILayer.HUD)
  end
end

-- DECOMPILER ERROR at PC9: Confused about usage of register: R0 in 'UnsetPending'

DailyDungeonMgr.OpenDailyDungeonDifficulty = function(type, ...)
  -- function num : 0_1 , upvalues : _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  DailyDungeonMgr.curSelectTrialType = type
  if #DailyDungeonData.trialDataTable <= 0 then
    (DailyDungeonService.ReqInitData)(function(...)
    -- function num : 0_1_0 , upvalues : _ENV
    OpenWindow((WinResConfig.DailyDungeonDifficultyWindow).name, UILayer.HUD)
  end
)
  else
    OpenWindow((WinResConfig.DailyDungeonDifficultyWindow).name, UILayer.HUD)
  end
end

-- DECOMPILER ERROR at PC12: Confused about usage of register: R0 in 'UnsetPending'

DailyDungeonMgr.StartChallenge = function(cards, ...)
  -- function num : 0_2 , upvalues : _ENV
  if not cards then
    cards = (DailyDungeonData.GetChallengeCardInfo)(DailyDungeonMgr.curSelectTrialType)
  end
  local cardInfo = {}
  for i = 1, 6 do
    local common = {}
    if cards[i] then
      common.id = cards[i]
    else
      common.id = 0
    end
    common.value = i
    ;
    (table.insert)(cardInfo, common)
  end
  local stageId = DailyDungeonMgr.curSelectStageId
  ;
  (DailyDungeonService.ReqInTrial)(cardInfo, stageId, false)
end

-- DECOMPILER ERROR at PC15: Confused about usage of register: R0 in 'UnsetPending'

DailyDungeonMgr.InitSelfFormation = function(...)
  -- function num : 0_3 , upvalues : _ENV
  local cardInfo = (DailyDungeonData.GetChallengeCardInfo)(DailyDungeonMgr.curSelectTrialType)
  local formation = {}
  for i,v in ipairs(cardInfo) do
    if v.id ~= 0 then
      formation[v.value] = v.id
    end
  end
  PrintTable(formation, "formation:")
  return formation
end

-- DECOMPILER ERROR at PC18: Confused about usage of register: R0 in 'UnsetPending'

DailyDungeonMgr.InitEnemyFormation = function(stageId, ...)
  -- function num : 0_4 , upvalues : _ENV
  local stageData = ((TableData.gTable).BaseTrialStageData)[stageId]
  local enemyList = {}
  local groupList = split(stageData.monster_group_list, ":")
  local battle = ((TableData.gTable).BaseMonsterGroupData)[tonumber(groupList[1])]
  local monsters = split(battle.monster_list, ":")
  for i = 1, 6 do
    if tonumber(monsters[i]) == 0 then
      enemyList[i] = nil
    else
      enemyList[i] = monsters[i]
    end
  end
  return enemyList, stageData
end

-- DECOMPILER ERROR at PC21: Confused about usage of register: R0 in 'UnsetPending'

DailyDungeonMgr.ReqSaveFormation = function(cards, type, ...)
  -- function num : 0_5 , upvalues : _ENV
  ld("PlotDungeon")
  ;
  (PlotDungeonService.ReqSaveFormation)(cards, type)
end

-- DECOMPILER ERROR at PC24: Confused about usage of register: R0 in 'UnsetPending'

DailyDungeonMgr.OpenDailyDungeonBattleWindow = function(sData, ...)
  -- function num : 0_6 , upvalues : _ENV
  (CommonWinMgr.OpenDailyDungeonBattleWindow)(sData)
end

-- DECOMPILER ERROR at PC27: Confused about usage of register: R0 in 'UnsetPending'

DailyDungeonMgr.OpenPassCountReward = function(...)
  -- function num : 0_7
end

-- DECOMPILER ERROR at PC30: Confused about usage of register: R0 in 'UnsetPending'

DailyDungeonMgr.GetAssetTip = function(curTrialType, ...)
  -- function num : 0_8 , upvalues : _ENV
  if curTrialType == PlayType.CoinDungeon then
    return (PUtil.get)(40002001)
  else
    if curTrialType == PlayType.RoleExpDungeon then
      return (PUtil.get)(40002002)
    else
      if curTrialType == PlayType.EquipmentExpDungeon then
        return (PUtil.get)(40002003)
      end
    end
  end
end


