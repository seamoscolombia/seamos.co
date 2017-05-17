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

# API endpoints

### Tags List:

**explanation**: This endpoint returns a JSON with the list of all tags.

**endpoint**: `GET /tags.json`

**Returned attributes**: id, name, tag_image

### User Interests List:

**explanation**: This endpoint returns a JSON with the list of all tags and an extra atribute ( selected ) that is set to true of false; true if user has a related interest, false if user doesn't have a related interest.

**endpoint**: `GET /users/:user_id/tags`

**Returned attributes**: id, name, tag_image, selected

### Polls list by tag:

** explanation **: This endpoint returns JSON with a list of all polls arranged by vote count from major to minor for a determined Tag. 

**endpoint**: `GET /tags/:tag_id/polls`

**Returned attributes**: id, title, description, type



# COPY coldocuments (divipol_id, doc_num)  FROM 'pth to CSV' DELIMITER ',' CSV;

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...