-- params : ...
-- function num : 0 , upvalues : _ENV
require("AdventureGame_TaroRewardChoiceByName")
local TaroRewardChoiceWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local _bulletPool = {}
local _playing = nil
local _screenBulletInfo = {}
TaroRewardChoiceWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, TaroRewardChoiceWindow
  bridgeObj:SetView((WinResConfig.TaroRewardChoiceWindow).package, (WinResConfig.TaroRewardChoiceWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetAdventureGame_TaroRewardChoiceUis(contentPane)
  ;
  (TaroRewardChoiceWindow.InitVariable)()
  ;
  (TaroRewardChoiceWindow.InitText)()
  ;
  (TaroRewardChoiceWindow.InitButtonEvent)()
end

TaroRewardChoiceWindow.InitVariable = function(...)
  -- function num : 0_1 , upvalues : uis, TaroRewardChoiceWindow
  (((uis.BlackBgAni).root).onClick):Add(TaroRewardChoiceWindow.ClickCloseBtn)
end

TaroRewardChoiceWindow.InitText = function(...)
  -- function num : 0_2 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  (uis.ShootBtn).text = (PUtil.get)(20000233)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.WordTxt).text = (PUtil.get)(60000490)
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.SubtitleTxt).text = (PUtil.get)(60000500)
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.SubtitleWordTxt).promptText = "[color=" .. Const.GrayColor .. "]" .. (PUtil.get)(60000491) .. "[/color]"
end

TaroRewardChoiceWindow.InitButtonEvent = function(...)
  -- function num : 0_3 , upvalues : uis, TaroRewardChoiceWindow
  ((uis.TouchScreenBtn).onClick):Add(TaroRewardChoiceWindow.ClickCloseBtn)
  ;
  ((uis.SubtitleBtn).onClick):Add(TaroRewardChoiceWindow.ChangeScreenBulletStatus)
  ;
  ((uis.ShootBtn).onClick):Add(TaroRewardChoiceWindow.SendScreenBullet)
end

TaroRewardChoiceWindow.InitEvent = function(...)
  -- function num : 0_4
end

TaroRewardChoiceWindow.RemoveEvent = function(...)
  -- function num : 0_5
end

TaroRewardChoiceWindow.OnShown = function(...)
  -- function num : 0_6 , upvalues : TaroRewardChoiceWindow
  (TaroRewardChoiceWindow.InitEvent)()
  ;
  (TaroRewardChoiceWindow.Init)()
end

TaroRewardChoiceWindow.OnHide = function(...)
  -- function num : 0_7
end

TaroRewardChoiceWindow.Init = function(...)
  -- function num : 0_8 , upvalues : _ENV, TaroRewardChoiceWindow, _playing
  if AdventureData.TarotStatue == AdventureTarotStatue.Played then
    (TaroRewardChoiceWindow.ShowResult)()
  else
    ;
    (TaroRewardChoiceWindow.ShowPickTarot)()
  end
  ;
  (TaroRewardChoiceWindow.InitSubtitleBtn)()
  if _playing then
    (TaroRewardChoiceWindow.InitBulletScreen)()
  end
end

TaroRewardChoiceWindow.InitSubtitleBtn = function(...)
  -- function num : 0_9 , upvalues : uis, _ENV, _playing
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R0 in 'UnsetPending'

  (uis.SubtitleBtn).selected = (Util.GetPlayerSetting)(PlayerPrefsKeyName.ADVENTURE_SKIP_SUBTITLE) ~= Const.True
  _playing = (uis.SubtitleBtn).selected
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

TaroRewardChoiceWindow.ShowPickTarot = function(...)
  -- function num : 0_10 , upvalues : uis, _ENV, TaroRewardChoiceWindow
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

  (uis.c1Ctr).selectedIndex = 0
  local count = #split(((AdventureData.WishRewards)[AdventureWishRewardType.Tarot]).reward_pool, ",")
  ;
  (uis.RewardList):RemoveChildrenToPool()
  for i = 1, count do
    do
      local item = (uis.RewardList):AddItemFromPool()
      ;
      (item:GetChild("TaroReward")).alpha = 0
      ;
      (item:GetChild("TaroResult")).alpha = 0
      ;
      (SimpleTimer.setTimeout)(0.1 * (i - 1), function(...)
    -- function num : 0_10_0 , upvalues : item, TaroRewardChoiceWindow, i
    if item ~= nil then
      (item:GetTransition("up")):Play(function(...)
      -- function num : 0_10_0_0 , upvalues : TaroRewardChoiceWindow, i, item
      (TaroRewardChoiceWindow.RefreshTarotCard)(i, item)
    end
)
    end
  end
)
    end
  end
