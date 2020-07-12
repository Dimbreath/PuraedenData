-- params : ...
-- function num : 0 , upvalues : _ENV
require("HandBook_RelationByName")
local HandBookRelationWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local curTreeId = nil
local treeData = {}
local curCardItemIndex = 1
local lastCardItemIndex = 1
local MAXNUM = 11
local itemX, starUrl = nil, nil
local sortTab = {}
local CONSTWORDPOS_Y = 5.5
local curShowItems = {}
HandBookRelationWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, curCardItemIndex, itemX, lastCardItemIndex, MAXNUM, HandBookRelationWindow
  bridgeObj:SetView((WinResConfig.HandBookRelationWindow).package, (WinResConfig.HandBookRelationWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetHandBook_RelationUis(contentPane)
  local m = {}
  m.windowName = (WinResConfig.HandBookRelationWindow).name
  m.Tip = (PUtil.get)(157)
  m.model = uis.AssetStripGrp
  m.closeToWindow = (WinResConfig.HandBookMainWindow).name
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.PHYSICAL}
  ;
  (CommonWinMgr.RegisterAssets)(m)
  -- DECOMPILER ERROR at PC50: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((uis.AssetStripGrp).Assets_01_Grp).root).visible = false
  -- DECOMPILER ERROR at PC54: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((uis.AssetStripGrp).Assets_02_Grp).root).visible = false
  -- DECOMPILER ERROR at PC58: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((uis.AssetStripGrp).Assets_03_Grp).root).visible = false
  -- DECOMPILER ERROR at PC62: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((uis.AssetStripGrp).Assets_04_Grp).root).visible = false
  ;
  (((uis.Relation_CardList).scrollPane).onScrollEnd):Add(function(...)
    -- function num : 0_0_0 , upvalues : uis, curCardItemIndex, _ENV, itemX, lastCardItemIndex, MAXNUM, HandBookRelationWindow
    local x = ((uis.Relation_CardList).scrollPane).posX
    curCardItemIndex = (math.ceil)(x / (itemX + (uis.Relation_CardList).columnGap)) + 1
    do
      if lastCardItemIndex ~= curCardItemIndex then
        local item = nil
        if curCardItemIndex == MAXNUM then
          item = (uis.Relation_CardList):GetChildAt(1)
        else
          item = (uis.Relation_CardList):GetChildAt(0)
        end
      end
      lastCardItemIndex = curCardItemIndex
      ;
      (HandBookRelationWindow.SetAttributeInfo)(curCardItemIndex)
      ;
      (HandBookRelationWindow.CheckArrow)()
    end
  end
)
  ;
  (uis.Relation_CardList):SetVirtual()
  -- DECOMPILER ERROR at PC74: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.Relation_CardList).itemRenderer = HandBookRelationWindow.RefreshCardListItem
  ;
  (uis.Relation_CardList):SpecifyScrollPos(0.5, 0.5)
  ;
  (HandBookRelationWindow.InitEvent)(true)
  -- DECOMPILER ERROR at PC89: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((uis.AttributeTipsGrp).Word_00_Txt).text = (PUtil.get)(159)
end

HandBookRelationWindow.ForHentaiDirectorEffect = function(...)
  -- function num : 0_1 , upvalues : uis
  local childNum = (uis.Relation_CardList).numChildren
  for i = 1, childNum do
    local index = i - 1
    local item = (uis.Relation_CardList):GetChildAt(index)
    for i = 1, 6 do
      local cardItem = item:GetChild("Card_0" .. i .. "_Grp")
      cardItem.alpha = 0
    end
  end
end

HandBookRelationWindow.PlayFirstAnimation = function(...)
  -- function num : 0_2 , upvalues : uis, _ENV
  local item = (uis.Relation_CardList):GetChildAt(0)
  PlayUITrans(item, "up")
end

