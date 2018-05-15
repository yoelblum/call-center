# README

Building the project

Prerequisites 
a) docker (and docker compose)

1) Clone the project
2) docker-compose build
3) docker-compose up (starts the server and the polling process)
from another terminal:
4) docker-compose run website rails db:create
5) docker-compose run website rails db:migrate
6) docker-compose run website rails db:seed

Run the tests:

docker-compose run website rspec

The solution is based on polling a calls table for waiting calls, and letting each free employee either handle or escalate it.
if there is no free employee the call will wait until the right employee is free.
For the sake of this solution respondents and managers are able or not able to handle a call randomly.

CallCenter.rb -> polls the calls table for waiting calls
Employee.rb -> Base class. has functionality for querying free/unfree employees and handling calls. can either handle the call (and then
the employee becomes busy) or escalate.
Manager.rb, Respondent.rb, Director.rb-> inherit employee. Only implement escalate (respondent escalates to manager, manager to director)
Call.rb -> has status (waiting, being_handled, done) and escalation (manager/director).

Why Database and not a queue?

Queue does make sense here. I felt the solution is somewhat cleaner by polling a db.


