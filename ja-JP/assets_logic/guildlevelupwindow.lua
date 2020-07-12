-- params : ...
-- function num : 0 , upvalues : _ENV
require("Guild_GuildLevelUpByName")
local GuildLevelUpWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local modelPath = "HomeTaskSpine_11301004"
GuildLevelUpWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis
  bridgeObj:SetView((WinResConfig.GuildLevelUpWindow).package, (WinResConfig.GuildLevelUpWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  local level = argTable[1]
  uis = GetGuild_GuildLevelUpUis(contentPane)
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.IconLoader).url = (GuildData.GetGuildIcon)((GuildData.BaseInfo).icon)
  ;
  ((uis.TouchScreenBtn).onClick):Set(function(...)
    -- function num : 0_0_0 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.GuildLevelUpWindow).name)
  end
)
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.TouchTxt).text = (PUtil.get)(20000224)
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.WordTxt).UBBEnabled = true
  -- DECOMPILER ERROR at PC50: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.WordTxt).text = (PUtil.get)(20000225, "[color=" .. Const.GreenColor .. "]" .. level .. "[/color]")
  local title = (uis.root):GetChild("n21")
  local pos = Vector2(title.x + title.width * 0.5, title.y + title.height * 0.5)
  ;
  (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_UNLOCK, true, uis.root, pos)
  ;
  (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_CHARACTER_LEVEL_UP, false, uis.root, Vector2((GRoot.inst).width / 2, (GRoot.inst).height * 1 / 2))
end

GuildLevelUpWindow.OnShown = function(...)
  -- function num : 0_1
end

GuildLevelUpWindow.OnHide = function(...)
  -- function num : 0_2
end

GuildLevelUpWindow.OnClose = function(...)
  -- function num : 0_3 , upvalues : uis, contentPane, argTable
  uis = nil
  contentPane = nil
  argTable = {}
end

GuildLevelUpWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_4
end

return GuildLevelUpWindow

