package("breakpad-tool")
    set_homepage("https://github.com/getsentry/breakpad-tools")
    set_description("Crashpad is a crash-reporting system.")
    set_license("Apache-2.0")

    add_urls("https://github.com/getsentry/breakpad-tools.git")
    add_versions("2020.07.16", "abcafc115e6130c009c3b2efae12ff6ffcc1d539")

    on_install("linux", function(package)
        os.cd("linux")
        local configs = {}
        import("package.tools.make").install(package, configs)
        -- package:addenv("PATH", "bin")
    end)

    on_install("windows|x86", "windows|x64", function(package)
        os.cd("windows")
        local configs = {}
        import("package.tools.make").install(package, configs)
        -- package:addenv("PATH", "bin")
    end)

    on_test(function(package)
        if package:is_plat("linux") then
            os.vrunv("minidump_stackwalk", {"--help"})
        end

        if package:is_plat("windows") then
            os.vrunv("minidump_stackwalk.exe", {"--help"})
        end

    end)
