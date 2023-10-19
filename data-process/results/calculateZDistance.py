import pandas as pd
import numpy as np
from pathlib import Path

xyzFile = '../../data-result/results-landmarks.xlsx'

def getInd(columns, keys):
  columns = np.array(columns)
  colInd = [np.where(columns == key)[0][0] for key in keys]
  return colInd

def str2Arr(point):
  cleaned_data = point.strip('[]').split()
  float_data = [float(value) for value in cleaned_data]
  xyz = np.array(float_data)
  return xyz[2]

def modifyRow(row, columns):
  landmarks = ['LT2', 'LT1', 'LA', 'LH', 'LD', 'LB', 'LM1', 'LM2']
  landmarkInd = getInd(columns, landmarks)
  landmarkStrArr = row[landmarkInd]

  vectorized_function = np.vectorize(str2Arr)

  landmarkXArr = vectorized_function(landmarkStrArr)

  LT2, LT1, LA, LH, LD, LB, LM1, LM2  =  landmarkXArr

  AH = LA - LH
  BH = LB - LH
  AD = LA - LD
  BD = LB - LD
  HD = LH - LD
  AB = LA - LB
  M2T2 = LM2 - LT2
  M1T2 = LM1 - LT2
  T1H = LT1 - LH 
  T2H = LT2 - LH 
  M1H = LM1 - LH
  M2H = LM2 - LH
  T1A = LT1 - LA
  T2A = LT2 - LA
  T1B = LT1 - LB
  T2B = LT2 - LB

  distances = [
    [ 'AHz', 'BHz', 'HDz', 'ABz', 'M2T2z', 'T2Hz', 'M2Hz', 'ADz', 'BDz', 'T2Az', 'T2Bz', 'M1T2z', 'T1Hz', 'M1Hz', 'T1Az', 'T1Bz'],
    [ AH, BH, HD, AB, M2T2, T2H, M2H, AD, BD, T2A, T2B, M1T2, T1H, M1H, T1A, T1B]
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

  for row in data:
    row = modifyRow(row, df.columns)
  
  updateData(data, df.columns)

if __name__ == '__main__':
  #modifyRow('8-1_9-58_3')
  batch()
