-- params : ...
-- function num : 0 , upvalues : _ENV
require("CommonResource_AssetStripByName")
local m = {}
local AssetStripWindow = {}
local openWindowList = {}
local assetList = {}
local uis = nil
local actId = 0
local diamondSfx, bindSfx = nil, nil
local sfxOffset = Vector2(10, 28)
AssetStripWindow.Init = function(params, ...)
  -- function num : 0_0 , upvalues : uis, openWindowList, assetList, _ENV, AssetStripWindow
  local model = params.model
  uis = model
  local windowName = params.windowName
  local Tip = params.Tip
  local openName = params.closeToWindow
  local moneyTypes = params.moneyTypes
  local BackBtnFun = params.BackBtnFun
  local CloseBtnFun = params.CloseBtnFun
  local isShowConfirm = params.isShowConfirm
  local ConfirmContent = params.ConfirmContent
  local isSelfClose = params.isSelfClose
  local activityId = params.activityId
  local activityIds = params.activityIds
  openWindowList[windowName] = params
  assetList[windowName] = moneyTypes
  if model.BackBtn then
    (LuaSound.SetClickSound)(model.BackBtn, LuaSound.COMMON_WIN_BACK)
  end
  if model.CloseBtn then
    (LuaSound.SetClickSound)(model.CloseBtn, LuaSound.COMMON_WIN_CLOSE)
  end
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R13 in 'UnsetPending'

  ;
  ((model.Double_01_Grp).root).visible = false
  -- DECOMPILER ERROR at PC38: Confused about usage of register: R13 in 'UnsetPending'

  ;
  ((model.Double_02_Grp).root).visible = false
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R13 in 'UnsetPending'

  ;
  ((model.Double_03_Grp).root).visible = false
  do
    if activityId then
      local isActive = (ActivityMgr.GetActivityIsOpenByID)(activityId)
      if isActive then
        (ActivityService.OnReqActivityInfo)(nil, 1, activityId)
      end
    end
    if activityIds and #activityIds > 0 then
      do
        for index,value in ipairs(activityIds) do
          print("***************value", value)
          local isActive = (ActivityMgr.GetActivityIsOpenByID)(value)
          if isActive then
            (ActivityService.OnReqActivityInfo)(nil, 1, value)
          end
        end
      end
    end
    do
      ;
      (AssetStripWindow.inItButton)(model.BackBtn, function(...)
    -- function num : 0_0_0 , upvalues : isShowConfirm, _ENV, ConfirmContent, BackBtnFun, isSelfClose, windowName
    if isShowConfirm then
      (MessageMgr.OpenConfirmWindow)(ConfirmContent, function(...)
      -- function num : 0_0_0_0 , upvalues : BackBtnFun, isSelfClose, _ENV, windowName
      if BackBtnFun then
        BackBtnFun()
      end
      if not isSelfClose then
        UIMgr:CloseWindow(windowName)
      end
    end
)
    else
      if BackBtnFun then
        BackBtnFun()
      end
      if not isSelfClose then
        UIMgr:CloseWindow(windowName)
      end
    end
  end
)
      local wordID = (AssetStripWindow.GetFunctionRuleIdByName)(windowName)
      if wordID and wordID > 0 then
        local ruleDes = (PUtil.get)(tonumber(wordID))
        -- DECOMPILER ERROR at PC101: Confused about usage of register: R15 in 'UnsetPending'

        ;
        (model.ExplainBtn).visible = true
        ;
        ((model.ExplainBtn).onClick):Set(function(...)
    -- function num : 0_0_1 , upvalues : _ENV, ruleDes
    OpenWindow((WinResConfig.ExplainWindow).name, UILayer.HUD1, tostring(ruleDes))
  end
)
      else
        do
          -- DECOMPILER ERROR at PC110: Confused about usage of register: R14 in 'UnsetPending'

          ;
          (model.ExplainBtn).visible = false
          ;
          (AssetStripWindow.inItCloseBtn)(model.CloseBtn, openName, CloseBtnFun, isShowConfirm, ConfirmContent, isSelfClose, windowName)
          ;
          (AssetStripWindow.inItAsset)(params, moneyTypes)
          -- DECOMPILER ERROR at PC125: Confused about usage of register: R14 in 'UnsetPending'

          ;
          (model.FunctionNameTxt).text = Tip
          ;
          ((model.root):GetTransition("in")).invalidateBatchingEveryFrame = true
        end
      end
    end
  end
