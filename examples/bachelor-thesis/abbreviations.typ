#let abbreviations-entry-list = (
    cpu: (
      short: "CPU",
      long: "Central Processing Unit",
    ),
)

// Add all entries to the "Abbreviation" group
#for key in abbreviations-entry-list.keys() {
  abbreviations-entry-list.at(key).insert("group", "Abbreviations")
}
