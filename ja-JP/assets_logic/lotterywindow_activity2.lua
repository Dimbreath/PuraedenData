-- params : ...
-- function num : 0 , upvalues : _ENV
LotteryWindow_Activity2 = {}
local LotteryCardId = {single = 24000071, ten = 24000072, day = 24000073}
local CostType = {Free = 1, Ticket = 2, Diamond = 3}
local countTimer = nil
local lotteryType = 8
local fx_main, uis, beginTime, endTime = nil, nil, nil, nil
-- DECOMPILER ERROR at PC15: Confused about usage of register: R8 in 'UnsetPending'

LotteryWindow_Activity2.RefreshWindow = function(_uis, ...)
  -- function num : 0_0 , upvalues : uis, _ENV
  if uis == nil then
    uis = _uis
  end
  ;
  (LotteryWindow_Activity2.ReceiveInitData)()
end

-- DECOMPILER ERROR at PC18: Confused about usage of register: R8 in 'UnsetPending'

LotteryWindow_Activity2.PreLoadFxMain = function(uis, ...)
  -- function num : 0_1 , upvalues : _ENV, lotteryType, fx_main
  local excelShowData = ((TableData.gTable).BaseLotteryShowData)[lotteryType]
  local lotteryCardId = tonumber(excelShowData.card_ids)
  local cardData = ((TableData.gTable).BaseCardData)[lotteryCardId]
  local fashionId = tonumber((split(cardData.fashion_ids, ":"))[3])
  local fashionData = ((TableData.gTable).BaseFashionData)[fashionId]
  do
    if fx_main == nil then
      local holder, effect = (LuaEffect.AddUIEffect)(fashionData.show_cg, false, false, Vector3.zero, 1)
      holder:SetXY((((((uis.LotteryPanelGrp).GetCha_NewCardUpGrp).CharacterNewCardUpComp).CardPicLoader).CardPicLoader).width / 2, (((((uis.LotteryPanelGrp).GetCha_NewCardUpGrp).CharacterNewCardUpComp).CardPicLoader).CardPicLoader).height / 2)
      ;
      (((((uis.LotteryPanelGrp).GetCha_NewCardUpGrp).CharacterNewCardUpComp).CardPicLoader).root):AddChild(holder)
      fx_main = effect
    end
    ;
    (Util.RecycleUIModel)((((uis.LotteryPanelGrp).GetCha_NewCardUpGrp).CharacterNewCardUpComp).CardLoader)
    local boneModel = (Util.ShowUIModel)(fashionData.spd_bundle, (((uis.LotteryPanelGrp).GetCha_NewCardUpGrp).CharacterNewCardUpComp).CardLoader, fashionData.show_spine_type)
    ;
    (SkeletonAnimationUtil.SetAnimation)(boneModel, 0, "idle", true)
    local scale = 20
    ;
    (CSLuaUtil.SetGOScale)(boneModel, scale, scale, scale)
    ;
    (SkeletonAnimationUtil.SetFlip)(boneModel, true, false)
    ;
    (CSLuaUtil.SetGOLocalPos)(boneModel, ((((uis.LotteryPanelGrp).GetCha_NewCardUpGrp).CharacterNewCardUpComp).CardLoader).width * 0.5, -((((uis.LotteryPanelGrp).GetCha_NewCardUpGrp).CharacterNewCardUpComp).CardLoader).height, 0)
    ;
    (((((uis.LotteryPanelGrp).GetCha_NewCardUpGrp).CharacterNewCardUpComp).Card_01_Btn).onClick):Set(function(...)
    -- function num : 0_1_0 , upvalues : _ENV, lotteryCardId
    OpenWindow("CardDetailsWindow", UILayer.HUD, lotteryCardId)
  end
)
  end
end

-- DECOMPILER ERROR at PC21: Confused about usage of register: R8 in 'UnsetPending'

