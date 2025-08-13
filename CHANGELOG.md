# Changelog

## 0.6.1

- Abstract: Fix case where only one keyword exists (#5) Thanks @AnnsAnns!

## 0.6.0

- Update glossarium to 0.5.8
- Add `before-content` and `after-content` properties to inject `abbreviations` or `glossaries` before and after the content letting them use the page counter before the actual content
- Expose `declaration-of-independent-processing` page
- **Breaking:**\
  Remove `include-declaration-of-independent-processing` property. Please import `declaration-of-independent-processing` from this library and put it into `after-content` or wherever you want it to be.

## 0.5.1

- Remove leftover deprecated use of `fill` and `indent: true` inside the outline

## 0.5.0

- Add optional supervisor to report template
- Add optional submission date to report template

## 0.4.0

- Support typst 0.13.0
- Simplify header styles and add margin collapse

## 0.3.3

- Simplify outline implementation
- Remove deprecated use of "label" and outline(indent: true)

## 0.3.2

- Fix wrong counter in page-header for reports
- Improve spacing between headers for reports

## 0.3.1

- Fix typst 0.12 compatibility
- Update glossarium to 0.5.1

## 0.3.0

- Fixed documentation pointing to an outdated version of the template
- Added dedicated template packages for `report`, `bachelor-thesis` and `master-thesis`

## 0.2.0

- Improved Readme documentation around fonts
- Added `List of Figures` page
- Added `List of Tables` page
- Added `Listings` page
- Added abbreviations to the template
- Fixed header showing chapter with number "0" for chapters without numbering

## 0.1.0

Initial release
