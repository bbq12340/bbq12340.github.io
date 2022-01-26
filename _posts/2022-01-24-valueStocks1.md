---
layout: post
title: In the Search of Value Stocks in Korean Market pt. 1
---
# Introduction
Thanks to the Fed rate hikes announcements and quantitative easing, my stock portfolio has been going through some critical crisis these days and is still on going now. I have altered most of my investments to some relatively safe assets such as Dollars and ETFs, but still am bleeding from previous drops. Before the FOMC announcement which will be taken in few days, I have been trying to discover some value stocks that hopefully will be less painful to hold onto compared to growth stocks. Also, considering the ongoing inflation, I am expecting some of ranging chart until this May or June. Therefore, I think this is a perfect time to find a company that has been undervalued but also having the potential momentum (growth) in the marketplace.

# Strategy
I have been following Benjamin Graham's work for a quite a long time who has been emphasizing defensive investment strategy and I believe this is the time his theory is about to shine. He defined the 'value stocks' as the ones that have high dividends with low PER and PBR. Since I don't have accurate ratio of how much 'high' or 'low' it is, I earned some advices from a trader, [Jin Han Bae](https://www.youtube.com/channel/UCu2R3TCLSxYV8pRyBGNOh2g), who is currently considered one of the best ones in Korean stock market. Apparently, there is a 5x5x5 technique and the numbers indicate the condition for each variables above. To be more specific, PER should be lower than 5, PBR lower than 0.5 and the dividend yield rate higher 5%.
Therefore, I am planning to scrape all stocks uploaded in Naver Finance and manipulate the data into the condition above. Of course, this doesn't mean that the stocks will go through completely during this hard time. However, I do believe this would be the first step to find at least one or two value stocks.

# Web Scraping
```python
import requests
from bs4 import BeautifulSoup
import pandas as pd
from requests_html import HTMLSession
import numpy as np
```
I didn't take the time to clean the code because I try to accomplish this as fast as I can to keep updating the strategy to get prepared for the FOMC. 
First, I extracted all the company links from the [Naver Finanace](https://finance.naver.com/). Each of the link contains overall IR data of the selected company. My goal is to extract the year IR data of each coorperation since last year was a big win for the growth stocks. So, I extracted all the company links from the sector page. During the process, I found out that all the base urls were the same and the difference between the company links was just the code number in the parameter. So, I only extracted the codes and saved it into `code` list.
```python
# extract links for each sector
res = requests.get(
    'https://finance.naver.com/sise/sise_group.naver?type=upjong')
soup = BeautifulSoup(res.text, 'html.parser')
a_tags = soup.table.find_all('a')
df = pd.DataFrame(
    data={'sector': [a.text for a in a_tags], 'link': [a['href'] for a in a_tags]})
df.to_csv('sector_links', index=False)

# extract links of companies' analysis from each sector
session = HTMLSession()
df = pd.read_csv('sector_links')
codes = []
for l in df['link']:
    res = session.get('https://finance.naver.com'+l)
    codes.extend([list(name.absolute_links)[0].split('code=')[-1]
                  for name in res.html.find('.name')])
```
With all the company code numbers, I collected the year overall IR data. There were some companies that didn't have the data (probably were the IPOs last year), so I had to skip those by `try` & `except`.
```python
# extract information from each link
d = []
for c in codes:
    print(c)
    res = session.get(
        'https://navercomp.wisereport.co.kr/v2/company/c1010001.aspx?cmp_cd='+c)
    try:
        table = res.html.find('table.cmp-table')[0].text.split('\n')
        d.append({
            'code': c,
            'name': table[0].split()[0],
            'engName': table[1],
            'market': table[2].split()[0],
            'sector': table[3].split()[-1],
            'yearPer': table[6].split()[-1],
            'yearPbr': table[8].split()[-1],
            'yearDivYield': table[9].split()[-1]
        })
    except IndexError:
        d.append({
            'code': c,
            'name': "N/A",
            'engName': "N/A",
            'market': "N/A",
            'sector': "N/A",
            'yearPer': "N/A",
            'yearPbr': "N/A",
            'yearDivYield': "N/A"
        })
pd.DataFrame(data=d).to_csv('irData.csv', encoding='utf-8-sig', index=False)
```
These is the top results of the chart.

|code|name|engName|market|sector|yearPer|yearPbr|yearDivYield|  
|----|----|-------|------|------|-------|-------|------------|  
|009770|삼정펄프|SAMJUNGPULP|KOSPI|가정용품|49.27|0.34|3.57%|  
|044480|블루베리|Blueberry NFT|KOSDAQ|가정용품|N/A|1.76|0.00%|  
|203690|프로스테믹스|Prostemics|KOSDAQ|가정용품|N/A|5.46|0.00%|  
|012690|모나리자|Monalisa|KOSPI|가정용품|40.60|1.83|2.02%|  
|318410|비비씨|BBC|KOSDAQ|가정용품|13.45|1.06|0.00%|  

Through some manipulation and subsetting, the data has been cleaned as following.

|code|name|engName|market|sector|yearPer|yearPbr|yearDivYield|  
|----|----|-------|------|------|-------|-------|------------|  
|000700|유수홀딩스|Eusu Holdings|KOSPI|항공화물운송과물|1.61|0.43|9.04|  
|001270|부국증권|BookookSecu|KOSPI|증권|3.79,|0.33|5.01|  
|001750|한양증권|HanyangSecu|KOSPI|증권|2.62|0.4|,5.1|  
|001275|부국증권|BookookSecu|KOSPI|증권|3.79,|0.33|5.01|  
|003540|대신증권|DaishinSecu|KOSPI|증권|2.32,|0.44|7.04|  
|003547|대신증권|DaishinSecu|KOSPI|증권|2.32,|0.44|7.04|  
|030610|교보증권|KYOBOSECURITIES|KOSPI|증권|3.22,|0.37|5.63|  
|001500|현대차증권|HMSEC|KOSPI|증권|4.73|0.38|5.95|  
|003545|대신증권|DaishinSecu|KOSPI|증권|2.32,|0.44|7.04|  
|001755|한양증권|HanyangSecu|KOSPI|증권|2.62|0.4|,5.1|  
|025000|KPX케미칼|KPXCHEMICAL|KOSPI|화학|4.32|0.45|5.23|  

Something interesting is that we can see that the finance sector covers up most of the stocks as above. Plus, there is none of the stocks that are up on KOSDAQ which kind of explains the insecurity of the small companies. However, I think this is way too ignorant to invest in these stocks and not considering other factors.

# Future Direction
Hopefully, I would have the time to analyze the stocks more carefully and will be posting another one in recent time. There are few more things I want to check.
1. What is the average PBR, PER and dividend yield rate in each market, KOSPI and KOSDAQ? Is the number '5' the accurate standard?
2. What is the growth potential of each sector above?
3. Who are the major shareholders of each stock? Do they have some possibilites of problems due to inheritance or division?