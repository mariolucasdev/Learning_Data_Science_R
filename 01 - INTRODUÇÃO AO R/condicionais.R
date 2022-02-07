# Condicionais R

minha.funcao<-function(x){
  if(x==1){
    cat("O número é igual a 1")
  }else if(x==2) {
    cat("O número é igual a 2")
  }else{
    cat("O número é diferente de 1")
  }
}
minha.funcao(1)
minha.funcao(2)
minha.funcao(3)

minha.funcao2<-function(x){
  while (x<=10) {
    x=x+1
    cat(x)
  }
}
minha.funcao2(0)
