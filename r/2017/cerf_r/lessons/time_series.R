## ----setup, echo = FALSE, message = F, warning = F-----------------------
library(tidyverse)
library(WRTDStidal)
library(gridExtra)
library(grid)
library(SWMPr)
library(GGally)
library(lubridate)

# chunk options
knitr::opts_chunk$set(warning = FALSE, message = FALSE, dpi = 300, fig.align = 'center', out.width = '900px', fig.width = 8, fig.height = 4.5)

# chunk hook
knitr::knit_hooks$set(
  small.mar = function(before = FALSE, options, envir) {
    if (before) par(mar = c(4, 4, 1, 1))  # smaller margin on top and right
    }, 
  def.mar = function(before, options, envir) {
    if (before) par(mar = c(5, 4, 4, 2))
    }
  )

## ----fig.width = 8, fig.height = 4.5, out.width = '800px', echo = F------
p1 <- prdnrmplot(tidfit, annuals = F) +
  theme(legend.position = 'none', , axis.title.y = element_blank())
p2 <- prdnrmplot(tidfit) +
  theme(legend.position = 'none', axis.title.y = element_blank())
grid.arrange(p1, p2, ncol = 1, left = textGrob(chllab(), rot = 90))

## ----echo = F------------------------------------------------------------
data(austres)
data(nottem)

n <- 100
smp <- rnorm(n)
nrm <- smp %>% 
  data.frame(
    dts = 1:n, 
    val = .,
    lab = 'Value'
  )

walk <- nrm %>% 
  mutate(val = cumsum(val))

aust <- data.frame(
  dts = as.numeric(time(austres)),
  val = as.numeric(austres)/ 1000,
  lab = 'Pop. (1e3)'
  )

nott <- data.frame(
  dts = as.numeric(time(nottem)),
  val = as.numeric(nottem),
  lab = 'Temp (F)'
  )

dats <- list(
  nrm = nrm, 
  walk = walk,
  austres = aust, 
  nottem = nott
  ) %>% 
  enframe

tsplo <- pmap(dats, function(name, value){
  
  lab <- unique(value$lab)
  ggplot(value, aes(x = dts, y = val)) +
    geom_line() + 
    geom_point(size = 0.8) + 
    scale_y_continuous(lab) +
    theme_bw() +
    theme(
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      axis.title.x = element_blank()
    ) + 
    ggtitle(name)
  
  })

grid.arrange(
  tsplo[[1]], tsplo[[2]], tsplo[[3]], tsplo[[4]],
  bottom = 'Time',
  ncol = 2
)

## ---- echo = F-----------------------------------------------------------
## subset for daily decomposition
dat <- subset(apadbwq, subset = c('2013-07-01 00:00', '2013-07-31 00:00'))

## decomposition and plot
test <- decomp(dat, param = 'do_mgl', frequency = 'daily')
plot(test)

## ---- echo = F-----------------------------------------------------------
dat <- apacpnut %>% 
  qaqc(qaqc_keep = NULL) %>% 
  select(-no2f, -no3f) %>% 
  rename(
    Orthophosphate = po4f, 
    Ammonium= nh4f, 
    `Nitrite/Nitrate` = no23f,
    Chlorophyll = chla_n
  )

ggpairs(dat[, -1]) +
  theme_bw()

## ---- echo = F-----------------------------------------------------------
dat <- dat %>%
  gather('var', 'val', -datetimestamp)
ggplot(dat, aes(x = datetimestamp)) +
  geom_ribbon(aes(ymax = val), ymin = 0, fill = 'blue', alpha = 0.6) + 
  geom_line(aes(y = val)) +
  geom_line(aes(y = val)) +
  facet_wrap(~var, ncol = 1, scale = 'free_y') +
  theme_bw() + 
  theme(axis.title.x = element_blank()) +
  ylab('Concentration (mg/L, ug/L)') +
  scale_x_datetime(expand = c(0, 0))

## ---- echo = T, fig.height = 3, fig.width = 9, small.mar = T-------------
x <- rnorm(100)
y <- x + rnorm(100)
par(mfrow = c(1, 3))
plot(x); plot(y)
plot(y ~ x)
abline(reg = lm(y ~ x))

## ---- echo = T, small.mar = T--------------------------------------------
par(mfrow = c(2, 2))
mod1 <- lm(y ~ x)
plot(mod1)

