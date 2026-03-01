local PlayersService = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local localPlayer = PlayersService.LocalPlayer
local hasDecompile = type(decompile) == "function"
local oldDecompile = hasDecompile and decompile or function() return "-- No decompiler available" end
local hasGetBytecode = type(getscriptbytecode) == "function"
local getBytecode = hasGetBytecode and getscriptbytecode or function() return "-- Bytecode mode not supported" end

local gui = Instance.new("ScreenGui")
gui.Name = "BetterDecompiler"
gui.ResetOnSpawn = false
gui.Parent = localPlayer:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(720, 620)
main.Position = UDim2.fromScale(0.5, 0.5)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = Color3.fromRGB(18, 20, 28)
main.BackgroundTransparency = 0.08
main.BorderSizePixel = 0
main.Parent = gui
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 22)
mainCorner.Parent = main
local mainStroke = Instance.new("UIStroke")
mainStroke.Thickness = 1.8
mainStroke.Color = Color3.fromRGB(0, 255, 170)
mainStroke.Transparency = 0.25
mainStroke.Parent = main
local mainGradient = Instance.new("UIGradient")
mainGradient.Color = ColorSequence.new(Color3.fromRGB(0, 255, 170), Color3.fromRGB(0, 180, 100))
mainGradient.Transparency = NumberSequence.new(0.25, 0.55)
mainGradient.Parent = mainStroke

