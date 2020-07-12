-- params : ...
-- function num : 0 , upvalues : _ENV
require("Guild_GuessByName")
GTween = FairyGUI.GTween
local GuildGuessWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local Cups = {}
local initPosLoader = 0
local initPosText = 0
local InitScale = 1.5
local BgPosScale = 1.5
local FarPosScale = 0.75
local MiddlePosScale = 0.5
local FarMaxPosX = 750
local FarMinPosX = 570
local MiddleMaxPosX = 810
local MiddleMinPoxX = 490
local BGMinPosY = -190
local BGMaxPosY = 0
local mBg = nil
local currentItems = {}
local timerList = {}
local tranList = {}
local playResetAni = false
GuildGuessWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, playResetAni, uis, initPosLoader, initPosText, GuildGuessWindow, mBg
  bridgeObj:SetView((WinResConfig.GuildGuessWindow).package, (WinResConfig.GuildGuessWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  playResetAni = false
  uis = GetGuild_GuessUis(contentPane)
  initPosLoader = (uis.SpendItemLoader).x
  initPosText = (uis.SpendNumberTxt).x
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.NewResult).ItemList).defaultItem = "ui://CommonResource/AllItemIcon"
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.NewResult).ItemList).itemRenderer = GuildGuessWindow.itemRenderer
  ;
  (GuildGuessWindow.InitAssetStrip)()
  ;
  (GuildGuessWindow.InitBtn)()
  ;
  (GuildGuessWindow.SetConsumeAndTimes)()
  ;
  (GuildGuessWindow.InitCups)(true)
  ;
  (GuildGuessWindow.InitBg)()
  mBg = (uis.root):GetChild("n26")
  ;
  (GuildGuessWindow.SetCurrentReward)()
  -- DECOMPILER ERROR at PC55: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.NewResult).WordTxt).text = (PUtil.get)(20000255)
  -- DECOMPILER ERROR at PC61: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.SpendWordTxt).text = (PUtil.get)(20000397)
end

GuildGuessWindow.itemRenderer = function(index, obj, ...)
  -- function num : 0_1 , upvalues : currentItems, _ENV
  local item = currentItems[index + 1]
  ;
  (Util.SetAllItemIcon)(obj, item.id, item.value)
end

GuildGuessWindow.OnUpdate = function(...)
  -- function num : 0_2 , upvalues : _ENV, mBg, GuildGuessWindow
  if (Input.GetKey)(KeyCode.UpArrow) then
    mBg.y = mBg.y - Time.deltaTime * 20
    loge(mBg.y)
  end
  if (Input.GetKey)(KeyCode.DownArrow) then
    mBg.y = mBg.y + Time.deltaTime * 20
    loge(mBg.y)
  end
  if (Input.GetKey)(KeyCode.LeftArrow) then
    (GuildGuessWindow.SetBg)(-Time.deltaTime * 10, 0)
  end
  if (Input.GetKey)(KeyCode.RightArrow) then
    (GuildGuessWindow.SetBg)(Time.deltaTime * 10, 0)
  end
end

local gt = nil
GuildGuessWindow.InitBg = function(...)
  -- function num : 0_3 , upvalues : uis, _ENV, InitScale, gt, GuildGuessWindow
  local com = (uis.Lamp).root
  com.scale = Vector2(InitScale, InitScale)
  local far, farEffect = (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_GUILD_GUESS_01, false, (uis.Far).root, (Vector2((GRoot.inst).width / 2, (GRoot.inst).height / 2)), nil, InitScale)
  gt = (GTween.To)(InitScale, 1, 2)
  gt:OnUpdate(function(...)
    -- function num : 0_3_0 , upvalues : gt, _ENV, farEffect, com
    local scale = (gt.value).x
    ;
    (CSLuaUtil.SetGOScale)(farEffect, scale, scale, scale, false)
    com.scale = Vector2(scale, scale)
  end
)
  ;
  (GuildGuessWindow.StartBgMove)()
end

GuildGuessWindow.StartBgMove = function(...)
  -- function num : 0_4 , upvalues : _ENV, GuildGuessWindow
  ((CS.InputGyroscope).Singleton):AddAction(GuildGuessWindow.BgMove)
end

GuildGuessWindow.StopBgMove = function(...)
  -- function num : 0_5 , upvalues : _ENV, GuildGuessWindow
  ((CS.InputGyroscope).Singleton):RemoveAction(GuildGuessWindow.BgMove)
end

