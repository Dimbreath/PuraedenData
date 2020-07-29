-- params : ...
-- function num : 0 , upvalues : _ENV
require("DailyDungeon_SweepWindowByName")
local DailyDungeonSweepWindow = {}
local uis, contentPane, selectIds = nil, nil, nil
local sweepHandTable = {}
DailyDungeonSweepWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, uis, DailyDungeonSweepWindow
  bridgeObj:SetView((WinResConfig.DailyDungeonSweepWindow).package, (WinResConfig.DailyDungeonSweepWindow).comName)
  contentPane = bridgeObj.contentPane
  contentPane:Center()
  uis = GetDailyDungeon_SweepWindowUis(contentPane)
  ;
  (DailyDungeonSweepWindow.InitShow)()
end

DailyDungeonSweepWindow.ResetSelectIdList = function(...)
  -- function num : 0_1 , upvalues : selectIds, _ENV, sweepHandTable
  selectIds = {[PlayType.CoinDungeon] = 0, [PlayType.RoleExpDungeon] = 0, [PlayType.EquipmentExpDungeon] = 0}
  sweepHandTable = {}
end

DailyDungeonSweepWindow.InitShow = function(...)
  -- function num : 0_2 , upvalues : uis, _ENV, DailyDungeonSweepWindow
  local CloseBtn = (uis.Sweep).CloseBtn
  ;
  (CloseBtn.onClick):Set(function(...)
    -- function num : 0_2_0 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.DailyDungeonSweepWindow).name)
  end
)
  local HeadChoiceTxt = (uis.Sweep).HeadChoiceTxt
  HeadChoiceTxt.text = (PUtil.get)(40002011)
  local OnceBtn = (uis.Sweep).OnceBtn
  OnceBtn.text = (PUtil.get)(40002012)
  ;
  (OnceBtn.onClick):Set(function(...)
    -- function num : 0_2_1 , upvalues : DailyDungeonSweepWindow
    (DailyDungeonSweepWindow.ClickSweepBtn)(1)
  end
)
  local TwiceBtn = (uis.Sweep).TwiceBtn
  TwiceBtn.text = (PUtil.get)(40002013)
  ;
  (TwiceBtn.onClick):Set(function(...)
    -- function num : 0_2_2 , upvalues : DailyDungeonSweepWindow
    (DailyDungeonSweepWindow.ClickSweepBtn)(2)
  end
)
  ;
  (DailyDungeonSweepWindow.UpdateSweepList)()
end

DailyDungeonSweepWindow.UpdateSweepList = function(...)
  -- function num : 0_3 , upvalues : DailyDungeonSweepWindow, uis, _ENV
  (DailyDungeonSweepWindow.ResetSelectIdList)()
  local SweepList = (uis.Sweep).SweepList
  if SweepList then
    SweepList:RemoveChildrenToPool()
    local typeTable = {PlayType.RoleExpDungeon, PlayType.CoinDungeon, PlayType.EquipmentExpDungeon}
    for trialIndex,trialType in ipairs(typeTable) do
      local oneSweepList = SweepList:AddItemFromPool((Util.GetResUrl)("DailyDungeon:SweepList"))
      ;
      (DailyDungeonSweepWindow.UpdateOneSweepList)(oneSweepList, trialType, trialIndex)
    end
  end
end

local typeTable = {
[PlayType.RoleExpDungeon] = {index = 2, displayType = PlayType.CoinDungeon}
, 
[PlayType.CoinDungeon] = {index = 1, displayType = PlayType.RoleExpDungeon}
, 
[PlayType.EquipmentExpDungeon] = {index = 3, displayType = PlayType.EquipmentExpDungeon}
}
DailyDungeonSweepWindow.UpdateOneSweepList = function(oneSweepList, trialType, trialIndex, ...)
  -- function num : 0_4 , upvalues : _ENV, typeTable, DailyDungeonSweepWindow
  if oneSweepList and trialType then
    local NameTxt = oneSweepList:GetChild("NameTxt")
    local remainTime = (DailyDungeonData.GetRemainChallengeTime)(trialType)
    if remainTime > 0 then
      NameTxt.text = (DailyDungeonMgr.GetAssetTip)(trialType) .. (PUtil.get)(40002017, remainTime)
    else
      NameTxt.text = (DailyDungeonMgr.GetAssetTip)(trialType) .. (PUtil.get)(40002018, remainTime)
    end
    local list = oneSweepList:GetChild("List")
    list:RemoveChildrenToPool()
    local trialDataList = (DailyDungeonData.GetTrialDataListByType)(trialType)
    for index,trialData in ipairs(trialDataList) do
      local oneSweepTrial = list:AddItemFromPool((Util.GetResUrl)("DailyDungeon:SweepDungeonChoice"))
      ChangeUIController(oneSweepTrial, "c1", (typeTable[trialType]).index - 1)
      ;
      (DailyDungeonSweepWindow.UpdateOneSweepTrial)(trialType, oneSweepTrial, trialData, index, (typeTable[trialType]).displayType)
    end
  end
