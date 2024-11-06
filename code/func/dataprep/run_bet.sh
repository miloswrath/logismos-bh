#!/bin/bash

# Bash script to run BET on a list of subjects
# Input: list of files
# Output: skull stripped files

# Set directories
T1_DIR="/Shared/vosslabhpc/Projects/BikeExtend/3-Experiment/2-Data/BIDS"
FMRIPREP_DIR="/Shared/vosslabhpc/Projects/BikeExtend/3-Experiment/2-Data/BIDS/derivatives/fmriprep_v22.0.2"
FSL_DIR="/Shared/vosslabhpc/Projects/BikeExtend/3-Experiment/2-Data/BIDS/derivatives/breathold_fsl/T1_preproc"
subs="code/res/subject_list_test.txt"

# Check if the subject list file exists
if [ ! -f "$subs" ]; then
    echo "File $subs not found!"
    exit 1
fi

# Read the list of subjects
while IFS= read -r subject; do
    subject=$(echo "$subject" | xargs)

    # Check if the line is not empty
    if [ -n "$subject" ]; then
        # Define paths for T1 and output directories
        t1_dir="${T1_DIR}/sub-${subject}"
        fm_dir="${FMRIPREP_DIR}/sub-${subject}"
        fsl_dir="${FSL_DIR}/${subject}"

        raw_image="${t1_dir}/ses-day1pre/anat/sub-${subject}_ses-day1pre_T1w.nii.gz"
        fmri_iamge="${fm_dir}/ses-day1pre/anat/sub-${subject}_ses-day1pre_desc-preproc_T1w.nii.gz"
        rout="${fsl_dir}/in/sub-${subject}_ses-day1pre_T1w_brain_RAW"
        fout="${fsl_dir}/in/sub-${subject}_ses-day1pre_desc-preproc_T1w_brain_FMRI"
        # Check if the input file exists
        if [ ! -f "$image" ]; then
            echo "File $image not found!"
            continue
        fi

        # Run BET using the Python script
        bet "$raw_image" "$rout" -f 0.6 -g -.1 -R -v -o -B
        bet "$fmri_image" "$fout" -f 0.6 -g -.1 -R -v -o -B
    fi
done < "$subs"

echo "Done!"