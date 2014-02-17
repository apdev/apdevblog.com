---
layout: post
title: "salt'n'pepper - or how to store passwords securely"
date: 2014-02-17 12:00:00 +0100
author: Phil
comments: true
categories: 
  - web development
  - security
---
Just yesterday I received an email from [kickstarter][1] telling me that their database
servers were hacked and that someone was able to access all my account data: 

> Accessed information included usernames, email addresses, mailing addresses, phone numbers, and encrypted passwords. Actual passwords were not revealed, [...]

Good to know, that they didn't store the password in plain text but encrypted the
most sensitive data.

You see, in today's world it is very important to make sure that an attacker,
after aquiring your user data, isn't able to just know you password and:

1) log into your account  
2) more importantly - use the password for other services with which he/she
could really "harm" you

> [...] however it is possible for a malicious person with enough computing power to guess and crack an encrypted password, particularly a weak or obvious one.

That's true - even when using encryption. So, we as developers have to make sure
that this process of "computing" or "guessing" takes as long as possible (and has to be repeated for every password). 

I can remember my first attemps at server-side user-management with PHP 13-14 years 
ago. I just stored the user's data like this:

<pre>
----------------------
| user | password    |
----------------------
| phil | topsecret   |
| aron | notsosecret |
----------------------
</pre>

The user sent the data via `POST` to the server where I would compare the password he/she just entered with the password stored inside my database like this:

<pre>
// don't do this
if ($_POST["password"] === $row["password"]) {
  // grant access ...
}
</pre>

If the user ever forgot his/her password, I could just get it from the DB and resend it via email :( - a really bad idea! But back in the days I didn't know better.

**Rule #1**  
Never save passwords in plain text

Use a [hash function][2] to store the password securely. Hash functions are one-way
algorithms that turn your plain text password into a totally unrecognizable number
and letter combination. Plus they produce results that differ completely even if
the input is almost the same.

_The following snippets are JavaScript because our last project was a node.js
project - but these functions are available in other programming languages as
well._

{% gist 9048021 sha256.js pkyeck %}

You get the idea ...

But this is not enough. If we save the once hashed password into the DB, hackers
can use methods like "[dictionary][3]"-, "[brute force][4]"-attacks, [lookup][5]- or
[rainbow-tables][6] to "guess" your password. It'll take some time, but they will get
there - and even faster if the original password only contains letters from a-z.

**Rule #2**  
Salt your password before saving it

Hashing function always produce the same result if the input is the same. You 
can run the code above as many times as you like, the result won't change.  
Two users with the same password would get the same hash, which makes it easier
for an attacker because he/she can use lookup- or rainbow-tables to "decrypt" 
your password.

Appending a **random** string (a [salt][7]) to the password makes this impossible.

_I don't know if they still do, but in a previous version wordpress used the 
hashed `SITE_URL` as a salt for every password - not good. You can do better 
than that._

Create a new salt everytime you store a password in the database - never reuse
an old one. And don't make the salt to short. It gets harder to hack the longer 
the salt is.

<pre>
var crypto = require("crypto");
var salt = crypto.randomBytes(64);
</pre>

If you don't use the same salt for every password, you have to store the salt in
the database as well. Either in a seperate column or add it to the password as 
"metadata".

<pre>
------------------------------------------
| user | password                        |
------------------------------------------
| phil | &lt;hashed password + salt&gt;:&lt;salt&gt; |
| aron | &lt;hashed password + salt&gt;:&lt;salt&gt; |
------------------------------------------
</pre>

Salting the passwords prevents hackers from using lookup-tables to gain access 
to your passwords **quickly** but with up-to-date hardware they can use "brute force"
to generate billions of hashes a second and compare them with the hashes you
stored in the database.

**Rule #3**  
Use "slow" hash functions

This may sound strange but another method to make sure it'll take attackers more
time to hack the passwords is to use an encryption algorithm that takes it time 
to produce a result. This reduces the number of hashes a hacker can generate to 
a fraction of the number above.

[PBKDF2][8] is a good choice for this.

Storing the encrypted password

{% gist 9047805 storing.js pkyeck %}

Retrieving the encrypted password

{% gist 9047805 retrieving.js pkyeck %}

Hope this summary helps and makes your next project a bit more secure (than it already is).


  [1]: https://www.kickstarter.com/
  [2]: http://en.wikipedia.org/wiki/Hash_function
  [3]: http://en.wikipedia.org/wiki/Dictionary_attack
  [4]: http://en.wikipedia.org/wiki/Brute-force_attack
  [5]: http://en.wikipedia.org/wiki/Lookup_table
  [6]: http://en.wikipedia.org/wiki/Rainbow_table
  [7]: http://en.wikipedia.org/wiki/Salt_(cryptography)
  [8]: http://en.wikipedia.org/wiki/PBKDF2