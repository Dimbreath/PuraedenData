-- params : ...
-- function num : 0 , upvalues : _ENV
require("Bag_BagWindowByName")
require("CommonResource_HeadDebrisByName")
require("CommonResource_ItemFrameByName")
local contentPane = nil
local uis = {}
local BagWindow = {}
local currentIndex = 0
local list = nil
local listData = {}
local LeftButtonEnum = {Item = 0, Material = 1, Debris = 2, Equip = 3}
local selectFrame = nil
local selectedIndex = 0
local SelectOffset = Vector2(1, 1)
BagWindow.OnInit = function(bridge, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, uis, currentIndex, selectFrame, BagWindow, list
  bridge:SetView((WinResConfig.BagWindow).package, (WinResConfig.BagWindow).comName)
  contentPane = bridge.contentPane
  uis = GetBag_BagWindowUis(contentPane)
  if not bridge.OpenFromClose then
    currentIndex = 0
  end
  local m = {}
  m.windowName = (WinResConfig.BagWindow).name
  m.Tip = (PUtil.get)(20000130)
  m.model = uis.AssetStrip
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.PHYSICAL}
  ;
  (CommonWinMgr.RegisterAssets)(m)
  ;
  ((uis.ItemBtn):GetChild("NameTxt")).text = (PUtil.get)(20000026)
  ;
  ((uis.MaterialBtn):GetChild("NameTxt")).text = (PUtil.get)(20000027)
  ;
  ((uis.FragmentBtn):GetChild("NameTxt")).text = (PUtil.get)(20000028)
  ;
  ((uis.EquipmentBtn):GetChild("NameTxt")).text = (PUtil.get)(20000029)
  -- DECOMPILER ERROR at PC84: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.c1Ctr).selectedIndex = currentIndex
  ;
  ((uis.c1Ctr).onChanged):Add(function(...)
    -- function num : 0_0_0 , upvalues : selectFrame, currentIndex, uis, BagWindow
    selectFrame.visible = false
    currentIndex = (uis.c1Ctr).selectedIndex
    ;
    (BagWindow.InitList)()
  end
)
  list = uis.ItemList
  list:SetVirtual()
  list.itemRenderer = BagWindow.RenderListItem
  selectFrame = UIMgr:CreateObject("CommonResource", "FrameEff")
  -- DECOMPILER ERROR at PC108: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.NothingTxt).text = (PUtil.get)(20000351)
end

BagWindow.InitList = function(...)
  -- function num : 0_1 , upvalues : BagWindow, list
  (BagWindow.RefreshList)()
  list:ScrollToView(0)
  ;
  (BagWindow.RefreshDetail)(1)
end

