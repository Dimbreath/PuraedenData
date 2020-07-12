-- params : ...
-- function num : 0 , upvalues : _ENV
local require = require
if IsBattleServer == true then
  loge = function(...)
  -- function num : 0_0
end

  logw = function(...)
  -- function num : 0_1
end

  log = function(...)
  -- function num : 0_2
end

end
require("BattleUtil")
require("BattleConfig")
require("BattleService")
require("BattleAtk")
require("BattleBackground")
require("BattleBuff")
require("BattleBuffMgr")
require("BattleBuffEffect")
require("BattleCard")
require("BattleCardInfo")
require("BattleData")
require("BattleMgr")
require("BattlePlay")
require("BattleChoose")
require("BattleDataCount")
require("BattleCardHeadInfo")
require("BattleHurtNum")
require("BattleResource")
require("BattleSkill")
require("BattleResultCount")
require("BattleCameraMgr")
local BattleScriptList = {}
return BattleScriptList

