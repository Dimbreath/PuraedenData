-- params : ...
-- function num : 0 , upvalues : _ENV
require("Lottery_ProbabilityByName")
local LotteryProbabilityWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local lotteryShowId = nil
LotteryProbabilityWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, lotteryShowId, LotteryProbabilityWindow
  bridgeObj:SetView((WinResConfig.LotteryProbabilityWindow).package, (WinResConfig.LotteryProbabilityWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  contentPane:Center()
  uis = GetLottery_ProbabilityUis(contentPane)
  if argTable[1] then
    lotteryShowId = argTable[1]
  end
  local m = {}
  m.windowName = (WinResConfig.LotteryProbabilityWindow).name
  m.Tip = (PUtil.get)(188)
  m.model = uis.AssetStripGrp
  m.closeToWindow = (WinResConfig.HomeWindow).name
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.PHYSICAL}
  ;
  (CommonWinMgr.RegisterAssets)(m)
  -- DECOMPILER ERROR at PC57: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((uis.AssetStripGrp).CloseAssetGrp).visible = false
  ;
  (LotteryProbabilityWindow.RefreshWindow)()
end

LotteryProbabilityWindow.RefreshWindow = function(...)
  -- function num : 0_1 , upvalues : lotteryShowId, uis, _ENV
  if lotteryShowId == nil then
    return 
  end
  ;
  (uis.TipsList):RemoveChildrenToPool()
  local excelData = ((TableData.gTable).BaseLotteryShowData)[lotteryShowId]
  local details = split(excelData.content, "|")
  for index,value in ipairs(details) do
    local detail = split(value, ",")
    local tag = detail[1]
    local title = detail[2]
    local content = detail[3]
    local cardIds = nil
    if tag == "A" then
      cardIds = split(detail[4], ":")
      local item = (uis.TipsList):AddItemFromPool((UIPackage.GetItemURL)((WinResConfig.LotteryProbabilityWindow).package, "P_A"))
      ;
      (item:GetChild("WordTxt")).text = (PUtil.get)(tonumber(title))
      ;
      (item:GetChild("ProbabilityTxt")).text = (PUtil.get)(tonumber(content))
      local cardList = item:GetChild("CardList")
      cardList:RemoveChildrenToPool()
      for n,m in ipairs(cardIds) do
        local cardItem = cardList:AddItemFromPool()
        local cardId = tonumber(m)
        local cardData = ((TableData.gTable).BaseCardData)[cardId]
        ;
        (cardItem:GetController("c1")).selectedIndex = 0
        local starList = cardItem:GetChild("StarList")
        starList:RemoveChildrenToPool()
        for i = 1, cardData.star do
          starList:AddItemFromPool()
        end
        ;
        (cardItem:GetChild("NameTxt")).text = cardData.name
        if not cardData.fashionId then
          local fashionId = (((TableData.gTable).BaseCardQualityUpData)[tonumber(tostring(cardId) .. "00")]).unlock_fashion_id
        end
        ;
        (Util.SetSliverHeadIcon)(fashionId, (cardItem:GetChild("CardLoaderPic")):GetChild("CardLoader"))
      end
    else
      do
        do
          if tag == "B" then
            local item = (uis.TipsList):AddItemFromPool((UIPackage.GetItemURL)((WinResConfig.LotteryProbabilityWindow).package, "P_B"))
            ;
            (item:GetChild("WordTxt")).text = (PUtil.get)(tonumber(title))
            ;
            (item:GetChild("ProbabilityTxt")).text = (PUtil.get)(tonumber(content))
          end
          -- DECOMPILER ERROR at PC164: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC164: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC164: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
end

LotteryProbabilityWindow.SetCardTexture = function(fashionID, loader, ...)
  -- function num : 0_2 , upvalues : _ENV
  local fashionConfig = ((TableData.gTable).BaseFashionData)[fashionID]
  if not fashionConfig then
    loge(fashionID .. "fashionID" .. "未找到")
    loader.visible = false
    return 
  end
  loader.visible = true
  local textureObj = (Util.ShowUIModel)(fashionConfig.show_texture, loader)
  local scale = fashionConfig.settlement_texture_scale / 10000
  ;
  (CSLuaUtil.SetGOScale)(textureObj, scale, scale, scale)
  local positionTable = split(fashionConfig.settlement_texture_position, ":")
  ;
  (CSLuaUtil.SetGOLocalPos)(textureObj, tonumber(positionTable[1]), tonumber(positionTable[2]), 0)
end

LotteryProbabilityWindow.OnClose = function(...)
  -- function num : 0_3 , upvalues : _ENV, uis, contentPane, argTable, lotteryShowId
  (CommonWinMgr.RemoveAssets)((WinResConfig.LotteryProbabilityWindow).name)
  uis = nil
  contentPane = nil
  argTable = nil
  lotteryShowId = nil
end

return LotteryProbabilityWindow

