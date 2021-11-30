cmake_minimum_required(VERSION 3.16)
project(assembled C ASM_NASM)

set(CMAKE_C_STANDARD 99)
set(CMAKE_ASM_NASM_LINK_EXECUTABLE "ld -e _start <CMAKE_ASM_NASM_LINK_FLAGS> <LINK_FLAGS> <OBJECTS>  -o <TARGET> <LINK_LIBRARIES>")
set(CMAKE_ASM_NASM_OBJECT_FORMAT macho64)

link_libraries(libSystem.dylib)

add_executable(fibonacci fibonacci.asm)
