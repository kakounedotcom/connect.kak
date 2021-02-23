install:
	curl -sSL https://github.com/mawww/kakoune/raw/master/doc/kakoune_logo.svg --create-dirs -o ~/.local/share/icons/hicolor/scalable/apps/kakoune.svg
	mkdir -p ~/.local/bin ~/.local/share/kak ~/.local/share/applications
	ln -sf "${PWD}/bin/kak-shell" "${PWD}/bin/kak-desktop" ~/.local/bin
	ln -sf "${PWD}/share/applications/kakoune-connect.desktop" ~/.local/share/applications
	ln -sf "${PWD}/share/kak/connect" ~/.local/share/kak

uninstall:
	rm -Rf ~/.local/bin/kak-shell ~/.local/bin/kak-desktop ~/.local/share/kak/connect
