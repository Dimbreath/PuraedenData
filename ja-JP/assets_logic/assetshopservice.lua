-- params : ...
-- function num : 0 , upvalues : _ENV
AssetShopService = {}
-- DECOMPILER ERROR at PC4: Confused about usage of register: R0 in 'UnsetPending'

AssetShopService.Init = function(...)
  -- function num : 0_0 , upvalues : _ENV
  (Net.AddListener)((Proto.MsgName).ResGetBuyAssistNum, AssetShopService.OnResGetBuyAssistNum)
  ;
  (Net.AddListener)((Proto.MsgName).ResBuyAssist, AssetShopService.OnResBuyAssist)
end

-- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

AssetShopService.ReqGetBuyAssistNum = function(type, ...)
  -- function num : 0_1 , upvalues : _ENV
  local m = {}
  m.type = type
  ;
  (Net.Send)((Proto.MsgName).ReqGetBuyAssistNum, m, (Proto.MsgName).ResGetBuyAssistNum)
end

-- DECOMPILER ERROR at PC10: Confused about usage of register: R0 in 'UnsetPending'

AssetShopService.OnResGetBuyAssistNum = function(msg, ...)
  -- function num : 0_2 , upvalues : _ENV
  (AssetShopService.SetInformation)(msg.type, msg.buyAssistNum)
  if msg.type == (ProtoEnum.BUY_ASSIST_TYPE).GOLD_BUY_TIME_TYPE then
    OpenWindow((WinResConfig.AssetBuyWindow).name, UILayer.HUD, AssetType.GOLD)
  else
    if msg.type == (ProtoEnum.BUY_ASSIST_TYPE).VIT_BUY_TIME_TYPE then
      OpenWindow((WinResConfig.AssetBuyWindow).name, UILayer.HUD, AssetType.PHYSICAL)
    else
      if msg.type == (ProtoEnum.BUY_ASSIST_TYPE).STA_BUY_TIME_TYPE then
        OpenWindow((WinResConfig.AssetBuyWindow).name, UILayer.HUD, AssetType.ENDURANCE)
      else
        if msg.type == (ProtoEnum.BUY_ASSIST_TYPE).ENERGY_BUY_TIME_TYPE then
          OpenWindow((WinResConfig.AssetBuyWindow).name, UILayer.HUD, AssetType.SPIRIT)
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC13: Confused about usage of register: R0 in 'UnsetPending'

AssetShopService.ReqBuyAssist = function(type, time, ...)
  -- function num : 0_3 , upvalues : _ENV
  local m = {}
  m.type = type
  m.buyNum = time
  ;
  (Net.Send)((Proto.MsgName).ReqBuyAssist, m, (Proto.MsgName).ResBuyAssist)
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

AssetShopService.OnResBuyAssist = function(msg, ...)
  -- function num : 0_4 , upvalues : _ENV
  (AssetShopService.SetInformation)(msg.type, msg.buyAssistNum)
  ;
  (MessageMgr.OpenItemBuyTipsWindowByGoodsObj)(msg.assist)
  UIMgr:CloseWindow((WinResConfig.AssetBuyWindow).name)
end

-- DECOMPILER ERROR at PC19: Confused about usage of register: R0 in 'UnsetPending'

AssetShopService.SetInformation = function(type, buyAssistNum, ...)
  -- function num : 0_5 , upvalues : _ENV
  if type == (ProtoEnum.BUY_ASSIST_TYPE).GOLD_BUY_TIME_TYPE then
    (AssetShopMgr.GoldBuyTimes)(buyAssistNum)
  else
    if type == (ProtoEnum.BUY_ASSIST_TYPE).VIT_BUY_TIME_TYPE then
      (AssetShopMgr.PhysicalBuyTimes)(buyAssistNum)
    else
      if type == (ProtoEnum.BUY_ASSIST_TYPE).STA_BUY_TIME_TYPE then
        (AssetShopMgr.StaBuyTimes)(buyAssistNum)
      else
        if type == (ProtoEnum.BUY_ASSIST_TYPE).ENERGY_BUY_TIME_TYPE then
          (AssetShopMgr.EnergyBuyTimes)(buyAssistNum)
        end
      end
    end
  end
end

;
(AssetShopService.Init)()

