import json

f = open('.bolsaFNDE.temp', 'r')
response = json.loads(f.read())
bolsista = response['programas'][0]['entidades']['13031547000104']['funcoes']['49']

print ('Beneficiário:',response['cpf'],'-',response['nome'],'-',bolsista['nome'])