BagWindow.RefreshList = function(...)
  -- function num : 0_2 , upvalues : listData, _ENV, currentIndex, LeftButtonEnum, BagWindow, list, selectedIndex
  listData = {}
  local propsData = (ActorData.GetPropsData)()
  for _,v in ipairs(propsData) do
    local data = ((TableData.gTable).BasePropData)[v.id]
    if tonumber(data.bag_type) == tonumber(currentIndex + 1) then
      (table.insert)(listData, v)
    end
  end
  if currentIndex == LeftButtonEnum.Equip then
    for _,v in ipairs(EquiptData.Equipments) do
      if not v.identify then
        (table.insert)(listData, v)
      end
    end
  end
  do
    ;
    (BagWindow.SetItemDefault)()
    if currentIndex ~= LeftButtonEnum.Equip then
      (table.sort)(listData, function(a, b, ...)
    -- function num : 0_2_0 , upvalues : _ENV
    local aData = ((TableData.gTable).BasePropData)[a.id]
    local bData = ((TableData.gTable).BasePropData)[b.id]
    local aSort = aData.sort * 1e+14
    local bSort = bData.sort * 1e+14
    local aQuality = aData.quality * 10000000000
    local bQuality = aData.quality * 10000000000
    do return aSort + aQuality + a.count < bSort + bQuality + b.count end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    end
    list.numItems = #listData
    ;
    (BagWindow.RefreshDetail)(selectedIndex + 1)
  end
end

BagWindow.SetItemDefault = function(...)
  -- function num : 0_3 , upvalues : currentIndex, LeftButtonEnum, list
  if currentIndex == LeftButtonEnum.Debris then
    list.defaultItem = "ui://CommonResource/HeadDebris"
  else
    if currentIndex == LeftButtonEnum.Material or currentIndex == LeftButtonEnum.Item then
      list.defaultItem = "ui://CommonResource/ItemFrame"
    else
      if currentIndex == LeftButtonEnum.Equip then
        list.defaultItem = "ui://CommonResource/EquiptIcon"
      end
    end
  end
end

BagWindow.RenderListItem = function(dex, obj, ...)
  -- function num : 0_4 , upvalues : listData, currentIndex, LeftButtonEnum, _ENV, selectFrame, selectedIndex, SelectOffset, BagWindow
  local index = dex + 1
  local data = listData[index]
  local model = nil
  if currentIndex == LeftButtonEnum.Debris then
    model = GetCommonResource_HeadDebrisUis(obj)
    if data then
      (Util.SetDebrisFrame)(obj, data.id, data.count, nil, nil, true)
    else
      -- DECOMPILER ERROR at PC23: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (model.NumberTxt).visible = false
      -- DECOMPILER ERROR at PC26: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((model.PeacecompGrp).HeadDebrisLoader).visible = false
    end
  else
    if currentIndex == LeftButtonEnum.Item or currentIndex == LeftButtonEnum.Material then
      model = GetCommonResource_ItemFrameUis(obj)
      if data then
        local propData = ((TableData.gTable).BasePropData)[data.id]
        -- DECOMPILER ERROR at PC48: Confused about usage of register: R6 in 'UnsetPending'

        ;
        (model.NumberTxt).visible = true
        -- DECOMPILER ERROR at PC50: Confused about usage of register: R6 in 'UnsetPending'

        ;
        (model.IconLoader).visible = true
        -- DECOMPILER ERROR at PC54: Confused about usage of register: R6 in 'UnsetPending'

        ;
        (model.NumberTxt).text = (listData[index]).count
        -- DECOMPILER ERROR at PC60: Confused about usage of register: R6 in 'UnsetPending'

        ;
        (model.IconLoader).url = (Util.GetItemUrl)(propData.icon)
        -- DECOMPILER ERROR at PC63: Confused about usage of register: R6 in 'UnsetPending'

        ;
        (model.QualityCtr).selectedIndex = propData.quality
      else
        do
          -- DECOMPILER ERROR at PC66: Confused about usage of register: R5 in 'UnsetPending'

          ;
          (model.NumberTxt).visible = false
          -- DECOMPILER ERROR at PC68: Confused about usage of register: R5 in 'UnsetPending'

          ;
          (model.IconLoader).visible = false
          -- DECOMPILER ERROR at PC70: Confused about usage of register: R5 in 'UnsetPending'

          ;
          (model.QualityCtr).selectedIndex = 0
          -- DECOMPILER ERROR at PC72: Confused about usage of register: R5 in 'UnsetPending'

          ;
          (model.GetImage).visible = false
          if currentIndex == LeftButtonEnum.Equip then
            if data then
              (Util.SetEquipFrame)(obj, data, false)
            else
              ;
              (obj:GetController("c1")).selectedIndex = 3
              ;
              (obj:GetController("c2")).selectedIndex = 0
              ;
              (obj:GetController("c3")).selectedIndex = 1
              ;
              (obj:GetChild("FrameEffGrp")).visible = false
            end
          end
          local eff = obj:GetChild(selectFrame.name)
          if eff and dex ~= selectedIndex then
            ((selectFrame.displayObject).gameObject):SetActive(false)
          end
          if dex == selectedIndex then
            obj:AddChildAt(selectFrame, 0)
            selectFrame.xy = SelectOffset
            ;
            ((selectFrame.displayObject).gameObject):SetActive(true)
          end
          ;
          (obj.onClick):Set(function(...)
    -- function num : 0_4_0 , upvalues : data, BagWindow, index
    if data then
      (BagWindow.RefreshDetail)(index)
    end
  end
)
        end
      end
    end
  end
end

BagWindow.SetSelectBg = function(...)
  -- function num : 0_5 , upvalues : list, selectedIndex, listData, selectFrame, SelectOffset
  local index = list:ItemIndexToChildIndex(selectedIndex)
  if index < list.numChildren and index >= 0 then
    local frame = list:GetChildAt(index)
    local data = listData[selectedIndex + 1]
    if frame and data then
      frame:AddChildAt(selectFrame, 0)
      selectFrame.xy = SelectOffset
      selectFrame.visible = true
    end
  else
    do
      selectFrame.visible = false
    end
  end
end

BagWindow.SetSpecialTxtVisible = function(visible, ...)
  -- function num : 0_6 , upvalues : uis
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (uis.EquiptTxt).visible = visible
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.EquiptImage).visible = visible
end

