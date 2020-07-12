-- params : ...
-- function num : 0 , upvalues : _ENV
require("Expedition_ExpeditionByName")
GTween = FairyGUI.GTween
local ExpeditionWindow = {}
local RelationType = FairyGUI.RelationType
SwipeGesture = FairyGUI.SwipeGesture
local Swipe, uis, contentPane = nil, nil, nil
local argTable = {}
local expeditionData = nil
local IconList = {}
local LineList = {}
local SpotList = {}
local pointName = "Map_A_003_Grp"
local MapBg = nil
local isCanClick = true
local CloudList, PointBackMoveTo = nil, nil
local sfxHolder = {}
local bgPercent = 0.3
local stageSortNum = 0
local putHolder = nil
ExpeditionWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, sfxHolder, uis, ExpeditionWindow, expeditionData, stageSortNum, putHolder
  bridgeObj:SetView((WinResConfig.ExpeditionWindow).package, (WinResConfig.ExpeditionWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  sfxHolder = {}
  uis = GetExpedition_ExpeditionUis(contentPane)
  ;
  (ExpeditionWindow.InitAssetStrip)()
  local eId = (ExpeditionMgr.GetCurrentExpeditionId)()
  expeditionData = ((TableData.gTable).BaseExpeditionData)[tonumber(eId)]
  stageSortNum = (ExpeditionMgr.GetExpeditionNum)(eId)
  putHolder = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_EXPEDITION_CHALLENGE)
  putHolder.visible = false
  ;
  (ExpeditionWindow.InitMap)()
  ;
  (((uis.Map_002_List).scrollPane).onScroll):Set(ExpeditionWindow.OnMapScroll)
end

ExpeditionWindow.SetBgPos = function(...)
  -- function num : 0_1 , upvalues : uis, bgPercent
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.Map_001_List).scrollPane).posX = ((uis.Map_002_List).scrollPane).posX * bgPercent
end

ExpeditionWindow.OnMapScroll = function(...)
  -- function num : 0_2 , upvalues : ExpeditionWindow
  (ExpeditionWindow.SetBgPos)()
end

ExpeditionWindow.InitMap = function(...)
  -- function num : 0_3 , upvalues : _ENV, expeditionData, uis, ExpeditionWindow
  local mapStr = split(expeditionData.stage_path, ":")
  local map = UIMgr:CreateObject(mapStr[1], mapStr[2] .. "_001")
  ;
  (uis.Map_001_List):AddChild(map)
  local map = UIMgr:CreateObject(mapStr[1], mapStr[2] .. "_002")
  ;
  (uis.Map_002_List):AddChild(map)
  ;
  (ExpeditionWindow.InitPointBottom)()
end

ExpeditionWindow.PlayCloudAni = function(IsIn, ...)
  -- function num : 0_4 , upvalues : uis, _ENV
  local mLoader = uis.CloudLoader
  if mLoader.Model == nil and IsIn then
    (Util.ShowUIModel)("ui_sweep", mLoader, nil, false, function(obj, ...)
    -- function num : 0_4_0 , upvalues : _ENV
    (CSLuaUtil.SetGOScale)(obj, 100, 100, 100, false)
    ;
    (CSLuaUtil.SetGOLocalPos)(obj, 0, 0, 0)
    ;
    (SkeletonAnimationUtil.SetAnimation)(obj, 0, "in", false, function(...)
      -- function num : 0_4_0_0 , upvalues : _ENV, obj
      (SkeletonAnimationUtil.SetAnimation)(obj, 0, "idle", true)
    end
)
  end
)
  else
    local model = (mLoader.Model).gameObject
    do
      if IsIn then
        (SkeletonAnimationUtil.SetAnimation)(model, 0, "in", false, function(...)
    -- function num : 0_4_1 , upvalues : _ENV, model
    (SkeletonAnimationUtil.SetAnimation)(model, 0, "idle", true)
  end
)
      else
        if model then
          (SkeletonAnimationUtil.SetAnimation)(model, 0, "out", false, function(...)
    -- function num : 0_4_2 , upvalues : _ENV, mLoader
    (Util.RecycleUIModel)(mLoader, true)
  end
)
        end
      end
    end
  end
