-- params : ...
-- function num : 0 , upvalues : _ENV
require("AdventureGame_BuildingUseWindowByName")
local BuildingUseWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local _buildingData, _buildingConfig = nil, nil
local _totalFC = 0
BuildingUseWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, BuildingUseWindow
  bridgeObj:SetView((WinResConfig.BuildingUseWindow).package, (WinResConfig.BuildingUseWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetAdventureGame_BuildingUseWindowUis(contentPane)
  ;
  (BuildingUseWindow.InitVariable)()
  ;
  (BuildingUseWindow.InitText)()
  ;
  (BuildingUseWindow.InitButtonEvent)()
end

BuildingUseWindow.InitVariable = function(...)
  -- function num : 0_1
end

BuildingUseWindow.InitText = function(...)
  -- function num : 0_2 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.BuildingUseGrp).FunctionBtn).text = (PUtil.get)(60000402)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.BuildingUseGrp).RateTxt).text = (PUtil.get)(60000428)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.BuildingUseGrp).GetTxt).text = (PUtil.get)(60000430)
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.BuildingUseGrp).TotalTxt).text = (PUtil.get)(60000431)
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.BuildingUseGrp).TitleTxt).text = (PUtil.get)(60000462)
end

BuildingUseWindow.InitButtonEvent = function(...)
  -- function num : 0_3 , upvalues : uis, BuildingUseWindow
  (((uis.BuildingUseGrp).CloseBtn).onClick):Add(BuildingUseWindow.ClickCloseBtn)
  ;
  (((uis.BuildingUseGrp).FunctionBtn).onClick):Add(BuildingUseWindow.ClickUnlockBtn)
end

BuildingUseWindow.InitEvent = function(...)
  -- function num : 0_4
end

BuildingUseWindow.RemoveEvent = function(...)
  -- function num : 0_5
end

BuildingUseWindow.OnShown = function(...)
  -- function num : 0_6 , upvalues : BuildingUseWindow
  (BuildingUseWindow.InitEvent)()
  ;
  (BuildingUseWindow.Init)()
end

BuildingUseWindow.OnHide = function(...)
  -- function num : 0_7
end

BuildingUseWindow.Init = function(showEffect, ...)
  -- function num : 0_8 , upvalues : BuildingUseWindow
  (BuildingUseWindow.InitData)()
  ;
  (BuildingUseWindow.InitBasicInfo)(showEffect)
end

BuildingUseWindow.InitData = function(...)
  -- function num : 0_9 , upvalues : _buildingData, _ENV, argTable, _buildingConfig
  _buildingData = (AdventureData.BuildingInfo)[argTable[1]]
  _buildingConfig = ((TableData.gTable).BaseAdventureBuildingData)[argTable[1]]
end

BuildingUseWindow.InitBasicInfo = function(showEffect, ...)
  -- function num : 0_10 , upvalues : uis, _buildingConfig, _ENV, BuildingUseWindow
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  ((uis.BuildingUseGrp).BuildingNameTxt).text = _buildingConfig.name
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((uis.BuildingUseGrp).BuildingGrp).c1Ctr).selectedIndex = tonumber(_buildingConfig.icon_path)
  do
    if showEffect then
      local holder = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_ADVENTUREGAME_UNLOCK_BUILDING, true, true)
      ;
      (((uis.BuildingUseGrp).BuildingGrp).root):AddChild(holder)
      holder:SetXY((((uis.BuildingUseGrp).BuildingGrp).root).width * 0.5, (((uis.BuildingUseGrp).BuildingGrp).root).height)
    end
    ;
    (BuildingUseWindow.RefreshProduceInfo)()
    ;
    (BuildingUseWindow.RefreshLockStatue)()
    ;
    (BuildingUseWindow.RefreshCardInfo)()
  end
end

