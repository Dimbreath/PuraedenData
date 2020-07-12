-- params : ...
-- function num : 0 , upvalues : _ENV
require("Card_CardCommentByName")
require("Card_CommentWordByName")
require("Card_CardCommentWindowByName")
local CardCommentWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local cardID = 0
local commentData = {}
local commentType = {hotLine = 1, newLine = 2, hotContent = 3, newContent = 4}
local currentPage = 0
CardCommentWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, cardID, currentPage, uis, CardCommentWindow
  bridgeObj:SetView((WinResConfig.CardCommentWindow).package, (WinResConfig.CardCommentWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  cardID = tonumber(argTable[1])
  currentPage = 1
  uis = GetCard_CardCommentWindowUis(contentPane)
  uis = uis.CardComment
  ;
  (CardCommentWindow.InitList)()
  ;
  (CardCommentWindow.SetCardTexture)()
  ;
  (CardCommentWindow.InitBtn)()
  ;
  (CardCommentWindow.RefreshList)()
  ;
  (CardCommentWindow.SetCardLikeState)()
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.WordTxt).text = ""
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.WordTxt).promptText = (PUtil.get)(20000365)
  -- DECOMPILER ERROR at PC47: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.TtileTxt).text = (PUtil.get)(213)
end

CardCommentWindow.InitList = function(...)
  -- function num : 0_1 , upvalues : uis, _ENV, CardCommentWindow, currentPage, cardID
  local CommentList = uis.CommentList
  CommentList.defaultItem = (Util.GetResUrl)("Card:CommentWord")
  CommentList:SetVirtual()
  CommentList.itemRenderer = CardCommentWindow.ListRender
  ;
  ((CommentList.scrollPane).onPullUpRelease):Set(function(...)
    -- function num : 0_1_0 , upvalues : CommentList, _ENV, currentPage, cardID, CardCommentWindow
    local footer = (CommentList.scrollPane).footer
    ;
    (footer:GetController("c1")).selectedIndex = 1
    PlayUITrans(footer, "Rotate")
    ;
    (CommentList.scrollPane):LockFooter(footer.sourceHeight)
    currentPage = currentPage + 1
    ;
    (CardService.ReqGetCardChat)(cardID, currentPage)
    ;
    (SimpleTimer.setTimeout)(1, function(...)
      -- function num : 0_1_0_0 , upvalues : footer, CommentList, CardCommentWindow
      (footer:GetController("c1")).selectedIndex = 0
      ;
      (CommentList.scrollPane):LockFooter(0)
      ;
      (CardCommentWindow.RefreshList)()
    end
)
  end
)
end

CardCommentWindow.SetCardLikeState = function(...)
  -- function num : 0_2 , upvalues : uis, _ENV, cardID
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  (uis.LoveBtn).selected = (CardMgr.GetCardLikeState)(cardID)
end

CardCommentWindow.RefreshList = function(...)
  -- function num : 0_3 , upvalues : commentData, _ENV, commentType, uis
  commentData = {}
  local hotComment = (CardMgr.GetHotComment)()
  local newComment = (CardMgr.GetNewComment)()
  local hotLine = 0
  local newLine = 0
  if #hotComment > 0 then
    hotLine = 1
    ;
    (table.insert)(commentData, {value = nil, type = commentType.hotLine})
    for _,v in ipairs(hotComment) do
      (table.insert)(commentData, {value = v, type = commentType.hotContent})
    end
  end
  do
    if #newComment > 0 then
      newLine = 1
      ;
      (table.insert)(commentData, {value = nil, type = commentType.newLine})
      for _,v in ipairs(newComment) do
        (table.insert)(commentData, {value = v, type = commentType.newContent})
      end
    end
    do
      -- DECOMPILER ERROR at PC64: Confused about usage of register: R4 in 'UnsetPending'

      ;
      (uis.CommentList).itemProvider = function(index, ...)
    -- function num : 0_3_0 , upvalues : commentData, commentType, _ENV
    local type = (commentData[index + 1]).type
    local resUrl = nil
    if type == commentType.hotLine then
      resUrl = (Util.GetResUrl)("Card:DivisionLine_A")
    else
      if type == commentType.newLine then
        resUrl = (Util.GetResUrl)("Card:DivisionLine_B")
      else
        resUrl = (Util.GetResUrl)("Card:CommentWord")
      end
    end
    return resUrl
  end

      -- DECOMPILER ERROR at PC70: Confused about usage of register: R4 in 'UnsetPending'

      if #commentData <= 0 then
        (uis.c1Ctr).selectedIndex = 1
        -- DECOMPILER ERROR at PC76: Confused about usage of register: R4 in 'UnsetPending'

        ;
        (uis.NothingTxt).text = (PUtil.get)(20000232)
        ;
        (Util.SetNotFoundEffect)(uis.CardQLoader)
      else
        -- DECOMPILER ERROR at PC85: Confused about usage of register: R4 in 'UnsetPending'

        ;
        (uis.CommentList).numItems = #commentData
        -- DECOMPILER ERROR at PC87: Confused about usage of register: R4 in 'UnsetPending'

        ;
        (uis.c1Ctr).selectedIndex = 0
      end
    end
  end
