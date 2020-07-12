-- params : ...
-- function num : 0 , upvalues : _ENV
require("Guild_GuildManageByName")
local GuildDetailWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local _noOneEffect, _listPos = nil, nil
GuildDetailWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, GuildDetailWindow
  bridgeObj:SetView((WinResConfig.GuildDetailWindow).package, (WinResConfig.GuildDetailWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetGuild_GuildManageUis(contentPane)
  ;
  (GuildDetailWindow.InitTopMenu)()
  ;
  (GuildDetailWindow.InitVariable)()
  ;
  (GuildDetailWindow.InitText)()
  ;
  (GuildDetailWindow.InitList)()
  ;
  (GuildDetailWindow.InitButtonEvent)()
  ;
  (RedDotMgr.BindingUI)((WinResConfig.GuildDetailWindow).name, RedDotComID.Guild_Detail_Apply, (uis.GuildManageContentGrp).InspectBtn)
  ;
  (RedDotMgr.RefreshTreeUI)((WinResConfig.GuildDetailWindow).name)
end

GuildDetailWindow.InitTopMenu = function(...)
  -- function num : 0_1 , upvalues : _ENV, uis
  local m = {}
  m.windowName = (WinResConfig.GuildDetailWindow).name
  m.Tip = (PUtil.get)(60000266)
  m.model = uis.AssetStripGrp
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.SHOP_TOKEN}
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

GuildDetailWindow.InitVariable = function(...)
  -- function num : 0_2
end

GuildDetailWindow.InitText = function(...)
  -- function num : 0_3 , upvalues : uis, _ENV
  (((uis.GuildManageContentGrp).JournalBtn):GetChild("NameTxt")).text = (PUtil.get)(60000267)
  ;
  (((uis.GuildManageContentGrp).MemberBtn):GetChild("NameTxt")).text = (PUtil.get)(60000268)
  ;
  (((uis.GuildManageContentGrp).InspectBtn):GetChild("NameTxt")).text = (PUtil.get)(60000269)
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.GuildManageContentGrp).JournalGrp).Word_01_Txt).text = (PUtil.get)(60000277)
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.GuildManageContentGrp).JournalGrp).Word_02_Txt).text = (PUtil.get)(60000278)
  -- DECOMPILER ERROR at PC53: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.GuildManageContentGrp).JournalGrp).Word_03_Txt).text = (PUtil.get)(60000279)
  -- DECOMPILER ERROR at PC61: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.GuildManageContentGrp).JournalGrp).Choice_01_Txt).text = (PUtil.get)(60000212)
  -- DECOMPILER ERROR at PC69: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.GuildManageContentGrp).JournalGrp).Choice_02_Txt).text = (PUtil.get)(7)
  -- DECOMPILER ERROR at PC77: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.GuildManageContentGrp).InspectGrp).AllNoBtn).text = (PUtil.get)(60000284)
  -- DECOMPILER ERROR at PC85: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.GuildManageContentGrp).InspectGrp).AllYesBtn).text = (PUtil.get)(60000285)
end

GuildDetailWindow.InitList = function(...)
  -- function num : 0_4 , upvalues : uis, GuildDetailWindow
  (((uis.GuildManageContentGrp).JournalGrp).JournalWordList):SetVirtual()
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.GuildManageContentGrp).JournalGrp).JournalWordList).itemRenderer = GuildDetailWindow.RefreshLogItem
  ;
  (((uis.GuildManageContentGrp).MemberGrp).MemberTipsList):SetBeginAnim()
  ;
  (((uis.GuildManageContentGrp).MemberGrp).MemberTipsList):SetVirtual()
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.GuildManageContentGrp).MemberGrp).MemberTipsList).itemRenderer = GuildDetailWindow.RefreshMemberItem
  ;
  (((uis.GuildManageContentGrp).InspectGrp).InspectTipsList):SetBeginAnim()
  ;
  (((uis.GuildManageContentGrp).InspectGrp).InspectTipsList):SetVirtual()
  -- DECOMPILER ERROR at PC39: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.GuildManageContentGrp).InspectGrp).InspectTipsList).itemRenderer = GuildDetailWindow.RefreshApplyItem
