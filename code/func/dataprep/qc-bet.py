import os
import subprocess
import argparse
import tempfile

FSLDIR = '/vosslabhpc/UniversalSoftware/fsl504/data/standard/MNI152_T1_1mm_brain.nii.gz'

def parse_args():
    parser = argparse.ArgumentParser(description='Quality check the outputs from bet by overlaying the mask on the original image and returning a set of PNG files')
    parser.add_argument('-i', type=str, help='Input image dir')
    parser.add_argument('-m', type=str, help='Mask image dir')
    parser.add_argument('-o', type=str, help='Output image dir')
    parser.add_argument('-t', type=str, help='Text file with list of subjects')
    return parser.parse_args()

def gather_images(subs, indir, maskdir):
    matches = []
    for sub in subs:
        inpath = os.path.join(indir, f"sub-{sub}", "ses-day1pre", "anat", f"sub-{sub}_ses-day1pre_T1w.nii.gz")
        maskpath = os.path.join(maskdir, f"{sub}", "in", f"sub-{sub}_ses-day1pre_T1w_brain.nii.gz")
        matches.append([inpath, maskpath])
    return matches

def qc_bet(matches):
    # Verify all paths before proceeding
    missing_files = [pair for pair in matches if not (os.path.exists(pair[0]) and os.path.exists(pair[1]))]
    if missing_files:
        print("Error: The following files are missing:")
        for inpath, maskpath in missing_files:
            if not os.path.exists(inpath):
                print(f"Missing input file: {inpath}")
            if not os.path.exists(maskpath):
                print(f"Missing mask file: {maskpath}")
        return  # Exit if any files are missing

    # Construct the command by adding all pairs directly
    file_pairs = " ".join([f"{inpath} {maskpath}" for inpath, maskpath in matches])
    cmd = f"slicesdir -o {file_pairs}"

    # Execute the slicesdir command
    print(f"Running command: {cmd}")
    subprocess.run(cmd, shell=True)

def main():
    args = parse_args()
    subs = [line.rstrip() for line in open(args.t)]
    matches = gather_images(subs, args.i, args.m)
    qc_bet(matches)

if __name__ == '__main__':
    main()