local folderName = "BetterDecompiler"
local versionRemoteUrl = "https://raw.githubusercontent.com/Pokifi/Better-Decompiler/refs/heads/main/BetterDecompiler/version.txt"
local baseUrl = "https://raw.githubusercontent.com/Pokifi/Better-Decompiler/refs/heads/main/BetterDecompiler/"
local function folderExists()
    return isfolder(folderName)
end
local function createFolder()
    if not folderExists() then
        makefolder(folderName)
    end
end
local function downloadRemoteVersion()
    local success, content = pcall(function()
        return game:HttpGet(versionRemoteUrl)
    end)
    if success then
        return content:match("%S+")
    end
    return "0.0.0"
end
local function readLocalVersion()
    local path = folderName .. "/version.txt"
    if isfile(path) then
        return readfile(path)
    end
    return "0.0.0"
end
local function writeLocalVersion(version)
    writefile(folderName .. "/version.txt", version)
end
local function logToFile(level, message)
    local path = folderName .. "/logs.json"
    local logs = {}
    if isfile(path) then
        local success, content = pcall(function()
            return game:GetService("HttpService"):JSONDecode(readfile(path))
        end)
        if success then logs = content end
    end
    table.insert(logs, {
        timestamp = os.date("%Y-%m-%d %H:%M:%S"),
        level = level,
        message = message
    })
    writefile(path, game:GetService("HttpService"):JSONEncode(logs))
end
local function downloadFile(filename)
    local url = baseUrl .. filename .. ".luau"
    local success, content = pcall(function()
        return game:HttpGet(url)
    end)
    if success and content then
        writefile(folderName .. "/" .. filename .. ".luau", content)
        return true
    end
    logToFile("ERROR", "Failed to download " .. filename)
    return false
end
local function reinstallAllModules()
    logToFile("INFO", "Starting reinstall")
    createFolder()
    local files = {"Utils", "Cleaner", "Analyzer", "Translator", "Renamer", "Optimizer", "Formatter", "Pipeline", "Main", "Tools"}
    for _, file in ipairs(files) do
        downloadFile(file)
    end
    local remoteVer = downloadRemoteVersion()
    writeLocalVersion(remoteVer)
    logToFile("INFO", "Reinstall completed - version " .. remoteVer)
end
local remoteVersion = downloadRemoteVersion()
local localVersion = readLocalVersion()
if not folderExists() or remoteVersion ~= localVersion then
    logToFile("WARN", "Version mismatch or folder missing (" .. localVersion .. " vs " .. remoteVersion .. "). Reinstalling...")
    reinstallAllModules()
else
    logToFile("INFO", "Version match (" .. localVersion .. ") - loading system")
end
local Tools = loadstring(readfile(folderName .. "/Tools.luau"))()
local BetterDecompiler = loadstring(readfile(folderName .. "/Main.luau"))()
Tools.Install()
logToFile("INFO", "Better Decompiler loaded successfully")
print("Better Decompiler v0.0.1 installed and ready")
