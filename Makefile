SRCS = main.asm exec.asm eval.asm fpp.asm hardware.asm hardware-sound.asm hardware-time.asm cpm.asm ram.asm

INCS := $(shell find . -name '*.inc')

bbcbasic.com: $(SRCS) $(INCS) version.inc
	$(MAKE) clean-lib
	z80asm -obbcbasic.com -b -d -l -m $(SRCS)

clean-lib:
	rm -f *.o *.err *.lis *.map

clean:
	rm -f *.o *.err *.lis *.map *.com *.bin

TEST_FILES := $(shell find ./tests-fixtures -name '*.bas')

.PHONY: test

test:
	@./test-all

VERSION ?= "0.0.0"
BUILDTIME := $(shell date --rfc-3339=seconds)
.PHONY: version.inc
version.inc:
	@echo "#define VERSIONSTAMP \"${VERSION}\"\n" > $@ && \
	echo "#define BUILDTIME \"${BUILDTIME}\"\n" >> $@
