-- params : ...
-- function num : 0 , upvalues : _ENV
require("Arena_RewardWindowByName")
local ArenaRewardWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local _rewardCtrl = nil
ArenaRewardWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, ArenaRewardWindow
  bridgeObj:SetView((WinResConfig.ArenaRewardWindow).package, (WinResConfig.ArenaRewardWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  contentPane:Center()
  uis = GetArena_RewardWindowUis(contentPane)
  uis = uis.Reward
  ;
  (ArenaRewardWindow.InitVariable)()
  ;
  (ArenaRewardWindow.InitText)()
  ;
  (ArenaRewardWindow.InitButtonEvent)()
  ;
  (ArenaRewardWindow.BindingUI)()
end

ArenaRewardWindow.BindingUI = function(...)
  -- function num : 0_1 , upvalues : _ENV, uis
  local winName = (WinResConfig.ArenaRewardWindow).name
  local BindingUI = RedDotMgr.BindingUI
  local RedDotComID = RedDotComID
  BindingUI(winName, RedDotComID.ArenaReward_Integer, (uis.RewardChangePanelGrp).FractionBtn)
  BindingUI(winName, RedDotComID.ArenaReward_Career, (uis.RewardChangePanelGrp).CareerBtn)
  ;
  (RedDotMgr.RefreshTreeUI)(winName)
end

ArenaRewardWindow.InitVariable = function(...)
  -- function num : 0_2 , upvalues : _rewardCtrl, uis, ArenaRewardWindow
  _rewardCtrl = (((uis.RewardChangePanelGrp).RewardRankingGrp).root):GetController("c1")
  ;
  (((uis.RewardChangePanelGrp).RewardFractionGrp).FractionList):SetVirtual()
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.RewardChangePanelGrp).RewardFractionGrp).FractionList).itemRenderer = ArenaRewardWindow.RefreshDailyRewardItem
  ;
  (((uis.RewardChangePanelGrp).RewardFractionGrp).FractionList):SetBeginAnim()
  ;
  (((uis.RewardChangePanelGrp).RewardCareerGrp).CareerList):SetVirtual()
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.RewardChangePanelGrp).RewardCareerGrp).CareerList).itemRenderer = ArenaRewardWindow.RefreshCareerRewardItem
  ;
  (((uis.RewardChangePanelGrp).RewardCareerGrp).CareerList):SetBeginAnim()
  ;
  (((uis.RewardChangePanelGrp).RewardRankingGrp).RankingList):SetVirtual()
  -- DECOMPILER ERROR at PC46: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.RewardChangePanelGrp).RewardRankingGrp).RankingList).itemRenderer = ArenaRewardWindow.RefreshDailyRankItem
  ;
  (((uis.RewardChangePanelGrp).RewardRankingGrp).RankingList):SetBeginAnim()
end

ArenaRewardWindow.InitText = function(...)
  -- function num : 0_3 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  (uis.RewardTxt).text = (PUtil.get)(60000473)
  ;
  (((uis.RewardChangePanelGrp).FractionBtn):GetChild("NameTxt")).text = (PUtil.get)(60000018)
  ;
  (((uis.RewardChangePanelGrp).CareerBtn):GetChild("NameTxt")).text = (PUtil.get)(60000019)
  ;
  (((uis.RewardChangePanelGrp).RankingBtn):GetChild("NameTxt")).text = (PUtil.get)(60000029)
  -- DECOMPILER ERROR at PC39: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.RewardChangePanelGrp).RewardCareerGrp).Tips_03_Txt).text = ""
  -- DECOMPILER ERROR at PC47: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.RewardChangePanelGrp).RewardCareerGrp).Tips_01_Txt).text = (PUtil.get)(60000488)
  -- DECOMPILER ERROR at PC55: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.RewardChangePanelGrp).RewardFractionGrp).Tips_04_Txt).text = (PUtil.get)(60000489)
  -- DECOMPILER ERROR at PC78: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.RewardChangePanelGrp).RewardFractionGrp).Tips_01_Txt).text = (PUtil.get)(60000497, "[color=" .. Const.GreenColor .. "]" .. (os.date)("%H:%M", ((ArenaData.BaseData).scoreRefreshTime).bTime * 0.001) .. "[/color]")
  -- DECOMPILER ERROR at PC82: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.RewardChangePanelGrp).RewardFractionGrp).Tips_02_Txt).text = ""
  -- DECOMPILER ERROR at PC86: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.RewardChangePanelGrp).RewardFractionGrp).Tips_03_Txt).text = ""
  -- DECOMPILER ERROR at PC94: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.RewardChangePanelGrp).RewardRankingGrp).Ranking_01_Txt).text = (PUtil.get)(60000505)