HandBookRelationWindow.InitEvent = function(isInit, ...)
  -- function num : 0_3 , upvalues : curTreeId, _ENV, curCardItemIndex, sortTab, treeData, curShowItems, uis, HandBookRelationWindow
  curTreeId = (HandBookData.GetCurClickedFetterTreeId)()
  curCardItemIndex = (HandBookData.GetRelationIndexById)(curTreeId)
  local tmpTData = (HandBookData.GetAllInfo)()
  if isInit then
    sortTab = tmpTData
  end
  treeData = (HandBookData.GetAllInfo)()
  curShowItems = {}
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.Relation_CardList).numItems = #treeData
  ;
  (HandBookRelationWindow.SetAttributeInfo)(curCardItemIndex)
  if isInit then
    (HandBookRelationWindow.PlayFirstAnimation)()
  end
  ;
  (LuaSound.PlaySound)(LuaSound.COMMON_SLIDE_2, SoundBank.OTHER)
  ;
  (uis.Relation_CardList):ScrollToView(curCardItemIndex - 1)
  ;
  (HandBookRelationWindow.CheckArrow)()
  ;
  ((uis.OverviewBtn).onClick):Clear()
  ;
  ((uis.OverviewBtn).onClick):Add(function(...)
    -- function num : 0_3_0 , upvalues : _ENV
    OpenWindow((WinResConfig.HandBookRelationListWindow).name, UILayer.HUD)
  end
)
  -- DECOMPILER ERROR at PC61: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((uis.AttributeTipsGrp).Word_00_Txt).text = (PUtil.get)(159)
  ;
  (((uis.AttributeTipsGrp).SureBtn):GetChild("title")).text = (PUtil.get)(163)
end

