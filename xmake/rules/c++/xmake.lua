--!A cross-platform build utility based on Lua
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
-- 
-- Copyright (C) 2015 - 2019, TBOOX Open Source Group.
--
-- @author      ruki
-- @file        xmake.lua
--

-- define rule: c.build.pcheader
rule("c.build.pcheader")
    before_build(function (target, opt)
        import("private.action.build.pcheader")(target, "c", opt)
    end)

-- define rule: c.build
rule("c.build")
    set_extensions(".c")    
    add_deps("c.build.pcheader")
    on_build_files(function (target, sourcebatch, opt)
        import("private.action.build.object")(target, sourcebatch, opt)
    end)

-- define rule: cpp.build.pcheader
rule("cpp.build.pcheader")
    before_build(function (target, opt)
        import("private.action.build.pcheader")(target, "cxx", opt)
    end)

-- define rule: cpp.build
rule("cpp.build")
    set_extensions(".cpp", ".cc", ".cxx")    
    add_deps("cpp.build.pcheader")
    on_build_files(function (target, sourcebatch, opt)
        import("private.action.build.object")(target, sourcebatch, opt)
    end)

-- define rule: cpp
rule("cpp")
    add_deps("cpp.build", "c.build")
