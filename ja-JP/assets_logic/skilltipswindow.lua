-- params : ...
-- function num : 0 , upvalues : _ENV
require("DescriptionTips_SkillTipsWindowByName")
local SkillTipsWindow = {}
local uis = nil
local skillData = {}
local skillLevel = 0
local cardData, contentPane, _originYSize = nil, nil, nil
local OffsetNum = 75
local starUrl = nil
local isMovePosition = false
SkillTipsWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, uis, starUrl
  bridgeObj:SetView((WinResConfig.SkillTipsWindow).package, (WinResConfig.SkillTipsWindow).comName)
  contentPane = bridgeObj.contentPane
  contentPane:Center()
  uis = GetDescriptionTips_SkillTipsWindowUis(contentPane)
  ;
  ((uis.TouchScreenBtn).onClick):Add(function(...)
    -- function num : 0_0_0 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.SkillTipsWindow).name)
  end
)
  if starUrl == nil then
    starUrl = ((((uis.SkillTipsGrp).StarImage).root):GetChild("0")).resourceURL
  end
end

SkillTipsWindow.SetPanePosition = function(position, ...)
  -- function num : 0_1 , upvalues : _ENV, skillData, skillLevel, uis, SkillTipsWindow, contentPane, isMovePosition
  local skillAttrData = (CardData.GetBaseSkillAttrData)(skillData.add_attr_type, skillLevel)
  local skillRemark = ""
  if skillAttrData ~= nil and skillAttrData.remark ~= nil then
    skillRemark = skillAttrData.remark
  end
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((uis.SkillTipsGrp).SkillWordTxt).text = (SkillTipsWindow.GetDetailTxt)(skillData.des) .. skillRemark
  ;
  (SkillTipsWindow.ResetWorldTxt)()
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((uis.SkillTipsGrp).root).y = (contentPane.height - ((uis.SkillTipsGrp).TipsImage).height / 2) * 0.5
  print("isMovePosition", isMovePosition)
  -- DECOMPILER ERROR at PC43: Confused about usage of register: R3 in 'UnsetPending'

  if isMovePosition then
    ((uis.SkillTipsGrp).root).x = contentPane.width * 0.815
  else
    -- DECOMPILER ERROR at PC49: Confused about usage of register: R3 in 'UnsetPending'

    ;
    ((uis.SkillTipsGrp).root).x = contentPane.width * 0.25
  end
end

SkillTipsWindow.ResetWorldTxt = function(...)
  -- function num : 0_2 , upvalues : uis
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R0 in 'UnsetPending'

  if ((uis.SkillTipsGrp).SkillWordTxt).height < 71 then
    ((uis.SkillTipsGrp).SkillWordTxt).text = ((uis.SkillTipsGrp).SkillWordTxt).text .. "\n\n"
  end
end

SkillTipsWindow.GetDetailTxt = function(text, ...)
  -- function num : 0_3 , upvalues : _ENV, SkillTipsWindow
  if (string.find)(text, "damage_A") ~= nil then
    text = (string.gsub)(text, "damage_A", (SkillTipsWindow.Damage_A)())
  end
  if (string.find)(text, "damage_B") ~= nil then
    text = (string.gsub)(text, "damage_B", (SkillTipsWindow.Damage_B)())
  end
  if (string.find)(text, "damage_C1") ~= nil then
    text = (string.gsub)(text, "damage_C1", (SkillTipsWindow.Damage_C)(1))
  end
  if (string.find)(text, "damage_C2") ~= nil then
    text = (string.gsub)(text, "damage_C2", (SkillTipsWindow.Damage_C)(2))
  end
  if (string.find)(text, "damage_C3") ~= nil then
    text = (string.gsub)(text, "damage_C3", (SkillTipsWindow.Damage_C)(3))
  end
  if (string.find)(text, "damage_C4") ~= nil then
    text = (string.gsub)(text, "damage_C4", (SkillTipsWindow.Damage_C)(4))
  end
  if (string.find)(text, "damage_D") ~= nil then
    local str = (string.match)(text, "damage_D%d+")
    if str then
      str = (string.gsub)(str, "damage_D", "")
      local buffId = tonumber(str)
      text = (string.gsub)(text, "damage_D%d+", (SkillTipsWindow.Damage_D)(buffId))
    end
  end
  do
    return text
  end
end

