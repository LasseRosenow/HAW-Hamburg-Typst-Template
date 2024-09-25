# HAW Hamburg Typst Template

This is an **`unofficial`** template for writing a report or thesis in the `HAW Hamburg` department of `Computer Science` design using [Typst](https://github.com/typst/typst).

## How to Use

1. Copy the [template](./template/) folder into your project directory.
2. Include the `bachelor-thesis`, `master-thesis` or `report` function and use it using the following code:

```typst
#import "./template/main.typ": thesis, report
#show: report.with(
  language: "en",
  title: "Universal Declaration of Human Rights",
  author:"United Nations",
  faculty: "Engineering and Computer Science",
  department: "Computer Science",
  include-declaration-of-independent-processing: true,
)
```

## How to Compile

This project contains an example setup that splits individual chapters into different files.\
This can cause problems when using references etc.\
These problems can be avoided by following these steps:

- Make sure to always compile your `main.typ` file which includes all of your chapters for references to work correctly.
- VSCode:
  - Install the [Tinymist Typst](https://marketplace.visualstudio.com/items?itemName=myriad-dreamin.tinymist) extension.
  - Make sure to start the `PDF` or `Live Preview` only from within your `main.typ` file.
  - If problems occur it usually helps to close the preview and restart it from your `main.typ` file.

## Examples

Examples can be found inside of the [examples](./examples/) directory

- For Bachelor  theses see: [Bachelor thesis example](./examples/bachelor-thesis/)
- For Master theses see: [Master thesis example](./examples/master-thesis/)
- For reports see: [Report example](./examples/report/)
