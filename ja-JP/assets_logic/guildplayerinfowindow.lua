-- params : ...
-- function num : 0 , upvalues : _ENV
require("Guild_PlayerInfoWindowByName")
local GuildPlayerInfoWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
GuildPlayerInfoWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, GuildPlayerInfoWindow
  bridgeObj:SetView((WinResConfig.GuildPlayerInfoWindow).package, (WinResConfig.GuildPlayerInfoWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetGuild_PlayerInfoWindowUis(contentPane)
  ;
  (GuildPlayerInfoWindow.InitArgTable)()
  ;
  (GuildPlayerInfoWindow.InitVariable)()
  ;
  (GuildPlayerInfoWindow.InitText)()
  ;
  (GuildPlayerInfoWindow.InitList)()
  ;
  (GuildPlayerInfoWindow.InitButtonEvent)()
  ;
  (LeanTween.delayedCall)(0.5, function(...)
    -- function num : 0_0_0 , upvalues : _ENV
    if UIMgr:IsWindowOpen((WinResConfig.GuildPlayerInfoWindow).name) == false then
      return 
    end
    ;
    (BattleBackground.PreLoad)(0, (ProtoEnum.E_BATTLE_TYPE).GUILD_PK)
  end
)
end

GuildPlayerInfoWindow.InitArgTable = function(...)
  -- function num : 0_1 , upvalues : argTable
  argTable.memberInfo = argTable[1]
  argTable.Cards = argTable[2]
end

GuildPlayerInfoWindow.InitVariable = function(...)
  -- function num : 0_2
end

GuildPlayerInfoWindow.InitText = function(...)
  -- function num : 0_3 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.PlayerInfoGrp).NameTxt).text = (PUtil.get)(60000527)
end

GuildPlayerInfoWindow.InitList = function(...)
  -- function num : 0_4 , upvalues : uis, GuildPlayerInfoWindow
  ((uis.PlayerInfoGrp).CardList):SetVirtual()
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.PlayerInfoGrp).CardList).itemRenderer = GuildPlayerInfoWindow.RefreshCardsItem
end

GuildPlayerInfoWindow.InitButtonEvent = function(...)
  -- function num : 0_5 , upvalues : uis, GuildPlayerInfoWindow
  (((uis.PlayerInfoGrp).CloseBtn).onClick):Add(GuildPlayerInfoWindow.ClickQuitBtn)
end

GuildPlayerInfoWindow.InitEvent = function(...)
  -- function num : 0_6
end

GuildPlayerInfoWindow.RemoveEvent = function(...)
  -- function num : 0_7
end

GuildPlayerInfoWindow.OnShown = function(...)
  -- function num : 0_8 , upvalues : GuildPlayerInfoWindow
  (GuildPlayerInfoWindow.InitEvent)()
  ;
  (GuildPlayerInfoWindow.Init)()
end

GuildPlayerInfoWindow.OnHide = function(...)
  -- function num : 0_9
end

GuildPlayerInfoWindow.Init = function(...)
  -- function num : 0_10 , upvalues : GuildPlayerInfoWindow
  (GuildPlayerInfoWindow.InitBasicInfo)()
  ;
  (GuildPlayerInfoWindow.RefreshRightsList)()
end

GuildPlayerInfoWindow.OnClose = function(...)
  -- function num : 0_11 , upvalues : GuildPlayerInfoWindow, uis, contentPane, argTable
  (GuildPlayerInfoWindow.RemoveEvent)()
  uis = nil
  contentPane = nil
  argTable = {}
end

GuildPlayerInfoWindow.InitBasicInfo = function(...)
  -- function num : 0_12 , upvalues : uis, argTable, _ENV, GuildPlayerInfoWindow
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.PlayerInfoGrp).PlayerNameTxt).text = (argTable.memberInfo).name
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R0 in 'UnsetPending'

  if (argTable.memberInfo).onlineTime == 0 then
    ((uis.PlayerInfoGrp).TimeTxt).text = (PUtil.get)(60000233)
  else
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((uis.PlayerInfoGrp).TimeTxt).text = (PUtil.get)(60000234, (LuaTime.GetLeftTimeStr)((argTable.memberInfo).onlineTime / 1000))
  end
  ;
  ((((uis.PlayerInfoGrp).PlayerHeadGrp).root):GetChild("ActorHeadLoader")).url = (Util.GetHeadIconByFashionId)((argTable.memberInfo).fashionId, HeadIconType.ROUND)
  ;
  (GuildPlayerInfoWindow.SetDetailItem)((uis.PlayerInfoGrp).BattleNumberGrp, (PUtil.get)(60000235), (argTable.memberInfo).fc)
  ;
  (GuildPlayerInfoWindow.SetDetailItem)((uis.PlayerInfoGrp).WeekGrp, (PUtil.get)(60000236), (argTable.memberInfo).weekActivation)
  -- DECOMPILER ERROR at PC68: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.PlayerInfoGrp).CardList).numItems = #argTable.Cards
  ;
  (GuildPlayerInfoWindow.InitPositionInfo)()
