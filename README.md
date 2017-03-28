# README

This README would normally document whatever steps are necessary to get the
application up and running.


Run the test suite
--------

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
