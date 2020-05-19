SRCS = main.asm exec.asm eval.asm fpp.asm hardware.asm hardware-sound.asmpp hardware-time.asm cpm.asm ram.asm tracing.asm

INCS := $(shell find . -name '*.inc')

DEFINES=
#-DTRACING

bbcbasic.com: bbcbasic.asm _bbcbasic.com
	z80asm -obbcbasic.com -b bbcbasic.asm

%.asmpp: %.asm $(INCS)
	gpp --includemarker "; #include line: %, file:%" -n  $(DEFINES) -o $@ $<

consts._inc: $(SRCS) $(INCS)
	@rm -f consts._inc
	@touch consts._inc
	@z80asm -o_bbcbasic.com -g -DFIRSTPASS $(SRCS)
	@./consts.sh

_bbcbasic.com: $(SRCS) $(INCS) consts._inc
	$(MAKE) version._inc
	z80asm -o_bbcbasic.com -b -l ${DEFINES} -DSECONDPASS --reloc-info  $(SRCS)

clean-lib:
	rm -f *.o *.err *.lis *.map

clean:
	rm -f *.o *.err *.lis *.map *.com *.bin *.reloc

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
