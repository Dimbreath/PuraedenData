-- params : ...
-- function num : 0 , upvalues : _ENV
require("Card_CardChoiceByName")
require("Card_CardChoiceCompByName")
require("Card_StageStateByName")
local CardChoiceWindow = {}
local contentPane = nil
local uis = {}
local cardData = {}
local fashionInfo = {}
local MAXQUALITYNUM = 19
local selectedItem = nil
local selectedFashionId = 0
local fashionItems = {}
local uniqueEffect = nil
local lastClickIndex = -1
local scrollClickEnable = false
local lastIsFinal = false
CardChoiceWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, uis, CardChoiceWindow
  bridgeObj:SetView((WinResConfig.CardChoiceWindow).package, (WinResConfig.CardChoiceWindow).comName)
  contentPane = bridgeObj.contentPane
  contentPane:Center()
  uis = GetCard_CardChoiceUis(contentPane)
  ;
  (CardChoiceWindow.RefreshWindow)(true)
  local m = {}
  m.windowName = (WinResConfig.CardChoiceWindow).name
  m.Tip = (PUtil.get)(176)
  m.model = uis.AssetStripGrp
  m.closeToWindow = (WinResConfig.HomeWindow).name
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.PHYSICAL}
  ;
  (CommonWinMgr.RegisterAssets)(m)
  -- DECOMPILER ERROR at PC52: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.CardHeadList).touchable = false
  ;
  (SimpleTimer.setTimeout)(0.25, function(...)
    -- function num : 0_0_0 , upvalues : uis
    -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

    (uis.CardHeadList).touchable = true
  end
)
  ;
  (CardChoiceWindow.SetRoleScrollView)()
  ;
  (CardChoiceWindow.OutDetailsFairyGUIEffects)()
  ;
  (AudioManager.DisposeCurAudioAndBubble)()
end

CardChoiceWindow.OutDetailsFairyGUIEffects = function(...)
  -- function num : 0_1 , upvalues : uis, _ENV
  for i = 1, 4 do
    (((uis.AssetStripGrp).root):GetChild("Assets_0" .. tostring(i) .. "_Grp")).visible = false
  end
end

CardChoiceWindow.RefreshWindow = function(isInit, isReqBack, ...)
  -- function num : 0_2 , upvalues : _ENV, cardData, fashionInfo, MAXQUALITYNUM, selectedFashionId, lastClickIndex, CardChoiceWindow, uis, fashionItems, selectedItem
  if isReqBack == nil then
    isReqBack = false
  end
  local cardID = (CardData.ReturnCardID)()
  cardData = {}
  fashionInfo = {}
  cardData = (CardData.GetCardData)(cardID)
  for i = 0, MAXQUALITYNUM do
    local qualityData = (CardMgr.GetBaseCardQualityData)(i, cardData.id)
    do
      if qualityData.unlock_fashion_id > 0 then
        local isLock = false
        if i <= cardData.quality then
          isLock = false
        else
          isLock = true
        end
        do
          local fashionData = ((TableData.gTable).BaseFashionData)[qualityData.unlock_fashion_id]
          ;
          (table.insert)(fashionInfo, {fashionID = qualityData.unlock_fashion_id, spd_bundle = fashionData.spd_bundle, head_icon_banner = fashionData.head_icon_banner, isLock = isLock, lockTips = qualityData.name, qualityData = qualityData})
          -- DECOMPILER ERROR at PC54: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC54: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  local fashionConfig = nil
  if isInit then
    fashionConfig = (CardData.GetFashionConfig)(cardData)
  else
    selectedFashionId = (fashionInfo[lastClickIndex]).fashionID
    fashionConfig = ((TableData.gTable).BaseFashionData)[selectedFashionId]
  end
  if isReqBack == false then
    (CardChoiceWindow.SetCg)(fashionConfig.id)
  end
  ;
  ((uis.CardLookBtn).onClick):Clear()
  ;
  ((uis.CardLookBtn).onClick):Add(function(...)
    -- function num : 0_2_0 , upvalues : _ENV, selectedFashionId, uis
    OpenWindow("CardLookWindow", UILayer.HUD, selectedFashionId)
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((uis.CardChoicePicShow).root).visible = false
  end
)
  ;
  (uis.ContentList):RemoveChildrenToPool()
  ;
  (CardChoiceWindow.SetFashionItemState)()
  fashionItems = {}
  for k,v in ipairs(fashionInfo) do
    print("v.isLock", v.fashionID, v.isLock)
    local uiMap = (uis.ContentList):AddItemFromPool()
    if selectedItem == nil then
      selectedItem = uiMap
    end
    ;
    (table.insert)(fashionItems, uiMap)
    local cardkChoiceComp = uiMap:GetChild("CardChoiceComp")
    local cardLoader = (cardkChoiceComp:GetChild("CardChoicePic")):GetChild("CardShowLoader")
    local stateTxt = cardkChoiceComp:GetChild("StageTxt")
    local c1Ctr = cardkChoiceComp:GetController("c1")
    if isInit == true then
      cardkChoiceComp.alpha = 0
      PlayUITrans(uiMap, "in", function(...)
    -- function num : 0_2_1
  end
, 0.05 * k)
    end
    local scale = 20
    ;
    (cardLoader.onClick):Clear()
    ;
    (Util.SetSliverHeadIcon)(v.fashionID, cardLoader)
    ;
    (cardLoader.onClick):Add(function(...)
    -- function num : 0_2_2 , upvalues : lastClickIndex, k, selectedFashionId, v, selectedItem, uiMap, CardChoiceWindow
    if lastClickIndex ~= k then
      selectedFashionId = v.fashionID
      selectedItem = uiMap
      ;
      (CardChoiceWindow.SetFashionItemState)(uiMap)
      lastClickIndex = k
      ;
      (CardChoiceWindow.SetCg)(selectedFashionId)
      ;
      (CardChoiceWindow.SetButtonState)()
    end
  end
)
    if v.isLock == true then
      c1Ctr.selectedIndex = 2
      ;
      ((cardkChoiceComp:GetChild("CardChoicePic")):GetController("c1")).selectedIndex = 0
      local stageState = GetCard_StageStateUis(cardkChoiceComp:GetChild("StageState"))
      -- DECOMPILER ERROR at PC171: Confused about usage of register: R16 in 'UnsetPending'

      ;
      (stageState.StageNumberTxt).text = (v.qualityData).level
      -- DECOMPILER ERROR at PC177: Confused about usage of register: R16 in 'UnsetPending'

      ;
      (stageState.WordTxt).text = (PUtil.get)(171)
      -- DECOMPILER ERROR at PC187: Confused about usage of register: R16 in 'UnsetPending'

      ;
      (stageState.c1Ctr).selectedIndex = tonumber((split((v.qualityData).level_show, ":"))[1])
    else
      do
        ;
        ((cardkChoiceComp:GetChild("CardChoicePic")):GetController("c1")).selectedIndex = 1
        -- DECOMPILER ERROR at PC203: Unhandled construct in 'MakeBoolean' P1

        if lastClickIndex == -1 and cardData.fashionId == v.fashionID then
          lastClickIndex = k
          selectedFashionId = v.fashionID
        end
        -- DECOMPILER ERROR at PC214: Unhandled construct in 'MakeBoolean' P1

        if lastClickIndex ~= k or cardData.fashionId == v.fashionID then
          c1Ctr.selectedIndex = 1
          local stageState = GetCard_StageStateUis(cardkChoiceComp:GetChild("StageState"))
          -- DECOMPILER ERROR at PC225: Confused about usage of register: R16 in 'UnsetPending'

          ;
          (stageState.WordTxt).text = (PUtil.get)(68)
        else
          do
            do
              c1Ctr.selectedIndex = 0
              if lastClickIndex == k then
                (CardChoiceWindow.SetFashionItemState)(uiMap)
              end
              -- DECOMPILER ERROR at PC236: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC236: LeaveBlock: unexpected jumping out IF_ELSE_STMT

              -- DECOMPILER ERROR at PC236: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC236: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC236: LeaveBlock: unexpected jumping out IF_ELSE_STMT

              -- DECOMPILER ERROR at PC236: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    end
  end
  ;
  (CardChoiceWindow.SetButtonState)()
  ;
  ((uis.StaticChangeBtn).onClick):Set(function(...)
    -- function num : 0_2_3 , upvalues : _ENV, cardID, selectedFashionId, cardData, CardChoiceWindow
    local isStatic = (Util.GetPlayerSetting)(cardID .. "Static", "0")
    if isStatic == "0" then
      (Util.SetPlayerSetting)(cardID .. "Static", "1")
    else
      ;
      (Util.SetPlayerSetting)(cardID .. "Static", "0")
    end
    if (ActorData.GetFashionShow)() == selectedFashionId then
      (CardService.ReqSetMainCover)(selectedFashionId)
      ;
      (Util.SetPlayerSetting)(PlayerPrefsKeyName.MAIN_SHOW_STATIC, (Util.GetPlayerSetting)(cardData.id .. "Static", "0"))
    end
    ;
    (CardChoiceWindow.SetCg)(selectedFashionId)
  end
)
  ;
  ((uis.UseBtn).onClick):Clear()
  ;
  ((uis.UseBtn).onClick):Add(function(...)
    -- function num : 0_2_4 , upvalues : uis, _ENV, selectedFashionId, cardData
    if ((uis.UseBtn):GetController("c1")).selectedIndex == 1 then
      (MessageMgr.SendCenterTips)((PUtil.get)(20000022))
      return 
    else
      if ((uis.UseBtn):GetController("c1")).selectedIndex == 2 then
        (MessageMgr.SendCenterTips)((PUtil.get)(202))
        return 
      else
        if ((uis.UseBtn):GetController("c1")).selectedIndex == 3 then
          (MessageMgr.SendCenterTips)((PUtil.get)(205))
          return 
        end
      end
    end
    if selectedFashionId == cardData.fashionId then
      return 
    else
      if selectedFashionId == 0 then
        return 
      end
    end
    ;
    (CardService.ReqSetFashion)(cardData.id, selectedFashionId)
  end
)
  local selectBtn = nil
  ;
  ((uis.ImageSetBtn).onClick):Clear()
  -- DECOMPILER ERROR at PC258: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((uis.ImageSetBtn).onClick):Add(function(...)
    -- function num : 0_2_5 , upvalues : selectBtn, _ENV, selectedFashionId, cardData
    if (selectBtn:GetController("c1")).selectedIndex == 4 then
      (MessageMgr.SendCenterTips)((PUtil.get)(20000022))
      return 
    else
      if (selectBtn:GetController("c1")).selectedIndex == 5 then
        (CardService.ReqSetMainCover)(selectedFashionId)
        ;
        (Util.SetPlayerSetting)(PlayerPrefsKeyName.MAIN_SHOW_STATIC, (Util.GetPlayerSetting)(cardData.id .. "Static", "0"))
      else
        if (selectBtn:GetController("c1")).selectedIndex == 6 then
          (MessageMgr.SendCenterTips)((PUtil.get)(206))
          return 
        end
      end
    end
  end
)
end

