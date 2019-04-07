VERSION?=2.6
PREFIX?=/usr
CFLAGS?=-Wall -O2 -DVERSION=$(VERSION)
CC?=gcc

all: cpulimit

osx:
	$(CC) -o cpulimit cpulimit.c -D__APPLE__ $(CFLAGS) $(CPPFLAGS) $(LDFLAGS)

minix:
	$(CC) -o cpulimit cpulimit.c $(CFLAGS) $(CPPFLAGS) $(LDFLAGS)

freebsd:
	$(CC) -o cpulimit cpulimit.c -lrt -DFREEBSD $(CFLAGS) $(CPPFLAGS) $(LDFLAGS)

cpulimit: cpulimit.c
	$(CC) -o cpulimit cpulimit.c -pthread -lrt -DLINUX $(CFLAGS) $(CPPFLAGS) $(LDFLAGS)

tests:
	$(MAKE) -C test

install: cpulimit
	mkdir -p ${PREFIX}/bin
	mkdir -p ${PREFIX}/share/man/man1
	cp cpulimit ${PREFIX}/bin
	cp cpulimit.1 ${PREFIX}/share/man/man1

deinstall:
	rm -f ${PREFIX}/bin/cpulimit
	rm -f ${PREFIX}/share/man/man1/cpulimit.1

clean:
	rm -f *~ cpulimit
	$(MAKE) -C test clean

tarball: clean
	cd .. && tar czf cpulimit-$(VERSION).tar.gz cpulimit-$(VERSION) --exclude=.svn
	
