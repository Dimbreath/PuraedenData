-- params : ...
-- function num : 0 , upvalues : _ENV
ActorService = {}
-- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

ActorService.Init = function(...)
  -- function num : 0_0 , upvalues : _ENV
  (Net.AddListener)((Proto.MsgName).ResDetailInfo, ActorService.OnResDetailInfo)
  ;
  (Net.AddListener)((Proto.MsgName).ResGoodsChange, ActorService.OnResGoodsChange)
  ;
  (Net.AddListener)((Proto.MsgName).ResPing, ActorService.OnResPing)
  ;
  (Net.AddListener)((Proto.MsgName).ResGuildId, ActorService.OnResGuildId)
  ;
  (Net.AddListener)((Proto.MsgName).ResPlayerLevelUp, ActorService.OnResPlayerLevelUp)
  ;
  (Net.AddListener)((Proto.MsgName).ResRegisterMail, ActorService.OnResRegisterMail)
  ;
  (Net.AddListener)((Proto.MsgName).ResTitleList, ActorService.OnResTitleList)
  ;
  (Net.AddListener)((Proto.MsgName).ResWearTitle, ActorService.OnResWearTitle)
  ;
  (Net.AddListener)((Proto.MsgName).ResActivityLottery, ActorService.OnResActivityLottery)
end

local needInit = false
-- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

ActorService.ReqDetailInfo = function(...)
  -- function num : 0_1 , upvalues : _ENV, needInit
  local t = {}
  ;
  (Net.Send)((Proto.MsgName).ReqDetailInfo, t, (Proto.MsgName).ResDetailInfo)
  if Net.isReconnectOk == false then
    OpenWindow((WinResConfig.LoadingWindow).name, UILayer.Loading)
  end
  needInit = true
end

-- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

ActorService.OnResDetailInfo = function(msg, ...)
  -- function num : 0_2 , upvalues : _ENV, needInit
  PrintTable(msg, "", "收到玩家数据回应:")
  if needInit == true then
    (ActorData.InitActorData)()
    ;
    (ActorData.InitTempData)()
    needInit = false
  end
  if Game.jumpOverture == true and msg.baseInfo and (msg.baseInfo).level == 3 then
    (Util.SetPlayerSetting)(PlayerPrefsKeyName.GUIDE_OPEN, 0)
    ;
    (LoginService.OnReqSendChar)("gm,addExp,100000")
    ;
    (LoginService.OnReqSendChar)("gm,addAsset,21100003,100000000")
    ;
    (LoginService.OnReqSendChar)("gm,addAsset,21100001,10000000")
    ;
    (LoginService.OnReqSendChar)("gm,addAsset,21100002,10000000")
    local cardConfig = (TableData.gTable).BaseCardData
    local str = ""
    for _,v in pairs(cardConfig) do
      str = str .. ":" .. "gm,addCard," .. v.id
    end
    ;
    (LoginService.OnReqSendChar)(str)
    ;
    (LoginService.OnReqSendChar)("gm,unlockChapter,52100301")
    UIMgr:CloseWindow("LoadingWindow")
    ;
    (LoginMgr.ReturnToLoginWindow)()
    return 
  end
  do
    local callBack = function(...)
    -- function num : 0_2_0 , upvalues : _ENV
    local callBack1 = function(...)
      -- function num : 0_2_0_0 , upvalues : _ENV
      ld("Home", function(...)
        -- function num : 0_2_0_0_0 , upvalues : _ENV
        (HomeMgr.PreLoadCardSpine)(true)
        ;
        (RedDotMgr.InitRedDotData)()
        ;
        (EquiptMgr.InitEquiptMainRedDot)()
        ;
        (Game.SetMainFramerate)()
        ld("Announcement", function(...)
          -- function num : 0_2_0_0_0_0 , upvalues : _ENV
          (AnnouncementMgr.InitAnnouncementRedDot)()
        end
)
        ;
        (ActorMgr.ReqEnterInfo)()
      end
)
    end

    -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

    if Net.isReconnectOk == true and OvertureMgr.isPlaying ~= true then
      Net.isReconnectOk = false
      ;
      (ActorMgr.RefreshAfterReconnect)()
      local ResendPak = require("ResendPak")
      ;
      (ResendPak.Resend)()
    else
      do
        -- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

        OvertureMgr.isPlaying = false
        -- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'

        Net.isReconnectOk = false
        local name = (WinResConfig.LoadingWindow).name
        if UIMgr:IsWindowOpen(name) == false then
          UIMgr:SetOnShownComplete(name, function(...)
      -- function num : 0_2_0_1 , upvalues : callBack1
      callBack1()
    end
)
          OpenWindow(name, UILayer.Loading)
        else
          callBack1()
        end
      end
    end
  end

    ;
    (ActorData.SaveActorData)(msg, callBack)
    ;
    (ActorMgr.InitHeartMessageUpdate)()
    if Game.jumpOverture == true and Game.jumpNewHand == true then
      (LoginService.OnReqSendChar)("gm,funcOpen,1")
    end
  end
