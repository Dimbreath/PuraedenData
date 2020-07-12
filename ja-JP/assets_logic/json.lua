-- params : ...
-- function num : 0 , upvalues : _ENV
local math = require("math")
local string = require("string")
local table = require("table")
local json = {}
local json_private = {}
json.EMPTY_ARRAY = {}
json.EMPTY_OBJECT = {}
local decode_scanArray, decode_scanComment, decode_scanConstant, decode_scanNumber, decode_scanObject, decode_scanString, decode_scanWhitespace, isArray, isEncodable = nil, nil, nil, nil, nil, nil, nil, nil, nil
json.encode = function(v, ...)
  -- function num : 0_0 , upvalues : _ENV, json_private, isArray, table, json, isEncodable
  if v == nil then
    return "null"
  end
  local vtype = type(v)
  if vtype == "string" then
    return "\"" .. (json_private.encodeString)(v) .. "\""
  end
  if vtype == "number" or vtype == "boolean" then
    return tostring(v)
  end
  if vtype == "table" then
    local rval = {}
    local bArray, maxCount = isArray(v)
    if bArray then
      for i = 1, maxCount do
        (table.insert)(rval, (json.encode)(v[i]))
      end
    else
      do
        for i,j in pairs(v) do
          if isEncodable(i) and isEncodable(j) then
            (table.insert)(rval, "\"" .. (json_private.encodeString)(i) .. "\":" .. (json.encode)(j))
          end
        end
        do
          do
            if bArray then
              return "[" .. (table.concat)(rval, ",") .. "]"
            else
              return "{" .. (table.concat)(rval, ",") .. "}"
            end
            if vtype == "function" and v == json.null then
              return "null"
            end
            assert(false, "encode attempt to encode unsupported type " .. vtype .. ":" .. tostring(v))
          end
        end
      end
    end
  end
end

json.decode = function(s, startPos, ...)
  -- function num : 0_1 , upvalues : decode_scanWhitespace, _ENV, string, decode_scanObject, decode_scanArray, decode_scanNumber, decode_scanString, json, decode_scanComment, decode_scanConstant
  if not startPos or not startPos then
    startPos = 1
  end
  startPos = decode_scanWhitespace(s, startPos)
  assert(startPos <= (string.len)(s), "Unterminated JSON encoded object found at position in [" .. s .. "]")
  local curChar = (string.sub)(s, startPos, startPos)
  if curChar == "{" then
    return decode_scanObject(s, startPos)
  end
  if curChar == "[" then
    return decode_scanArray(s, startPos)
  end
  if (string.find)("+-0123456789.e", curChar, 1, true) then
    return decode_scanNumber(s, startPos)
  end
  if curChar == "\"" or curChar == "\'" then
    return decode_scanString(s, startPos)
  end
  if (string.sub)(s, startPos, startPos + 1) == "/*" then
    return (json.decode)(s, decode_scanComment(s, startPos))
  end
  do return decode_scanConstant(s, startPos) end
  -- DECOMPILER ERROR: 7 unprocessed JMP targets
end

json.null = function(...)
  -- function num : 0_2 , upvalues : json
  return json.null
end

decode_scanArray = function(s, startPos, ...)
  -- function num : 0_3 , upvalues : string, _ENV, decode_scanWhitespace, json
  local array = {}
  local stringLen = (string.len)(s)
  assert((string.sub)(s, startPos, startPos) == "[", "decode_scanArray called but array does not start at position " .. startPos .. " in string:\n" .. s)
  startPos = startPos + 1
  local index = 1
  local object = nil
  repeat
    startPos = decode_scanWhitespace(s, startPos)
    assert(startPos <= stringLen, "JSON String ended unexpectedly scanning array.")
    local curChar = (string.sub)(s, startPos, startPos)
    if curChar == "]" then
      return array, startPos + 1
    end
    if curChar == "," then
      startPos = decode_scanWhitespace(s, startPos + 1)
    end
    assert(startPos <= stringLen, "JSON String ended unexpectedly scanning array.")
    object = (json.decode)(s, startPos)
    array[index] = object
    index = index + 1
  until false
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

