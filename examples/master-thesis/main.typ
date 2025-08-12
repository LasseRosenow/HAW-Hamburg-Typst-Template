// Register abbreviations and glossary
#import "dependencies.typ": make-glossary, print-glossary, register-glossary
#show: make-glossary
// Abbreviations
#import "abbreviations.typ": abbreviations-entry-list
#register-glossary(abbreviations-entry-list)
// Glossary
#import "glossary.typ": glossary-entry-list
#register-glossary(glossary-entry-list)

// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#import "../../lib/lib.typ": declaration-of-independent-processing, master-thesis
#show: master-thesis.with(
  language: "en",

  title-de: "Antwort auf die endgültige Frage nach dem Leben, dem Universum und dem ganzen Rest",
  keywords-de: ("Leben", "Universum", "Alles"),
  abstract-de: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit.
Ut purus elit, vestibulum ut, placerat ac, adipiscing vitae,
felis. Curabitur dictum gravida mauris. Nam arcu lib
ero, nonummy eget, consectetuer id, vulputate a, magna.",

  title-en: "Answer to the Ultimate Question of Life, the Universe, and Everything",
  keywords-en: ("Live", "Universe", "Everything"),
  abstract-en: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit.
Ut purus elit, vestibulum ut, placerat ac, adipiscing vitae,
felis. Curabitur dictum gravida mauris. Nam arcu lib
ero, nonummy eget, consectetuer id, vulputate a, magna.",

  author: "The Computer",
  faculty: "Engineering and Computer Science",
  department: "Computer Science",
  study-course: "Master of Science Computer Science",
  supervisors: ("Prof. Dr. Example", "Prof. Dr. Example"),
  submission-date: datetime(year: 1948, month: 12, day: 10),
  // Everything inside "before-content" will be automatically injected
  // into the document before the actual content starts.
  before-content: {
    // Print abbreviations
    pagebreak(weak: true)
    heading("Abbreviations", numbering: none)
    print-glossary(
      abbreviations-entry-list,
      disable-back-references: true,
    )
  },
  // Everything inside "after-content" will be automatically injected
  // into the document after the actual content ends.
  after-content: {
    // Print glossary
    pagebreak(weak: true)
    heading("Glossary", numbering: none)
    print-glossary(
      glossary-entry-list,
      disable-back-references: true,
    )

    // Print bibliography
    pagebreak(weak: true)
    bibliography("bibliography.bib", style: "../../lib/assets/ieeetran.csl")

    // Declaration of independent processing (comment out to remove)
    declaration-of-independent-processing
  },
)

// Include chapters of thesis
#pagebreak(weak: true)
#include "chapters/01_preamble.typ"
#include "chapters/02_articles.typ"
