-- params : ...
-- function num : 0 , upvalues : _ENV
require("ActorInfo_ActorInfoByName")
require("ActorInfoData")
require("ActorInfoService")
require("GuildService")
local ActorInfoWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local MAXLEVEL = 70
ActorInfoWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, ActorInfoWindow
  bridgeObj:SetView((WinResConfig.ActorInfoWindow).package, (WinResConfig.ActorInfoWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetActorInfo_ActorInfoUis(contentPane)
  ;
  (ActorInfoWindow.BasicInfoSet)()
  ;
  (ActorInfoWindow.RefreshWindow)()
  ;
  (ActorInfoWindow.BindingUI)()
end

ActorInfoWindow.BindingUI = function(...)
  -- function num : 0_1 , upvalues : _ENV, uis
  local winName = (WinResConfig.ActorInfoWindow).name
  local BindingUI = RedDotMgr.BindingUI
  local RedDotComID = RedDotComID
  local TitlePic = ((uis.InfoAssemblyGrp).root):GetChild("TitlePic")
  BindingUI(winName, RedDotComID.Setting_Title, TitlePic)
  ;
  (RedDotMgr.RefreshTreeUI)(winName)
end

ActorInfoWindow.BasicInfoSet = function(...)
  -- function num : 0_2 , upvalues : _ENV, uis
  local m = {}
  m.windowName = (WinResConfig.ActorInfoWindow).name
  m.Tip = (PUtil.get)(107)
  m.model = uis.AssetStripGrp
  m.closeToWindow = (WinResConfig.HomeWindow).name
  m.moneyTypes = {AssetType.DIAMOND_BIND, AssetType.DIAMOND, AssetType.GOLD, AssetType.PHYSICAL}
  ;
  (CommonWinMgr.RegisterAssets)(m)
  ;
  ((((uis.InfoAssemblyGrp).ActorHeadGrp).HeadBtn).onClick):Add(function(...)
    -- function num : 0_2_0 , upvalues : _ENV
    OpenWindow((WinResConfig.HeadChoiceWindow).name, UILayer.HUD)
  end
)
  ;
  (((uis.InfoAssemblyGrp).CopyBtn):GetChild("title")).text = (PUtil.get)(112)
  ;
  (((uis.InfoAssemblyGrp).CopyBtn).onClick):Add(function(...)
    -- function num : 0_2_1 , upvalues : _ENV
    ((CS.UniClipboard).SetText)(tostring((ActorData.GetPlayerIndex)()))
    ;
    (MessageMgr.SendCenterTips)((PUtil.get)(128))
  end
)
  ;
  (((uis.InfoAssemblyGrp).RechargeBtn).onClick):Add(function(...)
    -- function num : 0_2_2 , upvalues : _ENV
    if (FunctionControlMgr.GetFunctionState)(ControlID.AssetShop_Diamond, true) then
      ld("Shop")
      ;
      (ShopMgr.ExternalGotoShop)(ShopType.Recharge)
    end
  end
)
  ;
  (((uis.InfoAssemblyGrp).NoticeBtn).onClick):Add(function(...)
    -- function num : 0_2_3 , upvalues : _ENV
    print("公告按钮")
    ld("Announcement", function(...)
      -- function num : 0_2_3_0 , upvalues : _ENV
      (AnnouncementMgr.OpenAnnouncement)()
    end
)
  end
)
  ;
  ((((uis.InfoAssemblyGrp).root):GetChild("ServiceBtn")).onClick):Set(function(...)
    -- function num : 0_2_4 , upvalues : _ENV
    print("客服")
    if Game.useSDK == true then
      (SuperSDKUtil.OpenCustomServer)()
    end
  end
)
  ;
  (((uis.InfoAssemblyGrp).SetBtn).onClick):Add(function(...)
    -- function num : 0_2_5 , upvalues : _ENV
    print("设置按钮")
    OpenWindow((WinResConfig.SystemSetWindow).name, UILayer.HUD, SystemSetType.NonBattle)
  end
)
  ;
  (((uis.InfoAssemblyGrp).OutBtn).onClick):Add(function(...)
    -- function num : 0_2_6 , upvalues : _ENV
    print("退出登录按钮")
    if Game.useSDK == true then
      (SuperSDKUtil.Logout)()
    else
      ;
      (MessageMgr.OpenConfirmWindow)((PUtil.get)(119), function(...)
      -- function num : 0_2_6_0 , upvalues : _ENV
      (LoginService.ReqLogout)()
    end
, nil, (PUtil.get)(120))
    end
  end
)
  local txt = ((uis.InfoAssemblyGrp).ActorIntroduceGrp).ActorIntroduceTxt
  ;
  (txt.onFocusOut):Set(function(...)
    -- function num : 0_2_7 , upvalues : _ENV, txt
    if (Util.StringIsNullOrEmpty)(txt.text) == false then
      (ActorInfoService.ReqSet)(3, txt.text)
    end
  end
)
  local lastText = (((uis.InfoAssemblyGrp).ActorIntroduceGrp).ActorIntroduceTxt).text
  ;
  (txt.onChanged):Set(function(...)
    -- function num : 0_2_8 , upvalues : txt, lastText, uis
    if txt.textHeight > 74 then
      txt.text = lastText
    else
      lastText = (((uis.InfoAssemblyGrp).ActorIntroduceGrp).ActorIntroduceTxt).text
    end
  end
)
  ;
  (((uis.InfoAssemblyGrp).ModifyNameBtn).onClick):Add(function(...)
    -- function num : 0_2_9 , upvalues : _ENV
    OpenWindow((WinResConfig.RenameWindow).name, UILayer.HUD)
  end
)
  ;
  (Util.RecycleUIModel)(uis.PictureLoader)
  local fashionShow = (ActorData.GetFashionShow)()
  ;
  (Util.CreateShowModel)(fashionShow, uis.PictureLoader)
end

ActorInfoWindow.RefreshWindow = function(...)
  -- function num : 0_3 , upvalues : uis, _ENV, ActorInfoWindow, MAXLEVEL
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.InfoAssemblyGrp).ActorNameTxt).text = (ActorData.GetNickName)()
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

  ;
  ((uis.InfoAssemblyGrp).LevelTxt).text = (ActorData.GetLevel)()
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (((uis.InfoAssemblyGrp).ActorIntroduceGrp).ActorIntroduceTxt).text = (ActorData.GetSignature)()
  local headLoader = ((uis.InfoAssemblyGrp).ActorHeadGrp).ActorHeadLoader
  local fashionHead = (ActorData.GetFashionHead)()
  do
    if headLoader and fashionHead then
      local fashionConfig = ((TableData.gTable).BasePlayerHeadIconData)[fashionHead]
      if fashionConfig then
        headLoader.url = (Util.GetResUrl)(fashionConfig.icon_path)
      end
    end
    -- DECOMPILER ERROR at PC46: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((uis.InfoAssemblyGrp).Guild_01_Txt).text = (PUtil.get)(108)
    -- DECOMPILER ERROR at PC53: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((uis.InfoAssemblyGrp).BattleNumber_01_Txt).text = (PUtil.get)(60000235)
    -- DECOMPILER ERROR at PC58: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((uis.InfoAssemblyGrp).BattleNumber_02_Txt).text = (ActorInfoWindow.GetTopSixHeroFc)()
    -- DECOMPILER ERROR at PC65: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((uis.InfoAssemblyGrp).PlayerIDTxt).text = (PUtil.get)(111)
    -- DECOMPILER ERROR at PC71: Confused about usage of register: R2 in 'UnsetPending'

    ;
    ((uis.InfoAssemblyGrp).PlayerIDNumberTxt).text = (ActorData.GetPlayerIndex)()
    local plyerLvl = (ActorData.GetLevel)()
    local curExp = (ActorData.GetExp)()
    local nextExp = (ActorData.GetNextExp)()
    local percent = curExp / nextExp
    -- DECOMPILER ERROR at PC85: Confused about usage of register: R6 in 'UnsetPending'

    ;
    ((uis.InfoAssemblyGrp).ExpProgressBar).value = percent * 100
    -- DECOMPILER ERROR at PC97: Confused about usage of register: R6 in 'UnsetPending'

    if MAXLEVEL <= plyerLvl then
      if nextExp <= curExp then
        ((uis.InfoAssemblyGrp).ExpNumberTxt).text = (PUtil.get)(20000048)
      else
        -- DECOMPILER ERROR at PC105: Confused about usage of register: R6 in 'UnsetPending'

        ;
        ((uis.InfoAssemblyGrp).ExpNumberTxt).text = curExp .. "/" .. nextExp
      end
    else
      -- DECOMPILER ERROR at PC113: Confused about usage of register: R6 in 'UnsetPending'

      ;
      ((uis.InfoAssemblyGrp).ExpNumberTxt).text = curExp .. "/" .. nextExp
    end
    ;
    (ActorInfoWindow.InitUIEffect)()
  end
