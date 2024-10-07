#import "../translations.typ": translations

#context {
  if query(figure.where(kind: table)).len() > 0 {
    heading(translations.list-of-tables, numbering: none)
    outline(
      title: none,
      indent: true,
      fill: repeat(text(". ")),
      target: figure.where(kind: table),
    )
  }
}