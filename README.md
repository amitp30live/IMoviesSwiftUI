# IMoviesSwiftUI

This SwiftUI app uses the MVVM architecture to create a movie browsing experience with a focus on clean and scalable code. The app features a tab bar with "Home" and "Favorites" sections.

Key Features:

- Home Screen: Displays a grid of popular movies with images and titles, fetched from the IMDb API. If the API fails or takes too long, data is loaded from a local Json file.
- Favorites Screen: Allows users to view and manage their favorite movies. Favorites are stored using UserDefaults for persistence.
Movie Details: Shows detailed information about each movie, including a poster, title, rating, and overview, with a visually appealing layout.

Technical Highlights:

- MVVM Architecture: Separates the view, view model, and model for better code organization.
- Generic API Manager: Handles dynamic GET and POST requests with error handling and loading states.
- Reusable Components: Includes RemoteImageView for asynchronous image loading and caching, and TitleValueView for displaying key-value - pairs consistently.
- Fallback Mechanism: Automatically switches to loading data from a local JSON file if the API response is failing.
- Favorites Management: Uses a static class and UserDefaults to handle favorite movies across different views.
