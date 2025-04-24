# Squaremouth Advanced Rails Skill Assessment

Congratulations on reaching the next phase of your interview! This assessment will test your Rails knowledge using code and tools that are very similar to what we use in production. Inside you'll find a basic Rails 5 app, with Bootstrap SASS, jQuery, RSpec, and Docker added in. It implements a simplified version of squaremouth.com's quote results page, which is the focus of the assessment.

It should take you 2-4 hours to complete. Please think of this as a timebox; submitting an incomplete assessment is OK! Just let us know what parts you didn't get to and how you planned to solve them.

## Requirements
Our business folks have requested an enhancement to the Quote Results page to help customers customize their quote. Today, each product has a set of things that it covers, like trip cancellation, which vary from product to product. They've requested we add a sidebar to the page that gives the customer the ability to modify their quote by selecting coverage upgrades.

Selecting a coverage should do the following:
1. Hide products that do not have the coverage.
2. Recalculate the product premium based on the following rules:
    * Baggage Delay: double the premium
    * Emergency Medical: add $50 to the premium
    * Trip Cancellation: If Emergency Medical is selected, add $75 to the premium, otherwise add $100 to the premium

For the implementation, we should make the customer's selected coverages persist between visits and apply the changes via AJAX. We should also have adequate test coverage for the new functionality.

## Submission
Once you've completed the assessment, please ensure all your changes are committed and send a zip containing the entire project to us. Once we've reviewed the assessment, we'll get back to you with feedback and next steps.

## Things to Note
* Be sure to seed your local database with the seed file provided. It contains all the sample data you'll need to get started.
* Docker configuration is provided for your convenience. We encourage you to use Docker, but it's not necessary to complete the assessment.
* The assessment uses [Cuprite](https://github.com/rubycdp/cuprite) for feature tests, so if you don't use Docker you'll need to have Chrome or Chromium installed on your machine.
* The [quote index page](http://localhost:3000/quotes) is there to give easy access to the seeded data; the assessment doesn't require any changes to the page.
* Good luck!
