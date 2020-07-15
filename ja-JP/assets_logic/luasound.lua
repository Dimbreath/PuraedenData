-- params : ...
-- function num : 0 , upvalues : _ENV
local FMODCom = CS.FMODCom
local bgmEventInstance, _bgmID = nil, nil
local LuaSound = {COMMON_BTN_CLICK = "event:/UI/UI_Cmn/sfx_ui_click_bottom", COMMON_BOTTOM_CLICK = "event:/UI/UI_Cmn/sfx_ui_click_bottom", COMMON_TAB_CLICK = "event:/UI/UI_Cmn/sfx_ui_click_tag", COMMON_TAB_CLICK_FAIL = "event:/UI/UI_Cmn/sfx_ui_click_tag", COMMON_CARD_CLICK = "event:/UI/UI_Cmn/sfx_ui_click_bottom", COMMON_ROLE_CLICK = "event:/UI/UI_Cmn/sfx_ui_click_simple_01", COMMON_WIN_BACK = "event:/UI/UI_Cmn/sfx_ui_click_back", COMMON_WIN_CLOSE = "event:/UI/UI_Cmn/sfx_ui_click_back", COMMON_SHOW_REWARD = "event:/UI/UI_Other/sfx_ui_show_reward_01", COMMON_SHOW_REWARD_TINY = "event:/UI/UI_Other/sfx_ui_show_reward_tiny", COMMON_POP_WIN = "event:/UI/UI_Other/sfx_ui_show_wd_small_01", COMMON_PANEL_IN = "event:/UI/UI_Other/sfx_ui_slide_simple_01", COMMON_SLIDE_2 = "event:/UI/UI_Other/sfx_ui_slide_simple_02", COMMON_LIST_ANIM = "event:/UI/UI_Other/sfx_ui_menu_roll_01", CARD_UP_FLASH = "event:/UI/UI_Other/sfx_ui_role_lvup_01", CARD_STAR_UP_FLASH = "event:/UI/UI_Other/sfx_ui_role_lvup_02", BATTLE_UP = "event:/UI/UI_Other/sfx_ui_score_power", CARD_USE_EXP_ITEM = "event:/UI/UI_Other/sfx_ui_role_exp_add", COMMON_WARNING = "event:/UI/UI_Other/sfx_ui_error_warning", EQUIP_ON = "event:/UI/UI_Other/sfx_ui_equip_on", EQUIP_IDENTIFY = "event:/UI/UI_Other/sfx_ui_jianding", HERO_DUNGEON_SHOW = "event:/UI/UI_Other/sfx_ui_show_maoxian", DUNGEON_SHOW = "event:/UI/UI_Other/sfx_ui_zhangjie_roll", ARENA_MAIN = "event:/UI/UI_Other/sfx_ui_show_doujichang", ARENA_REFRESH = "event:/UI/UI_Other/sfx_ui_qiehuan_doujichang", HANDBOOK_ACTIVE = "event:/UI/UI_Other/sfx_ui_chengyuan_jihuo", HANDBOOK_INTIMACY_LEVELUP = "event:/UI/UI_Other/sfx_ui_lvup_haogandu", GUILD_WELFARE_TOUCH = "event:/UI/UI_Other/sfx_ui_xuli", GUILD_BLESS_TOUCH = "event:/UI/UI_Other/sfx_ui_qifu_diandeng", LOTTERY_ONE = "event:/UI/UI_Other/sfx_tx_zhaomu", TALENT_LEVEL_UP = "event:/UI/UI_Other/sfx_ui_tianfu_lvup_01", LOTTERY_REWARD = "event:/UI/UI_Other/sfx_tx_card_pt", CARD_GET_SHOW = "event:/UI/UI_Other/sfx_tx_card_role", UNLOCK_NEW_CG = "event:/UI/UI_Other/sfx_tx_cg_unlock", PLOT_PASS = "event:/UI/UI_Other/sfx_tx_chapter_done", TX_OPEN_BOX = "event:/UI/UI_Other/sfx_tx_box_open", ADVENTURE_FLIP_CARD = "event:/UI/UI_Other/sfx_mijing_card_show", ADVENTURE_ACQUIRE_GOLD = "event:/UI/UI_Other/sfx_mijing_coin_show", ADVENTURE_THROW_DICE = "event:/UI/UI_Other/sfx_mijing_dice_show_roll", ADVENTURE_CATCH_GOLD = "event:/UI/UI_Other/sfx_mijing_game_coin", ADVENTURE_RPS_START = "event:/UI/UI_Other/sfx_mijing_game_caiquan_1", ADVENTURE_RPS_RESULT = "event:/UI/UI_Other/sfx_mijing_game_caiquan_2", ADVENTURE_KNOCK_BRICK = "event:/UI/UI_Other/sfx_mijing_game_stone", ADVENTURE_BOOM = "event:/UI/UI_Other/sfx_mijing_game_explosion", PLOT_CLICK = "event:/UI/UI_Other/sfx_juqing_click", FORMATION_DRAG_START = "event:/UI/UI_Other/sfx_ui_buzhen_grab", FORMATION_DRAG_END = "event:/UI/UI_Other/sfx_ui_buzhen_set", FORMATION_TO_CARDLIST = "event:/UI/UI_Other/sfx_ui_buzhen_back", BATTLE_BIG_SKILL = "event:/UI/UI_Other/sfx_ui_btl_big_ntf", BATTLE_SMALL_SKILL = "event:/UI/UI_Other/sfx_ui_btl_small_ntf", ADVENTURE_STEP = "event:/UI/UI_Other/sfx_mijing_game_step", LOTTERY_FLIP_BOOK = "event:/UI/UI_Other/sfx_tx_zhaomu_release", RESULT_ROLE_LVUP = "event:/UI/UI_Other/sfx_ui_jiesuan_lvup", GAME_CARD_WIN = "event:/UI/UI_Other/sfx_mijing_game_card_win"}
SoundBank = {COMMON_CLICK = "UI_Cmn", OTHER = "UI_Other"}
SoundType = {Sound = 1, Music = 2, CV = 3}
LuaSound.GetBGMId = function(...)
  -- function num : 0_0 , upvalues : _bgmID
  return _bgmID
