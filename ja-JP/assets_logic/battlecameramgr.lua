-- params : ...
-- function num : 0 , upvalues : _ENV
local curTrack = nil
local trackTable = {}
local curAtkCard, curDefCard = nil, nil
BattleCameraMgr = {isMoving = false}
local self = BattleCameraMgr
if LeanTween then
  local delayedCall = LeanTween.delayedCall
end
if Util then
  local MoveBattleCamera = Util.MoveBattleCamera
end
local LeanTweenType = LeanTweenType
local Vector3 = Vector3
local split = split
local tonumber = tonumber
local BattleCardCamp = BattleCardCamp
if Util then
  local SetCameraOrthographicSize = Util.SetCameraOrthographicSize
end
BattleCameraMoveType = {NO_MOVE = 0, MOVE_UP = 1, MOVE_DOWN = 2, MOVE_LEFT = 3, MOVE_RIGHT = 4}
-- DECOMPILER ERROR at PC36: Confused about usage of register: R13 in 'UnsetPending'

BattleCameraMgr.MoveCamera = function(camera_id, atkCard, defCard, ...)
  -- function num : 0_0 , upvalues : self, _ENV, curAtkCard, curDefCard
  (self.Clear)()
  -- DECOMPILER ERROR at PC5: Confused about usage of register: R3 in 'UnsetPending'

  if camera_id then
    BattleCameraMgr.isMoving = true
    curAtkCard = atkCard
    curDefCard = defCard
    local procedureConfig = ((TableData.gTable).BaseSkillCameraProcedureData)[camera_id]
    if procedureConfig then
      (self.ParseCameraTrack)(procedureConfig.array)
    end
  end
end

-- DECOMPILER ERROR at PC39: Confused about usage of register: R13 in 'UnsetPending'

BattleCameraMgr.ParseCameraTrack = function(trackStr, ...)
  -- function num : 0_1 , upvalues : trackTable, _ENV, self
  trackTable = (Util.ParseConfigStr)(trackStr)
  ;
  (self.PlayCameraTrack)()
end

local index = 0
-- DECOMPILER ERROR at PC43: Confused about usage of register: R14 in 'UnsetPending'

BattleCameraMgr.PlayCameraTrack = function(...)
  -- function num : 0_2 , upvalues : index, _ENV, curTrack, trackTable, self
  index = index + 1
  print("index", index)
  curTrack = trackTable[1]
  ;
  (table.remove)(trackTable, 1)
  if curTrack then
    local callBack = function(...)
    -- function num : 0_2_0 , upvalues : curTrack, self
    curTrack = nil
    ;
    (self.PlayCameraTrack)()
  end

    ;
    (self.PlayOneTrack)(callBack)
  else
    do
      ;
      (self.Clear)()
    end
  end
end

-- DECOMPILER ERROR at PC46: Confused about usage of register: R14 in 'UnsetPending'

BattleCameraMgr.Clear = function(...)
  -- function num : 0_3 , upvalues : _ENV, curTrack, trackTable, curAtkCard, curDefCard
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

  BattleCameraMgr.isMoving = false
  curTrack = nil
  trackTable = {}
  curAtkCard = nil
  curDefCard = nil
end

-- DECOMPILER ERROR at PC49: Confused about usage of register: R14 in 'UnsetPending'

BattleCameraMgr.PlayOneTrack = function(callBack, ...)
  -- function num : 0_4 , upvalues : curTrack, tonumber, _ENV, delayedCall, self
  if curTrack then
    local delayTime = tonumber(curTrack[1])
    do
      local moveId = tonumber(curTrack[2])
      if delayTime and moveId then
        local isShake = false
        local shakeConfig = ((TableData.gTable).BaseCameraShakeData)[moveId]
        if shakeConfig then
          isShake = true
          if callBack then
            callBack()
          end
        end
        delayedCall(delayTime / 1000, function(...)
    -- function num : 0_4_0 , upvalues : self, moveId, callBack, isShake
    (self.Move)(moveId, callBack, isShake)
  end
)
      end
    end
  end
end

-- DECOMPILER ERROR at PC52: Confused about usage of register: R14 in 'UnsetPending'

BattleCameraMgr.Move = function(moveId, callBack, isShake, ...)
  -- function num : 0_5 , upvalues : _ENV, SetCameraOrthographicSize, curAtkCard, curDefCard, split, tonumber, BattleCardCamp, Vector3, MoveBattleCamera, LeanTweenType, delayedCall
  if moveId ~= 0 or isShake == true then
    local shakeConfig = ((TableData.gTable).BaseCameraShakeData)[moveId]
    local name = shakeConfig.name
    local ShakeAnimPlay = require("ShakeAnimPlay")
    ;
    (ShakeAnimPlay.PlayShake)(name, Game.battleCamera)
  else
    do
      local moveConfig = ((TableData.gTable).BaseSkillCameraMoveData)[moveId]
      if moveConfig then
        local move_time = moveConfig.move_time
        local time = move_time / 1000
        local scale = moveConfig.scale
        local position = moveConfig.position_a
        local end_type = moveConfig.end_type
        if scale and scale ~= 0 then
          SetCameraOrthographicSize(Game.battleCamera, scale, time, true)
        end
        local targetPosition = nil
        local isRelative = true
        if end_type then
          if end_type == 1 then
            targetPosition = curAtkCard.curPosition
            local posIndex = curAtkCard:GetPosIndex()
            if posIndex % 100 > 10 then
              position = moveConfig.position_b
            else
              position = moveConfig.position_a
            end
          else
            do
              if end_type == 2 then
                targetPosition = curDefCard.curPosition
                local posIndex = curDefCard:GetPosIndex()
                if posIndex % 100 > 10 then
                  position = moveConfig.position_b
                else
                  position = moveConfig.position_a
                end
              end
              do
                isRelative = false
                if position then
                  local t_pos = split(position, ",")
                  local moveX = tonumber(t_pos[1])
                  local atkCamp = curAtkCard:GetCampFlag()
                  if atkCamp == BattleCardCamp.RIGHT then
                    moveX = -moveX
                  end
                  local v_pos = Vector3(moveX, tonumber(t_pos[2]), 0)
                  targetPosition = targetPosition and targetPosition + v_pos or v_pos
                end
                do
                  if targetPosition then
                    local moveY = targetPosition.y
                    local moveX = targetPosition.x
                    MoveBattleCamera(Vector3(moveX, moveY, 0), time, isRelative, LeanTweenType.easeInOutQuad)
                  end
                  do
                    delayedCall(time, callBack)
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

-- DECOMPILER ERROR at PC55: Confused about usage of register: R14 in 'UnsetPending'

BattleCameraMgr.mirrorCamera = function(enable, ...)
  -- function num : 0_6 , upvalues : _ENV
  local launch = (CS.Launch).Singleton
  launch.mirrorCamera = enable
end


