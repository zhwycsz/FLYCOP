#!/bin/bash

# FLYCOP 
# Author: Beatriz García-Jiménez
# April 2018

# Call:
#sh plot_biomassX4_vs_mediaItem.sh <suffix> <met1 (without [e])> <strain1> <strain2> <strain3> <strain4>

dirScripts="../../Scripts"


suffix=$1
met1=$2
strain1=$3
strain2=$4
strain3=$5
strain4=$6

outFile="biomass_vs_"${met1}_${suffix}".txt"
plotFile="biomass_vs_"${met1}_${suffix}"_plot.pdf"

numMet1=`head -n1 media_log_${suffix}.txt | sed "s/.*{ //" | sed "s/}.*//" | sed "s/'//g" | sed "s/, /\n/g" | egrep -w -n ${met1} | cut -d: -f1`

egrep '\{'$numMet1'\}' media_log_${suffix}.txt | sed "s/media_//" | sed "s/{$numMet1}//" | sed "s/(1, 1)//" | sed "s/sparse.*/0.0/" | sed "s/;$//" | sed "s/\ =\ /\t/" | awk -F"\t" 'BEGIN{oldCycle=0;value=-1}{if($1!=oldCycle){print value; oldCycle=$1; value=$2}else{value=$2}}END{print value}' > media_log_substrate.txt

paste -d'\t' total_biomass_log_${suffix}.txt media_log_substrate.txt > $outFile
rm media_log_substrate.txt



