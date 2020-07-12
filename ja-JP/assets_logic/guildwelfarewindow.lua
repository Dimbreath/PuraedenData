-- params : ...
-- function num : 0 , upvalues : _ENV
require("Guild_WelfareByName")
local GUILD_TIDY_SLOTS_AMOUNT = 6
local CLEAN_UP_DURATION = 3
local GuildWelfareWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local _panels = {}
GuildWelfareWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, GuildWelfareWindow
  bridgeObj:SetView((WinResConfig.GuildWelfareWindow).package, (WinResConfig.GuildWelfareWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetGuild_WelfareUis(contentPane)
  ;
  (GuildWelfareWindow.InitTopMenu)()
  ;
  (GuildWelfareWindow.InitVariable)()
  ;
  (GuildWelfareWindow.InitText)()
  ;
  (GuildWelfareWindow.InitButtonEvent)()
end

GuildWelfareWindow.InitTopMenu = function(...)
  -- function num : 0_1 , upvalues : _ENV, uis
  local m = {}
  m.windowName = (WinResConfig.GuildWelfareWindow).name
  m.Tip = (PUtil.get)(60000256)
  m.model = uis.AssetStripGrp
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.SHOP_TOKEN}
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

GuildWelfareWindow.InitVariable = function(...)
  -- function num : 0_2
end

GuildWelfareWindow.InitText = function(...)
  -- function num : 0_3
end

GuildWelfareWindow.InitButtonEvent = function(...)
  -- function num : 0_4 , upvalues : uis, GuildWelfareWindow
  ((uis.RankingBtn).onClick):Add(GuildWelfareWindow.ClickRankingBtn)
end

GuildWelfareWindow.InitEvent = function(...)
  -- function num : 0_5
end

GuildWelfareWindow.RemoveEvent = function(...)
  -- function num : 0_6
end

GuildWelfareWindow.OnShown = function(...)
  -- function num : 0_7 , upvalues : GuildWelfareWindow
  (GuildWelfareWindow.InitEvent)()
  ;
  (GuildWelfareWindow.Init)()
end

GuildWelfareWindow.OnHide = function(...)
  -- function num : 0_8
end

GuildWelfareWindow.Init = function(...)
  -- function num : 0_9 , upvalues : GUILD_TIDY_SLOTS_AMOUNT, GuildWelfareWindow
  for i = 1, GUILD_TIDY_SLOTS_AMOUNT do
    (GuildWelfareWindow.RefreshSingleItem)(i)
  end
end

GuildWelfareWindow.RefreshSingleItem = function(index, ...)
  -- function num : 0_10 , upvalues : uis, _ENV, CLEAN_UP_DURATION
  local content = (uis.WelfareContent)["Content_0" .. tostring(index)]
  local pressPanel = (content.root):GetChildAt((content.root).numChildren - 2)
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R3 in 'UnsetPending'

  if (GuildData.RewardStatus)[index] ~= nil and not ((GuildData.RewardStatus)[index]).isDraw then
    (content.root).visible = true
    local tweener, ctrl = nil, nil
    do
      ctrl = pressPanel:GetController("c1")
      local longPress = (FairyGUI.LongPressGesture)(content.root)
      longPress:Enable(true)
      longPress.trigger = 0
      longPress.interval = 0.1
      local sound = nil
      longPress:AddEventListener("onLongPressBegin", function(...)
    -- function num : 0_10_0 , upvalues : sound, _ENV, ctrl, pressPanel, tweener, CLEAN_UP_DURATION, content, index
    sound = (LuaSound.PlaySound)(LuaSound.GUILD_WELFARE_TOUCH, SoundBank.OTHER)
    ctrl.selectedIndex = 1
    local bar = pressPanel:GetChild("ClearBar")
    bar.value = 0
    tweener = ((bar:TweenValue(100, CLEAN_UP_DURATION)):SetEase((FairyGUI.EaseType).Linear)):OnComplete(function(...)
      -- function num : 0_10_0_0 , upvalues : content, _ENV, index
      -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

      (content.root).visible = false
      ;
      (GuildService.ReqGuildGiftGet)(index)
    end
)
  end
)
      longPress:AddEventListener("onLongPressEnd", function(...)
    -- function num : 0_10_1 , upvalues : _ENV, sound, tweener, ctrl
    (LuaSound.StopSound)(sound)
    tweener:Kill(false)
    ctrl.selectedIndex = 0
  end
)
    end
  else
    do
      -- DECOMPILER ERROR at PC52: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (content.root).visible = false
      ;
      ((content.root).onTouchBegin):Clear()
      ;
      ((content.root).onTouchEnd):Clear()
    end
  end
end

GuildWelfareWindow.ClickRankingBtn = function(...)
  -- function num : 0_11 , upvalues : _ENV
  (GuildService.ReqGuildGiftRank)()
end

GuildWelfareWindow.OnClose = function(...)
  -- function num : 0_12 , upvalues : _ENV, GuildWelfareWindow, uis, contentPane, argTable
  (CommonWinMgr.RemoveAssets)((WinResConfig.GuildWelfareWindow).name)
  ;
  (GuildWelfareWindow.RemoveEvent)()
  uis = nil
  contentPane = nil
  argTable = {}
end

GuildWelfareWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_13 , upvalues : _ENV, GuildWelfareWindow
  if msgId == (WindowMsgEnum.Guild).E_MSG_REFRESH_WELFARE_STATUS then
    (GuildWelfareWindow.Init)()
  end
end

return GuildWelfareWindow

