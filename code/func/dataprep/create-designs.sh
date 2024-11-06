#NEEDS
#OUTDIR
#FSLDIR
#BHFILE
#SKULLSTRIP

#/Volumes/vosslabhpc/Projects/BikeExtend/3-Experiment/2-Data/BIDS/sub-2002/ses-day1pre/func/sub-2002_ses-day1pre_task-breathhold_bold.nii.gz


#!/bin/bash

BIDSDERIV=/Shared/vosslabhpc/Projects/BikeExtend/3-Experiment/2-Data/BIDS/derivatives
FSLPATH=/Shared/vosslabhpc/Projects/BikeExtend/3-Experiment/2-Data/BIDS/derivatives/breathold_fsl
JOBSDIR=/Shared/vosslabhpc/Projects/BikeExtend/3-Experiment/2-Data/BIDS/derivatives/breathold_fsl/code/job_scripts/

cd ${JOBSDIR}

for sub in `cat ${FSLPATH}/code/subject_list_test.txt`
do
    # Set variables based on the subject name
    OUTDIR="${FSLPATH}/sub-${sub}"
    FSLDIR="/opt/fsl-6.0.1/"
    BHFILE="/Volumes/vosslabhpc/Projects/BikeExtend/3-Experiment/2-Data/BIDS/sub-${sub}/ses-day1pre/func/sub-${sub}_ses-day1pre_task-breathhold_bold.nii.gz"
    SKULLSTRIP="${FSLPATH}/T1_preproc/${sub}/in/sub-${sub}_ses-day1pre_desc-preproc_T1w_brain.nii.gz"

    # Search and replace in the template
    sed -e 's|SUBJECT|'"sub-${sub}"'|g' \
        -e 's|OUTDIR|'${OUTDIR}'|g' \
        -e 's|FSLDIR|'${FSLDIR}'|g' \
        -e 's|BHFILE|'${BHFILE}'|g' \
        -e 's|SKULLSTRIP|'${SKULLSTRIP}'|g' \
        breathold-hpc-TEMPLATE.fsf > sub-${sub}_feat.fsf

done

unset BIDSDERIV FSLPATH JOBSDIR