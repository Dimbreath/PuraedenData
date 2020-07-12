-- params : ...
-- function num : 0 , upvalues : _ENV
require("Message_ExplainWindowByName")
require("Message_TextContentByName")
local ExplainWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local ruleDes = ""
ExplainWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, ruleDes, uis, ExplainWindow
  bridgeObj:SetView((WinResConfig.ExplainWindow).package, (WinResConfig.ExplainWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  ruleDes = tostring(argTable[1])
  uis = GetMessage_ExplainWindowUis(contentPane)
  uis = uis.Explain
  ;
  (LuaSound.PlaySound)(LuaSound.COMMON_POP_WIN, SoundBank.OTHER)
  -- DECOMPILER ERROR at PC34: Confused about usage of register: R1 in 'UnsetPending'

  if argTable[2] then
    (uis.ExplainTxt).text = argTable[2]
  else
    -- DECOMPILER ERROR at PC41: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (uis.ExplainTxt).text = (PUtil.get)(20000337)
  end
  ;
  (ExplainWindow.InitEvent)()
end

ExplainWindow.InitEvent = function(...)
  -- function num : 0_1 , upvalues : uis, _ENV
  ((uis.ContentList).onClick):Set(function(...)
    -- function num : 0_1_0 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.ExplainWindow).name)
  end
)
  ;
  ((uis.CloseBtn).onClick):Set(function(...)
    -- function num : 0_1_1 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.ExplainWindow).name)
  end
)
  ;
  ((uis.SureBtn).onClick):Set(function(...)
    -- function num : 0_1_2 , upvalues : _ENV
    UIMgr:CloseWindow((WinResConfig.ExplainWindow).name)
  end
)
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R0 in 'UnsetPending'

  ;
  (uis.SureBtn).text = (PUtil.get)(20000016)
end

ExplainWindow.OnShown = function(...)
  -- function num : 0_2 , upvalues : uis, _ENV, ruleDes, ExplainWindow
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R0 in 'UnsetPending'

  (uis.ContentList).numItems = 0
  local rule = split(ruleDes, "::")
  for i,v in ipairs(rule) do
    if not (Util.StringIsNullOrEmpty)(v) then
      local line = (ExplainWindow.CreateLine)(v)
      if line then
        (uis.ContentList):AddChild(line)
      end
    end
  end
end

ExplainWindow.CreateLine = function(content, ...)
  -- function num : 0_3 , upvalues : _ENV
  if (Util.StringIsNullOrEmpty)(content) then
    return 
  end
  local lineModel = UIMgr:CreateObject("Message", "TextContent")
  local model = GetMessage_TextContentUis(lineModel)
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (model.ContentTxt).UBBEnabled = true
  -- DECOMPILER ERROR at PC26: Confused about usage of register: R3 in 'UnsetPending'

  if (string.sub)(content, 0, 2) == "$$" then
    (model.TabImage).visible = false
    -- DECOMPILER ERROR at PC33: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (model.ContentTxt).text = (string.sub)(content, 3)
  else
    -- DECOMPILER ERROR at PC36: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (model.ContentTxt).text = content
  end
  return lineModel
end

ExplainWindow.OnHide = function(...)
  -- function num : 0_4
end

ExplainWindow.OnClose = function(...)
  -- function num : 0_5 , upvalues : uis, contentPane
  uis = nil
  contentPane = nil
end

ExplainWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_6
end

return ExplainWindow

