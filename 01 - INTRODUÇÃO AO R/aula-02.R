# Aula 02 - Treinaweb

nome.do.aluno <- "Mário Lucas"
nome.do.aluno

nome.dos.alunos <- c("Mário", "Michele", "Gabriel")
nome.dos.alunos

# Vetor é uma coleção de objetos
# Os vetores podem conter números ou objetos e nunca ambos

#Gerando números aleatórios

sample(x=1:10)
sample(x=1:10, size=5)
amostra<-sample(x=1:50, size=10, replace = TRUE)
amostra

#Indexação
amostra[1]
amostra[2:5]
summary(amostra)
