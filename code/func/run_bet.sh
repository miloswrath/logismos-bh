#!/bin/bash

# Bash script to run BET on a list of subjects
# Input: list of files
# Output: skull stripped files

# Set directories
T1_DIR="/Volumes/vosslabhpc/Projects/BikeExtend/3-Experiment/2-Data/BIDS"
FSL_DIR="/Volumes/vosslabhpc/Projects/BikeExtend/3-Experiment/2-Data/BIDS/derivatives/breathold_fsl/T1_preproc"
subs="code/res/subject_list.txt"

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
        fsl_dir="${FSL_DIR}/${subject}"

        image="${t1_dir}/ses-day1pre/anat/sub-${subject}_ses-day1pre_T1w.nii.gz"
        out="${fsl_dir}/in/"

        # Check if the input file exists
        if [ ! -f "$image" ]; then
            echo "File $image not found!"
            continue
        fi

        # Run BET using the Python script
        python code/func/bet.py -i "$image" -o "$out"
    fi
done < "$subs"

echo "Done!"