end

CardCommentWindow.ListRender = function(index, obj, ...)
  -- function num : 0_4 , upvalues : commentData, commentType, _ENV, cardID
  local data = commentData[index + 1]
  if data == nil then
    return 
  end
  local type = data.type
  local cData = data.value
  if type == commentType.newLine then
    (obj:GetChild("WordTxt")).text = (PUtil.get)(215)
  else
    if type == commentType.hotLine then
      (obj:GetChild("WordTxt")).text = (PUtil.get)(214)
    end
  end
  if type == commentType.newLine or type == commentType.hotLine or cData == nil then
    return 
  end
  local model = GetCard_CommentWordUis(obj)
  local name = model.CardNameTxt
  name.text = cData.pName
  if cData.pId == (ActorData.GetPlayerIndex)() then
    name.color = Const.YellowColorRGB
  else
    if type == commentType.hotContent then
      name.color = Const.EnoughColorRGB
    else
      if type == commentType.newContent then
        name.color = Const.BlueColorRGB
      end
    end
  end
  -- DECOMPILER ERROR at PC70: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (model.CommentWordTxt).text = cData.content
  local isPraise = (CardMgr.GetCommentPraise)(cData.chatId)
  -- DECOMPILER ERROR at PC76: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (model.AppreciateBtn).selected = isPraise
  ;
  ((model.AppreciateBtn).onClick):Set(function(...)
    -- function num : 0_4_0 , upvalues : isPraise, _ENV, cardID, cData, model
    if not isPraise then
      (CardService.ReqClickLike)(cardID, cData.chatId)
      local num = cData.clickLikeNum + 1
      if num > 9999 then
        num = "9999+"
      end
      ;
      ((model.AppreciateBtn):GetChild("NumberTxt")).text = num
    end
  end
)
  local praiseNum = cData.clickLikeNum
  if praiseNum > 9999 then
    praiseNum = "9999+"
  end
  ;
  ((model.AppreciateBtn):GetChild("NumberTxt")).text = praiseNum
end

CardCommentWindow.InitBtn = function(...)
  -- function num : 0_5 , upvalues : uis, _ENV, cardID
  ((uis.CloseBtn).onClick):Set(function(...)
    -- function num : 0_5_0 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.CardCommentWindow).name)
  end
)
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.SureBtn).text = (PUtil.get)(20000233)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.WordTxt).inputTextField).RestrictRow = 1
  ;
  ((uis.SureBtn).onClick):Set(function(...)
    -- function num : 0_5_1 , upvalues : uis, _ENV, cardID
    local content = (uis.WordTxt).text
    if not (Util.StringIsNullOrEmpty)(content) then
      local content = ((CS.DirtyWordChecker).Singleton):Replace(content)
      ;
      (ChatService.ReqSetCardComment)(content, cardID)
    else
      do
        ;
        (MessageMgr.SendCenterTips)((PUtil.get)(20000228))
        -- DECOMPILER ERROR at PC28: Confused about usage of register: R1 in 'UnsetPending'

        ;
        (uis.WordTxt).text = ""
      end
    end
  end
)
  ;
  ((uis.LoveBtn).onClick):Set(function(...)
    -- function num : 0_5_2 , upvalues : _ENV, uis, cardID
    local type = (CardMgr.CardCommentState).Cancel
    if (uis.LoveBtn).selected then
      type = (CardMgr.CardCommentState).Like
      local holder, likeEffect = (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_CARD_COMMENT_LIKE, true, uis.root, (Vector2((uis.LoveBtn).x + (uis.LoveBtn).width * 0.5, (uis.LoveBtn).y + (uis.LoveBtn).height * 0.5)), nil, 1, true)
    end
    do
      ;
      (CardService.ReqSetLikeCard)(cardID, type)
    end
  end
)
end

CardCommentWindow.SetCardTexture = function(...)
  -- function num : 0_6 , upvalues : _ENV, cardID, uis
  local fashionConfig = (CardData.GetFashionConfig)((CardData.GetCardData)(cardID))
  local obj = (Util.ShowUIModel)(fashionConfig.show_texture, (uis.CardLoaderPic).CardLoader)
  ;
  (Util.UpdateShowTextureByConfig)(obj, fashionConfig)
end

CardCommentWindow.OnShown = function(...)
  -- function num : 0_7
end

CardCommentWindow.OnHide = function(...)
  -- function num : 0_8
end

CardCommentWindow.OnClose = function(...)
  -- function num : 0_9 , upvalues : uis, contentPane, argTable
  uis = nil
  contentPane = nil
  argTable = {}
end

CardCommentWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_10 , upvalues : CardCommentWindow
  if msgId == 1 then
    (CardCommentWindow.RefreshList)()
  end
end

return CardCommentWindow

