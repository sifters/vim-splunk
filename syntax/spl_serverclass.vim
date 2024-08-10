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
syn cluster confStanzas contains=confServerClassStanzas,confGenericStanzas

" serverclass.conf
syn match   confServerClassStanzas contained /\v<(global|serverClass:\S+(:app:[^]]+)?)>/

syn match   confServerClass /\v<^(appFile|(black|white)list\.(\d+|from_pathname|select_field|where_(equals|field)))>/
syn match   confServerClass /\v<^(continueMatching|crossServerChecksum|disabled|endpoint|excludeFromUpdate|filterType|issueReload)>/
syn match   confServerClass /\v<^(machineTypesFilter|precompressBundles|repositoryLocation|restart(IfNeeded|Splunk(d|Web))|stateOnClient)>/
syn match   confServerClass /\v<^(targetRepositoryLocation|tmpFolder)>/

syn match   confServerClassConstants /\v<((black|white)list|(dis|en)abled|noop)$>/

" 9.3.0
syn match   confServerClass /\v<^(syncMode|maxConcurrentDownloads|reloadCheckInterval|packageTypesFilter|updaterRunningFilter)>/
syn match   confServerClass /\v<^(cronSchedule)>/
syn match   confServerClassConstants /\v<(none|sharedDir)$>/

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
hi def link confServerClassStanzas Identifier
hi def link confServerClass Keyword
hi def link confServerClassConstants Constant
