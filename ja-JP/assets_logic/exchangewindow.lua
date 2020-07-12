-- params : ...
-- function num : 0 , upvalues : _ENV
local ExchangeWindow = {}
local contentPane = nil
ExchangeWindow.OnInit = function(bridgeObj, ...)
  -- function num : 0_0 , upvalues : _ENV, contentPane
  bridgeObj:SetView((WinResConfig.ExchangeWindow).package, (WinResConfig.ExchangeWindow).comName)
  contentPane = bridgeObj.contentPane
  contentPane:Center()
end

ExchangeWindow.OnShown = function(...)
  -- function num : 0_1
end

ExchangeWindow.OnHide = function(...)
  -- function num : 0_2
end

ExchangeWindow.OnClose = function(...)
  -- function num : 0_3 , upvalues : contentPane
  contentPane = nil
end

ExchangeWindow.HandleMessage = function(...)
  -- function num : 0_4
end

return ExchangeWindow