end

LuaSound.UpdateSoundInfo = function(...)
  -- function num : 0_1 , upvalues : FMODCom, _ENV
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R0 in 'UnsetPending'

  (FMODCom.Singleton).SoundVolume = (Util.GetFloatPlayerSetting)(PlayerPrefsKeyName.SOUND_VOLUME, 1)
  -- DECOMPILER ERROR at PC19: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (FMODCom.Singleton).SoundMute = (Util.GetPlayerSetting)(PlayerPrefsKeyName.SOUND_MUTE, "0") == "1"
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

LuaSound.SetClickSound = function(object, soundName, ...)
  -- function num : 0_2 , upvalues : _ENV
  local UIConfig = FairyGUI.UIConfig
  if UIConfig.fmod == true then
    object.soundFMod = soundName
  else
    local AudioMgr = (CS.AudioAssetManager).Singleton
    local ac = AudioMgr:GetAudioClip(soundName)
    if ac ~= nil then
      object.sound = (FairyGUI.NAudioClip)(ac)
    end
  end
end

LuaSound.PlaySound = function(soundName, bank, callback, soundType, ...)
  -- function num : 0_3 , upvalues : _ENV, FMODCom
  if not bank then
    bank = SoundBank.OTHER
  end
  local volume, mute = nil, nil
  if soundType == SoundType.Music then
    volume = (Util.GetFloatPlayerSetting)(PlayerPrefsKeyName.MUSIC_VOLUME, 1)
    mute = (Util.GetPlayerSetting)(PlayerPrefsKeyName.MUSIC_MUTE, "0") == "1"
  elseif soundType == SoundType.CV then
    volume = (Util.GetFloatPlayerSetting)(PlayerPrefsKeyName.CV_VOLUME, 1)
    mute = (Util.GetPlayerSetting)(PlayerPrefsKeyName.CV_MUTE, "0") == "1"
  else
    volume = (Util.GetFloatPlayerSetting)(PlayerPrefsKeyName.SOUND_VOLUME, 1)
    mute = (Util.GetPlayerSetting)(PlayerPrefsKeyName.SOUND_MUTE, "0") == "1"
  end
  do
    if soundName ~= nil and (not mute or callback ~= nil) then
      local eventInstance = (FMODCom.Singleton):Play(soundName, bank)
      if mute then
        eventInstance:setVolume(0)
      else
        eventInstance:setVolume(volume)
      end
      if callback ~= nil then
        eventInstance:setCallback(callback, (((CS.FMOD).Studio).EVENT_CALLBACK_TYPE).SOUND_STOPPED)
      end
      return eventInstance
    end
    -- DECOMPILER ERROR: 11 unprocessed JMP targets
  end