## ---- echo = T, fig.height = 3, fig.width = 9, small.mar = T-------------
x <- cumsum(x)
y <- cumsum(y)
par(mfrow = c(1, 3))
plot(x); plot(y)
plot(y ~ x)
abline(reg = lm(y ~ x))

## ---- echo = T, small.mar = T--------------------------------------------
mod2 <- lm(y ~ x)
par(mfrow = c(2, 2))
plot(mod2)

## ---- echo = T, fig.height = 3, fig.width = 9, small.mar = T-------------
par(mfrow = c(1, 2))
acf(resid(mod1))
acf(resid(mod2))

## ------------------------------------------------------------------------
load('data/sapdc.RData')
load('data/apacp.RData')

## ------------------------------------------------------------------------
head(sapdc)
head(apacp)

## ----echo = F, fig.height = 3, fig.width = 7, out.width = '600px'--------
toplo <- sapdc %>% 
  select(DateTimeStamp, DO_obs, Tide) %>% 
  gather('var', 'val', DO_obs:Tide) %>% 
  mutate(
    mo = month(DateTimeStamp)
  ) %>% 
  filter(mo %in% 7)

ggplot(toplo, aes(x = DateTimeStamp, y = val)) + 
  geom_line() +
  facet_wrap(~var, ncol = 1, scales = 'free_y') + 
  theme_bw() + 
  theme(axis.title.x = element_blank(), axis.title.y = element_blank())

## ------------------------------------------------------------------------
apacp <- read.table('https://usepa.github.io/cerf_r/lessons/data/apacp.txt', 
                    header = T, sep = ',')
sapdc <- read.table('https://usepa.github.io/cerf_r/lessons/data/sapdc.txt', 
                    header = T, sep = ',')
str(apacp)

## ----fig.height = 3, fig.width = 9, small.mar = T------------------------
plot(chla ~ date, apacp)

## ----fig.height = 3, fig.width = 9, small.mar = T------------------------
library(lubridate)
apacp$date <- ymd(apacp$date)
class(apacp$date)
plot(chla ~ date, apacp)

## ------------------------------------------------------------------------
head(sapdc)
sapdc$DateTimeStamp <- ymd_hms(sapdc$DateTimeStamp)
class(sapdc$DateTimeStamp)

## ------------------------------------------------------------------------
tz(sapdc$DateTimeStamp)

## ------------------------------------------------------------------------
sapdc$DateTimeStamp <- ymd_hms(sapdc$DateTimeStamp, tz = 'America/Jamaica')
class(sapdc$DateTimeStamp)
tz(sapdc$DateTimeStamp)
head(sapdc)

## ------------------------------------------------------------------------
toplo1 <- sapdc[1:100, ]
toplo2 <- toplo1 
toplo2$DateTimeStamp <- ymd_hms(toplo2$DateTimeStamp, tz = 'America/Regina')
head(toplo1$DateTimeStamp)
head(toplo2$DateTimeStamp)

## ----fig.height = 3, fig.width = 8, small.mar = T------------------------
plot(toplo1$DateTimeStamp, toplo1$Tide, type = 'l')
lines(toplo2$DateTimeStamp, toplo2$Tide, col = 'red')

## ------------------------------------------------------------------------
apacp <- apacp %>% 
  mutate(
    yr = year(date), 
    mo = month(date), 
    molb = month(date, label = TRUE),
    mdy = mday(date),
    wdy = wday(date), 
    qdy = qday(date),
    ydy = yday(date)
  )
head(apacp, 4)

## ------------------------------------------------------------------------
sapdc <- sapdc %>% 
  mutate(
    mo = month(DateTimeStamp, label = TRUE),
    dy = mday(DateTimeStamp),
    hr = hour(DateTimeStamp),
    mn = minute(DateTimeStamp), 
    sc = second(DateTimeStamp)
  )
head(sapdc)

## ------------------------------------------------------------------------
dctm <- dec_time(apacp$date)
names(dctm)
head(dctm$day_num)
head(dctm$year)
head(dctm$dec_time)

## ----eval = T, fig.width = 7, fig.height = 3, out.width = '800px'--------
ggplot(apacp, aes(x = date, y = chla)) + 
  geom_line()

## ----fig.height = 3, fig.width = 7, out.width = '800px'------------------
ggplot(apacp, aes(x = date, y = chla)) + 
  geom_line() + 
  scale_x_date(date_labels = "%Y - %m")

