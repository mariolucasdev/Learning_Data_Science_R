# Análise Exploratória do Banco de Dados

summary(Airq) #resumo geral dos dados

# Quais variáveis intereferem na qualidade do ar das cidades?

# airq : índice para medir a qualidade do ar (quanto menor melhor)
# vala : valor das empresa nas cidades (milhares de dólares)
# rain : quantiade de chuvas (em polegadas)
# coas : a cidade é costeira?
# dens : dencidade da população (milha quadrada)
# medi : renda média per capita (US Dollars)

# Tipo de variáveis: contínua ou categórica

# Tranformando variáveis coas em fatores

coas<-as.factor(Airq$coas)
plot(coas)

# A qualidade do ar (airq) é a nossa variável responsta
# As demais variáveis são explicativas

# Histograma e distribuições
# o comando "hist": para histogramas

hist(Airq$airq)
plot(coas)
hist(Airq$rain)
hist(Airq$dens)
hist(Airq$vala, main = "Histograma Valor das Empresas",
     xlab="Valor",
     ylab="Frequência")

# Gráficos exploratórios
names(Airq)

# plot(y~x)
plot(Airq$airq~Airq$rain)
plot(airq~rain, data=Airq)

# abline é pra construir retas ou curvas
abline(lm(Airq$airq~Airq$rain))

plot(airq~dens, data=Airq)
abline(lm(Airq$airq~Airq$dens))

plot(Airq$airq~Airq$vala)
abline(lm(Airq$airq~Airq$vala))

# Personalizando um gráfico
plot(Airq$airq~Airq$vala,
     xlab="Valor das Empresas",
     ylab="Qualidade do Ar",
     main="Valor das empresas",
     sub="Dados de 2017/2018",
     ylim=c(50,200),
     xlim=c(0,20000),
     cex.lab=1.3,
     cex=1.3,
     pch=16,
     col="darkblue",
     bty="n",)
abline(lm(Airq$airq~Airq$vala), col="red", lwd=1.7)

# Gráficos de correlação
# Corrgram
corrgram(Airq, upper.panel = panel.cor)

# PerformanceAnalytics
Airq2<-Airq[,-5] #Removendo coluna categórica do banco de dados
chart.Correlation(Airq2)

# Montando um modelo estatístico
modelo<-glm(airq~vala+rain+coas+dens+medi, data=Airq)

# Selecionando as variáveis significativas
library(MuMin)
options(na.action = "na.fail")
dredge(modelo, rank = "AIC") # Critério de Akaike

# Criando os gráficos do resultado estatístico
library(ggplot2)

# Regressão
ggplot(data=Airq, aes(x=medi, y=airq)) +
  geom_point(size=2) +
  geom_smooth(method = "glm", se=FALSE) +
  labs(x="Renda Média", y="Qualidade do Ar")

# Boxplot
ggplot(data=Airq, aes(x=coas, y=airq)) +
  geom_boxplot(aes(color=coas)) +
  labs(x="Posição Costeira", y="Qualidade do Ar", colour="")

# ANCOVA (y contínuo ~ x contínuo + x categórico)
ggplot(data=Airq, aes(x=medi, y=airq, group=coas)) +
  geom_point(size=2) +
  geom_smooth(method = "glm", aes(color=coas), se=FALSE) +
  labs(x="Renda Média", y="Qualidade do Ar", colour="Posição Costeira")

# CONCLUSÃO: A qualidade do ar diminui com o aumento da renda média, além disso as cidad
# costeiras tem uma qualidade melhor em relação as não costeiras.
