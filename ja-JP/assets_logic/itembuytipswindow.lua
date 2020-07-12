-- params : ...
-- function num : 0 , upvalues : _ENV
require("Message_ItemBuyTipsWindowByName")
local RelationType = FairyGUI.RelationType
local ItemBuyTipsWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local goods = {}
local itemS = {}
local TipsPool = {}
local isEnd = false
local waitNum = 0
local intervalTime = 0.5
ItemBuyTipsWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, goods, uis, waitNum, isEnd
  bridgeObj:SetView((WinResConfig.ItemBuyTipsWindow).package, (WinResConfig.ItemBuyTipsWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  goods = argTable[1]
  uis = GetMessage_ItemBuyTipsWindowUis(contentPane)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.ItemBuyTipsGrp).root).visible = false
  waitNum = 0
  isEnd = false
end

ItemBuyTipsWindow.PlayItemList = function(item, ...)
  -- function num : 0_1 , upvalues : _ENV, itemS, isEnd, ItemBuyTipsWindow
  for _,v in ipairs(item) do
    (table.insert)(itemS, v)
  end
  if isEnd then
    (ItemBuyTipsWindow.PlayTransition)()
  end
end

ItemBuyTipsWindow.PlayTransition = function(...)
  -- function num : 0_2 , upvalues : itemS, isEnd, waitNum, ItemBuyTipsWindow, _ENV, RelationType, contentPane, intervalTime
  if not itemS[1] then
    isEnd = true
    return 
  end
  isEnd = false
  waitNum = waitNum + 1
  local item = itemS[1]
  local content = (ItemBuyTipsWindow.GetTipsByPool)()
  if content == nil then
    content = UIMgr:CreateObject("Message", "ItemBuyTipsWindow")
    content:SetSize((GRoot.inst).width, (GRoot.inst).height)
    content:AddRelation(GRoot.inst, RelationType.Size)
  end
  local model = GetMessage_ItemBuyTipsWindowUis(content)
  contentPane:AddChild(content)
  ;
  (ItemBuyTipsWindow.ShowTips)(model, item, false)
  ;
  (table.remove)(itemS, 1)
  ;
  (SimpleTimer.setTimeout)(intervalTime, function(...)
    -- function num : 0_2_0 , upvalues : ItemBuyTipsWindow
    (ItemBuyTipsWindow.PlayTransition)()
  end
)
end

ItemBuyTipsWindow.GetTipsByPool = function(...)
  -- function num : 0_3 , upvalues : _ENV, TipsPool
  local pos = nil
  for i,_ in ipairs(TipsPool) do
    pos = i
    do break end
  end
  do
    local value = TipsPool[pos]
    ;
    (table.remove)(TipsPool, pos)
    return value
  end
end

ItemBuyTipsWindow.ShowTips = function(model, mItem, root, ...)
  -- function num : 0_4 , upvalues : _ENV, TipsPool, waitNum
  local modelUis = model.ItemBuyTipsGrp
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R4 in 'UnsetPending'

  ;
  (modelUis.ItemList).numItems = 0
  ;
  (Util.SetFrame)(mItem.id, 1, modelUis.ItemList)
  local itemData = (Util.GetConfigDataByID)(mItem.id)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (modelUis.NameTxt).text = (PUtil.get)(20000109, itemData.name, mItem.Num)
  local tran = (model.root):GetTransition("in")
  ;
  (LuaSound.PlaySound)(LuaSound.COMMON_SHOW_REWARD_TINY, SoundBank.OTHER)
  tran:Play(function(...)
    -- function num : 0_4_0 , upvalues : root, _ENV, TipsPool, model, waitNum
    if not root then
      (table.insert)(TipsPool, model.root)
    end
    waitNum = waitNum - 1
    if waitNum <= 0 then
      UIMgr:CloseWindow((WinResConfig.ItemBuyTipsWindow).name)
    end
  end
)
end

ItemBuyTipsWindow.GetTablePos = function(mItem, ...)
  -- function num : 0_5 , upvalues : _ENV, itemS
  for i,v in ipairs(itemS) do
    if v == mItem then
      return i
    end
  end
end

ItemBuyTipsWindow.OnShown = function(...)
  -- function num : 0_6 , upvalues : ItemBuyTipsWindow, goods
  (ItemBuyTipsWindow.PlayItemList)(goods)
  ;
  (ItemBuyTipsWindow.PlayTransition)()
end

ItemBuyTipsWindow.OnHide = function(...)
  -- function num : 0_7
end

ItemBuyTipsWindow.OnClose = function(...)
  -- function num : 0_8 , upvalues : uis, contentPane, argTable, goods, itemS, TipsPool
  uis = nil
  contentPane = nil
  argTable = {}
  goods = {}
  itemS = {}
  TipsPool = {}
end

ItemBuyTipsWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_9 , upvalues : ItemBuyTipsWindow
  if msgId == 1 then
    (ItemBuyTipsWindow.PlayItemList)(para)
  end
end

return ItemBuyTipsWindow

