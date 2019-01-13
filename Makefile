CC=arm-none-eabi-gcc
SIZE=arm-none-eabi-size
NIM=nim
CFLAGS= -mcpu=cortex-m4 -mthumb -mfloat-abi=hard -mfpu=fpv4-sp-d16 -ffunction-sections -fdata-sections -Os -g -nostartfiles -nostdlib
NIMFLAGS=cc -c --cpu=arm --d:release --gc:none --os:standalone --deadCodeElim:on --nimcache:src/nimcache
OBJS=$(notdir $(subst .c,.o,$(wildcard src/*.c)) $(subst .c,.o,$(wildcard src/nimcache/*.c)) $(subst .s,.o,$(wildcard src/*.s)))

.PHONY: all nim flash clean

all: nim output.elf
	$(SIZE) output.elf

nim:
	$(NIM) $(NIMFLAGS) src/main.nim

output.elf: $(OBJS)
	$(CC) $(CFLAGS) -Wl,-T,LinkerScript.ld,-Map=output.map,--gc-sections -o $@ $^

%.o: src/%.c
	$(CC) $(CFLAGS) -c -o $@ $^
%.o: src/nimcache/%.c
	$(CC) $(CFLAGS) -c -o $@ $^
%.o: src/%.s
	$(CC) $(CFLAGS) -c -o $@ $^

flash:
	echo output.elf | xargs -I {} openocd -f interface/cmsis-dap.cfg -f target/stm32f3x.cfg -c 'init;program {};reset;exit'

clean:
	$(RM) *.o *.elf *.map
