#!/bin/sh

gfortran-7 -c parse_config.f90 -o ../config/parse_config.o

cp parse_config.o ../preprocess/
cp parse_config.o ../src/
