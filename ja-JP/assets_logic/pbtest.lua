-- params : ...
-- function num : 0 , upvalues : _ENV
local pb = require("pb")
local protoc = require("Protoc")
assert(protoc:load("   message Phone {\n      optional string name        = 1;\n      optional int64  phonenumber = 2;\n   }\n   message Person {\n      optional string name     = 1;\n      optional int32  age      = 2;\n      optional string address  = 3;  //对方对方的\n      repeated Phone  contacts = 4;\n      optional Color ddd = 5;\n   }\n\n    enum Color { Red = 1; Green = 2; Blue = 3 }\n    "))
local data = {name = "ilse", age = 18, 
contacts = {
{name = "alice", phonenumber = 12312341234}
, 
{name = "bob", phonenumber = 45645674567}
}
, ddd = 2}

