local PlayersService = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local localPlayer = PlayersService.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "BetterDecompilerMain"
gui.ResetOnSpawn = false
gui.Parent = localPlayer:WaitForChild("PlayerGui")
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.fromOffset(820, 720)
mainFrame.Position = UDim2.fromScale(0.5, 0.5)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(14, 16, 24)
mainFrame.BackgroundTransparency = 0.04
mainFrame.BorderSizePixel = 0
mainFrame.Parent = gui
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 26)
mainCorner.Parent = mainFrame
local mainStroke = Instance.new("UIStroke")
mainStroke.Thickness = 2.2
mainStroke.Color = Color3.fromRGB(0, 255, 175)
mainStroke.Transparency = 0.18
mainStroke.Parent = mainFrame
local mainGradient = Instance.new("UIGradient")
mainGradient.Color = ColorSequence.new(Color3.fromRGB(0, 255, 175), Color3.fromRGB(0, 155, 95))
mainGradient.Transparency = NumberSequence.new(0.18, 0.48)
mainGradient.Parent = mainStroke
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 66)
titleBar.BackgroundTransparency = 1
titleBar.Parent = mainFrame
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -100, 1, 0)
titleLabel.Position = UDim2.new(0, 26, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Better Decompiler"
titleLabel.Font = Enum.Font.GothamBlack
titleLabel.TextScaled = true
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.TextColor3 = Color3.fromRGB(0, 255, 185)
titleLabel.Parent = titleBar
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.fromOffset(54, 54)
closeButton.Position = UDim2.new(1, -70, 0.5, -27)
closeButton.BackgroundTransparency = 1
closeButton.Text = "X"
closeButton.Font = Enum.Font.GothamBlack
closeButton.TextScaled = true
closeButton.TextColor3 = Color3.fromRGB(255, 75, 75)
closeButton.Parent = titleBar
local closeStroke = Instance.new("UIStroke")
closeStroke.Thickness = 1.4
closeStroke.Color = Color3.fromRGB(255, 75, 75)
closeStroke.Transparency = 0.38
closeStroke.Parent = closeButton
local contentArea = Instance.new("Frame")
contentArea.Size = UDim2.new(1, -48, 1, -160)
contentArea.Position = UDim2.new(0, 24, 0, 82)
contentArea.BackgroundColor3 = Color3.fromRGB(20, 22, 32)
contentArea.BackgroundTransparency = 0.12
contentArea.BorderSizePixel = 0
contentArea.Parent = mainFrame
local contentCorner = Instance.new("UICorner")
contentCorner.CornerRadius = UDim.new(0, 20)
contentCorner.Parent = contentArea
local contentStroke = Instance.new("UIStroke")
contentStroke.Thickness = 1.4
contentStroke.Color = Color3.fromRGB(0, 255, 185)
contentStroke.Transparency = 0.32
contentStroke.Parent = contentArea
local contentPadding = Instance.new("UIPadding")
contentPadding.PaddingTop = UDim.new(0, 16)
contentPadding.PaddingBottom = UDim.new(0, 16)
contentPadding.PaddingLeft = UDim.new(0, 16)
contentPadding.PaddingRight = UDim.new(0, 16)
contentPadding.Parent = contentArea
local contentListLayout = Instance.new("UIListLayout")
contentListLayout.FillDirection = Enum.FillDirection.Vertical
contentListLayout.SortOrder = Enum.SortOrder.LayoutOrder
contentListLayout.Padding = UDim.new(0, 12)
contentListLayout.Parent = contentArea
local pathLabel = Instance.new("TextLabel")
pathLabel.Size = UDim2.new(1, 0, 0, 26)
pathLabel.BackgroundTransparency = 1
pathLabel.Text = "Script Path:"
pathLabel.TextColor3 = Color3.fromRGB(165, 165, 255)
pathLabel.Font = Enum.Font.Gotham
pathLabel.TextSize = 17
pathLabel.Parent = contentArea
local pathInput = Instance.new("TextBox")
pathInput.Size = UDim2.new(1, 0, 0, 46)
pathInput.BackgroundColor3 = Color3.fromRGB(12, 14, 20)
pathInput.BackgroundTransparency = 0.08
pathInput.TextColor3 = Color3.fromRGB(255, 255, 255)
pathInput.Font = Enum.Font.Gotham
pathInput.TextSize = 18
pathInput.PlaceholderText = "game:GetService(\"Players\").LocalPlayer.PlayerScripts.PlayerModule"
pathInput.ClearTextOnFocus = false
pathInput.Parent = contentArea
local pathInputCorner = Instance.new("UICorner")
pathInputCorner.CornerRadius = UDim.new(0, 13)
pathInputCorner.Parent = pathInput
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 0, 24)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "-- Ready"
statusLabel.TextColor3 = Color3.fromRGB(135, 255, 135)
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 16
statusLabel.Parent = contentArea
local buttonsRow = Instance.new("Frame")
buttonsRow.Size = UDim2.new(1, 0, 0, 50)
buttonsRow.BackgroundTransparency = 1
buttonsRow.Parent = contentArea
local buttonsGrid = Instance.new("UIGridLayout")
buttonsGrid.CellSize = UDim2.new(0.32, 0, 1, 0)
buttonsGrid.CellPadding = UDim2.new(0, 16, 0, 0)
buttonsGrid.FillDirection = Enum.FillDirection.Horizontal
buttonsGrid.SortOrder = Enum.SortOrder.LayoutOrder
buttonsGrid.Parent = buttonsRow
local byteToggle = Instance.new("TextButton")
byteToggle.BackgroundColor3 = Color3.fromRGB(36, 36, 50)
byteToggle.Text = "Bytecode Mode: OFF"
byteToggle.TextColor3 = Color3.fromRGB(185, 185, 255)
byteToggle.Font = Enum.Font.Gotham
byteToggle.TextSize = 16
byteToggle.Parent = buttonsRow
local byteCorner = Instance.new("UICorner")
byteCorner.CornerRadius = UDim.new(0, 13)
byteCorner.Parent = byteToggle
local byteStroke = Instance.new("UIStroke")
byteStroke.Thickness = 1.2
byteStroke.Color = Color3.fromRGB(95, 95, 255)
byteStroke.Transparency = 0.45
byteStroke.Parent = byteToggle
local translateToggle = Instance.new("TextButton")
translateToggle.BackgroundColor3 = Color3.fromRGB(36, 36, 50)
translateToggle.Text = "Translate Bytecode: OFF"
translateToggle.TextColor3 = Color3.fromRGB(185, 185, 255)
translateToggle.Font = Enum.Font.Gotham
translateToggle.TextSize = 16
translateToggle.Parent = buttonsRow
local translateCorner = Instance.new("UICorner")
translateCorner.CornerRadius = UDim.new(0, 13)
translateCorner.Parent = translateToggle
local translateStroke = Instance.new("UIStroke")
translateStroke.Thickness = 1.2
translateStroke.Color = Color3.fromRGB(95, 95, 255)
translateStroke.Transparency = 0.45
translateStroke.Parent = translateToggle
local isByteMode = false
local isTranslateMode = false
local decompButton = Instance.new("TextButton")
decompButton.BackgroundColor3 = Color3.fromRGB(0, 165, 85)
decompButton.Text = "DECOMPILE"
decompButton.TextColor3 = Color3.new(1, 1, 1)
decompButton.Font = Enum.Font.GothamBold
decompButton.TextSize = 20
decompButton.Parent = buttonsRow
local decompCorner = Instance.new("UICorner")
decompCorner.CornerRadius = UDim.new(0, 13)
decompCorner.Parent = decompButton
local decompStroke = Instance.new("UIStroke")
decompStroke.Thickness = 1.2
decompStroke.Color = Color3.fromRGB(0, 245, 125)
decompStroke.Transparency = 0.28
decompStroke.Parent = decompButton
local analyzeButton = Instance.new("TextButton")
analyzeButton.BackgroundColor3 = Color3.fromRGB(0, 105, 180)
analyzeButton.Text = "FUNCTION DUMP"
analyzeButton.TextColor3 = Color3.new(1, 1, 1)
analyzeButton.Font = Enum.Font.GothamBold
analyzeButton.TextSize = 20
analyzeButton.Parent = buttonsRow
local analyzeCorner = Instance.new("UICorner")
analyzeCorner.CornerRadius = UDim.new(0, 13)
analyzeCorner.Parent = analyzeButton
local analyzeStroke = Instance.new("UIStroke")
analyzeStroke.Thickness = 1.2
analyzeStroke.Color = Color3.fromRGB(0, 175, 245)
analyzeStroke.Transparency = 0.28
analyzeStroke.Parent = analyzeButton
local outputTitle = Instance.new("TextLabel")
outputTitle.Size = UDim2.new(1, 0, 0, 26)
outputTitle.BackgroundTransparency = 1
outputTitle.Text = "Improved Output:"
outputTitle.TextColor3 = Color3.fromRGB(165, 165, 255)
outputTitle.Font = Enum.Font.Gotham
outputTitle.TextSize = 17
outputTitle.Parent = contentArea
local outputScrollFrame = Instance.new("ScrollingFrame")
outputScrollFrame.Size = UDim2.new(1, 0, 1, -225)
outputScrollFrame.BackgroundColor3 = Color3.fromRGB(10, 12, 18)
outputScrollFrame.BackgroundTransparency = 0.06
outputScrollFrame.ScrollBarThickness = 9
outputScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
outputScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
outputScrollFrame.Parent = contentArea
local scrollCorner = Instance.new("UICorner")
scrollCorner.CornerRadius = UDim.new(0, 16)
scrollCorner.Parent = outputScrollFrame
local outputHolder = Instance.new("Frame")
outputHolder.Size = UDim2.new(1, -16, 0, 0)
outputHolder.AutomaticSize = Enum.AutomaticSize.Y
outputHolder.BackgroundTransparency = 1
outputHolder.Parent = outputScrollFrame
local holderLayout = Instance.new("UIListLayout")
holderLayout.FillDirection = Enum.FillDirection.Vertical
holderLayout.SortOrder = Enum.SortOrder.LayoutOrder
holderLayout.Padding = UDim.new(0, 0)
holderLayout.Parent = outputHolder
local copyButton = Instance.new("TextButton")
copyButton.Size = UDim2.new(0.3, 0, 0, 48)
copyButton.Position = UDim2.new(0.7, 0, 1, 14)
copyButton.BackgroundColor3 = Color3.fromRGB(85, 85, 245)
copyButton.Text = "COPY TO CLIPBOARD"
copyButton.TextColor3 = Color3.new(1, 1, 1)
copyButton.Font = Enum.Font.GothamBold
copyButton.TextSize = 16
copyButton.TextScaled = true
copyButton.Parent = contentArea
local copyCorner = Instance.new("UICorner")
copyCorner.CornerRadius = UDim.new(0, 12)
copyCorner.Parent = copyButton
local copyStroke = Instance.new("UIStroke")
copyStroke.Thickness = 1.3
copyStroke.Color = Color3.fromRGB(115, 115, 245)
copyStroke.Transparency = 0.32
copyStroke.Parent = copyButton
local currentOutput = "-- Output here"
local initialSize = UDim2.fromOffset(0, 0)
mainFrame.Size = initialSize
local openTweenInfo = TweenInfo.new(0.48, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
local openTarget = {Size = UDim2.fromOffset(820, 720)}
TweenService:Create(mainFrame, openTweenInfo, openTarget):Play()
closeButton.MouseButton1Click:Connect(function()
    local closeTweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
    local closeTarget = {Size = UDim2.fromOffset(0, 0)}
    TweenService:Create(mainFrame, closeTweenInfo, closeTarget):Play()
    task.wait(0.3)
    gui:Destroy()
end)
local dragActive = false
local dragStartPos = nil
local mainStartPos = nil
titleBar.InputBegan:Connect(function(inputObj)
    if inputObj.UserInputType == Enum.UserInputType.MouseButton1 then
        dragActive = true
        dragStartPos = inputObj.Position
        mainStartPos = mainFrame.Position
    end
end)
titleBar.InputEnded:Connect(function(inputObj)
    if inputObj.UserInputType == Enum.UserInputType.MouseButton1 then
        dragActive = false
    end
end)
UserInputService.InputChanged:Connect(function(inputObj)
    if dragActive and inputObj.UserInputType == Enum.UserInputType.MouseMovement then
        local deltaMove = inputObj.Position - dragStartPos
        mainFrame.Position = UDim2.new(mainStartPos.X.Scale, mainStartPos.X.Offset + deltaMove.X, mainStartPos.Y.Scale, mainStartPos.Y.Offset + deltaMove.Y)
    end
end)
local function createHoverEffect(buttonObj, normalColor, hoverColor)
    buttonObj.MouseEnter:Connect(function()
        TweenService:Create(buttonObj, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundColor3 = hoverColor, Size = buttonObj.Size + UDim2.fromOffset(6, 6)}):Play()
    end)
    buttonObj.MouseLeave:Connect(function()
        TweenService:Create(buttonObj, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {BackgroundColor3 = normalColor, Size = buttonObj.Size - UDim2.fromOffset(6, 6)}):Play()
    end)
