#########################################################################################

#pacotes essencias utilizados durante o curso
install.packages("forecast")
install.packages("fpp2")
install.packages("ggplot2")


library(forecast)
library(fpp2)
library(ggplot2)

#########################################################################################
#Importa e cria  uma serie temporal

setwd("C:\Users\Rodolfo\Desktop\ComerCimento\Pós\Modelo Estatisticos")# direciona o R para pasta
getwd() # visualiza a pasta de trabalho do R
dados1 <- read.csv2("Dados Emprego Formal - IA.csv") # Leitura do arquivo csv no R

serie2 = ts(dados1$Taxa.de.Juros,start = c(2005,1), end=c(2009,12), frequency=12)
class(serie2)
plot(serie2)

###########################Decomposição de uma série temporal#########################

autoplot(serie2)

dec1 <- decompose(serie2)

autoplot(dec1)
########################################################################################
#alisamento exponencial Simples

modelo1 <- ets(serie2, "ANN")
modelo1

autoplot(modelo1$residuals)
autoplot(modelo1$fitted)

prev1 = forecast(modelo1, h=12,levels=c(85,90))
print(prev1$mean)
autoplot(prev1)

########################################################################################
#alisamento exponencial  - Automático

modelo2 <- ets(serie2 ,"ZZZ")
modelo2

autoplot(modelo2$residuals)
autoplot(modelo2$fitted)

prev2 = forecast(modelo2, h=12,levels=c(85,90))
print(prev2$mean)
autoplot(prev2)


########################################################################################
#comparando modelos


treino = window(serie2,2005,c(2008,12))
teste  = window(serie2,2007,c(2007,12))

#################################################################################

plot(serie2)
lines(prev1$mean, col="blue")
lines(prev2$mean, col="red")
lines(teste, col="green")
legend("topright",legend=c("ANN","ZZZ","Teste"), col = c("blue","red","green"),
       lty=1:2, cex=0.8)

########################################################################################

#####################  Estimação do Modelo  ####################################

modelo3=arima(serie2, order = c(1, 1, 0),seasonal = list(order = c(1, 1, 0)))

modelo3

forecast(modelo3, 12, level=c(80,95))

autoplot(forecast(modelo3, 12, level=c(80,95)))

#################################################################################
#####################  Modelo Autoarima ####################################


modelo4 = auto.arima(serie2)

modelo4

autoplot(forecast(modelo4, 12, level=c(80,95)))

######################comparando modelos#####################


modelo3=arima(treino, order = c(1, 1, 0),seasonal = list(order = c(1, 1, 0)))
prev3 = forecast(modelo3, h=12)
prev4 = forecast(modelo4, h=12)
print(prev3$mean)
autoplot(prev3)

plot(serie2)
lines(prev3$mean, col="blue")
lines(prev4$mean, col="red")
lines(teste, col="green")
legend("bottomleft",legend=c("SARIMA","SARIMA2","Teste"), col = c("blue","red","green"), lty=1:2, cex=0.5)

#########################################################################################

######################comparando modelos automáticos #####################


modelo1 = ets(treino);modelo1
modelo2 = auto.arima(treino);modelo2

prev1 = forecast(modelo1, h=12)
prev2 = forecast(modelo2, h=12)


plot(serie2)
lines(prev1$mean, col="blue")
lines(prev2$mean, col="red")
legend("bottomleft",legend=c("SARIMA","ETS"), col = c("blue","red"), lty=1:2, cex=0.5)

########################################################################################