end

LuaSound.StopSound = function(eventInstance, stop_mode, ...)
  -- function num : 0_4 , upvalues : _ENV
  if eventInstance and not stop_mode then
    eventInstance:stop((((CS.FMOD).Studio).STOP_MODE).ALLOWFADEOUT)
  end
end

LuaSound.PlayBGM = function(soundName, bank, ...)
  -- function num : 0_5 , upvalues : bgmEventInstance, LuaSound, _ENV
  if not soundName then
    bgmEventInstance = (LuaSound.PlaySound)(bgmEventInstance ~= nil or LuaSound.MAIN_BGM_01, bank, nil, SoundType.Music)
  end
end

LuaSound.ChangeBGMVolume = function(volume, ...)
  -- function num : 0_6 , upvalues : bgmEventInstance
  if bgmEventInstance ~= nil then
    bgmEventInstance:setVolume(volume)
  end
end

LuaSound.StopBGM = function(...)
  -- function num : 0_7 , upvalues : _bgmID, bgmEventInstance, LuaSound
  _bgmID = nil
  if bgmEventInstance ~= nil then
    (LuaSound.StopSound)(bgmEventInstance)
    bgmEventInstance = nil
  end
end

LuaSound.ChangeBGM = function(soundName, bank, ...)
  -- function num : 0_8 , upvalues : LuaSound
  (LuaSound.StopBGM)()
  ;
  (LuaSound.PlayBGM)(soundName, bank)
end

LuaSound.LoadAndPlaySound = function(soundId, callback, ...)
  -- function num : 0_9 , upvalues : _ENV, LuaSound
  if soundId ~= nil then
    local soundConfig = ((TableData.gTable).BaseSoundPathData)[soundId]
    if soundConfig then
      local path = soundConfig.path
      local bank = soundConfig.bank
      if path and bank then
        return (LuaSound.PlaySound)(path, bank, callback)
      end
    end
  end
end

LuaSound.LoadAndPlayBGM = function(soundId, ignoreMute, ...)
  -- function num : 0_10 , upvalues : _ENV, _bgmID, LuaSound
  local mute = (Util.GetPlayerSetting)(PlayerPrefsKeyName.MUSIC_MUTE, "0") == "1"
  if _bgmID == soundId or ignoreMute == nil and mute then
    return 
  end
  if soundId ~= nil then
    local soundConfig = ((TableData.gTable).BaseSoundPathData)[soundId]
    if soundConfig then
      local path = soundConfig.path
      local bank = soundConfig.bank
      if path and bank then
        (LuaSound.ChangeBGM)(path, bank)
      end
    end
  end
  _bgmID = soundId
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

LuaSound.AudioMgrPlaySound = function(path, loop, callback, audioSource, specifyTime, ...)
  -- function num : 0_11 , upvalues : _ENV
  local volume = (Util.GetFloatPlayerSetting)(PlayerPrefsKeyName.CV_VOLUME, 1)
  local mute = (Util.GetPlayerSetting)(PlayerPrefsKeyName.CV_MUTE, "0") == "1"
  if not mute or callback ~= nil then
    if mute then
      volume = 0
    end
    local AudioMgr = (CS.AudioAssetManager).Singleton
    if not specifyTime then
      specifyTime = 0
    end
    return AudioMgr:PlaySound(path, loop, callback, audioSource, volume, specifyTime)
  else
    return -1
  end
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

LuaSound.ResetVideoSound = function(gameObject, ...)
  -- function num : 0_12 , upvalues : _ENV, FMODCom
  local vp = gameObject:GetComponentInChildren(typeof(((CS.UnityEngine).Video).VideoPlayer), true)
  if vp then
    vp:SetDirectAudioMute(0, (FMODCom.Singleton).SoundMute)
    vp:SetDirectAudioVolume(0, (FMODCom.Singleton).SoundVolume)
  end
end

return LuaSound