end

AssetStripWindow.GetFunctionRuleIdByName = function(name, ...)
  -- function num : 0_1 , upvalues : _ENV
  local windowNameData = (TableData.gTable).BaseWindowNameData
  for _,v in pairs(windowNameData) do
    if v.window_name == name then
      if (Util.StringIsNullOrEmpty)(v.rule_des) then
        return 
      end
      local cons = (Util.ParseConfigStr)(v.rule_des)
      for _,v in ipairs(cons) do
        local functionID = tonumber(v[1])
        if functionID == 0 or (FunctionControlMgr.GetFunctionState)(functionID) then
          return tonumber(v[2])
        end
      end
    end
  end
end

AssetStripWindow.inItCloseBtn = function(model, winName, func, isShowConfirm, content, isSelfClose, windowName, ...)
  -- function num : 0_2 , upvalues : _ENV
  local openWindow = winName
  if not openWindow then
    openWindow = (WinResConfig.HomeWindow).name
  end
  ;
  (model.onClick):Set(function(...)
    -- function num : 0_2_0 , upvalues : _ENV, openWindow, windowName, isShowConfirm, content, func, isSelfClose
    if UIMgr:IsWindowInList(openWindow) == false then
      UIMgr:CloseWindow(windowName)
      return 
    end
    if isShowConfirm then
      (MessageMgr.OpenConfirmWindow)(content, function(...)
      -- function num : 0_2_0_0 , upvalues : func, isSelfClose, _ENV, openWindow
      if func then
        func()
      end
      if not isSelfClose then
        UIMgr:CloseToWindow(openWindow)
      end
    end
)
    else
      if func then
        func()
      end
      if not isSelfClose then
        UIMgr:CloseToWindow(openWindow)
      end
    end
  end
)
end

AssetStripWindow.inItButton = function(model, fuc, ...)
  -- function num : 0_3 , upvalues : _ENV
  if fuc and type(fuc) == "function" then
    (model.onClick):Add(fuc)
  else
    model.visible = false
  end
end

AssetStripWindow.RemoveWindow = function(name, ...)
  -- function num : 0_4 , upvalues : openWindowList, assetList, diamondSfx, _ENV, bindSfx, uis
  openWindowList[name] = nil
  assetList[name] = nil
  if diamondSfx ~= nil then
    (LuaEffect.DestroyEffect)(diamondSfx)
    diamondSfx = nil
  end
  if bindSfx ~= nil then
    (LuaEffect.DestroyEffect)(bindSfx)
    bindSfx = nil
  end
  uis = nil
end

AssetStripWindow.ChangeAssetType = function(name, types, ...)
  -- function num : 0_5 , upvalues : openWindowList, AssetStripWindow, assetList
  if openWindowList[name] then
    (AssetStripWindow.inItAsset)(openWindowList[name], types)
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (openWindowList[name]).moneyTypes = types
    assetList[name] = types
  end
end

