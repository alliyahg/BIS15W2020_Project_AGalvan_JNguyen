---
title: "Weather"
author: "Alliyah Galvan & Jason Nguyen"
date: "March 3, 2020"
output:
  html_document: 
    keep_md: yes
    theme: spacelab
    toc: yes
    toc_float: yes
---


```r
library(tidyverse)
```

```
## <U+2500><U+2500> Attaching packages <U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500> tidyverse 1.3.0 <U+2500><U+2500>
```

```
## <U+2713> ggplot2 3.2.1     <U+2713> purrr   0.3.3
## <U+2713> tibble  2.1.3     <U+2713> dplyr   0.8.3
## <U+2713> tidyr   1.0.0     <U+2713> stringr 1.4.0
## <U+2713> readr   1.3.1     <U+2713> forcats 0.4.0
```

```
## <U+2500><U+2500> Conflicts <U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500><U+2500> tidyverse_conflicts() <U+2500><U+2500>
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```

```r
library(naniar)
library(skimr)
```

```
## 
## Attaching package: 'skimr'
```

```
## The following object is masked from 'package:naniar':
## 
##     n_complete
```


```r
weather <- readr::read_csv("data/weather.csv")
```

```
## Warning: Missing column names filled in: 'X1' [1]
```

```
## Parsed with column specification:
## cols(
##   .default = col_double(),
##   city = col_character(),
##   date = col_date(format = ""),
##   events = col_character()
## )
```

```
## See spec(...) for full column specifications.
```

```
## Warning: 183 parsing failures.
##  row    col expected actual               file
## 2194 precip a double      T 'data/weather.csv'
## 2196 precip a double      T 'data/weather.csv'
## 2197 precip a double      T 'data/weather.csv'
## 2203 precip a double      T 'data/weather.csv'
## 2206 precip a double      T 'data/weather.csv'
## .... ...... ........ ...... ..................
## See problems(...) for more details.
```

```r
weather
```

```
## # A tibble: 3,655 x 26
##       X1 city  date        year month   day high_temp avg_temp low_temp
##    <dbl> <chr> <date>     <dbl> <dbl> <dbl>     <dbl>    <dbl>    <dbl>
##  1     1 Auck<U+2026> 2016-01-01  2016     1     1        68       65       62
##  2     2 Auck<U+2026> 2016-01-02  2016     1     2        68       66       64
##  3     3 Auck<U+2026> 2016-01-03  2016     1     3        77       72       66
##  4     4 Auck<U+2026> 2016-01-04  2016     1     4        73       66       60
##  5     5 Auck<U+2026> 2016-01-05  2016     1     5        69       62       55
##  6     6 Auck<U+2026> 2016-01-06  2016     1     6        69       63       57
##  7     7 Auck<U+2026> 2016-01-07  2016     1     7        71       66       60
##  8     8 Auck<U+2026> 2016-01-08  2016     1     8        77       70       64
##  9     9 Auck<U+2026> 2016-01-09  2016     1     9        69       66       64
## 10    10 Auck<U+2026> 2016-01-10  2016     1    10        71       66       62
## # <U+2026> with 3,645 more rows, and 17 more variables: high_dewpt <dbl>,
## #   avg_dewpt <dbl>, low_dewpt <dbl>, high_humidity <dbl>, avg_humidity <dbl>,
## #   low_humidity <dbl>, high_hg <dbl>, avg_hg <dbl>, low_hg <dbl>,
## #   high_vis <dbl>, avg_vis <dbl>, low_vis <dbl>, high_wind <dbl>,
## #   avg_wind <dbl>, low_wind <dbl>, precip <dbl>, events <chr>
```


```r
weather %>% 
  select(-"X1")
```

