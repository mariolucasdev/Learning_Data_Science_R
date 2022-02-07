getwd() # Exibe o diretório de trabalho atual
setwd() # Utilizado para navegação entre as pastas
setwd("./../Desktop/Curso R/dados/")
setwd("./dados/")
dados <- read.csv("tabela.csv", h=T)
attach(dados) # Indica que esse é o principal objeto de trabalho.

# A quantidade de adubo altera o crescimento da planta?

modelo <- lm(tamanho_cm~adubo_gr)

anova(modelo)

summary(modelo)

# Fazendo o gráfico com o comando plot
plot(tamanho_cm~adubo_gr,
     xlab = "Quantidade de Adubo (gr)",
     ylab = "Tamanho da Planta (cm)",
     pch=16)
curve(-2.88133+0.72110*x, add=TRUE, lty=2)