GuildGuessWindow.BgMove = function(gyro, ...)
  -- function num : 0_6 , upvalues : _ENV, GuildGuessWindow
  local eulerAngles = gyro.rotationRateUnbiased
  if (math.abs)(eulerAngles.x) < 0.2 and (math.abs)(eulerAngles.y) < 0.2 then
    return 
  end
  local offsetX = eulerAngles.y
  local offsetY = eulerAngles.x
  ;
  (GuildGuessWindow.SetBg)(offsetX, offsetY)
end

GuildGuessWindow.SetBg = function(posX, posY, ...)
  -- function num : 0_7 , upvalues : mBg, BgPosScale, uis, _ENV, FarPosScale, FarMinPosX, FarMaxPosX, MiddlePosScale, MiddleMinPoxX, MiddleMaxPosX, BGMinPosY, BGMaxPosY
  local offsetX = posX
  local offsetY = posY
  mBg.x = mBg.x + offsetX * BgPosScale
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((uis.Far).root).x = (Umath.Clamp)(((uis.Far).root).x + offsetX * FarPosScale, FarMinPosX, FarMaxPosX)
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((uis.Middle).root).x = (Umath.Clamp)(((uis.Middle).root).x + offsetX * MiddlePosScale, MiddleMinPoxX, MiddleMaxPosX)
  mBg.y = mBg.y + offsetY * BgPosScale
  -- DECOMPILER ERROR at PC48: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((uis.Far).root).y = ((uis.Far).root).y + offsetY * FarPosScale
  -- DECOMPILER ERROR at PC62: Confused about usage of register: R4 in 'UnsetPending'

  ;
  ((uis.Middle).root).y = (Umath.Clamp)(((uis.Middle).root).y + offsetY * MiddlePosScale, BGMinPosY, BGMaxPosY)
end

GuildGuessWindow.InitCups = function(isInit, ...)
  -- function num : 0_8 , upvalues : Cups, uis, _ENV, playResetAni
  for i = 1, 9 do
    do
      local cup = Cups[i]
      if cup == nil then
        cup = ((uis.Lamp).root):GetChild("GuessItem_0" .. i .. "_Grp")
        Cups[i] = cup
      end
      local loader = cup:GetChild("ItemLoader")
      loader.url = ""
      do
        do
          if loader.Model == nil then
            local obj = (Util.ShowUIModel)("ui_diantiandeng", loader, nil, false, function(model, ...)
    -- function num : 0_8_0 , upvalues : _ENV, i
    (SkeletonAnimationUtil.SetAnimation)(model.gameObject, 0, tostring(i), true)
  end
)
          end
          if playResetAni then
            if cup.visible then
              PlayUITrans(cup, "hide")
            else
              PlayUITrans(cup, "Reset")
            end
          end
          do
            if isInit then
              local isOpen = (GuildMgr.GetCupsIsOpen)(i)
              cup.visible = not isOpen
              cup.touchable = true
            end
            ;
            (cup.onClick):Set(function(...)
    -- function num : 0_8_1 , upvalues : _ENV, i
    if (GuildMgr.GetGuessIsCovered)() and not (GuildMgr.GetCupsIsOpen)(i) then
      local times = (math.min)((GuildMgr.GetGuessTimes)() + 1, Const.SCATTER_GUESS_MAX_CUP)
      local cost = (Util.GetBuyTimesConsume)(BuyTimesType.GuildGuess, times)
      ;
      (MessageMgr.OpenCostResConfirmWindow)(60000406, cost, function(...)
      -- function num : 0_8_1_0 , upvalues : _ENV, i
      (GuildService.ReqGuildGamePlay)(GuessCupOperateType.Once, i)
      ;
      (LuaSound.PlaySound)(LuaSound.GUILD_BLESS_TOUCH, SoundBank.OTHER)
    end
)
    end
  end
)
          end
          -- DECOMPILER ERROR at PC61: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC61: LeaveBlock: unexpected jumping out DO_STMT

        end
      end
    end
  end
  playResetAni = false
end

