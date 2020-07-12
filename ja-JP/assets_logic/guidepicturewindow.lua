-- params : ...
-- function num : 0 , upvalues : _ENV
require("Guide_PictureLookByName")
local GuidePictureWindow = {}
local uis, contentPane = nil, nil
local argTable = {}
local count = 0
local currentIndex = 0
local winData = {}
local picture = {}
local word = {}
GuidePictureWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane, argTable, uis, winData, GuidePictureWindow
  bridgeObj:SetView((WinResConfig.GuidePictureWindow).package, (WinResConfig.GuidePictureWindow).comName)
  contentPane = bridgeObj.contentPane
  argTable = bridgeObj.argTable
  uis = GetGuide_PictureLookUis(contentPane)
  do
    if argTable then
      local winID = argTable[1]
      winData = ((TableData.gTable).BaseWindowNameData)[winID]
    end
    ;
    ((GRoot.inst).onClick):Set(GuidePictureWindow.OnClickNext)
  end
end

GuidePictureWindow.OnClickNext = function(...)
  -- function num : 0_1 , upvalues : currentIndex, count, _ENV, winData, picture, word, uis
  if count <= currentIndex then
    (GuideMgr.PictureGuidePlayOver)(winData.id)
    UIMgr:CloseWindow((WinResConfig.GuidePictureWindow).name)
    return 
  end
  currentIndex = currentIndex + 1
  local path = picture[currentIndex]
  local wordID = word[currentIndex]
  -- DECOMPILER ERROR at PC27: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (uis.PicLoader).url = (Util.GetItemUrl)(path)
  ;
  (((uis.PicLoader).component):GetChild("WordTxt")).text = (PUtil.get)(tonumber(wordID))
end

GuidePictureWindow.InitBtn = function(...)
  -- function num : 0_2 , upvalues : uis, currentIndex, _ENV, count, GuidePictureWindow
  ((uis.CloseBtn).onClick):Set(function(...)
    -- function num : 0_2_0
  end
)
  ;
  ((uis.RightBtn).onClick):Set(function(...)
    -- function num : 0_2_1 , upvalues : currentIndex, _ENV, count, GuidePictureWindow
    currentIndex = (math.min)(count, currentIndex + 1)
    ;
    (GuidePictureWindow.RefreshWin)()
  end
)
  ;
  ((uis.LeftBtn).onClick):Set(function(...)
    -- function num : 0_2_2 , upvalues : currentIndex, _ENV, GuidePictureWindow
    currentIndex = (math.max)(1, currentIndex - 1)
    ;
    (GuidePictureWindow.RefreshWin)()
  end
)
end

GuidePictureWindow.RefreshWin = function(...)
  -- function num : 0_3
end

GuidePictureWindow.OnShown = function(...)
  -- function num : 0_4 , upvalues : winData, _ENV, picture, count, word, currentIndex, GuidePictureWindow
  if not winData or (Util.StringIsNullOrEmpty)(winData.pic_path) then
    loge("图片引导未找到配置")
    UIMgr:CloseWindow((WinResConfig.GuidePictureWindow).name)
    return 
  end
  local configS = winData.pic_path
  picture = split(configS, ",")
  count = #picture
  word = split(winData.pic_content, ",")
  currentIndex = 0
  ;
  (GuidePictureWindow.OnClickNext)()
end

GuidePictureWindow.OnHide = function(...)
  -- function num : 0_5
end

GuidePictureWindow.OnClose = function(...)
  -- function num : 0_6 , upvalues : _ENV, GuidePictureWindow, uis, contentPane, argTable, picture, word
  ((GRoot.inst).onClick):Remove(GuidePictureWindow.OnClickNext)
  uis = nil
  contentPane = nil
  argTable = {}
  picture = {}
  word = {}
end

GuidePictureWindow.HandleMessage = function(msgId, para, ...)
  -- function num : 0_7
end

return GuidePictureWindow