BagWindow.RefreshDetail = function(index, ...)
  -- function num : 0_7 , upvalues : listData, uis, _ENV, selectedIndex, BagWindow, currentIndex, LeftButtonEnum
  local data = listData[index]
  if not data then
    index = index - 1
    data = listData[index]
  end
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

  if data then
    (uis.c2Ctr).selectedIndex = 0
  else
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (uis.c2Ctr).selectedIndex = 1
    ;
    (Util.SetNotFoundEffect)(uis.CardLoader)
  end
  selectedIndex = index - 1
  ;
  (BagWindow.SetSelectBg)()
  if data then
    local propData = nil
    if currentIndex == LeftButtonEnum.Equip then
      propData = ((TableData.gTable).BaseEquipData)[data.id]
    else
      propData = ((TableData.gTable).BasePropData)[data.id]
    end
    if propData and currentIndex ~= LeftButtonEnum.Equip then
      local limitLv = propData.use_level
      local lv = tonumber((split(limitLv, ":"))[1])
      local mLv = (ActorData.GetLevel)()
      -- DECOMPILER ERROR at PC67: Confused about usage of register: R6 in 'UnsetPending'

      if lv and lv > 0 and mLv < lv then
        (uis.EquiptTxt).text = (PUtil.get)(20000305, lv)
        ;
        (BagWindow.SetSpecialTxtVisible)(true)
      else
        ;
        (BagWindow.SetSpecialTxtVisible)(false)
      end
    else
      do
        ;
        (BagWindow.SetSpecialTxtVisible)(false)
        if currentIndex == LeftButtonEnum.Item or currentIndex == LeftButtonEnum.Material then
          (BagWindow.SetDetailSellBtn)(data)
          ;
          (BagWindow.SetDetailSecondBtn)(data)
          ;
          (Util.SetItemFrame)((uis.ItemFrameGrp).root, data.id, data.count)
        else
          -- DECOMPILER ERROR at PC106: Confused about usage of register: R3 in 'UnsetPending'

          if currentIndex == LeftButtonEnum.Debris then
            (uis.CancleBtn).visible = false
            -- DECOMPILER ERROR at PC108: Confused about usage of register: R3 in 'UnsetPending'

            ;
            (uis.UseBtn).visible = true
            -- DECOMPILER ERROR at PC114: Confused about usage of register: R3 in 'UnsetPending'

            ;
            (uis.UseBtn).text = (PUtil.get)(20000030)
            ;
            ((uis.UseBtn).onClick):Set(function(...)
    -- function num : 0_7_0 , upvalues : _ENV, data
    (Util.ShowGetWay)(data.id)
  end
)
            ;
            (Util.SetDebrisFrame)((uis.HeadDebrisGrp).root, data.id, data.count)
          else
            if currentIndex == LeftButtonEnum.Equip then
              (Util.SetEquipFrame)((uis.EquiotIcon).root, data)
              ;
              (BagWindow.SetEquipInfo)(data)
              -- DECOMPILER ERROR at PC142: Confused about usage of register: R3 in 'UnsetPending'

              ;
              (uis.UseBtn).visible = true
              -- DECOMPILER ERROR at PC151: Confused about usage of register: R3 in 'UnsetPending'

              if data.identify then
                (uis.UseBtn).text = (PUtil.get)(20000209)
              else
                -- DECOMPILER ERROR at PC158: Confused about usage of register: R3 in 'UnsetPending'

                ;
                (uis.UseBtn).text = (PUtil.get)(20000210)
              end
              ;
              ((uis.UseBtn).onClick):Set(function(...)
    -- function num : 0_7_1 , upvalues : data, _ENV
    if data.identify then
      (EquiptMgr.OpenEquipmentWindow)(EquiptOpenType.SpecifyEquipment, data.objectIndex)
    else
      ;
      (EquiptMgr.OpenEquipmentWindow)(EquiptOpenType.Identify)
    end
  end
)
            end
          end
        end
        -- DECOMPILER ERROR at PC166: Confused about usage of register: R3 in 'UnsetPending'

        ;
        (uis.ItemNameTxt).text = propData.name
        -- DECOMPILER ERROR at PC168: Confused about usage of register: R3 in 'UnsetPending'

        ;
        (uis.WordTxt).UBBEnabled = true
        -- DECOMPILER ERROR at PC171: Confused about usage of register: R3 in 'UnsetPending'

        ;
        (uis.WordTxt).text = propData.remark
      end
    end
  end
