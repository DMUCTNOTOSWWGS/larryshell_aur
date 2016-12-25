PKGVER=1.2
REL=1
VER="$(PKGVER)-$(REL)"
# Be sure to update this in PKGBUILD

EOL=$

build:
	if [ -d larryshell ]; then \
		cd larryshell && git pull; \
	else git clone git@github.com:Devon-Austin-Wood-Thomas/larryshell larryshell; fi
	tar cvf $(VER).tar.gz \
		larryshell/larryshell \
		larryshell/larryshellrc \
		larryshell/larryshell-errors.txt
	cp $(VER).tar.gz /srv/http/larryshell
	perl -pi -e "s/(pkgver=).*$(EOL)/\1'$(PKGVER)'/" PKGBUILD
	perl -pi -e "s/(pkgrel=).*$(EOL)/\1'$(REL)'/" PKGBUILD
	perl -pi -e "s/(md5sums=)\((.*)\)/\1('`md5sum $(VER).tar.gz | cut -d " " -f1`')/" PKGBUILD
	makepkg --printsrcinfo > .SRCINFO
clean:
	rm -rf src pkg *.tar* larryshell
