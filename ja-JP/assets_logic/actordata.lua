-- params : ...
-- function num : 0 , upvalues : _ENV
ActorData = {
tempEquipInfo = {}
, 
tempPropInfo = {}
, tempEquipPageCount = 0, tempPropPageCount = 0, 
tempCardInfo = {}
, 
tempFetterIds = {}
, 
tempOtherLottery = {}
}
local t_insert = table.insert
local t_remove = table.remove
local ipairs = ipairs
local pairs = pairs
-- DECOMPILER ERROR at PC21: Confused about usage of register: R4 in 'UnsetPending'

ActorData.MODIFY_NAME_COST = 72000014
local self = ActorData
-- DECOMPILER ERROR at PC25: Confused about usage of register: R5 in 'UnsetPending'

ActorData.InitActorData = function(...)
  -- function num : 0_0 , upvalues : self
  self.baseInfo = {}
  self.assetInfo = {}
  self.propInfo = {}
  self.intimacyInfo = {}
  self.intimacyAttrTable = {}
  self.cardStarTeamAttrTable = {}
  self.fetterId = {}
  self.noviceLottery = false
  self.noviceLotteryOnceNum = 0
  self.noviceLotteryMoreNum = 0
  self.otherLottery = {}
end

-- DECOMPILER ERROR at PC28: Confused about usage of register: R5 in 'UnsetPending'

ActorData.InitTempData = function(...)
  -- function num : 0_1 , upvalues : self
  self.tempEquipInfo = {}
  self.tempPropInfo = {}
  self.tempEquipPageCount = 0
  self.tempPropPageCount = 0
  self.tempCardInfo = {}
  self.tempFetterIds = {}
end

-- DECOMPILER ERROR at PC31: Confused about usage of register: R5 in 'UnsetPending'

ActorData.SaveActorData = function(msg, completeCallBack, ...)
  -- function num : 0_2 , upvalues : self, _ENV, ipairs, t_insert
  if msg.noviceLotteryOnceNum then
    self.noviceLotteryOnceNum = msg.noviceLotteryOnceNum
  end
  if msg.noviceLotteryMoreNum then
    self.noviceLotteryMoreNum = msg.noviceLotteryMoreNum
  end
  if msg.baseInfo then
    self.baseInfo = msg.baseInfo
    if msg.matrixTreeInfo then
      ld("Talent", function(...)
    -- function num : 0_2_0 , upvalues : _ENV, msg
    (TalentData.TalentDataInit)(msg.matrixTreeInfo)
  end
)
    end
    ;
    (LuaSound.UpdateSoundInfo)()
  end
  if msg.assetInfo and #msg.assetInfo > 0 then
    self.assetInfo = msg.assetInfo
  end
  if msg.fetterId and #msg.fetterId > 0 then
    self.tempFetterIds = msg.fetterId
  end
  for index,value in ipairs(msg.otherLottery) do
    print("=============", value.lotteryId)
  end
  if msg.otherLottery and #msg.otherLottery > 0 then
    self.tempOtherLottery = msg.otherLottery
  end
  for index,value in ipairs(self.tempOtherLottery) do
    print("``````````````", value.lotteryId)
  end
  if msg.cardInfo and #msg.cardInfo > 0 then
    for _,v in ipairs(msg.cardInfo) do
      if v.intimacyLv > 0 then
        t_insert(self.intimacyInfo, {id = v.id, value = v.intimacyLv})
      end
    end
    self.tempCardInfo = msg.cardInfo
  end
  local equipInfo = msg.equipInfo
  local propInfo = msg.propInfo
  if equipInfo then
    self.tempEquipPageCount = self.tempEquipPageCount + 1
    for _,v in ipairs(equipInfo.equipInfo) do
      t_insert(self.tempEquipInfo, v)
    end
    if self.tempEquipPageCount == msg.equipTotalPage then
      (EquiptMgr.InitEquipmentsInBag)(self.tempEquipInfo)
    end
  end
  if propInfo then
    self.tempPropPageCount = self.tempPropPageCount + 1
    for _,v in ipairs(propInfo.propInfo) do
      t_insert(self.tempPropInfo, v)
    end
    if self.tempPropPageCount == msg.propTotalPage then
      self.propInfo = self.tempPropInfo
    end
  end
  if self.tempEquipPageCount == msg.equipTotalPage and self.tempPropPageCount == msg.propTotalPage then
    (self.SaveIntimacyAttrTable)()
    ;
    (self.SaveCardStarTeamAttrTable)(self.tempCardInfo)
    ;
    (self.SaveFetterAttrTable)(self.tempFetterIds)
    ;
    (CardData.SaveAllCard)(self.tempCardInfo)
    ld("HandBook")
    ;
    (HandBookData.CheckFetterData)(self.tempFetterIds)
    self.fetterId = self.tempFetterIds
    if completeCallBack then
      completeCallBack()
    end
    ;
    (self.InitTempData)()
  end
