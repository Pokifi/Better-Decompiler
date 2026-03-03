local folderName = "BetterDecompiler"
local versionRemoteUrl = "https://raw.githubusercontent.com/Pokifi/Better-Decompiler/refs/heads/main/BetterDecompiler/version.txt"
local baseUrl = "https://raw.githubusercontent.com/Pokifi/Better-Decompiler/refs/heads/main/BetterDecompiler/"

local LOG_LIMIT = 200

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
    if success and content then
        return content:match("%S+")
    end
    return "0.0.0"
end

local function readLocalVersion()
    local path = folderName .. "/version.txt"
    if isfile(path) then
        return readfile(path):match("%S+")
    end
    return "0.0.0"
end

local function writeLocalVersion(version)
    writefile(folderName .. "/version.txt", version)
end

local function logToFile(level, message)
    local path = folderName .. "/logs.txt"
    createFolder()

    local line = string.format("[%s] [%s] %s\n",
        os.date("%Y-%m-%d %H:%M:%S"),
        level,
        message
    )

    if not isfile(path) then
        writefile(path, line)
        return
    end

    local content = readfile(path)
    local lines = {}

    for l in content:gmatch("[^\r\n]+") do
        table.insert(lines, l)
    end

    table.insert(lines, line:gsub("\n", ""))

    if #lines > LOG_LIMIT then
        local newLines = {}
        for i = #lines - LOG_LIMIT + 1, #lines do
            table.insert(newLines, lines[i])
        end
        lines = newLines
    end

    writefile(path, table.concat(lines, "\n") .. "\n")
end

local function downloadFile(filename)
    local url = baseUrl .. filename .. ".luau"

    local success, content = pcall(function()
        return game:HttpGet(url)
    end)

    if success and content and #content > 10 then
        writefile(folderName .. "/" .. filename .. ".luau", content)
        return true
    end

    logToFile("ERROR", "Failed to download " .. filename)
    return false
end

local function reinstallAllModules()
    logToFile("INFO", "Starting reinstall")
    createFolder()

    local files = {
        "Utils",
        "Cleaner",
        "Analyzer",
        "Translator",
        "Renamer",
        "Optimizer",
        "Formatter",
        "Pipeline",
        "Tools"
    }

    for _, file in ipairs(files) do
        downloadFile(file)
    end

    local remoteVer = downloadRemoteVersion()
    writeLocalVersion(remoteVer)

    logToFile("INFO", "Reinstall completed - version " .. remoteVer)
end

if not getgenv().BetterDecompilerLoaded then
    getgenv().BetterDecompilerLoaded = true
    createFolder()
    local remoteVersion = downloadRemoteVersion()
    local localVersion = readLocalVersion()

    if not folderExists() or remoteVersion ~= localVersion then
        logToFile("WARN", "Version mismatch (" .. localVersion .. " vs " .. remoteVersion .. ") - reinstalling")
        reinstallAllModules()
    else
        logToFile("INFO", "Version match (" .. localVersion .. ")")
    end
    local Tools = loadfile(folderName .. "/Tools.luau")()
    Tools.Install()
    logToFile("INFO", "Better Decompiler loaded successfully")
    print("Better Decompiler v" .. readLocalVersion() .. " ready")
else
    print("Better Decompiler already loaded.")
end
