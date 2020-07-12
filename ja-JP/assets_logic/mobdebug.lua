-- params : ...
-- function num : 0 , upvalues : _ENV
local require = require
if not io then
  local io = require("io")
end
if not table then
  local table = require("table")
end
if not string then
  local string = require("string")
end
if not coroutine then
  local coroutine = require("coroutine")
end
local debug = require("debug")
if not os then
  local os = (function(module, ...)
  -- function num : 0_0 , upvalues : _ENV, require
  local ok, res = pcall(require, module)
  return ok and res or nil
end
)("os")
end
local mobdebug = {_NAME = "mobdebug", _VERSION = "0.703", _COPYRIGHT = "Paul Kulchenko", _DESCRIPTION = "Mobile Remote Debugger for the Lua programming language", port = os and os.getenv and tonumber((os.getenv)("MOBDEBUG_PORT")) or 8172, checkcount = 200, yieldtimeout = 0.02, connecttimeout = 2}
local HOOKMASK = "lcr"
local error = error
local getfenv = getfenv
local setfenv = setfenv
local loadstring = loadstring or load
local pairs = pairs
local setmetatable = setmetatable
local tonumber = tonumber
local unpack = table.unpack or unpack
local rawget = rawget
local gsub, sub, find = string.gsub, string.sub, string.find
local genv = _G or _ENV
local jit = rawget(genv, "jit")
local MOAICoroutine = rawget(genv, "MOAICoroutine")
if getmetatable(genv) then
  local metagindex = (getmetatable(genv)).__index
end
local ngx = type(metagindex) == "table" and metagindex.rawget and metagindex:rawget("ngx") or nil
if not ngx or not coroutine._create then
  local corocreate = coroutine.create
end
if not ngx or not coroutine._resume then
  local cororesume = coroutine.resume
end
if not ngx or not coroutine._yield then
  local coroyield = coroutine.yield
end
if not ngx or not coroutine._status then
  local corostatus = coroutine.status
end
local corowrap = coroutine.wrap
do
  if not setfenv then
    local findenv = function(f, ...)
  -- function num : 0_1 , upvalues : debug
  local level = 1
  repeat
    local name, value = (debug.getupvalue)(f, level)
    if name == "_ENV" then
      return level, value
    end
    level = level + 1
  until name == nil
  return nil
end

    do
      getfenv = function(f, ...)
  -- function num : 0_2 , upvalues : _ENV, findenv
  return select(2, findenv(f)) or _G
end

      setfenv = function(f, t, ...)
  -- function num : 0_3 , upvalues : findenv, debug
  local level = findenv(f)
  if level then
    (debug.setupvalue)(f, level, t)
  end
  return f
end

    end
  end
  local win = not (os.getenv)("WINDIR") and (((os.getenv)("OS") or (not os or not os.getenv or ""):match("[Ww]indows")) and true) or false
  local mac = not win and (((os and os.getenv and (os.getenv)("DYLD_LIBRARY_PATH")) or not (io.open)("/proc")) and true) or false
  local iscasepreserving = win or not mac or (io.open)("/library") ~= nil
  if jit and jit.off then
    (jit.off)()
  end
  local socket = (require("socket"))
  local coro_debugger, coro_debugee = nil, nil
  local coroutines = {}
  setmetatable(coroutines, {__mode = "k"})
  local events = {BREAK = 1, WATCH = 2, RESTART = 3, STACK = 4}
  local breakpoints = {}
  local watches = {}
  local lastsource, lastfile = nil, nil
  local watchescnt = 0
  local abort = nil
  local seen_hook = false
  local checkcount = 0
  local step_into = false
  local step_over = false
  local step_level = 0
  local stack_level = 0
  local server, buf = nil, nil
  local outputs = {}
  local iobase = {print = print}
  local basedir = ""
  local deferror = "execution aborted at default debugee"
  local debugee = function(...)
  -- function num : 0_4 , upvalues : error, deferror
  local a = 1
  for _ = 1, 10 do
    a = a + 1
  end
  error(deferror)
end

  local q = function(s, ...)
  -- function num : 0_5 , upvalues : string
  return (string.gsub)(s, "([%(%)%.%%%+%-%*%?%[%^%$%]])", "%%%1")
