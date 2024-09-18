#let report(
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
  import "src/template.typ": template
  template(
    title: title,
    abstract: abstract,
    author: author,
    faculty: faculty,
    department: department,
    document-type: document-type,
    supervisors: supervisors,
    submission-date: submission-date,
    pagebreak-per-chapter: false,
    include-declaration-of-independent-processing: include-declaration-of-independent-processing,
    body,
  )
}

#let thesis(
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
  import "src/template.typ": template
  template(
    title: title,
    abstract: abstract,
    author: author,
    faculty: faculty,
    department: department,
    document-type: document-type,
    supervisors: supervisors,
    submission-date: submission-date,
    pagebreak-per-chapter: true,
    include-declaration-of-independent-processing: include-declaration-of-independent-processing,
    body,
  )
}