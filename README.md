# MovieDataBase iOS App

A SwiftUI-based iOS application that allows users to browse and search through a collection of movies, offering detailed information about each film including ratings, plot, cast, and more.

## Features

- **Browse Movies**: View all movies in the database with an aesthetically pleasing card-based layout
- **Advanced Search**: Search movies by multiple criteria:
  - Title
  - Actor
  - Director
  - Genre
  - Year
- **Filter Categories**: Browse movies through categorized filters:
  - Years
  - Genres
  - Directors
  - Actors
- **Detailed Movie Information**:
  - High-resolution movie poster
  - Plot summary
  - Cast and crew details
  - Release information
  - Multiple rating sources (IMDB, Rotten Tomatoes, Metacritic)
  - Awards and recognition
  - Box office performance
  - Technical details (runtime, language, country)

## Technical Details

### Architecture
- **MVVM Architecture** using SwiftUI and Combine
- Observable objects for state management
- Async image loading with proper loading states
- Efficient search implementation with multiple criteria

### Key Components

1. **MainViewModel**
   - Manages the movie data and filtering logic
   - Implements search functionality
   - Handles data loading and filtering

2. **Views**
   - `MovieDatabaseView`: Main view with search and filtering capabilities
   - `SelectedMoviesView`: Displays filtered movie results
   - `MovieDetailView`: Shows comprehensive movie information
   - `MovieCardView`: Reusable component for movie list items

### Requirements

- iOS 18.0 or later
- Xcode 16.0 or later
- Swift 6.0 or later

## Installation

1. Clone the repository:
```bash
git clone https://github.com/gembalisandesh/MovieDataBase.git
```

2. Open MovieDataBase.xcodeproj in Xcode

3. Build and run the project

## Usage

1. **Browse Movies**
   - Launch the app
   - Scroll through the available movies
   - Use the filter sections to browse by specific criteria

2. **Search**
   - Use the search bar at the top
   - Enter any search term (title, actor, director, etc.)
   - Results update automatically

3. **View Details**
   - Tap on any movie to view detailed information
   - Switch between different rating sources using the segmented control
   - Scroll through comprehensive movie details

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## Acknowledgments

- Uses dummy data for demonstration purposes
- Built with SwiftUI and Combine frameworks
- Uses AsyncImage for efficient image loading
