-- params : ...
-- function num : 0 , upvalues : _ENV
LotteryWindow_Coupon = {}
local LotteryCouponId = {single = 24000031, ten = 24000032}
local curAnimatior = nil
-- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

LotteryWindow_Coupon.OnInit = function(...)
  -- function num : 0_0
end

local grp, countTimer = nil, nil
local CostType = {Free = 1, Ticket = 2, Diamond = 3, Day = 4}
local lotteryShowId = 3
local excelShowData = nil
-- DECOMPILER ERROR at PC19: Confused about usage of register: R7 in 'UnsetPending'

LotteryWindow_Coupon.RefreshWindow = function(uis, ...)
  -- function num : 0_1 , upvalues : grp, _ENV
  if uis then
    grp = uis
  end
  ;
  (LotteryWindow_Coupon.InitAnimation)()
  ;
  (LotteryWindow_Activity.HideOrShowFxMain)(false)
  ;
  (LotteryWindow_Activity2.HideOrShowFxMain)(false)
end

-- DECOMPILER ERROR at PC22: Confused about usage of register: R7 in 'UnsetPending'

LotteryWindow_Coupon.InitAnimation = function(...)
  -- function num : 0_2 , upvalues : excelShowData, _ENV, lotteryShowId
  excelShowData = ((TableData.gTable).BaseLotteryShowData)[lotteryShowId]
end

-- DECOMPILER ERROR at PC25: Confused about usage of register: R7 in 'UnsetPending'

LotteryWindow_Coupon.ReceiveInitData = function(...)
  -- function num : 0_3 , upvalues : _ENV, countTimer, grp, LotteryCouponId
  local lData = ((LotteryData.GetLotteryData)()).data
  print("单抽剩余免费次数", lData.onceFreeNum, "单抽剩余CD时间", lData.onceCdTime, "每一日抽", lData.dayLottery)
  if lData.onceCdTime > 0 then
    if countTimer ~= nil then
      countTimer:Stop()
    end
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (((grp.LotteryPanelGrp).GetCha_CouponGrp).TimeTxt).visible = true
    ;
    ((((grp.LotteryPanelGrp).GetCha_CouponGrp).OneTimeBtn):GetChild("FreeNumberTxt")).visible = false
    countTimer = (LuaTime.CountDown)((lData.onceCdTime + 1000) * 0.001, ((grp.LotteryPanelGrp).GetCha_CouponGrp).TimeTxt, function(...)
    -- function num : 0_3_0 , upvalues : grp, _ENV, LotteryCouponId, lData
    -- DECOMPILER ERROR at PC3: Confused about usage of register: R0 in 'UnsetPending'

    (((grp.LotteryPanelGrp).GetCha_CouponGrp).TimeTxt).visible = false
    ;
    ((((grp.LotteryPanelGrp).GetCha_CouponGrp).OneTimeBtn):GetChild("FreeNumberTxt")).visible = true
    ;
    ((((grp.LotteryPanelGrp).GetCha_CouponGrp).OneTimeBtn):GetChild("Number_01_Loader")).visible = false
    local excelData = ((TableData.gTable).BaseLotteryData)[LotteryCouponId.single]
    ;
    ((((grp.LotteryPanelGrp).GetCha_CouponGrp).OneTimeBtn):GetChild("Number_01_Txt")).text = (PUtil.get)(90)
    ;
    ((((grp.LotteryPanelGrp).GetCha_CouponGrp).OneTimeBtn):GetChild("FreeNumberTxt")).text = (PUtil.get)(89, lData.onceFreeNum, excelData.day_free_num)
  end
)
  else
    -- DECOMPILER ERROR at PC47: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (((grp.LotteryPanelGrp).GetCha_CouponGrp).TimeTxt).visible = false
  end
  -- DECOMPILER ERROR at PC56: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((grp.LotteryPanelGrp).GetCha_CouponGrp).BackImage).visible = lData.onceFreeNum > 0
  ;
  (LotteryWindow_Coupon.SetButtonInfo)(((grp.LotteryPanelGrp).GetCha_CouponGrp).OneTimeBtn, LotteryCouponId.single, lData.onceFreeNum)
  ;
  (LotteryWindow_Coupon.SetButtonInfo)(((grp.LotteryPanelGrp).GetCha_CouponGrp).TenTimeBtn, LotteryCouponId.ten, lData.moreFreeNum)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC28: Confused about usage of register: R7 in 'UnsetPending'

