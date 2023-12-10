#!/usr/bin/env bash

declare -A CURRENCY_CODES=(["$"]="R01235" ["EUR"]="R01239")
CBR_DATE=$(date '+%d/%m/%Y')
CBR_XSLT=$(mktemp /tmp/cbr.XXXXXX.xslt)

JOURNAL="$HOME/rsync/ledger/exchange_rates.journal"
JOURNAL_DATE=$(date '+%Y-%m-%d')

cat << EOF > "$CBR_XSLT"
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="text"/>
  <xsl:template match="ValCurs">
    <xsl:for-each select="Record">
      <xsl:value-of select="Value"/>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
EOF

for curr in "${!CURRENCY_CODES[@]}"; do
    URL="https://cbr.ru/scripts/XML_dynamic.asp?date_req1=$CBR_DATE&date_req2=$CBR_DATE&VAL_NM_RQ=${CURRENCY_CODES[$curr]}"
    EXCHANGE_RATE=$(curl -s "$URL" | xsltproc "$CBR_XSLT" - | sed 's/,/./g')
    if [ ! -n "$EXCHANGE_RATE" ]; then
        continue
    fi
    echo "P $JOURNAL_DATE $curr $EXCHANGE_RATE RUB" >> "$JOURNAL"
done

rm -f "$CBR_XSLT"

