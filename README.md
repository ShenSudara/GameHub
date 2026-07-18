# T. A. A. Sudaraka
**Index:** COBSCCOMP242p-037

## GameHub
A simple iOS game app built with SwiftUI. This project includes multiple mini-games, basic stats tracking, and user settings in a clean tab-based approach.

## Game Screenshots and Play Guide
<table align='center'>
  <tr>
    <td><img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-07-18 at 08 22 58" src="https://github.com/user-attachments/assets/6cbf6c51-e236-4829-8abe-ff157d29b0ba" /></td>
  <td><img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-07-18 at 08 24 02" src="https://github.com/user-attachments/assets/13229929-fcb9-4931-ba25-4cf82735f12d" /></td>
  <td><img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-07-18 at 08 25 34" src="https://github.com/user-attachments/assets/e55e6071-7f6f-426b-b1c5-ba2ace48366b" /></td>
  </tr>
</table>

### Tap Frenzy
**Game Overview**
<table>
  <tr>
    <td><img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-07-18 at 08 41 11" src="https://github.com/user-attachments/assets/ac8d2641-13a7-4741-a662-b197ce680d69" /></td>
    <td><img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-07-18 at 08 44 57" src="https://github.com/user-attachments/assets/2b8be403-0b2a-4b17-8746-55e6a15e43d1" /></td>
  </tr>
</table>

**Small Overview**
Tap Frenzy is a speed tapping game where you score points by tapping as many times as possible before the timer ends.

**How to Play**
- Tap the main button quickly to increase your score.
- Keep tapping until the countdown reaches zero.
- Check your final score on the game over screen.

### Quick Tap
**Game Overview**
<table>
<tr>
  <td><img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-07-18 at 08 49 43" src="https://github.com/user-attachments/assets/0667a05a-7b7b-46c9-8c02-70ce0c7e6b41" /></td>
  <td><img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-07-18 at 08 53 49" src="https://github.com/user-attachments/assets/0e32681e-ae99-44e9-85cc-57dc2dfdb737" /></td>
</tr>
</table>

**Small Overview**
Quick Tap tests reaction speed by asking you to tap at the right moment and maintain accuracy.

**How to Play**
- Start the round and watch the timer.
- Tap when required and avoid missing chances.
- Complete the round and review your score at the end.

### Quiz Rush
**Game Overview**
<table>
  <tr>
    <td><img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-07-18 at 09 02 35" src="https://github.com/user-attachments/assets/00f900a3-bb81-45d2-ba92-4c44cd230db1" /></td>
    <td><img width="1206" height="2622" alt="Simulator Screenshot - iPhone 17 Pro - 2026-07-18 at 09 02 46" src="https://github.com/user-attachments/assets/20e3fe3c-aba6-41b8-a08d-728bde265013" /></td>
  </tr>
</table>

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