end

GuildDetailWindow.InitButtonEvent = function(...)
  -- function num : 0_5 , upvalues : uis, GuildDetailWindow
  (((uis.GuildManageContentGrp).JournalBtn).onClick):Add(GuildDetailWindow.ClickLogBtn)
  ;
  (((uis.GuildManageContentGrp).MemberBtn).onClick):Add(GuildDetailWindow.ClickMemberBtn)
  ;
  (((uis.GuildManageContentGrp).InspectBtn).onClick):Add(GuildDetailWindow.ClickApplyBtn)
  ;
  ((((uis.GuildManageContentGrp).JournalGrp).BattleTxt).onChanged):Add(GuildDetailWindow.CheckConditionMaxValue)
  ;
  ((((uis.GuildManageContentGrp).JournalGrp).BattleTxt).onFocusOut):Add(GuildDetailWindow.ChangeCondition)
  ;
  ((((uis.GuildManageContentGrp).JournalGrp).Choice_01_Btn).onClick):Add(GuildDetailWindow.ClickFreeJoinBtn)
  ;
  ((((uis.GuildManageContentGrp).JournalGrp).Choice_02_Btn).onClick):Add(GuildDetailWindow.ClickLimitJoinBtn)
  ;
  ((((uis.GuildManageContentGrp).InspectGrp).AllNoBtn).onClick):Add(GuildDetailWindow.ClickAllRejectBtn)
  ;
  ((((uis.GuildManageContentGrp).InspectGrp).AllYesBtn).onClick):Add(GuildDetailWindow.ClickAllApproveBtn)
end

GuildDetailWindow.InitEvent = function(...)
  -- function num : 0_6
end

GuildDetailWindow.RemoveEvent = function(...)
  -- function num : 0_7
end

GuildDetailWindow.OnShown = function(...)
  -- function num : 0_8 , upvalues : GuildDetailWindow
  (GuildDetailWindow.InitEvent)()
  ;
  (GuildDetailWindow.Init)()
end

GuildDetailWindow.OnHide = function(...)
  -- function num : 0_9
end

GuildDetailWindow.Init = function(...)
  -- function num : 0_10 , upvalues : _ENV, uis, GuildDetailWindow
  (GuildMgr.InitGuildBasicInfoPanel)(uis.MainInformationGrp, GuildDetailPanelType.SubInterface)
  ;
  (GuildDetailWindow.InitApplyBtnStatus)()
  ;
  (GuildDetailWindow.ClickLogBtn)()
end

GuildDetailWindow.OnClose = function(...)
  -- function num : 0_11 , upvalues : _ENV, GuildDetailWindow, uis, contentPane, argTable, _noOneEffect
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

  GuildData.MemberCards = {}
  ;
  (CommonWinMgr.RemoveAssets)((WinResConfig.GuildDetailWindow).name)
  ;
  (RedDotMgr.EliminateRedDot)((WinResConfig.GuildDetailWindow).name)
  ;
  (GuildDetailWindow.RemoveEvent)()
  uis = nil
  contentPane = nil
  argTable = {}
  _noOneEffect = nil
end

GuildDetailWindow.InitApplyBtnStatus = function(...)
  -- function num : 0_12 , upvalues : _ENV, uis
  local rights = (GuildData.GetSelfRights)()
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  if rights.agree_join == 1 or rights.refuse_join == 1 then
    ((uis.GuildManageContentGrp).c2Ctr).selectedIndex = 0
  else
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((uis.GuildManageContentGrp).c2Ctr).selectedIndex = 1
  end
end

GuildDetailWindow.InitLogList = function(...)
  -- function num : 0_13 , upvalues : _ENV, uis
  local count = #GuildData.LogInfos
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((uis.GuildManageContentGrp).JournalGrp).JournalWordList).numItems = count
end

