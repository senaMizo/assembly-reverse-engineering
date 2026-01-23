CC = gcc
CFLAGS = -no-pie -fno-stack-protector -z execstack
TARGET = crackme1

all: $(TARGET)

$(TARGET): crackme1.c
	$(CC) $(CFLAGS) -o $(TARGET) crackme1.c

clean:
	rm -f $(TARGET) *.o

debug: $(TARGET)
	gdb -q ./$(TARGET)

.PHONY: all clean debug
