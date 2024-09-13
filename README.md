bash-the-tarot
==========

A fully featured cli-based tarot card reader with basic interpretations and ASCII images 
  
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

I wanted a fully featured, celtic-cross reading tarot program on the command line. So I made one.

The scripts *only* do the Celtic cross layout. 

The images are the out-of-copyright Rider-Waite ones, though `jp2a` turns them into ASCII for us.

The data for the readings largely come from  [the Resonator Voyant Tarot](https://github.com/abetusk/ResonatorVoyantTarot), although they've been modified somewhat.

The script will take any optional input and use that in the seed for the pseudo-random generator, so go ahead and ask the questions you want.

The main version (*not* the "no fancy" version) will walk you through the cards of the reading one at a time, then provide you a nice interface using `fzf` to let you review or optionally export the reading.

 
## 2. License


  To the extent possible under law, the person who associated CC0 with
  this source code has waived all copyright and related or neighboring rights
  to this source code.

  You should have received a copy of the CC0 legalcode along with this
  work.  If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.



## 3. Prerequisites

    bash - I use some bashisms here.
    fzf - for pretty review
    jq - for parsing json
    awk, sed, grep 
    jp2a - for the images

    On Debian/Ubuntu/MXLinux and the like, you should be able to get these with:
    
    `sudo apt install jq fzf gawk jp2a sed grep`

## 4. Installation

* Ensure that the prerequisites are installed and on your $PATH.
* Make sure that the `/lib/` directory exists in the same place as the script.
* Make sure that the directory is writeable (it creates a `/tmp` directory here)

## 5. Usage

./bash_the_tarot.sh [Optional query string here]
 
Uses `fzf` to allow you to scroll through the reading after the initial walkthrough. 
You may also optionally export the reading which is placed in your $HOME directory.
 
`./bash_the_tarot_no_fancy.sh [Optional query string here]`

Just gives you a quick reading, no fancypants stuff like images or scrolling.

## 6. Examples

## 7. TODO

* Add in no-color switch somehow
* Add in the pictorial descriptions from R-W, perhaps?
