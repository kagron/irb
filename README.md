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

For the student(s) who might maintain this: scroll down to Further Guides and References or changing the application process / adding new features.  There is also a documentation.md located in this repository for more information about the various files and directories along with common issues and how to troubleshoot them!

This application was developed in the MVC Framework Ruby on Rails and is currently running on a CentOS server.  Every line of code is commented ( we think ), and any resources we used are linked below.  HTML, CSS, ad Jascript/jQuery were also used.  Automation was done using the [Whenever](https://github.com/javan/whenever) gem which allows for using CronTab easily in Ruby syntax.  We would run rake tasks on a daily basis located in the lib/task folder. Any diagrams/presentations/notes we have will be in the repository as well.

A lot of our functionality came from gems.  What and why we used it is in our Gemfile.  


## Features

*  **Login**
*  **Document Submission**: Users can submit an application and attach PDFs to be reviewed
*  **Reviewable**: Each application can then be seen by board members
*  **Assignments**: Chair of the board can assign applications to other board members (and delete them if needed)
*  **Commenting**: Board members can comment on the application and then vote on what state they think it should be
*  **Emailing**: Emailing the chair when a new application comes in, and email the user when their application is finished reviewing
*  **Revisions**: Users can then resubmit their application with changes if needed
*  **Stamping**: Stamp each approved PDF with an approved stamp so the investigator can hand it out to the people being investigated
*  **Archival**: Every application is archived either after approval or 3 months of inactivity
*  **Searching**: Search all the applications and sort by date and name
*  **Changing Board and Chair Members**: The Chair of the board can easily add/remove current board members or add a new chair member
*  **Read Only Role**:  There is also a read only role in case there's a person in the board who just needs to view applications


## Requirements to Run Locally

1.  Ruby 2.4.1+
2.  Rails 5.1.4+
3.  [ElasticSearch](https://www.elastic.co/products/elasticsearch)
4.  MySql Community Server
5.  NodeJS
6.  Git

If you're using Linux, we recommend you use [RVM](https://rvm.io/) or RBEnv for managing your Ruby version and gems (including Rails).  For Windows: Download the Ruby Installer [here](https://www.ruby-lang.org/en/downloads/).  Once you have Ruby installed, download Rails by typing in `gem install rails`. For MySQL, theres a windows installer [here](https://dev.mysql.com/downloads/mysql/) that you can download.  For NodeJS, the installer is [here](https://nodejs.org/en/).  For more guides, scroll down to Further Guides and Resources.


## Getting Started Locally

1.  Clone by typing `git clone https://github.com/kagron/irb.git` into terminal / command prompt
2.  `cd irb`
3.  Make sure your config/database.yml file has the correct username and password for your local MySQL user
4.  `bundle install`
5.  Create databases in mysql by running `rake db:create`
6.  `rake db:create`
7.  `rake db:migrate`
8.  `service elasticsearch start`
9.  `rails s`
10. Open up http://localhost:3000/ in your preferred web browser

If you're on windows, step 8 will be different.  For installation on windows go [here](https://www.elastic.co/guide/en/elasticsearch/reference/current/windows.html) and for more general information go to the Getting Started guide [here](https://www.elastic.co/guide/en/elasticsearch/reference/current/getting-started.html).  Make sure you install Elastic Search as a service if you're using Linux, otherwise just make sure its running by checking http://localhost:9200/

## Accessing the live server 

1.  Use Putty (Windows) or terminal (Linux/Mac) to SSH into the server
2.  Hostname: irb.aurora.edu
3.  Password: Will be supplied to whoever is maintaining the app
4.  Files will be located in /var/www/irb
5.  Ruby is installed via RVM
6.  Nginx config file is in /opt/nginx/config/nginx.conf

## Deploying/Re-Deploying the application

Currently the deployment is NOT using a script or application to pull from github, so we have do that manually.  I also did not set up an SSH key to this github to the server because that gives more access to my github than just the IRB application.

1.  Make sure your latest changes are pushed to either your forked master branch or the master branch here
2.  Change directories into /var/www/irb
3.  Pull the changes into the directory
4.  Migrate any new database changes via `rake db:migrate`
5.  If the application is being deployed for the first time, make sure the database is clean by running `rake db:reset` (Note this will also erase everything including users, so make sure to recreate the board members)
5.  Reindex User tables if needed `rake searchkick:reindex class=User`
6.  Restart the nginx server by typing in `service nginx restart`.  If deploying to a new server, you will likely need to set the rails environment to production instead of development
7.  Check the website
8.  If needed, nginx logs everything to `/var/log/nginx/error.log` if it's stricly a nginx error, otherwise your errors will likely end up in `/var/www/irb/log/production.log` if in production, otherwise it's `/var/www/irb/log/development.log`.  

## Implementing AU's Single Sign On

Truthfully, when designing this application, Single Sign in was always considered but we were never entirely sure how to prepare for it.  So currently, users will have to register and log in.  If you need to implement Single Sign On, we suggest still using our users table because that is what our application is based around.  In order to do that, you could perhaps treat them as "profiles" instead of regular users.  What we mean by this, is that when a user logs in using Single Sign On, they still get a user created in our database but it is instead treated as a profile.  This way, you dont need to go through the entire application changing authorization and/or figuring out permissions.  Permissions work by checking the current user and determining whether they have permissions based on a boolean value stored in the database.  If you were to use Single Sign On, you would not have alteration priviliges to Aurora University's database and thus, the application breaks.

Some files to look at: 
  *  /app/controllers/registrations_controller.rb - This is a file that overrides the Devise controller.  We use this to modify how registrations are handled.  You might be able to just do everything in the sign_up_params method
  *  /app/models/user.rb - This is the file related to the Users model.  You might be able to add some things in here 
  *  [Devise](https://github.com/plataformatec/devise) - This is the gem that we used for User authentication.  It provides everything we needed and can be accessed via rails helper methods.  For any questions/guides/concerns, check this place first.

## Further Guides and Helpful References

*  [Ruby-Lang](https://www.ruby-lang.org/en/downloads/) - The Official Ruby programming language website
*  [MySQL](https://dev.mysql.com/downloads/mysql/) - MySQL's official website
*  [NodeJS](https://nodejs.org/en/)
*  [RubyDocs](http://www.rubydoc.info/) - For a list of APIs and documentation for gems
*  [Ruby On Rails API](http://api.rubyonrails.org/) - The official Ruby on Rails API
*  [Ruby on Rails Guide](http://guides.rubyonrails.org/) - Official list of Ruby on Rails Guides and examples
*  [Ruby on Rails commands for the Command Line](http://guides.rubyonrails.org/command_line.html) - Use this to read about various commands Ruby on rails allows
*  [StackOverflow](https://stackoverflow.com/) - StackOverflow for answering any question you might have outside of these other links
*  [Elastic](https://www.elastic.co/ ) - Elastic's website: the Company that made ElasticSearch
*  [ElasticSearch Getting Started Guide](https://www.elastic.co/guide/en/elasticsearch/reference/current/getting-started.html)
*  [ElasticSearch Installation on Windows](https://www.elastic.co/guide/en/elasticsearch/reference/current/windows.html)
*  [Everything you need to know about Git](https://www.udemy.com/learngit/)
*  [How to Install MySQL Server on Windows](https://www.youtube.com/watch?v=UgHRay7gN1g)
*  [How to Install NodeJS on Windows](https://www.youtube.com/watch?v=-u-j7uqU7sI)
*  [How to Install Ruby on Rails on Windows](https://www.youtube.com/watch?v=OHgXELONyTQ)
*  [How to Install ElasticSearch on Windows](https://www.youtube.com/watch?v=YE7AzSCC3E0)
*  [What is a MVC Framework?](https://www.youtube.com/watch?v=qXRcVhWxuaU)

## Changing the Application Process / Adding other features

This application is personalized to the Aurora University Institutional Review Board.  In order to add / remove parts of the application process, the documents table will need to be changed.  Each application is called a 'document' in our database.  Ruby on Rails uses an Active Record model to abstract the database.  So in order to modify the application/document, you will need to create a **migration** which can be read about [here](http://edgeguides.rubyonrails.org/active_record_migrations.html).  Once the table is modified, the model is located in app/models/document.rb  and the controller for modifying various actions is in app/controllers/documents_controller.rb! If you do not know about MVC logic, a link to MVC frameworks is linked above.

Other features will likely require JavaScript / other tables in the MySQL Database.  Anything that needs to be saved from page to page should be in session variables or saved in a table.  Anything that pertains to how the application behaves ( examples being validation, fancy animations when doing something, AJAX ) should be done in CSS/JavaScript/AJAX.  For starters, we recommend looking into SASS for CSS related stuff, Axios for AJAX related stuff, and React/Angular/VueJS for anything else Javascript related.

If it is related to automation, take a look at how [Whenever](https://github.com/javan/whenever) works.  It allows for easy Cron jobs using Ruby syntax.  You can use this to run Rake tasks in any interval possible.

If all else fails, try looking up a gem to do what you want!  There's thousands of gems and there's generally something out there for what you need done.


## Contribution

Thank you for considering contributing to our Institutional Review Board web application.  Feel free to fork and create a pull request!  The documents table was created specifically for Aurora University's Institutional Review Board, so in order to truly utilize the application, the application process should be customized to the board.

## License

The Institional Review Board is open-sourced software licensed under the [MIT License](https://opensource.org/licenses/MIT).
