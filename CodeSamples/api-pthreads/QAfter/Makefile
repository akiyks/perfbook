CFLAGS=-g

all: time timelocked

time: time.o
	cc -g -pthread -o time time.o

timelocked: timelocked.o
	cc -g -pthread -o timelocked timelocked.o
