--!strict
local lexer = require(script.lexer)
local escapeFullName = require(script.escapeFullName)
local selectInstance = require(script.selectInstance)

return {
	select = selectInstance,
	escapeFullName = escapeFullName,
	lexer = lexer
}
