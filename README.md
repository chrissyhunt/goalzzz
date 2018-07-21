# Welcome to Goalzzz!

Goalzzz is a productivity app built in Rails, and using bcrypt and Omniauth.

Version 2.0 features a Rails API backend and a jQuery frontend for the '/goals' portion of the application.

## Installation

Run ``bundle install`` to install all required gems.

## To Run Locally

Omniauth login requires a self-signed SSL certificate for HTTPS connection. See this blog post for more info on how to configure your local environment:

https://www.devmynd.com/blog/rails-local-development-https-using-self-signed-ssl-certificate/

Then open browser and navigate to https://localhost:3000/.

(If you do not plan to use Omniauth, you can start the rails server as usual by typing 'rails s' in your terminal, navigate to http://localhost:3000, and create an account manually.)

## File Structure

``/app`` - Contains all MVC files and assets for app.

``/config`` - Contains environment files and initializers.

``/db`` - Contains db, migrations, and seeds.

## Routes and Features

``/`` - Landing page, will direct you to log in or sign up.

``/users/:id`` - User's home dashboard, with summary of user goals and success rate.

``/goals`` - Goal landing page, with list of user's goals.

## Contributors Guide

This code is maintained at https://github.com/chrissyhunt87/goalzzz. For any contributions, please open a pull request.

## Licensing Statement

This project has been licensed under the MIT open source license. For more info, see: https://opensource.org/licenses/MIT
