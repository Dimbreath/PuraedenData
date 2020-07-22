-- params : ...
-- function num : 0 , upvalues : _ENV
LotteryWindow_Fresh = {}
local LotteryCardId = {single = 24000042, ten = 24000041}
local curAnimatior = nil
-- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

LotteryWindow_Fresh.OnInit = function(...)
  -- function num : 0_0
end

local grp, countTimer = nil, nil
local CostType = {Free = 1, Ticket = 2, Diamond = 3}
local hasSingle = false
local lotteryShowId = 4
local excelShowData = nil
-- DECOMPILER ERROR at PC19: Confused about usage of register: R8 in 'UnsetPending'

LotteryWindow_Fresh.RefreshWindow = function(uis, ...)
  -- function num : 0_1 , upvalues : grp, _ENV
  if uis then
    grp = uis
    ;
    (LotteryWindow_Fresh.InitAnimation)(grp)
  else
    ;
    (LotteryWindow_Fresh.ReceiveInitData)()
  end
  ;
  (LotteryWindow_Activity.HideOrShowFxMain)(false)
  ;
  (LotteryWindow_Activity2.HideOrShowFxMain)(false)
end

-- DECOMPILER ERROR at PC22: Confused about usage of register: R8 in 'UnsetPending'

LotteryWindow_Fresh.InitAnimation = function(_grp, isInit, ...)
  -- function num : 0_2 , upvalues : hasSingle, _ENV, excelShowData, lotteryShowId
  hasSingle = (ActorData.GetNoviceLotteryOnceNumInit)() ~= 0
  local selectedIndex = 0
  if hasSingle then
    selectedIndex = 1
  else
    selectedIndex = 0
  end
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (((_grp.LotteryPanelGrp).GetCha_NewCardGrp).c1Ctr).selectedIndex = selectedIndex
  if isInit then
    PlayUITrans((_grp.AssetStripGrp).root, "in")
    PlayUITrans((_grp.LotteryPanelGrp).root, "in")
    if hasSingle then
      PlayUITrans(((_grp.LotteryPanelGrp).GetCha_NewCardGrp).root, "in")
    else
      PlayUITrans(((_grp.LotteryPanelGrp).GetCha_NewCardGrp).root, "in1")
    end
    return 
  end
  excelShowData = ((TableData.gTable).BaseLotteryShowData)[lotteryShowId]
  ;
  (LotteryMgr.SetCharacterCompBtnClick)((((_grp.LotteryPanelGrp).GetCha_NewCardGrp).CharacterFreshComp).root, excelShowData.card_ids)
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC25: Confused about usage of register: R8 in 'UnsetPending'

LotteryWindow_Fresh.ReceiveInitData = function(...)
  -- function num : 0_3 , upvalues : _ENV, grp, hasSingle, LotteryCardId
  local lData = ((LotteryData.GetLotteryData)()).data
  print("单抽剩余免费次数", lData.onceFreeNum, "单抽剩余CD时间", lData.onceCdTime, "每一日抽", lData.dayLottery, "单抽剩余总次数", lData.onceSurplusNum, "十连抽剩余总次数", lData.moreSurplusNum)
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (((grp.LotteryPanelGrp).GetCha_NewCardGrp).TimeTxt).visible = false
  hasSingle = (ActorData.GetNoviceLotteryOnceNumInit)() ~= 0
  local selectedIndex = 0
  if hasSingle then
    selectedIndex = 1
  else
    selectedIndex = 0
  end
  -- DECOMPILER ERROR at PC38: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((grp.LotteryPanelGrp).GetCha_NewCardGrp).c1Ctr).selectedIndex = selectedIndex
  if hasSingle then
    (LotteryWindow_Fresh.SetButtonInfo)(((grp.LotteryPanelGrp).GetCha_NewCardGrp).OneTimeBtn, LotteryCardId.single, lData.onceFreeNum)
    ;
    ((((grp.LotteryPanelGrp).GetCha_NewCardGrp).OneTimeBtn):GetChild("FreeNumberTxt")).visible = false
  end
  ;
  (LotteryWindow_Fresh.SetButtonInfo)(((grp.LotteryPanelGrp).GetCha_NewCardGrp).TenTimeBtn, LotteryCardId.ten, lData.moreFreeNum)
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC28: Confused about usage of register: R8 in 'UnsetPending'

