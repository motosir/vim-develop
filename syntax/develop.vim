if exists("b:current_syntax")
    finish
endif

syntax match developPrompt  "\v\~\$"
syntax match developCommand "python .*.py"
syntax match developCommand "bash .*.sh"

syntax match developError   "\v.*Error.*$"

"highlight link developError   SpellBad
highlight link developError   DiffAdd
highlight link developPrompt  rubyPredefinedIdentifier
highlight link developCommand Keyword

let b:current_syntax = "develop"
