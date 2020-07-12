-- params : ...
-- function num : 0 , upvalues : _ENV
require("GetWay_GetWayWindowByName")
local GetWayWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local _luaBridge, _currentFrame, _lastPos, _anim = nil, nil, nil, nil
GetWayWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, _luaBridge, uis, GetWayWindow
  bridgeObj:SetView((WinResConfig.GetWayWindow).package, (WinResConfig.GetWayWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  contentPane:Center()
  _luaBridge = bridgeObj
  uis = GetGetWay_GetWayWindowUis(contentPane)
  ;
  (GetWayWindow.InitVariable)()
  ;
  (GetWayWindow.InitList)()
  ;
  (GetWayWindow.InitText)()
  ;
  (GetWayWindow.InitButtonEvent)()
  ;
  (LuaSound.PlaySound)(LuaSound.COMMON_POP_WIN, SoundBank.OTHER)
end

GetWayWindow.InitVariable = function(...)
  -- function num : 0_1 , upvalues : _anim, uis
  _anim = ((uis.GetWay).ExchangeBtn):GetTransition("play")
end

GetWayWindow.InitText = function(...)
  -- function num : 0_2 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.GetWay).GetWayTxt).text = (PUtil.get)(29)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.GetWay).Button_01_Btn).text = (PUtil.get)(30)
end

GetWayWindow.InitList = function(...)
  -- function num : 0_3 , upvalues : uis, GetWayWindow
  ((uis.GetWay).GetWayList):SetVirtual()
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.GetWay).GetWayList).itemRenderer = GetWayWindow.RefreshWay
end

GetWayWindow.InitButtonEvent = function(...)
  -- function num : 0_4 , upvalues : uis, GetWayWindow
  (((uis.GetWay).Button_01_Btn).onClick):Add(GetWayWindow.ClickCloseBtn)
  ;
  (((uis.GetWay).Close_01_Btn).onClick):Add(GetWayWindow.ClickCloseBtn)
end

GetWayWindow.InitEvent = function(...)
  -- function num : 0_5
end

GetWayWindow.RemoveEvent = function(...)
  -- function num : 0_6
end

GetWayWindow.OnShown = function(...)
  -- function num : 0_7 , upvalues : GetWayWindow
  (GetWayWindow.InitEvent)()
  ;
  (GetWayWindow.Init)()
end

GetWayWindow.OnHide = function(...)
  -- function num : 0_8 , upvalues : GetWayWindow
  (GetWayWindow.RemoveEvent)()
end

GetWayWindow.Init = function(...)
  -- function num : 0_9 , upvalues : GetWayWindow, uis, _ENV, _luaBridge, _lastPos
  (GetWayWindow.InitData)()
  ;
  (GetWayWindow.InitBasicInfo)()
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.GetWay).GetWayList).numItems = #GetWayData.Ways
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R0 in 'UnsetPending'

  if _luaBridge.OpenFromClose then
    (((uis.GetWay).GetWayList).scrollPane).posY = _lastPos
  end
end

