cmake_minimum_required(VERSION 3.28)
project(sys-dashboard VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# ── Dependencies (FetchContent) ──
include(FetchContent)

# spdlog (header-only logging)
FetchContent_Declare(spdlog
  GIT_REPOSITORY https://github.com/gabime/spdlog.git
  GIT_TAG        v1.15.1
)
FetchContent_MakeAvailable(spdlog)

# FTXUI (terminal UI library)
FetchContent_Declare(ftxui
  GIT_REPOSITORY https://github.com/ArthurSonzogni/FTXUI.git
  GIT_TAG        v5.0.0
  SYSTEM
)
FetchContent_MakeAvailable(ftxui)

# ── Sources ──
file(GLOB_RECURSE SOURCES src/*.cpp)
file(GLOB_RECURSE HEADERS include/*.hpp include/*.h)

add_executable(sys-dashboard ${SOURCES} ${HEADERS})
target_include_directories(sys-dashboard PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/include)
target_link_libraries(sys-dashboard PRIVATE
  ftxui::screen
  ftxui::dom
  ftxui::component
  spdlog::spdlog
)

# ── Tests (opcional) ──
option(BUILD_TESTS "Build tests" ON)
if(BUILD_TESTS)
  enable_testing()
  add_subdirectory(tests)
endif()

# ── Install ──
install(TARGETS sys-dashboard DESTINATION bin)
