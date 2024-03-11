# Pipeline CRM Homework Assignment
The goal of this Ruby on Rails & React homework assignment is to assess your ability to resolve issues and implement new functionality in a scalable and simple manner while utilizing best practices within each domain.

This repository mocks a CRM in the simplest of terms by demonstrating the one to many relationship of Companies to Deals and visualizng various attributes of each to our users.

Unfortunately, the current implementation is (intentionally) naive and not working as expected in several ways.  

Your primary task with this homework assignment is to resolve the user stories below.

## Expected Level of Investment
*Estimated time to completion: 3-4 hours*

## User Stories
- [x] The frontend is not properly fetching data, i.e. filters aren't being sent, requests are being sent too often, non-successful response codes aren't being handled, etc.
  - [x] Ensured filters are sent with requests
  - [x] Debouncer: Control the frequency of API requests, ensuring that they're made only after a user has paused their input, reducing unnecessary server load.
  - [x] Added error handling for API responses, displaying user-friendly messages and preventing the application from crashing on non-successful response codes.
- [x] The backend is taking too long to return the expected data, i.e.  filters aren't being applied, too much data is being returned, db performance isn't optimized, etc.
  - [x] Pagination: To reduce load times by limiting the amount of data sent in a single request.
  - [x] Filterer Concern: To cleanly apply filters, improving query efficiency and code maintainability.
  - [x] Serializers: To only send necessary data, reducing bandwidth and speeding up responses.
  - [x] Database Optimization: To enhance query speed and overall application performance.
- [ ] The confidence in our current functionality and ability to deploy additional changes is extremely low.  Help us increase our confidence in an automated way.
  - [x] Unit Tests: Cover individual components or methods, ensuring they work as expected in isolation.
  - [x] Controller Tests: Verify that the application's HTTP endpoints respond as intended, covering various scenarios including success, failure, and edge cases.
  - [ ] System Tests: Implement systems tests to ensure different parts of the application work together as expected.
- [ ] The confidence in our security posture is also very low.  Help us increase our confidence that we are running a securely designed application.
  - [x] Strong Parameters: Use strong parameters to prevent mass-assignment vulnerabilities and ensure we explicitly permit only the required parameters for each action.
  - [ ] Input Validation: Ensure all inputs from users are validated both in terms of type and content to prevent SQL injection and other forms of injection attacks.
  - [ ] Update Dependencies: Use `bundler-audit` to check for vulnerabilities.

## Assumptions

Assumptions to make regarding the user story for this service:

- The service is not write-intensive, but is read-intensive.
- The seed data is quite minimal. Assume the production system could have thousands (or millions) of records.

## Instructions
#### Installation
- `bundle install`
- `yarn install`
- `bundle exec rails db:setup`

#### Running the App
- `bin/dev`

#### Submission
- Clone the repository
- Setup a new repository with the source code
- Implement solution
- Push your solution to a new branch
- Create a Pull Request within the new repository
- When you're ready, share a link to the Pull Request with us 
 

## FAQ
#### How will I be evaluated?

Some of the things we will look at in our evaluation:
- **Functional correctness** - Does the solution function correctly and meet the requirements of the User Stories.
- **Code quality** - How you reason about making sure code is readable and maintainable.
- **Testing** - How you reason about what to test and how to test it.
- **Performance** - How you can identify performance bottlenecks and reason around solving them.
- **System design** - How you reason about concepts like reusability, separation of concerns and various abstractions.

In this we also try to understand how you solve problems generally and how you communicate your solutions. Problem solving and communication are both things we value highly.

Finally, we encourage candidates to focus on quality over quantity. Feel free to add notes/comments/etc highlighting what you would expand or improve given more time.

#### Why did you pick this stack?
This is the stack that the majority of our platform is written in.

#### Can I change things in the existing code?
Of course! The existing code is simply to serve as a simple foundation.  Feel free to modify in any way you prefer.

#### Can I use additional libraries/frameworks?
You're free to use whatever you want. The important thing is that you can explain why you made the decision.

#### Asking for Help
You can reach out to Alan at [first name]@pipelinecrm.com for any questions about this homework assignment. We encourage you to ask for help if you're blocked or are unsure about requirements, but consider time-boxing your troubleshooting to 20 minutes before reaching out to us.
