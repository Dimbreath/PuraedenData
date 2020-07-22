-- params : ...
-- function num : 0 , upvalues : _ENV
require("Shop_GiftWindowByName")
local ShopGiftWindow = {}
local GiftType = {Fresh6 = 0, Fresh68 = 1, Fresh128 = 2, EveryDayGift = 3, EveryWeekGift = 4, EveryMonthGift = 5, EveryDayGiftFree = 6, PicesGift = 7, DoubleGem = 8}
local uis, contentPane = nil, nil
local argTable = {}
local configData = nil
ShopGiftWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, configData, uis, ShopGiftWindow, GiftType
  bridgeObj:SetView((WinResConfig.ShopGiftWindow).package, (WinResConfig.ShopGiftWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  local productID = tonumber(argTable[1])
  configData = ((TableData.gTable).BasePayProductData)[productID]
  uis = GetShop_GiftWindowUis(contentPane)
  uis = uis.Gift
  -- DECOMPILER ERROR at PC28: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.ItemNameTxt).text = configData.product_name
  ;
  (ShopGiftWindow.SetBtnEvent)()
  -- DECOMPILER ERROR at PC33: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.c1Ctr).selectedIndex = configData.gift_type
  local remainTime = (PayData.GetProductRemainTimes)(productID)
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R3 in 'UnsetPending'

  if remainTime > 0 then
    (uis.c2Ctr).selectedIndex = 1
    local textNum = nil
    if configData.sell_limit_type == PayProductLimitType.DayLimit then
      textNum = 20000332
    else
      if configData.sell_limit_type == PayProductLimitType.WeekLimit then
        textNum = 20000333
      else
        if configData.sell_limit_type == PayProductLimitType.MouthLimit then
          textNum = 20000334
        else
          if configData.sell_limit_type == PayProductLimitType.ForeverLimit then
            textNum = 20000335
          end
        end
      end
    end
    -- DECOMPILER ERROR at PC78: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (uis.NumberTxt).text = (PUtil.get)(textNum, tostring(remainTime))
  else
    do
      -- DECOMPILER ERROR at PC81: Confused about usage of register: R3 in 'UnsetPending'

      ;
      (uis.c2Ctr).selectedIndex = 0
      if configData.gift_type ~= GiftType.EveryDayGiftFree then
        local list = uis["Reward_" .. configData.gift_type .. "_List"]
        -- DECOMPILER ERROR at PC92: Confused about usage of register: R4 in 'UnsetPending'

        ;
        (uis.c3Ctr).selectedIndex = 0
        local contain = list:GetChildAt(0)
        local count = contain.numChildren
        local effect, obj, item = nil, nil, nil
        for i = 0, count - 1 do
          item = contain:GetChildAt(i)
          effect = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_MONTHLYCARD_SMALL, true, true)
          item:AddChild(effect)
          effect:SetXY(item.width * 0.5, item.height * 0.5)
          ;
          (Util.SetSfxClipInList)(obj, list)
        end
      else
        do
          -- DECOMPILER ERROR at PC132: Confused about usage of register: R3 in 'UnsetPending'

          ;
          (uis.c3Ctr).selectedIndex = 1
          -- DECOMPILER ERROR at PC138: Confused about usage of register: R3 in 'UnsetPending'

          ;
          (uis.TipsTxt).text = (PUtil.get)(230)
          if configData.gift_type == GiftType.Fresh68 and configData.role_rewards then
            local role = split(configData.role_rewards, ":")
            local rewardCard = tonumber(role[1])
            local cardList = (CardData.GetObtainedCardList)()
            local possess = false
            -- DECOMPILER ERROR at PC157: Overwrote pending register: R7 in 'AssignReg'

            for _,v in obj(cardList) do
              if v.id == rewardCard then
                possess = true
                break
              end
            end
            do
              do
                if possess then
                  local com = ((uis.Reward_1_List):GetChildAt(0)):GetChild("n0")
                  ChangeUIController(com, "c1", 1)
                end
                -- DECOMPILER ERROR at PC187: Confused about usage of register: R3 in 'UnsetPending'

                ;
                (uis.TitleTxt).text = (PUtil.get)(20000378)
                local lod = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_MONTHLYCARD_HUGE, true, true)
                ;
                (uis.root):AddChild(lod)
                lod:SetXY((uis.Decorate_03_Image).x + (uis.Decorate_03_Image).width * 0.5, (uis.Decorate_03_Image).y + (uis.Decorate_03_Image).height * 0.5)
              end
            end
          end
        end
      end
    end
  end
end

ShopGiftWindow.SetBtnEvent = function(...)
  -- function num : 0_1 , upvalues : uis, _ENV, ShopGiftWindow, configData
  ((uis.CloseBtn).onClick):Set(function(...)
    -- function num : 0_1_0 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.ShopGiftWindow).name)
  end
)
  ;
  ((uis.SureBtn).onClick):Set(function(...)
    -- function num : 0_1_1 , upvalues : ShopGiftWindow, _ENV, configData
    if (ShopGiftWindow.CheckLv)() then
      (PayMgr.SendPayCheck)(configData.id)
    end
  end
)
  -- DECOMPILER ERROR at PC15: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.SureBtn).text = (PUtil.get)(20000324)
end

ShopGiftWindow.CheckLv = function(...)
  -- function num : 0_2 , upvalues : _ENV, configData
  local lv = (ActorData.GetLevel)()
  local strLV = configData.sell_level
  local rangeLV = split(strLV, ":")
  if tonumber(rangeLV[1]) <= lv and lv <= tonumber(rangeLV[2]) then
    return true
  end
  ;
  (MessageMgr.SendCenterTips)((PUtil.get)(20000493, tonumber(rangeLV[1])))
  return false
end

ShopGiftWindow.OnShown = function(...)
  -- function num : 0_3
end

ShopGiftWindow.OnHide = function(...)
  -- function num : 0_4
end

ShopGiftWindow.OnClose = function(...)
  -- function num : 0_5 , upvalues : uis, contentPane, argTable
  uis = nil
  contentPane = nil
  argTable = {}
end

ShopGiftWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_6
end

return ShopGiftWindow

