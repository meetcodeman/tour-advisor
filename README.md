
# README

## Problem Statement

A client needed to get information about it's trip details, where he could see the location of 

city/place and also gets it weather details.

It is using OpenWeatherAPI and GoolgeMapAPI to get weather information and render maps for the user

to give him details of his latest trips.

### Built with


* [Ruby](https://www.ruby-lang.org/en/)

* [Ruby on Rails](https://rubyonrails.org/)

* [PostgreSQL](https://www.postgresql.org/)

* [RSpec](https://github.com/rspec/rspec-rails)

### Getting Started

To get a local copy up and running follow these simple steps.

### Prerequisites

*  `ruby 3.0.5`

*  `rails 6.1.7.4`

### Installation

1. Clone the repo and cd into it
	```
	git clone https://github.com/meetcodeman/trip-advisor
	cd trip-advisor
	```
2. Install the gems
	`bundle install`

3. Setup the Database
	```
    rails db:create
    rails db:migrate
    ```
4. Configure your Google Maps API Key and OpenWeather API Key:
    ```
    GOOGLE_MAPS_API_KEY=your-google-maps-api-key
    OPENWEATHER_API_KEY=your-openweather-api-key
    ```
5. Install JavaScript dependencies using webpacker:
    `yarn install`
6. Compile JavaScript assets:
    `rails webpacker:compile`
6. Start the server
	`rails s`
7. Run test suits
	`rspec`

### Features

Create and manage trips with weather information and location on Google Maps.

View trip details, including name, status, weather conditions, and location.

Delete trips as needed.

**Get All Data**
```http
curl http://localhost:3000/trips?email=your-email@gmail.com
```
