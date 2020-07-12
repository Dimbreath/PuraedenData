-- params : ...
-- function num : 0 , upvalues : _ENV
require("Guild_WelfareRankingByName")
local GuildWelfareRankingWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local _emptyEffect = nil
GuildWelfareRankingWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, GuildWelfareRankingWindow
  bridgeObj:SetView((WinResConfig.GuildWelfareRankingWindow).package, (WinResConfig.GuildWelfareRankingWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetGuild_WelfareRankingUis(contentPane)
  ;
  (GuildWelfareRankingWindow.InitTopMenu)()
  ;
  (GuildWelfareRankingWindow.InitVariable)()
  ;
  (GuildWelfareRankingWindow.InitText)()
  ;
  (GuildWelfareRankingWindow.InitList)()
  ;
  (GuildWelfareRankingWindow.InitButtonEvent)()
end

GuildWelfareRankingWindow.InitTopMenu = function(...)
  -- function num : 0_1 , upvalues : _ENV, uis
  local m = {}
  m.windowName = (WinResConfig.GuildWelfareRankingWindow).name
  m.Tip = (PUtil.get)(60000257)
  m.model = uis.AssetStripGrp
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.SHOP_TOKEN}
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

GuildWelfareRankingWindow.InitVariable = function(...)
  -- function num : 0_2
end

GuildWelfareRankingWindow.InitText = function(...)
  -- function num : 0_3 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.TalkGrp).WordTxt).text = (PUtil.get)(60000415)
end

GuildWelfareRankingWindow.InitList = function(...)
  -- function num : 0_4 , upvalues : uis, GuildWelfareRankingWindow
  (uis.CardList):SetBeginAnim()
  ;
  (uis.CardList):SetVirtual()
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.CardList).itemRenderer = GuildWelfareRankingWindow.RefreshRankItem
end

GuildWelfareRankingWindow.InitButtonEvent = function(...)
  -- function num : 0_5
end

GuildWelfareRankingWindow.InitEvent = function(...)
  -- function num : 0_6
end

GuildWelfareRankingWindow.RemoveEvent = function(...)
  -- function num : 0_7
end

GuildWelfareRankingWindow.OnShown = function(...)
  -- function num : 0_8 , upvalues : GuildWelfareRankingWindow
  (GuildWelfareRankingWindow.InitEvent)()
  ;
  (GuildWelfareRankingWindow.Init)()
end

GuildWelfareRankingWindow.OnHide = function(...)
  -- function num : 0_9
end

GuildWelfareRankingWindow.Init = function(...)
  -- function num : 0_10 , upvalues : GuildWelfareRankingWindow
  (GuildWelfareRankingWindow.Refresh)()
end

GuildWelfareRankingWindow.OnClose = function(...)
  -- function num : 0_11 , upvalues : _ENV, GuildWelfareRankingWindow, _emptyEffect, uis, contentPane, argTable
  (CommonWinMgr.RemoveAssets)((WinResConfig.GuildWelfareRankingWindow).name)
  ;
  (GuildWelfareRankingWindow.RemoveEvent)()
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

  GuildData.GuildGiftRank = {}
  _emptyEffect = nil
  uis = nil
  contentPane = nil
  argTable = {}
end

GuildWelfareRankingWindow.Refresh = function(...)
  -- function num : 0_12 , upvalues : _ENV, uis, _emptyEffect, GuildWelfareRankingWindow
  local count = #(GuildData.GuildGiftRank).RankList
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.CardList).numItems = count
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R1 in 'UnsetPending'

  if count == 0 then
    (uis.c2Ctr).selectedIndex = 1
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (uis.c3Ctr).selectedIndex = 1
    if _emptyEffect == nil then
      _emptyEffect = (Util.SetNotFoundEffect)(uis.IconLoader)
    end
  else
    -- DECOMPILER ERROR at PC22: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (uis.c2Ctr).selectedIndex = 0
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R1 in 'UnsetPending'

    if (GuildData.GuildGiftRank).SelfRank == 0 then
      (uis.c3Ctr).selectedIndex = 1
    else
      -- DECOMPILER ERROR at PC32: Confused about usage of register: R1 in 'UnsetPending'

      ;
      (uis.c3Ctr).selectedIndex = 0
      ;
      (GuildWelfareRankingWindow.RefreshRankItem)((GuildData.GuildGiftRank).SelfRank - 1, (uis.OneselfGrp).root)
    end
  end
end

GuildWelfareRankingWindow.RefreshRankItem = function(index, item, ...)
  -- function num : 0_13 , upvalues : _ENV
  local data = ((GuildData.GuildGiftRank).RankList)[index + 1]
  if index < 3 then
    (item:GetController("c1")).selectedIndex = index
  else
    ;
    (item:GetController("c1")).selectedIndex = 3
    ;
    (item:GetChild("Ranking_04_Txt")).text = index + 1
  end
  ;
  ((item:GetChild("PlayerHeadGrp")):GetChild("ActorHeadLoader")).url = (Util.GetHeadIconByFashionId)((data.memberInfo).fashionId, HeadIconType.ROUND)
  ;
  (item:GetChild("CardNameTxt")).text = (data.memberInfo).name
  ;
  (item:GetChild("WordTxt")).text = (PUtil.get)(60000100)
  local list = item:GetChild("ItemList")
  list:RemoveChildrenToPool()
  local count = #data.goods
  local subItem = nil
  for i = 1, count do
    subItem = list:AddItemFromPool()
    local subData = (data.goods)[i]
    ;
    (subItem:GetChild("ItemLoader")).url = (Util.GetUrlFromItemID)(subData.id, subData.type)
    ;
    (subItem:GetChild("ItemNumberTxt")).text = subData.value
  end
end

GuildWelfareRankingWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_14
end

return GuildWelfareRankingWindow

