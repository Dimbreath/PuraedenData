-- params : ...
-- function num : 0 , upvalues : _ENV
require("Tower_RewardShowWindowByName")
local TIPS_RESOURCES = "LuckTips"
local TowerChallengeWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local _config = nil
local _rewardCount = 0
local _reward = {}
local _luckyReward = {}
local _disableClick = false
local _tipsPanel = nil
TowerChallengeWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, TowerChallengeWindow
  bridgeObj:SetView((WinResConfig.TowerChallengeWindow).package, (WinResConfig.TowerChallengeWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  argTable.StageId = argTable[1]
  argTable.SkipSetFormation = argTable[2]
  uis = GetTower_RewardShowWindowUis(contentPane)
  ;
  (TowerChallengeWindow.InitVariable)()
  ;
  (TowerChallengeWindow.InitText)()
  ;
  (TowerChallengeWindow.InitList)()
  ;
  (TowerChallengeWindow.InitButtonEvent)()
  ;
  (TowerChallengeWindow.InitFunctionControl)()
  ;
  (LeanTween.delayedCall)(0.6, function(...)
    -- function num : 0_0_0 , upvalues : _ENV, argTable
    if UIMgr:IsWindowOpen((WinResConfig.TowerChallengeWindow).name) == false then
      return 
    end
    ;
    (BattleBackground.PreLoad)(argTable.StageId, (ProtoEnum.E_BATTLE_TYPE).TOWER)
    local enemyList = (BattleData.GetMonsterList)(1, argTable.StageId, (ProtoEnum.E_BATTLE_TYPE).TOWER)
    for _,monsterId in pairs(enemyList) do
      (BattleResource.PreLoadMonster)(monsterId)
    end
    local myselfList = (Util.CovertRemoteFormationToLocal)(TowerData.FormationInfo)
    for _,cardId in pairs(myselfList) do
      (BattleResource.PreLoadCard)(cardId)
    end
  end
)
end

TowerChallengeWindow.InitFunctionControl = function(...)
  -- function num : 0_1 , upvalues : _ENV, uis
  local winName = (WinResConfig.TowerChallengeWindow).name
  local RegisterGuideAndControl = GuideData.RegisterGuideAndControl
  local ControlID = ControlID
  RegisterGuideAndControl(ControlID.TowerDetail_Challenge, (uis.RewardShowGrp).BattleBtn, winName)
  RegisterGuideAndControl(ControlID.TowerDetail_Smash, (uis.RewardShowGrp).SweepBtn, winName)
end

TowerChallengeWindow.InitVariable = function(...)
  -- function num : 0_2 , upvalues : uis
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R0 in 'UnsetPending'

  (((uis.RewardShowGrp).Reward_02_Tips).c1Ctr).selectedIndex = 1
end

TowerChallengeWindow.InitText = function(...)
  -- function num : 0_3 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.RewardShowGrp).TitleTxt).text = (PUtil.get)(20000336)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.RewardShowGrp).SweepBtn).text = (PUtil.get)(60000007)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.RewardShowGrp).BattleBtn).text = (PUtil.get)(60000008)
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.RewardShowGrp).Number_01_Grp).NameTxt).text = (PUtil.get)(20000007)
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.RewardShowGrp).Number_02_Grp).NameTxt).text = (PUtil.get)(20000008)
  -- DECOMPILER ERROR at PC44: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.RewardShowGrp).Reward_01_Tips).ShowTxt).text = (PUtil.get)(60000370)
  -- DECOMPILER ERROR at PC52: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.RewardShowGrp).Reward_02_Tips).ShowTxt).text = (PUtil.get)(60000450)
  -- DECOMPILER ERROR at PC60: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.RewardShowGrp).Reward_02_Tips).LuckTxt).text = (PUtil.get)(55)
  -- DECOMPILER ERROR at PC67: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.RewardShowGrp).BattleWordTxt).text = (PUtil.get)(20000056)
end

