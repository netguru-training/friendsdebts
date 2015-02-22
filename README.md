# FriendsDebts
FriendsDebts is an app created during Netguru workshops on 21 and 22 February 2015. App let you track and menage of debts between you, your friends and family, so you always know how much money they owe you or you owe them.

### How to setup:
Clone our repository: `git clone https://github.com/netguru-training/friendsdebts.git`

Copy the database config file and aplication config file: 

` cp config/database.yml.example config/database.yml`

` cp config/application.yml.example config/application.yml`

Setup database using `rake db:setup` and add a new app on your facebook develper site. After that fill in application.yml with proper value.

### Features
* Sing up via email or Facebook account
* Creating groups and adding members
* Adding recipes to group, in every recipe you can specify users from this group.
* Checking balance of each user in your group, basing on recipe which you share.
* Balancing user debt
* Email notification after balance or add new recipe
* History of debts

### Spec
To run spec run `rspec spec`

### Contributors 
[Katarzyna Kobierska](https://github.com/kradydal)

[Przemysław Fałowski](https://github.com/przemkow)
