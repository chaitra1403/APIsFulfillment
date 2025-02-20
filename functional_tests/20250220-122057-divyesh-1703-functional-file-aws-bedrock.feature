Feature: Credit Card Application System

  # Functional Test Scenarios

  Scenario: Successful Credit Card Application
    Given the user is on the credit card application page
    When the user submits a valid application with all required information
    Then the application should be successfully submitted
    And a confirmation message should be displayed

  Scenario: Incomplete Credit Card Application
    Given the user is on the credit card application page
    When the user submits an application with missing income details
    Then the application submission should fail
    And an error message highlighting the missing information should be displayed

  Scenario: Branch Application Submission
    Given a customer is at a bank branch
    When the bank representative submits a valid application on behalf of the customer
    Then the application should be processed successfully
    And a confirmation should be provided to the customer

  Scenario: Successful Fee Waiver
    Given a customer has an unexpected late payment fee
    When the customer requests a fee waiver
    And the bank reviews and approves the waiver
    Then the fee should be waived
    And the updated balance should be reflected on the account

  Scenario: Fee Waiver Rejection
    Given a customer requests to waive the annual fee
    When the bank reviews the request
    And decides not to waive the fee
    Then the customer should be notified of the decision
    And the fee should remain on the account

  Scenario: Successful Points Redemption
    Given a customer has 10,000 points available
    When the customer selects a gift card option for 10,000 points
    And submits the redemption request
    Then the points should be deducted from the customer's account
    And a gift card should be issued
    And a confirmation should be sent to the customer

  Scenario: Insufficient Points for Redemption
    Given a customer has 15,000 points available
    When the customer attempts to redeem 20,000 points
    Then the redemption should be blocked
    And an error message should be displayed

  Scenario: Automatic Credit Limit Increase
    Given a customer has a good payment history and stable income
    When the system evaluates the customer's creditworthiness
    Then the credit limit should be automatically increased
    And the customer should be notified of the increase

  Scenario: Customer-Requested Credit Limit Increase
    Given a customer requests a credit limit increase
    When the bank reviews and approves the request
    Then the credit limit should be increased
    And a confirmation should be sent to the customer

  Scenario: Risk-Based Credit Limit Reduction
    Given a customer has a declining credit score
    When the system flags the account for review
    Then the credit limit should be reduced
    And the customer should be notified with an explanation

  Scenario: Credit Limit Reduction Below Current Balance
    Given a customer has a $5000 balance
    When the system attempts to reduce the credit limit to $4000
    Then the reduction should be blocked
    And the limit should be maintained above the current balance

  Scenario: Successful Balance Transfer
    Given a customer initiates a $3000 balance transfer from another card
    When the balance transfer is processed with a promotional rate
    Then the balance should be transferred successfully
    And the promotional rate should be applied
    And a confirmation should be sent to the customer

  Scenario: Balance Transfer Exceeding Available Credit
    Given a customer has $5000 available credit
    When the customer attempts to transfer $8000 from another card
    Then the transfer should be rejected
    And an error message should be displayed

  # Non-Functional Test Scenarios

  Scenario: Application Processing Time
    Given a user submits a credit card application
    When the application is processed
    Then the processing time should not exceed 2 minutes

  Scenario: Data Encryption
    Given a user submits sensitive personal and financial data
    When the data is transmitted
    Then it should be encrypted using industry-standard protocols

  Scenario: Peak Load Handling
    Given the system is under normal operation
    When 1000 concurrent credit card applications are simulated
    Then the system should handle the load without significant performance degradation

  Scenario: Mobile Responsiveness
    Given a user accesses the credit card application form on various mobile devices
    When the form is rendered
    Then it should display correctly and be easily navigable on all tested devices

  Scenario: System Uptime
    Given the credit card application system is monitored for 30 days
    When the uptime is calculated
    Then it should achieve 99.9% availability

  Scenario: Cross-Browser Functionality
    Given the credit card application process is tested on major browsers
    When the application is accessed on Chrome, Firefox, Safari, and Edge
    Then it should demonstrate consistent functionality and appearance across all tested browsers

  Scenario: Screen Reader Compatibility
    Given a user navigates the credit card application using a screen reader
    When the application form is read
    Then all form elements and instructions should be properly read and accessible
