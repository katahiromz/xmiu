# CMakeLists.txt --- CMake project settings
##############################################################################

# CMake minimum version
cmake_minimum_required(VERSION 3.10)

# project name and language
project(xmiu C CXX RC)

# C++17
set(CMAKE_CXX_STANDARD 17)

# We don't like run-time DLL
if (CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
    # using Clang
    set(CMAKE_CXX_FLAGS "-static")
elseif (CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
    # using GCC
    set(CMAKE_CXX_FLAGS "-static")
elseif (MSVC)
    # replace "/MD" with "/MT" (building without runtime DLLs)
    set(CompilerFlags
        CMAKE_CXX_FLAGS
        CMAKE_CXX_FLAGS_DEBUG
        CMAKE_CXX_FLAGS_RELEASE
        CMAKE_CXX_FLAGS_RELWITHDEBINFO)
    foreach(CompilerFlags ${CompilerFlags})
        string(REPLACE "/MD" "/MT" ${CompilerFlags} "${${CompilerFlags}}")
    endforeach()
endif()

# submodules
add_subdirectory(compact_enc_det)
add_subdirectory(gtest)

# No manifest
if(MSVC)
    set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} /MANIFEST:NO")
    set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} /MANIFEST:NO")
endif()

# xmiu.exe
add_executable(xmiu WIN32 xmiu.cpp xmiu_res.rc)
target_compile_definitions(xmiu PRIVATE UNICODE _UNICODE)
target_include_directories(xmiu PRIVATE compact_enc_det)
target_link_libraries(xmiu d2d1 d3d11 dxgi dcomp dwrite dxguid imm32 comdlg32 comctl32 dwmapi uxtheme ced)
