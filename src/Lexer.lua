--!strict
local VAILD_IDENTIFIER = "[^%.%/]"

export type Lexed = {
	[number]: {
		ttype: "Identifier",
		value: string,
	} | {
		ttype: "Seperator",
	},
}

local lexer = function(input: string): Lexed
	local tokens: Lexed = {}

	local index = 1

	while #input > index do
		local character = input:sub(index, index)

		if character:match(VAILD_IDENTIFIER) or character:match("/") then
			local identifier = {}

			while true do
				local matchedCharacter = input:sub(index, index)

				if matchedCharacter == "" then
					break
				elseif matchedCharacter:match("%.") then
					break
				elseif matchedCharacter:match(VAILD_IDENTIFIER) then
					table.insert(identifier, matchedCharacter)
					index += 1
				elseif matchedCharacter:match("/") then
					local peek = input:sub(index + 1, index + 1)
					if peek:match("%.") then
						table.insert(identifier, ".")
						index += 2
					elseif peek:match("/") then
						table.insert(identifier, "/")
						index += 2
					else
						table.insert(identifier, "/")
						index += 1
					end
				else
					error(
						"Unexpected character found while parsing an identifier '"
							.. string.format("%q", matchedCharacter)
							.. "'."
					)
				end
			end

			table.insert(tokens, {
				ttype = "Identifier",
				value = table.concat(identifier),
			})
		elseif character:match("%.") then
			table.insert(tokens, {
				ttype = "Seperator",
			})

			index += 1
		end
	end

	return tokens
end

return lexer