HandBookRelationWindow.RefreshCardListItem = function(index, item, ...)
  -- function num : 0_4 , upvalues : itemX, treeData, HandBookRelationWindow, _ENV, starUrl, curShowItems
  if itemX == nil then
    itemX = item.width
  end
  index = index + 1
  local curTreeData = treeData[index]
  local cards = curTreeData.allCardsIds
  local cardItems = {}
  local isShowEffect = true
  for i = 1, 6 do
    local cardItem = (item:GetChild("Card_0" .. i .. "_Grp"))
    do
      local selectedIndex = nil
      ;
      (cardItem.onClick):Clear()
      ;
      (cardItem:GetController("c2")).selectedIndex = 0
      ;
      (HandBookRelationWindow.ClearLastEffect)(cardItem)
      ;
      (table.insert)(cardItems, cardItem)
      if cards[i] then
        local cardId = cards[i]
        do
          if not (CardData.GetCardData)(cardId) then
            local cardData = ((TableData.gTable).BaseCardData)[cardId]
          end
          if not cardData.fashionId then
            local fashionId = (((TableData.gTable).BaseCardQualityUpData)[tonumber(tostring(cardId) .. "00")]).unlock_fashion_id
          end
          ;
          (Util.SetSliverHeadIcon)(fashionId, (cardItem:GetChild("CardPictureLoaderPic")):GetChild("CardPictureLoader"))
          local starList = cardItem:GetChild("StarList")
          local stageLvl = cardItem:GetChild("StageLevelGrp")
          ;
          (stageLvl:GetController("c1")).selectedIndex = 0
          starList:RemoveChildrenToPool()
          if starUrl == nil then
            starUrl = starList.defaultItem
          end
          if (CardData.IsObtained)(cardId) then
            selectedIndex = 0
            local star = cardData.star
            for j = 1, star do
              starList:AddItemFromPool()
            end
            local quality = cardData.quality
            local stageData = (CardMgr.GetBaseCardQualityData)(cardData.quality, cardData.id)
            local levelShow = split(stageData.level_show, ":")
            ;
            (stageLvl:GetController("c1")).selectedIndex = tonumber(levelShow[1])
            if quality == 0 then
              (stageLvl:GetChild("StageNumberTxt")).text = ""
            else
              ;
              (stageLvl:GetChild("StageNumberTxt")).text = quality
            end
            ;
            (cardItem.onClick):Add(function(...)
    -- function num : 0_4_0 , upvalues : cardItem, _ENV, cardItems
    if (cardItem:GetController("c2")).selectedIndex == 1 then
      (cardItem:GetController("c2")).selectedIndex = 0
      return 
    end
    for index,value in ipairs(cardItems) do
      (value:GetController("c2")).selectedIndex = 0
    end
    ;
    (cardItem:GetController("c2")).selectedIndex = 1
  end
)
            local gotoBtn = cardItem:GetChild("GoBtn")
            ;
            (gotoBtn:GetChild("title")).text = (PUtil.get)(178)
            ;
            (gotoBtn.onClick):Clear()
            ;
            (gotoBtn.onClick):Add(function(...)
    -- function num : 0_4_1 , upvalues : _ENV, cardId
    (CardMgr.ClickCardResultByCardId)(cardId)
  end
)
          else
            do
              do
                local pieceInfo = (ActorData.GetCardPieceInfo)(cardId)
                local allChipNum = pieceInfo.needNum
                local piceID = pieceInfo.id
                local curChipNum = pieceInfo.haveNum
                do
                  local percent = curChipNum / allChipNum * 100
                  if percent < 100 then
                    selectedIndex = 1
                    ;
                    (cardItem:GetChild("UnHaveTxt")).text = (PUtil.get)(217)
                  else
                    selectedIndex = 3
                    ;
                    (cardItem:GetChild("UnHaveTxt")).text = (PUtil.get)(218)
                  end
                  ;
                  (cardItem.onClick):Add(function(...)
    -- function num : 0_4_2 , upvalues : _ENV, cardId
    (CardMgr.ClickCardResultByCardId)(cardId)
  end
)
                  ;
                  (table.insert)(curShowItems, cardItem)
                end
                selectedIndex = 2
                ;
                (cardItem:GetController("c1")).selectedIndex = selectedIndex
                ;
                ((cardItem:GetChild("CardPictureLoaderPic")):GetController("c1")).selectedIndex = selectedIndex
                local tmpBool = selectedIndex == 0 or selectedIndex == 2
                if isShowEffect then
                  do
                    isShowEffect = tmpBool
                    -- DECOMPILER ERROR at PC221: LeaveBlock: unexpected jumping out IF_THEN_STMT

                    -- DECOMPILER ERROR at PC221: LeaveBlock: unexpected jumping out IF_STMT

                  end
                end
              end
              -- DECOMPILER ERROR at PC221: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC221: LeaveBlock: unexpected jumping out IF_ELSE_STMT

              -- DECOMPILER ERROR at PC221: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC221: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC221: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC221: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC221: LeaveBlock: unexpected jumping out DO_STMT

            end
          end
        end
      end
    end
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

