Definitions.
Commentline = //[^\n|\r]*(\n|\n\r) 
Numbers = [0-9]
Words = [a-zA-Z][a-zA-Z0-9]*
Space = [\s|\t|\f]
Enter = [\n|\r]
Dot = [.]
Reserved = await|break|case|catch|class|const|continue|debugger|default|delete|do|else|export|extends|finally|for|function|if|interface|import|implements|in|instanceof|let|new|package|private|protected|public|return|super|static|switch|this|throw|try|typeof|var|void|while|with|yield|log
Identifier = [a-zA-Z\_\$][0-9]*[a-zA-Z]*

Rules.
{Space}             : {token,{space,TokenLine,TokenChars}}.
{Enter}               : {token,{enter,TokenLine,TokenChars}}.
{Numbers}+          : {token, {int, TokenLine, list_to_integer(TokenChars)}}.
//[^\n|\r]*(\n|\n\r)        : {token,{commentline,TokenLine,TokenChars}}.
{Reserved}          : {token,{reserved,TokenLine,TokenChars}}.
{Identifier}        : {token,{identifier,TokenLine,TokenChars}}.
[\+\-\*\/\;\=\,\.]  : {token, {signs, TokenLine, TokenChars}}.
[\(\)]              : {token, {list_to_atom(TokenChars), TokenLine, TokenChars}}.

Erlang code.
