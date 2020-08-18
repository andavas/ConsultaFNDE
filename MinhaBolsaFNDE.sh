#!/bin/bash
#Programa para consulta de bolsas Oferecidas pelo FNDE
filename=.bolsaFNDE.temp
wget -cq https://www.fnde.gov.br/digef/rs/spba/publica/pagamento/$(<.userID.dat) -O - | python -m json.tool > "$filename"
python3 .parsingJSON.py
echo
echo "===================="
echo "Consultado em:"
echo $(date -r $filename +"%d/%m/%Y - %H:%M:%S") 
echo
echo Aperte ENTER para sair
read
echo Removendo arquivos temporários
rm $filename
echo Concluído!

