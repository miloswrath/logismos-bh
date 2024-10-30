# LOGISMOS Registered ML Prediction of Cerebrovascular Disposition to Exercise Intervention Benefits at Baseline

This repo houses the code and data used to analyze cerebrovascular features at baseline (along with covariates) and their relation to responses and benefits of an exercise intervention trial

The data comes from HBCs EXTEND study directed by PI Michelle Voss

Images used were: 
- Native Space 4D CVR images from breathhold task
- Hippocampal masks derived from Deep Logismos registered to the CVR images

For any correspondance, please email me at zakgilliam@gmail.com

### Image Transforms
- Applied `fslmaths` t1 brain mask to images with skull and spine
- 


## Tasks
- [] change breathhold_fsl design file, change the preprocessing steps to account for source of skull stripped t1w's
- [] change breathhold_fsl design file, change the preprocessing steps to account for source of skull stripped t1w's
- [] uncheck melodic for space and time
- [] change the output to a deriv dir and not the design
- [] add all the wild cards in
- [x] check to see if t1w _brain exists in fmriprep folder
    - [x] if not, use the script mwv sent to run BET on the t1w images 