LotteryWindow_Activity2.ReceiveInitData = function(...)
  -- function num : 0_2 , upvalues : _ENV, beginTime, endTime, countTimer, uis, LotteryCardId
  local lData = ((LotteryData.GetLotteryData)()).data
  print("beginTime", lData.beginTime, "endTime", lData.endTime, "onceSurplusNum", lData.onceSurplusNum, "moreSurplusNum", lData.moreSurplusNum)
  beginTime = lData.beginTime
  endTime = lData.endTime
  if lData.onceCdTime > 0 then
    if countTimer ~= nil then
      countTimer:Stop()
    end
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (((uis.LotteryPanelGrp).GetCha_NewCardUpGrp).TimeTxt).visible = true
    ;
    ((((uis.LotteryPanelGrp).GetCha_NewCardUpGrp).OneTimeBtn):GetChild("FreeNumberTxt")).visible = false
    countTimer = (LuaTime.CountDown)(lData.onceCdTime * 0.001, ((uis.LotteryPanelGrp).GetCha_NewCardUpGrp).TimeTxt, function(...)
    -- function num : 0_2_0 , upvalues : uis, _ENV, LotteryCardId, lData
    -- DECOMPILER ERROR at PC3: Confused about usage of register: R0 in 'UnsetPending'

    (((uis.LotteryPanelGrp).GetCha_NewCardUpGrp).TimeTxt).visible = false
    ;
    ((((uis.LotteryPanelGrp).GetCha_NewCardUpGrp).OneTimeBtn):GetChild("FreeNumberTxt")).visible = true
    ;
    ((((uis.LotteryPanelGrp).GetCha_NewCardUpGrp).OneTimeBtn):GetChild("Number_01_Loader")).visible = false
    local excelData = ((TableData.gTable).BaseLotteryData)[LotteryCardId.single]
    ;
    ((((uis.LotteryPanelGrp).GetCha_NewCardUpGrp).OneTimeBtn):GetChild("Number_01_Txt")).text = (PUtil.get)(90)
    ;
    ((((uis.LotteryPanelGrp).GetCha_NewCardUpGrp).OneTimeBtn):GetChild("FreeNumberTxt")).text = (PUtil.get)(89, lData.onceFreeNum, excelData.day_free_num)
  end
)
  else
    -- DECOMPILER ERROR at PC52: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (((uis.LotteryPanelGrp).GetCha_NewCardUpGrp).TimeTxt).visible = false
  end
  ;
  (LotteryWindow_Activity2.SetButtonInfo)(((uis.LotteryPanelGrp).GetCha_NewCardUpGrp).OneTimeBtn, LotteryCardId.single, lData.onceFreeNum)
  ;
  (LotteryWindow_Activity2.SetButtonInfo)(((uis.LotteryPanelGrp).GetCha_NewCardUpGrp).TenTimeBtn, LotteryCardId.ten, lData.moreFreeNum)
  ;
  (LotteryWindow_Activity2.SetButtonInfo)(((uis.LotteryPanelGrp).GetCha_NewCardUpGrp).SpecialOneTimeBtn, LotteryCardId.day, 0, lData.dayLottery)
end

-- DECOMPILER ERROR at PC24: Confused about usage of register: R8 in 'UnsetPending'

