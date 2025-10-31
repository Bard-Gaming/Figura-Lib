--[[

Project: BG Lib - Actions
File description:
Implementation for ToggleAction class

--]]

local Class = require("../core.class")
local random = require("../core.random")


local ToggleAction = Class:new({ _baseAction = nil, _actionPage = nil, _updateHandle = nil })


function ToggleAction:register(actionsPage)
  --[[
  Function that's called when the action
  gets toggled (i.e. switches from toggled
  to untoggled or vice-versa).
  --]]
  -- update state
  self._actionPage = actionsPage
  self._baseAction = actionsPage:newAction()
  self._updateHandle = random.uuid()

  -- register action functions
  self._baseAction:setOnToggle(function(isActive) self:onToggle(isActive) end)

  -- register tick
  events.TICK:register(function() self:tick() end, self._updateHandle)
end

function ToggleAction:unregister()
  --[[
  Unregisters the action.
  Does nothing if the action isn't
  registered.
  --]]
  -- remove action from action wheel
  for index, action in ipairs(self._actionPage:getActions()) do
    if action == self._baseAction then
      self._actionPage:setAction(index, nil)
      break
    end
  end

  -- unregister tick event
  events.TICK:remove(self._updateHandle)
  
  -- reset state
  self._updateHandle = nil
  self._baseAction = nil
  self._actionPage = nil
end

function ToggleAction:onToggle(isActive)
  --[[
  Function that's called when the action
  gets toggled (i.e. switches from toggled
  to untoggled or vice-versa).
  --]]
end

function ToggleAction:isToggled()
  --[[
  Determines if the action has
  been toggled or not
  --]]
  self:_requireRegister()

  return self._baseAction:isToggled()
end

function ToggleAction:setToggled(newState)
  --[[
  Sets the toggle state of the action
  to the specified value
  --]]
  self:_requireRegister()

  self._baseAction:setToggled(newState)
  self:onToggle(newState)
  return self
end

function ToggleAction:tick()
  --[[
  Action tick function.

  This function is called every tick (usually every 20ms).
  --]]
  if not self:isToggled() then return end

  self:onActive()
end

function ToggleAction:onActive()
  --[[
  Function that gets called every
  tick whilst the action is toggled on.
  --]]
end

function ToggleAction:_requireRegister()
  --[[
  Ensures the action has been registered.
  If so, this function does nothing.
  If the action hasn't been registered,
  an error is thrown.
  --]]
  if self._baseAction ~= nil then return end

  error("Attempted to use a toggle action without registering it prior.", 2)
end


return ToggleAction