HandBookRelationWindow.SetAttributeInfo = function(cIndex, ...)
  -- function num : 0_5 , upvalues : treeData, _ENV, uis, HandBookRelationWindow
  local curTreeData = nil
  if cIndex then
    curTreeData = treeData[cIndex]
  else
    curTreeData = (HandBookData.GetRelationInfoById)((HandBookData.GetCurClickedFetterTreeId)())
  end
  ;
  (HandBookData.SaveCurClickedFetterTreeId)(curTreeData.treeId)
  local allReadyFetterIds = curTreeData.allReadyFetterIds
  local canFetterIds = curTreeData.canFetterIds
  local allFetterIds = curTreeData.allFetterIds
  local attrGrp = ((uis.root):GetChild("AttributeTipsGrp"))
  local grpSelectedIndex, canActivateFetter = nil, nil
  if #allReadyFetterIds < 1 and #canFetterIds < 1 then
    grpSelectedIndex = 0
    local ftId = allFetterIds[1]
    do
      local ftData = ((TableData.gTable).BaseCardFetterData)[ftId]
      local attr = ftData.add_attr
      local attrs = split(attr, ",")
      for index,value in ipairs(attrs) do
        (HandBookRelationWindow.SetAttrInfo)(attrGrp:GetChild("Attribute_0" .. index .. "_Grp"), value, 0)
      end
      -- DECOMPILER ERROR at PC63: Confused about usage of register: R12 in 'UnsetPending'

      ;
      ((uis.AttributeTipsGrp).Word_02_Txt).text = (PUtil.get)(160)
    end
  end
  do
    if #allReadyFetterIds < 1 and #canFetterIds >= 1 then
      grpSelectedIndex = 1
      -- DECOMPILER ERROR at PC77: Confused about usage of register: R8 in 'UnsetPending'

      ;
      ((uis.AttributeTipsGrp).Word_01_Txt).text = (PUtil.get)(161)
      local ftId = allFetterIds[1]
      local ftData = ((TableData.gTable).BaseCardFetterData)[ftId]
      local attr = ftData.add_attr
      local attrs = split(attr, ",")
      for index,value in ipairs(attrs) do
        (HandBookRelationWindow.SetAttrInfo)(attrGrp:GetChild("Attribute_0" .. index .. "_Grp"), value, 0)
      end
      ChangeUIController((uis.AttributeTipsGrp).SureBtn, "c1", 0)
      canActivateFetter = ftId
      ;
      (((uis.AttributeTipsGrp).SureBtn).onClick):Clear()
      ;
      (((uis.AttributeTipsGrp).SureBtn).onClick):Add(function(...)
    -- function num : 0_5_0 , upvalues : _ENV, ftId
    (HandBookService.ReqActivateFetter)(ftId)
    ;
    (LuaSound.PlaySound)(LuaSound.HANDBOOK_ACTIVE, SoundBank.OTHER)
  end
)
    end
    do
      if #allReadyFetterIds >= 1 and #allReadyFetterIds < #allFetterIds then
        grpSelectedIndex = 2
        local indexx = 0
        for i,v in ipairs(allReadyFetterIds) do
          local ftId = v
          local ftData = ((TableData.gTable).BaseCardFetterData)[ftId]
          local attr = ftData.add_attr
          local attrs = split(attr, ",")
          for index,value in ipairs(attrs) do
            (HandBookRelationWindow.SetAttrInfo)(attrGrp:GetChild("Attribute_0" .. index + indexx .. "_Grp"), value, 0)
          end
          indexx = indexx + #attrs
        end
        local readyNum = #allReadyFetterIds
        local isSetFirst = false
        local pushTips = nil
        for i,v in ipairs(allFetterIds) do
          if readyNum < i then
            local ftId = v
            local ftData = ((TableData.gTable).BaseCardFetterData)[ftId]
            local attr = ftData.add_attr
            local attrs = split(attr, ",")
            local realIndex = i - readyNum
            if isSetFirst == false then
              if #canFetterIds > 0 then
                (HandBookRelationWindow.SetAttrInfo)((attrGrp:GetChild("Attribute_0" .. 1 + (indexx) .. "_Grp")), nil, 1)
                canActivateFetter = ftId
              else
                local tmpTxt = (HandBookRelationWindow.SetAttrInfo)((attrGrp:GetChild("Attribute_0" .. 1 + (indexx) .. "_Grp")), nil, 2, ftData)
                if pushTips == nil then
                  pushTips = tmpTxt
                end
              end
              do
                isSetFirst = true
                do
                  do
                    local tmpTxt = (HandBookRelationWindow.SetAttrInfo)((attrGrp:GetChild("Attribute_0" .. 1 + (indexx) .. "_Grp")), nil, 2)
                    if pushTips == nil then
                      pushTips = tmpTxt
                    end
                    indexx = indexx + #attrs
                    -- DECOMPILER ERROR at PC234: LeaveBlock: unexpected jumping out DO_STMT

                    -- DECOMPILER ERROR at PC234: LeaveBlock: unexpected jumping out DO_STMT

                    -- DECOMPILER ERROR at PC234: LeaveBlock: unexpected jumping out IF_THEN_STMT

                    -- DECOMPILER ERROR at PC234: LeaveBlock: unexpected jumping out IF_STMT

                    -- DECOMPILER ERROR at PC234: LeaveBlock: unexpected jumping out IF_THEN_STMT

                    -- DECOMPILER ERROR at PC234: LeaveBlock: unexpected jumping out IF_STMT

                  end
                end
              end
            end
          end
        end
        ;
        (((uis.AttributeTipsGrp).SureBtn).onClick):Clear()
        if canActivateFetter ~= nil then
          (((uis.AttributeTipsGrp).SureBtn).onClick):Add(function(...)
    -- function num : 0_5_1 , upvalues : _ENV, canActivateFetter
    (HandBookService.ReqActivateFetter)(canActivateFetter)
  end
)
          ChangeUIController((uis.AttributeTipsGrp).SureBtn, "c1", 0)
        else
          ;
          (((uis.AttributeTipsGrp).SureBtn).onClick):Clear()
          ;
          (((uis.AttributeTipsGrp).SureBtn).onClick):Add(function(...)
    -- function num : 0_5_2 , upvalues : _ENV, pushTips
    (MessageMgr.SendCenterTips)((PUtil.get)(182) .. pushTips)
  end
)
          ChangeUIController((uis.AttributeTipsGrp).SureBtn, "c1", 1)
        end
      end
      do
        if #allFetterIds <= #allReadyFetterIds then
          grpSelectedIndex = 3
          local indexx = 0
          -- DECOMPILER ERROR at PC286: Confused about usage of register: R9 in 'UnsetPending'

          ;
          ((uis.AttributeTipsGrp).Word_02_Txt).text = (PUtil.get)(162)
          for i,v in ipairs(allReadyFetterIds) do
            local ftId = v
            local ftData = ((TableData.gTable).BaseCardFetterData)[ftId]
            local attr = ftData.add_attr
            local attrs = split(attr, ",")
            for index,value in ipairs(attrs) do
              (HandBookRelationWindow.SetAttrInfo)(attrGrp:GetChild("Attribute_0" .. index + indexx .. "_Grp"), value, 0)
            end
            indexx = indexx + #attrs
          end
        end
        do
          ;
          (attrGrp:GetController("c1")).selectedIndex = grpSelectedIndex
          if #canFetterIds > 0 then
            (HandBookRelationWindow.AddEffectsActive)()
          else
            ;
            (HandBookRelationWindow.DeleteAllEffectsActive)()
          end
        end
      end
    end
  end