local top = Instance.new("Frame")
top.Size = UDim2.new(1, 0, 0, 58)
top.BackgroundTransparency = 1
top.Parent = main

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -80, 1, 0)
title.Position = UDim2.new(0, 22, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Better Decompiler"
title.Font = Enum.Font.GothamBlack
title.TextScaled = true
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextColor3 = Color3.fromRGB(0, 255, 190)
title.Parent = top

local close = Instance.new("TextButton")
close.Size = UDim2.fromOffset(48, 48)
close.Position = UDim2.new(1, -58, 0.5, -24)
close.BackgroundTransparency = 1
close.Text = "X"
close.Font = Enum.Font.GothamBlack
close.TextScaled = true
close.TextColor3 = Color3.fromRGB(255, 90, 90)
close.Parent = top
local closeStroke = Instance.new("UIStroke")
closeStroke.Thickness = 1.1
closeStroke.Color = Color3.fromRGB(255, 90, 90)
closeStroke.Transparency = 0.45
closeStroke.Parent = close

local content = Instance.new("Frame")
content.Size = UDim2.new(1, -40, 1, -135)
content.Position = UDim2.new(0, 20, 0, 72)
content.BackgroundColor3 = Color3.fromRGB(24, 26, 36)
content.BackgroundTransparency = 0.18
content.BorderSizePixel = 0
content.Parent = main
local contentCorner = Instance.new("UICorner")
contentCorner.CornerRadius = UDim.new(0, 16)
contentCorner.Parent = content
local contentStroke = Instance.new("UIStroke")
contentStroke.Thickness = 1.1
contentStroke.Color = Color3.fromRGB(0, 255, 200)
contentStroke.Transparency = 0.45
contentStroke.Parent = content
local contentPadding = Instance.new("UIPadding")
contentPadding.PaddingTop = UDim.new(0, 12)
contentPadding.PaddingBottom = UDim.new(0, 12)
contentPadding.PaddingLeft = UDim.new(0, 12)
contentPadding.PaddingRight = UDim.new(0, 12)
contentPadding.Parent = content
local contentLayout = Instance.new("UIListLayout")
contentLayout.FillDirection = Enum.FillDirection.Vertical
contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
contentLayout.Padding = UDim.new(0, 8)
contentLayout.Parent = content

local pathLabel = Instance.new("TextLabel")
pathLabel.Size = UDim2.new(1, 0, 0, 22)
pathLabel.BackgroundTransparency = 1
pathLabel.Text = "Path:"
pathLabel.TextColor3 = Color3.fromRGB(180, 180, 255)
pathLabel.Font = Enum.Font.Gotham
pathLabel.TextSize = 15
pathLabel.Parent = content

local pathBox = Instance.new("TextBox")
pathBox.Size = UDim2.new(1, 0, 0, 40)
pathBox.PlaceholderText = "game:GetService(\"Players\").LocalPlayer.PlayerScripts.PlayerModule"
pathBox.BackgroundColor3 = Color3.fromRGB(16, 18, 24)
pathBox.BackgroundTransparency = 0.12
pathBox.TextColor3 = Color3.fromRGB(255, 255, 255)
pathBox.Font = Enum.Font.Gotham
pathBox.TextSize = 16
pathBox.ClearTextOnFocus = false
pathBox.Parent = content
local pathCorner = Instance.new("UICorner")
pathCorner.CornerRadius = UDim.new(0, 11)
pathCorner.Parent = pathBox

local buttonsFrame = Instance.new("Frame")
buttonsFrame.Size = UDim2.new(1, 0, 0, 44)
buttonsFrame.BackgroundTransparency = 1
buttonsFrame.Parent = content
local buttonsLayout = Instance.new("UIGridLayout")
buttonsLayout.CellSize = UDim2.new(0.3, 0, 1, 0)
buttonsLayout.CellPadding = UDim2.new(0, 12, 0, 0)
buttonsLayout.FillDirection = Enum.FillDirection.Horizontal
buttonsLayout.SortOrder = Enum.SortOrder.LayoutOrder
buttonsLayout.Parent = buttonsFrame

local bytecodeToggle = Instance.new("TextButton")
bytecodeToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
bytecodeToggle.Text = "Bytecode Mode: OFF"
bytecodeToggle.TextColor3 = Color3.fromRGB(200, 200, 255)
bytecodeToggle.Font = Enum.Font.Gotham
bytecodeToggle.TextSize = 14
bytecodeToggle.Parent = buttonsFrame
local bytecodeCorner = Instance.new("UICorner")
bytecodeCorner.CornerRadius = UDim.new(0, 11)
bytecodeCorner.Parent = bytecodeToggle
local isByteMode = false
bytecodeToggle.MouseButton1Click:Connect(function()
    isByteMode = not isByteMode
    bytecodeToggle.Text = "Bytecode Mode: " .. (isByteMode and "ON" or "OFF")
    bytecodeToggle.BackgroundColor3 = isByteMode and Color3.fromRGB(0, 180, 100) or Color3.fromRGB(40, 40, 55)
end)

local decompileButton = Instance.new("TextButton")
decompileButton.BackgroundColor3 = Color3.fromRGB(0, 180, 100)
decompileButton.Text = "DECOMPILE"
decompileButton.TextColor3 = Color3.new(1, 1, 1)
decompileButton.Font = Enum.Font.GothamBold
decompileButton.TextSize = 18
decompileButton.Parent = buttonsFrame
local decompileCorner = Instance.new("UICorner")
decompileCorner.CornerRadius = UDim.new(0, 11)
decompileCorner.Parent = decompileButton

local analyzeButton = Instance.new("TextButton")
analyzeButton.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
analyzeButton.Text = "ANALYZE"
analyzeButton.TextColor3 = Color3.new(1, 1, 1)
analyzeButton.Font = Enum.Font.GothamBold
analyzeButton.TextSize = 18
analyzeButton.Parent = buttonsFrame
local analyzeCorner = Instance.new("UICorner")
analyzeCorner.CornerRadius = UDim.new(0, 11)
analyzeCorner.Parent = analyzeButton

local outputLabel = Instance.new("TextLabel")
outputLabel.Size = UDim2.new(1, 0, 0, 22)
outputLabel.BackgroundTransparency = 1
outputLabel.Text = "Output:"
outputLabel.TextColor3 = Color3.fromRGB(180, 180, 255)
outputLabel.Font = Enum.Font.Gotham
outputLabel.TextSize = 15
outputLabel.Parent = content

local outputScroll = Instance.new("ScrollingFrame")
outputScroll.Size = UDim2.new(1, 0, 1, -205)
outputScroll.BackgroundColor3 = Color3.fromRGB(16, 18, 24)
outputScroll.BackgroundTransparency = 0.12
outputScroll.ScrollBarThickness = 9
outputScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
outputScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
outputScroll.Parent = content
local outputScrollCorner = Instance.new("UICorner")
outputScrollCorner.CornerRadius = UDim.new(0, 13)
outputScrollCorner.Parent = outputScroll

local outputText = Instance.new("TextLabel")
outputText.Size = UDim2.new(1, -12, 0, 0)
outputText.AutomaticSize = Enum.AutomaticSize.Y
outputText.BackgroundTransparency = 1
outputText.TextWrapped = true
outputText.TextXAlignment = Enum.TextXAlignment.Left
outputText.TextYAlignment = Enum.TextYAlignment.Top
outputText.Font = Enum.Font.Code
outputText.TextSize = 15
outputText.TextColor3 = Color3.fromRGB(200, 240, 255)
outputText.Text = "-- Output here"
outputText.Parent = outputScroll

local copyButton = Instance.new("TextButton")
copyButton.Size = UDim2.new(0.22, 0, 0, 38)
copyButton.Position = UDim2.new(0.78, 0, 1, 8)
copyButton.BackgroundColor3 = Color3.fromRGB(100, 100, 255)
copyButton.Text = "COPY TO CLIPBOARD"
copyButton.TextColor3 = Color3.new(1, 1, 1)
copyButton.Font = Enum.Font.GothamBold
copyButton.TextSize = 15
copyButton.Parent = content
local copyCorner = Instance.new("UICorner")
copyCorner.CornerRadius = UDim.new(0, 9)
copyCorner.Parent = copyButton

local initialSize = UDim2.fromOffset(0, 0)
main.Size = initialSize
local animationInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
local targetSize = {Size = UDim2.fromOffset(720, 620)}
TweenService:Create(main, animationInfo, targetSize):Play()

close.MouseButton1Click:Connect(function()
    local closeInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
    local closeTarget = {Size = UDim2.fromOffset(0, 0)}
    TweenService:Create(main, closeInfo, closeTarget):Play()
    task.wait(0.25)
    gui:Destroy()
end)

local dragging = false
local dragStart = nil
local startPos = nil
top.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = main.Position
    end
end)
top.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