GuildDetailWindow.RefreshLogItem = function(index, item, ...)
  -- function num : 0_14 , upvalues : _ENV
  local data = (GuildData.LogInfos)[#GuildData.LogInfos - index]
  local str = "[color=" .. Const.GreenColor .. "]" .. (os.date)("%m " .. (PUtil.get)(60000032) .. " %d " .. (PUtil.get)(60000033) .. " [%H:%M]", (math.floor)(data.time * 0.001)) .. "[/color] "
  if data.logType == (ProtoEnum.GUILD_LOG).PROMOTION_LOG then
    local position = tonumber(data.param)
    if position == (ProtoEnum.GUILD_POST).VICE_LEADER_POST then
      str = str .. (PUtil.get)(60000221, data.memberName)
    else
      if position == (ProtoEnum.GUILD_POST).LEADER_POST then
        str = str .. (PUtil.get)(60000223, data.memberName)
      else
        str = str .. (PUtil.get)(60000222, data.memberName)
      end
    end
  else
    do
      if data.logType == (ProtoEnum.GUILD_LOG).CREATE_LOG then
        str = str .. (PUtil.get)(60000311, data.memberName)
      else
        if data.logType == (ProtoEnum.GUILD_LOG).RENAME_LOG then
          str = str .. (PUtil.get)(60000312, data.memberName, data.param)
        else
          str = str .. (PUtil.get)(60000217 + data.logType, data.memberName)
        end
      end
      ;
      (item:GetChild("JournalWordTxt")).text = str
    end
  end
end

GuildDetailWindow.InitCondition = function(...)
  -- function num : 0_15 , upvalues : _ENV, uis
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R0 in 'UnsetPending'

  if (GuildData.BaseInfo).joinMinFc == 0 then
    (((uis.GuildManageContentGrp).JournalGrp).c1Ctr).selectedIndex = 0
  else
    -- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (((uis.GuildManageContentGrp).JournalGrp).c1Ctr).selectedIndex = 1
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (((uis.GuildManageContentGrp).JournalGrp).BattleTxt).text = (GuildData.BaseInfo).joinMinFc
  end
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R0 in 'UnsetPending'

  if ((GuildData.GetSelfRights)()).change_join_condition == 1 then
    (((uis.GuildManageContentGrp).JournalGrp).Choice_01_Btn).touchable = true
    -- DECOMPILER ERROR at PC34: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (((uis.GuildManageContentGrp).JournalGrp).Choice_02_Btn).touchable = true
    -- DECOMPILER ERROR at PC38: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (((uis.GuildManageContentGrp).JournalGrp).BattleTxt).touchable = true
  else
    -- DECOMPILER ERROR at PC43: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (((uis.GuildManageContentGrp).JournalGrp).Choice_01_Btn).touchable = false
    -- DECOMPILER ERROR at PC47: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (((uis.GuildManageContentGrp).JournalGrp).Choice_02_Btn).touchable = false
    -- DECOMPILER ERROR at PC51: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (((uis.GuildManageContentGrp).JournalGrp).BattleTxt).touchable = false
  end
end

GuildDetailWindow.ChangeCondition = function(...)
  -- function num : 0_16 , upvalues : uis, _ENV, GuildDetailWindow
  local str = (((uis.GuildManageContentGrp).JournalGrp).BattleTxt).text
  if (((uis.GuildManageContentGrp).JournalGrp).c1Ctr).selectedIndex == 1 and (Util.StringIsNullOrEmpty)(str) == false then
    local condition = tonumber(str)
    if condition == nil then
      (GuildDetailWindow.SetDefaultBattleValue)()
    else
      if condition ~= (GuildData.BaseInfo).joinMinFc then
        (GuildMgr.ReqSetGuildJoinCondition)(condition)
      end
      -- DECOMPILER ERROR at PC38: Confused about usage of register: R2 in 'UnsetPending'

      if condition == 0 then
        (((uis.GuildManageContentGrp).JournalGrp).c1Ctr).selectedIndex = 0
        -- DECOMPILER ERROR at PC42: Confused about usage of register: R2 in 'UnsetPending'

        ;
        (((uis.GuildManageContentGrp).JournalGrp).BattleTxt).text = ""
      else
        -- DECOMPILER ERROR at PC47: Confused about usage of register: R2 in 'UnsetPending'

        ;
        (((uis.GuildManageContentGrp).JournalGrp).BattleTxt).text = str
      end
    end
  end
end

GuildDetailWindow.CheckConditionMaxValue = function(...)
  -- function num : 0_17 , upvalues : uis, _ENV
  local str = (((uis.GuildManageContentGrp).JournalGrp).BattleTxt).text
  if (string.find)(str, "%.") ~= -1 then
    str = (string.gsub)(str, "%.", "")
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (((uis.GuildManageContentGrp).JournalGrp).BattleTxt).text = str
  end
  local condition = tonumber(str)
  if condition ~= nil and GuildData.MAX_JOIN_CONDITION < condition then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000309))
    -- DECOMPILER ERROR at PC43: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (((uis.GuildManageContentGrp).JournalGrp).BattleTxt).text = GuildData.MAX_JOIN_CONDITION
  end
