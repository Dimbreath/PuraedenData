-- params : ...
-- function num : 0 , upvalues : _ENV
require("Lottery_LotteryRewardByName")
local LotteryRewardWindow = {}
local uis, contentPane = nil, nil
local rewardData = {}
local lotteryType = nil
local GetItemType = {Card = 1, Props = 2, Equip = 3}
local rewards = {}
local detalTime = 0.1
local enableClose = false
LotteryRewardWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, uis, rewardData, lotteryType, LotteryRewardWindow, enableClose
  bridgeObj:SetView((WinResConfig.LotteryRewardWindow).package, (WinResConfig.LotteryRewardWindow).comName)
  contentPane = bridgeObj.contentPane
  contentPane:Center()
  uis = GetLottery_LotteryRewardUis(contentPane)
  rewardData = ((bridgeObj.argTable)[1]).data
  lotteryType = (bridgeObj.argTable)[2]
  ;
  (LotteryRewardWindow.RefreshWindow)(rewardData)
  ;
  ((uis.TouchScreenBtn).onClick):Set(function(...)
    -- function num : 0_0_0 , upvalues : enableClose, _ENV
    if enableClose then
      UIMgr:CloseWindow((WinResConfig.LotteryRewardWindow).name)
    end
  end
)
  local uiMap = uis.root
  local holder = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_LOTTERYDIALOG_SHOW, false, false)
  holder:SetXY(uiMap.width / 2, uiMap.height / 2)
  uiMap:AddChild(holder)
  ;
  (LuaSound.PlaySound)(LuaSound.LOTTERY_REWARD, SoundBank.OTHER)
  ;
  (Util.RegistCaptureScreenShot)((uis.Information).ShotBtn, (uis.Information).LogoImage, (uis.Information).CodeImage, 1334, 750)
end

LotteryRewardWindow.RefreshWindow = function(listData, ...)
  -- function num : 0_1 , upvalues : uis, _ENV, rewards, LotteryRewardWindow
  (uis.RewardList):RemoveChildrenToPool()
  local list = {}
  for index,value in ipairs(listData.goods) do
    (table.insert)(list, value)
  end
  for index,value in ipairs(listData.equip) do
    (table.insert)(list, value)
  end
  for i,v in ipairs(list) do
    if v.value >= 0 then
      local item = (uis.RewardList):AddItemFromPool((UIPackage.GetItemURL)((WinResConfig.LotteryRewardWindow).package, "Reward"))
      item.visible = false
      ;
      (table.insert)(rewards, {item = item, info = v})
    end
  end
  ;
  (LotteryRewardWindow.PlayRewardEffect)()
end

