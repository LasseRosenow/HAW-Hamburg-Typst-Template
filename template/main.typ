#import "cover.typ": cover_page
#import "abstract.typ": abstract_page
#import "outline.typ": outline_page

#let config(
  title: "",
  abstract: none,
  author: "",
  faculty: "",
  department: "",
  document-type: none,
  supervisors: (),
  submission-date: none,
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
  counter(page).update(())

  // Main body.
  set par(justify: true)

  body
}