GetWayWindow.RefreshWay = function(index, item, ...)
  -- function num : 0_10 , upvalues : _ENV, _lastPos, uis, GetWayWindow, argTable
  local config = ((TableData.gTable).BaseClientGotoData)[tonumber((GetWayData.Ways)[index + 1])]
  ;
  (item:GetChild("TypeTxt")).text = config.name
  ;
  (item:GetChild("DungeonLoader")).url = (Util.GetItemUrl)(config.icon)
  ;
  (item:GetChild("NameTxt")).text = config.remark
  local ctr = item:GetController("c1")
  local timesText = item:GetChild("BattleNumberTxt")
  local gotoBtn = item:GetChild("SkipBtn")
  gotoBtn.text = (PUtil.get)(60000072)
  ;
  (gotoBtn.onClick):Set(function(...)
    -- function num : 0_10_0 , upvalues : _lastPos, uis, GetWayWindow, _ENV, config
    _lastPos = (((uis.GetWay).GetWayList).scrollPane).posY
    ;
    (GetWayWindow.ClickCloseBtn)()
    ;
    (GetWayMgr.Goto)(config.type, config.value)
  end
)
  if config.type == ControlID.Adventure_Plot or config.type == ControlID.Adventure_Hero then
    (PlotDungeonMgr.ExternalGetStageState)(config.type, config.value, function(unlock, remainTimes, totalTimes, ...)
    -- function num : 0_10_1 , upvalues : gotoBtn, _ENV, timesText, ctr, item
    gotoBtn.visible = unlock
    if unlock and totalTimes < Const.NoShowAmount then
      if remainTimes <= 0 then
        timesText.text = (PUtil.get)(60000075) .. ":" .. "[color=" .. Const.RedColor .. "]" .. tostring(remainTimes) .. "[/color]/" .. tostring(totalTimes)
      else
        timesText.text = (PUtil.get)(60000075) .. ":" .. "[color=" .. Const.GreenColor .. "]" .. tostring(remainTimes) .. "/" .. tostring(totalTimes) .. "[/color]"
      end
      ctr.selectedIndex = 0
    else
      if unlock == false then
        (item:GetChild("WordTxt")).text = (PUtil.get)(60000085)
        ctr.selectedIndex = 1
      else
        timesText.text = ""
        ctr.selectedIndex = 0
      end
    end
  end
)
    if config.type == ControlID.Adventure_Plot then
      (gotoBtn.onClick):Set(function(...)
    -- function num : 0_10_2 , upvalues : _lastPos, uis, GetWayWindow, _ENV, config, argTable
    _lastPos = (((uis.GetWay).GetWayList).scrollPane).posY
    ;
    (GetWayWindow.ClickCloseBtn)()
    ;
    (GetWayMgr.Goto)(config.type, config.value, argTable[1], argTable[4])
  end
)
    end
  else
    if ControlID.Shop_Grocer <= config.type and config.type <= ControlID.Shop_Expedition then
      ld("Shop")
      ;
      (ShopMgr.ExternalGetShopState)(config.type, config.type - 102000, function(unlock, ...)
    -- function num : 0_10_3 , upvalues : gotoBtn, item, _ENV, ctr, timesText
    gotoBtn.visible = unlock
    if unlock == false then
      (item:GetChild("WordTxt")).text = (PUtil.get)(60000085)
      ctr.selectedIndex = 1
    else
      timesText.text = ""
      ctr.selectedIndex = 0
    end
  end
)
    else
      gotoBtn.visible = (FunctionControlMgr.GetFunctionState)(config.type)
      timesText.text = ""
    end
  end
end

GetWayWindow.InitData = function(...)
  -- function num : 0_11 , upvalues : _ENV, argTable
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

  GetWayData.Config = (Util.GetConfigDataByID)(argTable[1])
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R0 in 'UnsetPending'

  if GetWayData.ShowType == PropType.ITEM and (GetWayData.Config).type == PropItemType.CHARACTER_DEBRIS then
    GetWayData.CurrentPieceInfo = (ActorData.GetCardPieceInfo)((GetWayData.Config).effect_value)
  end
  -- DECOMPILER ERROR at PC39: Confused about usage of register: R0 in 'UnsetPending'

  if (Util.StringIsNullOrEmpty)((GetWayData.Config).go_to_id) then
    GetWayData.Ways = {}
  else
    -- DECOMPILER ERROR at PC48: Confused about usage of register: R0 in 'UnsetPending'

    GetWayData.Ways = split((GetWayData.Config).go_to_id, ":")
  end
end

