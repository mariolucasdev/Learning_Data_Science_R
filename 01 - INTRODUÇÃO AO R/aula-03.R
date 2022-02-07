# Matrizes podem ser inseridos números ou caracteres, nunca amobos
# Data frame (quadro de dados) pode ser inseridos números ou caracteres

x<-1:5
y<-6:10
z<-11:15
cbind(x, y, z)

# cbind cria um matriz unde x y z são colunas

rbind(x, y, z)

# criando um data frame de 3 colunas
dados<-data.frame("notas"=c(7,2,6,4,9,10,8,7),
           "nome"=c("João", "Maria", "Pedro", "José", "Alice", "Veronica", "Vinicius", "Alan"),
           "sexo"=c("M", "F", "M", "M", "F", "F", "F", "A"))

#Mostras as 6 primeiras linhas do dataframe
head(dados)

#Mostras as 6 últimas linhas do dataframe
tail(dados)

# Mostra visualização amigável
View(dados)

# Exibe o número de linhas e colunas
dim(dados)

# Exibe número de linhas e colunas
rownames(dados)

# Exibe o nome das colunas
colnames(dados)

summary(dados)

