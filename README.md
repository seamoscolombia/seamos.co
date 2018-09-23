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
