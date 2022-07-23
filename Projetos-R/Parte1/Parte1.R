getwd() # visualiza a pasta de trabalho do R

install.packages("corrplot") #instalar pacote corrplot

library(corrplot) #chamar o pacote

setwd("C:\\Users\\Rodolfo\\Desktop\\ComerCimento\\Pós\\Modelo Estatisticos") # direciona o R para pasta

dados<- read.csv2("Dados Professores - IA.csv") # Leitura do arquivo csv no R

names(dados)
summary(dados)

dados2 <- dados[, c("horas_totais","qtd_disciplina",
                     "qtd_alunos","horas_disciplina","nota_prof",
                     "horas_atv_dedicacao",
                     "tempo_de_casa")]

dados3 <- dados[, c("ID","titulacao",
                    "tipo_vinculo","dat_admissao","tempo_de_casa",
                    "cargo","regime_trabalho_mec","horas_totais",
                    "qtd_disciplina","qtd_alunos","horas_disciplina",
                    "horas_atv_dedicacao","nota_prof")]

summary(dados2)
summary(dados3)

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
################## MODELO DE REGRESSÃO COM TODAS AS VARIÁVEIS #################

dados3$titulacao<- as.factor(dados3$titulacao)
dados3$tipo_vinculo<- as.factor(dados3$tipo_vinculo)
dados3$dat_admissao<- as.factor(dados3$dat_admissao)
dados3$cargo<- as.factor(dados3$cargo)
dados3$regime_trabalho_mec<- as.factor(dados3$regime_trabalho_mec)

attach(dados3)
summary(dados3)

tapply(horas_atv_dedicacao, titulacao, summary)
tapply(horas_atv_dedicacao, titulacao, t.test) #Desnecessaria

tapply(horas_atv_dedicacao, tipo_vinculo, summary)
tapply(horas_atv_dedicacao, tipo_vinculo, t.test) #Util

tapply(horas_atv_dedicacao, dat_admissao, summary)
tapply(horas_atv_dedicacao, dat_admissao, t.test) #Desnecessaria

tapply(horas_atv_dedicacao, cargo, summary)
tapply(horas_atv_dedicacao, cargo, t.test) #Desnecessaria

tapply(horas_atv_dedicacao, regime_trabalho_mec, summary)
tapply(horas_atv_dedicacao, regime_trabalho_mec, t.test) #Util

modelo1 <- lm(horas_atv_dedicacao~. ,dados3)
summary(modelo1)

###############################################################################
######################### LIMPEZA DE DADOS DESNECESSARIOS #####################

tapply(horas_atv_dedicacao, dat_admissao, summary)
tapply(horas_atv_dedicacao, dat_admissao, t.test)

tapply(horas_atv_dedicacao, cargo, summary)
tapply(horas_atv_dedicacao, cargo, t.test)

#Foi removido as variaveis:
#dat_admissao
#cargo

dados4 <- dados[, c("ID","titulacao",
                    "tipo_vinculo","tempo_de_casa","regime_trabalho_mec","horas_totais",
                    "qtd_disciplina","qtd_alunos","horas_disciplina",
                    "horas_atv_dedicacao","nota_prof")] #Variveis significaticas

dados4$titulacao<- as.factor(dados4$titulacao)
dados4$tipo_vinculo<- as.factor(dados4$tipo_vinculo)
dados4$regime_trabalho_mec<- as.factor(dados4$regime_trabalho_mec)

attach(dados4)

###############################################################################
############ MODELO DE REGRESSÃO COM TODAS AS VARIÁVEIS SIGNIFICATIVAS ########

modelo2 <- lm(horas_atv_dedicacao~tipo_vinculo+tempo_de_casa+regime_trabalho_mec+horas_totais+qtd_disciplina+qtd_alunos+horas_disciplina+nota_prof, dados4)
summary(modelo2)

predict(modelo2, data.frame(tipo_vinculo = c("Aulista"), tempo_de_casa = c(11), regime_trabalho_mec = c("Regime de Tempo Parcial"), horas_totais = c(17.33), qtd_disciplina = c(3), qtd_alunos = c(121), horas_disciplina = c(10), nota_prof = c(3.98)), interval = "confidence")
predict(modelo2, data.frame(tipo_vinculo = c("Aulista"), tempo_de_casa = c(11), regime_trabalho_mec = c("Regime de Tempo Parcial"), horas_totais = c(17.33), qtd_disciplina = c(3), qtd_alunos = c(121), horas_disciplina = c(10), nota_prof = c(3.98)), interval = "prediction")