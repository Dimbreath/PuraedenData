-- params : ...
-- function num : 0 , upvalues : _ENV
MailData = {
data = {}
}
local selectedIndex = -1
-- DECOMPILER ERROR at PC7: Confused about usage of register: R1 in 'UnsetPending'

MailData.SaveClickedIndex = function(index, ...)
  -- function num : 0_0 , upvalues : selectedIndex
  selectedIndex = index
end

-- DECOMPILER ERROR at PC10: Confused about usage of register: R1 in 'UnsetPending'

MailData.GetClickedIndex = function(...)
  -- function num : 0_1 , upvalues : selectedIndex
  return selectedIndex
end

-- DECOMPILER ERROR at PC13: Confused about usage of register: R1 in 'UnsetPending'

MailData.SaveMailData = function(data, ...)
  -- function num : 0_2 , upvalues : _ENV
  -- DECOMPILER ERROR at PC2: Confused about usage of register: R1 in 'UnsetPending'

  MailData.data = {}
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R1 in 'UnsetPending'

  MailData.data = data
end

-- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

MailData.GetMailData = function(...)
  -- function num : 0_3 , upvalues : _ENV
  return MailData.data
end

-- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

MailData.GetMailIndex = function(mailId, ...)
  -- function num : 0_4 , upvalues : _ENV
  for index,value in ipairs(MailData.data) do
    if value.id == mailId then
      return index - 1
    end
  end
end

-- DECOMPILER ERROR at PC22: Confused about usage of register: R1 in 'UnsetPending'

MailData.ChangeMailIsRead = function(mailId, isRead, ...)
  -- function num : 0_5 , upvalues : _ENV
  for i,v in ipairs(MailData.data) do
    if v.id == mailId then
      v.read = isRead
    end
  end
end

-- DECOMPILER ERROR at PC25: Confused about usage of register: R1 in 'UnsetPending'

MailData.GetMailIsRead = function(mailId, ...)
  -- function num : 0_6 , upvalues : _ENV
  local isRead = false
  for i,v in ipairs(MailData.data) do
    if v.id == mailId then
      isRead = v.read
    end
  end
  return isRead
end

-- DECOMPILER ERROR at PC28: Confused about usage of register: R1 in 'UnsetPending'

MailData.GetMailIsRecive = function(mailId, ...)
  -- function num : 0_7 , upvalues : _ENV
  local isRecive = false
  for i,v in ipairs(MailData.data) do
    if v.id == mailId then
      isRecive = v.received
    end
  end
  return isRecive
end

-- DECOMPILER ERROR at PC31: Confused about usage of register: R1 in 'UnsetPending'

MailData.ChangeMailIsTaken = function(resList, ...)
  -- function num : 0_8 , upvalues : _ENV
  for i,v in ipairs(resList) do
    if v.id == (ActorService.RegisterMail)() then
      (ActorService.RegisterMail)(0)
    end
    for n,m in ipairs(MailData.data) do
      -- DECOMPILER ERROR at PC25: Confused about usage of register: R11 in 'UnsetPending'

      if v.id == m.id then
        (MailData.data)[n] = v
        break
      end
    end
  end
  return MailData.data
end


