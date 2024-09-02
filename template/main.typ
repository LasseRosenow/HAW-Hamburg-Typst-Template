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
  set text(font: "New Computer Modern", lang: "en")
  set heading(
    numbering: "1.1 "
  )
  // Configure correct spacing between headings and headings or paragraphs
  show heading.where(): h => {
    if h.level == 1 {
      pagebreak(weak: true)
    }
    v(10pt)
    h
    v(15pt)
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
