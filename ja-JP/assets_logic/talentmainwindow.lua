-- params : ...
-- function num : 0 , upvalues : _ENV
require("Talent_TalentMainByName")
require("CommonResource_AssetStripByName")
require("Talent_TalentSkillByName")
local TalentMainWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local curMatrixTree = 71100001
local curFaZhenId = 71200001
local fazhenRotateTime = 120
local fazhen, fengyin = nil, nil
local rotateTweenPool = {}
local stableEffectPool = {}
local fengyinCircles = {}
local talentTreeAlwaysCircle, oritalentTreeAlwaysCirclePos, selectTalentEffect, selectSealEffect, talentDetailBgEffect = nil, nil, nil, nil, nil
local nodesUIs = {}
local lastClickIndex = 0
local curSelectedPointItem, detailInfoAlwaysCircle = nil, nil
local percents = {5, 20, 35, 50, 65, 80, 100}
local _openFromClose = nil
TalentMainWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, _openFromClose, uis, TalentMainWindow
  bridgeObj:SetView((WinResConfig.TalentMainWindow).package, (WinResConfig.TalentMainWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  _openFromClose = bridgeObj.OpenFromClose
  uis = GetTalent_TalentMainUis(contentPane)
  ;
  (TalentMainWindow.InitBasic)()
end

TalentMainWindow.InitBasic = function(...)
  -- function num : 0_1 , upvalues : _ENV, uis, _openFromClose, TalentMainWindow, detailInfoAlwaysCircle, talentDetailBgEffect, fengyinCircles, lastClickIndex, nodesUIs, curMatrixTree
  local m = {}
  m.windowName = (WinResConfig.TalentMainWindow).name
  m.Tip = (PUtil.get)(121)
  m.model = uis.AssetStripGrp
  m.isSelfClose = true
  m.BackBtnFun = function(...)
    -- function num : 0_1_0 , upvalues : uis, _ENV, _openFromClose, TalentMainWindow, detailInfoAlwaysCircle, talentDetailBgEffect, fengyinCircles, lastClickIndex
    if (uis.c1Ctr).selectedIndex == 0 then
      UIMgr:CloseToWindow((WinResConfig.HomeWindow).name)
    else
      if (uis.c1Ctr).selectedIndex == 1 then
        _openFromClose = false
        ;
        (TalentMainWindow.InitCurTalentTree)()
        if detailInfoAlwaysCircle ~= nil then
          (LuaEffect.DestroyEffect)(detailInfoAlwaysCircle)
          detailInfoAlwaysCircle = nil
        end
        if talentDetailBgEffect ~= nil then
          (LuaEffect.DestroyEffect)(talentDetailBgEffect)
          talentDetailBgEffect = nil
        end
        if #fengyinCircles > 0 then
          for i = 1, 3 do
            (LuaEffect.DestroyEffect)(fengyinCircles[i])
          end
          fengyinCircles = {}
        end
        lastClickIndex = 0
      end
    end
  end

  m.CloseBtnFun = function(...)
    -- function num : 0_1_1 , upvalues : _ENV
    UIMgr:CloseToWindow((WinResConfig.HomeWindow).name)
  end

  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD}
  ;
  (CommonWinMgr.RegisterAssets)(m)
  for i = 1, 7 do
    (table.insert)(nodesUIs, (((uis.Inner).SkillList).root):GetChild("Skill_00" .. tostring(i)))
  end
  curMatrixTree = (TalentData.GetCurShowTalentTree)()
  ;
  (TalentMainWindow.CreatBasicBgEffect)()
  ;
  (TalentMainWindow.InitCurTalentTree)(true)
end

TalentMainWindow.InitCurTalentTree = function(isInit, ...)
  -- function num : 0_2 , upvalues : TalentMainWindow, _ENV, curMatrixTree, uis, talentTreeAlwaysCircle, oritalentTreeAlwaysCirclePos, stableEffectPool, fazhen, fazhenRotateTime, rotateTweenPool, curFaZhenId, selectTalentEffect, _openFromClose
  (TalentMainWindow.OutDetailsFairyGUIEffects)()
  local excelData = ((TableData.gTable).BaseMatrixTreeData)[curMatrixTree]
  local fazhenList = split(excelData.matrix_list, ":")
  local fazhenSource = split(excelData.source, ":")
  local fazhenScale = split(excelData.effect_scale, ":")
  local bgEffects = split(excelData.matrix_bg_effect, ":")
  if isInit then
    local holder, effect = (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_TALENT_BG_FAZHEN2, false, (uis.BGGroup).root, Vector2((uis.BackgroundEffectLoader).width / 2, (uis.BackgroundEffectLoader).height / 2))
    talentTreeAlwaysCircle = effect
    oritalentTreeAlwaysCirclePos = (talentTreeAlwaysCircle.transform).position
    ;
    (Util.PlayAnimation)((talentTreeAlwaysCircle.transform):Find("FX_ui_tianfu_bgfazheng2_grp"), "FX_ui_tianfu_bgfazhegn2_in")
    ;
    (table.insert)(stableEffectPool, holder)
    fazhen = (UIPackage.CreateObject)(fazhenSource[1], fazhenSource[2])
    ;
    ((uis.Outer).root):AddChild(fazhen)
    fazhen.x = DesignScreen.width / 2
    fazhen.y = DesignScreen.height / 2
    local gTween = ((fazhen:TweenRotate(360, fazhenRotateTime)):SetRepeat(-1)):SetEase((FairyGUI.EaseType).Linear)
    ;
    (table.insert)(rotateTweenPool, gTween)
    for index,value in ipairs(fazhenList) do
      do
        local btn = fazhen:GetChild("Magic_" .. tostring(index) .. "_Btn")
        local selectEffect = btn:GetChild("SelectEffect")
        selectEffect.x = selectEffect.x + selectEffect.width / 2
        selectEffect.y = selectEffect.y + selectEffect.height / 2
        local btnTween = ((btn:TweenRotate(-360, fazhenRotateTime)):SetRepeat(-1)):SetEase((FairyGUI.EaseType).Linear)
        ;
        (table.insert)(rotateTweenPool, btnTween)
        ;
        (btn.onClick):Add(function(...)
    -- function num : 0_2_0 , upvalues : curFaZhenId, _ENV, value, bgEffects, index, btn, curMatrixTree, TalentMainWindow
    curFaZhenId = tonumber(value)
    ;
    (TalentData.SaveFazhenCallBackInfo)(curFaZhenId, bgEffects[index], btn)
    local fazhenState = (TalentData.GetFaZhenState)(curMatrixTree, curFaZhenId)
    if fazhenState == 0 then
      (MessageMgr.SendCenterTips)((PUtil.get)(189))
      return 
    else
      if fazhenState == 3 then
        (MessageMgr.SendCenterTips)((PUtil.get)(200))
        return 
      end
    end
    ;
    (TalentMainWindow.InitTalentDetails)(true, bgEffects[index], btn)
  end
)
      end
    end
    -- DECOMPILER ERROR at PC146: Confused about usage of register R11 for local variables in 'ReleaseLocals'

  else
    holder = talentTreeAlwaysCircle
    if holder then
      holder = Util
      holder = holder.SetAnimatorBool
      effect = talentTreeAlwaysCircle.transform
      effect, gTween = effect:Find, effect
      effect = effect(gTween, "FX_ui_tianfu_bgfazheng2_grp")
      gTween = "toDetail"
      holder(effect, gTween, false)
      holder = Util
      holder = holder.SetAnimatorBool
      effect = talentTreeAlwaysCircle.transform
      effect, gTween = effect:Find, effect
      effect = effect(gTween, "FX_ui_tianfu_bgfazheng2_grp")
      gTween = "toMain"
      holder(effect, gTween, true)
      holder = talentTreeAlwaysCircle.transform
      effect = oritalentTreeAlwaysCirclePos
      holder.position = effect
    end
  end
  holder = ipairs
  effect = fazhenList
  holder = holder(effect)
  for index,value in holder do
    local l_0_2_17, l_0_2_18, l_0_2_19, index, value = nil
    l_0_2_17 = fazhen
    l_0_2_17, l_0_2_18 = l_0_2_17:GetChild, l_0_2_17
    l_0_2_19 = "Magic_"
    index = tostring
    -- DECOMPILER ERROR at PC179: Confused about usage of register: R9 in 'UnsetPending'

    value = true
    index = index(value)
    value = "_Btn"
    l_0_2_19 = l_0_2_19 .. index .. value
    l_0_2_17 = l_0_2_17(l_0_2_18, l_0_2_19)
    local btn = nil
    l_0_2_18 = TalentData
    l_0_2_18 = l_0_2_18.GetFaZhenState
    l_0_2_19 = curMatrixTree
    index = tonumber
    value = 
    l_0_2_18 = l_0_2_18(l_0_2_19, index(value))
    local fazhenState = nil
    l_0_2_19 = l_0_2_19(l_0_2_17, "c1")
    l_0_2_19.selectedIndex = l_0_2_18
    if l_0_2_18 == 1 then
      l_0_2_19 = selectTalentEffect
      if l_0_2_19 ~= nil then
        l_0_2_19 = LuaEffect
        l_0_2_19 = l_0_2_19.DestroyEffect
        l_0_2_19(selectTalentEffect)
        l_0_2_19 = nil
        selectTalentEffect = l_0_2_19
      end
      l_0_2_19 = l_0_2_19(l_0_2_17, "SelectEffect")
      local selectEffect = nil
      selectTalentEffect = (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_TALENT_MAIN_XUANZHONG, btn, fazhenState, selectEffect(0, 0))
      -- DECOMPILER ERROR at PC223: Confused about usage of register: R9 in 'UnsetPending'

      -- DECOMPILER ERROR at PC223: Overwrote pending register: R16 in 'AssignReg'

      selectTalentEffect.scale = selectTalentEffect.scale * tonumber(btn)
      -- DECOMPILER ERROR at PC227: Confused about usage of register R18 for local variables in 'ReleaseLocals'

    end
  end
  if _openFromClose then
    local fazhenInfo = nil
    curFaZhenId = ((TalentData.ReturnFazhenCallBackInfo)()).fazhenId
    ;
    (TalentMainWindow.InitTalentDetails)(false, ((TalentData.ReturnFazhenCallBackInfo)()).bgEffects, nil, l_0_2_17)
  end
end

TalentMainWindow.InitTalentDetails = function(isInit, bgEffect, btn, isOpenFromClose, ...)
  -- function num : 0_3 , upvalues : TalentMainWindow, uis, _ENV, talentTreeAlwaysCircle, fengyin, detailInfoAlwaysCircle, fengyinCircles, talentDetailBgEffect, curMatrixTree, curFaZhenId
  (TalentMainWindow.SetAssetType)(1)
  local anmLoader = (uis.Inner).AnimationLoader
  local loaderPos = (((anmLoader.displayObject).gameObject).transform).position
  local anmLoaderScale = (((anmLoader.displayObject).gameObject).transform).lossyScale
  local endPos = Vector3(loaderPos.x + anmLoader.width / 2 * anmLoaderScale.x, loaderPos.y - (anmLoader.height - 20) / 2 * anmLoaderScale.y, 0)
  if isInit then
    (TalentMainWindow.InDetailsFairyGUIEffects)()
    ;
    (TalentMainWindow.ClearSealEffect)()
    if talentTreeAlwaysCircle then
      (Util.SetAnimatorBool)((talentTreeAlwaysCircle.transform):Find("FX_ui_tianfu_bgfazheng2_grp"), "toDetail", true)
      ;
      (Util.SetAnimatorBool)((talentTreeAlwaysCircle.transform):Find("FX_ui_tianfu_bgfazheng2_grp"), "toMain", false)
    end
    if fengyin == nil then
      fengyin = (UIPackage.CreateObject)("Talent", "Star")
      ;
      (((uis.Inner).AGGroup).root):AddChild(fengyin)
      fengyin.x = ((uis.Inner).AnimationLoader).width / 2
      fengyin.y = ((uis.Inner).AnimationLoader).width / 2 - 70
    end
    if detailInfoAlwaysCircle ~= nil then
      (LuaEffect.DestroyEffect)(detailInfoAlwaysCircle)
      detailInfoAlwaysCircle = nil
    end
    if bgEffect ~= nil and btn ~= nil then
      local btnWorldPos = (((btn.displayObject).gameObject).transform).position
      do
        local btnWorldScale = (((btn.displayObject).gameObject).transform).lossyScale
        local worldPos = Vector3(btnWorldPos.x + btn.width / 2 * btnWorldScale.x, btnWorldPos.y - btn.height / 2 * btnWorldScale.y, 0)
        detailInfoAlwaysCircle = (LuaEffect.CreateEffectToObj)(bgEffect, false, ((uis.Inner).BGGroup).root, btn.xy)
        local pressEffect = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_TALENT_SELECT_PRESS, true, true)
        ;
        (((uis.Inner).BGGroup).root):AddChild(pressEffect)
        detailInfoAlwaysCircle.visible = false
        ;
        (SimpleTimer.setTimeout)(0.01, function(...)
    -- function num : 0_3_0 , upvalues : detailInfoAlwaysCircle
    detailInfoAlwaysCircle.visible = true
  end
)
        -- DECOMPILER ERROR at PC150: Confused about usage of register: R12 in 'UnsetPending'

        ;
        (((detailInfoAlwaysCircle.displayObject).gameObject).transform).position = worldPos
        -- DECOMPILER ERROR at PC154: Confused about usage of register: R12 in 'UnsetPending'

        ;
        (((pressEffect.displayObject).gameObject).transform).position = worldPos
        local move = ((FairyGUI.GTween).To)(worldPos, endPos, 0.8)
        move:OnUpdate(function(...)
    -- function num : 0_3_1 , upvalues : detailInfoAlwaysCircle, move, talentTreeAlwaysCircle, _ENV
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R0 in 'UnsetPending'

    if detailInfoAlwaysCircle then
      (((detailInfoAlwaysCircle.displayObject).gameObject).transform).position = (move.value).vec3
      -- DECOMPILER ERROR at PC21: Confused about usage of register: R0 in 'UnsetPending'

      ;
      (talentTreeAlwaysCircle.transform).position = Vector3(((move.value).vec3).x, ((talentTreeAlwaysCircle.transform).position).y, ((talentTreeAlwaysCircle.transform).position).z)
    end
  end
)
        if #fengyinCircles > 0 then
          for i = 1, 3 do
            (LuaEffect.DestroyEffect)(fengyinCircles[i])
          end
        end
        do
          fengyinCircles = {}
          for i = 1, 3 do
            local curfengyinBtn = fengyin:GetChild("Star_00" .. tostring(i) .. "_Btn")
            local idleGrop = curfengyinBtn:GetChild("IdleEffect")
            local tmpEffect = (LuaEffect.CreateEffectToObj)("FX_ui_tianfu_erji_" .. tostring(i), false, idleGrop, Vector2(25, 25))
            ;
            (table.insert)(fengyinCircles, tmpEffect)
          end
        end
        do
          talentDetailBgEffect = (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_TALENT_DETAIL_BG, false, ((uis.Inner).BGGroup).root, Vector2((uis.BackgroundEffectLoader).width / 2, (uis.BackgroundEffectLoader).height / 2))
          -- DECOMPILER ERROR at PC238: Confused about usage of register: R8 in 'UnsetPending'

          if isOpenFromClose then
            (uis.c1Ctr).selectedIndex = 1
            if detailInfoAlwaysCircle ~= nil then
              (LuaEffect.DestroyEffect)(detailInfoAlwaysCircle)
              detailInfoAlwaysCircle = nil
            end
            if talentTreeAlwaysCircle then
              (Util.SetAnimatorBool)((talentTreeAlwaysCircle.transform):Find("FX_ui_tianfu_bgfazheng2_grp"), "toDetail", true)
              ;
              (Util.SetAnimatorBool)((talentTreeAlwaysCircle.transform):Find("FX_ui_tianfu_bgfazheng2_grp"), "toMain", false)
            end
            if fengyin == nil then
              fengyin = (UIPackage.CreateObject)("Talent", "Star")
              ;
              (((uis.Inner).AGGroup).root):AddChild(fengyin)
              fengyin.x = ((uis.Inner).AnimationLoader).width / 2
              fengyin.y = ((uis.Inner).AnimationLoader).width / 2 - 70
            end
            detailInfoAlwaysCircle = (LuaEffect.CreateEffectToObj)(bgEffect, false, ((uis.Inner).BGGroup).root, Vector2(0, 0))
            -- DECOMPILER ERROR at PC311: Confused about usage of register: R8 in 'UnsetPending'

            ;
            (((detailInfoAlwaysCircle.displayObject).gameObject).transform).position = endPos
            -- DECOMPILER ERROR at PC313: Confused about usage of register: R8 in 'UnsetPending'

            ;
            (talentTreeAlwaysCircle.transform).position = endPos
            if #fengyinCircles > 0 then
              for i = 1, 3 do
                (LuaEffect.DestroyEffect)(fengyinCircles[i])
              end
            end
            do
              fengyinCircles = {}
              for i = 1, 3 do
                local curfengyinBtn = fengyin:GetChild("Star_00" .. tostring(i) .. "_Btn")
                local idleGrop = curfengyinBtn:GetChild("IdleEffect")
                local tmpEffect = (LuaEffect.CreateEffectToObj)("FX_ui_tianfu_erji_" .. tostring(i), false, idleGrop, Vector2(25, 25))
                ;
                (table.insert)(fengyinCircles, tmpEffect)
              end
              do
                local fazhenData = (TalentData.GetFaZhenInfo)(curMatrixTree, curFaZhenId)
                local curNode = fazhenData.curNode
                local points = (TalentData.GetPointGrpByFzIdAndCurNode)(curFaZhenId, curNode)
                local nodeData = (TalentMainWindow.SetButtonPointGrp)(points, curNode, curFaZhenId)
                local curSealId = (TalentMainWindow.SetMatrixSealGrp)(fazhenData)
                ;
                (TalentMainWindow.SetAttrInfo)(nodeData.id, 1)
              end
            end
          end
        end
      end
    end
  end