LotteryWindow_Fresh.SetButtonInfo = function(btn, id, freeNum, sound, ...)
  -- function num : 0_4 , upvalues : _ENV, CostType
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
    -- function num : 0_4_0 , upvalues : freeNum, _ENV, id, CostType, sound, excelData
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
        local bind, bindNum = (LotteryMgr.CheckAssetIsEnough)(excelData.cost)
        local notBind = (LotteryMgr.CheckAssetIsEnough)(excelData.cost_final, bindNum)
        local notbindId = tonumber((split(excelData.cost_final, ":"))[2])
        if bind then
          (LotteryService.ReqLotteryDraw)(id)
          if sound ~= nil then
            (LuaSound.PlaySound)(sound, SoundBank.OTHER)
          end
        else
          if notBind then
            (LotteryService.ReqLotteryDraw)(id)
            if sound ~= nil then
              (LuaSound.PlaySound)(sound, SoundBank.OTHER)
            end
          else
            ;
            (MessageMgr.OpenConfirmWindow)((PUtil.get)(212), function(...)
      -- function num : 0_4_0_0 , upvalues : _ENV
      ld("Mail", function(...)
        -- function num : 0_4_0_0_0 , upvalues : _ENV
        OpenWindow((WinResConfig.MailWindow).name, UILayer.HUD)
      end
)
    end
)
          end
        end
      end
    end
  end
)
  -- DECOMPILER ERROR: 9 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC31: Confused about usage of register: R8 in 'UnsetPending'

LotteryWindow_Fresh.ReceiveDrawedData = function(para, ...)
  -- function num : 0_5 , upvalues : _ENV, grp, hasSingle, CostType, LotteryCardId
  PlayUITrans((((grp.LotteryPanelGrp).GetCha_NewCardGrp).CharacterFreshComp).root, "press")
  if hasSingle then
    PlayUITrans(((grp.LotteryPanelGrp).GetCha_NewCardGrp).root, "out")
  else
    PlayUITrans(((grp.LotteryPanelGrp).GetCha_NewCardGrp).root, "out1")
  end
  PlayUITrans((grp.AssetStripGrp).root, "close")
  PlayUITrans((grp.LotteryPanelGrp).root, "out")
  local costType = (LotteryData.GetCurCostMode)()
  if costType == CostType.Free then
    (LotteryData.SubFreeNumber)((para.data).lotteryId, (para.data).freeNum)
    ;
    (LotteryData.SetCDTime)((para.data).lotteryId, (para.data).cdTime)
  end
  if ((para.data).freeNum > 0 and (para.data).cdTime <= 0) or (para.data).lotteryId == LotteryCardId.single then
    (LotteryData.SubFreshSingleNum)(1)
    ;
    (LotteryData.SetIsFreshLine)(true)
  else
    if (para.data).lotteryId == LotteryCardId.ten then
      (LotteryData.SubFreshTenNum)(1)
    end
  end
  ;
  (ActorData.SetNoviceLottery)((LotteryData.GetFreshSingleNum)(), (LotteryData.GetFreshTenNum)())
  ;
  (LotteryMgr.PlayLotteryEffects)(function(...)
    -- function num : 0_5_0 , upvalues : _ENV
    (LotteryWindow_Fresh.RefreshWindow)()
    UIMgr:SendWindowMessage("LotteryWindow", (WindowMsgEnum.Lottery).E_MSG_LOTTERY_DRAW_ANIMATION_END, {})
  end
, para)
end

-- DECOMPILER ERROR at PC34: Confused about usage of register: R8 in 'UnsetPending'

LotteryWindow_Fresh.ShowResult = function(para, ...)
  -- function num : 0_6 , upvalues : _ENV, hasSingle, grp
  OpenWindow("LotteryRewardWindow", UILayer.HUD, para, 3)
  hasSingle = (ActorData.GetNoviceLotteryOnceNumInit)() ~= 0
  PlayUITrans((grp.AssetStripGrp).root, "in")
  PlayUITrans((((grp.LotteryPanelGrp).GetCha_NewCardGrp).CharacterFreshComp).root, "press", nil, nil, nil, nil, nil, nil, true)
  if hasSingle then
    PlayUITrans(((grp.LotteryPanelGrp).GetCha_NewCardGrp).root, "in")
  else
    PlayUITrans(((grp.LotteryPanelGrp).GetCha_NewCardGrp).root, "in1")
  end
  PlayUITrans((grp.LotteryPanelGrp).root, "in")
  ;
  (LotteryMgr.HideAllBackGroundEffects)()
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC37: Confused about usage of register: R8 in 'UnsetPending'

LotteryWindow_Fresh.OnClose = function(...)
  -- function num : 0_7 , upvalues : curAnimatior
  curAnimatior = nil
end