end

BagWindow.SetDetailSellBtn = function(data, ...)
  -- function num : 0_8 , upvalues : _ENV, uis
  local propData = ((TableData.gTable).BasePropData)[data.id]
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.CancleBtn).visible = propData.can_sell == 1
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.CancleBtn).text = (PUtil.get)(20000031)
  ;
  ((uis.CancleBtn).onClick):Set(function(...)
    -- function num : 0_8_0 , upvalues : _ENV, data
    OpenWindow((WinResConfig.BagSellAndBuyWindow).name, UILayer.HUD, data.id, 1, data.objectIndex)
  end
)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BagWindow.SetDetailSecondBtn = function(data, ...)
  -- function num : 0_9 , upvalues : _ENV, uis
  local propData = ((TableData.gTable).BasePropData)[data.id]
  ChangeUIController(uis.UseBtn, "c1", 0)
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R2 in 'UnsetPending'

  if propData.can_use == 1 then
    (uis.UseBtn).visible = true
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (uis.UseBtn).text = (PUtil.get)(20000032)
    ;
    ((uis.UseBtn).onClick):Set(function(...)
    -- function num : 0_9_0 , upvalues : data, propData, _ENV
    if data.count > 1 and propData.type ~= PropItemType.GIFT_OPTIONAL_BREAK then
      OpenWindow((WinResConfig.BagSellAndBuyWindow).name, UILayer.HUD, data.id, 2, data.objectIndex)
    else
      ;
      (BagService.UseProp)(data.id, data.objectIndex, 1)
    end
  end
)
  else
    -- DECOMPILER ERROR at PC31: Confused about usage of register: R2 in 'UnsetPending'

    if propData.go_to_id then
      (uis.UseBtn).visible = true
      -- DECOMPILER ERROR at PC37: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (uis.UseBtn).text = (PUtil.get)(20000030)
      ;
      ((uis.UseBtn).onClick):Set(function(...)
    -- function num : 0_9_1 , upvalues : _ENV, data
    (Util.ShowGetWay)(data.id)
  end
)
    else
      -- DECOMPILER ERROR at PC50: Confused about usage of register: R2 in 'UnsetPending'

      if propData.type == PropItemType.COMPOUND_DEBRIS then
        (uis.UseBtn).visible = true
        -- DECOMPILER ERROR at PC56: Confused about usage of register: R2 in 'UnsetPending'

        ;
        (uis.UseBtn).text = (PUtil.get)(20000244)
        local count = (ActorData.GetPropsByID)(data.id)
        do
          local baseProp = ((TableData.gTable).BasePropData)[data.id]
          local effect = split(baseProp.effect_value, ":")
          local singleNum = tonumber(effect[2])
          if count < singleNum then
            ChangeUIController(uis.UseBtn, "c1", 1)
          else
            ChangeUIController(uis.UseBtn, "c1", 0)
          end
          ;
          ((uis.UseBtn).onClick):Set(function(...)
    -- function num : 0_9_2 , upvalues : count, singleNum, _ENV, data, effect
    if singleNum * 2 <= count then
      OpenWindow((WinResConfig.TicketWindow).name, UILayer.HUD, data.id)
    else
      if count < singleNum * 2 and singleNum <= count then
        (BagService.UseProp)(data.id, data.objectIndex, singleNum)
      else
        local itemData = ((TableData.gTable).BasePropData)[tonumber(effect[1])]
        ;
        (MessageMgr.SendCenterTips)((PUtil.get)(20000245, itemData.name))
      end
    end
  end
)
        end
      else
        do
          -- DECOMPILER ERROR at PC94: Confused about usage of register: R2 in 'UnsetPending'

          ;
          (uis.UseBtn).visible = false
        end
      end
    end
  end
end

