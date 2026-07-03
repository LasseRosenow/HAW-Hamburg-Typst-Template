// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#import "../../lib/lib.typ": expose
#show: expose.with(
  language: "en",
  title: "Answer to the Ultimate Question of Life, the Universe, and Everything",
  keywords: ("Life", "Universe", "Everything"),
  author: "The Computer",
  faculty: "Computer Science and Digital Society",
  supervisors: ("Prof. Dr. Example", "Prof. Dr. Example"),
  submission-date: datetime(year: 1948, month: 12, day: 10),
  // Everything inside "after-content" will be automatically injected
  // into the document after the actual content ends.
  after-content: {
    // Print bibliography
    pagebreak(weak: true)
    bibliography("bibliography.bib", style: "../../lib/assets/ieeetran.csl")
  },
)

// Include chapters of expose
#include "chapters/01_introduction.typ"
#include "chapters/02_objectives.typ"
#include "chapters/03_approach.typ"
#include "chapters/04_schedule.typ"
