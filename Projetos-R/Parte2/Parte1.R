
setwd("C:\\Users\\Rodolfo\\Desktop\\ComerCimento\\Pós\\Modelo Estatisticos")
getwd()
Dados <- read.csv2("Dados Emprego Formal - IA.csv")

summary(Dados)

attach(Dados)

Dados$Mês<- as.factor(Dados$Mês)
Dados$Saldo.de.emprego<- as.factor(Dados$Saldo.de.emprego)

summary(Dados)

################################################################


modelo1<- glm(Saldo.de.emprego~Patentes+PIB+Inflação+Taxa.de.Juros+Taxa.de.Câmbio,family=binomial(link="logit"))
summary(modelo1)


modelo2<- glm(Saldo.de.emprego~Patentes+Taxa.de.Câmbio,family=binomial(link="logit"))
summary(modelo2)


#################################### PrevisÃ£o ########################################

predict(modelo2, data.frame(Patentes = c(96), Taxa.de.Câmbio= c(4.05)), type = "response")


############################ ClassificaÃ§Ã£o - Matriz de ConfusÃ£o #######################

prev <- as.factor(
  ifelse(
    predict(modelo2, 
            type = "response")
    >0.8,"1","0"))

Dados$prev<- as.factor(prev)

attach(Dados)


table(Saldo.de.emprego,prev)


table(Saldo.de.emprego)

prop.table(table(Saldo.de.emprego,prev))

Ac =  prop.table(table(Saldo.de.emprego,prev)) [1,1] +
  prop.table(table(Saldo.de.emprego,prev)) [2,2]


Ac 


#######################################################################################
#######################################################################################