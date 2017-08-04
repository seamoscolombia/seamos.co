# README

This README would normally document whatever steps are necessary to get the
application up and running.


Run the test suite
--------

Check for pending migrations and, and load the test schema:
```
bundle exec rake db:test:prepare
```

Use the `rspec` command to run your specs:

```
bundle exec rspec
```

By default the above will run all `_spec.rb` files in the `spec` directory.
To run only a subset of these specs use the following command:
```
# Run only model specs
bundle exec rspec spec/models

# Run only specs for AccountsController
bundle exec rspec spec/controllers/accounts_controller_spec.rb

# Run only spec on line 8 of AccountsController
bundle exec rspec spec/controllers/accounts_controller_spec.rb:8
```

Specs can also be run via `rake spec`, though this command may be slower to
start than the `rspec` command.

[# API endpoints](Link URL)

### Tags List:

**explanation**: This endpoint returns a JSON with the list of all tags.

**endpoint**: `GET /tags.json`

**Returned attributes**: id, name, tag_image


## Users 

### User Interests List:

**explanation**: This endpoint returns a JSON with the list of all tags and an extra atribute ( selected ) that is set to true of false; true if user has a related interest, false if user doesn't have a related interest.

**endpoint**: `GET /users/:user_id/tags`

**Returned attributes**: id, name, tag_image, selected

### User's Profile:

**explanation**: This endpoint returns a JSON with the necessary information for the user's profile view

**endpoint**: `GET /profile`

**Returned attributes**: id, full_name, interests_count, participations( count, polls), authenticity_token

## Polls

### Polls list:

** explanation **: This endpoint returns JSON with a list of all open polls were the user has not yet voted, arranged by vote count from major to minor 

**endpoint**: `GET /polls.json` 

**Returned attributes**: id, title, description, type

### Poll details:

** explanation **: This endpoint returns JSON with the poll details. 

**endpoint**: `GET /poll/:id.json` 

**Returned attributes**: id, title, description, type, objective, remaining, vote_count, links, politician


### Polls list by tag:

** explanation **: This endpoint returns JSON with a list of all open polls arranged by vote count from major to minor for a determined Tag. 

**endpoint**: `GET /tags/:tag_id/polls`

**Returned attributes**: id, title, description, type


### Polls list by politician:

** explanation **: This endpoint returns JSON with a list of all open polls arranged by vote count from major to minor that were created by a determined politician. 

**endpoint**: `GET /politician/:politician_id/polls` 

**Returned attributes**: id, title, description, type
