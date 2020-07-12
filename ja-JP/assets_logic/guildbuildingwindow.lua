-- params : ...
-- function num : 0 , upvalues : _ENV
require("Guild_BuildByName")
local WATER_MIN_POS = -282
local WATER_MAX_POS = -15
local GuildBuildingWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local _buildCostPanel = {}
local _statusTxt, _loopEffect, _waterEffect, _progressCom, _showingProgress, _tweener = nil, nil, nil, nil, nil, nil
GuildBuildingWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, GuildBuildingWindow
  bridgeObj:SetView((WinResConfig.GuildBuildingWindow).package, (WinResConfig.GuildBuildingWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetGuild_BuildUis(contentPane)
  ;
  (GuildBuildingWindow.InitTopMenu)()
  ;
  (GuildBuildingWindow.InitVariable)()
  ;
  (GuildBuildingWindow.InitText)()
  ;
  (GuildBuildingWindow.InitButtonEvent)()
  ;
  (GuildBuildingWindow.InitUIEffect)()
end

GuildBuildingWindow.InitTopMenu = function(...)
  -- function num : 0_1 , upvalues : _ENV, uis
  local m = {}
  m.windowName = (WinResConfig.GuildBuildingWindow).name
  m.Tip = (PUtil.get)(60000255)
  m.model = uis.AssetStripGrp
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.SHOP_TOKEN}
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

GuildBuildingWindow.InitVariable = function(...)
  -- function num : 0_2 , upvalues : _buildCostPanel, _ENV, uis, _statusTxt
  _buildCostPanel[GuildBuildType.Gold] = (uis.Build_B_Grp).BuildTips_A
  _buildCostPanel[GuildBuildType.Diamond] = (uis.Build_B_Grp).BuildTips_B
  _buildCostPanel[GuildBuildType.Ultra] = (uis.Build_B_Grp).BuildTips_C
  _statusTxt = ((uis.Build_B_Grp).root):GetChild("ExplainTxt")
end

GuildBuildingWindow.InitText = function(...)
  -- function num : 0_3 , upvalues : uis, _ENV, _buildCostPanel
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.Build_B_Grp).Word_01_Txt).text = (PUtil.get)(60000263)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((_buildCostPanel[GuildBuildType.Gold]).WordTxt).text = (PUtil.get)(60000100)
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((_buildCostPanel[GuildBuildType.Diamond]).WordTxt).text = (PUtil.get)(60000100)
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((_buildCostPanel[GuildBuildType.Ultra]).WordTxt).text = (PUtil.get)(60000100)
end

GuildBuildingWindow.InitButtonEvent = function(...)
  -- function num : 0_4
end

GuildBuildingWindow.InitUIEffect = function(...)
  -- function num : 0_5 , upvalues : _loopEffect, _ENV, uis, _waterEffect, _progressCom
  _loopEffect = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_GUILD_BUILDING_LOOP, false, false, nil)
  _loopEffect:SetXY((((uis.Build_B_Grp).BuildEffect_A_Grp).root).width * 0.5, (((uis.Build_B_Grp).BuildEffect_A_Grp).root).height * 0.5)
  ;
  (((uis.Build_B_Grp).BuildEffect_A_Grp).root):AddChild(_loopEffect)
  _waterEffect = (ResHelper.InstantiateEffect)(UIEffectEnum.UI_GUILD_BUILD_EFFECT_WATER)
  ;
  (CSLuaUtil.ChangeLayer)(_waterEffect.transform, "UI")
  _progressCom = (_waterEffect.transform):Find("FX_ui_gonghuijianshe_zhangshui_grp/Mesh_low_plane")
  ;
  (_waterEffect.transform):SetParent((((((uis.Build_B_Grp).BuildEffect_A_Grp).root).displayObject).gameObject).transform)
  -- DECOMPILER ERROR at PC56: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (_waterEffect.transform).localScale = Vector3.one
  -- DECOMPILER ERROR at PC63: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (_waterEffect.transform).localPosition = Vector3(182, -202, 0)
  ;
  (SimpleTimer.setTimeout)(0.1, function(...)
    -- function num : 0_5_0 , upvalues : uis, _ENV, _waterEffect
    local renderer = (((((uis.Build_B_Grp).root):GetChild("n78")).displayObject).gameObject):GetComponent(typeof((CS.UnityEngine).Renderer))
    local renderS = _waterEffect:GetComponentsInChildren(typeof((CS.UnityEngine).Renderer))
    local count = renderS.Length
    for i = 0, count - 1 do
      -- DECOMPILER ERROR at PC30: Confused about usage of register: R7 in 'UnsetPending'

      (renderS[i]).sortingOrder = renderer.sortingOrder + 1
    end
  end
)
end

GuildBuildingWindow.InitEvent = function(...)
  -- function num : 0_6
end

GuildBuildingWindow.RemoveEvent = function(...)
  -- function num : 0_7
