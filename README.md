## Frontend - iOS app
### Tools needed
- **Xcode** - Install from App Store

### Organization
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

## Frontend - Admin Portal
### Tools needed
N/A

### Organization
```bash
src/
└── app/* (Structure of this directory matches the built in router nextJS has)
    └── (authorized)/* (Screens accessible only after user auth is done)
        ├── mentees (Mentee table will go here)
        ├── mentors (Mentor table will go here)
        ├── sessions (Sessions table goes here)
        └── layout.tsx (shared layout by all pages in (authorized))
    └──  login (Login page goes here)
├── components (all shared components will go here)
├── icons (lot of images are svgs and changing svg is much easier in React format than svg format)
└── styles (CSS modules for all Pages go here)
```

### Setup & Run
To setup, `cd admin-portal` and then do npm install.
To run, use `npm run dev` 

### Linting
Run lint using `npm lint`

## Backend
Documentation - https://documenter.getpostman.com/view/18831621/2s93XsXm5B
### Tools needed
[Postman](https://www.postman.com/) - Used to test API endpoints manually. 

### Postman setup
We have a Postman collection setup for all our routes. 

1. Just click on this button and either "Fork Collection" (recommended) OR "View collection". 

[![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/18831621-b16db8a4-a9c6-4d09-9b34-9a3434a4e212?action=collection%2Ffork&collection-url=entityId%3D18831621-b16db8a4-a9c6-4d09-9b34-9a3434a4e212%26entityType%3Dcollection%26workspaceId%3Db962d7f5-c39d-4b7a-90ff-51c554da3711#?env%5BALUM%5D=W3sia2V5IjoiQVBJX1VSTCIsInZhbHVlIjoiaHR0cDovLzEyNy4wLjAuMTozMDAwIiwiZW5hYmxlZCI6dHJ1ZSwidHlwZSI6ImRlZmF1bHQiLCJzZXNzaW9uVmFsdWUiOiJodHRwOi8vMTI3LjAuMC4xOjMwMDAiLCJzZXNzaW9uSW5kZXgiOjB9LHsia2V5IjoiTUVOVE9SX0JFQVJFUl9UT0tFTiIsInZhbHVlIjoiIiwiZW5hYmxlZCI6dHJ1ZSwidHlwZSI6InNlY3JldCIsInNlc3Npb25WYWx1ZSI6ImV5SmhiR2NpT2lKU1V6STFOaUlzSW10cFpDSTZJamczWXpGbE4yWTRNREF6TkdKaVl6Z3hZamhtTW1SaU9ETTNPVEl4WmpSaVpESTROMll4WkdZaUxDSjBlWEFpT2lKS1YxUWlmUS5leUp5YjJ4bElqb2liV1Z1ZEc5eUlpd2lhWE56SWpvaWFILi4uIiwic2Vzc2lvbkluZGV4IjoxfSx7ImtleSI6Ik1FTlRFRV9CRUFSRVJfVE9LRU4iLCJ2YWx1ZSI6IiIsImVuYWJsZWQiOnRydWUsInR5cGUiOiJzZWNyZXQiLCJzZXNzaW9uVmFsdWUiOiJleUpoYkdjaU9pSlNVekkxTmlJc0ltdHBaQ0k2SWpnM1l6RmxOMlk0TURBek5HSmlZemd4WWpobU1tUmlPRE0zT1RJeFpqUmlaREk0TjJZeFpHWWlMQ0owZVhBaU9pSktWMVFpZlEuZXlKeWIyeGxJam9pYldWdWRHVmxJaXdpYVhOeklqb2lhSC4uLiIsInNlc3Npb25JbmRleCI6Mn0seyJrZXkiOiJHT09HTEVfQVBJX0tFWSIsInZhbHVlIjoiIiwiZW5hYmxlZCI6dHJ1ZSwidHlwZSI6ImRlZmF1bHQiLCJzZXNzaW9uVmFsdWUiOiJBSXphU3lCaTNRYkdMOFVrVEI1dHhtSHl2c05aUHRmQV9vaV9qMVEiLCJzZXNzaW9uSW5kZXgiOjN9XQ==)

2. Next, setup the variable environment using the video tutorial linked - https://drive.google.com/file/d/1y1TsyelzPby0q7eyMPXuYSbsWRod6NdQ/view?usp=share_link
Note: The `ALUM.postman_environment.json` imported in the video can be found in the root of the repository

3. At this point, you should be able to run the requests on the collection (ones protected by auth too)
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

### Organization
```bash
src/
├── models/* (DB models to interact with the database)
├── services/* (Methods that utilizes models to perform operations on DB. Logic of the backend )
├── routes/* (Exposes the various services to the clients using endpoints)
└── app.ts (Main script to run the server and use routes)
```

### Auth Layer and Roles
The backend uses the firebase authentication and custom user claims to protect routes. Custom user claims are essentially roles and we use three: mentor, mentee, and admin. Outside of protecting the routes, the auth layer can also be used to determine who is accessing the route (mentor, mentee, admin, etc.). Reference the [Firebase API](https://firebase.google.com/docs/reference/rest/auth) for more information on how the auth layer works.

### How to deploy?

#### Backend
We use the firebase to host our backend. Firebase has a feature called Cloud Functions which basically runs our server to process requests whenever one is received. This required Firebase Blaze Plan which is a "pay as you go". Judging from the scope of this, we should always be able to be under the free tier. 

Before you deploy, you should login into firebase using firebase CLI by running the following commands.
Note - You only need to do this once
```
npm i -g firebase-tools
firebase login
```

To deploy backend, simply run the following command
```
npm run deploy
```

Before deploying you can test out the server by simulating the deployment using
```
npm run local-deploy
```
This runs your server locally. 

#### Frontend 
All app releases are done through the [Apple Connect Portal](https://appstoreconnect.apple.com/). 

Till now we have only released testflight. You can checkout this tutorial on how to release a test flight - [video](https://www.youtube.com/watch?v=DLvdZtTAJrE)