end

-- DECOMPILER ERROR at PC34: Confused about usage of register: R5 in 'UnsetPending'

ActorData.SaveIntimacyData = function(cardId, intimacyLv, ...)
  -- function num : 0_3 , upvalues : ipairs, self, t_insert
  local isFind = false
  for _,v in ipairs(self.intimacyInfo) do
    -- DECOMPILER ERROR at PC11: Unhandled construct in 'MakeBoolean' P1

    if v.id == cardId and v.value ~= intimacyLv then
      v.value = intimacyLv
      isFind = true
    end
    do break end
  end
  do
    if isFind == false then
      t_insert(self.intimacyInfo, {id = cardId, value = intimacyLv})
    end
    ;
    (self.SaveIntimacyAttrTable)()
  end
end

-- DECOMPILER ERROR at PC37: Confused about usage of register: R5 in 'UnsetPending'

ActorData.SaveIntimacyAttrTable = function(...)
  -- function num : 0_4 , upvalues : self
  self.intimacyAttrTable = (self.GetIntimacyAttrTable)(self.intimacyInfo)
end

-- DECOMPILER ERROR at PC40: Confused about usage of register: R5 in 'UnsetPending'

ActorData.GetIntimacyAttrTable = function(intimacyInfo, ...)
  -- function num : 0_5 , upvalues : _ENV, ipairs
  ld("HandBook")
  local intimacyAttrTable = {}
  for i,v in ipairs(intimacyInfo) do
    local config = (HandBookMgr.GetCardIntimacyData)(v.id, v.value)
    if config then
      local addAttrs = (CardData.GetAddAttrList)(config.team_add_attr)
      ;
      (CardData.MergeAttrList)(intimacyAttrTable, addAttrs)
    end
  end
  return intimacyAttrTable
end

-- DECOMPILER ERROR at PC43: Confused about usage of register: R5 in 'UnsetPending'

ActorData.SaveCardStarTeamAttrTable = function(cardStarTable, ...)
  -- function num : 0_6 , upvalues : self
  self.cardStarTeamAttrTable = (self.GetCardStarTeamAttrTable)(cardStarTable)
end

-- DECOMPILER ERROR at PC46: Confused about usage of register: R5 in 'UnsetPending'

ActorData.GetCardStarTeamAttrTable = function(cardStarTable, ...)
  -- function num : 0_7 , upvalues : ipairs, _ENV
  local cardStarTeamAttrTable = {}
  if cardStarTable then
    for _,v in ipairs(cardStarTable) do
      if not v.value then
        local config = (CardData.GetCardStarUpConfig)(v.id, v.star)
        do
          if config then
            local addAttrs = (CardData.GetAddAttrList)(config.team_add_attr)
            ;
            (CardData.MergeAttrList)(cardStarTeamAttrTable, addAttrs)
          end
          -- DECOMPILER ERROR at PC26: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC26: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  else
    local allCard = (CardData.GetObtainedCardList)()
    for _,v in ipairs(allCard) do
      local starConfig = (CardData.GetCardStarUpConfig)(v.id, v.star)
      if starConfig then
        local addAttrs = (CardData.GetAddAttrList)(starConfig.team_add_attr)
        ;
        (CardData.MergeAttrList)(cardStarTeamAttrTable, addAttrs)
      end
    end
  end
  do
    return cardStarTeamAttrTable
  end
end

-- DECOMPILER ERROR at PC49: Confused about usage of register: R5 in 'UnsetPending'

ActorData.SaveFetterAttrTable = function(fetterTable, ...)
  -- function num : 0_8 , upvalues : _ENV, self
  ld("HandBook")
  if not fetterTable then
    fetterTable = (HandBookData.GetAllActivationFetterId)()
  end
  self.fetterTeamAttrTable = (self.GetFetterAttrTable)(fetterTable)
end

-- DECOMPILER ERROR at PC52: Confused about usage of register: R5 in 'UnsetPending'

ActorData.GetFetterAttrTable = function(fetterTable, ...)
  -- function num : 0_9 , upvalues : ipairs, _ENV
  local fetterTeamAttrTable = {}
  if fetterTable then
    for _,fetterId in ipairs(fetterTable) do
      local config = ((TableData.gTable).BaseCardFetterData)[fetterId]
      if config then
        local addAttrs = (CardData.GetAddAttrList)(config.add_attr)
        ;
        (CardData.MergeAttrList)(fetterTeamAttrTable, addAttrs)
      end
    end
  end
  do
    return fetterTeamAttrTable
  end
end