## ----fig.height = 3, fig.width = 7, out.width = '800px'------------------
ggplot(apacp, aes(x = date, y = chla)) + 
  geom_line() + 
  scale_x_date(date_labels = "%Y - %m", date_breaks = '2 years')

## ----fig.height = 3, fig.width = 7, out.width = '800px'------------------
toplo <- sapdc[1:1000, ]
ggplot(toplo, aes(x = DateTimeStamp, y = Temp)) + 
  geom_line()

## ----fig.height = 3, fig.width = 7, out.width = '800px'------------------
toplo <- sapdc[1:1000, ]
ggplot(toplo, aes(x = DateTimeStamp, y = Temp)) + 
  geom_line() + 
  scale_x_datetime(date_labels = "%d %H")

## ----fig.height = 3, fig.width = 7, out.width = '800px'------------------
toplo <- sapdc[1:1000, ]
ggplot(toplo, aes(x = DateTimeStamp, y = Temp)) + 
  geom_line() + 
  scale_x_datetime(date_labels = "%d %H", date_breaks = '36 hours')

## ----eval = T, fig.width = 7, fig.height = 3, out.width = '800px'--------
ggplot(apacp, aes(x = factor(yr), y = chla)) + 
  geom_boxplot()

## ----eval = T, fig.width = 7, fig.height = 3, out.width = '800px'--------
ggplot(apacp, aes(x = molb, y = chla)) + 
  geom_boxplot()

## ----eval = T, fig.width = 7, fig.height = 3, out.width = '800px'--------
ggplot(apacp, aes(x = ydy, y = chla, colour = factor(yr))) + 
  geom_line()

## ------------------------------------------------------------------------
apacp_sum <- apacp %>% 
  group_by(yr) %>% 
  summarise(
    med = median(chla, na.rm = T), 
    sd = sd(chla, na.rm = T), 
    min = min(chla, na.rm = T),
    max = max(chla, na.rm = T)
  )
head(apacp_sum)

## ---- fig.height = 3, fig.width = 7, out.width = '700px'-----------------
toplo <- sapdc %>% 
  mutate(hr = hour(DateTimeStamp)) %>% 
  group_by(hr) %>% 
  summarise(
    ave = mean(DO_obs, na.rm = T), 
    std = sd(DO_obs, na.rm = T)
  )
ggplot(toplo, aes(x = hr, y = ave)) +
  geom_ribbon(aes(ymax = ave + std, ymin = ave - std)) +
  geom_line()

## ---- eval = F-----------------------------------------------------------
## apacp_filt <- apacp %>%
##   mutate(
##     chla = ifelse(chla > 19, NA, chla)
##   )

## ------------------------------------------------------------------------
apacp_filt <- apacp %>% 
  filter(chla <= 19)

## ------------------------------------------------------------------------
head(apacp)
sum(is.na(apacp$chla))

## ---- fig.height = 3, fig.width = 8, small.mar = T-----------------------
dts <- seq.Date(min(apacp$date), max(apacp$date), by = 'month')
chla_int <- approx(x = apacp$date, y = apacp$chla, xout = dts)
plot(chla ~ date, apacp, type = 'l')
lines(dts, chla_int$y, col = 'blue')

## ----eval = F------------------------------------------------------------
## library(EnvStats)

## ---- fig.height = 3, fig.width = 7, small.mar = T-----------------------
plot(chla ~ date, apacp, type = 'l')

## ----echo = F------------------------------------------------------------
library(EnvStats)

## ----eval = T------------------------------------------------------------
# add decimal date, month
apacp$dec_time <- decimal_date(apacp$date) 
apacp$mo <- month(apacp$date)

# run test
trnd <- kendallSeasonalTrendTest(chla ~ mo + dec_time, apacp)
trnd$estimate
trnd$p.value

## ----eval = T------------------------------------------------------------
trnd$estimate
trnd$p.value

## ---- fig.height = 3, fig.width = 7, out.width = '700px'-----------------
ggplot(apacp, aes(x = factor(yr), y = nh4)) + 
  geom_boxplot()

## ---- out.width = '700px'------------------------------------------------
# subset
totst <- apacp %>% 
  filter(yr > 2004 & yr < 2009)

# run test
trnd <- kendallSeasonalTrendTest(nh4 ~ mo + dec_time, totst)
trnd$estimate
trnd$p.value

