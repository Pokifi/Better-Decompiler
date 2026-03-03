local Renamer = {}
function Renamer.Run(source)
    local counter = 0
    local map = {}
    local result = source:gsub("v(%d+)", function(id)
        if not map[id] then
            counter = counter + 1
            map[id] = "var_" .. counter
        end
        return map[id]
    end)
    return result
end
function Renamer.RenameTempVars(source)
    local counter = 0
    local map = {}
    local result = source:gsub("v(%d+)", function(id)
        if not map[id] then
            counter = counter + 1
            map[id] = "temporaryVariable_" .. counter
        end
        return map[id]
    end)
    return result
end
function Renamer.RenameUpvalues(source)
    local counter = 0
    local map = {}
    local result = source:gsub("upvalue(%d+)", function(id)
        if not map[id] then
            counter = counter + 1
            map[id] = "upvalueCache_" .. counter
        end
        return map[id]
    end)
    return result
end
function Renamer.RenameParams(source)
    local counter = 0
    local map = {}
    local result = source:gsub("p(%d+)", function(id)
        if not map[id] then
            counter = counter + 1
            map[id] = "argumentParam_" .. counter
        end
        return map[id]
    end)
    return result
end
function Renamer.RenameModuleClass(source)
    local result = source:gsub("ModuleClass", "AdvancedScriptModule")
    return result
end
return Renamer