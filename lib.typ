#let project(
  title: "",
  authors: (),

  details: "5E, min. 5 players",
  titleBackground: none,

  font: "Source Sans Pro",

  body
) = {
  // Setup
  
  set document(title: title, author: authors.map(a => a.name))
  set page(numbering: "1", number-align: center)

  set text(font: font, lang: "en", size: 12pt)

  set par(spacing: 1.2em)

  set heading(numbering: "1.a.i")

  // Title page

  set page(background: titleBackground)

  v(1fr)
  
  box(
    fill: white, 
    radius: 1em,
    inset: 1em,
    [
      #text(1em, weight: 500, "Dungeons and Dragons /")
      #v(1.1em, weak: true)
      
      #text(2em, weight: 700, title)
      #h(1em)
      #text(details)
    
      #v(1.2em)
    
      #pad(
        top: 0.7em,
        right: 20%,
        grid(
          columns: (1fr,) * calc.min(3, authors.len()),
          gutter: 1em,
          ..authors.map(author => align(start)[
            *#author.name* \
            #author.affiliation
          ]),
        ),
      )
    ]
  )

  v(4fr)
  set page(background: none)
  pagebreak()

  // Contents page
  outline(depth: 3, indent: true)
  pagebreak()


  // Main body.
  set par(justify: true)
  set text(hyphenate: false)
  set list(marker: ([•], [◦], [‣], [⁃]))
  
  body
}