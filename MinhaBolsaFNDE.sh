#!/bin/bash
#Programa para consulta de bolsas Oferecidas pelo FNDE
echo "Verificando usuário..."
sleep 0.1
if [ -e .userID.dat ]
then
    echo "Ok"
    sleep 0.1
    clear
    
else
    sleep 0.5
    echo "ID do usuário não encontrada."
    sleep 0.5
    echo "Abrindo configuração inicial..."
    sleep 0.5
    clear
    ./.firstRun.sh
fi

outputFNDE=".bolsaFNDE.temp"
echo "Verificando bolsa no site do FNDE..."
wget -cq https://www.fnde.gov.br/digef/rs/spba/publica/pagamento/$(<.userID.dat) -O - > "$outputFNDE"
# verifica se o arquivo recebido está vazio
if [[ -n $(<$outputFNDE) ]]; then
    echo "Concluído! Organizando dados..."
    sleep 0.1
    clear
    python3 .parsingJSON.py   
else
    echo -e "\e[38;5;196mHouve um problema ao consultar os dados.\e[39m"
fi

echo
echo "===================="
echo "Consultado em:"
echo $(date -r $outputFNDE +"%d/%m/%Y - %H:%M:%S") 
echo
echo Aperte ENTER para sair
rm $outputFNDE
read
