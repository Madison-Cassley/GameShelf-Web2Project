[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/Vlt79NOB)
# GameShelf

## 1. Description
Game Library Tracker is a lightweight MVC web app for gamers to catalog their PC/console/mobile titles and record play sessions. Each user can:

- **Build** a personal library of games (title, platform).  
- **Log** each play session with date, duration, and quick notes (with editing possibilities).
- **Review** their play history per game to see when and how long they’ve played.  

This app solves the “lost‑track” problem: gamers often forget which games they own, how far they got, or what strategies they tried. By centralizing your game list and session notes, you get clear visibility into your play habits and progress.

---

## 2. Requirements

#### Authentication & User Management
- As a user, I want to **register** for an account so my data stays private.  
- As a user, I want to **log in** and **log out** so only I can see and edit my library.

#### Game Library
- As a user, I want to **add** a new game (title, platform) to my library.  
- As a user, I want to **view** all games in a list, showing title and platform.
- As a user, I want to have the option to **view** a specific game in my list.
- As a user, I want to **edit** a game entry if I’ve made a mistake.
- As a user I want to **delete** a game entry if I don't want it.
- As a user I want to be able to mark a game as **finished** once I am finished with it or its completed.

#### Play Sessions
- As a user, I want to **log a play session** for a game (date, playtime, notes).  
- As a user, I want to **see all sessions**
- As a user, I want to be able to **filter** my sessions by game or date. 
- As a user, I want to **edit** a session entry if I made a mistake.
- As a user, I want to **delete** a session entry if don't want to see it anymore
- As a user, I want to mark a play session as **done** once I am no longer playing.
- As a user, I want my current play session to be displayed at the top so its easy to access.

---
## 3. Entity Relationships
![EntityRelationships](./images/EntityRelationships.png)
---
## 4. API Routes
| Request                              | Action                                 | Response                          | Description                                               |
|--------------------------------------|----------------------------------------|-----------------------------------|-----------------------------------------------------------|
| **GET** `/register`                  | `AuthController.showRegisterForm`      | `200` + `auth/register` view      | Show the user registration form.                          |
| **POST** `/register`                 | `AuthController.register`              | `302 → /games`                    | Create a new user, start session, redirect to game list.  |
| **GET** `/login`                     | `AuthController.showLoginForm`         | `200` + `auth/login` view         | Show the login form.                                      |
| **POST** `/login`                    | `AuthController.login`                 | `302 → /games`                    | Authenticate credentials, start session, redirect.        |
| **POST** `/logout`                   | `AuthController.logout`                | `302 → /login`                    | End session, redirect to login.                           |
| **GET** `/games`                     | `GameController.index`                 | `200` + `games/index` view        | List all games in the user’s library.                     |
| **GET** `/games/new`                 | `GameController.new`                   | `200` + `games/new` view          | Show the “add new game” view.                             |
| **POST** `/games`                    | `GameController.create`                | `302 → /games/:id`                | Create a game entry, redirect to its detail page.         |
| **GET** `/games/:id`                 | `GameController.show`                  | `200` + `games/show` view         | Show details for one game and its play sessions.          |
| **GET** `/games/:id/edit`            | `GameController.edit`                  | `200` + `games/edit` view         | Show the “edit game” view.                                |
| **PUT** `/games/:id`                 | `GameController.update`                | `302 → /games/:id`                | Update game metadata, redirect back to its detail page.   |
| **POST** `/games/:id/delete`         | `GameController.delete`                | `302 → /games`                    | Delete the game (and associated sessions), redirect list. |
| **GET** `/games/:gameId/sessions/new`| `SessionController.new`                | `200` + `sessions/new` view       | Show the form to log a new play session for a game.       |
| **POST** `/games/:gameId/sessions`   | `SessionController.create`             | `302 → /games/:gameId`            | Create a play session, redirect to game’s detail page.    |
| **GET** `/sessions/:id/edit`         | `SessionController.edit`               | `200` + `sessions/edit` view      | Show the form to edit an existing play session.           |
| **PUT** `/sessions/:id`              | `SessionController.update`             | `302 → /games/:gameId`            | Update a session entry, redirect to its game’s detail.    |
| **POST** `/sessions/:id/delete`      | `SessionController.delete`             | `302 → /games/:gameId`            | Delete a session entry, redirect back to game’s detail.   |
---
## 5. Wireframes
![WireFrames](./images/WireFrames.png)
---
## 6. Test Cases (IDs for myself so I can check them off a Todo List)
### Authentication & User Management

