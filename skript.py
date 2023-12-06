from collections import Counter
from urllib.parse import urlparse

# Читаємо файли з логами та розбиваємо їх на рядки
with open('log.txt', 'r') as file:
    log_lines = file.readlines()

# Створюємо списки URL та реферерів
urls = [line.split()[6].strip('"') for line in log_lines]
referers = [line.split()[10].strip('"') for line in log_lines if '"Referer:' in line]

# Рахуємо кількість кожного URL та кількість кожного посилання від реферерів
url_counts = Counter(urls)
referer_counts = Counter(referers)

# Знаходимо топ-10 URL
top_urls = url_counts.most_common(10)

# Виводимо результати
print("Топ-10 URL та їх реферерів:")
for url, count in top_urls:
    print(f"{url} - {count} - 100%")
    
    # Знаходимо топ-10 реферерів для кожного URL
    url_referers = [referer for referer in referers if url in referer]
    referer_counts_url = Counter(url_referers)
    
    for referer, referer_count in referer_counts_url.most_common(10):
        percent = (referer_count / count) * 100
        print(f"  {referer} - {referer_count} - {percent:.2f}%")
    
    print()
