-- params : ...
-- function num : 0 , upvalues : _ENV
require("Guild_BuyNumberWindowByName")
local GuildGuessOneKeyWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local maxRound = 0
GuildGuessOneKeyWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, GuildGuessOneKeyWindow, maxRound
  bridgeObj:SetView((WinResConfig.GuildGuessOneKeyWindow).package, (WinResConfig.GuildGuessOneKeyWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetGuild_BuyNumberWindowUis(contentPane)
  uis = uis.BuyNumberGrp
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.titilenameTxt).text = (PUtil.get)(20000288)
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.ChangeNumberTxt).text = 1
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.Word_01_Txt).text = (PUtil.get)(20000289)
  ;
  (GuildGuessOneKeyWindow.InitBtn)()
  maxRound = (GuildMgr.GetGuessMaxTime)()
  ;
  (GuildGuessOneKeyWindow.SetConsume)()
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.DiamondWordTxt).text = (PUtil.get)(20000394)
end

GuildGuessOneKeyWindow.InitBtn = function(...)
  -- function num : 0_1 , upvalues : uis, _ENV, GuildGuessOneKeyWindow
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  (uis.BuyBtn).text = (PUtil.get)(20000173)
  ;
  ((uis.ReduceBtn).onClick):Set(function(...)
    -- function num : 0_1_0 , upvalues : GuildGuessOneKeyWindow
    (GuildGuessOneKeyWindow.AddNum)(-1)
  end
)
  ;
  ((uis.AddBtn).onClick):Set(function(...)
    -- function num : 0_1_1 , upvalues : GuildGuessOneKeyWindow
    (GuildGuessOneKeyWindow.AddNum)(1)
  end
)
  ;
  ((uis.MaxBtn).onClick):Set(function(...)
    -- function num : 0_1_2 , upvalues : GuildGuessOneKeyWindow
    local maxTimes = (GuildGuessOneKeyWindow.GetMaxTimes)()
    ;
    (GuildGuessOneKeyWindow.AddNum)(maxTimes, true)
  end
)
  ;
  ((uis.BuyBtn).onClick):Set(function(...)
    -- function num : 0_1_3 , upvalues : _ENV, uis, GuildGuessOneKeyWindow
    local formerNum = tonumber((uis.ChangeNumberTxt).text)
    local cost = (GuildGuessOneKeyWindow.GetNeedConsume)(formerNum)
    ;
    (MessageMgr.OpenCostResConfirmWindow)(60000407, cost, function(...)
      -- function num : 0_1_3_0 , upvalues : _ENV, formerNum
      (GuildService.ReqGuildGamePlay)(GuessCupOperateType.All, nil, formerNum)
    end
, nil, nil, true)
  end
)
  ;
  ((uis.CloseBtn).onClick):Set(function(...)
    -- function num : 0_1_4 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.GuildGuessOneKeyWindow).name)
  end
)
end

GuildGuessOneKeyWindow.AddNum = function(num, setTime, ...)
  -- function num : 0_2 , upvalues : _ENV, uis, GuildGuessOneKeyWindow
  local afterNum = 0
  if setTime then
    afterNum = num
  else
    local formerNum = tonumber((uis.ChangeNumberTxt).text)
    afterNum = formerNum + num
  end
  do
    local afterNum = (Umath.Clamp)(afterNum, 1, Const.SCATTER_GUESS_MAX_CUP)
    local const = (GuildGuessOneKeyWindow.GetNeedConsume)(afterNum)
    local spConst = split(const, ":")
    do
      if not (Util.CheckAssetEnough)(tonumber(spConst[2]), tonumber(spConst[3])) then
        local AssetData = ((TableData.gTable).BaseAssetData)[tonumber(spConst[2])]
        ;
        (MessageMgr.SendCenterTips)((PUtil.get)(20000125, AssetData.name))
        return 
      end
      -- DECOMPILER ERROR at PC56: Confused about usage of register: R6 in 'UnsetPending'

      ;
      (uis.ChangeNumberTxt).text = (math.ceil)(afterNum)
      ;
      (GuildGuessOneKeyWindow.SetConsume)()
    end
  end
end

GuildGuessOneKeyWindow.GetMaxTimes = function(...)
  -- function num : 0_3 , upvalues : _ENV, GuildGuessOneKeyWindow
  for i = 1, Const.SCATTER_GUESS_MAX_CUP do
    local times = Const.SCATTER_GUESS_MAX_CUP - i + 1
    local consume = (GuildGuessOneKeyWindow.GetNeedConsume)(times)
    local spConsume = split(consume, ":")
    if (Util.CheckAssetEnough)(tonumber(spConsume[2]), tonumber(spConsume[3])) then
      return times
    end
  end
end

GuildGuessOneKeyWindow.GetNeedConsume = function(times, ...)
  -- function num : 0_4 , upvalues : _ENV, maxRound
  local total = 0
  local const = nil
  for i = 1, times do
    const = (Util.GetBuyTimesConsume)(BuyTimesType.GuildGuess, i)
    total = tonumber((split(const, ":"))[3]) + total
  end
  total = (total) * (maxRound - (GuildMgr.GetGuessRoundTimes)() + 1)
  local con = split(const, ":")
  const = con[1] .. ":" .. con[2] .. ":" .. total
  return const
end

GuildGuessOneKeyWindow.SetConsume = function(...)
  -- function num : 0_5 , upvalues : _ENV, uis, GuildGuessOneKeyWindow
  local Num = tonumber((uis.ChangeNumberTxt).text)
  local const = (GuildGuessOneKeyWindow.GetNeedConsume)(Num)
  ;
  (Util.SetConsumption)(const, uis.DiamondLoader, uis.DiamondTxt)
end

GuildGuessOneKeyWindow.OnShown = function(...)
  -- function num : 0_6
end

GuildGuessOneKeyWindow.OnHide = function(...)
  -- function num : 0_7
end

GuildGuessOneKeyWindow.OnClose = function(...)
  -- function num : 0_8 , upvalues : uis, contentPane, argTable
  uis = nil
  contentPane = nil
  argTable = {}
end

GuildGuessOneKeyWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_9
end

return GuildGuessOneKeyWindow

