{CompositeDisposable} = require 'atom'
jsbeautify = (require 'js-beautify').js_beautify
cssbeautify = (require 'js-beautify').css
htmlbeautify = (require 'js-beautify').html
indentString = require('indent-string')

module.exports = VueFormat =
  vueFormatView: null
  modalPanel: null
  subscriptions: null

  config:
    IndentStartTag:
      title: 'Indent Wrap'
      description: 'indent wrap scoped area a tabsize'
      type: 'boolean'
      default: true
    wrapExtraLine:
      title: 'Wrap add extra line'
      description: 'add a extra newline between wrap scoped area'
      type: 'boolean'
      default: false
    Sort:
      title: 'Sort Wrap Area'
      type: 'array'
      default: ['html', 'js', 'css']
      description: "Rearrange according to the order when formated success, only: `html` `js` `css`\n !if not fill in, it will lost"
    General:
      type: 'object'
      title: 'Code style'
      properties:
        UseTab:
          title: 'Use Tab'
          type: 'boolean'
          default: false
        TabSize:
          title: 'Tab/Space Size'
          type: 'integer'
          default: 2
          minimum: 0
        WrapLine:
          title: 'Wrap Line Length'
          type: 'integer'
          default: 120
          minimum: 0

  activate: (state) ->

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'vue-format:format': => @format()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @vueFormatView.destroy()

  serialize: ->


  options: (type) ->
    defalutConfig = {
      def: {
        "indent_size": atom.config.get('vue-format.General.TabSize'),
        "indent_char": if atom.config.get('vue-format.General.UseTab') then '	' else " ",
        "indent_with_tabs": atom.config.get('vue-format.General.UseTab'),
        "wrap_line_length": atom.config.get('vue-format.General.WrapLine'),
        "preserve_newlines": true,
        "max_preserve_newlines": 2
      }
      html: {
        "wrap_attributes": "auto"
      },
      js: {
        "space_before_conditional": true,
        "space_after_anon_function": false,
        "brace_style": "collapse,preserve-inline"
      },
      css: {}
    }

    if type
      return Object.assign({},defalutConfig['def'], defalutConfig[type])
    else
      return {}

  format: (state) ->
    self = this
    editor = atom.workspace.getActiveTextEditor()
    text = editor.getText()
    newTextArr = []

    sortOrder = atom.config.get('vue-format.Sort')
    sortOrder.forEach((val, index) ->
      newText = self.replaceText(text, val)
      newTextArr.push(newText)
    )
    editor.setText(newTextArr.join('\n\n'))

  replaceText: (text, type) ->
    self = this
    regObj = {
      html: /<template(\s|\S)*>(\s|\S)*<\/template>/gi,
      js: /<script(\s|\S)*>(\s|\S)*<\/script>/gi,
      css: /<style(\s|\S)*>(\s|\S)*<\/style>/gi,
    }
    beautify = {
      html: htmlbeautify,
      js: jsbeautify,
      css: cssbeautify
    }
    contentRex = />(\s|\S)*<\//g

    if regObj[type].exec(text)
      console.log regObj[type].exec(text)
      typeText = regObj[type].exec(text)[0]
    else
      return ''

    if typeText
      typeTextCon = contentRex.exec(typeText)[0]
      typeContent = typeTextCon.substring(1).substr(0,typeTextCon.length - 3)
      typeArr = typeText.split(typeContent)

      formatOptions = self.options(type)
      beautifiedText = beautify[type](typeContent, formatOptions)

      isIndent = atom.config.get('vue-format.IndentStartTag')
      isExtraLine = atom.config.get('vue-format.wrapExtraLine')
      resultText = if isIndent then indentString(beautifiedText, formatOptions['indent_size'], {indent: formatOptions['indent_char']}) else beautifiedText
      #
      # console.log resultText
      if isExtraLine
        return typeArr[0] + '\n\n' + resultText + '\n\n' + typeArr[1]
      else
        return typeArr[0] + '\n' + resultText + '\n' + typeArr[1]
    else
      return ''
