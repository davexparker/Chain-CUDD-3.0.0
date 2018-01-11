#!/bin/sh

# PRISM-customised install script for CUDD
# Needs to be run from the containing directory

# Only re-run configure if Makefile doesn't already exist

if [ ! -f Makefile ]; then
  ./configure --prefix="$(pwd)" || exit 1
fi

# Build, install (locally)

make || exit 1
make install || exit 1

# Install links to headers not installed by make install

mkdir -p include # should already exist though
for HEADER in cudd/cuddInt.h config.h st/st.h mtr/mtr.h epd/epd.h util/util.h
#for HEADER in $(find . -name "*.h")
do
  if [ ! -L include/`basename $HEADER` ]; then
	ln -s ../$HEADER include
  fi
done