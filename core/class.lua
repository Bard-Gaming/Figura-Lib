--[[

Project: BG Lib - Core
File description:
Implementation for
BGLib's Classes

--]]


local Class = { _superLevel = 0 }


function Class:new(object)
  --[[
  Creates a new class.
  If this is called on an existing
  class, this creates a new instance
  instead.
  --]]
  object = object or {}

  setmetatable(object, self)
  self.__index = self

  return object
end

function Class:subclass(object)
  --[[
  Creates a subclass of the given
  class. When creating a new class
  (independent of others), you must
  use Class:new().
  --]]
  if self == Class then
    error(
      "Can't subclass the the base Class. \z
      If you wish to make a new class, please use Class:new()"
    )
  end

  local subclass = self:new(object)

  subclass._parent = self

  return subclass
end

function Class:super(method)
  --[[
  Returns a function that calls
  the given method from the class's
  parent with the current instance.
  --]]

  local parent = self._parent

  for level=1,self._superLevel do
    parent = parent._parent
  end

  if parent == nil then
    error("Attempted to call super on a class with no parent")
  end

  return function(...)
    local args = {...}

    -- actually call the appropriate method
    self._superLevel = self._superLevel + 1
    local return_value = parent[method](self, table.unpack(args))
    self._superLevel = self._superLevel - 1

    return return_value
  end
end


return Class
