// Import dependencies such as glossaries etc.
#import "dependencies.typ": *

// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#import "../../lib/lib.typ": report
#show: report.with(
  language: "en",
  title: "Universal Declaration of Human Rights",
  author:"United Nations",
  faculty: "Engineering and Computer Science",
  department: "Computer Science",
  include-declaration-of-independent-processing: true,
)

// Enable glossary
// Use: @key or @key:pl to reference
// More documentation: https://typst.app/universe/package/glossy
#import "abbreviations.typ": abbreviations-entry-list
#import "glossary.typ": glossary-entry-list
#show: init-glossary.with(abbreviations-entry-list)
#show: init-glossary.with(glossary-entry-list)

// Print abbreviations
#pagebreak(weak: true)
#{
  set heading(numbering: none)
  glossary(title: "Abbreviations", groups: "Abbreviations")
}

// Include chapters of report
#pagebreak(weak: true)
#include "chapters/01_preamble.typ"
#include "chapters/02_articles.typ"
#include "chapters/03_example.typ"

// Print glossary
#pagebreak(weak: true)
#{
  set heading(numbering: none)
  glossary(title: "Glossary", groups: "")
}

// Print bibliography
#pagebreak(weak: true)
#bibliography("bibliography.bib", style: "../../lib/assets/ieeetran.csl")
