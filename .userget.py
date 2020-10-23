import json

cpf = open('.cpf.temp', 'r+')
response = json.loads(cpf.read())
userID = response['pessoas'][0]['hash']
id = open('.userID.dat', 'w')
id.write(userID)
cpf.close()
id.close()
