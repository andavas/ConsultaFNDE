#!/bin/bash
infoBolsa=.bolsaFNDE.temp
infoCpf=.cpf.temp
sleep 1

echo "----------------------Configuração inicial ConsultaFNDE.sh----------------------
----------------------Produzido por Andeson A. Vasconcelos----------------------
-------------------------------github.com/andavas-------------------------------
"


echo " Insira seu CPF
"
while : 
do
    read -p "> " CPF

    if [ ${#CPF} -ge 12 ]; then 
        echo "Este número tem mais de 11 caracteres!" ; exit
    else
        echo 
    fi

    echo "Consultando seus dados..."
    wget -cq https://www.fnde.gov.br/digef/rs/spba/publica/pessoa/1/10/$CPF -O - > "$infoCpf"
    if [[ -z $(<$infoCpf) ]]; then
        echo "Houve um problema ao consultar os dados."
        rm $infoCpf
        echo "Aperte ENTER para sair"
        read
        exit
    fi
    touch .userID.dat
    python3 .userget.py
    wget -cq https://www.fnde.gov.br/digef/rs/spba/publica/pagamento/$(<.userID.dat) -O - > "$infoBolsa"
        if [[ -z $(<$infoBolsa) ]]; then
        echo "Houve um problema ao consultar os dados."
        rm $infoCpf
        rm $infoBolsa
        echo "Aperte ENTER para sair"
        read
        exit
    fi
    echo "Por favor confirme os seus dados abaixo:"
    python3 .usertest.py
    read -p "Está correto? (s/n)" answer
    case $answer in
    s|S|y|Y) break ;;
    *) rm .userID.dat
       echo "Insira seu CPF:"
       continue ;;
    esac
done

echo "Quase pronto..."
sleep 0.2
echo "Removendo arquivos temporários"
rm $infoBolsa
rm $infoCpf
sleep 0.1
echo "Concluído!"
sleep 1
echo "Fazendo sua primeira consulta..."
sleep 1
clear
