-- params : ...
-- function num : 0 , upvalues : _ENV
require("AdventureGame_VowRewardChoiceWindowByName")
require("AdventureGame_VowRewardByName")
local VowRewardChoiceWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local _vowPoint = {}
local _currentSelected, _chosedEffect = nil, nil
VowRewardChoiceWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, VowRewardChoiceWindow
  bridgeObj:SetView((WinResConfig.VowRewardChoiceWindow).package, (WinResConfig.VowRewardChoiceWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetAdventureGame_VowRewardChoiceWindowUis(contentPane)
  ;
  (VowRewardChoiceWindow.InitVariable)()
  ;
  (VowRewardChoiceWindow.InitText)()
  ;
  (VowRewardChoiceWindow.InitButtonEvent)()
end

VowRewardChoiceWindow.InitVariable = function(...)
  -- function num : 0_1 , upvalues : _ENV, uis, _vowPoint
  local pointInfo = nil
  for i = 1, AdventureData.MaxWishTimes do
    pointInfo = {}
    pointInfo.Root = ((uis.VowRewardChoice).root):GetChild("VP_0" .. i)
    pointInfo.Ctrl = (pointInfo.Root):GetController("c1")
    pointInfo.Anim = (pointInfo.Root):GetTransition("open")
    _vowPoint[i] = pointInfo
  end
end

VowRewardChoiceWindow.InitText = function(...)
  -- function num : 0_2 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.VowRewardChoice).WodrTxt).text = (PUtil.get)(60000403)
  -- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.VowRewardChoice).SureBtn).text = (PUtil.get)(60000452)
end

VowRewardChoiceWindow.InitButtonEvent = function(...)
  -- function num : 0_3 , upvalues : uis, VowRewardChoiceWindow
  (((uis.BlackBgAni).root).onClick):Add(VowRewardChoiceWindow.ClickCloseBtn)
  ;
  (((uis.VowRewardChoice).SureBtn).onClick):Add(VowRewardChoiceWindow.ClickWishBtn)
end

VowRewardChoiceWindow.InitEvent = function(...)
  -- function num : 0_4
end

VowRewardChoiceWindow.RemoveEvent = function(...)
  -- function num : 0_5
end

VowRewardChoiceWindow.OnShown = function(...)
  -- function num : 0_6 , upvalues : VowRewardChoiceWindow
  (VowRewardChoiceWindow.InitEvent)()
  ;
  (VowRewardChoiceWindow.Init)()
end

VowRewardChoiceWindow.OnHide = function(...)
  -- function num : 0_7
end

VowRewardChoiceWindow.Init = function(...)
  -- function num : 0_8 , upvalues : _currentSelected, VowRewardChoiceWindow, uis, argTable
  _currentSelected = 0
  ;
  (VowRewardChoiceWindow.InitWishPoint)()
  ;
  ((uis.VowRewardChoice).RewardList):RemoveChildrenToPool()
  local count = #argTable[1]
  local item = nil
  for i = 1, count do
    item = ((uis.VowRewardChoice).RewardList):AddItemFromPool()
    ;
    (VowRewardChoiceWindow.RefreshWishItem)(i, item)
  end
end

VowRewardChoiceWindow.InitWishPoint = function(...)
  -- function num : 0_9 , upvalues : _ENV, _vowPoint
  local progress = AdventureData.WishPoint / AdventureData.MaxWishTimes
  for i = 1, AdventureData.MaxWishTimes do
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R5 in 'UnsetPending'

    if i <= AdventureData.WishPoint then
      ((_vowPoint[i]).Ctrl).selectedIndex = 1
    else
      -- DECOMPILER ERROR at PC20: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((_vowPoint[i]).Ctrl).selectedIndex = 0
    end
    if AdventureData.PlayWishPointAnim and i == AdventureData.WishPoint then
      ((_vowPoint[i]).Anim):Play()
      -- DECOMPILER ERROR at PC34: Confused about usage of register: R5 in 'UnsetPending'

      AdventureData.PlayWishPointAnim = false
    end
  end
end

VowRewardChoiceWindow.RefreshWishItem = function(index, item, ...)
  -- function num : 0_10 , upvalues : _ENV, _currentSelected, VowRewardChoiceWindow, argTable
  item = GetAdventureGame_VowRewardUis(item)
  if _currentSelected == index then
    (VowRewardChoiceWindow.ShowChosedEffect)(item)
  end
  ;
  ((item.root).onClick):Set(function(...)
    -- function num : 0_10_0 , upvalues : _currentSelected, index, VowRewardChoiceWindow, item
    _currentSelected = index
    ;
    (VowRewardChoiceWindow.ShowChosedEffect)(item)
  end
)
  local data = ((((argTable[1])[index]).Data).Reward)[1]
  local config, type = (Util.GetConfigDataByID)(data.id)
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (item.NameTxt).text = config.name
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (item.NumberTxt).text = data.value
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (item.IconLoader).url = (Util.GetItemUrl)(config.icon)
  local holder = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_ADVENTUREGAME_WISH)
  holder.name = "Effect"
  ;
  (item.root):AddChild(holder)
  holder:SetXY((item.VowImage).x + (item.VowImage).width * 0.5, (item.VowImage).y - 36)
end

VowRewardChoiceWindow.ShowChosedEffect = function(item, ...)
  -- function num : 0_11 , upvalues : _chosedEffect, _ENV
  if _chosedEffect == nil then
    _chosedEffect = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_ADVENTUREGAME_WISH_CHOSED)
  end
  ;
  (item.root):AddChild(_chosedEffect)
  local img = (item.root):GetChild("RewardImage")
  _chosedEffect:SetXY(img.x + img.width * 0.5, img.y + img.height + 30)
end

VowRewardChoiceWindow.OnClose = function(...)
  -- function num : 0_12 , upvalues : VowRewardChoiceWindow, _chosedEffect, uis, contentPane, argTable, _vowPoint
  (VowRewardChoiceWindow.RemoveEvent)()
  if _chosedEffect ~= nil then
    _chosedEffect:Dispose()
    _chosedEffect = nil
  end
  local count = ((uis.VowRewardChoice).RewardList).numChildren
  for i = 0, count - 1 do
    local item = ((uis.VowRewardChoice).RewardList):GetChildAt(i)
    ;
    (item:GetChild("Effect")):Dispose()
  end
  uis = nil
  contentPane = nil
  argTable = {}
  _vowPoint = {}
end

VowRewardChoiceWindow.ClickCloseBtn = function(...)
  -- function num : 0_13 , upvalues : _ENV
  UIMgr:CloseWindow((WinResConfig.VowRewardChoiceWindow).name)
end

VowRewardChoiceWindow.ClickWishBtn = function(...)
  -- function num : 0_14 , upvalues : _currentSelected, _ENV, argTable, VowRewardChoiceWindow
  if _currentSelected == 0 then
    (MessageMgr.SendCenterTips)((PUtil.get)(60000470))
    return 
  end
  ;
  (AdventureService.ReqWishReward)(AdventureWishType.Wish, ((argTable[1])[_currentSelected]).PoolId)
  ;
  (VowRewardChoiceWindow.ClickCloseBtn)()
end

VowRewardChoiceWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_15
end

return VowRewardChoiceWindow

