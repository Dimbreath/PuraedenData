-- params : ...
-- function num : 0 , upvalues : _ENV
LotteryWindow_Card = {}
local LotteryCardId = {single = 24000011, ten = 24000012, day = 24000013}
local curAnimatior = nil
-- DECOMPILER ERROR at PC9: Confused about usage of register: R2 in 'UnsetPending'

LotteryWindow_Card.OnInit = function(...)
  -- function num : 0_0
end

local grp, countTimer = nil, nil
local CostType = {Free = 1, Ticket = 2, Diamond = 3, Day = 4}
local lotteryShowId = 1
local excelShowData = nil
-- DECOMPILER ERROR at PC20: Confused about usage of register: R7 in 'UnsetPending'

LotteryWindow_Card.RefreshWindow = function(uis, ...)
  -- function num : 0_1 , upvalues : grp, _ENV
  if uis then
    grp = uis
    ;
    (LotteryWindow_Card.InitAnimation)(grp)
  else
    ;
    (LotteryWindow_Card.ReceiveInitData)()
  end
  ;
  (LotteryWindow_Activity.HideOrShowFxMain)(false)
  ;
  (LotteryWindow_Activity2.HideOrShowFxMain)(false)
end

-- DECOMPILER ERROR at PC23: Confused about usage of register: R7 in 'UnsetPending'

LotteryWindow_Card.InitAnimation = function(_grp, isInit, ...)
  -- function num : 0_2 , upvalues : _ENV, excelShowData, lotteryShowId, grp
  if isInit then
    PlayUITrans(((_grp.LotteryPanelGrp).GetCha_CardGrp).root, "in")
    PlayUITrans((_grp.AssetStripGrp).root, "in")
    PlayUITrans((_grp.LotteryPanelGrp).root, "in")
    return 
  end
  excelShowData = ((TableData.gTable).BaseLotteryShowData)[lotteryShowId]
  ;
  (LotteryMgr.SetCharacterCompBtnClick)((((grp.LotteryPanelGrp).GetCha_CardGrp).CharacterCardComp).root, excelShowData.card_ids)
end

-- DECOMPILER ERROR at PC26: Confused about usage of register: R7 in 'UnsetPending'

LotteryWindow_Card.ReceiveInitData = function(...)
  -- function num : 0_3 , upvalues : _ENV, countTimer, grp, LotteryCardId
  local lData = ((LotteryData.GetLotteryData)()).data
  print("单抽剩余免费次数", lData.onceFreeNum, "单抽剩余CD时间", lData.onceCdTime, "每一日抽", lData.dayLottery)
  if lData.onceCdTime > 0 then
    if countTimer ~= nil then
      countTimer:Stop()
    end
    -- DECOMPILER ERROR at PC24: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (((grp.LotteryPanelGrp).GetCha_CardGrp).TimeTxt).visible = true
    ;
    ((((grp.LotteryPanelGrp).GetCha_CardGrp).OneTimeBtn):GetChild("FreeNumberTxt")).visible = false
    countTimer = (LuaTime.CountDown)(lData.onceCdTime * 0.001, ((grp.LotteryPanelGrp).GetCha_CardGrp).TimeTxt, function(...)
    -- function num : 0_3_0 , upvalues : grp, _ENV, LotteryCardId, lData
    -- DECOMPILER ERROR at PC3: Confused about usage of register: R0 in 'UnsetPending'

    (((grp.LotteryPanelGrp).GetCha_CardGrp).TimeTxt).visible = false
    ;
    ((((grp.LotteryPanelGrp).GetCha_CardGrp).OneTimeBtn):GetChild("FreeNumberTxt")).visible = true
    ;
    ((((grp.LotteryPanelGrp).GetCha_CardGrp).OneTimeBtn):GetChild("Number_01_Loader")).visible = false
    local excelData = ((TableData.gTable).BaseLotteryData)[LotteryCardId.single]
    ;
    ((((grp.LotteryPanelGrp).GetCha_CardGrp).OneTimeBtn):GetChild("Number_01_Txt")).text = (PUtil.get)(90)
    ;
    ((((grp.LotteryPanelGrp).GetCha_CardGrp).OneTimeBtn):GetChild("FreeNumberTxt")).text = (PUtil.get)(89, lData.onceFreeNum, excelData.day_free_num)
  end
)
  else
    -- DECOMPILER ERROR at PC46: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (((grp.LotteryPanelGrp).GetCha_CardGrp).TimeTxt).visible = false
  end
  ;
  (LotteryWindow_Card.SetButtonInfo)(((grp.LotteryPanelGrp).GetCha_CardGrp).OneTimeBtn, LotteryCardId.single, lData.onceFreeNum, nil)
  ;
  (LotteryWindow_Card.SetButtonInfo)(((grp.LotteryPanelGrp).GetCha_CardGrp).TenTimeBtn, LotteryCardId.ten, lData.moreFreeNum, nil, nil)
  ;
  (LotteryWindow_Card.SetButtonInfo)(((grp.LotteryPanelGrp).GetCha_CardGrp).SpecialOneTimeBtn, LotteryCardId.day, 0, lData.dayLottery)