AssetStripWindow.inItAsset = function(info, moneyTypes, ...)
  -- function num : 0_6 , upvalues : _ENV, diamondSfx, sfxOffset, bindSfx, AssetStripWindow
  local ids = moneyTypes
  info.AssetPanel = {}
  for i = 1, 4 do
    local index = 5 - i
    do
      local btnUi = (Util.GetGroupDate)((info.model).root, (info.model).CloseAssetGrp, index)
      local assetBtn = GetCommonResource_AssetsButtonUis(btnUi)
      do
        local moneyType = ids[#ids - i + 1]
        -- DECOMPILER ERROR at PC26: Confused about usage of register: R11 in 'UnsetPending'

        if moneyType then
          (info.AssetPanel)[moneyType] = assetBtn
          -- DECOMPILER ERROR at PC28: Confused about usage of register: R11 in 'UnsetPending'

          ;
          (assetBtn.root).visible = true
          -- DECOMPILER ERROR at PC39: Confused about usage of register: R11 in 'UnsetPending'

          if moneyType == AssetType.PHYSICAL then
            (assetBtn.NumberTxt).text = (ActorData.GetSpecifyFormatText)(AssetType.PHYSICAL)
          else
            -- DECOMPILER ERROR at PC51: Confused about usage of register: R11 in 'UnsetPending'

            if moneyType == AssetType.ENDURANCE then
              (assetBtn.NumberTxt).text = (ActorData.GetSpecifyFormatText)(AssetType.ENDURANCE)
            else
              -- DECOMPILER ERROR at PC64: Confused about usage of register: R11 in 'UnsetPending'

              if (Util.IsInParticularAssetConfig)(moneyType) then
                (assetBtn.NumberTxt).text = (ActorData.GetPropsByID)(moneyType)
              else
                -- DECOMPILER ERROR at PC71: Confused about usage of register: R11 in 'UnsetPending'

                ;
                (assetBtn.NumberTxt).text = (ActorData.GetAssetText)(moneyType)
              end
            end
          end
          if moneyType == AssetType.DIAMOND then
            if diamondSfx == nil then
              diamondSfx = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_DIAMOND_FLASH, false, false)
            end
            diamondSfx.xy = sfxOffset
            btnUi:AddChild(diamondSfx)
          end
          if moneyType == AssetType.DIAMOND_BIND then
            if bindSfx == nil then
              bindSfx = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_DIAMOND_FLASH, false, false)
            end
            bindSfx.xy = sfxOffset
            btnUi:AddChild(bindSfx)
          end
          local icon = (AssetStripWindow.GetAssetIcon)(moneyType)
          -- DECOMPILER ERROR at PC120: Confused about usage of register: R12 in 'UnsetPending'

          ;
          (assetBtn.AssetsSmallIconLoader).url = (Util.GetItemUrl)(icon)
          -- DECOMPILER ERROR at PC125: Confused about usage of register: R12 in 'UnsetPending'

          ;
          (assetBtn.AssetsSmallIconLoader).fill = (FairyGUI.FillType).ScaleNoBorder
          ;
          (btnUi.onClick):Set(function(...)
    -- function num : 0_6_0 , upvalues : AssetStripWindow, moneyType
    (AssetStripWindow.OnClickMoney)(moneyType)
  end
)
        else
          do
            -- DECOMPILER ERROR at PC132: Confused about usage of register: R11 in 'UnsetPending'

            ;
            (assetBtn.root).visible = false
          end
        end
        -- DECOMPILER ERROR at PC134: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
end

AssetStripWindow.IsInPropConfig = function(type, ...)
  -- function num : 0_7 , upvalues : _ENV
  for _,v in pairs(ParticularAssetType) do
    if v == type then
      return true
    end
  end
end

AssetStripWindow.UpdateAsset = function(info, modifyType, value, ...)
  -- function num : 0_8 , upvalues : _ENV
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'

  -- DECOMPILER ERROR at PC9: Unhandled construct in 'MakeBoolean' P1

  if modifyType ~= nil and (info.AssetPanel)[modifyType] ~= nil then
    (((info.AssetPanel)[modifyType]).NumberTxt).text = value
  end
  for k,v in pairs(info.moneyTypes) do
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R8 in 'UnsetPending'

    if v == AssetType.PHYSICAL then
      (((info.AssetPanel)[v]).NumberTxt).text = (ActorData.GetSpecifyFormatText)(AssetType.PHYSICAL)
    else
      -- DECOMPILER ERROR at PC41: Confused about usage of register: R8 in 'UnsetPending'

      if v == AssetType.ENDURANCE then
        (((info.AssetPanel)[v]).NumberTxt).text = (ActorData.GetSpecifyFormatText)(AssetType.ENDURANCE)
      else
        -- DECOMPILER ERROR at PC56: Confused about usage of register: R8 in 'UnsetPending'

        if (Util.IsInParticularAssetConfig)(v) then
          (((info.AssetPanel)[v]).NumberTxt).text = (ActorData.GetPropsByID)(v)
        else
          -- DECOMPILER ERROR at PC65: Confused about usage of register: R8 in 'UnsetPending'

          ;
          (((info.AssetPanel)[v]).NumberTxt).text = (ActorData.GetAssetText)(v)
        end
      end
    end
  end
end

