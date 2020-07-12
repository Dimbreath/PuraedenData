-- params : ...
-- function num : 0 , upvalues : _ENV
require("Gift_GiftChoiceWindowByName")
local BagGiftOptionWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local giftID, useNum, propIndex = nil, nil, nil
local mListTable = {}
local selectIndex = -1
BagGiftOptionWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, giftID, useNum, propIndex, uis, BagGiftOptionWindow
  bridgeObj:SetView((WinResConfig.BagGiftOptionWindow).package, (WinResConfig.BagGiftOptionWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  giftID = argTable[1]
  useNum = argTable[2]
  propIndex = argTable[3]
  uis = GetGift_GiftChoiceWindowUis(contentPane)
  uis = uis.GiftChoice
  ;
  (BagGiftOptionWindow.InitInvariable)()
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.ItemList).itemRenderer = BagGiftOptionWindow.listRender
  ;
  (BagGiftOptionWindow.SetListShow)()
end

BagGiftOptionWindow.listRender = function(index, obj, ...)
  -- function num : 0_1 , upvalues : mListTable, _ENV, selectIndex, uis
  local itemStr = mListTable[index + 1]
  if itemStr == nil then
    return 
  end
  local item = split(itemStr, ":")
  local itemType = tonumber(item[1])
  local itemID = tonumber(item[2])
  local itemNum = tonumber(item[3])
  ;
  (Util.SetAllItemIcon)(obj:GetChild("Item"), itemID, itemNum)
  local NameTxt = obj:GetChild("NameTxt")
  local configData = (Util.GetConfigDataByID)(itemID)
  NameTxt.text = configData.name
  if itemType == PropType.CARD then
    ChangeUIController(obj, "c1", 1)
    local star = configData.star
    local starList = obj:GetChild("StarList")
    starList.numItems = star
    local labelList = obj:GetChild("GiftCardLabelList")
    labelList.numItems = 0
    local labelShow = split(configData.card_label_show, ":")
    for _,v in ipairs(labelShow) do
      local label = UIMgr:CreateObject("Gift", "GiftCardLabel")
      ;
      (label:GetChild("LabelTxt")).text = (PUtil.get)(tonumber(v))
      labelList:AddChild(label)
    end
    ChangeUIController(obj, "c2", configData.intelligence)
    ;
    (obj:GetChild("HaveImage")).visible = (CardData.GetCardData)(itemID) ~= nil
  else
    ChangeUIController(obj, "c1", 0)
    local haveTxt = obj:GetChild("HaveTxt")
    local NumberTxt = obj:GetChild("NumberTxt")
    if itemType == PropType.ASSET then
      haveTxt.text = (PUtil.get)(20000418, (ActorData.GetAssetCount)(itemID))
    else
      haveTxt.text = (PUtil.get)(20000418, (ActorData.GetPropsByID)(itemID))
    end
    NumberTxt.text = "X" .. itemNum
    if itemType == PropType.EQUIP then
      ChangeUIController(obj, "c2", configData.intelligence - 1)
    else
      ChangeUIController(obj, "c2", configData.quality - 1)
    end
  end
  local btn = obj:GetChild("ChoiceBtn")
  btn.touchable = false
  btn.selected = selectIndex == index
  ;
  (obj.onClick):Set(function(...)
    -- function num : 0_1_0 , upvalues : index, selectIndex, btn, uis, _ENV
    if index == selectIndex then
      return 
    end
    btn.selected = true
    do
      if selectIndex >= 0 then
        local oldSelect = (uis.ItemList):GetChildAt(selectIndex)
        ;
        (oldSelect:GetChild("ChoiceBtn")).selected = false
      end
      selectIndex = index
      ChangeUIController(uis.SureBtn, "c1", 0)
    end
  end
)
  -- DECOMPILER ERROR: 7 unprocessed JMP targets
end

BagGiftOptionWindow.SetListShow = function(...)
  -- function num : 0_2 , upvalues : _ENV, giftID, mListTable, uis
  local PropData = ((TableData.gTable).BasePropData)[giftID]
  if PropData.type ~= PropItemType.GIFT_OPTIONAL then
    return 
  end
  local propType = tonumber(PropData.effect_value)
  local GiftData = (TableData.gTable).BaseDropGroupGiftData
  local mLV = (ActorData.GetLevel)()
  mListTable = {}
  for _,v in pairs(GiftData) do
    if v.type == propType then
      local lvLimit = split(v.use_level, ":")
      if tonumber(lvLimit[1]) <= mLV and mLV <= tonumber(lvLimit[2]) then
        local items = split(v.rewards, ",")
        for _,v in ipairs(items) do
          (table.insert)(mListTable, v)
        end
      end
    end
  end
  -- DECOMPILER ERROR at PC63: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (uis.ItemList).numItems = #mListTable
end

BagGiftOptionWindow.InitInvariable = function(...)
  -- function num : 0_3 , upvalues : selectIndex, _ENV, uis, mListTable, propIndex, useNum
  selectIndex = -1
  ChangeUIController(uis.SureBtn, "c1", 1)
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.TitleTxt).text = (PUtil.get)(20000417)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.SureBtn).text = (PUtil.get)(20000107)
  ;
  ((uis.SureBtn).onClick):Set(function(...)
    -- function num : 0_3_0 , upvalues : selectIndex, _ENV, mListTable, propIndex, useNum
    if selectIndex == -1 then
      (MessageMgr.SendCenterTips)((PUtil.get)(20000419))
      return 
    end
    local mData = mListTable[selectIndex + 1]
    local data = split(mData, ":")
    local mType = tonumber(data[1])
    local PropId = tonumber(data[2])
    local func = function(...)
      -- function num : 0_3_0_0 , upvalues : _ENV, PropId, propIndex, useNum
      local propList = {}
      ;
      (table.insert)(propList, {propId = PropId, count = 1})
      ;
      (BagService.ReqUseOptionGift)(propIndex, useNum, propList)
    end

    if mType == PropType.CARD then
      local debris_goods = ((CardData.GetBaseConfig)(PropId)).debris_goods
      local debris = split(debris_goods, ":")
      local PropData = ((TableData.gTable).BasePropData)[tonumber(debris[2])]
      if (CardData.GetCardData)(PropId) ~= nil then
        local content = (PUtil.get)(20000433, PropData.name, tonumber(debris[3]) * useNum)
        ;
        (MessageMgr.OpenConfirmWindow)(content, function(...)
      -- function num : 0_3_0_1 , upvalues : func
      func()
    end
)
        return 
      else
        do
          do
            if useNum > 1 then
              local content = (PUtil.get)(20000434, PropData.name, tonumber(debris[3]) * (useNum - 1))
              ;
              (MessageMgr.OpenConfirmWindow)(content, function(...)
      -- function num : 0_3_0_2 , upvalues : func
      func()
    end
)
              return 
            end
            func()
          end
        end
      end
    end
  end
)
  ;
  ((uis.CloseBtn).onClick):Set(function(...)
    -- function num : 0_3_1 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.BagGiftOptionWindow).name)
  end
)
end

BagGiftOptionWindow.OnShown = function(...)
  -- function num : 0_4
end

BagGiftOptionWindow.OnHide = function(...)
  -- function num : 0_5
end

BagGiftOptionWindow.OnClose = function(...)
  -- function num : 0_6 , upvalues : uis, contentPane, argTable
  uis = nil
  contentPane = nil
  argTable = {}
end

BagGiftOptionWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_7
end

return BagGiftOptionWindow

