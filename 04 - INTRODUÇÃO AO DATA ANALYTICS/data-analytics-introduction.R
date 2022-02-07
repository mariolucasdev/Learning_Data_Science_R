
# INTRODU√á√ÉO AO DATA ANALYTICS 

# Carregando dados e definido problemas de trabalho

# Base de Dados Produ√ß√£o do EUA
# lib Eacdat
# data Product

# Aula 01 - Carregando dados e definido o problema
#--------------------------------------------------

library(Ecdat) # Comando para carregar o pacote
data(Produc)
names(Produc)

# Pergunta
# O que afetou a taxa de desemprego ao longo dos anos?
# O aumento do capital p√∫blico, diminuiu o desemprego ao longo dos anos?

# Aula 02 - An√°lise explorat√≥ria
#--------------------------------------------------

summary(Produc)

library(DataExplorer)
plot_missing(Produc) # Verifica as vari√°veis vaziar por colunas
plot_histogram(Produc) # Distribui√ß√£o de Frequ√™ncias

# Aula 03 - Matriz de Correla√ß√£o
#--------------------------------------------------

library(DataExplorer)
plot_correlation(Produc)

Produc2<-Produc[,-1] # Removendo a primeira coluna
library(PerformanceAnalytics)
chart.Correlation(Produc2)

# Aula 04 - Primeiros Modelos EstatÌsticos
#---------------------------------------------------

m1<-lm(unemp~year, data=Produc) # CriaÁ„o de modelo
anova(m1, test="F") # Tese de Vari‚ncia (Clean)
summary(m1) # InformaÁıes Gerais inclusive teste de vari‚ncia

# Aula 05 - Aumentando o modelo
#---------------------------------------------------
m2<-lm(unemp~year+state, data=Produc)
anova(m2, test="F")

m3<-lm(unemp~year+state+util, data=Produc)
anova(m3, test="F")
# Valor de P < 0.05 para ser significativo

m4<-lm(unemp~util, data=Produc)
anova(m4, test="F")

m5<-lm(unemp~year+util+state, data=Produc)
anova(m5, test="F")
# A posiÁ„o da vari·vel explicativa pode interferir na signific‚ncia

# Aula 06 - Normalidade dos Dados
#---------------------------------------------------
hist(Produc$unemp)

library(ggplot2)
ggplot(Produc, aes(x=unemp)) + geom_histogram()

# Teste de normalidade
options(scipen = 999)
shapiro.test(Produc$unemp)

mNormal<-lm(unemp~year+state+util, data=Produc)
anova(mNormal, test="F")

npoisson<-glm(unemp~year+state+util, data=Produc, family = poisson)
anova(npoisson, test="F")

# Aula 07 - Gr·ficos
#------------------------------------------------------
m6<-lm(unemp~pc, data=Produc)
anova(m6, test="F")
m7<-glm(unemp~pc, data=Produc, family = poisson)
anova(m7, test="F")

library(ggplot2)
ggplot(Produc, aes(x=pc, y=unemp)) +
  geom_point() +
  geom_smooth(method="lm", color="blue", se=F) +
  geom_smooth(method="glm", color="red", se=F, formula=y~log(x))

# Aula 08 - Multicolinearidade
#--------------------------------------------------------
mcomplet1<-glm(unemp~year+pc+pcap+util+gsp, data=Produc, family=poisson)
options(scipen = 1)
anova(mcomplet1, test="F")

mcomplet2<-glm(unemp~year+util+pc+pcap+gsp, data=Produc, family=poisson)
anova(mcomplet2, test="F")
drop1(mcomplet2, test="F") # Verificiar a real import‚ncia

library(caret) # Library para verificaÁ„o de import‚ncia
varImp(mcomplet2) # Teste para classificar a import‚ncia da vari·veis

# Aula 09 - Conclus„o e Gr·ficos
#--------------------------------------------------------

mcompleto3<-glm(unemp~., data=Produc2, family = poisson)
drop1(mcompleto3, test="F")
library(caret)
varImp(mcompleto3)

library(ggplot2)
ggplot(Produc, aes(x=year, y=unemp)) +
  geom_point() +
  geom_smooth(method="glm", formula=y~log(x))

ggplot(Produc, aes(x=gsp, y=unemp)) +
  geom_point() +
  geom_smooth(method="glm", formula=y~log(x))

ggplot(Produc, aes(x=pc, y=unemp)) +
  geom_point() +
  geom_smooth(method="glm", formula=y~log(x))

ggplot(Produc, aes(x=pc, y=gsp)) +
  geom_point() +
  geom_smooth(method="lm")

mx<-glm(unemp~pcap+hwy+water+util+pc, data=Produc2, family = poisson)
drop1(mx, test="F")

# Aula 10 - RelatÛrios EstatÌsticos com RMarkdown
# --------------------------------------------------

