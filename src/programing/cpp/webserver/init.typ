#import "@preview/fletcher:0.5.3": diagram, node, edge

#import "../../../book.typ": book-page

#show: book-page.with(title: "webserver")

= 什么是WebServer

*引用AI的回答：一个 Web 服务器（Web server）是一个软件和硬件的结合体，负责处理通过 HTTP（超文本传输协议）
或 HTTPS（安全超文本传输协议）传输的网页请求。Web 服务器的主要功能是存储、处理和传递网站和网页内容给用户
的浏览器，从而使用户能够访问和浏览网站。*

#align(center)[
  #diagram(
    node(
      pos: (0, 0),
      label: [客户端浏览器]
    ),
    edge(
      (0, 0), (0, 1),
      "-|>",
      bend: -10deg,
      label: [HTTP请求],
    ),
    edge(
      (0, 1), (0, 0),
      "-|>",
      bend: -10deg,
      label: [HTTP响应],
    ),
    node(
      pos: (0, 1),
      label: [Web服务器]
    ),
  )
]

= 高性能网络模式

基于I/O多路复用，做了一层封装，就有了以下两种模式：
+ *Reactor*
+ *Proactor*
详细见#link("https://www.xiaolincoding.com/os/8_network_system/reactor.html")[高性能网络模式：*Reactor* 和 *Proactor*]。

= 整体框架

采用*Reactor*模式，基于`epoll`。

#align(center)[
  #diagram(
    node(
      pos: (0, 0),
      label: [WebServer]
    )
  )
]
