2019 (c) Alex Farmer, Pavel Ilin, Austin Smith


<p align="center">EasyComps</p>
<p align="center">Your Real Source for Real Easy Real Estate Comparables</p>

<p align="center">
  <img align="center" src="https://img.shields.io/badge/CSS-3.0-1572B6">
  <img align="center" src="https://img.shields.io/badge/HTML-5.2-E34F26">
  <img align="center" src="https://img.shields.io/badge/Postgresql-12.1-336791">
  <img align="center" src="https://img.shields.io/badge/Ruby-2.6.5-CC342D">
  <img align="center" src="https://img.shields.io/badge/Ruby%20On%20Rails-6.0.2.1-cc0600">
</p>  

<p align="center">
  <a href="https://github.com/trunkslamchest/mod2_project/tree/version-0.2"><img align="center" src="https://img.shields.io/badge/Latest%20Branch-0.2-000000"></a>
</p> 

<p align="center">
  <img align="center" src="https://img.shields.io/badge/Status-Work%20In%20Progress-000000">
</p>  

# Contents
- [Introduction](#introduction)
  - [Description](#description)
  - [Key Features](#key-features)
  - [Goals](#goals)
  - [Challenges](#challenges)
- [Installation](#installation)
    - [Prerequisites](#prerequisites)
    - [First Start](#first-start)
- [Summary Of Files](#summary-of-files)
  - [Internal File Structure](#internal-file-structure)
- [Credits](#credits)

&nbsp;

# Introduction
  ### Description
EasyComps is an application designed for potential real estate buyers/investors to browse, compare, and save real estate listings..
  
  ### Key Features
  - Data is collected and distributed through the Zillow API
  - User login/signup features with bcrypt validation and authentication
  - Browse listings and save them to favorites
  - Logging of player scores
  - Power Meter that fluctuates based on repetitions per keypress
  - Fun for the whole family
  
  ### Goals
  The main goals of the application is to provide users with the ability to .
  
  ### Challenges
  - Develop the application within 10 days
  - Work together as a 3-man development team and make sure all deliverables were met with no overlaps in workflow occured
  - Sending and receiving requests from the Zillow API using Zester
  - Developing proper validation and authentication tools for User login and Signup features
  - Design all CSS elements and animations with a simple, easy to use, east to understand interface
  - Deployment
  
&nbsp;

<a href="https://github.com/trunkslamchest/mod2_project/blob/master/README.md#contents"><img src="https://img.shields.io/badge/^-Back%20To%20Top-000000"></a>

&nbsp;

# Installation
  ### Prerequisites
 - Easy Comps is built using Ruby, Ruby on Rails & PostgresQL. Make sure you have the latest versions of the three following components installed before cloning this repo. You can find their official installation guides below:
  - [Ruby](https://www.ruby-lang.org/en/documentation/installation/)
  - [Ruby On Rails](https://guides.rubyonrails.org/v5.0/getting_started.html)
  - [PostgresQL](https://www.postgresqltutorial.com/)
 - A Zillow API key is required for Easy Comps to function properly. Sign up for a Zillow API key by [clicking this link](https://www.zillow.com/howto/api/APIOverview.htm)

&nbsp;
  ### Setup
  - Clone the Most Recent Branch [The Backend Repository](https://github.com/trunkslamchest/mod2_project/tree/version-0.2)
    - If you are running on Windows, add `gem 'wdm', '>= 0.1.0'` to Gemfile before running `bundle install`
    - If you are running on macOS, remove `gem 'wdm', '>= 0.1.0'` from Gemfile before running `bundle install`

  - Run `bundle install` to install all gems/dependancies required for Easy Comps
  - Run `rails db:create ` to create a local PostgresQL database
  - Run `rails db:migrate` to create the tables/columns required for proper Spacebar Smasher functionality
  - Create a file called `.env` in the root directory and add `SECRET_ZILLOW = "<insert Zillow API key here>"` and `EASYCOMPS_DATABASE_PASSWORD = "<insert password used during PostgresQL installation>"` to the file



&nbsp;

  ### First Start
   If you have not received any errors/resolve any errors you have encountered during Prerequisite Installation, you are ready to start Easy Comps for the first time.

  - Run `rails s` to start the server
    - You can now use Easy Comps by visiting: `http://localhost:3000`

  Thats it! Have fun breaking/fixing/doing whatever you want with Easy Comps. The world is your oyster!

&nbsp;

  **If you have recieved any errors during this process, feel free to contact me so I can help you and update this readme accordingly**

&nbsp;

<a href="https://github.com/trunkslamchest/mod2_project/blob/master/README.md#contents"><img src="https://img.shields.io/badge/^-Back%20To%20Top-000000"></a>

&nbsp;

# Summary Of Files
  ### Internal File Structure
    - [app](https://github.com/trunkslamchest/mod2_project/tree/version-0.2/app): Primary location for API configuration
      - [controllers](https://github.com/trunkslamchest/mod2_project/tree/version-0.2/app/controllers): Render/REST methods
      - [models](https://github.com/trunkslamchest/mod2_project/tree/version-0.2/app/models): Active Record Associations methods
      - [serializers](https://github.com/trunkslamchest/mod2_project/tree/version-0.2/app/serializers): Filters for API
      - [views](https://github.com/trunkslamchest/mod2_project/tree/version-0.2/app/views): HTML files used to render webpages
  - [bin](https://github.com/trunkslamchest/mod2_project/tree/version-0.2/bin): Environment configuration files
  - [config](https://github.com/trunkslamchest/mod2_project/tree/version-0.2/config): Backend configuration files
  - [db](https://github.com/trunkslamchest/mod2_project/tree/version-0.2/db): Database Configuration files
  - [Gemfile](https://github.com/trunkslamchest/mod2_project/tree/version-0.2/Gemfile): Prerequistes & Dependencies

&nbsp;

<a href="https://github.com/trunkslamchest/mod2_project/blob/master/README.md#contents"><img src="https://img.shields.io/badge/^-Back%20To%20Top-000000"></a>

&nbsp;

# Credits

  - [Alex Farmer](https://github.com/alexfarmer91): Co-creator & Contributor
  - [Pavel Illin](https://github.com/pashuntiy): Co-creator & Contributor
  - [The Flatiron School](https://flatironschool.com/)
  - [CSS](https://www.w3.org/Style/CSS/Overview.en.html)
  - [HTML](https://developer.mozilla.org/en-US/docs/Web/HTML)
  - [PostgresQL](https://www.postgresql.org/)
  - [Ruby](https://www.ruby-lang.org/en/)
  - [Ruby On Rails](https://rubyonrails.org/)

&nbsp;

<a href="https://github.com/trunkslamchest/mod2_project/blob/master/README.md#contents"><img src="https://img.shields.io/badge/^-Back%20To%20Top-000000"></a>

&nbsp;