SkillTipsWindow.Damage_A = function(...)
  -- function num : 0_4 , upvalues : _ENV, skillData
  local number = 0
  number = ((math.abs)(skillData.damage_rate * 0.0001) + (math.abs)(skillData.damage_rate_up * 0.0001)) * 100
  local str = ""
  if number > 0 then
    str = tostring(number)
  end
  return (string.sub)(str, 1, -3)
end

SkillTipsWindow.Damage_B = function(...)
  -- function num : 0_5 , upvalues : _ENV, skillData, skillLevel
  local number = 0
  number = (math.abs)(skillData.damage) * (1 + (math.abs)(skillData.damage_up) * 0.0001 * skillLevel)
  local str = ""
  if number > 0 then
    str = "+" .. tostring(number)
  end
  return (string.sub)(str, 1, -3)
end

SkillTipsWindow.Damage_C = function(cIndex, ...)
  -- function num : 0_6 , upvalues : _ENV, skillData, skillLevel
  local number = 0
  local attr = (split((split(skillData.add_attr, ","))[cIndex], ":"))[3]
  number = (math.abs)(attr) * skillLevel
  local str = ""
  if number > 0 then
    str = tostring(number)
  end
  local final = (string.sub)(str, 1, -3)
  return final
end

SkillTipsWindow.Damage_D = function(buffId, ...)
  -- function num : 0_7 , upvalues : _ENV, skillLevel
  local number = 0
  local config = (TableData.GetBaseSkillBuffData)(buffId)
  local value_up = tonumber((split(config.value_up, ":"))[2])
  local ConstValue = tonumber((split(config.value_up, ":"))[3] or 0)
  number = (math.abs)(value_up) * skillLevel + ConstValue
  local str = ""
  if number > 0 then
    str = "+" .. tostring(number)
  end
  return str
end

SkillTipsWindow.RefreshWindow_SKILL = function(...)
  -- function num : 0_8 , upvalues : uis, _ENV, skillData, skillLevel, cardData, starUrl, SkillTipsWindow
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R0 in 'UnsetPending'

  ((uis.SkillTipsGrp).SkillTypeTxt).text = (PUtil.get)(49)
  if skillData.type ~= nil then
    local skillType = skillData.type
    -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

    if skillType == 2 then
      (((uis.SkillTipsGrp).SkillFrameGrp).c1Ctr).selectedIndex = 2
      -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

      ;
      ((uis.SkillTipsGrp).c2Ctr).selectedIndex = 2
    else
      -- DECOMPILER ERROR at PC26: Confused about usage of register: R1 in 'UnsetPending'

      if skillType == 3 then
        (((uis.SkillTipsGrp).SkillFrameGrp).c1Ctr).selectedIndex = 1
        -- DECOMPILER ERROR at PC29: Confused about usage of register: R1 in 'UnsetPending'

        ;
        ((uis.SkillTipsGrp).c2Ctr).selectedIndex = 1
      else
        -- DECOMPILER ERROR at PC36: Confused about usage of register: R1 in 'UnsetPending'

        if skillType == 5 then
          (((uis.SkillTipsGrp).SkillFrameGrp).c1Ctr).selectedIndex = 0
          -- DECOMPILER ERROR at PC39: Confused about usage of register: R1 in 'UnsetPending'

          ;
          ((uis.SkillTipsGrp).c2Ctr).selectedIndex = 0
        end
      end
    end
    -- DECOMPILER ERROR at PC43: Confused about usage of register: R1 in 'UnsetPending'

    ;
    ((uis.SkillTipsGrp).SkillNameTxt).text = skillData.name
    -- DECOMPILER ERROR at PC55: Confused about usage of register: R1 in 'UnsetPending'

    if skillLevel > 0 then
      ((uis.SkillTipsGrp).SkillLevelTxt).text = (PUtil.get)(53) .. skillLevel
    else
      -- DECOMPILER ERROR at PC59: Confused about usage of register: R1 in 'UnsetPending'

      ;
      ((uis.SkillTipsGrp).SkillLevelTxt).text = ""
    end
    -- DECOMPILER ERROR at PC66: Confused about usage of register: R1 in 'UnsetPending'

    if skillData.need_star <= cardData.star then
      ((uis.SkillTipsGrp).OpenConditionTxt).text = ""
    else
      -- DECOMPILER ERROR at PC93: Confused about usage of register: R1 in 'UnsetPending'

      ;
      ((uis.SkillTipsGrp).OpenConditionTxt).text = (PUtil.get)(154) .. skillData.need_star .. "<img src=\'" .. starUrl .. "\' " .. "width=\'" .. tostring(26) .. "\' " .. "height=\'" .. tostring(26) .. "\'>" .. (PUtil.get)(171)
    end
    -- DECOMPILER ERROR at PC101: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (((uis.SkillTipsGrp).SkillFrameGrp).SkillLoader).url = (Util.GetResUrl)(skillData.icon_path)
    ;
    (SkillTipsWindow.SetPanePosition)()
  end
