# BodyMeasurements
Code and data for paper titled "Automated Retrieval of Cattle Body Measurements from LiDAR-Derived Point Cloud Data through Unmanned Aerial Vehicle" 

## segment 使用： "Usage of 'segment':

- 1 Start by writing the 'farm{day-num}.py' script to separate individual point clouds. Data is recorded in the 'flight-result-segment.xlsx' under 'flights.'
- 2 Use 'moveCluster.py' to group the standing cattle files together and copy them to the Mac.
- 3 Examine each standing point cloud, record posture, noise, and direction in 'flight-result-segment.xlsx' under 'standing-cattle' and 'direction.'
- 4 For point clouds that require processing ('uncertain'), create a 'farm{day-num}' folder. Process individual point clouds and record as in step 3.
- 5 Use 'entitie.py' to cut the point clouds out of the 'farm' point clouds.
- 6 Supplement 'data.csv' with the aim of automating point cloud movement.
- 7 Use 'move_individual_batch.py' to complete the point cloud transfer."

-------

- 1 先写 farm{day-num}.py 文件拆分出单个点云。 
  数据记录在flight-result-segement.xlsx的flights中。
- 2 使用moveCluster.py 将站立牛的文件移动到一起。并复制到mac中
- 3 查看每个standing点云记录姿态、噪音、以及方向到flight-result-segement.xslx的standing-cattle和direction中。
- 4 对有待处理点云（uncertain）创建farm{day-num}文件夹。对单个点云创建处理文件。并如3记录
- 5 使用entitie.py将点云从farm点云中切出。
- 6 补充data.csv 目的是自动化移动点云。
- 7 使用move_individual_batch.py 完成点云移动。

## 属性抽取 extraction
- 1 Start by completing 'data-direction.xslx.'
- 2 Use 'transDirectionData.py' to flatten 'data-direction.xlsx' into 'data-direction-flat.xlsx.'
- 3 Rotate the point clouds using 'normalisation_batch.py.'
- 4 Apply filtering using 'denoise_batch.py.'
- 5 Use 'backbone_batch.py' to obtain relevant backbone point clouds.
- 6 Update the width with 'belly.py.'
- 7 Extract hip point clouds from the 'bbInCattle' files.
- 8 Update 'hipheight' data with 'hipHeight.py.'

-------

- 1 先完成data-direction.xslx
- 2 使用transDirectionData.py将data-direction.xlsx打平到data-direction-flat.xlsx
- 3 使用normalisation_batch.py将点云旋转
- 4 使用denoise_batch.py 过滤
- 5 使用backbone_batch.py获取相关的脊柱点云
- 6 使用belly.py更新宽度
- 7 从bbInCattle 文件中截取hip点云
- 8 使用hipHeight.py 更新hipheight数据。

## data-measurment.xlsx 属性说明: the attributes in the 'data-measurement.xlsx':

- hip H: Height using the bounding box.
- HH: Height using the bounding box minus ground height.
- 
- joint hip H: The first highest point distinguished by setting color[0] = 1.
- joint HH: The first highest point (joint hip H) minus ground height.
- 
- JHH: The first highest point distinguished by setting color[0] = 1 and color[1] = 0.
- JHHG: JHH (the first highest point) minus ground height.
- Bsize: Number of backbone points.
- 
- joint: Coordinates of the first right intersection point with the backbone.
- 
- waist height: Find the highest Z value within 0.4 meters to the left of the cross-section as waist height.
- waist H: Waist height minus ground height.
- waistgap: Left side of the cross-section, greater than 0.5 meters.
- 
- withers height: Find the highest Z value within 0.6 to 0.8 meters to the right of the cross-section as withers height.
- withers H: Withers height minus ground height.
- withersgap: Distance of the highest point X from the cross-section X + 0.6.
- 
- withers height2: Find the highest Z value within 0.55 to 0.8 meters to the right of the cross-section as withers height.
- withers H2: Withers height minus ground height.
- withersgap2: Distance of the highest point X from the cross-section X + 0.6.
- 
- back height: Find the lowest Z value within the cross-section to cross-section + 0.5 as back height.
- back H: Back height minus ground height.

- LA, LB1, LB2, LD, LT1, LT2, LM1, LM2 # xyz of body-marks (or landmarks)

- MBL # morphorlogical body length

-------

-  hip H #使用bounding box框高 
-  HH # bounding box框高 - ground height
-
-  joint hip H #使用color[0] = 1来区分坐标值的 第一高点
-  joint HH # joint hip H - ground height
-
-  JHH #使用color[0] = 1, color[1] = 0来区分坐标值的 第一高点
-  JHHG # JHH - ground height
-  Bsize # backbone 点个数

-  joint #截面与backbone相交的右边第一点坐标

-  waist height # 从截面往左0.4m 找寻到最高z值作为waist height
-  waist H # waist height - ground height
-  waistgap # 截面左侧 > 0.5 m

-  withers height # 截面右侧 0.6 -0.8m 找寻到最高z值作为withers height
-  withers H  # withers height - ground height
-  withersgap	 # 最高点x距离截面x + 0.6 距离

-  withers height2 # 截面右侧 0.55 -0.8m 找寻到最高z值作为withers height
-  withers H2	# withers height - ground height
-  withersgap2 # 最高点x距离截面x + 0.6 距离

-  back height # 从截面到截面+ 0.5 中找寻最低z值作为back height
-  back H # back height - ground height

- LA, LB1, LB2, LD, LT1, LT2, LM1, LM2 # xyz of body-marks (or landmarks)

- MBL #体长