BuildingUseWindow.RefreshLockStatue = function(...)
  -- function num : 0_11 , upvalues : uis, _buildingData
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.BuildingUseGrp).FunctionBtn).visible = _buildingData == nil
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BuildingUseWindow.RefreshProduceInfo = function(...)
  -- function num : 0_12 , upvalues : _ENV, _buildingConfig, uis, _totalFC, _buildingData
  local item = split(_buildingConfig.item, ":")
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.BuildingUseGrp).RateIconLoader).url = (Util.GetUrlFromItemID)(tonumber(item[2]), tonumber(item[1]))
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.BuildingUseGrp).GetIconLoader).url = (Util.GetUrlFromItemID)(tonumber(item[2]), tonumber(item[1]))
  -- DECOMPILER ERROR at PC39: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.BuildingUseGrp).TotalIconLoader).url = (Util.GetUrlFromItemID)(tonumber(item[2]), tonumber(item[1]))
  _totalFC = 0
  if _buildingData == nil then
    (((uis.BuildingUseGrp).root):GetChild("Get")).visible = false
    ;
    (((uis.BuildingUseGrp).root):GetChild("Total")).visible = false
    -- DECOMPILER ERROR at PC63: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((uis.BuildingUseGrp).RateNumberTxt).text = (AdventureData.GetBuildingProduceSpeed)(_buildingConfig.id)
  else
    local count = #_buildingData.cardIndex
    ;
    (((uis.BuildingUseGrp).root):GetChild("Get")).visible = count ~= 0
    ;
    (((uis.BuildingUseGrp).root):GetChild("Total")).visible = count ~= 0
    -- DECOMPILER ERROR at PC93: Confused about usage of register: R2 in 'UnsetPending'

    if (_buildingData.totalOutput)[1] == nil then
      ((uis.BuildingUseGrp).GetNumberTxt).text = "0"
    else
      -- DECOMPILER ERROR at PC125: Confused about usage of register: R2 in 'UnsetPending'

      if (_buildingData.upperOutput)[1] ~= nil and ((_buildingData.totalOutput)[1]).value == ((_buildingData.upperOutput)[1]).value then
        ((uis.BuildingUseGrp).GetNumberTxt).text = "[color=" .. Const.YellowColor .. "]" .. GetFormatedCount(((_buildingData.totalOutput)[1]).value) .. "(" .. (PUtil.get)(60000432) .. ")[/color]"
      else
        -- DECOMPILER ERROR at PC134: Confused about usage of register: R2 in 'UnsetPending'

        ((uis.BuildingUseGrp).GetNumberTxt).text = GetFormatedCount(((_buildingData.totalOutput)[1]).value)
      end
    end
    local cardData = nil
    for i = 1, count do
      _totalFC = _totalFC + ((CardData.GetCardData)(((_buildingData.cardIndex)[i]).id)).fc
    end
    local enhance = (AdventureData.GetFCEnhanceEffect)(_totalFC)
    -- DECOMPILER ERROR at PC167: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((uis.BuildingUseGrp).TotalNumberTxt).text = (string.format)("%d", (math.floor)(enhance * 100)) .. "%"
    -- DECOMPILER ERROR at PC175: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((uis.BuildingUseGrp).RateNumberTxt).text = (AdventureData.GetBuildingProduceSpeed)(_buildingConfig.id, enhance)
  end
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

