-- params : ...
-- function num : 0 , upvalues : _ENV
require("Talent_StarUpByName")
require("Talent_StarUpWindowByName")
local TalentStarUpWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local sealId = 0
local curMatrixTree = 0
local curFaZhenId = 0
local index, bgEffect = nil, nil
TalentStarUpWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, sealId, curMatrixTree, curFaZhenId, index, bgEffect, TalentStarUpWindow
  bridgeObj:SetView((WinResConfig.TalentStarUpWindow).package, (WinResConfig.TalentStarUpWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetTalent_StarUpWindowUis(contentPane)
  sealId = argTable[1]
  curMatrixTree = argTable[2]
  curFaZhenId = argTable[3]
  index = argTable[4]
  ;
  (((uis.StarUp).CloseBtn).onClick):Add(function(...)
    -- function num : 0_0_0 , upvalues : bgEffect, _ENV
    if bgEffect ~= nil then
      (LuaEffect.DestroyEffect)(bgEffect)
      bgEffect = nil
    end
    UIMgr:CloseWindow((WinResConfig.TalentStarUpWindow).name)
  end
)
  -- DECOMPILER ERROR at PC36: Confused about usage of register: R1 in 'UnsetPending'

  ;
  ((uis.StarUp).TitleTxt).text = (PUtil.get)(130)
  ;
  (((uis.StarUp).SureBtn):GetChild("title")).text = (PUtil.get)(131)
  local holder = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_TALENT_MAIN_XUANZHONG)
  ;
  (((uis.StarUp).IdleEffect).root):AddChild(holder)
  holder:SetXY((((uis.StarUp).IdleEffect).root).width / 2, (((uis.StarUp).IdleEffect).root).height / 2)
  ;
  (TalentStarUpWindow.RefreshWindow)()
end

TalentStarUpWindow.RefreshWindow = function(...)
  -- function num : 0_1 , upvalues : _ENV, sealId, uis, bgEffect, index
  local data, icon, lvl = nil, nil, nil
  data = ((TableData.gTable).BaseMatrixSealData)[sealId]
  lvl = (PUtil.get)(53) .. data.level
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R3 in 'UnsetPending'

  if data.next_type ~= 0 then
    ((uis.StarUp).c1Ctr).selectedIndex = 1
  else
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((uis.StarUp).c1Ctr).selectedIndex = 0
  end
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((uis.StarUp).NameTxt).text = data.name
  -- DECOMPILER ERROR at PC32: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((uis.StarUp).IconLoader).url = (Util.GetItemUrl)(data.icon)
  if bgEffect == nil then
    bgEffect = (LuaEffect.CreateEffectToObj)("FX_ui_tianfu_erji_" .. tostring(index), false, ((uis.StarUp).IdleEffect).root, Vector2(25, 25))
  end
  -- DECOMPILER ERROR at PC60: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((uis.StarUp).LevelTxt).visible = data.level ~= 0
  -- DECOMPILER ERROR at PC63: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((uis.StarUp).LevelTxt).text = lvl
  local allAttrs = (TalentData.GetTalentTreeAllAttr)()
  local addAttrs = split(data.add_attr_show, ",")
  local attrList = (uis.StarUp).StarUpAttributeList
  attrList:RemoveChildrenToPool()
  for i,v in ipairs(allAttrs) do
    local item = nil
    local id = v.id
    local add = 0
    for n,m in ipairs(addAttrs) do
      local attr = split(m, ":")
      if tonumber(attr[2]) == id then
        add = tonumber(attr[3])
        item = attrList:AddItemFromPool()
        local attrData = ((TableData.gTable).BaseAttributeData)[tonumber(id)]
        ;
        (item:GetChild("NameTxt")).text = attrData.display_name
        if add > 0 then
          (item:GetController("c1")).selectedIndex = 0
          ;
          (item:GetChild("AfterTxt")).text = v.value + add
        else
          (item:GetController("c1")).selectedIndex = 1
        end
        ;
        (item:GetChild("NowTxt")).text = v.value
        break
      end
    end
  end
  local isCost1Enough = true
  local isCost2Enough = true
  local cost1, cost2 = nil, nil
  if data.next_type == 0 then
    local costData = ((TableData.gTable).BaseMatrixSealData)[sealId + 1]
    local costStr = split(costData.cost, ",")
    cost1 = tonumber((split(costStr[1], ":"))[2])
    cost2 = tonumber((split(costStr[2], ":"))[2])
    -- DECOMPILER ERROR at PC183: Confused about usage of register: R12 in 'UnsetPending'

    ;
    ((uis.StarUp).Spend_01_Loader).url = (Util.GetItemUrl)(((Util.GetConfigDataByID)(cost1)).icon)
    isCost1Enough = tonumber((split(costStr[1], ":"))[3]) <= (ActorData.GetPropsByID)(cost1)
    -- DECOMPILER ERROR at PC211: Confused about usage of register: R12 in 'UnsetPending'

    if isCost1Enough then
      ((uis.StarUp).Spend_01_Txt).text = "[color=#3dffbd]" .. (split(costStr[1], ":"))[3] .. "[/color]"
    else
      -- DECOMPILER ERROR at PC223: Confused about usage of register: R12 in 'UnsetPending'

      ((uis.StarUp).Spend_01_Txt).text = "[color=#ff5f7b]" .. (split(costStr[1], ":"))[3] .. "[/color]"
    end
    -- DECOMPILER ERROR at PC234: Confused about usage of register: R12 in 'UnsetPending'

    ;
    ((uis.StarUp).Spend_02_Loader).url = (Util.GetItemUrl)(((Util.GetConfigDataByID)(cost2)).icon)
    isCost2Enough = tonumber((split(costStr[2], ":"))[3]) <= (ActorData.GetAssetCount)(cost2)
    -- DECOMPILER ERROR at PC262: Confused about usage of register: R12 in 'UnsetPending'

    if isCost2Enough then
      ((uis.StarUp).Spend_02_Txt).text = "[color=#3dffbd]" .. (split(costStr[2], ":"))[3] .. "[/color]"
    else
      -- DECOMPILER ERROR at PC274: Confused about usage of register: R12 in 'UnsetPending'

      ((uis.StarUp).Spend_02_Txt).text = "[color=#ff5f7b]" .. (split(costStr[2], ":"))[3] .. "[/color]"
    end
  end
  local sureBtn = (uis.StarUp).SureBtn
  if ((uis.StarUp).c1Ctr).selectedIndex == 1 then
    (sureBtn:GetChild("title")).text = (PUtil.get)(185)
  else
    (sureBtn:GetChild("title")).text = (PUtil.get)(197)
  end
  ;
  (sureBtn.onClick):Clear()
  ;
  (sureBtn.onClick):Add(function(...)
    -- function num : 0_1_0 , upvalues : data, bgEffect, _ENV, isCost1Enough, cost1, isCost2Enough, cost2
    if data.next_type ~= 0 then
      if bgEffect ~= nil then
        (LuaEffect.DestroyEffect)(bgEffect)
        bgEffect = nil
      end
      UIMgr:CloseWindow((WinResConfig.TalentStarUpWindow).name)
      return 
    end
    if isCost1Enough == false then
      (MessageMgr.OpenAssetNotEnoughtWindow)(cost1)
      return 
    end
    if isCost2Enough == false then
      (MessageMgr.OpenAssetNotEnoughtWindow)(cost2)
      return 
    end
    ;
    (TalentService.ReqLevelUpMatrixSeal)(data.matrix_id, data.type)
  end
)
  -- DECOMPILER ERROR: 13 unprocessed JMP targets
end

TalentStarUpWindow.OnShown = function(...)
  -- function num : 0_2
end

TalentStarUpWindow.OnHide = function(...)
  -- function num : 0_3
end

TalentStarUpWindow.OnClose = function(...)
  -- function num : 0_4 , upvalues : _ENV, uis, contentPane, argTable, sealId, curMatrixTree, curFaZhenId
  UIMgr:SendWindowMessage("TalentMainWindow", (WindowMsgEnum.Talent).E_MSG_TALENT_STARUP_CLOSE, {})
  uis = nil
  contentPane = nil
  argTable = {}
  sealId = 0
  curMatrixTree = 0
  curFaZhenId = 0
end

TalentStarUpWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_5 , upvalues : _ENV, curMatrixTree, curFaZhenId, sealId, TalentStarUpWindow, uis
  local windowMsgEnum = WindowMsgEnum.Talent
  if msgId == windowMsgEnum.E_MSG_TALENT_UP_SEAL then
    (TalentData.SaveActiveSeal)(curMatrixTree, curFaZhenId, (para.msg).sealType, (para.msg).sealId)
    sealId = (para.msg).sealId
    ;
    (TalentStarUpWindow.RefreshWindow)()
    local holder = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_TALENT_SELECT_PRESS, true, true)
    ;
    ((uis.StarUp).root):AddChild(holder)
    holder:SetXY(((uis.StarUp).IconLoader).x + ((uis.StarUp).IconLoader).width / 2, ((uis.StarUp).IconLoader).y + ((uis.StarUp).IconLoader).height / 2)
  end
end

return TalentStarUpWindow

