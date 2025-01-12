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

## Features: 

- [x] Authentication: Register, Login, Logout.
- [x] Events: Create, Index all, Index own. 
- [x] Tickets: Create, Index own. (Constraint: Can book multiple but not more than the allocated amount)

Additional details: 

- [x] Caching must be implemented. 
- [x] Ticket booking must be thread safe. 
- [x] Performance focused. 
- [x] Specs and best practices. 

## Models
### User
Devise user model

### Event
Event model.

### Location
Location model. Separate as we can re-use this across the site.

### Tickets
Ticket. References user and event.

<img width="824" alt="Screenshot 2025-01-12 at 1 54 45 pm" src="https://github.com/user-attachments/assets/ccc69406-1db8-4b75-b6b6-c219b294aa8e" />


## Performance: 
#### Indexing: 
- [x] Database indexes for fast querying.

#### Background job processing: 
- [x] If the concurrency is causing slow processing times; we have the bookings in a background thread which will speed up the HTTP request and the users time. 

#### Caching
- [x] Fragment caching for fast HTML load time. 
- [x] Controller caching
- [x] IMPORTANT: I excluded caching on the personal event view and the tickets view as caching can bypass security (CanCanCan) and individual caching will bloat the caching server.

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

