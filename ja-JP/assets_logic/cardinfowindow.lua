-- params : ...
-- function num : 0 , upvalues : _ENV
require("Card_CardInfoByName")
CardInfoWindow = {}
local uis = nil
local cardData = {}
local concatCards = {}
local fashionId = nil
local curCard = 0
local isThisCardCover, PictureLoader, parent = nil, nil, nil
local SELF_LABEL_MAX = 4
local Asset = require("AssetStripWindow")
local FxManager = (require("FxManager"))
local shutterCount = nil
-- DECOMPILER ERROR at PC21: Confused about usage of register: R12 in 'UnsetPending'

CardInfoWindow.Init = function(contentPane, ...)
  -- function num : 0_0 , upvalues : parent, uis, PictureLoader, _ENV, Asset
  parent = contentPane
  uis = contentPane.CardInfoGrp
  PictureLoader = contentPane.PictureLoader
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((contentPane.AssetStripGrp).FunctionNameTxt).text = (PUtil.get)(172)
  ;
  (((contentPane.AssetStripGrp).BackBtn).onClick):Clear()
  ;
  (((contentPane.AssetStripGrp).BackBtn).onClick):Add(function(...)
    -- function num : 0_0_0 , upvalues : contentPane, _ENV
    -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

    (contentPane.c1Ctr).selectedIndex = 0
    PlayUITrans(contentPane.root, "in")
    UIMgr:SendWindowMessage("CardWindow", (WindowMsgEnum.CardWindow).E_MSG_CARD_CLOSECARDINFO, {})
    ;
    (((contentPane.AssetStripGrp).BackBtn).onClick):Clear()
    ;
    (((contentPane.AssetStripGrp).BackBtn).onClick):Add(function(...)
      -- function num : 0_0_0_0 , upvalues : _ENV
      UIMgr:CloseWindow((WinResConfig.CardWindow).name)
    end
)
  end
)
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((contentPane.AssetStripGrp).ExplainBtn).visible = true
  ;
  (((contentPane.AssetStripGrp).ExplainBtn).onClick):Set(function(...)
    -- function num : 0_0_1 , upvalues : contentPane, Asset, _ENV
    local windowName = nil
    if (contentPane.c1Ctr).selectedIndex == 0 then
      windowName = "CardWindow"
    else
      windowName = "CardInfoWindow"
    end
    local wordID = (Asset.GetFunctionRuleIdByName)(windowName)
    local ruleDes = (PUtil.get)(tonumber(wordID))
    OpenWindow((WinResConfig.ExplainWindow).name, UILayer.HUD1, tostring(ruleDes))
  end
)
  PlayUITrans(uis.root, "in")
  ;
  (CardInfoWindow.RefreshWindow)()
  ;
  (CardInfoWindow.UpdateSetBtn)()
end

local selectedIndex = nil
-- DECOMPILER ERROR at PC25: Confused about usage of register: R13 in 'UnsetPending'

CardInfoWindow.SetRoleScrollView = function(...)
  -- function num : 0_1 , upvalues : _ENV, parent, uis
  (CardMgr.SetButtomRoleList)(parent.CardHeadList, function(index, data, ...)
    -- function num : 0_1_0 , upvalues : _ENV
    (CardData.SaveCurClickCardID)(data.id)
    ;
    (CardData.SaveCurClickCardIndex)(index)
    ;
    (CardInfoWindow.RefreshWindow)()
  end
, (CardData.GetCardIndex)(), uis.LeftBtn, uis.RightBtn, (WinResConfig.CardWindow).name)
end

-- DECOMPILER ERROR at PC28: Confused about usage of register: R13 in 'UnsetPending'

CardInfoWindow.RefreshCardList = function(...)
  -- function num : 0_2 , upvalues : concatCards, _ENV
  concatCards = {}
  concatCards = (CardData.GetObtainedCardList)()
  ;
  (CardMgr.RefreshCardList)(#concatCards)
end

-- DECOMPILER ERROR at PC31: Confused about usage of register: R13 in 'UnsetPending'

CardInfoWindow.RefreshWindow = function(...)
  -- function num : 0_3 , upvalues : _ENV, curCard, cardData
  local cardID = (CardData.ReturnCardID)()
  curCard = cardID
  cardData = {}
  cardData = (CardData.GetCardData)(cardID)
  ;
  (CardInfoWindow.SetDetailedContentGrp)()
  ;
  (CardInfoWindow.SetDetailedContentOtherGrp)()
  ;
  (CardInfoWindow.SetInfoList)()
  ;
  (CardInfoWindow.UpdateSetBtn)()
end

-- DECOMPILER ERROR at PC34: Confused about usage of register: R13 in 'UnsetPending'

CardInfoWindow.SetPictureLoader = function(...)
  -- function num : 0_4 , upvalues : PictureLoader, _ENV, curCard, cardData, parent, shutterCount, FxManager
  PictureLoader.alpha = 0
  ;
  (Util.RecycleUIModel)(PictureLoader)
  local isStatic = (Util.GetPlayerSetting)(curCard .. "Static", "0")
  ;
  ((CardData.GetFashionConfig)(cardData))
  local fashionConfig = nil
  local obj = nil
  if isStatic == "0" then
    obj = (Util.CreateShowModel)(fashionConfig.id, PictureLoader)
  else
    local t_Object = (Util.ShowUIModel)(fashionConfig.show_texture, PictureLoader)
    obj = t_Object
    ;
    (Util.UpdateShowTextureByConfig)(t_Object, fashionConfig)
  end
  do
    -- DECOMPILER ERROR at PC40: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (parent.c2Ctr).selectedIndex = cardData.intelligence - 1
    if shutterCount ~= nil then
      shutterCount:stop()
      shutterCount = nil
    end
    shutterCount = (SimpleTimer.setTimeout)(0.001, function(...)
    -- function num : 0_4_0 , upvalues : PictureLoader, FxManager, obj, _ENV, cardData, parent
    PictureLoader.alpha = 1
    FxManager:SetShutterEffect(obj, PictureLoader.image)
    ;
    (CardMgr.SetIntelligenceEffect)(cardData.intelligence, (parent.PictureEffect).root)
  end
)
  end
end

-- DECOMPILER ERROR at PC37: Confused about usage of register: R13 in 'UnsetPending'

CardInfoWindow.SetCardHeadList = function(...)
  -- function num : 0_5
end

-- DECOMPILER ERROR at PC40: Confused about usage of register: R13 in 'UnsetPending'

CardInfoWindow.SetFashionId = function(id, ...)
  -- function num : 0_6 , upvalues : fashionId
  fashionId = id
end

-- DECOMPILER ERROR at PC43: Confused about usage of register: R13 in 'UnsetPending'

CardInfoWindow.UpdateSetBtn = function(...)
  -- function num : 0_7 , upvalues : _ENV, isThisCardCover, curCard
  local fashionShow = (ActorData.GetFashionShow)()
  local fashionConfig = ((TableData.gTable).BaseFashionData)[fashionShow]
  do
    if fashionConfig then
      local cardId = fashionConfig.card_id
      isThisCardCover = cardId == curCard
    end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

-- DECOMPILER ERROR at PC46: Confused about usage of register: R13 in 'UnsetPending'

CardInfoWindow.SetDetailedContentGrp = function(...)
  -- function num : 0_8 , upvalues : uis, _ENV, cardData, SELF_LABEL_MAX
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.DetailedContentGrp).LevelTxt).text = (PUtil.get)(53) .. cardData.level
  local excelData = ((TableData.gTable).BaseCardData)[cardData.id]
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.DetailedContentGrp).JueseNameLoader).url = (Util.GetItemUrl)(excelData.name_pic)
  local props = {(uis.DetailedContentGrp).One, (uis.DetailedContentGrp).Two, (uis.DetailedContentGrp).Three}
  local propsTxt = {((uis.DetailedContentGrp).One).LabelTxt, ((uis.DetailedContentGrp).Two).LabelTxt, ((uis.DetailedContentGrp).Three).LabelTxt}
  local selfLabel = split(excelData.card_label_show, ":")
  for i = 1, #props do
    -- DECOMPILER ERROR at PC50: Confused about usage of register: R8 in 'UnsetPending'

    ((props[i]).root).visible = false
  end
  for i = 1, #selfLabel do
    -- DECOMPILER ERROR at PC60: Confused about usage of register: R8 in 'UnsetPending'

    ((props[SELF_LABEL_MAX - i]).root).visible = true
    -- DECOMPILER ERROR at PC70: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (propsTxt[SELF_LABEL_MAX - i]).text = (PUtil.get)(tonumber(selfLabel[i]))
  end
  local preUpStageData = (Card_StageUpWindow.GetBaseCardQualityData)(cardData.quality)
  local levelShow = split(preUpStageData.level_show, ":")
  -- DECOMPILER ERROR at PC84: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((uis.DetailedContentGrp).c2Ctr).selectedIndex = cardData.intelligence - 1
  -- DECOMPILER ERROR at PC90: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((uis.DetailedContentGrp).c1Ctr).selectedIndex = tonumber(levelShow[1])
  -- DECOMPILER ERROR at PC94: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((uis.DetailedContentGrp).StageNumberTxt).text = cardData.quality
  ;
  ((uis.DetailedContentGrp).StarList):RemoveChildrenToPool()
  for i = 1, cardData.star do
    ((uis.DetailedContentGrp).StarList):AddItemFromPool()
  end
  local contentGrp = ((uis.DetailedContentGrp).DetailedContentList):GetChildAt(0)
  ;
  (contentGrp:GetChild("ShuXingNameTxt")).text = (PUtil.get)(54)
  ;
  (contentGrp:GetChild("SMNameTxt")).text = (PUtil.get)(35)
  ;
  (contentGrp:GetChild("SMNumberTxt")).text = cardData.hp
  ;
  (contentGrp:GetChild("GJNameTxt")).text = (PUtil.get)(6)
  ;
  (contentGrp:GetChild("GJNumberTxt")).text = cardData.atk
  ;
  (contentGrp:GetChild("FYNameTxt")).text = (PUtil.get)(1)
  ;
  (contentGrp:GetChild("FYNumberTxt")).text = cardData.def
  ;
  (contentGrp:GetChild("SDNameTxt")).text = (PUtil.get)(36)
  ;
  (contentGrp:GetChild("SDNumberTxt")).text = cardData.spd
  ;
  (contentGrp:GetChild("XYNameTxt")).text = (PUtil.get)(55)
  ;
  (contentGrp:GetChild("XYNumberTxt")).text = cardData.luck
  ;
  (contentGrp:GetChild("BJNameTxt")).text = (PUtil.get)(56)
  ;
  (contentGrp:GetChild("BJNumberTxt")).text = cardData.crt
  ;
  (contentGrp:GetChild("KBNameTxt")).text = (PUtil.get)(57)
  ;
  (contentGrp:GetChild("KBNumberTxt")).text = cardData.rec
  ;
  (contentGrp:GetChild("GDNameTxt")).text = (PUtil.get)(58)
  ;
  (contentGrp:GetChild("GDNumberTxt")).text = cardData.blk
  ;
  (contentGrp:GetChild("PDNameTxt")).text = (PUtil.get)(59)
  ;
  (contentGrp:GetChild("PDNumberTxt")).text = cardData.reb
  ;
  (contentGrp:GetChild("BJQDNameTxt")).text = (PUtil.get)(60)
  ;
  (contentGrp:GetChild("BJQDNumberTxt")).text = cardData.crt_int
  ;
  (contentGrp:GetChild("KBQDNameTxt")).text = (PUtil.get)(61)
  ;
  (contentGrp:GetChild("KBQDNumberTxt")).text = cardData.rec_int
  ;
  (contentGrp:GetChild("GDQDNameTxt")).text = (PUtil.get)(62)
  ;
  (contentGrp:GetChild("GDQDNumberTxt")).text = cardData.blk_int
  ;
  (contentGrp:GetChild("PJQDTxt")).text = (PUtil.get)(63)
  ;
  (contentGrp:GetChild("PJQDNumberTxt")).text = cardData.reb_int
  ;
  (contentGrp:GetChild("ZSQDNameTxt")).text = (PUtil.get)(64)
  ;
  (contentGrp:GetChild("ZSQDNumberTxt")).text = cardData.ext_damage
  ;
  (contentGrp:GetChild("MSQDNameTxt")).text = (PUtil.get)(65)
  ;
  (contentGrp:GetChild("MSQDNumberTxt")).text = cardData.ext_damage_sub
end

-- DECOMPILER ERROR at PC49: Confused about usage of register: R13 in 'UnsetPending'

CardInfoWindow.SetDetailedContentOtherGrp = function(...)
  -- function num : 0_9 , upvalues : _ENV, cardData, uis, fashionId
  local excelData = ((TableData.gTable).BaseCardData)[cardData.id]
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.DetailedContentOtherGrp).CVNameLoader).url = (Util.GetItemUrl)(excelData.cv_pic)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.DetailedContentOtherGrp).RelationTxt).text = (PUtil.get)(138)
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.DetailedContentOtherGrp).RelationNameTxt).text = (Util.GetCardIntimacyData)(cardData.id)
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.DetailedContentOtherGrp).RelationLevelTxt).text = cardData.intimacyLv
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.DetailedContentOtherGrp).JuQingTxt).text = (PUtil.get)(20000377)
  -- DECOMPILER ERROR at PC49: Confused about usage of register: R1 in 'UnsetPending'

  if excelData.is_handbookstage_open == 0 then
    ((uis.DetailedContentOtherGrp).JuQingNumberTxt).text = "[color=#ff5f7b]" .. (PUtil.get)(207) .. "[/color]"
  else
    -- DECOMPILER ERROR at PC63: Confused about usage of register: R1 in 'UnsetPending'

    if cardData.intimacyLv == 0 then
      ((uis.DetailedContentOtherGrp).JuQingNumberTxt).text = "[color=#ff5f7b]" .. (PUtil.get)(60000085) .. "[/color]"
    else
      -- DECOMPILER ERROR at PC75: Confused about usage of register: R1 in 'UnsetPending'

      ;
      ((uis.DetailedContentOtherGrp).JuQingNumberTxt).text = (PUtil.get)(140, (Util.GetCardStoryIndex)(cardData.id))
    end
  end
  ;
  (((uis.DetailedContentOtherGrp).ChangeCardBtn).onClick):Clear()
  ;
  (((uis.DetailedContentOtherGrp).ChangeCardBtn).onClick):Add(function(...)
    -- function num : 0_9_0 , upvalues : _ENV
    OpenWindow((WinResConfig.CardChoiceWindow).name, UILayer.HUD)
  end
)
  local fashionD = (CardData.GetFashionConfig)(cardData)
  fashionId = fashionD.id
  local littleLoader = ((uis.DetailedContentOtherGrp).ChangeCardBtn):GetChild("QBanLoader")
  ;
  (Util.RecycleUIModel)(littleLoader)
  local boneModel = (Util.ShowUIModel)(fashionD.spd_bundle, littleLoader, fashionD.show_spine_type)
  ;
  (SkeletonAnimationUtil.SetAnimation)(boneModel, 0, "idle", true)
  local scale = 20
  ;
  (CSLuaUtil.SetGOScale)(boneModel, scale, scale, scale)
  ;
  (SkeletonAnimationUtil.SetFlip)(boneModel, true, false)
  ;
  (CSLuaUtil.SetGOLocalPos)(boneModel, 63, -116, 0)
end

-- DECOMPILER ERROR at PC52: Confused about usage of register: R13 in 'UnsetPending'

CardInfoWindow.SetInfoList = function(...)
  -- function num : 0_10
end

-- DECOMPILER ERROR at PC55: Confused about usage of register: R13 in 'UnsetPending'

CardInfoWindow.OnClose = function(...)
  -- function num : 0_11 , upvalues : uis, shutterCount, parent, cardData, concatCards, fashionId, curCard, isThisCardCover, PictureLoader
  uis = nil
  if shutterCount ~= nil then
    shutterCount:stop()
    shutterCount = nil
  end
  parent = nil
  cardData = {}
  concatCards = {}
  fashionId = nil
  curCard = nil
  isThisCardCover = nil
  PictureLoader = nil
end

-- DECOMPILER ERROR at PC58: Confused about usage of register: R13 in 'UnsetPending'

CardInfoWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_12 , upvalues : _ENV, cardData
  local windowMsgEnum = WindowMsgEnum.CardWindow
  if msgId == windowMsgEnum.E_MSG_CARD_SENDCARDDATATOINFO then
    cardData = {}
    cardData = para.data
    ;
    (CardInfoWindow.RefreshWindow)()
  else
  end
  if msgId ~= windowMsgEnum.E_MSG_CARD_CLOSECARDCHOICE or msgId == windowMsgEnum.E_MSG_CARD_CHOICESELECTCARDLIST then
    (CardInfoWindow.OnChoiceSelectCardBack)()
  end
end

-- DECOMPILER ERROR at PC61: Confused about usage of register: R13 in 'UnsetPending'

CardInfoWindow.OnChoiceSelectCardBack = function(...)
  -- function num : 0_13 , upvalues : _ENV, parent
  (CardInfoWindow.RefreshWindow)()
  ;
  (CardInfoWindow.SetPictureLoader)()
  ;
  (parent.CardHeadList):ScrollToView((CardData.GetCardIndex)() - 1)
  ;
  (parent.CardHeadList):RefreshVirtualList()
end