end

TalentMainWindow.SetAttrInfo = function(id, type, ...)
  -- function num : 0_4 , upvalues : _ENV, curMatrixTree, curFaZhenId, uis
  local data, icon, lvl = nil, nil, nil
  local isLast = false
  data = ((TableData.gTable).BaseMatrixNodeData)[id]
  do
    if ((TalentData.GetFaZhenInfo)(curMatrixTree, curFaZhenId)).curNode ~= 0 then
      local curNodeData = ((TableData.gTable).BaseMatrixNodeData)[((TalentData.GetFaZhenInfo)(curMatrixTree, curFaZhenId)).curNode]
      isLast = curNodeData.next == 0
    end
    if isLast then
      lvl = (PUtil.get)(194)
      -- DECOMPILER ERROR at PC39: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (((uis.Inner).AttributeUp).c1Ctr).selectedIndex = 1
    else
      -- DECOMPILER ERROR at PC44: Confused about usage of register: R6 in 'UnsetPending'

      (((uis.Inner).AttributeUp).c1Ctr).selectedIndex = 0
      lvl = (PUtil.get)(191)
    end
    -- DECOMPILER ERROR at PC54: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (((uis.Inner).AttributeUp).NameTxt).text = data.name
    -- DECOMPILER ERROR at PC62: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (((uis.Inner).AttributeUp).IconLoader).url = (Util.GetItemUrl)(data.icon)
    -- DECOMPILER ERROR at PC66: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (((uis.Inner).AttributeUp).LvTxt).visible = false
    local curFaZhenData = ((TableData.gTable).BaseMatrixData)[curFaZhenId]
    local allAttrs = (TalentData.GetTalentTreeAllAttr)()
    local addAttrs = split(data.add_attr_show, ",")
    if isLast then
      addAttrs = ""
    end
    local attrList = ((uis.Inner).AttributeUp).AttributeList
    attrList:RemoveChildrenToPool()
    for i,v in ipairs(allAttrs) do
      local item = attrList:AddItemFromPool()
      local id = v.id
      local add = 0
      for n,m in ipairs(addAttrs) do
        local attr = split(m, ":")
        if tonumber(attr[2]) == id then
          add = tonumber(attr[3])
          break
        end
      end
      local attrData = ((TableData.gTable).BaseAttributeData)[tonumber(id)]
      ;
      (item:GetChild("NameTxt")).text = attrData.display_name
      if add > 0 then
        (item:GetController("c1")).selectedIndex = 1
        ;
        (item:GetChild("AfterTxt")).text = v.value + add
      else
        (item:GetController("c1")).selectedIndex = 0
      end
      ;
      (item:GetChild("NowTxt")).text = v.value
    end
    local costBtn1 = ((uis.Inner).AttributeUp).Spend_001
    local costBtn2 = ((uis.Inner).AttributeUp).Spend_002
    local isCost1Enough = true
    local costStr = split(data.cost, ",")
    local cost1 = tonumber((split(costStr[1], ":"))[2])
    local cost2 = tonumber((split(costStr[2], ":"))[2])
    local isCost2Enough = true
    -- DECOMPILER ERROR at PC186: Confused about usage of register: R17 in 'UnsetPending'

    ;
    (costBtn1.IconLoader).url = (Util.GetItemUrl)(((Util.GetConfigDataByID)(cost1)).icon)
    isCost1Enough = tonumber((split(costStr[1], ":"))[3]) <= (ActorData.GetPropsByID)(cost1)
    -- DECOMPILER ERROR at PC213: Confused about usage of register: R17 in 'UnsetPending'

    if isCost1Enough then
      (costBtn1.NumberTxt).text = "[color=#3dffbd]" .. (split(costStr[1], ":"))[3] .. "[/color]"
    else
      -- DECOMPILER ERROR at PC224: Confused about usage of register: R17 in 'UnsetPending'

      (costBtn1.NumberTxt).text = "[color=#ff5f7b]" .. (split(costStr[1], ":"))[3] .. "[/color]"
    end
    -- DECOMPILER ERROR at PC234: Confused about usage of register: R17 in 'UnsetPending'

    ;
    (costBtn2.IconLoader).url = (Util.GetItemUrl)(((Util.GetConfigDataByID)(cost2)).icon)
    isCost2Enough = tonumber((split(costStr[2], ":"))[3]) <= (ActorData.GetAssetCount)(cost2)
    -- DECOMPILER ERROR at PC261: Confused about usage of register: R17 in 'UnsetPending'

    if isCost2Enough then
      (costBtn2.NumberTxt).text = "[color=#3dffbd]" .. (split(costStr[2], ":"))[3] .. "[/color]"
    else
      -- DECOMPILER ERROR at PC272: Confused about usage of register: R17 in 'UnsetPending'

      (costBtn2.NumberTxt).text = "[color=#ff5f7b]" .. (split(costStr[2], ":"))[3] .. "[/color]"
    end
    local sureBtn = ((uis.Inner).AttributeUp).SureBtn
    ;
    (sureBtn:GetChild("title")).text = (PUtil.get)(196)
    ;
    (sureBtn.onClick):Clear()
    ;
    (sureBtn.onClick):Add(function(...)
    -- function num : 0_4_0 , upvalues : isLast, _ENV, isCost1Enough, cost1, isCost2Enough, cost2, data
    if isLast then
      (MessageMgr.SendCenterTips)((PUtil.get)(193))
      return 
    end
    if isCost1Enough == false then
      (MessageMgr.OpenAssetNotEnoughtWindow)(cost1)
      return 
    end
    if isCost2Enough == false then
      (MessageMgr.OpenAssetNotEnoughtWindow)(cost2)
      return 
    end
    ;
    (TalentService.ReqActivateMatrixNode)(data.matrix_id)
  end
)
    -- DECOMPILER ERROR: 16 unprocessed JMP targets
  end
