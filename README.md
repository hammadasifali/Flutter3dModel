# Flutter 3D Model Viewer

## Overview
This Flutter application provides an interactive 3D model viewer where users can explore different regions of the world by selecting countries and cities. The app also includes a splash screen and a signup page for user authentication.

### Features
- **Splash Screen:** A visually appealing splash screen that greets users upon launching the app.
- **Signup Page:** A user-friendly signup page where new users can create an account.
- **Region Selection:** A 3D model viewer that allows users to select a country and view detailed information about its cities.
- **3D Model Interaction:** The application uses a high-quality 3D model of the Earth, allowing users to zoom in on specific regions and view pin markers for cities.

## Screens

### Splash Screen
The splash screen is the first screen displayed when the app is launched. It provides a smooth transition to the signup page.

### Signup Page
Users can sign up for an account with a simple form. This page includes fields for entering user information and creating a password.

### Region Screen
The main feature of the app is the interactive Region Screen. Users can select a country from a dropdown menu, and the 3D model adjusts to show that country. When a country is selected, users can choose a city from a list, and pin markers appear on the 3D model at the city's location. The 3D camera smoothly zooms in to focus on the selected region, providing an immersive experience.

## Dependencies
- **flutter_3d_controller:** For handling the 3D model and its interactions.
- **flutter/material.dart:** For building the UI components.

## Getting Started

1. Clone the repository:
   git clone https://github.com/hammadasifali/Flutter3dModel.git
2. Install dependencies:
   flutter pub get
3. Run the app:
   flutter run

## Usage
Launch the app to see the splash screen.
Sign up or log in to access the Region Screen.
Select a country and then a city to see the 3D model zoom in on that region.

## Future Enhancements
- **Enhanced 3D Model: Improve the quality of the 3D model for a more detailed and realistic experience.
- **Additional Regions: Add more countries and cities to the selection options.
User Profile: Implement a user profile page to manage account details.

## Contributing
Contributions are welcome! Please fork the repository and submit a pull request with your changes.

## License
This project is licensed under the MIT License.

This README provides an overview of your project, including its features, dependencies, and instructions for getting started.









