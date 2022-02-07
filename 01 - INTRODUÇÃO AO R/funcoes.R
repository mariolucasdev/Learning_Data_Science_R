# Funções em R

#Nome, Inputs, Actions e Outputs

hello.world<-function() print("Mário Lucas")

minha.media<-function(x){
  output<-sum(x)/length(x)
  return(output)
}

data<-c(1,2,4)
minha.media(data)

minha.func<-function(x){
  x*x
}

minha.func(2)
