-- params : ...
-- function num : 0 , upvalues : _ENV
local ResolutionHandler = {}
local _screenWidth = ((CS.UnityEngine).Screen).width
local _screenHeight = ((CS.UnityEngine).Screen).height
local _designScreenWidth = DesignScreen.width
local _designScreenHeight = DesignScreen.height
local self = ResolutionHandler
self.Width = _designScreenWidth
self.Height = _designScreenHeight
self.AdaptOffset = {X = 0, Y = 0}
self.UIscale = 0.01333333
ResolutionHandler.Init = function(...)
  -- function num : 0_0 , upvalues : _screenWidth, _designScreenWidth, _screenHeight, _designScreenHeight, self, _ENV
  local dx = _screenWidth / _designScreenWidth
  local dy = _screenHeight / _designScreenHeight
  if dx < dy then
    dy = _screenWidth / _screenHeight
    dx = _designScreenWidth / (dy)
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self.AdaptOffset).Y = (dx - _designScreenHeight) * 0.5
    self.Height = dx
  else
    dy = _screenWidth / _screenHeight
    dx = _designScreenHeight * (dy)
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R2 in 'UnsetPending'

    ;
    (self.AdaptOffset).X = (dx - _designScreenWidth) * 0.5
    self.Width = dx
  end
  self.UIscale = (((((((CS.FairyGUI).Stage).inst).gameObject).transform):Find("GRoot/UILayer")).lossyScale).x
end

;
(ResolutionHandler.Init)()
return ResolutionHandler

