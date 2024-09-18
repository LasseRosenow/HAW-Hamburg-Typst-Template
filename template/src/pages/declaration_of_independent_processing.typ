#let declaration_of_independent_processing() = {
  heading(
    outlined: true,
    numbering: none,
    bookmarked: true,
    "Declaration of Independent Processing",
  )

  text("I hereby certify that I wrote this work independently without any outside help and only used the resources specified. Passages taken literally or figuratively from other works are identified by citing the sources.")

  v(40pt)

  grid(
    columns: 3,
    gutter: 10pt,
    line(length: 85pt, stroke: 1pt),
    line(length: 85pt, stroke: 1pt),
    line(length: 150pt, stroke: 1pt),
    align(center, text("Place", size: 9pt)),
    align(center, text("Date", size: 9pt)),
    align(center, text("Original Signature", size: 9pt)),
  )
}