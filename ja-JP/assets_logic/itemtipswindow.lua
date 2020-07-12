-- params : ...
-- function num : 0 , upvalues : _ENV
require("DescriptionTips_ItemTipsWindowByName")
Input = (CS.UnityEngine).Input
local ItemTipsWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local OffsetNum = 75
local _originYSize = nil
ItemTipsWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, _originYSize
  bridgeObj:SetView((WinResConfig.ItemTipsWindow).package, (WinResConfig.ItemTipsWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  contentPane:Center()
  uis = GetDescriptionTips_ItemTipsWindowUis(contentPane)
  ;
  ((uis.root).onClick):Set(function(...)
    -- function num : 0_0_0 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.ItemTipsWindow).name)
  end
)
  uis = uis.ItemTipsGrp
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.ItemFrameGrp).GetImage).visible = false
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.ItemFrameGrp).NumberTxt).visible = false
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.ItemWordTxt).UBBEnabled = true
  _originYSize = (uis.TipsImage).height
  -- DECOMPILER ERROR at PC42: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.HaveNumber_01_Txt).text = (PUtil.get)(20000348)
end

ItemTipsWindow.OnShown = function(...)
  -- function num : 0_1 , upvalues : argTable, _ENV, uis, ItemTipsWindow
  local itemID = argTable[1]
  local itemNum = argTable[2]
  local data, propType = (Util.GetConfigDataByID)(itemID)
  if not data then
    print("未找到" .. itemID .. "数据")
    return 
  end
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R4 in 'UnsetPending'

  if propType == PropType.ITEM or propType == PropType.ASSET then
    (uis.HaveNumberGrp).visible = true
    ;
    (ItemTipsWindow.ShowItem)(data, itemNum, propType)
  else
    -- DECOMPILER ERROR at PC36: Confused about usage of register: R4 in 'UnsetPending'

    if propType == PropType.EQUIP then
      (uis.HaveNumberGrp).visible = false
      local equipData = nil
      if data.is_identify == 0 then
        equipData = {}
        equipData.id = data.id
        equipData.identify = true
        equipData.level = data.star
        local attrs = split(data.fixed_attribute, ":")
        local buffs = split(data.fixed_buff, ":")
        local attr = {}
        local buff = {}
        for _,v in ipairs(attrs) do
          (table.insert)(attr, tonumber(v))
        end
        for _,v in ipairs(buffs) do
          (table.insert)(buff, tonumber(v))
        end
        equipData.randomAttrId = attr
        equipData.randomBuff = buff
        equipData.lock = false
      else
        do
          do
            equipData = argTable[3]
            ;
            (ItemTipsWindow.ShowEquipment)(data, equipData)
            ;
            (ItemTipsWindow.SetWindowPos)()
          end
        end
      end
    end
  end
end

ItemTipsWindow.IsInConfig = function(id, ...)
  -- function num : 0_2 , upvalues : _ENV
  for _,v in pairs(ItemTipsWithoutPossess) do
    if v == id then
      return true
    end
  end
end

ItemTipsWindow.ShowItem = function(data, itemNum, propType, ...)
  -- function num : 0_3 , upvalues : uis, _ENV, ItemTipsWindow, _originYSize
  local grp = (uis.root):GetChild("LvUse")
  if propType == PropType.ITEM then
    local limitLv = data.use_level
    local limitTxt = (uis.root):GetChild("LvUseTxt")
    local lv = tonumber((split(limitLv, ":"))[1])
    local mLv = (ActorData.GetLevel)()
    if lv and lv > 0 and mLv < lv then
      limitTxt.text = (PUtil.get)(20000305, lv)
      grp.visible = true
    else
      grp.visible = false
    end
  else
    do
      grp.visible = false
      -- DECOMPILER ERROR at PC42: Confused about usage of register: R4 in 'UnsetPending'

      ;
      (uis.ItemNameTxt).text = data.name
      -- DECOMPILER ERROR at PC54: Confused about usage of register: R4 in 'UnsetPending'

      if data.type == PropItemType.CHARACTER_DEBRIS or data.type == PropItemType.UNIVERSAL_DEBRIS then
        (uis.c1Ctr).selectedIndex = 1
        ;
        (Util.SetDebrisFrame)((uis.HeadDebrisGrp).root, data.id)
      else
        -- DECOMPILER ERROR at PC63: Confused about usage of register: R4 in 'UnsetPending'

        ;
        (uis.c1Ctr).selectedIndex = 0
        ;
        (Util.SetItemFrame)((uis.ItemFrameGrp).root, data.id, 1, false, false, true)
      end
      -- DECOMPILER ERROR at PC77: Confused about usage of register: R4 in 'UnsetPending'

      if itemNum then
        (uis.HaveNumberTxt).text = itemNum
      else
        -- DECOMPILER ERROR at PC85: Confused about usage of register: R4 in 'UnsetPending'

        if (ItemTipsWindow.IsInConfig)(data.id) then
          (uis.HaveNumberGrp).visible = false
        else
          -- DECOMPILER ERROR at PC96: Confused about usage of register: R4 in 'UnsetPending'

          if propType == PropType.ITEM then
            (uis.HaveNumberTxt).text = (ActorData.GetPropsByID)(data.id)
          else
            -- DECOMPILER ERROR at PC103: Confused about usage of register: R4 in 'UnsetPending'

            ;
            (uis.HaveNumberTxt).text = (ActorData.GetAssetCount)(data.id)
          end
        end
      end
      -- DECOMPILER ERROR at PC110: Confused about usage of register: R4 in 'UnsetPending'

      if data.can_sell == PropCanSell.Can_Sell then
        (uis.BuyGrp).visible = true
        -- DECOMPILER ERROR at PC113: Confused about usage of register: R4 in 'UnsetPending'

        ;
        (uis.BuyNumberTxt).text = data.sell_price
      else
        -- DECOMPILER ERROR at PC116: Confused about usage of register: R4 in 'UnsetPending'

        ;
        (uis.BuyGrp).visible = false
      end
      -- DECOMPILER ERROR at PC119: Confused about usage of register: R4 in 'UnsetPending'

      ;
      (uis.ItemWordTxt).text = data.remark
      -- DECOMPILER ERROR at PC122: Confused about usage of register: R4 in 'UnsetPending'

      ;
      (uis.TipsImage).height = _originYSize
    end
  end