end

TaroRewardChoiceWindow.ShowResultAnim = function(...)
  -- function num : 0_11 , upvalues : uis, _ENV, TaroRewardChoiceWindow
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

  (uis.c1Ctr).selectedIndex = 1
  local count = (uis.RewardList).numChildren
  local item = (uis.RewardList):GetChildAt((AdventureData.TarotResultInfo).Index - 1)
  ;
  (TaroRewardChoiceWindow.SetResultItemScale)(item, 1)
  ;
  ((item:GetChild("TaroResult")):GetController("c1")).selectedIndex = ((AdventureData.TarotResultInfo).List)[(AdventureData.TarotResultInfo).Index] - 1
  ;
  (SimpleTimer.setTimeout)(0.25, function(...)
    -- function num : 0_11_0 , upvalues : item
    (item:GetChild("TaroReward")).visible = false
  end
)
  ;
  (item:GetTransition("big")):Play(function(...)
    -- function num : 0_11_1 , upvalues : _ENV, uis, TaroRewardChoiceWindow
    for i = 1, AdventureData.MAX_TAROT_RESULT do
      local otherItem = (uis.RewardList):GetChildAt(i - 1)
      do
        (TaroRewardChoiceWindow.SetResultItemScale)(otherItem, 1)
        ;
        ((otherItem:GetChild("TaroResult")):GetController("c1")).selectedIndex = ((AdventureData.TarotResultInfo).List)[i] - 1
        if i ~= (AdventureData.TarotResultInfo).Index then
          (otherItem:GetTransition("small")):Play()
          ;
          (SimpleTimer.setTimeout)(0.25, function(...)
      -- function num : 0_11_1_0 , upvalues : otherItem
      (otherItem:GetChild("TaroReward")).visible = false
    end
)
        end
      end
    end
  end
)
end

TaroRewardChoiceWindow.SetResultItemScale = function(item, scale, ...)
  -- function num : 0_12 , upvalues : _ENV
  (item:GetChild("TaroResult")).scale = Vector2.one * scale
  ;
  (item:GetChild("TaroReward")).scale = Vector2.one * scale
end

TaroRewardChoiceWindow.ShowResult = function(...)
  -- function num : 0_13 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

  (uis.c1Ctr).selectedIndex = 1
  local count = (uis.RewardList).numChildren
  local item, resultItem = nil, nil
  ;
  (uis.RewardList):RemoveChildrenToPool()
  for i = 1, AdventureData.MAX_TAROT_RESULT do
    local item = (uis.RewardList):AddItemFromPool()
    ;
    (item:GetChild("TaroReward")).visible = false
    resultItem = item:GetChild("TaroResult")
    ;
    (resultItem:GetController("c1")).selectedIndex = ((AdventureData.TarotResultInfo).List)[i] - 1
    if i == (AdventureData.TarotResultInfo).Index then
      resultItem.scale = Vector2.one * 0.95
    else
      resultItem.scale = Vector2.one * 0.85
    end
  end
end

TaroRewardChoiceWindow.RefreshTarotCard = function(index, item, ...)
  -- function num : 0_14 , upvalues : _ENV
  (item.onClick):Set(function(...)
    -- function num : 0_14_0 , upvalues : _ENV, index
    (AdventureMgr.ReqPickTarotCard)(index)
  end
)
end

TaroRewardChoiceWindow.OnClose = function(...)
  -- function num : 0_15 , upvalues : _ENV, TaroRewardChoiceWindow, uis, contentPane, argTable
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  if AdventureData.NeedShowResult then
    AdventureData.NeedShowResult = false
    ;
    (MessageMgr.ShowGetGoods)(AdventureData.TarotRewards)
  end
  ;
  (TaroRewardChoiceWindow.StopScreenBullet)(true)
  ;
  (TaroRewardChoiceWindow.RemoveEvent)()
  uis = nil
  contentPane = nil
  argTable = {}
