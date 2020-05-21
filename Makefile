SRCS = main.asm exec.asm eval.asm fpp.asm hardware.asm hardware-sound.asmpp hardware-time.asm cpm.asm ram.asm tracing.asm

INCS := $(shell find . -name '*.inc')

ASSEMBLER=apploader
ASSFLAGS=-b --page-align
#-DTRACING

bbcbasic.com: $(SRCS)
	$(MAKE) version._inc
	$(ASSEMBLER) -obbcbasic.com ${ASSFLAGS} $(SRCS)

%.asmpp: %.asm $(INCS)
	gpp --includemarker "; #include line: %, file:%" -n  $(DEFINES) -o $@ $<

clean-lib:
	rm -f *.o *.err *.lis *.map

clean:
	rm -f *.o *.err *.lis *.map *.com *.bin *.reloc *._inc

TEST_FILES := $(shell find ./tests-fixtures -name '*.bas')

.PHONY: test

test:
	@./test-all

VERSION ?= "0.0.0"
BUILDTIME := $(shell date --rfc-3339=seconds)
.PHONY: version._inc
version._inc:
	@echo "#define VERSIONSTAMP \"${VERSION}\"\n" > $@ && \
	echo "#define BUILDTIME \"${BUILDTIME}\"\n" >> $@
