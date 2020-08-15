filename=.bolsaFNDE.temp
echo "Faça uma consulta da sua bolsa no site do FNDE.
Abrindo o navegador..."
xdg-open 2>.xdg-open.log https://www.fnde.gov.br/consulta-publica/pagamento-bolsa-executado/#/app/consultar/0/0 
sleep 1

echo "Depois da consulta, Insira o número que aparece no final da url do site da consulta.
O número contém 14 dígitos e aparece como demonstrado abaixo, nos asteriscos:
https://www.fnde.gov.br/consulta-publica/pagamento-bolsa-executado/#/app/detalhar/**************
"
while : 
do
    read -p "> " USERIDFNDE

    if [ ${#USERIDFNDE} -ge 15 ]; then 
        echo "Este número tem mais de 14 caracteres!" ; exit
    else
        echo 
    fi

    echo "Consultando seus dados..."

    wget -cq https://www.fnde.gov.br/digef/rs/spba/publica/pagamento/$USERIDFNDE -O - | python -m json.tool > "$filename"
    echo "Por favor confirme os seus dados abaixo:"

    python3 .usertest.py

    read -p "Está correto? (s/n)" answer

    case $answer in
    s|S|y|Y) break ;;
    *) echo "Insira o número de 14 dígitos:"
         continue ;;
    esac

done

echo "Salvando configurações"
echo $USERIDFNDE > .userID.dat
echo "Removendo arquivos temporários"
rm ".xdg-open.log"
rm $filename
sleep 0.1
echo "Concluído! Para consultar sua bolsa, use ./MinhaBolsaFNDE.sh"
sleep 2
clear
echo "Fazendo sua primeira consulta..."
sleep 1

./MinhaBolsaFNDE.sh
