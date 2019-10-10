cmake_minimum_required(VERSION 3.15)
project(Register)

set(CMAKE_CXX_STANDARD 11)

add_library(Register SHARED library.cpp library.h clz_Register.c DynamicRegister.c)

add_library(firstlib SHARED clz_Register.h clz_Register.c)

add_library(firstdylib SHARED DynamicRegister.c string_test.c)

add_library(stringtestlib SHARED  string_test.c)
add_library(jnitestlib SHARED  clz_JniTest.h clz_JniTest.c)