end

TalentMainWindow.SetButtonPointGrp = function(points, curNode, fazhenId, ...)
  -- function num : 0_5 , upvalues : nodesUIs, curSelectedPointItem, _ENV, uis, percents, lastClickIndex, TalentMainWindow
  local recordIndex = 7
  local showNode = curNode
  local fakeCurNode = curNode
  if curNode == 0 then
    fakeCurNode = points[1] - 1
  end
  for i = 1, 7 do
    local nodeUI = nodesUIs[i]
    local nodeId = points[i]
    local state = nil
    if fakeCurNode + 1 < nodeId then
      state = 0
    else
      if nodeId == fakeCurNode + 1 then
        state = 1
        recordIndex = i
        showNode = nodeId
        curSelectedPointItem = nodeUI
      else
        if nodeId < fakeCurNode + 1 then
          state = 2
        end
      end
    end
    ;
    (nodeUI:GetController("c1")).selectedIndex = state
    local tmpData = ((TableData.gTable).BaseMatrixNodeData)[nodeId]
    ;
    (nodeUI:GetChild("IconLoader")).url = (Util.GetItemUrl)(tmpData.icon)
  end
  local nodeData = ((TableData.gTable).BaseMatrixNodeData)[showNode]
  ;
  ((((uis.Inner).SkillList).root):GetChild("NumberProgressBar")).value = percents[recordIndex]
  ;
  ((((uis.Inner).SkillList).root):GetChild("WordTxt")).text = (PUtil.get)(190)
  if curNode == 0 then
    ((((uis.Inner).SkillList).root):GetChild("NowTxt")).text = "0"
  else
    ;
    ((((uis.Inner).SkillList).root):GetChild("NowTxt")).text = (((TableData.gTable).BaseMatrixNodeData)[curNode]).level
  end
  local fazhenData = ((TableData.gTable).BaseMatrixData)[fazhenId]
  ;
  ((((uis.Inner).SkillList).root):GetChild("MaxTxt")).text = "/" .. fazhenData.max_level
  ;
  ((((uis.Inner).SkillList).root).onClick):Clear()
  ;
  ((((uis.Inner).SkillList).root).onClick):Add(function(...)
    -- function num : 0_5_0 , upvalues : lastClickIndex, TalentMainWindow, nodeData
    lastClickIndex = 0
    ;
    (TalentMainWindow.SetAttrInfo)(nodeData.id, 1)
    ;
    (TalentMainWindow.ClearSealEffect)()
  end
)
  if showNode == curNode then
    ((nodesUIs[7]):GetController("c1")).selectedIndex = 1
  end
  return nodeData
