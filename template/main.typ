#let report(
  language: "en",
  title: "",
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
    is_thesis: false,
    is_report: true,

    language: language,
    
    title_de: "",
    keywords_de: none,
    abstract_de: none,

    title_en: none,
    keywords_en: none,
    abstract_en: none,

    author: author,
    faculty: faculty,
    department: department,
    study-course: none,
    document-type: document-type,
    supervisors: supervisors,
    submission-date: submission-date,
    pagebreak-per-chapter: false,
    include-declaration-of-independent-processing: include-declaration-of-independent-processing,
    body,
  )
}

#let thesis(
  language: "en",

  title_de: "",
  keywords_de: none,
  abstract_de: none,

  title_en: none,
  keywords_en: none,
  abstract_en: none,

  author: "",
  faculty: "",
  department: "",
  study-course: "",
  document-type: none,
  supervisors: (),
  submission-date: none,
  include-declaration-of-independent-processing: true,
  body,
) = {
  import "src/template.typ": template
  template(
    is_thesis: true,
    is_report: false,

    language: language,

    title_de: title_de,
    keywords_de: keywords_de,
    abstract_de: abstract_de,

    title_en: title_en,
    keywords_en: keywords_en,
    abstract_en: abstract_en,

    author: author,
    faculty: faculty,
    department: department,
    study-course: study-course,
    document-type: document-type,
    supervisors: supervisors,
    submission-date: submission-date,
    pagebreak-per-chapter: true,
    include-declaration-of-independent-processing: include-declaration-of-independent-processing,
    body,
  )
}