end

  local serpent = (function(...)
  -- function num : 0_6 , upvalues : _ENV, debug, tonumber, error, table, string, setmetatable, loadstring, setfenv
  local n, v = "serpent", "0.301"
  local c, d = "Paul Kulchenko", "Lua serializer and pretty printer"
  local snum = {[tostring(1 / 0)] = "1/0 --[[math.huge]]", [tostring(-1 / 0)] = "-1/0 --[[-math.huge]]", [tostring(0 / 0)] = "0/0"}
  local badtype = {thread = true, userdata = true, cdata = true}
  local getmetatable = debug and debug.getmetatable or getmetatable
  local pairs = function(t, ...)
    -- function num : 0_6_0 , upvalues : _ENV
    return next, t
  end

  local keyword, globals, G = {}, {}, _G or _ENV
  for _,k in ipairs({"and", "break", "do", "else", "elseif", "end", "false", "for", "function", "goto", "if", "in", "local", "nil", "not", "or", "repeat", "return", "then", "true", "until", "while"}) do
    keyword[k] = true
  end
  for k,v in pairs(G) do
    globals[v] = k
  end
  for _,g in ipairs({"coroutine", "debug", "io", "math", "string", "table", "os"}) do
    if type(G[g]) ~= "table" or not G[g] then
      for k,v in pairs({}) do
        globals[v] = g .. "." .. k
      end
      do
        -- DECOMPILER ERROR at PC103: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC103: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  local s = function(t, opts, ...)
    -- function num : 0_6_1 , upvalues : _ENV, tonumber, snum, globals, error, keyword, table, getmetatable, pairs, badtype, string
    local name, indent, fatal, maxnum = opts.name, opts.indent, opts.fatal, opts.maxnum
    local sparse, custom, huge = opts.sparse, opts.custom, not opts.nohuge
    if not opts.maxlevel then
      local space, maxl = opts.compact and "" or " ", math.huge
    end
    local maxlen, metatostring = tonumber(opts.maxlength), opts.metatostring
    if opts.comment and not tonumber(opts.comment) then
      local iname, comm = "_" .. (name or ""), math.huge
    end
    local numformat = opts.numformat or "%.17g"
    local seen, sref, syms, symn = {}, {"local " .. iname .. "={}"}, {}, 0
    local gensym = function(val, ...)
      -- function num : 0_6_1_0 , upvalues : _ENV, syms, symn
      return "_" .. ((tostring(tostring(val))):gsub("[^%w]", "")):gsub("(%d%w+)", function(s, ...)
        -- function num : 0_6_1_0_0 , upvalues : syms, symn, _ENV
        if not syms[s] then
          symn = symn + 1
          syms[s] = symn
        end
        return tostring(syms[s])
      end
)
    end

    local safestr = function(s, ...)
      -- function num : 0_6_1_1 , upvalues : _ENV, huge, snum, numformat
      if (type(s) ~= "number" or ((huge and snum[tostring(s)]) or not tostring(numformat:format(s))) and (type(s) == "string" or not tostring(s))) then
        return ((("%q"):format(s)):gsub("\n", "n")):gsub("\026", "\\026")
      end
    end

    local comment = function(s, l, ...)
      -- function num : 0_6_1_2 , upvalues : comm, _ENV
      return (l or not comm or 0 < comm) and " --[[" .. select(2, pcall(tostring, s)) .. "]]" or ""
    end

    local globerr = function(s, l, ...)
      -- function num : 0_6_1_3 , upvalues : globals, comment, fatal, safestr, _ENV, error
      if (not globals[s] or not globals[s] .. comment(s, l)) and (fatal or not safestr(select(2, pcall(tostring, s)))) then
        return error("Can\'t serialize " .. tostring(s))
      end
    end

    local safename = function(path, name, ...)
      -- function num : 0_6_1_4 , upvalues : _ENV, keyword, safestr
      local n = name == nil and "" or name
      local plain = (type(n) ~= "string" or n:match("^[%l%u_][%w_]*$")) and not keyword[n]
      if not plain or not n then
        local safe = "[" .. safestr(n) .. "]"
      end
      do return (path or "") .. (plain and path and "." or "") .. safe, safe end
      -- DECOMPILER ERROR: 7 unprocessed JMP targets
    end

    if type(opts.sortkeys) ~= "function" or not opts.sortkeys then
      local alphanumsort = function(k, o, n, ...)
      -- function num : 0_6_1_5 , upvalues : tonumber, _ENV, table
      local maxn, to = tonumber(n) or 12, {number = "a", string = "b"}
      local padnum = function(d, ...)
        -- function num : 0_6_1_5_0 , upvalues : _ENV, maxn, tonumber
        return ("%0" .. tostring(maxn) .. "d"):format(tonumber(d))
      end

      ;
      (table.sort)(k, function(a, b, ...)
        -- function num : 0_6_1_5_1 , upvalues : k, to, _ENV, padnum
        do return ((k[a] ~= nil and 0) or to[type(a)] or "z") .. (tostring(a)):gsub("%d+", padnum) < ((k[b] ~= nil and 0) or to[type(b)] or "z") .. (tostring(b)):gsub("%d+", padnum) end
        -- DECOMPILER ERROR: 1 unprocessed JMP targets
      end
)
    end

    end
    local val2str = function(t, name, indent, insref, path, plainindex, level, ...)
      -- function num : 0_6_1_6 , upvalues : _ENV, getmetatable, safename, space, seen, sref, comment, metatostring, maxl, maxlen, maxnum, pairs, opts, alphanumsort, sparse, badtype, globals, iname, gensym, val2str, string, table, custom, globerr, safestr
      local ttype, level, mt = type(t), level or 0, getmetatable(t)
      local spath, sname = safename(path, name)
      local tag = ((not plainindex or (type(name) == "number" and "") or not name .. space .. "=" .. space) and (name ~= nil and sname .. space .. "=" .. space)) or ""
      if seen[t] then
        sref[#sref + 1] = spath .. space .. "=" .. space .. seen[t]
        return tag .. "nil" .. comment("ref", level)
      end
      if type(mt) == "table" and metatostring ~= false then
        local to, tr = pcall(function(...)
        -- function num : 0_6_1_6_0 , upvalues : mt, t
        return (mt.__tostring)(t)
      end
)
        local so, sr = pcall(function(...)
        -- function num : 0_6_1_6_1 , upvalues : mt, t
        return (mt.__serialize)(t)
      end
)
        if not insref then
          do
            seen[t] = not to and not so or spath
            t = so and sr or tr
            ttype = type(t)
            if ttype == "table" then
              if maxl <= level then
                return tag .. "{}" .. comment("maxlvl", level)
              end
              seen[t] = insref or spath
              if next(t) == nil then
                return tag .. "{}" .. comment(t, level)
              end
              if maxlen and maxlen < 0 then
                return tag .. "{}" .. comment("maxlen", level)
              end
              if not maxnum then
                local maxn, o, out = (math.min)(#(t), #(t)), {}, {}
                for key = 1, maxn do
                  o[key] = key
                end
                do
                  if not maxnum or #o < maxnum then
                    local n = #o
                    for key in pairs(t) do
                      if o[key] ~= key then
                        n = n + 1
                        o[n] = key
                      end
                    end
                  end
                  do
                    if maxnum and maxnum < #o then
                      o[maxnum + 1] = nil
                    end
                    if opts.sortkeys and maxn < #o then
                      alphanumsort(o, t, opts.sortkeys)
                    end
                    local sparse = not sparse or maxn < #o
                    for n,key in ipairs(o) do
                      local value, ktype, plainindex = t[key], type(key), (n <= maxn and not sparse)
                      if (((opts.valignore and (opts.valignore)[value]) or (opts.keyallow and not (opts.keyallow)[key]) or (opts.keyignore and (opts.keyignore)[key]) or (not opts.valtypeignore or not (opts.valtypeignore)[type(value)]))) then
                        -- DECOMPILER ERROR at PC266: Unhandled construct in 'MakeBoolean' P3

                        if (sparse and value == nil and ktype == "table") or badtype[ktype] then
                          if not seen[key] and not globals[key] then
                            sref[#sref + 1] = "placeholder"
                            local sname = safename(iname, gensym(key))
                            sref[#sref] = val2str(key, sname, indent, sname, iname, true)
                          end
                          sref[#sref + 1] = "placeholder"
                          if not seen[key] and not globals[key] then
                            local path = seen[t] .. "[" .. tostring(gensym(key)) .. "]"
                            if not seen[value] then
                              do
                                do
                                  sref[#sref] = path .. space .. "=" .. space .. tostring(val2str(value, nil, indent, path))
                                  out[#out + 1] = val2str(value, key, indent, insref, seen[t], plainindex, level + 1)
                                  if maxlen then
                                    maxlen = maxlen - #out[#out]
                                  end
                                  -- DECOMPILER ERROR at PC347: LeaveBlock: unexpected jumping out DO_STMT

                                  -- DECOMPILER ERROR at PC347: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                  -- DECOMPILER ERROR at PC347: LeaveBlock: unexpected jumping out IF_STMT

                                  -- DECOMPILER ERROR at PC347: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                  -- DECOMPILER ERROR at PC347: LeaveBlock: unexpected jumping out IF_STMT

                                  -- DECOMPILER ERROR at PC347: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                  -- DECOMPILER ERROR at PC347: LeaveBlock: unexpected jumping out IF_STMT

                                  -- DECOMPILER ERROR at PC347: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                  -- DECOMPILER ERROR at PC347: LeaveBlock: unexpected jumping out IF_STMT

                                end
                              end
                            end
                          end
                        end
                      end
                    end
                    local prefix = (string.rep)(maxlen >= 0 and indent or "", level)
                    local head = indent and "{\n" .. prefix .. indent or "{"
                    local body = (table.concat)(out, "," .. (indent and "\n" .. prefix .. indent or space))
                    local tail = indent and "\n" .. prefix .. "}" or "}"
                    if not custom or not custom(tag, head, body, tail, level) then
                      do
                        do return tag .. head .. body .. tail .. comment(t, level) end
                        if not insref then
                          seen[t] = not badtype[ttype] or spath
                          do return tag .. globerr(t, level) end
                          if not insref then
                            seen[t] = ttype ~= "function" or spath
                            if opts.nocode then
                              return tag .. "function() --[[..skipped..]] end" .. comment(t, level)
                            end
                            local ok, res = pcall(string.dump, t)
                            if ok then
                              local func = "((loadstring or load)(" .. safestr(res) .. ",\'@serialized\'))" .. comment(t, level)
                            end
                            if not func then
                              do
                                do return tag .. globerr(t, level) end
                                do return tag .. safestr(t) end
                                -- DECOMPILER ERROR: 34 unprocessed JMP targets
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end

    if not indent or not "\n" then
      local sepr = ";" .. space
    end
    local body = val2str(t, name, indent)
    local tail = #sref > 1 and (table.concat)(sref, sepr) .. sepr or ""
    local warn = opts.comment and #sref > 1 and space .. "--[[incomplete output with shared/self-references skipped]]" or ""
    if name or not body .. warn then
      return "do local " .. body .. sepr .. tail .. "return " .. name .. sepr .. "end"
    end
  end

  local deserialize = function(data, opts, ...)
    -- function num : 0_6_2 , upvalues : G, setmetatable, error, loadstring, _ENV, setfenv
    if not opts or opts.safe ~= false or not G then
      local env = setmetatable({}, {__index = function(t, k, ...)
      -- function num : 0_6_2_0
      return t
    end
, __call = function(t, ...)
      -- function num : 0_6_2_1 , upvalues : error
      error("cannot call functions")
    end
})
    end
    local f, res = (loadstring or load)("return " .. data, nil, nil, env)
    if not loadstring then
      f = (f or load)(data, nil, nil, env)
      if not f then
        return f, res
      end
      if setfenv then
        setfenv(f, env)
      end
      return pcall(f)
    end
  end

  local merge = function(a, b, ...)
    -- function num : 0_6_3 , upvalues : pairs
    if b then
      for k,v in pairs(b) do
        a[k] = v
      end
    end
    do
      return a
    end
  end

  return {_NAME = n, _COPYRIGHT = c, _DESCRIPTION = d, _VERSION = v, serialize = s, load = deserialize, dump = function(a, opts, ...)
    -- function num : 0_6_4 , upvalues : s, merge
    return s(a, merge({name = "_", compact = true, sparse = true}, opts))
  end
, line = function(a, opts, ...)
    -- function num : 0_6_5 , upvalues : s, merge
    return s(a, merge({sortkeys = true, comment = true}, opts))
  end
, block = function(a, opts, ...)
    -- function num : 0_6_6 , upvalues : s, merge
    return s(a, merge({indent = "  ", sortkeys = true, comment = true}, opts))
  end
}
end
)()
  mobdebug.line = serpent.line
  mobdebug.dump = serpent.dump
  mobdebug.linemap = nil
  mobdebug.loadstring = loadstring
  local removebasedir = function(path, basedir, ...)
  -- function num : 0_7 , upvalues : iscasepreserving, q, string
  if not (path:lower()):find("^" .. q(basedir:lower())) or not path:sub(#basedir + 1) then
    do return not iscasepreserving or path end
    do return (string.gsub)(path, "^" .. q(basedir), "") end
  end
end

  local stack = function(start, ...)
  -- function num : 0_8 , upvalues : debug, string, _ENV, mobdebug, table, removebasedir, basedir
  local vars = function(f, ...)
    -- function num : 0_8_0 , upvalues : debug, string, _ENV
    local func = ((debug.getinfo)(f, "f")).func
    local i = 1
    local locals = {}
    while 1 do
      local name, value = (debug.getlocal)(f, i)
      if name then
        do
          if (string.sub)(name, 1, 1) ~= "(" then
            locals[name] = {value, select(2, pcall(tostring, value))}
          end
          i = i + 1
          -- DECOMPILER ERROR at PC32: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC32: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
    i = 1
    while 1 do
      local name, value = (debug.getlocal)(f, -i)
      if name and name == "(*vararg)" then
        do
          locals[name:gsub("%)$", " " .. i .. ")")] = {value, select(2, pcall(tostring, value))}
          i = i + 1
          -- DECOMPILER ERROR at PC61: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC61: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
    i = 1
    local ups = {}
    while 1 do
      if func then
        local name, value = (debug.getupvalue)(func, i)
        if name then
          do
            ups[name] = {value, select(2, pcall(tostring, value))}
            i = i + 1
            -- DECOMPILER ERROR at PC84: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC84: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC84: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC84: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
    return locals, ups
  end

  local stack = {}
  local linemap = mobdebug.linemap
  for i = start or 0, 100 do
    local source = (debug.getinfo)(i, "Snl")
    if source then
      local src = source.source
      if src:find("@") == 1 then
        src = (src:sub(2)):gsub("\\", "/")
        if src:find("%./") == 1 then
          src = src:sub(3)
        end
      end
      if ((not linemap or not linemap(source.linedefined, source.source)) and not linemap) or not linemap(source.currentline, source.source) then
        do
          (table.insert)(stack, {
{source.name, removebasedir(src, basedir), source.linedefined, source.currentline, source.what, source.namewhat, source.short_src}
, vars(i + 1)})
          -- DECOMPILER ERROR at PC77: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC77: LeaveBlock: unexpected jumping out IF_STMT

          -- DECOMPILER ERROR at PC77: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC77: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  if source.what ~= "main" then
    return stack
  end
end

  local set_breakpoint = function(file, line, ...)
  -- function num : 0_9 , upvalues : lastfile, iscasepreserving, string, breakpoints
  if file == "-" and lastfile then
    file = lastfile
  else
    if iscasepreserving then
      file = (string.lower)(file)
    end
  end
  if not breakpoints[line] then
    breakpoints[line] = {}
  end
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R2 in 'UnsetPending'

  ;
  (breakpoints[line])[file] = true
end

  local remove_breakpoint = function(file, line, ...)
  -- function num : 0_10 , upvalues : lastfile, breakpoints, iscasepreserving, string
  if file == "-" and lastfile then
    file = lastfile
  else
    if file == "*" and line == 0 then
      breakpoints = {}
    else
      if iscasepreserving then
        file = (string.lower)(file)
      end
    end
  end
  -- DECOMPILER ERROR at PC25: Confused about usage of register: R2 in 'UnsetPending'

  if breakpoints[line] then
    (breakpoints[line])[file] = nil
  end
end

  local has_breakpoint = function(file, line, ...)
  -- function num : 0_11 , upvalues : breakpoints, iscasepreserving, string
  return (breakpoints[line])[not breakpoints[line] or (iscasepreserving and (string.lower)(file)) or file]
end

  local restore_vars = function(vars, ...)
  -- function num : 0_12 , upvalues : _ENV, debug, string, rawget
  if type(vars) ~= "table" then
    return 
  end
  local i = 1
  while 1 do
    local name = (debug.getlocal)(3, i)
    if name then
      do
        i = i + 1
        -- DECOMPILER ERROR at PC14: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC14: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  i = i - 1
  local written_vars = {}
  do
    while i > 0 do
      local name = (debug.getlocal)(3, i)
      -- DECOMPILER ERROR at PC40: Unhandled construct in 'MakeBoolean' P1

      if not written_vars[name] and (string.sub)(name, 1, 1) ~= "(" then
        (debug.setlocal)(3, i, rawget(vars, name))
      end
      written_vars[name] = true
      i = i - 1
    end
    i = 1
    local func = ((debug.getinfo)(3, "f")).func
    while 1 do
      local name = (debug.getupvalue)(func, i)
      if name then
        do
          -- DECOMPILER ERROR at PC73: Unhandled construct in 'MakeBoolean' P1

          if not written_vars[name] and (string.sub)(name, 1, 1) ~= "(" then
            (debug.setupvalue)(func, i, rawget(vars, name))
          end
          written_vars[name] = true
          i = i + 1
          -- DECOMPILER ERROR at PC76: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC76: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
end

  local capture_vars = function(level, thread, ...)
  -- function num : 0_13 , upvalues : debug, string, setmetatable, getfenv
  level = (level or 0) + 2
  if (not thread or not (debug.getinfo)(thread, level, "f")) and not (debug.getinfo)(level, "f") then
    local func = ({}).func
    if not func then
      return {}
    end
    local vars = {
["..."] = {}
}
    local i = 1
    while 1 do
      local name, value = (debug.getupvalue)(func, i)
      if name then
        do
          if (string.sub)(name, 1, 1) ~= "(" then
            vars[name] = value
          end
          i = i + 1
          -- DECOMPILER ERROR at PC44: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC44: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
    i = 1
    while 1 do
      local name, value = nil, nil
      if thread then
        name = (debug.getlocal)(thread, level, i)
      else
        -- DECOMPILER ERROR at PC61: Overwrote pending register: R6 in 'AssignReg'

        name = (debug.getlocal)(level, i)
      end
      if name then
        do
          if (string.sub)(name, 1, 1) ~= "(" then
            vars[name] = value
          end
          i = i + 1
          -- DECOMPILER ERROR at PC74: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC74: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
    i = 1
    while 1 do
      -- DECOMPILER ERROR at PC76: Overwrote pending register: R6 in 'AssignReg'

      local name, value = nil, value
      if thread then
        name = (debug.getlocal)(thread, level, -i)
      else
        -- DECOMPILER ERROR at PC91: Overwrote pending register: R6 in 'AssignReg'

        name = (debug.getlocal)(level, -i)
      end
      -- DECOMPILER ERROR at PC98: Confused about usage of register: R7 in 'UnsetPending'

      if name and name == "(*vararg)" then
        do
          (vars["..."])[i] = value
          i = i + 1
          -- DECOMPILER ERROR at PC100: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC100: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
    -- DECOMPILER ERROR at PC102: Overwrote pending register: R6 in 'AssignReg'

    setmetatable(value, {__index = getfenv(func), __newindex = getfenv(func)})
    return vars
  end
end

  local stack_depth = function(start_depth, ...)
  -- function num : 0_14 , upvalues : debug
  for i = start_depth, 0, -1 do
    if (debug.getinfo)(i, "l") then
      return i + 1
    end
  end
  return start_depth
end

  local is_safe = function(stack_level, ...)
  -- function num : 0_15 , upvalues : debug
  if stack_level == 3 then
    return true
  end
  for i = 3, stack_level do
    local info = (debug.getinfo)(i, "S")
    if not info then
      return true
    end
    if info.what == "C" then
      return false
    end
  end
  return true
end

  local in_debugger = function(...)
  -- function num : 0_16 , upvalues : debug
  local this = ((debug.getinfo)(1, "S")).source
  for i = 3, 7 do
    local info = (debug.getinfo)(i, "S")
    if not info then
      return false
    end
    if info.source == this then
      return true
    end
  end
  return false
end

  local is_pending = function(peer, ...)
  -- function num : 0_17 , upvalues : buf, checkcount, mobdebug
  if not buf and mobdebug.checkcount <= checkcount then
    peer:settimeout(0)
    buf = peer:receive(1)
    peer:settimeout()
    checkcount = 0
  end
  return buf
end

  local readnext = function(peer, num, ...)
  -- function num : 0_18
  peer:settimeout(0)
  local res, err, partial = peer:receive(num)
  peer:settimeout()
  return res or partial or "", err
end

  local handle_breakpoint = function(peer, ...)
  -- function num : 0_19 , upvalues : buf, readnext, set_breakpoint, tonumber, remove_breakpoint
  if not buf or buf:sub(1, 1) ~= "S" and buf:sub(1, 1) ~= "D" then
    return 
  end
  if #buf == 1 then
    buf = buf .. readnext(peer, 1)
  end
  if buf:sub(2, 2) ~= "E" then
    return 
  end
  buf = buf .. readnext(peer, 5 - #buf)
  if buf ~= "SETB " and buf ~= "DELB " then
    return 
  end
  local res, _, partial = peer:receive()
  if not res and partial then
    buf = buf .. partial
  end
  do return  end
  local _, _, cmd, file, line = (buf .. res):find("^([A-Z]+)%s+(.-)%s+(%d+)%s*$")
  if cmd == "SETB" then
    set_breakpoint(file, tonumber(line))
  else
    if cmd == "DELB" then
      remove_breakpoint(file, tonumber(line))
    else
      return 
    end
  end
  buf = nil
end

  local normalize_path = function(file, ...)
  -- function num : 0_20
  local n = nil
  repeat
    file = file:gsub("/+%.?/+", "/")
  until n == 0
  repeat
    -- DECOMPILER ERROR at PC14: Overwrote pending register: R1 in 'AssignReg'

    file = file:gsub("[^/]+/%.%./", "", 1)
  until n == 0
  return file:gsub("^(/?)%.%./", "%1")
end

  local debug_hook = function(event, line, ...)
  -- function num : 0_21 , upvalues : jit, coroutine, coroutines, coro_debugee, in_debugger, abort, is_safe, stack_level, error, seen_hook, mobdebug, _ENV, debug, step_into, step_over, breakpoints, watchescnt, is_pending, server, checkcount, stack_depth, lastfile, lastsource, find, gsub, basedir, normalize_path, iscasepreserving, string, sub, q, handle_breakpoint, capture_vars, pairs, watches, setfenv, cororesume, coro_debugger, events, step_level, has_breakpoint, restore_vars, stack
  if jit then
    local coro, main = (coroutine.running)()
    if not coro or main then
      coro = "main"
    end
    local disabled = coroutines[coro] == nil and (not coro_debugee and coro ~= coroutines[coro] == false or "main")
    if (coro_debugee and disabled) or not coro_debugee and (disabled or in_debugger()) then
      return 
    end
  end
  if abort and is_safe(stack_level) then
    error(abort)
  end
  if not seen_hook and in_debugger() then
    return 
  end
  if event == "call" then
    stack_level = stack_level + 1
  elseif event == "return" or event == "tail return" then
    stack_level = stack_level - 1
  elseif event == "line" then
    do
      if mobdebug.linemap then
        local ok, mappedline = pcall(mobdebug.linemap, line, ((debug.getinfo)(2, "S")).source)
        if ok then
          line = mappedline
        end
        if not line then
          return 
        end
      end
      if not step_into and not step_over and not breakpoints[line] and watchescnt <= 0 and not is_pending(server) then
        checkcount = checkcount + 1
        return 
      end
      checkcount = mobdebug.checkcount
      stack_level = stack_depth(stack_level + 1)
      local caller = (debug.getinfo)(2, "S")
      local file = lastfile
      if lastsource ~= caller.source then
        file = caller.source
        if find(file, "^@") or not find(file, "[\r\n]") then
          file = gsub(gsub(file, "^@", ""), "\\", "/")
          if find(file, "^%.%./") then
            file = basedir .. file
          end
          if find(file, "/%.%.?/") then
            file = normalize_path(file)
          end
          if iscasepreserving then
            file = (string.lower)(file)
          end
          if find(file, "^%./") then
            file = sub(file, 3)
          else
            file = gsub(file, "^" .. q(basedir), "")
          end
          file = gsub(file, "\n", " ")
        else
          file = (mobdebug.line)(file)
        end
        seen_hook = true
        lastfile = file
      end
      if is_pending(server) then
        handle_breakpoint(server)
      end
      local vars, status, res = nil, nil, nil
      if watchescnt > 0 then
        vars = capture_vars(1)
        for index,value in pairs(watches) do
          setfenv(value, vars)
          local ok, fired = pcall(value)
          if ok and fired then
            status = cororesume(coro_debugger, events.WATCH, vars, file, line, index)
            break
          end
        end
      end
      local getin = step_over and (((((coroutine.running)() or step_over == status ~= nil or step_into or "main") and stack_level <= step_level) or not has_breakpoint(file, line)) and is_pending(server))
      if getin then
        if not vars then
          vars = capture_vars(1)
        end
        step_into = false
        step_over = false
        -- DECOMPILER ERROR at PC312: Overwrote pending register: R6 in 'AssignReg'

        status = cororesume(coro_debugger, events.BREAK, vars, file, line)
      end
      while status and res == "stack" do
        if vars then
          restore_vars(vars)
        end
        -- DECOMPILER ERROR at PC332: Overwrote pending register: R6 in 'AssignReg'

        status = cororesume(coro_debugger, events.STACK, stack(3), file, line)
      end
      if status and res and res ~= "stack" then
        if not abort and res == "exit" then
          (mobdebug.onexit)(1, true)
          return 
        end
        if not abort and res == "done" then
          (mobdebug.done)()
          return 
        end
        abort = res
        if is_safe(stack_level) then
          error(abort)
        end
      elseif not status and res then
        error(res, 2)
      end
      if vars then
        restore_vars(vars)
      end
      if not (coroutine.running)() then
        do
          step_over = step_over ~= true or "main"
          -- DECOMPILER ERROR: 40 unprocessed JMP targets
        end
      end
    end
  end
end

  local stringify_results = function(params, status, ...)
  -- function num : 0_22 , upvalues : pairs, _ENV, mobdebug
  if not status then
    return status, ...
  end
  if not params then
    params = {}
  end
  if params.nocode == nil then
    params.nocode = true
  end
  if params.comment == nil then
    params.comment = 1
  end
  local t = {...}
  for i,v in pairs(t) do
    local ok, res = pcall(mobdebug.line, v, params)
    if not ok or not res then
      do
        t[i] = ((("%q"):format(res)):gsub("\n", "n")):gsub("\026", "\\026")
        -- DECOMPILER ERROR at PC46: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC46: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  return pcall(mobdebug.dump, t, {sparse = false})
end

  local isrunning = function(...)
  -- function num : 0_23 , upvalues : coro_debugger, corostatus
  do return not coro_debugger or corostatus(coro_debugger) == "suspended" or corostatus(coro_debugger) == "running" end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

  local done = function(...)
  -- function num : 0_24 , upvalues : isrunning, server, jit, pairs, coroutines, debug, coro_debugger, seen_hook, abort
  if not isrunning() or not server then
    return 
  end
  if not jit then
    for co,debugged in pairs(coroutines) do
      if debugged then
        (debug.sethook)(co)
      end
    end
  end
  do
    ;
    (debug.sethook)()
    server:close()
    coro_debugger = nil
    seen_hook = nil
    abort = nil
  end
end

  local debugger_loop = function(sev, svars, sfile, sline, ...)
  -- function num : 0_25 , upvalues : pairs, _ENV, rawget, genv, mobdebug, server, error, buf, string, set_breakpoint, tonumber, remove_breakpoint, loadstring, coro_debugee, capture_vars, setfenv, stringify_results, unpack, abort, coroyield, debugee, watchescnt, watches, events, step_into, step_over, step_level, stack_level, basedir, iscasepreserving, lastsource, seen_hook, iobase, corowrap, coroutine, table
  local command, app, osname = nil, nil, nil
  if not svars then
    local eval_env = {}
  end
  local emptyWatch = function(...)
    -- function num : 0_25_0
    return false
  end

  local loaded = {}
  do
    for k in pairs(package.loaded) do
      do
        loaded[k] = true
      end
    end
  end
  do
    while 1 do
      while 1 do
        local line, err = nil, nil
        local wx = rawget(genv, "wx")
        if (wx or mobdebug.yield) and server.settimeout then
          server:settimeout(mobdebug.yieldtimeout)
        end
        while 1 do
          while 1 do
            while 1 do
              while 1 do
                while 1 do
                  line = server:receive()
                  if not line and err == "timeout" then
                    if not app and wx and wx.wxGetApp then
                      app = (wx.wxGetApp)()
                    end
                    if app then
                      local win = app:GetTopWindow()
                      local inloop = app:IsMainLoopRunning()
                      if not osname then
                        osname = (((wx.wxPlatformInfo).Get)()):GetOperatingSystemFamilyName()
                      end
                      if win then
                        if not inloop then
                          if osname == "Unix" then
                            ((wx.wxTimer)(app)):Start(10, true)
                          end
                          local exitLoop = function(...)
    -- function num : 0_25_1 , upvalues : win, wx, app
    win:Disconnect(wx.wxID_ANY, wx.wxID_ANY, wx.wxEVT_IDLE)
    win:Disconnect(wx.wxID_ANY, wx.wxID_ANY, wx.wxEVT_TIMER)
    app:ExitMainLoop()
  end

                          win:Connect(wx.wxEVT_IDLE, exitLoop)
                          win:Connect(wx.wxEVT_TIMER, exitLoop)
                          app:MainLoop()
                        end
                      end
                      -- DECOMPILER ERROR at PC88: LeaveBlock: unexpected jumping out IF_THEN_STMT

                      -- DECOMPILER ERROR at PC88: LeaveBlock: unexpected jumping out IF_STMT

                      -- DECOMPILER ERROR at PC88: LeaveBlock: unexpected jumping out IF_THEN_STMT

                      -- DECOMPILER ERROR at PC88: LeaveBlock: unexpected jumping out IF_STMT

                    end
                  end
                end
              end
              do
                if mobdebug.yield then
                  (mobdebug.yield)()
                end
                -- DECOMPILER ERROR at PC95: LeaveBlock: unexpected jumping out DO_STMT

              end
            end
            if not line and err == "closed" then
              error("Debugger connection closed", 0)
              -- DECOMPILER ERROR at PC104: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC104: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
          if buf then
            line = buf .. line
            buf = nil
          end
          break
        end
        if server.settimeout then
          server:settimeout()
        end
        command = (string.sub)(line, (string.find)(line, "^[A-Z]+"))
        if command == "SETB" then
          do
            local _, _, _, file, line = (string.find)(line, "^([A-Z]+)%s+(.-)%s+(%d+)%s*$")
            if file and line then
              set_breakpoint(file, tonumber(line))
              server:send("200 OK\n")
              break
            end
            server:send("400 Bad Request\n")
            do break end
            if command == "DELB" then
              do
                local _, _, _, file, line = (string.find)(line, "^([A-Z]+)%s+(.-)%s+(%d+)%s*$")
                if file and line then
                  remove_breakpoint(file, tonumber(line))
                  server:send("200 OK\n")
                  break
                end
                server:send("400 Bad Request\n")
                do break end
                if command == "EXEC" then
                  local params = (string.match)(line, "--%s*(%b{})%s*$")
                  local _, _, chunk = (string.find)(line, "^[A-Z]+%s+(.+)$")
                  if chunk then
                    local func, res = (mobdebug.loadstring)(chunk)
                    local status = nil
                    if func then
                      if params then
                        local pfunc = loadstring("return " .. params)
                      end
                      if pfunc then
                        params = pfunc()
                      end
                      if type(params) ~= "table" or not params then
                        params = {}
                      end
                      local stack = tonumber(params.stack)
                      local env = stack and coro_debugee and capture_vars(stack - 1, coro_debugee) or eval_env
                      setfenv(func, env)
                      if not env["..."] then
                        do
                          status = stringify_results(params, pcall(func, unpack({})))
                          if status then
                            if mobdebug.onscratch then
                              (mobdebug.onscratch)(res)
                            end
                            server:send("200 OK " .. tostring(#res) .. "\n")
                            server:send(res)
                            break
                          end
                          -- DECOMPILER ERROR at PC277: Overwrote pending register: R18 in 'AssignReg'

                          if not res then
                            do
                              do
                                server:send("401 Error in Expression " .. tostring(#res) .. "\n")
                                server:send(res)
                                do break end
                                -- DECOMPILER ERROR at PC293: Overwrote pending register: R18 in 'AssignReg'

                                server:send("400 Bad Request\n")
                                do break end
                                if command == "LOAD" then
                                  local _, _, size, name = (string.find)(line, "^[A-Z]+%s+(%d+)%s+(%S.-)%s*$")
                                  size = tonumber(size)
                                  if abort == nil then
                                    if size > 0 then
                                      server:receive(size)
                                    end
                                    if sfile and sline then
                                      server:send("201 Started " .. sfile .. " " .. tostring(sline) .. "\n")
                                      break
                                    end
                                    server:send("200 OK 0\n")
                                    break
                                  end
                                  for k in pairs(package.loaded) do
                                    -- DECOMPILER ERROR at PC347: Confused about usage of register: R21 in 'UnsetPending'

                                    if not loaded[k] then
                                      (package.loaded)[k] = nil
                                    end
                                  end
                                  if size == 0 and name == "-" then
                                    server:send("200 OK 0\n")
                                    coroyield("load")
                                    break
                                  end
                                  if size ~= 0 or not "" then
                                    local chunk = server:receive(size)
                                  end
                                  if chunk then
                                    do
                                      do
                                        local func, res = (mobdebug.loadstring)(chunk, "@" .. name)
                                        if func then
                                          server:send("200 OK 0\n")
                                          debugee = func
                                          coroyield("load")
                                          break
                                        end
                                        server:send("401 Error in Expression " .. tostring(#res) .. "\n")
                                        server:send(res)
                                        do break end
                                        server:send("400 Bad Request\n")
                                        do break end
                                        if command == "SETW" then
                                          local _, _, exp = (string.find)(line, "^[A-Z]+%s+(.+)%s*$")
                                          if exp then
                                            local func, res = (mobdebug.loadstring)("return(" .. exp .. ")")
                                            if func then
                                              watchescnt = watchescnt + 1
                                              do
                                                do
                                                  do
                                                    local newidx = #watches + 1
                                                    watches[newidx] = func
                                                    server:send("200 OK " .. tostring(newidx) .. "\n")
                                                    do break end
                                                    server:send("401 Error in Expression " .. tostring(#res) .. "\n")
                                                    server:send(res)
                                                    do break end
                                                    server:send("400 Bad Request\n")
                                                    do break end
                                                    if command == "DELW" then
                                                      local _, _, index = (string.find)(line, "^[A-Z]+%s+(%d+)%s*$")
                                                      index = tonumber(index)
                                                      if watches[index] == emptyWatch or not 1 then
                                                        do
                                                          watchescnt = watchescnt - (index <= 0 or index > #watches or 0)
                                                          watches[index] = emptyWatch
                                                          server:send("200 OK\n")
                                                          do break end
                                                          server:send("400 Bad Request\n")
                                                          do break end
                                                          if command == "RUN" then
                                                            server:send("200 OK\n")
                                                            do
                                                              local ev, vars, file, line, idx_watch = coroyield()
                                                              eval_env = vars
                                                              if ev == events.BREAK then
                                                                server:send("202 Paused " .. file .. " " .. tostring(line) .. "\n")
                                                                break
                                                              end
                                                              if ev == events.WATCH then
                                                                server:send("203 Paused " .. file .. " " .. tostring(line) .. " " .. tostring(idx_watch) .. "\n")
                                                                break
                                                              end
                                                              if ev == events.RESTART then
                                                                break
                                                              end
                                                              server:send("401 Error in Execution " .. tostring(#file) .. "\n")
                                                              server:send(file)
                                                              do break end
                                                              if command == "STEP" then
                                                                server:send("200 OK\n")
                                                                step_into = true
                                                                do
                                                                  local ev, vars, file, line, idx_watch = coroyield()
                                                                  eval_env = vars
                                                                  if ev == events.BREAK then
                                                                    server:send("202 Paused " .. file .. " " .. tostring(line) .. "\n")
                                                                    break
                                                                  end
                                                                  if ev == events.WATCH then
                                                                    server:send("203 Paused " .. file .. " " .. tostring(line) .. " " .. tostring(idx_watch) .. "\n")
                                                                    break
                                                                  end
                                                                  if ev == events.RESTART then
                                                                    break
                                                                  end
                                                                  server:send("401 Error in Execution " .. tostring(#file) .. "\n")
                                                                  server:send(file)
                                                                  do break end
                                                                  if command == "OVER" or command == "OUT" then
                                                                    server:send("200 OK\n")
                                                                    step_over = true
                                                                    if command == "OUT" then
                                                                      step_level = stack_level - 1
                                                                    else
                                                                      step_level = stack_level
                                                                    end
                                                                    do
                                                                      local ev, vars, file, line, idx_watch = coroyield()
                                                                      eval_env = vars
                                                                      if ev == events.BREAK then
                                                                        server:send("202 Paused " .. file .. " " .. tostring(line) .. "\n")
                                                                        break
                                                                      end
                                                                      if ev == events.WATCH then
                                                                        server:send("203 Paused " .. file .. " " .. tostring(line) .. " " .. tostring(idx_watch) .. "\n")
                                                                        break
                                                                      end
                                                                      if ev == events.RESTART then
                                                                        break
                                                                      end
                                                                      server:send("401 Error in Execution " .. tostring(#file) .. "\n")
                                                                      server:send(file)
                                                                      do break end
                                                                      if command == "BASEDIR" then
                                                                        local _, _, dir = (string.find)(line, "^[A-Z]+%s+(.+)%s*$")
                                                                        if not iscasepreserving or not (string.lower)(dir) then
                                                                          do
                                                                            basedir = not dir or dir
                                                                            lastsource = nil
                                                                            server:send("200 OK\n")
                                                                            do break end
                                                                            server:send("400 Bad Request\n")
                                                                            do break end
                                                                            if command == "SUSPEND" then
                                                                              break
                                                                            end
                                                                            if command == "DONE" then
                                                                              coroyield("done")
                                                                              do return  end
                                                                              break
                                                                            end
                                                                            if command == "STACK" then
                                                                              local vars, ev = {}, nil
                                                                              if seen_hook then
                                                                                ev = coroyield("stack")
                                                                              end
                                                                              if ev and ev ~= events.STACK then
                                                                                server:send("401 Error in Execution " .. tostring(#vars) .. "\n")
                                                                                server:send(vars)
                                                                                break
                                                                              end
                                                                              local params = (string.match)(line, "--%s*(%b{})%s*$")
                                                                              if params then
                                                                                local pfunc = loadstring("return " .. params)
                                                                              end
                                                                              if pfunc then
                                                                                params = pfunc()
                                                                              end
                                                                              if type(params) ~= "table" or not params then
                                                                                params = {}
                                                                              end
                                                                              if params.nocode == nil then
                                                                                params.nocode = true
                                                                              end
                                                                              if params.sparse == nil then
                                                                                params.sparse = false
                                                                              end
                                                                              if tonumber(params.maxlevel) then
                                                                                params.maxlevel = tonumber(params.maxlevel) + 4
                                                                              end
                                                                              do
                                                                                local ok, res = pcall(mobdebug.dump, vars, params)
                                                                                if ok then
                                                                                  server:send("200 OK " .. tostring(res) .. "\n")
                                                                                  break
                                                                                end
                                                                                server:send("401 Error in Execution " .. tostring(#res) .. "\n")
                                                                                server:send(res)
                                                                                do break end
                                                                                -- DECOMPILER ERROR at PC842: Overwrote pending register: R13 in 'AssignReg'

                                                                                if command == "OUTPUT" then
                                                                                  local _, _, stream, mode = vars(line, "^[A-Z]+%s+(%w+)%s+([dcr])%s*$")
                                                                                  if mode ~= "d" then
                                                                                    local default = not stream or not mode or stream ~= "stdout"
                                                                                    if not default or not iobase.print then
                                                                                      do
                                                                                        do
                                                                                          genv.print = corowrap(function(...)
    -- function num : 0_25_2 , upvalues : coroutine, mode, iobase, unpack, _ENV, mobdebug, table, server, stream
    while 1 do
      local tbl = {(coroutine.yield)()}
      if mode == "c" then
        (iobase.print)(unpack(tbl))
      end
      for n = 1, #tbl do
        tbl[n] = select(2, pcall(mobdebug.line, tbl[n], {nocode = true, comment = false}))
      end
      local file = (table.concat)(tbl, "\t") .. "\n"
      server:send("204 Output " .. stream .. " " .. tostring(#file) .. "\n" .. file)
    end
  end
)
                                                                                          if not default then
                                                                                            (genv.print)()
                                                                                          end
                                                                                          server:send("200 OK\n")
                                                                                          do break end
                                                                                          server:send("400 Bad Request\n")
                                                                                          do break end
                                                                                          do break end
                                                                                          if command == "EXIT" then
                                                                                            server:send("200 OK\n")
                                                                                            coroyield("exit")
                                                                                            break
                                                                                          end
                                                                                          server:send("400 Bad Request\n")
                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out DO_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out DO_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out IF_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out IF_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out IF_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out DO_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out IF_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out DO_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out IF_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out IF_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out DO_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out IF_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out DO_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out IF_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out DO_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out IF_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out DO_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out IF_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out IF_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out DO_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out DO_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out DO_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out IF_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out IF_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out IF_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out DO_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out DO_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out IF_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out IF_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out DO_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out DO_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out IF_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out DO_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out IF_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out IF_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out IF_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out IF_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out DO_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out IF_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out DO_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                                                                          -- DECOMPILER ERROR at PC894: LeaveBlock: unexpected jumping out IF_STMT

                                                                                        end
                                                                                      end
                                                                                    end
                                                                                  end
                                                                                end
                                                                              end
                                                                            end
                                                                          end
                                                                        end
                                                                      end
                                                                    end
                                                                  end
                                                                end
                                                              end
                                                            end
                                                          end
                                                        end
                                                      end
                                                    end
                                                  end
                                                end
                                              end
                                            end
                                          end
                                        end
                                      end
                                    end
                                  end
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
    -- DECOMPILER ERROR: 7 unprocessed JMP targets
  end
end

  local output = function(stream, data, ...)
  -- function num : 0_26 , upvalues : server, _ENV
  if server then
    return server:send("204 Output " .. stream .. " " .. tostring(#data) .. "\n" .. data)
  end
end

  local connect = function(controller_host, controller_port, ...)
  -- function num : 0_27 , upvalues : socket, mobdebug, _ENV
  local sock, err = (socket.tcp)()
  if not sock then
    return nil, err
  end
  if sock.settimeout then
    sock:settimeout(mobdebug.connecttimeout)
  end
  local res, err = sock:connect(controller_host, tostring(controller_port))
  if sock.settimeout then
    sock:settimeout()
  end
  if not res then
    return nil, err
  end
  return sock
end

  local lasthost, lastport = nil, nil
  local start = function(controller_host, controller_port, ...)
  -- function num : 0_28 , upvalues : isrunning, lasthost, lastport, mobdebug, server, stack_level, stack_depth, debug, _ENV, genv, iobase, coro_debugger, corocreate, debugger_loop, debug_hook, HOOKMASK, seen_hook, step_into
  if isrunning() then
    return 
  end
  lasthost = controller_host or lasthost
  lastport = controller_port or lastport
  controller_host = lasthost or "localhost"
  controller_port = lastport or mobdebug.port
  local err = nil
  server = (mobdebug.connect)(controller_host, controller_port)
  if server then
    stack_level = stack_depth(16)
    local f = function(...)
    -- function num : 0_28_0
    return function(...)
      -- function num : 0_28_0_0
    end

  end

    do
      do
        if f() ~= f() then
          local dtraceback = debug.traceback
          do
            debug.traceback = function(...)
    -- function num : 0_28_1 , upvalues : _ENV, dtraceback, genv, iobase
    if select("#", ...) >= 1 then
      local thr, err, lvl = ..., ..., ...
      if type(thr) ~= "thread" then
        err = thr
      end
      local trace = dtraceback(err, (lvl or 1) + 1)
      if genv.print == iobase.print then
        return trace
      else
        ;
        (genv.print)(trace)
        return 
      end
    end
    do
      -- DECOMPILER ERROR at PC34: Overwrote pending register: R2 in 'AssignReg'

      local tb = dtraceback("", lvl)
      return type(tb) == "string" and tb:gsub("^\n", "") or tb
    end
  end

          end
        end
        coro_debugger = corocreate(debugger_loop)
        ;
        (debug.sethook)(debug_hook, HOOKMASK)
        seen_hook = nil
        step_into = true
        do return true end
        print(("Could not connect to %s:%s: %s"):format(controller_host, controller_port, err or "unknown error"))
      end
    end
  end
end

  local controller = function(controller_host, controller_port, scratchpad, ...)
  -- function num : 0_29 , upvalues : isrunning, lasthost, lastport, mobdebug, server, _ENV, seen_hook, coro_debugger, corocreate, debugger_loop, step_into, abort, checkcount, coro_debugee, debugee, debug, debug_hook, HOOKMASK, cororesume, unpack, corostatus, error, string, deferror, events, capture_vars
  if isrunning() then
    return 
  end
  lasthost = controller_host or lasthost
  lastport = controller_port or lastport
  controller_host = lasthost or "localhost"
  controller_port = lastport or mobdebug.port
  local exitonerror = not scratchpad
  local err = nil
  server = (mobdebug.connect)(controller_host, controller_port)
  if server then
    local report = function(trace, err, ...)
    -- function num : 0_29_0 , upvalues : server, _ENV
    local msg = err .. "\n" .. trace
    server:send("401 Error in Execution " .. tostring(#msg) .. "\n")
    server:send(msg)
    return err
  end

    seen_hook = true
    coro_debugger = corocreate(debugger_loop)
    while 1 do
      while 1 do
        while 1 do
          step_into = true
          abort = false
          if scratchpad then
            checkcount = mobdebug.checkcount
          end
          coro_debugee = corocreate(debugee)
          ;
          (debug.sethook)(coro_debugee, debug_hook, HOOKMASK)
          if not arg then
            local status, err = cororesume(coro_debugee, unpack({}))
            -- DECOMPILER ERROR at PC73: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC73: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
        -- DECOMPILER ERROR at PC84: Unhandled construct in 'MakeBoolean' P1

        if (not abort or tostring(abort) ~= "exit" and status) and corostatus(coro_debugee) == "suspended" then
          error("attempt to yield from the main thread", 3)
        end
      end
      if not err or not (string.find)(tostring(err), deferror) then
        report((debug.traceback)(coro_debugee), tostring(err))
        if not exitonerror and coro_debugger then
          do
            local status, err = cororesume(coro_debugger, events.RESTART, capture_vars(0))
            -- DECOMPILER ERROR at PC123: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC123: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC123: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC123: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  else
    do
      if err ~= "exit" then
        if not err then
          print(("Could not connect to %s:%s: %s"):format(controller_host, controller_port, "unknown error"))
          do return false end
          return true
        end
      end
    end
  end
end

  local scratchpad = function(controller_host, controller_port, ...)
  -- function num : 0_30 , upvalues : controller
  return controller(controller_host, controller_port, true)
end

  local loop = function(controller_host, controller_port, ...)
  -- function num : 0_31 , upvalues : controller
  return controller(controller_host, controller_port, false)
end

  local on = function(...)
  -- function num : 0_32 , upvalues : isrunning, server, coroutine, coroutines, debug, debug_hook, HOOKMASK, jit
  if not isrunning() or not server then
    return 
  end
  local co, main = (coroutine.running)()
  if main then
    co = nil
  end
  if co then
    coroutines[co] = true
    ;
    (debug.sethook)(co, debug_hook, HOOKMASK)
  else
    if jit then
      coroutines.main = true
    end
    ;
    (debug.sethook)(debug_hook, HOOKMASK)
  end
end

  local off = function(...)
  -- function num : 0_33 , upvalues : isrunning, server, coroutine, coroutines, jit, debug, pairs
  if not isrunning() or not server then
    return 
  end
  local co, main = (coroutine.running)()
  if main then
    co = nil
  end
  if co then
    coroutines[co] = false
    if not jit then
      (debug.sethook)(co)
    end
  else
    if jit then
      coroutines.main = false
    end
    if not jit then
      (debug.sethook)()
    end
  end
  if jit then
    local remove = true
    for _,debugged in pairs(coroutines) do
      if debugged then
        remove = false
        break
      end
    end
    do
      if remove then
        (debug.sethook)()
      end
    end
  end
end

  local handle = function(params, client, options, ...)
  -- function num : 0_34 , upvalues : _ENV, string, watches, tonumber, outputs, removebasedir, basedir, set_breakpoint, remove_breakpoint, pairs, io, require, loadstring, unpack, breakpoints, mobdebug
  local verbose = options and ((options.verbose ~= nil and options.verbose))
  if (not verbose or (type(verbose) == "function" and verbose) or not print) then
    local print = function(...)
    -- function num : 0_34_0
  end

  end
  local file, line, watch_idx = nil, nil, nil
  local _, _, command = (string.find)(params, "^([a-z]+)")
  if command == "run" or command == "step" or command == "out" or command == "over" or command == "exit" then
    client:send((string.upper)(command) .. "\n")
    client:receive()
    while 1 do
      local done = true
      local breakpoint = client:receive()
      if not breakpoint then
        print("Program finished")
        return nil, nil, false
      end
      local _, _, status = (string.find)(breakpoint, "^(%d+)")
      -- DECOMPILER ERROR at PC73: Overwrote pending register: R14 in 'AssignReg'

      if (status ~= "200" or status == "202") and file and line then
        print("Paused at file " .. file .. " line " .. line)
      end
      -- DECOMPILER ERROR at PC93: Overwrote pending register: R6 in 'AssignReg'

      -- DECOMPILER ERROR at PC94: Overwrote pending register: R5 in 'AssignReg'

      -- DECOMPILER ERROR at PC95: Overwrote pending register: R14 in 'AssignReg'

      -- DECOMPILER ERROR at PC96: Overwrote pending register: R14 in 'AssignReg'

      if status == "203" and file and line and watch_idx then
        print("Paused at file " .. file .. " line " .. line .. " (watch expression " .. watch_idx .. ": [" .. watches[watch_idx] .. "])")
      end
      if status == "204" then
        local _, _, stream, size = (string.find)(breakpoint, "^204 Output (%w+) (%d+)$")
        if stream and size then
          local size = tonumber(size)
          local msg = size > 0 and client:receive(size) or ""
          print(msg)
          if outputs[stream] then
            (outputs[stream])(msg)
          end
          done = false
        end
      elseif status == "401" then
        local _, _, size = (string.find)(breakpoint, "^401 Error in Execution (%d+)$")
        if size then
          local msg = client:receive(tonumber(size))
          print("Error in remote application: " .. msg)
          return nil, nil, msg
        end
      else
        print("Unknown error")
        return nil, nil, "Debugger error: unexpected response \'" .. breakpoint .. "\'"
      end
    end
  else
    -- DECOMPILER ERROR at PC187: Overwrote pending register: R14 in 'AssignReg'

    if not done then
      if command == "done" then
        client:send((string.upper)(_) .. "\n")
      else
        -- DECOMPILER ERROR at PC201: Overwrote pending register: R6 in 'AssignReg'

        -- DECOMPILER ERROR at PC202: Overwrote pending register: R5 in 'AssignReg'

        -- DECOMPILER ERROR at PC204: Overwrote pending register: R9 in 'AssignReg'

        -- DECOMPILER ERROR at PC205: Overwrote pending register: R9 in 'AssignReg'

        -- DECOMPILER ERROR at PC220: Overwrote pending register: R5 in 'AssignReg'

        -- DECOMPILER ERROR at PC225: Overwrote pending register: R5 in 'AssignReg'

        if command == "setb" or command == "asetb" then
          if file and line then
            if not file:find("^\".*\"$") then
              client:send("SETB " .. file .. " " .. line .. "\n")
              if command == "asetb" or client:receive() == "200 OK" then
                set_breakpoint(file, line)
              else
                print("Error: breakpoint not inserted")
              end
              print("Invalid command")
              if command == "setw" then
                local _, _, exp = (string.find)(params, "^[a-z]+%s+(.+)$")
                if exp then
                  client:send("SETW " .. exp .. "\n")
                  local answer = client:receive()
                  local _, _, watch_idx = (string.find)(answer, "^200 OK (%d+)%s*$")
                  if watch_idx then
                    watches[watch_idx] = exp
                    print("Inserted watch exp no. " .. watch_idx)
                  else
                    local _, _, size = (string.find)(answer, "^401 Error in Expression (%d+)$")
                    if size then
                      local err = (client:receive(tonumber(size))):gsub(".-:%d+:%s*", "")
                      print("Error: watch expression not set: " .. err)
                    else
                      print("Error: watch expression not set")
                    end
                  end
                else
                  print("Invalid command")
                end
              else
                -- DECOMPILER ERROR at PC319: Overwrote pending register: R6 in 'AssignReg'

                -- DECOMPILER ERROR at PC320: Overwrote pending register: R5 in 'AssignReg'

                -- DECOMPILER ERROR at PC321: Overwrote pending register: R9 in 'AssignReg'

                -- DECOMPILER ERROR at PC322: Overwrote pending register: R9 in 'AssignReg'

                -- DECOMPILER ERROR at PC323: Overwrote pending register: R9 in 'AssignReg'

                -- DECOMPILER ERROR at PC338: Overwrote pending register: R5 in 'AssignReg'

                -- DECOMPILER ERROR at PC343: Overwrote pending register: R5 in 'AssignReg'

                if command == "delb" or command == "adelb" then
                  if file and line then
                    if not file:find("^\".*\"$") then
                      client:send("DELB " .. file .. " " .. line .. "\n")
                      if command == "adelb" or client:receive() == "200 OK" then
                        remove_breakpoint(file, line)
                      else
                        print("Error: breakpoint not removed")
                      end
                      print("Invalid command")
                      if command == "delallb" then
                        local file, line = "*", 0
                        client:send("DELB " .. file .. " " .. tostring(line) .. "\n")
                        if client:receive() == "200 OK" then
                          remove_breakpoint(file, line)
                        else
                          print("Error: all breakpoints not removed")
                        end
                      elseif command == "delw" then
                        local _, _, index = (string.find)(params, "^[a-z]+%s+(%d+)%s*$")
                        if index then
                          client:send("DELW " .. index .. "\n")
                          if client:receive() == "200 OK" then
                            watches[index] = nil
                          else
                            print("Error: watch expression not removed")
                          end
                        else
                          print("Invalid command")
                        end
                      elseif command == "delallw" then
                        for index,exp in pairs(watches) do
                          client:send("DELW " .. index .. "\n")
                          if client:receive() == "200 OK" then
                            watches[index] = nil
                          else
                            print("Error: watch expression at index " .. index .. " [" .. exp .. "] not removed")
                          end
                        end
                      elseif command == "eval" or command == "exec" or command == "load" or command == "loadstring" or command == "reload" then
                        local _, _, exp = (string.find)(params, "^[a-z]+%s+(.+)$")
                        if exp or command == "reload" then
                          if command == "eval" or command == "exec" then
                            exp = ((exp:gsub("%-%-%[(=*)%[.-%]%1%]", "")):gsub("%-%-.-\n", " ")):gsub("\n", " ")
                            if command == "eval" then
                              exp = "return " .. exp
                            end
                            client:send("EXEC " .. exp .. "\n")
                          elseif command == "reload" then
                            client:send("LOAD 0 -\n")
                          elseif command == "loadstring" then
                            local _, _, _, file, lines = (string.find)(exp, "^([\"\'])(.-)%1%s(.+)")
                            -- DECOMPILER ERROR at PC523: Overwrote pending register: R16 in 'AssignReg'

                            if not file then
                              do
                                client:send("LOAD " .. tostring(#lines) .. " " .. file .. "\n")
                                client:send(lines)
                                -- DECOMPILER ERROR at PC540: Overwrote pending register: R16 in 'AssignReg'

                                local file = (io.open)(exp, _)
                                -- DECOMPILER ERROR at PC546: Overwrote pending register: R17 in 'AssignReg'

                                if not file and pcall(require, file) then
                                  (winapi.set_encoding)(winapi.CP_UTF8)
                                  local shortp = (winapi.short_path)(exp)
                                  -- DECOMPILER ERROR at PC563: Overwrote pending register: R18 in 'AssignReg'

                                  if shortp then
                                    file = (io.open)(shortp, lines)
                                  end
                                end
                                if not file then
                                  return nil, nil, "Cannot open file " .. exp
                                end
                                local lines = (file:read("*all")):gsub("^#!.-\n", "\n")
                                file:close()
                                do
                                  do
                                    local file = (string.gsub)(exp, "\\", "/")
                                    file = removebasedir(file, basedir)
                                    client:send("LOAD " .. tostring(#lines) .. " " .. file .. "\n")
                                    if #lines > 0 then
                                      client:send(lines)
                                    end
                                    while 1 do
                                      local params, err = client:receive()
                                      if not err then
                                        do return nil, nil, "Debugger connection " .. (params or "error") end
                                        local done = true
                                        do
                                          local _, _, status, len = (string.find)(params, "^(%d+).-%s+(%d+)%s*$")
                                          if status == "200" then
                                            len = tonumber(len)
                                            if len > 0 then
                                              local status, res = nil, nil
                                              local str = client:receive(len)
                                              local func, err = loadstring(str)
                                              if func then
                                                status = pcall(func)
                                                if not status then
                                                  err = res
                                                elseif type(res) ~= "table" then
                                                  err = "received " .. type(res) .. " instead of expected \'table\'"
                                                end
                                              end
                                              if err then
                                                print("Error in processing results: " .. err)
                                                return nil, nil, "Error in processing results: " .. err
                                              end
                                              print(unpack(res))
                                              return res[1], res
                                            end
                                          else
                                            -- DECOMPILER ERROR at PC685: Overwrote pending register: R22 in 'AssignReg'

                                            -- DECOMPILER ERROR at PC688: Overwrote pending register: R6 in 'AssignReg'

                                            -- DECOMPILER ERROR at PC689: Overwrote pending register: R5 in 'AssignReg'

                                            -- DECOMPILER ERROR at PC691: Overwrote pending register: R18 in 'AssignReg'

                                          end
                                          if status ~= "201" or status ~= "202" then
                                            if params ~= "200 OK" or status == "204" then
                                              local _, _, stream, size = (string.find)(params, "^204 Output (%w+) (%d+)$")
                                              if stream and size then
                                                local size = tonumber(size)
                                                local msg = size > 0 and client:receive(size) or ""
                                                print(msg)
                                                if outputs[stream] then
                                                  (outputs[stream])(msg)
                                                end
                                                done = false
                                              end
                                            elseif status == "401" then
                                              len = tonumber(len)
                                              local res = client:receive(len)
                                              print("Error in expression: " .. res)
                                              return nil, nil, res
                                            else
                                              print("Unknown error")
                                              return nil, nil, "Debugger error: unexpected response after EXEC/LOAD \'" .. params .. "\'"
                                            end
                                          end
                                          -- DECOMPILER ERROR at PC759: LeaveBlock: unexpected jumping out IF_THEN_STMT

                                          -- DECOMPILER ERROR at PC759: LeaveBlock: unexpected jumping out IF_STMT

                                        end
                                      end
                                    end
                                    if not done then
                                      print("Invalid command")
                                    end
                                    if command == "listb" then
                                      for l,v in pairs(breakpoints) do
                                        for f in pairs(v) do
                                          print(f .. ": " .. l)
                                        end
                                      end
                                    elseif command == "listw" then
                                      for i,v in pairs(watches) do
                                        print("Watch exp. " .. i .. ": " .. v)
                                      end
                                    elseif command == "suspend" then
                                      client:send("SUSPEND\n")
                                    elseif command == "stack" then
                                      local opts = (string.match)(params, "^[a-z]+%s+(.+)$")
                                      client:send("STACK" .. (opts and " " .. opts or "") .. "\n")
                                      local resp = client:receive()
                                      local _, _, status, res = (string.find)(resp, "^(%d+)%s+%w+%s+(.+)%s*$")
                                      if status == "200" then
                                        local func, err = loadstring(res)
                                        if func == nil then
                                          print("Error in stack information: " .. err)
                                          return nil, nil, err
                                        end
                                        local ok, stack = pcall(func)
                                        if not ok then
                                          print("Error in stack information: " .. stack)
                                          return nil, nil, stack
                                        end
                                        for _,frame in ipairs(stack) do
                                          print((mobdebug.line)(frame[1], {comment = false}))
                                        end
                                        return stack
                                      elseif status == "401" then
                                        local _, _, len = (string.find)(resp, "%s+(%d+)%s*$")
                                        len = tonumber(len)
                                        local res = len > 0 and client:receive(len) or "Invalid stack information."
                                        print("Error in expression: " .. res)
                                        return nil, nil, res
                                      else
                                        print("Unknown error")
                                        return nil, nil, "Debugger error: unexpected response after STACK"
                                      end
                                    elseif command == "output" then
                                      local _, _, stream, mode = (string.find)(params, "^[a-z]+%s+(%w+)%s+([dcr])%s*$")
                                      if stream and mode then
                                        client:send("OUTPUT " .. stream .. " " .. mode .. "\n")
                                        local resp, err = client:receive()
                                        if not resp then
                                          print("Unknown error: " .. err)
                                          return nil, nil, "Debugger connection error: " .. err
                                        end
                                        local _, _, status = (string.find)(resp, "^(%d+)%s+%w+%s*$")
                                        if status == "200" then
                                          print("Stream " .. stream .. " redirected")
                                          outputs[stream] = type(options) == "table" and options.handler or nil
                                        elseif type(options) == "table" and options.handler then
                                          outputs[stream] = options.handler
                                        else
                                          print("Unknown error")
                                          return nil, nil, "Debugger error: can\'t redirect " .. stream
                                        end
                                      else
                                        print("Invalid command")
                                      end
                                    elseif command == "basedir" then
                                      local _, _, dir = (string.find)(params, "^[a-z]+%s+(.+)$")
                                      if dir then
                                        dir = (string.gsub)(dir, "\\", "/")
                                        if not (string.find)(dir, "/$") then
                                          dir = dir .. "/"
                                        end
                                        local remdir = dir:match("\t(.+)")
                                        if remdir then
                                          dir = dir:gsub("/?\t.+", "/")
                                        end
                                        basedir = dir
                                        client:send("BASEDIR " .. (remdir or dir) .. "\n")
                                        local resp, err = client:receive()
                                        if not resp then
                                          print("Unknown error: " .. err)
                                          return nil, nil, "Debugger connection error: " .. err
                                        end
                                        local _, _, status = (string.find)(resp, "^(%d+)%s+%w+%s*$")
                                        if status == "200" then
                                          print("New base directory is " .. basedir)
                                        else
                                          print("Unknown error")
                                          return nil, nil, "Debugger error: unexpected response after BASEDIR"
                                        end
                                      else
                                        print(basedir)
                                      end
                                    elseif command == "help" then
                                      print("setb <file> <line>    -- sets a breakpoint")
                                      print("delb <file> <line>    -- removes a breakpoint")
                                      print("delallb               -- removes all breakpoints")
                                      print("setw <exp>            -- adds a new watch expression")
                                      print("delw <index>          -- removes the watch expression at index")
                                      print("delallw               -- removes all watch expressions")
                                      print("run                   -- runs until next breakpoint")
                                      print("step                  -- runs until next line, stepping into function calls")
                                      print("over                  -- runs until next line, stepping over function calls")
                                      print("out                   -- runs until line after returning from current function")
                                      print("listb                 -- lists breakpoints")
                                      print("listw                 -- lists watch expressions")
                                      print("eval <exp>            -- evaluates expression on the current context and returns its value")
                                      print("exec <stmt>           -- executes statement on the current context")
                                      print("load <file>           -- loads a local file for debugging")
                                      print("reload                -- restarts the current debugging session")
                                      print("stack                 -- reports stack trace")
                                      print("output stdout <d|c|r> -- capture and redirect io stream (default|copy|redirect)")
                                      print("basedir [<path>]      -- sets the base path of the remote application, or shows the current one")
                                      print("done                  -- stops the debugger and continues application execution")
                                      print("exit                  -- exits debugger and the application")
                                    else
                                      local _, _, spaces = (string.find)(params, "^(%s*)$")
                                      if spaces then
                                        return nil, nil, "Empty command"
                                      else
                                        print("Invalid command")
                                        return nil, nil, "Invalid command"
                                      end
                                    end
                                    do return file, line end
                                    -- DECOMPILER ERROR: 104 unprocessed JMP targets
                                  end
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

  local listen = function(host, port, ...)
  -- function num : 0_35 , upvalues : mobdebug, require, _ENV, string, io, handle
  if not host then
    host = "*"
  end
  if not port then
    port = mobdebug.port
  end
  local socket = require("socket")
  print("Lua Remote Debugger")
  print("Run the program you wish to debug")
  local server = (socket.bind)(host, port)
  local client = server:accept()
  client:send("STEP\n")
  client:receive()
  local breakpoint = client:receive()
  local _, _, file, line = (string.find)(breakpoint, "^202 Paused%s+(.-)%s+(%d+)%s*$")
  if file and line then
    print("Paused at file " .. file)
    print("Type \'help\' for commands")
  else
    local _, _, size = (string.find)(breakpoint, "^401 Error in Execution (%d+)%s*$")
    if size then
      print("Error in remote application: ")
      print(client:receive(size))
    end
  end
  do
    while 1 do
      (io.write)("> ")
      local file, line, err = handle((io.read)("*line"), client)
    end
    do
      if not file then
        if err ~= false then
          client:close()
        end
      end
    end
  end
end

  local cocreate = nil
  local coro = function(...)
  -- function num : 0_36 , upvalues : cocreate, coroutine, mobdebug
  if cocreate then
    return 
  end
  cocreate = cocreate or coroutine.create
  coroutine.create = function(f, ...)
    -- function num : 0_36_0 , upvalues : cocreate, mobdebug
    return cocreate(function(...)
      -- function num : 0_36_0_0 , upvalues : mobdebug, f
      (mobdebug.on)()
      return f(...)
    end
, ...)
  end

end

  local moconew = nil
  local moai = function(...)
  -- function num : 0_37 , upvalues : moconew, MOAICoroutine, _ENV, mobdebug
  if moconew then
    return 
  end
  moconew = moconew or not MOAICoroutine or MOAICoroutine.new
  if not moconew then
    return 
  end
  MOAICoroutine.new = function(...)
    -- function num : 0_37_0 , upvalues : moconew, _ENV, mobdebug
    local thread = moconew(...)
    if not thread.run or not thread then
      local mt = getmetatable(thread)
    end
    local patched = mt.run
    mt.run = function(self, f, ...)
      -- function num : 0_37_0_0 , upvalues : patched, mobdebug
      return patched(self, function(...)
        -- function num : 0_37_0_0_0 , upvalues : mobdebug, f
        (mobdebug.on)()
        return f(...)
      end
, ...)
    end

    return thread
  end

end

  mobdebug.setbreakpoint = set_breakpoint
  mobdebug.removebreakpoint = remove_breakpoint
  mobdebug.listen = listen
  mobdebug.loop = loop
  mobdebug.scratchpad = scratchpad
  mobdebug.handle = handle
  mobdebug.connect = connect
  mobdebug.start = start
  mobdebug.on = on
  mobdebug.off = off
  mobdebug.moai = moai
  mobdebug.coro = coro
  mobdebug.done = done
  mobdebug.pause = function(...)
  -- function num : 0_38 , upvalues : step_into
  step_into = true
end

  mobdebug.yield = nil
  mobdebug.output = output
  mobdebug.onexit = os and os.exit or done
  mobdebug.onscratch = nil
  mobdebug.basedir = function(b, ...)
  -- function num : 0_39 , upvalues : basedir
  if b then
    basedir = b
  end
  return basedir
end

  do return mobdebug end
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