end

GuildPlayerInfoWindow.InitPositionInfo = function(...)
  -- function num : 0_13 , upvalues : uis, _ENV, argTable
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R0 in 'UnsetPending'

  (((uis.PlayerInfoGrp).ChatStatus).c1Ctr).selectedIndex = (GuildData.GetPositionUIIndex)((argTable.memberInfo).post)
end

GuildPlayerInfoWindow.RefreshRightsList = function(...)
  -- function num : 0_14 , upvalues : uis, argTable, GuildPlayerInfoWindow
  ((uis.PlayerInfoGrp).FunctionList):RemoveChildrenToPool()
  local count = #(argTable.memberInfo).Rights
  local item = nil
  for i = 1, count do
    item = ((uis.PlayerInfoGrp).FunctionList):AddItemFromPool()
    ;
    (GuildPlayerInfoWindow.RefreshRightsItem)(i, item)
  end
end

GuildPlayerInfoWindow.SetDetailItem = function(item, name, value, ...)
  -- function num : 0_15
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (item.NameTxt).text = name
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (item.WordTxt).text = value
end

GuildPlayerInfoWindow.RefreshCardsItem = function(index, item, ...)
  -- function num : 0_16 , upvalues : _ENV, argTable
  (Util.SetHeadFrame)(item, (argTable.Cards)[index + 1])
end

GuildPlayerInfoWindow.RefreshRightsItem = function(index, item, ...)
  -- function num : 0_17 , upvalues : argTable, _ENV
  local data = ((argTable.memberInfo).Rights)[index]
  if data.type == GuildMemberOperateType.Transfer then
    item.text = (PUtil.get)(60000238)
    ;
    (item.onClick):Set(function(...)
    -- function num : 0_17_0 , upvalues : _ENV, argTable
    (MessageMgr.OpenConfirmWindow)((PUtil.get)(60000243, (argTable.memberInfo).name), function(...)
      -- function num : 0_17_0_0 , upvalues : _ENV, argTable
      (GuildMgr.ChangeMemberPosition)(GuildMemberOperateType.Transfer, argTable.memberInfo, (ProtoEnum.GUILD_POST).LEADER_POST)
    end
)
  end
)
  else
    if data.type == GuildMemberOperateType.Promote then
      item.text = (PUtil.get)(60000240, (GuildData.GetPositionName)(data.value))
      ;
      (item.onClick):Set(function(...)
    -- function num : 0_17_1 , upvalues : _ENV, argTable, data
    (GuildMgr.ChangeMemberPosition)(GuildMemberOperateType.Promote, argTable.memberInfo, data.value)
  end
)
    else
      if data.type == GuildMemberOperateType.Demote then
        item.text = (PUtil.get)(60000241, (GuildData.GetPositionName)(data.value))
        ;
        (item.onClick):Set(function(...)
    -- function num : 0_17_2 , upvalues : _ENV, argTable, data
    (GuildMgr.ChangeMemberPosition)(GuildMemberOperateType.Demote, argTable.memberInfo, data.value)
  end
)
      else
        if data.type == GuildMemberOperateType.KickOut then
          item.text = (PUtil.get)(60000239)
          ;
          (item.onClick):Set(function(...)
    -- function num : 0_17_3 , upvalues : _ENV, argTable
    (GuildMgr.KickOutMember)(argTable.memberInfo)
  end
)
        else
          if data.type == GuildMemberOperateType.Fight then
            item.text = (PUtil.get)(60000242)
            ;
            (item.onClick):Set(function(...)
    -- function num : 0_17_4 , upvalues : _ENV, argTable
    (GuildMgr.ReqGuildPK)((argTable.memberInfo).objectindex, (argTable.memberInfo).serverId)
  end
)
          end
        end
      end
    end
  end
end

GuildPlayerInfoWindow.ClickQuitBtn = function(...)
  -- function num : 0_18 , upvalues : _ENV
  UIMgr:CloseWindow((WinResConfig.GuildPlayerInfoWindow).name)
end

GuildPlayerInfoWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_19 , upvalues : _ENV, argTable, GuildPlayerInfoWindow
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  if msgId == (WindowMsgEnum.Guild).E_MSG_REFRESH_MEMBER_RIGHTS then
    (argTable.memberInfo).Rights = para
    ;
    (GuildPlayerInfoWindow.RefreshRightsList)()
    ;
    (GuildPlayerInfoWindow.InitPositionInfo)()
  end
end

return GuildPlayerInfoWindow