end

GuildDetailWindow.InitMemberList = function(setToLastPos, ...)
  -- function num : 0_18 , upvalues : uis, _ENV, _listPos
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  (((uis.GuildManageContentGrp).MemberGrp).MemberTipsList).numItems = #GuildData.MemberList
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

  if setToLastPos then
    ((((uis.GuildManageContentGrp).MemberGrp).MemberTipsList).scrollPane).posY = _listPos
  end
end

GuildDetailWindow.RefreshMemberItem = function(index, item, ...)
  -- function num : 0_19 , upvalues : _ENV, _listPos, uis
  local data = (GuildData.MemberList)[index + 1]
  local headGrp = item:GetChild("PlayerHeadGrp")
  ;
  (headGrp:GetController("c1")).selectedIndex = 1
  ;
  (headGrp:GetChild("ActorHeadLoader")).url = (Util.GetHeadIconByFashionId)(data.fashionId, HeadIconType.ROUND)
  ;
  (headGrp:GetChild("LevelTxt")).text = "Lv." .. data.level
  ;
  (item:GetChild("PlayerNameTxt")).text = data.name
  local titlePanel = item:GetChild("TitlePic")
  if data.titleId == 0 or data.titleId == nil then
    (titlePanel:GetChild("PicLoader")).url = nil
  else
    ;
    (titlePanel:GetChild("PicLoader")).url = (Util.GetItemUrl)((((TableData.gTable).BasePlayerTitleData)[data.titleId]).icon)
  end
  if data.onlineTime == 0 then
    (item:GetChild("TimeTxt")).text = (PUtil.get)(60000233)
  else
    ;
    (item:GetChild("TimeTxt")).text = "(" .. (LuaTime.GetLeftTimeStr)(data.onlineTime / 1000) .. ")"
  end
  ;
  ((item:GetChild("ChatStatus")):GetController("c1")).selectedIndex = (GuildData.GetPositionUIIndex)(((GuildData.BaseInfo).members)[data.objectindex])
  local powerGrp = item:GetChild("MainTips_01_Grp")
  ;
  (powerGrp:GetChild("NameTxt")).text = (PUtil.get)(7)
  ;
  (powerGrp:GetChild("WordTxt")).text = data.fc
  local vigourGrp = item:GetChild("MainTips_02_Grp")
  ;
  (vigourGrp:GetChild("NameTxt")).text = (PUtil.get)(60000236)
  ;
  (vigourGrp:GetChild("WordTxt")).text = data.weekActivation
  ;
  (item.onClick):Set(function(...)
    -- function num : 0_19_0 , upvalues : _listPos, uis, _ENV, data
    _listPos = ((((uis.GuildManageContentGrp).MemberGrp).MemberTipsList).scrollPane).posY
    ;
    (GuildMgr.ViewGuildMemeber)(data)
  end
)
end

