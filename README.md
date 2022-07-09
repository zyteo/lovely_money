# lovely_money

Personal budget / expenses app.

## Description

Used a mobile app for budgeting many years ago. I thought the back up worked. I backed up once in a while.

One day, my phone crashed. Turns out, the back up never worked. When I tried to import the back up file, it was empty.

Yes, I'm looking at you, daily expenses 2 app. From that day, I never used such apps again. Back to manual for me.

Now, I believe I am decent enough to build my very own functional app from scratch doing what I want to do.

No rubbish. No ads. And the app can send the data as a CSV to my email.

### Accessing the Application

Developing with flutter means that this app technically works with multiple OS.

Windows, macOS, linux, android, iOS, yada yada.
But it's a personal app, and it's for personal use, so I won't go through the hassle of bringing it to Google playstore.

I'm also using the free version of firebase, and bringing it out to the masses might mean I have to scale things up and go for a paid version. I'm not sponsored, sorry.

I might limit the app and share it with a few other users, though any abuse of the app and I can rid the account muahaha...

### Video showing App features

### Technology Used

Technologies used to build this project.

```
- Flutter
- Firebase

```

### User story

```
To use the app, user should:

- Create an account with email + password
- Log in, set default details (currency, amount, debit/credit, name)

```

---

## Planning and Development Process

Models:

-Item list(string) example: FOOD, TRAVEL, GROCERIES, HEALTH, GIFT, TAXI, TRANSPORT

-Transaction: date, time, item from item list (string), currency, amount, comment, entry(credit/debit)

-Users: email (string), username (string), saved default details [item, price, currency, entry], item list

-Transactions --> email --> month --> list of transactions in an array

```
Timeline

- 14 May: Set up new flutter project.

- 15 May: Started planning for app.

- 18 May: Finally configured firebase stuff on flutter. Was more challenging than expected. Had to set up web version instead of flutter.

Got register screen up and working with firebase. Able to register a user.

- 19 May: Registering user now provides pre-configured values of 7 items and defaults.

Set up login function, but not accounting for wrong password/email etc yet.

- 4 Jun: Refine login function to account for wrong email / password cases.

Now register and login function are both fully complete and working.

Added datetime constants and created button for user to choose the date.

- 9 Jul: Adding more functions to the add a transaction button - adjusted date picker, added time picker, adjusted amount and comment fields.

Added another currencies code list to constants file so that a dropdown list can be used when adding transactions.

```

---

### MVP

- [x] Register
- [x] Login
- [ ] Homepage
- [ ] Settings
- [ ] Add Transaction