LotteryRewardWindow.SetItemInfo = function(item, iData, ...)
  -- function num : 0_2 , upvalues : _ENV
  local ctr1 = item:GetController("c1")
  local quality = 0
  if iData.type == PropType.CARD then
    ctr1.selectedIndex = 0
    local cardItem = item:GetChild("Card")
    local cardData = ((TableData.gTable).BaseCardData)[iData.id]
    local fashionId = tonumber((split(cardData.fashion_ids, ":"))[1])
    ;
    (Util.SetSliverHeadIcon)(fashionId, (cardItem:GetChild("CardLoaderPic")):GetChild("CardLoader"))
    ;
    (cardItem:GetChild("NameTxt")).text = cardData.name
    ;
    (cardItem:GetController("c1")).selectedIndex = cardData.intelligence
    quality = cardData.intelligence
    local holder = nil
    if quality ~= 0 or quality == 1 then
      local effect = nil
      do
        holder = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_LOTTERYREWARD_CARD_BLUE, false, false)
      end
    else
      do
        -- DECOMPILER ERROR at PC65: Overwrote pending register: R8 in 'AssignReg'

        if quality == 2 then
          local effect = effect
          holder = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_LOTTERYREWARD_CARD_PURPLE, false, false)
          local anim = (effect.transform):Find("FX_ui_gachajiesuanpai_purple_grp")
          print("anim", anim)
          if anim ~= nil then
            (SimpleTimer.setTimeout)(0.01, function(...)
    -- function num : 0_2_0 , upvalues : _ENV, anim
    (Util.PlayAnimation)(anim, "FX_ui_gachajiesuanpai_purple_" .. tostring((math.random)(1, 5)))
  end
)
          end
        else
          do
            -- DECOMPILER ERROR at PC94: Overwrote pending register: R8 in 'AssignReg'

            if quality == 3 then
              holder = (effect.AddUIEffect)(UIEffectEnum.UI_LOTTERYREWARD_CARD_GOLD, false, false)
            end
            local uiMap = item:GetChild("Effect")
            holder:SetXY(uiMap.width / 2, uiMap.height / 2 - 2)
            uiMap:AddChild(holder)
            local starList = cardItem:GetChild("StarList")
            for i = 1, cardData.star do
              starList:AddItemFromPool()
            end
            if iData.value == 0 then
              (cardItem:GetController("c2")).selectedIndex = 1
              local piceIndex = 0
              local piceNum = tonumber((split(cardData.debris_goods, ":"))[3])
              if piceNum == 5 then
                piceIndex = 0
              else
                if piceNum == 15 then
                  piceIndex = 1
                else
                  if piceNum == 40 then
                    piceIndex = 2
                  end
                end
              end
              ;
              ((cardItem:GetChild("RepeatGet")):GetController("c1")).selectedIndex = piceIndex
              local piecesId = tonumber((split(cardData.recruit_cost, ":"))[2])
              local imgUrl = (Util.GetItemUrl)((((TableData.gTable).BasePropData)[piecesId]).icon)
              ;
              ((cardItem:GetChild("RepeatGet")):GetChild("IconLoader")).url = imgUrl
            else
              do
                do
                  ;
                  (cardItem:GetController("c2")).selectedIndex = 0
                  if iData.type == PropType.ITEM then
                    ctr1.selectedIndex = 1
                    local itemData = ((TableData.gTable).BasePropData)[iData.id]
                    local propItem = item:GetChild("Item")
                    ;
                    (propItem:GetChild("ItemLoader")).url = (Util.GetItemUrl)(itemData.icon)
                    ;
                    (propItem:GetChild("NumberTxt")).text = iData.value
                    ;
                    (propItem:GetChild("NameTxt")).text = itemData.name
                    if itemData.type == PropItemType.CHARACTER_DEBRIS then
                      local cardQuality = (((TableData.gTable).BaseCardData)[tonumber(itemData.effect_value)]).intelligence + 1
                      ;
                      (propItem:GetController("c1")).selectedIndex = cardQuality
                      quality = cardQuality
                    else
                      do
                        ;
                        (propItem:GetController("c1")).selectedIndex = itemData.quality
                        quality = itemData.quality
                        local holder = nil
                        if quality ~= 0 or quality == 1 then
                          holder = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_LOTTERREWARD_ITEM_GREEN, false, false)
                        else
                          if quality == 2 then
                            holder = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_LOTTERREWARD_ITEM_BLUE, false, false)
                          else
                            if quality == 3 then
                              holder = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_LOTTERREWARD_ITEM_PURPLE, false, false)
                            else
                              if quality == 4 then
                                holder = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_LOTTERREWARD_ITEM_GOLD, false, false)
                              end
                            end
                          end
                        end
                        local uiMap = item:GetChild("Effect")
                        holder:SetXY(uiMap.width / 2, uiMap.height / 2)
                        uiMap:AddChild(holder)
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

LotteryRewardWindow.PlayRewardEffect = function(...)
  -- function num : 0_3 , upvalues : rewards, _ENV, detalTime, LotteryRewardWindow, enableClose
  local LEFT = 5
  local RIGHT = 6
  if #rewards > 1 then
    for i = 0, 4 do
      do
        (SimpleTimer.setTimeout)(detalTime * i, function(...)
    -- function num : 0_3_0 , upvalues : rewards, LEFT, i, LotteryRewardWindow, _ENV, RIGHT, enableClose
    local l = rewards[LEFT - i]
    -- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (l.item).visible = true
    ;
    (LotteryRewardWindow.SetItemInfo)(l.item, l.info)
    PlayUITrans(l.item, "in", function(...)
      -- function num : 0_3_0_0
    end
)
    local r = rewards[RIGHT + i]
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (r.item).visible = true
    ;
    (LotteryRewardWindow.SetItemInfo)(r.item, r.info)
    PlayUITrans(r.item, "in", function(...)
      -- function num : 0_3_0_1 , upvalues : i, enableClose
      if i == 4 then
        enableClose = true
      end
    end
)
  end
)
      end
    end
  else
    do
      -- DECOMPILER ERROR at PC21: Confused about usage of register: R2 in 'UnsetPending'

      ;
      ((rewards[1]).item).visible = true
      ;
      (LotteryRewardWindow.SetItemInfo)((rewards[1]).item, (rewards[1]).info)
      PlayUITrans((rewards[1]).item, "in", function(...)
    -- function num : 0_3_1 , upvalues : enableClose
    enableClose = true
  end
)
    end
  end
end

LotteryRewardWindow.OnClose = function(...)
  -- function num : 0_4 , upvalues : uis, contentPane, _ENV, rewards, enableClose
  uis = nil
  contentPane = nil
  UIMgr:SendWindowMessage("LotteryWindow", (WindowMsgEnum.Lottery).E_MSG_LOTTERY_REWARDCLOSE, {})
  rewards = {}
  enableClose = false
end

LotteryRewardWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_5
end

return LotteryRewardWindow