-- DECOMPILER ERROR at PC55: Confused about usage of register: R5 in 'UnsetPending'

ActorData.ChangeActorData = function(msg, ...)
  -- function num : 0_10 , upvalues : _ENV, ipairs, self, t_insert, t_remove
  local E_GOODS_TYPE = ProtoEnum.E_GOODS_TYPE
  local PropItemType = PropItemType
  local updateActor = false
  local updateCardPiece = false
  local CardData = CardData
  local AssetType = AssetType
  local BaseCardData = (TableData.gTable).BaseCardData
  local BasePropData = (TableData.gTable).BasePropData
  local fcChange = false
  for _,v in ipairs(msg.goods) do
    if v.type == E_GOODS_TYPE.ASSET then
      updateActor = true
      local isFind = false
      for _,v2 in ipairs(self.assetInfo) do
        if v2.id == v.id then
          v2.value = v.after
          isFind = true
        end
      end
      if v.id == AssetType.ACTOR_EXP then
        print("SetExpSetExpSetExpSetExpSetExp.." .. v.after)
        ;
        (self.SetExp)(v.after)
      end
      if isFind == false then
        t_insert(self.assetInfo, (Util.clone)(v))
      end
    else
      do
        if v.type == E_GOODS_TYPE.CARD and v.value > 0 then
          local cardBase = BaseCardData[v.id]
          if cardBase then
            local cardObject = {}
            cardObject.id = cardBase.id
            cardObject.level = 1
            cardObject.exp = 0
            if v.attr and v.attr > 0 then
              cardObject.star = v.attr
            else
              cardObject.star = cardBase.star
            end
            cardObject.quality = cardBase.quality
            cardObject.intimacyLv = 0
            cardObject.lastStageId = 0
            cardObject.skillInfo = {}
            cardObject.equipInfo = {}
            local fashionConfig = (CardData.GetFashionConfig)(cardObject)
            cardObject.fashionId = fashionConfig.id
            ;
            (CardData.ObtainNewCard)(cardObject)
          else
            do
              do
                print("未找到BaseCardData id:" .. v.id)
                if v.type == E_GOODS_TYPE.OTHER then
                  updateActor = true
                  local id = v.id
                  if id == (ProtoEnum.E_GOODS_OTHER_ID).LEVEL then
                    local before = (self.GetLevel)()
                    local isUplevel = false
                    if before and before < v.after then
                      loge("角色升级啦")
                      isUplevel = true
                      if Game.useSDK == true then
                        (SuperSDKUtil.SendAdLevelUp)(v.after)
                        ;
                        (SuperSDKUtil.SendAdOnLevel15)(v.after)
                        ;
                        (SuperSDKUtil.SendAdOnLevel30)(v.after)
                        ;
                        (SuperSDKUtil.SendAdOnLevel40)(v.after)
                      end
                    end
                    ;
                    (self.SetLevel)(v.after)
                    if isUplevel then
                      if Game.useSDK == true then
                        (SuperSDKMgr.SendLevelUp)()
                      end
                      RedDotManager:RefreshEntireTree()
                      ;
                      (RedDotMgr.RefreshOpenUI)()
                    end
                  else
                    do
                      do
                        if id == (ProtoEnum.E_GOODS_OTHER_ID).FC then
                          local preFc = (self.GetFc)()
                          if preFc and preFc ~= 0 and preFc < v.after then
                            self.fcChangeList = {preFc = preFc, newFc = v.after}
                            fcChange = true
                          end
                          ;
                          (self.SetFc)(v.after)
                        end
                        if v.type == E_GOODS_TYPE.PROP then
                          local isExist = false
                          for k,m2 in ipairs(self.propInfo) do
                            if v.objectIndex == m2.objectIndex then
                              m2.count = v.after
                              isExist = true
                              if m2.count <= 0 then
                                t_remove(self.propInfo, k)
                              end
                            end
                          end
                          do
                            if not isExist and v.after > 0 then
                              local value = (Util.clone)(v)
                              value.count = v.after
                              t_insert(self.propInfo, value)
                            end
                            do
                              local config = BasePropData[v.id]
                              if config.type == PropItemType.CHARACTER_DEBRIS then
                                updateCardPiece = true
                              end
                              -- DECOMPILER ERROR at PC242: LeaveBlock: unexpected jumping out DO_STMT

                              -- DECOMPILER ERROR at PC242: LeaveBlock: unexpected jumping out IF_THEN_STMT

                              -- DECOMPILER ERROR at PC242: LeaveBlock: unexpected jumping out IF_STMT

                              -- DECOMPILER ERROR at PC242: LeaveBlock: unexpected jumping out DO_STMT

                              -- DECOMPILER ERROR at PC242: LeaveBlock: unexpected jumping out DO_STMT

                              -- DECOMPILER ERROR at PC242: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                              -- DECOMPILER ERROR at PC242: LeaveBlock: unexpected jumping out IF_STMT

                              -- DECOMPILER ERROR at PC242: LeaveBlock: unexpected jumping out IF_THEN_STMT

                              -- DECOMPILER ERROR at PC242: LeaveBlock: unexpected jumping out IF_STMT

                              -- DECOMPILER ERROR at PC242: LeaveBlock: unexpected jumping out DO_STMT

                              -- DECOMPILER ERROR at PC242: LeaveBlock: unexpected jumping out DO_STMT

                              -- DECOMPILER ERROR at PC242: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                              -- DECOMPILER ERROR at PC242: LeaveBlock: unexpected jumping out IF_STMT

                              -- DECOMPILER ERROR at PC242: LeaveBlock: unexpected jumping out IF_THEN_STMT

                              -- DECOMPILER ERROR at PC242: LeaveBlock: unexpected jumping out IF_STMT

                              -- DECOMPILER ERROR at PC242: LeaveBlock: unexpected jumping out DO_STMT

                              -- DECOMPILER ERROR at PC242: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                              -- DECOMPILER ERROR at PC242: LeaveBlock: unexpected jumping out IF_STMT

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
  for _,n in ipairs(msg.equip) do
  end
  if updateCardPiece == true then
    (CardData.SaveNotObtainCardList)()
    ;
    (RedDotMgr.CheckTalentStarEnergy)()
  end
  if updateActor == true then
    UIMgr:SendWindowMessage((WinResConfig.HomeWindow).name, (WindowMsgEnum.HomeWindow).E_MSG_UPDATE_ACTOR_INFO)
  end
  return fcChange
