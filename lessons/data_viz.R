## ----setup, echo = FALSE, message = F, warning = F-----------------------
library(tidyverse)

# chunk options
knitr::opts_chunk$set(warning = FALSE, message = FALSE, dpi = 300, fig.align = 'center', out.width = '700px')

# chunk hook
knitr::knit_hooks$set(
  small.mar = function(before = FALSE, options, envir) {
    if (before) par(mar = c(4, 4, .5, .5))  # smaller margin on top and right
    }, 
  def.mar = function(before, options, envir) {
    if (before) par(mar = c(5, 4, 4, 2))
    }
  )


## ----fig.width = 8, fig.height = 4.5, out.width = '800px', echo = F------
data(iris)
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species, group = Species)) + 
  geom_point() + 
  geom_smooth(method = 'lm') + 
  theme_bw()

## ------------------------------------------------------------------------
data(iris)
str(iris)

## ------------------------------------------------------------------------
data(iris)
head(iris)

## ---- fig.width = 6, fig.height = 4.5, eval = F--------------------------
## plot(Sepal.Length ~ Sepal.Width, data = iris)

## ---- fig.width = 5, fig.height = 4, small.mar = TRUE--------------------
plot(Sepal.Length ~ Sepal.Width, data = iris)

## ---- fig.width = 5, fig.height = 4, eval = F----------------------------
## plot(iris$Sepal.Width, iris$Sepal.Length)

## ---- fig.width = 6, fig.height = 4.5, eval = F--------------------------
## plot(Sepal.Length ~ Sepal.Width, data = iris)

## ---- fig.width = 5, fig.height = 4, eval = T, out.width = '600px', small.mar = T----
plot(iris$Sepal.Width, iris$Sepal.Length)

## ---- fig.width = 5, fig.height = 4, eval = T, out.width = '600px', small.mar = T----
plot(iris$Sepal.Width, iris$Sepal.Length)

## ---- fig.width = 5, fig.height = 4, eval = T, out.width = '600px', def.mar = T----
plot(iris$Sepal.Width, iris$Sepal.Length, xlab = 'Width (cm)', ylab = 'Length (cm)', main = 'Sepal dimensions')

## ---- fig.width = 5, fig.height = 4, eval = T, out.width = '600px'-------
par(mar = c(4.5, 4.5, 1, 1))
plot(iris$Sepal.Width, iris$Sepal.Length, xlab = 'Width (cm)', ylab = 'Length (cm)', main = 'Sepal dimensions')

## ---- fig.width = 5, fig.height = 4, small.par = T-----------------------
barplot(table(iris$Species))

## ---- fig.width = 5, fig.height = 4, small.par = T-----------------------
hist(iris$Sepal.Length)

## ---- fig.width = 5, fig.height = 4, small.par = T-----------------------
boxplot(Sepal.Length ~ Species, data = iris)

## ---- fig.width = 5, fig.height = 4, small.par = T-----------------------
pairs(iris)

## ---- eval = F-----------------------------------------------------------
## install.packages('tidyverse')
## library(tidyverse)

## ------------------------------------------------------------------------
loadedNamespaces()

## ------------------------------------------------------------------------
head(iris)

## ---- eval = F-----------------------------------------------------------
## ggplot(data = iris, aes(x = Sepal.Width, y = Sepal.Length))

## ------------------------------------------------------------------------
aes(x = Sepal.Width, y = Sepal.Length)

## ---- fig.width = 5, fig.height = 3--------------------------------------
ggplot(data = iris, aes(x = Sepal.Width, y = Sepal.Length))

## ---- fig.width = 5, fig.height = 3--------------------------------------
ggplot(data = iris, aes(x = Sepal.Width, y = Sepal.Length)) +
  geom_point()

## ---- eval = F-----------------------------------------------------------
## ggplot(data = iris, aes(x = Sepal.Width, y = Sepal.Length)) +
##   geom_point()

## ---- fig.width = 5, fig.height = 3.5------------------------------------
ggplot(data = iris, aes(x = Sepal.Width, y = Sepal.Length)) +
  geom_line()

## ---- fig.width = 5, fig.height = 3.5------------------------------------
ggplot(data = iris, aes(x = Sepal.Width, y = Sepal.Length)) +
  geom_count()

## ---- fig.width = 5, fig.height = 3.5------------------------------------
ggplot(data = iris, aes(x = Sepal.Width, y = Sepal.Length)) +
  geom_density_2d()

## ----eval = F------------------------------------------------------------
## ggplot(data = iris, aes(x = Sepal.Width, y = Sepal.Length)) +
##   geom_linerange()

## ----eval = F------------------------------------------------------------
## ?geom_linerange

## ----eval = F------------------------------------------------------------
## ?geom_point

## ---- fig.width = 5, fig.height = 3.5------------------------------------
ggplot(data = iris, aes(x = Sepal.Width, y = Sepal.Length, 
                        colour = Species)) +
  geom_point()

## ---- fig.width = 5, fig.height = 3.5------------------------------------
ggplot(data = iris, aes(x = Sepal.Width, y = Sepal.Length, 
                        colour = Species, size = Sepal.Width)) +
  geom_point()

