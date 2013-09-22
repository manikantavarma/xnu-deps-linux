DESTDIR=/usr/local

.PHONY: all

all: 
	@echo Building migcom...
	make -C bootstrap_cmds-60/migcom.tproj/
	@echo Building cctools...
	/bin/sh -c "cd cctools-836; ./configure --target=arm-apple-darwin11 --prefix=/; make CFLAGS=-I$(PWD)/include all"
	@echo Building kext-tools...
	make -C kext-tools/

install:
	@echo Installing mig and migcom...
	make -C bootstrap_cmds-60/migcom.tproj/ DESTDIR=$(DESTDIR) install
	@echo Installing cctools...
	make -C cctools-836/ DESTDIR=$(DESTDIR) install
	@echo Installing kext-tools
	make -C kext-tools/ DESTDIR=$(DESTDIR) install
	@echo Installing xcode stubs...
	@/bin/sh gen-stubs.sh $(DESTDIR)

clean:
	@echo Cleaning migcom...
	make -C bootstrap_cmds-60/migcom.tproj/ clean
	@echo Cleaning cctools...
	make -C cctools-836/ clean
	@echo Cleaning kext-tools...
	make -C kext-tools/ clean
