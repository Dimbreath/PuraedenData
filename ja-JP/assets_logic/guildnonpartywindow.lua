-- params : ...
-- function num : 0 , upvalues : _ENV
require("Guild_ApplyRegisterByName")
local DEFAULT_MEMBER_COUNT_HEXCOLOR = "#56718C"
local GuildNonpartyWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local _listData, _curType = nil, nil
local _applyDic = {}
local _countDownTimer, _notFoundEffect, _lastGuildName = nil, nil, nil
GuildNonpartyWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, GuildNonpartyWindow
  bridgeObj:SetView((WinResConfig.GuildNonpartyWindow).package, (WinResConfig.GuildNonpartyWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetGuild_ApplyRegisterUis(contentPane)
  ;
  (GuildNonpartyWindow.InitTopMenu)()
  ;
  (GuildNonpartyWindow.InitVariable)()
  ;
  (GuildNonpartyWindow.InitText)()
  ;
  (GuildNonpartyWindow.InitList)()
  ;
  (GuildNonpartyWindow.InitButtonEvent)()
  GuideSetDelayShow(contentPane)
end

GuildNonpartyWindow.InitTopMenu = function(...)
  -- function num : 0_1 , upvalues : _ENV, uis
  local m = {}
  m.windowName = (WinResConfig.GuildNonpartyWindow).name
  m.Tip = (PUtil.get)(60000298)
  m.model = uis.AssetStripGrp
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.SHOP_TOKEN}
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

GuildNonpartyWindow.InitVariable = function(...)
  -- function num : 0_2 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.ApplyGrp).QueryBtn).text = (PUtil.get)(60000200)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.ApplyGrp).MyApplyBtn).text = (PUtil.get)(60000201)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.ApplyGrp).RefreshBtn).text = (PUtil.get)(60000202)
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.ApplyGrp).SpeedJoinBtn).text = (PUtil.get)(60000203)
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.ApplyGrp).InputNameTxt).promptText = (PUtil.get)(60000458)
  ;
  ((uis.ApplyBtn):GetChild("NameTxt")).text = (PUtil.get)(60000205)
  ;
  ((uis.RegisterBtn):GetChild("NameTxt")).text = (PUtil.get)(60000206)
  -- DECOMPILER ERROR at PC59: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.RegisterGrp).SureBtn).text = (PUtil.get)(60000216)
end

GuildNonpartyWindow.InitText = function(...)
  -- function num : 0_3 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R0 in 'UnsetPending'

  (((uis.RegisterGrp).GuildNameTxt).inputTextField).RestrictRow = 0
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.RegisterGrp).WordTxt).text = (PUtil.get)(60000317, Const.MAX_NAME_LENGTH)
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.RegisterGrp).GuildNameTxt).promptText = "[color=" .. Const.GrayColor .. "]" .. (PUtil.get)(60000499) .. "[/color]"
end

GuildNonpartyWindow.InitList = function(...)
  -- function num : 0_4 , upvalues : uis, GuildNonpartyWindow
  ((uis.ApplyGrp).ApplyTipsList):SetBeginAnim()
  ;
  ((uis.ApplyGrp).ApplyTipsList):SetVirtual()
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.ApplyGrp).ApplyTipsList).itemRenderer = GuildNonpartyWindow.RefreshGuildItem
end

GuildNonpartyWindow.InitButtonEvent = function(...)
  -- function num : 0_5 , upvalues : uis, GuildNonpartyWindow
  (((uis.ApplyGrp).QueryBtn).onClick):Add(GuildNonpartyWindow.ClickSearchBtn)
  ;
  (((uis.ApplyGrp).MyApplyBtn).onClick):Add(GuildNonpartyWindow.ClickMyApplyBtn)
  ;
  (((uis.ApplyGrp).RefreshBtn).onClick):Add(GuildNonpartyWindow.ClickRefreshBtn)
  ;
  (((uis.ApplyGrp).SpeedJoinBtn).onClick):Add(GuildNonpartyWindow.ClickQuickJoinBtn)
  ;
  (((uis.RegisterGrp).SureBtn).onClick):Add(GuildNonpartyWindow.ClickCreateGuildBtn)
  ;
  (((uis.RegisterGrp).GuildNameTxt).onChanged):Add(GuildNonpartyWindow.OnChangedText)
end

GuildNonpartyWindow.InitEvent = function(...)
  -- function num : 0_6
end

GuildNonpartyWindow.RemoveEvent = function(...)
  -- function num : 0_7
end

GuildNonpartyWindow.OnShown = function(...)
  -- function num : 0_8 , upvalues : GuildNonpartyWindow, _ENV
  (GuildNonpartyWindow.InitEvent)()
  ;
  (GuildNonpartyWindow.Init)()
  ;
  (GuideMgr.PictureTriggerGuide)((WinResConfig.GuildNonpartyWindow).name)
