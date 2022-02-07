# Definindo a pergunta:
# H:A marca do adubo altera o crescimento da planta?
# H0: Não existe diferença entre as marcas do adubo.

dados <- read.csv("tabela2.csv", h=T)

attach(dados)

modeloaov<-aov(tamanho_cm~adubo_marca)

summary(modeloaov)

summary(dados)

# Tamanho para calcular média para variável X categórica
medias <- tapply(tamanho_cm, adubo_marca, mean)

# Calculando Erro
erros <- tapply(tamanho_cm , adubo_marca, sd)/sqrt(tapply(tamanho_cm, adubo_marca, length))

# Pacotes para contrução do gráfico de anova
library(gplots)

barplot2(medias,
         ylab = "Crescimento da planta (cm)",
         xlab = "Marca do adubo",
         names.arg = c("Marca A", "Marca B"),
         col = c("red", "green"),
         plot.ci = T, ci.u = medias+erros, ci.l = medias-erros,
         ylim = c(0,10),
         main = "Crescimento médio das plantas")