end

GuildBuildingWindow.OnShown = function(...)
  -- function num : 0_8 , upvalues : GuildBuildingWindow
  (GuildBuildingWindow.InitEvent)()
  ;
  (GuildBuildingWindow.Init)()
end

GuildBuildingWindow.OnHide = function(...)
  -- function num : 0_9
end

GuildBuildingWindow.Init = function(...)
  -- function num : 0_10 , upvalues : _ENV, uis, GuildBuildingWindow
  (GuildMgr.InitGuildBasicInfoPanel)(uis.MainInformationGrp, GuildDetailPanelType.Building)
  ;
  (GuildBuildingWindow.RefreshBuildTimes)()
  ;
  (GuildBuildingWindow.RefreshRewards)()
  ;
  (GuildBuildingWindow.InitBuildCost)()
end

GuildBuildingWindow.OnClose = function(...)
  -- function num : 0_11 , upvalues : _tweener, _ENV, GuildBuildingWindow, _loopEffect, _waterEffect, uis, contentPane, argTable
  if _tweener ~= nil then
    _tweener:Kill()
  end
  ;
  (CommonWinMgr.RemoveAssets)((WinResConfig.GuildBuildingWindow).name)
  ;
  (GuildBuildingWindow.RemoveEvent)()
  if _loopEffect ~= nil then
    _loopEffect:Dispose()
    _loopEffect = nil
  end
  if _waterEffect ~= nil then
    (ResHelper.DestroyGameObject)(_waterEffect, false)
    _waterEffect = nil
  end
  uis = nil
  contentPane = nil
  argTable = {}
end

