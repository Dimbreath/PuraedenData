-- params : ...
-- function num : 0 , upvalues : _ENV
LotteryWindow_Activity4 = {}
local LotteryCardId = {single = 24000091, ten = 24000092, day = 24000093}
local CostType = {Free = 1, Ticket = 2, Diamond = 3}
local LotteryType = {Card = 1, Equip = 2, Coupon = 3, Fresh = 4, ShilianBiChu = 6, HuoDongUp = 7, HuoDongUp2 = 8, HuoDongUp3 = 9, HuoDongUp4 = 10}
local countTimer = nil
local lotteryType = LotteryType.HuoDongUp4
local fx_main, uis, beginTime, endTime = nil, nil, nil, nil
-- DECOMPILER ERROR at PC25: Confused about usage of register: R9 in 'UnsetPending'

LotteryWindow_Activity4.RefreshWindow = function(_uis, ...)
  -- function num : 0_0 , upvalues : uis, _ENV
  if uis == nil then
    uis = _uis
  end
  ;
  (LotteryWindow_Activity4.PreLoadFxMain)(uis)
end

-- DECOMPILER ERROR at PC28: Confused about usage of register: R9 in 'UnsetPending'

LotteryWindow_Activity4.HideOrShowFxMain = function(isShow, ...)
  -- function num : 0_1 , upvalues : fx_main
  if fx_main ~= nil then
    fx_main:SetActive(isShow)
  end
end

-- DECOMPILER ERROR at PC31: Confused about usage of register: R9 in 'UnsetPending'

LotteryWindow_Activity4.PreLoadFxMain = function(uis, ...)
  -- function num : 0_2 , upvalues : _ENV, lotteryType, fx_main
  local excelShowData = ((TableData.gTable).BaseLotteryShowData)[lotteryType]
  local cardNum = #split(excelShowData.card_ids, ":")
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R3 in 'UnsetPending'

  if cardNum == 1 then
    ((((uis.LotteryPanelGrp).GetCha_NewCardUpGrp).CharacterNewCardUpComp).c1Ctr).selectedIndex = 0
    local lotteryCardId = tonumber(excelShowData.card_ids)
    do
      local cardData = ((TableData.gTable).BaseCardData)[lotteryCardId]
      local fashionId = tonumber((split(cardData.fashion_ids, ":"))[3])
      local fashionData = ((TableData.gTable).BaseFashionData)[fashionId]
      if fx_main == nil then
        local holder, effect = (LuaEffect.AddUIEffect)(fashionData.show_cg, false, false, Vector3.zero, 1)
        do
          holder:SetXY((((((uis.LotteryPanelGrp).GetCha_NewCardUpGrp).CharacterNewCardUpComp).CardPicLoader).CardPicLoader).width / 2, (((((uis.LotteryPanelGrp).GetCha_NewCardUpGrp).CharacterNewCardUpComp).CardPicLoader).CardPicLoader).height / 2)
          ;
          (((((uis.LotteryPanelGrp).GetCha_NewCardUpGrp).CharacterNewCardUpComp).CardPicLoader).root):AddChild(holder)
          fx_main = effect
        end
      else
        do
          ;
          (LotteryWindow_Activity.HideOrShowFxMain)(false)
          ;
          (LotteryWindow_Activity2.HideOrShowFxMain)(false)
          ;
          (LotteryWindow_Activity3.HideOrShowFxMain)(false)
          if (LotteryMgr.GetIsLotterying)() ~= true then
            (LotteryWindow_Activity4.HideOrShowFxMain)(true)
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
          (((((uis.LotteryPanelGrp).GetCha_NewCardUpGrp).CharacterNewCardUpComp).Card_A1_Btn).onClick):Set(function(...)
    -- function num : 0_2_0 , upvalues : _ENV, lotteryCardId
    OpenWindow("CardDetailsWindow", UILayer.HUD, lotteryCardId)
  end
)
          ;
          (((((uis.LotteryPanelGrp).GetCha_NewCardUpGrp).CharacterNewCardUpComp).Card_A1_Btn):GetChild("PicLoader")).url = (Util.GetItemUrl)(cardData.lottery_pic)
        end
        do
          -- DECOMPILER ERROR at PC174: Confused about usage of register: R3 in 'UnsetPending'

          ;
          ((((uis.LotteryPanelGrp).GetCha_NewCardUpGrp).CharacterNewCardUpComp).c1Ctr).selectedIndex = 1
          for index,value in ipairs(split(excelShowData.card_ids, ":")) do
            local cardId = tonumber(value)
            local curCardData = ((TableData.gTable).BaseCardData)[cardId]
            local seeBtn = ((((uis.LotteryPanelGrp).GetCha_NewCardUpGrp).CharacterNewCardUpComp).root):GetChild("Card_B" .. tostring(index) .. "_Btn")
            ;
            (seeBtn:GetChild("PicLoader")).url = (Util.GetItemUrl)(curCardData.lottery_pic)
            ;
            (seeBtn.onClick):Set(function(...)
    -- function num : 0_2_1 , upvalues : _ENV, cardId
    OpenWindow("CardDetailsWindow", UILayer.HUD, cardId)
  end
)
          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC34: Confused about usage of register: R9 in 'UnsetPending'