BuildingUseWindow.RefreshCardInfo = function(...)
  -- function num : 0_13 , upvalues : _buildingData, _ENV, uis, _totalFC, BuildingUseWindow
  if _buildingData == nil then
    for i = 1, AdventureData.MAX_GUARD_AMOUNT do
      local com = (uis.BuildingUseGrp)["Card_0" .. tostring(i) .. "_Grp"]
      do
        -- DECOMPILER ERROR at PC17: Confused about usage of register: R5 in 'UnsetPending'

        (com.c1Ctr).selectedIndex = 0
        ;
        ((com.root).onClick):Clear()
        -- DECOMPILER ERROR at PC27: Confused about usage of register: R5 in 'UnsetPending'

        ;
        (com.SeatTxt).text = (PUtil.get)(60000105)
        -- DECOMPILER ERROR at PC33: Confused about usage of register: R5 in 'UnsetPending'

        ;
        (com.LockTxt).text = (PUtil.get)(60000466)
      end
    end
  else
    do
      for i = 1, AdventureData.MAX_GUARD_AMOUNT do
        local index = i
        local count = #_buildingData.cardIndex
        local cardData = nil
        for j = 1, count do
          if ((_buildingData.cardIndex)[j]).value == i then
            cardData = (_buildingData.cardIndex)[j]
          end
        end
        local com = (uis.BuildingUseGrp)["Card_0" .. tostring(i) .. "_Grp"]
        -- DECOMPILER ERROR at PC68: Confused about usage of register: R8 in 'UnsetPending'

        if cardData ~= nil then
          (com.c1Ctr).selectedIndex = 1
          ;
          ((com.root).onClick):Set(function(...)
    -- function num : 0_13_0 , upvalues : _ENV, _buildingData, _totalFC, cardData
    (AdventureMgr.OpenBuildingCardChoiceWindow)(_buildingData.buildingId, _totalFC, true, cardData)
  end
)
          -- DECOMPILER ERROR at PC80: Confused about usage of register: R8 in 'UnsetPending'

          ;
          (com.SeatTxt).text = ((CardData.GetCardData)(cardData.id)).name
          ;
          (BuildingUseWindow.RefreshSingleCardInfo)(com, cardData.id)
        else
          -- DECOMPILER ERROR at PC87: Confused about usage of register: R8 in 'UnsetPending'

          ;
          (com.c1Ctr).selectedIndex = 2
          ;
          ((com.root).onClick):Set(function(...)
    -- function num : 0_13_1 , upvalues : _ENV, _buildingData, _totalFC, index
    (AdventureMgr.OpenBuildingCardChoiceWindow)(_buildingData.buildingId, _totalFC, false, index)
  end
)
          ;
          (Util.RecycleUIModel)(com.CardLoader)
          -- DECOMPILER ERROR at PC102: Confused about usage of register: R8 in 'UnsetPending'

          ;
          (com.SeatTxt).text = (PUtil.get)(60000105)
          -- DECOMPILER ERROR at PC108: Confused about usage of register: R8 in 'UnsetPending'

          ;
          (com.AddTxt).text = (PUtil.get)(60000467)
        end
      end
    end
  end
end

BuildingUseWindow.RefreshSingleCardInfo = function(grp, cardId, ...)
  -- function num : 0_14 , upvalues : _ENV
  local cardData = (CardData.GetCardData)(cardId)
  local fashion = (CardData.GetFashionConfig)(cardData)
  ;
  (Util.RecycleUIModel)(grp.CardLoader)
  ;
  (Util.CreateMiniModel)(grp.CardLoader, fashion.id)
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (grp.BattleWordTxt).text = (PUtil.get)(60000235)
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (grp.BattleNumberTxt).text = cardData.fc
end

BuildingUseWindow.OnClose = function(...)
  -- function num : 0_15 , upvalues : BuildingUseWindow, _ENV, uis, contentPane, argTable
  (BuildingUseWindow.PreClose)()
  ;
  (BuildingUseWindow.RemoveEvent)()
  for i = 1, AdventureData.MAX_GUARD_AMOUNT do
    (Util.RecycleUIModel)(((uis.BuildingUseGrp)["Card_0" .. tostring(i) .. "_Grp"]).CardLoader)
  end
  uis = nil
  contentPane = nil
  argTable = {}
end

BuildingUseWindow.PreClose = function(...)
  -- function num : 0_16 , upvalues : _ENV, uis, argTable
  (AdventureMgr.CheckBuildingEvent)(((uis.BuildingUseGrp).FunctionBtn).visible, argTable[2])
end

BuildingUseWindow.ClickCloseBtn = function(...)
  -- function num : 0_17 , upvalues : _ENV
  UIMgr:CloseWindow((WinResConfig.BuildingUseWindow).name)
end

BuildingUseWindow.ClickUnlockBtn = function(...)
  -- function num : 0_18 , upvalues : _ENV, argTable
  (AdventureService.ReqAdventureBuilding)(AdventureBuildingOperateType.Unlock, {id = argTable[2], value = argTable[1]})
end

BuildingUseWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_19 , upvalues : _ENV, BuildingUseWindow
  if para ~= AdventureBuildingOperateType.Unlock then
    (BuildingUseWindow.Init)(msgId ~= (WindowMsgEnum.Adventure).E_MSG_REFRESH_BUILDING_STATUE)
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

return BuildingUseWindow

