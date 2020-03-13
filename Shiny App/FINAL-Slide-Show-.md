---
title: "Weather Patterns in 5 Major Cities"
author: "Alliyah Galvan & Jason Nguyen"
date: "March 13, 2020"
output: 
  ioslides_presentation: 
    keep_md: yes
---







## Background | Data
-  <font size="4"> Our data was provided by: https://vincentarelbundock.github.io/Rdatasets/doc/mosaicData/Weather.html </font>
- <font size="4"> The data is an average of different weather patterns collected every day from 2016-2017 in 5 major cities: Auckland, New Zealand | Beijing, China | Chicago, USA | Mumbai, India | San Diego, USA</font>
- <font size="4"> Weather patterns include: Temperature, Dewpoint, Humidity, Wind, and Weathering Events</font>

## Shiny App










```r
weather_mean <- cbind(weather_temp, weather_dewpt, weather_humidty, weather_wind) #combining yearly average into one table
weather_cleaner <- weather_mean %>% 
  select(-c(4,6,8)) %>% 
  pivot_longer(Average_Temp:Average_Wind,
               names_to = "Measure",
               values_to = "Value")
weather_cleaner
```

- The Shiny App allows for a visual representation of the yearly comparisons between each city for temperature, dewpoint, humidity, and wind.
- We had to make multiple tables of each category and combine them. Then, tidy the data using pivot longer.
- The Shiny App is present in its own file in our Repository.

## **Average Monthly Temperatures for All Cities for 2016**
<img src="FINAL-Slide-Show-_files/figure-html/unnamed-chunk-8-1.png" width="60%" style="display: block; margin: auto;" />

- <font size="2">To break things down further, here is a look at the average temperature for each city in 2016.</font>
- <font size="2">It is evident that Auckland lies in the Southern Hemisphere while the other cities lie in the Northern Hemisphere.</font>
- <font size="2">Auckland increases temperature while the other cities' average temperatures decrease and vice versa.</font>

## **Average Monthly Temperatures for All Cities for 2017**
<img src="FINAL-Slide-Show-_files/figure-html/unnamed-chunk-9-1.png" width="60%" style="display: block; margin: auto;" />

- <font size="2">Similar temperature patterns are shown in 2017 with slight fluctuations.</font>
- <font size="2">We also notice that  Mumbai has overall the highest temperature because it is closest to the equator.</font>

## **Average Monthly Dewpoints for All Cities for 2016**
<img src="FINAL-Slide-Show-_files/figure-html/unnamed-chunk-10-1.png" width="60%" style="display: block; margin: auto;" />

- <font size="2">Average dewpoint percentages show similar results to average temperatures as dewpoint is defined as the measure of how much moisture is in the air.</font>

## **Average Monthly Dewpoints for All Cities for 2017**
<img src="FINAL-Slide-Show-_files/figure-html/unnamed-chunk-11-1.png" width="60%" style="display: block; margin: auto;" />

- Again here is the overall year of 2017 showing the dewpoint monthly average percentages for each of the 5 cities.

## **Average Monthly Humidity for All Cities for 2016**
<img src="FINAL-Slide-Show-_files/figure-html/unnamed-chunk-12-1.png" width="60%" style="display: block; margin: auto;" />

- <font size="2"> Humidity varies from the two previous graphs. As seen, Auckland has a consistently high humidity percentage while the other cities have greater fluctuation.</font> 
- <font size="2">This is also in fact due to the fact that Auckland lies closest to the equator and does not vary in weather patterns as much.</font>

## **Average Monthly Humidity for All Cities for 2017**
<img src="FINAL-Slide-Show-_files/figure-html/unnamed-chunk-13-1.png" width="60%" style="display: block; margin: auto;" />

- In 2017, the overall humidity greatly resembles that of 2016 for these major cities.

## **Chaning NA's for Events Column**

```r
weather$events<- as.character(weather$events)
weather$events[is.na(weather$events)] <- "Clear Skies"
skies <- weather %>% 
  select(city, events)
```

- We had NA's in the Weathering Events Column. But since we wanted to find out the types of weather events each city had, we changed the NA into "Clear Skies".

## **Auckland Weather Events**

<img src="FINAL-Slide-Show-_files/figure-html/unnamed-chunk-15-1.png" width="70%" style="display: block; margin: auto;" />

- Auckland's weathering events are a bit of a surprise; rain takes precedence over clear skies.

## **Beijing Weather Events**
<img src="FINAL-Slide-Show-_files/figure-html/unnamed-chunk-16-1.png" width="70%" style="display: block; margin: auto;" />

- Beijing's full of days with clear skies within these two years. Rain trails along as the next common weathering event.

## **Chicago Weather Events**
<img src="FINAL-Slide-Show-_files/figure-html/unnamed-chunk-17-1.png" width="70%" style="display: block; margin: auto;" />

- As expected, Chicago shows variation throughout the two years with a variety of different patterns. However, Chicago still maintains its days with clear skies as higher than any other weathering event.

## **Mumbai Weather Events**
<img src="FINAL-Slide-Show-_files/figure-html/unnamed-chunk-18-1.png" width="70%" style="display: block; margin: auto;" />

- For a majority of the year, Mumbai shows clear skies. Rainy days are not as common as clear skies but appear more frequently than any other weather event or combinations of events.

## **San Diego Weather Events**
<img src="FINAL-Slide-Show-_files/figure-html/unnamed-chunk-19-1.png" width="70%" style="display: block; margin: auto;" />

- San Diego as predicted has a majority of clear skies throughout the two years of data. 
- They don't call it "Sunny San Diego" for nothing!
