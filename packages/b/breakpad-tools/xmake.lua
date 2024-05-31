package("breakpad-tools")
    set_homepage("https://github.com/getsentry/breakpad-tools")
    set_description("breakpad tools bins,for example:minidump_stackwalk")
    set_license("Apache-2.0")

    add_urls("https://github.com/getsentry/breakpad-tools.git")
    add_versions("2020.07.16", "abcafc115e6130c009c3b2efae12ff6ffcc1d539")
    add_patches("2020.07.16","patches/2020.07.16/fixlinux.patch","441c7b5bd07c1d09166b7ee09c4a4b8e6c7d60bac78ffae9d8ff258fd3487a4c")
    
    on_install("linux", function(package)
        
        os.cd("linux")
        local configs = {}

        import("package.tools.make").build(package, configs)
        
        os.cp("build/*",package:installdir("bin"))
        package:addenv("PATH", "bin")
    end)

    on_install("windows|x86", "windows|x64", function(package)
        os.cd("windows")
        local configs = {}

        -- import("package.tools.make").build(package, configs)
        os.vrunv("make.bat",{"all"})
        os.cp("build/*",package:installdir("bin"))
        package:addenv("PATH", "bin")
    end)

    on_test(function(package)
        if package:is_plat("linux") then
            os.vrunv("minidump_stackwalk", {"-help"})
        end

        if package:is_plat("windows") then
            os.vrunv("minidump_stackwalk.exe", {"-help"})
        end

    end)
