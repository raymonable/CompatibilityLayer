local Compatibility = {
    new = function()
        -- CompatibilityLayer
        return function(ToCompatibilitate)
            local _syn = syn
            local Compatibilities = {
                ["getsynasset"] = function(...)
                    if getsynasset then
                        return getsynasset(...)
                    elseif getcustomasset then
                        return getcustomasset(...)
                    end
                end,
                ["getcustomasset"] = function(...)
                    if getsynasset then
                        return getsynasset(...)
                    elseif getcustomasset then
                        return getcustomasset(...)
                    end
                end,
                ["setreadonly"] = function(ToSetReadOnly)
                    if setreadonly then
                        setreadonly(ToSetReadOnly)
                    elseif make_writeable then
                        make_writeable(ToSetReadOnly, false)
                    end
                end,
                ["newcclosure"] = function(Function)
                    if newcclosure then
                        return newcclosure(Function)
                    else
                        return Function 
                    end
                end,
                ["syn"] = (function()
                    if _syn then
                        return _syn
                    else
                        -- This does not have full compatibility. It's pretty unfinished.
                        return {
                            request = function(Options)
                                if Options.Method == "GET" then
                                    -- Not sure if this works
                                    return game:HttpGet(Options.Url, Options.Headers, Option.Body) 
                                else
                                    warn('The compatibility layer does not support other HTTP request types than GET. Please send in a PR with a fix!')
                                end
                            end,
                            ["is_beta"] = function() return false end,
                            ["protect_gui"] = function() warn('Protects do not work yet. Sorry!') end,
                            ["unprotect_gui"] = function() warn('Protects do not work yet. Sorry!') end
                        }
                    end
                end)
            }
            local To_G = ""
            for CompatibilityName, Compatibility in pairs(Compatibilities) do
                _G[CompatibilityName] = Compatibility
                To_G = To_G .. "local "..CompatibilityName.."=_G['"..CompatibilityName.."'];"
            end
            return loadstring(To_G.."\n"..ToCompatibilitate) 
        end
    end
}
return Compatibility
