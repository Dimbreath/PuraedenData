-- params : ...
-- function num : 0 , upvalues : _ENV
LotteryWindow_Sure = {}
local LotteryCardId = {ten = 24000051}
local CostType = {Free = 1, Ticket = 2, Diamond = 3}
local lotteryType = 6
local moreSurplusNum, uis, beginTime, endTime = nil, nil, nil, nil
-- DECOMPILER ERROR at PC12: Confused about usage of register: R7 in 'UnsetPending'

LotteryWindow_Sure.RefreshWindow = function(_uis, ...)
  -- function num : 0_0 , upvalues : uis, _ENV
  if uis == nil then
    uis = _uis
  end
  ;
  (LotteryWindow_Sure.ReceiveInitData)()
end

-- DECOMPILER ERROR at PC15: Confused about usage of register: R7 in 'UnsetPending'

LotteryWindow_Sure.ReceiveInitData = function(...)
  -- function num : 0_1 , upvalues : _ENV, beginTime, endTime, moreSurplusNum, uis, LotteryCardId
  local lData = ((LotteryData.GetLotteryData)()).data
  print("beginTime", lData.beginTime, "endTime", lData.endTime, "onceSurplusNum", lData.onceSurplusNum, "moreSurplusNum", lData.moreSurplusNum)
  beginTime = lData.beginTime
  endTime = lData.endTime
  moreSurplusNum = lData.moreSurplusNum
  ;
  (LotteryWindow_Sure.SetButtonInfo)(((uis.LotteryPanelGrp).Sure_CardGrp).TenTimeBtn, LotteryCardId.ten, lData.moreFreeNum)
end

-- DECOMPILER ERROR at PC18: Confused about usage of register: R7 in 'UnsetPending'

LotteryWindow_Sure.SetButtonInfo = function(btn, id, freeNum, sound, ...)
  -- function num : 0_2 , upvalues : _ENV, beginTime, endTime, moreSurplusNum, CostType
  local excelData = ((TableData.gTable).BaseLotteryData)[id]
  local costStr, haveCount, needCount = nil, nil, nil
  local isKaQuan = excelData.type == 3
  if freeNum > 0 then
    (btn:GetChild("Number_01_Loader")).visible = false
    ;
    (btn:GetChild("Number_01_Txt")).text = (PUtil.get)(90)
  else
    (btn:GetChild("Number_01_Loader")).visible = true
    if isKaQuan then
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
    -- function num : 0_2_0 , upvalues : _ENV, beginTime, endTime, moreSurplusNum, freeNum, id, CostType, sound, excelData
    local curTime = (ActorData.GetServerTime)()
    if beginTime <= curTime and curTime <= endTime then
      (MessageMgr.SendCenterTips)((PUtil.get)(223))
      UIMgr:SendWindowMessage("LotteryWindow", (WindowMsgEnum.Lottery).E_MSG_REFRESHLOTTERYLIST, {})
      do return  end
      if moreSurplusNum > 0 then
        if freeNum > 0 then
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
            (LotteryData.SaveCurCostMode)(CostType.Ticket)
            ;
            (LotteryService.ReqLotteryDraw)(id)
            if sound ~= nil then
              (LuaSound.PlaySound)(sound, SoundBank.OTHER)
            end
          else
            ;
            (LotteryData.SaveCurCostMode)(CostType.Diamond)
            print("================", excelData.cost)
            ;
            (MessageMgr.OpenCostResConfirmWindow)(224, excelData.cost, function(...)
      -- function num : 0_2_0_0 , upvalues : _ENV, id, sound
      (LotteryService.ReqLotteryDraw)(id)
      if sound ~= nil then
        (LuaSound.PlaySound)(sound, SoundBank.OTHER)
      end
    end
)
          end
        end
      else
        do
          ;
          (MessageMgr.SendCenterTips)((PUtil.get)(216))
        end
      end
    end
  end
)
  -- DECOMPILER ERROR: 9 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC21: Confused about usage of register: R7 in 'UnsetPending'

LotteryWindow_Sure.ReceiveDrawedData = function(para, ...)
  -- function num : 0_3 , upvalues : _ENV, lotteryType
  (ActorData.SubLotteryActivityNum)((para.data).lotteryId, 1)
  ;
  (LotteryMgr.PlayLotteryEffects)(function(...)
    -- function num : 0_3_0 , upvalues : _ENV, lotteryType
    (LotteryService.ReqLotteryInit)(lotteryType)
    UIMgr:SendWindowMessage("LotteryWindow", (WindowMsgEnum.Lottery).E_MSG_LOTTERY_DRAW_ANIMATION_END, {})
  end
, para)
end

-- DECOMPILER ERROR at PC24: Confused about usage of register: R7 in 'UnsetPending'

LotteryWindow_Sure.ShowResult = function(para, ...)
  -- function num : 0_4 , upvalues : _ENV
  OpenWindow("LotteryRewardWindow", UILayer.HUD, para, 0)
  ;
  (LotteryMgr.HideAllBackGroundEffects)()
end

-- DECOMPILER ERROR at PC27: Confused about usage of register: R7 in 'UnsetPending'

LotteryWindow_Sure.OnClose = function(...)
  -- function num : 0_5 , upvalues : uis
  uis = nil
end