BagWindow.SetEquipInfo = function(equipInfo, ...)
  -- function num : 0_10 , upvalues : _ENV, uis, BagWindow
  local data = ((TableData.gTable).BaseEquipData)[equipInfo.id]
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R2 in 'UnsetPending'

  if equipInfo.identify then
    ((uis.EquiptInfoGrp).c1Ctr).selectedIndex = 0
    if data.show_type == 1 and data.card_id > 0 then
      local cardData = ((TableData.gTable).BaseCardData)[data.card_id]
      -- DECOMPILER ERROR at PC28: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (uis.EquiptTxt).text = (PUtil.get)(20000207, cardData.name)
      ;
      (BagWindow.SetSpecialTxtVisible)(true)
    else
      do
        ;
        (BagWindow.SetSpecialTxtVisible)(false)
        ;
        ((uis.EquiptInfoGrp).InfoList):RemoveChildren(true)
        local obj = (BagWindow.CreateEquipOneAttrInfo)(equipInfo.mainAttrId)
        ;
        ((uis.EquiptInfoGrp).InfoList):AddChild(obj)
        for _,v in ipairs(equipInfo.randomAttrId) do
          local attr = (BagWindow.CreateEquipOneAttrInfo)(v)
          ;
          ((uis.EquiptInfoGrp).InfoList):AddChild(attr)
        end
        local line = UIMgr:CreateObject("Bag", "Line")
        ;
        ((uis.EquiptInfoGrp).InfoList):AddChild(line)
        for _,v in ipairs(equipInfo.randomBuff) do
          local buff = (BagWindow.CreateEquipBuffInfo)(v)
          ;
          ((uis.EquiptInfoGrp).InfoList):AddChild(buff)
        end
        do
          -- DECOMPILER ERROR at PC90: Confused about usage of register: R2 in 'UnsetPending'

          ;
          ((uis.EquiptInfoGrp).c1Ctr).selectedIndex = 1
          -- DECOMPILER ERROR at PC96: Confused about usage of register: R2 in 'UnsetPending'

          ;
          (uis.EquiptTxt).text = (PUtil.get)(20000208)
          ;
          (BagWindow.SetSpecialTxtVisible)(true)
          -- DECOMPILER ERROR at PC103: Confused about usage of register: R2 in 'UnsetPending'

          ;
          ((uis.EquiptInfoGrp).WordTxt).text = data.des
        end
      end
    end
  end
end

BagWindow.CreateEquipOneAttrInfo = function(attrID, ...)
  -- function num : 0_11 , upvalues : _ENV
  local obj = UIMgr:CreateObject("Bag", "EquiptPopAttribute_A")
  local data = ((TableData.gTable).BaseEquipAttributeData)[attrID]
  local attrs = split(data.value, ":")
  ;
  (obj:GetChild("NameTxt")).text = (((TableData.gTable).BaseAttributeData)[tonumber(attrs[2])]).display_name
  ;
  (obj:GetChild("NumberTxt")).text = attrs[3]
  ChangeUIController(obj, "c1", EquiptData.MAX_ATTR_QUALITY_AMOUNT - data.level)
  return obj
end

BagWindow.CreateEquipBuffInfo = function(buffID, ...)
  -- function num : 0_12 , upvalues : _ENV
  local obj = UIMgr:CreateObject("Bag", "EquiptPopAttribute_B")
  local data = ((TableData.gTable).BaseBuffPreBattleData)[buffID]
  ;
  (obj:GetChild("WordTxt")).text = data.remark
  ChangeUIController(obj, "c1", EquiptData.MAX_ATTR_QUALITY_AMOUNT - data.level)
  return obj
end

BagWindow.OnShown = function(...)
  -- function num : 0_13 , upvalues : BagWindow
  (BagWindow.InitList)()
end

BagWindow.OnHide = function(...)
  -- function num : 0_14
end

BagWindow.OnClickClose = function(...)
  -- function num : 0_15
end

BagWindow.OnClose = function(...)
  -- function num : 0_16 , upvalues : _ENV, selectedIndex, contentPane, uis, list
  (CommonWinMgr.RemoveAssets)((WinResConfig.BagWindow).name)
  selectedIndex = 0
  contentPane = nil
  uis = {}
  list = nil
end

BagWindow.HandleMessage = function(msgId, ...)
  -- function num : 0_17 , upvalues : _ENV, BagWindow
  if msgId == (WindowMsgEnum.BagWindow).E_MSG_BAG_REFRESH then
    print("界面刷新")
    ;
    (BagWindow.RefreshList)()
  end
  if msgId == (WindowMsgEnum.NETBrokenReconnect).E_MSG_RECONNECT_Ok then
    (BagWindow.RefreshList)()
  end
end

return BagWindow

