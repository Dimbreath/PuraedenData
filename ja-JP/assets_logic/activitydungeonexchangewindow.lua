-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActivityDungeon_ExchangeByName")
local ActivityDungeonExchangeWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local laba, cardModel, cardLoader = nil, nil, nil
local lotteryIDs = {}
local aniName = {"white", "blue", "green", "purple", "gold", "ten"}
local mTime, centerPos, configData = nil, nil, nil
local RoundData = -1
local RoundDataList = {}
local isSkipAni = false
ActivityDungeonExchangeWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, centerPos, uis, ActivityDungeonExchangeWindow, cardLoader
  bridgeObj:SetView((WinResConfig.ActivityDungeonExchangeWindow).package, (WinResConfig.ActivityDungeonExchangeWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  centerPos = Vector2(DesignScreen.width / 2 + (ResolutionHandler.AdaptOffset).X, DesignScreen.height / 2 + (ResolutionHandler.AdaptOffset).Y)
  uis = GetActivityDungeon_ExchangeUis(contentPane)
  ;
  (ActivityDungeonExchangeWindow.GetConfigData)()
  cardLoader = (uis.root):GetChild("CardTxt")
  ;
  (ActivityDungeonExchangeWindow.InitAssetStrip)()
  ;
  (ActivityDungeonExchangeWindow.InitLabelList)()
  ;
  (ActivityDungeonExchangeWindow.InitBtn)()
  ;
  (ActivityDungeonExchangeWindow.InitSfx)()
  ;
  (ActivityDungeonExchangeWindow.SetResetShow)()
  ;
  (ActivityDungeonExchangeWindow.InitSkipAni)()
end

ActivityDungeonExchangeWindow.InitSkipAni = function(...)
  -- function num : 0_1 , upvalues : _ENV, uis, isSkipAni
  local isOpen = (Util.GetPlayerSetting)(PlayerPrefsKeyName.ACTIVITY_EXCHANGE_SKIP_ANI, "0") == "1"
  local skipBtn = (uis.root):GetChild("SkipBtn")
  skipBtn.selected = isOpen
  isSkipAni = isOpen
  ;
  (skipBtn.onClick):Set(function(...)
    -- function num : 0_1_0 , upvalues : isSkipAni, _ENV
    isSkipAni = not isSkipAni
    local value = "0"
    if isSkipAni then
      value = "1"
    end
    ;
    (Util.SetPlayerSetting)(PlayerPrefsKeyName.ACTIVITY_EXCHANGE_SKIP_ANI, value)
  end
)
  local txt = (uis.root):GetChild("SkipTxt")
  txt.text = (PUtil.get)(20000522)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

ActivityDungeonExchangeWindow.GetConfigData = function(...)
  -- function num : 0_2 , upvalues : _ENV, configData
  local type = (SlotsData.GetCurrentType)()
  local ShowData = (TableData.gTable).BaseSlotsData
  for _,v in pairs(ShowData) do
    if v.type == type then
      configData = v
    end
  end
end

ActivityDungeonExchangeWindow.InitSfx = function(...)
  -- function num : 0_3 , upvalues : _ENV, uis, centerPos
  (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_ACTIVITY_EXCHANGE_BG, false, uis.root, centerPos)
end

ActivityDungeonExchangeWindow.SetResetShow = function(...)
  -- function num : 0_4 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

  (uis.ResetBtn).visible = (SlotsData.CanReset)()
end

ActivityDungeonExchangeWindow.InitBtn = function(...)
  -- function num : 0_5 , upvalues : _ENV, configData, ActivityDungeonExchangeWindow, uis
  local times = split(configData.mode, ":")
  ;
  (ActivityDungeonExchangeWindow.SetBtnContent)((uis.GetReward_A).root, times[1])
  ;
  (ActivityDungeonExchangeWindow.SetBtnContent)((uis.GetReward_B).root, times[2], tonumber(times[1]))
  ;
  (ActivityDungeonExchangeWindow.SetBtnContent)((uis.GetReward_C).root, times[3], tonumber(times[2]))
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.ResetBtn).text = (PUtil.get)(20000519)
  ;
  ((uis.ResetBtn).onClick):Set(function(...)
    -- function num : 0_5_0 , upvalues : _ENV, configData
    (MessageMgr.OpenConfirmWindow)((PUtil.get)(20000514), function(...)
      -- function num : 0_5_0_0 , upvalues : _ENV, configData
      (SlotsService.ReqSlotsReset)(configData.type)
    end
)
  end
)
end

ActivityDungeonExchangeWindow.SetBtnContent = function(com, times, preTimes, ...)
  -- function num : 0_6 , upvalues : _ENV, configData, ActivityDungeonExchangeWindow
  if times == nil or tonumber(times) <= 0 then
    com.visible = false
  end
  times = tonumber(times)
  local icon = com:GetChild("IconLoader")
  local txt = com:GetChild("NumberTxt")
  local singleCost = split(configData.cost, ":")
  local count = (ActorData.GetAssetCount)(tonumber(singleCost[2]))
  local Const = singleCost[1] .. ":" .. singleCost[2] .. ":" .. tonumber(singleCost[3]) * times
  if not (Util.CheckCostResources)(Const, nil, nil, true) and count > 0 and times > 1 and preTimes and preTimes > 0 then
    local preConst = singleCost[1] .. ":" .. singleCost[2] .. ":" .. tonumber(singleCost[3]) * preTimes
    if (Util.CheckCostResources)(preConst, nil, nil, true) then
      local mTimes = (math.floor)(count / tonumber(singleCost[3]))
      if preTimes < mTimes then
        times = mTimes
      end
    end
  end
  do
    times = (math.min)(times, (ActivityDungeonExchangeWindow.GetRemainCount)())
    local btn = com:GetChild("n4")
    btn.text = (PUtil.get)(20000458, times)
    local Const = singleCost[1] .. ":" .. singleCost[2] .. ":" .. tonumber(singleCost[3]) * times
    ;
    (Util.SetConsumption)(Const, icon, txt, false, true)
    ;
    (btn.onClick):Set(function(...)
    -- function num : 0_6_0 , upvalues : singleCost, _ENV, configData, times
    local Const = singleCost[1] .. ":" .. singleCost[2] .. ":" .. 1
    if (Util.CheckCostResources)(Const, nil, nil, true) then
      (SlotsService.ReqSlotsOperation)(configData.type, times)
    else
      local data = (Util.GetConfigDataByID)(singleCost[2])
      ;
      (MessageMgr.SendCenterTips)((PUtil.get)(177, data.name))
    end
  end
)
  end
end

ActivityDungeonExchangeWindow.OnShown = function(...)
  -- function num : 0_7 , upvalues : laba, _ENV, uis, cardModel, cardLoader, ActivityDungeonExchangeWindow
  laba = (Util.ShowUIModel)("ui_laba", uis.ALoader, nil, false, function(object, ...)
    -- function num : 0_7_0 , upvalues : _ENV
    (SkeletonAnimationUtil.SetAnimation)(object, 0, "idle", true, nil, true)
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((object.gameObject).transform).localScale = Vector3(100, 100, 100)
  end
)
  cardModel = (Util.ShowUIModel)("CardSpine_11101002", cardLoader, nil, false, function(model, ...)
    -- function num : 0_7_1 , upvalues : _ENV
    (SkeletonAnimationUtil.SetAnimation)(model, 0, "idle", true, nil, true)
    ;
    (CSLuaUtil.SetGOScale)(model, 20, 20, 20)
  end
)
  ;
  (ActivityDungeonExchangeWindow.SetRoundShow)((SlotsData.SlotRound)())
  local time = (((ActivityMgr.InitActivityDungeonData)()).baseActivityInfo).destroyTime
  ;
  (ActivityDungeonExchangeWindow.SetCountDown)(time)
  ;
  (ActivityDungeonExchangeWindow.ModifyLastLabel)()
end

ActivityDungeonExchangeWindow.SetCountDown = function(time, ...)
  -- function num : 0_8 , upvalues : mTime, _ENV, uis
  if mTime then
    mTime:Stop()
  end
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R1 in 'UnsetPending'

  if time - (ActorData.GetServerTime)() <= 0 then
    ((uis.RewardShow).EndTimeTxt).text = (PUtil.get)(20000221)
  else
    mTime = (LuaTime.CountDown)(time * 0.001 - (ActorData.GetServerTime)() * 0.001, (uis.RewardShow).EndTimeTxt, function(...)
    -- function num : 0_8_0 , upvalues : uis, _ENV
    -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

    ((uis.RewardShow).EndTimeTxt).text = (PUtil.get)(20000221)
  end
, true)
  end
end

ActivityDungeonExchangeWindow.PlayAnimation = function(name, goods, equip, ...)
  -- function num : 0_9 , upvalues : isSkipAni, _ENV, laba, cardModel, uis, centerPos
  if isSkipAni then
    (ActorService.OtherWayToGetCardShow)(goods, function(...)
    -- function num : 0_9_0 , upvalues : _ENV, goods, equip
    (MessageMgr.ShowGetGoods)(goods, equip)
  end
)
    return 
  end
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (GRoot.inst).touchable = false
  ;
  (SkeletonAnimationUtil.SetAnimation)(laba, 0, name, false, function(...)
    -- function num : 0_9_1 , upvalues : name, _ENV, goods, equip
    if name == "ten" then
      (SimpleTimer.setTimeout)(0.4, function(...)
      -- function num : 0_9_1_0 , upvalues : _ENV, goods, equip
      -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

      (GRoot.inst).touchable = true
      ;
      (ActorService.OtherWayToGetCardShow)(goods, function(...)
        -- function num : 0_9_1_0_0 , upvalues : _ENV, goods, equip
        (MessageMgr.ShowGetGoods)(goods, equip)
      end
)
    end
)
    else
      ;
      (ActorService.OtherWayToGetCardShow)(goods, function(...)
      -- function num : 0_9_1_1 , upvalues : _ENV, goods, equip
      (MessageMgr.ShowGetGoods)(goods, equip)
    end
)
      -- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

      ;
      (GRoot.inst).touchable = true
    end
  end
, true)
  ;
  (SkeletonAnimationUtil.AddEvent)(laba, function(trackEntry, event, ...)
    -- function num : 0_9_2 , upvalues : _ENV, cardModel
    if (event.Data).Name == "hanggezuishuai" then
      (SkeletonAnimationUtil.SetAnimation)(cardModel, 0, "idle", true)
    end
  end
)
  ;
  (SkeletonAnimationUtil.SetAnimation)(cardModel, 0, "run", true)
  if name == "ten" then
    (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_ACTIVITY_EXCHANGE_TEN, true, uis.root, centerPos)
  else
    ;
    (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_ACTIVITY_EXCHANGE_SINGLE, true, uis.root, centerPos)
  end
end

ActivityDungeonExchangeWindow.RefreshRewardList = function(...)
  -- function num : 0_10 , upvalues : _ENV, RoundData, uis, ActivityDungeonExchangeWindow
  local mData = (TableData.gTable).BaseSlotsPoolData
  local aimList = {}
  local basicList = {}
  for _,v in pairs(mData) do
    if v.type == RoundData.pool then
      if v.reward_lab == 1 then
        (table.insert)(aimList, v)
      else
        ;
        (table.insert)(basicList, v)
      end
    end
  end
  ;
  (table.sort)(aimList, function(a, b, ...)
    -- function num : 0_10_0
    do return a.sort < b.sort end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (table.sort)(basicList, function(a, b, ...)
    -- function num : 0_10_1
    do return a.sort < b.sort end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((uis.RewardShow).RewardList).numItems = 0
  if #aimList > 0 then
    (ActivityDungeonExchangeWindow.SetListShow)(aimList, true)
  end
  if #basicList > 0 then
    (ActivityDungeonExchangeWindow.SetListShow)(basicList, false)
  end
end

ActivityDungeonExchangeWindow.GetRemainCount = function(...)
  -- function num : 0_11 , upvalues : _ENV, RoundDataList
  local mData = nil
  for _,v in ipairs(RoundDataList) do
    if v.num_round == (SlotsData.SlotRound)() then
      mData = v
    end
  end
  local PoolData = (TableData.gTable).BaseSlotsPoolData
  local count = 0
  local get = 0
  for _,v in pairs(PoolData) do
    if v.type == mData.pool then
      count = count + v.reward_max
      local times = (SlotsData.GetItemTimes)(mData.num_round, v.id)
      if times > 0 then
        get = get + times
      end
    end
  end
  return count - (get)
end

ActivityDungeonExchangeWindow.SetListShow = function(mList, isAim, ...)
  -- function num : 0_12 , upvalues : _ENV, ActivityDungeonExchangeWindow, uis, RoundData
  local line = UIMgr:CreateObject("ActivityDungeon", "RewardTitle")
  if isAim then
    (line:GetChild("NameTxt")).text = (PUtil.get)(20000460)
  else
    ;
    (line:GetChild("NameTxt")).text = (PUtil.get)(20000461)
  end
  local count, getCount = (ActivityDungeonExchangeWindow.GetAimCount)(mList)
  if count - getCount > 0 then
    (line:GetChild("NumberTxt")).text = (PUtil.get)(20000462, count - getCount, count)
  else
    ;
    (line:GetChild("NumberTxt")).text = (PUtil.get)(20000515, count - getCount, count)
  end
  ;
  ((uis.RewardShow).RewardList):AddChild(line)
  for i,v in ipairs(mList) do
    local item = split(v.reward, ":")
    local itemID = tonumber(item[2])
    local propData = (Util.GetConfigDataByID)(itemID)
    local reward = UIMgr:CreateObject("ActivityDungeon", "Reward")
    ;
    (Util.SetAllItemIcon)(reward:GetChild("AllItemIcon"), itemID, 1, false, false, true)
    ;
    (reward:GetChild("NameTxt")).text = propData.name .. "x" .. item[3]
    local roundNum = ((SlotsData.SlotRound)())
    local getCount = nil
    local times = (SlotsData.GetItemTimes)(RoundData.num_round, v.id)
    if times == -1 then
      times = v.reward_max
    end
    if roundNum == RoundData.num_round then
      getCount = times
    else
      if roundNum < RoundData.num_round then
        getCount = 0
      else
        getCount = times
      end
    end
    local max = v.reward_max
    if max - getCount > 0 then
      (reward:GetChild("ItemNumberTxt")).text = (PUtil.get)(20000463, max - getCount, max)
    else
      ;
      (reward:GetChild("ItemNumberTxt")).text = (PUtil.get)(20000516, max - getCount, max)
    end
    ;
    ((uis.RewardShow).RewardList):AddChild(reward)
    if i < #mList then
      local line = UIMgr:CreateObject("ActivityDungeon", "RewardLine")
      ;
      ((uis.RewardShow).RewardList):AddChild(line)
    end
  end
end

ActivityDungeonExchangeWindow.GetAimCount = function(List, ...)
  -- function num : 0_13 , upvalues : _ENV, RoundData
  local roundNum = (SlotsData.SlotRound)()
  local count = 0
  local getCount = 0
  for _,v in pairs(List) do
    count = count + v.reward_max
    local times = (SlotsData.GetItemTimes)(RoundData.num_round, v.id)
    if times == -1 then
      times = v.reward_max
    end
    if roundNum == RoundData.num_round then
      local get = times
      getCount = getCount + get
    else
      do
        do
          if RoundData.num_round < roundNum then
            getCount = times + (getCount)
          else
            getCount = 0
          end
          -- DECOMPILER ERROR at PC31: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC31: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC31: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  return count, getCount
end

ActivityDungeonExchangeWindow.InitLabelList = function(...)
  -- function num : 0_14 , upvalues : uis, _ENV, RoundDataList, configData, RoundData, ActivityDungeonExchangeWindow
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.RewardShow).LabelList).numItems = 0
  local mData = (TableData.gTable).BaseSlotsRoundData
  RoundDataList = {}
  for _,v in pairs(mData) do
    do
      if v.type == configData.type then
        do
          (table.insert)(RoundDataList, v)
          -- DECOMPILER ERROR at PC21: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC21: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  ;
  (table.sort)(RoundDataList, function(a, b, ...)
    -- function num : 0_14_0
    do return a.num_round < b.num_round end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  for i,v in ipairs(RoundDataList) do
    local obj = UIMgr:CreateObject("ActivityDungeon", "RewardChangeBtn")
    ;
    (obj:GetChild("NameTxt")).text = (PUtil.get)(20000459, i)
    ;
    ((uis.RewardShow).LabelList):AddChild(obj)
    if i == #RoundDataList then
      (obj:GetChild("n12")).visible = false
    end
    ;
    (obj.onClick):Set(function(...)
    -- function num : 0_14_1 , upvalues : RoundData, v, ActivityDungeonExchangeWindow, uis, i
    RoundData = v
    ;
    (ActivityDungeonExchangeWindow.RefreshRewardList)()
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R0 in 'UnsetPending'

    if ((uis.RewardShow).LabelList).selectedIndex ~= i - 1 then
      ((uis.RewardShow).LabelList).selectedIndex = i - 1
    end
  end
)
  end
end

ActivityDungeonExchangeWindow.SetRoundShow = function(round, ...)
  -- function num : 0_15 , upvalues : _ENV, RoundDataList, RoundData, ActivityDungeonExchangeWindow, uis
  for i,v in ipairs(RoundDataList) do
    if v.num_round == round then
      RoundData = v
      ;
      (ActivityDungeonExchangeWindow.RefreshRewardList)()
      -- DECOMPILER ERROR at PC19: Confused about usage of register: R6 in 'UnsetPending'

      if ((uis.RewardShow).LabelList).selectedIndex ~= i - 1 then
        ((uis.RewardShow).LabelList).selectedIndex = i - 1
        ;
        ((uis.RewardShow).LabelList):ScrollToView(i - 1)
      end
    end
  end
  local count = ((uis.RewardShow).LabelList).numItems
  for i = 1, count do
    local obj = ((uis.RewardShow).LabelList):GetChildAt(i - 1)
    if obj then
      if i - 1 == round then
        ChangeUIController(obj, "c1", 1)
      else
        ChangeUIController(obj, "c1", 0)
      end
    end
  end
end

ActivityDungeonExchangeWindow.OnHide = function(...)
  -- function num : 0_16
end

ActivityDungeonExchangeWindow.ModifyLastLabel = function(...)
  -- function num : 0_17 , upvalues : _ENV, uis
  local total = (SlotsData.ChangeTotalRound)()
  local curr = (SlotsData.SlotRound)()
  if total <= curr then
    return 
  end
  local labelList = (uis.RewardShow).LabelList
  local obj = labelList:GetChildAt(labelList.numItems - 1)
  ;
  (obj:GetChild("NameTxt")).text = (PUtil.get)(20000459, total + 1)
end

ActivityDungeonExchangeWindow.InitAssetStrip = function(...)
  -- function num : 0_18 , upvalues : _ENV, uis
  local m = {}
  m.windowName = (WinResConfig.ActivityDungeonExchangeWindow).name
  m.Tip = (PUtil.get)(20000216)
  m.model = uis.AssetStrip
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.ACTIVITY_SCORE}
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

ActivityDungeonExchangeWindow.OnClose = function(...)
  -- function num : 0_19 , upvalues : mTime, _ENV, uis, cardLoader, laba, cardModel, contentPane, argTable
  if mTime then
    mTime:Stop()
  end
  ;
  (Util.RecycleUIModel)(uis.ALoader)
  ;
  (Util.RecycleUIModel)(cardLoader)
  laba = nil
  cardModel = nil
  cardLoader = nil
  uis = nil
  contentPane = nil
  argTable = {}
  ;
  (CommonWinMgr.RemoveAssets)((WinResConfig.ActivityDungeonExchangeWindow).name)
end

ActivityDungeonExchangeWindow.GetLotteryColor = function(goods, equip, ...)
  -- function num : 0_20 , upvalues : _ENV
  local id = 0
  for _,v in pairs(goods) do
    if v.value >= 0 then
      id = v.id
    end
    do break end
  end
  do
    for _,v in pairs(equip) do
      id = v.id
      do break end
    end
    do
      local configData, type = (Util.GetConfigDataByID)(id)
      if type == PropType.ITEM or type == PropType.ASSET then
        return configData.quality
      else
        if type == PropType.CARD then
          return configData.intelligence + 1
        else
          if type == PropType.EQUIP then
            return configData.intelligence
          end
        end
      end
    end
  end
end

ActivityDungeonExchangeWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_21 , upvalues : _ENV, ActivityDungeonExchangeWindow, aniName, isSkipAni
  if msgId == (WindowMsgEnum.ActivityDungeonExchange).E_MSG_SHOW_RESULT then
    local data = para
    local goods = data[1]
    local equip = data[2]
    if #goods + #equip >= 10 then
      (ActivityDungeonExchangeWindow.PlayAnimation)("ten", goods, equip)
    else
      local colorNum = (ActivityDungeonExchangeWindow.GetLotteryColor)(goods, equip) or 1
      ;
      (ActivityDungeonExchangeWindow.PlayAnimation)(aniName[colorNum + 1], goods, equip)
    end
  else
    do
      if msgId == (WindowMsgEnum.ActivityDungeonExchange).E_MSG_RESET then
        (ActivityDungeonExchangeWindow.SetRoundShow)((SlotsData.SlotRound)())
        ;
        (ActivityDungeonExchangeWindow.SetResetShow)()
        ;
        (ActivityDungeonExchangeWindow.InitBtn)()
      else
        if msgId == (WindowMsgEnum.ActivityDungeonExchange).E_MSG_REFRESH then
          (ActivityDungeonExchangeWindow.InitBtn)()
          local waitTime = 5
          if isSkipAni then
            waitTime = 0
          end
          ;
          (SimpleTimer.setTimeout)(waitTime, function(...)
    -- function num : 0_21_0 , upvalues : ActivityDungeonExchangeWindow, _ENV
    (ActivityDungeonExchangeWindow.SetRoundShow)((SlotsData.SlotRound)())
    ;
    (ActivityDungeonExchangeWindow.SetResetShow)()
  end
)
          local isChange = (SlotsData.ChangeRound)()
          if isChange then
            (ActivityDungeonExchangeWindow.ModifyLastLabel)()
            ;
            (SlotsData.ChangeRound)(false)
            UIMgr:SetOnHideComplete((WinResConfig.RewardShowWindow).name, function(...)
    -- function num : 0_21_1 , upvalues : _ENV
    local content = (PUtil.get)(20000512, (SlotsData.ChangeTotalRound)() + 1)
    ;
    (MessageMgr.OpenSoloConfirmWindow)(content, nil, (PUtil.get)(20000513))
  end
)
          end
        end
      end
    end
  end
end

return ActivityDungeonExchangeWindow

