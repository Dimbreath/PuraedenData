-- params : ...
-- function num : 0 , upvalues : _ENV
require("HandBook_MInformationWindowByName")
local FormationMonsterInfoWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local MonsterTable = {}
local selectIndex = {}
local listData = {}
local BannerIndex = -1
FormationMonsterInfoWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, MonsterTable, uis, FormationMonsterInfoWindow, BannerIndex
  bridgeObj:SetView((WinResConfig.FormationMonsterInfoWindow).package, (WinResConfig.FormationMonsterInfoWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  MonsterTable = argTable[1]
  uis = GetHandBook_MInformationWindowUis(contentPane)
  uis = uis.MInformation
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.TipsList).scrollPane).pageMode = true
  for _,v in ipairs(MonsterTable) do
    local obj = UIMgr:CreateObject("HandBook", "MInformationTips")
    ;
    (obj:GetChild("SetList")).itemRenderer = FormationMonsterInfoWindow.ItemRenderer
    ;
    (obj:GetChild("SetList")):SetVirtual()
    ;
    (FormationMonsterInfoWindow.SetMonsterCom)(obj, v)
    ;
    (uis.TipsList):AddChild(obj)
  end
  ;
  (FormationMonsterInfoWindow.SetEvent)()
  -- DECOMPILER ERROR at PC59: Confused about usage of register: R1 in 'UnsetPending'

  if #MonsterTable > 1 then
    (uis.PageNumberList).visible = true
    ;
    (FormationMonsterInfoWindow.InitPageList)()
    BannerIndex = 1
    ;
    (FormationMonsterInfoWindow.SetPageShow)()
  else
    -- DECOMPILER ERROR at PC68: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (uis.PageNumberList).visible = false
  end
  ;
  (((uis.TipsList).scrollPane).onScrollEnd):Set(function(...)
    -- function num : 0_0_0 , upvalues : BannerIndex, uis, FormationMonsterInfoWindow
    BannerIndex = ((uis.TipsList).scrollPane).currentPageX + 1
    ;
    (FormationMonsterInfoWindow.SetPageShow)()
  end
)
end

FormationMonsterInfoWindow.SetPageShow = function(...)
  -- function num : 0_1 , upvalues : uis, BannerIndex, _ENV
  local list = uis.PageNumberList
  local length = list.numItems
  for i = 1, length do
    local obj = list:GetChildAt(i - 1)
    if i == BannerIndex then
      ChangeUIController(obj, "c1", 1)
    else
      ChangeUIController(obj, "c1", 0)
    end
  end
end

FormationMonsterInfoWindow.InitPageList = function(...)
  -- function num : 0_2 , upvalues : uis, MonsterTable, _ENV
  local subList = uis.PageNumberList
  local length = #MonsterTable
  for i = 1, length do
    local obj = UIMgr:CreateObject("HandBook", "Page")
    subList:AddChild(obj)
  end
end

FormationMonsterInfoWindow.SetEvent = function(...)
  -- function num : 0_3 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  (uis.SureBtn).text = (PUtil.get)(20000370)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.TitleTxt).text = (PUtil.get)(20000445)
  ;
  ((uis.SureBtn).onClick):Set(function(...)
    -- function num : 0_3_0 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.FormationMonsterInfoWindow).name)
  end
)
  ;
  ((uis.CloseBtn).onClick):Set(function(...)
    -- function num : 0_3_1 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.FormationMonsterInfoWindow).name)
  end
)
end

FormationMonsterInfoWindow.ItemRenderer = function(index, obj, ...)
  -- function num : 0_4 , upvalues : listData, _ENV
  local data = listData[index + 1]
  ;
  (obj:GetChild("NameTxt")).text = (PUtil.get)(tonumber(data[1]))
  ;
  (obj:GetChild("WordTxt")).text = (PUtil.get)(tonumber(data[2]))
end

FormationMonsterInfoWindow.SetMonsterCom = function(obj, mData, ...)
  -- function num : 0_5 , upvalues : _ENV, uis, selectIndex, FormationMonsterInfoWindow
  for i = 1, 6 do
    do
      local com = obj:GetChild("Monster_" .. i)
      local data = tonumber(mData[i])
      com.touchable = not data or data > 0
      if data and data > 0 then
        ChangeUIController(com, "c1", 0)
        local configData = (TableData.GetBaseMonsterData)(data)
        ;
        (com:GetChild("MonsterNameTxt")).text = configData.name
        ;
        (Util.SetHeadFrame)(com:GetChild("HeadFrameGrp"), {id = data}, true)
        ;
        ((com:GetChild("HeadFrameGrp")):GetChild("LevelTxt")).visible = false
        ;
        (com.onClick):Set(function(...)
    -- function num : 0_5_0 , upvalues : uis, selectIndex, i, obj, FormationMonsterInfoWindow
    local pageX = ((uis.TipsList).scrollPane).currentPageX
    local mIndex = selectIndex[pageX]
    if mIndex and mIndex == i then
      return 
    end
    if mIndex and mIndex > 0 then
      (obj:GetChild("Monster_" .. mIndex)).selected = false
    end
    selectIndex[pageX] = i
    ;
    (FormationMonsterInfoWindow.SetListInfo)()
  end
)
      else
        ChangeUIController(com, "c1", 1)
      end
    end
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

FormationMonsterInfoWindow.SetListInfo = function(...)
  -- function num : 0_6 , upvalues : uis, MonsterTable, _ENV, selectIndex, listData
  local page = ((uis.TipsList).scrollPane).currentPageX
  local mData = MonsterTable[page + 1]
  local data = tonumber(mData[selectIndex[page]])
  local configData = (TableData.GetBaseMonsterData)(data)
  listData = (Util.ParseConfigStr)(configData.handbook_label_show)
  local child = (uis.TipsList):GetChildAt(page)
  ;
  (child:GetChild("SetList")).numItems = #listData
end

FormationMonsterInfoWindow.SetMons = function(...)
  -- function num : 0_7
end

FormationMonsterInfoWindow.OnShown = function(...)
  -- function num : 0_8
end

FormationMonsterInfoWindow.OnHide = function(...)
  -- function num : 0_9
end

FormationMonsterInfoWindow.OnClose = function(...)
  -- function num : 0_10 , upvalues : uis, contentPane, argTable, MonsterTable, selectIndex, listData
  uis = nil
  contentPane = nil
  argTable = {}
  MonsterTable = {}
  selectIndex = {}
  listData = {}
end

FormationMonsterInfoWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_11
end

return FormationMonsterInfoWindow

