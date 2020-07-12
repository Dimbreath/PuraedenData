-- params : ...
-- function num : 0 , upvalues : _ENV
require("Guild_BuySpendWindowByName")
require("Guild_BuyResultTipsByName")
local GuildGuessResultWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local timer1, timer2 = nil, nil
local count = 0
local data = {}
GuildGuessResultWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, data, uis, GuildGuessResultWindow
  bridgeObj:SetView((WinResConfig.GuildGuessResultWindow).package, (WinResConfig.GuildGuessResultWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  data = argTable[1]
  uis = GetGuild_BuySpendWindowUis(contentPane)
  uis = uis.BuySpendGrp
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.RewardTxt).text = (PUtil.get)(20000177)
  ;
  ((GRoot.inst).onClick):Add(GuildGuessResultWindow.SetRootClick)
  -- DECOMPILER ERROR at PC37: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.SureBtn).text = (PUtil.get)(60000004)
  ;
  ((uis.SureBtn).onClick):Set(function(...)
    -- function num : 0_0_0 , upvalues : GuildGuessResultWindow, _ENV
    if (GuildGuessResultWindow.TimerIsPause)() then
      UIMgr:CloseWindow((WinResConfig.GuildGuessResultWindow).name)
    end
  end
)
  ;
  ((uis.CloseBtn).onClick):Set(function(...)
    -- function num : 0_0_1 , upvalues : GuildGuessResultWindow, _ENV
    if (GuildGuessResultWindow.TimerIsPause)() then
      UIMgr:CloseWindow((WinResConfig.GuildGuessResultWindow).name)
    end
  end
)
  -- DECOMPILER ERROR at PC50: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.BuySpendList).itemRenderer = GuildGuessResultWindow.ItemRenderer
  ;
  (GuildGuessResultWindow.RefreshList)()
  ;
  (GuildGuessResultWindow.CalculateConsumption)()
  -- DECOMPILER ERROR at PC60: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.SpendWordTxt).text = (PUtil.get)(20000395)
end

GuildGuessResultWindow.ItemRenderer = function(index, obj, ...)
  -- function num : 0_1 , upvalues : data, _ENV
  index = index + 1
  local listData = data[index]
  local model = GetGuild_BuyResultTipsUis(obj)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (model.NumberTxt).text = (PUtil.get)(20000176, index)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (model.ItemList).numItems = 0
  if (model.ItemList).numItems <= 0 then
    for _,v in ipairs(listData.reward) do
      (Util.SetFrame)(v.id, v.value, model.ItemList)
    end
  end
  do
    obj.visible = false
  end
end

GuildGuessResultWindow.CalculateConsumption = function(...)
  -- function num : 0_2 , upvalues : _ENV, data, uis
  local total = 0
  for _,v in ipairs(data) do
    local totalSub = 0
    for i = 1, #v.reward do
      local coast = (Util.GetBuyTimesConsume)(BuyTimesType.GuildGuess, i)
      totalSub = totalSub + tonumber((split(coast, ":"))[3])
    end
    total = total + (totalSub)
  end
  local consume = (Util.GetBuyTimesConsume)(BuyTimesType.GuildGuess, 1)
  local consumeID = (split(consume, ":"))[2]
  ;
  (Util.SetConsumptionByID)(tonumber(consumeID), total, uis.SpendItemLoader, uis.SpendNumberTxt)
end

GuildGuessResultWindow.TimerIsPause = function(...)
  -- function num : 0_3 , upvalues : timer1
  do return (not timer1.isRun and not timer1.isRun) end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

GuildGuessResultWindow.RefreshList = function(...)
  -- function num : 0_4 , upvalues : uis, data, count, timer1, _ENV, timer2
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R0 in 'UnsetPending'

  (uis.BuySpendList).numItems = #data
  count = 0
  timer1 = (SimpleTimer.new)(0.5, #data, function(...)
    -- function num : 0_4_0 , upvalues : _ENV, count, uis, timer1
    local scollIndex = (math.max)(0, count - 3 + 1)
    ;
    (uis.BuySpendList):ScrollToView(scollIndex, true, true)
    local obj = (uis.BuySpendList):GetChildAt(count)
    obj.visible = true
    count = count + 1
    PlayUITrans(obj, "up")
    if uis.BuySpendList == nil then
      timer1:stop()
      return 
    end
  end
)
  timer2 = (SimpleTimer.new)(0.03, #data - count, function(...)
    -- function num : 0_4_1 , upvalues : _ENV, count, uis, data, timer2
    local scollIndex = (math.max)(0, count - 3 + 1)
    ;
    (uis.BuySpendList):ScrollToView(scollIndex, true, true)
    local obj = (uis.BuySpendList):GetChildAt(count)
    obj.visible = true
    count = count + 1
    if #data == count then
      timer2:stop()
    end
  end
)
  timer1:start()
end

GuildGuessResultWindow.SetRootClick = function(...)
  -- function num : 0_5 , upvalues : timer1, timer2
  if timer1:IsRunIng() then
    timer1:stop()
    timer2:start()
  end
end

GuildGuessResultWindow.OnShown = function(...)
  -- function num : 0_6
end

GuildGuessResultWindow.OnHide = function(...)
  -- function num : 0_7
end

GuildGuessResultWindow.OnClose = function(...)
  -- function num : 0_8 , upvalues : _ENV, GuildGuessResultWindow, uis, contentPane, argTable, timer1, timer2, count
  ((GRoot.inst).onClick):Remove(GuildGuessResultWindow.SetRootClick)
  uis = nil
  contentPane = nil
  argTable = {}
  timer1 = nil
  timer2 = nil
  count = 0
end

GuildGuessResultWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_9
end

return GuildGuessResultWindow

