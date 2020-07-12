-- params : ...
-- function num : 0 , upvalues : _ENV
require("Battle_BattleFailureByName")
local BattleSettleFailureWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local AgainFun, ConfirmFun = nil, nil
local LimitData = {}
BattleSettleFailureWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, AgainFun, ConfirmFun, uis, BattleSettleFailureWindow, LimitData
  bridgeObj:SetView((WinResConfig.BattleSettleFailureWindow).package, (WinResConfig.BattleSettleFailureWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  AgainFun = argTable[1]
  ConfirmFun = argTable[2]
  contentPane:Center()
  uis = GetBattle_BattleFailureUis(contentPane)
  ;
  (Util.CreateSelfShowModel)(uis.CardShowLoader)
  ;
  (BattleSettleFailureWindow.InitButton)()
  LimitData = {}
  local FailRateMax = (TableData.gTable).BaseBattleFailRateMaxData
  for _,v in pairs(FailRateMax) do
    if v.level == (ActorData.GetLevel)() then
      LimitData.card_level_max = v.card_level_max
      LimitData.card_quality_max = v.card_quality_max
      LimitData.card_star_max = v.card_star_max
      LimitData.card_skill_level_max = v.card_skill_level_max
      LimitData.equipment_level_max = v.equipment_level_max
      LimitData.talent_level_max = v.talent_level_max
    end
  end
  ;
  (BattleSettleFailureWindow.InitGotoData)()
end

BattleSettleFailureWindow.InitCardAttrEnough = function(...)
  -- function num : 0_1 , upvalues : _ENV
  local DataTable = (((BattleResultCount.GetBattleDamageData)())[1]).SelfCardData
  local equipLvAttr = {}
  local cardLv = {}
  local cardStageLv = {}
  local cardStartLv = {}
  local cardSkillLv = {}
  for _,v in pairs(DataTable) do
    local cardId = ((v.CardData).cardInfo).id
    do
      if ((v.CardData).cardInfo).equipInfo then
        local totalLv = 0
        for _,v2 in ipairs(((v.CardData).cardInfo).equipInfo) do
          totalLv = totalLv + v2.level
        end
        equipLvAttr[cardId] = totalLv
      end
      cardLv[cardId] = ((v.CardData).cardInfo).level
      cardStageLv[cardId] = ((v.CardData).cardInfo).quality
      cardStartLv[cardId] = ((v.CardData).cardInfo).star
      do
        if ((v.CardData).cardInfo).skillInfo then
          local totalLv = 0
          for _,v2 in ipairs(((v.CardData).cardInfo).skillInfo) do
            totalLv = totalLv + v2.value
          end
          cardSkillLv[cardId] = totalLv
        end
        -- DECOMPILER ERROR at PC63: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  return equipLvAttr, cardLv, cardStageLv, cardStartLv, cardSkillLv
end

BattleSettleFailureWindow.InitGotoData = function(...)
  -- function num : 0_2 , upvalues : _ENV, BattleSettleFailureWindow, LimitData, uis
  local BattleFail = (TableData.gTable).BaseBattleFailData
  local equipLvAttr, cardLv, cardStageLv, cardStartLv, cardSkillLv = (BattleSettleFailureWindow.InitCardAttrEnough)()
  local bottom = {}
  local up = {}
  for _,v in pairs(BattleFail) do
    do
      local property = v.rate_type
      do
        local limitValue = LimitData[property]
        local functionId = v.id
        do
          local isMax = true
          if functionId == ControlID.Home_EquipBtn then
            for _,v in pairs(equipLvAttr) do
              if v < limitValue then
                isMax = false
                break
              end
            end
          else
            do
              if functionId == ControlID.Card_Strength then
                for _,v in pairs(cardLv) do
                  if v < limitValue then
                    isMax = false
                    break
                  end
                end
              else
                do
                  if functionId == ControlID.Card_Break then
                    for _,v in pairs(cardStageLv) do
                      if v < limitValue then
                        isMax = false
                        break
                      end
                    end
                  else
                    do
                      if functionId == ControlID.Card_Wake then
                        for _,v in pairs(cardStartLv) do
                          if v < limitValue then
                            isMax = false
                            break
                          end
                        end
                      else
                        do
                          if functionId == ControlID.Card_Talent then
                            for i,v in pairs(cardSkillLv) do
                              local limitValue = (cardStartLv[i] + 2) * limitValue
                              if v < limitValue then
                                isMax = false
                                break
                              end
                            end
                          else
                            do
                              do
                                if functionId == ControlID.Home_TeamBtn then
                                  ld("Talent", function(...)
    -- function num : 0_2_0 , upvalues : _ENV, limitValue, isMax
    local value = (TalentData.GetAllTalentTreeLevel)()
    if value < limitValue then
      isMax = false
    end
  end
)
                                else
                                  if functionId == ControlID.Home_LotteryBtn then
                                    isMax = false
                                  end
                                end
                                if not isMax then
                                  if v.type == 1 then
                                    (table.insert)(up, v)
                                  else
                                    ;
                                    (table.insert)(bottom, v)
                                  end
                                end
                              end
                              -- DECOMPILER ERROR at PC124: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                              -- DECOMPILER ERROR at PC124: LeaveBlock: unexpected jumping out IF_STMT

                              -- DECOMPILER ERROR at PC124: LeaveBlock: unexpected jumping out DO_STMT

                              -- DECOMPILER ERROR at PC124: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                              -- DECOMPILER ERROR at PC124: LeaveBlock: unexpected jumping out IF_STMT

                              -- DECOMPILER ERROR at PC124: LeaveBlock: unexpected jumping out DO_STMT

                              -- DECOMPILER ERROR at PC124: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                              -- DECOMPILER ERROR at PC124: LeaveBlock: unexpected jumping out IF_STMT

                              -- DECOMPILER ERROR at PC124: LeaveBlock: unexpected jumping out DO_STMT

                              -- DECOMPILER ERROR at PC124: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                              -- DECOMPILER ERROR at PC124: LeaveBlock: unexpected jumping out IF_STMT

                              -- DECOMPILER ERROR at PC124: LeaveBlock: unexpected jumping out DO_STMT

                              -- DECOMPILER ERROR at PC124: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                              -- DECOMPILER ERROR at PC124: LeaveBlock: unexpected jumping out IF_STMT

                              -- DECOMPILER ERROR at PC124: LeaveBlock: unexpected jumping out DO_STMT

                              -- DECOMPILER ERROR at PC124: LeaveBlock: unexpected jumping out DO_STMT

                              -- DECOMPILER ERROR at PC124: LeaveBlock: unexpected jumping out DO_STMT

                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  ;
  (table.sort)(up, function(a, b, ...)
    -- function num : 0_2_1
    do return a.sort < b.sort end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (table.sort)(bottom, function(a, b, ...)
    -- function num : 0_2_2
    do return a.sort < b.sort end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  local count = #up + 1
  for i = 1, 3 do
    local failCom = (uis.root):GetChild("Failure_0" .. i .. "_Grp")
    local model = GetBattle_FailureGrpUis(failCom)
    -- DECOMPILER ERROR at PC155: Confused about usage of register: R15 in 'UnsetPending'

    if count < i then
      (failCom.root).visible = false
    else
      local FailData = up[i]
      -- DECOMPILER ERROR at PC162: Confused about usage of register: R16 in 'UnsetPending'

      if FailData then
        (model.WaysToImproveTxt).text = FailData.name
        -- DECOMPILER ERROR at PC168: Confused about usage of register: R16 in 'UnsetPending'

        ;
        (model.IconLoader).url = (Util.GetItemUrl)(FailData.icon)
        ;
        (failCom.onClick):Set(function(...)
    -- function num : 0_2_3 , upvalues : _ENV, FailData
    (Util.GetWayGoto)(FailData.id)
    ;
    (BattleMgr.CloseBattle)(true)
  end
)
      else
        -- DECOMPILER ERROR at PC179: Confused about usage of register: R16 in 'UnsetPending'

        ;
        (model.WaysToImproveTxt).text = (PUtil.get)(20000169)
        -- DECOMPILER ERROR at PC181: Confused about usage of register: R16 in 'UnsetPending'

        ;
        (model.Decorate_02_Image).visible = false
      end
    end
  end
  if bottom then
    for _,v in ipairs(bottom) do
      local failItem = UIMgr:CreateObject("Battle", "BattleFailureItem")
      ;
      (failItem:GetChild("ItemLoader")).url = (Util.GetItemUrl)(v.icon)
      ;
      (failItem:GetChild("NameLoader")).url = (Util.GetItemUrl)(v.name_icon)
      ;
      (failItem.onClick):Set(function(...)
    -- function num : 0_2_4 , upvalues : _ENV, v
    (Util.GetWayGoto)(v.id)
    ;
    (BattleMgr.CloseBattle)(true)
  end
)
      ;
      (uis.PowerChoiceList):AddChild(failItem)
    end
  end
end

BattleSettleFailureWindow.InitButton = function(...)
  -- function num : 0_3 , upvalues : uis, _ENV, ConfirmFun, AgainFun
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R0 in 'UnsetPending'

  (uis.FormationBtn).text = (PUtil.get)(20000061)
  ;
  ((uis.FormationBtn).onClick):Set(function(...)
    -- function num : 0_3_0 , upvalues : _ENV
    local ChallengeSummarizeDataTable = (BattleResultCount.GetBattleDamageData)()
    ;
    (CommonWinMgr.OpenBattleDataWindow)(ChallengeSummarizeDataTable)
  end
)
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.CloseBtn).text = (PUtil.get)(30)
  ;
  ((uis.CloseBtn).onClick):Set(function(...)
    -- function num : 0_3_1 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.BattleSettleFailureWindow).name)
  end
)
  if ConfirmFun then
    ((uis.CloseBtn).onClick):Set(function(...)
    -- function num : 0_3_2 , upvalues : ConfirmFun
    ConfirmFun()
  end
)
  end
  -- DECOMPILER ERROR at PC35: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.AgainBtn).text = (PUtil.get)(20000062)
  -- DECOMPILER ERROR at PC40: Confused about usage of register: R0 in 'UnsetPending'

  if AgainFun then
    (uis.AgainBtn).visible = true
    ;
    ((uis.AgainBtn).onClick):Set(function(...)
    -- function num : 0_3_3 , upvalues : AgainFun
    AgainFun()
  end
)
  else
    -- DECOMPILER ERROR at PC48: Confused about usage of register: R0 in 'UnsetPending'

    ;
    (uis.AgainBtn).visible = false
  end
end

BattleSettleFailureWindow.OnShown = function(...)
  -- function num : 0_4
end

BattleSettleFailureWindow.OnHide = function(...)
  -- function num : 0_5
end

BattleSettleFailureWindow.OnClose = function(...)
  -- function num : 0_6 , upvalues : uis, contentPane, AgainFun, ConfirmFun
  uis = nil
  contentPane = nil
  AgainFun = nil
  ConfirmFun = nil
end

BattleSettleFailureWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_7
end

return BattleSettleFailureWindow

