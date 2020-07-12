-- params : ...
-- function num : 0 , upvalues : _ENV
BattleResource = {curIndex = 0, totalCount = 0, 
resourceList = {}
}
local UIMgr = UIMgr
local self = BattleResource
local load = true
-- DECOMPILER ERROR at PC11: Confused about usage of register: R3 in 'UnsetPending'

BattleResource.Load = function(...)
  -- function num : 0_0 , upvalues : load, self, _ENV, UIMgr
  if load == true then
    (self.Clear)()
    self.curIndex = 0
    ;
    (self.GetCardSkillResource)()
    self.totalCount = #self.resourceList
    ;
    (self.LoadResource)()
    ;
    (SimpleTimer.setTimeout)(10, function(...)
    -- function num : 0_0_0 , upvalues : UIMgr, _ENV, self
    if UIMgr:IsWindowOpen((WinResConfig.LoadingWindow).name) == true then
      for _,resInfo in ipairs(self.resourceList) do
        if resInfo.isLoaded ~= true then
          loge("加载失败的资源：")
          log(resInfo.res)
        end
      end
    end
  end
)
  else
    local t = (((LeanTween.value)(0, 1, 0.3)):setOnUpdate(function(value, ...)
    -- function num : 0_0_1 , upvalues : UIMgr, _ENV
    UIMgr:SendWindowMessage((WinResConfig.LoadingWindow).name, (WindowMsgEnum.LoadingWindow).E_MSG_UPDATE_LOADING_PROCESS_TWEEN, {value = value})
  end
)):setOnComplete(function(...)
    -- function num : 0_0_2 , upvalues : _ENV
    (BattleResource.LoadComplete)()
  end
)
    t:setIgnoreTimeScale(true)
  end
end

-- DECOMPILER ERROR at PC14: Confused about usage of register: R3 in 'UnsetPending'

BattleResource.LoadResource = function(...)
  -- function num : 0_1 , upvalues : self, _ENV, UIMgr
  if self.totalCount == 0 then
    (self.LoadComplete)()
  else
    for _,resInfo in ipairs(self.resourceList) do
      do
        loge(resInfo.res)
        if resInfo.type == "effect" then
          if UIMgr:IsWindowOpen((WinResConfig.LoadingWindow).name) == true then
            (ResHelper.AsyncInstantiateEffect)(resInfo.res, nil, function(object, ...)
    -- function num : 0_1_0 , upvalues : self, UIMgr, _ENV, resInfo
    if object then
      self.curIndex = self.curIndex + 1
      UIMgr:SendWindowMessage((WinResConfig.LoadingWindow).name, (WindowMsgEnum.LoadingWindow).E_MSG_UPDATE_LOADING_PROCESS_TWEEN, {value = self.curIndex / self.totalCount, callback = self.LoadComplete})
      print("  加载完成： ", resInfo.res, resInfo.type)
      ;
      (ResHelper.DestroyGameObject)(object, true)
      resInfo.isLoaded = true
    end
  end
)
          else
            local object = (ResHelper.InstantiateEffect)(resInfo.res)
            if object then
              (ResHelper.DestroyGameObject)(object)
              self.curIndex = self.curIndex + 1
              if self.totalCount <= self.curIndex then
                (self.LoadComplete)()
              end
              print("  加载完成： ", resInfo.res, resInfo.type)
            end
          end
        else
          do
            if UIMgr:IsWindowOpen((WinResConfig.LoadingWindow).name) == true then
              (ResHelper.AsyncInstantiateModel)(resInfo.res, nil, function(object, ...)
    -- function num : 0_1_1 , upvalues : self, UIMgr, _ENV, resInfo
    if object then
      self.curIndex = self.curIndex + 1
      UIMgr:SendWindowMessage((WinResConfig.LoadingWindow).name, (WindowMsgEnum.LoadingWindow).E_MSG_UPDATE_LOADING_PROCESS_TWEEN, {value = self.curIndex / self.totalCount, callback = self.LoadComplete})
      print("  加载完成： ", resInfo.res, resInfo.type)
      ;
      (ResHelper.DestroyGameObject)(object, true)
    end
  end
)
            else
              local object = (ResHelper.InstantiateModel)(resInfo.res)
              if object then
                (ResHelper.DestroyGameObject)(object)
                self.curIndex = self.curIndex + 1
                if self.totalCount <= self.curIndex then
                  (self.LoadComplete)()
                end
                print("  加载完成： ", resInfo.res, resInfo.type)
              end
            end
          end
        end
        do
          -- DECOMPILER ERROR at PC96: LeaveBlock: unexpected jumping out DO_STMT

        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC17: Confused about usage of register: R3 in 'UnsetPending'

BattleResource.GetCardSkillResource = function(...)
  -- function num : 0_2 , upvalues : _ENV, self
  local teamInfo = BattleData.teamInfo
  local teamA = teamInfo.teamA
  local teamB = teamInfo.teamB
  for _,team in ipairs(teamA) do
    (self.GetOneTeamResource)(team)
  end
  for _,team in ipairs(teamB) do
    (self.GetOneTeamResource)(team)
  end
  local resourceList = {}
  for res,_ in pairs(self.resourceList) do
    (table.insert)(resourceList, {res = res, type = "effect"})
  end
  self.resourceList = resourceList
end

-- DECOMPILER ERROR at PC20: Confused about usage of register: R3 in 'UnsetPending'

