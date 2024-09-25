// Import dependencies such as glossaries etc.
#import "dependencies.typ": *

// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#import "../../template/main.typ": thesis
#show: thesis.with(
  language: "en",

  title_de: "Entwicklung und Aufbau\neines mikrorechnergesteuerten Bestückungsautomaten",
  keywords_de: ("Leben", "Universum", "Alles"),
  abstract_de: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit.
Ut purus elit, vestibulum ut, placerat ac, adipiscing vitae,
felis. Curabitur dictum gravida mauris. Nam arcu lib
ero, nonummy eget, consectetuer id, vulputate a, magna.",

  title_en: "Runtime configuration of
constrained devices via a
shared operating system
module",
  keywords_en: ("Life", "Universe", "Everything"),
  abstract_en: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit.
Ut purus elit, vestibulum ut, placerat ac, adipiscing vitae,
felis. Curabitur dictum gravida mauris. Nam arcu lib
ero, nonummy eget, consectetuer id, vulputate a, magna.",

  author: "Martin Musterman",
  faculty: "Engineering and Computer Science",
  department: "Computer Science",
  study-course: "Bachelor of Science Informatik Technischer Systeme",
  document-type: "Bachelor thesis",
  supervisors: ("Prof. Dr. Example", "Prof. Dr. Example"),
  submission-date: datetime(year: 1948, month: 12, day: 10),
  include-declaration-of-independent-processing: true,
)

// Enable glossary
// Use: #gls("key") or #glspl("key") to reference and #print-glossary to print it
// More documentation: https://typst.app/universe/package/glossarium/
#show: make-glossary

// Include chapters of thesis
#include "chapters/01_preamble.typ"
#include "chapters/02_article_1.typ"
#include "chapters/03_article_2.typ"

// Print glossary
#pagebreak(weak: true)
#include "glossary.typ"

// Print bibliography
#pagebreak(weak: true)
#bibliography("bibliography.bib", style: "../../template/src/assets/ieeetran.csl")
