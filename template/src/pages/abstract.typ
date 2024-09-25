#let abstract_page(
  abstract_de: "",
  abstract_en: "",
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
    
    #abstract_de
  ]
  
  v(1.618fr)
}