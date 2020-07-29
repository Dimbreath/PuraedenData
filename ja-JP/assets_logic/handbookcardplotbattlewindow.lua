-- params : ...
-- function num : 0 , upvalues : _ENV
require("HandBook_CardPlotBattleByName")
require("HandBook_CardPlotBattleTipsByName")
local HandBookCardPlotBattleWindow = {}
local stageType = {Fight = 1, Story = 2, Reward = 3}
local uis, contentPane = nil, nil
local argTable = {}
local cardId = 0
local tempPop, ToolsTxt, ToolsBtn, currentFashionID, inputTxt = nil, nil, nil, nil, nil
local baseTable = {}
local currentIndex = 0
local mHolder = nil
HandBookCardPlotBattleWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, cardId, uis, HandBookCardPlotBattleWindow, currentIndex, tempPop, ToolsTxt, ToolsBtn, inputTxt
  bridgeObj:SetView((WinResConfig.HandBookCardPlotBattleWindow).package, (WinResConfig.HandBookCardPlotBattleWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  cardId = argTable[1]
  uis = GetHandBook_CardPlotBattleUis(contentPane)
  ;
  (HandBookCardPlotBattleWindow.InitAssetStrip)()
  ;
  (HandBookCardPlotBattleWindow.InitMap)()
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.MapList).scrollItemToViewOnClick = false
  ;
  ((uis.CardPlotCGBtn).onClick):Set(HandBookCardPlotBattleWindow.OnClickCGBtn)
  currentIndex = 0
  ;
  (UpdateMgr.AddUpdateHandler)(HandBookCardPlotBattleWindow.Update)
  ;
  (HandBookCardPlotBattleWindow.InitBaseFashionData)()
  tempPop = UIMgr:CreateObject("Tool", "TempTools")
  ;
  (tempPop:GetController("c1")).selectedIndex = 1
  tempPop.draggable = true
  ToolsTxt = tempPop:GetChild("n1")
  ToolsBtn = tempPop:GetChild("btn")
  inputTxt = tempPop:GetChild("inputtxt")
  ;
  (HandBookCardPlotBattleWindow.InitToolsSlider)()
end

HandBookCardPlotBattleWindow.GetCGId = function(...)
  -- function num : 0_1 , upvalues : _ENV, cardId
  local CGData = (TableData.gTable).BaseHandbookCGData
  for _,v in pairs(CGData) do
    if v.chapter_id == cardId then
      return v.id
    end
  end
end

HandBookCardPlotBattleWindow.OnClickCGBtn = function(...)
  -- function num : 0_2 , upvalues : HandBookCardPlotBattleWindow, _ENV
  local cgID = (HandBookCardPlotBattleWindow.GetCGId)()
  if cgID == nil then
    return 
  end
  local num = (HandBookMgr.GetStagePassNum)()
  OpenWindow((WinResConfig.CGShowWindow).name, UILayer.HUD, cgID, num)
end

HandBookCardPlotBattleWindow.InitBaseFashionData = function(...)
  -- function num : 0_3 , upvalues : _ENV, baseTable
  local data = (TableData.gTable).BaseFashionData
  for _,v in pairs(data) do
    (table.insert)(baseTable, v)
  end
  ;
  (table.sort)(baseTable, function(a, b, ...)
    -- function num : 0_3_0
    do return a.id < b.id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
end

HandBookCardPlotBattleWindow.InitToolsSlider = function(...)
  -- function num : 0_4 , upvalues : uis, tempPop, _ENV, HandBookCardPlotBattleWindow, ToolsBtn, inputTxt, currentIndex
  local mLoader = uis.CardLoader
  local width = tempPop:GetChild("width")
  ;
  (width.onChanged):Set(function(...)
    -- function num : 0_4_0 , upvalues : width, _ENV, mLoader, HandBookCardPlotBattleWindow
    local value = (width.value / 20 - 2) * DesignScreen.width
    local image = ((mLoader.image).gameObject).transform
    image.localPosition = Vector3(value, (image.localPosition).y, (image.localPosition).z)
    ;
    (HandBookCardPlotBattleWindow.SetToolsValue)()
  end
)
  local height = tempPop:GetChild("height")
  ;
  (height.onChanged):Set(function(...)
    -- function num : 0_4_1 , upvalues : height, _ENV, mLoader, HandBookCardPlotBattleWindow
    local value = (height.value / 20 - 2) * DesignScreen.height
    local image = ((mLoader.image).gameObject).transform
    image.localPosition = Vector3((image.localPosition).x, value, (image.localPosition).z)
    ;
    (HandBookCardPlotBattleWindow.SetToolsValue)()
  end
)
  local scale = tempPop:GetChild("scale")
  ;
  (scale.onChanged):Set(function(...)
    -- function num : 0_4_2 , upvalues : scale, mLoader, _ENV, HandBookCardPlotBattleWindow
    local value = scale.value / 100 * 5
    local image = ((mLoader.image).gameObject).transform
    image.localScale = Vector3(value, value, value)
    ;
    (HandBookCardPlotBattleWindow.SetToolsValue)()
  end
)
  local alpha = tempPop:GetChild("alpha")
  ;
  (alpha.onChanged):Set(function(...)
    -- function num : 0_4_3 , upvalues : alpha, uis, _ENV, HandBookCardPlotBattleWindow
    local value = alpha.value / 100
    -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (uis.CardLoader).alpha = tonumber(value)
    ;
    (HandBookCardPlotBattleWindow.SetToolsValue)()
  end
)
  ;
  (ToolsBtn.onClick):Set(function(...)
    -- function num : 0_4_4 , upvalues : _ENV, inputTxt, HandBookCardPlotBattleWindow
    local fashionId = tonumber(inputTxt.text)
    local fashionConfig = ((TableData.gTable).BaseFashionData)[fashionId]
    if not fashionConfig then
      print("没找到.." .. fashionId .. "啊睿哥")
      return 
    end
    inputTxt.text = ""
    ;
    (HandBookCardPlotBattleWindow.SetCardTexture)(fashionId)
    ;
    (HandBookCardPlotBattleWindow.SetToolsValue)()
  end
)
  local nextBtn = tempPop:GetChild("Next_btn")
  nextBtn.text = "Next"
  ;
  (nextBtn.onClick):Set(function(...)
    -- function num : 0_4_5 , upvalues : currentIndex, HandBookCardPlotBattleWindow, _ENV, width, height, scale, alpha
    currentIndex = currentIndex + 1
    local fashion = (HandBookCardPlotBattleWindow.GetNextFashionID)()
    if not fashion then
      print("没了")
      return 
    end
    ;
    (HandBookCardPlotBattleWindow.SetCardTexture)(fashion.id)
    width.value = 20
    height.value = 10
    scale.value = 33
    alpha.value = 100
    ;
    (width.onChanged):Call()
    ;
    (height.onChanged):Call()
    ;
    (scale.onChanged):Call()
    ;
    (alpha.onChanged):Call()
    ;
    (HandBookCardPlotBattleWindow.SetToolsValue)()
  end
)
end

HandBookCardPlotBattleWindow.GetNextFashionID = function(...)
  -- function num : 0_5 , upvalues : _ENV, baseTable, currentFashionID
  for i,v in ipairs(baseTable) do
    if v.id == currentFashionID then
      return baseTable[i + 1]
    end
  end
end

HandBookCardPlotBattleWindow.SetToolsValue = function(...)
  -- function num : 0_6 , upvalues : uis, currentFashionID, _ENV, ToolsTxt
  local str = ""
  local mLoader = uis.CardLoader
  str = str .. "fashionID: " .. currentFashionID .. "\n" .. "positionX: " .. ((((mLoader.image).gameObject).transform).localPosition).x .. "    positionY: " .. ((((mLoader.image).gameObject).transform).localPosition).y .. "\n" .. "Scale: " .. (math.floor)(((((mLoader.image).gameObject).transform).localScale).x * 10000) .. "\n" .. "alpha: " .. (math.floor)(mLoader.alpha * 10000)
  ToolsTxt.text = str
end

HandBookCardPlotBattleWindow.Update = function(...)
  -- function num : 0_7 , upvalues : _ENV, ToolsBtn, ToolsTxt, HandBookCardPlotBattleWindow, tempPop
  if (Input.GetKey)(KeyCode.Z) and (Input.GetKeyDown)(KeyCode.C) then
    ToolsBtn.visible = false
    ToolsTxt.text = ""
    ;
    (HandBookCardPlotBattleWindow.SetToolsValue)()
    ;
    (GRoot.inst):ShowPopup(tempPop)
  else
    if (Input.GetKey)(KeyCode.Z) and (Input.GetKeyDown)(KeyCode.X) then
      ToolsBtn.visible = true
      ChangeUIController(tempPop, "c1", 1)
      ;
      (GRoot.inst):ShowPopup(tempPop)
    end
  end
end

HandBookCardPlotBattleWindow.InitMap = function(...)
  -- function num : 0_8 , upvalues : _ENV, cardId, uis, HandBookCardPlotBattleWindow
  local RoleData = ((TableData.gTable).BaseHandbookRoleData)[cardId]
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.NameTxt).text = RoleData.map_name
  local mapPath = split(RoleData.map_path, ":")
  local map = UIMgr:CreateObject(mapPath[1], mapPath[2])
  ;
  (HandBookCardPlotBattleWindow.SetMapShow)(map)
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (uis.MapList).numItems = 0
  ;
  (uis.MapList):AddChild(map)
  ;
  (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_HANDBOOK_ATMOSPHERE, false, uis.root, Vector2(DesignScreen.width / 2, DesignScreen.height / 2))
  local stageNum = (HandBookCardPlotBattleWindow.GetChallengeNum)()
  local stageName = (HandBookCardPlotBattleWindow.GetLineOrStage)(stageNum, true)
  loge("stageNum..............." .. stageNum)
  local stage = map:GetChild(stageName)
  if stage then
    local pos = stage.x - DesignScreen.width / 2
    local offsetX = (Umath.Clamp)(pos, 0, 100000)
    -- DECOMPILER ERROR at PC70: Confused about usage of register: R8 in 'UnsetPending'

    ;
    ((uis.MapList).scrollPane).posX = offsetX
  end
end

HandBookCardPlotBattleWindow.SetStageShow = function(obj, data, index, ...)
  -- function num : 0_9 , upvalues : HandBookCardPlotBattleWindow, _ENV, stageType, mHolder, uis
  local stageName = (HandBookCardPlotBattleWindow.GetLineOrStage)(index, true)
  local stage = obj:GetChild(stageName)
  if stage == nil then
    loge("配置表关卡数量超过了预制关卡数量")
    return 
  end
  local isUnlock = (HandBookMgr.GetStageIsUnlock)(data.id)
  local stageModel = GetHandBook_CardPlotBattleTipsUis(stage)
  local CardPlotHead = stage:GetChild("CardPlotHead")
  ;
  (CardPlotHead:GetChild("HeadLoader")).url = (Util.GetItemUrl)(data.stage_icon)
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R8 in 'UnsetPending'

  if isUnlock then
    (stageModel.c2Ctr).selectedIndex = 0
    ChangeUIController(CardPlotHead, "c1", 0)
  else
    -- DECOMPILER ERROR at PC42: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (stageModel.c2Ctr).selectedIndex = 1
    ChangeUIController(CardPlotHead, "c1", 1)
  end
  -- DECOMPILER ERROR at PC54: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (stageModel.NumberTxt).text = (PUtil.get)(20000148, index)
  if data.type == stageType.Fight and isUnlock then
    (LeanTween.delayedCall)(0.6, function(...)
    -- function num : 0_9_0 , upvalues : _ENV, data
    if UIMgr:IsWindowOpen((WinResConfig.HandBookCardPlotBattleWindow).name) == false then
      return 
    end
    ;
    (BattleBackground.PreLoad)(data.id, (ProtoEnum.E_BATTLE_TYPE).CG)
  end
)
  end
  -- DECOMPILER ERROR at PC75: Confused about usage of register: R8 in 'UnsetPending'

  if not (HandBookMgr.GetStageIsGetReward)(data.id) and isUnlock then
    (stageModel.c3Ctr).selectedIndex = 1
    if data.type == stageType.Fight then
      local pos = Vector2(stage.width / 2, stage.height / 2)
      mHolder = (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_HANDBOOK_BATTLE_FIGHT, true, stage, pos)
    else
      do
        do
          local pos = Vector2(stage.width / 2, stage.height / 2)
          mHolder = (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_HANDBOOK_BATTLE_STORY, true, stage, pos)
          ;
          (Util.SetSfxClipInList)((mHolder.displayObject).gameObject, uis.MapList)
          -- DECOMPILER ERROR at PC119: Confused about usage of register: R8 in 'UnsetPending'

          ;
          (stageModel.c3Ctr).selectedIndex = 0
          ;
          (stage.onClick):Set(function(...)
    -- function num : 0_9_1 , upvalues : isUnlock, data, stageType, HandBookCardPlotBattleWindow, uis, _ENV
    if isUnlock then
      if data.type == stageType.Fight then
        (HandBookCardPlotBattleWindow.EnterFormation)(data.id)
      else
        if data.type == stageType.Story then
          local pos = ((uis.MapList).scrollPane).posX
          ;
          (HandBookMgr.ReserveStagePos)(pos)
          OpenPlotPlay(data.story_id, PlotPlayTriggerType.INSTANTLY_PLAY, function(...)
      -- function num : 0_9_1_0 , upvalues : _ENV, data
      if not (HandBookMgr.GetStageIsGetReward)(data.id) then
        (HandBookService.OnReqCGCopyStage)(data.id)
      end
    end
, true)
        else
          do
            if data.type == stageType.Reward then
              (HandBookMgr.OnClickBoxEvent)(data)
            end
            if (Util.CheckCondition)(data.open_condition, false) then
              (MessageMgr.SendCenterTips)((PUtil.get)(20000262))
            end
          end
        end
      end
    end
  end
)
        end
      end
    end
  end
end

HandBookCardPlotBattleWindow.EnterFormation = function(stageID, ...)
  -- function num : 0_10 , upvalues : _ENV, uis
  local StageData = ((TableData.gTable).BaseHandbookStageData)[stageID]
  local groupList = split(StageData.monster_group_list, ":")
  local enemyList = (Util.CovertMonsterFormationToLocal)(tonumber(groupList[1]))
  local btnData = {}
  btnData.btnTxt = (PUtil.get)(20000021)
  btnData.fun = function(list, ...)
    -- function num : 0_10_0 , upvalues : _ENV, stageID
    (HandBookService.OnReqInCGCopyStage)(stageID, list)
  end

  local formationData = {}
  formationData.enemyList = enemyList
  local selfMonster = split(StageData.embattle_monster_ids, ":")
  formationData.PrepareList = selfMonster
  local externalData = {}
  externalData.maxFight = StageData.embattle_count_limit
  externalData.mustID = StageData.embattle_need_id
  formationData.ExternalData = externalData
  formationData.BtnData = btnData
  formationData.formationType = FormationType.CG
  formationData.battleType = (ProtoEnum.E_BATTLE_TYPE).CG
  formationData.stageId = stageID
  local pos = ((uis.MapList).scrollPane).posX
  formationData.DetailBtn = function(...)
    -- function num : 0_10_1 , upvalues : groupList, _ENV
    local length = #groupList
    local data = {}
    for i = 1, length do
      local enemyList = (Util.CovertMonsterFormationToLocal)(tonumber(groupList[i]))
      ;
      (table.insert)(data, enemyList)
    end
    OpenWindow((WinResConfig.FormationMonsterInfoWindow).name, UILayer.HUD1, data)
  end

  ;
  (HandBookMgr.ReserveStagePos)(pos)
  ;
  (MessageMgr.OpenFormationWindow)(formationData)
end

HandBookCardPlotBattleWindow.SetMapShow = function(obj, ...)
  -- function num : 0_11 , upvalues : mHolder, _ENV, cardId, HandBookCardPlotBattleWindow
  if mHolder then
    (LuaEffect.DestroyEffect)(mHolder)
  end
  local stageS = (HandBookMgr.GetCardStageList)(cardId)
  for i,v in ipairs(stageS) do
    (HandBookCardPlotBattleWindow.SetStageShow)(obj, v, i)
  end
  local openNum = (HandBookCardPlotBattleWindow.GetChallengeNum)()
  local line = (obj:GetChild("LineGrp")):GetChild("Line_02")
  ChangeUIController(line, "c1", openNum - 1)
end

HandBookCardPlotBattleWindow.GetChallengeNum = function(...)
  -- function num : 0_12 , upvalues : _ENV, cardId
  local stageS = (HandBookMgr.GetCardStageList)(cardId)
  for i,v in ipairs(stageS) do
    if not (HandBookMgr.GetStageIsGetReward)(v.id) then
      return i
    end
  end
  return #stageS
end

HandBookCardPlotBattleWindow.GetLineOrStage = function(num, isStage, ...)
  -- function num : 0_13
  local stageName, lineName = nil, nil
  if num < 10 then
    stageName = "Tips_0" .. num .. "_Grp"
    lineName = "Line_0" .. num
  else
    stageName = "Tips_" .. num .. "_Grp"
    lineName = "Line_" .. num
  end
  if isStage then
    return stageName
  else
    return lineName
  end
end

HandBookCardPlotBattleWindow.OnShown = function(...)
  -- function num : 0_14 , upvalues : _ENV, cardId, HandBookCardPlotBattleWindow
  local fashionId = ((CardData.GetCardData)(cardId)).fashionId
  ;
  (HandBookCardPlotBattleWindow.SetCardTexture)(fashionId)
end

HandBookCardPlotBattleWindow.SetCardTexture = function(fashionId, ...)
  -- function num : 0_15 , upvalues : _ENV, currentFashionID, uis
  local fashionConfig = ((TableData.gTable).BaseFashionData)[fashionId]
  if not fashionConfig then
    loge(fashionId .. "fashionID" .. "未找到" .. "或者show_texture未配置")
    return 
  end
  if not fashionConfig.show_texture then
    (MessageMgr.SendCenterTips)(fashionId .. "未配置show_texture字段")
    return 
  end
  currentFashionID = fashionId
  local textureObj = (Util.ShowUIModel)(fashionConfig.show_texture, uis.CardLoader)
  local scale = fashionConfig.stage_texture__scale / 10000
  ;
  (CSLuaUtil.SetGOScale)(textureObj, scale, scale, scale)
  local positionTable = split(fashionConfig.stage_texture_position, ":")
  ;
  (CSLuaUtil.SetGOLocalPos)(textureObj, tonumber(positionTable[1]), tonumber(positionTable[2]), 0)
  local alphaNum = fashionConfig.stage_texture_pellucidity / 10000
  -- DECOMPILER ERROR at PC60: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (uis.CardLoader).alpha = tonumber(alphaNum)
end

HandBookCardPlotBattleWindow.OnHide = function(...)
  -- function num : 0_16
end

HandBookCardPlotBattleWindow.OnClose = function(...)
  -- function num : 0_17 , upvalues : mHolder, _ENV, uis, contentPane, argTable, HandBookCardPlotBattleWindow
  if mHolder then
    (LuaEffect.DestroyEffect)(mHolder)
  end
  mHolder = nil
  ;
  (Util.RecycleUIModel)(uis.CardLoader)
  uis = nil
  contentPane = nil
  argTable = {}
  ;
  (UpdateMgr.RemoveUpdateHandler)(HandBookCardPlotBattleWindow.Update)
  ;
  (CommonWinMgr.RemoveAssets)((WinResConfig.HandBookCardPlotBattleWindow).name)
end

HandBookCardPlotBattleWindow.InitAssetStrip = function(...)
  -- function num : 0_18 , upvalues : _ENV, uis
  local m = {}
  m.windowName = (WinResConfig.HandBookCardPlotBattleWindow).name
  m.Tip = (PUtil.get)(20000129)
  m.closeToWindow = (WinResConfig.HandBookMainWindow).name
  m.model = uis.AssetStripGrp
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.PHYSICAL}
  m.BackBtnFun = function(...)
    -- function num : 0_18_0 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.HandBookCardPlotBattleWindow).name)
    ;
    (HandBookService.OnReqCGCopySummary)((HandBookMgr.CardPlotWinType).Story)
    ;
    (HandBookMgr.ReserveStagePos)(-1)
  end

  m.CloseBtnFun = function(...)
    -- function num : 0_18_1 , upvalues : _ENV
    UIMgr:CloseToWindow((WinResConfig.HandBookMainWindow).name)
    ;
    (HandBookMgr.ReserveStagePos)(-1)
  end

  m.isSelfClose = true
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

HandBookCardPlotBattleWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_19 , upvalues : HandBookCardPlotBattleWindow
  if msgId == 1 then
    (HandBookCardPlotBattleWindow.InitMap)()
  end
end

return HandBookCardPlotBattleWindow