LotteryWindow_Activity2.SetButtonInfo = function(btn, id, freeNum, dayLottery, sound, ...)
  -- function num : 0_3 , upvalues : _ENV, uis, LotteryCardId, beginTime, endTime, CostType
  local excelData = ((TableData.gTable).BaseLotteryData)[id]
  local costStr, haveCount, needCount = nil, nil, nil
  local isKaQuan = excelData.type == 3
  if freeNum > 0 and (((uis.LotteryPanelGrp).GetCha_NewCardUpGrp).TimeTxt).visible == false then
    (btn:GetChild("Number_01_Loader")).visible = false
    ;
    (btn:GetChild("FreeNumberTxt")).visible = true
    ;
    (btn:GetChild("Number_01_Txt")).text = (PUtil.get)(90)
    ;
    (btn:GetChild("FreeNumberTxt")).text = (PUtil.get)(89, freeNum, excelData.day_free_num)
  else
    (btn:GetChild("Number_01_Loader")).visible = true
    if btn:GetChild("FreeNumberTxt") then
      (btn:GetChild("FreeNumberTxt")).visible = false
    end
    if isKaQuan or dayLottery then
      costStr = split(excelData.cost, ":")
    elseif (string.len)(excelData.first_cost) > 1 then
      local cStr1 = split(excelData.first_cost, ":")
      haveCount = (ActorData.GetGoodsCount)(cStr1[2], tonumber(cStr1[1])) or 0
      needCount = tonumber(cStr1[3])
      if needCount <= haveCount then
        costStr = cStr1
      else
        local cStr2 = split(excelData.cost, ":")
        costStr = cStr2
      end
    else
      local cStr2 = split(excelData.cost, ":")
      costStr = cStr2
    end
    if costStr[2] then
      (btn:GetChild("Number_01_Loader")).url = (Util.GetItemUrl)(((Util.GetConfigDataByID)(costStr[2])).icon)
    end
    if costStr[3] then
      (btn:GetChild("Number_01_Txt")).text = costStr[3]
    end
  end
  if (id == LotteryCardId.single and id ~= LotteryCardId.ten) or id == LotteryCardId.day then
    if dayLottery then
      (btn:GetController("c1")).selectedIndex = 0
    else
      (btn:GetController("c1")).selectedIndex = 1
      ;
      (btn:GetChild("WordTxt")).text = (PUtil.get)(170)
    end
  end
  ;
  (btn.onClick):ClearCallFunc()
  ;
  (btn.onClick):Add(function(...)
    -- function num : 0_3_0 , upvalues : _ENV, beginTime, endTime, freeNum, uis, id, CostType, sound, excelData, LotteryCardId, dayLottery
    local curTime = (ActorData.GetServerTime)()
    if beginTime <= curTime and curTime <= endTime then
      (MessageMgr.SendCenterTips)((PUtil.get)(223))
      UIMgr:SendWindowMessage("LotteryWindow", (WindowMsgEnum.Lottery).E_MSG_REFRESHLOTTERYLIST, {})
      do return  end
      if freeNum > 0 and (((uis.LotteryPanelGrp).GetCha_NewCardUpGrp).TimeTxt).visible == false then
        loge("免费次数")
        ;
        (LotteryService.ReqLotteryDraw)(id)
        ;
        (LotteryData.SaveCurCostMode)(CostType.Free)
        if sound ~= nil then
          (LuaSound.PlaySound)(sound, SoundBank.OTHER)
        end
      else
        local cost = split(excelData.first_cost, ":")
        local costItemNum = (ActorData.GetGoodsCount)(cost[2], tonumber(cost[1])) or 0
        local costNeedNum = tonumber(cost[3])
        if costNeedNum ~= nil and costNeedNum <= costItemNum then
          loge("钻石招募券")
          if id == LotteryCardId.day then
            if dayLottery then
              (LotteryData.SaveCurCostMode)(CostType.Day)
            else
              ;
              (MessageMgr.SendCenterTips)((PUtil.get)(174))
              return 
            end
          else
            ;
            (LotteryData.SaveCurCostMode)(CostType.Ticket)
          end
          ;
          (LotteryService.ReqLotteryDraw)(id)
          if sound ~= nil then
            (LuaSound.PlaySound)(sound, SoundBank.OTHER)
          end
        else
          loge("消耗绑钻或者非绑钻   " .. tostring(id))
          if id == LotteryCardId.day then
            print("++++++++++++++++++++++dayLottery", dayLottery)
            if dayLottery then
              (LotteryData.SaveCurCostMode)(CostType.Day)
              local bind = (LotteryMgr.CheckAssetIsEnough)(excelData.cost)
              local bindId = tonumber((split(excelData.cost, ":"))[2])
              if bind then
                (MessageMgr.OpenCostResConfirmWindow)(224, excelData.cost, function(...)
      -- function num : 0_3_0_0 , upvalues : _ENV, id, sound
      (LotteryService.ReqLotteryDraw)(id)
      if sound ~= nil then
        (LuaSound.PlaySound)(sound, SoundBank.OTHER)
      end
    end
)
              else
                ;
                (MessageMgr.OpenAssetNotEnoughtWindow)(bindId)
              end
            else
              do
                ;
                (MessageMgr.SendCenterTips)((PUtil.get)(174))
                do return  end
                ;
                (LotteryData.SaveCurCostMode)(CostType.Diamond)
                ;
                (MessageMgr.OpenCostResConfirmWindow)(224, excelData.cost, function(...)
      -- function num : 0_3_0_1 , upvalues : _ENV, id, sound
      (LotteryService.ReqLotteryDraw)(id)
      if sound ~= nil then
        (LuaSound.PlaySound)(sound, SoundBank.OTHER)
      end
    end
)
              end
            end
          end
        end
      end
    end
  end
)
  -- DECOMPILER ERROR: 15 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC27: Confused about usage of register: R8 in 'UnsetPending'

LotteryWindow_Activity2.ReceiveDrawedData = function(para, ...)
  -- function num : 0_4 , upvalues : _ENV, lotteryType
  (ActorData.SubLotteryActivityNum)((para.data).lotteryId, 1)
  ;
  (LotteryMgr.PlayLotteryEffects)(function(...)
    -- function num : 0_4_0 , upvalues : _ENV, lotteryType
    (LotteryService.ReqLotteryInit)(lotteryType)
    UIMgr:SendWindowMessage("LotteryWindow", (WindowMsgEnum.Lottery).E_MSG_LOTTERY_DRAW_ANIMATION_END, {})
  end
, para)
end

-- DECOMPILER ERROR at PC30: Confused about usage of register: R8 in 'UnsetPending'

LotteryWindow_Activity2.ShowResult = function(para, ...)
  -- function num : 0_5 , upvalues : _ENV
  OpenWindow("LotteryRewardWindow", UILayer.HUD, para, 0)
  ;
  (LotteryMgr.HideAllBackGroundEffects)()
end

-- DECOMPILER ERROR at PC33: Confused about usage of register: R8 in 'UnsetPending'

LotteryWindow_Activity2.OnClose = function(...)
  -- function num : 0_6 , upvalues : uis, _ENV, fx_main
  if uis then
    (Util.RecycleUIModel)((((uis.LotteryPanelGrp).GetCha_NewCardUpGrp).CharacterNewCardUpComp).CardLoader)
  end
  uis = nil
  fx_main = nil
end