end

GuildNonpartyWindow.OnHide = function(...)
  -- function num : 0_9
end

GuildNonpartyWindow.Init = function(...)
  -- function num : 0_10 , upvalues : GuildNonpartyWindow
  (GuildNonpartyWindow.RefreshGuildList)()
  ;
  (GuildNonpartyWindow.InitCreateGuildCost)()
  ;
  (GuildNonpartyWindow.InitCountDown)()
end

GuildNonpartyWindow.OnClose = function(...)
  -- function num : 0_11 , upvalues : _ENV, GuildNonpartyWindow, uis, _countDownTimer, _notFoundEffect, contentPane, argTable
  (CommonWinMgr.RemoveAssets)((WinResConfig.GuildNonpartyWindow).name)
  ;
  (GuildNonpartyWindow.RemoveEvent)()
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

  GuildData.GuildList = {}
  ;
  (Util.RecycleUIModel)((uis.ApplyGrp).IconLoader, true)
  if _countDownTimer ~= nil then
    _countDownTimer:stop()
  end
  _notFoundEffect = nil
  uis = nil
  contentPane = nil
  argTable = {}
end

GuildNonpartyWindow.OnChangedText = function(...)
  -- function num : 0_12 , upvalues : _ENV, uis, _lastGuildName
  local left = Const.MAX_NAME_LENGTH - (Util.StrUnicodeLength)(((uis.RegisterGrp).GuildNameTxt).text)
  if left >= 0 then
    _lastGuildName = ((uis.RegisterGrp).GuildNameTxt).text
  else
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((uis.RegisterGrp).GuildNameTxt).text = _lastGuildName
  end
end

GuildNonpartyWindow.InitCreateGuildCost = function(...)
  -- function num : 0_13 , upvalues : _ENV, uis
  (Util.SetCurrencyWithConfig)((((TableData.gTable).BaseFixedData)[GuildData.CREATE_GUILD_COST]).array_value, (uis.RegisterGrp).ItmeLoader, (uis.RegisterGrp).SpendNumberTxt)
end

GuildNonpartyWindow.InitCountDown = function(...)
  -- function num : 0_14 , upvalues : _ENV, uis, _countDownTimer
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

  if GuildData.JoinTimeStamp == 0 or GuildData.JoinTimeStamp < (LuaTime.GetTimeStamp)() then
    ((uis.ApplyGrp).Word_01_Txt).text = ""
  else
    local leftTime = GuildData.JoinTimeStamp - (LuaTime.GetTimeStamp)()
    do
      -- DECOMPILER ERROR at PC37: Confused about usage of register: R1 in 'UnsetPending'

      ((uis.ApplyGrp).Word_01_Txt).text = (PUtil.get)(60000290, "[color=" .. Const.GreenColor .. "]" .. (LuaTime.GetTimeWithoutSeondsStr)(leftTime) .. "[/color]")
      local secondTimerFunc = function(...)
    -- function num : 0_14_0 , upvalues : _countDownTimer, _ENV, leftTime, uis
    _countDownTimer = (SimpleTimer.new)(1, -1, function(...)
      -- function num : 0_14_0_0 , upvalues : leftTime, uis, _countDownTimer, _ENV
      leftTime = leftTime - 1
      -- DECOMPILER ERROR at PC8: Confused about usage of register: R0 in 'UnsetPending'

      if leftTime == 0 then
        ((uis.ApplyGrp).Word_01_Txt).text = ""
        _countDownTimer:stop()
      else
        -- DECOMPILER ERROR at PC29: Confused about usage of register: R0 in 'UnsetPending'

        ;
        ((uis.ApplyGrp).Word_01_Txt).text = (PUtil.get)(60000290, "[color=" .. Const.GreenColor .. "]" .. (LuaTime.GetTimeWithoutSeondsStr)(leftTime) .. "[/color]")
      end
    end
)
    _countDownTimer:start()
  end

      if leftTime <= 3600 then
        secondTimerFunc()
      else
        local lastMin = leftTime / 60
        _countDownTimer = (SimpleTimer.new)(1, -1, function(...)
    -- function num : 0_14_1 , upvalues : leftTime, _countDownTimer, secondTimerFunc, lastMin, uis, _ENV
    leftTime = leftTime - 1
    if leftTime <= 3600 then
      _countDownTimer:stop()
      secondTimerFunc()
    else
      -- DECOMPILER ERROR at PC33: Confused about usage of register: R0 in 'UnsetPending'

      if leftTime / 60 ~= lastMin then
        ((uis.ApplyGrp).Word_01_Txt).text = (PUtil.get)(60000290, "[color=" .. Const.GreenColor .. "]" .. (LuaTime.GetTimeWithoutSeondsStr)(leftTime) .. "[/color]")
      end
    end
  end
)
        _countDownTimer:start()
      end
    end
  end
