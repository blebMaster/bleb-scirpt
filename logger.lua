
local safeLogTemplate = {
    ["MessageInfo"] = {
        [1] = "GrabLocal active"
    },
    ["MessageError"] = {},
    ["MessageWarning"] = {},
    ["MessageOutput"] = {
        [1] = "[TomahawkVFX]: Client listener initialized",
        [2] = "[SecondTracker] initialized"
    }
}


local function formatTable(tbl, depth)
    depth = depth or 0
    if depth > 3 then return "{...}" end
    local result = {}
    for k, v in pairs(tbl) do
        local key = type(k) == "string" and string.format("[%q]", k) or string.format("[%s]", tostring(k))
        local val
        if type(v) == "table" then val = formatTable(v, depth + 1)
        elseif type(v) == "string" then val = string.format("%q", v)
        else val = tostring(v) end
        table.insert(result, key .. " = " .. val)
    end
    return "{" .. table.concat(result, ", ") .. "}"
end

local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    local method = getnamecallmethod()

    if (method == "FireServer" or method == "InvokeServer") then
        if checkcaller() then 
            setnamecallmethod(method)
            return oldNamecall(self, ...) 
        end

        local path = "Unknown"
        pcall(function()
            path = self:GetFullName()
        end)
        if  string.find(path, "Remotes.Grab") then
            setnamecallmethod(method)
            print("Был вызван Grab но был перехвачен и отправленно: safeLogTemplate ")
            return oldNamecall(self, safeLogTemplate)
        end
        if not string.find(path, "ChatService") and not string.find(path, "RobloxGui")  then
            local args = table.pack(...) 
            local argCount = args.n
            print("----------------------------------------")
            print(string.format("[REMOTE SPY] Вызов: ".. method))
            print(string.format("[Путь]: ".. path))
            print(string.format("[Кол-во аргументов]: ".. argCount))
            print("[Аргументы]:")
            
            if argCount == 0 then
                print("  -> (Пустой вызов / Нет аргументов)")
            else
                for i = 1, argCount do
                    local arg = args[i]
                    local argType = type(arg)
                    
                    if arg == nil then
                        print(string.format( i.." is nil"))
                    elseif argType == "table" then
                        print(string.format("  [%d] (table): %s", i, formatTable(arg)))
                    elseif argType == "string" then
                        print(string.format("  [%d] (string): %q", i, arg))
                    elseif argType == "userdata" and typeof(arg) == "Instance" then
                        local instancePath = "Unknown Instance"
                        pcall(function() instancePath = arg:GetFullName() end)
                        print(string.format("  [%d] (Instance): %s", i, instancePath))
                    else
                        print(string.format("  [%d] (%s): %s", i, argType, tostring(arg)))
                    end
                end
            end
            print("----------------------------------------")
        end
    end
    
    setnamecallmethod(method)
    return oldNamecall(self, ...)
end))

print("[Remote Spy]: Полностью исправлено. Оригинальный стек вызовов сохранен!")
