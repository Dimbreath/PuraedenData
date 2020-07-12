-- params : ...
-- function num : 0 , upvalues : _ENV
require("AdventureGame_GoldGameByName")
local AdventureGame_GoldGame = {}
local uis, contentPane = nil, nil
local argTable = {}
local nodeId = nil
local dropGrps = {}
local randomDropPos = {}
local dropGoodsId = {}
local dropGoodsItem = {}
local timer, swipe, dog = nil, nil, nil
local dogIsRun = false
local dogSpeed = 1
local GameState = {init = 1, talk = 2, startCountDown = 3, gaming = 4, gameover = 5, accounts = 6}
local gameState = GameState.init
local getRewards = {}
local COUNTDOWN = 11
local INTERVAL = 0.15
local DURATION = 4
local SLOWDOWN = 5
local BOOMBNUM = 3
local ALLITEMNUM = 54
local GEMNUM = 5
local GOLDNUM = 46
local BOOBMSPACEMIN = 12
local BOOBMSPACEMAX = 18
local GEMSPACEMIN = 8
local GEMSPACEMAX = 12
local FIRSTGOLDID = 76460001
local LASTGOLDID = 76460046
local LASTGEMID = 76460051
local DROPPOSIMIN = -200
local DROPPOSIMAX = 200
local DROPCONSTY, swipe, dropTimer, timerL, timerR = nil, nil, nil, nil, nil
AdventureGame_GoldGame.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, nodeId, uis, DROPPOSIMIN, DROPPOSIMAX, DROPCONSTY, AdventureGame_GoldGame
  bridgeObj:SetView((WinResConfig.AdventureGame_GoldGame).package, (WinResConfig.AdventureGame_GoldGame).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  nodeId = argTable[1]
  uis = GetAdventureGame_GoldGameUis(contentPane)
  DROPPOSIMIN = (math.floor)((((uis.RefreshGrp).root):GetChild("Refresh_01_Image")).x + ((uis.RefreshGrp).root).x)
  DROPPOSIMAX = (math.floor)((((uis.RefreshGrp).root):GetChild("Refresh_07_Image")).x + ((uis.RefreshGrp).root).x)
  DROPCONSTY = (((uis.RefreshGrp).root):GetChild("Refresh_01_Image")).y + ((uis.RefreshGrp).root).y
  ;
  (AdventureGame_GoldGame.InitAttr)()
  ;
  (LuaSound.LoadAndPlayBGM)(1010004)
end

AdventureGame_GoldGame.InitAttr = function(...)
  -- function num : 0_1 , upvalues : uis, _ENV, COUNTDOWN, gameState, GameState, AdventureGame_GoldGame, timer, timerR, timerL
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.BrickTalkGrp).root).visible = true
  ;
  (Util.RecycleUIModel)((uis.BrickTalkGrp).CardLoader)
  ;
  (Util.ShowUIModel)("l2d_11301004", (uis.BrickTalkGrp).CardLoader)
  UIMgr:ShowGrabBloom((((uis.BrickTalkGrp).root):GetChild("PopBg")).displayObject)
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.TouchScreenBtn).visible = true
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.Animation_StartGrp).root).visible = false
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.Animation_OverGrp).root).visible = false
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.ReduceTimeTxt).visible = false
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.TimeTxt).visible = false
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.ClockImage).visible = false
  COUNTDOWN = 11
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.BrickTalkGrp).TalkTxt).text = (PUtil.get)(156)
  gameState = GameState.talk
  ;
  ((uis.TouchScreenBtn).onClick):Add(function(...)
    -- function num : 0_1_0 , upvalues : gameState, GameState, uis, _ENV, AdventureGame_GoldGame, timer, COUNTDOWN, timerR, timerL
    -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

    if gameState == GameState.talk then
      ((uis.BrickTalkGrp).root).visible = false
      UIMgr:HideGrabBloom((((uis.BrickTalkGrp).root):GetChild("PopBg")).displayObject)
      -- DECOMPILER ERROR at PC18: Confused about usage of register: R0 in 'UnsetPending'

      ;
      ((uis.Animation_StartGrp).root).visible = true
      gameState = GameState.startCountDown
      PlayUITrans((uis.Animation_StartGrp).root, "Start", function(...)
      -- function num : 0_1_0_0 , upvalues : gameState, GameState, AdventureGame_GoldGame, uis, timer, _ENV, COUNTDOWN, timerR, timerL
      gameState = GameState.gaming
      ;
      (AdventureGame_GoldGame.InitGameIssue)()
      -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

      ;
      ((uis.Animation_StartGrp).root).visible = false
      -- DECOMPILER ERROR at PC8: Confused about usage of register: R0 in 'UnsetPending'

      ;
      (uis.TouchScreenBtn).visible = false
      -- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

      ;
      (uis.TimeTxt).visible = true
      -- DECOMPILER ERROR at PC12: Confused about usage of register: R0 in 'UnsetPending'

      ;
      (uis.ClockImage).visible = true
      ;
      (AdventureGame_GoldGame.StartDropSomething)()
      local issue = 0.01
      timer = (SimpleTimer.new)(issue, -1, function(...)
        -- function num : 0_1_0_0_0 , upvalues : COUNTDOWN, issue, _ENV, uis, timer
        COUNTDOWN = COUNTDOWN - issue
        local str = split(tostring(COUNTDOWN), ".")
        local s1 = str[1]
        if (string.len)(s1) < 2 then
          s1 = "0" .. s1
        end
        local s2 = (string.sub)(str[2], 0, 2)
        if (string.len)(s2) < 2 then
          s2 = s2 .. "0"
        end
        local finals = s1 .. "：" .. s2
        -- DECOMPILER ERROR at PC40: Confused about usage of register: R4 in 'UnsetPending'

        ;
        (uis.TimeTxt).text = finals
        if COUNTDOWN <= 0 then
          timer:Comp()
          timer = nil
        end
      end
, function(...)
        -- function num : 0_1_0_0_1 , upvalues : uis, _ENV, timerR, timerL, gameState, GameState, AdventureGame_GoldGame
        -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

        (uis.TimeTxt).text = "00：00"
        -- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

        ;
        ((uis.Animation_OverGrp).root).visible = true
        -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

        ;
        (uis.TouchScreenBtn).visible = true
        PlayUITrans((uis.Animation_OverGrp).root, "Over", function(...)
          -- function num : 0_1_0_0_1_0 , upvalues : timerR, timerL, _ENV, gameState, GameState, AdventureGame_GoldGame
          if timerR ~= nil then
            timerR:stop()
            timerR = nil
          end
          if timerL ~= nil then
            timerL:stop()
            timerL = nil
          end
          ;
          (SimpleTimer.setTimeout)(1.5, function(...)
            -- function num : 0_1_0_0_1_0_0 , upvalues : gameState, GameState
            gameState = GameState.accounts
          end
)
          gameState = GameState.gameover
          ;
          (AdventureGame_GoldGame.OnGameOver)()
        end
)
      end
)
      timer:start()
    end
)
    else
      if gameState == GameState.accounts then
        UIMgr:CloseWindow((WinResConfig.AdventureGame_GoldGame).name)
      end
    end
  end
)
end

