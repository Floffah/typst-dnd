#let project(
  title: "",
  brand: ("Homebrew", "My Homebrew Campaign"),

  details: "5E, min. 3 players",
  titleBackground: none,

  body
) = {
  // Setup

  let headingColour = rgb("#7f1d1d")
  let rootHeadingColour = rgb("#eab308")
  let pageBackgroundColour =  rgb("#fffef7")
  let pageNumberColour = rgb("#b45309").transparentize(50%)
  
  show outline.entry: it => {
    if it.level == 1 {
      text(it.body, 1.5em, fill: headingColour, font: "Mr Eaves SC Remake")
      h(1fr)
      it.page
      v(6pt, weak: true)
      box(width: 1fr, line(length: 100%, stroke: rootHeadingColour))
      v(0pt, weak: true)
    } else if it.level == 2 {
      text(it.body, 1.3em, fill: headingColour, font: "Mr Eaves SC Remake")
      sym.space
      box(it.fill, width: 1fr)
      sym.space
      it.page
    } else {
      it
    }
  }

  show heading: it => {
    set text(size: 2em) if it.level == 1
    set text(size: 1.8em) if it.level == 2
    set text(size: 1.7em) if it.level == 3
    set text(size: 1.6em) if it.level == 4
    
    it

    if it.level == 4 {
      v(6pt, weak: true)
      box(width: 1fr, line(length: 100%, stroke: rootHeadingColour))
      v(8pt, weak: true)
    }
  }
  
  set document(title: title)
  set page(number-align: center)

  set text(font: "Bookinsanity Remake", lang: "en", size: 12pt)

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
  set text(hyphenate: false)
  set list(marker: ([•], [◦], [‣], [⁃]))

  show heading: set text(fill: headingColour, font: "Mr Eaves SC Remake")

  // Page numbering & chapter footer
  set page(
    footer: context {
      let pageNumber = counter(page).at(here()).at(0) + 1
      let evenPage = calc.rem(pageNumber, 2) == 0
      let headings = query(
        heading.where(level: 1, outlined: true).before(here())
      )

      let pageNumberText = text([#pageNumber], 15pt, fill: pageNumberColour, font: "Mr Eaves SC Remake")
      let alignText = right

      if (evenPage == true) {
        alignText = left
      }

      align(
        alignText,
        {
          if(evenPage) {
            pageNumberText
            h(1em)
          }
          
          if headings.len() > 0 {
            if (evenPage) {
              text("|", 10pt, fill: pageNumberColour)
              h(1em)
            }
            
            let currentChapter = headings.last()
    
            text(upper(currentChapter.body), 10pt, fill: pageNumberColour, font: "Mr Eaves SC Remake")

            if (not evenPage) {
              h(1em)
              text("|", 10pt, fill: pageNumberColour)
            }
          }

          if (not evenPage) {
            h(1em)
            pageNumberText
          }
        }
      )
    }
  )
  
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