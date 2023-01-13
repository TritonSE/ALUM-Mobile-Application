## Frontend
### Tools needed
- **Xcode** - Install from App Store

Once Xcode is installed, double-click ALUM.xcodeproj to open the frontend in Xcode

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