local Formatter = {}
local Utils = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pokifi/Better-Decompiler/refs/heads/main/BetterDecompiler/Utils.luau"))()
function Formatter.Run(source)
    local lines = Utils.SplitLines(source)
    local indent = 0
    for i = 1, #lines do
        local line = Utils.Trim(lines[i])
        if line:match("^end") then
            indent = indent - 1
        end
        lines[i] = string.rep("    ", indent) .. line
        if line:match("then$") or line:match("do$") or line:match("function") then
            indent = indent + 1
        end
    end
    return Utils.JoinLines(lines)
end
function Formatter.AddSpacing(source)
    return source:gsub("\n", "\n\n")
end
function Formatter.AddBlankAfterEnd(source)
    return source:gsub("end\n", "end\n\n")
end
function Formatter.AddBlankBeforeFunction(source)
    return source:gsub("function%s+%w+%s*%(", "\nfunction %1(")
end
function Formatter.AddBlankBeforeReturn(source)
    return source:gsub("return%s+", "\nreturn ")
end
function Formatter.AddBlankBeforeIf(source)
    return source:gsub("if%s+", "\nif ")
end
function Formatter.AddBlankBeforeFor(source)
    return source:gsub("for%s+", "\nfor ")
end
function Formatter.AddBlankBeforeWhile(source)
    return source:gsub("while%s+", "\nwhile ")
end
function Formatter.AddBlankBeforeRepeat(source)
    return source:gsub("repeat%s+", "\nrepeat ")
end
function Formatter.AddBlankBeforeLocal(source)
    return source:gsub("local%s+%w+%s*=", "\nlocal %1 =")
end

return Formatter
