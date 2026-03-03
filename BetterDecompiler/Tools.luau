local Tools = {}
function Tools.Install()
    local originalDecompile = decompile
    local originalDecompiler = decompiler
    local function universalDecompile(scriptInstance)
        if typeof(scriptInstance) ~= "Instance" then
            return "-- Invalid script instance"
        end
        local rawSource
        if originalDecompile and type(originalDecompile) == "function" then
            local success, result = pcall(originalDecompile, scriptInstance)
            if success and typeof(result) == "string" then rawSource = result end
        end
        if not rawSource and originalDecompiler and type(originalDecompiler) == "function" then
            local success, result = pcall(originalDecompiler, scriptInstance)
            if success and typeof(result) == "string" then rawSource = result end
        end
        if not rawSource and env and env.decompile then
            local success, result = pcall(env.decompile, scriptInstance)
            if success and typeof(result) == "string" then rawSource = result end
        end
        if not rawSource and getscriptbytecode and type(getscriptbytecode) == "function" then
            local success, bytecode = pcall(getscriptbytecode, scriptInstance)
            if success and typeof(bytecode) == "string" then
                rawSource = "-- Bytecode mode (use Better Decompiler pipeline)"
            end
        end

        if not rawSource then
            rawSource = "-- Decompile failed or not supported by executor"
        end
        local BetterDecompiler = loadstring(readfile("BetterDecompiler/Main.luau"))()
        local resultTable = BetterDecompiler.Run(rawSource)
        return resultTable.code
    end
    decompile = universalDecompile
    decompiler = universalDecompile
    if ScriptViewer and ScriptViewer.ViewScript then
        local originalViewScript = ScriptViewer.ViewScript
        ScriptViewer.ViewScript = function(scr)
            if not scr:GetAttribute("ScriptFake_Dex") then
                local source = universalDecompile(scr)
                originalViewScript(scr)
                if codeFrame and codeFrame.SetText then
                    codeFrame:SetText(source)
                end
            else
                originalViewScript(scr)
            end
        end
    end
    print("Better Decompiler Tools Loaded")
end
return Tools
