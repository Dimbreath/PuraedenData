-- params : ...
-- function num : 0 , upvalues : _ENV
require("Arena_RankingWindowByName")
local ArenaRankWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
ArenaRankWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, ArenaRankWindow
  bridgeObj:SetView((WinResConfig.ArenaRankWindow).package, (WinResConfig.ArenaRankWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  contentPane:Center()
  uis = GetArena_RankingWindowUis(contentPane)
  uis = uis.Ranking
  ;
  (ArenaRankWindow.InitText)()
  uis.RankingTxt = uis.NowRankingTxt
  ;
  (ArenaRankWindow.InitVariable)()
  ;
  (ArenaRankWindow.InitButtonEvent)()
end

ArenaRankWindow.InitVariable = function(...)
  -- function num : 0_1 , upvalues : uis, ArenaRankWindow
  (uis.BattleInformationList):SetVirtual()
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.BattleInformationList).itemRenderer = ArenaRankWindow.RefreshRankItem
  ;
  (uis.BattleInformationList):SetBeginAnim()
end

ArenaRankWindow.InitText = function(...)
  -- function num : 0_2 , upvalues : uis, _ENV
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  (uis.ButtonBtn).text = (PUtil.get)(30)
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.RankingTxt).text = (PUtil.get)(60000472)
end

ArenaRankWindow.InitButtonEvent = function(...)
  -- function num : 0_3 , upvalues : uis, ArenaRankWindow
  ((uis.ButtonBtn).onClick):Add(ArenaRankWindow.ClickCloseBtn)
  ;
  ((uis.CloseBtn).onClick):Add(ArenaRankWindow.ClickCloseBtn)
end

ArenaRankWindow.InitEvent = function(...)
  -- function num : 0_4
end

ArenaRankWindow.RemoveEvent = function(...)
  -- function num : 0_5
end

ArenaRankWindow.OnShown = function(...)
  -- function num : 0_6 , upvalues : ArenaRankWindow
  (ArenaRankWindow.InitEvent)()
  ;
  (ArenaRankWindow.Init)()
end

ArenaRankWindow.OnHide = function(...)
  -- function num : 0_7 , upvalues : ArenaRankWindow
  (ArenaRankWindow.RemoveEvent)()
end

ArenaRankWindow.Init = function(...)
  -- function num : 0_8 , upvalues : ArenaRankWindow, uis, _ENV
  (ArenaRankWindow.InitSelfInfo)()
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.BattleInformationList).numItems = #ArenaData.RankData
end

ArenaRankWindow.InitSelfInfo = function(...)
  -- function num : 0_9 , upvalues : _ENV, ArenaRankWindow, uis
  if ArenaData.BestRank == 0 then
    (ArenaRankWindow.SetTitleStatue)(false)
  else
    ;
    (ArenaRankWindow.SetTitleStatue)(true)
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (uis.MaxRankingTxt).text = (PUtil.get)(60000024, ArenaData.BestRank)
  end
  local fashionShow = (ActorData.GetFashionShow)()
  local fashionId = (ActorData.GetFashionShow)()
  local fashionData = ((TableData.gTable).BaseFashionData)[fashionId]
  if fashionData.type == 3 then
    for k,v in pairs((TableData.gTable).BaseFashionData) do
      if v.card_id == fashionData.card_id and v.type == 2 then
        fashionData = v
        break
      end
    end
  end
  do
    local model = (Util.ShowUIModel)(fashionData.show_texture, (uis.RankCardLoaderPic).CardShowLoader)
    ;
    (Util.UpdateShowTextureByConfig)(model, fashionData)
    ;
    (ArenaMgr.SetRank)((ArenaData.BaseData).rank, uis)
    -- DECOMPILER ERROR at PC71: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (uis.NameTxt).text = (ActorData.GetNickName)()
    -- DECOMPILER ERROR at PC76: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (uis.BattleNumberTxt).text = (ActorData.GetFc)()
    local title = (ActorData.GetWearTitle)()
    -- DECOMPILER ERROR at PC84: Confused about usage of register: R5 in 'UnsetPending'

    if title == 0 then
      ((uis.TitlePic).PicLoader).url = nil
    else
      -- DECOMPILER ERROR at PC96: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((uis.TitlePic).PicLoader).url = (Util.GetItemUrl)((((TableData.gTable).BasePlayerTitleData)[title]).icon)
    end
  end
end

ArenaRankWindow.SetTitleStatue = function(show, ...)
  -- function num : 0_10 , upvalues : uis
  ((uis.root):GetChild("MaxGrp")).visible = show
end

ArenaRankWindow.RecyclePNG = function(...)
  -- function num : 0_11 , upvalues : _ENV, uis
  (Util.RecycleUIModel)((uis.RankCardLoaderPic).CardShowLoader)
end

ArenaRankWindow.RefreshRankItem = function(index, item, ...)
  -- function num : 0_12 , upvalues : _ENV
  local data = (ArenaData.RankData)[index + 1]
  if data.rank < 4 then
    (item:GetController("c1")).selectedIndex = data.rank - 1
  else
    ;
    (item:GetController("c1")).selectedIndex = 3
    ;
    (item:GetChild("Ranking_04_Txt")).text = data.rank
  end
  local titlePanel = item:GetChild("TitlePic")
  if data.title == 0 or data.title == nil then
    (titlePanel:GetChild("PicLoader")).url = nil
  else
    ;
    (titlePanel:GetChild("PicLoader")).url = (Util.GetItemUrl)((((TableData.gTable).BasePlayerTitleData)[data.title]).icon)
  end
  ;
  (item:GetChild("HeadLoader")).url = (Util.GetHeadIconByFashionId)(data.fashionHead, HeadIconType.ROUND)
  ;
  (item:GetChild("BattleTxt")).text = (PUtil.get)(60000235)
  ;
  (item:GetChild("LvNumTxt")).text = "Lv." .. data.level
  ;
  (item:GetChild("PlayerNameTxt")).text = data.name
  ;
  (item:GetChild("NumberTxt")).text = (ArenaData.GetFC)(data)
  local list = item:GetChild("CardHeadList")
  if data.isPlayer then
    (table.sort)(data.cardGroups, function(x, y, ...)
    -- function num : 0_12_0
    do return x.position < y.position end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  end
  list:RemoveChildrenToPool()
  local count = #data.cardGroups
  local subItem = nil
  for i = 1, count do
    subItem = list:AddItemFromPool()
    ;
    (Util.SetHeadFrame)(subItem, (data.cardGroups)[i], not data.isPlayer)
  end
end

ArenaRankWindow.OnClose = function(...)
  -- function num : 0_13 , upvalues : uis, contentPane
  uis = nil
  contentPane = nil
end

ArenaRankWindow.ClickCloseBtn = function(...)
  -- function num : 0_14 , upvalues : _ENV
  UIMgr:CloseWindow((WinResConfig.ArenaRankWindow).name)
end

ArenaRankWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_15
end

return ArenaRankWindow

