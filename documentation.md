<img src="http://s3.amazonaws.com/kylegrondin-portfolio/projects/avatars/000/000/004/original/irb.jpg?1520623284" alt="IRB image" align="center">

# Aurora University IRB application
##### Created by Kyle Grondin, Anthony Barrios, and Brandon Pichen

Ruby 2.4.1

Rails 5.1.4

---

The Institutional Review Board (IRB) is a web application designed to connect the investigator with Aurora University’s Institutional Review Board easily and efficiently.  The purpose of the IRB web app is to provide a platform where investigators at the university can submit an application for ethics and safety review and Board members can effectively review, discuss, vote, and assign applications among each other.  


If you're looking for information on using the software:

For Board Members: [IRB Board Manual](https://docs.google.com/document/d/1-X5ouNzfN3ncTXFYhbNVclyeZyZIa49QF3oXrXbyS1A/edit?usp=sharing)

For Users: [IRB User Manual](https://docs.google.com/document/d/1g5JFOZxCvrauNB5Z_lo8z3b0gpe0zysHIepgzUJfFPU/edit?usp=sharing)

For the student(s) who might maintain this: scroll down to Further Guides and References or changing the application process / adding new features.

This application was developed in the MVC Framework Ruby on Rails and is currently running on a CentOS server.  Every line of code is commented ( we think ), and any resources we used are linked below.  HTML, CSS, ad Jascript/jQuery were also used.  Automation was done using the [Whenever](https://github.com/javan/whenever) gem which allows for using CronTab easily in Ruby syntax.  We would run rake tasks on a daily basis located in the lib/task folder. Any diagrams/presentations/notes we have will be in the repository as well.

This document is to describe what the purpose of each file is and various troubleshooting problems we think someone might see when installing.  There are a few modes and key terms that I will be using below.  As for the modes, theres **development** mode and **production** mode.  Development is when you're doing things locally and making sure everything works.  Production mode is when the application gets put onto a live serve and runs in a more professional setting with all debugging features turned off.  an MVC framework is a Model-View-Controller framework that allows for interacting with the database, routing, and logic all in a modularized setting.  Everything is broken down into various folders, actions, and files that can be viewed and modified.  Below I will describe each of the directories we used, and where each important file is located.  

Each time we use the word document, that is simply a user application.  We changed the word to document in our database and code.  


## Files and What They Do

* App - Where all the fun stuff is
  * Assets - This is where the javascript, css, and image files are.  Do NOT use the ones in /public, use the ones in this directory only!
  * Models - This is where all the models are.  These are tables in the database and these files should be used for validation and where you might put a method related to the object.  Think of these as your class files, but are an abstraction of your database tables.
    * assignment.rb - Where everything related to the assignments table is located
    * chair_comment.rb - Chair Comments table location
    * comment.rb - Comments table
    * document.rb - Documents table (applications)
    * page.rb - Where the front page resides
    * user.rb - Users table
    * vote.rb - Votes table
  * Controllers - This is where all the controllers reside.  These are usually linked, but not always, to controllers and views (by name, there is no syntax that links them).  This is where logic pertaining to how the model interacts with the database and view is stored.  So for example, when you want to store an instance of the model in your database, that method, or action as they're called in controllers, is put here.  Instance variables (ruby variables starting with the '@' symbol) can be created here and accessed in their corresponding views
    * Each model will have a controller here.  In each one there is typically a new, edit, create, update, and delete functionality.  These are meant to be RESTful and are related to certain routes in the config/routes.rb file.  This is where a lot of the Ruby is located for back end functionality.  
    * Also worth noting that controllers is where you handle any sort of HTTP filtering and permissions. So what that means is, if you want to make sure only admins can access a page, you would do so in its respective controller.  Not everyone can view every application, so in documents_controller.rb, we specified which people we wanted to see various actions, or pages
    * documents_controller.rb has a lot of content in it because it handles a tiny bit more than just documents.  For example, in the show action, theres variables set for voting, comments, and chair comments.  Naturally they should probably be in their respective controller, but since they're attached to the document, it makes more sense to keep them located int he documents controller for easy accessibility.  When creating a vote, or comment, they will then go to the comments_controller or votes_controller and execute the create action.
  * mailers - This is where you can create various mailers for your application.  We created user_email_mailer.rb to email to various users in certain actions.  We call these methods in the controllers when certain actions happen
  * uploaders - This is where we mount the uploaders and any logic pertaining to what files we can upload are.  So if we want to change what files you can upload to the Sample Consent form, we do it here
  * views - This is where a bulk of the HTML is.  This is where your 'views' are for the project.  These files are HTML with embedded ruby (the .erb extension).  The ruby gets processed before the HTML and can grab variables from the controller and methods from the model if you add them
    * layouts - Where the layouts preside.
      * application.html.erb - this is the main layout where every other HTML.erb file stems from.  If you need to change the header/footer, here is where you do it
    * irb - Home page and board page are located here
    * documents - Everything pertaining to the documents (user applications) user interface is located in this folder
      * \_form.html.erb - This file is a partial file that gets included.  If you want to change the form, this is where it'll be (and new_apps.html.erb)
      * approved.html.erb - When a user goes to /applications/approved in their web browser, it gets routed through here and displays this HTML
      * assignments.html.erb - This is for board members when they click on their assignments tab. All HTML and some embedded ruby
      * edit.html.erb - Edit a document goes here.  All it does is grab the partial form file
      * index.html.erb - This is loaded when a user goes to /applications in their web browser.  This is connected to index in documents_controller.rb and loads every application.  Only board members can view this page.
      * needs_revisions.html.erb - **deprecated** This file is when a user goes to /applications/needs_revisions
      * new.html.erb - When a user wants to create a new application, this file is rendered.  Will also only include the partial form.html.erb file
      * \_apps.html.erb - Partial file.  This is for loading in the table that displays documents so we didnt have to keep repeating it in every HTML file
      * new_apps.html.erb - The code in this file is a giant if statement.  If you're the chair, you see the top of the if statement, otherwise, display the apps.html.erb partial instead.  This is where a chair can assign documents to other board members
    * There are some other directories in here such as chair_comments and votes, but the files inside are blank because we don't need to display anything.  They get immediately redirected after hitting this page and I'm not sure if you can delete them or not
  * helpers - We didn't use this folder but this is where you would store logic or methods that you want to use in the respective model/controller.  I'm not entirely sure of a good example
* Config - Where all the config files are.  
  * environments - Here is where you would go to specify various config options based on what environment you're running.  IE development vs production vs test
  * Application.rb - This is an important file where you might need to change some things.  This is application-wide so this is where some settings might go such as forcing an SSL certicate option.  
  * database.yml - Your database options.  Make sure to hide any live passwords and usernames in this file so no one can hack into the application.  This could probably be in the .gitignore but meh
  * deploy.rb - **deprecated** This was added by Kyle for possible Mina deployment but was scraped. Can be looked at later for easy deployment scripts.
  * puma.rb - If you want to use Puma for local development, your config options would go here, such as default port, and stuff.
  * schedule.rb - This is an important file used by the Whenever gem! This file gets looked at to check when to run certain cron jobs.  So if you want to add/modify WHEN but not HOW things are automatically done, go here
  * secrets.yml - This file can likely be ignored but if there's ever a problem in PRODUCTION mode, check this file and print out your SECRETS_KEY environmental variable and make sure that this all adds up properly!
  * routes.rb - This is where all the routes are.  Routes are how the application determines what to do when certain HTTP requests come in.  For example, the HTTP request could say "GET /" which means get the Root directory.  The routes file will then interpret that and respond with "return irb#home", which means go to the irb controller and execute the home action.  
* db - Everything database related
  * migrations - you will generate these automatically using rails generate migration NAME_OF_MIGRATION, and edit them accordingly.  Migrations are used for interacting with the database without actually interacting with the database.  It's a middle man system that abstracts everything into Ruby syntax so its easy to read and doesn't force you to use SQL syntax.  
    * Things to note: You CAN change the migration files after migrating them, you can undo them, reset the database, or redo them, etc etc.  There's wayyy too many migrations in here and can probably be condensed
  * seeds.rb - if you wanna seed the database (meaning add in a bunch of dummy data) this file is pretty useful if you're constantly migrating and resetting the database because then you can just seed your database and always have data, like an admin user
  * schema.rb - dont touch this.
* diagrams - where we put the project diagrams, has nothing to do with running the application
* lib/tasks - Where the automation tasks are located.  If you need to add another task to be automated, or edit a current one, it'll be located in here.  config/schedule.rb will then need to be updated to redo the task.  Look into Whenever gem that is located in the Gem File
* log - where logs go
* notes - Any notes we might add
* presentations - some of our presentations
* public - Don't touch this folder unless you want to check if somethings there.  This is the public directory for the application and Nginx actually points to this directory, not the root of this project
* vendor - Don't touch this folder unless you want to check if somethings there.  Gems can be installed here for production purposes
* Gemfile - Modify this file, NOT Gemfile.lock!! When you want to add a new gem, add it in here and then save and type in "Bundle install" to add the gem to your application
* stamp.pdf - This gets generated daily by a rake task
* tester.rb - This will use selenium-webdriver to automatically submit an application for testing purposes.  Only works on firefox, must have gecko driver downloaded and in your path variable

## Troubleshooting Common Errors and Problems We Overcame

So I (Kyle) thought long and hard about what someone might occur when trying to install this locally or what an intern might have trouble with and the truth is, theres a lot.  Before I dive into various problems and potential solutions, I want to address that StackOverflow is wonderful for this kind of thing, and where a lot of these solutions were found.  Trial and error is your best friend and sometimes all you're missing is one little command line.  

Also, always know where the logs are! This is crucial.  A lot of times the errors will be logged straight to /log/development.log or /log/production.log but sometimes they aren't depending on what application you're using! For example, nginx logs will log to /var/log/nginx/error.log by default on a linux server if theres a problem with Nginx itself.    

First things first is getting the server running.  when typing in `rails s` and going to http://localhost:3000/ if it doesn't automatically work, chances are its Elastic Search or a database problem.  To fix this,
1. make sure elastic search is running either in your task manager (Windows) or by typing in `service elasticsearch status` if you're on Linux (only if elasticsearch was installed as a service).  
2. If that's working, make sure your database is created! log into mysql locally either through WorkBench or through command line and check that a database called irb exists.  If it doesn't run `rake db:create` in the irb directory where you cloned the application.  
3.  If the database does exist, make sure your password is correct in config/database.yml.  If you're using ENV.fetch to grab an environmental variable, try finding that environmental variable and making sure its set by typing `printenv | grep NAME_OF_ENV_VARIABLE` or simply `printenv` (Linux)
4.  If these steps all succeed, then it's likely a config issue with rails.  Make sure to check if secrets.yml is appropriately working by doing step 3 but with SECRETS_KEY if in production.
5.  Try to get a regular ruby on rails application working outside of IRB.  Could possibly be an issue with Rails installation itself.  Make sure Ruby is in your path variable by typing in `ruby -v` in the command line.

Another common issue is getting the server to be run in production mode on a linux webserver.  On the current CentOS web server, it is using Passenger and Nginx to handle HTTP requests.  In order to replicate this, or reinstall for whatever reason, follow the guide [here](https://www.digitalocean.com/community/tutorials/how-to-deploy-rails-apps-using-passenger-with-nginx-on-centos-6-5).  To check if passenger is installed type `passenger` in application directory.  To check if nginx is installed, type `service nginx status` in the command line.  
1.  If both are working, start up nginx by typing `service nginx restart` and going to your url or IP.  The config file created in the guide is located in /opt/nginx/conf/nginx.conf .  If you followed the guide, there should be a line that says passenger_app_env development.  Make sure thats there and just see if you can get the application running in development mode.
2.  If development mode is working fine, then it might be a problem with config/secrets.yml.  run `rake secret`, copy this output and put it into an environmental variable called SECRET_KEY by running `export echo SECRET_KEY="paste hashed secret here" >> $HOME/.bashrc`.  (Note this command is for CentOS, if running another server, you have to check where your bash profile is located).  Relog and type in `echo $SECRET_KEY` to see if it worked.  
3.  If config/secrets.yml is working, try setting your assets to precompile by running `bundle exec rake assets:precompile db:migrate RAILS_ENV=production` * note this also sets your environment to production
4.  Check config/database.yml as well.  Make sure you're connecting to the same database and using the same password unless you want a separate account/database/password for a production application.  
5.  ElasticSearch could also be a problem, make sure elasticsearch is running by typing in `service elasticsearch status`

Getting ElasticSearch to work:  Sometimes you'll notice that Elasticsearch is running properly but autocomplete isn't working.  This is likely caused by a indexing issue and ElasticSearch simply doesn't have any information on the table.  We handle everything ElasticSearch related via the Searchkick gem.  On the command line type in `rake searchkick:reindex CLASS=User`.  You can also go into rails console by typing in `rails c` and typing in `User.reindex` to achieve the same thing.  More information can be found on Searchkick's github.

Bcrypt issues.  There may be errors related to Bcrypt and we have to be honest with you, the solution varies from PC to PC.  It seems to be directly related to some issue on Windows and how gems are installed.  We suggest googling around for this, as there are many many solutions people have found over the years to fix this, and any number of those issues might work for you.  Or you could switch over to Linux!

Keeping the server running outside of console.  To run the application even when you aren't using the terminal, you have to run the server as a daemon.  when using Puma for development, simply add a `-d` to the end of your command when starting up the rails server.  If in production mode, you can still use the `-d` if using puma, but we highly highly recommend using Nginx and Passenger instead or you WILL run into problems with slowdown and SSL problems (if you use a SSL certificate, which you should)

Stamping.  Stamping does not want to work with .docx because they're trickier to read and there's not many ruby libraries out there for doing such.  So I (Kyle) decided to limit the stamping to PDFs and even then they're finnicky.  Make sure the PDF is actually a PDF and not an image saved as a PDF.  To check this, open up the PDF in any browser or application of your choosing, and see if you can highlight any text.  If so, it's likely a normal PDF.  If not, try changing to a different PDF that isn't an image and see if Stamping works then.  It's also worth noting that if you're running this application for the first time or haven't ran it over night, that you don't have a stamp to begin with!  if you run `rake stamp:stamp_task` and it will manually create a stamp for you.  This can also be done for the other tasks by doing `rake whenever:demo_task`.

If Ruby on Rails itself is not working, I highly recommend simply installing rails as a gem through ruby.  Don't use any installer, or weird methodology.  Once you have ruby installed and working, just type `gem install rails` and it'll install it.  Sometimes gems do not load properly, (EG Nokogiri or bundler) and the errors for those are kinda tricky to decipher.  if you cant find bundler, try just typing in `gem install bundler` and it should fix it.  If not, it could be a path issue and not finding your gems.  On linux, you can try typing in `whereis ruby` and find out if you can even find ruby itself.  `rvm gemset list` is also useful if using rvm on linux.  Sometimes the dependencies aren't installed properly and thus, the gem wont get installed (such as nokogiri or nio4r), this can be solved by typing in `gem pristine -all` and it will get pristine versions of gems which is something we don't fully understand.  but it works!

It's also worth noting that if you're on linux, please please please do not do anything as the root user! Give another user root permissions and only use sudo when absolutely necessary.  For a while we were having problems on the actual live server because Kyle installed ruby on rails as root and it just messed with everything.  You have trouble finding gems, permissions become clunky when trying to retroactively fix it, and its a pain resetting everything.  So if you did this, uninstall everything and start over from a regular user.  some commands that might be useful for you: `chmod` - Changing permissions of a file or directory.  `chown` changing who owns the file or directory

and if Ruby itself is not working, it is 95% probably a pathing issue.  If you type in `ruby -v` on your command line, and cannot find it, make sure your path variable has the directory in it!

If something wasn't discussed here, google is your friend.  There was countless bugs and problems we encountered over our time creating this, and 90% of our solutions were from people online who had similar problems.  Chances are, if you're encountering something, someone else has too!
