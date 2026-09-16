# Activity Tracker

A very simple Rails 8 webapp that lets you define "activities" and
tally when "engaging" with that activity per day.

I mostly built this tiny app to check out Vite and TailWindCSS, and also
have it deployed somewhere to help me track where I'm spending my time or
what things I haven't done for a while.

Activities can be anything, from a personal project to pending chores.
The idea is to count an "engagement" ocurrence when doing something
related to that activity. For example, if there's an activity like
"Project X", doing a task for that project counts as "engagement". The
sole rule is that each activity should only be counted once per day.

# Deploying

The project ships a `Dockerfile` and a `docker-compose.yml` file to
easily drop it anywhere. Registrations are disabled so users should
be added via console for the time being.

Create the stack:

Clone the project, copy `production.env.sample` onto a `production.env` file
and fill in with desired values. You can use postgres defaults for database.
Build the containers:

```bash
docker compose build
```

Generate new secrets:
```bash
docker compose run --rm web bin/rails secret
```

Finalize configs and ensure database is configured in the config file.
Run migrations:

```bash
docker compose run --rm web bin/rails db:prepare
```

Launch the console:
```bash
docker compose run --rm web bin/rails c
```

Generate a user:
```Ruby
User.create name: "Bob", email: "bob@example.com", password: "something"
```

Exit the console and then launch:
```bash
docker compose up -d
```

That should be it.

# Development

Included devcontainer to build up the development environment. Install
`devcontainer` and launch it with:
```bash
devcontainer up --workspace-folder .
```

The rest is handled through the dev container using the `devcontainer` commands.

For example to run the specs:
```bash
devcontainer exec --workspace-folder . bundle exec rspec spec
```