end

-- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

ActorService.OnInitDirtyWordData = function(...)
  -- function num : 0_3 , upvalues : _ENV
  local WordData = (TableData.gTable).BaseDirtyWordData
  local DirtyWordChecker = (CS.DirtyWordChecker).Singleton
  for _,v in pairs(WordData) do
    if not (Util.StringIsNullOrEmpty)(v.name) then
      DirtyWordChecker:AddBadWord(v.name)
    end
  end
end

local ShowTeamFc = true
-- DECOMPILER ERROR at PC18: Confused about usage of register: R2 in 'UnsetPending'

ActorService.SetShowTeamFcChange = function(show, ...)
  -- function num : 0_4 , upvalues : ShowTeamFc
  ShowTeamFc = show
end

-- DECOMPILER ERROR at PC21: Confused about usage of register: R2 in 'UnsetPending'

ActorService.OnResGoodsChange = function(msg, ...)
  -- function num : 0_5 , upvalues : _ENV, ShowTeamFc
  PrintTable(msg, "", "收到物品更新消息:")
  local count = #msg.goods
  for i = 1, count do
    (Util.ShowGuideTips)(GuideTipsCheckPoint.MergeItem, (msg.goods)[i])
  end
  local fcChange = (ActorData.ChangeActorData)(msg)
  local card, asset = (ActorService.IsChangeCardOrAssets)(msg.goods)
  if not card or asset then
    (CommonWinMgr.RefreshAssets)()
    UIMgr:SendWindowMessage((WinResConfig.ClearingWindow).name, (WindowMsgEnum.ClearingWindow).E_MSG_PHYSICAL_REFRESH)
  end
  if #msg.goods > 0 then
    if (ActorService.IsContainLottery)(msg.goods) then
      (CommonWinMgr.RefreshAssets)()
    end
    if UIMgr:IsWindowOpen((WinResConfig.HandBookIntimacyWindow).name) and (ActorService.IsContainIntimacyItem)(msg.goods) then
      UIMgr:SendWindowMessage((WinResConfig.HandBookIntimacyWindow).name, (WindowMsgEnum.HandBookIntimacyWindow).REFRESH_INTIMACY_ITEM)
    end
    if UIMgr:IsWindowOpen((WinResConfig.BagWindow).name) then
      UIMgr:SendWindowMessage((WinResConfig.BagWindow).name, (WindowMsgEnum.BagWindow).E_MSG_BAG_REFRESH)
    end
    UIMgr:SendWindowMessage((WinResConfig.AdventureGameWindow).name, (WindowMsgEnum.Adventure).E_MSG_REFRESH_CTRL_REDDOT)
  end
  ;
  (EquiptMgr.AcquireEquipments)(msg.equip)
  ;
  (EquiptMgr.LoseEquipments)(msg.delEquipIndex)
  if NeedShowGetGoodsMsg[msg.reqMsgId] ~= nil then
    if msg.reqMsgId == (Proto.MsgIdByName).ReqGetMailAnnex or msg.reqMsgId == (Proto.MsgIdByName).ReqPaySuccess or msg.reqMsgId == SpecialGoodsID.Gift_Code then
      (ActorService.OtherWayToGetCardShow)(msg.goods, function(...)
    -- function num : 0_5_0 , upvalues : _ENV, msg
    (MessageMgr.ShowGetGoods)(msg.goods, msg.equip)
  end
)
    else
      if msg.reqMsgId == (Proto.MsgIdByName).ReqSlotsOperation then
        UIMgr:SendWindowMessage((WinResConfig.ActivityDungeonExchangeWindow).name, (WindowMsgEnum.ActivityDungeonExchange).E_MSG_SHOW_RESULT, {msg.goods, msg.equip})
      else
        ;
        (MessageMgr.ShowGetGoods)(msg.goods, msg.equip)
      end
    end
  else
    if NeedShowPromptMsg[msg.reqMsgId] ~= nil then
      local goods = {}
      for _,v in ipairs(msg.goods) do
        if v.value > 0 then
          local item = {}
          item.id = v.id
          item.Num = v.value
          ;
          (table.insert)(goods, item)
        end
      end
      ;
      (MessageMgr.OpenItemBuyTipsWindow)(goods)
      local equips = {}
      for _,v in ipairs(msg.equip) do
        local item = {}
        item.id = v.id
        item.Num = 1
        ;
        (table.insert)(equips, item)
      end
      ;
      (MessageMgr.OpenItemBuyTipsWindow)(equips)
    end
  end
  do
    if FCChangeMsg[msg.reqMsgId] ~= nil and fcChange and ShowTeamFc then
      if card or UIMgr:IsWindowOpen((WinResConfig.PiceGetShowWindow).name) then
        UIMgr:SetOnShownComplete((WinResConfig.CardListWindow).name, function(...)
    -- function num : 0_5_1 , upvalues : _ENV
    (CommonWinMgr.OpenCommonFcUp)()
  end
)
      else
        ;
        (CommonWinMgr.OpenCommonFcUp)()
      end
    end
    UIMgr:SendWindowMessage((WinResConfig.StarDebrisChangeGrpWindow).name, (WindowMsgEnum.CardWindow).E_MSG_CARD_AFTER_EXCHANGE)
    UIMgr:SendWindowMessage((WinResConfig.GetWayWindow).name, (WindowMsgEnum.CardWindow).E_MSG_CARD_AFTER_EXCHANGE)
    UIMgr:SendWindowMessage((WinResConfig.CardWindow).name, (WindowMsgEnum.CardWindow).E_MSG_CARD_AFTER_EXCHANGE)
  end