local function resolvePath(path)
    if typeof(path) ~= "string" or path == "" then return nil end
    local s, f = pcall(loadstring, "return " .. path)
    if s then
        local ok, r = pcall(f)
        if ok and typeof(r) == "Instance" then return r end
    end
    local parts = string.split(path:gsub("^game%.", ""), "%.")
    local cur = game
    for _, part in parts do
        if part == "" then continue end
        local child = cur:FindFirstChild(part) or cur:FindFirstChild(part, true)
        if not child then return nil end
        cur = child
    end
    return cur
end

local function countLines(str)
    return #str:gsub("[^\n]", "") + 1
end

local function cleanStep1(code)
    return code:gsub("%s*%-%-[^\n]*\n?", "\n")
end

local function cleanStep2(code)
    return code:gsub("debug%.%w+%s*%b()", ""):gsub("debug%s*:%s*%w+%s*%b()", "")
end

local function cleanStep3(code)
    return code:gsub("pcall%s*%b()", "")
end

local function cleanStep4(code)
    return code:gsub("xpcall%s*%b()", "")
end

local function cleanStep5(code)
    return code:gsub("[^\n]*__index%s*=%s*function%b()%s*end[^\n]*\n?", "")
end

local function cleanStep6(code)
    return code:gsub("warn%s*%b()", "")
end

local function cleanStep7(code)
    return code:gsub("print%s*%b()", "")
end

local function cleanStep8(code)
    return code:gsub("assert%s*%b()", "")
end

local function cleanStep9(code)
    return code:gsub("error%s*%b()", "")
end

local function cleanStep10(code)
    return code:gsub("^%s*\n", ""):gsub("[%s\n]+$", "\n")
end

local function cleanStep11(code)
    return code:gsub("require%s*%b()", "")
end

local function cleanStep12(code)
    return code:gsub("task%.spawn%s*%b()", "")
