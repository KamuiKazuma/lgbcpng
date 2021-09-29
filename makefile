
## ---------------------------------------------------------------------
## Set phony & default targets, and override the default suffix rules.
## ---------------------------------------------------------------------

.PHONY: all clean
.SUFFIXES:

.DEFAULT_GOAL := all

## ---------------------------------------------------------------------
## Setup project details.
## ---------------------------------------------------------------------

TARGET   := $(shell basename $(CURDIR))
OBJS     := $(patsubst %.c,%.o,$(wildcard *.c))

## ---------------------------------------------------------------------
## Set flags for code generation.
## ---------------------------------------------------------------------

CC       := gcc
LD       := gcc
#OBJCOPY := objcopy

CFLAGS   := -Wall -O1 `libpng-config --cflags`
LDFLAGS  := `libpng-config --libs`
#OCARCH  ?= elf64-x86-64

## ---------------------------------------------------------------------
## Compilation rules.
## ---------------------------------------------------------------------

all: $(TARGET)
	-@chmod +x $<

#$(TARGET): $(TARGET).elf
#	-@echo 'Stripping symbols from "$<"... ("$<"->"$@")'
#	$(OBJCOPY) -vgO $(OCARCH) $< $@

$(TARGET): $(OBJS)
	-@echo 'Linking objects... ("$^"->"$@")'
	$(LD) $(LDFLAGS) $^ -o $@

$(OBJS): %.o : %.c
	-@echo 'Compiling object "$@"... ("$<"->"$@")'
	$(CC) $(CFLAGS) -c $< -o $@

.IGNORE: clean
clean:
	@echo 'Cleaning up intermediary files...'
	@rm -vf *.o $(TARGET)
