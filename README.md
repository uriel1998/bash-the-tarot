bash-the-tarot
==========

# A different way at looking at historical and current barometric data for a location.


* `barometers.py` - Produce graphs and various charts of historical barometric data for a location to aid in visualization of pressure changes quickly for (possible) prediction of health effects from the change in weather pressure.  

* Quickstart:  Install [Python (tested with v3.9.9)](https://www.python.org/downloads/) and [the PIL library](https://pillow.readthedocs.io/en/stable/installation.html).  Clone/download this repository. Get an [API key from OpenWeatherMap](http://openweathermap.org/appid).  Run the program once every half hour from a scheduled task or as a cron job.  After you've collected enough data, start outputting graphs or the "barometric load".

* To see the differences the calculations and color schemes make with data, skip down to the Examples section.

  ![](https://i.imgur.com/BDd3tBx.png)

  ![](https://i.imgur.com/OaxA4JG.png)

## Contents
 1. [About](#1-about)
 2. [License](#2-license)
 3. [Prerequisites](#3-prerequisites)
 4. [Installation](#4-installation)
 5. [Usage](#5-usage)
 6. [Examples](#6-Examples)
 7. [TODO](#7-todo)

***

## 1. About

I suffer from Willis-Ekbom Syndrome, commonly (and in my case, wrongly) called "Restless Legs Syndrome".  In my case, I experience it as *pain*, and it seemed to be significantly worse when there was a rapid change in the barometric pressure.

I know a number of other people who experience symptoms when the pressure changes quickly - or at least, it *seems* to correlate.  I noticed that I could see the correlation when I looked back at graphs, but I had a hard time *predicting* when I'd have bad symptoms from publicly available data and graphs.

Until it hit me that bodily symptoms - particularly around pressure - take *time* to adjust to changes in the environment. [I made a rough bash script that charted change over time, and it seems to provide some degree of predictive ability](https://ideatrash.net/2021/12/data-hiding-in-plain-sight-pain-and-pressure-changes-over-time.html) 

So then I taught myself python properly in a week and rewrote the program so it could provide more visualizations of the data, and am making it available so that others can do the same.


## 2. License

 
  To the extent possible under law, the person who associated CC0 with
  this source code has waived all copyright and related or neighboring rights
  to this source code.
 
  You should have received a copy of the CC0 legalcode along with this
  work.  If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.
 
 

## 3. Prerequisites

## 4. Installation

## 5. Usage

## 6. Examples

## 7. TODO

* Add in images from https://github.com/lawreka/ascii-tarot
