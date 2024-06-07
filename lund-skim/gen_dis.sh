#!/bin/bash
echo $1
LAST=$(( $1 * 50 ))
FIRST=$(( ($1 - 1) * 50 ))

for i in $(seq $FIRST $LAST)
do
    echo $i
    clasdis --docker --trig 25000 --zpos -3
    mv clasdis.dat clasdis_25k_targetshiftm3cm_pcut2p5_eleEvKept_$i.dat
    python skimLund.py clasdis_25k_targetshiftm3cm_pcut2p5_eleEvKept_$i.dat sector41skim_clasdis_25k_p2p5_eleEvKept_$i.dat
done
