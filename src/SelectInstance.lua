--!strict
local lexer = require(script.Parent.lexer)

local selectInstance = function(root: Instance, selection: string): (boolean, string | Instance)
	local tokens = lexer(selection)
	local child = root

	local index = 1
	while #tokens >= index do
		local identifier = tokens[index]
		local seperator = tokens[index + 1]

		if identifier.ttype ~= "Identifier" then
			return false, "Expected Identifier, got " .. identifier.ttype .. " instead."
		end

		local newChild: Instance? = child:FindFirstChild(identifier.value)
		if newChild == nil then
			return false, ("Could not find child '%s'."):format(child.Name)
		end

		child = assert(newChild, "Unreachable")

		if seperator == nil then
			return true, child
		end

		if seperator.ttype ~= "Seperator" then
			return false, "Expected Seperator, got " .. identifier.ttype .. " instead."
		end

		index += 2
	end

	return true, child
end

return selectInstance