end

local function cleanStep13(code)
    return code:gsub("task%.delay%s*%b()", "")
end

local function cleanStep14(code)
    return code:gsub("spawn%s*%b()", "")
end

local function cleanStep15(code)
    return code:gsub("wait%s*%b()", "")
end

local function cleanStep16(code)
    return code:gsub("getmetatable%s*%b()", "")
end

local function cleanStep17(code)
    return code:gsub("setmetatable%s*%b()", "setmetatable({}, {})")
end

local function cleanStep18(code)
    return code:gsub("rawset%s*%b()", "")
end

local function cleanStep19(code)
    return code:gsub("rawget%s*%b()", "")
end

local function cleanStep20(code)
    return code:gsub("loadstring%s*%b()", "")
end

local function cleanStep21(code)
    return code:gsub("hookfunction%s*%b()", "")
end

local function cleanStep22(code)
    return code:gsub("hookmetamethod%s*%b()", "")
end

local function cleanStep23(code)
    return code:gsub("[\128-\255]", function(c) return string.format("0x%02X", string.byte(c)) end)
end

local function cleanStep24(code)
    return code:gsub("string%.char%s*%b()", "")
end

local function cleanStep25(code)
    return code:gsub("bit32%.%w+%s*%b()", "")
end

local function cleanStep26(code)
    return code:gsub("local%s+%w+%s*:%s*%w+", function(m) return m:gsub(":%s*%w+", "") end)
end

local function cleanStep27(code)
    return code:gsub(":%s*%w+%s*=", "=")
end

local function cleanStep28(code)
    return code:gsub("for%s+%w+%s*:%s*%w+", function(m) return m:gsub(":%s*%w+", "") end)
end

local function cleanStep29(code)
    return code:gsub("bit32%.bxor%s*%b()", "")
end

local function cleanStep30(code)
    return code:gsub("if%s+not%s+%w+%s+then", "")
end

local function cleanStep31(code)
    return code:gsub("local%s+%w+%s*<%s*%w+>", function(m) return m:gsub("<%s*%w+>", "") end)
end

local function cleanStep32(code)
    return code:gsub("Enum%.%w+%.%w+", "0")
end

local function cleanStep33(code)
    return code:gsub("repeat%s+until%s+true", "")
end

local function cleanStep34(code)
    return code:gsub("self%s*=%s*self", "")
end

local function cleanStep35(code)
    return code:gsub("\0", "")
end

local function cleanStep36(code)
    return code:gsub("string%.byte%s*%b()", "")
end

local function cleanStep37(code)
    return code:gsub("math%.random%s*%b()", "0")
end

local function cleanStep38(code)
    return code:gsub("os%.time%s*%b()", "0")
end

local function cleanStep39(code)
    return code:gsub("table%.concat%s*%b()", "{}")
end

local function cleanStep40(code)
    return code:gsub("for%s+i%s*=%s*1%s*,%s*#%w+%s*do", "for i = 1, 1 do")
end

local function cleanStep41(code)
    return code:gsub("nil%s*=%s*nil", "")
end

local function cleanStep42(code)
    return code:gsub("= nil%s*;", "=")
end

local function cleanStep43(code)
    return code:gsub("local%s+(%w+)%s*=%s*nil", "local %1 = nil")
end

local function cleanStep44(code)
    return code:gsub("nil%s*==%s*nil", "true")
end

local function cleanStep45(code)
    return code:gsub("if%s+nil%s+then", "")
end

local function cleanStep46(code)
    return code:gsub("hookfunction%s*%b()", "")
end

local function cleanStep47(code)
    return code:gsub("hookmetamethod%s*%b()", "")
end

local function cleanStep48(code)
    return code:gsub("loadstring%s*%b()", "")
end

local function cleanStep49(code)
    return code:gsub("metatable%s*=%s*metatable", "")
end

local function cleanStep50(code)
    return code:gsub("nil%s*==%s*nil", "true")
end