end

GuildNonpartyWindow.RefreshGuildList = function(...)
  -- function num : 0_15 , upvalues : _listData, _ENV, _curType, uis, GuildNonpartyWindow
  _listData = GuildData.GuildList
  _curType = GuildListType.AllGuild
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.ApplyGrp).c1Ctr).selectedIndex = 0
  ;
  (GuildNonpartyWindow.RefreshList)()
end

GuildNonpartyWindow.RefreshSearchList = function(...)
  -- function num : 0_16 , upvalues : _listData, _ENV, _curType, GuildNonpartyWindow, uis, _notFoundEffect
  _listData = GuildData.SearchResultList
  _curType = GuildListType.SearchResult
  ;
  (GuildNonpartyWindow.RefreshList)()
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R0 in 'UnsetPending'

  if #_listData == 0 then
    ((uis.ApplyGrp).c1Ctr).selectedIndex = 1
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((uis.ApplyGrp).TalkWordTxt).text = (PUtil.get)(60000397)
    if _notFoundEffect == nil then
      _notFoundEffect = (Util.SetNotFoundEffect)((uis.ApplyGrp).IconLoader)
    end
  else
    -- DECOMPILER ERROR at PC34: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((uis.ApplyGrp).c1Ctr).selectedIndex = 0
  end
end

GuildNonpartyWindow.RefreshMyApplyList = function(...)
  -- function num : 0_17 , upvalues : _listData, _ENV, _curType, GuildNonpartyWindow, uis, _notFoundEffect
  _listData = GuildData.MyApplyList
  _curType = GuildListType.AppliedGuid
  ;
  (GuildNonpartyWindow.RefreshList)()
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R0 in 'UnsetPending'

  if #_listData == 0 then
    ((uis.ApplyGrp).c1Ctr).selectedIndex = 1
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((uis.ApplyGrp).TalkWordTxt).text = (PUtil.get)(60000398)
    if _notFoundEffect == nil then
      _notFoundEffect = (Util.SetNotFoundEffect)((uis.ApplyGrp).IconLoader)
    end
  else
    -- DECOMPILER ERROR at PC34: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((uis.ApplyGrp).c1Ctr).selectedIndex = 0
  end
end

GuildNonpartyWindow.RefreshList = function(...)
  -- function num : 0_18 , upvalues : _applyDic, _ENV, _listData, uis
  _applyDic = {}
  local count = #GuildData.MyApplyList
  for i = 1, count do
    _applyDic[((GuildData.MyApplyList)[i]).id] = true
  end
  if #_listData > 0 then
    ((uis.ApplyGrp).ApplyTipsList):ScrollToView(0, false)
  end
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.ApplyGrp).ApplyTipsList).numItems = #_listData
end

