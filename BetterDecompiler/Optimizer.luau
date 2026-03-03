local Optimizer = {}
function Optimizer.Run(source)
    local result = source
    result = result:gsub("if false then.-end", "")
    result = result:gsub("local (%w+) = %1", "")
    return result
end
function Optimizer.RemoveDeadCode(source)
    return source:gsub("if false then.-end", "")
end
function Optimizer.RemoveSelfAssign(source)
    return source:gsub("local (%w+) = %1", "")
end
function Optimizer.RemoveDuplicateLocals(source)
    return source:gsub("local local", "local")
end
function Optimizer.SimplifyEquals(source)
    return source:gsub("= ==", "=")
end
function Optimizer.RemoveEmptyBlocks(source)
    return source:gsub("do%s+end", "")
end
return Optimizer