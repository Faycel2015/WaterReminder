# Water Reminder App 🚰

![App Logo](assets/images/app-logo.png)

A SwiftUI-based iOS application designed to help users stay hydrated throughout the day. The app tracks water intake, sends customizable reminders, and provides visual feedback on hydration goals.

[![Swift Version](https://img.shields.io/badge/Swift-5.9-orange.svg)](https://swift.org)
[![Platform](https://img.shields.io/badge/Platform-iOS%2018.0+-blue.svg)](https://developer.apple.com/ios/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

## Table of Contents
- [Overview](#overview)
- [Features](#features)
- [Screenshots](#screenshots)
- [Installation](#installation)
- [Usage](#usage)
- [Technologies Used](#technologies-used)
- [Contributing](#contributing)
- [License](#license)
- [Acknowledgments](#acknowledgments)

## Overview

The Water Reminder App is built using SwiftUI, Core Data, and the UserNotifications framework. It allows users to log their daily water intake, set personalized hydration goals, and configure reminders to ensure they stay hydrated. The app also includes statistics and achievements to motivate consistent usage.

## Features

### 💧 Hydration Tracking
- Log water intake in different units (ml, oz, cups)
- Quick-add buttons for common amounts
- Daily progress toward hydration goals

### 🎯 Personalized Goal Setting
- Calculate recommended daily water intake based on weight, activity level, and climate
- Manual adjustment of daily goals
- Support for metric/imperial measurement systems

### ⏰ Reminder System
- Configure customizable reminder schedules
- Smart reminders based on user activity and previous intake
- Notification styles with snooze/dismiss options

### 📊 Visualization & Statistics
- Daily/weekly/monthly consumption charts
- Streak information and achievements
- Insights into hydration habits

### 🎨 User Experience
- Smooth animations for water logging
- Engaging visual representation of water levels
- Intuitive navigation and input methods

## Screenshots

<div align="center">
  <img src="assets/screenshots/dashboard.png" alt="Dashboard" width="250"/>
  <img src="assets/screenshots/history.png" alt="History" width="250"/>
  <img src="assets/screenshots/statistics.png" alt="Statistics" width="250"/>
</div>

## Installation

### Prerequisites
- Xcode 16.2 or later
- macOS 12.0 or later
- iOS 18.0 or later

### Steps

1. Clone the Repository
```bash
git clone https://github.com/Faycel2015/WaterReminderApp.git
cd WaterReminderApp
```

2. Open the Project
- Open `WaterReminderApp.xcodeproj` in Xcode

3. Install Dependencies
- Dependencies will be installed automatically via Swift Package Manager

4. Run the App
- Select your target device/simulator
- Press `Cmd + R` or click the Run button

## Usage

### 1. Set Up Profile
- Launch the app and complete the initial setup wizard
- Configure your personal details:
  - Weight
  - Activity level
  - Climate conditions
  - Daily hydration goal

### 2. Log Water Intake
- Use the main dashboard quick-actions
- Tap the "+" button for custom amounts
- Swipe to edit or delete entries

### 3. Configure Reminders
- Navigate to Settings > Reminders
- Set your preferred reminder schedule
- Customize notification messages
- Enable/disable smart reminders

### 4. Track Progress
- View daily progress on the main dashboard
- Check detailed statistics in the History tab
- Monitor achievements and streaks

## Technologies Used

- **SwiftUI**: Modern declarative UI framework
- **Core Data**: Local data persistence
- **UserNotifications**: iOS notification system
- **Swift Concurrency**: Async/await pattern
- **HealthKit** (Optional): Health data integration
- **Charts**: Data visualization
- **SwiftUI Animations**: Enhanced UX

## Contributing

We welcome contributions! Here's how you can help:

1. Fork the repository
2. Create your feature branch:
```bash
git checkout -b feature/amazing-feature
```
3. Commit your changes:
```bash
git commit -m 'Add some amazing feature'
```
4. Push to the branch:
```bash
git push origin feature/amazing-feature
```
5. Open a Pull Request

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- 🙏 SwiftUI and Core Data communities
- 💡 Inspired by leading health and wellness apps
- 🎨 Icons by [Icons8](https://icons8.com)
- 📊 Charts powered by [Swift Charts](https://developer.apple.com/documentation/charts)

---

<div align="center">
  Made with ❤️ by <a href="https://github.com/Faycel2015">Faycel2015</a>
</div>
