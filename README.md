# CalCentral-Task-Planner 
### General Information 
[![Build Status](https://travis-ci.org/Garyguo2011/CalCentral-Task-Planner.svg?branch=master)](https://travis-ci.org/Garyguo2011/CalCentral-Task-Planner) [![Test Coverage](https://codeclimate.com/github/Garyguo2011/CalCentral-Task-Planner/badges/coverage.svg)](https://codeclimate.com/github/Garyguo2011/CalCentral-Task-Planner) [![Code Climate](https://codeclimate.com/github/Garyguo2011/CalCentral-Task-Planner/badges/gpa.svg)](https://codeclimate.com/github/Garyguo2011/CalCentral-Task-Planner)
* Demo: http://calcentral.iBearHost.com (Username: test@gmail.com | Password: 12345678)
* Poivotal Tracker: https://www.pivotaltracker.com/n/projects/1269296
* CodeClimate: https://codeclimate.com/github/Garyguo2011/CalCentral-Task-Planner
* Github: https://github.com/Garyguo2011/CalCentral-Task-Planner.git

### Documents
Check release notes for feature user story
* [Initial Client Meeting](https://www.youtube.com/watch?v=a9aJq5xb9OU)
* [Lo-fi UI Mockup](https://ibearhost.atlassian.net/wiki/display/CAL/Iteration+1+Lo-fi+UI+Mockup)
* [User Stories](https://ibearhost.atlassian.net/wiki/display/CAL/Iteration+1+User+Stories)
* [Survey Questions](http://survey.ibearhost.com)
* [Online Report](https://docs.google.com/a/berkeley.edu/forms/d/1N0di7zn4hwAgEZncM-AERepqIKxCbAH0W44UGP5PwEY/viewanalytics#start=publishanalytics)
* [iBearHost Survey Report](https://docs.google.com/a/berkeley.edu/presentation/d/19tUvj-lFaFKDhZ8BwyUFdq-ZXYl9jws_TlcFhmqMkgg/edit?usp=sharing)

### Set Up
Run following commands will help you setup develop environement.
Running with ruby 1.9.3, rails 3.2.19
  
    git clone https://github.com/Garyguo2011/CalCentral-Task-Planner.git
    cd CalCentral-Task-Planner
    bundle install --without production
    rake db:migrate db:test:prepare db:seed
    rake cucumber                                         [Run Human Readable Cucumber Test]
    rake spec                                             [Run RSpec Unit Tests]
    open coverage/index.html                              [Show current C0 test coverage]
    rails server                                          [Server run on http://0.0.0.0:3000]

### Project Poster
![CalCentral Task Planner](http://www.ibearhost.com/screenshot/poster.png)

### Core Features

##### Tasks Priority List & TimeLine
![Tasks Priority List & TimeLine](http://www.ibearhost.com/screenshot/timeline.png)

##### Important Due Data Calendar
![Important Due Date Calendar](http://www.ibearhost.com/screenshot/calendar.png)

##### Single Task Time Usage & Progress Tracking
![Single Task Time Usage & Progress Tracking](http://www.ibearhost.com/screenshot/single_task.png)

##### Create or Intelligently generate subtasks
![Create or Intelligently generate subtasks](http://www.ibearhost.com/screenshot/subtasks.png)

##### Email Notification
![Email Notification](http://www.ibearhost.com/screenshot/email.png)

##### Alert Message
![Alert Message](http://www.ibearhost.com/screenshot/alert.png)

##### All Task Control Panel & Analysis
![All Task Control Panel & Analysis](http://www.ibearhost.com/screenshot/control_panel.png)



