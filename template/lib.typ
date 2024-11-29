#let heading-color = rgb("#7f1d1d")
#let root-heading-color = rgb("#eab308")
#let background-colour = rgb("#fffef7")
#let footer-colour = rgb("#b45309").transparentize(50%)
#let dialog-line-colour = rgb("#854d0e")

// A dungeons and dragons corebook-style home page
// Not the template, will not work if called with .with
#let dnd-title-page(
  // The title to show
  title: "",
  // (subtitle, brand-name). The official books use ("D&D", "Dungeons & Dragons")
  // Optional, can omit brand name too
  brand: ("Homebrew", "My Homebrew Campaign"),

  // The details portion at the bottom of the screen
  details: "5E, min. 3 players",

  // Background content to use
  // String path to image or any content
  background: none,
) = {
  // convert a path to an image
  if (background != none and type(background) == "string") {
    background = image(background, fit: "cover", width: 100%, height: 100%)
  }

  set page(background: background)
  set par(justify: false)

  // Get subtitle or apply default
  let subtitle = "Homebrew"

  if brand != none and brand.len() > 0 {
    subtitle = brand.at(0)
  }

  // Subtitle text
  align(
    center, 
    text(
      subtitle,
      3em,
      weight: 600,
      stroke: black + 1pt,
      fill: red,
      tracking: -2pt,
      font: "Nodesto Caps"
    )
  )
  // Title
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
  // Title underline
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

  // Brand region
  if brand != none and brand.len() >= 2 {
    // Brand background
    place(
      left,
      dx: -2.5cm,
      dy: -10em,
      image("./brand-background.png", width: 25em)
    )

    // Brand text
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

  // Details text
  align(
    center,
    text(
      details,
      2em,
      font: "Scaly Sans Remake",
      weight: 600,
      fill: white,
      stroke: black + 1.05pt,
      tracking: -1pt,
    )
  )
}

#let dialog-block(body) = context {
  let circle-radius = 2pt
  
  let content_box = box(
    fill: black.transparentize(95%),
    inset: 12.5pt,
    width: 100%,
    body
  )
  let content-box-measurements = measure(body)
  let box-height = content-box-measurements.height + 25pt

  let dialog-circle = circle(
    radius: circle-radius,
    fill: dialog-line-colour
  )
  
  box({
    // circle top left
    place(
      dialog-circle,
      dy: -circle-radius,
      dx: -circle-radius
    )
    // line left
    place(
      line(
        start: (0pt, 0pt), 
        end: (0pt, box-height),
        stroke: 1.5pt + dialog-line-colour,
      )
    )
    // circle bottom left
    place(
      dialog-circle,
      dy: box-height - circle-radius,
      dx: -circle-radius
    )

    // circle top right
    place(
      dialog-circle,
      dy: -circle-radius,
      dx: 100% - circle-radius
    )
    // line right
    place(
      line(
        start: (0pt, 0pt), 
        end: (0pt, box-height),
        stroke: 1.5pt + dialog-line-colour,
      ),
      dx: 100%
    )
    // circle bottom right
    place(
      dialog-circle,
      dy: box-height - circle-radius,
      dx: 100% - circle-radius
    )
    
    content_box
  })
}

// Dungeons and dragons styling and title page for Typst
// Use with .with like `#show: dnd-template.with(...)`
#let dnd-template(
  // Document title
  title: "",
  // (subtitle, brand-name). The official books use ("D&D", "Dungeons & Dragons")
  // Optional, can omit brand name too
  brand: ("Homebrew", "My Homebrew Campaign"),

  // The details portion at the bottom of the screen
  details: "5E, min. 3 players",
  // Background content to use
  // String path to image or any content
  title-background: none,

  // Document content
  body
) = {
  // Set page size
  set page(paper: "uk-quarto", margin: (x: 0.625in, y: 0.6in))

  // Style table of contents
  show outline.entry: it => {
    if it.level == 1 {
      v(1em)
      text(it.body, 1.5em, fill: heading-color, font: "Mr Eaves SC Remake") // Heading
      h(1fr) // Fill remaining space to align pagenum right
      it.page // page number
      v(6pt, weak: true)
      box(width: 1fr, line(length: 100%, stroke: root-heading-color)) // underline
      v(0pt, weak: true)
    } else if it.level == 2 {
      text(it.body, 1.3em, fill: heading-color, font: "Mr Eaves SC Remake") // heading
      sym.space
      box(it.fill, width: 1fr) // Fill empty space with repeating periods
      sym.space
      it.page // page number
    } else {
      it
    }
  }

  // Style headings
  show heading: it => {
    set text(size: 2em) if it.level == 1
    set text(size: 1.8em) if it.level == 2
    set text(size: 1.7em) if it.level == 3
    set text(size: 1.6em) if it.level == 4

    // Ensure all chapters start on their own page
    if it.level == 1 {
      pagebreak(weak: true)
    }

    v(1em, weak: true)
    
    it

    // Give level 4 headings and underline
    if it.level == 4 {
      v(6pt, weak: true)
      box(width: 1fr, line(length: 100%, stroke: root-heading-color))
      v(8pt, weak: true)
    }
  }

  // Setup document content
  set document(title: title)
  set page(number-align: center, background: none, fill: background-colour)
  
  set text(font: "Bookinsanity Remake", lang: "en", size: 12pt, hyphenate: false)
  show link: set text(fill: heading-color)
  show heading: set text(fill: heading-color, font: "Mr Eaves SC Remake")
  
  set par(spacing: 1.2em, justify: true)
  set list(marker: ([•], [◦], [‣], [⁃]))

  // Title page
  dnd-title-page(title: title, brand: brand, details: details, background: title-background)
  pagebreak()

  // Page numbering & chapter footer
  set page(
    footer: context {
      // get context
      let page-number = counter(page).at(here()).at(0)
      let is-even-page = calc.rem(page-number, 2) == 0
      let headings = query(
        heading.where(level: 1, outlined: true).before(here())
      )

      let page-number-text = text([#page-number], 15pt, fill: footer-colour, font: "Mr Eaves SC Remake")
      let footer-alignment = right

      // make sure pages alternate in alignment
      if (is-even-page == true) {
        footer-alignment = left
      }

      // get page number that the heading is on
      let page-number-of-chapter-heading = none

      if headings.len() > 0 {
        page-number-of-chapter-heading = counter(page).at(headings.last().location()).at(0)
      }

      align(
        footer-alignment,
        {
          if is-even-page {
            page-number-text
            h(1em)
          }

          // if this footer is within a chapter & its not on the same page, show chapter name
          if headings.len() > 0 and page-number-of-chapter-heading != page-number {
            // paste preceding chapter separator on even pages
            if is-even-page {
              text("|", 10pt, fill: footer-colour)
              h(1em)
            }

            // get chapter & write it to the page
            let chapter = headings.last()
            text(upper(chapter.body), 10pt, fill: footer-colour, font: "Mr Eaves SC Remake")

            // paste succeeding chapter separator on even pages
            if not is-even-page {
              h(1em)
              text("|", 10pt, fill: footer-colour)
            }
          }

          // paste page number text right on odd pages
          if not is-even-page {
            h(1em)
            page-number-text
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


  // Main body
  body
}