GuildGuessWindow.PlayFlyAni = function(pos, goods, ...)
  -- function num : 0_9 , upvalues : Cups, _ENV, tranList, timerList
  local com = Cups[pos]
  if com == nil then
    return 
  end
  ;
  (LuaEffect.CreateEffectToObj)(UIEffectEnum.UI_GUILD_GET_CLICK, true, com, (Vector2(com.width / 2, com.height / 2)), nil, nil, true)
  local timer = (SimpleTimer.setTimeout)(0.2, function(...)
    -- function num : 0_9_0 , upvalues : com, _ENV, goods, tranList
    if com ~= nil then
      local rewardLoader = com:GetChild("RewardLoader")
      do
        local baseData = (Util.GetConfigDataByID)(goods.id)
        rewardLoader.url = (Util.GetItemUrl)(baseData.icon)
        local reset = function(...)
      -- function num : 0_9_0_0 , upvalues : com, _ENV
      com.visible = false
      local openList = (GuildMgr.GetGuessOpenList)()
      local maxTimes = (GuildMgr.GetGuessMaxTime)()
      local roundTimes = (GuildMgr.GetGuessRoundTimes)()
      if #openList == Const.SCATTER_GUESS_MAX_CUP and maxTimes - roundTimes > 0 then
        (GuildService.ReqGuildGameReset)()
      end
    end

        local tran = PlayUITrans(com, "fly", function(...)
      -- function num : 0_9_0_1 , upvalues : reset
      reset()
    end
)
        ;
        (table.insert)(tranList, tran)
        local trans = com:GetTransition("fly")
        if trans == nil then
          reset()
        end
      end
    end
  end
)
  ;
  (table.insert)(timerList, timer)
end

GuildGuessWindow.ClearTimer = function(ignoreClick, ...)
  -- function num : 0_10 , upvalues : _ENV, timerList, tranList
  for _,v in ipairs(timerList) do
    if v ~= nil then
      v:stop()
      v = nil
    end
  end
  timerList = {}
  for _,v in ipairs(tranList) do
    if v ~= nil and v.playing then
      v:Stop(true, true)
      v = nil
    end
  end
  tranList = {}
  if ignoreClick then
    (Util.SetOnClickDelay)(2)
  end
end

GuildGuessWindow.InitBtn = function(...)
  -- function num : 0_11 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  (uis.AllBtn).text = (PUtil.get)(20000173)
  ;
  ((uis.AllBtn).onClick):Set(function(...)
    -- function num : 0_11_0 , upvalues : _ENV
    OpenWindow((WinResConfig.GuildGuessOneKeyWindow).name, UILayer.HUD)
  end
)
  ;
  ((uis.GuessBtn).onClick):Set(function(...)
    -- function num : 0_11_1 , upvalues : _ENV
    if ((GuildMgr.GetGuessTimes)() == 0 and not (GuildMgr.GetGuessIsCovered)()) or (GuildMgr.GetGuessIsCovered)() then
      if (GuildMgr.GetGuessTimes)() == 0 then
        (MessageMgr.SendCenterTips)((PUtil.get)(20000374))
        return 
      end
      local maxTimes = (GuildMgr.GetGuessMaxTime)()
      local roundTimes = (GuildMgr.GetGuessRoundTimes)()
      if maxTimes - roundTimes > 0 then
        (GuildService.ReqGuildGameReset)()
      else
        ;
        (MessageMgr.SendCenterTips)((PUtil.get)(20000180))
      end
    end
  end
)
  ;
  ((uis.RecordBtn).onClick):Set(function(...)
    -- function num : 0_11_2 , upvalues : _ENV
    (GuildService.ReqGuildGameRecord)()
  end
)
end

GuildGuessWindow.SetCurrentReward = function(...)
  -- function num : 0_12 , upvalues : _ENV, uis, currentItems
  local data = (GuildMgr.GetRoundReward)()
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  if data == nil or #data.reward <= 0 then
    ((uis.NewResult).root).visible = false
  else
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((uis.NewResult).root).visible = true
    currentItems = data.reward
    -- DECOMPILER ERROR at PC22: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((uis.NewResult).ItemList).numItems = #currentItems
  end
end

