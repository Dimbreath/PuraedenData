-- params : ...
-- function num : 0 , upvalues : _ENV
local require = require
local type = type
local t_insert = table.insert
local s_sub = string.sub
local s_gsub = string.gsub
local s_find = string.find
local s_len = string.len
local s_fomat = string.format
local s_byte = string.byte
local pairs = pairs
local ipairs = ipairs
if IsBattleServer == nil then
  require("CommonResource_ItemFrameByName")
  require("CommonResource_HeadFrameByName")
  require("CommonResource_HeadDebrisByName")
end
split = function(s, delim, ...)
  -- function num : 0_0 , upvalues : type, s_len, s_find, t_insert, s_sub
  if type(delim) ~= "string" or s_len(delim) <= 0 then
    return 
  end
  local start = 1
  local t = {}
  while 1 do
    local pos = s_find(s, delim, start, true)
    if pos then
      do
        t_insert(t, s_sub(s, start, pos - 1))
        start = pos + s_len(delim)
        -- DECOMPILER ERROR at PC33: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC33: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  t_insert(t, s_sub(s, start))
  return t
end

local split = split
trim = function(s, ...)
  -- function num : 0_1 , upvalues : s_gsub
  return s_gsub(s, "^%s*(.-)%s*$", "%1")
end

checkIsMobile = function(str, ...)
  -- function num : 0_2 , upvalues : _ENV
  do return (string.match)(str, "[1][3,4,5,7,8]%d%d%d%d%d%d%d%d%d") == str end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

serialize = function(obj, ...)
  -- function num : 0_3 , upvalues : type, _ENV, s_fomat, pairs
  local lua = ""
  local t = type(obj)
  if t == "number" then
    lua = lua .. obj
  else
    if t == "boolean" then
      lua = lua .. tostring(obj)
    else
      if t == "string" then
        lua = lua .. s_fomat("%q", obj)
      else
        if t == "table" then
          lua = lua .. "{"
          for k,v in pairs(obj) do
            lua = lua .. "[" .. serialize(k) .. "]=" .. serialize(v) .. ","
          end
          local metatable = getmetatable(obj)
          if metatable ~= nil and type(metatable.__index) == "table" then
            for k,v in pairs(metatable.__index) do
              lua = lua .. "[" .. serialize(k) .. "]=" .. serialize(v) .. ","
            end
          end
          do
            do
              lua = lua .. "}"
              if t == "nil" then
                return nil
              else
                error("can not serialize a " .. t .. " type.")
              end
              return lua
            end
          end
        end
      end
    end
  end
end

unserialize = function(lua, ...)
  -- function num : 0_4 , upvalues : type, _ENV
  local t = type(lua)
  if t == "nil" or lua == "" then
    return nil
  else
    if t == "number" or t == "string" or t == "boolean" then
      lua = tostring(lua)
    else
      error("can not unserialize a " .. t .. " type.")
    end
  end
  lua = "return " .. lua
  local func = load(lua)
  if func == nil then
    return nil
  end
  return func()
end

local GetBaseWordData = TableData.GetBaseWordData
local GetBaseStoryWordData = TableData.GetBaseStoryWordData
local BaseTestWordData = (TableData.gTable).BaseTestWordData
local BaseClientWordData = (TableData.gTable).BaseClientWordData
PUtil = {}
-- DECOMPILER ERROR at PC55: Confused about usage of register: R16 in 'UnsetPending'

PUtil.get = function(id, ...)
  -- function num : 0_5 , upvalues : type, _ENV, BaseClientWordData, s_fomat, GetBaseWordData, GetBaseStoryWordData, BaseTestWordData
  if type(id) == "string" then
    id = tonumber(id)
  end
  if IsBattleServer == nil then
    local config = BaseClientWordData[id]
    if config then
      return s_fomat(config, ...)
    else
      config = GetBaseWordData(id)
      if config == nil then
        config = GetBaseStoryWordData(id)
        if config == nil then
          config = BaseTestWordData[id]
          if config == nil then
            return "未配置：" .. id
          end
        end
      end
      if config and config.name then
        return s_fomat(config.name, ...)
      end
    end
    return "未配置：" .. id
  else
    do
      do return "" end
    end
  end
end

local Util = {}
Util.InsertTable = function(t, element, isUnique, ...)
  -- function num : 0_6 , upvalues : pairs, _ENV, t_insert
  if t and element then
    if isUnique == true then
      local isFind = false
      for i,v in pairs(t) do
        if (table.equal)(v, element) == true then
          isFind = true
          break
        end
      end
      do
        do
          if isFind == false then
            t_insert(t, element)
          end
          t_insert(t, element)
        end
      end
    end
  end
end

Util.CopyOne = function(t2, t1, ...)
  -- function num : 0_7 , upvalues : type, pairs, Util
  if type(t1) == "table" then
    for k,v in pairs(t1) do
      if type(v) == "table" then
        local d2 = {}
        ;
        (Util.CopyOne)(d2, v)
        t2[k] = d2
      else
        do
          do
            t2[k] = v
            -- DECOMPILER ERROR at PC22: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC22: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC22: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
end

Util.Copy = function(t1, ...)
  -- function num : 0_8 , upvalues : Util
  local t2 = {}
  ;
  (Util.CopyOne)(t2, t1)
  return t2
end

Util.JumpTo = function(obj, position, interval, callBack, jump_y, moveCamera, ...)
  -- function num : 0_9 , upvalues : _ENV
  local LeanTween = LeanTween
  local LeanTweenType = LeanTweenType
  local BattleConfig = BattleConfig
  if obj == nil then
    return 0
  end
  ;
  (LeanTween.cancel)(obj)
  if not jump_y then
    jump_y = BattleConfig.cardJumpOffDefault
  end
  local curPosition = (CSLuaUtil.GetGOLocalPos)(obj)
  if not interval then
    interval = BattleConfig.maxMoveInterval
  end
  local middlePosition = (position + curPosition) / 2
  ;
  ((LeanTween.moveLocalX)(obj, position.x, interval)):setEase(LeanTweenType.linear)
  ;
  ((LeanTween.moveLocalZ)(obj, position.z, interval)):setOnComplete(callBack)
  local sequence = (LeanTween.sequence)()
  sequence:append(((LeanTween.moveLocalY)(obj, middlePosition.y + jump_y, interval / 2)):setEase(LeanTweenType.easeOutSine))
  sequence:append(((LeanTween.moveLocalY)(obj, position.y, interval / 2)):setEase(LeanTweenType.easeInSine))
  if moveCamera == true then
    return interval
  end
end

Util.MoveTo = function(obj, position, interval, callBack, moveCamera, ...)
  -- function num : 0_10 , upvalues : _ENV
  if obj == nil then
    return 0
  end
  local LeanTween = LeanTween
  local BattleConfig = BattleConfig
  ;
  (LeanTween.cancel)(obj)
  if not interval then
    interval = BattleConfig.maxMoveInterval
  end
  ;
  ((LeanTween.moveLocal)(obj, position, interval)):setOnComplete(callBack)
  if moveCamera == true then
    return interval
  end
end

Util.MoveCameraScreenCenter = function(time, ...)
  -- function num : 0_11 , upvalues : _ENV, Util
  time = 0.3
  local obj = (((Game.battleCamera).transform).parent).gameObject
  ;
  (LeanTween.cancel)(obj)
  ;
  (Util.ZoomBattleCamera)(Vector3.zero, time, BattleConfig.orthographicSize)
end

Util.ZoomBattleCamera = function(position, interval, targetSize, ...)
  -- function num : 0_12 , upvalues : _ENV, Util
  local BattleConfig = BattleConfig
  local battleCamera = Game.battleCamera
  local moveY = (math.max)(position.y, 0)
  if not targetSize then
    local targetSize = BattleConfig.orthographicSize + BattleConfig.battleCameraSizeChange
  end
  ;
  (Util.SetCameraOrthographicSize)(battleCamera, targetSize, interval)
  ;
  (Util.MoveBattleCamera)(Vector3(position.x, moveY, 0), interval)
end

Util.MoveBattleCamera = function(position, interval, isRelative, leanTweenType, ...)
  -- function num : 0_13 , upvalues : _ENV, require
  local battleCamera = Game.battleCamera
  local CameraMove = require("CameraMove")
  if not leanTweenType then
    (CameraMove.GoNowCamera)(battleCamera, position, interval, LeanTweenType.easeInSine, nil, isRelative)
  end
end

Util.FloatUpTo = function(obj, position, interval, callBack, ...)
  -- function num : 0_14 , upvalues : _ENV
  (LeanTween.cancel)(obj)
  local maxHeightPosition = position + BattleConfig.floatUpMaxAdd
  if not interval then
    interval = BattleConfig.floatUpInterval
  end
  local ltDescr = (((LeanTween.moveLocal)(obj, maxHeightPosition, interval)):setEase(LeanTweenType.easeOutSine)):setOnComplete(callBack)
  return ltDescr
end

Util.FloatDownTo = function(obj, position, interval, callBack, ...)
  -- function num : 0_15 , upvalues : _ENV
  (LeanTween.cancel)(obj)
  if not interval then
    interval = BattleConfig.floatDownInterval
  end
  local ltDescr = (((LeanTween.moveLocal)(obj, position, interval)):setEase(LeanTweenType.easeInSine)):setOnComplete(callBack)
  return ltDescr
end

Util.SetCameraActive = function(camera, active, ...)
  -- function num : 0_16
  if camera and camera.activeSelf ~= active then
    camera:SetActive(active)
  end
end

Util.SetCameraCullingMask = function(camera, cullingMask, ...)
  -- function num : 0_17
  if camera then
    local lCamera = camera:GetComponent("Camera")
    lCamera.cullingMask = cullingMask
  end
end

Util.SetCameraOrthographicSize = function(cameraObject, orthographicSize, interval, isRelative, ...)
  -- function num : 0_18 , upvalues : _ENV
  local camera = (cameraObject.transform):GetComponent(typeof(Camera))
  if camera then
    if interval == nil then
      if isRelative == true then
        camera.orthographicSize = camera.orthographicSize + orthographicSize
      else
        camera.orthographicSize = orthographicSize
      end
    else
      if isRelative == true then
        local oriValue = camera.orthographicSize
        do
          (((LeanTween.value)(0, orthographicSize, interval)):setEase(LeanTweenType.easeInSine)):setOnUpdate(function(value, camera, ...)
    -- function num : 0_18_0 , upvalues : oriValue
    camera.orthographicSize = oriValue + value
  end
, camera)
        end
      else
        do
          local oriValue = camera.orthographicSize
          ;
          (((LeanTween.value)(oriValue, orthographicSize, interval)):setEase(LeanTweenType.easeInSine)):setOnUpdate(function(value, camera, ...)
    -- function num : 0_18_1
    camera.orthographicSize = value
  end
, camera)
        end
      end
    end
  end
end

Util.GetItemUrl = function(resStr, ...)
  -- function num : 0_19 , upvalues : Util
  return (Util.GetResUrl)(resStr)
end

Util.GetResUrl = function(resStr, ...)
  -- function num : 0_20 , upvalues : split, _ENV
  local resStrTable = split(resStr, ":")
  if resStrTable and #resStrTable > 1 then
    return UIMgr:GetItemUrl(resStrTable[1], resStrTable[2])
  end
end

Util.ExchangeLuatableData = function(mTable, index, index2, ...)
  -- function num : 0_21 , upvalues : Util
  if mTable == nil then
    return 
  end
  local first = (Util.clone)(mTable[index])
  local second = (Util.clone)(mTable[index2])
  if first == nil or second == nil then
    return 
  end
  mTable[index] = second
  mTable[index2] = first
end

Util.clone = function(object, ...)
  -- function num : 0_22 , upvalues : type, pairs, _ENV
  local lookup_table = {}
  local _copy = function(object, ...)
    -- function num : 0_22_0 , upvalues : type, lookup_table, pairs, _copy, _ENV
    if type(object) ~= "table" then
      return object
    else
      if lookup_table[object] then
        return lookup_table[object]
      end
    end
    local new_table = {}
    lookup_table[object] = new_table
    for key,value in pairs(object) do
      new_table[_copy(key)] = _copy(value)
    end
    return setmetatable(new_table, getmetatable(object))
  end

  return _copy(object)
end

Util.GetGroupDate = function(uis, group, pos, ...)
  -- function num : 0_23 , upvalues : t_insert
  local list = {}
  for i = 1, uis.numChildren do
    local temp = uis:GetChildAt(i - 1)
    if temp.group == group then
      t_insert(list, temp)
    end
  end
  return list[pos]
end

Util.SetSquareCardInfo = function(uis, cData, notShowStar, ...)
  -- function num : 0_24 , upvalues : t_insert, _ENV, split, pairs
  local icon = uis.IconLoader
  local lvlTxt = uis.LevelTxt
  local stageTxt = uis.StageTxt
  if not notShowStar then
    notShowStar = false
  end
  local stars = {}
  t_insert(stars, uis.Star_01_smallImage)
  t_insert(stars, uis.Star_02_smallImage)
  t_insert(stars, uis.Star_03_smallImage)
  t_insert(stars, uis.Star_04_smallImage)
  t_insert(stars, uis.Star_05_smallImage)
  t_insert(stars, uis.Star_06_smallImage)
  t_insert(stars, uis.Star_07_smallImage)
  if cData.url ~= icon.url and icon ~= nil then
    icon.url = cData.url
  end
  if cData.level == -1 then
    lvlTxt.visible = false
  else
    lvlTxt.visible = true
    lvlTxt.text = "Lv." .. cData.level
  end
  if cData.stage == -1 or notShowStar then
    stageTxt.visible = false
    -- DECOMPILER ERROR at PC60: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (uis.c2Ctr).selectedIndex = 0
  else
    stageTxt.visible = true
    stageTxt.text = cData.stage
    local preUpStageData = (CardMgr.GetBaseCardQualityData)(cData.stage, cData.id)
    local levelShow = split(preUpStageData.level_show, ":")
    -- DECOMPILER ERROR at PC78: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (uis.c2Ctr).selectedIndex = tonumber(levelShow[1])
  end
  do
    local cardData = ((TableData.gTable).BaseCardData)[cData.id]
    -- DECOMPILER ERROR at PC87: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (uis.QualityCtrlCtr).selectedIndex = cardData.intelligence + 1
    local star = cData.star
    for i,v in pairs(stars) do
      v.visible = false
    end
    if notShowStar == false then
      for i = 1, star do
        -- DECOMPILER ERROR at PC103: Confused about usage of register: R13 in 'UnsetPending'

        (stars[i]).visible = true
      end
    end
  end
