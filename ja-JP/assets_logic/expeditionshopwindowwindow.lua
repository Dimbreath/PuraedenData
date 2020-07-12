-- params : ...
-- function num : 0 , upvalues : _ENV
require("Expedition_ExpeditionShopWindowByName")
require("Expedition_ItemBuyByName")
local ExpeditionShopWindowWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local stageSortNum = 0
ExpeditionShopWindowWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, ExpeditionShopWindowWindow, stageSortNum
  bridgeObj:SetView((WinResConfig.ExpeditionShopWindowWindow).package, (WinResConfig.ExpeditionShopWindowWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetExpedition_ExpeditionShopWindowUis(contentPane)
  uis = uis.ExpeditionShop
  local ShopStage = (ExpeditionMgr.GetExternalShop)()
  local count = #ShopStage
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (uis.c1Ctr).selectedIndex = count - 1
  ;
  (ExpeditionShopWindowWindow.InitEvent)()
  local eId = (ExpeditionMgr.GetCurrentExpeditionId)()
  stageSortNum = (ExpeditionMgr.GetExpeditionNum)(eId)
  ;
  (ExpeditionShopWindowWindow.RefreshShopList)()
end

ExpeditionShopWindowWindow.RefreshShopList = function(...)
  -- function num : 0_1 , upvalues : _ENV, uis, ExpeditionShopWindowWindow
  local ShopStage = (ExpeditionMgr.GetExternalShop)()
  local count = #ShopStage
  local max = (math.min)(2, count)
  for i = 1, max do
    local obj = (uis.root):GetChild("Tips_0" .. i)
    ;
    (ExpeditionShopWindowWindow.SetSingleShop)(obj, ShopStage[i])
  end
end

ExpeditionShopWindowWindow.SetSingleShop = function(obj, stageID, ...)
  -- function num : 0_2 , upvalues : _ENV, stageSortNum, ExpeditionShopWindowWindow
  local dataList = (ExpeditionMgr.GetSpecialMerchantData)(stageID)
  local stageNum = (ExpeditionMgr.GetStageNum)(stageID)
  ;
  (obj:GetChild("NameTxt")).text = stageSortNum .. "-" .. stageNum .. " " .. (PUtil.get)(20000319)
  for i = 1, 2 do
    local data = dataList[i]
    local configData = (ExpeditionMgr.GetShopDataConfig)(data.shopType, data.buyNum)
    if configData then
      local shopData = {}
      shopData.supTime = data.totalNum - data.buyNum
      shopData.data = configData
      shopData.stageID = stageID
      local item = obj:GetChild("Item_0" .. i)
      ;
      (ExpeditionShopWindowWindow.SetShopGrid)(item, shopData)
    end
  end
end

ExpeditionShopWindowWindow.SetShopGrid = function(item, shopData, ...)
  -- function num : 0_3 , upvalues : _ENV
  local model = GetExpedition_ItemBuyUis(item)
  local supTime = shopData.supTime
  local configData = shopData.data
  local configItem = split(configData.reward, ":")
  local itemData, DataType = (Util.GetConfigDataByID)(configItem[2])
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (model.IconLoader).url = (Util.GetItemUrl)(itemData.icon)
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R8 in 'UnsetPending'

  ;
  (model.Word_01_Txt).text = itemData.name
  local shopNum = tonumber(configItem[3]) or 1
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R9 in 'UnsetPending'

  ;
  (model.IconNumberTxt).text = shopNum
  ;
  (Util.SetConsumption)(configData.cost, model.SpendLoader, model.SpendNumberTxt)
  local consumeConfigs = split(configData.cost, ":")
  -- DECOMPILER ERROR at PC46: Confused about usage of register: R10 in 'UnsetPending'

  if tonumber(consumeConfigs[3]) == 0 then
    (model.c1Ctr).selectedIndex = 1
  else
    -- DECOMPILER ERROR at PC49: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (model.c1Ctr).selectedIndex = 0
  end
  -- DECOMPILER ERROR at PC56: Confused about usage of register: R10 in 'UnsetPending'

  ;
  (model.BuyNumberTxt).text = (PUtil.get)(20000320, supTime)
  -- DECOMPILER ERROR at PC60: Confused about usage of register: R10 in 'UnsetPending'

  if supTime > 0 then
    (model.c2Ctr).selectedIndex = 0
  else
    -- DECOMPILER ERROR at PC63: Confused about usage of register: R10 in 'UnsetPending'

    ;
    (model.c2Ctr).selectedIndex = 1
  end
  -- DECOMPILER ERROR at PC69: Confused about usage of register: R10 in 'UnsetPending'

  ;
  (model.BuyBtn).text = (PUtil.get)(20000079)
  -- DECOMPILER ERROR at PC75: Confused about usage of register: R10 in 'UnsetPending'

  ;
  (model.BuyBtn).grayed = supTime == 0
  -- DECOMPILER ERROR at PC81: Confused about usage of register: R10 in 'UnsetPending'

  ;
  (model.BuyBtn).touchable = supTime > 0
  ;
  ((model.BuyBtn).onClick):Set(function(...)
    -- function num : 0_3_0 , upvalues : supTime, _ENV, configData, shopData
    if supTime > 0 and (Util.CheckCostResources)(configData.cost) then
      (ExpeditionService.OnReqBuyExpedition)(shopData.stageID, configData.id)
    end
    ;
    (MessageMgr.SendCenterTips)((PUtil.get)(20000124))
  end
)
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

ExpeditionShopWindowWindow.InitEvent = function(...)
  -- function num : 0_4 , upvalues : uis, _ENV
  ((uis.SureBtn).onClick):Set(function(...)
    -- function num : 0_4_0 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.ExpeditionShopWindowWindow).name)
  end
)
  -- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.SureBtn).text = (PUtil.get)(20000016)
  ;
  ((uis.CloseBtn).onClick):Set(function(...)
    -- function num : 0_4_1 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.ExpeditionShopWindowWindow).name)
  end
)
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.TitleTxt).text = (PUtil.get)(20000319)
end

ExpeditionShopWindowWindow.OnShown = function(...)
  -- function num : 0_5
end

ExpeditionShopWindowWindow.OnHide = function(...)
  -- function num : 0_6
end

ExpeditionShopWindowWindow.OnClose = function(...)
  -- function num : 0_7 , upvalues : uis, contentPane, argTable
  uis = nil
  contentPane = nil
  argTable = {}
end

ExpeditionShopWindowWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_8 , upvalues : _ENV, ExpeditionShopWindowWindow
  if msgId == (WindowMsgEnum.ExpeditionEventWindow).REFRESH_SHOP_LIST then
    (ExpeditionShopWindowWindow.RefreshShopList)()
  end
end

return ExpeditionShopWindowWindow

