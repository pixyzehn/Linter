INSTALL_PATH = /usr/local/bin/Linter

install:
	swift package update
	swift build -c release -Xswiftc -static-stdlib
	cp -f .build/release/Linter $(INSTALL_PATH)

uninstall:
	rm -f $(INSTALL_PATH)

lint:
	linter --included Sources Tests --excluded Templates
