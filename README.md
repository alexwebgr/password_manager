# Password manager

### Task
Your task is to create a single page app for uploading user data. 

### Requirements
The app must implement the following functionality.

There is only one entity, a user, which has the following two attributes:
* name - this is a required attribute
* password - this is required and must be "strong"

A password is considered "strong" if all of the following conditions are met:
* It has at least 10 characters and at most 16 characters.
* It contains at least one lowercase character, one uppercase character and one digit.
* It cannot contain three repeating characters in a row (e.g. "...zzz..." is not strong, but "...zz...z..." is strong, assuming other conditions are met).

For example, the following passwords are "strong":
* Aqpfk1swods
* QPFJWz1343439
* PFSHH78KSM

And the following passwords are not "strong":
* Abc123 (this is too short)
* abcdefghijklmnop (this does not contain an uppercase character or a digit)
* AAAfk1swods (this contains three repeating characters, namely AAA)

### User data upload flow

* When I visit the homepage of the website, I can upload a CSV file of names and passwords (this is all that I can do when I visit the homepage).
* After uploading the CSV file, I see the results of the uploaded CSV.
* For each row in the CSV file, the system will attempt to create a User in the database and display the result of each row on the homepage

  * If a row leads to a valid User, then the User is saved and the result for this row is a success.
  * If a row leads to an invalid User, the User should not be saved and an error should be shown in the results on the website. 
   If the password provided is not strong, then the minimum number of character changes required to make it a strong password must be displayed on the website. 
   Insertion, deletion or replacement of any one character is considered one change.

For example, uploading the attached CSV file should result in one user being saved to the database and the following result being displayed:

    Muhammad was successfully saved

    Change 1 character of Maria Turing's password

    Change 4 characters of Isabella's password

    Change 5 characters of Axel's password