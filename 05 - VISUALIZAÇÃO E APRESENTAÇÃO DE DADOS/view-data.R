# Aula 01 - Data Science e DataViz
#-------------------------------------
# Aprender a fazer ótimos gráficos e boas práticas de exibição

# ggplot2
install.packages("ggplot2") # Instalando pacote
library(ggplot2) # Carregando pacote

# Aula 02 - Mapeamento Estético e Elementos Estéticos
#-------------------------------------
# Grammar fo Graphics

# mapeamento estético dos dados e das variáveis
# camada dos elementos gramaticais (linhas, pontos)

# Airquality

# ozone (partes por milhão/hora)
# solar.R (radiação em frequência)
# wind (milhas por hora)
# temp (Temperaruta Fahrenheit diário)
# month (1--12)
# day numeric (1--32)

data("airquality", package = "datasets")
names(airquality)

#(i) Mapeamento estético
#(ii) Elementos gramáticos
ggplot(airquality, aes(x=Wind, y=Ozone)) +
  geom_point() +
  geom_line()

# Aula 03 - Histogramas
#-------------------------------------
ggplot(airquality, aes(x=Temp)) +
  geom_histogram(fill="black", color="red") +
  labs(x="Temperatura (F)", y="Contagem", title="Histograma da Temperatura")

# mean(airquality$Temp)

# Aula 04 - Gráficos de pontos e retas
#-------------------------------------
ggplot(airquality, aes(x=Temp, y=Wind)) +
  geom_point(aes(color=Day)) +
  geom_smooth(method =lm, se=FALSE, color="black") +
  labs(x="Temperatura", y="Vento", color="Mês")

# Aula 05 - Bloxpot e Gráficos de Barra
#-------------------------------------

#mean(airquality$Temp)
#median(airquality$Temp)

ggplot(airquality, aes(x=as.factor(Month), y=Temp)) +
  geom_boxplot(color="black", fill="lightblue") +
  labs(x="Mês", y="Temperatura")

ggplot(airquality, aes(x=as.factor(Month), y=Temp)) +
  geom_col()

#Calcular a média
library(dplyr)
media<-airquality %>%
  group_by(Month) %>%
  summarise(mean = mean(Temp),
    sem = sd(Temp)/sqrt(length(Temp)))

media

ggplot(media, aes(x=Month, y=mean)) +
  geom_col() +
  geom_errorbar(aes(ymin=mean-sem, ymax=mean+sem), width=0)

# Aula 06 - Bolhas e correlação
#-------------------------------------------------

ggplot(airquality, aes(x=Temp, y=Wind, size=Ozone)) +
  geom_point(alpha=0.7, aes(color=Month)) +
  geom_smooth(method=lm, se=F, size=1) +
  labs(x="Temperatura", y="Ventro", color="Mês", size="Ozônio")


# Aula 07 - Temas e cores ggplot2
#-------------------------------------------------
  
ggplot(airquality, aes(x=Temp, y=Wind)) +
  geom_point(aes(color=Month)) +
  geom_smooth(method = lm)
  
install.packages("ggthemes")
library(ggthemes)

ggplot(airquality, aes(x=Temp, y=Wind)) +
  geom_point() +
  geom_smooth(method = lm) +
  theme_minimal()

install.packages("extrafont")
library(extrafont)

#Alterando fontes
ggplot(airquality, aes(x=Temp, y=Wind)) +
  geom_point() +
  geom_smooth(method = lm, color="red") +
  theme(text=element_text(family="Ubuntu", size=16))


# Aula 08 - Múltiplos Gráficos
#-------------------------------------------------

p1<-ggplot(airquality, aes(x=Temp, y=Wind)) + geom_point()
p2<-ggplot(airquality, aes(x=as.factor(Month), y=Temp)) + geom_boxplot()
p3<-ggplot(airquality, aes(x=Ozone, y=Solar.R)) + geom_smooth()

install.packages("ggpubr")
library(ggpubr)

ggarrange(p1, p2, p3, ncol= 2, nrow = 2)

#facets
p<-ggplot(airquality, aes(x=Temp, y=Wind)) +
  geom_point() +
  geom_smooth(aes(color=Month), se=F, method=lm) +
  facet_grid(Month~.)


library(plotly)
ggplotly(p)

p2<-ggplot(airquality, aes(x=Temp, y=Ozone)) + geom_point() +geom_smooth(method = lm)
ggplotly(p2)