LotteryWindow_Coupon.SetButtonInfo = function(btn, id, freeNum, sound, ...)
  -- function num : 0_4 , upvalues : _ENV, grp, CostType
  local excelData = ((TableData.gTable).BaseLotteryData)[id]
  local costStr, haveCount, needCount = nil, nil, nil
  local isKaQuan = excelData.type == 3
  if freeNum > 0 and (((grp.LotteryPanelGrp).GetCha_CouponGrp).TimeTxt).visible == false then
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
    if isKaQuan then
      print("---如果直接是卡券抽奖")
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
  ;
  (btn.onClick):ClearCallFunc()
  ;
  (btn.onClick):Add(function(...)
    -- function num : 0_4_0 , upvalues : freeNum, grp, _ENV, id, CostType, sound, excelData, costStr
    if freeNum > 0 and (((grp.LotteryPanelGrp).GetCha_CouponGrp).TimeTxt).visible == false then
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
      if costItemNum > 0 and costItemNum ~= nil then
        loge("钻石招募券")
        ;
        (LotteryService.ReqLotteryDraw)(id)
        ;
        (LotteryData.SaveCurCostMode)(CostType.Ticket)
        if sound ~= nil then
          (LuaSound.PlaySound)(sound, SoundBank.OTHER)
        end
      else
        loge("消耗绑钻或者非绑钻")
        local kaQuanNum = (ActorData.GetPropsByID)(costStr[2])
        local needNum = tonumber(costStr[3])
        if needNum <= kaQuanNum then
          (MessageMgr.OpenCostResConfirmWindow)(224, excelData.cost, function(...)
      -- function num : 0_4_0_0 , upvalues : _ENV, id, CostType, sound
      (LotteryService.ReqLotteryDraw)(id)
      ;
      (LotteryData.SaveCurCostMode)(CostType.Ticket)
      if sound ~= nil then
        (LuaSound.PlaySound)(sound, SoundBank.OTHER)
      end
    end
)
        else
          ;
          (MessageMgr.SendCenterTips)((PUtil.get)(177, (((TableData.gTable).BasePropData)[tonumber(costStr[2])]).name))
        end
      end
    end
  end
)
  -- DECOMPILER ERROR: 10 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC31: Confused about usage of register: R7 in 'UnsetPending'

LotteryWindow_Coupon.ReceiveDrawedData = function(para, ...)
  -- function num : 0_5 , upvalues : _ENV, CostType, grp
  local costType = (LotteryData.GetCurCostMode)()
  if costType == CostType.Free then
    (LotteryData.SubFreeNumber)((para.data).lotteryId, (para.data).freeNum)
    print("================设置倒计时", (para.data).cdTime)
    ;
    (LotteryData.SetCDTime)((para.data).lotteryId, (para.data).cdTime)
    print("===Coupon==消除红点", (para.data).freeNum)
    if (para.data).freeNum <= 0 or (para.data).cdTime > 0 then
      (RedDotMgr.EliminateRedDot)((WinResConfig.LotteryWindow).name, RedDotComID.Lottery_Card)
    end
  else
    if costType == CostType.Day then
      (LotteryData.SetDayState)(false)
    end
  end
  PlayUITrans((((grp.LotteryPanelGrp).GetCha_CouponGrp).CharacterCouponComp).root, "press")
  PlayUITrans(((grp.LotteryPanelGrp).GetCha_CouponGrp).root, "out")
  PlayUITrans((grp.AssetStripGrp).root, "close")
  PlayUITrans((grp.LotteryPanelGrp).root, "out")
  ;
  (LotteryMgr.PlayLotteryEffects)(function(...)
    -- function num : 0_5_0 , upvalues : _ENV
    (LotteryWindow_Coupon.RefreshWindow)()
    ;
    (LotteryWindow_Coupon.ReceiveInitData)()
    UIMgr:SendWindowMessage("LotteryWindow", (WindowMsgEnum.Lottery).E_MSG_LOTTERY_DRAW_ANIMATION_END, {})
  end
, para)
end

-- DECOMPILER ERROR at PC34: Confused about usage of register: R7 in 'UnsetPending'

LotteryWindow_Coupon.ShowResult = function(para, ...)
  -- function num : 0_6 , upvalues : _ENV, grp
  OpenWindow("LotteryRewardWindow", UILayer.HUD, para, 1)
  PlayUITrans((grp.LotteryPanelGrp).root, "in")
  PlayUITrans((grp.AssetStripGrp).root, "in")
  PlayUITrans((((grp.LotteryPanelGrp).GetCha_CouponGrp).CharacterCouponComp).root, "press", nil, nil, nil, nil, nil, nil, true)
  PlayUITrans(((grp.LotteryPanelGrp).GetCha_CouponGrp).root, "in")
  ;
  (LotteryMgr.HideAllBackGroundEffects)()
end

-- DECOMPILER ERROR at PC37: Confused about usage of register: R7 in 'UnsetPending'

LotteryWindow_Coupon.OnClose = function(...)
  -- function num : 0_7 , upvalues : countTimer
  if countTimer ~= nil then
    countTimer:Stop()
  end
end


