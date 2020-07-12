-- params : ...
-- function num : 0 , upvalues : _ENV
require("Guide_GuideWindowByName")
local GuideWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local Stage = FairyGUI.Stage
local GuideCamera, clickArea, clickCtr = nil, nil, nil
local modifyUpdate = false
local timer, finger, timer2 = nil, nil, nil
local isChangeEffectLayer = true
local AniWindowName = {(WinResConfig.HomeWindow).name, (WinResConfig.AdventureWindow).name, (WinResConfig.CardWindow).name, (WinResConfig.LotteryWindow).name, (WinResConfig.FormationWindow).name}
local playPlotCtr = {ControlID.HeroChapterList_FirstChapter, ControlID.Home_HandbookBtn, ControlID.Home_AdventureBtn, ControlID.Break_Sure, ControlID.Card_GetShow}
local externalFun = nil
GuideWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, isChangeEffectLayer, uis, externalFun, GuideWindow, clickArea, finger
  bridgeObj:SetView((WinResConfig.GuideWindow).package, (WinResConfig.GuideWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  contentPane:Center()
  isChangeEffectLayer = true
  uis = GetGuide_GuideWindowUis(contentPane)
  externalFun = nil
  ;
  (GuideWindow.CreateCamera)()
  clickArea = contentPane:GetChild("clickArea")
  finger = (uis.Hand).root
  ;
  (UpdateMgr.AddUpdateHandler)(GuideWindow.Update)
end

GuideWindow.IsInPlayPlotCtr = function(...)
  -- function num : 0_1 , upvalues : _ENV, playPlotCtr
  local sID = (GuideMgr.GuideStepId)()
  local GuideStep = ((TableData.gTable).BaseGuideStepData)[tonumber(sID)]
  local cID = GuideStep.ctrl_id
  for _,v in pairs(playPlotCtr) do
    if v == cID then
      return true
    end
  end
  return false
end

GuideWindow.SetClickAreaXY = function(...)
  -- function num : 0_2 , upvalues : clickCtr, _ENV, uis, clickArea
  if clickCtr ~= nil and (clickCtr.displayObject).cachedTransform ~= nil then
    local v2 = clickCtr:TransformPoint(Vector2.zero, uis.root)
    local pX = 0
    local pY = 0
    if clickCtr.pivotAsAnchor then
      pX = clickCtr.pivotX
      pY = clickCtr.pivotY
    end
    local offsetX = (clickArea.pivotX - pX) * clickCtr.width
    local offsetY = (clickArea.pivotY - pY) * clickCtr.height
    clickArea.xy = Vector2(v2.x + offsetX, v2.y + offsetY)
  end
end

GuideWindow.Update = function(...)
  -- function num : 0_3 , upvalues : modifyUpdate
  if modifyUpdate then
  end
end

GuideWindow.IsContainAniWinName = function(winName, ...)
  -- function num : 0_4 , upvalues : _ENV, AniWindowName
  for _,v in pairs(AniWindowName) do
    if v == winName then
      return true
    end
  end
  return false
end

GuideWindow.SetGuideShow = function(...)
  -- function num : 0_5 , upvalues : timer, _ENV, uis, GuideWindow, externalFun, clickCtr
  if timer then
    timer:_destroy()
  end
  local sID = (GuideMgr.GuideStepId)()
  local GuideStep = ((TableData.gTable).BaseGuideStepData)[tonumber(sID)]
  if not GuideStep then
    loge("为找到配置id....." .. sID)
    UIMgr:CloseWindow((WinResConfig.GuideWindow).name)
    return 
  end
  local bg = (uis.root):GetChild("n0")
  bg.visible = true
  if GuideStep.alpha then
    bg.alpha = GuideStep.alpha
  end
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (uis.root).touchable = true
  ;
  (GuideWindow.SetShowType)(false, false)
  local ctrId = GuideStep.ctrl_id
  if ctrId == nil or ctrId <= 0 then
    bg.visible = false
    -- DECOMPILER ERROR at PC53: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (uis.root).touchable = false
    loge("播放了剧情")
    OpenPlotPlay(GuideStep.plotplay_Id, PlotPlayTriggerType.INSTANTLY_PLAY, function(...)
    -- function num : 0_5_0 , upvalues : externalFun, _ENV, GuideWindow
    if externalFun then
      externalFun()
      loge("执行了")
      externalFun = nil
    end
    ;
    (GuideWindow.OnClickNext)()
  end
)
  else
    ;
    (SimpleTimer.setTimeout)(0.1, function(...)
    -- function num : 0_5_1 , upvalues : ctrId, _ENV, clickCtr, sID, GuideWindow
    if ctrId == ControlID.CardList_List then
      local cardID = 11100003
      UIMgr:SendWindowMessage((WinResConfig.CardListWindow).name, (WindowMsgEnum.CardWindow).E_MSG_CARD_LIST_SCROLL, cardID)
    else
      do
        do
          if ctrId == ControlID.CardList_List2 then
            local cardID = 11100002
            UIMgr:SendWindowMessage((WinResConfig.CardListWindow).name, (WindowMsgEnum.CardWindow).E_MSG_CARD_LIST_SCROLL, cardID)
          else
          end
          if ctrId == ControlID.Equipment_TipsWear then
            clickCtr = (GuideMgr.GetCtrInfer)(ctrId)
            if not clickCtr then
              (GuideMgr.GuideLog)("在该界面没找到id为" .. ctrId .. "的控件，请检查BaseGuideStepData中id" .. sID .. "配置是否正确?或者该界面是否没有注册该控件？")
              UIMgr:CloseWindow((WinResConfig.GuideWindow).name)
              return 
            end
            ;
            (GuideWindow.SetShowAndClickArea)(clickCtr, ctrId == ControlID.Task_List, ctrId)
            ;
            (GuideWindow.SetBubbleInfo)()
            -- DECOMPILER ERROR: 2 unprocessed JMP targets
          end
        end
      end
    end
  end
)
  end
end

GuideWindow.SetBubbleInfo = function(...)
  -- function num : 0_6 , upvalues : _ENV, GuideWindow, timer2, clickCtr, uis, finger
  local sID = (GuideMgr.GuideStepId)()
  local GuideStep = ((TableData.gTable).BaseGuideStepData)[tonumber(sID)]
  if GuideStep == nil then
    return 
  end
  local waitTime = 0.3
  local winName = ((TableData.gTable).BaseWindowNameData)[GuideStep.window_name]
  if winName and (GuideWindow.IsContainAniWinName)(winName.window_name) then
    waitTime = 0.7
  end
  local ctrId = GuideStep.ctrl_id
  timer2 = (SimpleTimer.setTimeout)(waitTime, function(...)
    -- function num : 0_6_0 , upvalues : GuideWindow, GuideStep, _ENV, clickCtr, uis, ctrId, finger
    (GuideWindow.SetClickAreaXY)()
    ;
    (GuideWindow.SetShowType)(false, true)
    if GuideStep.guide_eff_offset then
      local finger_Pos = split(GuideStep.guide_eff_offset, ":")
      do
        local mPos = clickCtr:TransformPoint(Vector2(tonumber(finger_Pos[1]), tonumber(finger_Pos[2])), uis.root)
        if ctrId and ctrId == ControlID.Tower_OneChapter then
          mPos = mPos + Vector2((ResolutionHandler.AdaptOffset).X, (ResolutionHandler.AdaptOffset).Y)
        end
        finger.xy = mPos
        finger.visible = true
        -- DECOMPILER ERROR at PC51: Confused about usage of register: R2 in 'UnsetPending'

        if ((uis.Hand).HandLoader).Model == nil then
          ((uis.Hand).HandLoader).visible = false
          ;
          (Util.ShowUIModel)("handpooint", (uis.Hand).HandLoader, nil, false, function(model, ...)
      -- function num : 0_6_0_0 , upvalues : _ENV, uis, GuideWindow, GuideStep, mPos
      (SimpleTimer.setTimeout)(0.1, function(...)
        -- function num : 0_6_0_0_0 , upvalues : uis, _ENV
        -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

        ((uis.Hand).HandLoader).visible = true
        -- DECOMPILER ERROR at PC9: Confused about usage of register: R0 in 'UnsetPending'

        ;
        ((((uis.Hand).HandLoader).Model).gameObject).layer = Const.GuideLayer
      end
)
      ;
      (GuideWindow.SetCatAni)(model, GuideStep.finger_state, mPos)
    end
)
        else
          ;
          (GuideWindow.SetCatAni)(((uis.Hand).HandLoader).Model, GuideStep.finger_state, mPos)
        end
      end
    else
      do
        finger.visible = false
        local bubble_text = GuideStep.bubble_text
        -- DECOMPILER ERROR at PC83: Confused about usage of register: R1 in 'UnsetPending'

        if not bubble_text or (Util.StringIsNullOrEmpty)(bubble_text) then
          ((uis.WordGrp).root).visible = false
        else
          -- DECOMPILER ERROR at PC87: Confused about usage of register: R1 in 'UnsetPending'

          ;
          ((uis.WordGrp).root).visible = true
          -- DECOMPILER ERROR at PC90: Confused about usage of register: R1 in 'UnsetPending'

          ;
          ((uis.WordGrp).WordTxt).text = bubble_text
          local bubble_Pos = split(GuideStep.bubble_pos, ":")
          local mPos = clickCtr:TransformPoint(Vector2(tonumber(bubble_Pos[1]), tonumber(bubble_Pos[2])), uis.root)
          -- DECOMPILER ERROR at PC109: Confused about usage of register: R3 in 'UnsetPending'

          ;
          ((uis.WordGrp).root).xy = mPos
          -- DECOMPILER ERROR at PC117: Confused about usage of register: R3 in 'UnsetPending'

          if ((uis.WordGrp).HeadLoader).Model == nil then
            ((uis.WordGrp).HeadLoader).visible = false
            ;
            (Util.ShowUIModel)(Const.NotFoundEffect2, (uis.WordGrp).HeadLoader, nil, false, function(model, ...)
      -- function num : 0_6_0_1 , upvalues : GuideWindow, _ENV, uis
      (GuideWindow.SetNpcAni)(model, "idle")
      ;
      (SimpleTimer.setTimeout)(0.05, function(...)
        -- function num : 0_6_0_1_0 , upvalues : GuideWindow, _ENV, uis
        (GuideWindow.SetLoaderAndBubbleLayer)(Const.GuideLayer)
        -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

        ;
        ((uis.WordGrp).HeadLoader).visible = true
      end
)
    end
)
          else
            ;
            (GuideWindow.SetNpcAni)(((uis.WordGrp).HeadLoader).Model, "idle")
          end
        end
      end
    end
  end
)
end

GuideWindow.SetLoaderAndBubbleLayer = function(layer, ...)
  -- function num : 0_7 , upvalues : GuideWindow, uis
  (GuideWindow.SetClickCtrLayer)((uis.WordGrp).root, layer)
end

GuideWindow.SetCatAni = function(model, ani, sfxPos, ...)
  -- function num : 0_8 , upvalues : _ENV, uis, isChangeEffectLayer
  if model == nil then
    return 
  end
  if ani == 1 then
    (SkeletonAnimationUtil.SetAnimation)(model.gameObject, 0, "left_down", true)
  else
    if ani == 2 then
      (SkeletonAnimationUtil.SetAnimation)(model.gameObject, 0, "left_up", true)
    else
      if ani == 3 then
        (SkeletonAnimationUtil.SetAnimation)(model.gameObject, 0, "right_up", true)
      else
        if ani == 4 then
          (SkeletonAnimationUtil.SetAnimation)(model.gameObject, 0, "right_down", true)
        end
      end
    end
  end
  ;
  (SkeletonAnimationUtil.ClearAllEvent)(model.gameObject)
  ;
  (SkeletonAnimationUtil.AddEvent)(model.gameObject, function(trackEntry, event, ...)
    -- function num : 0_8_0 , upvalues : _ENV, uis, sfxPos, isChangeEffectLayer
    if (event.Data).Name == "trigger" then
      local holder = (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_GUIDE_POINT, true, uis.root, sfxPos)
      do
        if isChangeEffectLayer then
          holder.ManuallyModifySd = true
          -- DECOMPILER ERROR at PC17: Confused about usage of register: R3 in 'UnsetPending'

          ;
          (holder.displayObject).renderingOrder = 200
          ;
          (SimpleTimer.setTimeout)(0.01, function(...)
      -- function num : 0_8_0_0 , upvalues : holder, _ENV
      -- DECOMPILER ERROR at PC3: Confused about usage of register: R0 in 'UnsetPending'

      (holder.displayObject).layer = Const.GuideLayer
    end
)
        end
      end
    end
  end
)
end

GuideWindow.SetNpcAni = function(model, aniName, ...)
  -- function num : 0_9 , upvalues : _ENV
  if model == nil then
    return 
  end
  ;
  (SkeletonAnimationUtil.SetAnimation)(model.gameObject, 0, aniName, true)
end

GuideWindow.SetClickCtrLayer = function(ctr, layer, ...)
  -- function num : 0_10
  if ctr == nil then
    return 
  end
  if ctr.asCom then
    (ctr.container):SetChildrenLayer(layer)
  else
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R2 in 'UnsetPending'

    if ctr.asLoader then
      if (ctr.asLoader).Model ~= nil then
        (((ctr.asLoader).Model).gameObject).layer = layer
      else
        -- DECOMPILER ERROR at PC29: Confused about usage of register: R2 in 'UnsetPending'

        if (ctr.asLoader).texture ~= nil then
          ((ctr.asLoader).displayObject).layer = layer
        end
      end
    else
      -- DECOMPILER ERROR at PC33: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((ctr.displayObject).gameObject).layer = layer
    end
  end
end

GuideWindow.SetShowAndClickArea = function(clickCtr, isTask, ctrId, ...)
  -- function num : 0_11 , upvalues : GuideWindow, _ENV, clickArea
  (GuideWindow.SetClickCtrLayer)(clickCtr, Const.GuideLayer)
  local factorWidth = 1
  local factorHeight = 1
  if ctrId then
    if ctrId == ControlID.Tower_OneChapter then
      factorWidth = 0.44
      factorHeight = 0.44
    else
      if ctrId == ControlID.Adventure_Expedition then
        factorWidth = 0.5
        factorHeight = 0.9
      end
    end
  end
  if clickCtr.asLoader then
    clickArea.width = clickCtr.width * factorWidth
    clickArea.height = clickCtr.height * factorHeight
  else
    clickArea.width = clickCtr.sourceWidth * factorWidth
    clickArea.height = clickCtr.sourceHeight * factorHeight
  end
  local sID = (GuideMgr.GuideStepId)()
  local GuideStep = ((TableData.gTable).BaseGuideStepData)[tonumber(sID)]
  if GuideStep.req_severs == 0 then
    if isTask then
      ((clickCtr:GetChild("functionBtn")).onClick):AddCapture(GuideWindow.OnClickNext)
    else
      ;
      (clickCtr.onClick):AddCapture(GuideWindow.OnClickNext)
    end
  else
    ;
    (clickCtr.onClick):AddCapture(GuideWindow.SendGuideServiceMsg)
  end
end

GuideWindow.SendGuideServiceMsg = function(...)
  -- function num : 0_12 , upvalues : _ENV, clickCtr, GuideWindow
  local pID = (GuideMgr.GuideId)()
  local sgID = (GuideMgr.GuideStepGroupId)()
  local sID = (GuideMgr.GuideStepId)()
  if (GuideMgr.CurrentGuideIsDungeon)() then
    (GuideService.SavePlotGuideData)(pID, sgID, sID)
  else
    ;
    (GuideService.SaveBasicGuideData)(pID, sgID, sID)
  end
  ;
  (clickCtr.onClick):RemoveCapture(GuideWindow.SendGuideServiceMsg)
end

GuideWindow.CloseClickArea = function(...)
  -- function num : 0_13 , upvalues : clickArea
  clickArea.width = 0
  clickArea.height = 0
end

GuideWindow.OnClickNext = function(eventContext, ignoreFull, ...)
  -- function num : 0_14 , upvalues : _ENV, clickCtr, GuideWindow, externalFun
  local sID = (GuideMgr.GuideStepId)()
  loge("新手引导结束当前步骤:   " .. sID)
  local GuideStep = ((TableData.gTable).BaseGuideStepData)[tonumber(sID)]
  if clickCtr then
    if GuideStep.req_severs == 0 then
      (clickCtr.onClick):RemoveCapture(GuideWindow.OnClickNext)
    end
    ;
    (GuideWindow.SetClickCtrLayer)(clickCtr, Const.UILayer)
    ;
    (GuideWindow.CloseClickArea)()
  end
  ;
  (GuideWindow.SetShowType)(false, false)
  local waitTime = 0
  if GuideStep.ctrl_id and GuideStep.ctrl_id == ControlID.Card_ExpMedical then
    waitTime = 0.5
  end
  local func = function(...)
    -- function num : 0_14_0 , upvalues : GuideStep, _ENV, GuideWindow, clickCtr, externalFun, eventContext, ignoreFull
    if GuideStep.is_goto_main and GuideStep.is_goto_main == 1 then
      UIMgr:CloseToWindow((WinResConfig.HomeWindow).name)
    end
    ;
    (Util.SetOnClickDelay)(0.2)
    local nextIsPlot = (GuideWindow.NextStepIsPlot)()
    if nextIsPlot and clickCtr and GuideStep.req_severs == 0 and not (GuideWindow.IsInPlayPlotCtr)() then
      externalFun = (clickCtr.onClick):GetEvent0()
      if externalFun == nil then
        externalFun = (clickCtr.onClick):GetEvent1()
      end
      if eventContext then
        eventContext:StopPropagation()
      end
    end
    clickCtr = nil
    ;
    (GuideMgr.GuideStepPlayOver)(ignoreFull)
  end

  if waitTime > 0 then
    (SimpleTimer.setTimeout)(waitTime, function(...)
    -- function num : 0_14_1 , upvalues : func
    func()
  end
)
  else
    func()
  end
end

GuideWindow.NextStepIsPlot = function(...)
  -- function num : 0_15 , upvalues : GuideWindow, _ENV
  local nextSid = (GuideWindow.GetNextGuideStep)()
  do
    if nextSid then
      local StepData = ((TableData.gTable).BaseGuideStepData)[nextSid]
      if StepData and StepData.plotplay_Id and StepData.plotplay_Id > 0 then
        return true
      end
    end
    return false
  end
end

GuideWindow.GetNextGuideStep = function(...)
  -- function num : 0_16 , upvalues : _ENV
  local pID = (GuideMgr.GuideId)()
  local sgID = (GuideMgr.GuideStepGroupId)()
  local sID = (GuideMgr.GuideStepId)()
  local isSpecial = (GuideMgr.GuideStepGroupSpecial)()
  local nextGuideStep = (GuideMgr.GetNextGuideStep)(pID, sgID, sID, isSpecial, false)
  return nextGuideStep
end

GuideWindow.SetShowType = function(talk, tip, ...)
  -- function num : 0_17 , upvalues : uis
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R2 in 'UnsetPending'

  (uis.WrodGrp).visible = tip
end

GuideWindow.CreateCamera = function(...)
  -- function num : 0_18 , upvalues : _ENV, GuideCamera
  local obj = GameObject("GuideCamera")
  GuideCamera = obj:AddComponent(typeof(Camera))
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (GuideCamera.transform).localPosition = ((Game.uiCamera).transform).localPosition
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (GuideCamera.transform).localRotation = ((Game.uiCamera).transform).localRotation
  GuideCamera.orthographic = true
  GuideCamera.clearFlags = 4
  GuideCamera.depth = 2
  GuideCamera.farClipPlane = 30
  GuideCamera.nearClipPlane = -30
  GuideCamera.cullingMask = 8192
  GuideCamera.allowHDR = false
  GuideCamera.allowMSAA = false
  GuideCamera.forceIntoRenderTexture = false
end

GuideWindow.OnShown = function(...)
  -- function num : 0_19 , upvalues : GuideWindow
  (GuideWindow.SetGuideShow)()
end

GuideWindow.OnHide = function(...)
  -- function num : 0_20
end

GuideWindow.OnClose = function(...)
  -- function num : 0_21 , upvalues : modifyUpdate, _ENV, GuideWindow, GuideCamera, clickCtr, uis, contentPane, argTable, clickArea, timer, timer2
  modifyUpdate = false
  ;
  (UpdateMgr.RemoveUpdateHandler)(GuideWindow.Update)
  ;
  (ResHelper.DestroyGameObject)(GuideCamera.gameObject, false)
  clickCtr = nil
  GuideCamera = nil
  uis = nil
  contentPane = nil
  argTable = {}
  clickArea = nil
  if timer then
    timer:_destroy()
  end
  if timer2 then
    timer2:_destroy()
  end
end

local isGetCtr = true
local externalVisible = true
GuideWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_22 , upvalues : _ENV, GuideWindow, clickCtr, isGetCtr, externalVisible
  if msgId == (WindowMsgEnum.GuideWindow).GUIDE_CONTINUAL then
    (GuideWindow.SetGuideShow)()
  end
  if msgId == (WindowMsgEnum.GuideWindow).GUIDE_FINISH then
    UIMgr:CloseWindow((WinResConfig.GuideWindow).name)
  end
  do
    if msgId == (WindowMsgEnum.GuideWindow).GUIDE_CHECK then
      local fun = function(...)
    -- function num : 0_22_0 , upvalues : _ENV
    if UIMgr:IsWindowOpen((WinResConfig.PlotPlayPanelWindow).name) or UIMgr:IsWindowOpen((WinResConfig.LoadingWindow).name) then
      UIMgr:CloseWindow((WinResConfig.GuideWindow).name)
    end
  end

      ;
      ((SimpleTimer.new)(0.1, 5, fun)):start()
    end
    if msgId == (WindowMsgEnum.GuideWindow).GUIDE_INFER then
      clickCtr = para
      ;
      (GuideWindow.SetShowAndClickArea)(clickCtr, false)
      ;
      (GuideWindow.SetBubbleInfo)()
      if isGetCtr == false then
        isGetCtr = true
        ;
        (GuideWindow.ExternalSetGuideShow)(externalVisible)
      end
    end
    do
      if msgId == (WindowMsgEnum.GuideWindow).GUIDE_SET_GUIDE_SHOW then
        local visible = para
        loge("设置新手引导的显示" .. tostring(visible))
        ;
        (GuideWindow.ExternalSetGuideShow)(visible)
      end
      if msgId == (WindowMsgEnum.GuideWindow).GUIDE_CURRENT_STEP_OVER then
        (GuideWindow.OnClickNext)()
      end
      if msgId == (WindowMsgEnum.NETBrokenReconnect).E_MSG_RECONNECT_Ok then
        local sID = (GuideMgr.GuideStepId)()
        local GuideStep = ((TableData.gTable).BaseGuideStepData)[tonumber(sID)]
        local ctrl_id = GuideStep.ctrl_id
        ;
        (GuideMgr.GuideLog)("断线重连")
        if GuideStep and GuideStep.req_severs == 1 and ctrl_id and ctrl_id > 0 then
          if ctrl_id == ControlID.Card_WakeBtn then
            local cardData = (CardData.GetCardData)(11100002)
            if cardData.star > 1 then
              (GuideWindow.OnClickNext)(nil, true)
            end
          else
            do
              if ctrl_id == ControlID.Task_List then
                local mLv = (ActorData.GetLevel)()
                if mLv >= 7 then
                  (GuideWindow.OnClickNext)(nil, true)
                end
              end
            end
          end
        end
      end
    end
  end
end

GuideWindow.ExternalSetGuideShow = function(isShow, ...)
  -- function num : 0_23 , upvalues : _ENV, uis, GuideWindow, isChangeEffectLayer, clickCtr, isGetCtr, externalVisible
  local layer = Const.UILayer
  if isShow then
    layer = Const.GuideLayer
  end
  local model = ((uis.Hand).HandLoader).Model
  ;
  (GuideWindow.SetLoaderAndBubbleLayer)(layer)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R3 in 'UnsetPending'

  if model then
    (model.gameObject).layer = layer
  end
  isChangeEffectLayer = isShow
  if clickCtr == nil then
    isGetCtr = false
    externalVisible = isShow
    return 
  end
  ;
  (GuideWindow.SetClickCtrLayer)(clickCtr, layer)
end

return GuideWindow

