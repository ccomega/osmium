local defaultBoot  = "/sys/boot/full.boot"
local recoveryBoot = "/sys/boot/recovery.boot"
local headlessBoot = "/sys/boot/headless.boot"
--not gonna happen
-- because no
print("Booting Osmium, please press any key to go to boot options.")
bootOptions = {
    ["recovery"] = {
        ["label"] = "Recovery",
        ["path"] = recoveryBoot
    },
    ["craftos"] = {
        ["label"] = os.version(),
        ["path"] = "/rom/programs/shell"
    },
    ["full"] = {
        ["label"] = "Default",
        ["path"] = defaultBoot
    },
    ["headless"] =  {
        ["label"] = "Headless",
        ["path"] = headlessBoot
    }
}
parallel.waitForAny(
    function()
        if not pressedKey then
            sleep(1)
            return -- Return to normal boot sequence
        else
            return
        end
    end,
    function()
        local event, key = os.pullEvent("key") -- get the key and go further with the script
        if key then
            pressedKey = true
        end
    end
)
if pressedKey then
    --avoid double keypresses
    sleep(.001)
    times = 0
    tTimes = {}
    for k,v in pairs(table.sort(bootOptions) or bootOptions) do
        times = times+1
        tTimes[times] = v
        print(times .. " - " ..v.label)
    end
    while true do
        local input = read()
        print(textutils.serialize(tTimes))
        if tTimes[tonumber(input)] then
            shell.run(tTimes[tonumber(input)].path)
            break
        end
    end
end