end

HandBookRelationWindow.SetAttrInfo = function(item, attr, state, ftData, ...)
  -- function num : 0_6 , upvalues : _ENV, starUrl
  local text = nil
  ;
  (item:GetController("c1")).selectedIndex = state
  local attrs = nil
  if attr then
    attrs = split(attr, ":")
  end
  if state == 0 then
    (item:GetChild("NameTxt")).text = (((TableData.gTable).BaseAttributeData)[tonumber(attrs[2])]).display_name
    ;
    (item:GetChild("NumberTxt")).text = attrs[3]
  else
    if state == 1 then
      text = (PUtil.get)(164)
    else
      if state == 2 then
        if ftData then
          if ftData.lock_type == 1 then
            text = (PUtil.get)(166) .. ftData.star .. "<img src=\'" .. starUrl .. "\' " .. "width=\'" .. tostring(26) .. "\' " .. "height=\'" .. tostring(26) .. "\'>" .. (PUtil.get)(165)
          else
            local quality = ftData.quality
            local stageData = (CardMgr.GetBaseCardQualityData)(quality, 11100003)
            local levelShow = split(stageData.level_show, ":")
            text = (PUtil.get)(167, levelShow[1] .. ":" .. tostring(quality))
          end
        else
          do
            text = (PUtil.get)(179)
            ;
            (item:GetChild("WordTxt")).text = text
            return text
          end
        end
      end
    end
  end
