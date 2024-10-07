#import "../translations.typ": translations

#context {
  if query(figure.where(kind: image)).len() > 0 {
    heading(translations.list-of-figures, numbering: none)
    outline(
      title: none, 
      indent: true,
      fill: repeat(text(". ")),
      target: figure.where(kind: image), 
    )
  }
}