end

TaroRewardChoiceWindow.ClickCloseBtn = function(...)
  -- function num : 0_16 , upvalues : _ENV
  UIMgr:CloseWindow((WinResConfig.TaroRewardChoiceWindow).name)
end

TaroRewardChoiceWindow.PickTarotCard = function(...)
  -- function num : 0_17 , upvalues : _ENV
  local msg = {}
  msg.rewardPoolId = 202
  msg.type = AdventureWishType.Tarot
  msg.rewards = {
{id = 211000012, value = 1000, type = (ProtoEnum.E_GOODS_TYPE).ASSET}
}
  ;
  (AdventureService.RecvWishReward)(msg)
end

TaroRewardChoiceWindow.InitBulletScreen = function(...)
  -- function num : 0_18 , upvalues : _ENV, _screenBulletInfo, TaroRewardChoiceWindow
  local count = (math.min)(#AdventureData.TaroChatData, AdventureData.MaxBulletAmount)
  for i = 1, count do
    (table.insert)(_screenBulletInfo, (TaroRewardChoiceWindow.ShootOneBullet)(true, i))
  end
  for k,v in pairs(AdventureData.CurrentBulletStatue) do
    if v.Delay then
      v.Delay = false
    end
  end
end

TaroRewardChoiceWindow.AfterSendScreenBullet = function(...)
  -- function num : 0_19 , upvalues : _screenBulletInfo, _ENV, TaroRewardChoiceWindow
  if #_screenBulletInfo < AdventureData.MaxBulletAmount then
    (TaroRewardChoiceWindow.ShootNextBullet)(#_screenBulletInfo + 1)
  end
end

TaroRewardChoiceWindow.ShootNextBullet = function(index, ...)
  -- function num : 0_20 , upvalues : _playing, _screenBulletInfo, TaroRewardChoiceWindow
  if not _playing then
    return 
  end
  _screenBulletInfo[index] = (TaroRewardChoiceWindow.ShootOneBullet)(false, index)
end

TaroRewardChoiceWindow.ShootOneBullet = function(init, index, ...)
  -- function num : 0_21 , upvalues : _ENV, TaroRewardChoiceWindow
  local bulletData = (AdventureData.PopScreenBulletContent)()
  if bulletData == nil then
    return 
  end
  local bullet = (TaroRewardChoiceWindow.GetOneBullet)()
  local bulletInfo = {}
  bulletInfo.Info = bulletData
  bulletInfo.Index = index
  bulletInfo.Bullet = bullet
  local size = (bulletData.bulletScreenData).size
  local bulletStatue = (AdventureData.CurrentBulletStatue)[size]
  if bulletStatue == nil then
    for k,v in pairs(AdventureData.CurrentBulletStatue) do
      bulletStatue = v
      do break end
    end
  end
  do
    bullet.x = ResolutionHandler.Width + 3
    bullet.y = bulletStatue.Index * (size + AdventureData.BulletLineGap)
    bulletStatue.Index = bulletStatue.Index + 1
    if bulletStatue.MaxIndex < bulletStatue.Index then
      bulletStatue.Index = 0
      bulletStatue.Round = bulletStatue.Round + 1
      if init then
        bulletStatue.Delay = true
      end
    end
    local txt = bullet:GetChild("TaroWordTxt")
    txt.text = "[color=#" .. ((AdventureData.BulletsColorPool)[(bulletData.bulletScreenData).color]).Value .. "]" .. bulletData.content .. "[/color]"
    -- DECOMPILER ERROR at PC68: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (txt.textFormat).size = size
    local box = bullet:GetChild("n1")
    box.visible = bulletData.pId == (ActorData.GetPlayerIndex)()
    local duration = (ResolutionHandler.Width + bullet.width) / ((bulletData.bulletScreenData).speed * AdventureData.BulletBaseSpeed)
    local delay = (((CS.UnityEngine).Random).Range)(0, 4)
    if bulletStatue.Delay then
      delay = delay + bulletStatue.Round * 5
    end
    bulletInfo.Tweener = ((((bullet:TweenMoveX(-bullet.width, duration)):SetEase((FairyGUI.EaseType).Linear)):SetDelay(delay)):OnUpdate(function(...)
    -- function num : 0_21_0 , upvalues : bullet
    bullet:InvalidateBatchingState()
  end
)):OnComplete(function(...)
    -- function num : 0_21_1 , upvalues : TaroRewardChoiceWindow, bullet, _ENV, bulletData, index
    (TaroRewardChoiceWindow.PutOneBullet)(bullet)
    ;
    (AdventureData.PushScreenBulletContent)(bulletData)
    ;
    (TaroRewardChoiceWindow.ShootNextBullet)(index)
  end
)
    do return bulletInfo end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

TaroRewardChoiceWindow.GetOneBullet = function(...)
  -- function num : 0_22 , upvalues : _bulletPool, _ENV, uis
  local bullet = nil
  if #_bulletPool > 0 then
    bullet = (table.remove)(_bulletPool, #_bulletPool)
    bullet.visible = true
  else
    bullet = (UIPackage.CreateObject)((WinResConfig.AdventureGameWindow).package, AdventureData.BulletComponent)
    bullet:InvalidateBatchingState(true)
  end
  ;
  (uis.root):AddChild(bullet)
  return bullet
end

TaroRewardChoiceWindow.PutOneBullet = function(bullet, ...)
  -- function num : 0_23 , upvalues : _ENV, _bulletPool
  if bullet == nil then
    return 
  end
  bullet.visible = false
  ;
  (table.insert)(_bulletPool, bullet)
end

TaroRewardChoiceWindow.ChangeScreenBulletStatus = function(...)
  -- function num : 0_24 , upvalues : _playing, TaroRewardChoiceWindow, uis, _ENV
  _playing = not _playing
  if _playing then
    (TaroRewardChoiceWindow.InitBulletScreen)()
  else
    ;
    (TaroRewardChoiceWindow.StopScreenBullet)()
  end
  if (uis.SubtitleBtn).selected then
    (Util.SetPlayerSetting)(PlayerPrefsKeyName.ADVENTURE_SKIP_SUBTITLE, Const.False)
  else
    ;
    (Util.SetPlayerSetting)(PlayerPrefsKeyName.ADVENTURE_SKIP_SUBTITLE, Const.True)
  end
end

TaroRewardChoiceWindow.StopScreenBullet = function(destroy, ...)
  -- function num : 0_25 , upvalues : _ENV, _screenBulletInfo, _bulletPool, TaroRewardChoiceWindow
  loge("stop")
  local count = #_screenBulletInfo
  local recycleFunc, data = nil, nil
  if destroy then
    recycleFunc = function(obj, ...)
    -- function num : 0_25_0
    if obj ~= nil then
      obj:Dispose()
    end
    obj = nil
  end

    for k,v in pairs(_bulletPool) do
      recycleFunc(v)
    end
    _bulletPool = {}
  else
    recycleFunc = TaroRewardChoiceWindow.PutOneBullet
  end
  for i = 1, count do
    data = _screenBulletInfo[i]
    ;
    (AdventureData.PushScreenBulletContent)(data.Info)
    if data.Bullet ~= nil and (data.Bullet).displayObject ~= nil and ((data.Bullet).displayObject).gameObject ~= nil then
      (data.Tweener):Kill(false)
      recycleFunc(data.Bullet)
      data.Bullet = nil
    end
  end
  _screenBulletInfo = {}
end

TaroRewardChoiceWindow.SendScreenBullet = function(...)
  -- function num : 0_26 , upvalues : _ENV, uis
  (AdventureMgr.SendScreenBullet)((uis.SubtitleWordTxt).text)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.SubtitleWordTxt).text = ""
end

TaroRewardChoiceWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_27 , upvalues : _ENV, TaroRewardChoiceWindow
  if msgId == (WindowMsgEnum.Adventure).E_MSG_SHOW_TAROT_RESULT then
    (TaroRewardChoiceWindow.ShowResultAnim)()
  else
    if msgId == (WindowMsgEnum.Adventure).E_MSG_AFTER_SEND_SCREEN_BULLET then
      (TaroRewardChoiceWindow.AfterSendScreenBullet)()
    end
  end
end

return TaroRewardChoiceWindow