end

SkillTipsWindow.RefreshWindow_TALENT = function(talentInfo, ...)
  -- function num : 0_9 , upvalues : SkillTipsWindow, _ENV, uis
  (SkillTipsWindow.FreeStylePosition)()
  local talentData = ((TableData.gTable).BaseTalentData)[talentInfo.talentId]
  -- DECOMPILER ERROR at PC14: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (((uis.SkillTipsGrp).TalentSkillGrp).IconLoader).url = (Util.GetResUrl)(talentData.icon)
  -- DECOMPILER ERROR at PC18: Confused about usage of register: R2 in 'UnsetPending'

  ;
  ((uis.SkillTipsGrp).SkillNameTxt).text = talentData.name
  local str = ""
  if tonumber(talentInfo.extraLvl) > 0 then
    str = (PUtil.get)(145) .. talentInfo.talentLvl .. "[color=#45ff76]" .. "(" .. talentInfo.extraLvl .. ")" .. "[/color]" .. "/" .. talentData.max_level
  else
    str = (PUtil.get)(145) .. talentInfo.talentLvl .. "/" .. talentData.max_level
  end
  -- DECOMPILER ERROR at PC49: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((uis.SkillTipsGrp).OpenConditionTxt).text = str
  -- DECOMPILER ERROR at PC53: Confused about usage of register: R3 in 'UnsetPending'

  ;
  ((uis.SkillTipsGrp).SkillWordTxt).text = talentData.name
  ;
  (SkillTipsWindow.ResetWorldTxt)()
end

SkillTipsWindow.FreeStylePosition = function(...)
  -- function num : 0_10 , upvalues : _originYSize, uis, contentPane, _ENV, OffsetNum
  _originYSize = ((uis.SkillTipsGrp).TipsImage).height
  local v2 = contentPane:GlobalToLocal(Vector2((Input.mousePosition).x, (Input.mousePosition).y))
  local mHeight = (GRoot.inst).height - v2.y - contentPane.sourceHeight / 2
  local mX = 0
  local mY = 0
  if mHeight < 0 then
    mY = (GRoot.inst).height - v2.y
  else
    if (GRoot.inst).height - contentPane.sourceHeight < mHeight then
      mY = (GRoot.inst).height - contentPane.sourceHeight
    else
      mY = mHeight
    end
  end
  if v2.x - contentPane.sourceWidth - OffsetNum <= 0 then
    mX = (math.max)(0, v2.x - contentPane.sourceWidth / 2)
    mY = mHeight - contentPane.sourceHeight / 2 - OffsetNum
    if mY <= 0 then
      mX = v2.x + OffsetNum
      mY = (math.max)(0, mHeight)
    end
  else
    mX = v2.x - contentPane.sourceWidth - OffsetNum
  end
  contentPane:SetXY(mX, mY)
end

SkillTipsWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_11 , upvalues : _ENV, skillData, cardData, skillLevel, isMovePosition, SkillTipsWindow
  local windowMsgEnum = WindowMsgEnum.CardWindow
  if msgId == windowMsgEnum.E_MSG_CARD_SKILLDETAIL then
    skillData = {}
    skillData = para.skillData
    cardData = para.cardData
    if para.skillLevel == nil then
      skillLevel = 0
    else
      skillLevel = para.skillLevel
    end
    if para.position then
      isMovePosition = true
    else
      isMovePosition = false
    end
    ;
    (SkillTipsWindow.RefreshWindow_SKILL)()
  else
    if msgId == (WindowMsgEnum.Talent).E_MSG_TALNET_TALENT_TIPS then
      (SkillTipsWindow.RefreshWindow_TALENT)(para)
    end
  end
end

SkillTipsWindow.OnClose = function(...)
  -- function num : 0_12 , upvalues : cardData, uis, contentPane, skillData, skillLevel, starUrl, isMovePosition
  cardData = nil
  uis = nil
  contentPane = nil
  skillData = {}
  skillLevel = 0
  starUrl = nil
  isMovePosition = false
end

return SkillTipsWindow

