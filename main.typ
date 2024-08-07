#import "template/main.typ": config

// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: config.with(
  title: "Towards Gardening",
  author: "Musterblume",
  abstract: none,
  faculty: "Engineering and Computer Science",
  department: "Computer Science",
  document-type: none,
  supervisors: ("Prof. Dr. Musterhummel"),
  submission-date: datetime(year: 1948, month: 12, day: 10),
)

#include "chapters/01_preamble.typ"
#include "chapters/02_article_1.typ"

#bibliography("bibliography.bib")