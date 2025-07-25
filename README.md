# DEPI Program Schedule - README

[DEPI Program Schedule](DEPI-schedule.html)

## Overview

The DEPI Program Schedule is a modern, responsive web application that displays a detailed schedule for the DEPI Graduates Program (Round 3). It features dynamic progress tracking, color-coded session types, and a seamless light/dark mode toggle.

## Features

- **Dynamic Progress Tracking**: Real-time calculation of program progress based on current date
- **Color-Coded Sessions**: Each session type has a distinct color scheme
  - Technical Sessions (Blue)
  - Skills for Freelancing (Green)
  - Freelancing (Light Green)
  - Coaching (Orange)
  - English for Freelancing (Yellow)
  - Project Work (Purple)
- **Light/Dark Mode**: Toggle between themes with one click
- **Current Week Highlighting**: Automatically highlights the current week
- **Responsive Design**: Works on all device sizes
- **Comprehensive Legend**: Clear visual indicators for all elements
- **Program Statistics**: Shows weeks completed and remaining

## Technology Stack

- **Frontend**: HTML5, CSS3, JavaScript (ES6)
- **Icons**: Font Awesome 6
- **Design**: CSS Variables, Flexbox, Grid
- **Responsiveness**: Media Queries

## Getting Started

To run this project locally, simply:

1. Download the HTML file
2. Open it in any modern web browser
3. No additional dependencies required

## Usage

1. **Toggle Theme**: Click the circular button at the top right to switch between light and dark modes
2. **View Progress**: See program completion percentage and weeks completed/remaining
3. **Navigate Schedule**: Scroll through the interactive schedule table
4. **Identify Sessions**: Use the legend to understand color coding and indicators

## Key Components

### 1. Program Information Cards
- Program Duration
- Weekly Schedule
- Program Focus

### 2. Progress Tracking
- Visual progress bar
- Percentage completed
- Weeks statistics

### 3. Interactive Schedule
- Color-coded session types
- Physical vs online indicators
- Milestone markers
- Current week highlighting

### 4. Comprehensive Legend
- Session types
- Location indicators
- Status markers

## Code Structure

```plaintext
DEPI-schedule.html
├── CSS Styles
│   ├── Theme Variables (Light/Dark)
│   ├── Responsive Design
│   ├── Session Type Colors
│   └── Animations & Transitions
├── HTML Structure
│   ├── Header with Theme Toggle
│   ├── Program Information Cards
│   ├── Progress Tracking Section
│   ├── Interactive Schedule Table
│   └── Comprehensive Legend
└── JavaScript
    ├── Theme Switching Logic
    ├── Progress Calculation
    ├── Current Date Handling
    └── Schedule Generation
```

## Customization

To modify the program dates or content:
1. Update the `programStart` and `programEnd` dates in the JavaScript section
2. Modify the `scheduleData` array to change session content
3. Adjust color variables in the `:root` and `.dark-mode` sections to change the color scheme