end

ArenaRewardWindow.InitButtonEvent = function(...)
  -- function num : 0_4 , upvalues : uis, ArenaRewardWindow
  (((uis.RewardChangePanelGrp).FractionBtn).onClick):Add(ArenaRewardWindow.ClickDailyRewardBtn)
  ;
  (((uis.RewardChangePanelGrp).CareerBtn).onClick):Add(ArenaRewardWindow.ClickCareerRewardBtn)
  ;
  (((uis.RewardChangePanelGrp).RankingBtn).onClick):Add(ArenaRewardWindow.ClickDailyRankBtn)
  ;
  ((uis.CloseBtn).onClick):Add(ArenaRewardWindow.ClickCloseBtn)
end

ArenaRewardWindow.InitEvent = function(...)
  -- function num : 0_5
end

ArenaRewardWindow.RemoveEvent = function(...)
  -- function num : 0_6
end

ArenaRewardWindow.OnShown = function(...)
  -- function num : 0_7 , upvalues : ArenaRewardWindow
  (ArenaRewardWindow.InitEvent)()
  ;
  (ArenaRewardWindow.Init)()
end

ArenaRewardWindow.OnHide = function(...)
  -- function num : 0_8 , upvalues : ArenaRewardWindow
  (ArenaRewardWindow.RemoveEvent)()
end

ArenaRewardWindow.Init = function(...)
  -- function num : 0_9 , upvalues : uis, _ENV, ArenaRewardWindow, argTable
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  (((uis.RewardChangePanelGrp).RewardFractionGrp).FractionTxt).text = (ArenaData.BaseData).score
  ;
  (ArenaRewardWindow.SetMyDailyRankReward)()
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

  if argTable[1] == ArenaRewardType.CareerReward then
    ((uis.RewardChangePanelGrp).c1Ctr).selectedIndex = 1
    ;
    (ArenaRewardWindow.ClickCareerRewardBtn)()
  else
    -- DECOMPILER ERROR at PC22: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((uis.RewardChangePanelGrp).c1Ctr).selectedIndex = 0
    ;
    (ArenaRewardWindow.ClickDailyRewardBtn)()
  end
end

ArenaRewardWindow.OnClose = function(...)
  -- function num : 0_10 , upvalues : uis, contentPane
  uis = nil
  contentPane = nil
end

ArenaRewardWindow.ClickCloseBtn = function(...)
  -- function num : 0_11 , upvalues : _ENV
  UIMgr:CloseWindow((WinResConfig.ArenaRewardWindow).name)
end

ArenaRewardWindow.ClickDailyRewardBtn = function(...)
  -- function num : 0_12 , upvalues : uis, _ENV, ArenaRewardWindow
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  (uis.ButtonBtn).text = (PUtil.get)(60000020)
  ;
  ((uis.ButtonBtn).onClick):Set(ArenaRewardWindow.ClickAllDailyRewardBtn)
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R0 in 'UnsetPending'

  ArenaData.HaveAvailableDailyReward = false
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.RewardChangePanelGrp).RewardFractionGrp).FractionList).numItems = #ArenaData.DailyRewardData
end

ArenaRewardWindow.ClickCareerRewardBtn = function(...)
  -- function num : 0_13 , upvalues : uis, _ENV, ArenaRewardWindow
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  (uis.ButtonBtn).text = (PUtil.get)(60000020)
  ;
  ((uis.ButtonBtn).onClick):Set(ArenaRewardWindow.ClickAllCareerRewardBtn)
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R0 in 'UnsetPending'

  ArenaData.HaveAvaiableCareerReward = false
  local beginFinish = (LuaTime.CheckTimeUp)(((ArenaData.BaseData).seasonSettleTime).bTime * 0.001)
  local endFinish = (LuaTime.CheckTimeUp)((((ArenaData.BaseData).seasonSettleTime).bTime + ((ArenaData.BaseData).seasonSettleTime).durationTime) * 0.001)
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R2 in 'UnsetPending'

  if beginFinish and not endFinish then
    (((uis.RewardChangePanelGrp).RewardCareerGrp).Tips_02_Txt).text = (PUtil.get)(60000034)
  else
    -- DECOMPILER ERROR at PC80: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (((uis.RewardChangePanelGrp).RewardCareerGrp).Tips_02_Txt).text = (PUtil.get)(60000487, "[color=" .. Const.GreenColor .. "]" .. (os.date)("%m " .. (PUtil.get)(60000032) .. " %d " .. (PUtil.get)(60000033) .. " %H:%M", ((ArenaData.BaseData).seasonSettleTime).bTime * 0.001) .. "[/color]")
  end
  -- DECOMPILER ERROR at PC87: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((uis.RewardChangePanelGrp).RewardCareerGrp).CareerList).numItems = #ArenaData.CareerRewardData
