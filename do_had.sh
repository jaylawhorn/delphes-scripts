#!/bin/bash

#chmod 777 *.*

#set -o verbose                                                                                                                                                                               

echo "Starting job on " `date`
echo "Running on " `uname -a`
echo "System release " `cat /etc/redhat-release`

export PRODHOME=`pwd`
export SCRAM_ARCH=slc6_amd64_gcc472
export RELEASE=CMSSW_5_3_19
export PATH=`pwd`:${PATH}

scram project ${RELEASE}
cd ${RELEASE}/src
eval `scram runtime -sh`
pwd

in_file=${1} #root://eoscms.cern.ch//store/group/upgrade/lhe/Bj-4p-0-300-v1510_14TEV/Bj-4p-0-300-v1510_14TEV_100381631.lhe.gz
loc_file=${2}  #Bj-4p-0-300-v1510_14TEV_100381631.lhe.gz

echo ${in_file}

cp /afs/cern.ch/user/j/jlawhorn/cmssw/CMSSW_5_3_19/src/hadronizer.py .
cp /afs/cern.ch/user/j/jlawhorn/cmssw/CMSSW_5_3_19/src/mgPostProcv2.py .

echo 'xrdcp' ${in_file} ${loc_file}
xrdcp ${in_file} ${loc_file}

gunzip ${loc_file}

loc_file=${loc_file%.*}

qCut=`zgrep ' = xqcut' ${loc_file} | awk '{print $1}'`
maxjets=`grep "maxjetflav" ${loc_file} | awk '{print $1}'`

echo 'python mgPostProcv2.py -o' ${loc_file}'.root -j '${maxjets}' -q '${qCut}' -e 5 -s '${loc_file}
python mgPostProcv2.py -o ${loc_file}.root -j ${maxjets} -q ${qCut} -e 5 -s ${loc_file}

cmsRun hadronizer.py ${loc_file}.root

cmsStage ${loc_file}.root /store/user/jlawhorn/test/