# App Specification: Kids Sound Guessing Game

## 1. General Overview
- **App Type:** Educational mobile game for kids (ages 3–6).
- **Core Concept:** "Guess the Sound". The child hears a sound and must guess what object produces it, then reveals the answer.
- **Platform:** Flutter (iOS & Android).
- **Language:** Dart.

## 2. Design System & UI
- **Visual Style:** Child-friendly but balanced (not overly neon/bright).
- **Color Palette:**
  - Background: Cream/Soft color (`0xFFFFF9E1`) with a subtle sound-related pattern (e.g., music notes, waves).
  - Primary Buttons: Orange (`0xFFFF9F29`) or similar distinct color.
  - Placeholder: White rounded square (`0xFFFFFFFF`).
- **Typography:** Rounded, readable font (e.g., 'Fredoka One').
- **Assets Structure:**
  - Images: `assets/images/[name].png`
  - Sounds: `assets/sounds/[name].mp3`
  - Naming Convention: Filenames must match (e.g., `car.png` and `car.mp3`).

## 3. Screen 1: Home Screen (Start)
- **Layout:** Centralized layout.
- **Elements:**
  - Game Logo/Title (Top).
  - Large "Start Game" button (Center).
- **Action:** Tapping "Start Game" navigates to the *Game Screen*.

## 4. Screen 2: Game Screen (Main Logic)
This screen handles the core gameplay loop.

### UI Elements
1.  **Top Bar:**
    - Right Corner: "Home" icon button (Navigate back to *Home Screen*).
2.  **Center Area (The Mystery):**
    - **State A (Guessing):** Shows a white container with rounded corners and a large Question Mark icon/image.
    - **State B (Revealed):** Shows the actual image of the object (e.g., `car.png`).
3.  **Bottom Area (Controls):**
    - **Button 1 (Left):** "Repeat Sound" (Icon: Speaker/Play).
    - **Button 2 (Right):**
        - Text in State A: "Show Answer" (or "Check").
        - Text in State B: "Next" (Arrow icon).

### Gameplay Logic (State Machine)
1.  **Initialization:**
    - When the screen loads, the first item is selected.
    - **Auto-play:** The sound for the current item plays automatically immediately upon loading.
2.  **Interaction - Repeat Sound:**
    - Tapping "Repeat Sound" plays the audio file again.
3.  **Interaction - Show Answer:**
    - User taps "Show Answer".
    - **State Change:** The Question Mark placeholder is replaced by the actual image (`[item].png`).
    - **Button Change:** The "Show Answer" button text changes to "Next".
4.  **Interaction - Next:**
    - User taps "Next".
    - **State Change:**
        - Current item index increments.
        - View resets to **State A** (Question Mark placeholder).
        - "Next" button reverts to "Show Answer".
    - **Auto-play:** The NEW sound plays automatically.

## 5. Data Model
The app should use a list of objects to manage the game data.
Example structure:
```dart
class GameItem {
  final String id;    // e.g., "car"
  final String image; // "assets/images/car.png"
  final String audio; // "assets/sounds/car.mp3"
}