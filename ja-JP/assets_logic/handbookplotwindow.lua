-- params : ...
-- function num : 0 , upvalues : _ENV
require("HandBook_AllPlotByName")
local HandBookPlotWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
HandBookPlotWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, HandBookPlotWindow
  bridgeObj:SetView((WinResConfig.HandBookPlotWindow).package, (WinResConfig.HandBookPlotWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetHandBook_AllPlotUis(contentPane)
  ;
  (HandBookPlotWindow.InitAssetStrip)()
end

HandBookPlotWindow.OnShown = function(...)
  -- function num : 0_1 , upvalues : uis, _ENV
  ((uis.ActivityPlotBtn).onClick):Set(function(...)
    -- function num : 0_1_0 , upvalues : _ENV
    (HandBookService.OnReqAdventureStoryChapter)((ProtoEnum.E_BATTLE_TYPE).ACTIVITY)
  end
)
  ;
  ((uis.AdventurePlotBtn).onClick):Set(function(...)
    -- function num : 0_1_1 , upvalues : _ENV
    (HandBookService.OnReqAdventureStoryChapter)((ProtoEnum.E_BATTLE_TYPE).STORY)
  end
)
end

HandBookPlotWindow.OnHide = function(...)
  -- function num : 0_2
end

HandBookPlotWindow.OnClose = function(...)
  -- function num : 0_3 , upvalues : _ENV, uis, contentPane, argTable
  (CommonWinMgr.RemoveAssets)((WinResConfig.HandBookPlotWindow).name)
  uis = nil
  contentPane = nil
  argTable = {}
end

HandBookPlotWindow.InitAssetStrip = function(...)
  -- function num : 0_4 , upvalues : _ENV, uis
  local m = {}
  m.windowName = (WinResConfig.HandBookPlotWindow).name
  m.Tip = (PUtil.get)(20000128)
  m.model = uis.AssetStripGrp
  m.closeToWindow = (WinResConfig.HandBookMainWindow).name
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.PHYSICAL}
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

HandBookPlotWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_5
end

return HandBookPlotWindow