TowerChallengeWindow.InitList = function(...)
  -- function num : 0_4 , upvalues : uis, _ENV, TowerChallengeWindow
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R0 in 'UnsetPending'

  (((uis.RewardShowGrp).Reward_01_Tips).RewardList).defaultItem = (Util.GetItemUrl)(TowerData.REWARD_ITEM_RESOURCE)
  ;
  (((uis.RewardShowGrp).Reward_01_Tips).RewardList):SetVirtual()
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.RewardShowGrp).Reward_01_Tips).RewardList).itemRenderer = TowerChallengeWindow.RefreshNormalItems
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.RewardShowGrp).Reward_02_Tips).RewardList).defaultItem = (Util.GetItemUrl)(TowerData.REWARD_ITEM_RESOURCE)
  ;
  (((uis.RewardShowGrp).Reward_02_Tips).RewardList):SetVirtual()
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.RewardShowGrp).Reward_02_Tips).RewardList).itemRenderer = TowerChallengeWindow.RefreshLuckItems
end

TowerChallengeWindow.InitButtonEvent = function(...)
  -- function num : 0_5 , upvalues : uis, TowerChallengeWindow
  (((uis.RewardShowGrp).CloseBtn).onClick):Add(TowerChallengeWindow.ClickCloseBtn)
  ;
  (((uis.RewardShowGrp).BattleBtn).onClick):Add(TowerChallengeWindow.ClickChallengeBtn)
  ;
  (((uis.RewardShowGrp).SweepBtn).onClick):Add(TowerChallengeWindow.ClickSmashBtn)
  ;
  ((((uis.RewardShowGrp).Reward_02_Tips).TipsBtn).onClick):Add(TowerChallengeWindow.ClickTipsBtn)
end

TowerChallengeWindow.InitEvent = function(...)
  -- function num : 0_6
end

TowerChallengeWindow.RemoveEvent = function(...)
  -- function num : 0_7
end

TowerChallengeWindow.OnShown = function(...)
  -- function num : 0_8 , upvalues : TowerChallengeWindow
  (TowerChallengeWindow.InitEvent)()
  ;
  (TowerChallengeWindow.Init)()
end

TowerChallengeWindow.OnHide = function(...)
  -- function num : 0_9
end

TowerChallengeWindow.Init = function(...)
  -- function num : 0_10 , upvalues : _ENV, _config, argTable, TowerChallengeWindow
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

  (GRoot.inst).IgnoreItemClick = false
  ;
  (TowerData.InitLuckyInfo)()
  _config = ((TableData.gTable).BaseTowerStageData)[argTable.StageId]
  ;
  (TowerChallengeWindow.RefreshBasicInfo)()
  ;
  (TowerChallengeWindow.RefreshRewards)()
end

TowerChallengeWindow.OnClose = function(...)
  -- function num : 0_11 , upvalues : _tipsPanel, _ENV, TowerChallengeWindow, uis, contentPane, argTable
  if _tipsPanel ~= nil then
    _tipsPanel:Dispose()
    _tipsPanel = nil
  end
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (GRoot.inst).IgnoreItemClick = true
  ;
  (GRoot.inst):ClearCustomPopups()
  ;
  (GuideData.AbolishControlRefer)((WinResConfig.TowerChallengeWindow).name)
  ;
  (TowerChallengeWindow.RemoveEvent)()
  uis = nil
  contentPane = nil
  argTable = {}
end