end

DailyDungeonSweepWindow.UpdateOneSweepTrial = function(trialType, oneSweepTrial, trialData, index, displayType, ...)
  -- function num : 0_5 , upvalues : _ENV, sweepHandTable, selectIds
  if oneSweepTrial and trialData then
    local trialId = trialData.id
    do
      local btn = oneSweepTrial:GetChild("Dungeon_" .. displayType .. "_Btn")
      ChangeUIController(btn, "c2", index - 1)
      local canSweep = false
      local schedule = (DailyDungeonData.GetTrialStageSchedule)(trialId)
      if schedule >= 10000 then
        ChangeUIController(btn, "c1", 0)
        canSweep = true
        ChangeUIController(oneSweepTrial, "c2", 0)
      else
        local stageConfig = ((TableData.gTable).BaseTrialStageData)[trialId]
        if (DailyDungeonData.IsTrialStageOpen)(trialId) and (Util.CheckCondition)(stageConfig.open_condition, true) then
          ChangeUIController(btn, "c1", 0)
        else
          ChangeUIController(btn, "c1", 1)
        end
        ChangeUIController(oneSweepTrial, "c2", 2)
      end
      do
        local ProgressTxt = btn:GetChild("ProgressTxt")
        if ProgressTxt then
          ProgressTxt.text = (math.floor)(schedule / 100) .. "%"
        end
        sweepHandTable[trialId] = oneSweepTrial
        ;
        (oneSweepTrial.onClick):Set(function(...)
    -- function num : 0_5_0 , upvalues : schedule, selectIds, trialType, trialId, _ENV, oneSweepTrial, sweepHandTable
    if schedule >= 10000 then
      local id = selectIds[trialType]
      if id and id > 0 then
        if id == trialId then
          selectIds[trialType] = 0
          ChangeUIController(oneSweepTrial, "c2", 0)
        else
          local selectHand = sweepHandTable[id]
          if selectHand then
            ChangeUIController(selectHand, "c2", 0)
          end
          selectIds[trialType] = trialId
          ChangeUIController(oneSweepTrial, "c2", 1)
        end
      else
        do
          do
            selectIds[trialType] = trialId
            ChangeUIController(oneSweepTrial, "c2", 1)
            ;
            (MessageMgr.SendCenterTips)((PUtil.get)(40002015))
          end
        end
      end
    end
  end
)
      end
    end
  end
end

DailyDungeonSweepWindow.ClickSweepBtn = function(num, ...)
  -- function num : 0_6 , upvalues : _ENV, selectIds
  local idList = {}
  local remainMaxTime = 0
  for type,id in pairs(selectIds) do
    if id ~= 0 then
      (table.insert)(idList, id)
    end
    local remainTime = (DailyDungeonData.GetRemainChallengeTime)(type)
    remainMaxTime = (math.max)(remainTime, remainMaxTime)
  end
  if remainMaxTime < num then
    (MessageMgr.SendCenterTips)((PUtil.get)(40002019))
    return 
  end
  if #idList <= 0 then
    (MessageMgr.SendCenterTips)((PUtil.get)(40002014))
    return 
  end
  ;
  (DailyDungeonService.ReqSweepTrial)(idList, num)
end

DailyDungeonSweepWindow.OnShown = function(...)
  -- function num : 0_7
end

DailyDungeonSweepWindow.OnHide = function(...)
  -- function num : 0_8
end

DailyDungeonSweepWindow.OnClose = function(...)
  -- function num : 0_9 , upvalues : DailyDungeonSweepWindow, uis, contentPane
  (DailyDungeonSweepWindow.ResetSelectIdList)()
  uis = nil
  contentPane = nil
end

DailyDungeonSweepWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_10
end

return DailyDungeonSweepWindow

