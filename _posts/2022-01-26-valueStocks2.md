---
layout: post
title: In the Search of Value Stocks in Korean Market pt. 2
---
# Data Analysis
To continue with the [prior post](https://bbq12340.github.io/valueStocks1/), let us answer some of the questions that I have added at the end of the blog. **I shifted the coding environment from Python to R for data manipulation convenience.*
***1. What is the average PBR, PER and dividend yield rate in each market, KOSPI and KOSDAQ? Is the number '5' the accurate standard?***

```
    yearPer            yearPbr        yearDivYield    
 Min.   :   0.020   Min.   : 0.000   Min.   : 0.0000  
 1st Qu.:   7.902   1st Qu.: 0.650   1st Qu.: 0.1425  
 Median :  14.870   Median : 1.200   Median : 1.0300  
 Mean   :  56.727   Mean   : 1.934   Mean   : 1.4392  
 3rd Qu.:  30.075   3rd Qu.: 2.220   3rd Qu.: 2.1575  
 Max.   :6789.070   Max.   :35.280   Max.   :15.7600  

    yearPer           yearPbr        yearDivYield   
 Min.   :   0.24   Min.   : 0.160   Min.   : 0.000  
 1st Qu.:   5.68   1st Qu.: 0.480   1st Qu.: 0.690  
 Median :  10.77   Median : 0.740   Median : 1.580  
 Mean   :  49.12   Mean   : 1.226   Mean   : 1.995  
 3rd Qu.:  22.56   3rd Qu.: 1.420   3rd Qu.: 2.990  
 Max.   :4064.73   Max.   :26.310   Max.   :15.760  

    yearPer           yearPbr        yearDivYield    
 Min.   :   0.02   Min.   : 0.000   Min.   : 0.0000  
 1st Qu.:  10.46   1st Qu.: 0.990   1st Qu.: 0.0000  
 Median :  19.04   Median : 1.690   Median : 0.6200  
 Mean   :  63.26   Mean   : 2.542   Mean   : 0.9622  
 3rd Qu.:  37.10   3rd Qu.: 2.880   3rd Qu.: 1.4500  
 Max.   :6789.07   Max.   :35.280   Max.   :10.2000 
```
As we can see the result above, 5 seems to be a safe number for overall. However, the number seems too harsh for KOSDAQ stocks. So, let us examine stocks for each market that are undervalued from the data above. I manipulated the stocks data into rows with top 10% lowest PBR, PER and top 10% highest dividend yield rate.
```r
> low_value_kospi <- kospi[which(kospi$yearPer <= quantile(kospi$yearPer, 0.1) & kospi$yearPbr <= quantile(kospi$yearPbr, 0.1) & kospi$yearDivYield >= quantile(kospi$yearDivYield, 0.9)),]
> low_value_kosdaq <- kosdaq[which(kosdaq$yearPer <= quantile(kosdaq$yearPer, 0.1) & kosdaq$yearPbr <= quantile(kosdaq$yearPbr, 0.1) & kosdaq$yearDivYield >= quantile(kosdaq$yearDivYield, 0.9)),]
```
```
# low_value_kospi
       code            name     engName market       sector yearPer yearPbr yearDivYield
324  017940              E1          E1  KOSPI 가스유틸리티    2.09    0.21         4.70
500  016610      DB금융투자        DBFI  KOSPI         증권    1.96    0.30         4.57
765  092230       KPX홀딩스 KPXHOLDINGS  KOSPI         화학    1.86    0.30         4.98
1196 294870 HDC현대산업개발      HDC-OP  KOSPI         건설    3.09    0.32         4.23

# low_value_kosdaq
       code             name             engName market   sector yearPer yearPbr yearDivYield
283  012700         리드코프            LEADCORP KOSDAQ 기타금융    5.17    0.48        10.20
490  078020 이베스트투자증권            eBEST IS KOSDAQ     증권    3.24    0.59         7.04
1028 017480         삼현철강              SAMSCO KOSDAQ     철강    3.85    0.51         2.68
1209 054930             유신             Yooshin KOSDAQ     건설    5.57    0.56         3.00
1212 013120         동원개발             Dongwon KOSDAQ     건설    4.11    0.49         3.65
1214 037350       성도이엔지          SUNGDO ENG KOSDAQ     건설    0.95    0.30         3.83
1221 036190     금화피에스시         Geumhwa PSC KOSDAQ     건설    5.68    0.64         4.36
1225 035890         서희건설 Seohee Construction KOSDAQ     건설    2.18    0.54         2.54
1226 011370             서한              Seohan KOSDAQ     건설    4.40    0.45         2.60
```
Now, as we all can see the sector is quite different from the first post which is very interesting. I would like to hold onto this result rather than the previous post because it seems more reasonable than just the number '5'.

**2. What is the growth potential of each sector above?**
Then, how is the flow of each sector?