end

Util.ParseConfigStr = function(str, delim_1, delim_2, ...)
  -- function num : 0_25 , upvalues : split, ipairs, t_insert
  local mTable = {}
  local configs = split(str, delim_1 or ",")
  for _,v in ipairs(configs) do
    local data = split(v, delim_2 or ":")
    t_insert(mTable, data)
  end
  return mTable
end

Util.GetConfigDataByID = function(itemId, ...)
  -- function num : 0_26 , upvalues : _ENV
  local tonumber = tonumber
  local config = ((TableData.gTable).BasePropData)[tonumber(itemId)]
  if config ~= nil then
    return config, PropType.ITEM
  end
  config = ((TableData.gTable).BaseAssetData)[tonumber(itemId)]
  if config ~= nil then
    return config, PropType.ASSET
  end
  config = ((TableData.gTable).BaseCardData)[tonumber(itemId)]
  if config ~= nil then
    return config, PropType.CARD
  end
  config = ((TableData.gTable).BaseEquipData)[tonumber(itemId)]
  if config ~= nil then
    return config, PropType.EQUIP
  end
  config = ((TableData.gTable).BasePlayerTitleData)[tonumber(itemId)]
  if config ~= nil then
    return config, PropType.TITLE
  end
end

Util.IsTableEqual = function(table1, table2, ...)
  -- function num : 0_27 , upvalues : pairs, type, Util
  for i,v1 in pairs(table1) do
    local v2 = table2[i]
    if type(v1) == "table" and type(v2) == "table" then
      local isEqual = (Util.IsTableEqual)(v1, v2)
      if isEqual == false then
        return false
      end
    else
      do
        do
          if v1 ~= v2 then
            return false
          end
          -- DECOMPILER ERROR at PC28: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC28: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC28: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  for i,v1 in pairs(table2) do
    local v2 = table1[i]
    if type(v1) == "table" and type(v2) == "table" then
      local isEqual = (Util.IsTableEqual)(v1, v2)
      if isEqual == false then
        return false
      end
    else
      do
        do
          if v1 ~= v2 then
            return false
          end
          -- DECOMPILER ERROR at PC58: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC58: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC58: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  return true
end

Util.SetHeadFrameByOneCard = function(headFrame, oneCard, isRobot, ...)
  -- function num : 0_28 , upvalues : Util
  local cardInfo = {}
  cardInfo.id = oneCard.id
  cardInfo.quality = oneCard.quality
  cardInfo.level = oneCard.level
  cardInfo.star = oneCard.star
  cardInfo.fashionId = oneCard.fashionId
  ;
  (Util.SetHeadFrame)(headFrame, cardInfo, isRobot)
end

Util.SetShowHeadFrame = function(headFrame, cardId, isFirst, star, changeDebris, ...)
  -- function num : 0_29 , upvalues : _ENV, split, Util
  local cardConfig = ((TableData.gTable).BaseCardData)[cardId]
  local cardInfo = {id = cardId, level = cardConfig.level, star = cardConfig.star, quality = cardConfig.quality}
  ;
  (headFrame:GetChild("IconLoader")).url = (CardMgr.GetHeadIconSquareUrl)(cardInfo)
  ;
  (headFrame:GetController("QualityCtrl")).selectedIndex = cardConfig.intelligence + 1
  ;
  (headFrame:GetChild("LevelTxt")).text = ""
  local config = ((TableData.gTable).BaseCardData)[cardId]
  if star == nil or star <= 0 then
    star = config.star
  end
  for i = 1, Const.MaxRoleStar do
    (headFrame:GetChild("Star_0" .. tostring(i) .. "_smallImage")).visible = i <= star
  end
  if isFirst then
    (headFrame:GetController("c4")).selectedIndex = 1
  else
    (headFrame:GetController("c4")).selectedIndex = 0
  end
  ;
  (headFrame:GetChild("StageTxt")).visible = false
  if changeDebris then
    (headFrame:GetController("c5")).selectedIndex = 1
    local debris = split(cardConfig.debris_goods, ":")
    local PropData = ((TableData.gTable).BasePropData)[tonumber(debris[2])]
    ;
    ((headFrame:GetChild("n206")):GetChild("IconLoader")).url = (Util.GetItemUrl)(PropData.icon)
    ;
    ((headFrame:GetChild("n206")):GetController("c1")).selectedIndex = cardConfig.intelligence - 1
  else
    (headFrame:GetController("c5")).selectedIndex = 0
  end
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

Util.SetHeadFrame = function(headFrame, cardInfo, isRobot, ...)
  -- function num : 0_30 , upvalues : _ENV, split, Util
  if headFrame == nil or cardInfo == nil then
    return 
  end
  ;
  (LuaSound.SetClickSound)(headFrame, LuaSound.COMMON_ROLE_CLICK)
  if not isRobot then
    isRobot = false
  end
  local level = 1
  local star = 1
  local quality = 1
  local config, fashionID = nil, nil
  if isRobot then
    config = (TableData.GetBaseMonsterData)(cardInfo.id)
    if config then
      level = config.level
      star = config.star
      quality = config.quality
      local qualityData = split(config.quality_show, ":")
      ;
      (headFrame:GetController("c2")).selectedIndex = tonumber(qualityData[1])
      ;
      (headFrame:GetController("QualityCtrl")).selectedIndex = config.intelligence + 1
      fashionID = config.unlock_fashion_id
      config = ((TableData.gTable).BaseFashionData)[fashionID]
      if config ~= nil then
        (headFrame:GetChild("IconLoader")).url = (Util.GetItemUrl)(config.head_icon_square)
      else
        ;
        (headFrame:GetChild("IconLoader")).url = nil
        loge("怪物:" .. tostring(cardInfo.id) .. " 时装ID配置有误:" .. tostring(fashionID))
      end
    end
  else
    do
      level = cardInfo.level
      star = cardInfo.star
      quality = cardInfo.quality
      fashionID = cardInfo.fashionId
      local BaseConfig = ((TableData.gTable).BaseCardData)[cardInfo.id]
      if fashionID and fashionID > 0 then
        config = ((TableData.gTable).BaseFashionData)[fashionID]
        ;
        (headFrame:GetChild("IconLoader")).url = (Util.GetItemUrl)(config.head_icon_square)
      else
        ;
        (headFrame:GetChild("IconLoader")).url = (CardMgr.GetHeadIconSquareUrl)(cardInfo)
      end
      local preUpStageData = (CardMgr.GetBaseCardQualityData)(quality, cardInfo.id)
      do
        local levelShow = split(preUpStageData.level_show, ":")
        ;
        (headFrame:GetController("c2")).selectedIndex = tonumber(levelShow[1])
        ;
        (headFrame:GetController("QualityCtrl")).selectedIndex = BaseConfig.intelligence + 1
        ;
        (headFrame:GetChild("LevelTxt")).text = "Lv." .. level
        for i = 1, Const.MaxRoleStar do
          (headFrame:GetChild("Star_0" .. tostring(i) .. "_smallImage")).visible = i <= star
        end
        local stageTxt = headFrame:GetChild("StageTxt")
        if quality == 0 then
          stageTxt.visible = false
        else
          stageTxt.visible = true
          stageTxt.text = quality
        end
        -- DECOMPILER ERROR: 3 unprocessed JMP targets
      end
    end
  end
end

Util.CreateHeadFrameByID = function(cardId, ...)
  -- function num : 0_31 , upvalues : _ENV, Util
  local CardData = (CardData.GetCardData)(cardId)
  if CardData then
    local card = UIMgr:CreateObject("CommonResource", "HeadFrame")
    ;
    (Util.SetHeadFrame)(card, CardData)
    return card
  end
end

Util.CheckCondition = function(condition, notShowMessage, ...)
  -- function num : 0_32 , upvalues : _ENV, Util, ipairs
  local ConditionType = ConditionType
  local condition = (Util.ParseConfigStr)(condition)
  for _,v in ipairs(condition) do
    local conditionID = tonumber(v[1])
    local conditionType = tonumber(v[2])
    local conditionValue = tonumber(v[3])
    local config = ((TableData.gTable).BaseConditionData)[tonumber(conditionID)]
    if conditionID == ConditionType.PASS_NORMAL_DUNGEON then
      print("通关普通副本")
      if not (PlotDungeonMgr.IsPassDungeon)(conditionType) then
        do
          if notShowMessage ~= true then
            local stageData = ((TableData.gTable).BaseStageData)[conditionType]
            ;
            (MessageMgr.SendCenterTips)((PUtil.get)(20000033, stageData.remark))
          end
          do return false end
          if conditionID == ConditionType.PLAYER_LEVEL and not (Util.CompareNum)(config.judge, (ActorData.GetLevel)(), conditionValue) then
            if notShowMessage ~= true then
              (MessageMgr.SendCenterTips)((PUtil.get)(20000037, conditionValue))
            end
            return false, conditionValue
          end
          if conditionID == ConditionType.PASS_GOLD_TRIAL or conditionID == ConditionType.PASS_EXP_TRIAL or conditionID == ConditionType.PASS_EQUIP_TRIAL then
            print("每日副本")
            if not (DailyDungeonData.IsTrialStagePass)(conditionType) then
              if notShowMessage ~= true then
                (MessageMgr.SendCenterTips)((PUtil.get)(40002010))
              end
              return false, conditionValue
            end
          else
            if conditionID == ConditionType.INTIMACY_LEVEL then
              local intimacyLv = ((CardData.GetCardData)(conditionType)).intimacyLv
              local isCondition = conditionValue <= intimacyLv
              if not isCondition and not notShowMessage then
                (MessageMgr.SendCenterTips)((PUtil.get)(20000261, conditionValue))
              end
              return isCondition
            end
          end
          -- DECOMPILER ERROR at PC135: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC135: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC135: LeaveBlock: unexpected jumping out IF_STMT

          -- DECOMPILER ERROR at PC135: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC135: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  do return true end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

Util.CompareNum = function(symbol, Num1, Num2, ...)
  -- function num : 0_33 , upvalues : _ENV
  local num1 = tonumber(Num1)
  local num2 = tonumber(Num2)
  if num2 >= num1 then
    do return symbol ~= 1 end
    if num1 ~= num2 then
      do return symbol ~= 2 end
      if num1 >= num2 then
        do return symbol ~= 3 end
        if num1 > num2 then
          do return symbol ~= 4 end
          if num2 > num1 then
            do return symbol ~= 5 end
            -- DECOMPILER ERROR: 10 unprocessed JMP targets
          end
        end
      end
    end
  end
end

Util.CovertRivalCardStateToLocal = function(formation, ...)
  -- function num : 0_34
  local localFormation = {}
  local count = #formation
  local data = nil
  for i = 1, count do
    data = formation[i]
    localFormation[(formation[i]).pos] = data
    data.spd = data.speed
  end
  return localFormation
end

Util.CovertRemoteFormationToLocal = function(formation, ...)
  -- function num : 0_35
  local localFormation = {}
  local count = #formation
  for i = 1, count do
    if (formation[i]).id ~= 0 then
      localFormation[(formation[i]).value] = (formation[i]).id
    end
  end
  return localFormation
end

Util.CovertLoaclFormationToRemote = function(formation, ...)
  -- function num : 0_36 , upvalues : _ENV, t_insert
  local remoteFormation = {}
  for i = 1, Const.FormationMaxCount do
    local subTable = {}
    if formation[i] then
      subTable.id = formation[i]
    else
      subTable.id = 0
    end
    subTable.value = i
    t_insert(remoteFormation, subTable)
  end
  return remoteFormation
end

Util.CovertMonsterFormationToLocal = function(monsterGroupId, ...)
  -- function num : 0_37 , upvalues : _ENV, split
  local formation = {}
  local battle = ((TableData.gTable).BaseMonsterGroupData)[monsterGroupId]
  if battle ~= nil then
    local monsters = split(battle.monster_list, ":")
    for i = 1, Const.FormationMaxCount do
      if tonumber(monsters[i]) == 0 then
        formation[i] = nil
      else
        formation[i] = monsters[i]
      end
    end
  end
  do
    return formation
  end
end

Util.BeforeCloseFormation = function(formation, cb, formationGetter, formationSetter, ...)
  -- function num : 0_38 , upvalues : pairs, _ENV
  local savedFormation, tips = nil, nil
  local same = true
  local backup = {}
  savedFormation = formationGetter()
  for k,v in pairs(formation) do
    backup[k] = v
    if savedFormation[k] ~= nil then
      if savedFormation[k] ~= v then
        same = false
      else
        savedFormation[k] = nil
        formation[k] = nil
      end
    else
      same = false
    end
  end
  if same then
    if (_G.next)(savedFormation) ~= nil then
      same = false
    end
    if (_G.next)(formation) ~= nil then
      same = false
    end
  end
  if same == false then
    (MessageMgr.OpenConfirmWindow)((PUtil.get)(tips), function(...)
    -- function num : 0_38_0 , upvalues : formationSetter, backup, cb
    formationSetter(backup)
    cb()
  end
, cb)
  else
    cb()
  end
