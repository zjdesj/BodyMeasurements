import sys
import numpy as np
sys.path.append('..')
from farm import segmentation, test_segment, getNumbers, dbscan
from individuals import process
from pathlib import Path
from basement import Farm

pcd_path = '/Volumes/2T-Experiment/许昌牛场PCD/ret_pcd'
pcd_name = '9-56.pcd'

stem = Path(pcd_name).stem
farm_path = str(Path(pcd_path, stem))
cattle_path = str(Path(pcd_path, stem, stem + '_cropx', stem + '_cropx_cropz/clusters/standing'))
p_path = str(Path(pcd_path, stem, stem + '_cropx', stem + '_cropx_cropz/', stem + '_cropx_cropz.pcd'))

#segmentation(pcd_path, pcd_name, 5.5, shift_y=1.7)

##process(cattle_path, farm_path)
#
##test_segment(p_path, 0.03, 1, 400, save=True)
#
##dbscan(p_path, -9.45, 0.05, 1, 3000)
#
##getNumbers(p_path, -9.45)


c_path = str(Path(pcd_path, stem, stem + '_cropx', stem + '_cropx_cropz/'))
farm = Farm('9-56_cropx_cropz.pcd', rotate=False, data_path=c_path, mkdir=False)

labels = np.load('/Volumes/2T-Experiment/许昌牛场PCD/ret_pcd/9-56/9-56_cropx/9-56_cropx_cropz/9-56_cropx_cropz_0.05_1_3000.npy')
farm.showClusters(labels, save=True)

