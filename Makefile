#!/usr/bin/make -f
#
# Filename Makefile
# Date 10/11/2020
# Author Junsik Seo
# Email jxs161930@utdallas.edu
# Version 1.0
# Copyright 2020, All Rights Reserved
# Description:
#This is MakeFile that take care of creating dependencies
#


CC = gcc
CCFLAGS = -Werror
CPPFLAGS = 

LEX = /bin/flex
LFLAGS =

YACC = /bin/bison
YFLAGS = -dy

PROJECTNAME = assignment4

EXECFILE = assign4

OBJS = parse.o scan.o myfile.o

.PRECIOUS: scan.c parse.c

all: $(EXECFILE)

clean: 
	rm -f $(OBJS) $(EXECFILE) y.tab.h parse.c scan.c *~ \#* scanner parser

$(EXECFILE): 	$(OBJS)
	$(CC) -o $@ $(OBJS)
	ln -fs ./$@ scanner
	ln -fs ./$@ parser
backup:
	@make clean
	@mkdir ~p ~/backups; chmod 700 ~backups
	@$(eval CURDIRNAME := $(shell basename "'pwd'"))
	@$(eval MKBKUPNAME := ~/backups/$(PROJECTNAME)-$(shell date +'%Y.%m.%d-%H:%M:%S')tar.gz)
	@echo
	@echo Writing Backup file to: $(MKBKUPNAME)
	@echo
	@-tar zcfv $(MKBKUPNAME) ../$(CURDIRNAME) 2> /dev/null
	@chmod 600 $(MKBKUPNAME)
	@echo
	@echo Done!
