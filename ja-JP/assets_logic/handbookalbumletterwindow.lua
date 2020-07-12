-- params : ...
-- function num : 0 , upvalues : _ENV
require("HandBook_AlbumLetterWindowByName")
local HandBookAlbumLetterWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local handLetterID = 0
HandBookAlbumLetterWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, handLetterID, uis
  bridgeObj:SetView((WinResConfig.HandBookAlbumLetterWindow).package, (WinResConfig.HandBookAlbumLetterWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  handLetterID = argTable[1]
  uis = GetHandBook_AlbumLetterWindowUis(contentPane)
  uis = uis.AlbumLetterGrp
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (uis.CloseBtn).text = (PUtil.get)(20000137)
  ;
  ((uis.CloseBtn).onClick):Set(function(...)
    -- function num : 0_0_0 , upvalues : _ENV, handLetterID
    UIMgr:CloseWindow((WinResConfig.HandBookAlbumLetterWindow).name)
    UIMgr:SendWindowMessage((WinResConfig.HandBookAlbumWindow).name, 2, handLetterID)
  end
)
end

HandBookAlbumLetterWindow.ShowLetter = function(...)
  -- function num : 0_1 , upvalues : _ENV, handLetterID, uis
  local cData = ((TableData.gTable).BaseHandLetterData)[handLetterID]
  if not cData then
    loge(handLetterID .. "未在BaseHandLetterData配置表中找到")
    return 
  end
  local word = UIMgr:CreateObject("HandBook", "AlbumLetterWord")
  local content = word:GetChild("WordTxt")
  content.text = cData.remark
  content.UBBEnabled = true
  ;
  (uis.WordList):AddChild(word)
end

HandBookAlbumLetterWindow.OnShown = function(...)
  -- function num : 0_2 , upvalues : HandBookAlbumLetterWindow
  (HandBookAlbumLetterWindow.ShowLetter)()
end

HandBookAlbumLetterWindow.OnHide = function(...)
  -- function num : 0_3
end

HandBookAlbumLetterWindow.OnClose = function(...)
  -- function num : 0_4 , upvalues : uis, contentPane, argTable
  uis = nil
  contentPane = nil
  argTable = {}
end

HandBookAlbumLetterWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_5
end

return HandBookAlbumLetterWindow

