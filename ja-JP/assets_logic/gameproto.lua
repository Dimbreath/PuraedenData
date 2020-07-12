-- params : ...
-- function num : 0 , upvalues : _ENV
local proto = {}
proto.NameByID = {[666] = "Person"}
proto.IDByName = {Person = 666}
return proto

