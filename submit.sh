#!/bin/bash

#IN_FILE=$1
#IN_DIR=$2
#OUT_DIR=$3
#DET_CARD=$4

#conf_file=bbtt.txt
#conf_file=bbgg.txt
#conf_file=vbf_htt.txt
conf_file=vbf_hh_4b.txt
#output_loc=/store/user/jlawhorn/dih_bbtt_140PU/
#output_loc=/store/user/jlawhorn/dih_bbgg_140PU/
#output_loc=/store/user/jlawhorn/vbf_htt_140PU/
output_loc=/store/user/jlawhorn/vbf_hh_4b_140PU/
#input_loc=/store/user/jlawhorn/dih_bbtt_pythia/
#input_loc=/store/user/jlawhorn/dih_bbgg_pythia/
#input_loc=/store/user/arapyan/mc/VBFHToTauTau_TuneZ2_14TeV-powheg-pythia6/GEN/
input_loc=/store/user/arapyan/mc/VBFHHTobbbb_TuneZ2_8TeV-madgraph/Winter12_DR53X-PU_S10_START53_V7C-v1/GENSIM
#i=0

while read line
do
    if [[ "${line:0:1}" != "#" ]]; then
	testvar="$( /afs/cern.ch/project/eos/installation/0.3.4/bin/eos.select ls ${output_loc}/${line} 2> /dev/null )"
	if [[ ${testvar} == "" ]]; then 
	    echo    bsub -q 2nd -o /afs/cern.ch/work/j/jlawhorn/logfile_${line%.*}.txt -e /afs/cern.ch/work/j/jlawhorn/errfile_${line%.*}.txt -J ${line} run.sh ${line} $input_loc $output_loc JetStudies_Phase_II_140PileUp_conf4.tcl
	    bsub -q 2nd -o /afs/cern.ch/work/j/jlawhorn/logfile_${line%.*}.txt -e /afs/cern.ch/work/j/jlawhorn/errfile_${line%.*}.txt -J ${line} run.sh ${line} $input_loc $output_loc JetStudies_Phase_II_140PileUp_conf4.tcl
	fi
    fi
done < ${conf_file}