GuildBuildingWindow.RefreshRewards = function(...)
  -- function num : 0_12 , upvalues : _ENV, uis, _showingProgress, _progressCom, WATER_MIN_POS, WATER_MAX_POS, _tweener, _statusTxt
  local vigourConfig = (GuildData.VigourConfig)[(GuildData.BaseInfo).dayFixationLevel]
  local maxVigour = (vigourConfig[#vigourConfig]).Value
  local vigour = (GuildData.BuildingInfo).buildingPlan
  if maxVigour < vigour then
    vigour = maxVigour
  end
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((uis.Build_B_Grp).NumberTxt).text = tostring(vigour) .. "/" .. tostring(maxVigour)
  if _showingProgress == nil or vigour <= _showingProgress then
    _progressCom.localPosition = Vector3((_progressCom.localPosition).x, WATER_MIN_POS + (WATER_MAX_POS - WATER_MIN_POS) * vigour / maxVigour, (_progressCom.localPosition).z)
    _showingProgress = vigour
  else
    local holder = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_GUILD_BUILD_EFFECT, true)
    holder:SetXY((((uis.Build_B_Grp).BuildEffect_A_Grp).root).width * 0.5, (((uis.Build_B_Grp).BuildEffect_A_Grp).root).height * 0.5)
    ;
    (((uis.Build_B_Grp).BuildEffect_A_Grp).root):AddChild(holder)
    local beginPos, endPos = nil, nil
    if _tweener == nil then
      beginPos = WATER_MIN_POS + (WATER_MAX_POS - WATER_MIN_POS) * _showingProgress / maxVigour
    else
      _tweener:Kill()
      beginPos = (_progressCom.localPosition).y
    end
    local endPos = WATER_MIN_POS + (WATER_MAX_POS - WATER_MIN_POS) * vigour / maxVigour
    _tweener = (((FairyGUI.GTween).To)(beginPos, endPos, 0.5)):SetEase((FairyGUI.EaseType).Linear)
    ;
    (_tweener:OnUpdate(function(...)
    -- function num : 0_12_0 , upvalues : _progressCom, _ENV, _tweener
    _progressCom.localPosition = Vector3((_progressCom.localPosition).x, (_tweener.value).x, (_progressCom.localPosition).z)
  end
)):OnComplete(function(...)
    -- function num : 0_12_1 , upvalues : _tweener
    _tweener = nil
  end
)
    _showingProgress = vigour
  end
  do
    ;
    (((uis.Build_B_Grp).BigRewardBtn).onClick):Clear()
    local count = #vigourConfig
    local found = false
    do
      for i = 1, count do
        local data = vigourConfig[i]
        if ((GuildData.BuildingInfo).RewardStatus)[data.Id] == nil then
          found = true
          local rewards = split(data.Rewards, ":")
          local imgStr = "<img src=\'" .. (Util.GetUrlFromItemID)(tonumber(rewards[2]), tonumber(rewards[1])) .. "\' width=\'32\' height=\'32\'/>"
          if vigour < data.Value then
            _statusTxt.text = (PUtil.get)(60000291, data.Value, imgStr .. rewards[3])
            -- DECOMPILER ERROR at PC168: Confused about usage of register: R12 in 'UnsetPending'

            ;
            ((uis.Build_B_Grp).c1Ctr).selectedIndex = 0
            break
          end
          -- DECOMPILER ERROR at PC172: Confused about usage of register: R12 in 'UnsetPending'

          ;
          ((uis.Build_B_Grp).c1Ctr).selectedIndex = 1
          _statusTxt.text = (PUtil.get)(60000292, imgStr .. rewards[3])
          ;
          (((uis.Build_B_Grp).BigRewardBtn).onClick):Set(function(...)
    -- function num : 0_12_2 , upvalues : _ENV, data
    (GuildMgr.ReqGetGuildVigourGift)(data.Id)
  end
)
          break
        end
      end
    end
    do
      if found == false then
        _statusTxt.text = (PUtil.get)(60000293)
        -- DECOMPILER ERROR at PC199: Confused about usage of register: R5 in 'UnsetPending'

        ;
        ((uis.Build_B_Grp).c1Ctr).selectedIndex = 0
        ;
        ((((uis.Build_B_Grp).BuildEffect_A_Grp).root).onClick):Set(function(...)
    -- function num : 0_12_3 , upvalues : _ENV
    (MessageMgr.SendCenterTips)((PUtil.get)(60000293))
  end
)
      end
    end
  end
end

GuildBuildingWindow.AcquireGuildVigourGift = function(id, req, ...)
  -- function num : 0_13
  if req then
  end
end

GuildBuildingWindow.RefreshBuildTimes = function(...)
  -- function num : 0_14 , upvalues : _ENV, uis
  local leftTimes = (((TableData.gTable).BaseFixedData)[GuildData.DAILY_BUILD_LIMIT]).int_value - (GuildData.BuildingInfo).buildingNum
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R1 in 'UnsetPending'

  if leftTimes == 0 then
    ((uis.Build_B_Grp).BuildNumberTxt).text = (PUtil.get)(60000247, "[color=" .. Const.RedColor .. "]0[/color]", (((TableData.gTable).BaseFixedData)[GuildData.DAILY_BUILD_LIMIT]).int_value)
  else
    -- DECOMPILER ERROR at PC47: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((uis.Build_B_Grp).BuildNumberTxt).text = (PUtil.get)(60000247, leftTimes, (((TableData.gTable).BaseFixedData)[GuildData.DAILY_BUILD_LIMIT]).int_value)
  end
end

GuildBuildingWindow.InitBuildCost = function(...)
  -- function num : 0_15 , upvalues : _ENV, GuildBuildingWindow
  for i = GuildBuildType.Gold, GuildBuildType.Ultra do
    (GuildBuildingWindow.RefreshSingleBuildCost)(i)
  end
end

GuildBuildingWindow.RefreshSingleBuildCost = function(type, ...)
  -- function num : 0_16 , upvalues : _buildCostPanel, _ENV
  local panel = _buildCostPanel[type]
  local config = ((TableData.gTable).BaseGuildBuildData)[(GuildData.BuildConfig)[type]]
  ;
  (Util.SetCurrencyWithConfig)(config.cost, panel.Spend_01_Loader, panel.SpendTxt)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (panel.Spend_01_Loader).alpha = 1
  local rewards = split(config.rewards, ",")
  ;
  (panel.RewardList):RemoveChildrenToPool()
  local count = #rewards
  local item, cost = nil, nil
  for i = 1, count do
    item = (panel.RewardList):AddItemFromPool()
    cost = split(rewards[i], ":")
    ;
    (item:GetChild("Spend_01_Loader")).url = (Util.GetUrlFromItemID)(tonumber(cost[2]), tonumber(cost[1]))
    ;
    (item:GetChild("SpendTxt")).text = tostring(cost[3])
  end
  if config.guild_exp > 0 then
    item = (panel.RewardList):AddItemFromPool()
    ;
    (item:GetChild("Spend_01_Loader")).url = (Util.GetUrlFromItemID)(AssetType.GUILD_TOKEN, PropType.ASSET)
    ;
    (item:GetChild("SpendTxt")).text = config.guild_exp
  end
  -- DECOMPILER ERROR at PC87: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (panel.SpendBtn).text = (PUtil.get)(60000248)
  ;
  ((panel.SpendBtn).onClick):Set(function(...)
    -- function num : 0_16_0 , upvalues : _ENV, type, config
    (GuildMgr.ReqGuildBuild)(type, config.cost)
  end
)
end

GuildBuildingWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_17 , upvalues : _ENV, GuildBuildingWindow, uis
  if msgId == (WindowMsgEnum.Guild).E_MSG_REFRESH_BUILD_INFO then
    (GuildBuildingWindow.RefreshBuildTimes)()
    ;
    (GuildBuildingWindow.RefreshRewards)()
    ;
    (GuildBuildingWindow.InitBuildCost)()
    ;
    (GuildMgr.InitBuildingLog)(uis.MainInformationGrp)
  end
end

return GuildBuildingWindow

