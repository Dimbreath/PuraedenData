-- params : ...
-- function num : 0 , upvalues : _ENV
require("Title_TitleWindowByName")
local TitleWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local listData = {}
local titleList = {}
local selectTitle = 0
local allAttributePanel = nil
TitleWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, titleList, uis, TitleWindow
  bridgeObj:SetView((WinResConfig.TitleWindow).package, (WinResConfig.TitleWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  titleList = (ActorData.TitleListData)()
  uis = GetTitle_TitleWindowUis(contentPane)
  ;
  (TitleWindow.InitAssetStrip)()
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.Title_A).TitleList).itemRenderer = TitleWindow.ListRenderer
  ;
  ((uis.Title_A).TitleList):SetVirtual()
  ;
  (TitleWindow.SetInvariableTxt)()
  ;
  (TitleWindow.InitLeftList)()
  ;
  (TitleWindow.RefreshWearInfo)()
end

TitleWindow.RefreshWearInfo = function(...)
  -- function num : 0_1 , upvalues : TitleWindow, uis, _ENV
  local current = (TitleWindow.GetCurrentTitle)()
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  if current and current <= 0 then
    ((uis.Title_B).c1Ctr).selectedIndex = 1
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((uis.Title_B).NothingTxt).text = (PUtil.get)(20000447)
    ;
    (Util.SetNotFoundEffect)((uis.Title_B).CardLoader)
    return 
  end
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.Title_B).c1Ctr).selectedIndex = 0
  ;
  (TitleWindow.SetListShow)(current, (uis.Title_B).TitleList)
end

TitleWindow.RefreshSelectInfo = function(...)
  -- function num : 0_2 , upvalues : _ENV, selectTitle, TitleWindow, uis
  (RedDotMgr.EliminateRedDot)((WinResConfig.TitleWindow).name, RedDotComID.Title_List, selectTitle)
  local current = (TitleWindow.GetCurrentTitle)()
  ;
  (TitleWindow.SetListShow)(selectTitle, (uis.Title_C).TitleList)
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'

  if selectTitle == current then
    ((uis.Title_C).UseBtn).text = (PUtil.get)(20000451)
    ChangeUIController((uis.Title_C).UseBtn, "c1", 0)
  else
    -- DECOMPILER ERROR at PC44: Confused about usage of register: R1 in 'UnsetPending'

    if (TitleWindow.GetTitleIsGet)(selectTitle) then
      ((uis.Title_C).UseBtn).text = (PUtil.get)(20000450)
      ChangeUIController((uis.Title_C).UseBtn, "c1", 0)
    else
      -- DECOMPILER ERROR at PC58: Confused about usage of register: R1 in 'UnsetPending'

      ;
      ((uis.Title_C).UseBtn).text = (PUtil.get)(20000450)
      ChangeUIController((uis.Title_C).UseBtn, "c1", 1)
    end
  end
  ;
  (((uis.Title_C).UseBtn).onClick):Set(function(...)
    -- function num : 0_2_0 , upvalues : selectTitle, current, _ENV, TitleWindow
    if selectTitle == current then
      (ActorService.ReqWearTitle)(0)
    else
      if (TitleWindow.GetTitleIsGet)(selectTitle) then
        (ActorService.ReqWearTitle)(selectTitle)
      else
        ;
        (MessageMgr.SendCenterTips)((PUtil.get)(20000452))
      end
    end
  end
)
end

TitleWindow.SetListShow = function(titleID, list, ...)
  -- function num : 0_3 , upvalues : _ENV, TitleWindow
  list.numItems = 0
  local configData = ((TableData.gTable).BasePlayerTitleData)[titleID]
  local show = UIMgr:CreateObject("Title", "Show")
  local titlePic = show:GetChild("TitlePic")
  ;
  (titlePic:GetChild("PicLoader")).url = (Util.GetItemUrl)(configData.icon)
  local timeTxt = show:GetChild("TimeTxt")
  local day = (TitleWindow.GetRemainTime)(titleID)
  timeTxt.visible = day > 0
  if day > 0 then
    timeTxt.text = (PUtil.get)(20000446, day)
  end
  local current = (TitleWindow.GetCurrentTitle)()
  if current > 0 and titleID == current then
    ChangeUIController(show, "c1", 0)
  else
    ChangeUIController(show, "c1", 1)
  end
  ;
  (show:GetChild("GetATxt")).text = (PUtil.get)(20000448)
  ;
  (show:GetChild("AttributeTxt")).text = (PUtil.get)(20000449)
  ;
  (show:GetChild("GetBTxt")).text = configData.remark
  local attrStr = configData.add_attr
  ;
  (TitleWindow.SetAttrInfo)(show, attrStr)
  list:AddChild(show)
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

