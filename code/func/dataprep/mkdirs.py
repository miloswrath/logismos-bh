# makes subject dirs in the breathhold fsl directory
import os
import pandas as pd
BREATHHOLD_DIR = '/Volumes/vosslabhpc/Projects/BikeExtend/3-Experiment/2-Data/BIDS/derivatives/breathold_fsl/T1_preproc'

df = pd.read_csv('./data/breathhold_clusters.csv')
subs = df['subID'].unique()

for sub in subs:
    sub_dir = os.path.join(BREATHHOLD_DIR, str(sub), 'in')
    os.makedirs(sub_dir, exist_ok=True)
    print(f'Created directory: {sub_dir}')


#create a txt file with the subject list
for sub in subs:
    with open('./code/res/subject_list.txt', 'a') as f:
        f.write(str(sub) + '\n')