AdventureGame_GoldGame.InitGameIssue = function(...)
  -- function num : 0_2 , upvalues : uis, _ENV, AdventureGame_GoldGame, dogIsRun
  local lastX = 0
  local lastY = 0
  local init = false
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((uis.DogGrp).DogLoader).draggable_X = true
  ;
  (((uis.DogGrp).DogLoader).onDragStart):Add(function(eventContext, ...)
    -- function num : 0_2_0 , upvalues : lastX, lastY
    lastX = (eventContext.inputEvent).x
    lastY = (eventContext.inputEvent).y
  end
)
  ;
  (((uis.DogGrp).DogLoader).onDragMove):Add(function(eventContext, ...)
    -- function num : 0_2_1 , upvalues : lastX, lastY, _ENV, AdventureGame_GoldGame
    local x = (eventContext.inputEvent).x - lastX
    lastX = (eventContext.inputEvent).x
    local y = (eventContext.inputEvent).y - lastY
    lastY = (eventContext.inputEvent).y
    x = x / Screen.width * ResolutionHandler.Width
    y = y / Screen.height * ResolutionHandler.Height
    ;
    (AdventureGame_GoldGame.MoveDog)(x, y)
  end
)
  dogIsRun = false
end

AdventureGame_GoldGame.Update = function(...)
  -- function num : 0_3
