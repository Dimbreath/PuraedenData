-- params : ...
-- function num : 0 , upvalues : _ENV
LotteryService = {}
-- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

LotteryService.Init = function(...)
  -- function num : 0_0 , upvalues : _ENV
  (Net.AddListener)((Proto.MsgName).ResLotteryInit, LotteryService.OnResLotteryInit)
  ;
  (Net.AddListener)((Proto.MsgName).ResLotteryDraw, LotteryService.OnResLotteryDraw)
end

-- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

LotteryService.ReqLotteryInit = function(lType, ...)
  -- function num : 0_1 , upvalues : _ENV
  print("抽奖初始化    lType", lType)
  local send = {type = lType}
  ;
  (Net.Send)((Proto.MsgName).ReqLotteryInit, send, (Proto.MsgName).ResLotteryInit)
end

-- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

LotteryService.OnResLotteryInit = function(msg, ...)
  -- function num : 0_2 , upvalues : _ENV
  print("抽奖初始化返回  onceFreeNum", msg.onceFreeNum, "onceCdTime", msg.onceCdTime, "moreFreeNum", msg.moreFreeNum, "moreCdTime", msg.moreCdTime, "onceSurplusNum", msg.onceSurplusNum, "moreSurplusNum", msg.moreSurplusNum)
  UIMgr:SendWindowMessage("LotteryWindow", (WindowMsgEnum.Lottery).E_MSG_LOTTERY_INIT, {data = msg})
end

-- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

LotteryService.ReqLotteryDraw = function(id, ...)
  -- function num : 0_3 , upvalues : _ENV
  print("抽奖    id", id)
  local send = {lotteryId = id}
  ;
  (Net.Send)((Proto.MsgName).ReqLotteryDraw, send, (Proto.MsgName).ResLotteryDraw)
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

LotteryService.OnResLotteryDraw = function(msg, ...)
  -- function num : 0_4 , upvalues : _ENV
  print("抽奖返回 lotteryId", msg.lotteryId, #msg.goods)
  local LotteryData = ((TableData.gTable).BaseLotteryData)[msg.lotteryId]
  if LotteryData.type == 5 then
    UIMgr:SendWindowMessage("LotteryWindow", (WindowMsgEnum.Lottery).E_MSG_LOTTERY_DRAW, {data = msg})
    UIMgr:SendWindowMessage("LotteryRewardWindow", (WindowMsgEnum.Lottery).E_MSG_LOTTERY_DRAW, {data = msg})
    ;
    (HandBookData.CheckFetterData)()
    if UIMgr:IsWindowOpen("HomeWindow") and (Application.platform == RuntimePlatform.WindowsEditor or Application.platform == RuntimePlatform.OSXEditor) then
      local str = ""
      local count, item = nil, nil
      if msg.goods ~= nil then
        count = #msg.goods
        local eachGoods = nil
        for i = 1, count do
          eachGoods = (msg.goods)[i]
          if NoShowGetGoods[eachGoods.id] == nil and eachGoods.type ~= (ProtoEnum.E_GOODS_TYPE).OTHER then
            item = {}
            item.Type = eachGoods.type
            item.id = eachGoods.id
            item.Num = eachGoods.value
            item.attr = eachGoods.attr
            if item.Num > 1 then
              str = str .. item.id .. "x" .. item.Num .. "    "
            else
              str = str .. item.id .. "    "
            end
          end
        end
      end
      do
        if msg.showProp then
          count = #msg.props
          for i = 1, count do
            local eachGoods = (msg.props)[i]
            if NoShowGetGoods[eachGoods.id] == nil and eachGoods.count > 0 then
              item = {}
              item.Type = (ProtoEnum.E_GOODS_TYPE).PROP
              item.id = eachGoods.id
              item.Num = eachGoods.count
              if item.Num > 1 then
                str = str .. item.id .. "x" .. item.Num .. "    "
              else
                str = str .. item.id .. "    "
              end
            end
          end
        end
        do
          if msg.equips ~= nil then
            count = #msg.equips
            for i = 1, count do
              local eachGoods = (msg.equips)[i]
              if NoShowGetGoods[eachGoods.id] == nil then
                item = {}
                item.Type = (ProtoEnum.E_GOODS_TYPE).EQUIP
                item.id = eachGoods.id
                item.Num = 1
                if item.Num > 1 then
                  str = str .. item.id .. "x" .. item.Num .. "    "
                else
                  str = str .. item.id .. "    "
                end
              end
            end
          end
          do
            ;
            ((CS.FileManager).WriteFile)("LotteryTestResult.txt", str .. "\n")
          end
        end
      end
    end
  end
end

;
(LotteryService.Init)()