## ---- fig.width = 5, fig.height = 3.5------------------------------------
ggplot(data = iris, aes(x = Sepal.Width, y = Sepal.Length, 
                        colour = Species, size = Species)) +
  geom_point()

## ---- eval = F-----------------------------------------------------------
## ggplot(data = iris, aes(x = Sepal.Width, y = Sepal.Length,
##                         colour = Species)) +
##   geom_point()

## ------------------------------------------------------------------------
p <- ggplot(data = iris, aes(x = Sepal.Width, y = Sepal.Length, 
                             colour = Species)) +
  geom_point()
class(p)

## ---- fig.width = 5, fig.height = 3.5------------------------------------
p <- p + xlab('Width (cm)') + ylab('Length (cm)') +
  ggtitle('Iris sepal dimensions')
p

## ---- fig.width = 5, fig.height = 3.5------------------------------------
p <- p + scale_colour_manual(values = c('red', 'blue', 'green'))
p

## ---- eval = F-----------------------------------------------------------
## ggplot(data = iris, aes(x = Sepal.Width, y = Sepal.Length,
##                              colour = Species)
##        ) +
##   geom_point() +
##   xlab('Width (cm)') + ylab('Length (cm)') +
##   ggtitle('Iris sepal dimensions') +
##   scale_colour_manual(values = c('red', 'blue', 'green'))

## ---- fig.width = 5, fig.height = 3.5------------------------------------
p <- p + theme(legend.position = 'top')
p

## ---- fig.width = 5, fig.height = 3.5------------------------------------
p <- p + theme(
  panel.grid.major = element_blank(), 
  panel.grid.minor = element_blank()
)
p

## ---- fig.width = 5, fig.height = 3.5------------------------------------
p <- p + theme(panel.background = element_rect(fill = 'white'))
p

## ---- eval = F-----------------------------------------------------------
## ?theme

## ---- fig.width = 5, fig.height = 3.5------------------------------------
p <- p + theme_bw()
p

## ---- fig.width = 5, fig.height = 3.5------------------------------------
p <- p + theme_bw(base_size = 10, base_family = 'serif')
p

## ---- fig.width = 5, fig.height = 3.5------------------------------------
p + geom_smooth()

## ---- fig.width = 5, fig.height = 3.5------------------------------------
p <- p + geom_smooth(method = 'lm')
p

## ---- eval = F-----------------------------------------------------------
## ggplot(data = iris, aes(x = Sepal.Width, y = Sepal.Length,
##                              colour = Species)
##        ) +
##   geom_point() +
##   xlab('Width (cm)') + ylab('Length (cm)') +
##   ggtitle('Iris sepal dimensions') +
##   scale_colour_manual(values = c('red', 'blue', 'green')) +
##   theme_bw(base_size = 10, base_family = 'serif') +
##   geom_smooth(method = 'lm')

## ---- fig.width = 5, fig.height = 3.5------------------------------------
p <- ggplot(data = iris, aes(x = Sepal.Width, y = Sepal.Length)
       ) +
  geom_point(aes(colour = Species)) +
  xlab('Width (cm)') + ylab('Length (cm)') +
  ggtitle('Iris sepal dimensions') +
  scale_colour_manual(values = c('red', 'blue', 'green')) + 
  theme_bw(base_size = 10, base_family = 'serif') + 
  geom_smooth(method = 'lm')

## ---- fig.width = 5, fig.height = 3.5------------------------------------
p

## ---- fig.width = 5, fig.height = 3.5------------------------------------
p <- ggplot(data = iris, aes(x = Sepal.Width, y = Sepal.Length)
       ) +
  geom_point(aes(colour = Species)) +
  xlab('Width (cm)') + ylab('Length (cm)') +
  ggtitle('Iris sepal dimensions') +
  scale_colour_manual(values = c('red', 'blue', 'green')) + 
  theme_bw(base_size = 10, base_family = 'serif') + 
  geom_smooth(method = 'lm')

## ---- fig.width = 5, fig.height = 3.5------------------------------------
p <- ggplot(data = iris) +
  geom_point(aes(x = Sepal.Width, y = Sepal.Length, 
                 colour = Species)) +
  xlab('Width (cm)') + ylab('Length (cm)') +
  ggtitle('Iris sepal dimensions') +
  scale_colour_manual(values = c('red', 'blue', 'green')) + 
  theme_bw(base_size = 10, base_family = 'serif') + 
  geom_smooth(method = 'lm')

## ---- fig.width = 5, fig.height = 3--------------------------------------
ggplot(data = iris, aes(x = Species, y = Petal.Width)) + 
  geom_boxplot() + 
  theme_bw()

## ---- fig.width = 5, fig.height = 3.5------------------------------------
toplo <- group_by(iris, Species) %>% 
  summarise(
    ave = mean(Petal.Width), 
    std = sd(Petal.Width)
    )
toplo

## ---- fig.width = 5, fig.height = 3--------------------------------------
ggplot(toplo, aes(x = Species, y = ave)) + 
  geom_bar(stat = 'identity') + 
  geom_errorbar(aes(ymin = ave - std, ymax = ave + std)) + 
  theme_bw()

