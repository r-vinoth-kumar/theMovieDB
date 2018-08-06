# theMovieDB

[![Build Status](https://travis-ci.com/r-vinoth-kumar/theMovieDB.svg?branch=master)](https://travis-ci.com/r-vinoth-kumar/theMovieDB)
[![codecov](https://codecov.io/gh/r-vinoth-kumar/theMovieDB/branch/master/graph/badge.svg)](https://codecov.io/gh/r-vinoth-kumar/theMovieDB)
[![GitHub license](https://img.shields.io/github/license/mashape/apistatus.svg)](https://github.com/r-vinoth-kumar/theMovieDB)


An iOS mobile app to help people discover the current most popular movies and find more information about movies their friends are talking about. The app consist of a homepage displaying the most popular movies, a search bar to search for movies by name and tapping on a movie (either homepage or search) displays additional details.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

Things you need

1. An OSX machine
2. Xcode 9.3.x or higher (Swift 4.1) (iOS 11.0)

### Installing

1. Clone this repo:
```
git clone https://github.com/r-vinoth-kumar/theMovieDB.git
```
2. Open the Xcode project
3. Run the project by pressing **⌘ + R**

## Running the tests

1. Open the Xcode project
2. Run the tests by pressing **⌘ + U**

## Project Structure (MVVM)

**MVC** is a good architecture for small projects. But when it comes to testing and code maintenance, it quickly becomes a problem.

**VIPER** is a good clean architecture for large projects. Its also good for testing and code maintenance of huge projects in the long run. But, this will be overengineered if we were to use it in small projects.

**MVVM** hits the sweet spot of having a good clean architecture for small projects. As well as good for testing and code maintenance.

So, **MVVM** it is... :)

![MVVM ScreenShot](https://themindstudios.com/blog/content/images/2017/07/MVVM-model.jpg)

## Authors

* **Vinoth Kumar Ramalingam** - [r-vinoth-kumar](https://github.com/r-vinoth-kumar)

## License

This project is licensed under the MIT License
