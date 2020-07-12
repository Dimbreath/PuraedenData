-- params : ...
-- function num : 0 , upvalues : _ENV
require("HandBook_AlbumByName")
require("HandBook_AlbumCGByName")
local HandBookAlbumWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local winType = {Main = 1, Branch = 2, Activity = 3}
local OpenType = winType.Main
local listData = {}
HandBookAlbumWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, HandBookAlbumWindow
  bridgeObj:SetView((WinResConfig.HandBookAlbumWindow).package, (WinResConfig.HandBookAlbumWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetHandBook_AlbumUis(contentPane)
  ;
  (HandBookAlbumWindow.InitAssetStrip)()
  ;
  (HandBookAlbumWindow.InitBtn)()
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.AlbumCGList).CGList).itemRenderer = HandBookAlbumWindow.ListRender
  ;
  ((uis.AlbumCGList).CGList):SetBeginAnim(false, "up", 0.05, 0.05, true)
  ;
  ((uis.AlbumCGList).CGList):SetVirtual()
  ;
  (HandBookAlbumWindow.BindingUI)()
  ;
  (((uis.AlbumPanelGrp).MuJianBtn).onClick):Call()
end

HandBookAlbumWindow.BindingUI = function(...)
  -- function num : 0_1 , upvalues : _ENV, uis
  local winName = (WinResConfig.HandBookAlbumWindow).name
  local BindingUI = RedDotMgr.BindingUI
  local RedDotComID = RedDotComID
  BindingUI(winName, RedDotComID.HandBook_Collection_Album, (uis.AlbumPanelGrp).MuJianBtn)
  BindingUI(winName, RedDotComID.HandBook_Collection_Album_Activity, (uis.AlbumPanelGrp).ShouXinBtn)
  ;
  (RedDotMgr.RefreshTreeUI)(winName)
end

HandBookAlbumWindow.OnShown = function(...)
  -- function num : 0_2 , upvalues : OpenType, winType, uis, HandBookAlbumWindow
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  if OpenType == winType.Main then
    ((uis.AlbumPanelGrp).c1Ctr).selectedIndex = 0
    ;
    (((uis.AlbumPanelGrp).MuJianBtn).onClick):Call()
  else
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((uis.AlbumPanelGrp).c1Ctr).selectedIndex = 1
    ;
    (((uis.AlbumPanelGrp).ShouXinBtn).onClick):Call()
  end
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.AlbumPanelGrp).root).visible = (HandBookAlbumWindow.GetCountNum)(winType.Activity) > 0
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

HandBookAlbumWindow.GetCountNum = function(type, ...)
  -- function num : 0_3 , upvalues : _ENV
  local count = 0
  local data = (TableData.gTable).BaseHandbookCGData
  for _,v in pairs(data) do
    if v.type == type then
      count = count + 1
    end
  end
  return count
end