end

AdventureGame_GoldGame.MoveDog = function(x, y, ...)
  -- function num : 0_4 , upvalues : AdventureGame_GoldGame, uis
  (AdventureGame_GoldGame.SetMapPos)(((uis.DogGrp).root).x + x, ((uis.DogGrp).root).y + y)
end

AdventureGame_GoldGame.SetMapPos = function(posX, posY, ...)
  -- function num : 0_5 , upvalues : uis, _ENV
  local minX = ((uis.DogGrp).DogLoader).width / 2
  local minY = ((uis.DogGrp).DogLoader).height / 2
  local limitX = ResolutionHandler.Width - minX
  local limitY = ResolutionHandler.Height - minY
  if limitX < posX then
    posX = limitX
  else
    if posX < minX then
      posX = minX
    end
  end
  if limitY < posY then
    posY = limitY
  else
    if posY < minY then
      posY = minY
    end
  end
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((uis.DogGrp).root).x = posX
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((uis.DogGrp).root).y = posY
end

AdventureGame_GoldGame.StartDropSomething = function(...)
  -- function num : 0_6 , upvalues : AdventureGame_GoldGame, _ENV, dropGoodsId, FIRSTGOLDID, dropTimer, INTERVAL, dropGoodsItem
  (AdventureGame_GoldGame.InitSomethingData)()
  for i = 1, 100000 do
    (table.insert)(dropGoodsId, FIRSTGOLDID)
  end
  dropTimer = (SimpleTimer.setInterval)(INTERVAL, #dropGoodsId, function(timer, count, ...)
    -- function num : 0_6_0 , upvalues : _ENV, dropGoodsItem, AdventureGame_GoldGame, dropGoodsId
    (table.insert)(dropGoodsItem, (AdventureGame_GoldGame.CreatItem)(dropGoodsId[count], count))
  end
, function(...)
    -- function num : 0_6_1 , upvalues : _ENV
    print("----所有物品创建完毕")
  end
)
end

AdventureGame_GoldGame.InitSomethingData = function(...)
  -- function num : 0_7 , upvalues : dropGoodsId, AdventureGame_GoldGame, FIRSTGOLDID, LASTGOLDID, GOLDNUM, GEMNUM, _ENV, GEMSPACEMIN, GEMSPACEMAX, BOOMBNUM, BOOBMSPACEMIN, BOOBMSPACEMAX, ALLITEMNUM, LASTGEMID
  dropGoodsId = {}
  dropGoodsId = (AdventureGame_GoldGame.Randomx)(FIRSTGOLDID, LASTGOLDID, GOLDNUM)
  local tempG = {}
  for i = 1, GEMNUM do
    if i > 1 then
      tempG[i] = (math.random)(GEMSPACEMIN, GEMSPACEMAX) + tempG[i - 1]
    else
      tempG[i] = (math.random)(GEMSPACEMIN, GEMSPACEMAX)
    end
  end
  if GOLDNUM <= tempG[GEMNUM] then
    tempG[GEMNUM] = GOLDNUM
  end
  for index,value in ipairs(tempG) do
    print(" GEM insert position", value)
    ;
    (table.insert)(dropGoodsId, value, LASTGOLDID + index)
  end
  local tempT = {}
  for i = 1, BOOMBNUM do
    if i > 1 then
      tempT[i] = (math.random)(BOOBMSPACEMIN, BOOBMSPACEMAX) + tempT[i - 1]
    else
      tempT[i] = (math.random)(BOOBMSPACEMIN, BOOBMSPACEMAX)
    end
  end
  if ALLITEMNUM - GEMNUM <= tempT[BOOMBNUM] then
    tempT[BOOMBNUM] = ALLITEMNUM - GEMNUM
  end
  for index,value in ipairs(tempT) do
    print("BOOMB insert position", value)
    ;
    (table.insert)(dropGoodsId, value, LASTGEMID + index)
  end
  ;
  (AdventureGame_GoldGame.RandomDropGrp)()
end

