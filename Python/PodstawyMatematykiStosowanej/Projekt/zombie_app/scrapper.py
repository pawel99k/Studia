import bs4
import requests
import pandas as pd
page_url = 'https://pl.wikipedia.org/wiki/Miasta_w_Unii_Europejskiej_wed%C5%82ug_liczby_ludno%C5%9Bci'

r = requests.get(page_url)

soup = bs4.BeautifulSoup(r.content, 'html.parser')
table = soup.find('table', class_ = 'wikitable')
cities = []
populations = []

for row in table.findAll('tr'):
    cells = row.findAll('td')
    if len(cells) == 5:
        City = cells[1].text.strip()
        population = int(''.join(cells[2].find(text=True).split()))
        print(City, population)
        cities.append(City)
        populations.append(population)

df = pd.DataFrame(index = range(len(cities)), columns=['City', 'Population'])
df['City'] = cities
df['Population'] = populations

df.to_csv('populations_data.csv')