HandBookAlbumWindow.SetCollectionNum = function(...)
  -- function num : 0_4 , upvalues : _ENV, OpenType, uis, listData
  local num = (HandBookMgr.GetAlbumCollectionNumByType)(OpenType)
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

  if num == 0 then
    (uis.NumberTxt).text = (PUtil.get)(20000135, num, #listData)
  else
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (uis.NumberTxt).text = (PUtil.get)(20000152, num, #listData)
  end
end

HandBookAlbumWindow.RefreshList = function(...)
  -- function num : 0_5 , upvalues : listData, _ENV, OpenType, winType, uis, HandBookAlbumWindow
  listData = {}
  local data = (TableData.gTable).BaseHandbookCGData
  for _,v in pairs(data) do
    if tonumber(v.type) == OpenType then
      if OpenType == winType.Branch then
        local cardData = ((TableData.gTable).BaseCardData)[v.chapter_id]
        if cardData and cardData.is_handbookstage_open == 1 then
          (table.insert)(listData, v)
        end
      else
        do
          do
            if OpenType == winType.Activity then
              (table.insert)(listData, v)
            else
              if OpenType == winType.Main then
                (table.insert)(listData, v)
              end
            end
            -- DECOMPILER ERROR at PC54: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC54: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC54: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC54: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC54: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
  ;
  (table.sort)(listData, function(a, b, ...)
    -- function num : 0_5_0
    do return a.id < b.id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  -- DECOMPILER ERROR at PC65: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.AlbumCGList).CGList).numItems = #listData
  ;
  (HandBookAlbumWindow.SetCollectionNum)()
end

HandBookAlbumWindow.CheckRedDot = function(...)
  -- function num : 0_6 , upvalues : OpenType, winType, _ENV, HandBookAlbumWindow
  if OpenType == winType.Main then
    (RedDotMgr.EliminateRedDot)((WinResConfig.HandBookAlbumWindow).name, RedDotComID.HandBook_Collection_Album)
  else
    ;
    (RedDotMgr.EliminateRedDot)((WinResConfig.HandBookAlbumWindow).name, RedDotComID.HandBook_Collection_Album_Activity)
  end
  ;
  (SimpleTimer.setTimeout)(1, function(...)
    -- function num : 0_6_0 , upvalues : HandBookAlbumWindow
    (HandBookAlbumWindow.DeleteNewLabel)()
  end
)
end

HandBookAlbumWindow.DeleteNewLabel = function(...)
  -- function num : 0_7 , upvalues : _ENV, listData
  for _,v in ipairs(listData) do
    local isGet, isNew = (HandBookMgr.GetAlbumState)(v.id)
    if isNew and isGet then
      (HandBookMgr.SetAlbumNotNew)(v.id)
    end
  end
end

HandBookAlbumWindow.CheckIsContainNew = function(...)
  -- function num : 0_8 , upvalues : _ENV, listData
  for _,v in ipairs(listData) do
    local isGet, isNew = (HandBookMgr.GetAlbumState)(v.id)
    if isNew then
      return true
    end
  end
  return false
end

HandBookAlbumWindow.ListRender = function(index, obj, ...)
  -- function num : 0_9 , upvalues : listData, _ENV, OpenType, winType
  local data = listData[index + 1]
  local isGet, isNew = nil, nil
  obj = obj:GetChild("AlbumCG")
  local model = GetHandBook_AlbumCGUis(obj)
  ;
  (obj:GetChild("IconImage")).url = (Util.GetItemUrl)(data.icon)
  ChangeUIController(obj, "c2", 0)
  isGet = (HandBookMgr.GetAlbumState)(data.id)
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R6 in 'UnsetPending'

  if OpenType == winType.Main or OpenType == winType.Activity then
    (model.NumberTxt).text = "No." .. (string.format)("%03d", data.index)
  else
    local cardData = ((TableData.gTable).BaseCardData)[data.chapter_id]
    -- DECOMPILER ERROR at PC54: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (model.NumberTxt).text = cardData.name
  end
  do
    -- DECOMPILER ERROR at PC59: Confused about usage of register: R6 in 'UnsetPending'

    if isGet then
      (model.WordTxt).text = data.name
    end
    if isGet then
      ChangeUIController(obj, "c1", 0)
    else
      ChangeUIController(obj, "c1", 1)
    end
    if isNew then
      ChangeUIController(obj, "c3", 0)
    else
      ChangeUIController(obj, "c3", 1)
    end
    ;
    (obj.onClick):Set(function(...)
    -- function num : 0_9_0 , upvalues : isGet, isNew, _ENV, data, obj, OpenType, winType
    if isGet then
      if isNew then
        (HandBookService.OnReqOpenCG)(data.id)
        ChangeUIController(obj, "c3", 1)
      end
      ;
      (CommonWinMgr.OpenCGShow)(data.id, false)
    else
      if OpenType == winType.Activity then
        (MessageMgr.SendCenterTips)((PUtil.get)(20000507))
      else
        ;
        (MessageMgr.SendCenterTips)((PUtil.get)(20000246))
      end
    end
  end
)
  end
end

HandBookAlbumWindow.OnHide = function(...)
  -- function num : 0_10
end

HandBookAlbumWindow.InitBtn = function(...)
  -- function num : 0_11 , upvalues : uis, _ENV, OpenType, winType, HandBookAlbumWindow
  (((uis.AlbumPanelGrp).MuJianBtn):GetChild("NameTxt")).text = (PUtil.get)(20000253)
  ;
  (((uis.AlbumPanelGrp).MuJianBtn).onClick):Set(function(...)
    -- function num : 0_11_0 , upvalues : OpenType, winType, HandBookAlbumWindow
    OpenType = winType.Main
    ;
    (HandBookAlbumWindow.RefreshList)()
    ;
    (HandBookAlbumWindow.CheckRedDot)()
  end
)
  ;
  (((uis.AlbumPanelGrp).ShouXinBtn):GetChild("NameTxt")).text = (PUtil.get)(20000506)
  ;
  (((uis.AlbumPanelGrp).ShouXinBtn).onClick):Set(function(...)
    -- function num : 0_11_1 , upvalues : OpenType, winType, HandBookAlbumWindow
    OpenType = winType.Activity
    ;
    (HandBookAlbumWindow.RefreshList)()
    ;
    (HandBookAlbumWindow.CheckRedDot)()
  end
)
end

HandBookAlbumWindow.OnClose = function(...)
  -- function num : 0_12 , upvalues : _ENV, uis, contentPane, argTable, listData
  (CommonWinMgr.RemoveAssets)((WinResConfig.HandBookAlbumWindow).name)
  uis = nil
  contentPane = nil
  argTable = {}
  listData = {}
end

HandBookAlbumWindow.InitAssetStrip = function(...)
  -- function num : 0_13 , upvalues : _ENV, uis, OpenType, winType
  local m = {}
  m.windowName = (WinResConfig.HandBookAlbumWindow).name
  m.Tip = (PUtil.get)(20000132)
  m.model = uis.AssetStripGrp
  m.closeToWindow = (WinResConfig.HandBookMainWindow).name
  m.moneyTypes = {}
  m.CloseBtnFun = function(...)
    -- function num : 0_13_0 , upvalues : OpenType, winType
    OpenType = winType.Album
  end

  ;
  (CommonWinMgr.RegisterAssets)(m)
end

HandBookAlbumWindow.GetIDIndex = function(id, ...)
  -- function num : 0_14 , upvalues : _ENV, listData
  for i,v in ipairs(listData) do
    if v.id == id then
      return i
    end
  end
end

HandBookAlbumWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_15 , upvalues : HandBookAlbumWindow, uis, _ENV
  if msgId == 1 then
    (HandBookAlbumWindow.RefreshList)()
  else
    if msgId == 2 then
      local obj = ((uis.AlbumCGList).CGList):GetChildAt((HandBookAlbumWindow.GetIDIndex)(para) - 1)
      ChangeUIController(obj, "c3", 1)
      ;
      (HandBookMgr.SetAlbumNotNew)(para)
    end
  end
end

return HandBookAlbumWindow