end

Util.GetFCByFomation = function(formation, ...)
  -- function num : 0_39 , upvalues : _ENV
  local fc = 0
  local oneCard, cardData = nil, nil
  for i = 1, Const.FormationMaxCount do
    if formation[i] ~= nil and (formation[i]).id ~= 0 then
      cardData = (CardData.GetCardData)((formation[i]).id)
      if cardData ~= nil then
        fc = fc + cardData.fc
      end
    end
  end
  return fc
end

Util.GetModelByspdName = function(name, skin, isAsync, callBack, ...)
  -- function num : 0_40 , upvalues : _ENV, Util
  isAsync = false
  if isAsync == true then
    (ResHelper.AsyncInstantiateModel)(name, nil, function(go, ...)
    -- function num : 0_40_0 , upvalues : Util, skin, _ENV, callBack
    if (Util.StringIsNullOrEmpty)(skin) == false then
      (SkeletonAnimationUtil.SetSkin)(go, skin)
    end
    if callBack ~= nil then
      callBack(go)
    end
  end
)
  else
    local model = (ResHelper.InstantiateModel)(name)
    if (Util.StringIsNullOrEmpty)(skin) == false then
      (SkeletonAnimationUtil.SetSkin)(model, skin)
    end
    if callBack then
      callBack(model)
    end
    if (Util.IsNil)(model) then
      return 
    end
    if (Util.IsNil)(model:GetComponent(typeof((CS.UnityEngine).MeshRenderer))) == false then
      local materials = (model:GetComponent(typeof((CS.UnityEngine).MeshRenderer))).materials
      local count = materials.Length - 1
      for i = 0, count do
        local mat = materials[i]
        mat:SetFloat("_StencilComp", 8)
        mat:SetFloat("_Stencil", 2)
      end
    end
    do
      do return model end
    end
  end
end

Util.ShowUIModelByFashionId = function(id, quality, fashionId, loader, isAsync, callback, ...)
  -- function num : 0_41 , upvalues : _ENV, Util
  isAsync = false
  local config = (CardData.GetFashionConfig)({id = id, quality = quality, fashionId = fashionId})
  return (Util.ShowUIModel)(config.spd_bundle, loader, config.show_spine_type, isAsync, callback)
end

Util.ShowUIModel = function(rolePath, loader, skin, isAsync, callBack, isPlayEffect, nextShow, withRT, ...)
  -- function num : 0_42 , upvalues : _ENV, s_find, Util
  isAsync = false
  if rolePath == nil then
    return 
  end
  if tonumber(rolePath) ~= nil or s_find(rolePath, "img_") ~= nil then
    local texture = (ResHelper.LoadTexture)(rolePath)
    if texture ~= nil then
      loader.texture = (FairyGUI.NTexture)(texture)
    end
    ;
    (loader.image):SetSkipFairyBatching(false)
    return (loader.image).gameObject
  else
    do
      if isAsync == true then
        (loader.image):SetSkipFairyBatching(true)
        ;
        (Util.GetModelByspdName)(rolePath, skin, isAsync, function(model, ...)
    -- function num : 0_42_0 , upvalues : Util, rolePath, loader, isPlayEffect, nextShow, withRT, callBack
    if model ~= nil then
      (Util.AfterModelLoaded)(rolePath, loader, model, isPlayEffect, nextShow, withRT)
      if callBack then
        callBack(model)
      end
    end
    return model
  end
)
      else
        local model = (Util.GetModelByspdName)(rolePath, skin, isAsync, nil)
        if model ~= nil then
          (Util.AfterModelLoaded)(rolePath, loader, model, isPlayEffect, nextShow, withRT)
        end
        if callBack then
          callBack(model)
        end
        return model
      end
    end
  end
end

Util.AfterModelLoaded = function(rolePath, loader, model, isPlayEffect, nextShow, withRT, ...)
  -- function num : 0_43 , upvalues : s_find, _ENV, Util
  if s_find(rolePath, "l2d") ~= nil then
    local CubismRenderController = (((CS.Live2D).Cubism).Rendering).CubismRenderController
    if withRT then
      ((CS.RTManager).Singleton):ShowModelToLoader(loader, model)
      loader:SetLive2DWithRT(((model.transform):GetChild(0)):GetComponent(typeof(CubismRenderController)))
    else
      ;
      (CSLuaUtil.ChangeLayer)(model.transform, "UI")
      loader:SetModelRender(((model.transform):GetChild(0)):GetComponent(typeof(CubismRenderController)))
    end
  else
    do
      local Renderer = (CS.UnityEngine).Renderer
      do
        local render = model:GetComponent(typeof(Renderer))
        if (Util.IsNil)(render) then
          render = model:GetComponentInChildren(typeof(Renderer))
        end
        if withRT then
          ((CS.RTManager).Singleton):ShowModelToLoader(loader, model)
          loader:SetSpineWithRT(render)
        else
          ;
          (CSLuaUtil.ChangeLayer)(model.transform, "UI")
          loader:SetModelRender(render, model.transform)
        end
        ;
        (render.sharedMaterial):EnableKeyword("_STRAIGHT_ALPHA_INPUT")
        if isPlayEffect then
          (Util.AppearEffect)(loader)
        end
        if nextShow then
          (loader.image):SetSkipFairyBatching(true)
          local scale = (((loader.displayObject).cachedTransform).lossyScale).x / Const.DefaultUIScale
          ;
          (CSLuaUtil.SetGOScale)(model, scale, scale, scale, true)
        end
      end
    end
  end
end

Util.AppearEffect = function(loader, ...)
  -- function num : 0_44
end

Util.SetModelClip = function(loader, com, enable, ...)
  -- function num : 0_45 , upvalues : _ENV
  if loader == nil or loader.Model == nil then
    return 
  end
  local sa = (loader.Model):GetComponent(typeof(((CS.Spine).Unity).SkeletonAnimation))
  if enable == false then
    sa:SetMaterial(nil)
  else
    local render = (loader.Model):GetComponent(typeof((CS.UnityEngine).Renderer))
    local mat = render.materials
    local count = mat.Length
    for i = 0, count - 1 do
      if com.reversedMask then
        (mat[i]):SetFloat(((FairyGUI.ShaderConfig).IDs)._StencilComp, 6)
      else
        ;
        (mat[i]):SetFloat(((FairyGUI.ShaderConfig).IDs)._StencilComp, 3)
      end
      ;
      (mat[i]):SetFloat(((FairyGUI.ShaderConfig).IDs)._Stencil, 1)
    end
    sa:SetMaterial(mat)
  end
end

Util.SetSfxClipInList = function(sfx, list, ...)
  -- function num : 0_46 , upvalues : _ENV, Util
  if sfx == nil then
    return 
  end
  local renderS = sfx:GetComponentsInChildren(typeof((CS.UnityEngine).Renderer))
  local count = renderS.Length
  for i = 0, count - 1 do
    local render = renderS[i]
    local mat = render.material
    mat:EnableKeyword("CLIPPED")
    mat:SetFloat(((FairyGUI.ShaderConfig).IDs)._BlendSrcFactor, 5)
    mat:SetVector(((FairyGUI.ShaderConfig).IDs)._ClipBox, (Util.GetListClipArea)(list))
  end
end

Util.GetComponentArea = function(com, ...)
  -- function num : 0_47 , upvalues : _ENV, Util
  if com == nil then
    return 
  end
  local rect = ((com.parent).displayObject):TransformRect((((CS.UnityEngine).Rect)(com.x, com.y, com.width, com.height)), nil)
  return (Util.GetRectClipArea)(rect)
end

Util.GetListClipArea = function(list, ...)
  -- function num : 0_48 , upvalues : Util
  if list == nil then
    return 
  end
  local rect = ((list.scrollPane).MaskContainer):TransformRect(((list.scrollPane).MaskContainer).clipRect, nil)
  return (Util.GetRectClipArea)(rect)
end

Util.GetRectClipArea = function(rect, ...)
  -- function num : 0_49 , upvalues : _ENV
  local Vector4 = (CS.UnityEngine).Vector4
  rect.x = rect.x + rect.width / 2
  rect.y = rect.y + rect.height / 2
  rect.width = rect.width / 2
  rect.height = rect.height / 2
  return Vector4(-rect.x / rect.width, -rect.y / rect.height, 1 / rect.width, 1 / rect.height)
end

Util.CreateSelfMiniModel = function(loader, callback, ...)
  -- function num : 0_50 , upvalues : Util, _ENV
  if loader then
    (Util.CreateMiniModel)(loader, (ActorData.GetFashionShow)(), callback)
  end
end

Util.CreateMiniModelByPath = function(loader, path, callback, IsFlipX, ...)
  -- function num : 0_51 , upvalues : Util, _ENV
  return (Util.ShowUIModel)(path, loader, nil, true, function(model, ...)
    -- function num : 0_51_0 , upvalues : IsFlipX, _ENV, callback
    if model then
      if IsFlipX then
        (SkeletonAnimationUtil.SetFlip)(model, true, false)
      end
      ;
      (CSLuaUtil.SetGOScale)(model, 20, 20, 20)
      ;
      (SkeletonAnimationUtil.SetAnimation)(model, 0, "idle", true, nil, true)
      if callback ~= nil then
        callback(model)
      end
    end
  end
)
end

Util.CreateMiniModel = function(loader, fashionId, callback, IsFlipX, ...)
  -- function num : 0_52 , upvalues : _ENV, Util
  local fashionData = ((TableData.gTable).BaseFashionData)[fashionId]
  if fashionData == nil then
    return 
  end
  ;
  (Util.CreateMiniModelByPath)(loader, fashionData.spd_bundle, callback, IsFlipX)
end

Util.CreateNo3rdSelfShowModel = function(loader, ...)
  -- function num : 0_53 , upvalues : _ENV, Util
  local fashionShow = (ActorData.GetFashionShow)()
  local fashionData = ((TableData.gTable).BaseFashionData)[fashionShow]
  local cardData = (CardData.GetCardData)(fashionData.card_id)
  local isStatic = (Util.GetPlayerSetting)(cardData.id .. "Static", "0")
  local fashionConfig = ((CardData.GetFashionConfig)(cardData))
  local obj = nil
  if isStatic == "0" then
    obj = (Util.CreateShowModel)(fashionConfig.id, loader, false, nil, nil, true)
    ;
    (loader.image):SetSkipFairyBatching(true)
  else
    local t_Object = (Util.ShowUIModel)(fashionConfig.show_texture, loader)
    obj = t_Object
    ;
    (Util.UpdateShowTextureByConfig)(t_Object, fashionConfig)
  end
end

Util.CreateSelfShowModel = function(loader, showFinal, ...)
  -- function num : 0_54 , upvalues : _ENV, Util
  if loader then
    local fashionShow = (ActorData.GetFashionShow)()
    return (Util.CreateShowModel)(fashionShow, loader, showFinal)
  end
end

Util.CreateShowModel = function(fashionId, loader, showFinalSpine, isAsync, doNotPlayIn, isPlayEffect, param, ...)
  -- function num : 0_55 , upvalues : _ENV, Util
  isAsync = false
  local fashionData = ((TableData.gTable).BaseFashionData)[fashionId]
  if fashionData == nil then
    return 
  end
  local spine_Final = fashionData.show_spine_Final
  if not showFinalSpine and spine_Final and spine_Final > 0 then
    fashionData = ((TableData.gTable).BaseFashionData)[spine_Final]
    if fashionData == nil then
      loge("替换fashionID未找到" .. spine_Final)
      return 
    end
  end
  do
    if fashionData.show_spine == nil and fashionData.show_texture then
      local t_Object = (Util.ShowUIModel)(fashionData.show_texture, loader)
      ;
      (Util.UpdateShowTextureByConfig)(t_Object, fashionData)
      return t_Object
    end
    local SetAnimation = SkeletonAnimationUtil.SetAnimation
    if isAsync then
      (Util.ShowUIModel)(fashionData.show_spine, loader, fashionData.show_spine_type, true, function(model, ...)
    -- function num : 0_55_0 , upvalues : Util, fashionData, SetAnimation
    (Util.UpdateShowSpineByConfig)(model, fashionData)
    if model then
      SetAnimation(model, 0, "idle", true)
    end
  end
, isPlayEffect)
    else
      local model = (Util.ShowUIModel)(fashionData.show_spine, loader, fashionData.show_spine_type, nil, nil, isPlayEffect)
      if param then
        (Util.UpdateShowSpineByConfig)(model, fashionData, param.isRight)
        if model then
          SetAnimation(model, 0, "idle", true)
        end
        do return model end
      end
    end
  end
end

