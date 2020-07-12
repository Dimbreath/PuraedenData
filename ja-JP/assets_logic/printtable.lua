-- params : ...
-- function num : 0 , upvalues : _ENV
local tconcat = table.concat
local tinsert = table.insert
local tsort = table.sort
local type = type
local pairs = pairs
local ipairs = ipairs
local tostring = tostring
PrintTable = function(root, frontstr, name, ...)
  -- function num : 0_0 , upvalues : _ENV, pairs, tinsert, tsort, ipairs, type, tconcat, tostring
  if IsBattleServer == true and frontstr ~= "battleCompleteData" then
    return ""
  end
  if Game and Game.testPackage == true and frontstr ~= "battleCompleteData" then
    return ""
  end
  local cache = {[root] = "."}
  local result = ""
  local _dump = function(t, space, name, ...)
    -- function num : 0_0_0 , upvalues : pairs, tinsert, tsort, ipairs, type, tconcat, tostring, cache, _dump
    local temp = {}
    local tableKey = {}
    for key in pairs(t) do
      if key ~= nil then
        tinsert(tableKey, key)
      end
    end
    tsort(tableKey, function(a, b, ...)
      -- function num : 0_0_0_0
      do return a < b end
      -- DECOMPILER ERROR: 1 unprocessed JMP targets
    end
)
    for _,key in ipairs(tableKey) do
      local v = t[key]
      if type(key) == "number" then
        key = tconcat({"[", key, "]"})
      else
        key = tostring(key)
      end
      if cache[v] then
        tinsert(temp, tconcat({"\n", key, " = {", cache[v], "\n},"}))
      else
        if type(v) == "table" then
          local new_key = tconcat({name, ".", key})
          cache[v] = new_key
          tinsert(temp, tconcat({key, " = { \n", _dump(v, "", new_key), "\n},"}))
        else
          do
            do
              if type(v) == "string" then
                v = tconcat({"\"", v, "\""})
              end
              tinsert(temp, tconcat({key, "=", tostring(v), ","}))
              -- DECOMPILER ERROR at PC112: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC112: LeaveBlock: unexpected jumping out IF_ELSE_STMT

              -- DECOMPILER ERROR at PC112: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC112: LeaveBlock: unexpected jumping out IF_ELSE_STMT

              -- DECOMPILER ERROR at PC112: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    end
    return tconcat(temp, "\n")
  end

  local str = frontstr or ""
  if name ~= nil then
    if name == "ReqHeartBeat" or name == "ResHeartBeat" then
      result = tconcat({str, " ", name, "\n", _dump(root, "", "")})
      log(result)
    else
      result = tconcat({str, " ", name, "\n", _dump(root, "", "")})
      logw(result)
    end
  else
    result = tconcat({str, "= {\n", _dump(root, "", ""), "\n}"})
    logw(result)
  end
  return result
end

-- DECOMPILER ERROR at PC14: Confused about usage of register: R7 in 'UnsetPending'

table.equal = function(tableA, tableB, ...)
  -- function num : 0_1 , upvalues : pairs, type, _ENV
  for i,v in pairs(tableA) do
    -- DECOMPILER ERROR at PC28: Unhandled construct in 'MakeBoolean' P1

    -- DECOMPILER ERROR at PC28: Unhandled construct in 'MakeBoolean' P1

    -- DECOMPILER ERROR at PC28: Unhandled construct in 'MakeBoolean' P1

    if tableB[i] and type(v) == type(tableB[i]) and type(v) == "table" and (table.equal)(v, tableB[i]) == false then
      return false
    end
    if v ~= tableB[i] then
      return false
    end
    do return false end
    do return false end
  end
  for i,v in pairs(tableB) do
    -- DECOMPILER ERROR at PC71: Unhandled construct in 'MakeBoolean' P1

    -- DECOMPILER ERROR at PC71: Unhandled construct in 'MakeBoolean' P1

    -- DECOMPILER ERROR at PC71: Unhandled construct in 'MakeBoolean' P1

    if tableA[i] and type(v) == type(tableA[i]) and type(v) == "table" and (table.equal)(v, tableA[i]) == false then
      return false
    end
    if v ~= tableA[i] then
      return false
    end
    do return false end
    do return false end
  end
  return true
end


