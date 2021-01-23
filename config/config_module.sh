#!/bin/sh

# changes to run the model:
# 1) change compiler ifort to compiler of choice
ifort -c parse_config.f90 -o ../config/parse_config.o

cp parse_config.o ../preprocess/
cp parse_config.o ../src/
