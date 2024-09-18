#let abstract_page(
  abstract: ""
) = {
  set page(
    margin: (left: 25mm, right: 25mm, top: 30mm, bottom: 30mm),
    numbering: "1",
    number-align: center,
  )
  
  v(1fr)
  
  align(center)[
    #heading(
      outlined: false,
      numbering: none,
      text(0.85em, smallcaps[Abstract]),
    )
    
    #abstract
  ]
  
  v(1.618fr)
}