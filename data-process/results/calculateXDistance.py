import pandas as pd
import numpy as np
from pathlib import Path

#xyzFile = '../../data-result/results-landmarks.xlsx'
xyzFile = '../../data-result/results-dimensions-adjusted.xlsx'

def getInd(columns, keys):
  columns = np.array(columns)
  colInd = [np.where(columns == key)[0][0] for key in keys]
  return colInd

def str2Arr(point):
  cleaned_data = point.strip('[]').split()
  float_data = [float(value) for value in cleaned_data]
  xyz = np.array(float_data)
  return xyz[0]

def modifyRow2(row, columns):
  landmarks = ['BAx', 'MBL', 'MBL_x', 'ABz']
  landmarkInd = getInd(columns, landmarks)
  landmarkXArr = row[landmarkInd]

  BAx, MBL, MBL_x, ABz  =  landmarkXArr

  
  MBL_BAx = MBL - BAx
  MBL_BAx_ABz = -(MBL-BAx-ABz)
  MBL_x_BAx = MBL_x - BAx

  distances = [
    [ 'MBL_BAx', 'MBL_BAx_ABz', 'MBL_x_BAx'],
    [ MBL_BAx, MBL_BAx_ABz, MBL_x_BAx]
  ]

  distancesInd = getInd(columns, distances[0])
  row[distancesInd] = distances[1]

  return row


def modifyRow(row, columns):
  #landmarks = ['LT2', 'LT1', 'LA', 'LH', 'LD', 'LB', 'LM1', 'LM2', 'BA']
  landmarks = ['BA']
  landmarkInd = getInd(columns, landmarks)
  landmarkStrArr = row[landmarkInd]

  vectorized_function = np.vectorize(str2Arr)

  landmarkXArr = vectorized_function(landmarkStrArr)

  LT2, LT1, LA, LH, LD, LB, LM1, LM2  =  landmarkXArr

  HA = LH - LA
  BH = LB - LH
  DH = LD - LH
  BA = LB - LA
  M2T2 = LM2 - LT2
  HT2 = LH - LT2
  HT1 = LH - LT1
  M2H = LM2 - LH
  M1H = LM1 - LH
  AT1 = LA - LT1
  AT2 = LA - LT2

  distances = [
    [ 'HAx', 'BHx', 'DHx', 'BAx', 'M2T2x', 'HT2x', 'HT1x', 'M2Hx', 'M1Hx', 'AT1x', 'AT2x'],
    [ HA, BH, DH, BA, M2T2, HT2, HT1, M2H, M1H, AT1, AT2]
  ]

  distancesInd = getInd(columns, distances[0])
  row[distancesInd] = distances[1]

  return row
  
def updateData(data, cols):
  df2 = pd.DataFrame(data, columns=cols)
  df2.to_excel(xyzFile, index=False)

def batch(): 
  df = pd.read_excel(xyzFile , sheet_name='Sheet1')
  data = df.values

  for ind, row  in enumerate(data):
    row = modifyRow2(row, df.columns)
  
  updateData(data, df.columns)

if __name__ == '__main__':
  #modifyRow('8-1_9-58_3')
  batch()
