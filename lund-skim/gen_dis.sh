#!/bin/bash
echo $1
LAST=$(( $1 * 50 ))
FIRST=$(( ($1 - 1) * 50 ))
PREFIX=clasdis_10k_targetshiftm3cm_hadInRICH_p1GeV
for i in $(seq $FIRST $LAST)
do
    echo $i
    clasdis --docker --trig 10000 --zpos -3
    mv clasdis.dat ${PREFIX}_$i.dat
    python skimLund.py ${PREFIX}_$i.dat sector41skim_${PREFIX}_$i.dat
    rm ${PREFIX}_$i.dat
done