GetWayWindow.InitBasicInfo = function(...)
  -- function num : 0_12 , upvalues : _ENV, GetWayWindow, argTable, uis
  if GetWayData.ShowType == PropType.ITEM or GetWayData.ShowType == PropType.ASSET then
    if GetWayData.ShowType == PropType.ITEM and (GetWayData.Config).type == PropItemType.CHARACTER_DEBRIS then
      (GetWayWindow.InitPiecesCount)((GetWayData.CurrentPieceInfo).haveNum, argTable[3])
      -- DECOMPILER ERROR at PC41: Confused about usage of register: R0 in 'UnsetPending'

      ;
      ((uis.GetWay).ItemLoader).url = (Util.GetUrlFromItemID)((GetWayData.CurrentPieceInfo).id, GetWayData.ShowType)
    else
      ;
      (GetWayWindow.InitPiecesCount)((ActorData.GetGoodsCount)((GetWayData.Config).id, GetWayData.ShowType), argTable[3])
      -- DECOMPILER ERROR at PC64: Confused about usage of register: R0 in 'UnsetPending'

      ;
      ((uis.GetWay).ItemLoader).url = (Util.GetUrlFromItemID)((GetWayData.Config).id, GetWayData.ShowType)
    end
  end
  ;
  (CommonWinMgr.RegisterItemLongPress)((uis.GetWay).ItemLoader, (GetWayData.Config).id)
  ;
  (GetWayWindow.SetExchangeBtn)()
  -- DECOMPILER ERROR at PC80: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.GetWay).NameTxt).text = (GetWayData.Config).name
end

GetWayWindow.SetExchangeBtn = function(...)
  -- function num : 0_13 , upvalues : argTable, uis, _lastPos, _anim
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  if argTable[2] == nil then
    ((uis.GetWay).ExchangeBtn).visible = false
  else
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((uis.GetWay).ExchangeBtn).visible = true
    ;
    (((uis.GetWay).ExchangeBtn).onClick):Set(function(...)
    -- function num : 0_13_0 , upvalues : _lastPos, uis, _anim, argTable
    _lastPos = (((uis.GetWay).GetWayList).scrollPane).posY
    _anim:Play(-1, 0, nil)
    if argTable[2] ~= nil then
      (argTable[2])(function(...)
      -- function num : 0_13_0_0 , upvalues : _anim, uis
      _anim:Stop()
      ;
      (((uis.GetWay).ExchangeBtn):GetChild("n5")).alpha = 1
      ;
      (((uis.GetWay).ExchangeBtn):GetChild("n6")).alpha = 1
    end
)
    end
  end
)
  end
end

GetWayWindow.SetIconStatue = function(show, ...)
  -- function num : 0_14 , upvalues : uis
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R1 in 'UnsetPending'

  (((uis.GetWay).HeadDebrisGrp).root).visible = show
  -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((uis.GetWay).ItemFrameGrp).root).visible = not show
end

GetWayWindow.InitPiecesCount = function(haveNum, needNum, ...)
  -- function num : 0_15 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R2 in 'UnsetPending'

  if needNum ~= nil then
    if haveNum < needNum then
      ((uis.GetWay).NumberTxt).text = "[color=" .. Const.RedColor .. "]" .. tostring(haveNum) .. "[/color]" .. "/" .. tostring(needNum)
    else
      -- DECOMPILER ERROR at PC36: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((uis.GetWay).NumberTxt).text = "[color=" .. Const.GreenColor .. "]" .. tostring(haveNum) .. "[/color]" .. "/" .. tostring(needNum)
    end
  else
    -- DECOMPILER ERROR at PC52: Confused about usage of register: R2 in 'UnsetPending'

    if haveNum == 0 then
      ((uis.GetWay).NumberTxt).text = (PUtil.get)(60000111) .. "  " .. "[color=" .. Const.RedColor .. "]0[/color]"
    else
      -- DECOMPILER ERROR at PC65: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((uis.GetWay).NumberTxt).text = (PUtil.get)(60000111) .. "  " .. tostring(haveNum)
    end
  end
end

GetWayWindow.ClickCloseBtn = function(...)
  -- function num : 0_16 , upvalues : _ENV
  UIMgr:CloseWindow((WinResConfig.GetWayWindow).name)
end

GetWayWindow.OnClose = function(...)
  -- function num : 0_17 , upvalues : _anim, uis, contentPane, argTable, _luaBridge, _ENV
  _anim = nil
  uis = nil
  contentPane = nil
  argTable = {}
  _luaBridge = nil
  ;
  (CardData.CheckUpAllHeroRedPoint)()
  ;
  (AudioManager.DisposeCurAudioAndBubble)()
end

GetWayWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_18 , upvalues : _ENV, GetWayWindow
  if msgId == (WindowMsgEnum.CardWindow).E_MSG_CARD_AFTER_EXCHANGE then
    (GetWayWindow.Init)()
  end
end

return GetWayWindow

