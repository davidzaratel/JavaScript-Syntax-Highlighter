Definitions.
Commentline = //[^\n|\r]*(\n|\n\r|\r\n)
Commentblock = /\*(.|\r\n)*\*/ 
Numint = [0-9]+
Numoct = 0[oO][0-7]*
Numhex = 0[xX][0-9|a-zA-Z]*
Numbin = 0[bB][0-1]*
Space = [\s|\t|\f]
String = "[^"]*" 
Charlist = '[^']*' 
Enter = (\n|\n\r|\r\n)
Dot = [.]
Reserved = await|assign|break|case|catch|class|const|continue|debugger|default|delete|do|else|export|extends|finally|for|function|if|interface|import|implements|in|instanceof|let|new|package|private|protected|public|return|super|static|switch|this|throw|try|typeof|var|void|while|with|yield|log
Identifier = [a-zA-Z\_\$][0-9|a-zA-Z]*
Booleans = true|false|null

Rules.
{Space}                                 : {token,{space,TokenLine,TokenChars}}.
{Enter}                                 : {token,{enter,TokenLine,TokenChars}}.
{Numint}                                : {token, {num, TokenLine, TokenChars}}.
{Numoct}                                : {token, {num, TokenLine, TokenChars}}.
{Numhex}                                : {token, {num, TokenLine, TokenChars}}.
{Numbin}                                : {token, {num, TokenLine, TokenChars}}.
{Commentline}                           : {token,{commentline,TokenLine,TokenChars}}.
{Commentblock}                           : {token,{commentblock,TokenLine,TokenChars}}.
{Reserved}                              : {token,{reserved,TokenLine,TokenChars}}.
{Booleans}                              : {token,{bool,TokenLine,TokenChars}}.
{Identifier}                            : {token,{identifier,TokenLine,TokenChars}}.
{String}                                : {token,{string,TokenLine,TokenChars}}.
{Charlist}                              : {token,{charlist,TokenLine,TokenChars}}.
{Numint}\.{Numint}                      : {token, {float, TokenChars}}.
[\+\-\*\/\;\=\,\.\%\}\{\[\]\#\@\`\~\:]  : {token, {signs, TokenLine, TokenChars}}.
[\(|)\&\>\<\?\!\>\<]                    :  {token, {logical, TokenLine, TokenChars}}.
[\(\)]                                  : {token, {list_to_atom(TokenChars), TokenLine, TokenChars}}.


Erlang code.
