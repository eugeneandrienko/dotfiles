CC=gcc
SOURCES=main.c
OBJFILES=main.o
BIN=
CFLAGS=-c
LDFAGS=-lc

all: all_objects
	$(CC) -o $(BIN) $(OBJFILES) $(LDFAGS)

all_objects: $(SOURCES)
	$(CC) $(CFLAGS) $(SOURCES)

.PHONY: clean
clean:
	rm -f $(BIN) \
		$(OBJFILES)

