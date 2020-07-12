-- params : ...
-- function num : 0 , upvalues : _ENV
AssetShopMgr = {}
local self = AssetShopMgr
-- DECOMPILER ERROR at PC5: Confused about usage of register: R1 in 'UnsetPending'

AssetShopMgr.GoldBuyTimes = function(times, ...)
  -- function num : 0_0 , upvalues : self
  if times == nil then
    return self.GoldTimes
  else
    self.GoldTimes = times
  end
end

-- DECOMPILER ERROR at PC8: Confused about usage of register: R1 in 'UnsetPending'

AssetShopMgr.PhysicalBuyTimes = function(times, ...)
  -- function num : 0_1 , upvalues : self
  if times == nil then
    return self.PhysicalTimes
  else
    self.PhysicalTimes = times
  end
end

-- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

AssetShopMgr.StaBuyTimes = function(times, ...)
  -- function num : 0_2 , upvalues : self
  if times == nil then
    return self.StaTimes
  else
    self.StaTimes = times
  end
end

-- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

AssetShopMgr.EnergyBuyTimes = function(times, ...)
  -- function num : 0_3 , upvalues : self
  if times == nil then
    return self.EnergyTimes
  else
    self.EnergyTimes = times
  end
end

-- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

AssetShopMgr.GetAssetBuyTimeByID = function(assetID, ...)
  -- function num : 0_4 , upvalues : _ENV, self
  if assetID == AssetType.GOLD then
    return self.GoldTimes
  else
    if assetID == AssetType.PHYSICAL then
      return self.PhysicalTimes
    else
      if assetID == AssetType.ENDURANCE then
        return self.StaTimes
      else
        if assetID == AssetType.SPIRIT then
          return self.EnergyTimes
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

AssetShopMgr.GetAssetTypeByID = function(assetID, ...)
  -- function num : 0_5 , upvalues : _ENV
  if assetID == AssetType.GOLD then
    return BuyTimesType.PurchaseGold
  else
    if assetID == AssetType.PHYSICAL then
      return BuyTimesType.PurchasePhysical
    else
      if assetID == AssetType.ENDURANCE then
        return BuyTimesType.PurchaseEndurance
      else
        if assetID == AssetType.SPIRIT then
          return BuyTimesType.PurchaseSprite
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC23: Confused about usage of register: R1 in 'UnsetPending'

AssetShopMgr.GetPropAssetTypeByID = function(assetID, ...)
  -- function num : 0_6 , upvalues : _ENV
  if assetID == AssetType.GOLD then
    return (ProtoEnum.BUY_ASSIST_TYPE).GOLD_BUY_TIME_TYPE
  else
    if assetID == AssetType.PHYSICAL then
      return (ProtoEnum.BUY_ASSIST_TYPE).VIT_BUY_TIME_TYPE
    else
      if assetID == AssetType.ENDURANCE then
        return (ProtoEnum.BUY_ASSIST_TYPE).STA_BUY_TIME_TYPE
      else
        if assetID == AssetType.SPIRIT then
          return (ProtoEnum.BUY_ASSIST_TYPE).ENERGY_BUY_TIME_TYPE
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC26: Confused about usage of register: R1 in 'UnsetPending'

AssetShopMgr.GetMaxTimes = function(type, ...)
  -- function num : 0_7 , upvalues : _ENV
  local buyTimes = (TableData.gTable).BaseBuyTimeData
  local maxTimes = 0
  for _,v in pairs(buyTimes) do
    if v.type == type then
      maxTimes = (math.max)(maxTimes, v.finish)
    end
  end
  return maxTimes
end