end

ArenaRewardWindow.ClickDailyRankBtn = function(...)
  -- function num : 0_14 , upvalues : uis, _ENV, ArenaRewardWindow
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  (uis.ButtonBtn).text = (PUtil.get)(60000004)
  ;
  ((uis.ButtonBtn).onClick):Set(ArenaRewardWindow.ClickCloseBtn)
  ;
  (ArenaRewardWindow.SetMyDailyRankReward)()
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.RewardChangePanelGrp).RewardRankingGrp).RankingList).numItems = #ArenaData.DailyRankRewardData
end

ArenaRewardWindow.ClickAllCareerRewardBtn = function(...)
  -- function num : 0_15 , upvalues : _ENV
  if ArenaData.HaveAvaiableCareerReward == false then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000031))
    return 
  end
  ;
  (ArenaMgr.TryAcquireReward)(0, ArenaRewardOperateType.All, ArenaRewardType.CareerReward)
end

ArenaRewardWindow.ClickAllDailyRewardBtn = function(...)
  -- function num : 0_16 , upvalues : _ENV
  if ArenaData.HaveAvailableDailyReward == false then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000031))
    return 
  end
  ;
  (ArenaMgr.TryAcquireReward)(0, ArenaRewardOperateType.All, ArenaRewardType.DailyReward)
end

ArenaRewardWindow.SetMyDailyRankReward = function(...)
  -- function num : 0_17 , upvalues : _ENV, _rewardCtrl, uis
  if (ArenaData.BaseData).rank == 0 then
    _rewardCtrl.selectedIndex = 1
  else
    _rewardCtrl.selectedIndex = 0
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (((uis.RewardChangePanelGrp).RewardRankingGrp).Ranking_02_Txt).text = (ArenaData.BaseData).rank
  end
  local rewards = {}
  if (ArenaData.BaseData).rank ~= 0 then
    local count = #ArenaData.DailyRankRewardData
    local item = nil
    for i = count, 1, -1 do
      item = (ArenaData.DailyRankRewardData)[i]
      if item.rank_low <= (ArenaData.BaseData).rank then
        rewards = split(item.reward, ",")
        break
      end
    end
  end
  do
    ;
    (((uis.RewardChangePanelGrp).RewardRankingGrp).MySelfRankingList):RemoveChildrenToPool()
    local count = #rewards
    local subItem = nil
    for i = 1, count do
      (Util.SetFrameByConfig)(rewards[i], ((uis.RewardChangePanelGrp).RewardRankingGrp).MySelfRankingList)
    end
  end
end

ArenaRewardWindow.RefreshDailyRewardItem = function(index, item, ...)
  -- function num : 0_18 , upvalues : _ENV
  local data = (ArenaData.DailyRewardData)[index + 1]
  local statue = (ArenaData.GetDailyRewardStatue)(data)
  ;
  (item:GetChild("Fraction_01_Txt")).text = (PUtil.get)(60000021, data.rank_high)
  ;
  (item:GetChild("Fraction_02_Txt")).text = ""
  local list = item:GetChild("FractionRewardList")
  list:RemoveChildrenToPool()
  local rewards = split(data.reward, ",")
  local count = #rewards
  local subItem = nil
  for i = 1, count do
    (Util.SetFrameByConfig)(rewards[i], list)
  end
  local btn = item:GetChild("GetBtn")
  ;
  (btn.onClick):Clear()
  local ctrl = item:GetController("c1")
  if statue == ArenaRewardStatue.Acquired then
    ctrl.selectedIndex = 1
  else
    ctrl.selectedIndex = 0
    -- DECOMPILER ERROR at PC63: Confused about usage of register: R10 in 'UnsetPending'

    if statue == ArenaRewardStatue.Available then
      ArenaData.HaveAvailableDailyReward = true
      btn.visible = true
      btn.text = (PUtil.get)(60000023)
      ;
      (btn.onClick):Add(function(...)
    -- function num : 0_18_0 , upvalues : _ENV, data
    (ArenaMgr.TryAcquireReward)(data.id, ArenaRewardOperateType.SpecifyId, ArenaRewardType.DailyReward)
  end
)
    else
      btn.visible = false
    end
  end