TowerChallengeWindow.ClickTipsBtn = function(...)
  -- function num : 0_12 , upvalues : _tipsPanel, _ENV, TIPS_RESOURCES, uis
  if _tipsPanel == nil then
    _tipsPanel = (UIPackage.CreateObject)((WinResConfig.TowerBounsLevelWindow).package, TIPS_RESOURCES)
    ;
    (((uis.RewardShowGrp).Reward_02_Tips).root):AddChild(_tipsPanel)
    _tipsPanel.x = (((uis.RewardShowGrp).Reward_02_Tips).TipsBtn).x + (((uis.RewardShowGrp).Reward_02_Tips).TipsBtn).width * 0.5 - _tipsPanel.width * 0.5
    _tipsPanel.y = (((uis.RewardShowGrp).Reward_02_Tips).TipsBtn).y - _tipsPanel.height + 20
    ;
    (_tipsPanel:GetChild("ItemWordTxt")).text = (PUtil.get)(60000479)
  end
  ;
  (GRoot.inst):AddCustomPopups(_tipsPanel, function(...)
    -- function num : 0_12_0 , upvalues : _tipsPanel
    _tipsPanel.visible = false
  end
)
  _tipsPanel.visible = true
end

TowerChallengeWindow.RefreshBasicInfo = function(...)
  -- function num : 0_13 , upvalues : uis, _config, _ENV, argTable
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.RewardShowGrp).NumberTxt).text = _config.name
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.RewardShowGrp).BackImageGrp).ImageLoader).url = (Util.GetItemUrl)((((TableData.gTable).BaseTowerStageData)[argTable.StageId]).battle_banner_show)
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.RewardShowGrp).BackImageGrp).ImageLoader).fill = (FairyGUI.FillType).ScaleNoBorder
  local config = ((TableData.gTable).BaseBuffPreBattleData)[tonumber(_config.buff_id)]
  -- DECOMPILER ERROR at PC38: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((uis.RewardShowGrp).BuffGrp).IconLoader).url = (Util.GetItemUrl)(config.icon)
  -- DECOMPILER ERROR at PC43: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((uis.RewardShowGrp).BuffGrp).NameTxt).text = config.name
  -- DECOMPILER ERROR at PC48: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((uis.RewardShowGrp).BuffGrp).WordTxt).text = config.remark
  -- DECOMPILER ERROR at PC53: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((uis.RewardShowGrp).Number_01_Grp).NumberTxt).text = _config.fc
  -- DECOMPILER ERROR at PC62: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((uis.RewardShowGrp).Number_02_Grp).NumberTxt).text = (CardData.GetFormationfc)(TowerData.FormationInfo)
  -- DECOMPILER ERROR at PC68: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((uis.RewardShowGrp).Reward_02_Tips).LuckNumberTxt).text = TowerData.CurrentLucky
  -- DECOMPILER ERROR at PC75: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.RewardShowGrp).BattleNumberTxt).text = (ActorData.GetNumByCost)(_config.cost)
  -- DECOMPILER ERROR at PC88: Confused about usage of register: R1 in 'UnsetPending'

  if (((TowerData.BaseInfo)[TowerData.CurrentLayer])[argTable.StageId]).isPass then
    ((uis.RewardShowGrp).c1Ctr).selectedIndex = 1
  else
    -- DECOMPILER ERROR at PC92: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((uis.RewardShowGrp).c1Ctr).selectedIndex = 0
  end
end

TowerChallengeWindow.RefreshRewards = function(...)
  -- function num : 0_14 , upvalues : _reward, _luckyReward, _ENV, argTable, uis
  _reward = (TowerData.GetReward)(TowerData.CurrentLayer, argTable.StageId)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.RewardShowGrp).Reward_01_Tips).RewardList).numItems = #_reward
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.RewardShowGrp).Reward_02_Tips).RewardList).numItems = #_luckyReward
end

TowerChallengeWindow.RefreshNormalItems = function(index, item, ...)
  -- function num : 0_15 , upvalues : _reward, _ENV
  index = index + 1
  local data = _reward[index]
  ;
  (item.onClick):Clear()
  ;
  (Util.SetAllItemIcon)(item, data.Id, data.Amount, false, data.First, false, data.Lucky)
  local ConfigData, type = (Util.GetConfigDataByID)(data.Id)
  if type == PropType.EQUIP and data.Chance ~= nil then
    local frame = item:GetChild("EquiotIcon")
    ;
    (frame:GetController("c5")).selectedIndex = data.Chance
  end
