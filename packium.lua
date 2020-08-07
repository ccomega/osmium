local function printHelp(topic)
    local topics = {
        args = [[
            packium {-H --help} [options]
            packium {-S --sync} [options]
            packium {-R --remove} [options]
            packium {-U --upgrade} [options] <file(s)>
            packium {-V --version}
        ]]
    }
end

local function printVersion()
    print([[
        Version b1.0    Main Writer: Pjals
                        Supervisor: RubenKnijn

        Inspired by `pacman` on Arch Linux
         ]])
end

local function act(action, what)
    if action == "install" then
        print("install " .. what)
        [[
            Programs:
            chat

        ]]
    elseif not what then
        error("Invalid argument")
    end
end
local args = {...}
local validArgs = {
    {name = "sync", short = "S", long = "sync", f = act, args = {"install", args[2]} },
    {name = "help", short = "H", long = "help", f = printHelp, args = {(args[2] or "topics")} },
    {name = "remove", short = "R", long = "remove", f = act, args = {"remove", args[2]} },
    {name = "version", short = "V", long = "version", f = printVersion, args = nil }
}
for k,v in pairs(validArgs) do
    for k2,v2 in pairs(args) do
        print((textutils.serialize(k2) or "function"), (textutils.serialize(v2) or "function"))
        print((textutils.serialize(k) or "function"), (textutils.serialize(v) or "function"))
        if v2 == "-"..v.short or v2 == "--"..v.long then
            found = true
            v.f(table.unpack(v.args))
        end
    end

end
if not found then
    error("Invalid argument")
end