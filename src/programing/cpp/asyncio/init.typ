#import "../../../book.typ": book-page


#show: book-page.with(title: "Asyncio")

= 介绍

参考python的#link("https://docs.python.org/3/library/asyncio.html")[asyncio]框架，
使用c++20的#link("https://en.cppreference.com/w/cpp/language/coroutines")[coroutines]构建一个异步框架。

包含以下：
+ EventLoop
+ Task
+ Socket
