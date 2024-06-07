import os
import numpy as np
import sys
import ROOT
import math
###
# Skim LUND file to look for events with either
# scattered electron or charged hadron (p>~2GeV)
# in sector 4/1
###

# define something to format lines
# because we have to redefine indices etc.
def formatHeader(linearr, npart):
    returnstr = "          {} {} {} {} {} {} {} {} {} {} \n".format(str(npart),linearr[1], linearr[2],linearr[3],
                                                               linearr[4],linearr[5],linearr[6],
                                                               linearr[7],linearr[8],linearr[9])
    return returnstr

def formatPartLine(linearr, index):
    returnstr = "    {} {} {} {} {} {} {} {} {} {} {} {} {} {} \n".format(str(index),linearr[1], linearr[2],linearr[3],
                                                            linearr[4],linearr[5],linearr[6],
                                                            linearr[7],linearr[8],linearr[9],
                                                            linearr[10],linearr[11],linearr[12],
                                                            linearr[13])
    return returnstr

# sector phi cuts
def phiCut4(phi):
    return ((phi <= 180 and phi > 150 ) or (phi >= -180 and phi < -150))
def phiCut1(phi):
    return (phi >= -30 and phi <= 30)
def phiCut(phi,sectorlist):
    cuts = []
    for sector in sectorlist:
        if sector==4:
            cuts.append(phiCut4(phi))
        if sector==1:
            cuts.append(phiCut1(phi))
    return np.any(np.array(cuts))
sectors = [4,1]
keepEleEvents = True
ncurrent = 0
partskept = []
hadkept = 0
headerline = " "
outfilename = sys.argv[2]

with open(sys.argv[1]) as file:
    for line in file:

        linearr = line.strip().split()

        # if we are at the header line
        if(len(linearr)==10):
            partskept = []
            Ninev = int(linearr[0])
            headerline = linearr
            ncurrent = 0
            partskept = []
            hadkept = 0
            eleInRich = False
            continue

        # if we are still within the event
        if ncurrent < Ninev:
            #print("checking part")
            pid = int(linearr[3])
            geantstatus = int(linearr[2])
            parent = int(linearr[4])
            if (abs(pid) == 211 or abs(pid) == 321 or abs(pid) == 2212 or abs(pid) == 11) and geantstatus == 1 and parent != 1:
                px = float(linearr[6])
                py = float(linearr[7])
                pz = float(linearr[8])
                p = ROOT.TVector3(px,py,pz)
                phi = (p.Phi())*180/math.pi
                # if in sector 4 (CHECK THIS)                
                if phiCut(phi,sectors) and p.Mag() >= 2.5:
                    partskept.append(linearr)
                    hadkept += 1
            if pid==11 and parent == 1:
                # DIS electron
                partskept.append(linearr)
                px = float(linearr[6])
                py = float(linearr[7])
                pz = float(linearr[8])
                p = ROOT.TVector3(px,py,pz)
                phi = (p.Phi())*180/math.pi
                # if in sector 4 or 1 (CHECK THIS)                
                if phiCut(phi,sectors):
                    eleInRich = True
            ncurrent+=1                
        if ncurrent == Ninev and (hadkept > 0 or (eleInRich and keepEleEvents)):
            with open(outfilename, 'a') as outfile:
                outfile.write(formatHeader(headerline,len(partskept)))
                currentindex = 1 
                for savedline in partskept:                    
                    outfile.write(formatPartLine(savedline, currentindex))
                    currentindex+=1
                
