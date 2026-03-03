local Translator = {}
function Translator.Run(source)
    local result = source
    result = result:gsub("local function %(", "local function anonymous(")
    result = result:gsub("if true then", "")
    result = result:gsub("end; end", "end")
    result = result:gsub("CALL%s+A:%d+%s+B:%d+%s+C:%d+", "Function call optimized")
    result = result:gsub("GETGLOBAL%s+A:%d+%s+B:%d+", "Global variable load optimized")
    result = result:gsub("SETGLOBAL%s+A:%d+%s+B:%d+", "Global variable store optimized")
    return result
end
function Translator.TranslateCall(source)
    return source:gsub("CALL%s+A:%d+%s+B:%d+%s+C:%d+", "Function call optimized")
end
function Translator.TranslateGetGlobal(source)
    return source:gsub("GETGLOBAL%s+A:%d+%s+B:%d+", "Global variable load optimized")
end
function Translator.TranslateSetGlobal(source)
    return source:gsub("SETGLOBAL%s+A:%d+%s+B:%d+", "Global variable store optimized")
end
function Translator.TranslateLoadK(source)
    return source:gsub("LOADK", "Load constant")
end
function Translator.TranslateReturn(source)
    return source:gsub("RETURN", "Return values")
end
return Translator