GuildDetailWindow.InitApplyList = function(...)
  -- function num : 0_20 , upvalues : _ENV, uis, _noOneEffect
  local count = #GuildData.GuildApplyList
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  if count == 0 then
    (((uis.GuildManageContentGrp).InspectGrp).c1Ctr).selectedIndex = 1
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (((uis.GuildManageContentGrp).InspectGrp).WordTxt).text = (PUtil.get)(60000280)
    if _noOneEffect == nil then
      _noOneEffect = (Util.SetNotFoundEffect)(((uis.GuildManageContentGrp).InspectGrp).AnimationLoader)
    end
  else
    -- DECOMPILER ERROR at PC31: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (((uis.GuildManageContentGrp).InspectGrp).c1Ctr).selectedIndex = 0
    -- DECOMPILER ERROR at PC38: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (((uis.GuildManageContentGrp).InspectGrp).InspectTipsList).numItems = #GuildData.GuildApplyList
  end
end

GuildDetailWindow.RefreshApplyItem = function(index, item, ...)
  -- function num : 0_21 , upvalues : _ENV
  local data = (GuildData.GuildApplyList)[index + 1]
  local headGrp = item:GetChild("PlayerHeadGrp")
  ;
  (headGrp:GetController("c1")).selectedIndex = 1
  ;
  (headGrp:GetChild("ActorHeadLoader")).url = (Util.GetHeadIconByFashionId)(data.fashionId, HeadIconType.ROUND)
  ;
  (headGrp:GetChild("LevelTxt")).text = data.level
  local battleCom = item:GetChild("Battle")
  ;
  (battleCom:GetChild("NameTxt")).text = (PUtil.get)(60000235)
  ;
  (battleCom:GetChild("WordTxt")).text = data.fc
  ;
  (item:GetChild("PlayerNameTxt")).text = data.name
  if data.onlineTime == 0 then
    (item:GetChild("TimeTxt")).text = (PUtil.get)(60000233)
  else
    ;
    (item:GetChild("TimeTxt")).text = "(" .. (LuaTime.GetLeftTimeStr)(data.onlineTime / 1000) .. ")"
  end
  local rejectBtn = item:GetChild("NoBtn")
  rejectBtn.text = (PUtil.get)(60000282)
  ;
  (rejectBtn.onClick):Set(function(...)
    -- function num : 0_21_0 , upvalues : _ENV, data
    (GuildMgr.ReqProcessApply)((ProtoEnum.GUILD_APPLY).REFUSE_APPLY, {[1] = data.objectindex})
  end
)
  local approveBtn = item:GetChild("YesBtn")
  approveBtn.text = (PUtil.get)(60000283)
  ;
  (approveBtn.onClick):Set(function(...)
    -- function num : 0_21_1 , upvalues : _ENV, data
    (GuildMgr.ReqProcessApply)((ProtoEnum.GUILD_APPLY).PASS_APPLY, {[1] = data.objectindex})
  end
)
  local list = item:GetChild("HeadList")
  list:RemoveChildrenToPool()
  local count = #data.cardList
  local subItem = nil
  for i = 1, count do
    subItem = list:AddItemFromPool()
    ;
    (Util.SetHeadFrame)(subItem, (data.cardList)[i])
  end
end

GuildDetailWindow.ClickLogBtn = function(...)
  -- function num : 0_22 , upvalues : GuildDetailWindow
  (GuildDetailWindow.InitLogList)()
  ;
  (GuildDetailWindow.InitCondition)()
end

GuildDetailWindow.ClickMemberBtn = function(...)
  -- function num : 0_23 , upvalues : _ENV
  (GuildMgr.ShowMemberList)()
end

GuildDetailWindow.ClickApplyBtn = function(...)
  -- function num : 0_24 , upvalues : _ENV
  (GuildMgr.ShowGuildApplyList)()
  ;
  (RedDotMgr.EliminateRedDot)((WinResConfig.GuildDetailWindow).name, RedDotComID.Guild_Detail_Apply)
