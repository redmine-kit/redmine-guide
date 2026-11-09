---
source: RedmineMacros
source_url: https://www.redmine.org/projects/redmine/wiki/RedmineMacros
source_version: 3
source_updated_on: '2012-10-17T20:35:48Z'
---

# Macros

Redmine includes a macros system that lets you add custom functions to insert dynamic content in formatted text.

## Invoking macros in formatted text

Macros are invoked using double curly brackets. Arguments must be enclosed in parenthesis if any. A new line after the macro name or the arguments starts the block of text that will be passed to the macro (invoking a macro that do not accept a block of text with some text will fail).

Examples:

    No arguments:
    {{my_macro}}

    With arguments:
    {{my_macro(arg1, arg2)}}

    With a block of text:
    {{my_macro
    multiple lines
    of text
    }}

    With arguments and a block of text
    {{my_macro(arg1, arg2)
    multiple lines
    of text
    }}

If a block of text is given, the closing tag `}}` must be at the start of a new line.

## Adding custom macros

Custom macros can be added from a Redmine plugin using the following syntax:

    <code class="ruby">
    Redmine::WikiFormatting::Macros.macro(name, options={}, &block)
    </code>

Options:

- `:desc` - A description of the macro
- `:parse_args => false` - Disables arguments parsing (the whole arguments string is passed to the macro)

Macro blocks accept 2 or 3 arguments:

- `obj` - the object that is rendered (eg. an Issue, a WikiContent…)
- `args` - the macro arguments
- `text` - the block of text given to the macro (should be present only if the macro accepts a block of text). text is a String or nil if the macro is invoked without a block of text.

The block is called each time the macro is invoked in formatted text and its return value is inserted in the final output. This return value must be a html escaped string.

Examples:

By default, when the macro is invoked, the coma separated list of arguments is split and passed to the macro block as an array. If no argument is given the macro will be invoked with an empty array:

    <code class="ruby">
    macro :my_macro, :desc => 'This is a custom macro' do |obj, args|
      # args is an array
      # and this macro does not accept a block of text
    end
    </code>

You can disable arguments spliting with the `:parse_args => false` option. In this case, the full string of arguments is passed to the macro:

    <code class="ruby">
    macro :my_macro, :parse_args => false do |obj, args|
      # args is a string
    end
    </code>

Macro can optionally accept a block of text as a third argument:

    <code class="ruby">
    macro :my_macro do |obj, args, text|
      # this macro accepts a block of text
      # text is a String that represent the whole text passed to the macro
    end
    </code>

As a starting point for writing your own macros, you can have a look at the builtin macros definitions: source:/tags/2.1.0/lib/redmine/wiki_formatting/macros.rb#L162