Util.CreateAutoFitModel = function(fashionId, loader, showFinalSpine, isAsync, doNotPlayIn, isPlayEffect, param, ...)
  -- function num : 0_56 , upvalues : _ENV, Util, split
  isAsync = false
  local fashionData = ((TableData.gTable).BaseFashionData)[fashionId]
  if fashionData == nil then
    return 
  end
  local spine_Final = fashionData.show_spine_Final
  if not showFinalSpine and spine_Final and spine_Final > 0 then
    fashionData = ((TableData.gTable).BaseFashionData)[spine_Final]
    if fashionData == nil then
      loge("替换fashionID未找到" .. spine_Final)
      return 
    end
  end
  do
    if fashionData.show_spine == nil and fashionData.show_texture then
      local t_Object = (Util.ShowUIModel)(fashionData.show_texture, loader)
      return t_Object
    end
    local SetAnimation = SkeletonAnimationUtil.SetAnimation
    if isAsync then
      (Util.ShowUIModel)(fashionData.show_spine, loader, fashionData.show_spine_type, true, function(model, ...)
    -- function num : 0_56_0 , upvalues : SetAnimation
    if model then
      SetAnimation(model, 0, "idle", true)
    end
  end
, isPlayEffect)
    else
      local model = (Util.ShowUIModel)(fashionData.show_spine, loader, fashionData.show_spine_type, nil, nil, isPlayEffect)
      local scale = fashionData.show_spine_scale / 10000
      ;
      (CSLuaUtil.SetGOScale)(model, param and param.isRight and -scale or scale, scale, scale)
      do
        if (Util.StringIsNullOrEmpty)(fashionData.show_texture_size) == false then
          local size = split(fashionData.show_texture_size, ":")
          loader:SetModelSize(tonumber(size[1]), tonumber(size[2]))
        end
        if model then
          SetAnimation(model, 0, "idle", true)
        end
        do return model end
      end
    end
  end
end

Util.RecycleUIModel = function(loader, destroy, ...)
  -- function num : 0_57 , upvalues : _ENV, Util
  -- DECOMPILER ERROR at PC14: Unhandled construct in 'MakeBoolean' P1

  if loader.CurrentResType == ((FairyGUI.GLoader).ResType).Texture and loader.texture ~= nil then
    (ResHelper.UnloadTexture)((loader.texture).nativeTexture)
    loader.texture = nil
  end
  if (Util.IsNil)(loader.Model) == false then
    local meshRender = ((loader.Model).gameObject):GetComponent(typeof((CS.UnityEngine).MeshRenderer))
    if (Util.IsNil)(meshRender) == false then
      local materials = meshRender.materials
      if materials then
        local count = materials.Length - 1
        for i = 0, count do
          local mat = materials[i]
          mat:SetFloat("_StencilComp", 8)
          mat:SetFloat("_Stencil", 0)
        end
        local sa = ((loader.Model).gameObject):GetComponent(typeof(((CS.Spine).Unity).SkeletonAnimation))
        if sa then
          sa:SetMaterial(materials)
        end
      end
    end
    do
      do
        ;
        (CSLuaUtil.ChangeLayer)((loader.Model).transform, "Default")
        loader.alpha = 1
        ;
        (ResHelper.DestroyGameObject)((loader.Model).gameObject, not destroy)
        loader:RemoveModelRender()
        if loader.CurrentResType == ((FairyGUI.GLoader).ResType).Live2DWithRT or loader.CurrentResType == ((FairyGUI.GLoader).ResType).SpineWithRT then
          ((CS.RTManager).Singleton):ReleaseModelFromLoader(loader)
        end
        if loader.CurrentResType == ((FairyGUI.GLoader).ResType).Live2DWithRT or loader.CurrentResType == ((FairyGUI.GLoader).ResType).SpineWithRT then
          ((CS.RTManager).Singleton):ReleaseModelFromLoader(loader)
        end
      end
    end
  end
end

Util.UpdateShowSpineByConfig = function(model, fashionConfig, isRight, ...)
  -- function num : 0_58 , upvalues : _ENV, split
  if model == nil or fashionConfig == nil then
    return 
  end
  local scale = fashionConfig.show_spine_scale / 10000
  ;
  (CSLuaUtil.SetGOScale)(model, isRight == true and -scale or scale, scale, scale)
  local positionTable = (split(fashionConfig.show_spine_position, ":"))
  local x = nil
  if isRight == true then
    x = -tonumber(positionTable[1])
  else
    x = tonumber(positionTable[1])
  end
  ;
  (CSLuaUtil.MoveGoLocalPos)(model, x, tonumber(positionTable[2]), tonumber(positionTable[3]))
end

Util.UpdateShowTextureByConfig = function(textureObj, fashionConfig, ...)
  -- function num : 0_59 , upvalues : _ENV, split
  if textureObj == nil or fashionConfig == nil then
    return 
  end
  local scale = fashionConfig.show_texture_scale / 10000
  ;
  (CSLuaUtil.SetGOScale)(textureObj, scale, scale, scale)
  local positionTable = split(fashionConfig.show_texture_position, ":")
  ;
  (CSLuaUtil.MoveGoLocalPos)(textureObj, tonumber(positionTable[1]), tonumber(positionTable[2]), tonumber(positionTable[3]))
end

Util.CheckNullString = function(str, ...)
  -- function num : 0_60 , upvalues : Util
  do return str ~= "0" and (Util.StringIsNullOrEmpty)(str) end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

Util.StringIsNullOrEmpty = function(str, ...)
  -- function num : 0_61
  do return str == nil or str == "" or str == "\000" end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Util.GetUrlFromItemID = function(itemID, itemType, ...)
  -- function num : 0_62 , upvalues : _ENV, Util
  if itemID == nil or itemType == nil then
    print("Error Input", itemID, itemType)
    return ""
  end
  local config = (Util.GetConfigByItemIDAndType)(itemID, itemType)
  if config ~= nil then
    local icon = config.icon
    return (Util.GetItemUrl)(icon) or ""
  else
    do
      do return "" end
    end
  end
end

Util.GetConfigByItemIDAndType = function(itemID, itemType, ...)
  -- function num : 0_63 , upvalues : _ENV
  local PropType = PropType
  local excelTable = {}
  if itemType == PropType.ITEM then
    excelTable = (TableData.gTable).BasePropData
  else
    if itemType == PropType.ASSET then
      excelTable = (TableData.gTable).BaseAssetData
    else
    end
  end
  if itemType ~= PropType.CARD or itemType == PropType.EQUIP then
    return excelTable[itemID]
  end
end

Util.GetHeadIconByFashionId = function(fashionId, type, ...)
  -- function num : 0_64 , upvalues : _ENV, Util
  local fashionConfig = ((TableData.gTable).BasePlayerHeadIconData)[fashionId]
  if fashionConfig then
    return (Util.GetResUrl)(fashionConfig.icon_path)
  end
end

Util.GetHeadIcon = function(name, type, ...)
  -- function num : 0_65 , upvalues : _ENV, Util
  local HeadIconType = HeadIconType
  if type == HeadIconType.SQUARE then
    return (Util.GetResUrl)("CardHeadIconSquare:" .. name)
  else
    if type == HeadIconType.ROUND then
      return (Util.GetResUrl)("CardHeadIconCircle:" .. name)
    else
      if type == HeadIconType.BANNER then
        return (Util.GetResUrl)("CharacterHeadBanner:" .. name)
      else
        if type == HeadIconType.BATTLE then
          return nil
        else
          if type == HeadIconType.SKILL_BANNER then
            return nil
          end
        end
      end
    end
  end
end

Util.PlayAnimation = function(obj, animName, ...)
  -- function num : 0_66 , upvalues : _ENV
  if animName and animName ~= "" and obj ~= nil then
    local Animator = (CS.UnityEngine).Animator
    local anim = obj:GetComponent(typeof(Animator))
    if anim then
      local stateId = (Animator.StringToHash)(animName)
      local hasState = anim:HasState(0, stateId)
      if not hasState then
        print("PlayShake, do not has anim state " .. animName)
      end
      anim:Play(animName)
    end
  end
end

Util.GetClipLength = function(obj, clipName, ...)
  -- function num : 0_67 , upvalues : _ENV
  local length = 0
  if clipName and clipName ~= "" then
    local anim = obj:GetComponent(typeof((CS.UnityEngine).Animator))
    if anim then
      local clipInfo = (anim.runtimeAnimatorController).animationClips
      local count = clipInfo.Length
      for i = 0, count - 1 do
        if (clipInfo[i]).name == clipName then
          length = (clipInfo[i]).length
        end
      end
    end
  end
  do
    return length
  end
end

Util.PlayAnimationWithNormalLizedTime = function(obj, animName, value, ...)
  -- function num : 0_68 , upvalues : _ENV
  if animName and animName ~= "" and obj ~= nil then
    local Animator = (CS.UnityEngine).Animator
    local anim = obj:GetComponent(typeof(Animator))
    if anim then
      local stateId = (Animator.StringToHash)(animName)
      local hasState = anim:HasState(0, stateId)
      if not hasState then
        print("PlayShake, do not has anim state " .. animName)
      end
      if anim.speed ~= 0 then
        anim.speed = 0
      end
      anim:Play(animName, -1, value)
    end
  end
end

Util.SetAnimationSpeed = function(obj, value, ...)
  -- function num : 0_69 , upvalues : _ENV
  if obj ~= nil then
    local Animator = (CS.UnityEngine).Animator
    local anim = obj:GetComponent(typeof(Animator))
    if anim then
      anim.speed = value
    end
  end
end

Util.SetAnimatorBool = function(obj, boolName, value, ...)
  -- function num : 0_70 , upvalues : _ENV
  if obj ~= nil and boolName ~= nil and boolName ~= "" and value ~= nil then
    local Animator = (CS.UnityEngine).Animator
    local anim = obj:GetComponent(typeof(Animator))
    if anim then
      anim:SetBool(boolName, value)
    end
  end
end

Util.RemoveTableKey = function(t, k, ...)
  -- function num : 0_71 , upvalues : _ENV
  (table.remove)(t, k)
end

Util.GetCardSpeed = function(cardObject, ...)
  -- function num : 0_72 , upvalues : _ENV
  local info = {}
  ;
  (CardData.InitCardAttr)(info, cardObject)
  return info.spd
end

Util.SetPlayerSetting = function(key, Value, ...)
  -- function num : 0_73 , upvalues : _ENV
  if key and Value then
    local SetKey = (ActorData.GetPlayerIndex)() .. key
    ;
    (PlayerPrefs.SetString)(SetKey, tostring(Value))
  end
end

Util.GetPlayerSetting = function(key, defaultValue, ...)
  -- function num : 0_74 , upvalues : _ENV
  if key then
    local SetKey = (ActorData.GetPlayerIndex)() .. key
    if (PlayerPrefs.HasKey)(SetKey) then
      return (PlayerPrefs.GetString)(SetKey)
    else
      return tostring(defaultValue)
    end
  end
end

Util.SetIntPlayerSetting = function(key, Value, ...)
  -- function num : 0_75 , upvalues : _ENV
  if key and Value and tonumber(Value) ~= nil then
    local SetKey = (ActorData.GetPlayerIndex)() .. key
    ;
    (PlayerPrefs.SetInt)(SetKey, Value)
  end
end

Util.GetIntPlayerSetting = function(key, defaultValue, ...)
  -- function num : 0_76 , upvalues : _ENV
  if not defaultValue then
    defaultValue = 0
  end
  if key then
    return (PlayerPrefs.GetInt)((ActorData.GetPlayerIndex)() .. key, defaultValue)
  else
    return defaultValue
  end
end

Util.SetFloatPlayerSetting = function(key, Value, ...)
  -- function num : 0_77 , upvalues : _ENV
  if key and Value and tonumber(Value) ~= nil then
    local SetKey = (ActorData.GetPlayerIndex)() .. key
    ;
    (PlayerPrefs.SetFloat)(SetKey, Value)
  end
end

Util.GetFloatPlayerSetting = function(key, defaultValue, ...)
  -- function num : 0_78 , upvalues : _ENV
  if not defaultValue then
    defaultValue = 0
  end
  if key then
    return (PlayerPrefs.GetFloat)((ActorData.GetPlayerIndex)() .. key, defaultValue)
  else
    return defaultValue
  end
end

Util.CardIsMaxLevel = function(cardData, ...)
  -- function num : 0_79 , upvalues : _ENV
  local nextExp = ((CardData.GetCardLevelUpConfig)(cardData.grow_type, cardData.level)).next_exp
  do return nextExp <= cardData.exp end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Util.SetConsumptionByID = function(id, num, loader, txt, ShowFree, showColor, ...)
  -- function num : 0_80 , upvalues : _ENV, Util
  local itemID = tonumber(id)
  local itemNum = tonumber(num)
  local consumeData, propType = (Util.GetConfigDataByID)(itemID)
  loader.url = (Util.GetItemUrl)(consumeData.icon)
  loader.visible = true
  if ShowFree and itemNum <= 0 then
    txt.text = (PUtil.get)(20000195)
    loader.visible = false
  else
    txt.text = itemNum
  end
  if showColor then
    if propType == PropType.ASSET and not (Util.CheckAssetEnough)(itemID, itemNum) then
      txt.color = Const.LackColorRGB
    else
      txt.color = Const.EnoughColorRGB
    end
  end
end

Util.SetConsumption = function(consume, loader, txt, ShowFree, showColor, ...)
  -- function num : 0_81 , upvalues : split, Util
  local consumeConfigs = split(consume, ":")
  ;
  (Util.SetConsumptionByID)(consumeConfigs[2], consumeConfigs[3], loader, txt, ShowFree, showColor)
end