end

ExpeditionWindow.OnShown = function(...)
  -- function num : 0_5 , upvalues : _ENV, ExpeditionWindow, uis
  local swTime = (ExpeditionMgr.SweepNum)()
  if swTime > 0 then
    (ExpeditionWindow.PlayCloudAni)(true)
  end
  ;
  (ExpeditionWindow.SetBuff)()
  ;
  (ExpeditionWindow.ExternalShopBtn)()
  if ExpeditionMgr.guideTips ~= nil then
    (Util.ShowGuideTips)(GuideTipsCheckPoint.PassExpedition, Expedition.guideTips)
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R1 in 'UnsetPending'

    ExpeditionMgr.guideTips = nil
  end
  ;
  ((ExpeditionMgr.ChapterSortNum)())
  local sortNum = nil
  local effName = nil
  if sortNum == 1 then
    effName = UIEffectEnum.UI_EXPEDITION__ATMOSPHERE_01
  else
    if sortNum == 2 then
      effName = UIEffectEnum.UI_EXPEDITION__ATMOSPHERE_02
    else
      effName = UIEffectEnum.UI_EXPEDITION__ATMOSPHERE_03
    end
  end
  ;
  (LuaEffect.CreateEffectToObj)(effName, false, uis.root, Vector2(DesignScreen.width / 2, DesignScreen.height / 2))
end

ExpeditionWindow.InitListPos = function(...)
  -- function num : 0_6 , upvalues : _ENV, IconList, uis, ExpeditionWindow
  local stageID = (ExpeditionMgr.GetCurrentStage)()
  local obj = IconList[stageID]
  if obj then
    local pos = obj.x - DesignScreen.width / 2
    local offsetX = (Umath.Clamp)(pos, 0, 100000)
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R4 in 'UnsetPending'

    ;
    ((uis.Map_002_List).scrollPane).posX = offsetX
  else
    do
      -- DECOMPILER ERROR at PC28: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((uis.Map_002_List).scrollPane).posX = ((uis.Map_002_List):GetChildAt(0)).width
      ;
      (ExpeditionWindow.SetBgPos)()
    end
  end
end

ExpeditionWindow.InitPointBottom = function(notScroll, ...)
  -- function num : 0_7 , upvalues : uis, _ENV, expeditionData, SpotList, LineList, ExpeditionWindow, IconList
  local com = (uis.Map_002_List):GetChildAt(0)
  local points = (ExpeditionMgr.GetExpeditionPoints)(expeditionData.id)
  for i,v in ipairs(points) do
    local num = i
    local LineName, IconName, spotName = nil, nil, nil
    if num < 10 then
      LineName = "Line_0" .. num .. "_Grp"
      IconName = "Event_0" .. num .. "_Grp"
      spotName = "Spot_0" .. num .. "_Grp"
    else
      LineName = "Line_" .. num .. "_Grp"
      IconName = "Event_" .. num .. "_Grp"
      spotName = "Spot_" .. num .. "_Grp"
    end
    local Line = com:GetChild(LineName)
    local Icon = com:GetChild(IconName)
    local Spot = com:GetChild(spotName)
    local isPass = (ExpeditionMgr.ExpeditionStageIsPass)(v.id)
    if Spot then
      SpotList[v.id] = Spot
      if (ExpeditionMgr.ExpeditionStageCanChallenge)(v.id) or isPass then
        ChangeUIController(Spot, "c1", 0)
      else
        ChangeUIController(Spot, "c1", 1)
      end
    end
    if Line then
      LineList[v.id] = Line
      if isPass then
        ChangeUIController(Line, "c1", 0)
      else
        ChangeUIController(Line, "c1", 1)
      end
    end
    if Icon then
      (ExpeditionWindow.SetIconShow)(Icon, v.id)
      IconList[v.id] = Icon
    end
  end
  if not notScroll then
    (ExpeditionWindow.InitListPos)()
  end
end

