#!/usr/bin/env zsh

# @Function: init_ocaml_env
# @Brief: Set the current $SHELL env to be OCaml ready
function init_ocaml_env() {
	echo -e "Setting $SHELL env for an OCaml session with:\n$(opam env)"
	eval $(opam env)
	echo "$SHELL env ready for OCaml"
}