Util.CheckAssetEnough = function(assetID, needNum, ...)
  -- function num : 0_82 , upvalues : _ENV
  local possess = 0
  local GetAssetCount = ActorData.GetAssetCount
  local AssetType = AssetType
  if assetID == AssetType.DIAMOND_BIND then
    possess = GetAssetCount(AssetType.DIAMOND_BIND) + GetAssetCount(AssetType.DIAMOND)
  else
    possess = GetAssetCount(assetID)
  end
  do return needNum <= possess end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Util.IsAssetCondition = function(assetType, num, isShowTips, ...)
  -- function num : 0_83 , upvalues : _ENV
  assetType = tonumber(assetType)
  num = tonumber(num)
  local GetAssetCount = ActorData.GetAssetCount
  local AssetType = AssetType
  local have = GetAssetCount(assetType)
  if assetType == AssetType.DIAMOND_BIND then
    have = GetAssetCount(assetType) + GetAssetCount(AssetType.DIAMOND)
  end
  local asset = ((TableData.gTable).BaseAssetData)[assetType]
  if have < num and isShowTips then
    (MessageMgr.SendCenterTips)((PUtil.get)(20000125, asset.name))
  end
  do return num <= have end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Util.SetTransition = function(ObjS, ...)
  -- function num : 0_84 , upvalues : pairs
  for _,v in pairs(ObjS) do
    local cnt = v.numChildren
    for i = 0, cnt - 1 do
      local obj = (v:GetChildAt(i)).asCom
      if obj then
        local tran = obj:GetTransition("in")
        if tran then
          tran.invalidateBatchingEveryFrame = true
        end
      end
    end
  end
end

Util.CheckAssetByType = function(cost, type, ...)
  -- function num : 0_85 , upvalues : _ENV, Util
  if (ActorData.GetAssetCount)(type) < cost then
    (MessageMgr.SendCenterTips)(((Util.GetConfigDataByID)(type)).name .. (PUtil.get)(60000036))
    return false
  else
    return true
  end
end

Util.CreateHeadDebris = function(id, num, isFirst, ...)
  -- function num : 0_86 , upvalues : _ENV, Util
  local data = ((TableData.gTable).BasePropData)[tonumber(id)]
  if not data then
    return 
  end
  local debris = UIMgr:CreateObject("CommonResource", "HeadDebris")
  local debrisModel = GetCommonResource_HeadDebrisUis(debris)
  -- DECOMPILER ERROR at PC23: Confused about usage of register: R6 in 'UnsetPending'

  ;
  ((debrisModel.PeacecompGrp).HeadDebrisLoader).url = (Util.GetItemUrl)(data.icon)
  local cardData = ((TableData.gTable).BaseCardData)[tonumber(data.effect_value)]
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R7 in 'UnsetPending'

  ;
  (debrisModel.c2Ctr).selectedIndex = cardData.intelligence - 1
  -- DECOMPILER ERROR at PC38: Confused about usage of register: R7 in 'UnsetPending'

  if isFirst then
    (debrisModel.c1Ctr).selectedIndex = 1
  else
    -- DECOMPILER ERROR at PC41: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (debrisModel.c1Ctr).selectedIndex = 0
  end
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R7 in 'UnsetPending'

  if num then
    (debrisModel.NumberTxt).text = num
  else
    -- DECOMPILER ERROR at PC48: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (debrisModel.NumberTxt).visible = false
  end
  ;
  (CommonWinMgr.RegisterItemLongPress)((debrisModel.PeacecompGrp).HeadDebrisLoader, id)
  return debris
end

Util.SetEquipFrame = function(equipFrame, equipInfo, selected, ...)
  -- function num : 0_87 , upvalues : _ENV, Util
  if equipFrame == nil or equipInfo == nil then
    return 
  end
  if not selected then
    selected = false
  end
  local configData = ((TableData.gTable).BaseEquipData)[equipInfo.id]
  ;
  (equipFrame:GetController("c1")).selectedIndex = 1
  ;
  (equipFrame:GetController("c2")).selectedIndex = configData.intelligence
  if equipInfo.identify then
    (equipFrame:GetController("c6")).selectedIndex = 0
  else
    ;
    (equipFrame:GetController("c6")).selectedIndex = 1
  end
  ;
  (equipFrame:GetChild("NewCompGrp")).visible = (EquiptData.NewEquipments)[equipInfo.objectIndex]
  local loader = equipFrame:GetChild("IconLoader")
  loader.url = (Util.GetItemUrl)(configData.icon)
  loader.alpha = 1
  ;
  (equipFrame:GetChild("LockImage")).visible = equipInfo.lock
  ;
  (equipFrame:GetChild("FrameEffGrp")).visible = selected
  local starList = equipFrame:GetChild("StarList")
  starList:RemoveChildrenToPool()
  for i = 1, configData.star do
    starList:AddItemFromPool()
  end
end

Util.SetEquipFrameOnlyForShow = function(equipFrame, id, gray, selected, lock, luck, ...)
  -- function num : 0_88 , upvalues : _ENV, Util
  if equipFrame == nil then
    return 
  end
  if not gray then
    gray = false
  end
  if not selected then
    selected = false
  end
  if not lock then
    lock = false
  end
  if not luck then
    luck = false
  end
  noNeedTips = noNeedTips or false
  local configData = ((TableData.gTable).BaseEquipData)[id]
  local colorIndex = configData.intelligence
  ;
  (equipFrame:GetController("c1")).selectedIndex = 1
  ;
  (equipFrame:GetController("c2")).selectedIndex = colorIndex
  local icon = equipFrame:GetChild("IconLoader")
  if lock then
    (equipFrame:GetController("c3")).selectedIndex = 1
  else
    ;
    (equipFrame:GetController("c3")).selectedIndex = 0
  end
  if luck then
    (equipFrame:GetController("c4")).selectedIndex = 1
  else
    ;
    (equipFrame:GetController("c4")).selectedIndex = 0
  end
  icon.url = (Util.GetItemUrl)(configData.icon)
  local color = nil
  if gray then
    color = Const.GrayRGB
  else
    color = ((CS.UnityEngine).Color).white
  end
  icon.color = color
  local str = "Quality" .. (Const.QualityColorStr)[colorIndex + 1] .. "Image"
  ;
  (equipFrame:GetChild(str)).color = color
  ;
  (equipFrame:GetChild("Back" .. (Const.QualityColorStr)[colorIndex + 1] .. "Image")).color = color
  ;
  (equipFrame:GetChild("NewCompGrp")).visible = false
  ;
  (equipFrame:GetChild("LockImage")).visible = false
  ;
  (equipFrame:GetChild("FrameEffGrp")).visible = selected
  local starList = equipFrame:GetChild("StarList")
  starList:RemoveChildrenToPool()
  for i = 1, configData.star do
    starList:AddItemFromPool()
  end
  return (CommonWinMgr.RegisterItemLongPress)(equipFrame, id)
end

Util.GoodsToItemDataModel = function(goodsObj, ...)
  -- function num : 0_89 , upvalues : ipairs, _ENV
  local mGoods = {}
  if goodsObj then
    for _,v in ipairs(goodsObj) do
      local Goods = {}
      Goods.id = v.Id
      Goods.Num = v.Amount
      Goods.isGet = false
      ;
      (table.insert)(mGoods, Goods)
    end
  end
  do
    return mGoods
  end
end

Util.SetEnemyHeadFrameGray = function(frame, gray, ...)
  -- function num : 0_90 , upvalues : _ENV
  local color = ((CS.UnityEngine).Color).white
  if gray then
    color = Const.GrayRGB
  end
  ;
  (frame:GetChild("IconLoader")).color = color
  ;
  (frame:GetChild("n26")).color = color
  ;
  (frame:GetChild("QualityWhiteImage")).color = color
end

Util.SetItemFrameByConfig = function(item, str, get, isFirst, ...)
  -- function num : 0_91 , upvalues : split, _ENV, Util
  local info = split(str, ":")
  if #info ~= 3 then
    loge("传入道具参数有误:" .. str)
    return 
  end
  ;
  (Util.SetItemFrame)(item, tonumber(info[2]), tonumber(info[3]), get, isFirst)
end

Util.SetItemFrame = function(item, id, number, get, isFirst, hideNum, gray, ...)
  -- function num : 0_92 , upvalues : _ENV, Util
  if not get then
    get = false
  end
  if not isFirst then
    isFirst = false
  end
  if not gray then
    gray = false
  end
  local color = nil
  if gray then
    color = Const.GrayRGB
  else
    color = ((CS.UnityEngine).Color).white
  end
  local configData, dataType = (Util.GetConfigDataByID)(id)
  local iconLoader = item:GetChild("IconLoader")
  iconLoader.url = (Util.GetItemUrl)(configData.icon)
  iconLoader.color = color
  ;
  (item:GetChild("Quality" .. (Const.QualityColorStr)[configData.quality] .. "Image")).color = color
  ;
  (item:GetChild("Back" .. (Const.QualityColorStr)[configData.quality] .. "Image")).color = color
  ;
  (item:GetChild("NumberTxt")).text = number
  -- DECOMPILER ERROR at PC68: Unhandled construct in 'MakeBoolean' P1

  if number and tonumber(number) <= 1 then
    (item:GetChild("NumberTxt")).visible = not hideNum
    ;
    (item:GetChild("GetImage")).visible = get
    ;
    (item:GetController("Quality")).selectedIndex = configData.quality
    if isFirst then
      (item:GetController("c1")).selectedIndex = 1
    else
      (item:GetController("c1")).selectedIndex = 0
    end
    do return (CommonWinMgr.RegisterItemLongPress)(item, id) end
    -- DECOMPILER ERROR: 5 unprocessed JMP targets
  end
end

Util.SetDebrisFrameByConfig = function(item, str, ...)
  -- function num : 0_93 , upvalues : split, _ENV, Util
  local info = split(str, ":")
  if #info ~= 3 then
    loge("传入道具参数有误:" .. str)
    return 
  end
  ;
  (Util.SetDebrisFrame)(item, tonumber(info[2]), tonumber(info[3]))
end

Util.SetDebrisFrame = function(item, id, number, isFirst, HideNum, forbiddenLongPress, gray, ...)
  -- function num : 0_94 , upvalues : _ENV, Util
  if not gray then
    gray = false
  end
  local color = nil
  if gray then
    color = Const.GrayRGB
  else
    color = ((CS.UnityEngine).Color).white
  end
  local ConfigData, DataType = (Util.GetConfigDataByID)(id)
  local headLoader = (item:GetChild("PeacecompGrp")):GetChild("HeadDebrisLoader")
  headLoader.url = (Util.GetItemUrl)(ConfigData.icon)
  headLoader.color = color
  ;
  (item:GetChild("NumberTxt")).text = number
  -- DECOMPILER ERROR at PC45: Unhandled construct in 'MakeBoolean' P1

  if number and tonumber(number) <= 1 then
    (item:GetChild("NumberTxt")).visible = not HideNum
    if isFirst then
      (item:GetController("c1")).selectedIndex = 1
    else
      (item:GetController("c1")).selectedIndex = 0
    end
    if ConfigData.type == PropItemType.UNIVERSAL_DEBRIS then
      (item:GetController("c2")).selectedIndex = 4
    elseif ConfigData.type == PropItemType.CHARACTER_DEBRIS then
      local cardData = ((TableData.gTable).BaseCardData)[tonumber(ConfigData.effect_value)]
      ;
      (item:GetController("c2")).selectedIndex = cardData.intelligence - 1
    end
    if forbiddenLongPress ~= true then
      return (CommonWinMgr.RegisterItemLongPress)(item, id)
    end
    -- DECOMPILER ERROR: 8 unprocessed JMP targets
  end
end

Util.SetFrameByConfig = function(str, list, get, isFirst, ...)
  -- function num : 0_95 , upvalues : split, _ENV, Util
  local info = split(str, ":")
  if #info ~= 3 then
    loge("传入道具参数有误:" .. str)
    return 
  end
  ;
  (Util.SetFrame)(tonumber(info[2]), tonumber(info[3]), list, get, isFirst)
end

Util.SetFrame = function(id, number, list, get, isFirst, hideNum, ...)
  -- function num : 0_96 , upvalues : _ENV, Util
  id = tonumber(id)
  number = tonumber(number)
  local PropItemType = PropItemType
  local GoodsIconType = GoodsIconType
  local PropType = PropType
  local ConfigData, type = (Util.GetConfigDataByID)(id)
  local frame, LongPressGesture = nil, nil
  if type == PropType.ITEM or type == PropType.ASSET then
    if type == PropType.ITEM and (ConfigData.type == PropItemType.CHARACTER_DEBRIS or ConfigData.type == PropItemType.UNIVERSAL_DEBRIS) then
      frame = (Util.GetFrameFromPoolOrCreate)(GoodsIconType.DEBRIS, list)
      LongPressGesture = (Util.SetDebrisFrame)(frame, id, number, isFirst, hideNum)
    else
      frame = (Util.GetFrameFromPoolOrCreate)(GoodsIconType.ITEM, list)
      LongPressGesture = (Util.SetItemFrame)(frame, id, number, get, isFirst, hideNum)
    end
  else
    if type == PropType.EQUIP then
      frame = (Util.GetFrameFromPoolOrCreate)(GoodsIconType.EQUIPMENT, list)
      LongPressGesture = (Util.SetEquipFrameOnlyForShow)(frame, id)
    else
      if type == PropType.CARD then
        frame = (Util.GetFrameFromPoolOrCreate)(GoodsIconType.CARD, list)
        ;
        (Util.SetShowHeadFrame)(frame, id, isFirst)
        ;
        ((frame:GetChild("IconLoader")).onClick):Clear()
        ;
        ((frame:GetChild("IconLoader")).onClick):Add(function(...)
    -- function num : 0_96_0 , upvalues : _ENV, id
    OpenWindow("CardDetailsWindow", UILayer.HUD, id)
  end
)
      end
    end
  end
  if frame == nil then
    loge("id:" .. tostring(id) .. " type:" .. tostring(type))
  end
  return frame, LongPressGesture
end

