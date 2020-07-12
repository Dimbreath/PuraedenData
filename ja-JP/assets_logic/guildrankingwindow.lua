-- params : ...
-- function num : 0 , upvalues : _ENV
require("Guild_GuildRankingByName")
local GuildRankingWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
GuildRankingWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, GuildRankingWindow
  bridgeObj:SetView((WinResConfig.GuildRankingWindow).package, (WinResConfig.GuildRankingWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  argTable.GuildInfo = argTable[1]
  argTable.MyRank = argTable[2]
  uis = GetGuild_GuildRankingUis(contentPane)
  ;
  (GuildRankingWindow.InitTopMenu)()
  ;
  (GuildRankingWindow.InitVariable)()
  ;
  (GuildRankingWindow.InitText)()
  ;
  (GuildRankingWindow.InitList)()
  ;
  (GuildRankingWindow.InitButtonEvent)()
end

GuildRankingWindow.InitTopMenu = function(...)
  -- function num : 0_1 , upvalues : _ENV, uis
  local m = {}
  m.windowName = (WinResConfig.GuildRankingWindow).name
  m.Tip = (PUtil.get)(60000258)
  m.model = uis.AssetStripGrp
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.SHOP_TOKEN}
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

GuildRankingWindow.InitVariable = function(...)
  -- function num : 0_2
end

GuildRankingWindow.InitText = function(...)
  -- function num : 0_3
end

GuildRankingWindow.InitList = function(...)
  -- function num : 0_4 , upvalues : uis, GuildRankingWindow
  (uis.OtherGuildList):SetBeginAnim()
  ;
  (uis.OtherGuildList):SetVirtual()
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.OtherGuildList).itemRenderer = GuildRankingWindow.RefreshRankItem
end

GuildRankingWindow.InitButtonEvent = function(...)
  -- function num : 0_5
end

GuildRankingWindow.InitEvent = function(...)
  -- function num : 0_6
end

GuildRankingWindow.RemoveEvent = function(...)
  -- function num : 0_7
end

GuildRankingWindow.OnShown = function(...)
  -- function num : 0_8 , upvalues : GuildRankingWindow
  (GuildRankingWindow.InitEvent)()
  ;
  (GuildRankingWindow.Init)()
end

GuildRankingWindow.OnHide = function(...)
  -- function num : 0_9
end

GuildRankingWindow.Init = function(...)
  -- function num : 0_10 , upvalues : argTable, uis, GuildRankingWindow, _ENV
  local count = #argTable.GuildInfo
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.OtherGuildList).numItems = count
  if argTable.MyRank == 0 then
    (GuildRankingWindow.InitSingleItem)((uis.OneSelfGrp).root, GuildData.BaseInfo, argTable.MyRank, true)
  else
    for i = 1, count do
      if i == argTable.MyRank then
        (GuildRankingWindow.InitSingleItem)((uis.OneSelfGrp).root, (argTable.GuildInfo)[i], argTable.MyRank, true)
      end
    end
  end
end

GuildRankingWindow.OnClose = function(...)
  -- function num : 0_11 , upvalues : _ENV, GuildRankingWindow, uis, contentPane, argTable
  (CommonWinMgr.RemoveAssets)((WinResConfig.GuildRankingWindow).name)
  ;
  (GuildRankingWindow.RemoveEvent)()
  uis = nil
  contentPane = nil
  argTable = {}
end

GuildRankingWindow.RefreshRankItem = function(index, item, ...)
  -- function num : 0_12 , upvalues : argTable, GuildRankingWindow
  index = index + 1
  local data = (argTable.GuildInfo)[index]
  ;
  (GuildRankingWindow.InitSingleItem)(item, data, index, index == argTable.MyRank)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

GuildRankingWindow.InitSingleItem = function(item, data, rank, myself, ...)
  -- function num : 0_13 , upvalues : _ENV, GuildRankingWindow
  if rank < 4 then
    (item:GetController("c1")).selectedIndex = rank - 1
  else
    ;
    (item:GetController("c1")).selectedIndex = 3
    ;
    (item:GetChild("Ranking_04_Txt")).text = tostring(rank)
  end
  if myself then
    (item:GetController("c2")).selectedIndex = 1
  else
    ;
    (item:GetController("c2")).selectedIndex = 0
  end
  ;
  ((item:GetChild("GuildIconGrp")):GetChild("GuildIconLoader")).url = (GuildData.GetGuildIcon)(data.icon)
  ;
  (item:GetChild("GuildLevelTxt")).text = "Lv." .. tostring(data.level)
  ;
  (item:GetChild("GuildNameTxt")).text = data.name
  local maxCount = (((TableData.gTable).BaseGuildLevelUpData)[(GuildData.GuildLevelConfig)[data.level]]).max_member
  if maxCount <= data.memberCount then
    (item:GetChild("MemberTxt")).text = (PUtil.get)(60000260) .. " [color=" .. Const.OrangeColor .. "]" .. tostring(data.memberCount) .. "[/color]/" .. tostring(maxCount)
  else
    ;
    (item:GetChild("MemberTxt")).text = (PUtil.get)(60000260) .. " " .. tostring(data.memberCount) .. "/" .. tostring(maxCount)
  end
  ;
  (GuildRankingWindow.SetSubItemInfo)(item:GetChild("TipsInfo_01_Grp"), 0, (PUtil.get)(60000208), data.leader)
  ;
  (GuildRankingWindow.SetSubItemInfo)(item:GetChild("TipsInfo_02_Grp"), 2, (PUtil.get)(60000209), data.activation)
  ;
  (GuildRankingWindow.SetSubItemInfo)(item:GetChild("TipsInfo_03_Grp"), 3, (PUtil.get)(60000210), data.fc)
end

GuildRankingWindow.SetSubItemInfo = function(item, index, name, value, ...)
  -- function num : 0_14
  (item:GetChild("NameTxt")).text = name
  ;
  (item:GetChild("WordTxt")).text = value
end

GuildRankingWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_15
end

return GuildRankingWindow

