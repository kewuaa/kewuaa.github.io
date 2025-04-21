#import "@preview/shiroa:0.2.0": *

#show: book

#book-meta(
  title: "Kewuaa-Blog",
  authors: ("kewuaa",),
  language: "zh-cn",
  summary: [
    #prefix-chapter("introduction.typ")[介绍]
    = Linux
    - #chapter("linux/file_system.typ")[文件系统]
    = 编程语言
    - #chapter("programing/cmake.typ", section: "1")[CMake]
    - #chapter("programing/cpp/init.typ")[C++]
      - #chapter("programing/cpp/asyncio/init.typ")[Asyncio]
      - #chapter("programing/cpp/webserver/init.typ")[WebServer]
    - #chapter("programing/python/init.typ")[Python]
      - #chapter("programing/python/asyncio.typ")[Asyncio]
    = LeetCode
    - #chapter("leetcode/rotated_sorted_array.typ", section: "1")[螺旋数组]
    - #chapter("leetcode/gas_station.typ")[加油站]
  ]
)

#build-meta(dest-dir: "../dist")



// re-export page template
#import "templates/page.typ": project
#let book-page = project
