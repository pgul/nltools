# $Id$
# Makefile for nltools with Husky build enviroment
# Use GNU version of 'make' program

ifeq ($(DEBIAN), 1)
# Every Debian-Source-Paket has one included.
include /usr/share/husky/huskymak.cfg
else
include ../huskymak.cfg
endif

.PHONY: default

all: default

default: nldiff$(_EXE) nlcrc$(_EXE) ulc$(_EXE) nlupdate$(_EXE)

ifeq ($(DEBUG), 1)
  CFLAGS= -I$(INCDIR) -Ih $(DEBCFLAGS)
  LFLAGS=$(DEBLFLAGS)
else
  CFLAGS= -I$(INCDIR) -Ih $(OPTCFLAGS)
  LFLAGS=$(OPTLFLAGS)
endif
ifeq ($(SHORTNAME), 1)
  LIBS=-L$(LIBDIR) -lfidoconf -lsmapi -lhusky
else
  LIBS=-L$(LIBDIR) -lfidoconfig -lsmapi -lhusky
endif

CDEFS=-D$(OSTYPE) $(ADDCDEFS)

%$(_OBJ): src$(DIRSEP)%.c
	$(CC) $(CFLAGS) $(CDEFS) -c $<

nldiff$(_EXE): nldiff$(_OBJ) crc16$(_OBJ)
	$(CC) $(LFLAGS) -o nldiff$(_EXE) nldiff$(_OBJ) crc16$(_OBJ) \
              $(LIBS)

nlcrc$(_EXE): crc16$(_OBJ) nlcrc$(_OBJ)
	$(CC) $(LFLAGS) -o nlcrc$(_EXE) crc16$(_OBJ) nlcrc$(_OBJ) \
              $(LIBS)

ulc$(_EXE): ulcsort$(_OBJ) ulcomp$(_OBJ) ulc$(_OBJ) string$(_OBJ) \
     nldate$(_OBJ) julian$(_OBJ) nlfind$(_OBJ)
	$(CC) $(LFLAGS) -o ulc$(_EXE) ulcsort$(_OBJ) ulcomp$(_OBJ) ulc$(_OBJ) \
          string$(_OBJ) nldate$(_OBJ) julian$(_OBJ) nlfind$(_OBJ) \
         $(LIBS)

nlupdate$(_EXE): nlupdate$(_OBJ) string$(_OBJ) nldate$(_OBJ) julian$(_OBJ) \
          nlfind$(_OBJ)
	$(CC) $(LFLAGS) -o nlupdate$(_EXE) nlupdate$(_OBJ) string$(_OBJ) \
          nldate$(_OBJ) julian$(_OBJ) nlfind$(_OBJ) $(LIBS)

clean:
	-$(RM) $(RMOPT) crc16$(_OBJ)
	-$(RM) $(RMOPT) nlcrc$(_OBJ)
	-$(RM) $(RMOPT) nldiff$(_OBJ)
	-$(RM) $(RMOPT) ulc$(_OBJ)
	-$(RM) $(RMOPT) ulcomp$(_OBJ)
	-$(RM) $(RMOPT) ulcsort$(_OBJ)
	-$(RM) $(RMOPT) julian$(_OBJ)
	-$(RM) $(RMOPT) nlfind$(_OBJ)
	-$(RM) $(RMOPT) nldate$(_OBJ)
	-$(RM) $(RMOPT) nlupdate$(_OBJ)
	-$(RM) $(RMOPT) string$(_OBJ)
	-$(RM) $(RMOPT) patmat$(_OBJ)

distclean: clean
	-$(RM) $(RMOPT) nlcrc$(_EXE)
	-$(RM) $(RMOPT) nldiff$(_EXE)
	-$(RM) $(RMOPT) ulc$(_EXE)
	-$(RM) $(RMOPT) nlupdate$(_EXE)

install: ulc$(_EXE) nldiff$(_EXE) nlcrc$(_EXE) nlupdate$(_EXE)
	$(INSTALL) $(IBOPT) ulc$(_EXE) $(BINDIR)
	$(INSTALL) $(IBOPT) nldiff$(_EXE) $(BINDIR)
	$(INSTALL) $(IBOPT) nlcrc$(_EXE) $(BINDIR)
	$(INSTALL) $(IBOPT) nlupdate$(_EXE) $(BINDIR)

uninstall:
	-$(RM) $(RMOPT) $(BINDIR)$(DIRSEP)ulc$(_EXE)
	-$(RM) $(RMOPT) $(BINDIR)$(DIRSEP)nldiff$(_EXE)
	-$(RM) $(RMOPT) $(BINDIR)$(DIRSEP)nlcrc$(_EXE)
	-$(RM) $(RMOPT) $(BINDIR)$(DIRSEP)nlupdate$(_EXE)