GuildGuessWindow.SetConsumeAndTimes = function(...)
  -- function num : 0_13 , upvalues : _ENV, uis, initPosLoader, initPosText
  local times = (math.min)((GuildMgr.GetGuessTimes)() + 1, Const.SCATTER_GUESS_MAX_CUP)
  local const = (Util.GetBuyTimesConsume)(BuyTimesType.GuildGuess, times)
  ;
  (Util.SetConsumption)(const, uis.SpendItemLoader, uis.SpendNumberTxt, true, true)
  local consumeNum = tonumber((split(const, ":"))[3])
  local maxTimes = (GuildMgr.GetGuessMaxTime)()
  local roundTimes = (GuildMgr.GetGuessRoundTimes)()
  local remind = (math.max)(maxTimes - roundTimes, 0)
  -- DECOMPILER ERROR at PC49: Confused about usage of register: R6 in 'UnsetPending'

  if remind <= 0 then
    (uis.GuessNumberTxt).text = (PUtil.get)(20000264, remind)
  else
    -- DECOMPILER ERROR at PC57: Confused about usage of register: R6 in 'UnsetPending'

    ;
    (uis.GuessNumberTxt).text = (PUtil.get)(20000172, remind)
  end
  local state = not (GuildMgr.GetGuessIsCovered)() or maxTimes - roundTimes > 0 or (GuildMgr.GetGuessTimes)() < Const.SCATTER_GUESS_MAX_CUP
  ;
  ((uis.root):GetChild("n52")).visible = not state or consumeNum > 0
  -- DECOMPILER ERROR at PC93: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (uis.SpendWordTxt).visible = not state or consumeNum > 0
  -- DECOMPILER ERROR at PC101: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (uis.SpendItemLoader).visible = not state or consumeNum > 0
  -- DECOMPILER ERROR at PC109: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (uis.SpendNumberTxt).visible = not state or consumeNum > 0
  -- DECOMPILER ERROR at PC114: Confused about usage of register: R7 in 'UnsetPending'

  if consumeNum > 0 then
    (uis.SpendItemLoader).x = initPosLoader
    -- DECOMPILER ERROR at PC117: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (uis.SpendNumberTxt).x = initPosText
  else
    -- DECOMPILER ERROR at PC122: Confused about usage of register: R7 in 'UnsetPending'

    (uis.SpendItemLoader).x = initPosLoader - 40
    -- DECOMPILER ERROR at PC126: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (uis.SpendNumberTxt).x = initPosText - 40
  end
  -- DECOMPILER ERROR at PC137: Confused about usage of register: R7 in 'UnsetPending'

  if (GuildMgr.GetGuessIsCovered)() then
    (uis.GuessBtn).text = (PUtil.get)(20000175)
  else
    -- DECOMPILER ERROR at PC144: Confused about usage of register: R7 in 'UnsetPending'

    (uis.GuessBtn).text = (PUtil.get)(20000174)
  end
  -- DECOMPILER ERROR at PC153: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (uis.AllBtn).visible = (GuildMgr.GetGuessTimes)() == 0
  if (GuildMgr.GetGuessTimes)() == 0 and (GuildMgr.GetGuessIsCovered)() then
    ChangeUIController(uis.GuessBtn, "c1", 1)
  else
    ChangeUIController(uis.GuessBtn, "c1", 0)
  end
  -- DECOMPILER ERROR: 17 unprocessed JMP targets
end

GuildGuessWindow.InitAssetStrip = function(...)
  -- function num : 0_14 , upvalues : _ENV, uis
  local m = {}
  m.windowName = (WinResConfig.GuildGuessWindow).name
  m.Tip = (PUtil.get)(20000174)
  m.model = uis.AssetStripGrp
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.SHOP_TOKEN}
  ;
  (CommonWinMgr.RegisterAssets)(m)
end

GuildGuessWindow.OnShown = function(...)
  -- function num : 0_15
end

GuildGuessWindow.OnHide = function(...)
  -- function num : 0_16
end

GuildGuessWindow.OnClose = function(...)
  -- function num : 0_17 , upvalues : gt, GuildGuessWindow, _ENV, uis, contentPane, argTable, Cups
  gt:Kill(false)
  ;
  (GuildGuessWindow.ClearTimer)(false)
  ;
  (GuildGuessWindow.StopBgMove)()
  ;
  (CommonWinMgr.RemoveAssets)((WinResConfig.GuildGuessWindow).name)
  uis = nil
  contentPane = nil
  argTable = {}
  Cups = {}
end

GuildGuessWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_18 , upvalues : GuildGuessWindow, playResetAni
  if msgId == 1 then
    (GuildGuessWindow.SetConsumeAndTimes)()
    if para then
      (GuildGuessWindow.InitCups)(false)
    else
      ;
      (GuildGuessWindow.InitCups)(true)
    end
    ;
    (GuildGuessWindow.SetCurrentReward)()
  end
  if msgId == 2 then
    (GuildGuessWindow.PlayFlyAni)(para[1], para[2])
  end
  if msgId == 3 then
    (GuildGuessWindow.ClearTimer)(true)
    playResetAni = true
  end
end

return GuildGuessWindow

