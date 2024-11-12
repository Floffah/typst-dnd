#let project(
  title: "",
  brand: ("Homebrew", "My Homebrew Campaign"),

  details: "5E, min. 3 players",
  titleBackground: none,

  font: "Source Sans Pro",

  body
) = {
  // Setup

  let headingColour = rgb("#7f1d1d")
  let rootHeadingColour = rgb("#eab308")
  let pageBackgroundColour =  rgb("#fffef7")
  
  show outline.entry: it => {
    if it.level == 1 {
      text(it.body, 1.5em, fill: headingColour)
      h(1fr)
      it.page
      v(6pt, weak: true)
      box(width: 1fr, line(length: 100%, stroke: rootHeadingColour))
      v(0pt, weak: true)
    } else if it.level == 2 {
      text(it.body, 1.2em, fill: headingColour)
      box(it.fill, width: 1fr)
      it.page
    } else {
      it.body
      box(it.fill, width: 1fr)
      it.page
    }
  }
  
  set document(title: title)
  set page(numbering: "1", number-align: center)

  set text(font: font, lang: "en", size: 12pt)

  set par(spacing: 1.2em)

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

  set page(background: none, fill: pageBackgroundColour)
  pagebreak()

  // Global settings
  set par(justify: true)
  set text(hyphenate: false, font: "Bookinsanity Remake")
  set list(marker: ([•], [◦], [‣], [⁃]))

  show heading: set text(fill: headingColour, font: "Mr Eaves SC Remake")
  
  // Contents page
  align(center, heading("Contents", outlined: false, numbering: none))
  v(1em)
  columns(
    2,
    outline(depth: 3, indent: 1em, title: none)
  )
  
  pagebreak()


  // Main body.
  
  body
}