end

-- DECOMPILER ERROR at PC58: Confused about usage of register: R5 in 'UnsetPending'

ActorData.GetPlayerIndex = function(...)
  -- function num : 0_11 , upvalues : self
  return self.baseInfo and (self.baseInfo).playerIndex or ""
end

-- DECOMPILER ERROR at PC61: Confused about usage of register: R5 in 'UnsetPending'

ActorData.GetRegisterTime = function(...)
  -- function num : 0_12 , upvalues : self
  return self.baseInfo and (self.baseInfo).registerTime or 0
end

-- DECOMPILER ERROR at PC64: Confused about usage of register: R5 in 'UnsetPending'

ActorData.GetNickName = function(...)
  -- function num : 0_13 , upvalues : self
  if self.baseInfo then
    return (self.baseInfo).nickName
  end
end

-- DECOMPILER ERROR at PC67: Confused about usage of register: R5 in 'UnsetPending'

ActorData.SetNickname = function(nickName, ...)
  -- function num : 0_14 , upvalues : self
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  if self.baseInfo then
    (self.baseInfo).nickName = nickName
  end
end

-- DECOMPILER ERROR at PC70: Confused about usage of register: R5 in 'UnsetPending'

ActorData.GetSignature = function(...)
  -- function num : 0_15 , upvalues : self
  if self.baseInfo then
    return (self.baseInfo).signature
  end
end

-- DECOMPILER ERROR at PC73: Confused about usage of register: R5 in 'UnsetPending'

ActorData.SetSignature = function(signature, ...)
  -- function num : 0_16 , upvalues : self
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  if self.baseInfo then
    (self.baseInfo).signature = signature
  end
end

-- DECOMPILER ERROR at PC76: Confused about usage of register: R5 in 'UnsetPending'

ActorData.GetFashionHead = function(...)
  -- function num : 0_17 , upvalues : self
  if self.baseInfo then
    local fashionHead = (self.baseInfo).fashionHead
  end
  if fashionHead and fashionHead ~= 0 then
    return fashionHead
  else
    return 14000100
  end
end

-- DECOMPILER ERROR at PC79: Confused about usage of register: R5 in 'UnsetPending'

ActorData.SetFashionHead = function(fashionHead, ...)
  -- function num : 0_18 , upvalues : self
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  if self.baseInfo then
    (self.baseInfo).fashionHead = fashionHead
  end
end

-- DECOMPILER ERROR at PC82: Confused about usage of register: R5 in 'UnsetPending'

ActorData.GetFashionShow = function(...)
  -- function num : 0_19 , upvalues : self
  if self.baseInfo then
    local fashionShow = (self.baseInfo).fashionShow
  end
  if fashionShow and fashionShow ~= 0 then
    return fashionShow
  else
    return 14000100
  end
end

-- DECOMPILER ERROR at PC85: Confused about usage of register: R5 in 'UnsetPending'

ActorData.SetFashionShow = function(fashionShow, ...)
  -- function num : 0_20 , upvalues : self
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  if self.baseInfo then
    (self.baseInfo).fashionShow = fashionShow
  end
