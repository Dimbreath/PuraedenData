-- params : ...
-- function num : 0 , upvalues : _ENV
BattleBackground = {}
local mapObject = nil
local mapList = {}
local effectList = {}
local curMapPath = ""
local ResHelper = ResHelper
local CSLuaUtil = CSLuaUtil
local ipairs = ipairs
local t_insert = table.insert
local self = BattleBackground
-- DECOMPILER ERROR at PC14: Confused about usage of register: R9 in 'UnsetPending'

BattleBackground.CreateBackground = function(isChangeWave, stageId, battleType, curWave, ...)
  -- function num : 0_0 , upvalues : _ENV, curMapPath, self
  local background_path, soundId = (BattleData.GetBattleMapAndBGM)(stageId, battleType, curWave)
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R6 in 'UnsetPending'

  if soundId then
    BattleData.soundId = soundId
  else
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R6 in 'UnsetPending'

    BattleData.soundId = nil
  end
  if isChangeWave and background_path == curMapPath then
    return 
  end
  curMapPath = background_path
  if IsBattleTest == true then
    curMapPath = "BattleScene_1003"
  end
  ;
  (self.ExtendBackground)()
end

-- DECOMPILER ERROR at PC17: Confused about usage of register: R9 in 'UnsetPending'

BattleBackground.ExtendBackground = function(...)
  -- function num : 0_1 , upvalues : _ENV, ResHelper, curMapPath, CSLuaUtil, mapList, t_insert
  local battleCamera = Game.battleCamera
  local cameraRotation = (battleCamera.transform).localEulerAngles
  local model = (ResHelper.InstantiateModel)(curMapPath)
  local scale = 1
  ;
  (CSLuaUtil.SetGOScale)(model, scale, scale, scale)
  ;
  (CSLuaUtil.SetParent)(model, BattleRoot)
  local empty = (model.transform):Find("empty")
  if empty then
    (empty.gameObject):SetActive(false)
  end
  local lastModel = mapList[#mapList]
  if lastModel then
    local localPos = (CSLuaUtil.GetGOLocalPos)(lastModel)
    ;
    (CSLuaUtil.SetGOLocalPos)(model, localPos.x + 13.34, 0, 0)
  else
    do
      ;
      (CSLuaUtil.SetGOLocalPos)(model, 0, 0, 0)
      ;
      (CSLuaUtil.SetGOLocalEuler)(model, cameraRotation.x, 0, 0)
      local SortingHelper = require("SortingHelper")
      ;
      (SortingHelper.SetOrderInLayer)(model, BattleConfig.sortingOrderInit)
      t_insert(mapList, model)
    end
  end
end

-- DECOMPILER ERROR at PC20: Confused about usage of register: R9 in 'UnsetPending'

BattleBackground.ShowSceneEffect = function(...)
  -- function num : 0_2 , upvalues : _ENV, ResHelper, CSLuaUtil, t_insert, effectList
  local battleCamera = Game.battleCamera
  local cameraRotation = (battleCamera.transform).localEulerAngles
  local eff = (ResHelper.InstantiateEffect)(BattleEffectEnum.COMMON_IRRADIATION)
  ;
  (CSLuaUtil.SetParent)(eff, BattleRoot)
  local SortingHelper = require("SortingHelper")
  ;
  (SortingHelper.SetOrderInLayer)(eff, BattleConfig.sortingOrderInit)
  ;
  (CSLuaUtil.SetGOLocalPos)(eff, 0, 0, 0)
  ;
  (CSLuaUtil.SetGOLocalEuler)(eff, cameraRotation.x, 0, 0)
  t_insert(effectList, eff)
end

-- DECOMPILER ERROR at PC23: Confused about usage of register: R9 in 'UnsetPending'

BattleBackground.MoveLeft = function(time, callBack, ...)
  -- function num : 0_3 , upvalues : ipairs, mapList, _ENV
  if not time then
    time = 1
  end
  for _,mapModel in ipairs(mapList) do
    ((LeanTween.moveLocalX)(mapModel, ((mapModel.transform).localPosition).x - BattleConfig.nextWaveCardMoveX, time)):setOnComplete(function(...)
    -- function num : 0_3_0 , upvalues : callBack
    if callBack then
      callBack()
    end
  end
)
  end
end

-- DECOMPILER ERROR at PC26: Confused about usage of register: R9 in 'UnsetPending'

BattleBackground.ClearBackground = function(isCache, ...)
  -- function num : 0_4 , upvalues : ipairs, mapList, ResHelper, effectList
  if isCache == nil then
    isCache = false
  end
  for _,v in ipairs(mapList) do
    (ResHelper.DestroyGameObject)(v, isCache)
  end
  mapList = {}
  for _,v in ipairs(effectList) do
    (ResHelper.DestroyGameObject)(v, isCache)
  end
  effectList = {}
end

-- DECOMPILER ERROR at PC29: Confused about usage of register: R9 in 'UnsetPending'

BattleBackground.PreLoad = function(stageId, battleType, curWave, ...)
  -- function num : 0_5 , upvalues : _ENV
  if not curWave then
    curWave = 1
  end
  local background_path = (BattleData.GetBattleMapAndBGM)(stageId, battleType, curWave)
  ;
  (BattleResource.PreLoadByPath)(background_path, false)
end

-- DECOMPILER ERROR at PC32: Confused about usage of register: R9 in 'UnsetPending'

BattleBackground.SetBgShow = function(show, ...)
  -- function num : 0_6 , upvalues : mapList, ipairs
  if mapList then
    for _,v in ipairs(mapList) do
      if v.activeSelf ~= show then
        v:SetActive(show)
      end
    end
  end
end


