if getgenv().BetterDecompilerLoaded then
    warn("BetterDecompiler already loaded.")
    return
end
getgenv().BetterDecompilerLoaded = true

local VERSION_LUAU = "https://raw.githubusercontent.com/Pokifi/Better-Decompiler/refs/heads/main/BetterDecompiler/version.txt"
local VERSION_LUA  = "https://raw.githubusercontent.com/Pokifi/Better-Decompiler/refs/heads/main/BetterDecompilerLua/version.txt"

local BASE_LUAU = "https://raw.githubusercontent.com/Pokifi/Better-Decompiler/refs/heads/main/BetterDecompiler/"
local BASE_LUA  = "https://raw.githubusercontent.com/Pokifi/Better-Decompiler/refs/heads/main/BetterDecompilerLua/"

local MODULES = {
    "Utils","Cleaner","Analyzer","Translator",
    "Renamer","Optimizer","Formatter","Pipeline","Tools"
}

local FOLDER = "BetterDecompiler"
local LOG_LIMIT = 200

local function supportsLuau()
    return loadstring("local x: number = 5 return x") ~= nil
end

local USE_LUAU = supportsLuau()
local BASE = USE_LUAU and BASE_LUAU or BASE_LUA
local VERSION_URL = USE_LUAU and VERSION_LUAU or VERSION_LUA
local EXT = USE_LUAU and ".luau" or ".lua"

print("BetterDecompiler Mode:", USE_LUAU and "LUAU" or "LUA")

local HAS_FS = (typeof(writefile)=="function" and typeof(makefolder)=="function" and typeof(isfile)=="function")

local function safeHttpGet(url)
    local ok,res = pcall(function()
        return game:HttpGet(url)
    end)
    if ok and res and #res>10 then
        return res
    end
    return nil
end

local function loadMemory()
    local Loaded = {}

    for _,name in ipairs(MODULES) do
        local src = safeHttpGet(BASE..name..EXT)
        if not src then
            warn("Failed to download:",name)
            continue
        end

        local fn,err = loadstring(src)
        if not fn then
            warn("Compile error:",name,err)
            continue
        end

        local ok,res = pcall(fn)
        if ok then
            Loaded[name]=res
        else
            warn("Runtime error:",name,res)
        end
    end

    if Loaded.Tools and Loaded.Tools.Install then
        Loaded.Tools.Install()
        print("BetterDecompiler Loaded (Memory Mode)")
    else
        warn("Failed to initialize Tools")
    end
end

local function installFS()
    if not isfolder(FOLDER) then
        makefolder(FOLDER)
    end

    local function path(f)
        return FOLDER.."/"..f
    end

    local function readVersion()
        if isfile(path("version.txt")) then
            return readfile(path("version.txt")):match("%S+") or "0.0.0"
        end
        return "0.0.0"
    end

    local function writeVersion(v)
        writefile(path("version.txt"),v)
    end

    local function log(msg)
        local p = path("logs.txt")
        local line = "["..os.date("%H:%M:%S").."] "..msg

        if not isfile(p) then
            writefile(p,line.."\n")
            return
        end

        local content = readfile(p)
        local lines = {}
        for l in content:gmatch("[^\r\n]+") do
            table.insert(lines,l)
        end
        table.insert(lines,line)

        if #lines>LOG_LIMIT then
            local new={}
            for i=#lines-LOG_LIMIT+1,#lines do
                table.insert(new,lines[i])
            end
            lines=new
        end

        writefile(p,table.concat(lines,"\n").."\n")
    end

    local remoteVersion = safeHttpGet(VERSION_URL)
    remoteVersion = remoteVersion and remoteVersion:match("%S+") or "0.0.0"
    local localVersion = readVersion()

    if remoteVersion ~= localVersion then
        log("Updating modules...")

        for _,name in ipairs(MODULES) do
            local src = safeHttpGet(BASE..name..EXT)
            if src then
                writefile(path(name..EXT),src)
                log("Downloaded "..name)
            else
                log("Failed "..name)
            end
        end

        writeVersion(remoteVersion)
        log("Update complete "..remoteVersion)
    else
        log("Version OK "..localVersion)
    end

    local toolsPath = path("Tools"..EXT)
    if isfile(toolsPath) then
        local Tools = loadfile(toolsPath)()
        if Tools and Tools.Install then
            Tools.Install()
            print("BetterDecompiler Loaded (Filesystem Mode)")
        else
            warn("Tools invalid")
        end
    else
        warn("Tools not found")
    end
end

if HAS_FS then
    installFS()
else
    loadMemory()
end
