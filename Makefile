SRCS = main.asm exec.asm eval.asm fpp.asm hardware.asm hardware-sound.asm hardware-time.asm cpm.asm ram.asm

INCS := $(shell find . -name '*.inc')

bbcbasic.com: $(SRCS) $(INCS)
	z80asm -obbcbasic.com -b -d -l -m $(SRCS)

.PHONY: cpm
cpm:
	$(MAKE) --directory cpm

clean:
	rm -f *.o *.err *.lis *.map *.com *.bin

TEST_FILES := $(shell find ./tests-fixtures -name '*.bas')

.PHONY: test

test:
	@./all-tests.sh