Util.SetAllItemIconByConfig = function(frame, str, get, isFirst, ...)
  -- function num : 0_97 , upvalues : split, _ENV, Util
  local info = split(str, ":")
  if #info ~= 3 then
    loge("传入道具参数有误:" .. str)
    return 
  end
  ;
  (Util.SetAllItemIcon)(frame, tonumber(info[2]), tonumber(info[3]), get, isFirst)
end

Util.SetAllItemIcon = function(frame, id, number, get, isFirst, hideNum, lucky, lock, gray, headDebris, ...)
  -- function num : 0_98 , upvalues : _ENV, Util
  id = tonumber(id)
  local PropType = PropType
  local PropItemType = PropItemType
  local ConfigData, type = (Util.GetConfigDataByID)(id)
  local LongPressGesture = nil
  if type == PropType.ITEM or type == PropType.ASSET then
    if type == PropType.ITEM and (ConfigData.type == PropItemType.CHARACTER_DEBRIS or ConfigData.type == PropItemType.UNIVERSAL_DEBRIS) then
      (frame:GetController("c1")).selectedIndex = 1
      LongPressGesture = (Util.SetDebrisFrame)(frame:GetChild("HeadDebrisGrp"), id, number, isFirst, hideNum, gray)
    else
      ;
      (frame:GetController("c1")).selectedIndex = 0
      LongPressGesture = (Util.SetItemFrame)(frame:GetChild("ItemFrameGrp"), id, number, get, isFirst, hideNum, gray)
    end
  else
    if type == PropType.EQUIP then
      if not lock then
        lock = false
      end
      ;
      (frame:GetController("c1")).selectedIndex = 2
      LongPressGesture = (Util.SetEquipFrameOnlyForShow)(frame:GetChild("EquiotIcon"), id, gray, false, lock, lucky)
    else
      if type == PropType.CARD then
        (frame:GetController("c1")).selectedIndex = 3
        LongPressGesture = (Util.SetShowHeadFrame)(frame:GetChild("HeadFrame"), id, isFirst, nil, headDebris)
      end
    end
  end
  if frame == nil then
    loge("id:" .. tostring(id) .. " type:" .. tostring(type))
  end
  return LongPressGesture
end

Util.GetFrameFromPoolOrCreate = function(type, list, ...)
  -- function num : 0_99 , upvalues : _ENV
  local pkg, res = nil, nil
  local GoodsIconType = GoodsIconType
  if type == GoodsIconType.EQUIPMENT then
    pkg = "CommonResource"
    res = "EquiptIcon"
  else
    if type == GoodsIconType.DEBRIS then
      pkg = "CommonResource"
      res = "HeadDebris"
    else
      if type == GoodsIconType.CARD then
        pkg = "CommonResource"
        res = "HeadFrame"
      else
        pkg = "CommonResource"
        res = "ItemFrame"
      end
    end
  end
  if list == nil then
    return (UIPackage.CreateObject)(pkg, res)
  else
    return list:AddItemFromPool((UIPackage.GetItemURL)(pkg, res))
  end
end

Util.CreateFrame = function(id, get, number, isFirst, hideNum, ...)
  -- function num : 0_100 , upvalues : Util
  return (Util.SetFrame)(id, number, nil, get, isFirst, hideNum)
end

Util.SetFrameInLoader = function(loader, id, number, ...)
  -- function num : 0_101 , upvalues : Util, _ENV
  local ConfigData, type = (Util.GetConfigDataByID)(id)
  local PropType = PropType
  if type == PropType.ITEM or type == PropType.ASSET then
    if type == PropType.ITEM and ConfigData.type == PropItemType.CHARACTER_DEBRIS then
      loader.url = (Util.GetItemUrl)("CommonResource:HeadDebris")
      ;
      (Util.SetDebrisFrame)(loader.component, id, number)
    else
      loader.url = (Util.GetItemUrl)("CommonResource:ItemFrame")
      ;
      (Util.SetItemFrame)(loader.component, id, number)
    end
  else
    if type == PropType.EQUIP then
      loader.url = (Util.GetItemUrl)("CommonResource:EquiptIcon")
      ;
      (Util.SetEquipFrameOnlyForShow)(loader.component, id)
    end
  end
  ;
  (CommonWinMgr.RegisterItemLongPress)(loader.component, id)
  return loader.component
end

Util.CreateBuffFrame = function(id, ...)
  -- function num : 0_102 , upvalues : _ENV, Util
  local buff = ((TableData.gTable).BaseBuffPreBattleData)[tonumber(id)]
  if not buff then
    return 
  end
  local uis = UIMgr:CreateObject("Expedition", "BuffIcon")
  local icon = uis:GetChild("BuffIconLoader")
  icon.url = (Util.GetItemUrl)(buff.icon)
  return uis
end

Util.ShowGetWay = function(id, btnCB, needAmont, ...)
  -- function num : 0_103 , upvalues : _ENV
  ld("GetWay")
  OpenWindow((WinResConfig.GetWayWindow).name, UILayer.HUD, id, btnCB, needAmont, ...)
end

Util.GrayBtn = function(btn, gray, ...)
  -- function num : 0_104 , upvalues : _ENV, Util
  if btn == nil then
    return 
  end
  local count = btn.numChildren
  local color, txtAlpha = nil, nil
  local Const = Const
  if gray then
    color = ((CS.UnityEngine).Color)(Const.GrayRColor / 255, Const.GrayRColor / 255, Const.GrayRColor / 255)
    txtAlpha = 0.3
  else
    color = ((CS.UnityEngine).Color).white
    txtAlpha = 1
  end
  local component = nil
  for i = 0, count - 1 do
    component = btn:GetChildAt(i)
    if component.name ~= "RedDot" then
      if component.asTextField ~= nil then
        component.alpha = txtAlpha
      else
        if component.color == nil then
          (Util.GrayBtn)(component, gray)
        else
          component.color = color
        end
      end
    end
  end
end

Util.GrayLoader = function(loader, gray, ...)
  -- function num : 0_105 , upvalues : _ENV
  if loader then
    local Const = Const
    if gray then
      loader.color = ((CS.UnityEngine).Color)(Const.GrayRColor / 255, Const.GrayRColor / 255, Const.GrayRColor / 255)
    else
      loader.color = ((CS.UnityEngine).Color).white
    end
  end
end

Util.GrayImage = function(imgage, gray, ...)
  -- function num : 0_106 , upvalues : _ENV
  if imgage then
    local Const = Const
    if gray then
      imgage.color = ((CS.UnityEngine).Color)(Const.GrayRColor / 255, Const.GrayRColor / 255, Const.GrayRColor / 255)
    else
      imgage.color = ((CS.UnityEngine).Color).white
    end
  end
end

Util.GetWayGoto = function(funId, ...)
  -- function num : 0_107 , upvalues : _ENV
  ld("GetWay", function(...)
    -- function num : 0_107_0 , upvalues : _ENV, funId
    (GetWayMgr.Goto)(funId)
  end
)
end

Util.SetOnClickDelay = function(timer, ...)
  -- function num : 0_108 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  (GRoot.inst).touchable = false
  ;
  (SimpleTimer.setTimeout)(timer, function(...)
    -- function num : 0_108_0 , upvalues : _ENV
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

    (GRoot.inst).touchable = true
  end
)
end

Util.SetDelayCall = function(func, time, ...)
  -- function num : 0_109 , upvalues : _ENV
  if func == nil then
    return 
  end
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (GRoot.inst).touchable = false
  ;
  (LeanTween.delayedCall)(time or 0.04, function(...)
    -- function num : 0_109_0 , upvalues : _ENV, func
    -- DECOMPILER ERROR at PC2: Confused about usage of register: R0 in 'UnsetPending'

    (GRoot.inst).touchable = true
    func()
  end
)
end

Util.PreloadResource = function(...)
  -- function num : 0_110
end

Util.CheckConsumeByStr = function(str, fun, ...)
  -- function num : 0_111 , upvalues : split, Util
  local consumeConfigs = split(str, ":")
  if #consumeConfigs < 3 then
    return 
  end
  ;
  (Util.CheckConsumeAsset)(consumeConfigs[2], consumeConfigs[3], fun)
end

Util.CheckConsumeAsset = function(assetID, assetNum, fun, ...)
  -- function num : 0_112 , upvalues : _ENV
  assetID = tonumber(assetID)
  assetNum = tonumber(assetNum)
  local possession = (ActorData.GetAssetCount)(assetID)
  if assetNum <= possession then
    fun()
  else
    local AssetData = ((TableData.gTable).BaseAssetData)[assetID]
    ;
    (MessageMgr.SendCenterTips)((PUtil.get)(20000125, AssetData.name))
  end
end

Util.IsInParticularAssetConfig = function(type, ...)
  -- function num : 0_113 , upvalues : pairs, _ENV
  for _,v in pairs(ParticularAssetType) do
    if v == type then
      return true
    end
  end
end