end

ActorInfoWindow.InitUIEffect = function(...)
  -- function num : 0_4 , upvalues : _ENV, uis, contentPane
  local holder = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_PLAYER_INFO_EFFECT, false, true)
  holder:SetXY(((uis.InfoAssemblyGrp).root).width / 2, ((uis.InfoAssemblyGrp).root).height / 2)
  contentPane:AddChild(holder)
  contentPane:SetChildIndex(holder, contentPane:GetChildIndex((uis.InfoAssemblyGrp).root))
end

ActorInfoWindow.OnShown = function(...)
  -- function num : 0_5 , upvalues : _ENV, uis
  if (ActorData.GetGuildID)() ~= 0 then
    (GuildService.ReqGuildSummary)()
  else
    -- DECOMPILER ERROR at PC15: Confused about usage of register: R0 in 'UnsetPending'

    ;
    ((uis.InfoAssemblyGrp).Guild_02_Txt).text = (PUtil.get)(60000379)
  end
  local TitlePic = ((uis.InfoAssemblyGrp).root):GetChild("TitlePic")
  local titleID = (ActorData.GetWearTitle)()
  if titleID > 0 then
    ChangeUIController(TitlePic, "c1", 0)
    local configData = ((TableData.gTable).BasePlayerTitleData)[titleID]
    ;
    (TitlePic:GetChild("PicLoader")).url = (Util.GetItemUrl)(configData.icon)
  else
    do
      ChangeUIController(TitlePic, "c1", 2)
      ;
      (TitlePic.onClick):Set(function(...)
    -- function num : 0_5_0 , upvalues : _ENV
    OpenWindow((WinResConfig.TitleWindow).name, UILayer.HUD)
  end
)
      local TitlePic = ((uis.InfoAssemblyGrp).root):GetChild("TitlePic")
      ;
      (GuideData.RegisterGuideAndControl)(ControlID.Setting_Title, TitlePic, (WinResConfig.ActorInfoWindow).name)
    end
  end
