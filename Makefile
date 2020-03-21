SRCS = main.asm exec.asm eval.asm fpp.asm hardware.asm cpm.asm ram.asm

bbcbasic.com: $(SRCS)
	z80asm -obbcbasic.com -b -d -l -m $(SRCS)

clean:
	rm -f *.o *.err *.lis *.map *.com *.bin

TEST_FILES := $(shell find ./tests-fixtures -name '*.bas')

.PHONY: test

test:
	@./all-tests.sh