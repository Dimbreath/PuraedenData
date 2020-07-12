-- params : ...
-- function num : 0 , upvalues : _ENV
require("Card_SkillGetGrpByName")
SkillGetGrpWindow = {}
local uis = nil
local paraData = {}
local contentPane, argTable = nil, nil
-- DECOMPILER ERROR at PC10: Confused about usage of register: R4 in 'UnsetPending'

SkillGetGrpWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis
  bridgeObj:SetView((WinResConfig.SkillGetGrpWindow).package, (WinResConfig.SkillGetGrpWindow).comName)
  contentPane = bridgeObj.contentPane
  contentPane:Center()
  argTable = bridgeObj.argTable
  uis = GetCard_SkillGetGrpUis(contentPane)
  ;
  (LuaSound.PlaySound)(LuaSound.COMMON_SHOW_REWARD, SoundBank.OTHER)
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.TipsTxt).text = (PUtil.get)(33)
  ;
  ((uis.TouchScreenBtn).onClick):Add(function(...)
    -- function num : 0_0_0 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.SkillGetGrpWindow).name)
  end
)
  ;
  (Util.PlayUIEffect)(uis, contentPane, 1)
  ;
  (SkillGetGrpWindow.RefreshWindowData)()
  ;
  (GuideData.RegisterGuideAndControl)(ControlID.Talent_Sure, uis.TouchScreenBtn, (WinResConfig.SkillGetGrpWindow).name)
  local holder = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_UNLOCK_PANEL, true)
  holder:SetXY(((uis.ResultImageGrp).root).x + ((uis.ResultImageGrp).root).width * 0.5, ((uis.ResultImageGrp).root).y + ((uis.ResultImageGrp).root).height * 0.5)
  contentPane:AddChild(holder)
end

-- DECOMPILER ERROR at PC13: Confused about usage of register: R4 in 'UnsetPending'

SkillGetGrpWindow.RefreshWindowData = function(...)
  -- function num : 0_1 , upvalues : _ENV, paraData, uis
  local skillTable = (CardData.GetHowManySkillGetFromQ)()
  print("大家好这里是获得技能界面 我们现在播报的是这个技能    ", skillTable[1])
  if skillTable[1] == nil then
    UIMgr:CloseWindow((WinResConfig.SkillGetGrpWindow).name)
    return 
  end
  paraData = {}
  paraData = (TableData.GetBaseSkillData)(skillTable[1])
  -- DECOMPILER ERROR at PC30: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.SkillFrameGrp).SkillLoader).url = (Util.GetResUrl)(paraData.icon_path)
  local skillType = paraData.type
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R2 in 'UnsetPending'

  if skillType == 2 then
    ((uis.SkillFrameGrp).c1Ctr).selectedIndex = 2
  else
    -- DECOMPILER ERROR at PC42: Confused about usage of register: R2 in 'UnsetPending'

    if skillType == 3 then
      ((uis.SkillFrameGrp).c1Ctr).selectedIndex = 1
    else
      -- DECOMPILER ERROR at PC48: Confused about usage of register: R2 in 'UnsetPending'

      if skillType == 5 then
        ((uis.SkillFrameGrp).c1Ctr).selectedIndex = 0
      end
    end
  end
  ;
  (CardData.SubHowManySkillGetFromQ)()
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R4 in 'UnsetPending'

SkillGetGrpWindow.OnClose = function(...)
  -- function num : 0_2 , upvalues : _ENV, argTable, uis, paraData, contentPane
  local fashionTable = (CardData.GetHowManyFashionGetFromQ)()
  local skillTable = (CardData.GetHowManySkillGetFromQ)()
  if #skillTable > 0 then
    OpenWindow("SkillGetGrpWindow", UILayer.HUD, argTable[1])
  else
  end
  if #fashionTable > 0 then
    (CommonWinMgr.OpenCommonFcUp)(argTable[1])
    UIMgr:SendWindowMessage("CardWindow", (WindowMsgEnum.CardWindow).E_MSG_CARD_STARUP_TRUE, {})
    uis = nil
    paraData = nil
    contentPane = nil
    ;
    (GuideData.AbolishControlRefer)((WinResConfig.SkillGetGrpWindow).name)
  end
end

-- DECOMPILER ERROR at PC19: Confused about usage of register: R4 in 'UnsetPending'

SkillGetGrpWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_3 , upvalues : _ENV
  local windowMsgEnum = WindowMsgEnum.CardWindow
  if msgId == windowMsgEnum.E_MSG_CARD_SKILLGET then
  end
end

return SkillGetGrpWindow

