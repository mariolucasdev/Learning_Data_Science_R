# Carregando os Dados

library(DAAG) # Pacote para banco de dados
data("houseprices") # Carregando banco de dados
names(houseprices) # Nomes das variáveis
summary(houseprices) # Sumário dos dados

df <- read.csv("https://stats.idre.ucla.edu/stat/data/binary.csv")
names(df)
summary(df)

# ----------------------------------
# MODELO LINEAR
# ----------------------------------

# Montando o modelo
# O que afeta o preço da casa? Como?
mr <- lm(sale.price~area, data=houseprices)
summary(mr)
plot(sale.price~area, data=houseprices, xlab="Área da casa", ylab="Preço ($)")

areaNova<-data.frame(area=c(1100,1200,1300)) # Criando um objeto com os novos valores
predict(mr, areaNova, type="response") # Predizendo os novos valores

p <- predict(mr, areaNova, type="response")
points(c(1100,1200), p, col="red")
curve(70.7504+0.1878*x, add=T, col="blue")

# Qual será os valores para casas com 1100 e 1200m² ? Será de 277.30 para
# de 1100m² e de 296.08 para casas de 1200m²

# ----------------------------------
# MODELO LOGÍSTICO OU BINOMIAL
# ----------------------------------
names(df)
# admit (0 ou 1):  foi aceito ou não
# gre (graduate record exam): Valor mais alto em um teste
# gra (grade point avarege): Valor médio


mb <- glm(admit~gre, data=df)
summary(mb)
summary(df)

# Os alunos que tiveram GRE igual a 250 e 280 poderão entrar?
greNovo <- data.frame(gre=c(580, 280))
predict(mb, greNovo, type="response")

# Gráfico binomial
plot(admit~gre, data=df)
p2<-predict(mb, greNovo, type = "response")
points(c(250,280), p2, col="red")


# ----------------------------------
# MACHINE LEARNING NO R
# ----------------------------------
set.seed(123) # padrão incial para controlar aleatoriedade
library(caret) # pacote para o machine learning

# dividindo o banco de dados para o modelo de regressão
dataindex = createDataPartition(houseprices$sale.price, p= .7, list=FALSE)

#separando em treino e teste
housetreino <- houseprices[dataindex,]
houseteste <- houseprices[-dataindex,]

##################################
# Modelo de regressão
##################################

modeloML1<-train(sale.price~bedrooms+area, data=housetreino, method="glm")
modeloML2<-train(sale.price~bedrooms+area, data=housetreino, method="ranger", importance="impurity")

# Compando os modelos
listamodelos<-list(glm=modeloML1, ranger=modeloML2)
comparacao<-resamples(listamodelos)
dotplot(comparacao)

# MAE: Mean absolute error
# RMSE: Root mean squared error
# Rsquared: Coeficiente de correlação

# O nosso modelo utilizando o algitímo GLM apresentou menor error
library(caTools)
varImp(modeloML1) # importância das variáveis no modelo
plot(varImp(modeloML1)) #plot com a importância das variáveis

# fazendo predições com o modelo de ML
predict(modeloML1, newdata = houseteste)


##################################
# Modelo de classificação
##################################

df$admit <- as.factor(df$admit)

dataindex2 <- createDataPartition(df$admit, p=.7, list=FALSE)

dftreino <- df[dataindex2,]
dfteste <- df[-dataindex2,]

#modelo de classificação

modeloML3 <- train(admit~gre+gpa+rank, data=dftreino, method="glm")
modeloML4 <- train(admit~gre+gpa+rank, data=dftreino, method="ranger", importance="impurity")

pGLM <- predict(modeloML3, dfteste)
pRANGER <- predict(modeloML4, dfteste)

#Matriz de Confusão
confusionMatrix(factor(pGLM), factor(dfteste$admit))
confusionMatrix(factor(pRANGER), factor(dfteste$admit))

plot(varImp(modeloML3))