GuildNonpartyWindow.RefreshGuildItem = function(index, item, ...)
  -- function num : 0_19 , upvalues : _listData, _ENV, GuildNonpartyWindow, _applyDic
  local data = _listData[index + 1]
  ;
  ((item:GetChild("GuildIconGrp")):GetChild("GuildIconLoader")).url = (GuildData.GetGuildIcon)(data.icon)
  ;
  (item:GetChild("GuildLevelTxt")).text = "Lv." .. tostring(data.level)
  ;
  (item:GetChild("GuildNameTxt")).text = data.name
  local maxCount = (((TableData.gTable).BaseGuildLevelUpData)[(GuildData.GuildLevelConfig)[data.level]]).max_member
  local memberText = item:GetChild("MemberTxt")
  if maxCount <= data.memberCount then
    memberText.text = (PUtil.get)(60000260) .. " [color=" .. Const.OrangeColor .. "]" .. tostring(data.memberCount) .. "[/color]/" .. tostring(maxCount)
  else
    memberText.text = (PUtil.get)(60000260) .. " " .. tostring(data.memberCount) .. "/" .. tostring(maxCount)
  end
  ;
  (GuildNonpartyWindow.SetSubItemInfo)(item:GetChild("TipsInfo_01_Grp"), 0, (PUtil.get)(60000208), data.leader)
  ;
  (GuildNonpartyWindow.SetSubItemInfo)(item:GetChild("TipsInfo_03_Grp"), 2, (PUtil.get)(60000209), data.activation)
  ;
  (GuildNonpartyWindow.SetSubItemInfo)(item:GetChild("TipsInfo_04_Grp"), 3, (PUtil.get)(60000210), data.fc)
  if data.joinMinFc == 0 then
    (item:GetController("c1")).selectedIndex = 0
    ;
    (item:GetChild("ConditionTxt")).text = "(" .. (PUtil.get)(60000212) .. ")"
    local btn = item:GetChild("JoinBtn")
    btn.text = (PUtil.get)(60000205)
    ;
    (btn.onClick):Set(function(...)
    -- function num : 0_19_0 , upvalues : _ENV, data
    (GuildMgr.ReqImmediatelyJoin)(data)
  end
)
  else
    do
      if _applyDic[data.id] then
        (item:GetController("c1")).selectedIndex = 1
        local btn = item:GetChild("SureBtn")
        btn.text = (PUtil.get)(60000207)
        ;
        (btn.onClick):Set(function(...)
    -- function num : 0_19_1 , upvalues : _ENV, data
    (GuildService.ReqCancelJoin)(data.id)
  end
)
        ;
        (item:GetChild("ConditionTxt")).text = "[color=" .. Const.GreenColor .. "]" .. (PUtil.get)(60000213, data.joinMinFc) .. "[/color]"
      else
        do
          if (ActorData.GetFc)() < data.joinMinFc then
            (item:GetController("c1")).selectedIndex = 2
            ;
            (item:GetChild("ConditionTxt")).text = "[color=" .. Const.RedColor .. "]" .. (PUtil.get)(60000213, data.joinMinFc) .. "[/color]"
            ;
            (item:GetChild("TipsTxt")).text = (PUtil.get)(60000459)
          else
            ;
            (item:GetChild("ConditionTxt")).text = "[color=" .. Const.GreenColor .. "]" .. (PUtil.get)(60000213, data.joinMinFc) .. "[/color]"
            ;
            (item:GetController("c1")).selectedIndex = 1
            local btn = item:GetChild("SureBtn")
            btn.text = (PUtil.get)(60000204)
            ;
            (btn.onClick):Set(function(...)
    -- function num : 0_19_2 , upvalues : _ENV, data
    (GuildMgr.ReqApplyGuild)(data.id)
  end
)
          end
        end
      end
    end
  end
end

GuildNonpartyWindow.SetSubItemInfo = function(item, index, name, value, ...)
  -- function num : 0_20
  (item:GetChild("NameTxt")).text = name
  ;
  (item:GetChild("WordTxt")).text = value
end

GuildNonpartyWindow.ClickSearchBtn = function(...)
  -- function num : 0_21 , upvalues : _ENV, uis
  (GuildMgr.PreSearchGuild)(((uis.ApplyGrp).InputNameTxt).text)
end

GuildNonpartyWindow.ClickMyApplyBtn = function(...)
  -- function num : 0_22 , upvalues : GuildNonpartyWindow
  (GuildNonpartyWindow.RefreshMyApplyList)()
end

GuildNonpartyWindow.ClickRefreshBtn = function(...)
  -- function num : 0_23 , upvalues : _ENV
  (GuildMgr.ReqGuildList)()
end

GuildNonpartyWindow.ClickQuickJoinBtn = function(...)
  -- function num : 0_24 , upvalues : _ENV
  (GuildMgr.QuickJoinGuild)()
end

GuildNonpartyWindow.ClickCreateGuildBtn = function(...)
  -- function num : 0_25 , upvalues : _ENV, uis
  (GuildMgr.PreCreateGuild)(((uis.RegisterGrp).GuildNameTxt).text)
end

GuildNonpartyWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_26 , upvalues : _ENV, _curType, GuildNonpartyWindow
  if msgId == (WindowMsgEnum.Guild).E_MSG_REFRESH_GUILD_LIST then
    if para and para.Type == GuildListType.AllGuild then
      if _curType == GuildListType.AllGuild and para.Same then
        (MessageMgr.SendCenterTips)((PUtil.get)(60000305))
      else
        ;
        (GuildNonpartyWindow.RefreshGuildList)()
      end
    else
      if para and para.Type == GuildListType.AppliedGuid then
        (GuildNonpartyWindow.RefreshMyApplyList)()
      else
        if para and para.Type == GuildListType.SearchResult then
          (GuildNonpartyWindow.RefreshSearchList)()
        else
          ;
          (GuildNonpartyWindow.RefreshList)()
        end
      end
    end
  else
    if msgId == (WindowMsgEnum.Guild).E_MSG_MY_APPLY_APPROVED then
      (MessageMgr.OpenSoloConfirmWindow)((PUtil.get)(60000295), function(...)
    -- function num : 0_26_0 , upvalues : _ENV
    (GuildMgr.OpenGuildMainUI)()
  end
, (PUtil.get)(60000294), (PUtil.get)(60000072))
    end
  end
end

return GuildNonpartyWindow

