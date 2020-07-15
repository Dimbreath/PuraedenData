-- params : ...
-- function num : 0 , upvalues : _ENV
CardService = {}
-- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

CardService.Init = function(...)
  -- function num : 0_0 , upvalues : _ENV
  (Net.AddListener)((Proto.MsgName).ResLevelUp, CardService.OnResLevelUp)
  ;
  (Net.AddListener)((Proto.MsgName).ResUseProp, CardService.ResUseProp)
  ;
  (Net.AddListener)((Proto.MsgName).ResQualityUp, CardService.ResQualityUp)
  ;
  (Net.AddListener)((Proto.MsgName).ResUpdateInfo, CardService.OnResUpdateInfo)
  ;
  (Net.AddListener)((Proto.MsgName).ResSkillUp, CardService.ResSkillUp)
  ;
  (Net.AddListener)((Proto.MsgName).ResGoodsChange, CardService.onResGoodChange)
  ;
  (Net.AddListener)((Proto.MsgName).ResStarUp, CardService.RecvStarUp)
  ;
  (Net.AddListener)((Proto.MsgName).ResSetFashion, CardService.ResSetFashion)
  ;
  (Net.AddListener)((Proto.MsgName).ResExchangeDebris, CardService.RecvExchangeDebris)
  ;
  (Net.AddListener)((Proto.MsgName).ResSetMainCover, CardService.OnResSetMainCover)
  ;
  (Net.AddListener)((Proto.MsgName).ResGetCardChat, CardService.OnResGetCardChat)
  ;
  (Net.AddListener)((Proto.MsgName).ResClickLike, CardService.OnResClickLike)
  ;
  (Net.AddListener)((Proto.MsgName).ResGetLikeCard, CardService.OnResGetLikeCard)
  ;
  (Net.AddListener)((Proto.MsgName).ResSetLikeCard, CardService.OnResSetLikeCard)
  ;
  (Net.AddListener)((Proto.MsgName).ResMyClickLikeRemark, CardService.OnResMyClickLikeRemark)
end

-- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

CardService.OnResUpdateInfo = function(msg, ...)
  -- function num : 0_1 , upvalues : _ENV
  PrintTable(msg, "卡片数据更新：")
  local levelInfo = msg.levelInfo
  for i,v in ipairs(levelInfo) do
    (CardData.UpdateCardLevelInfo)(v)
  end
end

-- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

CardService.ReqLevelUp = function(id, num, ...)
  -- function num : 0_2 , upvalues : _ENV
  print("请求升级卡片 卡片ID", id, "数量", num)
  local send = {id = id, num = num}
  ;
  (Net.Send)((Proto.MsgName).ReqLevelUp, send, (Proto.MsgName).ResLevelUp)
end

-- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

CardService.onResGoodChange = function(...)
  -- function num : 0_3 , upvalues : _ENV
  UIMgr:SendWindowMessage("CardWindow", (WindowMsgEnum.CardWindow).E_MSG_CARD_GOODCHANGE, {})
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

CardService.OnResLevelUp = function(msg, ...)
  -- function num : 0_4 , upvalues : _ENV
  print("请求升级卡片等级 消息回调", msg.level, msg.exp)
  ;
  (CardData.SetCardDataLevel)(msg.id, msg.level)
  ;
  (CardData.SetCardDataExp)(msg.id, msg.exp)
  UIMgr:SendWindowMessage("CardWindow", (WindowMsgEnum.CardWindow).E_MSG_CARD_LEVELUP, {id = msg.id, level = msg.level, exp = msg.exp, totalExp = msg.totalExp})
  ;
  (CommonWinMgr.OpenCommonFcUp)(msg.id)
end

-- DECOMPILER ERROR at PC19: Confused about usage of register: R0 in 'UnsetPending'