end

ItemTipsWindow.ShowEquipment = function(data, equipInfo, ...)
  -- function num : 0_4 , upvalues : uis, _ENV, _originYSize
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  (uis.Equipt_01_Txt).text = (PUtil.get)(60000461)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.ItemNameTxt).text = "[color=#0099FF]" .. data.name .. "[/color]"
  ;
  (Util.SetEquipFrameOnlyForShow)((uis.EquiotIcon).root, data.id)
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.c2Ctr).selectedIndex = data.type - 1
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R2 in 'UnsetPending'

  if equipInfo == nil or equipInfo.identify == false then
    (uis.Equipt_03_Txt).text = "(" .. (PUtil.get)(20000208) .. ")"
    -- DECOMPILER ERROR at PC37: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (uis.c1Ctr).selectedIndex = 2
    -- DECOMPILER ERROR at PC43: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (uis.ItemWordTxt).text = "[color=#617992]" .. data.des .. "[/color]"
    local ySize = (uis.ItemWordTxt).y + (uis.ItemWordTxt).height + 10
    if ySize < _originYSize then
      ySize = _originYSize
    end
    -- DECOMPILER ERROR at PC55: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (uis.TipsImage).height = ySize
  else
    do
      -- DECOMPILER ERROR at PC68: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (uis.Equipt_03_Txt).text = "[color=" .. Const.GreenColor .. "](" .. (PUtil.get)(60000399) .. ")[/color]"
      -- DECOMPILER ERROR at PC70: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (uis.c1Ctr).selectedIndex = 3
      -- DECOMPILER ERROR at PC72: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (uis.ItemWordTxt).text = ""
      ;
      (EquiptMgr.SetAttrs)(uis, equipInfo)
      -- DECOMPILER ERROR at PC87: Confused about usage of register: R2 in 'UnsetPending'

      ;
      (uis.TipsImage).height = (uis.PopList).y + (uis.PopList).height + EquiptData.EquipPanelBottomBlankSize
    end
  end
end

ItemTipsWindow.SetWindowPos = function(...)
  -- function num : 0_5 , upvalues : _ENV, argTable, contentPane, uis, OffsetNum
  local data, propType = (Util.GetConfigDataByID)(argTable[1])
  local v2 = contentPane:GlobalToLocal(Vector2((Input.mousePosition).x, (Input.mousePosition).y))
  loge("uis sourceWidth:" .. tostring((uis.root).sourceWidth) .. " Height:" .. tostring((uis.root).sourceHeight))
  loge("uis Width:" .. tostring((uis.root).width) .. " Height:" .. tostring((uis.root).height))
  local verticalDis = (GRoot.inst).height - v2.y - (uis.root).height - OffsetNum
  local horizontalDis = nil
  if verticalDis >= 0 then
    horizontalDis = v2.x - (uis.root).width * 0.5
    if horizontalDis < 0 then
      horizontalDis = v2.x + OffsetNum
    end
  else
    verticalDis = (GRoot.inst).height - v2.y - (uis.root).height * 0.5 + ((uis.root).height - (uis.root).sourceHeight) * 0.5
    if verticalDis < 0 then
      verticalDis = (GRoot.inst).height - v2.y + OffsetNum
    end
    horizontalDis = v2.x - (uis.root).width - OffsetNum
    if horizontalDis < 0 then
      horizontalDis = v2.x + OffsetNum
    end
  end
  contentPane:SetXY(horizontalDis, verticalDis)
end

ItemTipsWindow.OnHide = function(...)
  -- function num : 0_6
end

ItemTipsWindow.OnClose = function(...)
  -- function num : 0_7 , upvalues : uis, contentPane, argTable
  uis = nil
  contentPane = nil
  argTable = {}
end

ItemTipsWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_8
end

return ItemTipsWindow

