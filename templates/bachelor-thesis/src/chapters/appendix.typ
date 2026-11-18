= Appendix <appendix>

== Additional things
#lorem(100)

== Tools and Aids Used

#[
  #figure(
    caption: [Used aids and tools],
    kind: table,
    table(
      columns: (auto, auto),
      stroke: 0.4pt,
      inset: (x: 6pt, y: 4pt),
      align: left,
      fill: (_, y) => if y == 0 { luma(75%) },
      // should be similar to \rowcolor{lightgray}

      table.header([Tool], [Purpose of use]),

      [Typst], [Typesetting and layout tool used to create this document],
      [], [],
    ),
  ) <tab:tooling>
]
