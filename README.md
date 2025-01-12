# jarred_baker_event_booking

### Getting started

```bash
  cd jarred_baker_event_booking
```
```bash
  bin/rails db:create
```

##### Enable caching in development
```bash
bin/rails dev:cache
```

## Please note

In `config/environments/development.rb`

I've set the following so that caching works in development. If you want to make changes to the code, please set if back to false

```ruby
  config.cache_classes = true
```

# Technical Design Documentation: 

## Description:

Build a tread safe event booking system that's performance focused.

## Models

### User
Devise user model

### Event
Event model

### Location
Location model. Separate as we can re-use this across the site.

### Tickets
Ticket

### Migrations:
```ruby
# Events
def change
  create_table :events, id: :uuid do |t|
    t.string :name, null: false, index: true
    t.text :description
    t.datetime :date, null: false, index: true
    t.integer :tickets_available, default: 0, null: false
    t.references :user, foreign_key: true, null: false, type: :uuid

    t.timestamps
  end

  add_index :events, [:user_id, :date]
end
```


## Performance: 
#### Indexing: 
- [x] Database indexes for fast querying.

#### Background job processing: 
- [x] If the concurrency is causing slow processing times have the bookings in a background thread will speed up the HTTP request and the users time. 

#### Caching
- [x] Fragment caching for fast HTML load time. 
- [x] Controller caching and invalidation.

#### Concurrency:
- [x] Transaction blocks and SQL level locking.

## Edge cases:
- [ ] [Out of scope] Timezones of events. If the user creates it in America and another user views in in Dubai it won't align. The best case scenario is if the event date is scoped to the event locations timezone. 
- [x] Ensure cached data isn't leaked to the wrong user. If caching bookings we don't want users to access another cache.  

## Security:
#### Additions: 
1. Devise authentication. 
2. CanCanCan for route level authorization.

## Gem breakdown:

