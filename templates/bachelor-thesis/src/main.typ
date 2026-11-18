#import "@preview/haw-hamburg:0.11.0": bachelor-thesis, declaration-of-independent-processing

// Register abbreviations and glossary
#import "dependencies.typ": make-glossary, print-glossary, register-glossary
#show: make-glossary
// Abbreviations
#import "abbreviations.typ": abbreviations-entry-list
#register-glossary(abbreviations-entry-list)
// Glossary
#import "glossary.typ": glossary-entry-list
#register-glossary(glossary-entry-list)

// Initialize template
#show: bachelor-thesis.with(
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
  faculty: "Computer Science and Digital Society",
  study-course: "Bachelor of Science Informatik Technischer Systeme",
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
    bibliography("bibliography.bib", style: "./ieeetran.csl")

    // Appendix: chapters are lettered (A, A.1, A.2 etc.)
    {
      set heading(numbering: "A.1", supplement: [Appendix])
      counter(heading).update(0)
      // Figures and tables are numbered per appendix chapter (Figure A1, Table A1 etc.)
      // Reset it
      show heading.where(level: 1): it => {
        for kind in (image, table, raw) { counter(figure.where(kind: kind)).update(0) }
        it
      }
      // Build new numbering scheme
      set figure(numbering: n => numbering("A", counter(heading).get().first()) + str(n))
      include "chapters/appendix.typ"
    }

    // Declaration of independent processing (comment out to disable)
    declaration-of-independent-processing
  },
)

// Include chapters of thesis
#pagebreak(weak: true)
#include "chapters/01_introduction.typ"
#include "chapters/02_background.typ"