LotteryWindow_Activity4.ReceiveInitData = function(...)
  -- function num : 0_3 , upvalues : _ENV, beginTime, endTime, countTimer, uis, LotteryCardId
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
    -- function num : 0_3_0 , upvalues : uis, _ENV, LotteryCardId, lData
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
  (LotteryWindow_Activity4.SetButtonInfo)(((uis.LotteryPanelGrp).GetCha_NewCardUpGrp).OneTimeBtn, LotteryCardId.single, lData.onceFreeNum)
  ;
  (LotteryWindow_Activity4.SetButtonInfo)(((uis.LotteryPanelGrp).GetCha_NewCardUpGrp).TenTimeBtn, LotteryCardId.ten, lData.moreFreeNum)
  ;
  (LotteryWindow_Activity4.SetButtonInfo)(((uis.LotteryPanelGrp).GetCha_NewCardUpGrp).SpecialOneTimeBtn, LotteryCardId.day, 0, lData.dayLottery)
end

-- DECOMPILER ERROR at PC37: Confused about usage of register: R9 in 'UnsetPending'

LotteryWindow_Activity4.SetButtonInfo = function(btn, id, freeNum, dayLottery, sound, ...)
  -- function num : 0_4 , upvalues : _ENV, uis, LotteryCardId, beginTime, endTime, CostType
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
    -- function num : 0_4_0 , upvalues : _ENV, beginTime, endTime, freeNum, uis, id, CostType, sound, excelData, LotteryCardId, dayLottery
    local curTime = (ActorData.GetServerTime)()
    print("------------curTime", curTime, beginTime, endTime)
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
      -- function num : 0_4_0_0 , upvalues : _ENV, id, sound
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
      -- function num : 0_4_0_1 , upvalues : _ENV, id, sound
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

-- DECOMPILER ERROR at PC40: Confused about usage of register: R9 in 'UnsetPending'

LotteryWindow_Activity4.ReceiveDrawedData = function(para, ...)
  -- function num : 0_5 , upvalues : _ENV, lotteryType
  (ActorData.SubLotteryActivityNum)((para.data).lotteryId, 1)
  ;
  (LotteryMgr.PlayLotteryEffects)(function(...)
    -- function num : 0_5_0 , upvalues : _ENV, lotteryType
    (LotteryService.ReqLotteryInit)(lotteryType)
    UIMgr:SendWindowMessage("LotteryWindow", (WindowMsgEnum.Lottery).E_MSG_LOTTERY_DRAW_ANIMATION_END, {})
  end
, para)
end

-- DECOMPILER ERROR at PC43: Confused about usage of register: R9 in 'UnsetPending'

LotteryWindow_Activity4.ShowResult = function(para, ...)
  -- function num : 0_6 , upvalues : _ENV
  OpenWindow("LotteryRewardWindow", UILayer.HUD, para, 0)
  ;
  (LotteryMgr.HideAllBackGroundEffects)()
end

-- DECOMPILER ERROR at PC46: Confused about usage of register: R9 in 'UnsetPending'

LotteryWindow_Activity4.OnClose = function(...)
  -- function num : 0_7 , upvalues : uis, _ENV, fx_main
  if uis then
    (Util.RecycleUIModel)((((uis.LotteryPanelGrp).GetCha_NewCardUpGrp).CharacterNewCardUpComp).CardLoader)
  end
  uis = nil
  fx_main = nil
end


