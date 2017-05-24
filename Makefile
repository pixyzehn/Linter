INSTALL_PATH = /usr/local/bin/Linter

install:
	swift package --enable-prefetching update
	swift build --enable-prefetching -c release -Xswiftc -static-stdlib
	cp -f .build/release/Linter $(INSTALL_PATH)

uninstall:
	rm -f $(INSTALL_PATH)
