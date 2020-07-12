-- params : ...
-- function num : 0 , upvalues : _ENV
require("HandBook_ActivityPlotReviewByName")
local HandBookActivityPlotWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local listData = {}
HandBookActivityPlotWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, HandBookActivityPlotWindow
  bridgeObj:SetView((WinResConfig.HandBookActivityPlotWindow).package, (WinResConfig.HandBookActivityPlotWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetHandBook_ActivityPlotReviewUis(contentPane)
  ;
  (HandBookActivityPlotWindow.InitAssetStrip)()
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.ReviewList).itemRenderer = HandBookActivityPlotWindow.ItemRenderer
  ;
  (uis.ReviewList):SetVirtual()
end

HandBookActivityPlotWindow.InitListData = function(...)
  -- function num : 0_1 , upvalues : _ENV
  local OpenList = {}
  local ActivityChapterList = (HandBookMgr.GetChapterActivityType)()
  local ActData = (TableData.gTable).BaseHandbookAdventureChapterActData
  for _,v in pairs(ActData) do
    local activityType = v.activity_type
    local chapterList = ActivityChapterList[activityType]
    for _,v2 in ipairs(chapterList) do
      if (HandBookMgr.ActivityChapterIsUnlock)(v2.id) then
        (table.insert)(OpenList, v)
        break
      end
    end
  end
  return OpenList
end

HandBookActivityPlotWindow.ItemRenderer = function(index, obj, ...)
  -- function num : 0_2 , upvalues : listData, _ENV
  local data = listData[index + 1]
  if data == nil then
    return 
  end
  local loader = obj:GetChild("IconIoader")
  local num = obj:GetChild("NumberTxt")
  loader.url = (Util.GetItemUrl)(data.icon)
  num.text = "No." .. (string.format)("%03d", index + 1)
  ;
  (obj.onClick):Set(function(...)
    -- function num : 0_2_0 , upvalues : _ENV, data
    OpenWindow((WinResConfig.HandBookStoryPlotWindow).name, UILayer.HUD, (HandBookMgr.AdventureStoryType).Activity, data.activity_type)
  end
)
end

HandBookActivityPlotWindow.OnShown = function(...)
  -- function num : 0_3 , upvalues : listData, HandBookActivityPlotWindow, uis
  listData = (HandBookActivityPlotWindow.InitListData)()
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.ReviewList).numItems = #listData
end

HandBookActivityPlotWindow.OnHide = function(...)
  -- function num : 0_4
end

HandBookActivityPlotWindow.InitAssetStrip = function(...)
  -- function num : 0_5 , upvalues : _ENV, uis
  local m = {}
  m.windowName = (WinResConfig.HandBookActivityPlotWindow).name
  m.Tip = (PUtil.get)(20000404)
  m.model = uis.AssetStripGrp
  m.closeToWindow = (WinResConfig.HandBookMainWindow).name
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.PHYSICAL}
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

HandBookActivityPlotWindow.OnClose = function(...)
  -- function num : 0_6 , upvalues : _ENV, uis, contentPane, argTable
  (CommonWinMgr.RemoveAssets)((WinResConfig.HandBookActivityPlotWindow).name)
  uis = nil
  contentPane = nil
  argTable = {}
end

HandBookActivityPlotWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_7
end

return HandBookActivityPlotWindow