ExpeditionWindow.SetBottomShow = function(com, id, ...)
  -- function num : 0_8 , upvalues : _ENV, ExpeditionWindow
  if (ExpeditionMgr.ExpeditionStageIsFight)(id) and (ExpeditionMgr.ExpeditionStageCanChallenge)(id) and (ExpeditionMgr.SweepNum)() > 0 then
    ChangeUIController(com, "c2", 1)
    ;
    (com:GetChild("SweepBtn")).text = (PUtil.get)(20000212)
    ;
    (com.onClick):Set(function(...)
    -- function num : 0_8_0 , upvalues : ExpeditionWindow, id
    (ExpeditionWindow.OnClickStage)(id)
  end
)
  else
    ChangeUIController(com, "c2", 0)
  end
  local isPass = (ExpeditionMgr.ExpeditionStageIsPass)(id)
  if isPass or (ExpeditionMgr.ExpeditionStageCanChallenge)(id) then
    ChangeUIController(com, "c3", 0)
  else
    ChangeUIController(com, "c3", 1)
  end
end

ExpeditionWindow.SetIconShow = function(com, id, ...)
  -- function num : 0_9 , upvalues : _ENV, stageSortNum, putHolder, ExpeditionWindow
  local stageData = ((TableData.gTable).BaseExpeditionStageData)[id]
  if not stageData then
    return 
  end
  local NumberTxt = com:GetChild("NumberTxt")
  do
    if NumberTxt then
      local stageNum = (ExpeditionMgr.GetStageNum)(id)
      NumberTxt.text = stageSortNum .. "-" .. stageNum
    end
    if stageData.type == (ExpeditionMgr.StageType).General then
      ChangeUIController(com, "c1", 0)
    else
      if stageData.type == (ExpeditionMgr.StageType).Hard then
        ChangeUIController(com, "c1", 1)
      else
        if stageData.type == (ExpeditionMgr.StageType).Dead then
          ChangeUIController(com, "c1", 2)
        else
        end
      end
    end
    if ((stageData.type == (ExpeditionMgr.StageType).Altar and stageData.type ~= (ExpeditionMgr.StageType).Merchant) or stageData.type == (ExpeditionMgr.StageType).Treasure) then
      local isPass = (ExpeditionMgr.ExpeditionStageIsPass)(id)
      local canChallenge = (ExpeditionMgr.ExpeditionStageCanChallenge)(id)
      local con = com:GetController("Gray")
      local isInChallenge = false
      if isPass then
        con.selectedIndex = 2
      else
        if canChallenge then
          con.selectedIndex = 0
          local pos = Vector2(com.width / 2, com.height / 2)
          ;
          (LuaEffect.PlayEffectByHolder)(putHolder, com, pos, 0)
          putHolder.visible = true
          isInChallenge = true
        else
          do
            con.selectedIndex = 1
            do
              if not isInChallenge then
                local sfx = com:GetChild("mSfx")
                if sfx ~= nil then
                  putHolder.visible = false
                end
              end
              ;
              (com.onClick):Set(function(...)
    -- function num : 0_9_0 , upvalues : ExpeditionWindow, id
    (ExpeditionWindow.OnClickStage)(id)
  end
)
            end
          end
        end
      end
    end
  end
end

ExpeditionWindow.OnClickStage = function(stageId, ...)
  -- function num : 0_10 , upvalues : _ENV, ExpeditionWindow
  local Pass = (ExpeditionMgr.ExpeditionStageIsPass)(stageId)
  if Pass then
    return 
  end
  if (ExpeditionMgr.ExpeditionStageCanChallenge)(stageId) then
    (ExpeditionWindow.OnClickEvent)(stageId)
  else
    ;
    (MessageMgr.SendCenterTips)((PUtil.get)(20000118))
  end
end