end

-- DECOMPILER ERROR at PC24: Confused about usage of register: R2 in 'UnsetPending'

ActorService.OtherWayToGetCardShow = function(goods, callback, ...)
  -- function num : 0_6 , upvalues : _ENV
  local cards = {}
  for index,value in ipairs(goods) do
    if value.value ~= 0 then
      do
        local isHave = value.type ~= PropType.CARD
        ;
        (table.insert)(cards, {id = value.id, isHave = isHave, picesNum = value.value})
        -- DECOMPILER ERROR at PC25: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC25: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  if #cards > 0 then
    OpenWindow("PiceGetShowWindow", UILayer.HUD, nil, nil, cards, callback)
  else
    callback()
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC27: Confused about usage of register: R2 in 'UnsetPending'

ActorService.IsContainLottery = function(Goods, ...)
  -- function num : 0_7 , upvalues : _ENV
  for _,v in pairs(Goods) do
    if (Util.IsInParticularAssetConfig)(v.id) then
      return true
    end
  end
  return false
end

-- DECOMPILER ERROR at PC30: Confused about usage of register: R2 in 'UnsetPending'

ActorService.IsContainIntimacyItem = function(Goods, ...)
  -- function num : 0_8 , upvalues : _ENV
  local ConsumeIds = Const.IntimacyItemIDs
  local items = split(ConsumeIds, ":")
  for _,v in pairs(Goods) do
    for _,v2 in ipairs(items) do
      if tonumber(v.id) == tonumber(v2) then
        return true
      end
    end
  end
  return false
end

-- DECOMPILER ERROR at PC33: Confused about usage of register: R2 in 'UnsetPending'

ActorService.System_ReqPing = function(...)
  -- function num : 0_9 , upvalues : _ENV
  local t = {account = (LoginMgr.GetAccount)()}
  ;
  (Net.Send)((Proto.MsgName).ReqPing, t, (Proto.MsgName).ResPing)
end

-- DECOMPILER ERROR at PC36: Confused about usage of register: R2 in 'UnsetPending'

ActorService.OnResPing = function(msg, ...)
  -- function num : 0_10 , upvalues : _ENV
  PrintTable(msg, "心跳包消息:")
  local currentTime = msg.currentTime
  ;
  (ActorData.SetServerTime)(currentTime)
  if Game.useSDK == true then
    if LoginService.isRegister == true then
      (SuperSDKMgr.SendEnterGame)()
      ;
      (SuperSDKMgr.SendCreateRole)()
      ;
      (SuperSDKUtil.SendAdCreateRole)()
      ;
      (SuperSDKUtil.SendAdCharactorComplete)()
    else
      if LoginService.isRegister == false and (Util.StringIsNullOrEmpty)((ActorData.GetPlayerIndex)()) == false then
        (SuperSDKMgr.SendEnterGame)()
      end
    end
  end
  -- DECOMPILER ERROR at PC46: Confused about usage of register: R2 in 'UnsetPending'

  LoginService.isRegister = nil