CardChoiceWindow.CheckIsLock = function(fashionId, data, ...)
  -- function num : 0_3 , upvalues : _ENV
  for key,value in ipairs(data) do
    if value.fashionID == fashionId then
      return value.isLock
    end
  end
end

CardChoiceWindow.SetFashionItemState = function(fashionItem, ...)
  -- function num : 0_4 , upvalues : _ENV, fashionItems
  for index,value in ipairs(fashionItems) do
    ((value:GetChild("CardChoiceComp")):GetController("c2")).selectedIndex = 0
  end
  if fashionItem then
    ((fashionItem:GetChild("CardChoiceComp")):GetController("c2")).selectedIndex = 1
  else
    return 
  end
end

CardChoiceWindow.SetButtonState = function(fashionConfig, ...)
  -- function num : 0_5 , upvalues : _ENV, selectedFashionId, uis, CardChoiceWindow, fashionInfo, cardData
  local fashionExcelData = ((TableData.gTable).BaseFashionData)[selectedFashionId]
  if (ActorData.GetFashionShow)() == selectedFashionId then
    ((uis.ImageSetBtn):GetController("c1")).selectedIndex = 6
    ;
    ((uis.ImageSetBtn):GetChild("title")).text = (PUtil.get)(206)
  else
    if (CardChoiceWindow.CheckIsLock)(selectedFashionId, fashionInfo) then
      ((uis.ImageSetBtn):GetController("c1")).selectedIndex = 4
      ;
      ((uis.ImageSetBtn):GetChild("title")).text = (PUtil.get)(201)
    else
      ;
      ((uis.ImageSetBtn):GetController("c1")).selectedIndex = 5
      ;
      ((uis.ImageSetBtn):GetChild("title")).text = (PUtil.get)(201)
    end
  end
  if cardData.fashionId == selectedFashionId then
    ((uis.UseBtn):GetController("c1")).selectedIndex = 2
    ;
    ((uis.UseBtn):GetChild("title")).text = (PUtil.get)(68)
  else
    local isLock = (CardChoiceWindow.CheckIsLock)(selectedFashionId, fashionInfo)
    if isLock then
      ((uis.UseBtn):GetController("c1")).selectedIndex = 1
      ;
      ((uis.UseBtn):GetChild("title")).text = (PUtil.get)(20000032)
    else
      if fashionExcelData.type == 3 then
        ((uis.UseBtn):GetController("c1")).selectedIndex = 3
        ;
        ((uis.UseBtn):GetChild("title")).text = (PUtil.get)(205)
      else
        ;
        ((uis.UseBtn):GetController("c1")).selectedIndex = 0
        ;
        ((uis.UseBtn):GetChild("title")).text = (PUtil.get)(20000032)
      end
    end
  end
  do
    -- DECOMPILER ERROR at PC137: Confused about usage of register: R2 in 'UnsetPending'

    if fashionExcelData.type == 1 then
      (uis.StaticChangeBtn).visible = false
    else
      -- DECOMPILER ERROR at PC143: Confused about usage of register: R2 in 'UnsetPending'

      if fashionExcelData.type == 2 then
        (uis.StaticChangeBtn).visible = true
      else
        -- DECOMPILER ERROR at PC149: Confused about usage of register: R2 in 'UnsetPending'

        if fashionExcelData.type == 3 then
          (uis.StaticChangeBtn).visible = false
        end
      end
    end
  end
