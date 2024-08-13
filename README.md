# HAW Typst Template

This is a template for writing a report or thesis in the HAW Hamburg corporate design using `typst`.

## How to Compile

This project contains an example setup that splits individual chapters into different files.\
This can cause problems when using references etc.\
These problems can be avoided by following these steps:

- Make sure to always compile your `main.typ` file which includes all of your chapters for references to work correctly.
- VSCode:
  - Install the [Tinymist Typst](https://marketplace.visualstudio.com/items?itemName=myriad-dreamin.tinymist) extension
  - Make sure to start the `PDF` or `Live Preview` only from within your `main.typ` file.
  - If problems occur it usually helps to close the preview and restart it from your `main.typ` file.
