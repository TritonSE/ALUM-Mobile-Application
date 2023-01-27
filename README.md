## Frontend
### Tools needed
- **Xcode** - Install from App Store

### Organisation
```bash
src/
├── Components/*
├── Models/* (Data Models for frontend goes here)
├── Views/* (Views that the user will interact with)
├── ViewModels/* (Business Logic pertaining to Views)
├── Services/* (Logic related to external communication like API calls)
└── ALUMApp.swift (Entry-point for the app)
```

Once Xcode is installed, double-click ALUM.xcodeproj to open the frontend in Xcode

### Linting
To lint our frontend codebase, we have SwiftLint setup on the github workflow.

Often times, SwiftLint will show errors that can be fixed automatically. To fix those, you need to have swiftlint setup locally. 
1. Install SwiftLint by following the README at https://github.com/realm/SwiftLint (I used brew install but any should work). 
2. To run swiftlint, use:
```swiftlint lint --strict```
3. To fix swiftlint errors, use:
```swiftlint lint --strict --fix```
4. After running with fix, make sure to run lint again in case there are some errors that cannot be fixed automatically.

## Backend
### Tools needed
- [Postman](https://www.postman.com/) - Used to test API endpoints manually

### Setup
To get started, open a terminal and cd into the `backend/` directory using 
```
cd backend
```

Install all backend dependencies using 
```
npm install
```

Place `.env` file inside the `backend/` directory. 
You can find the `.env` file in our slack channel. 

Now, you are all set to start backend development. Open up VSCode and get started!

### How to run the server?
Following command runs the server at localhost:3000
```
npm run dev
```
By running this, you will be able to see any routes you create.

### Linting
Code styling goes a long way towards writing readable code. Our PR's enforce code styling using lint checkers.

To run the lint tests locally, use:
```
npm run lint-check
```

Some lint errors can be automatically fixed. To do so, run:
```
npm run lint-fix
```
If your PR is failing lint check, use these commands!

### Organisation
```bash
src/
├── models/* (DB models to interact with the database)
├── services/* (Methods that utilizes models to perform operations on DB. Logic of the backend )
├── routes/* (Exposes the various services to the clients using endpoints)
└── app.ts (Main script to run the server and use routes)
```