ExpeditionWindow.SetBuff = function(...)
  -- function num : 0_11 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.GetBuff).GetBuffList).numItems = 0
  local buffs = (ExpeditionMgr.ExpeditionBuff)()
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  if #buffs > 0 then
    ((uis.GetBuff).root).visible = true
    for _,v in ipairs(buffs) do
      do
        local frame = (Util.CreateBuffFrame)(v)
        ;
        ((uis.GetBuff).GetBuffList):AddChild(frame)
        ;
        (frame.onClick):Set(function(...)
    -- function num : 0_11_0 , upvalues : _ENV, v
    OpenWindow((WinResConfig.BuffTipsWindow).name, UILayer.Popup, v)
  end
)
      end
    end
    -- DECOMPILER ERROR at PC42: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((uis.GetBuff).Buff_01_Image).width = (Umath.Clamp)(#buffs * 60 + 110, 100, 332)
  else
    -- DECOMPILER ERROR at PC46: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((uis.GetBuff).root).visible = false
  end
end

ExpeditionWindow.SetWeepNum = function(...)
  -- function num : 0_12 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

  (uis.SweepNumberTxt).text = (ExpeditionMgr.SweepNum)()
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

  if (ExpeditionMgr.SweepNum)() > 0 then
    (uis.SweepNumberTxt).color = Const.EnoughColorRGB
  else
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (uis.SweepNumberTxt).color = Const.LackColorRGB
  end
end

ExpeditionWindow.PlaySweepSfx = function(stageId, ...)
  -- function num : 0_13 , upvalues : isCanClick, IconList, _ENV
  isCanClick = false
  local mCom = IconList[stageId]
  local pos = Vector2(mCom.width / 2, mCom.height / 2)
  ;
  (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_EXPEDITION_SWEEP, true, mCom, pos)
  ;
  (SimpleTimer.setTimeout)(1, function(...)
    -- function num : 0_13_0 , upvalues : _ENV, stageId, isCanClick
    (ExpeditionService.OnReqIntoExpedition)(stageId, nil)
    isCanClick = true
  end
)
end

ExpeditionWindow.OnClickEvent = function(stageID, ...)
  -- function num : 0_14 , upvalues : _ENV, isCanClick, ExpeditionWindow
  -- DECOMPILER ERROR at PC16: Unhandled construct in 'MakeBoolean' P1

  if (ExpeditionMgr.ExpeditionStageIsFight)(stageID) and (ExpeditionMgr.SweepNum)() > 0 and isCanClick then
    (ExpeditionWindow.PlaySweepSfx)(stageID)
  end
  OpenWindow((WinResConfig.ExpeditionDetailWindow).name, UILayer.HUD, stageID)
  ;
  (ExpeditionService.OnReqIntoExpedition)(stageID)
  ;
  (ExpeditionMgr.ExpeditionIsChallenging)(true)
end

ExpeditionWindow.OnHide = function(...)
  -- function num : 0_15
end

ExpeditionWindow.ExternalShopBtn = function(...)
  -- function num : 0_16 , upvalues : _ENV, uis
  local ShopStage = (ExpeditionMgr.GetExternalShop)()
  local count = #ShopStage
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.ShopBtn).visible = count > 0
  if count > 0 then
    ((uis.ShopBtn).onClick):Set(function(...)
    -- function num : 0_16_0 , upvalues : _ENV
    OpenWindow((WinResConfig.ExpeditionShopWindowWindow).name, UILayer.HUD)
  end
)
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

ExpeditionWindow.CalculateEndPos = function(startPoint, endPoint, ...)
  -- function num : 0_17 , upvalues : _ENV
  local distance = 220
  local distanceX = distance * 0.5
  local distanceY = distance * (Umath.Pow)(3, 0.5) / 6
  if startPoint.x <= endPoint.x and startPoint.y <= endPoint.y then
    return Vector2(endPoint.x - distanceX, endPoint.y - distanceY)
  else
    if startPoint.x <= endPoint.x and endPoint.y <= startPoint.y then
      return Vector2(endPoint.x - distanceX, endPoint.y + distanceY)
    else
      if endPoint.x <= startPoint.x and startPoint.y <= endPoint.y then
        return Vector2(endPoint.x + distanceX, endPoint.y - distanceY)
      else
        if endPoint.x <= startPoint.x and endPoint.y <= startPoint.y then
          return Vector2(endPoint.x + distanceX, endPoint.y + distanceY)
        end
      end
    end
  end
end