BattleResource.GetOneTeamResource = function(team, ...)
  -- function num : 0_3 , upvalues : _ENV
  local teamCard = team.teamCard
  for _,card in ipairs(teamCard) do
    local cardInfo = card.cardInfo
    ;
    (BattleResource.GetOneCardResource)(cardInfo)
  end
end

-- DECOMPILER ERROR at PC23: Confused about usage of register: R3 in 'UnsetPending'

BattleResource.GetOneCardResource = function(cardInfo, ...)
  -- function num : 0_4 , upvalues : _ENV, self
  if cardInfo == nil then
    return 
  end
  local id = cardInfo.id
  local cardConfig = (CardData.GetBaseConfig)(id)
  if cardConfig == nil then
    return 
  end
  local fashionId = cardInfo.fashionId
  local showIdTable = {}
  ;
  (table.insert)(showIdTable, (BattleSkill.GetSkillShowId)(fashionId, BattleSkillType.NORMAL))
  ;
  (table.insert)(showIdTable, (BattleSkill.GetSkillShowId)(fashionId, BattleSkillType.SMALL))
  ;
  (table.insert)(showIdTable, (BattleSkill.GetSkillShowId)(fashionId, BattleSkillType.SKILL))
  ;
  (table.insert)(showIdTable, (BattleSkill.GetSkillShowId)(fashionId, BattleSkillType.ASSIST))
  for _,showId in ipairs(showIdTable) do
    local showConfig = ((TableData.gTable).BaseSkillShowData)[showId]
    -- DECOMPILER ERROR at PC73: Confused about usage of register: R11 in 'UnsetPending'

    if showConfig.effect_attack then
      if (string.find)(showConfig.effect_attack, "SkillScript") == nil then
        (self.resourceList)[showConfig.effect_attack] = 1
      else
        local SkillScript = require(showConfig.effect_attack)
        -- DECOMPILER ERROR at PC82: Confused about usage of register: R12 in 'UnsetPending'

        if SkillScript then
          (self.resourceList)[SkillScript.timelineName] = 1
        end
      end
    end
    do
      if showConfig.effect_attack_target then
        local strTable = split(showConfig.effect_attack_target, "|")
        for _,str in ipairs(strTable) do
          -- DECOMPILER ERROR at PC95: Confused about usage of register: R17 in 'UnsetPending'

          (self.resourceList)[str] = 1
        end
      end
      do
        if showConfig.effect_attack_hit then
          local strTable = split(showConfig.effect_attack_hit, "|")
          for _,str in ipairs(strTable) do
            -- DECOMPILER ERROR at PC110: Confused about usage of register: R17 in 'UnsetPending'

            (self.resourceList)[str] = 1
          end
        end
        do
          do
            -- DECOMPILER ERROR at PC118: Confused about usage of register: R11 in 'UnsetPending'

            if showConfig.effect_attack_air then
              (self.resourceList)[showConfig.effect_attack_air] = 1
            end
            -- DECOMPILER ERROR at PC119: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC119: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC119: LeaveBlock: unexpected jumping out DO_STMT

          end
        end
      end
    end
  end
end

-- DECOMPILER ERROR at PC26: Confused about usage of register: R3 in 'UnsetPending'

BattleResource.LoadComplete = function(...)
  -- function num : 0_5 , upvalues : self, _ENV
  (self.Clear)()
  ;
  (BattleData.StartBattle)()
end

-- DECOMPILER ERROR at PC29: Confused about usage of register: R3 in 'UnsetPending'

BattleResource.Clear = function(...)
  -- function num : 0_6 , upvalues : self
  self.resourceList = {}
end

-- DECOMPILER ERROR at PC32: Confused about usage of register: R3 in 'UnsetPending'

BattleResource.PreLoadByPath = function(path, isAsync, ...)
  -- function num : 0_7 , upvalues : _ENV
  -- DECOMPILER ERROR at PC11: Unhandled construct in 'MakeBoolean' P1

  if isAsync ~= nil or path ~= nil then
    if isAsync == true then
      (ResHelper.AsyncInstantiateModel)(path, nil, function(obj, ...)
    -- function num : 0_7_0 , upvalues : _ENV
    (ResHelper.DestroyGameObject)(obj)
  end
)
    else
      local model = (ResHelper.InstantiateModel)(path)
      ;
      (ResHelper.DestroyGameObject)(model)
    end
  end
end

-- DECOMPILER ERROR at PC35: Confused about usage of register: R3 in 'UnsetPending'

BattleResource.PreLoadCard = function(cardId, ...)
  -- function num : 0_8 , upvalues : _ENV
  local card = (CardData.GetCardData)(cardId)
  if card then
    local fashionConfig = (CardData.GetFashionConfig)(card)
    ;
    (BattleResource.PreLoadByPath)(fashionConfig.spd_bundle)
  end
end

-- DECOMPILER ERROR at PC38: Confused about usage of register: R3 in 'UnsetPending'

BattleResource.PreLoadMonster = function(monsterId, ...)
  -- function num : 0_9 , upvalues : _ENV
  local cardConfig, isMonster = (CardData.GetBaseConfig)(monsterId)
  if cardConfig then
    local fashionConfig = (CardData.GetFashionConfig)(cardConfig)
    ;
    (BattleResource.PreLoadByPath)(fashionConfig.spd_bundle)
  end
end


