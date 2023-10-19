import sys
import numpy as np
sys.path.append('../..')
from farm import Farm
from pathlib import Path


pcd_path = Path('/Users/wyw/Documents/Chaper2/github-code/data/cattle/9-62/uncertain')
name = '9-62_cropx_cropz_cluster_8.pcd'

calf = Farm(name, rotate=False, data_path=pcd_path, mkdir=False)

min_y = calf.summary['min_bound'][1]
max_y = calf.summary['max_bound'][1] - 0.57
min_z = calf.summary['min_bound'][2]

cpcd = calf.cropFarm_y(max_y, min_y)

calf.updatePCD(cpcd)

labels = calf.cluster(min_points=1, min_cluster=6000, eps=0.05)
calf.saveClusters_2(labels)

#calf.show_summary()
#calf.visual()
