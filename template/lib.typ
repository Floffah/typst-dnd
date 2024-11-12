#let project(
  title: "",
  brand: ("Homebrew", "My Homebrew Campaign"),

  details: "5E, min. 3 players",
  titleBackground: none,

  font: "Source Sans Pro",

  body
) = {
  // Setup
  
  set document(title: title)
  set page(numbering: "1", number-align: center)

  set text(font: font, lang: "en", size: 12pt)

  set par(spacing: 1.2em)

  set heading(numbering: "1.a.i")

  // Title page

  if (titleBackground != none and type(titleBackground) == "string") {
    titleBackground = image(titleBackground, fit: "cover", width: 100%, height: 100%)
  }
  
  set page(background: titleBackground)

  let smallBrand = "Homebrew"

  if brand != none and brand.len() > 0 {
    smallBrand = brand.at(0)
  }
  
  align(
    center, 
    text(
      smallBrand,
      3em,
      weight: 600,
      stroke: black + 1pt,
      fill: red,
      tracking: -2pt,
      font: "Nodesto Caps"
    )
  )
  v(1em, weak: true)
  align(
    center, 
    text(
      upper(title), 
      7em, 
      weight: 800,
      stroke: black + 2.5pt, 
      fill: white, 
      font: "Nodesto Caps",
      tracking: -5pt,
    )
  )
  v(1em, weak:true)
  align(
    center,
    box(
      width: 70%,
      height: 8pt,
      polygon(
        fill: red.transparentize(20%),
        stroke: black.transparentize(50%) + 1.5pt,
        (0%, 60%),
        (0%, 40%),
        (50%, 0%),
        (100%, 40%),
        (100%, 60%),
        (50%, 100%)
      )
    )
  )

  v(1fr)

  if brand != none and brand.len() >= 2 {
    place(
      left,
      dx: -2.5cm,
      dy: -10em,
      image("./brand-background.png", width: 25em)
    )

    place(
      left,
      dx: -2.5cm,
      dy: -7.5em,
      box(
        width: 17em,
        align(
          right,
          text(
            upper(brand.at(1)),
            1.5em,
            fill: white,
            font: "Nodesto Caps",
            weight: 600
          )
        )
      )
    )
  }

  align(
    center,
    text(
      details,
      2em,
      font: "Scaly Sans Remake",
      weight: 600,
      fill: white,
      stroke: black + 1.05pt,
      tracking: -1pt
    )
  )

  // v(4fr)
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