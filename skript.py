from collections import Counter
from urllib.parse import urlparse

# Читаємо файли з логами та розбиваємо їх на рядки
with open('log.txt', 'r') as file:
    log_lines = file.readlines()

# Створюємо списки URL та реферерів
urls = [line.split()[6].strip('"') for line in log_lines]
# Рахуємо кількість кожного URL та кількість кожного посилання від реферерів
url_counts = Counter(urls)

# Знаходимо топ-10 URL
top_urls = url_counts.most_common(10)
kwarg={}
# Виводимо результати
print("Топ-10 URL та їх реферерів:")
a, max_count=1, 0
for url, count in top_urls:
    kwarg[a] = {"url":url, "count":int(count)}
    max_count=max_count+count
    a+=1
for i in range(1,11):
    ar = kwarg[i]
    counter = (ar["count"]*100)/max_count
    print(f" {ar['url']}  - {ar['count']} - {counter:.2f}%")
