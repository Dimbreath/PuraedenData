-- params : ...
-- function num : 0 , upvalues : _ENV
local AudioManager = {}
local isPlayingAudio = false
local currentAudioId = 0
local currentBubbleId = 0
local bubblePool = {}
local bubbleDefaultSizeY = 0
local bubblePrefab, bubbleTimer = nil, nil
local recordFirstLogin = false
local uisRoot = nil
local PAKEGE = "CommonResource"
local LEFT = "TalkLeft"
local RIGHT = "TalkRight"
local battleAudioIdsTable = {}
AudioManager.GetBubbleIds = function(fashionId, bubbleType, isRandom, ...)
  -- function num : 0_0 , upvalues : _ENV, AudioManager
  local bubbleIds, bubbleId = nil, nil
  local excelData = ((TableData.gTable).BaseFashionData)[fashionId]
  if bubbleType == CVAudioType.UnLockBubble then
    bubbleIds = excelData.unlock_bubble_ids
  else
    if bubbleType == CVAudioType.LoginBubble then
      bubbleIds = excelData.login_bubble_ids
    else
      if bubbleType == CVAudioType.HomeIdleBubble then
        bubbleIds = excelData.bubble_ids
      else
        if bubbleType == CVAudioType.LevelUpBubble then
          bubbleIds = excelData.levelUp_bubble_ids
        else
          if bubbleType == CVAudioType.QualityUpBubble then
            bubbleIds = excelData.qualityUp_bubble_ids
          else
            if bubbleType == CVAudioType.StarUpBubble then
              bubbleIds = excelData.starUp_bubble_ids
            else
              if bubbleType == CVAudioType.TouchBubble then
                bubbleIds = excelData.touch_bubble_ids
              else
                if bubbleType == CVAudioType.ArrayUpBubble then
                  bubbleIds = excelData.arrayup_bubble_ids
                else
                  if bubbleType == CVAudioType.AttackBubble then
                    bubbleIds = excelData.attack_bubble_ids
                  else
                    if bubbleType == CVAudioType.HitBubble then
                      bubbleIds = excelData.hit_bubble_ids
                    else
                      if bubbleType == CVAudioType.DeathBubble then
                        bubbleIds = excelData.death_bubble_ids
                      else
                        if bubbleType == CVAudioType.SkillBubble then
                          bubbleIds = excelData.skill_bubble_ids
                        else
                          if bubbleType == CVAudioType.UniqueSkillBubble then
                            bubbleIds = excelData.uniqueskill_bubble_ids
                          else
                            if bubbleType == CVAudioType.BattleWinBubble then
                              bubbleIds = excelData.win_bubble_ids
                            else
                              if bubbleType == CVAudioType.BattleLoseBubble then
                                bubbleIds = excelData.lose_bubble_ids
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
  end
  if bubbleIds == nil then
    return 
  end
  if isRandom then
    bubbleId = (AudioManager.RandomGetOneAudioId)(bubbleIds)
  else
    local ids = split(bubbleIds, ":")
    bubbleId = tonumber(ids[1])
  end
  do
    return bubbleId
  end
end

AudioManager.PlayBubbleVoice = function(bubbleId, callBackFunc, ...)
  -- function num : 0_1 , upvalues : _ENV, battleAudioIdsTable
  local bubbleData = ((TableData.gTable).BaseFashionBubbleData)[bubbleId]
  if not bubbleData then
    return 
  end
  for id,path in pairs(battleAudioIdsTable) do
    if path == bubbleData.voice_path then
      return 
    end
  end
  local audioId = nil
  audioId = (LuaSound.AudioMgrPlaySound)(bubbleData.voice_path, false, function(...)
    -- function num : 0_1_0 , upvalues : callBackFunc, battleAudioIdsTable, audioId
    if callBackFunc then
      callBackFunc()
    end
    battleAudioIdsTable[audioId] = nil
  end
)
  battleAudioIdsTable[audioId] = bubbleData.voice_path
end

AudioManager.PlayBattleVoice = function(fashionId, bubbleType, callBackFunc, ...)
  -- function num : 0_2 , upvalues : AudioManager
  local bubbleId = (AudioManager.GetBubbleIds)(fashionId, bubbleType, true)
  if bubbleId == nil then
    return 
  end
  ;
  (AudioManager.PlayBubbleVoice)(bubbleId, callBackFunc)
end

AudioManager.StopAllBattleVoice = function(...)
  -- function num : 0_3 , upvalues : _ENV, battleAudioIdsTable
  local AudioMgr = (CS.AudioAssetManager).Singleton
  if battleAudioIdsTable then
    for id,path in pairs(battleAudioIdsTable) do
      if path ~= nil then
        AudioMgr:RemoveSound(id, false)
      end
    end
  end
  do
    battleAudioIdsTable = {}
  end
end

