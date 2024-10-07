#import "../translations.typ": translations

#context {
  if query(figure.where(kind: raw)).len() > 0 {
    heading(translations.listings, numbering: none)
    outline(
      title: none,      
      indent: true,
      fill: repeat(text(". ")),
      target: figure.where(kind: raw),
    )
  }
}