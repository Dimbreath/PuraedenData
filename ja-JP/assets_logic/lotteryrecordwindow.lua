-- params : ...
-- function num : 0 , upvalues : _ENV
require("Lottery_RecordByName")
local LotteryRecordWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local recordData = {}
LotteryRecordWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, recordData, LotteryRecordWindow
  bridgeObj:SetView((WinResConfig.LotteryRecordWindow).package, (WinResConfig.LotteryRecordWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  contentPane:Center()
  uis = GetLottery_RecordUis(contentPane)
  local m = {}
  m.windowName = (WinResConfig.LotteryRecordWindow).name
  m.Tip = (PUtil.get)(188)
  m.model = uis.AssetStripGrp
  m.closeToWindow = (WinResConfig.HomeWindow).name
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.PHYSICAL}
  ;
  (CommonWinMgr.RegisterAssets)(m)
  -- DECOMPILER ERROR at PC52: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((uis.AssetStripGrp).CloseAssetGrp).visible = false
  if argTable[1] then
    recordData = argTable[1]
  else
    return 
  end
  ;
  (LotteryRecordWindow.RefreshWindow)()
end

LotteryRecordWindow.RefreshWindow = function(...)
  -- function num : 0_1 , upvalues : uis, _ENV, recordData
  (uis.TipsList):RemoveChildrenToPool()
  ;
  (table.sort)(recordData, function(a, b, ...)
    -- function num : 0_1_0
    do return b.recordTime < a.recordTime end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  for key,value in pairs(recordData) do
    local recordItem = (uis.TipsList):AddItemFromPool()
    ;
    (recordItem:GetChild("WordTxt")).text = (PUtil.get)(value.wordId) .. "[color=#3dffbd](" .. (LuaTime.GetFormatTimeStr)("%Y/%m/%d", value.recordTime) .. ")[/color]"
    local cardList = recordItem:GetChild("CardList")
    ;
    (table.sort)(value.cardIds, function(a, b, ...)
    -- function num : 0_1_1 , upvalues : _ENV
    local ac = ((TableData.gTable).BaseCardData)[a]
    local bc = ((TableData.gTable).BaseCardData)[b]
    if bc.id >= ac.id then
      do return ac.intelligence ~= bc.intelligence end
      do return bc.intelligence < ac.intelligence end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
    for j,k in pairs(value.cardIds) do
      local cardItem = cardList:AddItemFromPool()
      ;
      (Util.SetShowHeadFrame)(cardItem, k)
    end
  end
end

LotteryRecordWindow.OnClose = function(...)
  -- function num : 0_2 , upvalues : _ENV, uis, contentPane, argTable, recordData
  (CommonWinMgr.RemoveAssets)((WinResConfig.LotteryRecordWindow).name)
  uis = nil
  contentPane = nil
  argTable = nil
  recordData = {}
end

return LotteryRecordWindow