AudioManager.PlayBubbleAndVoice = function(isBub, isVoic, fashionId, bubbleType, loader, uis, isLoop, isRandom, isStay, isAxisChange, callBackFunc, force, ...)
  -- function num : 0_4 , upvalues : isPlayingAudio, _ENV, currentAudioId, AudioManager, currentBubbleId, bubblePrefab, PAKEGE, LEFT, RIGHT, bubbleDefaultSizeY, uisRoot
  if force == nil then
    force = false
  end
  if isPlayingAudio and force then
    local AudioMgr = (CS.AudioAssetManager).Singleton
    AudioMgr:RemoveSound(currentAudioId, false)
  else
    do
      do return  end
      if isBub == nil then
        isBub = true
      end
      if isVoic == nil then
        isVoic = true
      end
      if isStay == nil then
        isStay = false
      end
      if isRandom == nil then
        isRandom = false
      end
      if isLoop == nil then
        isLoop = false
      end
      if isAxisChange == nil then
        isAxisChange = true
      end
      local model = nil
      if loader then
        model = loader.Model
      end
      local bubbleId = (AudioManager.GetBubbleIds)(fashionId, bubbleType, isRandom)
      if bubbleId == nil then
        return 
      end
      local bubbleData = ((TableData.gTable).BaseFashionBubbleData)[bubbleId]
      currentBubbleId = bubbleId
      if not bubbleData then
        return 
      end
      if model then
        local loop = false
        if isLoop then
          loop = isLoop
        end
        isPlayingAudio = true
        currentAudioId = (LuaSound.AudioMgrPlaySound)(bubbleData.voice_path, loop, function(...)
    -- function num : 0_4_0 , upvalues : _ENV, callBackFunc, isBub, isStay, bubblePrefab, currentAudioId, isPlayingAudio, model, currentBubbleId
    print("CV播放完成回调")
    if callBackFunc then
      callBackFunc()
    end
    if isBub then
      if not isStay and bubblePrefab then
        PlayUITrans(bubblePrefab, "out", function(...)
      -- function num : 0_4_0_0 , upvalues : bubblePrefab, currentAudioId, isPlayingAudio, model
      bubblePrefab.visible = false
      currentAudioId = 0
      isPlayingAudio = false
      if model then
      end
    end
)
      end
      currentBubbleId = 0
    else
      currentAudioId = 0
      isPlayingAudio = false
      currentBubbleId = 0
    end
  end
)
        if isBub then
          local bbRes = nil
          local pos = split(bubbleData.position, ":")
          print("--pos", pos[1], pos[2], (ResolutionHandler.AdaptOffset).X, (ResolutionHandler.AdaptOffset).Y, isAxisChange)
          local X = 0
          local Y = 0
          local width = 0
          if bubbleData.direction == 1 then
            bbRes = PAKEGE .. ":" .. LEFT
          else
            bbRes = PAKEGE .. ":" .. RIGHT
          end
          X = tonumber(pos[1]) + (ResolutionHandler.AdaptOffset).X
          Y = tonumber(pos[2]) + (ResolutionHandler.AdaptOffset).Y
          bubblePrefab = (AudioManager.GetBubblePrefab)(bbRes)
          print("warning!!!!!!!", bubblePrefab, bbRes, uis.root)
          ;
          (uis.root):AddChild(bubblePrefab)
          if bubbleData.direction == 1 then
            width = bubblePrefab.width
          end
          bubblePrefab.xy = Vector2(X + width, Y)
          bubblePrefab.visible = true
          local img = bubblePrefab:GetChild("n2")
          if bubbleDefaultSizeY == 0 then
            bubbleDefaultSizeY = img.height
          end
          local txt = bubblePrefab:GetChild("TalkTxt")
          txt.text = bubbleData.bubble_text
          uisRoot = uis
          local animation = bubblePrefab:GetTransition("in")
          animation.invalidateBatchingEveryFrame = true
          animation:Play()
        end
      end
    end
  end
end

AudioManager.GetBubblePrefab = function(name, ...)
  -- function num : 0_5 , upvalues : bubblePool, _ENV
  local bPrefab = bubblePool[name]
  print("bubble    name", name)
  do
    if not bPrefab then
      local strPath = split(name, ":")
      bPrefab = UIMgr:CreateObject(strPath[1], strPath[2])
      bPrefab.touchable = false
      bubblePool[name] = bPrefab
    end
    return bPrefab
  end
end

AudioManager.RandomGetOneAudioId = function(str, ...)
  -- function num : 0_6 , upvalues : _ENV, currentBubbleId
  local ids = split(str, ":")
  local id = 0
  while 1 do
    local value = (math.random)(1, #ids)
    id = tonumber(ids[value])
    if id ~= currentBubbleId then
      return id
    end
  end
end

AudioManager.DisposeCurAudioAndBubble = function(isSaveAudio, ...)
  -- function num : 0_7 , upvalues : _ENV, currentAudioId, uisRoot, bubblePrefab, isPlayingAudio, bubbleTimer
  loge("清空当前所有的语音和气泡    " .. currentAudioId)
  if uisRoot then
    (uisRoot.root):RemoveChild(bubblePrefab)
  end
  if currentAudioId == 0 then
    return 
  end
  if bubblePrefab then
    bubblePrefab.visible = false
  end
  if isSaveAudio == nil then
    isPlayingAudio = false
    local AudioMgr = (CS.AudioAssetManager).Singleton
    AudioMgr:RemoveSound(currentAudioId, false)
    currentAudioId = 0
  end
  do
    if bubbleTimer ~= nil then
      bubbleTimer:Comp()
      bubbleTimer = nil
    end
  end
end

AudioManager.RecordFirstLogin = function(...)
  -- function num : 0_8 , upvalues : recordFirstLogin
  recordFirstLogin = true
end

AudioManager.GetRecordFirstLogin = function(...)
  -- function num : 0_9 , upvalues : recordFirstLogin
  return recordFirstLogin
end

return AudioManager

