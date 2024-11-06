# this file using the brain extractor tool (BET) to extract the brain from the MRI image

import os
from brainextractor import BrainExtractor
import nibabel as nib
import argparse

def parse_args():
    argparser = argparse.ArgumentParser(description='Extract the brain from the MRI image using the brain extractor tool (BET).')
    argparser.add_argument('-i', type=str, help='Path to the MRI image.')
    argparser.add_argument('-o', type=str, help='Path to the output directory.')
    argparser.add_argument('-f', type=float, default=0.5, help='Fractional intensity threshold (0->1).')
    return argparser.parse_args()


def bet(image, output_dir, **kwargs):
    """
    Extract the brain from the MRI image using the brain extractor tool (BET).

    Parameters
    ----------
    image : str
        Path to the MRI image.
    output_dir : str
        Path to the output directory.
    kwargs : dict
        will be using :
            - f : float -> set to 0.5 (default)
            - n : int -> set to 1000 (default)
    """
    output_images = []
    input_img = nib.load(image)

    # create a BrainExtractor object using the input_img as input
    # we just use the default arguments here, but look at the
    # BrainExtractor class in the code for the full argument list
    bet = BrainExtractor(img=input_img, **kwargs)

    bet.run()

    image_name = os.path.basename(image).split('.')[0]

    # save the computed mask out to file
    bet.save_mask(os.path.join(output_dir, f'{image_name}_brain.nii.gz'))
    output_images.append(os.path.join(output_dir, f'{image_name}_brain.nii.gz'))
    
    return output_images


def main():
    args = parse_args()
    bet(args.i, args.o, bt=args.f)

if __name__ == '__main__':
    main()