AdventureGame_GoldGame.CreatItem = function(mineralId, index, ...)
  -- function num : 0_8 , upvalues : _ENV, uis, DROPPOSIMIN, DROPPOSIMAX, DROPCONSTY, AdventureGame_GoldGame
  print("mineralId", mineralId)
  local mData = ((TableData.gTable).BaseAdventureGameMineralData)[mineralId]
  local item = (UIPackage.CreateObject)((WinResConfig.AdventureGameWindow).package, "GoldGameReward")
  ;
  (uis.root):AddChild(item)
  item.xy = Vector2((math.random)(DROPPOSIMIN, DROPPOSIMAX), DROPCONSTY)
  local loader = item:GetChild("RewardLoader")
  if tonumber(mData.type) == 2 then
    local rewardData = (AdventureData.GetMiniGameRewardInfo)(AdventureEventType.Goldmine, mData.reward_pool)
    local str = split(rewardData.Rewards, ":")
    loader.url = (Util.GetUrlFromItemID)(tonumber(str[2]), tonumber(str[1]))
  else
    do
      if tonumber(mData.type) == 1 then
        loader.url = (Util.GetItemUrl)(mData.mineral_path)
      else
        if tonumber(mData.type) == 3 then
          loader.url = (Util.GetItemUrl)(mData.mineral_path)
        end
      end
      ;
      (AdventureGame_GoldGame.MoveItems)(item, index, mData)
      return item
    end
  end
end

AdventureGame_GoldGame.RandomDuration = function(...)
  -- function num : 0_9 , upvalues : DURATION, _ENV
  local time = DURATION
  local randomNum = (math.random)(1, 10)
  if randomNum <= 2 then
    time = 3
  end
  if randomNum > 2 and randomNum <= 4 then
    time = 5
  end
  if randomNum > 4 then
    time = DURATION
  end
  return time
end

AdventureGame_GoldGame.MoveItems = function(item, index, mData, ...)
  -- function num : 0_10 , upvalues : _ENV, DURATION, AdventureGame_GoldGame, uis, COUNTDOWN, getRewards, dogSpeed, SLOWDOWN
  local jouney = ResolutionHandler.Height
  local dropTime = DURATION
  do
    if tonumber(mData.type) == 2 then
      local rewardData = (AdventureData.GetMiniGameRewardInfo)(AdventureEventType.Goldmine, mData.reward_pool)
      if rewardData.Id == 25113100 then
        dropTime = (AdventureGame_GoldGame.RandomDuration)()
      end
    end
    ;
    (((item:TweenMoveY(item.y + jouney, dropTime)):SetEase((FairyGUI.EaseType).Linear)):OnUpdate(function(...)
    -- function num : 0_10_0 , upvalues : _ENV, item, uis, mData, COUNTDOWN, getRewards, dogSpeed, SLOWDOWN
    local isGacha = (math.abs)(item.x + 20 - ((uis.DogGrp).root).x) <= (item.width + ((uis.DogGrp).DogLoader).width) * 0.5 and (math.abs)(item.y - ((uis.DogGrp).root).y) <= (item.height + ((uis.DogGrp).DogLoader).height) * 0.5
    if isGacha then
      if tonumber(mData.type) == 1 then
        (LuaSound.PlaySound)(LuaSound.ADVENTURE_BOOM, SoundBank.OTHER)
        COUNTDOWN = COUNTDOWN + mData.parameter
        PlayUITrans(uis.root, "ReduceTime")
        local lod = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_ADVENTUREGAME_BOOM, true)
        do
          (uis.root):AddChild(lod)
          lod:SetXY(item.x + item.width / 2, item.y - item.height / 2)
          loge("接到了地雷 ")
        end
      elseif tonumber(mData.type) == 2 then
        (LuaSound.PlaySound)(LuaSound.ADVENTURE_CATCH_GOLD, SoundBank.OTHER)
        local rewardData = (AdventureData.GetMiniGameRewardInfo)(AdventureEventType.Goldmine, mData.reward_pool)
        ;
        (table.insert)(getRewards, rewardData.Id)
        local get = (UIPackage.CreateObject)((WinResConfig.AdventureGameWindow).package, "Get")
        local loader = get:GetChild("IconLoader")
        local str = split(rewardData.Rewards, ":")
        loader.url = (Util.GetUrlFromItemID)(tonumber(str[2]), tonumber(str[1]))
        ;
        (uis.root):AddChild(get)
        get.xy = ((uis.DogGrp).root).xy
        PlayUITrans(get, "Float", function(...)
      -- function num : 0_10_0_0 , upvalues : get
      get:Dispose()
    end
)
        loge("接到了奖励 " .. tostring(rewardData.Id))
      elseif tonumber(mData.type) == 3 then
        dogSpeed = 0.5
        ;
        (SimpleTimer.setTimeout)(SLOWDOWN, function(...)
      -- function num : 0_10_0_1 , upvalues : dogSpeed
      dogSpeed = 1
    end
)
        loge("接到了减速效果")
      end
      item:Dispose()
    end
    -- DECOMPILER ERROR: 5 unprocessed JMP targets
  end
)):OnComplete(function(...)
    -- function num : 0_10_1 , upvalues : item
    item:Dispose()
  end
)
  end
