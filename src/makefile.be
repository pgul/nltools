.PHONY: default


default: nldiff nlcrc ulc nlupdate

CC=gcc
CFLAGS=-O3 -I../.. -DUNIX
LFLAGS=-s -L../../fidoconf

.c.o: 
	$(CC) $(CFLAGS) -c $<

nldiff: nldiff.o crc16.o
	$(CC) $(LFLAGS) -o nldiff nldiff.o crc16.o

nlcrc: crc16.o nlcrc.o
	$(CC) $(LFLAGS) -o nlcrc crc16.o nlcrc.o

ulc: ulcsort.o ulcomp.o ulc.o nllog.o string.o nldate.o julian.o nlfind.o trail.o patmat.o ffind.o fexist.o
	$(CC) $(LFLAGS) -o ulc ulcsort.o ulcomp.o ulc.o nllog.o string.o nldate.o julian.o nlfind.o trail.o patmat.o  ffind.o fexist.o -lfidoconfigbe

nlupdate: nlupdate.o nllog.o string.o nldate.o julian.o nlfind.o ffind.o fexist.o trail.o patmat.o
	$(CC) $(LFLAGS) -o nlupdate nlupdate.o nllog.o string.o nldate.o julian.o nlfind.o trail.o patmat.o ffind.o fexist.o -lfidoconfigbe

clean:
	-rm crc16.o nlcrc.o nldiff.o ulc.o ulcomp.o ulcsort.o nllog.o julian.o nlfind.o nldate.o nlupdate.o string.o trail.o patmat.o ffind.o fexist.o


distclean: clean
	-rm nlcrc
	-rm nldiff
	-rm ulc
	-rm nlupdate

