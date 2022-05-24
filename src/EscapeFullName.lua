--!strict
local escapeFullName = function(targetInstance: Instance): string
	assert(
		typeof(targetInstance) == "Instance",
		"Arg #1 expecting an Instance got " .. typeof(targetInstance) .. " instead."
	)

	local currentInstance = targetInstance
	local tree = {}
	local fullName = {}

	while currentInstance and currentInstance ~= game :: Instance do
		table.insert(tree, currentInstance)
		currentInstance = currentInstance.Parent
	end

	for i = #tree, 1, -1 do
		table.insert(fullName, (tree[i].Name:gsub("/", "//"):gsub("%.", "/.")))
	end

	return table.concat(fullName, ".")
end

return escapeFullName