end

-- DECOMPILER ERROR at PC88: Confused about usage of register: R5 in 'UnsetPending'

ActorData.GetLevel = function(...)
  -- function num : 0_21 , upvalues : self
  if self.baseInfo then
    return (self.baseInfo).level
  end
end

-- DECOMPILER ERROR at PC91: Confused about usage of register: R5 in 'UnsetPending'

ActorData.SetLevel = function(level, ...)
  -- function num : 0_22 , upvalues : self
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  if self.baseInfo then
    (self.baseInfo).level = level
  end
end

-- DECOMPILER ERROR at PC94: Confused about usage of register: R5 in 'UnsetPending'

ActorData.GetVipLv = function(...)
  -- function num : 0_23 , upvalues : self
  if self.baseInfo then
    return (self.baseInfo).vipLv
  end
end

-- DECOMPILER ERROR at PC97: Confused about usage of register: R5 in 'UnsetPending'

ActorData.GetGuildID = function(...)
  -- function num : 0_24 , upvalues : self
  if self.baseInfo then
    return (self.baseInfo).guildId
  end
end

-- DECOMPILER ERROR at PC100: Confused about usage of register: R5 in 'UnsetPending'

ActorData.SetGuildID = function(guildID, showTips, ...)
  -- function num : 0_25 , upvalues : self, _ENV
  if self.baseInfo then
    if showTips and (self.baseInfo).guildId == 0 and guildID ~= 0 then
      UIMgr:SendWindowMessage((WinResConfig.GuildNonpartyWindow).name, (WindowMsgEnum.Guild).E_MSG_MY_APPLY_APPROVED)
    else
      if showTips and (self.baseInfo).guildId ~= 0 and guildID == 0 and GuildData.InGuild then
        (MessageMgr.OpenSoloConfirmWindow)((PUtil.get)(60000297), function(...)
    -- function num : 0_25_0 , upvalues : _ENV
    (GuildMgr.TryEnterNonpartyWindow)()
  end
, (PUtil.get)(60000296))
      end
    end
    -- DECOMPILER ERROR at PC46: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self.baseInfo).guildId = guildID
  end
end

-- DECOMPILER ERROR at PC103: Confused about usage of register: R5 in 'UnsetPending'

ActorData.GetExp = function(...)
  -- function num : 0_26 , upvalues : self
  if self.baseInfo then
    return (self.baseInfo).exp
  end
end

-- DECOMPILER ERROR at PC106: Confused about usage of register: R5 in 'UnsetPending'

ActorData.GetNextExp = function(...)
  -- function num : 0_27 , upvalues : _ENV
  local curLevel = (ActorData.GetLevel)()
  local LevelUpData = ((TableData.gTable).BasePlayerLevelUpData)[curLevel + 72300000]
  if LevelUpData then
    return LevelUpData.next_exp
  end
end

-- DECOMPILER ERROR at PC109: Confused about usage of register: R5 in 'UnsetPending'

ActorData.GetAmountExp = function(...)
  -- function num : 0_28 , upvalues : _ENV
  local level = (ActorData.GetLevel)()
  local amount = (ActorData.GetExp)()
  if level > 1 then
    for i = 1, level - 1 do
      local LevelUpData = ((TableData.gTable).BasePlayerLevelUpData)[i + 72300000]
      amount = amount + LevelUpData.next_exp
    end
  end
  do
    return amount
  end
end

-- DECOMPILER ERROR at PC112: Confused about usage of register: R5 in 'UnsetPending'

ActorData.SetExp = function(exp, ...)
  -- function num : 0_29 , upvalues : self
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  if self.baseInfo then
    (self.baseInfo).exp = exp
  end
end

-- DECOMPILER ERROR at PC115: Confused about usage of register: R5 in 'UnsetPending'

ActorData.GetFc = function(...)
  -- function num : 0_30 , upvalues : self
  if self.baseInfo then
    return (self.baseInfo).fc
  end
end

-- DECOMPILER ERROR at PC118: Confused about usage of register: R5 in 'UnsetPending'

ActorData.SetFc = function(fc, ...)
  -- function num : 0_31 , upvalues : self
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  if self.baseInfo then
    (self.baseInfo).fc = fc
  end
end

-- DECOMPILER ERROR at PC121: Confused about usage of register: R5 in 'UnsetPending'

ActorData.GetAssetCount = function(assetType, ...)
  -- function num : 0_32 , upvalues : self, ipairs
  local assetInfo = self.assetInfo
  if assetType and assetInfo then
    for _,v in ipairs(assetInfo) do
      if v.id == assetType then
        return v.value
      end
    end
  end
  do
    return 0
  end
end