end

AdventureGame_GoldGame.OnGameOver = function(...)
  -- function num : 0_11 , upvalues : _ENV, nodeId, getRewards
  (AdventureService.ReqAdventureEventReward)(nodeId, AdventureEventType.Goldmine, false, getRewards)
  ;
  (AdventureMgr.AfterShowResult)()
end

AdventureGame_GoldGame.RandomDropGrp = function(...)
  -- function num : 0_12 , upvalues : dropGoodsId, _ENV, randomDropPos
  for i = 1, #dropGoodsId do
    if i < 2 then
      (table.insert)(randomDropPos, (math.random)(1, 7))
    else
      local lastPos = randomDropPos[i - 1]
      while 1 do
        local curPos = (math.random)(1, 7)
        if (math.abs)(curPos - lastPos) <= 0 or (math.abs)(curPos - lastPos) < 4 then
          (table.insert)(randomDropPos, curPos)
          break
        end
      end
    end
  end
end

AdventureGame_GoldGame.Randomx = function(m, n, cnt, ...)
  -- function num : 0_13 , upvalues : _ENV
  if n - m + 1 < cnt then
    return {}
  end
  local t = {}
  local tmp = {}
  ;
  (math.randomseed)((os.time)())
  do
    while cnt > 0 do
      local x = (math.random)(m, n)
      if not tmp[x] then
        t[#t + 1] = x
        tmp[x] = 1
        cnt = cnt - 1
      end
    end
    return t
  end
end

AdventureGame_GoldGame.OnClose = function(...)
  -- function num : 0_14 , upvalues : _ENV, dropTimer, uis, contentPane, argTable, nodeId, dropGrps, gameState, GameState, timer, swipe, dog, dogIsRun, getRewards, dropGoodsItem, dropGoodsId, dogSpeed, randomDropPos, timerR, timerL
  (LuaSound.LoadAndPlayBGM)(1010005)
  if dropTimer ~= nil then
    dropTimer:stop()
    dropTimer = nil
  end
  uis = nil
  contentPane = nil
  argTable = {}
  nodeId = nil
  dropGrps = {}
  gameState = GameState.init
  timer = nil
  swipe = nil
  dog = nil
  dogIsRun = false
  getRewards = {}
  for i,v in ipairs(dropGoodsItem) do
    if v then
      v:Dispose()
    end
  end
  dropGoodsId = {}
  dropGoodsItem = {}
  dogSpeed = 1
  randomDropPos = {}
  if timerR ~= nil then
    timerR:stop()
  end
  if timerL ~= nil then
    timerL:stop()
  end
end

AdventureGame_GoldGame.HandleMessage = function(msgId, para, ...)
  -- function num : 0_15 , upvalues : _ENV
  local windowMsgEnum = WindowMsgEnum.Adventure
  if msgId == windowMsgEnum.E_MSG_CLOSE_REWARDGET_WINDOW then
    UIMgr:CloseWindow((WinResConfig.AdventureGame_GoldGame).name)
  else
    if msgId == windowMsgEnum.E_MSG_GOLD_REWARDS then
      (AdventureMgr.AfterShowResult)()
    end
  end
end

return AdventureGame_GoldGame

