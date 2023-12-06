200~#!/bin/bash

# Використовуйте grep та awk для отримання списку URL та реферерів
urls=$(grep -o '"GET[^"]*' log.txt | awk '{print $2}')
referers=$(grep -o '"Referer:[^"]*' log.txt | awk '{print $2}')

# Створення асоціативного масиву для зберігання кількості кожного URL
declare -A url_count

# Заповнення масиву кількостіми URL
for url in $urls; do
    ((url_count[$url]++))
done

# Заповнення масиву кількостіми реферерів для кожного URL
declare -A referer_count
for ((i=1; i<=${#urls[@]}; i++)); do
    url=${urls[$i-1]}
    referer=${referers[$i-1]}
    ((referer_count[$url,$referer]++))
done

# Створення топ-10 URL
top_urls=$(for url in "${!url_count[@]}"; do
    echo "$url ${url_count[$url]}"
done | sort -k2 -nr | head -n 10)

# Виведення результатів
echo "Топ-10 URL та їх реферерів:"
while read -r line; do
    url=$(echo $line | awk '{print $1}')
    count=${url_count[$url]}
    echo "$url - $count - 100%"
    
    # Виведення топ-10 реферерів для кожного URL
    for referer in "${!referer_count[@]}"; do
        if [[ $referer == *$url* ]]; then
            percent=$(echo "scale=2; ${referer_count[$referer]} / $count * 100" | bc)
            echo "  $referer - ${referer_count[$referer]} - $percent%"
        fi
    done
    echo
done <<< "$top_urls"
#!/bin/bash

# Використовуйте grep та awk для отримання списку URL та реферерів
urls=$(grep -o '"GET[^"]*' log.txt | awk '{print $2}')
referers=$(grep -o '"Referer:[^"]*' log.txt | awk '{print $2}')

# Створення асоціативного масиву для зберігання кількості кожного URL
declare -A url_count

# Заповнення масиву кількостіми URL
for url in $urls; do
    ((url_count[$url]++))
done

# Заповнення масиву кількостіми реферерів для кожного URL
declare -A referer_count
for ((i=1; i<=${#urls[@]}; i++)); do
    url=${urls[$i-1]}
    referer=${referers[$i-1]}
    ((referer_count[$url,$referer]++))
done

# Створення топ-10 URL
top_urls=$(for url in "${!url_count[@]}"; do
    echo "$url ${url_count[$url]}"
done | sort -k2 -nr | head -n 10)

# Виведення результатів
echo "Топ-10 URL та їх реферерів:"
while read -r line; do
    url=$(echo $line | awk '{print $1}')
    count=${url_count[$url]}
    echo "$url - $count - 100%"
    
    # Виведення топ-10 реферерів для кожного URL
    for referer in "${!referer_count[@]}"; do
        if [[ $referer == *$url* ]]; then
            percent=$(echo "scale=2; ${referer_count[$referer]} / $count * 100" | bc)
            echo "  $referer - ${referer_count[$referer]} - $percent%"
        fi
    done
    echo
done <<< "$top_urls"

