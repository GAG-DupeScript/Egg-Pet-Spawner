--[[
    Script Loader - Enhanced
    Loads and executes a remote Lua script from Pastefy
    Includes logging, error handling, and structured layout
]]

--==[ Configuration ]==--
local ScriptName = "PastefyLoader"
local ScriptURL = "https://pastefy.app/IHnOJ4dz/raw"

--==[ Logging Functions ]==--
local function log(msg)
    print("[" .. ScriptName .. "] " .. msg)
end

local function errorLog(msg)
    warn("[" .. ScriptName .. "] ERROR: " .. msg)
end

--==[ Script Download Function ]==--
local function fetchScript(url)
    log("Attempting to fetch script from: " .. url)
    local success, result = pcall(function()
        return game:HttpGet(url)
    end)

    if success then
        log("Successfully fetched script (" .. #result .. " characters).")
        return result
    else
        errorLog("Failed to fetch script. Reason: " .. tostring(result))
        return nil
    end
end

--==[ Script Execution Function ]==--
local function executeScript(code)
    log("Compiling script...")
    local func, compileError = loadstring(code)

    if not func then
        errorLog("Compilation failed. Error: " .. tostring(compileError))
        return
    end

    log("Executing script...")
    local success, runtimeError = pcall(func)

    if success then
        log("Script executed successfully.")
    else
        errorLog("Runtime error during script execution: " .. tostring(runtimeError))
    end
end

--==[ Main Loader ]==--
log("Initializing script loader...")
local scriptContent = fetchScript(ScriptURL)

if scriptContent then
    executeScript(scriptContent)
else
    errorLog("Script execution aborted due to previous errors.")
end

log("Loader finished.")
