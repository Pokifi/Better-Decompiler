local Pipeline = {}
local function loadModule(path)
    local chunk = loadfile(path)
    if not chunk then
        error("Cannot load module: " .. path)
    end
    return chunk()
end
local Cleaner    = loadModule("Cleaner.luau")
local Analyzer   = loadModule("Analyzer.luau")
local Translator = loadModule("Translator.luau")
local Renamer    = loadModule("Renamer.luau")
local Optimizer  = loadModule("Optimizer.luau")
local Formatter  = loadModule("Formatter.luau")
function Pipeline.Run(source)
    if type(source) ~= "string" then
        error("Source must be a string")
    end
    source = Cleaner.Run(source)
    local analysis = Analyzer.Scan(source)
    source = Translator.Run(source)
    source = Renamer.Run(source)
    source = Optimizer.Run(source)
    source = Formatter.Run(source)
    return source, analysis
end
return Pipeline
