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

def getBar(name):
  calf = Farm(name, rotate=False, data_path=root_path, mkdir=False)

  return calf

def pro(calf):
  pcd, ind = calf.pcd.remove_statistical_outlier(nb_neighbors=3, std_ratio=0.005)
  calf.updatePCD(pcd)

  #tpcd = backbone(calf)
  [tops, a, b] = top_points(calf)
  print(len(tops))

  sd = np.std(tops[:, 2])
  mean = np.mean(tops[:, 2])
  print(mean, sd)
  return mean, sd, calf.summary["points"]
  
def batch_bar(patten, name, bars=dict()):
  bars_dir = Path(root_path)
  files = bars_dir.glob(patten)
  
  for bar in files:
    plan = bar.stem.split('_')[0]
    print('bar file name:', bar, plan)

    if plan not in bars:
      bars[plan] = dict()
    
    calf = getBar(bar)
    [a, b, c] = pro(calf)

    bars[plan][f'{name}_mean'] = a
    bars[plan][f'{name}_sd'] = b
    bars[plan][f'{name}_size'] = c

  return bars

def batch():
  patten = '*_fence_L1.pcd'
  bars = batch_bar(patten, 'lt')
  patten = '*_fence_L2.pcd'
  bars = batch_bar(patten, 'lb', bars=bars)

  patten = '*_fence_R1.pcd'
  bars = batch_bar(patten, 'rt', bars=bars)
  patten = '*_fence_R2.pcd'
  bars = batch_bar(patten, 'rb', bars=bars)

  print(bars)
  convert(bars)
  

def convert(data):
  # Initialize the result list with column headers
  result_list = [{'plan': 'plan', 'lt_mean': 'lt_mean', 'lt_sd': 'lt_sd', 'lb_mean': 'lb_mean', 'lb_sd': 'lb_sd', 'rt_mean': 'rt_mean', 'rt_sd': 'rt_sd', 'rb_mean': 'rb_mean', 'rb_sd': 'rb_sd', 'lt_size': 'lt_size', 'lb_size': 'lb_size', 'rt_size': 'rt_size', 'rb_size': 'rb_size'}]

  # Add the data rows
  for key, values in data.items():
    row_dict = {'plan': key}  # First column is 'plan'
    row_dict.update(values)    # Add the values from the inner dictionary
    result_list.append(row_dict)

  # Print the resulting list of dictionaries
  df = pd.DataFrame(result_list)
  df.to_excel('/Users/wyw/Documents/Chaper2/github-code/segmentation-3D/data-result/bars.xlsx', index=False)

if __name__ == '__main__':

  batch()
  #name = '9-58_fence_L1.pcd'
  #calf = getBar(name)

  #name = '9-58_fence_L2.pcd'
  #calf2 = getBar(name)

  #[a, b] = pro(calf)
  #[c, d] = pro(calf2)

  #gap = a - c
  #print(gap)
  
  
