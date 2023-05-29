# README

## Welcome to the RedFlag App

The RedFlag application is built on:
* Ruby v3.1.2
* Rails  v7.0.4.3
* postgresql v13.8 or higher
* node.js v18.9.0 or higher
* yarn v1.22.19 or higher
* npm 8.19.1 or higher


---

## Project Install (Mac)

1. Install the latest version of XCode from the App store, run `$ xcode-select --install`
2. Install the latest version of Homebrew: http://brew.sh
3. Install node.js, run `$ brew install nodejs`
4. Install yarn, run `$ npm install --global yarn`
5. Install Ruby from terminal (e.g. using RVM: `$ rvm install 3.1.2`)
6. Install posgtresql from terminal: `$ brew install postgresql` and follow on screen instructions (very important)
7. Create postgresql superuser postgres: `$ createuser postgres -s`
8. Change your directory to where you want your work projects in terminal and clone the git repo: `$ git clone git@github.com:Tetyana2015/redflag.git`
9. Go into the directory `$ cd redflag`. Confirm that when you run `$ rvm gemset list` it lists "redflag" as your gemset.
10. Run `$ gem install bundler`
11. Run `$ gem update --system`
12. Run bundler: `$ bundle`
13. Install redis using homebrew: `$ brew install redis`
14. Install JS dependencies `yarn install`
15. Create a new database: `$ rails db:create` + `$ rails db:seed`
16. Should be ready to roll in the terminal: `$ bin/dev`
17. Open a new tab in terminal and start redis: `$ redis-server`
18. Open a new tab in terminal and start sidekiq: `$ bundle exec sidekiq`. 
19. To access the application, open a browser window and navigate to `http://localhost:3000`.
20. To login as ProjectMagager use seeded user with email: `test@email.co` password: `password` 

---

## Summary
The idea is to create a simple project management dashboard with frontend as well as API access. The basic features include the following:

### Required models and functionality:
1. Project Managers which would contain name, login email, login password
2. Only Project Manager can create Employees
3. Employees which would contain name, title, login email, and login password, work focus (ex: development, design, business, research, etc.)
4. Tasks which would be assigned to the Employee(s) containing title, description, work focus, due date, status (not started, working, needs review, done, late), and Project Manager who created a Task
5. Tasks should be able to have sub tasks (the same model)
6. Only the assigned Project Manager to the Task can switch task to done status
7. Only the assigned Employee(s) can switch Task to working, and needs review statuses
8. Only the Project Manager can create Tasks
9. Projects which would contain Tasks (a Task can be assigned only to one Project), title, description, due date
10. Only the Project Manager can create Projects
11. Recurring job is added (via Sidekiq), which checks the due date on Tasks and switch Tasks to "late" status if due date passed
12. The frontend have a workable UI (but simple, design doesn't matter), which would show Projects and perhaps columns for each Task status, where the Project Manager or Employee can manage with the features described above (React is used)
13. This is an API which would contain all of the above dashboard and frontend functionality
14. Frontend is present as well as API functionality to login with an email and password as any of the Project Managers or Employees

--- 

**In order to implement above specification listed below `Rails` models were created:**
* `User` with STI for `ProjectManager` and `Employee`
* `ProjectManager < User`
* `Employee < User`
* `Project`
* `Task`

Also ref. `db/schema.rb`.

`has_secure_password` feature is implemented for users.

In oder to be able to form initial **db** `Rails` `seeds.rb` was created.

**API is implemented via `Rails` controllers:**
* `app/controllers/api/employees_controller.rb`
* `app/controllers/api/projects_controller.rb`
* `app/controllers/api/tasks_controller.rb`
* Session is managed via `app/controllers/sessions_controller.rb`
* `app/controllers/homepage_controller.rb` is used as entry point for React App

**Business logic is implemented in services classes:**
* `app/services/employee_create.rb`
* `app/services/task_create.rb`
* `app/services/task_update.rb`.

In order to check the due date on Tasks and switch Tasks to "late" status if due date passed
**`app/sidekiq/expire_task_job.rb`** and **`config/schedule.yml`** were created.

**UI is implemented via React - ref. listed below folders in the project:**
* `app/javascript/components`
* `app/javascript/controllers`
* `app/javascript/helpers`
* `app/javascript/queries`
* `app/javascript/routes`
* and `app/javascript/application.js`.

**Frontend is present as well as API functionality to `login` with an `email` and `password` as any of the `Project Managers` or `Employees`.**

Set of `rspec` tests as well as set of `factories` were created - ref. folder `spec`.

For demo tap this link - [LINK](https://www.loom.com/share/5b6fcc35b51d463ea376e296fc81977a)
