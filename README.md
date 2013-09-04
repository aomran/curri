# Getting Started

## To get this app working:

1. Clone it down to your computer (don't fork it please).
2. cd curry
3. bundle install
4. rake db:migrate
5. rake db:seed

### Start development environment
Terminal Tab 1: rails s
Terminal Tab 2: rackup private_pub.ru -s thin -E production

### Run tests
Terminal Tab 1: rackup private_pub.ru -s thin -E test
Terminal Tab 2: rake

## To do

### Student View
- success criteria pop-over style needs to be fixed
- give students an indication that their rating was saved to database. Maybe a "Last Rating at: <time>" somewhere on the page.
- when on a track, the side menu should indicate current track (prehaps with a colour or icon)

### Invitations
- student with account can claim invitation without sign up
- logged in student can claim invitation
- ability to invite multiple students at once

### Ratings
- checkpoint ratings are associated with a student

### Forms
- ~~add validations to forms~~ email presence and uniqueness required
- ~~add dynamic_forms gem for form errors~~ done; validation problems reported to user.

### Teacher Authorization
- only teachers should access analytics view
- only teachers should be able to add/edit/delete classrooms/tracks/checkpoints

### Student Authorization
- only students should be able to rate checkpoints

### Analytics
- individual student analytics
- aggregated analytics over time