CardService.ReqUseProp = function(cardId, propid, count, type, ...)
  -- function num : 0_5 , upvalues : _ENV
  print("请求使用道具", cardId, propid, count, type)
  local m = {}
  m.propIndex = propid
  m.count = count
  m.cardId = cardId
  m.useType = type
  if type == UsePropScene.CardLevelUp then
    (Net.Send)((Proto.MsgName).ReqUseProp, m, (Proto.MsgName).ResLevelUp)
    ;
    (ActorService.SetShowTeamFcChange)(false)
  else
    if type == UsePropScene.PiceToCard then
      (Net.Send)((Proto.MsgName).ReqUseProp, m, (Proto.MsgName).ResUseProp)
    else
      ;
      (Net.Send)((Proto.MsgName).ReqUseProp, m)
    end
  end
end

-- DECOMPILER ERROR at PC22: Confused about usage of register: R0 in 'UnsetPending'

CardService.ResUseProp = function(msg, ...)
  -- function num : 0_6 , upvalues : _ENV
  if msg.useType == UsePropScene.PiceToCard then
    UIMgr:SendWindowMessage("CardListWindow", (WindowMsgEnum.CardWindow).E_MSG_CARD_PICE_TO_CARD, {cardId = msg.cardId})
  end
  if msg.useType == UsePropScene.HandBookToCard then
    UIMgr:SendWindowMessage("HandBookRelationWindow", (WindowMsgEnum.HandBookIntimacyWindow).E_MSG_CARD_PICE_TO_CARD, {cardId = msg.cardId})
  end
end

-- DECOMPILER ERROR at PC25: Confused about usage of register: R0 in 'UnsetPending'

CardService.ReqQualityUp = function(id, num, ...)
  -- function num : 0_7 , upvalues : _ENV
  print("请求升品卡片 卡片ID", id, "数量", num)
  local send = {id = id, num = num}
  ;
  (Net.Send)((Proto.MsgName).ReqQualityUp, send, (Proto.MsgName).ResQualityUp)
end

-- DECOMPILER ERROR at PC28: Confused about usage of register: R0 in 'UnsetPending'

CardService.ResQualityUp = function(msg, ...)
  -- function num : 0_8 , upvalues : _ENV
  print("请求升级卡片品质 消息回调", msg.id, msg.quality)
  ;
  (CardData.SetCardDataQuality)(msg.id, msg.quality)
  ;
  (HandBookData.CheckFetterData)()
  if (HandBookData.GetCanActiveBySingleCardId)(msg.id) then
    (Util.ShowGuideTips)(GuideTipsCheckPoint.UnlockNewFetter)
  end
  UIMgr:SendWindowMessage("CardWindow", (WindowMsgEnum.CardWindow).E_MSG_CARD_STAGEUP, {id = msg.id, quality = msg.quality})
end

-- DECOMPILER ERROR at PC31: Confused about usage of register: R0 in 'UnsetPending'

CardService.OnReqSkillUp = function(id, skillID, num, skillData, ...)
  -- function num : 0_9 , upvalues : _ENV
  if not skillData then
    local send = {id = id, skillId = skillID or 0, num = num or 0, 
skillData = {}
}
    ;
    (Net.Send)((Proto.MsgName).ReqSkillUp, send, (Proto.MsgName).ResSkillUp)
  end
end

-- DECOMPILER ERROR at PC34: Confused about usage of register: R0 in 'UnsetPending'

CardService.ResSkillUp = function(msg, ...)
  -- function num : 0_10 , upvalues : _ENV
  print("请求升级卡片技能升级 消息回调", msg.id)
  ;
  (CardData.SaveUpSkills)(msg.id, msg.skill)
  UIMgr:SendWindowMessage("CardWindow", (WindowMsgEnum.CardWindow).E_MSG_CARD_SKILLUP, {id = msg.id, skill = msg.skill})
  ;
  (CommonWinMgr.OpenCommonFcUp)(msg.id)
end

-- DECOMPILER ERROR at PC37: Confused about usage of register: R0 in 'UnsetPending'

