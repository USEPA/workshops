


## ----function_create-----------------------------------------------------
hw<-function(){
  print("Hello, World")
}

hw()


## ----function2_create----------------------------------------------------
p<-function(my_text){
  print(my_text)
}

p("Hello, world")
p("Hola, mundo")
p("Howdy, Texas")


## ----plot_function_examp-------------------------------------------------
myplot<-function(x,y,grp,file){
  my_p<-ggplot(data.frame(x,y,grp),aes(x=x,y=y)) +
            geom_point(aes(color=grp, shape=grp),size=5) +
            geom_smooth(method="lm",aes(colour=grp))+
            labs(x=substitute(x),y=substitute(y))
  ggsave(my_p,file=file)
  return(my_p)
}

myplot(iris$Petal.Length,iris$Petal.Width,iris$Species,"petal_petal.jpg")
myplot(iris$Sepal.Length,iris$Sepal.Width,iris$Species,"sepal_l_petal_w.jpg")


## ----if_else_examp-------------------------------------------------------
odd_even<-function(num){
  if(num %% 2 == 0){
    print("EVEN")
  } else {
    print("ODD")
  }
}

odd_even(27)
odd_even(34)


## ----if_else_examp2------------------------------------------------------
plus_minus<-function(num){
  if(num>0){
    print("plus")
  } else if (num < 0) {
    print("minus")
  } else {
    print("zero")
  }
}
 
plus_minus(198)
plus_minus(-44)
plus_minus(37*0)


