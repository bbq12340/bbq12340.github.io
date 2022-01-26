---
layout: post
title: In the Search of Value Stocks in Korean Market pt. 2
---
# Data Analysis
To continue with the [prior post](https://bbq12340.github.io/valueStocks1/), let us answer some of the questions that I have added at the end of the blog. 
***1. What is the average PBR, PER and dividend yield rate in each market, KOSPI and KOSDAQ? Is the number '5' the accurate standard?***
```python
kospi = df.loc[df['market'] == 'KOSPI']
kosdaq = df.loc[df['market'] == 'KOSDAQ']
print(df.describe())
print(kospi.describe())
print(kosdaq.describe())
```
```
           yearPer      yearPbr  yearDivYield
count  1414.000000  1414.000000   1414.000000
mean     56.727277     1.934187      1.439158
std     300.143568     2.645417      1.569665
min       0.020000     0.000000      0.000000
25%       7.902500     0.650000      0.142500
50%      14.870000     1.200000      1.030000
75%      30.075000     2.220000      2.157500
max    6789.070000    35.280000     15.760000
           yearPer     yearPbr  yearDivYield
count   653.000000  653.000000    653.000000
mean     49.114747    1.225773      1.994962
std     281.471918    1.552071      1.762888
min       0.240000    0.160000      0.000000
25%       5.680000    0.480000      0.690000
50%      10.770000    0.740000      1.580000
75%      22.560000    1.420000      2.990000
max    4064.730000   26.310000     15.760000
           yearPer     yearPbr  yearDivYield
count   761.000000  761.000000    761.000000
mean     63.259448    2.542063      0.962234
std     315.323128    3.184869      1.192261
min       0.020000    0.000000      0.000000
25%      10.460000    0.990000      0.000000
50%      19.040000    1.690000      0.620000
75%      37.100000    2.880000      1.450000
max    6789.070000   35.280000     10.200000
```
As we can see the result above, 5 seems to be a safe number for overall. However, the number seems too harsh for KOSDAQ stocks. So, let us examine stocks for each market that are undervalued from the data above.
