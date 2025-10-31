--[[

Project: BG Lib - Core
File description:
Implementation for
BGLib's random module

--]]

local random = {}

function random.uuid()
  --[[
  Generates a random UUID string.
  --]]
  return client.intUUIDToString(client.generateUUID())
end

function random.vec3(precision)
  --[[
  Generates a random 3D direction vector.
  Since the vector is a "direction" vector,
  it's length/magnitude/norm will be 1.

  Note: Due to float imprecision, the norm
  might not be exactly 1.
  --]]
  precision = precision or 1000

  randomVector = vectors.vec3(
    math.random(-precision, precision) / precision,
    math.random(-precision, precision) / precision,
    math.random(-precision, precision) / precision
  )

  return randomVector:normalized()
end

return random