end

CardChoiceWindow.SetCg = function(fashionId, ...)
  -- function num : 0_6 , upvalues : _ENV, uis, uniqueEffect, lastIsFinal, CardChoiceWindow
  local fashionData = ((TableData.gTable).BaseFashionData)[fashionId]
  local isStatic = (Util.GetPlayerSetting)(fashionData.card_id .. "Static", "0")
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R3 in 'UnsetPending'

  if (Util.CheckNullString)(fashionData.name) then
    (uis.TitleTxt).text = (PUtil.get)(82610100)
  else
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (uis.TitleTxt).text = fashionData.name
  end
  if uniqueEffect ~= nil then
    (LuaEffect.DestroyEffect)(uniqueEffect)
    uniqueEffect = nil
  end
  if lastIsFinal then
    ((CS.RTManager).Singleton):ReleaseModelFromLoader((uis.CardChoicePicShow).PictureLoader)
  else
    ;
    (Util.RecycleUIModel)((uis.CardChoicePicShow).PictureLoader)
  end
  if fashionData.show_cg ~= nil then
    local model = (ResHelper.InstantiateEffect)(fashionData.show_cg)
    ;
    ((CS.RTManager).Singleton):ShowModelToLoader((uis.CardChoicePicShow).PictureLoader, model)
    ;
    (CardChoiceWindow.ProcessModelWithRT)(model)
    ;
    (CSLuaUtil.SetGOLocalPos)(model, DesignScreen.width * 0.5, -DesignScreen.height * 0.5, 0)
    local curScreenScale = Screen.width / Screen.height
    local designScale = DesignScreen.width / DesignScreen.height
    if designScale < curScreenScale then
      (CSLuaUtil.SetGOScale)(model, 1, 1, 1)
    else
      local scale = designScale / curScreenScale
      ;
      (CSLuaUtil.SetGOScale)(model, scale, scale, scale)
    end
  else
    do
      if isStatic == "0" then
        (Util.CreateAutoFitModel)(fashionId, (uis.CardChoicePicShow).PictureLoader, true, false, true)
      else
        local t_Object = (Util.ShowUIModel)(fashionData.show_texture, (uis.CardChoicePicShow).PictureLoader)
      end
      do
        lastIsFinal = fashionData.show_cg ~= nil
        -- DECOMPILER ERROR: 1 unprocessed JMP targets
      end
    end
  end
end

