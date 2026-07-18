# T. A. A. Sudaraka
**Index:** COBSCCOMP242p-037

## GameHub
A simple iOS game app built with SwiftUI. This project includes multiple mini-games, basic stats tracking, and user settings in a clean tab-based approach.

## Game Screenshots and Play Guide

### Tap Frenzy
**Game Screenshot**

**Game Over View**

**Small Overview**
Tap Frenzy is a speed tapping game where you score points by tapping as many times as possible before the timer ends.

**How to Play**
- Tap the main button quickly to increase your score.
- Keep tapping until the countdown reaches zero.
- Check your final score on the game over screen.

### Quick Tap
**Game Screenshot**

**Game Over View**

**Small Overview**
Quick Tap tests reaction speed by asking you to tap at the right moment and maintain accuracy.

**How to Play**
- Start the round and watch the timer.
- Tap when required and avoid missing chances.
- Complete the round and review your score at the end.

### Quiz Rush
**Game Screenshot**

**Game Over View**

**Small Overview**
Quiz Rush is a fast quiz mode where you answer questions within a limited time to earn points.

**How to Play**
- Read each question quickly.
- Select the correct answer before time runs out.
- Finish all questions and view your result on the end screen.

## Architecture Overview
- **Pattern:** MVVM (Models, ViewModels, Views)
- **UI:** SwiftUI views organized by feature
- **State:** App flow and game state handled through observable view models
- **Services:** Separate services for session storage, location permission, and notifications

## Feature List
- Splash and onboarding-style permission flow
- Home dashboard with game access
- Multiple mini-games:
  - Tap Frenzy
  - Quick Tap
  - Quiz Rush
- Session and score tracking
- Stats view with summaries/charts
- Settings for notification reminder time
- Daily local gameplay reminder notification

## Known Limitations
- Uses only local notifications (no remote push support)
- Notification behavior may differ slightly between simulator and real device
- Limited advanced analytics/history for game sessions
- UI and game logic are designed for class assessment scope (not production scale)

## Reflections
This project helped me practice structuring a SwiftUI app using MVVM and separating concerns across features. I improved handling permissions, local notifications, and state-driven navigation. If extended further, I would improve test coverage, polish game balancing, and refine UI responsiveness across more device sizes.