```
## # A tibble: 3,655 x 25
##    city  date        year month   day high_temp avg_temp low_temp high_dewpt
##    <chr> <date>     <dbl> <dbl> <dbl>     <dbl>    <dbl>    <dbl>      <dbl>
##  1 Auck<U+2026> 2016-01-01  2016     1     1        68       65       62         64
##  2 Auck<U+2026> 2016-01-02  2016     1     2        68       66       64         64
##  3 Auck<U+2026> 2016-01-03  2016     1     3        77       72       66         70
##  4 Auck<U+2026> 2016-01-04  2016     1     4        73       66       60         66
##  5 Auck<U+2026> 2016-01-05  2016     1     5        69       62       55         55
##  6 Auck<U+2026> 2016-01-06  2016     1     6        69       63       57         54
##  7 Auck<U+2026> 2016-01-07  2016     1     7        71       66       60         59
##  8 Auck<U+2026> 2016-01-08  2016     1     8        77       70       64         72
##  9 Auck<U+2026> 2016-01-09  2016     1     9        69       66       64         68
## 10 Auck<U+2026> 2016-01-10  2016     1    10        71       66       62         63
## # <U+2026> with 3,645 more rows, and 16 more variables: avg_dewpt <dbl>,
## #   low_dewpt <dbl>, high_humidity <dbl>, avg_humidity <dbl>,
## #   low_humidity <dbl>, high_hg <dbl>, avg_hg <dbl>, low_hg <dbl>,
## #   high_vis <dbl>, avg_vis <dbl>, low_vis <dbl>, high_wind <dbl>,
## #   avg_wind <dbl>, low_wind <dbl>, precip <dbl>, events <chr>
```


```r
glimpse(weather)
```

```
## Observations: 3,655
## Variables: 26
## $ X1            <dbl> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, <U+2026>
## $ city          <chr> "Auckland", "Auckland", "Auckland", "Auckland", "Auckla<U+2026>
## $ date          <date> 2016-01-01, 2016-01-02, 2016-01-03, 2016-01-04, 2016-0<U+2026>
## $ year          <dbl> 2016, 2016, 2016, 2016, 2016, 2016, 2016, 2016, 2016, 2<U+2026>
## $ month         <dbl> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1<U+2026>
## $ day           <dbl> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, <U+2026>
## $ high_temp     <dbl> 68, 68, 77, 73, 69, 69, 71, 77, 69, 71, 75, 69, 71, 75,<U+2026>
## $ avg_temp      <dbl> 65, 66, 72, 66, 62, 63, 66, 70, 66, 66, 67, 66, 66, 68,<U+2026>
## $ low_temp      <dbl> 62, 64, 66, 60, 55, 57, 60, 64, 64, 62, 59, 62, 62, 62,<U+2026>
## $ high_dewpt    <dbl> 64, 64, 70, 66, 55, 54, 59, 72, 68, 63, 61, 66, 61, 63,<U+2026>
## $ avg_dewpt     <dbl> 60, 63, 67, 60, 52, 51, 54, 67, 61, 58, 58, 62, 57, 61,<U+2026>
## $ low_dewpt     <dbl> 55, 61, 64, 54, 48, 46, 50, 59, 55, 55, 54, 59, 54, 59,<U+2026>
## $ high_humidity <dbl> 100, 100, 100, 100, 82, 88, 83, 100, 100, 88, 94, 100, <U+2026>
## $ avg_humidity  <dbl> 82, 94, 91, 76, 69, 65, 65, 92, 81, 76, 72, 87, 73, 80,<U+2026>
## $ low_humidity  <dbl> 68, 88, 74, 53, 56, 46, 53, 83, 64, 64, 53, 78, 64, 65,<U+2026>
## $ high_hg       <dbl> 30.15, 30.04, 29.80, 30.12, 30.21, 30.24, 30.24, 30.01,<U+2026>
## $ avg_hg        <dbl> 30.09, 29.90, 29.73, 29.90, 30.14, 30.22, 30.13, 29.79,<U+2026>
## $ low_hg        <dbl> 30.01, 29.80, 29.68, 29.77, 30.09, 30.18, 30.04, 29.62,<U+2026>
## $ high_vis      <dbl> 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6<U+2026>
## $ avg_vis       <dbl> 6, 5, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6<U+2026>
## $ low_vis       <dbl> 4, 1, 1, 6, 6, 6, 6, 2, 4, 6, 6, 3, 6, 6, 6, 6, 6, 2, 6<U+2026>
## $ high_wind     <dbl> 21, 33, 18, 15, 13, 17, 22, 21, 18, 20, 17, 16, 18, 17,<U+2026>
## $ avg_wind      <dbl> 15, 21, 12, 10, 7, 8, 12, 14, 11, 15, 10, 8, 13, 9, 7, <U+2026>
## $ low_wind      <dbl> 28, 46, NA, NA, NA, 28, 25, 28, 29, NA, 26, NA, NA, NA,<U+2026>
## $ precip        <dbl> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0<U+2026>
## $ events        <chr> "Rain", "Rain", "Rain", "Rain", NA, NA, "Rain", "Rain",<U+2026>
```


