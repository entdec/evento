# Evento

With Evento you can hook into events generated by AASM, state\_machines and Devise.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'evento'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install evento

## Usage

You can create methods based on events methods from AASM or state\_machines in another class:

```ruby
orchestrator = Evento::Orchestrator.new(Order)
orchestrator.define_event_methods_on(OrderEventHandler, state_machine: true) do |your, own, parameters, here|
  # your code here
end
```

If you're using devise you can also create event methods based on that:

```ruby
orchestrator = Evento::Orchestrator.new(User)
orchestrator.define_event_methods_on(UserEventHandler, devise: true) do |your, own, parameters, here|
  # your code here
end
```

If you set both teh state\_machine and devise options methods for both will be created in one go.
Existing method will *not* be overwritten using this method.

You can also override Devise's send\_devise\_notification method:

```ruby
orchestrator = Evento::Orchestrator.new(User)
orchestrator.override_devise_notification do |notification, *devise_params|
  # your own notification logic here...
end
```

The above *will* overwrite the existing method .

If you're using state\_machines with state\_machines-audit\_trail you can add add after\_commit hooks like so:

```
orchestrator = Evento::Orchestrator.new(Order)
orchestrator.after_audit_trail_commit(:unique_name) do |audit_trail_record|
  # your own code here ... you could for example hook into the handler methods you created earlier with something like the below:
  # handler = OrderEventHandler.new(audit_trail_record.resource).public_send(event.to_s, your, own, parameters, here)
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/evento.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
