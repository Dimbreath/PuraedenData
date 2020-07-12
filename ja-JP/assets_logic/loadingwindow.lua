-- params : ...
-- function num : 0 , upvalues : _ENV
require("Loading_LoadingWindowByName")
local LoadingWindow = {}
local uis, contentPane = nil, nil
local saveValue = 0
local texture = nil
LoadingWindow.ReInitData = function(...)
  -- function num : 0_0
end

LoadingWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_1 , upvalues : saveValue, _ENV, contentPane, uis
  saveValue = 0
  bridgeObj:SetView((WinResConfig.LoadingWindow).package, (WinResConfig.LoadingWindow).comName)
  contentPane = bridgeObj.contentPane
  contentPane:Center()
  uis = GetLoading_LoadingWindowUis(contentPane)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.LoadingProgressBar).value = 0
end

LoadingWindow.OnShown = function(...)
  -- function num : 0_2 , upvalues : _ENV, uis, texture
  local config = (((TableData.gTable).BaseFixedData)[72010040]).array_value
  config = split(config, ":")
  local index = (math.ceil)((math.random)(1, #config))
  local id = config[index]
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R3 in 'UnsetPending'

  if id then
    (uis.WordTxt).text = (PUtil.get)(id)
  end
  local picConfig = (((TableData.gTable).BaseFixedData)[72010041]).array_value
  picConfig = split(picConfig, ":")
  local index = (math.ceil)((math.random)(1, #picConfig))
  local id = picConfig[index]
  if id then
    texture = (ResHelper.LoadTexture)(id)
    if texture ~= nil then
      SetLoaderTexture(uis.BgLoader, texture)
    end
  end
end

LoadingWindow.OnHide = function(...)
  -- function num : 0_3
end

LoadingWindow.OnClose = function(...)
  -- function num : 0_4 , upvalues : texture, _ENV, uis, contentPane
  if texture then
    (ResHelper.UnloadTexture)(texture)
    texture = nil
  end
  uis = nil
  contentPane = nil
end

LoadingWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_5 , upvalues : _ENV, uis, saveValue
  if msgId == (WindowMsgEnum.LoadingWindow).E_MSG_UPDATE_LOADING_PROCESS then
    para = para + 0.05
    -- DECOMPILER ERROR at PC8: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (uis.LoadingProgressBar).value = (para) * 100
  else
    if msgId == (WindowMsgEnum.LoadingWindow).E_MSG_UPDATE_LOADING_PROCESS_TWEEN then
      local value = para.value
      do
        local callback = para.callback
        if value >= 1 then
          ((uis.LoadingProgressBar):TweenValue(value * 100, 0.2)):OnComplete(function(...)
    -- function num : 0_5_0 , upvalues : _ENV, callback
    (LeanTween.delayedCall)(0.1, callback)
  end
)
        else
          ;
          (uis.LoadingProgressBar):TweenValue(value * 100, 0.2)
        end
      end
    else
      do
        if msgId == (WindowMsgEnum.LoadingWindow).E_MSG_UPDATE_LOADING_PROCESS_TWEEN_ADD then
          local value = para.value
          saveValue = saveValue + value
          local callback = para.callback
          loge("saveValue" .. saveValue)
          if saveValue >= 1 then
            ((uis.LoadingProgressBar):TweenValue(saveValue * 100, 0.3)):OnComplete(function(...)
    -- function num : 0_5_1 , upvalues : _ENV, callback
    (LeanTween.delayedCall)(0.1, callback)
  end
)
          else
            ;
            (uis.LoadingProgressBar):TweenValue(saveValue * 100, 0.3)
          end
        end
      end
    end
  end
end

return LoadingWindow