end

ActorInfoWindow.OnHide = function(...)
  -- function num : 0_6
end

ActorInfoWindow.OnClose = function(...)
  -- function num : 0_7 , upvalues : _ENV, uis, contentPane, argTable
  (CommonWinMgr.RemoveAssets)((WinResConfig.ActorInfoWindow).name)
  ;
  (Util.RecycleUIModel)(uis.PictureLoader)
  uis = nil
  contentPane = nil
  argTable = {}
end

ActorInfoWindow.GetTopSixHeroFc = function(...)
  -- function num : 0_8 , upvalues : _ENV
  local ownCards = (CardData.GetObtainedCardList)()
  local totalFc = 0
  ;
  (table.sort)(ownCards, function(a, b, ...)
    -- function num : 0_8_0
    if a.fc == b.fc then
      if a.star == b.star then
        if a.level == b.level then
          if a.quality == b.quality then
            return false
          else
            return b.quality < a.quality
          end
        else
          return b.level < a.level
        end
      else
        return b.star < a.star
      end
    else
      return b.fc < a.fc
    end
    -- DECOMPILER ERROR: 8 unprocessed JMP targets
  end
)
  for i = 1, 6 do
    if ownCards[i] ~= nil then
      totalFc = totalFc + (ownCards[i]).fc
    else
      break
    end
  end
  do
    return totalFc
  end
end

ActorInfoWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_9 , upvalues : _ENV, ActorInfoWindow, uis
  local windowMsgEnum = WindowMsgEnum.ActorInfo
  if msgId == windowMsgEnum.E_MSG_SETFASHIONHEAD then
    (ActorInfoWindow.RefreshWindow)()
  else
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R3 in 'UnsetPending'

    if msgId == windowMsgEnum.E_MSG_SET_NEW_NICKNAME then
      ((uis.InfoAssemblyGrp).ActorNameTxt).text = (ActorData.GetNickName)()
    else
      -- DECOMPILER ERROR at PC25: Confused about usage of register: R3 in 'UnsetPending'

      if msgId == (WindowMsgEnum.Guild).E_MSG_REFRESH_GUILD_NAME then
        ((uis.InfoAssemblyGrp).Guild_02_Txt).text = para
      end
    end
  end
end

ActorInfoWindow.OnClickBackButton = function(...)
  -- function num : 0_10 , upvalues : _ENV
  UIMgr:CloseWindow("ActorInfoWindow")
end

return ActorInfoWindow