| ID       | Scenario                        | Steps                                                                                  | Expected Result                                                  |
|----------|---------------------------------|----------------------------------------------------------------------------------------|------------------------------------------------------------------|
| Auth-01  | Register with valid info        | Fill Username and password with valid data                                          | 302 → new user exists in DB; session started                     |
| Auth-02  | Register with missing fields    | Leave “password” and/or "email" blank and submit                                    | 200 + form view; validation error “Password is required”         |
| Auth-03  | Register with duplicate email   | Use an email already in DB                                                          | 200 + form view; error “Email already taken”                     |
| Auth-04  | Login with valid credentials    | Enter correct email + password                                                      | 302 → session started                                            |
| Auth-05  | Login with invalid credentials  | Enter wrong password and submit                                                     | 200 + form view; error “Invalid credentials”                     |
| Auth-06  | Logout                          | “Logout” Follow redirect                                                            | 302 → session destroyed                                          |

### Game Library

| ID       | Scenario                         | Steps                                                                                     | Expected Result                                                   |
|----------|----------------------------------|-------------------------------------------------------------------------------------------|-------------------------------------------------------------------|
| Game-01  | Add a new game with valid data   | Enter Title and platform                                                                  | 302 → game appears in `/games` list                               |
| Game-02  | Add game with missing data       | Leave “Title” and/or "Platform" blank and submit                                          | 200 + `games/new` view; validation error “Title is required”      |
| Game-03  | View games list                  | Add several games and then go to list all games                                           | List shows all titles + platforms                                 |
| Game-04  | View single game detail          | Click on a game                                                                           | `/games/:id` shows game info and its (initially empty) sessions   |
| Game-05  | Edit a game                      | Edit: Change Platform to “Switch”. Submit                                                 | 302 → `/games/:id`; platform updated                              |
| Game-06  | Delete a game                    | Click “Delete” on a game. Confirm                                                         | 302 → `/games`; game no longer in list; its sessions gone         |
| Game-07  | Mark game as finished            | Click “Finished” toggle                                                                   | Game status shows “Finished”                                      |

### Play Session

| ID        | Scenario                               | Steps                                                                                     | Expected Result                                                   |
|-----------|----------------------------------------|-------------------------------------------------------------------------------------------|-------------------------------------------------------------------|
| Sess-01   | Log a valid session                    | Create a New Play Session using "create new"                                              | 302 → `/games/:id`; session appears in list                      |
| Sess-02   | Log session with invalid data          | Leave game/duration blank                                                                 | 200 + `sessions/new` view; validation error “Duration must be ≥0” |
| Sess-03   | Edit a session                         | Edit Session Notes                                                                        | 302 → `/games/:id`; notes updated                                 |
| Sess-04   | Delete a session                       | Click “Delete” on a session. Confirm                                                      | 302 → `/games/:id`; session removed                               |
| Sess-05   | Filter sessions by date                | Set date range filter. Apply                                                              | Only sessions within date range are shown                         |
| Sess-06   | Filter sessions by game                | Select a game filter. Apply                                                               | Only sessions for that game are shown                             |
| Sess-07   | Mark session as done                   | Click “Done” toggle for a session                                                         | Session status updated to “Done”                                  |
| Sess-08   | Current session displayed at top       | Add two sessions. Leave one “in progress”. Visit `/games/:id`                             | In-progress session appears at top of the list                    |

### Entity Relationships & API Contracts

| ID      | Scenario                                  | Steps                                                                            | Expected Result                                               |
|---------|-------------------------------------------|----------------------------------------------------------------------------------|---------------------------------------------------------------|
| ER-01   | Deleting a game deletes sessions         | 1. Add game + two sessions. Delete game via                                       | All sessions for that game are removed from the database      |
| ER-02   | Creating session for non-existent game   | 1. Enter a Game title that isn't in the "games"                                   | 404 or error “Game not found”                                 |

### Edge & Negative Cases

- **Duplicate game entries**  
  Try adding the same title/platform twice → expect either prevention 

- **Very long notes**  
  Enter >5000 chars (limit TBD) in session notes → test DB/truncation behavior.

- **Invalid routes/methods**  
  GET `/games/:id/delete` → should 404 or reject (only POST allowed).

- **Session date in the future**  
  Log a session date beyond today 

- **Simultaneous “current” sessions**  
  Attempt to mark two sessions as in-progress → verify UI handles conflicts.

---
## Possible Implementations (if time permits)
- Cover Images for games (added as a string url to the games table)
---
## Extra Content
### Logo (Made with Canva)
![Logo](./images/Logo-GameShelf.png)
