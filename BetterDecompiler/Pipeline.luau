local Pipeline = {}
local Utils = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pokifi/Better-Decompiler/refs/heads/main/BetterDecompiler/Utils.luau"))()
local Cleaner = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pokifi/Better-Decompiler/refs/heads/main/BetterDecompiler/Cleaner.luau"))()
local Analyzer = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pokifi/Better-Decompiler/refs/heads/main/BetterDecompiler/Analyzer.luau"))()
local Translator = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pokifi/Better-Decompiler/refs/heads/main/BetterDecompiler/Translator.luau"))()
local Renamer = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pokifi/Better-Decompiler/refs/heads/main/BetterDecompiler/Renamer.luau"))()
local Optimizer = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pokifi/Better-Decompiler/refs/heads/main/BetterDecompiler/Optimizer.luau"))()
local Formatter = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pokifi/Better-Decompiler/refs/heads/main/BetterDecompiler/Formatter.luau"))()
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