end

HandBookRelationWindow.AddCanActiveEffect = function(item, ...)
  -- function num : 0_7 , upvalues : _ENV, uis
  local cardLoaderGrp = item:GetChild("CardPictureLoaderPic")
  local effect = cardLoaderGrp:GetChild("GoWrapper")
  if (Util.CheckNullString)(effect) then
    local mHolder = (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_RELATION_JIHUO, true, cardLoaderGrp, (Vector2(cardLoaderGrp.width / 2, cardLoaderGrp.height / 2 - 30)), nil, 1, false)
    mHolder.name = "GoWrapper"
    ;
    (Util.SetSfxClipInList)((mHolder.displayObject).gameObject, uis.Relation_CardList)
  else
    do
      effect.visible = true
    end
  end
end

HandBookRelationWindow.ClearLastEffect = function(item, ...)
  -- function num : 0_8 , upvalues : _ENV
  local cardLoaderGrp = item:GetChild("CardPictureLoaderPic")
  local effect = cardLoaderGrp:GetChild("GoWrapper")
  if (Util.CheckNullString)(effect) then
    effect.visible = false
  end
end

HandBookRelationWindow.AddEffectsActive = function(...)
  -- function num : 0_9 , upvalues : uis, HandBookRelationWindow
  (uis.Relation_CardList):TraversalItem(function(index, item, ...)
    -- function num : 0_9_0 , upvalues : uis, HandBookRelationWindow
    if ((uis.Relation_CardList).scrollPane).SpecifyIndex ~= index then
      return 
    end
    for i = 1, 6 do
      local cardItem = item:GetChild("Card_0" .. i .. "_Grp")
      if (cardItem:GetController("c1")).selectedIndex == 0 then
        (HandBookRelationWindow.AddCanActiveEffect)(cardItem)
      else
        ;
        (HandBookRelationWindow.ClearLastEffect)(cardItem)
      end
    end
  end
)
end

HandBookRelationWindow.DeleteAllEffectsActive = function(...)
  -- function num : 0_10 , upvalues : uis, HandBookRelationWindow
  (uis.Relation_CardList):TraversalItem(function(index, item, ...)
    -- function num : 0_10_0 , upvalues : uis, HandBookRelationWindow
    if ((uis.Relation_CardList).scrollPane).SpecifyIndex ~= index then
      return 
    end
    for i = 1, 6 do
      local cardItem = item:GetChild("Card_0" .. i .. "_Grp")
      ;
      (HandBookRelationWindow.ClearLastEffect)(cardItem)
    end
  end
)
end

HandBookRelationWindow.ClearAllRelationEffect = function(...)
  -- function num : 0_11 , upvalues : uis
  local itemList = uis.Relation_CardList
end

HandBookRelationWindow.ActiveSuccessEffect = function(...)
  -- function num : 0_12 , upvalues : uis, _ENV
  (uis.Relation_CardList):TraversalItem(function(index, item, ...)
    -- function num : 0_12_0 , upvalues : uis, _ENV
    if ((uis.Relation_CardList).scrollPane).SpecifyIndex ~= index then
      return 
    end
    for i = 1, 6 do
      local cardItem = item:GetChild("Card_0" .. i .. "_Grp")
      if (cardItem:GetController("c1")).selectedIndex == 0 then
        local mHolder = (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_RELATION_JIHUO_END, true, cardItem, (Vector2(cardItem.width / 2, cardItem.height)), nil, 1, true)
      end
    end
  end
)
end

