-- params : ...
-- function num : 0 , upvalues : _ENV
require("AdventureGame_HitBrickByName")
require("AdventureGame_Animation_StartByName")
require("AdventureGame_Animation_OverByName")
require("AdventureGame_BrickTalkByName")
GetAdventureGame_BrickGameUis = function(ui, ...)
  -- function num : 0_0 , upvalues : _ENV
  local uis = {}
  uis.ClockImage = ui:GetChild("ClockImage")
  uis.Brick_01_Grp = GetAdventureGame_HitBrickUis(ui:GetChild("Brick_01_Grp"))
  uis.Brick_02_Grp = GetAdventureGame_HitBrickUis(ui:GetChild("Brick_02_Grp"))
  uis.Brick_03_Grp = GetAdventureGame_HitBrickUis(ui:GetChild("Brick_03_Grp"))
  uis.Brick_04_Grp = GetAdventureGame_HitBrickUis(ui:GetChild("Brick_04_Grp"))
  uis.Brick_05_Grp = GetAdventureGame_HitBrickUis(ui:GetChild("Brick_05_Grp"))
  uis.Brick_06_Grp = GetAdventureGame_HitBrickUis(ui:GetChild("Brick_06_Grp"))
  uis.Brick_07_Grp = GetAdventureGame_HitBrickUis(ui:GetChild("Brick_07_Grp"))
  uis.Brick_08_Grp = GetAdventureGame_HitBrickUis(ui:GetChild("Brick_08_Grp"))
  uis.Brick_09_Grp = GetAdventureGame_HitBrickUis(ui:GetChild("Brick_09_Grp"))
  uis.Brick_10_Grp = GetAdventureGame_HitBrickUis(ui:GetChild("Brick_10_Grp"))
  uis.Brick_11_Grp = GetAdventureGame_HitBrickUis(ui:GetChild("Brick_11_Grp"))
  uis.Brick_12_Grp = GetAdventureGame_HitBrickUis(ui:GetChild("Brick_12_Grp"))
  uis.Brick_13_Grp = GetAdventureGame_HitBrickUis(ui:GetChild("Brick_13_Grp"))
  uis.Animation_StartGrp = GetAdventureGame_Animation_StartUis(ui:GetChild("Animation_StartGrp"))
  uis.Animation_OverGrp = GetAdventureGame_Animation_OverUis(ui:GetChild("Animation_OverGrp"))
  uis.TimeTxt = ui:GetChild("TimeTxt")
  uis.ReduceTimeTxt = ui:GetChild("ReduceTimeTxt")
  uis.BrickTalkGrp = GetAdventureGame_BrickTalkUis(ui:GetChild("BrickTalkGrp"))
  uis.TouchScreenBtn = ui:GetChild("TouchScreenBtn")
  uis.root = ui
  return uis
end


