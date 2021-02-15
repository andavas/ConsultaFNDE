import json
import datetime
import subprocess

#Leitura da solicitação
f = open('.bolsaFNDE.temp', 'r')

response = json.loads(f.read())
bolsista = response['programas'][0]['entidades']['13031547000104']['funcoes']['49']

#Variáveis
i=0 
pagRealizado = 0
hoje = datetime.datetime.now()
qtdPagamentos = len(bolsista['pagamentos'])

print('----------CONSULTA PÚBLICA FNDE----------')
print('Beneficiário:',response['cpf'],'-',response['nome'],'-',bolsista['nome'],sep=' ')
print('Pagamentos:',qtdPagamentos,sep=' ')
print()

for i in range(qtdPagamentos):
    dataPag = datetime.datetime.strptime(bolsista['pagamentos'][i]['data'], '%d/%m/%Y')
    if dataPag.year == hoje.year:
        if dataPag.month == hoje.month:
            pagRealizado += 1
        i+=1

if pagRealizado > 0:
    if pagRealizado == 1: 
        #print('Foi realizado', pagRealizado ,'pagamento neste mês, referente a',bolsista['pagamentos'][-1]['referencia'])
        # em testes        
        output = 'echo "\\e[38;5;76mFoi realizado '+str(pagRealizado)+' pagamento neste mês, referente a '+bolsista['pagamentos'][-1]['referencia']+'\\e[39m"'
        subprocess.call(output, shell=True)
        print()
        print('--Resumo do pagamento--')
        print('Ordem bancária:',bolsista['pagamentos'][-1]['ordermBancaria'],sep=' ')
        print('Referente a:',bolsista['pagamentos'][-1]['referencia'],sep=' ')
        print('Data:',bolsista['pagamentos'][-1]['data'],sep=' ')
        print('Valor:',bolsista['pagamentos'][-1]['valor'],sep=' ')
    else:
        output = 'echo "\\e[38;5;46mForam realizados '+str(pagRealizado)+' pagamentos neste mês\\e[39m"'
        subprocess.call(output, shell=True)
        print('Foram realizados', pagRealizado ,'pagamentos neste mês')
        print()
        print('--Resumo dos pagamentos--')
        for i in range(pagRealizado):
                    j = -(i+1)
                    print('Ordem bancária:',bolsista['pagamentos'][j]['ordermBancaria'],sep=' ')
                    print('Referente a:',bolsista['pagamentos'][j]['referencia'],sep=' ')
                    print('Data:',bolsista['pagamentos'][j]['data'],sep=' ')
                    print('Valor:',bolsista['pagamentos'][j]['valor'],sep=' ')
                    print()
        
else:
    
    output = 'echo "\\e[38;5;220mNão foi realizado nenhum pagamento este mês\\e[39m"'
    subprocess.call(output, shell=True)
    print('--Último pagamento--')
    print('Ordem bancária:',bolsista['pagamentos'][-1]['ordermBancaria'],sep=' ')
    print('Referente a:',bolsista['pagamentos'][-1]['referencia'],sep=' ')
    print('Data:',bolsista['pagamentos'][-1]['data'],sep=' ')
    print('Valor:',bolsista['pagamentos'][-1]['valor'],sep=' ')


print('--------------------')
print('Total recebido:')
print('R$',response['total'])