end

TowerChallengeWindow.RefreshLuckItems = function(index, item, ...)
  -- function num : 0_16 , upvalues : _luckyReward, _ENV
  index = index + 1
  local data = _luckyReward[index]
  local lock = data.LuckyCondition > 0
  ;
  (item.onClick):Clear()
  ;
  (Util.SetAllItemIcon)(item, data.Id, data.Amount, false, data.First, false, data.Lucky, data.LuckyCondition > 0, data.LuckyCondition > 0)
  if lock then
    (item.onClick):Add(function(...)
    -- function num : 0_16_0 , upvalues : _ENV, data
    (MessageMgr.SendCenterTips)((PUtil.get)(60000372, data.LuckyCondition))
  end
)
  end
  local ConfigData, type = (Util.GetConfigDataByID)(data.Id)
  do
    if type == PropType.EQUIP and data.Chance ~= nil then
      local frame = item:GetChild("EquiotIcon")
      ;
      (frame:GetController("c5")).selectedIndex = data.Chance
    end
    -- DECOMPILER ERROR: 5 unprocessed JMP targets
  end
end

TowerChallengeWindow.RefreshRewardItems = function(index, item, ...)
  -- function num : 0_17 , upvalues : _rewardCount, _reward, _ENV
  index = index + 1
  local data = nil
  if index == _rewardCount + 1 then
    return 
  else
    if index <= _rewardCount then
      data = _reward[index]
    else
      data = _lockedReward[index - _rewardCount - 1]
    end
  end
  local lock = data.LuckyCondition > 0
  ;
  (item.onClick):Clear()
  ;
  (Util.SetAllItemIcon)(item, data.Id, data.Amount, false, data.First, false, data.Lucky, lock, lock)
  if lock then
    (item.onClick):Add(function(...)
    -- function num : 0_17_0 , upvalues : _ENV, data
    (MessageMgr.SendCenterTips)((PUtil.get)(60000372, data.LuckyCondition))
  end
)
  end
  local ConfigData, type = (Util.GetConfigDataByID)(data.Id)
  do
    if type == PropType.EQUIP and data.Chance ~= nil then
      local frame = item:GetChild("EquiotIcon")
      ;
      (frame:GetController("c5")).selectedIndex = data.Chance
    end
    -- DECOMPILER ERROR: 3 unprocessed JMP targets
  end
end

TowerChallengeWindow.ClickCloseBtn = function(...)
  -- function num : 0_18 , upvalues : _ENV
  UIMgr:CloseWindow((WinResConfig.TowerChallengeWindow).name)
end

TowerChallengeWindow.ClickChallengeBtn = function(...)
  -- function num : 0_19 , upvalues : TowerChallengeWindow, argTable, _ENV, _reward
  (TowerChallengeWindow.ClickCloseBtn)()
  local stageId = argTable.StageId
  local skip = argTable.SkipSetFormation
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (GRoot.inst).touchable = false
  ;
  (SimpleTimer.setTimeout)(0.5, function(...)
    -- function num : 0_19_0 , upvalues : _ENV, stageId, skip, _reward
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

    (GRoot.inst).touchable = true
    ;
    (TowerMgr.TryEnterTower)(TowerData.CurrentLayer, stageId, false, skip, _reward)
  end
)
end

TowerChallengeWindow.ClickSmashBtn = function(...)
  -- function num : 0_20 , upvalues : TowerChallengeWindow, argTable, _ENV, _reward
  (TowerChallengeWindow.ClickCloseBtn)()
  local stageId = argTable.StageId
  local skip = argTable.SkipSetFormation
  ;
  (SimpleTimer.setTimeout)(0.5, function(...)
    -- function num : 0_20_0 , upvalues : _ENV, stageId, skip, _reward
    (TowerMgr.TryEnterTower)(TowerData.CurrentLayer, stageId, true, skip, _reward)
  end
)
end

TowerChallengeWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_21
end

return TowerChallengeWindow