```r
colnames(weather)
```

```
##  [1] "X1"            "city"          "date"          "year"         
##  [5] "month"         "day"           "high_temp"     "avg_temp"     
##  [9] "low_temp"      "high_dewpt"    "avg_dewpt"     "low_dewpt"    
## [13] "high_humidity" "avg_humidity"  "low_humidity"  "high_hg"      
## [17] "avg_hg"        "low_hg"        "high_vis"      "avg_vis"      
## [21] "low_vis"       "high_wind"     "avg_wind"      "low_wind"     
## [25] "precip"        "events"
```


```r
new_factor<- c(1:5,26)
new_numeric<- c(6:25)
weather[,new_factor] <- lapply(weather[,new_factor], as.factor)
weather[,new_numeric] <- lapply(weather[,new_numeric], as.numeric)
lapply(weather, class) #changing classes
```

```
## $X1
## [1] "factor"
## 
## $city
## [1] "factor"
## 
## $date
## [1] "factor"
## 
## $year
## [1] "factor"
## 
## $month
## [1] "factor"
## 
## $day
## [1] "numeric"
## 
## $high_temp
## [1] "numeric"
## 
## $avg_temp
## [1] "numeric"
## 
## $low_temp
## [1] "numeric"
## 
## $high_dewpt
## [1] "numeric"
## 
## $avg_dewpt
## [1] "numeric"
## 
## $low_dewpt
## [1] "numeric"
## 
## $high_humidity
## [1] "numeric"
## 
## $avg_humidity
## [1] "numeric"
## 
## $low_humidity
## [1] "numeric"
## 
## $high_hg
## [1] "numeric"
## 
## $avg_hg
## [1] "numeric"
## 
## $low_hg
## [1] "numeric"
## 
## $high_vis
## [1] "numeric"
## 
## $avg_vis
## [1] "numeric"
## 
## $low_vis
## [1] "numeric"
## 
## $high_wind
## [1] "numeric"
## 
## $avg_wind
## [1] "numeric"
## 
## $low_wind
## [1] "numeric"
## 
## $precip
## [1] "numeric"
## 
## $events
## [1] "factor"
```


## The Average Temperature of Each City in 2016.

```r
weather %>% 
  filter(year=="2016") %>% 
  select(city, avg_temp,) %>% 
  group_by(city) %>%
  summarize(yearly_avg_temp=mean(avg_temp))
```

```
## # A tibble: 5 x 2
##   city      yearly_avg_temp
##   <fct>               <dbl>
## 1 Auckland             60.8
## 2 Beijing              55.2
## 3 Chicago              52.5
## 4 Mumbai               80.7
## 5 San Diego            66.6
```


```r
weather %>% 
  filter(year=="2017") %>% 
  select(city, avg_temp,) %>% 
  group_by(city) %>%
  summarize(yearly_avg_temp=mean(avg_temp))
```

```
## # A tibble: 5 x 2
##   city      yearly_avg_temp
##   <fct>               <dbl>
## 1 Auckland             60.5
## 2 Beijing              55.8
## 3 Chicago              52.8
## 4 Mumbai               81.1
## 5 San Diego            66.5
```


```r
weather %>%
  group_by(city) %>%
  summarize(yearly_avg_temp=mean(avg_temp)) %>% 
  ggplot(aes(x=city, yearly_avg_temp)) +
  geom_bar(stat = "identity")
```

![](Weather_Project_files/figure-html/unnamed-chunk-9-1.png)<!-- -->

# make a shiny app, (copy ledford)
