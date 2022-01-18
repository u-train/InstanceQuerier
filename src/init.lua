local Lexer = require(script.Lexer)
local EscapeFullName = require(script.EscapeFullName)
local SelectInstance = require(script.SelectInstance)

return {
	Select = SelectInstance,
	EscapeFullName = EscapeFullName,
	Lexer = Lexer
}