end

-- DECOMPILER ERROR at PC29: Confused about usage of register: R7 in 'UnsetPending'

LotteryWindow_Card.SetButtonInfo = function(btn, id, freeNum, dayLottery, sound, ...)
  -- function num : 0_4 , upvalues : _ENV, grp, LotteryCardId, CostType
  local excelData = ((TableData.gTable).BaseLotteryData)[id]
  local costStr, haveCount, needCount = nil, nil, nil
  local isKaQuan = excelData.type == 3
  if freeNum > 0 and (((grp.LotteryPanelGrp).GetCha_CardGrp).TimeTxt).visible == false then
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
    -- function num : 0_4_0 , upvalues : freeNum, grp, _ENV, id, CostType, sound, excelData, LotteryCardId, dayLottery
    if freeNum > 0 and (((grp.LotteryPanelGrp).GetCha_CardGrp).TimeTxt).visible == false then
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
)
  -- DECOMPILER ERROR: 15 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC32: Confused about usage of register: R7 in 'UnsetPending'

LotteryWindow_Card.ReceiveDrawedData = function(para, ...)
  -- function num : 0_5 , upvalues : _ENV, CostType, grp
  local costType = (LotteryData.GetCurCostMode)()
  if costType == CostType.Free then
    (LotteryData.SubFreeNumber)((para.data).lotteryId, (para.data).freeNum)
    ;
    (LotteryData.SetCDTime)((para.data).lotteryId, (para.data).cdTime)
    print("===Card====消除红点", (para.data).freeNum)
    if (para.data).freeNum <= 0 or (para.data).cdTime > 0 then
      (RedDotMgr.EliminateRedDot)((WinResConfig.LotteryWindow).name, RedDotComID.Lottery_Character)
    end
  else
    if costType == CostType.Day then
      (LotteryData.SetDayState)(false)
    end
  end
  PlayUITrans((((grp.LotteryPanelGrp).GetCha_CardGrp).CharacterCardComp).root, "press")
  PlayUITrans(((grp.LotteryPanelGrp).GetCha_CardGrp).root, "out")
  PlayUITrans((grp.AssetStripGrp).root, "close")
  PlayUITrans((grp.LotteryPanelGrp).root, "out")
  ;
  (LotteryMgr.PlayLotteryEffects)(function(...)
    -- function num : 0_5_0 , upvalues : _ENV
    (LotteryWindow_Card.RefreshWindow)()
    UIMgr:SendWindowMessage("LotteryWindow", (WindowMsgEnum.Lottery).E_MSG_LOTTERY_DRAW_ANIMATION_END, {})
  end
, para)
end

-- DECOMPILER ERROR at PC35: Confused about usage of register: R7 in 'UnsetPending'

LotteryWindow_Card.ShowResult = function(para, ...)
  -- function num : 0_6 , upvalues : _ENV, grp
  OpenWindow("LotteryRewardWindow", UILayer.HUD, para, 0)
  PlayUITrans((grp.AssetStripGrp).root, "in")
  PlayUITrans((((grp.LotteryPanelGrp).GetCha_CardGrp).CharacterCardComp).root, "press", nil, nil, nil, nil, nil, nil, true)
  PlayUITrans(((grp.LotteryPanelGrp).GetCha_CardGrp).root, "in")
  PlayUITrans((grp.LotteryPanelGrp).root, "in")
  ;
  (LotteryMgr.HideAllBackGroundEffects)()
end

-- DECOMPILER ERROR at PC38: Confused about usage of register: R7 in 'UnsetPending'

LotteryWindow_Card.OnClose = function(...)
  -- function num : 0_7 , upvalues : curAnimatior
  curAnimatior = nil
end


