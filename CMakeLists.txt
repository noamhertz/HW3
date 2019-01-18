cmake_minimum_required(VERSION 3.13)
project(HW333)

set(CMAKE_CXX_STANDARD 14)

add_executable(HW333 main.cpp Quads.h Quads.cpp Helper.h Symbol.cpp Symbol.h Function.h Function.cpp Reader.lex Parser.y)