TitleWindow.SetAttrInfo = function(show, attrStr, ...)
  -- function num : 0_4 , upvalues : _ENV
  local list = show:GetChild("AttributeList")
  if attrStr and not (Util.StringIsNullOrEmpty)(attrStr) and attrStr ~= "0" then
    ChangeUIController(show, "c2", 0)
    list.numItems = 0
    local attr = (Util.ParseConfigStr)(attrStr)
    for _,v in ipairs(attr) do
      if tonumber(v[1]) == 1 then
        local line = UIMgr:CreateObject("Title", "TitleAttribute")
        local AttributeData = ((TableData.gTable).BaseAttributeData)[tonumber(v[2])]
        ;
        (line:GetChild("AttributeNameTxt")).text = AttributeData.display_name
        ;
        (line:GetChild("AttributeNumberTxt")).text = v[3]
        list:AddChild(line)
      end
    end
    list.height = list.numItems * 40 - 10
  else
    do
      ChangeUIController(show, "c2", 1)
      list.height = 0
    end
  end
end

TitleWindow.SetInvariableTxt = function(...)
  -- function num : 0_5 , upvalues : uis, _ENV, allAttributePanel
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.Title_B).NameTxt).text = (PUtil.get)(20000442)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.Title_C).NameTxt).text = (PUtil.get)(20000443)
  ;
  (((uis.Title_B).AllAttributeBtn).onClick):Set(function(...)
    -- function num : 0_5_0 , upvalues : allAttributePanel, _ENV, uis
    if allAttributePanel == nil then
      local allAttr = (ActorData.GetTitleAllAttr)()
      if next(allAttr) == nil then
        (MessageMgr.SendCenterTips)((PUtil.get)(20000455))
        return 
      end
      allAttributePanel = UIMgr:CreateObject("Title", "TitleAttributeTips")
      ;
      (allAttributePanel:GetChild("Word_01_Txt")).text = (PUtil.get)(20000453)
      local attrList = allAttributePanel:GetChild("Attribute_01_List")
      for i,v in pairs(allAttr) do
        local AttributeData = ((TableData.gTable).BaseAttributeData)[i]
        local tip = UIMgr:CreateObject("Title", "TitleAttribute")
        ;
        (tip:GetChild("AttributeNameTxt")).text = AttributeData.display_name
        ;
        (tip:GetChild("AttributeNumberTxt")).text = v
        attrList:AddChild(tip)
      end
      allAttributePanel.xy = ((uis.Title_B).AllAttributeBtn):TransformPoint(Vector2.zero, uis.root) - Vector2(allAttributePanel.width, 0)
      ;
      (uis.root):AddChild(allAttributePanel)
    end
    do
      allAttributePanel.visible = true
      ;
      (GRoot.inst):AddCustomPopups(allAttributePanel, function(...)
      -- function num : 0_5_0_0 , upvalues : allAttributePanel
      allAttributePanel.visible = false
    end
)
    end
  end
)
end

TitleWindow.ListRenderer = function(index, obj, ...)
  -- function num : 0_6 , upvalues : listData, TitleWindow, _ENV, selectTitle, uis
  local data = listData[index + 1]
  local timeTxt = obj:GetChild("TimeTxt")
  local titlePic = obj:GetChild("TitlePic")
  if (TitleWindow.GetTitleIsGet)(data.id) then
    if data.id == (TitleWindow.GetCurrentTitle)() then
      ChangeUIController(obj, "c1", 2)
    else
      ChangeUIController(obj, "c1", 0)
    end
    local day = (TitleWindow.GetRemainTime)(data.id)
    timeTxt.visible = day > 0
    do
      do
        if day > 0 then
          local day = (TitleWindow.GetRemainTime)(data.id)
          timeTxt.text = (PUtil.get)(20000446, day)
        end
        ChangeUIController(titlePic, "c1", 0)
        ChangeUIController(obj, "c1", 1)
        ChangeUIController(titlePic, "c1", 1)
        timeTxt.visible = false
        ;
        (obj:GetChild("RedDot")).visible = (TitleWindow.GetContainRedDot)(data.id)
        ;
        (titlePic:GetChild("PicLoader")).url = (Util.GetItemUrl)(data.icon)
        ;
        (obj.onClick):Set(function(...)
    -- function num : 0_6_0 , upvalues : selectTitle, data, TitleWindow, uis, index
    if selectTitle ~= data.id then
      selectTitle = data.id
      ;
      (TitleWindow.RefreshSelectInfo)()
      -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

      ;
      ((uis.Title_A).TitleList).selectedIndex = index
    end
  end
)
        -- DECOMPILER ERROR: 4 unprocessed JMP targets
      end
    end
  end