CardChoiceWindow.ProcessModelWithRT = function(info, ...)
  -- function num : 0_7 , upvalues : _ENV
  local scaler = GameObject("Scaler")
  ;
  (CSLuaUtil.ChangeLayer)(scaler.transform, "Model")
  ;
  (scaler.transform):SetParent((info.transform).parent)
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (scaler.transform).localScale = Vector3.one * ResolutionHandler.UIscale
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (scaler.transform).localPosition = Vector3(-DesignScreen.width * 0.5 * ResolutionHandler.UIscale, DesignScreen.height * 0.5 * ResolutionHandler.UIscale, 0)
  ;
  (info.transform):SetParent(scaler.transform, true)
end

CardChoiceWindow.SetRoleScrollView = function(...)
  -- function num : 0_8 , upvalues : _ENV, uis, CardChoiceWindow
  (CardMgr.SetButtomRoleList)(uis.CardHeadList, function(index, data, ...)
    -- function num : 0_8_0 , upvalues : _ENV, CardChoiceWindow
    if index ~= (CardData.GetCardIndex)() then
      (CardData.SaveCurClickCardID)(data.id)
      ;
      (CardData.SaveCurClickCardIndex)(index)
      ;
      (CardChoiceWindow.RefreshWindow)(false)
    end
  end
, (CardData.GetCardIndex)(), uis.LeftBtn, uis.RightBtn, (WinResConfig.CardChoiceWindow).name)
end

CardChoiceWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_9 , upvalues : _ENV, CardChoiceWindow, selectedItem, uis
  local windowMsgEnum = WindowMsgEnum.CardWindow
  if msgId == windowMsgEnum.E_MSG_CARD_SETFASHIONID then
    (CardData.SaveFashionID)(para.cardId, para.fashionId)
    ;
    (CardChoiceWindow.RefreshWindow)(false, true)
    ;
    (CardChoiceWindow.SelectedEffects)(selectedItem)
  else
    if msgId == windowMsgEnum.E_MSG_CARD_SETMAINFASHION then
      (CardChoiceWindow.RefreshWindow)(false, true)
      ;
      (CardChoiceWindow.SelectedEffects)(selectedItem)
    else
      -- DECOMPILER ERROR at PC34: Confused about usage of register: R3 in 'UnsetPending'

      if msgId == windowMsgEnum.E_MSG_CARD_CLOSECARDLOOK then
        ((uis.CardChoicePicShow).root).visible = true
      end
    end
  end
end

CardChoiceWindow.SelectedEffects = function(uiMap, ...)
  -- function num : 0_10 , upvalues : _ENV
  if uiMap == nil then
    return 
  end
  local holder = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_REFRESH_CARD, true, true)
  if holder then
    uiMap:AddChild(holder)
    holder:SetXY(uiMap.width * 0.5, uiMap.height * 0.5)
  end
end

CardChoiceWindow.SetCardTexture = function(fashionID, loader, ...)
  -- function num : 0_11 , upvalues : _ENV
  local fashionConfig = ((TableData.gTable).BaseFashionData)[fashionID]
  if not fashionConfig then
    loge(fashionID .. "fashionID" .. "未找到")
    loader.visible = false
    return 
  end
  loader.visible = true
  loader.url = (Util.GetItemUrl)(fashionConfig.head_icon_sliver)
end

CardChoiceWindow.OnClose = function(...)
  -- function num : 0_12 , upvalues : _ENV, lastIsFinal, uis, contentPane, selectedFashionId, lastClickIndex, uniqueEffect, fashionItems, scrollClickEnable, selectedItem
  (CommonWinMgr.RemoveAssets)((WinResConfig.CardChoiceWindow).name)
  if lastIsFinal then
    ((CS.RTManager).Singleton):ReleaseModelFromLoader((uis.CardChoicePicShow).PictureLoader)
  else
    ;
    (Util.RecycleUIModel)((uis.CardChoicePicShow).PictureLoader)
  end
  UIMgr:SendWindowMessage("CardWindow", (WindowMsgEnum.CardWindow).E_MSG_CARD_CLOSECARDCHOICE, {})
  UIMgr:SendWindowMessage((WinResConfig.HomeWindow).name, (WindowMsgEnum.HomeWindow).E_MSG_UPDATE_BG, {})
  contentPane = nil
  selectedFashionId = 0
  lastIsFinal = false
  lastClickIndex = -1
  uis = nil
  if uniqueEffect ~= nil then
    (LuaEffect.DestroyEffect)(uniqueEffect)
    uniqueEffect = nil
  end
  fashionItems = {}
  scrollClickEnable = false
  selectedItem = nil
end

return CardChoiceWindow