end

TalentMainWindow.SetMatrixSealGrp = function(fazhenData, ...)
  -- function num : 0_6 , upvalues : _ENV, curMatrixTree, curFaZhenId, fengyin, lastClickIndex
  if fazhenData == nil then
    fazhenData = (TalentData.GetFaZhenInfo)(curMatrixTree, curFaZhenId)
  end
  local sortSealInfo = {}
  for index,value in pairs(fazhenData.sealInfo) do
    (table.insert)(sortSealInfo, value)
  end
  ;
  (table.sort)(sortSealInfo, function(a, b, ...)
    -- function num : 0_6_0
    do return a.id < b.id end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  local tmpFengyin = {}
  do
    for i = 1, 3 do
      (table.insert)(tmpFengyin, {id = -1, value = -1})
    end
  end
  local tmpIndex = 1
  local curSealId = 0
  for index,value in ipairs(sortSealInfo) do
    -- DECOMPILER ERROR at PC46: Confused about usage of register: R10 in 'UnsetPending'

    (tmpFengyin[tmpIndex]).id = value.id
    -- DECOMPILER ERROR at PC49: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (tmpFengyin[tmpIndex]).value = value.value
    if value.value > -1 and curSealId == 0 then
      curSealId = value.value
    end
    tmpIndex = tmpIndex + 1
  end
  for i = 1, 3 do
    local curfengyinBtn = fengyin:GetChild("Star_00" .. tostring(i) .. "_Btn")
    local sealId = (tmpFengyin[i]).value
    local selectedIndex = 0
    if sealId == -1 then
      selectedIndex = 0
    else
      if sealId == 0 then
        selectedIndex = 2
        sealId = tonumber("740" .. tostring((tmpFengyin[i]).id) .. "000")
      else
        local sealData = ((TableData.gTable).BaseMatrixSealData)[sealId]
        if sealData.next_type == 0 then
          selectedIndex = 2
        else
          selectedIndex = 3
        end
      end
    end
    do
      do
        ;
        (curfengyinBtn:GetController("c1")).selectedIndex = selectedIndex
        ;
        (curfengyinBtn.onClick):Clear()
        ;
        (curfengyinBtn.onClick):Add(function(...)
    -- function num : 0_6_1 , upvalues : selectedIndex, _ENV, lastClickIndex, i, sealId, curMatrixTree, curFaZhenId
    if selectedIndex == 0 then
      (MessageMgr.SendCenterTips)((PUtil.get)(192))
      return 
    end
    lastClickIndex = i
    OpenWindow((WinResConfig.TalentStarUpWindow).name, UILayer.HUD, sealId, curMatrixTree, curFaZhenId, i)
  end
)
        if selectedIndex == 2 then
          curSealId = sealId
        end
        -- DECOMPILER ERROR at PC119: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  return curSealId
end

TalentMainWindow.SetSealEffect = function(btn, ...)
  -- function num : 0_7 , upvalues : fengyin, _ENV, selectSealEffect
  if btn == nil then
    for i = 1, 3 do
      local curfengyinBtn = fengyin:GetChild("Star_00" .. tostring(i) .. "_Btn")
      if (curfengyinBtn:GetController("c1")).selectedIndex == 2 then
        btn = curfengyinBtn
      end
    end
  end
  do
    if selectSealEffect ~= nil then
      (LuaEffect.DestroyEffect)(selectSealEffect)
    end
    selectSealEffect = (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_TALENT_MAIN_XUANZHONG, false, btn, Vector2(btn.width / 2, btn.height / 2))
  end
end

TalentMainWindow.ClearSealEffect = function(...)
  -- function num : 0_8 , upvalues : selectSealEffect, _ENV
  if selectSealEffect ~= nil then
    (LuaEffect.DestroyEffect)(selectSealEffect)
  end
end

TalentMainWindow.CreatBasicBgEffect = function(...)
  -- function num : 0_9 , upvalues : _ENV, uis, stableEffectPool
  local holder, effect = (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_TALENT_BG_FAZHEN, false, (uis.BGGroup).root, Vector2((uis.BackgroundEffectLoader).width / 2, (uis.BackgroundEffectLoader).height / 2))
  ;
  (table.insert)(stableEffectPool, holder)
end

TalentMainWindow.InDetailsFairyGUIEffects = function(...)
  -- function num : 0_10 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

  (uis.c1Ctr).selectedIndex = 1
  PlayUITrans((uis.Inner).root, "in")
  for i = 1, 4 do
    (((uis.AssetStripGrp).root):GetChild("Assets_0" .. tostring(i) .. "_Grp")).visible = true
  end
end

TalentMainWindow.OutDetailsFairyGUIEffects = function(...)
  -- function num : 0_11 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

  (uis.c1Ctr).selectedIndex = 0
  for i = 1, 4 do
    (((uis.AssetStripGrp).root):GetChild("Assets_0" .. tostring(i) .. "_Grp")).visible = false
  end
end

TalentMainWindow.NodeLvlUpEffect = function(item, ...)
  -- function num : 0_12 , upvalues : _ENV
  local holder = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_TALENT_POINT_UP, true, true)
  holder:SetXY(item.width / 2, item.height / 2)
  item:AddChild(holder)
