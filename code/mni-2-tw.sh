# transforms z-stats from MNI space to T1w space

# Set up
STATS_DIR=/Volumes/vosslabhpc/Projects/BikeExtend/3-Experiment/2-Data/BIDS/derivatives/breathold_v22.0.2/sub-EXT2002/ses-pre/preprocAroma.feat
H5_DIR=
OUT_DIR=

flirt -in ${STATS_DIR}/rendered_thrsh_zstat1.nii.gz -ref ${H5_DIR}/ -out ${OUT_DIR}/rendered_thresh_t1w_zstat1.nii.gz -applyxfm -init ${H5_DIR}/xfm_acpc_dc2standard.mat

flirt applywarp -i ${STATS_DIR}/rendered_thrsh_zstat1.nii.gz -r ${standard2highres?} -o ${OUT_DIR}/rendered_thresh_t1w_zstat1.nii.gz -w ${standard2highres_warp?} 

#NEEDS: standard2highres warp, 