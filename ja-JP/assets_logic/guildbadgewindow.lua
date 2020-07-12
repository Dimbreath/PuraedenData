-- params : ...
-- function num : 0 , upvalues : _ENV
require("Guild_BadgeChoiceWindowByName")
local GuildBadgeWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local _choseIndex = 0
local _choseItem = nil
local _curIndex = 0
GuildBadgeWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, GuildBadgeWindow
  bridgeObj:SetView((WinResConfig.GuildBadgeWindow).package, (WinResConfig.GuildBadgeWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetGuild_BadgeChoiceWindowUis(contentPane)
  ;
  (GuildBadgeWindow.InitVariable)()
  ;
  (GuildBadgeWindow.InitText)()
  ;
  (GuildBadgeWindow.InitList)()
  ;
  (GuildBadgeWindow.InitButtonEvent)()
end

GuildBadgeWindow.InitVariable = function(...)
  -- function num : 0_1
end

GuildBadgeWindow.InitText = function(...)
  -- function num : 0_2 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.BadgeChoiceGrp).SureBtn).text = (PUtil.get)(60000004)
end

GuildBadgeWindow.InitList = function(...)
  -- function num : 0_3 , upvalues : uis, GuildBadgeWindow
  ((uis.BadgeChoiceGrp).BadgeTipsList):SetVirtual()
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.BadgeChoiceGrp).BadgeTipsList).itemRenderer = GuildBadgeWindow.RefreshBadgeItem
end

GuildBadgeWindow.InitButtonEvent = function(...)
  -- function num : 0_4 , upvalues : uis, GuildBadgeWindow
  (((uis.BadgeChoiceGrp).CloseBtn).onClick):Add(GuildBadgeWindow.ClickCloseBtn)
  ;
  (((uis.BadgeChoiceGrp).SureBtn).onClick):Add(GuildBadgeWindow.ClickConfirmBtn)
end

GuildBadgeWindow.InitEvent = function(...)
  -- function num : 0_5
end

GuildBadgeWindow.RemoveEvent = function(...)
  -- function num : 0_6
end

GuildBadgeWindow.OnShown = function(...)
  -- function num : 0_7 , upvalues : GuildBadgeWindow
  (GuildBadgeWindow.InitEvent)()
  ;
  (GuildBadgeWindow.Init)()
end

GuildBadgeWindow.OnHide = function(...)
  -- function num : 0_8
end

GuildBadgeWindow.Init = function(...)
  -- function num : 0_9 , upvalues : _choseIndex, _choseItem, uis, _ENV
  _choseIndex = 0
  _choseItem = nil
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.BadgeChoiceGrp).BadgeTipsList).numItems = #GuildData.BadgeConfig
end

GuildBadgeWindow.OnClose = function(...)
  -- function num : 0_10 , upvalues : GuildBadgeWindow, uis, contentPane, argTable
  (GuildBadgeWindow.RemoveEvent)()
  uis = nil
  contentPane = nil
  argTable = {}
end

GuildBadgeWindow.RefreshBadgeItem = function(index, item, ...)
  -- function num : 0_11 , upvalues : _ENV, _curIndex, _choseIndex, _choseItem
  index = index + 1
  local config = ((TableData.gTable).BaseGuildBadgeData)[(GuildData.BadgeConfig)[index]]
  ;
  ((item:GetChild("GuildIconGrp")):GetChild("GuildIconLoader")).url = (Util.GetItemUrl)(config.icon)
  if config.id == (GuildData.BaseInfo).icon then
    (item:GetController("c1")).selectedIndex = 1
    _curIndex = index
  else
    ;
    (item:GetController("c1")).selectedIndex = 0
  end
  if index == _choseIndex then
    (item:GetController("c2")).selectedIndex = 1
  else
    ;
    (item:GetController("c2")).selectedIndex = 0
  end
  ;
  (item.onClick):Set(function(...)
    -- function num : 0_11_0 , upvalues : _choseItem, _choseIndex, index, item
    if _choseItem ~= nil then
      (_choseItem:GetController("c2")).selectedIndex = 0
    end
    _choseIndex = index
    ;
    (item:GetController("c2")).selectedIndex = 1
    _choseItem = item
  end
)
end

GuildBadgeWindow.ClickCloseBtn = function(...)
  -- function num : 0_12 , upvalues : _ENV
  UIMgr:CloseWindow((WinResConfig.GuildBadgeWindow).name)
end

GuildBadgeWindow.ClickConfirmBtn = function(...)
  -- function num : 0_13 , upvalues : _curIndex, _choseIndex, _ENV
  if _curIndex == _choseIndex then
    return 
  end
  ;
  (GuildMgr.ReqChangeBadge)(_choseIndex)
end

GuildBadgeWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_14
end

return GuildBadgeWindow

