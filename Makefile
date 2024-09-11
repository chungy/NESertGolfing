PROGRAM=dgolf

CC=cc65
AS=ca65
LD=ld65

CFLAGS=-O -T -g
ASFLAGS=-g
LDFLAGS=-m $(PROGRAM).map --dbgfile $(PROGRAM).dbg -C $(PROGRAM).cfg

.PHONE: all clean

all: $(PROGRAM).nes

%.o: %.s
	$(AS) -o $@ $(ASFLAGS) $<

%.c.s: %.c
	$(CC) -o $@ $(CFLAGS) $<

$(PROGRAM).nes: blend.o dgolf.o dgolf.c.o dgolf.c.s
	$(LD) -o $@ $(LDFLAGS) blend.o $(PROGRAM).o $(PROGRAM).c.o temp/runtime.lib

clean:
	$(RM) blend.o $(PROGRAM).c.o $(PROGRAM).c.s $(PROGRAM).dbg $(PROGRAM).map $(PROGRAM).nes $(PROGRAM).o