end

ArenaRewardWindow.RefreshCareerRewardItem = function(index, item, ...)
  -- function num : 0_19 , upvalues : _ENV
  local data = (ArenaData.CareerRewardData)[index + 1]
  local statue = (ArenaData.GetCareerRewardStatue)(data)
  ;
  (item:GetChild("Fraction_01_Txt")).text = (PUtil.get)(60000022, data.rank_low)
  ;
  (item:GetChild("Fraction_02_Txt")).text = ""
  local list = item:GetChild("FractionRewardList")
  list:RemoveChildrenToPool()
  local rewards = split(data.reward, ",")
  local count = #rewards
  local subItem = nil
  for i = 1, count do
    (Util.SetFrameByConfig)(rewards[i], list)
  end
  local btn = item:GetChild("GetBtn")
  ;
  (btn.onClick):Clear()
  local ctrl = item:GetController("c1")
  if statue == ArenaRewardStatue.Acquired then
    ctrl.selectedIndex = 1
  else
    ctrl.selectedIndex = 0
    -- DECOMPILER ERROR at PC63: Confused about usage of register: R10 in 'UnsetPending'

    if statue == ArenaRewardStatue.Available then
      ArenaData.HaveAvaiableCareerReward = true
      btn.visible = true
      btn.text = (PUtil.get)(60000023)
      ;
      (btn.onClick):Add(function(...)
    -- function num : 0_19_0 , upvalues : _ENV, data
    (ArenaMgr.TryAcquireReward)(data.id, ArenaRewardOperateType.SpecifyId, ArenaRewardType.CareerReward)
  end
)
    else
      btn.visible = false
    end
  end
end

ArenaRewardWindow.RefreshDailyRankItem = function(index, item, ...)
  -- function num : 0_20 , upvalues : _ENV
  local data = (ArenaData.DailyRankRewardData)[index + 1]
  if data.rank_low == data.rank_high then
    (item:GetChild("Fraction_01_Txt")).text = (PUtil.get)(60000030, data.rank_low)
  else
    ;
    (item:GetChild("Fraction_01_Txt")).text = (PUtil.get)(60000030, tostring(data.rank_low) .. "~" .. tostring(data.rank_high))
  end
  ;
  (item:GetChild("Fraction_02_Txt")).text = ""
  local list = item:GetChild("FractionRewardList")
  list:RemoveChildrenToPool()
  local rewards = split(data.reward, ",")
  local count = #rewards
  local subItem = nil
  for i = 1, count do
    (Util.SetFrameByConfig)(rewards[i], list)
  end
  ;
  (item:GetChild("GetBtn")).visible = false
end

ArenaRewardWindow.RefreshAllList = function(...)
  -- function num : 0_21 , upvalues : _ENV, uis
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

  (GRoot.inst).touchable = false
  ;
  (SimpleTimer.setTimeout)(0.3, function(...)
    -- function num : 0_21_0 , upvalues : _ENV
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

    (GRoot.inst).touchable = true
  end
)
  ;
  (((uis.RewardChangePanelGrp).RewardFractionGrp).FractionList):RefreshVirtualList()
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R0 in 'UnsetPending'

  ArenaData.HaveAvaiableCareerReward = false
  ;
  (((uis.RewardChangePanelGrp).RewardCareerGrp).CareerList):RefreshVirtualList()
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R0 in 'UnsetPending'

  ArenaData.HaveAvailableDailyReward = false
end

ArenaRewardWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_22 , upvalues : _ENV, ArenaRewardWindow
  if msgId == (WindowMsgEnum.Arena).E_MSG_REFRESH_REWARD then
    (ArenaRewardWindow.RefreshAllList)()
  end
end

return ArenaRewardWindow

