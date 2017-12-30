#vue-format package (https://github.com/LeslieYQ/vue-format)

```bash
apm install vue-format
```

Or Settings/Preferences ➔ Packages ➔ Search for `vue-format`

## Language Support

- [x] Vue, including html, css(not stylus, less, scss) , js (es6)

## Feature

![feature](http://ww3.sinaimg.cn/large/0060lm7Tly1fmyjsc5tujg30hn0lc49o.gif)

- Sort Your Code Area
- Indent Wrap
- Newline between Wrap

## Usage

It will beautify `.vue` file for html,css and js

### Shortcut

You can also type `ctrl-alt-v` as a shortcut or click `Packages > vue-format` in the menu.

#### Custom Keyboard Shortcuts

See [Keymaps In-Depth](https://atom.io/docs/latest/behind-atom-keymaps-in-depth) for more details.

For example:

```coffeescript
'.editor':
  'ctrl-alt-v': 'vue-format:format'
  'alt-l': 'vue-format:format'
```

## Configuration

*Formated Engine: js-beautify*

Some Options in `Setting`

Default options:

```json
{
  "indent_size": 2,
  "indent_char": " ",
  "other": " ",
  "indent_level": 0,
  "indent_with_tabs": false,
  "preserve_newlines": true,
  "max_preserve_newlines": 2,
  "jslint_happy": true,
  "indent_handlebars": true
}
```
See [examples/simple-jsbeautifyrc/.jsbeautifyrc](https://github.com/donaldpipowitch/atom-beautify/blob/master/examples/simple-jsbeautifyrc/.jsbeautifyrc).

## License

[MIT](https://github.com/LeslieYQ/vue-format/LICENSE.md) © [LeslieYQ yuqiu](https://github.com/LeslieYQ)
[Voodeng](https://github.com/voodeng)
