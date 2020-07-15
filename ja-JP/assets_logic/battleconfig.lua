-- params : ...
-- function num : 0 , upvalues : _ENV
local battleCamera, cameraRotation = nil, nil
local ratio = 0
local Vector3 = CSLuaUtil and CSLuaUtil.Vector3 or Vector3
local math = math
local ipairs = ipairs
local t_insert = table.insert
local tonumber = tonumber
if IsBattleServer == nil then
  battleCamera = Game.battleCamera
  if battleCamera then
    cameraRotation = (battleCamera.transform).localEulerAngles
  end
  ratio = (math.tan)((math.rad)(cameraRotation and cameraRotation.x or 0))
end
BattleConfig = {ratio = ratio, maxMoveInterval = 0.3, flashInterval = 0.1, nextAttackWaitTime = 0.5, 
floatUpBaseSpeed = {1.2, 0.8, 0.4}
, 
imitateGravityAcceleration = {0.06, 0.06, 0.06}
, assistCameraSize = 28, assistCameraTime = 0.1, smokeOff = Vector3(0, -2, -2 * ratio), cardScale = 1.2, battleCameraPosition = Vector3(0, 28, -95), battleStartCameraOffset = Vector3(-100, 0, 0), orthographicSize = 25, battleCameraSizeChange = -5, cardJumpOffDefault = 4, cardPositionOff = Vector3(0, -4, 0), frontPosXOff = Vector3(7.5, 0, 0), frontPosXOff_far_1 = Vector3(10, 0, 0), frontPosXOff_far_2 = Vector3(15, 0, 0), damageShareFrontPosXOff = Vector3(2, 0, 0), nextWaveCardMoveX = 50, nextWaveCardMoveTime = 1.5, printBattleData = false, lowFrameRate = 40, highFrameRate = 60, sortingOrderInit = -100, skillTimelineOrderInit = 0, uniqueSkillHitOrder = 200, originBattleCameraCullingMask = 257, positionInvisible = Vector3(0, 10000, 0), positionZero = Vector3(0, 0, 0), positionCenter_5 = Vector3(5, 0, 0), positionCenter_13 = Vector3(13, 0, 0), positionCenter_15 = Vector3(15, 0, 0), positionCenter_20 = Vector3(20, 0, 0), positionCenter_30 = Vector3(30, 0, 0)}
local self = BattleConfig
OriBattleSpeedList = {1, 1.5, 2}
-- DECOMPILER ERROR at PC167: Confused about usage of register: R9 in 'UnsetPending'

