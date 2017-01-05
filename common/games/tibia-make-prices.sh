#!/bin/sh

url='http://tibia.wikia.com/wiki/Ham'
#while read url; do
    name=`echo "$url" | sed 's/.*\///' | tr -dc '[:alnum:]\n\r' | tr '[:upper:]' '[:lower:]' | sed 's/27//'`
    echo "$name"

    OUT=/tmp/tibiabin
    mkdir "$OUT" -p
    wget "$url" -O $OUT/out.html 2>/dev/null

    start_line=`grep -n 'id="item-notes"' $OUT/out.html | cut -f1 -d:`
    start_line=$((start_line+2))
    end_line=`sed -n "${start_line},$ p" $OUT/out.html | grep -m 1 -n 'clear:left' | cut -f1 -d:`
    end_line=$((end_line-1))
    desc=`sed -n $start_line,${end_line}p $OUT/out.html | sed -e 's/<[^>]*>//g' | sed '/^\W*$/d' | awk '{$1=$1};1' | sed "s/'//" | sed 's/"//'`

    start_line=`grep -n 'Buy_From' $OUT/out.html | cut -f1 -d:`
    start_line=$((start_line+6))
    end_line=`sed -n "${start_line},$ p" $OUT/out.html | grep -m 1 -n 'tbody' | cut -f1 -d:`
    end_line=$((start_line+end_line-1))
    sed -n $start_line,${end_line}p $OUT/out.html | sed 's/<\/tr>/\n/g' | sed 's/<\/td>/,/g' | sed -e 's/<[^>]*>//g' | sed '/^\W*$/d ' | sed "s/'//" | sed 's/"//' |  sort -g -r --field-separator=',' --key=3 > $OUT/buy_prices.tmp
    echo 'BUY' > $OUT/buy_prices
    echo '---' >> $OUT/buy_prices
    column -s , -t $OUT/buy_prices.tmp >> $OUT/buy_prices

    start_line=`grep -n 'Sell_To' $OUT/out.html | cut -f1 -d:`
    start_line=$((start_line+6))
    end_line=`sed -n "${start_line},$ p" $OUT/out.html | grep -m 1 -n 'tbody' | cut -f1 -d:`
    end_line=$((start_line+end_line-1))
    sed -n $start_line,${end_line}p $OUT/out.html | sed 's/<\/tr>/\n/g' | sed 's/<\/td>/,/g' | sed -e 's/<[^>]*>//g' | sed '/^\W*$/d ' | sed "s/'//" | sed 's/"//' |  sort -g -r --field-separator=',' --key=3 > $OUT/sell_prices.tmp
    echo 'SELL' > $OUT/sell_prices
    echo '----' >> $OUT/sell_prices
    column -s , -t $OUT/sell_prices.tmp >> $OUT/sell_prices

    prices=`paste $OUT/buy_prices $OUT/sell_prices | column -s $'\t' -t`

    content="$desc"$'\n'$'\n'"$prices"
    mkdir .slash/usr/bin/tibiaprices -p
    echo "notify-send '$content'" > .slash/usr/bin/tibiaprices/tibia$name
    sed -i "s/'/\"/" .slash/usr/bin/tibiaprices/tibia$name
    chmod +x .slash/usr/bin/tibiaprices/tibia$name
#done < tibia-item-urls
