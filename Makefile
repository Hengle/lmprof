CC = gcc
CFLAGS = -Wall -ansi -pedantic -fPIC -shared

LUA_DIR = /usr/include/lua5.2
LUA_LIB = /usr/local/lib/lua/5.2
LUA_CFLAGS = -I$(LUA_DIR)
LUA_LIBS = -llua5.2

all: lmprof.so

install: lmprof.so
	mkdir -p $(LUA_LIB)/lmprof && cp src/reduce/*.lua $(LUA_LIB)/lmprof && cp lmprof.so /usr/local/lib/lua/5.2/

lmprof.so: lmprof.o
	cd src && $(CC) lmprof_lstrace.o lmprof_stack.o lmprof_hash.o lmprof.o -o lmprof.so $(CFLAGS) $(LUA_LIBS) && mv lmprof.so ../

lmprof.o: lmprof_stack.o lmprof_hash.o lmprof_lstrace.o
	cd src && $(CC) -c lmprof.c $(CFLAGS) $(LUA_CFLAGS)

lmprof_lstrace.o:
	cd src && $(CC) -c lmprof_lstrace.c $(CFLAGS) $(LUA_CFLAGS)

lmprof_hash.o:
	cd src && $(CC) -c lmprof_hash.c $(CFLAGS)

lmprof_stack.o:
	cd src && $(CC) -c lmprof_stack.c $(CFLAGS)

clean:
	rm -f src/*.o lmprof.so

