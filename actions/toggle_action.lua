--[[

Project: BG Lib - Actions
File description:
Implementation for ToggleAction class

--]]

local Class = require("../core.class")

local ToggleAction = Class:new({ _baseAction = nil })


function ToggleAction:register(actionsPage)
  --[[
  Function that's called when the action
  gets toggled (i.e. switches from toggled
  to untoggled or vice-versa).
  --]]
  self._baseAction = actionsPage:newAction()

  -- Register required functions
  self._baseAction:setOnToggle(function(isActive) self:onToggle(isActive) end)
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
