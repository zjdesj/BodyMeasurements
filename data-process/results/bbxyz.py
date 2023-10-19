import open3d as o3d
import sys
sys.path.append('..')
from basement import Farm
from pathlib import Path
import numpy as np
import pandas as pd

import re


def getInd(columns, keys):
  columns = np.array(columns)
  colInd = [np.where(columns == key)[0][0] for key in keys]
  return colInd

def str2Arr(point):
  cleaned_data = point.strip('[]').split()
  float_data = [float(value) for value in cleaned_data]
  xyz = np.array(float_data)
  return xyz

def getSpinePoints(name):
  root_path = '/Users/wyw/Documents/Chaper2/github-code/data/cattle-individual/r-feature'
  calf = Farm(name, rotate=False, data_path=root_path, mkdir=False)

  pts = calf.getPoints()
  print(f'pts: {len(pts)}')

  sortedInd = np.argsort(pts[:, 0])

  return pts[sortedInd]

def queryColumn(stem, A, B):
  xyzFile = '../../data-result/results-landmarks.xlsx'
  df = pd.read_excel(xyzFile , sheet_name='Sheet1')
  data = df.values
  AInd = np.where(df.columns == A)[0][0]
  BInd = np.where(df.columns == B)[0][0]

  try:
    index = np.where(data[:, 4] == stem)[0][0]
    return data[index][AInd], data[index][BInd]
  except:
    print('QueryColumn failed')


def getAxBx(stem):
  #stem = re.sub(r'_re_pure_.*_bbInCattle_HH.pcd', '', name)
  A, B = queryColumn(stem, 'LA', 'LB')
  print(f'A: {A} B: {B}')

  return str2Arr(A), str2Arr(B)

def saveData(stem, pts):
  xyzPath = '/Users/wyw/Documents/Chaper2/github-code/data/cattle-individual/bb/'
  df2 = pd.DataFrame(pts, columns=['x', 'y', 'z'])
  df2.to_excel(xyzPath + f'{stem}.xlsx', index=False)

def sliceBB(pts, Ax, Bx):
  apts = np.round(pts,4)
  AInd = np.where(apts[:, 0] == round(Ax[0], 4))[0][0]
  BInd = np.where(apts[:,0] == round(Bx[0], 4))[0][0]

  print(f'AInd: {AInd}, BInd: {BInd}')
  return pts[AInd: (BInd + 1), :]

def batchBB(patten):
  bb_path = '/Users/wyw/Documents/Chaper2/github-code/data/cattle-individual/r-feature'
  cattle_dir = Path(bb_path)
  files = cattle_dir.glob(patten)

  for calfFile in files:
    name = Path(calfFile).name
    
    print('calf file name:', calfFile, name)
    stem = re.sub(r'_re_pure_.*', '', name)

    pts = getSpinePoints(name)
    #saveData(stem, pts)
    Ax, Bx = getAxBx(stem)

    print(Ax, Bx)
    spts = sliceBB(pts, Ax, Bx)
    saveData(stem, spts)

if __name__ == '__main__':
  
  patten = '*_bb.pcd'
  #patten = '8-1_9-58_3_re_pure_2_bb.pcd'
  #patten = '30-1_9-73_11_0_re_pure_0_bb'
  batchBB(patten)