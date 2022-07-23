setwd("C:\\Users\\Rodolfo\\Desktop\\ComerCimento\\Pós\\Modelo Estatisticos")

names(dados)
summary(dados)

dados2 <- dados[, c("math.score","reading.score",
                    "writing.score")]

dados3 <- dados[, c("gender","race",
                    "parental.level.of.education","test.preparation.course","math.score",
                    "reading.score","writing.score")]

############# Matriz de correlação com as variáveis quantitativas #############

str(dados2) #verificar a estrutura dos dados
is.na(dados2) #verificar se há dados ausentes
sum(is.na(dados2)) #Para confirmar vamos aplicar a função sum
res <- cor(dados2) # Corr matrix
round(res, 2)
corrplot(cor(dados2), method = "number")

#ou

cor(dados2)
###############################################################################
############################## ANALISE DOS DADOS ##############################

scatter.smooth(x=math.score, y=reading.score, main="Matematica ~ Leitura")

scatter.smooth(x=math.score, y=writing.score, main="Matematica ~ Escrita")

###############################################################################
################## MODELO DE REGRESSÃO COM TODAS AS VARIÁVEIS #################

dados3$gender<- as.factor(dados3$gender)
dados3$race<- as.factor(dados3$race)
dados3$parental.level.of.education<- as.factor(dados3$parental.level.of.education)
dados3$test.preparation.course<- as.factor(dados3$test.preparation.course)

attach(dados3)
summary(dados3)

modelo <- lm(math.score~. ,dados3)
summary(modelo)

predict(modelo, data.frame(gender = c("female"), race = c("group C"), parental.level.of.education = c("some college"), test.preparation.course = c("completed"), reading.score = c(90), writing.score = c(88)), interval = "prediction")

###############################################################################
######################### MODELO DE REGRESSÃO DE TESTE ########################

modelo1 <- lm(math.score~reading.score+writing.score ,dados2)
summary(modelo1)

predict(modelo1, data.frame(reading.score = c(90), writing.score = c(88)), interval = "prediction")