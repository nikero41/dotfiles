function zvm_config() {
	ZVM_VI_INSERT_ESCAPE_BINDKEY=jk

	ZVM_CURSOR_STYLE_ENABLED=true
	ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BEAM
	ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT

	ZVM_INIT_MODE=sourcing
	ZVM_KEYTIMEOUT=0.04
	ZVM_ESCAPE_KEYTIMEOUT=0

	ZVM_VI_HIGHLIGHT_BACKGROUND=#cba6f7
	ZVM_VI_HIGHLIGHT_FOREGROUND=#1e1e2e

	zvm_define_widget run_snippet
}

function _register_pet_keymaps() {
	zvm_bindkey viins '^s' run_snippet
}
zvm_after_init_commands+=(_register_pet_keymaps)

function zvm_after_lazy_keybindings() {
	zvm_bindkey vicmd '^s' run_snippet
}