HandBookRelationWindow.SetCardTexture = function(fashionID, loader, ...)
  -- function num : 0_13 , upvalues : _ENV
  local fashionConfig = ((TableData.gTable).BaseFashionData)[fashionID]
  if not fashionConfig then
    loge(fashionID .. "fashionID" .. "未找到")
    loader.visible = false
    return 
  end
  loader.visible = true
  loader.url = (Util.GetItemUrl)(fashionConfig.head_icon_sliver)
end

HandBookRelationWindow.CheckArrow = function(...)
  -- function num : 0_14 , upvalues : uis, curCardItemIndex, MAXNUM
  if uis.LeftBtn == nil or uis.RightBtn == nil then
    return 
  end
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

  if curCardItemIndex == 1 then
    (uis.LeftBtn).visible = false
  else
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (uis.LeftBtn).visible = true
  end
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R0 in 'UnsetPending'

  if curCardItemIndex == MAXNUM then
    (uis.RightBtn).visible = false
  else
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (uis.RightBtn).visible = true
  end
end

HandBookRelationWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_15 , upvalues : _ENV, treeData, HandBookRelationWindow, uis, curCardItemIndex, itemX, lastCardItemIndex, MAXNUM
  local windowMsgEnum = WindowMsgEnum.HandBookIntimacyWindow
  if msgId == windowMsgEnum.RELATION_ACTIVETION then
    treeData = (HandBookData.GetAllInfo)()
    treeData = (HandBookRelationWindow.SortTable)(treeData)
    ;
    (HandBookData.SaveAllInfo)(treeData)
    ;
    (HandBookRelationWindow.InitEvent)(false)
    ;
    (HandBookRelationWindow.ActiveSuccessEffect)()
  else
    if msgId == windowMsgEnum.CLOSE_LIST_WINDOW then
      (HandBookRelationWindow.InitEvent)(false)
      local x = ((uis.Relation_CardList).scrollPane).posX
      curCardItemIndex = (math.ceil)(x / (itemX + (uis.Relation_CardList).columnGap)) + 1
      do
        do
          if lastCardItemIndex ~= curCardItemIndex then
            local item = nil
            if curCardItemIndex == MAXNUM then
              item = (uis.Relation_CardList):GetChildAt(1)
            else
              item = (uis.Relation_CardList):GetChildAt(0)
            end
          end
          lastCardItemIndex = curCardItemIndex
          ;
          (HandBookRelationWindow.SetAttributeInfo)(curCardItemIndex)
          ;
          (HandBookRelationWindow.CheckArrow)()
          if msgId == windowMsgEnum.E_MSG_CARD_PICE_TO_CARD then
            OpenWindow("PiceGetShowWindow", UILayer.HUD, para.cardId)
            ;
            (HandBookRelationWindow.InitEvent)(false)
          end
        end
      end
    end
  end
end

HandBookRelationWindow.SortTable = function(arrTab, ...)
  -- function num : 0_16 , upvalues : _ENV, sortTab
  local tab = {}
  for i,v in ipairs(sortTab) do
    for n,m in ipairs(arrTab) do
      if m.treeId == v.treeId then
        (table.insert)(tab, m)
        break
      end
    end
  end
  return tab
end

HandBookRelationWindow.OnShown = function(...)
  -- function num : 0_17 , upvalues : _ENV
  (GuideMgr.PictureTriggerGuide)((WinResConfig.HandBookRelationWindow).name)
end

HandBookRelationWindow.OnClose = function(...)
  -- function num : 0_18 , upvalues : _ENV, uis, contentPane, argTable, curTreeId, treeData, sortTab, curCardItemIndex, lastCardItemIndex, curShowItems, starUrl, itemX
  (CommonWinMgr.RemoveAssets)((WinResConfig.HandBookRelationWindow).name)
  uis = nil
  contentPane = nil
  argTable = {}
  curTreeId = nil
  treeData = {}
  sortTab = {}
  curCardItemIndex = 1
  lastCardItemIndex = 1
  curShowItems = {}
  starUrl = nil
  itemX = nil
end

return HandBookRelationWindow

