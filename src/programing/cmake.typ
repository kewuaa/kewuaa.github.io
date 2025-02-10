#import "../book.typ": book-page

#show: book-page.with(title: "CMake")


= 简单 CMakeLists.txt 例子

`main.cpp`
```cpp
#include <iostream>

#include "hello.hpp"


int main() {
    std::cout << hello("World") << std::endl;
}
```

`hello.cpp`
```cpp
#include <string>


std::string hello(const char* name) {
    std::string words { "Hello" };
    return words + " " + name + "!!!";
}
```

`include/hello.hpp`
```cpp
#pragma once
#include <string>


std::string hello(const char* name);
```

`CMakeLists.txt`
```cmake
cmake_minimum_required(VERSION 3.1...3.15)

project(
    MyProject
    LANGUAGES CXX
    DESCRIPTION "My project"
)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

add_library(hello STATIC hello.cpp)
target_include_directories(hello PUBLIC include)

add_executable(main main.cpp)
target_link_libraries(main hello)
```

接下来逐一解释`CMakeLists.txt`中命令的作用。

- `cmake_minimum_required`设置项目要求的`cmake`版本，`3.1...3.15`指定cmake版本在`3.1`和`3.15`之间。
- `project`设置项目相关信息，第一个参数指定项目名称，`LANGUAGES`后设置项目的语言，`DESCRIPTION`后为项目描述。
- `set`命令设置变量的值，这里将`CMAKE_EXPORT_COMPILE_COMMANDS`设置为`ON`，会导出`compile_commands.json`文件，
  用于设置语言服务器（如clangd）。
- `add_library`添加库，第一个参数为目标名称，`STATIC`设置库类型为静态库，若要设置为动态库则使用`SHARED`，
  再后面为库所需要的源文件，以空格分隔。
- `add_executable`添加可执行文件，第一个参数为目标名称，后面为所需要的源文件，同样以空格分隔。
- `target_include_directories`为目标添加头文件目录，第一个参数为目标名称（可执行文件或库），
  这里为`hello`静态库添加`include`目录，`PUBLIC`设置链接该静态库的其他库同样添加该头文件目录。
- `target_link_libraries`为目标添加链接库，第一个参数为目标名称（可执行文件或库），同样可以添加`PUBLIC`，
  作用和`target_include_directories`中的`PUBLIC`类似。

= GenerateExportHeader

构建动态/静态库时常常需要控制符号可见性，隐藏不必要的符号有以下好处：
- 安全，去掉不必要的符号可以增加逆向的难度
- 符号是存储在库中的，减少符号可以缩减库的体积
- 一定程度上提高性能，隐藏符号意味着不含参与到符号链接的过程中，编译器可以有更大的优化空间
- 避免和其他库的符号发生冲突

在不同平台下，需要使用不同方式来控制符号可见性。
- Linux下可以通过添加`-fvisibility=hidden`设置默认不导出符号，`-fvisibility-inlines-hidden`
  隐藏内联成员函数，然后通过给函数和类添加```cpp __attribute__((visibility("default")))```
  属性来导出对应符号。
- Windos下默认隐藏所有符号，要导出符号需要添加```cpp __declspec(dllexport)```
  在函数和类声明前。


`cmake`自带了#link("https://cmake.com.cn/cmake/help/latest/module/GenerateExportHeader.html")[`GenerateExportHeader`]
，可以帮助跨平台的控制符号的可见性，通过在`CMakeLists.txt`中添加`include(GenerateExportHeader)`，
引入`GENERATE_EXPORT_HEADER`函数。
```cmake
GENERATE_EXPORT_HEADER( LIBRARY_TARGET
    [BASE_NAME <base_name>]
    [EXPORT_MACRO_NAME <export_macro_name>]
    [EXPORT_FILE_NAME <export_file_name>]
    [DEPRECATED_MACRO_NAME <deprecated_macro_name>]
    [NO_EXPORT_MACRO_NAME <no_export_macro_name>]
    [INCLUDE_GUARD_NAME <include_guard_name>]
    [STATIC_DEFINE <static_define>]
    [NO_DEPRECATED_MACRO_NAME <no_deprecated_macro_name>]
    [DEFINE_NO_DEPRECATED]
    [PREFIX_NAME <prefix_name>]
    [CUSTOM_CONTENT_FROM_VARIABLE <variable>]
)
```
默认情况下`GENERATE_EXPORT_HEADER`根据库名称生成宏名称。
```cmake
SET(CMAKE_CXX_VISIBILITY_PRESET hidden)
SET(CMAKE_VISIBILITY_INLINES_HIDDEN 1)
ADD_LIBRARY(somelib someclass.cpp)
GENERATE_EXPORT_HEADER(somelib)
```
在源文件中`include``somelib_export.h`后通过`SOMELIB_EXPORT`宏导出符号。
```cpp
#include "somelib_export.h"
class SOMELIB_EXPORT SomeClass {
  ...
};
```
- 通过设置`BASE_NAME`可以修改宏的前缀，即不根据库名称而是自定义。
- 通过设置`EXPORT_MACRO_NAME`可以自己指定完整的宏名称。
