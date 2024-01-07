CC = arm-linux-gnueabihf-gcc
CC2 = gcc
CFLAGS = -Wall -g -std=c99 -D_POSIX_C_SOURCE=200809L -Werror -pthread

# List of source files
SRC = board.c config.c pinMap.c LED_Matrix.c game_logic.c main.c

# List of header files
HDR = board.h config.h LED_Matrix.h pinMap.h game_logic.h

# Output executable
TARGET = chess

all:
	$(CC) $(CFLAGS) $(SRC) -o $(TARGET) -lm
	cp $(TARGET) $(HOME)/cmpt433/public/myApps/

this:
	$(CC2) $(CFLAGS) $(SRC) -o $(TARGET) -lm

clean:
	rm -f $(TARGET)

