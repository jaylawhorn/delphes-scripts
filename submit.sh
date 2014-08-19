#!/bin/bash

#IN_FILE=$1
#IN_DIR=$2
#OUT_DIR=$3
#DET_CARD=$4

conf_file=pu_check.txt
output_loc=/store/user/jlawhorn/test/delphes/
input_loc=/store/user/jlawhorn/test/
delphes_version=/afs/cern.ch/work/j/jlawhorn/public/for-prod/delphes_pujetid.tar

while read line
do
    if [[ "${line:0:1}" != "#" ]]; then
	testvar="$( /afs/cern.ch/project/eos/installation/0.3.4/bin/eos.select ls ${output_loc}/${line} 2> /dev/null )"
	if [[ ${testvar} == "" ]]; then 
	    echo    bsub -q 2nd -o /afs/cern.ch/work/j/jlawhorn/logfile_${line%.*}.txt -e /afs/cern.ch/work/j/jlawhorn/errfile_${line%.*}.txt -J ${line} run.sh ${line} $input_loc $output_loc JetStudies_Phase_II_140PileUp_conf4.tcl ${delphes_version}
	    bsub -q 2nd -o /afs/cern.ch/work/j/jlawhorn/logfile_${line%.*}.txt -e /afs/cern.ch/work/j/jlawhorn/errfile_${line%.*}.txt -J ${line} run.sh ${line} $input_loc $output_loc JetStudies_Phase_II_140PileUp_conf4.tcl ${delphes_version}
	fi
    fi
done < ${conf_file}