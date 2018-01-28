# MTG Collection

## Environment setup

    Docker is required to be installed.

Setup local dockerized environment with:

`bin/dock setup`

## Starting the server

The server can be started with:

`docker-compose up`

Or, if the database service is running (`docker-compose up -d db`)

`bin/dock server`

## Migrations

Create a migration using:

`bin/dock generate-migration <name>`

To migrate database:

`bin/dock migrate`

To migrate database to a version:

`bin/dock migrate -M <version>`

To migrate test database:

`bin/dock migrate-test`

## Specs

Run spec suite with:

`bin/dock rspec`

## Heroku deployment

Push to the heroku instance:

`$ heroku git:remote -a <app-name> -r <remote-name>`

Run the migrations:

`$ heroku run --remote=<remote-name> bin/migrate-db`

Create a user:

```
$ heroku run --remote=<remote-name> bundle exec rack-console
> Services::Users::Create.perform(username: '...', password: '...')
```

## Thanks

Nothing of this could have been possible without the following tools:

- [Deckbox](https://deckbox.org/) An awesome place to store your library.
- [MTG Manager](http://mtgmanager.online/) Scan MTG Cards with your phone.
- [Decked Builder](http://www.deckedbuilder.com/) This one is also available
 for Windows!
- [MTGJson](http://mtgjson.com/) The MTG Database. In json!
- [Keyrune](https://andrewgioia.github.io/Keyrune/index.html) MTG Set symbols
 in a font.
- [Mana Icons](https://andrewgioia.github.io/Mana/icons.html) MTG Mana icons
 in a font.
- [These people](https://www.slightlymagic.net/forum/viewtopic.php?f=15&t=4430&sid=a4157beb902583b681496f74398d506e)
  at slightlymagic.

Mana and cards symbols, names and stuff might be (are) owned by
 [Wizards of the Coast](http://magicthegathering.com/), so, you know.