BattleConfig.Init = function(...)
  -- function num : 0_0 , upvalues : self, _ENV, ipairs, t_insert, math, tonumber
  self.lockAuto = false
  self.ServerBattle = IsBattleServer
  if #BattleData.battleProcessData <= 0 then
    self.isPlayBack = IsBattleServer ~= nil
    self.isPlayBack = false
    if IsBattleServer == nil then
      local playType = (BattleData.GetPlayTypeByBattleType)(BattleData.battleType)
      local playConfig = (TableData.GetBasePlayConfigByType)(playType)
      BattleSpeedList = {}
      if playConfig then
        local set_speed = playConfig.set_speed
        for i,v in ipairs(OriBattleSpeedList) do
          if i <= set_speed then
            t_insert(BattleSpeedList, v)
          end
        end
      end
      if IsBattleTest == true then
        BattleSpeedList = OriBattleSpeedList
      end
      local E_BATTLE_TYPE = ProtoEnum.E_BATTLE_TYPE
      local battleType = BattleData.battleType
      self.speedIndex = (math.min)(tonumber((Util.GetPlayerSetting)(PlayerPrefsKeyName.BATTLE_SPEED_INDEX .. battleType, "1")), #BattleSpeedList)
      local playAuto = tonumber((Util.GetPlayerSetting)(PlayerPrefsKeyName.BATTLE_AUTO .. battleType, "0"))
      self.autoBattle = playAuto == 1
      if battleType == E_BATTLE_TYPE.ARENA or battleType == E_BATTLE_TYPE.ADVENTURE or battleType == E_BATTLE_TYPE.GUILD_PK then
        self.autoBattle = true
        self.lockAuto = true
      end
      if battleType == E_BATTLE_TYPE.ARENA or battleType == E_BATTLE_TYPE.GUILD_PK then
        self.runIntoBattle = false
      else
        self.runIntoBattle = true
      end
      self.onlySmallSkill = false
      self.autoStrike = false
      self.autoAssist = false
    end
    -- DECOMPILER ERROR: 13 unprocessed JMP targets
  end
end

-- DECOMPILER ERROR at PC170: Confused about usage of register: R9 in 'UnsetPending'

BattleConfig.UpdateCurFrameRate = function(...)
  -- function num : 0_1 , upvalues : tonumber, _ENV, self
  local isLowFrame = tonumber((Util.GetPlayerSetting)(PlayerPrefsKeyName.BATTLE_SETTING_FRAME, Game.defaultBattleFrame)) == 1
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

  if isLowFrame == true then
    Application.targetFrameRate = self.lowFrameRate
  else
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

    Application.targetFrameRate = self.highFrameRate
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC173: Confused about usage of register: R9 in 'UnsetPending'

BattleConfig.IsHideTopInfo = function(...)
  -- function num : 0_2 , upvalues : tonumber, _ENV
  local saveValue = tonumber((Util.GetPlayerSetting)(PlayerPrefsKeyName.BATTLE_SETTING_TOP_INFO, "0"))
  do return saveValue == 1 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC176: Confused about usage of register: R9 in 'UnsetPending'

BattleConfig.IsHideAttackInfo = function(...)
  -- function num : 0_3 , upvalues : tonumber, _ENV
  local saveValue = tonumber((Util.GetPlayerSetting)(PlayerPrefsKeyName.BATTLE_SETTING_ATTACK, "0"))
  do return saveValue == 1 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC179: Confused about usage of register: R9 in 'UnsetPending'

BattleConfig.IsHideHpInfo = function(...)
  -- function num : 0_4 , upvalues : tonumber, _ENV
  local saveValue = tonumber((Util.GetPlayerSetting)(PlayerPrefsKeyName.BATTLE_SETTING_HP, "0"))
  do return saveValue == 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC182: Confused about usage of register: R9 in 'UnsetPending'

BattleConfig.IsHideBattleHeadInfo = function(...)
  -- function num : 0_5 , upvalues : tonumber, _ENV
  local saveValue = tonumber((Util.GetPlayerSetting)(PlayerPrefsKeyName.BATTLE_SETTING_HP_BAR, "0"))
  do return saveValue == 1 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

-- DECOMPILER ERROR at PC185: Confused about usage of register: R9 in 'UnsetPending'

BattleConfig.IsHideBattleSpeed = function(...)
  -- function num : 0_6 , upvalues : tonumber, _ENV
  local saveValue = tonumber((Util.GetPlayerSetting)(PlayerPrefsKeyName.BATTLE_SETTING_SPEED, "0"))
  do return saveValue == 0 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

BattleState = {BATTLE_INIT = "BATTLE_INIT", PRE_EVENT_BEGIN = "PRE_EVENT_BEGIN", PRE_EVENT_ING = "PRE_EVENT_ING", WAVE_SHOW_BEGIN = "WAVE_SHOW_BEGIN", WAVE_SHOW_ING = "WAVE_SHOW_ING", BOSS_SHOW_BEGIN = "BOSS_SHOW_BEGIN", BOSS_SHOW_ING = "BOSS_SHOW_ING", ROUND_START = "ROUND_START", PRE_ROUND_PLAY = "PRE_ROUND_PLAY", PRE_ROUND_PLAYING = "PRE_ROUND_PLAYING", ROUND_PLAYING = "ROUND_PLAYING", CHANGE_ROUND = "CHANGE_ROUND", CHANGE_WAVE = "CHANGE_WAVE", CHANGE_WAVEING = "CHANGE_WAVEING", CHANGE_ATTACK = "CHANGE_ATTACK", BUFF_BEFORE_ATTACK = "BUFF_BEFORE_ATTACK", BUFF_BEFORE_ATTACK_ING = "BUFF_BEFORE_ATTACK_ING", PLAY_ATTACK = "PLAY_ATTACK", PLAY_ATTACK_ING = "PLAY_ATTACK_ING", BUFF_AFTER_ATTACK = "BUFF_AFTER_ATTACK", BUFF_AFTER_ATTACK_ING = "BUFF_AFTER_ATTACK_ING", BUFF_AFTER_ATTACK_END = "BUFF_AFTER_ATTACK_END", MOVE_BEGIN = "MOVE_BEGIN", MOVE_ING = "MOVE_ING", BATTLE_OVER = "BATTLE_OVER", SEND_BATTLE_END_MSG = "SEND_BATTLE_END_MSG", BATTLE_CLOSE = "BATTLE_CLOSE", BATTLE_ERROR = "BATTLE_ERROR", STORY_PLAY = "STORY_PLAY"}
BattleSkillType = {NORMAL = 1, SKILL = 2, SMALL = 3, ASSIST = 4}
BattleSkillSpecialType = {COPY = 1}
BattleRunSpeed = {
[1] = {min = 7000, max = 9000}
, 
[2] = {min = 7000, max = 9000}
, 
[3] = {min = 7000, max = 9000}
, 
[11] = {min = 7000, max = 9000}
, 
[12] = {min = 7000, max = 9000}
, 
[13] = {min = 7000, max = 9000}
}
BattleAttackType = {RUN = 1, JUMP = 2, STAND = 3, FLASH = 4}
BattleAttackMovePosType = {TARGET_CARD = 1, TARGET_CARD_LINE = 2, SCREEN_CENTER = 3, TARGET_CARD_FAR_1 = 10, TARGET_CARD_FAR_2 = 11}
BattleCardCamp = {LEFT = 1, RIGHT = 0}
BattleCardState = {NONE = "", IDLE = "idle", RUN = "run", CATCH = "catch", ATTACK = "attack", ATTACK_AIR = "attack_air", FALL_DOWN = "fall_down", FLOAT_DOWN = "float_down", FLOAT_UP = "float_up", DIE = "die", HIT_1 = "hit_1", HIT_2 = "hit_2", JUMP_B = "jump_b", JUMP_F = "jump_f", LAND = "land", STUN = "stun", DEFENCE = "defence", UP = "up", SKILL = "skill", PREPARE = "prepare", UNIQUE_SKILL = "uniqueskill"}
BattleCardPosition = {
[1] = {pos = Vector3(-15, 0, 25)}
, 
[2] = {pos = Vector3(-18, 0, 0)}
, 
[3] = {pos = Vector3(-21, 0, -25)}
, 
[11] = {pos = Vector3(-28.5, 0, 25)}
, 
[12] = {pos = Vector3(-31.5, 0, 0)}
, 
[13] = {pos = Vector3(-34.5, 0, -25)}
, 
[101] = {pos = Vector3(15, 0, 25)}
, 
[102] = {pos = Vector3(18, 0, 0)}
, 
[103] = {pos = Vector3(21, 0, -25)}
, 
[111] = {pos = Vector3(28.5, 0, 25)}
, 
[112] = {pos = Vector3(31.5, 0, 0)}
, 
[113] = {pos = Vector3(34.5, 0, -25)}
}
BattleCardFloatUpState = {NONE = 0, FLOAT = 1}
BattleBuffSettleRoundType = {BEFORE_ROUND = 1, BEFORE_ATTACK = 2, AFTER_ATTACK = 3, BEFORE_BATTLE = 4, BEFORE_SKILL = 5, AFTER_SKILL = 6, BEFORE_ACTION = 8, AFTER_ACTION = 9}
BattleBuffDeductionRoundType = {NOW = 0, BEFORE_ROUND = 1, BEFORE_ATTACK = 2, AFTER_ATTACK = 3, BEFORE_BATTLE = 4, BEFORE_SKILL = 5, AFTER_SKILL = 6, AFTER_SKILL_ENEMY = 7, BEFORE_ACTION = 8, AFTER_ACTION = 9, BEFORE_ROUND_SINCE_2 = 10, AFTER_HIT = 11, AFTER_TREAT_DIRECT = 12, AFTER_ATTRACT = 13, BEFORE_ROUND_3 = 14, AFTER_CRIT = 15, DAMAGE_20_PER = 16, DAMAGE_KILL = 17, DAMAGE_DEAD = 18, DAMAGE_BUFF_ACTIVE = 19, PARTNER_DEAD = 20, ONE_ENEMY_ALIVE = 21, ENEMY_CONTROL = 22, BEFORE_ROUND_DELAY = 30}
BattlePlaySettleRoundType = {NOW = 0, FIRST_ATTACK = 1}
BattleBuffEffectCalType = {NONE = 0, VALUE = 1, ATK_PER = 2, HP_PER = 3, DEF_PER = 4, HURT_PER = 5, ATK_BASED_TARGET_DEAD = 6, ATK_BASED_SELF_DEAD = 7, ATK_BASED_ALL_DEAD = 8, ATK_BASED_TARGET_HP = 9, DAMAGE_BASED_TARGET_DEAD = 10, ATK_BASED_CLEAR_BUFF = 11, SPD_PER = 12}
_ENV.BattleBuffEffectDependType = {ATK_CARD = 1, DEF_CARD = 2}
_ENV.BattleBuffControlType = {TARGET_FORCE = 101, TARGET_RANDOM = 102, TARGET_SELF = 103, FORBIDDEN_NORMAL = 201, FORBIDDEN_SMALL = 202, FORBIDDEN_SKILL = 203, FORBIDDEN_ASSIST = 204, FORBIDDEN_ASSIST_PASSIVE = 205, FORBIDDEN_BLOCK = 301, FORBIDDEN_ATTACK_HIT = 302, FORBIDDEN_DEFEND_DODGE = 303, REMOVE_ANY_ATTACK = 401, FORBIDDEN_TREATMENT = 402}
_ENV.BattleCardAttributeID = {HP = 81050001, DANDER = 81050024}
_ENV.HurtNumType = {NOR_HURT = "NOR_HURT", CRI_HURT = "CRI_HURT", MISS_HURT = "MISS_HURT", NOR_TREATMENT = "NOR_TREATMENT", ABSORB_HURT = "ABSORB_HURT", MOVE_FAIL = "MOVE_FAIL", DANDER = "DANDER", BLOCK_HURT = "BLOCK_HURT", BUFF_HURT = "BUFF_HURT", INVINCIBLE = "INVINCIBLE", DOUBLE_ATTACK = "DOUBLE_ATTACK", KEEP_ALIVE = "KEEP_ALIVE", UNTREATMENT = "UNTREATMENT", RESIST = "RESIST", IMMUNE = "IMMUNE"}
_ENV.BattleDisplayEffect = {DAMAGE_EXTRA = 101, DAMAGE_PERSIST = 102, DAMAGE_PERCENT = 103, DAMAGE_REPEAT = 104, DEADLY = 105, STAMP = 106, COUNTER = 107, DIRECT_KILL = 108, UNIQUESKILL_DAMAGE_ADD = 109, DOUBLE_ATTACK = 110, FORCE_ASSIST = 111, SUMMON = 112, OFFER_REWARD = 113, WARLIKE = 116, ATTACK_DAMAGE_CHANGE = 117, HIT_DAMAGE_CHANGE = 118, DAMAGE_PERSIST_UP = 119, CRIT_PERSIST = 120, REB_PERSIST = 121, TREATMENT_EXTRA = 201, TREATMENT_PERSIST = 202, SHIELD = 301, DAMAGE_REDUCE = 302, KEEP_ALIVE = 303, DAMAGE_SHARE = 304, BLOCK_PERSIST = 305, INVINCIBLE = 306, RESIST = 309, SHIELD_UP = 311, REC_PERSIST = 312, ENCHANTMENT = 401, PARALYSIS = 402, STUN = 403, SLEEP = 404, SILENT = 405, BLIND = 406, UNTREATMENT = 407, CONFUSION = 408, ATTRACT = 409, LIE = 412, FOCUS_ATTACK = 413, DANDER_ABSORB = 607}
_ENV.BattleBuffEffectPosType = {BLOOD = 1, HEAD = 2, BODY = 3, AROUND = 4, WORD = 5}
_ENV.BattleEffectEnum = {COMMON_STUN = "fx_common_stun", COMMON_ENCHANTMENT = "fx_common_enchantment", COMMON_SLEEP = "fx_common_sleep", COMMON_SILENT = "fx_common_silent", COMMON_CONFUSION = "fx_common_confusion", COMMON_BLIND = "fx_common_blind", COMMON_UNTREATMENT = "fx_common_untreatment", COMMON_PARALYSIS = "fx_common_paralysis", COMMON_BLOODUP = "fx_common_bloodup", COMMON_FLASH = "FX_common_Flash", COMMON_FALLDOWN_SMOKE = "FX_common_falldown_Smoke", COMMON_SHADOW = "fx_common_shadow", COMMON_LEAD = "fx_common_lead", COMMON_NORMAL_SHIELD = "FX_common_normal_Shield", COMMON_PARTY_DIE = "fx_common_Party_Die", COMMON_SKILL_SHIELD = "FX_common_skill_Shield", COMMON_PRESS = "FX_common_press", COMMON_GATHERING = "FX_common_Gathering", COMMON_SKILL_FLASH = "FX_common_skill_Flash", COMMON_IRRADIATION = "FX_common_Irradiation", COMMON_TELEPORT = "FX_common_Teleport", COMMON_RUN_SMOKE = "FX_common_run_Smoke", COMMON_BLOCK = "FX_common_Block", COMMON_BURNING = "FX_common_Burning", COMMON_ENEMY_DIE = "FX_common_Enemy_Die", COMMON_BOOK_FLASH = "FX_common_Flash_ui"}
_ENV.BattleWinConditionType = {DEFAULT = "0", ENEMY_BEHIND_DEAD = "1", CARD_HP_PERCENT = "2"}
_ENV.BattleBuffWordType = {ABSORB = "Battle:buff_301", BLOCK = "Battle:buff_305", INVINCIBLE = "Battle:buff_306", CRIT = "Battle:buff_baoji", MOVE_FAIL = "Battle:buff_001", IMMUNE = "Battle:buff_002", DOUBLE_ATTACK = "Battle:buff_110", KEEP_ALIVE = "Battle:buff_303", UNTREATMENT = "Battle:buff_407", RESIST = "Battle:buff_309", ASSIST = "Battle:buff_xieji"}
_ENV.BuffTriggerCondition = {BUFF_TARGET_HP_PER = 1001, SELF_HP_PER = 1002, ATTACK_TARGET_HP_PER = 1003, SELF_TARGET_DANDER = 1011, TARGET_DANDER = 1112, SELF_TARGET_ATK = 1120, RANDOM = 1130, SELF_CAMP_CARD_ALIVE = 2001, TARGET_HAVE_EFFECT = 2010, TARGET_HAVE_BUFF_TYPE = 2011, TARGET_HAVE_BUFF = 2012, BATTLE_TYPE_PVE = 3000, BATTLE_TYPE_PLOT = 3001, BATTLE_TYPE_HERO = 3002, BATTLE_TYPE_DAILY = 3003, BATTLE_TYPE_TOWER = 3004, BATTLE_TYPE_EXPEDITION = 3005, BATTLE_TYPE_ARENA = 3006}
_ENV.BattleBuffOprType = {NEW = "NEW", UPDATE = "UPDATE", DELETE = "DELETE", IMMUNE = "IMMUNE", RESET = "RESET"}

