Water Reminder App
GitHub license
SwiftUI
iOS

A SwiftUI-based iOS application designed to help users stay hydrated throughout the day. The app tracks water intake, sends customizable reminders, and provides visual feedback on hydration goals.

Table of Contents
Overview
Features
Screenshots
Installation
Usage
Technologies Used
Contributing
License
Overview
The Water Reminder App is built using SwiftUI, Core Data, and the UserNotifications framework. It allows users to log their daily water intake, set personalized hydration goals, and configure reminders to ensure they stay hydrated. The app also includes statistics and achievements to motivate consistent usage.

Features
Hydration Tracking :
Log water intake in different units (ml, oz, cups).
Quick-add buttons for common amounts.
Daily progress toward hydration goals.
Personalized Goal Setting :
Calculate recommended daily water intake based on weight, activity level, and climate.
Manual adjustment of daily goals.
Support for metric/imperial measurement systems.
Reminder System :
Configure customizable reminder schedules.
Smart reminders based on user activity and previous intake.
Notification styles with snooze/dismiss options.
Visualization & Statistics :
Daily/weekly/monthly consumption charts.
Streak information and achievements.
Insights into hydration habits.
User Experience :
Smooth animations for water logging.
Engaging visual representation of water levels.
Intuitive navigation and input methods.
Screenshots
Dashboard
History
Statistics

Replace placeholder images with actual screenshots of your app.

Installation
To run the Water Reminder App locally, follow these steps:

Prerequisites
Xcode 16.2 or later
macOS 12.0 or later
iOS 18.0 or later
Steps
Clone the Repository :
bash
Copy
1
2
git clone [(https://github.com/Faycel2015/WaterReminder.git)]
cd WaterReminderApp
Open the Project :
Open the .xcodeproj file in Xcode.
Install Dependencies :
If you're using Swift Package Manager, dependencies will be installed automatically.
Run the App :
Select a simulator or physical device from the Xcode toolbar.
Click the "Run" button (Cmd + R) to launch the app.
Usage
Set Up Profile :
Open the Settings tab and configure your weight, activity level, and climate.
Adjust your daily hydration goal if needed.
Log Water Intake :
Use the Main Dashboard to log water consumption using quick-add buttons or manual entry.
Configure Reminders :
Go to the Reminder Configuration screen to set up personalized reminders.
Customize times, messages, and frequencies.
Track Progress :
View your hydration progress on the Main Dashboard.
Explore detailed statistics in the History and Statistics tabs.
Technologies Used
SwiftUI : For building the user interface.
Core Data : For local data storage.
UserNotifications Framework : For scheduling and managing reminders.
Swift Concurrency : For asynchronous operations.
HealthKit (Optional) : For integrating with Apple Health.
Contributing
We welcome contributions to improve the Water Reminder App! To contribute, follow these steps:

Fork the repository.
Create a new branch for your feature or bug fix:
bash
Copy
1
git checkout -b feature/your-feature-name
Make your changes and commit them:
bash
Copy
1
git commit -m "Add your feature description"
Push your changes to your fork:
bash
Copy
1
git push origin feature/your-feature-name
Submit a pull request to the main repository.
License
This project is licensed under the MIT License. See the LICENSE file for details.

Acknowledgments
Special thanks to the SwiftUI and Core Data communities for providing valuable resources and examples.
Inspiration for design and functionality came from popular health and wellness apps.