AssetStripWindow.OnClickMoney = function(moneyType, ...)
  -- function num : 0_9 , upvalues : _ENV
  print("open moneyTip" .. moneyType)
  if moneyType == AssetType.DIAMOND then
    ld("Shop")
    ;
    (ShopMgr.ExternalGotoShop)(ShopType.Recharge)
  else
    if moneyType == AssetType.GOLD then
      (AssetShopService.ReqGetBuyAssistNum)((ProtoEnum.BUY_ASSIST_TYPE).GOLD_BUY_TIME_TYPE)
    else
      if moneyType == AssetType.PHYSICAL then
        (AssetShopService.ReqGetBuyAssistNum)((ProtoEnum.BUY_ASSIST_TYPE).VIT_BUY_TIME_TYPE)
      else
        if moneyType == AssetType.ENDURANCE then
          (AssetShopService.ReqGetBuyAssistNum)((ProtoEnum.BUY_ASSIST_TYPE).STA_BUY_TIME_TYPE)
        else
          if moneyType == AssetType.SPIRIT then
            (AssetShopService.ReqGetBuyAssistNum)((ProtoEnum.BUY_ASSIST_TYPE).ENERGY_BUY_TIME_TYPE)
          else
            if moneyType == ParticularAssetType.CHARACTOR_TICKET then
              OpenWindow((WinResConfig.TicketWindow).name, UILayer.HUD, 21160002)
            else
              if moneyType == AssetType.EQUIP_EXP then
                (Util.ShowGetWay)(AssetType.EQUIP_EXP)
              else
                if moneyType == AssetType.DIAMOND_BIND then
                  (Util.ShowGetWay)(AssetType.DIAMOND_BIND)
                else
                  if moneyType == ParticularAssetType.TALENT_LVLUP_MAT then
                    (Util.ShowGetWay)(ParticularAssetType.TALENT_LVLUP_MAT)
                  else
                    if moneyType == ParticularAssetType.TALENT_STARUP_MAT then
                      (Util.ShowGetWay)(ParticularAssetType.TALENT_STARUP_MAT)
                    else
                      if moneyType == ParticularAssetType.CUSTOM_TICKET then
                        (Util.ShowGetWay)(ParticularAssetType.CUSTOM_TICKET)
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

AssetStripWindow.GetAssetIcon = function(moneyType, ...)
  -- function num : 0_10 , upvalues : _ENV
  do
    if (Util.IsInParticularAssetConfig)(moneyType) then
      local data = ((TableData.gTable).BasePropData)[tonumber(moneyType)]
      if data then
        return data.icon
      end
    end
    local data = ((TableData.gTable).BaseAssetData)[tonumber(moneyType)]
    if data == nil then
      loge("not find " .. moneyType .. "in BaseAsset")
      return 
    end
    return data.icon
  end
end

AssetStripWindow.RefreshAsset = function(...)
  -- function num : 0_11 , upvalues : _ENV, openWindowList, AssetStripWindow
  for windowName,windowInfo in pairs(openWindowList) do
    local window = UIMgr:GetWindow(windowName)
    if window and not window.IsClose then
      (AssetStripWindow.UpdateAsset)(windowInfo)
    end
  end
end

AssetStripWindow.RefreshAssetAmount = function(winName, moneyType, moneyNum, ...)
  -- function num : 0_12 , upvalues : _ENV, openWindowList, AssetStripWindow
  for windowName,windowInfo in pairs(openWindowList) do
    if windowName == winName then
      local window = UIMgr:GetWindow(windowName)
      if window and not window.IsClose then
        (AssetStripWindow.UpdateAsset)(windowInfo, moneyType, moneyNum)
      end
    end
  end
end

AssetStripWindow.SetCountDownData = function(id, endTime, ...)
  -- function num : 0_13 , upvalues : _ENV, actId, uis
  local excelData = ((TableData.gTable).BaseActivityData)[id]
  local icons = split(excelData.double_icons, ",")
  actId = id
  for i,v in ipairs(icons) do
    local content = (PUtil.get)(tonumber((split(v, "|"))[3]))
    local name = (PUtil.get)(tonumber((split(v, "|"))[2]))
    local icon = (split(v, "|"))[1]
    local map = (uis.root):GetChild("Double_0" .. i .. "_Grp")
    map.visible = true
    ;
    (map:GetChild("IconLoader")).url = (Util.GetItemUrl)(icon)
    ;
    (map:GetChild("TimeTxt")).text = (LuaTime.GetLeftTimeStr)((math.floor)(endTime * 0.001), true)
    ;
    (CommonWinMgr.RegisterMultipleLongPress)(map, name, content, (Util.GetItemUrl)(icon), endTime)
  end
end

AssetStripWindow.HideMultiple = function(id, ...)
  -- function num : 0_14 , upvalues : actId, uis
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

  if id == actId then
    ((uis.Double_01_Grp).root).visible = false
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((uis.Double_02_Grp).root).visible = false
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((uis.Double_03_Grp).root).visible = false
  end
end

return AssetStripWindow