end

TalentMainWindow.OnClose = function(...)
  -- function num : 0_13 , upvalues : uis, contentPane, argTable, nodesUIs, fazhen, fengyin, curSelectedPointItem, lastClickIndex, _ENV, rotateTweenPool, stableEffectPool, selectTalentEffect, detailInfoAlwaysCircle, TalentMainWindow, talentDetailBgEffect, fengyinCircles
  (((uis.Inner).AttributeUp).AttributeList):RemoveChildrenToPool()
  uis = nil
  contentPane = nil
  argTable = {}
  nodesUIs = {}
  fazhen = nil
  fengyin = nil
  curSelectedPointItem = nil
  lastClickIndex = 0
  for index,value in ipairs(rotateTweenPool) do
    value:Kill()
  end
  rotateTweenPool = {}
  for index,value in ipairs(stableEffectPool) do
    if value then
      (LuaEffect.DestroyEffect)(value)
    end
  end
  stableEffectPool = {}
  if selectTalentEffect ~= nil then
    (LuaEffect.DestroyEffect)(selectTalentEffect)
    selectTalentEffect = nil
  end
  if detailInfoAlwaysCircle ~= nil then
    (LuaEffect.DestroyEffect)(detailInfoAlwaysCircle)
    detailInfoAlwaysCircle = nil
  end
  ;
  (TalentMainWindow.ClearSealEffect)()
  if talentDetailBgEffect ~= nil then
    (LuaEffect.DestroyEffect)(talentDetailBgEffect)
    talentDetailBgEffect = nil
  end
  if #fengyinCircles > 0 then
    for i = 1, 3 do
      (LuaEffect.DestroyEffect)(fengyinCircles[i])
    end
  end
  do
    fengyinCircles = {}
    ;
    (CommonWinMgr.RemoveAssets)((WinResConfig.TalentMainWindow).name)
  end