ExpeditionWindow.OnClose = function(...)
  -- function num : 0_18 , upvalues : PointBackMoveTo, _ENV, Swipe, uis, contentPane, expeditionData, MapBg, isCanClick, CloudList, sfxHolder, IconList, LineList, SpotList, putHolder
  if PointBackMoveTo then
    PointBackMoveTo:Kill()
  end
  ;
  (CommonWinMgr.RemoveAssets)((WinResConfig.ExpeditionWindow).name)
  Swipe = nil
  uis = nil
  contentPane = nil
  expeditionData = nil
  MapBg = nil
  isCanClick = true
  CloudList = nil
  sfxHolder = {}
  IconList = {}
  LineList = {}
  SpotList = {}
  ;
  (LuaEffect.DestroyEffect)(putHolder)
end

ExpeditionWindow.InitAssetStrip = function(...)
  -- function num : 0_19 , upvalues : _ENV, uis
  local m = {}
  m.windowName = (WinResConfig.ExpeditionWindow).name
  m.Tip = (PUtil.get)(20000104)
  m.model = uis.AssetStripGrp
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.PHYSICAL}
  m.closeToWindow = (WinResConfig.AdventureWindow).name
  m.activityIds = (Util.GetActivityIds)(76000040)
  m.BackBtnFun = function(...)
    -- function num : 0_19_0 , upvalues : _ENV
    (ExpeditionMgr.ExpeditionIsChallenging)(false)
  end

  m.CloseBtnFun = function(...)
    -- function num : 0_19_1 , upvalues : _ENV
    (ExpeditionMgr.ExpeditionIsChallenging)(false)
  end

  ;
  (CommonWinMgr.RegisterAssets)(m)
end

ExpeditionWindow.RefreshPrePoint = function(stageId, ...)
  -- function num : 0_20 , upvalues : IconList, LineList, SpotList, _ENV, ExpeditionWindow
  local icon = IconList[stageId]
  local Line = LineList[stageId]
  local Spot = SpotList[stageId]
  local isPass = (ExpeditionMgr.ExpeditionStageIsPass)(stageId)
  local challenge = (ExpeditionMgr.ExpeditionStageCanChallenge)(stageId)
  if Line and isPass then
    ChangeUIController(Line, "c1", 0)
    ChangeUIController(Spot, "c1", 0)
  else
    ChangeUIController(Line, "c1", 1)
    if challenge then
      ChangeUIController(Spot, "c1", 0)
    else
      ChangeUIController(Spot, "c1", 1)
    end
  end
  if icon then
    (ExpeditionWindow.SetIconShow)(icon, stageId)
  end
end

ExpeditionWindow.ChangeNearbyState = function(stageID, ...)
  -- function num : 0_21 , upvalues : ExpeditionWindow, _ENV
  (ExpeditionWindow.RefreshPrePoint)(stageID)
  local stageData = ((TableData.gTable).BaseExpeditionStageData)[stageID]
  if stageData and stageData.next > 0 then
    (ExpeditionWindow.RefreshPrePoint)(stageData.next)
  end
  if stageData and stageData.pre > 0 then
    (ExpeditionWindow.RefreshPrePoint)(stageData.pre)
  end
end

ExpeditionWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_22 , upvalues : _ENV, ExpeditionWindow
  if msgId == (WindowMsgEnum.ExpeditionWindow).GOTO_NEXT_POINT then
    (ExpeditionWindow.ChangeNearbyState)(para)
    ;
    (ExpeditionWindow.ExternalShopBtn)()
  else
  end
  if msgId ~= (WindowMsgEnum.ExpeditionWindow).GOTO_BACK_POINT or msgId == (WindowMsgEnum.ExpeditionWindow).PLAY_BUFF_EFFECT then
    (ExpeditionWindow.SetBuff)()
    ;
    (ExpeditionWindow.ChangeNearbyState)(para)
    ;
    (ExpeditionWindow.ExternalShopBtn)()
  else
  end
  if msgId ~= (WindowMsgEnum.ExpeditionWindow).CHANGE_SWEEP_TIMES or msgId == (WindowMsgEnum.ExpeditionWindow).SWEEP_SHOW then
    (ExpeditionWindow.ChangeNearbyState)(para)
    local swTime = (ExpeditionMgr.SweepNum)()
    if swTime <= 0 then
      (ExpeditionWindow.PlayCloudAni)(false)
    end
  end
end

return ExpeditionWindow