end

GuildDetailWindow.ClickFreeJoinBtn = function(...)
  -- function num : 0_25 , upvalues : _ENV, uis
  if (GuildData.BaseInfo).joinMinFc ~= 0 then
    (GuildMgr.ReqSetGuildJoinCondition)(0)
  end
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.GuildManageContentGrp).JournalGrp).BattleTxt).text = ""
end

GuildDetailWindow.ClickLimitJoinBtn = function(...)
  -- function num : 0_26 , upvalues : uis, _ENV, GuildDetailWindow
  local str = (((uis.GuildManageContentGrp).JournalGrp).BattleTxt).text
  if (Util.StringIsNullOrEmpty)(str) then
    (GuildDetailWindow.SetDefaultBattleValue)()
  else
    local value = tonumber(str)
    if value and value ~= (GuildData.BaseInfo).joinMinFc then
      (GuildMgr.ReqSetGuildJoinCondition)(value)
    end
  end
end

GuildDetailWindow.SetDefaultBattleValue = function(...)
  -- function num : 0_27 , upvalues : _ENV, uis
  (GuildMgr.ReqSetGuildJoinCondition)(1)
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.GuildManageContentGrp).JournalGrp).BattleTxt).text = "1"
end

GuildDetailWindow.ClickAllRejectBtn = function(...)
  -- function num : 0_28 , upvalues : _ENV
  local data = {}
  local count = #GuildData.GuildApplyList
  for i = 1, count do
    (table.insert)(data, ((GuildData.GuildApplyList)[i]).objectindex)
  end
  ;
  (GuildMgr.ReqProcessApply)((ProtoEnum.GUILD_APPLY).REFUSE_APPLY, data)
end

GuildDetailWindow.ClickAllApproveBtn = function(...)
  -- function num : 0_29 , upvalues : _ENV
  local data = {}
  local count = #GuildData.GuildApplyList
  for i = 1, count do
    (table.insert)(data, ((GuildData.GuildApplyList)[i]).objectindex)
  end
  ;
  (GuildMgr.ReqProcessApply)((ProtoEnum.GUILD_APPLY).PASS_APPLY, data)
end

GuildDetailWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_30 , upvalues : _ENV, uis, GuildDetailWindow
  -- DECOMPILER ERROR at PC11: Unhandled construct in 'MakeBoolean' P1

  if msgId == (WindowMsgEnum.Guild).E_MSG_REFRESH_GUILD_LOG and ((uis.GuildManageContentGrp).c1Ctr).selectedIndex == 0 then
    (GuildDetailWindow.InitLogList)()
  end
  -- DECOMPILER ERROR at PC25: Unhandled construct in 'MakeBoolean' P1

  if msgId == (WindowMsgEnum.Guild).E_MSG_REFRESH_GUILD_MEMBER and ((uis.GuildManageContentGrp).c1Ctr).selectedIndex == 1 then
    (GuildDetailWindow.InitMemberList)(para)
  end
  -- DECOMPILER ERROR at PC38: Unhandled construct in 'MakeBoolean' P1

  if msgId == (WindowMsgEnum.Guild).E_MSG_REFRESH_GUILD_APPLY and ((uis.GuildManageContentGrp).c1Ctr).selectedIndex == 2 then
    (GuildDetailWindow.InitApplyList)()
  end
  -- DECOMPILER ERROR at PC52: Confused about usage of register: R2 in 'UnsetPending'

  if msgId == (WindowMsgEnum.Guild).E_MSG_REFRESH_MEMBER_RIGHTS then
    if ((uis.GuildManageContentGrp).c1Ctr).selectedIndex == 2 then
      ((uis.GuildManageContentGrp).c1Ctr).selectedIndex = 0
      ;
      (GuildDetailWindow.InitLogList)()
    end
    ;
    (GuildDetailWindow.InitApplyBtnStatus)()
  end
end

return GuildDetailWindow