end

-- DECOMPILER ERROR at PC39: Confused about usage of register: R2 in 'UnsetPending'

ActorService.IsChangeCardOrAssets = function(msg, ...)
  -- function num : 0_11 , upvalues : _ENV
  local card = false
  local assets = false
  for _,v in ipairs(msg) do
    if v.type == (ProtoEnum.E_GOODS_TYPE).CARD then
      card = true
    else
      if v.type == (ProtoEnum.E_GOODS_TYPE).ASSET then
        assets = true
      end
    end
  end
  return card, assets
end

-- DECOMPILER ERROR at PC42: Confused about usage of register: R2 in 'UnsetPending'

ActorService.OnResGuildId = function(msg, ...)
  -- function num : 0_12 , upvalues : _ENV
  (ActorData.SetGuildID)(msg.id, true)
end

-- DECOMPILER ERROR at PC45: Confused about usage of register: R2 in 'UnsetPending'

ActorService.OnResPlayerLevelUp = function(msg, ...)
  -- function num : 0_13 , upvalues : _ENV
  loge("收到角色升级" .. msg.newLevel)
  ;
  (Util.OpenPlayerLevelUpWindow)()
end

-- DECOMPILER ERROR at PC48: Confused about usage of register: R2 in 'UnsetPending'

ActorService.RegisterMail = function(id, ...)
  -- function num : 0_14 , upvalues : _ENV
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  if id ~= nil then
    ActorService.TenMailID = id
  else
    return ActorService.TenMailID or 0
  end
end

-- DECOMPILER ERROR at PC51: Confused about usage of register: R2 in 'UnsetPending'

ActorService.OnResRegisterMail = function(msg, ...)
  -- function num : 0_15 , upvalues : _ENV
  (ActorService.RegisterMail)(msg.id)
end

-- DECOMPILER ERROR at PC54: Confused about usage of register: R2 in 'UnsetPending'

ActorService.ReqHorseSet = function(isOpen, ...)
  -- function num : 0_16 , upvalues : _ENV
  local m = {}
  m.open = isOpen
  ;
  (Net.Send)((Proto.MsgName).ReqHorseSet, m)
end

-- DECOMPILER ERROR at PC57: Confused about usage of register: R2 in 'UnsetPending'

ActorService.ReqTitleList = function(...)
  -- function num : 0_17 , upvalues : _ENV
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqTitleList, m, (Proto.MsgName).ResTitleList)
end

-- DECOMPILER ERROR at PC60: Confused about usage of register: R2 in 'UnsetPending'

ActorService.OnResTitleList = function(msg, ...)
  -- function num : 0_18 , upvalues : _ENV
  (ActorData.TitleListData)(msg.titleInfo)
end

-- DECOMPILER ERROR at PC63: Confused about usage of register: R2 in 'UnsetPending'

ActorService.ReqWearTitle = function(titleID, ...)
  -- function num : 0_19 , upvalues : _ENV
  local m = {}
  m.titleId = titleID
  ;
  (Net.Send)((Proto.MsgName).ReqWearTitle, m, (Proto.MsgName).ResWearTitle)
end

-- DECOMPILER ERROR at PC66: Confused about usage of register: R2 in 'UnsetPending'

ActorService.OnResWearTitle = function(msg, ...)
  -- function num : 0_20 , upvalues : _ENV
  (ActorData.SetWearTitle)(msg.titleId)
  UIMgr:SendWindowMessage((WinResConfig.TitleWindow).name, (WindowMsgEnum.Title).E_MSG_REFRESH)
end

-- DECOMPILER ERROR at PC69: Confused about usage of register: R2 in 'UnsetPending'

ActorService.ReqActivityLottery = function(...)
  -- function num : 0_21 , upvalues : _ENV
  local m = {}
  ;
  (Net.Send)((Proto.MsgName).ReqActivityLottery, m, (Proto.MsgName).ResActivityLottery)
  print("请求有哪些活动扭蛋")
end

-- DECOMPILER ERROR at PC72: Confused about usage of register: R2 in 'UnsetPending'

ActorService.OnResActivityLottery = function(msg, ...)
  -- function num : 0_22 , upvalues : _ENV
  print("返回有哪些活动扭蛋")
  ;
  (ActorData.SaveLotteryActivityData)(msg.otherLottery)
  ld("Lottery", function(...)
    -- function num : 0_22_0 , upvalues : _ENV
    OpenWindow((WinResConfig.LotteryWindow).name, UILayer.HUD)
  end
)
end

;
(ActorService.Init)()