local function optimizeStep1(code)
    local map = {["game%.Players%.LocalPlayer"] = "LocalPlayer", ["game%.Workspace"] = "Workspace", ["game%.ReplicatedStorage"] = "ReplicatedStorage", ["game%.Lighting"] = "Lighting", ["game%.ServerStorage"] = "ServerStorage", ["game%.ServerScriptService"] = "ServerScriptService", ["game%.StarterGui"] = "StarterGui", ["CFrame%.new"] = "NewCFrame", ["Vector3%.new"] = "NewVector3", ["Instance%.new"] = "NewInstance", ["game%:GetService"] = "GetService"}
    for p, r in pairs(map) do code = code:gsub(p, r) end
    return code
end

local function renameStep1(code)
    local map = {}
    local counter = 0
    local names = {"playersServiceReference", "workspaceHandlerCache", "replicatedStorageLoader", "lightingControllerManager", "serverStorageDataHandler", "serverScriptServiceExecutor", "starterGuiInterfaceLoader", "cameraPositionFrame", "movementVector3Cache", "newInstanceCreator", "requiredModuleLoader", "nullValuePlaceholder", "contextVariableHandler", "metatableIndexChain", "dynamicLoadstringExecutor", "hookfunctionWrapper", "hookmetamethodHandler"}
    local function gen()
        counter = counter + 1
        return names[((counter - 1) % #names) + 1] .. "_" .. counter
    end
    code = code:gsub("local%s+v(%d+)%f[^%w_]", function(n)
        local key = "v" .. n
        map[key] = map[key] or gen()
        return "local " .. map[key]
    end)
    code = code:gsub("%f[%w_]v(%d+)%f[^%w_]", function(n)
        return map["v" .. n] or "v" .. n
    end)
    return code
end

local function renameClassPatterns(code)
    code = code:gsub("local%s+v_u_(%d+)%f[^%w_]", "local ModuleClass_%1")
    code = code:gsub("%f[%w_]v_u_(%d+)%f[^%w_]", "ModuleClass_%1")
    code = code:gsub("function%s+ModuleClass_(%d+)%.(%w+)%(([^)]*)%)", function(id, m, a)
        a = a:gsub("^p%d+%s*,?%s*", "")
        return a == "" and "function ModuleClass_" .. id .. "." .. m .. "(self)" or "function ModuleClass_" .. id .. "." .. m .. "(self, " .. a .. ")"
    end)
    code = code:gsub("__index%s*=%s*(%w+)", "__index = %1")
    code = code:gsub("setmetatable%s*%(%s*{},%s*(%w+)", "setmetatable({}, %1)")
    return code
end

local function indentStep1(code)
    local lines = {}
    local indent = 0
    for line in code:gmatch("[^\r\n]+") do
        local t = line:gsub("^%s+", "")
        if t:match("^end%f[%W]") or t:match("^until%f[%W]") then indent = math.max(indent - 1, 0) end
        if t:match("^elseif%f[%W]") or t:match("^else%f[%W]") then indent = math.max(indent - 1, 0) end
        table.insert(lines, ("    "):rep(indent) .. t)
        if t:match("^if%s") or t:match("^for%s") or t:match("^while%s") or t:match("^repeat%f[%W]") or t:match("^function%f[%W]") or t:match("^local%s+function") then indent = indent + 1 end
    end
    return table.concat(lines, "\n")
end

local function extraCleanA(code)
    return code:gsub("%f[%w_](%w+)%f[^%w_]%s*=%s*function", "local %1 = function")
end

local function extraCleanB(code)
    return code:gsub("(%w+)%s*:%s*function", "%1 = function")
end

local function extraCleanC(code)
    return code:gsub("return%s+function", "return function")
end

local function extraCleanD(code)
    return code:gsub("%f[%w_](%w+)%f[^%w_]%s*=%s*{}", "%1 = {}")
end

local function extraCleanE(code)
    return code:gsub("local%s+(%w+)%s*=%s*Instance%.new", "local %1 = NewInstance")
end

local function extraCleanF(code)
    return code:gsub("%f[%w_]game:GetService%f[^%w_]", "game:GetService")
end

local function extraCleanG(code)
    return code:gsub("%-%-%[%[.-%]%]", "")
end

local function extraCleanH(code)
    return code:gsub(";%s*\n", "\n")
end

local function extraCleanI(code)
    return code:gsub("%s*=%s*nil", " = nil")
end

local function extraCleanJ(code)
    return code:gsub("if%s+true%s+then", "do")
end

local function analyzeCode(code)
    local funcs = 0
    for _ in code:gmatch("function") do funcs = funcs + 1 end
    local vars = 0
    for _ in code:gmatch("local%s+%w+") do vars = vars + 1 end
    local loops = 0
    for _ in code:gmatch("for") do loops = loops + 1 end
    for _ in code:gmatch("while") do loops = loops + 1 end
    for _ in code:gmatch("repeat") do loops = loops + 1 end
    return "-- Analysis:\n-- Functions: " .. funcs .. "\n-- Variables: " .. vars .. "\n-- Loops: " .. loops .. "\n\n"
end

local function disassembleBytecode(bytecode)
    local opcodes = {"MOVE", "LOADK", "LOADBOOL", "LOADNIL", "GETUPVAL", "GETGLOBAL", "GETTABLE", "SETGLOBAL", "SETUPVAL", "SETTABLE", "NEWTABLE", "SELF", "ADD", "SUB", "MUL", "DIV", "MOD", "POW", "UNM", "NOT", "LEN", "CONCAT", "JMP", "EQ", "LT", "LE", "TEST", "TESTSET", "CALL", "TAILCALL", "RETURN", "FORLOOP", "FORPREP", "TFORLOOP", "SETLIST", "CLOSE", "CLOSURE", "VARARG"}
    local result = ""
    local i = 1
    local len = #bytecode
    while i <= len do
        local opcodeByte = string.byte(bytecode, i) or 0
        local opcode = opcodeByte % 64
        local opName = opcodes[opcode + 1] or "UNKNOWN"
        local a = math.floor(opcodeByte / 64) or 0
        local b = string.byte(bytecode, i+1) or 0
        local c = string.byte(bytecode, i+2) or 0
        local d = string.byte(bytecode, i+3) or 0
        result = result .. opName .. " A:" .. tostring(a) .. " B:" .. tostring(b) .. " C:" .. tostring(c) .. " D:" .. tostring(d) .. "\n"
        i = i + 4
    end
    return result
end

local function detectObfuscation(code)
    local hasRandomVars = code:find("v%d+") or code:find("arg%d+")
    local hasEncodedStrings = code:find("string%.char") or code:find("gsub")
    local hasJunk = code:find("if not") or code:find("repeat until true")
    local hasBitwise = code:find("bit32%.bxor")
    local hasLoadstring = code:find("loadstring")
    local hasMetatable = code:find("__index") or code:find("setmetatable")
    local hasHookfunction = code:find("hookfunction")
    local isObfuscated = hasRandomVars or hasEncodedStrings or hasJunk or hasBitwise or hasLoadstring or hasMetatable or hasHookfunction
    return isObfuscated
end

local function deobfuscate(code)
    code = code:gsub("string%.char%s*%((%d+)%)", function(c) return string.char(tonumber(c)) end)
    code = code:gsub("bit32%.bxor%s*%(%s*(%-?%d+)%s*,%s*(%-?%d+)%s*%)", function(a, b) return tostring(bit32.bxor(tonumber(a), tonumber(b))) end)
    code = code:gsub("if not (%w+) then", "")
    code = code:gsub("hookfunction%s*%b()", "")
    return code
end

local function smartRename(code)
    code = code:gsub("v(%d+)", function(n)
        if code:find("game%.Players") then return "playersServiceReference_" .. n end
        if code:find("CFrame") then return "cameraPositionFrame_" .. n end
        if code:find("Vector3") then return "movementVector3Cache_" .. n end
        if code:find("Instance%.new") then return "newInstanceCreator_" .. n end
        if code:find("require") then return "requiredModuleLoader_" .. n end
        if code:find("loadstring") then return "dynamicLoadstringExecutor_" .. n end
        if code:find("nil") then return "nullValuePlaceholder_" .. n end
        if code:find("__index") then return "metatableIndexChain_" .. n end
        if code:find("hookfunction") then return "hookfunctionWrapper_" .. n end
        return "contextVariableHandler_" .. n
    end)
    return code
end

decompileButton.MouseButton1Click:Connect(function()
    local obj = resolvePath(pathBox.Text)
    if not obj then outputText.Text = "-- Invalid Path!" return end
    outputText.Text = "-- Processing..."
    local raw = isByteMode and getBytecode(obj) or oldDecompile(obj)
    if typeof(raw) ~= "string" then outputText.Text = "-- Failed!" return end
    local isObf = detectObfuscation(raw)
    if isObf then raw = deobfuscate(raw) end
    if isByteMode then raw = disassembleBytecode(raw) end
    local s1 = cleanStep1(raw)
    local s2 = cleanStep2(s1)
    local s3 = cleanStep3(s2)
    local s4 = cleanStep4(s3)
    local s5 = cleanStep5(s4)
    local s6 = cleanStep6(s5)
    local s7 = cleanStep7(s6)
    local s8 = cleanStep8(s7)
    local s9 = cleanStep9(s8)
    local s10 = cleanStep10(s9)
    local s11 = cleanStep11(s10)
    local s12 = cleanStep12(s11)
    local s13 = cleanStep13(s12)
    local s14 = cleanStep14(s13)
    local s15 = cleanStep15(s14)
    local s16 = cleanStep16(s15)
    local s17 = cleanStep17(s16)
    local s18 = cleanStep18(s17)
    local s19 = cleanStep19(s18)
    local s20 = cleanStep20(s19)
    local s21 = cleanStep21(s20)
    local s22 = cleanStep22(s21)
    local s23 = cleanStep23(s22)
    local s24 = cleanStep24(s23)
    local s25 = cleanStep25(s24)
    local s26 = cleanStep26(s25)
    local s27 = cleanStep27(s26)
    local s28 = cleanStep28(s27)
    local s29 = cleanStep29(s28)
    local s30 = cleanStep30(s29)
    local s31 = cleanStep31(s30)
    local s32 = cleanStep32(s31)
    local s33 = cleanStep33(s32)
    local s34 = cleanStep34(s33)
    local s35 = cleanStep35(s34)
    local s36 = cleanStep36(s35)
    local s37 = cleanStep37(s36)
    local s38 = cleanStep38(s37)
    local s39 = cleanStep39(s38)
    local s40 = cleanStep40(s39)
    local s41 = cleanStep41(s40)
    local s42 = cleanStep42(s41)
    local s43 = cleanStep43(s42)
    local s44 = cleanStep44(s43)
    local s45 = cleanStep45(s44)
    local s46 = cleanStep46(s45)
    local s47 = cleanStep47(s46)
    local s48 = cleanStep48(s47)
    local s49 = cleanStep49(s48)
    local s50 = cleanStep50(s49)
    local o1 = optimizeStep1(s50)
    local r1 = renameStep1(o1)
    local sr = smartRename(r1)
    local rc = renameClassPatterns(sr)
    local ea = extraCleanA(rc)
    local eb = extraCleanB(ea)
    local ec = extraCleanC(eb)
    local ed = extraCleanD(ec)
    local ee = extraCleanE(ed)
    local ef = extraCleanF(ee)
    local eg = extraCleanG(ef)
    local eh = extraCleanH(eg)
    local ei = extraCleanI(eh)
    local ej = extraCleanJ(ei)
    local ind = indentStep1(ej)
    local header = "--[[ Better Decompiler v4.8 ]]\n\n"
    local final = header .. ind
    setclipboard(final)
    outputText.Text = final
end)

analyzeButton.MouseButton1Click:Connect(function()
    local curr = outputText.Text
    if curr == "-- Output here" or curr == "-- Processing..." then return end
    local ana = analyzeCode(curr)
    outputText.Text = ana .. curr
end)

copyButton.MouseButton1Click:Connect(function()
    setclipboard(outputText.Text)
end)

print("Better Decompiler v0.1 loaded")
