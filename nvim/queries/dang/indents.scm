; Indent bracketed forms one level deeper than the line that opened them.
; Capture both complete nodes and bare opening delimiters so pressing <CR>
; after an unfinished opener still indents correctly while typing.
[
  (arg_types)
  (arg_values)
  (block)
  (block_arg)
  (headers_block)
  (list)
  (list_type)
  (object_literal)
  (object_selection)
  (object_type)
  (paren_form)
  "{"
  "{{"
  "("
  "["
  (immediate_bracket)
  (immediate_paren)
] @indent.begin
  (#set! indent.immediate 1)

[
  ")"
  "]"
  "}"
  "}}"
] @indent.branch @indent.end

[
  (comment_token)
  (doc_string)
  (triple_quote_string)
] @indent.ignore
