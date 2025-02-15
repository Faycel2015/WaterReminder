# Water Reminder App Documentation

## Table of Contents
1. [Introduction](#introduction)
2. [Key Features](#key-features)
3. [Architecture Overview](#architecture-overview)
4. [Core Data Models](#core-data-models)
5. [View Hierarchy](#view-hierarchy)
6. [Services & Utilities](#services--utilities)
7. [Usage Instructions](#usage-instructions)
8. [Testing](#testing)
9. [Accessibility](#accessibility)
10. [Localization](#localization)
11. [Future Enhancements](#future-enhancements)

## Introduction
The Water Reminder App is a SwiftUI-based iOS application designed to help users stay hydrated throughout the day. It tracks water intake, sends customizable reminders, and provides visual feedback on hydration goals. The app leverages Core Data for local storage, Swift Concurrency for asynchronous operations, and the UserNotifications framework for reminders.

## Key Features

### 1. Hydration Tracking
- Log water intake in different units (ml, oz, cups)
- Quick-add buttons for common amounts
- Daily progress toward hydration goals

### 2. Personalized Goal Setting
- Calculate recommended daily water intake based on weight, activity level, and climate
- Manual adjustment of daily goals
- Support for metric/imperial measurement systems

### 3. Reminder System
- Configure customizable reminder schedules
- Smart reminders based on user activity and previous intake
- Notification styles with snooze/dismiss options

### 4. Visualization & Statistics
- Daily/weekly/monthly consumption charts
- Streak information and achievements
- Insights into hydration habits

### 5. User Experience
- Smooth animations for water logging
- Engaging visual representation of water levels
- Intuitive navigation and input methods

## Architecture Overview
The app follows a modular architecture with clear separation of concerns:

### Core Components
1. Models: Define Core Data entities for WaterIntake, UserProfile, and ReminderSettings
2. Views: Implement SwiftUI views for the dashboard, history, statistics, settings, and reminders
3. ViewModels: Manage business logic and data flow using ObservableObjects
4. Services: Handle notifications, HealthKit integration, and other external services
5. Utils: Provide utility functions and extensions for common tasks

### Data Flow
- Core Data: Stores water intake records, user profiles, and reminder settings
- ViewModels: Act as intermediaries between views and Core Data
- Views: Display data and capture user input

## Core Data Models

### WaterIntake
- Attributes:
  - amount (Double): Amount of water consumed
  - unit (String): Unit of measurement (e.g., "ml", "oz")
  - timestamp (Date): Time when water was logged

### UserProfile
- Attributes:
  - weight (Double): User's weight
  - activityLevel (String): Activity level (e.g., "low", "moderate", "high")
  - climate (String): Climate type (e.g., "dry", "humid")
  - dailyGoal (Double): Personalized daily water goal
  - measurementSystem (String): Preferred system ("metric" or "imperial")

### ReminderSettings
- Attributes:
  - time (Date): Scheduled reminder time
  - message (String): Custom notification message
  - isActive (Bool): Whether the reminder is enabled

## View Hierarchy

### Main Views
1. MainDashboard.swift:
   - Displays hydration progress, quick-add buttons, and next reminder
2. HistoryView.swift:
   - Shows a calendar view and recent water intake records
3. StatisticsView.swift:
   - Provides charts for daily, weekly, and monthly consumption
4. SettingsView.swift:
   - Configures user profile, reminder schedule, and app preferences
5. ReminderConfigurationView.swift:
   - Manages reminder settings and notification scheduling

### Supporting Views
- AchievementsView.swift: Displays streaks and badges
- ChartSection.swift: Renders consumption charts
- StreakSection.swift: Tracks consecutive days meeting hydration goals

## Services & Utilities

### NotificationService.swift
- Handles notification scheduling and cancellation
- Centralizes interaction with the UserNotifications framework

### HealthKitService.swift (Optional)
- Integrates with Apple Health to sync water intake data
- Imports/exports health metrics for correlation

### Extensions.swift
- Provides utility extensions for Date, String, and other types

### Constants.swift
- Stores app-wide constants (e.g., default daily goal, units)

### Animations.swift
- Implements custom liquid-themed animations for a polished UI

## Usage Instructions

### For Users
1. Set Up Profile:
   - Open the Settings tab and configure your weight, activity level, and climate
   - Adjust your daily hydration goal if needed
2. Log Water Intake:
   - Use the Main Dashboard to log water consumption using quick-add buttons or manual entry
3. Configure Reminders:
   - Go to the Reminder Configuration screen to set up personalized reminders
   - Customize times, messages, and frequencies
4. Track Progress:
   - View your hydration progress on the Main Dashboard
   - Explore detailed statistics in the History and Statistics tabs

### For Developers
1. Clone the Repository:
   - Clone the project from its source repository
   - Open the .xcodeproj file in Xcode 16.2 or later
2. Run the App:
   - Ensure you have iOS 18.0 or later installed on your device/simulator
   - Build and run the app to test functionality
3. Customize Features:
   - Modify Core Data models in the /Models folder
   - Update views and view models in the /Views and /ViewModels folders
   - Extend services in the /Services folder

## Testing

### Unit Tests
- Located in the UnitTests folder
- Test core business logic, such as data aggregation, notification scheduling, and Core Data operations

### UI Tests
- Located in the UITests folder
- Validate critical user flows, including logging water, configuring reminders, and navigating between screens

### How to Run Tests
1. Open the project in Xcode
2. Navigate to the Test Navigator (Cmd + 6)
3. Select and run individual tests or the entire suite

## Accessibility
The app supports accessibility features to ensure usability for all users:
- VoiceOver: Semantic labels are added to all interactive elements
- Dynamic Type: Text sizes can be adjusted for better readability
- Reduced Motion: Animations can be disabled for users with motion sensitivities
- Color Contrast: Sufficient contrast is maintained for text and visuals

## Localization
The app is designed for localization:
- All strings are stored in string catalogs for easy translation
- Supports multiple languages (English, Spanish, French, etc.)

## Future Enhancements

### 1. HealthKit Integration
- Sync water intake data with Apple Health
- Correlate hydration with other health metrics

### 2. Smart Suggestions
- Use machine learning to suggest optimal drinking times
- Adapt to user patterns over time

### 3. Social Features
- Optional sharing of achievements
- Hydration challenges with friends

### 4. Widgets & Complications
- Add Home Screen widgets for quick logging
- Include Apple Watch complications and Live Activities