end

TitleWindow.InitLeftList = function(...)
  -- function num : 0_7 , upvalues : listData, _ENV, TitleWindow, uis, titleList, selectTitle
  listData = {}
  local configData = (TableData.gTable).BasePlayerTitleData
  for _,v in pairs(configData) do
    (table.insert)(listData, v)
  end
  ;
  (table.sort)(listData, function(a, b, ...)
    -- function num : 0_7_0 , upvalues : TitleWindow
    do return (TitleWindow.GetListSort)(b) < (TitleWindow.GetListSort)(a) end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.Title_A).TitleList).numItems = #listData
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.Title_A).NameTxt).text = (PUtil.get)(20000441, #titleList, #listData)
  -- DECOMPILER ERROR at PC39: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.Title_A).TitleList).selectedIndex = 0
  selectTitle = (listData[1]).id
  ;
  (TitleWindow.RefreshSelectInfo)()
end

TitleWindow.GetContainRedDot = function(id, ...)
  -- function num : 0_8 , upvalues : _ENV
  local list = (RedDotMgr.TitleRedList)()
  for _,v in ipairs(list) do
    if v == id then
      return true
    end
  end
  return false
end

TitleWindow.GetListSort = function(data, ...)
  -- function num : 0_9 , upvalues : TitleWindow
  local isGet = (TitleWindow.GetTitleIsGet)(data.id)
  local sort = 0
  if isGet then
    sort = 10000
  end
  if data.id == (TitleWindow.GetCurrentTitle)() then
    sort = sort + 1000000
  end
  return sort + data.sort
end

TitleWindow.GetTitleIsGet = function(id, ...)
  -- function num : 0_10 , upvalues : _ENV, titleList
  for _,v in ipairs(titleList) do
    if v.titleId == id and v.pov ~= 0 then
      return true
    end
  end
  return false
end

TitleWindow.GetRemainTime = function(id, ...)
  -- function num : 0_11 , upvalues : _ENV, titleList
  for _,v in ipairs(titleList) do
    if v.titleId == id then
      if v.pov == -1 then
        return 0
      else
        return (math.ceil)(v.pov / 86400)
      end
    end
  end
  return 0
end

TitleWindow.GetCurrentTitle = function(...)
  -- function num : 0_12 , upvalues : _ENV
  return (ActorData.GetWearTitle)()
end

TitleWindow.OnShown = function(...)
  -- function num : 0_13
end

TitleWindow.OnHide = function(...)
  -- function num : 0_14
end

TitleWindow.OnClose = function(...)
  -- function num : 0_15 , upvalues : _ENV, uis, contentPane, argTable, allAttributePanel
  (CommonWinMgr.RemoveAssets)((WinResConfig.TitleWindow).name)
  uis = nil
  contentPane = nil
  argTable = {}
  if allAttributePanel ~= nil then
    allAttributePanel:Dispose()
    allAttributePanel = nil
  end
end

TitleWindow.InitAssetStrip = function(...)
  -- function num : 0_16 , upvalues : _ENV, uis
  local m = {}
  m.windowName = (WinResConfig.TitleWindow).name
  m.Tip = (PUtil.get)(20000439)
  m.model = uis.AssetStripGrp
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.PHYSICAL}
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

TitleWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_17 , upvalues : _ENV, uis, TitleWindow
  if msgId == (WindowMsgEnum.Title).E_MSG_REFRESH then
    ((uis.Title_A).TitleList):RefreshVirtualList()
    ;
    (TitleWindow.RefreshWearInfo)()
    ;
    (TitleWindow.RefreshSelectInfo)()
  else
    if msgId == (WindowMsgEnum.Title).E_MSG_RED_DOT then
      ((uis.Title_A).TitleList):RefreshVirtualList()
    end
  end
end

return TitleWindow

