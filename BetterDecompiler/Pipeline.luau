local Pipeline = {}
local Cleaner = require(script.Parent.Cleaner)
local Analyzer = require(script.Parent.Analyzer)
local Translator = require(script.Parent.Translator)
local Renamer = require(script.Parent.Renamer)
local Optimizer = require(script.Parent.Optimizer)
local Formatter = require(script.Parent.Formatter)
function Pipeline.Run(source)
    local cleaned = Cleaner.Run(source)
    local analysis = Analyzer.Scan(cleaned)
    local translated = Translator.Run(cleaned)
    local renamed = Renamer.Run(translated)
    local optimized = Optimizer.Run(renamed)
    local formatted = Formatter.Run(optimized)
    return formatted, analysis
end
return Pipeline