Util.Shuffle = function(t, ...)
  -- function num : 0_114 , upvalues : type, _ENV
  if type(t) ~= "table" then
    return 
  end
  local tab = {}
  local index = 1
  local random = math.random
  local remove = table.remove
  do
    while #t ~= 0 do
      local n = random(0, #t)
      if t[n] ~= nil then
        tab[index] = t[n]
        remove(t, n)
        index = index + 1
      end
    end
    return tab
  end
end

Util.MajorSort = function(items, ...)
  -- function num : 0_115 , upvalues : ipairs, _ENV
  local finalTable = items
  for a,b in ipairs(finalTable) do
    b.bWeight = 0
  end
  for index,value in ipairs(finalTable) do
    if not value.Type then
      local itemType = value.type
    end
    local itemData = nil
    local itemId = tonumber(value.id)
    if itemType == PropType.ASSET then
      itemData = ((TableData.gTable).BaseAssetData)[itemId]
    else
      if itemType == PropType.CARD then
        itemData = ((TableData.gTable).BaseCardData)[itemId]
      else
        if itemType == PropType.EQUIP then
          itemData = ((TableData.gTable).BaseEquipData)[itemId]
        else
          if itemType == PropType.ITEM then
            itemData = ((TableData.gTable).BasePropData)[itemId]
          end
        end
      end
    end
    if itemData then
      value.bWeight = itemData.reward_sort
    end
  end
  ;
  (table.sort)(finalTable, function(a, b, ...)
    -- function num : 0_115_0
    if b.id >= a.id then
      do return a.bWeight ~= b.bWeight end
      do return b.bWeight < a.bWeight end
      -- DECOMPILER ERROR: 4 unprocessed JMP targets
    end
  end
)
  return finalTable
end

Util.GetQualityById = function(itype, id, ...)
  -- function num : 0_116 , upvalues : _ENV
  local quality = 0
  local PropType = PropType
  if itype == PropType.ITEM then
    local excelData = ((TableData.gTable).BasePropData)[id]
    quality = excelData.quality
  else
    do
      if itype == PropType.ASSET then
        local excelData = ((TableData.gTable).BaseAssetData)[id]
        quality = excelData.quality
      else
        do
          if itype == PropType.CARD then
            local excelData = ((TableData.gTable).BaseCardData)[id]
            quality = excelData.quality
          else
            do
              do
                if itype == PropType.EQUIP then
                  local excelData = ((TableData.gTable).BaseEquipData)[id]
                  quality = excelData.intelligence
                end
                return quality
              end
            end
          end
        end
      end
    end
  end
end

Util.SetUseAndTotalText = function(haveCount, needCount, ...)
  -- function num : 0_117 , upvalues : _ENV
  if haveCount > 0 then
    return (PUtil.get)(20000063, haveCount, needCount)
  else
    return (PUtil.get)(20000064, haveCount, needCount)
  end
end

Util.GetCardIntimacyData = function(cardID, ...)
  -- function num : 0_118 , upvalues : _ENV, pairs
  local oneCard = (CardData.GetCardData)(cardID)
  if not oneCard then
    return 
  end
  local intimacyLv = oneCard.intimacyLv
  local IntimacyUpData = ((TableData.gTable).BaseCardData)[cardID]
  local intimacyType = IntimacyUpData.intimacy_grow_type
  local IntimacyUpData = (TableData.gTable).BaseIntimacyUpData
  for _,v in pairs(IntimacyUpData) do
    if v.level == intimacyLv and v.type == tonumber(intimacyType) then
      return (PUtil.get)(20000163 + v.rank)
    end
  end
end

Util.GetCardStoryIndex = function(cardID, ...)
  -- function num : 0_119 , upvalues : _ENV
  local oneCard = (CardData.GetCardData)(cardID)
  if not oneCard then
    return 
  end
  local StageData = ((TableData.gTable).BaseHandbookStageData)[oneCard.lastStageId]
  if StageData then
    return StageData.index
  else
    return 0
  end
end

Util.GetBuyTimesGain = function(type, times, ...)
  -- function num : 0_120 , upvalues : _ENV, pairs, t_insert, ipairs
  local buyData = {}
  local BuyTimeData = (TableData.gTable).BaseBuyTimeData
  for _,v in pairs(BuyTimeData) do
    if v.type == type then
      t_insert(buyData, v)
    end
  end
  ;
  (table.sort)(buyData, function(a, b, ...)
    -- function num : 0_120_0
    do return a.start < b.start end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  for _,v in ipairs(buyData) do
    if v.start <= times and times <= v.finish then
      return v.reward
    end
  end
end

Util.GetBuyTimesConsume = function(type, times, ...)
  -- function num : 0_121 , upvalues : _ENV, pairs, t_insert, ipairs
  local buyData = {}
  local BuyTimeData = (TableData.gTable).BaseBuyTimeData
  for _,v in pairs(BuyTimeData) do
    if v.type == type then
      t_insert(buyData, v)
    end
  end
  ;
  (table.sort)(buyData, function(a, b, ...)
    -- function num : 0_121_0
    do return a.start < b.start end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  for _,v in ipairs(buyData) do
    if v.start <= times and times <= v.finish then
      return v.cost
    end
  end
  if (buyData[#buyData]).finish == -1 then
    return (buyData[#buyData]).cost
  end
end

Util.SetTimesShow = function(str, times, maxTimes, ...)
  -- function num : 0_122 , upvalues : _ENV
  if times <= 0 then
    return (PUtil.get)(20000171, str, times, maxTimes)
  else
    return (PUtil.get)(20000170, str, times, maxTimes)
  end
end

Util.StrLength = function(input, ...)
  -- function num : 0_123 , upvalues : s_len, s_byte
  if input == nil then
    return 0
  end
  local len = s_len(input)
  local left = len
  local cnt = 0
  local arr = {0, 192, 224, 240, 248, 252}
  while left ~= 0 do
    local tmp = s_byte(input, -left)
    local i = #arr
    while arr[i] do
      if arr[i] <= tmp then
        left = left - i
        break
      end
      i = i - 1
    end
    cnt = cnt + 1
  end
  do
    return cnt
  end
end

Util.StrUnicodeLength = function(input, ...)
  -- function num : 0_124 , upvalues : s_len, s_byte
  if input == nil then
    return 0
  end
  local len = s_len(input)
  local left = len
  local cnt = 0
  local arr = {0, 192, 224, 240, 248, 252}
  local step = nil
  while left ~= 0 do
    local tmp = s_byte(input, -left)
    local i = #arr
    if tmp <= 127 then
      step = 1
    else
      step = 1
    end
    while arr[i] do
      if arr[i] <= tmp then
        left = left - i
        break
      end
      i = i - 1
    end
    cnt = cnt + step
  end
  do
    return cnt
  end
end

Util.NameCheck = function(name, prefix, minLength, maxLength, ignoreLegalCheck, isGiftCode, ...)
  -- function num : 0_125 , upvalues : Util, _ENV
  local length = (Util.StrUnicodeLength)(name)
  if prefix == nil then
    prefix = ""
  end
  if minLength == nil then
    minLength = Const.MIN_NAME_LENGTH
  end
  if maxLength == nil then
    maxLength = Const.MAX_NAME_LENGTH
  end
  if length < minLength then
    if isGiftCode then
      (MessageMgr.SendCenterTips)((PUtil.get)(20000437, minLength))
    else
      ;
      (MessageMgr.SendCenterTips)(prefix .. (PUtil.get)(60000228, minLength))
    end
    return false
  else
    if maxLength < length then
      if isGiftCode then
        (MessageMgr.SendCenterTips)((PUtil.get)(20000438, maxLength))
      else
        ;
        (MessageMgr.SendCenterTips)(prefix .. (PUtil.get)(60000229, maxLength))
      end
      return false
    end
  end
  if ignoreLegalCheck == true then
    return true
  else
    return (Util.TextLegalCheck)(name)
  end
end

Util.TextLegalCheck = function(text, ...)
  -- function num : 0_126 , upvalues : _ENV
  if ((CS.DirtyWordChecker).Singleton):Match(text) then
    (MessageMgr.SendCenterTips)((PUtil.get)(20000187))
    return false
  end
  return true
end

Util.SetCurrencyWithConfig = function(data, icon, txt, ...)
  -- function num : 0_127 , upvalues : split, Util, _ENV
  local cost = split(data, ":")
  ;
  (Util.SetCurrency)(tonumber(cost[2]), tonumber(cost[3]), icon, txt)
end

Util.GetMaxAssetNum = function(assetID, ...)
  -- function num : 0_128 , upvalues : _ENV, split
  local fixID = nil
  if assetID == AssetType.PHYSICAL then
    fixID = Const.MaxPhysicalFixedID
  else
    if assetID == AssetType.ENDURANCE then
      fixID = Const.MaxEnduranceFixedID
    else
      if assetID == AssetType.SPIRIT then
        fixID = Const.MaxSpiritFixedID
      else
        return 99999999
      end
    end
  end
  local FixedData = ((TableData.gTable).BaseFixedData)[fixID]
  local configData = split(FixedData.array_value, ":")
  return tonumber(configData[2])
end

Util.GetEquipRemainSlot = function(...)
  -- function num : 0_129 , upvalues : _ENV
  return EquiptData.MaxBagSlots - #EquiptData.Equipments
end

Util.GetGiftIsContainEquip = function(itemID, ...)
  -- function num : 0_130 , upvalues : _ENV, pairs, split, Util
  local propData = ((TableData.gTable).BasePropData)[itemID]
  if propData.type ~= PropItemType.GIFT then
    return 
  end
  local tonumber = tonumber
  local effectValue = propData.effect_value
  local DropGroup = (TableData.gTable).BaseDropGroupLevelData
  local level = ((ActorData.GetLevel)())
  local drop_ids = nil
  for _,v in pairs(DropGroup) do
    local limits = split(v.level_limit, ":")
    if v.type == effectValue and tonumber(limits[1]) <= level and level <= tonumber(limits[2]) then
      drop_ids = v.drop_ids
      break
    end
  end
  do
    local BaseDropGroupData = (TableData.gTable).BaseDropGroupData
    if drop_ids then
      local ids = split(drop_ids, ":")
      for _,v in pairs(ids) do
        local DropGroup = BaseDropGroupData[tonumber(v)]
        if not (Util.StringIsNullOrEmpty)(DropGroup.equips) and tonumber(DropGroup.equips) ~= 0 then
          return true
        end
      end
    end
  end
end

Util.SetCurrency = function(id, amount, icon, txt, ...)
  -- function num : 0_131 , upvalues : _ENV, Util
  local currencyAmount = (ActorData.GetAssetCount)(id)
  if id == AssetType.DIAMOND_BIND then
    local diamondAmount = (ActorData.GetAssetCount)(AssetType.DIAMOND)
    if currencyAmount == 0 then
      if diamondAmount < amount then
        txt.text = "[color=" .. Const.RedColor .. "]" .. tostring(amount) .. "[/color]"
      else
        txt.text = amount
      end
    else
      if diamondAmount + currencyAmount < amount then
        txt.text = "[color=" .. Const.RedColor .. "]" .. tostring(amount) .. "[/color]"
      else
        txt.text = amount
      end
    end
    icon.url = (Util.GetUrlFromItemID)(id, PropType.ASSET)
  else
    do
      icon.url = (Util.GetUrlFromItemID)(id, PropType.ASSET)
      if currencyAmount < amount then
        txt.text = "[color=" .. Const.RedColor .. "]" .. tostring(amount) .. "[/color]"
      else
        txt.text = amount
      end
    end
  end
end

ShakeType = {Horizontal = 1, Vertical = 2, Multiply = 3}
Util.Shake = function(component, type, amplitude, duration, callback, ...)
  -- function num : 0_132 , upvalues : _ENV, Util
  if component == nil then
    return 
  end
  if type == nil then
    type = ShakeType.Multiply
  end
  if amplitude == nil then
    amplitude = 20
  end
  if duration == nil then
    duration = 1
  end
  local originXY = component.xy
  local tweener, action = nil, nil
  if type == ShakeType.Horizontal then
    action = function(...)
    -- function num : 0_132_0 , upvalues : Util, component, originXY, tweener
    if not (Util.IsNil)(component) then
      component.x = originXY.x + (tweener.value).x
    end
  end

  else
    if type == ShakeType.Vertical then
      action = function(...)
    -- function num : 0_132_1 , upvalues : Util, component, originXY, tweener
    if not (Util.IsNil)(component) then
      component.y = originXY.y + (tweener.value).y
    end
  end

    else
      if type == ShakeType.Multiply then
        action = function(...)
    -- function num : 0_132_2 , upvalues : Util, component, originXY, tweener
    if not (Util.IsNil)(component) then
      component.x = originXY.x + (tweener.value).x
      component.y = originXY.y + (tweener.value).y
    end
  end

      else
        action = nil
      end
    end
  end
  tweener = ((((FairyGUI.GTween).Shake)(Vector3.zero, amplitude, duration)):OnUpdate(function(...)
    -- function num : 0_132_3 , upvalues : action
    if action ~= nil then
      action()
    end
  end
)):OnComplete(function(...)
    -- function num : 0_132_4 , upvalues : callback
    if callback ~= nil then
      callback()
    end
  end
)
end

Util.GoodsObjectToItemDataModel = function(goodsObj, ...)
  -- function num : 0_133 , upvalues : ipairs, t_insert
  local mGoods = {}
  if goodsObj then
    for _,v in ipairs(goodsObj) do
      local Goods = {}
      Goods.id = v.id
      Goods.Num = v.value
      Goods.Type = v.type
      Goods.isGet = false
      t_insert(mGoods, Goods)
    end
  end
  do
    return mGoods
  end
end

Util.IsFightScene = function(...)
  -- function num : 0_134 , upvalues : _ENV
  do return UIMgr:IsWindowOpen((WinResConfig.BattleUIWindow).name) == true end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

local prepareLevelUp = false
Util.OpenPlayerLevelUpWindow = function(...)
  -- function num : 0_135 , upvalues : Util, _ENV
  (Util.IsPrepareLevelUpWindow)(true)
  ;
  (SimpleTimer.setTimeout)(0.1, function(...)
    -- function num : 0_135_0 , upvalues : _ENV, Util
    if not UIMgr:IsWindowOpen((WinResConfig.BattleWinConvergeWindow).name) and not UIMgr:IsWindowOpen((WinResConfig.BattleUIWindow).name) and not UIMgr:IsWindowOpen((WinResConfig.ClearingWindow).name) then
      if UIMgr:IsWindowOpen((WinResConfig.RewardShowWindow).name) then
        OpenWindow((WinResConfig.PlayerLevelUpWindow).name, UILayer.HUD1)
        ;
        (Util.IsPrepareLevelUpWindow)(false)
      end
    end
  end
)
end

Util.IsPrepareLevelUpWindow = function(value, ...)
  -- function num : 0_136 , upvalues : prepareLevelUp
  if value == nil then
    return prepareLevelUp
  else
    prepareLevelUp = value
  end
end

Util.SetNotFoundEffect = function(loader, ...)
  -- function num : 0_137 , upvalues : Util, _ENV
  if loader.Model ~= nil then
    return 
  end
  local model = (Util.ShowUIModel)(Const.NotFoundEffect2, loader)
  ;
  (CSLuaUtil.SetGOScale)(model, 100, 100, 100)
  ;
  (SkeletonAnimationUtil.SetAnimation)(model, 0, "idle", true)
  return model
end

Util.GetSelfBattlePosByPos = function(pos, ...)
  -- function num : 0_138
  if pos < 4 then
    return pos
  else
    return 10 + pos - 3
  end
end

Util.GetSelfPosByBattlePos = function(pos, ...)
  -- function num : 0_139
  if pos < 10 then
    return pos
  else
    return pos - 10 + 3
  end
end

Util.GetEnemyBattlePosByPos = function(pos, ...)
  -- function num : 0_140
  if pos < 4 then
    return 100 + pos
  else
    return 110 + pos - 3
  end
end

Util.GetEnemyPosByBattlePos = function(pos, ...)
  -- function num : 0_141
  if pos < 110 then
    return pos - 100
  else
    return pos - 110 + 3
  end
end

Util.GetAllFomation = function(selfFormation, enemyFormation, ...)
  -- function num : 0_142 , upvalues : _ENV, Util, pairs
  local battleFormation = {}
  local count = #selfFormation
  for i = 1, count do
    if (selfFormation[i]).id ~= 0 then
      (table.insert)(battleFormation, (Util.GetSelfBattlePosByPos)((selfFormation[i]).value))
    end
  end
  for k,v in pairs(enemyFormation) do
    (table.insert)(battleFormation, (Util.GetEnemyBattlePosByPos)(v.Index))
  end
  return battleFormation
end

Util.CoverBattleFormation2SelfFormation = function(battleFormation, ...)
  -- function num : 0_143 , upvalues : _ENV, Util
  local selfFormation = {}
  local count = #battleFormation
  for i = 1, count do
    if (battleFormation[i]).posIndex < 100 then
      (table.insert)(selfFormation, {value = (Util.GetSelfPosByBattlePos)((battleFormation[i]).posIndex)})
    end
  end
  return selfFormation
end

Util.SortingCost = function(cost, ...)
  -- function num : 0_144 , upvalues : split, _ENV, Util
  local count = #cost
  local costInfo = nil
  for i = 1, count do
    costInfo = split(cost[i], ":")
    cost[i] = {Id = tonumber(costInfo[2]), Type = tonumber(costInfo[1]), Amount = tonumber(costInfo[3])}
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (cost[i]).Weight = (Util.GetAssetWeight)((cost[i]).Id)
  end
  ;
  (table.sort)(cost, function(x, y, ...)
    -- function num : 0_144_0
    if x.Weight == y.Weight then
      return false
    else
      return y.Weight < x.Weight
    end
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
)
  return cost
end

Util.GetAssetWeight = function(id, ...)
  -- function num : 0_145 , upvalues : _ENV
  if id == AssetType.DIAMOND then
    return 100
  else
    if id == AssetType.GOLD then
      return 1
    else
      return 10
    end
  end
end

Util.CheckCostResources = function(cost, func, notEnoughFunc, notShowTips, ...)
  -- function num : 0_146 , upvalues : type, split, Util, _ENV
  local costInfo = nil
  if type(cost) == "string" then
    costInfo = split(cost, ",")
  else
    costInfo = cost
  end
  costInfo = (Util.SortingCost)(costInfo)
  local count = #costInfo
  local eachCost, resAmount = nil, nil
  local result = true
  for i = 1, count do
    eachCost = costInfo[i]
    if eachCost.Id == AssetType.DIAMOND_BIND then
      local bindDiaCount = (ActorData.GetAssetCount)(AssetType.DIAMOND_BIND)
      if bindDiaCount < eachCost.Amount then
        local diaCount = (ActorData.GetAssetCount)(AssetType.DIAMOND)
        if bindDiaCount + diaCount < eachCost.Amount then
          if notEnoughFunc then
            notEnoughFunc()
          end
          if not notShowTips then
            (MessageMgr.OpenAssetNotEnoughtWindow)(AssetType.DIAMOND_BIND, func, func)
          end
          result = false
          break
        else
          if bindDiaCount == 0 then
            costInfo.OnlyDiamond = true
          else
            ;
            (table.insert)(costInfo, {Id = AssetType.DIAMOND, Type = PropType.ASSET, Amount = eachCost.Amount - bindDiaCount})
            eachCost.Amount = bindDiaCount
            costInfo.DiamondIndex = #costInfo
          end
        end
      end
    else
      do
        do
          resAmount = (ActorData.GetGoodsCount)(eachCost.Id, eachCost.Type)
          if resAmount < eachCost.Amount then
            if eachCost.Type == PropType.ASSET or eachCost.Type == PropType.ITEM then
              if notEnoughFunc then
                notEnoughFunc()
              end
              if not notShowTips then
                (MessageMgr.OpenAssetNotEnoughtWindow)(eachCost.Id, func, func)
              end
            end
            result = false
            break
          end
          -- DECOMPILER ERROR at PC118: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC118: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC118: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  return result, costInfo
end

Util.PlayUIEffect = function(uis, contentPane, delta, ...)
  -- function num : 0_147 , upvalues : _ENV
  local holder = (LuaEffect.AddUIEffect)(UIEffectEnum.UI_UNLOCK, true)
  holder:SetXY(((uis.ResultImageGrp).root).x + ((uis.ResultImageGrp).root).width * 0.5, ((uis.ResultImageGrp).root).y + delta)
  contentPane:AddChild(holder)
end

Util.PlayProgressBarAni = function(cardData, addExp, ProgressBar, waitTime, ...)
  -- function num : 0_148 , upvalues : _ENV, Util
  if cardData == nil or addExp == nil or addExp <= 0 or ProgressBar == nil then
    return 
  end
  local currentExp = cardData.exp
  local nextExp = ((CardData.GetCardLevelUpConfig)(cardData.grow_type, cardData.level)).next_exp
  local timer, mCurExp, mAddExp, mMax = (Util.GetUpLevelNum)(cardData, currentExp, addExp, 0)
  local mNum = 0
  ProgressBar.value = (mCurExp - mAddExp) / mMax * 100
  ;
  (SimpleTimer.setTimeout)(waitTime, function(...)
    -- function num : 0_148_0 , upvalues : timer, Util, ProgressBar, mCurExp, mAddExp, mMax, mNum, currentExp, nextExp, _ENV
    if timer > 0 then
      (Util.SetProgressAni)(ProgressBar, mCurExp - mAddExp, mMax, mMax, 1, function(...)
      -- function num : 0_148_0_0 , upvalues : Util, mNum, timer, ProgressBar, currentExp, nextExp
      (Util.SetCallBack)(mNum, timer, ProgressBar, currentExp, nextExp)
    end
)
    else
      local gt = (GTween.To)(mCurExp - mAddExp, currentExp, 1)
      do
        gt:OnUpdate(function(...)
      -- function num : 0_148_0_1 , upvalues : ProgressBar, gt, mMax
      ProgressBar.value = (gt.value).x / mMax * 100
    end
)
      end
    end
  end
)
end

Util.SetCallBack = function(mNum, timer, ProgressBar, currentExp, nextExp, ...)
  -- function num : 0_149 , upvalues : Util
  mNum = mNum + 1
  if timer <= mNum then
    (Util.SetProgressAni)(ProgressBar, 0, currentExp, nextExp, 1)
  else
    ;
    (Util.SetProgressAni)(ProgressBar, 0, 100, 100, 1, function(...)
    -- function num : 0_149_0 , upvalues : Util, mNum, timer, ProgressBar, currentExp, nextExp
    (Util.SetCallBack)(mNum, timer, ProgressBar, currentExp, nextExp)
  end
)
  end
end

Util.SetProgressAni = function(Progress, startValue, endValue, max, duration, callBack, ...)
  -- function num : 0_150 , upvalues : _ENV
  local gt = (GTween.To)(startValue, endValue, duration)
  gt:OnUpdate(function(...)
    -- function num : 0_150_0 , upvalues : Progress, gt, max
    Progress.value = (gt.value).x / max * 100
  end
)
  gt:OnComplete(function(...)
    -- function num : 0_150_1 , upvalues : callBack
    if callBack ~= nil then
      callBack()
    end
  end
)
end

Util.GetUpLevelNum = function(cardData, curExp, addExp, lvTimer, ...)
  -- function num : 0_151 , upvalues : _ENV, Util
  local currentExp = curExp
  if addExp <= currentExp then
    local maxExp = curExp
    if lvTimer == 0 then
      maxExp = ((CardData.GetCardLevelUpConfig)(cardData.grow_type, cardData.level)).next_exp
    end
    return lvTimer, currentExp, addExp, maxExp
  else
    do
      local timer = lvTimer + 1
      local nextExp = ((CardData.GetCardLevelUpConfig)(cardData.grow_type, cardData.level - timer)).next_exp
      if nextExp == nil then
        nextExp = ((CardData.GetCardLevelUpConfig)(cardData.grow_type, cardData.level - lvTimer)).next_exp
      end
      local v1, v2, v3, v4 = (Util.GetUpLevelNum)(cardData, nextExp, addExp - currentExp, timer)
      do return v1, v2, v3, v4 end
    end
  end
end

Util.ShowGuideTips = function(checkpoint, ...)
  -- function num : 0_152 , upvalues : _ENV
  ld("GuideTips")
  ;
  (GuideTipsMgr.ShowGuideTips)(checkpoint, ...)
end

Util.GetChapterIDByStageID = function(stageId, ...)
  -- function num : 0_153 , upvalues : _ENV
  stageId = tonumber(stageId)
  local chapterId = stageId % 10000
  chapterId = (math.floor)(chapterId / 100)
  local type = (PlotDungeonMgr.GetStageChapterType)(stageId)
  if type == DungeonType.BasicDungeon then
    return 51100000 + chapterId
  else
    if type == DungeonType.HeroDungeon then
      return 51200000 + chapterId
    else
      if type == DungeonType.ActivityDungeon then
        return 51410000 + chapterId
      end
    end
  end
end

Util.IsNil = function(uobj, ...)
  -- function num : 0_154
  do return uobj ~= nil and uobj:Equals(nil) end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

Util.SetBackGroundWithCardId = function(loader, cardId, ...)
  -- function num : 0_155 , upvalues : _ENV, Util
  local cardData = ((TableData.gTable).BaseCardData)[cardId]
  local url = (Util.GetResUrl)(cardData.intelligence_bg)
  loader.url = url
end

Util.GetANewCard = function(...)
  -- function num : 0_156
end

Util.NumberTransformKilo = function(num, ...)
  -- function num : 0_157 , upvalues : _ENV
  local num = tonumber(num)
  if num == nil then
    return 
  end
  local len = (string.len)(num)
  local round = (math.floor)(len / 3)
  if round < 1 then
    return num
  end
  local str = ""
  for i = 1, round do
    local startIndex = len - 2 - (i - 1) * 3
    local gsub = (string.sub)(num, startIndex, startIndex + 2)
    str = "," .. gsub .. str
  end
  local gsub = (string.sub)(num, 1, len % 3)
  str = gsub .. str
  if (string.sub)(str, 1, 1) == "," then
    str = (string.sub)(str, 2)
  end
  return str
end

Util.SetSliverHeadIcon = function(fashionId, loader, ...)
  -- function num : 0_158 , upvalues : _ENV, Util
  local fashionConfig = ((TableData.gTable).BaseFashionData)[fashionId]
  if not fashionConfig then
    loge(fashionId .. "fashionId" .. "未找到")
    loader.visible = false
    return 
  end
  loader.visible = true
  loader.url = (Util.GetItemUrl)(fashionConfig.head_icon_sliver)
end

Util.SetTxt = function(content, list, ...)
  -- function num : 0_159 , upvalues : split, ipairs, Util
  list.numItems = 0
  local ruleDes = content
  local rule = split(ruleDes, "::")
  for i,v in ipairs(rule) do
    if not (Util.StringIsNullOrEmpty)(v) then
      local line = (Util.CreateLine)(v)
      if line then
        list:AddChild(line)
      end
    end
  end
end

Util.CreateLine = function(content, ...)
  -- function num : 0_160 , upvalues : Util, _ENV
  if (Util.StringIsNullOrEmpty)(content) then
    return 
  end
  local lineModel = UIMgr:CreateObject("Message", "TextContent")
  local word = lineModel:GetChild("ContentTxt")
  local image = lineModel:GetChild("TabImage")
  word.UBBEnabled = true
  if (string.sub)(content, 0, 2) == "$$" then
    image.visible = false
    word.text = (string.sub)(content, 3)
  else
    word.text = content
  end
  return lineModel
end

Util.CheckPassWordLegal = function(content, showTip, minLen, maxLen, ...)
  -- function num : 0_161 , upvalues : _ENV
  local len = (string.len)(content)
  if len < minLen then
    if showTip then
      (MessageMgr.SendCenterTips)((PUtil.get)(20000341, minLen))
    end
    return false
  else
    if maxLen < len then
      if showTip then
        (MessageMgr.SendCenterTips)((PUtil.get)(20000342, maxLen))
      end
      return false
    end
  end
  local digital = false
  local letter = false
  for i = 1, len do
    local byte = (string.byte)(content, i)
    if byte <= 57 and byte >= 48 then
      digital = true
    else
      if byte <= 90 and byte >= 65 then
        letter = true
      else
        if byte <= 122 and byte >= 97 then
          letter = true
        end
      end
    end
  end
  if not digital then
    if showTip then
      (MessageMgr.SendCenterTips)((PUtil.get)(20000343))
    end
    return false
  else
    if not letter then
      if showTip then
        (MessageMgr.SendCenterTips)((PUtil.get)(20000344))
      end
      return false
    end
  end
  return true
end

Util.LimitContentType = function(content, digital, letter, ...)
  -- function num : 0_162 , upvalues : _ENV
  local len = (string.len)(content)
  local containDigital = false
  local containLetter = false
  local containWord = false
  for i = 1, len do
    local byte = (string.byte)(content, i)
    if byte <= 57 and byte >= 48 then
      containDigital = true
    else
      if byte <= 90 and byte >= 65 then
        containLetter = true
      else
        if byte <= 122 and byte >= 97 then
          containLetter = true
        else
          containWord = true
        end
      end
    end
  end
  if digital and letter then
    return not containWord
  end
  do return digital and ((not containWord and not containLetter)) end
  do return letter and ((not containWord and not containWord)) end
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

Util.CreatCardSpineWithStaticOrNot = function(loader, cardData, isNeedShutter, forceStatic, ...)
  -- function num : 0_163 , upvalues : Util, _ENV, require
  (Util.RecycleUIModel)(loader)
  local isStatic = (Util.GetPlayerSetting)(cardData.id .. "Static", "0")
  local fashionConfig = (CardData.GetFashionConfig)(cardData)
  print("get fashionId", fashionConfig.id, cardData.id)
  local obj = nil
  if isStatic == "0" or forceStatic then
    obj = (Util.CreateShowModel)(fashionConfig.id, loader, false, nil, nil, true)
    ;
    (loader.image):SetSkipFairyBatching(true)
  else
    local t_Object = (Util.ShowUIModel)(fashionConfig.show_texture, loader)
    obj = t_Object
    ;
    (Util.UpdateShowTextureByConfig)(t_Object, fashionConfig)
  end
  do
    if isNeedShutter then
      local FxManager = require("FxManager")
      FxManager:SetShutterEffect(obj, loader.image)
    end
  end
end

Util.RegistCaptureScreenShot = function(shotBtn, logo, code, wid, hei, ...)
  -- function num : 0_164 , upvalues : _ENV
  logo.visible = false
  code.visible = false
  shotBtn.visible = false
  ;
  (shotBtn.onClick):Set(function(...)
    -- function num : 0_164_0 , upvalues : _ENV, shotBtn, logo, code, wid, hei
    if (FunctionControlMgr.GetFunctionState)(ControlID.Share, true) then
      ((CS.ScreenShotManager).Instance):HideOrShowBackGroundCamera(false)
      shotBtn.visible = false
      logo.visible = true
      code.visible = true
      ;
      ((CS.ScreenShotManager).Instance):StartScreenShoot(wid, hei, function(...)
      -- function num : 0_164_0_0 , upvalues : _ENV, shotBtn, logo, code
      OpenWindow((WinResConfig.ShareMainWindow).name, UILayer.HUD, shotBtn, logo, code)
    end
)
    end
  end
)
end

Util.GetActivityIds = function(playId, ...)
  -- function num : 0_165 , upvalues : _ENV, ipairs, split
  local playData = ((TableData.gTable).BasePlayData)[playId]
  local buffIds = {}
  for index,value in ipairs(split(playData.double_activity_id, ":")) do
    local buffId = tonumber(value)
    ;
    (table.insert)(buffIds, buffId)
  end
  return buffIds
end

return Util