CardService.ReqStarUp = function(id, ...)
  -- function num : 0_11 , upvalues : _ENV
  local m = {}
  m.id = id
  ;
  (Net.Send)((Proto.MsgName).ReqStarUp, m, (Proto.MsgName).ResStarUp)
end

-- DECOMPILER ERROR at PC40: Confused about usage of register: R0 in 'UnsetPending'

CardService.RecvStarUp = function(msg, ...)
  -- function num : 0_12 , upvalues : _ENV
  local oldData = (CardData.UpdateCardStarInfo)(msg.id, msg.star)
  ;
  (HandBookData.CheckFetterData)()
  if (HandBookData.GetCanActiveBySingleCardId)(msg.id) then
    (Util.ShowGuideTips)(GuideTipsCheckPoint.UnlockNewFetter)
  end
  UIMgr:SendWindowMessage((WinResConfig.CardWindow).name, (WindowMsgEnum.CardWindow).E_MSG_CARD_STARUP, function(...)
    -- function num : 0_12_0 , upvalues : _ENV, oldData
    OpenWindow((WinResConfig.StarUpPropertyWindow).name, UILayer.HUD, oldData, CardData.CurrentCardInfo)
  end
)
end

-- DECOMPILER ERROR at PC43: Confused about usage of register: R0 in 'UnsetPending'

CardService.ReqSetFashion = function(cardID, fashionID, ...)
  -- function num : 0_13 , upvalues : _ENV
  print("请求更换立绘", cardID, fashionID)
  local send = {}
  send.cardId = cardID
  send.fashionId = fashionID
  ;
  (Net.Send)((Proto.MsgName).ReqSetFashion, send, (Proto.MsgName).ResSetFashion)
end

-- DECOMPILER ERROR at PC46: Confused about usage of register: R0 in 'UnsetPending'

CardService.ResSetFashion = function(msg, ...)
  -- function num : 0_14 , upvalues : _ENV
  print("请求更换立绘  消息回调", msg.cardId, msg.fashionId)
  UIMgr:SendWindowMessage("CardChoiceWindow", (WindowMsgEnum.CardWindow).E_MSG_CARD_SETFASHIONID, {cardId = msg.cardId, fashionId = msg.fashionId})
  UIMgr:SendWindowMessage("NewCardGetWindow", (WindowMsgEnum.CardWindow).E_MSG_CARD_SETFASHIONID, {cardId = msg.cardId, fashionId = msg.fashionId})
end

-- DECOMPILER ERROR at PC49: Confused about usage of register: R0 in 'UnsetPending'

CardService.ReqExchangeDebris = function(goodsIndex, count, debrisId, ...)
  -- function num : 0_15 , upvalues : _ENV
  local m = {}
  m.goodsIndex = goodsIndex
  m.count = count
  m.debrisId = debrisId
  ;
  (Net.Send)((Proto.MsgName).ReqExchangeDebris, m, (Proto.MsgIdByName).ResExchangeDebris)
  ;
  (MessageMgr.OpenItemBuyTipsWindow)({
{id = debrisId, Num = count}
})
end

-- DECOMPILER ERROR at PC52: Confused about usage of register: R0 in 'UnsetPending'

CardService.RecvExchangeDebris = function(msg, ...)
  -- function num : 0_16
end

-- DECOMPILER ERROR at PC55: Confused about usage of register: R0 in 'UnsetPending'

CardService.ReqSetMainCover = function(fashionId, ...)
  -- function num : 0_17 , upvalues : _ENV
  local m = {fashionId = fashionId}
  ;
  (Net.Send)((Proto.MsgName).ReqSetMainCover, m, (Proto.MsgName).ResSetMainCover)
end

-- DECOMPILER ERROR at PC58: Confused about usage of register: R0 in 'UnsetPending'

CardService.OnResSetMainCover = function(msg, ...)
  -- function num : 0_18 , upvalues : _ENV
  if msg.fashionId ~= nil then
    (ActorData.SetFashionShow)(msg.fashionId)
  end
  UIMgr:SendWindowMessage("CardChoiceWindow", (WindowMsgEnum.CardWindow).E_MSG_CARD_SETMAINFASHION, {})
