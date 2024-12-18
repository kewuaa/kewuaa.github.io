
#import "@preview/shiroa:0.1.2": *

#show: book

#book-meta(
  title: "Kewuaa-Blog",
  authors: ("kewuaa",),
  summary: [
    #prefix-chapter("introduction.typ")[Introduction]
  ]
)

#build-meta(dest-dir: "../dist")



// re-export page template
#import "templates/page.typ": project
#let book-page = project
