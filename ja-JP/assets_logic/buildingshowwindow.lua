-- params : ...
-- function num : 0 , upvalues : _ENV
require("AdventureGame_BuildingShowWindowByName")
local BuildingShowWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local _totalProduction = 0
BuildingShowWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, BuildingShowWindow
  bridgeObj:SetView((WinResConfig.BuildingShowWindow).package, (WinResConfig.BuildingShowWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetAdventureGame_BuildingShowWindowUis(contentPane)
  ;
  (BuildingShowWindow.InitVariable)()
  ;
  (BuildingShowWindow.InitText)()
  ;
  (BuildingShowWindow.InitList)()
  ;
  (BuildingShowWindow.InitButtonEvent)()
end

BuildingShowWindow.InitVariable = function(...)
  -- function num : 0_1
end

BuildingShowWindow.InitText = function(...)
  -- function num : 0_2 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.BuildingShowGrp).GetAllBtn).text = (PUtil.get)(60000095)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.BuildingShowGrp).TitleTxt).text = (PUtil.get)(60000462)
end

BuildingShowWindow.InitList = function(...)
  -- function num : 0_3 , upvalues : uis, BuildingShowWindow
  ((uis.BuildingShowGrp).BuildinglList):SetVirtual()
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.BuildingShowGrp).BuildinglList).itemRenderer = BuildingShowWindow.RefreshBuildingItem
end

BuildingShowWindow.InitButtonEvent = function(...)
  -- function num : 0_4 , upvalues : uis, BuildingShowWindow
  (((uis.BuildingShowGrp).CloseBtn).onClick):Add(BuildingShowWindow.ClickCloseBtn)
  ;
  (((uis.BuildingShowGrp).GetAllBtn).onClick):Add(BuildingShowWindow.ClickGetAllBtn)
end

BuildingShowWindow.InitEvent = function(...)
  -- function num : 0_5
end

BuildingShowWindow.RemoveEvent = function(...)
  -- function num : 0_6
end

BuildingShowWindow.OnShown = function(...)
  -- function num : 0_7 , upvalues : BuildingShowWindow
  (BuildingShowWindow.InitEvent)()
  ;
  (BuildingShowWindow.Init)()
end

BuildingShowWindow.OnHide = function(...)
  -- function num : 0_8
end

BuildingShowWindow.Init = function(...)
  -- function num : 0_9 , upvalues : _totalProduction, uis, _ENV
  _totalProduction = 0
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.BuildingShowGrp).BuildinglList).numItems = #AdventureData.Buildings
end

BuildingShowWindow.OnClose = function(...)
  -- function num : 0_10 , upvalues : BuildingShowWindow, uis, contentPane, argTable
  (BuildingShowWindow.RemoveEvent)()
  uis = nil
  contentPane = nil
  argTable = {}
end

BuildingShowWindow.RefreshBuildingItem = function(index, item, ...)
  -- function num : 0_11 , upvalues : _ENV, _totalProduction
  index = index + 1
  local data = (AdventureData.Buildings)[index]
  local config = ((TableData.gTable).BaseAdventureBuildingData)[data]
  local goods = split(config.item, ":")
  ;
  (item:GetChild("NameTxt")).text = config.name
  ;
  (item:GetChild("ProduceTxt")).text = (PUtil.get)(60000428)
  ;
  (item:GetChild("ProduceIconLoader")).url = (Util.GetUrlFromItemID)(tonumber(goods[2]), tonumber(goods[1]))
  ;
  ((item:GetChild("BuildingGrp")):GetController("c1")).selectedIndex = tonumber(config.icon_path)
  if (AdventureData.BuildingInfo)[data] == nil then
    (item:GetController("c1")).selectedIndex = 1
    ;
    (item:GetChild("UnGet_01_Txt")).text = (PUtil.get)(60000463)
    ;
    (item:GetChild("UnGet_02_Txt")).text = (PUtil.get)(60000464)
  else
    data = (AdventureData.BuildingInfo)[data]
    ;
    (item:GetController("c1")).selectedIndex = 0
    if (data.totalOutput)[1] == nil then
      (item:GetChild("ProduceNumberTxt")).text = "0"
    else
      if (data.upperOutput)[1] ~= nil and ((data.totalOutput)[1]).value == ((data.upperOutput)[1]).value then
        (item:GetChild("ProduceNumberTxt")).text = "[color=" .. Const.YellowColor .. "]" .. GetFormatedCount(((data.totalOutput)[1]).value) .. "(" .. (PUtil.get)(60000432) .. ")[/color]"
      else
        ;
        (item:GetChild("ProduceNumberTxt")).text = GetFormatedCount(((data.totalOutput)[1]).value)
      end
      _totalProduction = _totalProduction + ((data.totalOutput)[1]).value
    end
    if #data.cardIndex == config.station_max then
      (item:GetChild("CardNumberTxt")).text = (PUtil.get)(60000096) .. "  [color=" .. Const.GreenColor .. "]" .. tostring(#data.cardIndex) .. "/" .. tostring(config.station_max) .. "[/color]"
    else
      ;
      (item:GetChild("CardNumberTxt")).text = (PUtil.get)(60000096) .. "  " .. tostring(#data.cardIndex) .. "/" .. tostring(config.station_max)
    end
    local btn = item:GetChild("GoBtn")
    btn.text = (PUtil.get)(60000072)
    ;
    (btn.onClick):Set(function(...)
    -- function num : 0_11_0 , upvalues : _ENV, data
    OpenWindow((WinResConfig.BuildingUseWindow).name, UILayer.HUD, data.buildingId)
  end
)
  end
end

BuildingShowWindow.ClickCloseBtn = function(...)
  -- function num : 0_12 , upvalues : _ENV
  UIMgr:CloseWindow((WinResConfig.BuildingShowWindow).name)
end

BuildingShowWindow.ClickGetAllBtn = function(...)
  -- function num : 0_13 , upvalues : _totalProduction, _ENV, BuildingShowWindow
  if _totalProduction == 0 then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000106))
    return 
  end
  ;
  (AdventureService.ReqAdventureBuilding)(AdventureBuildingOperateType.RequestReward)
  ;
  (BuildingShowWindow.ClickCloseBtn)()
end

BuildingShowWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_14 , upvalues : _ENV, BuildingShowWindow
  if msgId == (WindowMsgEnum.Adventure).E_MSG_REFRESH_BUILDING_STATUE then
    (BuildingShowWindow.Init)()
  end
end

return BuildingShowWindow

