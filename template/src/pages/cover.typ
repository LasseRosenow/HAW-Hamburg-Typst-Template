#let cover_page(
  title: "",
  author: "",
  faculty: "",
  department: "",
  study-course: "",
  document-type: none,
  supervisors: (),
  submission-date: none,
) = {
  // Set the document's basic properties.
  set page(
    margin: (left: 0mm, right: 0mm, top: 0mm, bottom: 0mm),
    numbering: none,
    number-align: center,
  )

  // HAW Logo
  place(
    top + right,
    dx: -13mm,
    dy: 10mm,
    image("../assets/logo.svg", width: 164pt)
  )

  // Title etc.
  pad(
    left: 57mm,
    top: 66mm,
    right: 18mm,
    stack(
      // Type
      if document-type != none {
        upper(text(document-type, size: 9pt, weight: "bold"))
        v(2mm)
      },
      // Author
      text(author, size: 9pt),
      v(13mm),
      // Title
      par(
        leading: 9pt,
        text(title, size: 31pt, weight: 500, font: "New Computer Modern"),
      ),
      v(5mm),
      line(start: (0pt, 0pt), length: 30pt, stroke: 1mm),
      v(12mm),
      // Faculty
      text("Faculty of " + faculty, size: 10pt, weight: "bold"),
      v(2mm),
      // Department
      text("Department " + department, size: 10pt),
    )
  )

  // University name text
  place(
    right + bottom,
    dx: -11mm,
    dy: -35mm,
    box(
      align(
        left,
        stack(
          line(start: (0pt, 0pt), length: 25pt, stroke: 0.9mm),
          v(3mm),
          text("HOCHSCHULE FÜR ANGEWANDTE", size: 9pt, weight: "bold", font: "Open Sans"),
          v(2mm),
          text("WISSENSCHAFTEN HAMBURG", size: 9pt, weight: "bold", font: "Open Sans"),
          v(2mm),
          text("Hamburg University of Applied Sciences", size: 9pt, font: "Open Sans"),
        )
      )
    )
  )

  // Second cover page
  pagebreak()

  // Set the document's basic properties.
  set page(
    margin: (left: 31.5mm, right: 32mm, top: 66mm, bottom: 67mm),
    numbering: none,
    number-align: center,
  )

  // Title etc.
  stack(
    // Author
    upper(text(author, size: 10pt, weight: "bold")),
    v(13mm),
    // Title
    par(
      leading: 13pt,
      text(title, size: 23.3pt, weight: 900, font: ""),
    ),
    v(5mm),
    line(start: (0pt, 0pt), length: 30pt, stroke: 1mm),
    v(12mm),
    
    // Content
    stack(
      spacing: 3mm,
      text("Bachelor thesis submitted for examination in Bachelor´s degree"),
      text("in the study course " + study-course),
      text("at the Department " + department),
      text("at the Faculty of " + faculty),
      text("at University of Applied Science Hamburg"),
    )
  )

  v(1fr)

  // Supervision
  stack(
    if supervisors.len() > 0 {
      if type(supervisors) != array {
        text("Supervising examiner: " + text(upper(supervisors), weight: "bold"), size: 10pt)
      } else {
        text("Supervising examiner: " + text(upper(supervisors.first()), weight: "bold"), size: 10pt)

        if supervisors.len() > 1 {
          linebreak()
          text("Second examiner: " + text(upper(supervisors.at(1)), weight: "bold"), size: 10pt)
        }
      }
    },
  
    // Submission date
    if submission-date != none {
      stack(
        v(4mm),
        line(start: (0pt, 0pt), length: 25pt, stroke: 1mm),
        v(4mm),
        text(
          "Submitted: " + submission-date.display("[day]. [month repr:long] [year]"),
          size: 10pt,
        ),
      )
    },
  )
}
