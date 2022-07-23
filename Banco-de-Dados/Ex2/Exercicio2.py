import pymongo
import json
import re

client = pymongo.MongoClient("mongodb+srv://sato:123@cluster0.ck0sx.mongodb.net/teste?retryWrites=true&w=majority")
db = client.aula
db.get_collection("airbnb")
collection = db.airbnb

data = [json.loads(line) for line in open('/content/drive/MyDrive/Colab Notebooks/Bases/listingsAndReviews.json', 'r')]

collection.insert_one(data)

print('=== Exemplos')
# Exemplo 1
regex = re.compile("perfect", re.IGNORECASE)
count_find_perfect = collection.count_documents({"reviews.comments": regex})
print('Documentos com a palavra perfect: ', count_find_perfect)


# Exemplo 2
regex_best = re.compile("best place to be", re.IGNORECASE)
regex_wonderful = re.compile("wonderful host", re.IGNORECASE)
regex_beautiful = re.compile("beautiful place", re.IGNORECASE)

count_find_2 = colletion.count_documents({"$and": [{"reviews.comments": regex_best},{"reviews.comments": regex_wonderful},{"reviews.comments": regex_beautiful}]})
print('Documentos com os termos "best place to be", "wonderful host" e "beautiful place": ', count_find_2)

#Exemplo 3
regex_best = re.compile("best place to be", re.IGNORECASE)
regex_wonderful = re.compile("wonderful host", re.IGNORECASE)
regex_beautiful = re.compile("beautiful place", re.IGNORECASE)

count_find_3 = colletion.count_documents({"$or": [{"reviews.comments": regex_best},{"reviews.comments": regex_wonderful},{"reviews.comments": regex_beautiful}]})
print('Documentos que talvez possuam os termos  "best place to be", "wonderful host" e "beautiful place": ', count_find_3)

#Exemplo 4
regex_best = re.compile("best place to be", re.IGNORECASE)

count_find_4 = colletion.count_documents({"reviews.comments": regex_best})
print('Documentos com o termo "best place to be": ', count_find_4)

#Exemplo 5
regex_best = re.compile("best place to be", re.IGNORECASE)

count_find_5 = colletion.count_documents({"reviews.comments": regex_best})
print('Documentos com o termo "best place to be" (com poucos campos): ', count_find_5)


print('=== Exercicios')
#Exercicio 1
regex = re.compile("segurança", re.IGNORECASE)
count_find_Ex_1 = colletion.count_documents({"$and":[{"reviews.comments": regex},{"address.country": "Brazil"}]})
print('Documentos com o termo "segurança" no Brasil: ', count_find_Ex_1)


#Exercicio 2
regex = re.compile("O espaço", re.IGNORECASE)
count_find_Ex_2 = colletion.count_documents({"$and":[{"reviews.comments": regex},{"address.country": "Brazil"}]})
print('Documentos cujo comentário começa com "espaço": ', count_find_Ex_2)

#Exercicio 3
regex = re.compile("comida", re.IGNORECASE)
count_find_Ex_3 = colletion.count_documents({"$and":[{"reviews.comments": regex},{"address.country": "Brazil"}]})
print('Documentos com o termo "comida" no Brasil: ', count_find_Ex_3)

#Exercicio 4
regex = re.compile("dirty", re.IGNORECASE)
count_find_Ex_4 = colletion.count_documents({"$and":[{"reviews.comments": regex},{"address.country": "United States"}]})
print('Documentos com o termo "dirty" nos EUA: ', count_find_Ex_4)