decode_scanComment = function(s, startPos, ...)
  -- function num : 0_4 , upvalues : _ENV, string
  assert((string.sub)(s, startPos, startPos + 1) == "/*", "decode_scanComment called but comment does not start at position " .. startPos)
  local endPos = (string.find)(s, "*/", startPos + 2)
  assert(endPos ~= nil, "Unterminated comment in string at " .. startPos)
  do return endPos + 2 end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

decode_scanConstant = function(s, startPos, ...)
  -- function num : 0_5 , upvalues : _ENV, string
  local consts = {["true"] = true, ["false"] = false, null = nil}
  local constNames = {"true", "false", "null"}
  for i,k in pairs(constNames) do
    if (string.sub)(s, startPos, startPos + (string.len)(k) - 1) == k then
      return consts[k], startPos + (string.len)(k)
    end
  end
  assert(nil, "Failed to scan constant from string " .. s .. " at starting position " .. startPos)
end

decode_scanNumber = function(s, startPos, ...)
  -- function num : 0_6 , upvalues : string, _ENV
  local endPos = startPos + 1
  local stringLen = (string.len)(s)
  local acceptableChars = "+-0123456789.e"
  while (string.find)(acceptableChars, (string.sub)(s, endPos, endPos), 1, true) and endPos <= stringLen do
    endPos = endPos + 1
  end
  local stringValue = "return " .. (string.sub)(s, startPos, endPos - 1)
  local stringEval = load(stringValue)
  assert(stringEval, "Failed to scan number [ " .. stringValue .. "] in JSON string at position " .. startPos .. " : " .. endPos)
  return stringEval(), endPos
end

decode_scanObject = function(s, startPos, ...)
  -- function num : 0_7 , upvalues : string, _ENV, decode_scanWhitespace, json
  local object = {}
  local stringLen = ((string.len)(s))
  -- DECOMPILER ERROR at PC4: Overwrote pending register: R4 in 'AssignReg'

  local key, value = .end, nil
  assert((string.sub)(s, startPos, startPos) == "{", "decode_scanObject called but object does not start at position " .. startPos .. " in string:\n" .. s)
  startPos = startPos + 1
  repeat
    startPos = decode_scanWhitespace(s, startPos)
    assert(startPos <= stringLen, "JSON string ended unexpectedly while scanning object.")
    local curChar = (string.sub)(s, startPos, startPos)
    if curChar == "}" then
      return object, startPos + 1
    end
    if curChar == "," then
      startPos = decode_scanWhitespace(s, startPos + 1)
    end
    assert(startPos <= stringLen, "JSON string ended unexpectedly scanning object.")
    key = (json.decode)(s, startPos)
    assert(startPos <= stringLen, "JSON string ended unexpectedly searching for value of key " .. key)
    -- DECOMPILER ERROR at PC77: Overwrote pending register: R1 in 'AssignReg'

    assert(startPos <= stringLen, "JSON string ended unexpectedly searching for value of key " .. key)
    assert((string.sub)(s, startPos, startPos) == ":", "JSON object key-value assignment mal-formed at " .. startPos)
    -- DECOMPILER ERROR at PC105: Overwrote pending register: R1 in 'AssignReg'

    assert(startPos <= stringLen, "JSON string ended unexpectedly searching for value of key " .. key)
    -- DECOMPILER ERROR at PC119: Overwrote pending register: R1 in 'AssignReg'

    value = (json.decode)(s, startPos)
    object[key] = value
  until false
  -- DECOMPILER ERROR: 10 unprocessed JMP targets
end