end

TalentMainWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_14 , upvalues : _ENV, curMatrixTree, curFaZhenId, TalentMainWindow, curSelectedPointItem, uis
  local windowMsgEnum = WindowMsgEnum.Talent
  local type = 1
  local delay = 0
  if msgId == windowMsgEnum.E_MSG_TALENT_UP_NODE then
    (TalentData.SaveActivePoint)(curMatrixTree, curFaZhenId, (para.msg).nodeId)
    ;
    (TalentMainWindow.NodeLvlUpEffect)(curSelectedPointItem)
    if (para.msg).unlockMatrix ~= nil then
      (TalentData.AddNewMatrixInfo)(curMatrixTree, (para.msg).unlockMatrix)
    end
    type = 1
    delay = 0.5
    -- DECOMPILER ERROR at PC31: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (GRoot.inst).touchable = false
    local holder = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_TALENT_POINT_UP, true, true, nil, 1.6)
    ;
    (((uis.Inner).AttributeUp).root):AddChild(holder)
    holder:SetXY((((uis.Inner).AttributeUp).IconLoader).x + (((uis.Inner).AttributeUp).IconLoader).width * 1.7 / 2, (((uis.Inner).AttributeUp).IconLoader).y + (((uis.Inner).AttributeUp).IconLoader).height * 1.7 / 2)
  else
    do
      if msgId == windowMsgEnum.E_MSG_TALENT_STARUP_CLOSE then
        (TalentMainWindow.SetMatrixSealGrp)()
      end
      if delay > 0 then
        (SimpleTimer.setTimeout)(delay, function(...)
    -- function num : 0_14_0 , upvalues : TalentMainWindow, _ENV
    (TalentMainWindow.InitTalentDetails)(false)
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (GRoot.inst).touchable = true
  end
)
      else
        ;
        (TalentMainWindow.InitTalentDetails)(false)
      end
    end
  end
end

TalentMainWindow.SetAssetType = function(type, ...)
  -- function num : 0_15 , upvalues : _ENV
  local moneyTypes = nil
  if type == 1 then
    moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, ParticularAssetType.TALENT_LVLUP_MAT, ParticularAssetType.TALENT_STARUP_MAT}
  else
    if type == 2 then
      moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, ParticularAssetType.TALENT_STARUP_MAT}
    end
  end
  ;
  (CommonWinMgr.ChangeAssetsType)((WinResConfig.TalentMainWindow).name, moneyTypes)
end

return TalentMainWindow

