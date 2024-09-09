#import "cover.typ": cover_page
#import "abstract.typ": abstract_page
#import "outline.typ": outline_page
#import "declaration_of_independent_processing.typ": declaration_of_independent_processing

#let config(
  title: "",
  abstract: none,
  author: "",
  faculty: "",
  department: "",
  document-type: none,
  supervisors: (),
  submission-date: none,
  pagebreak-per-chapter: false,
  include-declaration-of-independent-processing: false,
  body,
) = {
  // Set the document's basic properties.
  set document(author: author, title: title, date: submission-date)
  set page(
    margin: (left: 31.5mm, right: 31.5mm, top: 30mm, bottom: 56mm),
    numbering: "i",
    number-align: right,
    binding: left,
  )
  set par(leading: 9pt)
  set text(font: "Latin Modern Roman", lang: "en", size: 10.85pt)
  set heading(
    numbering: "1.1", 
  )
  // Configure correct spacing between headings and headings or paragraphs
  show heading: h => {
    let top_margin = 0pt   
    let bottom_margin = 0pt
    let text_counter = text(counter(heading).display())
    let text_body = text(h.body)

    if h.level == 1 {
      text_counter = text(counter(heading).display(), font: "New Computer Modern 08", size: 21pt, weight: 600)
      text_body = text(h.body, font: "New Computer Modern 08", size: 21pt, weight: 600)

      if pagebreak-per-chapter {
        // New page if configured
        pagebreak(weak: true)
        top_margin = 104pt
      } else if here().position().y > 90pt {
        // Only apply this when the header is not at the top of the page
        top_margin = 20pt
      }

      bottom_margin = 20pt
    } else if h.level == 2 {
      text_counter = text(counter(heading).display(), size: 14pt)
      text_body = text(h.body, size: 14pt)

      top_margin = 20pt
      bottom_margin = 20pt
    } else {
      text_counter = text(counter(heading).display(), size: 9pt)
      text_body = text(h.body, size: 10pt)

      top_margin = 20pt
      bottom_margin = 20pt
    }

    // Draw headings
    v(top_margin)
    if h.numbering != none {
      grid(
        columns: 2,
        gutter: 10pt,
        text_counter,
        text_body
      )
    } else {
      text_body
    }
    v(bottom_margin)
  }

  // Cover
  cover_page(
    title: title,
    author: author,
    faculty: faculty,
    department: department,
    document-type: document-type,
    supervisors: supervisors,
    submission-date: submission-date,
  )

  // Abstract
  if abstract != none {
    abstract_page(
      abstract: abstract,
    )
  }

  // Table of contents.
  outline_page()

  // Reset page numbering and set it to numbers
  set page(
    numbering: "1",
  )
  counter(page).update(1)

  // Main body.
  set par(justify: true)

  body

  // Declaration of independent processing
  if include-declaration-of-independent-processing {
    declaration_of_independent_processing()
  }
}
