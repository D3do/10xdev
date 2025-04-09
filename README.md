# 10x Vibe Travels

## Table of Contents
- [Project Description](#project-description)
- [Tech Stack](#tech-stack)
- [Getting Started Locally](#getting-started-locally)
- [Available Scripts](#available-scripts)
- [Project Scope](#project-scope)
- [Project Status](#project-status)
- [License](#license)

## Project Description
10x Vibe Travels is an innovative application that helps users quickly transform loose travel ideas into detailed, engaging, and personalized travel itineraries. Leveraging AI, the application analyzes user inputs such as travel notes, interests, and dates to generate comprehensive travel plans complete with daily itineraries, recommended activities, and personalized suggestions.

## Tech Stack
- **Frontend:**
  - Astro 5
  - React 19
  - TypeScript 5
  - Tailwind CSS 4
  - Shadcn/ui
- **Backend:**
  - Supabase (PostgreSQL, authentication)
- **AI Integration:**
  - Openrouter.ai (supports multiple AI providers)
- **CI/CD & Hosting:**
  - GitHub Actions for CI/CD
  - DigitalOcean (via Docker images)

## Getting Started Locally
### Prerequisites
- **Node Version:** 22.14.0 (refer to the `.nvmrc` file)

### Installation
1. Clone the repository:
   ```bash
   git clone <repository-url>
   ```
2. Navigate to the project directory:
   ```bash
   cd 10x-vibe-travels
   ```
3. Install the dependencies:
   ```bash
   npm install
   ```

### Running the Development Server
Start the development server with the following command:
```bash
npm run dev
```

## Available Scripts
- `npm run dev` – Starts the Astro development server.
- `npm run build` – Builds the application for production.
- `npm run preview` – Previews the built application.
- `npm run astro` – Executes Astro commands.
- `npm run lint` – Runs ESLint on the project.
- `npm run lint:fix` – Automatically fixes linting issues.
- `npm run format` – Formats the codebase using Prettier.

## Project Scope
**MVP Features:**
- User registration and login.
- AI-driven itinerary generation based on user-input travel ideas.
- Editing and customization of generated travel plans.
- Secure management of personal travel itineraries.
  
## Project Status
This project is currently at the MVP stage. Future updates will enhance functionality and integrate additional features as outlined in the initial product requirements.

## License
This project is licensed under the MIT License.