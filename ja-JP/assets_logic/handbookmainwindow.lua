-- params : ...
-- function num : 0 , upvalues : _ENV
require("HandBook_HandBookMainByName")
local HandBookMainWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local currentID = 0
HandBookMainWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, HandBookMainWindow
  bridgeObj:SetView((WinResConfig.HandBookMainWindow).package, (WinResConfig.HandBookMainWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetHandBook_HandBookMainUis(contentPane)
  ;
  (HandBookMainWindow.InitAssetStrip)()
  ;
  (HandBookMainWindow.OnInitBtn)()
  ;
  (HandBookMainWindow.BindingUI)()
  ;
  (HandBookMainWindow.InitFunctionControl)()
  ;
  (HandBookData.SaveCurClickedFetterTreeId)((((HandBookData.GetAllInfo)())[1]).treeId)
end

HandBookMainWindow.BindingUI = function(...)
  -- function num : 0_1 , upvalues : _ENV, uis
  local winName = (WinResConfig.HandBookMainWindow).name
  local BindingUI = RedDotMgr.BindingUI
  local RedDotComID = RedDotComID
  BindingUI(winName, RedDotComID.HandBook_Story, uis.CardPlotBtn)
  BindingUI(winName, RedDotComID.HandBook_Album, uis.AlbumBtn)
  BindingUI(winName, RedDotComID.HandBook_Intimacy, uis.IntimacyBtn)
  BindingUI(winName, RedDotComID.HandBook_Relation, uis.RelationBtn)
  ;
  (RedDotMgr.RefreshTreeUI)(winName)
end

HandBookMainWindow.InitFunctionControl = function(...)
  -- function num : 0_2 , upvalues : _ENV, uis
  local winName = (WinResConfig.HandBookMainWindow).name
  local RegisterGuideAndControl = GuideData.RegisterGuideAndControl
  local ControlID = ControlID
  RegisterGuideAndControl(ControlID.HandBook_AdventureRecode, uis.StoryPlotBtn, winName)
  RegisterGuideAndControl(ControlID.HandBook_Story, uis.CardPlotBtn, winName)
  RegisterGuideAndControl(ControlID.HandBook_Album, uis.AlbumBtn, winName)
  RegisterGuideAndControl(ControlID.HandBook_Intimacy, uis.IntimacyBtn, winName)
  RegisterGuideAndControl(ControlID.HandBook_Relation, uis.RelationBtn, winName)
end

HandBookMainWindow.OnShown = function(...)
  -- function num : 0_3 , upvalues : _ENV
  (LuaSound.PlaySound)(LuaSound.COMMON_SLIDE_2, SoundBank.OTHER)
  ;
  (GuideMgr.PictureTriggerGuide)((WinResConfig.HandBookMainWindow).name)
end

HandBookMainWindow.SetShowModel = function(fashionId, intimacyLv, ...)
  -- function num : 0_4 , upvalues : _ENV, uis
  (Util.RecycleUIModel)(uis.PictureLoader, false)
  ;
  (Util.CreateShowModel)(fashionId, uis.PictureLoader)
  ;
  ((uis.PeachHeartBtn):GetChild("LevelTxt")).text = intimacyLv
end

HandBookMainWindow.OnHide = function(...)
  -- function num : 0_5
end

HandBookMainWindow.OnInitBtn = function(...)
  -- function num : 0_6 , upvalues : uis, _ENV
  ((uis.StoryPlotBtn).onClick):Set(function(...)
    -- function num : 0_6_0 , upvalues : _ENV
    print("冒险记录")
    OpenWindow((WinResConfig.HandBookPlotWindow).name, UILayer.HUD)
  end
)
  ;
  ((uis.AlbumBtn).onClick):Set(function(...)
    -- function num : 0_6_1 , upvalues : _ENV
    print("记忆相搏")
    ;
    (HandBookService.OnReqCGList)(false)
  end
)
  ;
  ((uis.RelationBtn).onClick):Set(function(...)
    -- function num : 0_6_2 , upvalues : _ENV
    print("羁绊")
    OpenWindow((WinResConfig.HandBookRelationWindow).name, UILayer.HUD)
  end
)
  ;
  ((uis.CardPlotBtn).onClick):Set(function(...)
    -- function num : 0_6_3 , upvalues : _ENV
    print("幕间物语")
    ;
    (HandBookService.OnReqCGCopySummary)((HandBookMgr.CardPlotWinType).Story)
  end
)
  ;
  ((uis.IntimacyBtn).onClick):Set(function(...)
    -- function num : 0_6_4 , upvalues : _ENV
    print("亲密度")
    ;
    (HandBookService.OnReqCGCopySummary)((HandBookMgr.CardPlotWinType).Intimacy)
  end
)
end

HandBookMainWindow.InitAssetStrip = function(...)
  -- function num : 0_7 , upvalues : _ENV, uis
  local m = {}
  m.windowName = (WinResConfig.HandBookMainWindow).name
  m.Tip = (PUtil.get)(20000126)
  m.model = uis.AssetStripGrp
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.PHYSICAL}
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

HandBookMainWindow.OnClose = function(...)
  -- function num : 0_8 , upvalues : _ENV, uis, contentPane, argTable
  (RedDotMgr.RemoveUIRefer)((WinResConfig.HandBookMainWindow).name)
  ;
  (GuideData.AbolishControlRefer)((WinResConfig.HandBookMainWindow).name)
  ;
  (CommonWinMgr.RemoveAssets)((WinResConfig.HandBookMainWindow).name)
  uis = nil
  contentPane = nil
  argTable = {}
end

HandBookMainWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_9
  if msgId == 1 then
  end
end

return HandBookMainWindow