-- DECOMPILER ERROR at PC124: Confused about usage of register: R5 in 'UnsetPending'

ActorData.GetPropsData = function(...)
  -- function num : 0_33 , upvalues : self
  return self.propInfo
end

-- DECOMPILER ERROR at PC127: Confused about usage of register: R5 in 'UnsetPending'

ActorData.GetFetterId = function(...)
  -- function num : 0_34 , upvalues : self
  return self.fetterId
end

-- DECOMPILER ERROR at PC130: Confused about usage of register: R5 in 'UnsetPending'

ActorData.GetPropsTypeData = function(type, ...)
  -- function num : 0_35 , upvalues : _ENV, self, ipairs, t_insert
  local data = {}
  local BasePropData = (TableData.gTable).BasePropData
  local tonumber = tonumber
  local propsData = self.propInfo
  for _,v in ipairs(propsData) do
    local PropData = BasePropData[v.id]
    if tonumber(PropData.type) == tonumber(type) then
      t_insert(data, v)
    end
  end
  return data
end

-- DECOMPILER ERROR at PC133: Confused about usage of register: R5 in 'UnsetPending'

ActorData.SubIDProps = function(index, num, ...)
  -- function num : 0_36 , upvalues : self
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  ((self.propInfo)[index]).count = ((self.propInfo)[index]).count - num
end

-- DECOMPILER ERROR at PC136: Confused about usage of register: R5 in 'UnsetPending'

ActorData.AddIDProps = function(index, num, ...)
  -- function num : 0_37 , upvalues : self
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R2 in 'UnsetPending'

  ((self.propInfo)[index]).count = ((self.propInfo)[index]).count + num
end

-- DECOMPILER ERROR at PC139: Confused about usage of register: R5 in 'UnsetPending'

ActorData.GetPropsByID = function(id, ...)
  -- function num : 0_38 , upvalues : _ENV, ipairs, self
  local count = 0
  id = tonumber(id)
  for i,v in ipairs(self.propInfo) do
    if v.id == id then
      count = count + v.count
    end
  end
  return count
end

-- DECOMPILER ERROR at PC142: Confused about usage of register: R5 in 'UnsetPending'

ActorData.GetNumByCost = function(cost, ...)
  -- function num : 0_39 , upvalues : _ENV, self
  local num = 0
  local splits = split(cost, ":")
  local costType = tonumber(splits[1])
  local costId = tonumber(splits[2])
  if costType == PropType.ASSET then
    num = (self.GetAssetCount)(costId)
  else
    if costType == PropType.ITEM then
      num = (self.GetPropsByID)(costId)
    end
  end
  return num
end

-- DECOMPILER ERROR at PC145: Confused about usage of register: R5 in 'UnsetPending'

ActorData.GetPropsIDAndNum = function(id, ...)
  -- function num : 0_40 , upvalues : ipairs, self
  local tb = {id = id, count = 0}
  for i,v in ipairs(self.propInfo) do
    if v.id == id then
      tb.count = tb.count + v.count
    end
  end
  return tb
end

-- DECOMPILER ERROR at PC148: Confused about usage of register: R5 in 'UnsetPending'