end
createHoverEffect(byteToggle, Color3.fromRGB(36, 36, 50), Color3.fromRGB(52, 52, 70))
createHoverEffect(translateToggle, Color3.fromRGB(36, 36, 50), Color3.fromRGB(52, 52, 70))
createHoverEffect(decompButton, Color3.fromRGB(0, 165, 85), Color3.fromRGB(0, 195, 105))
createHoverEffect(analyzeButton, Color3.fromRGB(0, 105, 180), Color3.fromRGB(0, 135, 210))
createHoverEffect(copyButton, Color3.fromRGB(85, 85, 245), Color3.fromRGB(105, 105, 255))
local Utils = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pokifi/Better-Decompiler/refs/heads/main/BetterDecompiler/Utils.luau"))()
local Cleaner = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pokifi/Better-Decompiler/refs/heads/main/BetterDecompiler/Cleaner.luau"))()
local Analyzer = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pokifi/Better-Decompiler/refs/heads/main/BetterDecompiler/Analyzer.luau"))()
local Translator = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pokifi/Better-Decompiler/refs/heads/main/BetterDecompiler/Translator.luau"))()
local Renamer = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pokifi/Better-Decompiler/refs/heads/main/BetterDecompiler/Renamer.luau"))()
local Optimizer = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pokifi/Better-Decompiler/refs/heads/main/BetterDecompiler/Optimizer.luau"))()
local Formatter = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pokifi/Better-Decompiler/refs/heads/main/BetterDecompiler/Formatter.luau"))()
local Pipeline = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pokifi/Better-Decompiler/refs/heads/main/BetterDecompiler/Pipeline.luau"))()
local BetterDecompiler = {}
function BetterDecompiler.Run(decompiledSource)
    local result, analysis = Pipeline.Run(decompiledSource)
    return {
        code = result,
        report = analysis
    }
