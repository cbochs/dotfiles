; Multi-line backtick templates with a language tag: highlight the body using
; the named language. The (!e) filter keeps `${...}` interpolation regions
; out of the injection so they remain Dang.
(multi_template
  (lang_tag_part (lang_tag_name) @injection.language)
  (multi_template_part !e)+ @injection.content)
