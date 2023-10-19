import open3d as o3d
import sys
sys.path.append('..')
sys.path.append('../extraction')
from basement import Farm
from pathlib import Path
import numpy as np
from backbone import backbone, top_points

import re
import pandas as pd

root_path = '/Users/wyw/Documents/Chaper2/github-code/data/cattle-individual/reference'

def getRob(name):
  calf = Farm(name, rotate=False, data_path=root_path, mkdir=False)

  return calf

def pro(calf):
  pcd, ind = calf.pcd.remove_statistical_outlier(nb_neighbors=3, std_ratio=0.01)
  calf.updatePCD(pcd)
  #calf.show_summary()

  top = calf.summary["max_bound"][2]
  bottom = top - 0.048
  # 9-76 使用0.06
  #bottom = top - 0.06

  pcd = calf.crop_z2(bottom, top)
  calf.updatePCD(pcd)
  #calf.show_summary()

  #9-75 滤噪
  #pcd, ind = calf.pcd.remove_statistical_outlier(nb_neighbors=3, std_ratio=0.01)
  #calf.updatePCD(pcd)
  ##calf.show_summary()

  length = calf.summary["region"][0]

  return calf.summary["min_bound"][0], calf.summary["max_bound"][0], length, calf.summary["points"]

def batch_rob():
  robs=dict()
  patten = '*_fence_T.pcd'
  robs_dir = Path(root_path)
  files = robs_dir.glob(patten)
  
  for rob in files:
    plan = rob.stem.split('_')[0]
    #print('rob file name:', rob, plan)

    if plan not in robs:
      robs[plan] = dict()
    
    calf = getRob(rob)
    [a, b, c, d] = pro(calf)

    robs[plan]['left'] = a
    robs[plan]['right'] = b
    robs[plan]['width'] = c
    robs[plan]['size'] = d

  return robs

def batch():
  robs = batch_rob()
  convert(robs)
  

def convert(data):
  # Initialize the result list with column headers
  result_list = [{'plan': 'plan', 'left': 'left', 'right': 'right', 'width': 'width'}]

  # Add the data rows
  for key, values in data.items():
    row_dict = {'plan': key}  # First column is 'plan'
    row_dict.update(values)    # Add the values from the inner dictionary
    result_list.append(row_dict)

  # Print the resulting list of dictionaries
  df = pd.DataFrame(result_list)
  df.to_excel('/Users/wyw/Documents/Chaper2/github-code/segmentation-3D/data-result/reference/robs.xlsx', index=False)

if __name__ == '__main__':

  batch()
  #name = '9-58_fence_T.pcd'
  #calf = getRob(name)
  #pro(calf)
