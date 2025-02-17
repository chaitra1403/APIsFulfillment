Feature: Credit Card Application System

  # Functional Test Cases

  Scenario: Successful Credit Card Application Submission
    Given the user is on the credit card application page
    When the user submits a valid application with the following details:
      | Field             | Value                |
      | Name              | John Doe             |
      | Income            | $50,000              |
      | Contact Number    | +1 123-456-7890      |
    Then the application should be submitted successfully
    And a confirmation message should be displayed

  Scenario: Invalid Credit Card Application Submission
    Given the user is on the credit card application page
    When the user submits an application with incomplete information:
      | Field             | Value                |
      | Name              | Jane Doe             |
      | Income            |                      |
      | Contact Number    | +1 987-654-3210      |
    Then the application should not be submitted
    And an error message should be displayed requesting the missing information

  Scenario: Successful Fee Waiver
    Given a customer with a positive account history
    When the customer requests to waive an unexpected fee of $25
    Then the fee should be waived
    And the customer's account balance should be updated accordingly

  Scenario: Fee Waiver Denial
    Given a customer with a negative account history
    When the customer requests to waive a fee of $30
    Then the fee waiver should be denied
    And an explanation should be provided to the customer

  Scenario: Successful Points Redemption
    Given a customer has 10,000 reward points
    When the customer requests to redeem 5,000 points for a $50 gift card
    Then the redemption should be successful
    And the customer's point balance should be updated to 5,000 points

  Scenario: Insufficient Points for Redemption
    Given a customer has 1,000 reward points
    When the customer attempts to redeem 2,000 points for a reward
    Then the redemption should be denied
    And an error message should be displayed indicating insufficient points

  Scenario: Approved Credit Limit Increase
    Given a customer with positive creditworthiness and stable income
    When the customer requests a credit limit increase
    Then the credit limit should be increased
    And the customer should be notified of their new limit

  Scenario: Denied Credit Limit Increase
    Given a customer with negative creditworthiness
    When the customer requests a credit limit increase
    Then the credit limit increase should be denied
    And the customer should be notified of the decision

  Scenario: Credit Limit Reduction
    Given a customer's financial situation has negatively changed
    When the bank initiates a credit limit reduction
    Then the customer's credit limit should be reduced
    And the customer should be notified of their new limit

  Scenario: Credit Limit Reduction Below Current Balance
    Given a customer has a current balance of $5,000 and a credit limit of $10,000
    When the bank attempts to reduce the credit limit to $4,000
    Then the reduction should be adjusted to accommodate the current balance
    And the customer should be notified of the adjusted limit

  Scenario: Successful Balance Transfer
    Given a customer is eligible for a promotional balance transfer
    When the customer requests a balance transfer of $2,000
    Then the balance transfer should be processed successfully
    And the promotional terms should be applied to the transferred amount

  Scenario: Balance Transfer Exceeding Limit
    Given a customer has an available credit of $3,000
    When the customer requests a balance transfer of $5,000
    Then the transfer should be partially approved for $3,000
    And the customer should be notified of the partial approval

  # Non-Functional Test Cases

  Scenario: Application Response Time
    Given the credit card application system is operational
    When 100 users submit applications simultaneously
    Then the average response time should be less than 3 seconds

  Scenario: Concurrent Application Handling
    Given the credit card application system is operational
    When 1000 concurrent applications are submitted
    Then the system should handle the load without performance degradation

  Scenario: System Recovery After Connection Loss
    Given a user is in the middle of filling out a credit card application
    When the connection is lost and then restored
    Then the system should recover gracefully
    And the partially entered data should be preserved

  Scenario: Data Encryption
    Given a user submits sensitive personal and financial data
    When the data is transmitted and stored
    Then all sensitive information should be properly encrypted

  Scenario: Application Form User-Friendliness
    Given 100 users complete the credit card application
    When they are surveyed about the form's usability
    Then at least 90% of users should rate the form as clear and easy to use

  Scenario: Cross-Browser Compatibility
    Given the credit card application is accessed on Chrome, Firefox, and Safari
    When users complete the application on each browser
    Then the functionality and appearance should be consistent across all platforms

  Scenario: Regulatory Compliance
    Given the credit card application process is reviewed
    When checked against relevant financial regulations
    Then all regulatory requirements should be met and documented
