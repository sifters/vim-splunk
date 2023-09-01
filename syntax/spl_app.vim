" Vim syntax file
" Language: Splunk configuration files
" Maintainer: Colby Williams <colbyw at gmail dot com>

if version < 600
    syntax clear
elseif exists("b:current_syntax")
    finish
endif

setlocal iskeyword+=.
setlocal iskeyword+=:
setlocal iskeyword+=-

syn case match

syn match confComment /^#.*/ contains=confTodo oneline display
syn match confSpecComment /^\s.*/ contains=confTodo oneline display
syn match confSpecComment /^\*.*/ contains=confTodo oneline display

syn region confString start=/"/ skip="\\\"" end=/"/ oneline display contains=confNumber,confVar
syn region confString start=/`/             end=/`/ oneline display contains=confNumber,confVar
syn region confString start=/'/ skip="\\'"  end=/'/ oneline display contains=confNumber,confVar
syn match  confNumber /\v[+-]?\d+([ywdhsm]|m(on|ins?))(\@([ywdhs]|m(on|ins?))\d*)?>/
syn match  confNumber /\v[+-]?\d+(\.\d+)*>/
syn match  confNumber /\v<\d+[TGMK]B>/
syn match  confNumber /\v<\d+(k)?b>/
syn match  confPath   ,\v(^|\s|\=)\zs(file:|https?:|\$\k+)?(/+\k+)+(:\d+)?,
syn match  confPath   ,\v(^|\s|\=)\zsvolume:\k+(/+\k+)+,
syn match  confVar    /\$\k\+\$/

syn keyword confBoolean on off t[rue] f[alse] T[rue] F[alse]
syn keyword confTodo FIXME[:] NOTE[:] TODO[:] CAUTION[:] contained

" Define generic stanzas
syn match confGenericStanzas display contained /\v[^\]]+/

" Define stanzas
syn region confStanza matchgroup=confStanzaStart start=/^\[/ matchgroup=confStanzaEnd end=/\]/ oneline transparent contains=@confStanzas

" Group clusters
syn cluster confStanzas contains=confAppStanzas,confGenericStanzas

" app.conf
syn match   confAppStanzas contained /\v<(default|author|id|launcher|package|install|triggers|ui|credentials_settings|credential:[^]]+|diag|shclustering)>/

syn match   confApp /\v<^(email|company|group|name|version|remote_tab|version|description|author|id|check_for_updates)>/
syn match   confApp /\v<^(state(_change_requires_restart)?|build|allows_disable|install_source(_local)?_checksum|attribution_link)>/
syn match   confApp /\v<^(reload\.[^\ |\=]+|is_(visible|configured|manageable)|show_in_nav|label|docs_section_override)>/
syn match   confApp /\v<^(setup_view|verify_script|password|extension_script|data_limit|default_gather_lookups)>/
syn match   confApp /\v<^(deployer_(lookups_)?push_mode|show_upgrade_notification|python\.version)>/

syn match   confAppConstants /\v<(disabled|enabled|never|simple|(rest|access)_endpoints|http_(get|post))$>/
syn match   confAppConstants /\v<(preserve_lookups|always_(preserve|overwrite)|full|merge_to_default|(local|default)_only)$>/
syn match   confAppConstants /\v<(default|python(2|3)|overwrite_on_change?|dark|light)$>/

" 9.0.0
syn match   confApp /\v<^(supported_themes)>/

" Highlight definitions (generic)
hi def link confComment Comment
hi def link confSpecComment Error
hi def link confBoolean Boolean
hi def link confTodo Todo

" Other highlight
hi def link confString String
hi def link confNumber Number
hi def link confPath   Number
hi def link confVar    PreProc

hi def link confStanzaStart Delimiter
hi def link confstanzaEnd Delimiter

" Highlight for stanzas
hi def link confStanza Function
hi def link confGenericStanzas Constant
hi def link confAppStanzas Identifier
hi def link confApp Keyword
hi def link confAppConstants Constant