end
local function resolvePathFunction(inputPath)
    if typeof(inputPath) ~= "string" or inputPath == "" then return nil end
    local loadSuccess, loadFunc = pcall(loadstring, "return " .. inputPath)
    if loadSuccess then
        local callSuccess, resultObj = pcall(loadFunc)
        if callSuccess and typeof(resultObj) == "Instance" then return resultObj end
    end
    local pathParts = string.split(inputPath:gsub("^game%.", ""), "%.")
    local currentObj = game
    for _, singlePart in pathParts do
        if singlePart == "" then continue end
        local foundChild = currentObj:FindFirstChild(singlePart) or currentObj:FindFirstChild(singlePart, true)
        if not foundChild then return nil end
        currentObj = foundChild
    end
    return currentObj
end
local function countTotalLines(inputString)
    return #inputString:gsub("[^\n]", "") + 1
end
local function applySyntaxHighlightFunction(inputCode)
    local keywordTable = {["local"] = true, ["function"] = true, ["end"] = true, ["if"] = true, ["then"] = true, ["else"] = true, ["elseif"] = true, ["for"] = true, ["while"] = true, ["repeat"] = true, ["until"] = true, ["return"] = true, ["do"] = true, ["and"] = true, ["or"] = true, ["not"] = true}
    local verticalOffset = 0
    local lineHeightValue = 18
    outputHolder:ClearAllChildren()
    for singleLine in string.gmatch(inputCode, "[^\n]+") do
        local horizontalOffset = 0
        for singleToken in string.gmatch(singleLine, "%S+") do
            if singleToken and singleToken ~= "" then
                local tokenLabel = Instance.new("TextLabel")
                tokenLabel.BackgroundTransparency = 1
                tokenLabel.Font = Enum.Font.Code
                tokenLabel.TextSize = 15
                tokenLabel.TextXAlignment = Enum.TextXAlignment.Left
                tokenLabel.TextYAlignment = Enum.TextYAlignment.Top
                tokenLabel.Text = singleToken .. " "
                tokenLabel.Position = UDim2.new(0, horizontalOffset, 0, verticalOffset)
                tokenLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
                if string.sub(singleLine, 1, 2) == "--" then
                    tokenLabel.TextColor3 = Color3.fromRGB(106, 153, 85)
                end
                if singleToken:match('^".*"$') or singleToken:match("^'.*'$") then
                    tokenLabel.TextColor3 = Color3.fromRGB(206, 145, 120)
                end
                if keywordTable[singleToken] then
                    tokenLabel.TextColor3 = Color3.fromRGB(86, 156, 214)
                end
                if singleToken:match("^%d") then
                    tokenLabel.TextColor3 = Color3.fromRGB(181, 206, 168)
                end
                tokenLabel.Size = UDim2.fromOffset(#singleToken * 8.5, lineHeightValue)
                tokenLabel.Parent = outputHolder
                horizontalOffset = horizontalOffset + tokenLabel.AbsoluteSize.X
            end
        end
        verticalOffset = verticalOffset + lineHeightValue
    end
end
byteToggle.MouseButton1Click:Connect(function()
    isByteMode = not isByteMode
    byteToggle.Text = "Bytecode Mode: " .. (isByteMode and "ON" or "OFF")
    byteToggle.BackgroundColor3 = isByteMode and Color3.fromRGB(0, 180, 100) or Color3.fromRGB(36, 36, 50)
end)
translateToggle.MouseButton1Click:Connect(function()
    isTranslateMode = not isTranslateMode
    translateToggle.Text = "Translate Bytecode: " .. (isTranslateMode and "ON" or "OFF")
    translateToggle.BackgroundColor3 = isTranslateMode and Color3.fromRGB(0, 180, 100) or Color3.fromRGB(36, 36, 50)
end)
decompButton.MouseButton1Click:Connect(function()
    local resolvedObj = resolvePathFunction(pathInput.Text)
    if not resolvedObj then
        statusLabel.Text = "-- Invalid Path!"
        return
    end
    statusLabel.Text = "-- Processing..."
    local rawCode = isByteMode and getscriptbytecode(resolvedObj) or decompile(resolvedObj)
    if typeof(rawCode) ~= "string" then
        statusLabel.Text = "-- Failed!"
        return
    end
    local resultTable = BetterDecompiler.Run(rawCode)
    currentOutput = resultTable.code
    statusLabel.Text = "-- Decompiled (" .. countTotalLines(currentOutput) .. " lines)"
    applySyntaxHighlightFunction(currentOutput)
end)
analyzeButton.MouseButton1Click:Connect(function()
    local currentText = currentOutput
    if currentText == "-- Output here" or currentText == "-- Processing..." then return end
    local analysisResult = BetterDecompiler.Run(currentText).report
    currentOutput = "-- Function Dump:\n" .. tostring(analysisResult.tempVars) .. " temp vars\n" .. tostring(analysisResult.redundantReturns) .. " redundant returns\n" .. currentOutput
    statusLabel.Text = "-- Function Dump Generated"
    applySyntaxHighlightFunction(currentOutput)
end)
copyButton.MouseButton1Click:Connect(function()
    setclipboard(currentOutput)
    statusLabel.Text = "-- Copied to clipboard"
end)
print("Better Decompiler Main v0.0.1")