local escapeSequences = {["\\t"] = "\t", ["\\f"] = "\f", ["\\r"] = "\r", ["\\n"] = "\n", ["\\b"] = "\b"}
setmetatable(escapeSequences, {__index = function(t, k, ...)
  -- function num : 0_8 , upvalues : string
  return (string.sub)(k, 2)
end
})
decode_scanString = function(s, startPos, ...)
  -- function num : 0_9 , upvalues : _ENV, string, table, math, escapeSequences
  assert(startPos, "decode_scanString(..) called without start position")
  local startChar = (string.sub)(s, startPos, startPos)
  assert(startChar == "\"" or startChar == "\'", "decode_scanString called for a non-string")
  local t = {}
  local i, j = startPos, startPos
  while 1 do
    while 1 do
      if (string.find)(s, startChar, j + 1) ~= j + 1 then
        local oldj = j
        i = (string.find)(s, "\\.", j + 1)
        local x, y = (string.find)(s, startChar, oldj + 1)
        -- DECOMPILER ERROR at PC47: Overwrote pending register: R5 in 'AssignReg'

        if not i or x < i then
          i = x
        end
        ;
        (table.insert)(t, (string.sub)(s, oldj + 1, i - 1))
        if (string.sub)(s, i, j) == "\\u" then
          local a = (string.sub)(s, j + 1, j + 4)
          -- DECOMPILER ERROR at PC69: Overwrote pending register: R5 in 'AssignReg'

          local n = tonumber(a, 16)
          assert(n, "String decoding failed: bad Unicode escape " .. a .. " at position " .. i .. " : " .. j)
          do
            local x = nil
            if n < 128 then
              x = (string.char)(n % 128)
            elseif n < 2048 then
              x = (string.char)(192 + (math.floor)(n / 64) % 32, 128 + n % 64)
            else
              x = (string.char)(224 + (math.floor)(n / 4096) % 16, 128 + (math.floor)(n / 64) % 64, 128 + n % 64)
            end
            ;
            (table.insert)(t, x)
            -- DECOMPILER ERROR at PC124: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC124: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC124: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC124: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
    ;
    (table.insert)(t, escapeSequences[(string.sub)(s, i, j)])
  end
  ;
  (table.insert)(t, (string.sub)(j, j + 1))
  assert((string.find)(s, startChar, j + 1), "String decoding failed: missing closing " .. startChar .. " at position " .. j .. "(for string at position " .. startPos .. ")")
  do return (table.concat)(t, ""), j + 2 end
  -- DECOMPILER ERROR: 9 unprocessed JMP targets
end

decode_scanWhitespace = function(s, startPos, ...)
  -- function num : 0_10 , upvalues : string
  local whitespace = " \n\r\t"
  local stringLen = (string.len)(s)
  while (string.find)(whitespace, (string.sub)(s, startPos, startPos), 1, true) and startPos <= stringLen do
    startPos = startPos + 1
  end
  return startPos
end

local escapeList = {["\""] = "\\\"", ["\\"] = "\\\\", ["/"] = "\\/", ["\b"] = "\\b", ["\f"] = "\\f", ["\n"] = "\\n", ["\r"] = "\\r", ["\t"] = "\\t"}
json_private.encodeString = function(s, ...)
  -- function num : 0_11 , upvalues : _ENV, escapeList
  local s = tostring(s)
  return s:gsub(".", function(c, ...)
    -- function num : 0_11_0 , upvalues : escapeList
    return escapeList[c]
  end
)
end

isArray = function(t, ...)
  -- function num : 0_12 , upvalues : json, _ENV, math, isEncodable
  if t == json.EMPTY_ARRAY then
    return true, 0
  end
  if t == json.EMPTY_OBJECT then
    return false
  end
  local maxIndex = 0
  for k,v in pairs(t) do
    if type(k) == "number" and (math.floor)(k) == k and k >= 1 then
      if not isEncodable(v) then
        return false
      end
      maxIndex = (math.max)(maxIndex, k)
    else
      -- DECOMPILER ERROR at PC50: Unhandled construct in 'MakeBoolean' P1

      if k == "n" and (t.n or v ~= #t) then
        return false
      end
    end
    if isEncodable(v) then
      return false
    end
  end
  return true, maxIndex
end

isEncodable = function(o, ...)
  -- function num : 0_13 , upvalues : _ENV, json
  local t = type(o)
  do return t == "string" or t == "boolean" or t == "number" or t == "nil" or t == "table" or (t == "function" and o == json.null) end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

return json

