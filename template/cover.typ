#let cover_page(
  title: "",
  author: "",
  faculty: "",
  department: "",
  document-type: none,
  supervisors: (),
  submission-date: none,
) = {
  // Set the document's basic properties.
  set page(
    margin: (left: 0mm, right: 0mm, top: 0mm, bottom: 0mm),
    numbering: "1",
    number-align: center,
  )

  // HAW Logo
  align(
    right, 
    pad(
      top: 5mm,
      right: 8mm,
      image("assets/logo.svg", width: 192pt)
    )
  )

  pad(
    left: 57mm,
    top: 30.6mm,
    right: 25mm,
    stack(
      // Type
      if document-type != none {
        upper(text(document-type, size: 10pt))
        v(2mm)
      },
      // Author
      text(author, size: 10pt),
      v(13mm),
      // Title
      par(
        leading: 9pt,
        text(title, size: 31pt, weight: 500),
      ),
      v(5mm),
      line(start: (-6pt, 0pt), length: 33pt, stroke: 1mm),
      v(15mm),
      // Faculty
      text("Faculty of " + faculty, size: 10pt),
      v(2mm),
      // Department
      text("Department " + department, size: 10pt),
    )
  )

  v(1fr)

  pad(
    left: 20mm,
    stack(
      // Supervision
      if supervisors.len() > 0 {
        text("Supervision: " + supervisors, font: "New Computer Modern Sans", size: 12pt)
      },
      v(1.5mm),
    
      // Submission date
      if submission-date != none {
        text(
          "Submitted: " + submission-date.display("[day]. [month repr:long] [year]"), 
          font: "New Computer Modern Sans",
          size: 12pt,
        )
      },
    )
  )  

  // University name text
  align(
    right,
    pad(
      right: 13mm,
      box(
        align(
          left,
          stack(
            line(start: (-3pt, 0pt), length: 30pt, stroke: 0.9mm),
            v(3.5mm),
            text("HOCHSCHULE FÜR ANGEWANDTE", size: 9pt),
            v(1.5mm),
            text("WISSENSCHAFTEN HAMBURG", size: 9pt),
            v(2.5mm),
            text("Hamburg University of Applied Sciences", size: 9pt),
          )
        )
      )
    )
  )

  v(37mm)
}
