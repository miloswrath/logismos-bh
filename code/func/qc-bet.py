import os 
import subprocess
import argparse

# This file is used to quality check the outputs from bet by overlaying the mask on the original image and returning a set of PNG files


# ex file strcutre for input:
# /Volumes/vosslabhpc/Projects/BikeExtend/3-Experiment/2-Data/BIDS

# ex file structure for mask:
# /Volumes/vosslabhpc/Projects/BikeExtend/3-Experiment/2-Data/BIDS/derivatives/breathold_fsl/T1_preproc


FSLDIR = '/vosslabhpc/UniversalSoftware/fsl504/data/standard/MNI152_T1_1mm_brain.nii.gz'

def parse_args():
    parser = argparse.ArgumentParser(description='Quality check the outputs from bet by overlaying the mask on the original image and returning a set of PNG files')
    parser.add_argument('-i', type=str, help='Input image dir')
    parser.add_argument('-m', type=str, help='Mask image dir')
    parser.add_argument('-o', type=str, help='Output image dir')
    parser.add_argument('-t', type=str, help='Text file with list of subjects')
    return parser.parse_args()

def gather_images(list, indir, maskdir):
    matches = []
    for i in list:
        inpath = os.path.join(indir, f"sub-{i}", "ses-day1pre", "anat", f"sub-{i}_ses-day1pre_T1w.nii.gz")
        maskpath = os.path.join(maskdir, f"{i}", "in", f"sub-{i}_ses-day1pre_T1w_brain.nii.gz")
        matches.append([inpath, maskpath])

    return matches

def qc_bet(matches):
    for i in matches:
        inpath = i[0]
        maskpath = i[1]
        cmd = f"slicesdir -p {inpath} {maskpath}"
        subprocess.run(cmd, shell=True)

def main():
    args = parse_args()
    subs = [line.rstrip() for line in open(args.t)]
    matches = gather_images(subs, args.i, args.m)
    qc_bet(matches)

if __name__ == '__main__':
    main()