ActorData.GetItemObjectIndex = function(id, ...)
  -- function num : 0_41 , upvalues : ipairs, self, t_insert, _ENV
  local propList = {}
  for _,v in ipairs(self.propInfo) do
    if v.id == id then
      t_insert(propList, v)
    end
  end
  ;
  (table.sort)(propList, function(a, b, ...)
    -- function num : 0_41_0
    do return a.count < b.count end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  if #propList > 0 then
    return (propList[1]).objectIndex
  end
end

-- DECOMPILER ERROR at PC151: Confused about usage of register: R5 in 'UnsetPending'

ActorData.GetCardPieceInfo = function(cardId, ...)
  -- function num : 0_42 , upvalues : _ENV, self
  local pieceInfo = nil
  if cardId then
    cardId = tonumber(cardId)
    local cardConfig = ((TableData.gTable).BaseCardData)[cardId]
    if cardConfig then
      local recruit_cost = cardConfig.recruit_cost
      if recruit_cost then
        pieceInfo = {}
        recruit_cost = split(recruit_cost, ":")
        pieceInfo.type = tonumber(recruit_cost[1])
        pieceInfo.id = tonumber(recruit_cost[2])
        pieceInfo.needNum = tonumber(recruit_cost[3])
        pieceInfo.haveNum = (self.GetPropsByID)(pieceInfo.id)
      end
    end
  end
  do
    return pieceInfo
  end
end

-- DECOMPILER ERROR at PC154: Confused about usage of register: R5 in 'UnsetPending'

ActorData.GetGoodsCount = function(id, type, ...)
  -- function num : 0_43 , upvalues : _ENV, self
  if type == PropType.ITEM then
    return (self.GetPropsByID)(tonumber(id))
  else
    if type == PropType.ASSET then
      return (self.GetAssetCount)(tonumber(id))
    end
  end
end

-- DECOMPILER ERROR at PC157: Confused about usage of register: R5 in 'UnsetPending'

ActorData.GetAssetText = function(assetType, ...)
  -- function num : 0_44 , upvalues : self, _ENV
  local count = (self.GetAssetCount)(assetType)
  return GetFormatedCount(count)
end

-- DECOMPILER ERROR at PC160: Confused about usage of register: R5 in 'UnsetPending'

ActorData.GetSpecifyFormatText = function(assetType, ...)
  -- function num : 0_45 , upvalues : _ENV, self
  local LevelUpData = ((TableData.gTable).BasePlayerLevelUpData)[(self.GetLevel)() + 72300000]
  local max = nil
  if assetType == AssetType.PHYSICAL then
    max = LevelUpData.max_vit
  else
    if assetType == AssetType.ENDURANCE then
      max = LevelUpData.max_sta
    end
  end
  local curValue = (self.GetAssetCount)(assetType)
  if curValue == 0 then
    return (PUtil.get)(40001102, curValue, max)
  else
    if max <= curValue then
      return (PUtil.get)(40001101, curValue, max)
    else
      return (PUtil.get)(40001100, curValue, max)
    end
  end
end

-- DECOMPILER ERROR at PC163: Confused about usage of register: R5 in 'UnsetPending'

ActorData.GetMaxStoreAsset = function(type, ...)
  -- function num : 0_46 , upvalues : _ENV, self
  local LevelUpData = ((TableData.gTable).BasePlayerLevelUpData)[(self.GetLevel)() + 72300000]
  local max = nil
  if type == AssetType.PHYSICAL then
    return LevelUpData.max_vit
  else
    if type == AssetType.ENDURANCE then
      if self.MaxEnduranceStore == nil then
        self.MaxEnduranceStore = tonumber((split((((TableData.gTable).BaseFixedData)[72000008]).array_value, ":"))[2])
      end
      return self.MaxEnduranceStore
    else
      if type == AssetType.SPIRIT then
        return (((TableData.gTable).BaseFixedData)[72000004]).int_value
      end
    end
  end
end

-- DECOMPILER ERROR at PC166: Confused about usage of register: R5 in 'UnsetPending'

ActorData.SetServerTime = function(serverTime, ...)
  -- function num : 0_47 , upvalues : self, _ENV
  self.saveLocalTime = Time.unscaledTime
  self.saveServerTime = serverTime
end

-- DECOMPILER ERROR at PC169: Confused about usage of register: R5 in 'UnsetPending'

ActorData.GetServerTime = function(...)
  -- function num : 0_48 , upvalues : self, _ENV
  if self.saveLocalTime == nil then
    return Time.unscaledTime * 1000
  end
  local time = Time.unscaledTime - self.saveLocalTime
  return self.saveServerTime + time * 1000
end

self.noviceLotteryOnceNum = 0
self.noviceLotteryMoreNum = 0
-- DECOMPILER ERROR at PC174: Confused about usage of register: R5 in 'UnsetPending'

ActorData.GetNoviceLottery = function(...)
  -- function num : 0_49 , upvalues : self
  do return self.noviceLotteryOnceNum > 0 or self.noviceLotteryMoreNum > 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC177: Confused about usage of register: R5 in 'UnsetPending'

ActorData.GetNoviceLotteryOnceNumInit = function(...)
  -- function num : 0_50 , upvalues : self
  return self.noviceLotteryOnceNum
end

-- DECOMPILER ERROR at PC180: Confused about usage of register: R5 in 'UnsetPending'

ActorData.GetNoviceLotteryTenNum = function(...)
  -- function num : 0_51 , upvalues : self
  return self.noviceLotteryMoreNum
end

-- DECOMPILER ERROR at PC183: Confused about usage of register: R5 in 'UnsetPending'

ActorData.SetNoviceLottery = function(once, more, ...)
  -- function num : 0_52 , upvalues : self
  self.noviceLotteryOnceNum = once or 0
  self.noviceLotteryMoreNum = more or 0
end

-- DECOMPILER ERROR at PC186: Confused about usage of register: R5 in 'UnsetPending'

ActorData.SaveLotteryActivityData = function(data, ...)
  -- function num : 0_53 , upvalues : self
  if data and #data > 0 then
    if not data then
      self.tempOtherLottery = {}
    end
  end
end

-- DECOMPILER ERROR at PC189: Confused about usage of register: R5 in 'UnsetPending'

ActorData.GetLotteryActivityNum = function(aType, ...)
  -- function num : 0_54 , upvalues : pairs, self, _ENV
  local activityData = {}
  local isExist = false
  for index,value in pairs(self.tempOtherLottery) do
    print("当前活动扭蛋类型", value.lotteryId, value.lotteryType, value.surLotteryNum)
    if aType == value.lotteryType and value.surLotteryNum > 0 then
      local curTime = (ActorData.GetServerTime)()
      local minTime = value.beginTime
      local maxTime = value.endTime
      print("==============aType", aType, value.surLotteryNum, minTime, curTime, maxTime)
      if value.beginTime == -1 or minTime <= curTime and curTime <= maxTime then
        if isExist == false then
          isExist = true
        end
        ;
        (table.insert)(activityData, value)
      end
    end
  end
  if isExist then
    return activityData
  else
    return nil
  end
end

-- DECOMPILER ERROR at PC192: Confused about usage of register: R5 in 'UnsetPending'

ActorData.GetActivityLotteryTime = function(aType, ...)
  -- function num : 0_55 , upvalues : pairs, self
  for index,value in pairs(self.tempOtherLottery) do
    if aType == value.lotteryType then
      return value.beginTime, value.endTime
    end
  end
end

-- DECOMPILER ERROR at PC195: Confused about usage of register: R5 in 'UnsetPending'

ActorData.SubLotteryActivityNum = function(lotteryId, num, ...)
  -- function num : 0_56 , upvalues : _ENV, self, pairs
  print("******************", lotteryId, num)
  local fakeTable = self.tempOtherLottery
  for index,value in pairs(self.tempOtherLottery) do
    if lotteryId == value.lotteryId then
      local tmpNum = value.surLotteryNum
      value.surLotteryNum = tmpNum - num
      print("减少扭蛋次数", lotteryId, value.surLotteryNum)
    end
  end
end

-- DECOMPILER ERROR at PC198: Confused about usage of register: R5 in 'UnsetPending'

ActorData.SetGeneralHomeBg = function(bgId, ...)
  -- function num : 0_57 , upvalues : _ENV
  (Util.SetIntPlayerSetting)("GENERAL_HOME_BG", bgId)
end

-- DECOMPILER ERROR at PC201: Confused about usage of register: R5 in 'UnsetPending'

ActorData.GetGeneralHomeBg = function(...)
  -- function num : 0_58 , upvalues : _ENV
  return (Util.GetIntPlayerSetting)("GENERAL_HOME_BG", 1)
end

-- DECOMPILER ERROR at PC204: Confused about usage of register: R5 in 'UnsetPending'

ActorData.GetBindRewardGet = function(...)
  -- function num : 0_59 , upvalues : self
  if self.baseInfo then
    return (self.baseInfo).bindRewardGet
  end
end

-- DECOMPILER ERROR at PC207: Confused about usage of register: R5 in 'UnsetPending'

ActorData.SetBindRewardGet = function(isGet, ...)
  -- function num : 0_60 , upvalues : self
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  if self.baseInfo then
    (self.baseInfo).bindRewardGet = isGet
  end
end

self.TitleList = {}
-- DECOMPILER ERROR at PC212: Confused about usage of register: R5 in 'UnsetPending'

ActorData.TitleListData = function(titleList, ...)
  -- function num : 0_61 , upvalues : self, _ENV
  if titleList == nil then
    return self.TitleList
  else
    loge("称号变更")
    self.TitleList = titleList
  end
end

-- DECOMPILER ERROR at PC215: Confused about usage of register: R5 in 'UnsetPending'

ActorData.GetWearTitle = function(...)
  -- function num : 0_62 , upvalues : self
  return self.baseInfo and (self.baseInfo).titleId or 0
end

-- DECOMPILER ERROR at PC218: Confused about usage of register: R5 in 'UnsetPending'

ActorData.SetWearTitle = function(id, ...)
  -- function num : 0_63 , upvalues : self
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (self.baseInfo).titleId = id
end

-- DECOMPILER ERROR at PC221: Confused about usage of register: R5 in 'UnsetPending'

ActorData.GetTitleAllAttr = function(...)
  -- function num : 0_64 , upvalues : ipairs, self, _ENV
  local attrData = {}
  for _,v in ipairs(self.TitleList) do
    local configData = ((TableData.gTable).BasePlayerTitleData)[v.titleId]
    local addAttr = (Util.ParseConfigStr)(configData.add_attr)
    for _,v2 in ipairs(addAttr) do
      local attrType = tonumber(v2[1])
      local attrID = tonumber(v2[2])
      local attrNum = tonumber(v2[3])
      if attrType == 1 then
        if attrData[attrID] == nil then
          attrData[attrID] = 0
        end
        attrData[attrID] = attrData[attrID] + attrNum
      end
    end
  end
  return attrData
end