end

-- DECOMPILER ERROR at PC61: Confused about usage of register: R0 in 'UnsetPending'

CardService.ReqGetCardChat = function(cardId, page, ...)
  -- function num : 0_19 , upvalues : _ENV
  (CardService.ReqMyClickLikeRemark)(cardId)
  local m = {}
  m.cardId = cardId
  m.paging = page
  ;
  (Net.Send)((Proto.MsgName).ReqGetCardChat, m, (Proto.MsgName).ResGetCardChat)
end

-- DECOMPILER ERROR at PC64: Confused about usage of register: R0 in 'UnsetPending'

CardService.OnResGetCardChat = function(msg, ...)
  -- function num : 0_20 , upvalues : _ENV
  (CardMgr.InitCommentContent)(msg)
end

-- DECOMPILER ERROR at PC67: Confused about usage of register: R0 in 'UnsetPending'

CardService.ReqClickLike = function(cardID, chatID, ...)
  -- function num : 0_21 , upvalues : _ENV
  local m = {}
  m.cardId = cardID
  m.chatId = chatID
  ;
  (Net.Send)((Proto.MsgName).ReqClickLike, m, (Proto.MsgName).ResClickLike)
end

-- DECOMPILER ERROR at PC70: Confused about usage of register: R0 in 'UnsetPending'

CardService.OnResClickLike = function(msg, ...)
  -- function num : 0_22 , upvalues : _ENV
  (CardMgr.ModifyComment)(msg.chatData)
  ;
  (CardMgr.AddPraiseToList)((msg.chatData).chatId)
end

-- DECOMPILER ERROR at PC73: Confused about usage of register: R0 in 'UnsetPending'

CardService.ReqGetLikeCard = function(...)
  -- function num : 0_23 , upvalues : _ENV
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqGetLikeCard, m, (Proto.MsgName).ResGetLikeCard)
end

-- DECOMPILER ERROR at PC76: Confused about usage of register: R0 in 'UnsetPending'

CardService.OnResGetLikeCard = function(msg, ...)
  -- function num : 0_24 , upvalues : _ENV
  for _,v in ipairs(msg.cardIds) do
    (CardMgr.SetLikeCardList)(v, (CardMgr.CardCommentState).Like)
  end
end

-- DECOMPILER ERROR at PC79: Confused about usage of register: R0 in 'UnsetPending'

CardService.ReqSetLikeCard = function(cardID, type, ...)
  -- function num : 0_25 , upvalues : _ENV
  local m = {}
  m.cardId = cardID
  m.type = type
  ;
  (Net.Send)((Proto.MsgName).ReqSetLikeCard, m, (Proto.MsgName).ResSetLikeCard)
end

-- DECOMPILER ERROR at PC82: Confused about usage of register: R0 in 'UnsetPending'

CardService.OnResSetLikeCard = function(msg, ...)
  -- function num : 0_26 , upvalues : _ENV
  (CardMgr.SetLikeCardList)(msg.cardId, msg.type)
end

-- DECOMPILER ERROR at PC85: Confused about usage of register: R0 in 'UnsetPending'

CardService.ReqMyClickLikeRemark = function(cardID, ...)
  -- function num : 0_27 , upvalues : _ENV
  local m = {}
  m.cardId = cardID
  ;
  (Net.Send)((Proto.MsgName).ReqMyClickLikeRemark, m, (Proto.MsgName).ResMyClickLikeRemark)
end

-- DECOMPILER ERROR at PC88: Confused about usage of register: R0 in 'UnsetPending'

CardService.OnResMyClickLikeRemark = function(msg, ...)
  -- function num : 0_28 , upvalues : _ENV
  (CardMgr.SetCardPraiseList)(msg.remarkId)
end

;
(CardService.Init)()

