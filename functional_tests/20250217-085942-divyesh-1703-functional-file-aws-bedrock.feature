Feature: Credit Card Management System API

  Scenario: Successful online credit card application submission
    Given the API base URL is "http://api.creditcardmanagement.com"
    And I have valid personal information, income details, and contact information
    When I send a POST request to "/applications" with the valid information
    Then the response status should be 201
    And the response should contain a confirmation message
    And the response should include an application ID

  Scenario: Unsuccessful credit card application due to incomplete information
    Given the API base URL is "http://api.creditcardmanagement.com"
    And I have incomplete application information missing income details
    When I send a POST request to "/applications" with the incomplete information
    Then the response status should be 400
    And the response should contain an error message indicating missing information

  Scenario: Successful fee waiver request
    Given the API base URL is "http://api.creditcardmanagement.com"
    And I have a valid account ID "ACC123"
    And I have a late payment fee of $35
    When I send a PUT request to "/accounts/ACC123/fee-waiver" with reason "unexpected late payment"
    Then the response status should be 200
    And the response should confirm the fee has been waived
    And the account balance should be updated

  Scenario: Rejected fee waiver request
    Given the API base URL is "http://api.creditcardmanagement.com"
    And I have a valid account ID "ACC456"
    And I have an annual fee of $95
    When I send a PUT request to "/accounts/ACC456/fee-waiver" with reason "annual fee waiver"
    Then the response status should be 403
    And the response should contain a message explaining the rejection reason

  Scenario: Successful points redemption for gift card
    Given the API base URL is "http://api.creditcardmanagement.com"
    And I have a valid account ID "ACC789"
    And I have a points balance of 10000
    When I send a POST request to "/accounts/ACC789/redeem-points" with gift card selection and 5000 points
    Then the response status should be 200
    And the response should confirm the gift card issuance
    And the points balance should be updated to 5000

  Scenario: Failed points redemption due to insufficient balance
    Given the API base URL is "http://api.creditcardmanagement.com"
    And I have a valid account ID "ACC101"
    And I have a points balance of 1000
    When I send a POST request to "/accounts/ACC101/redeem-points" with gift card selection and 2000 points
    Then the response status should be 400
    And the response should contain an error message about insufficient points

  Scenario: Automatic credit limit increase
    Given the API base URL is "http://api.creditcardmanagement.com"
    And I have a valid account ID "ACC202"
    When I send a GET request to "/accounts/ACC202/credit-limit"
    Then the response status should be 200
    And the response should show an increased credit limit
    And the response should include a notification about the increase

  Scenario: Manual credit limit increase request
    Given the API base URL is "http://api.creditcardmanagement.com"
    And I have a valid account ID "ACC303"
    When I send a PUT request to "/accounts/ACC303/credit-limit" with a new limit of $10000
    Then the response status should be 200
    And the response should confirm the new credit limit
    And the response should include a notification about the increase

  Scenario: Risk-based credit limit decrease
    Given the API base URL is "http://api.creditcardmanagement.com"
    And I have a valid account ID "ACC404"
    When the system sends a PUT request to "/accounts/ACC404/credit-limit" with a decreased limit
    Then the response status should be 200
    And the response should confirm the new lower credit limit
    And the response should include an explanation for the decrease

  Scenario: Successful balance transfer
    Given the API base URL is "http://api.creditcardmanagement.com"
    And I have a valid account ID "ACC505"
    When I send a POST request to "/accounts/ACC505/balance-transfer" with transfer details
    Then the response status should be 200
    And the response should confirm the balance transfer
    And the response should show the promotional rate applied

  Scenario: Failed balance transfer due to exceeding credit limit
    Given the API base URL is "http://api.creditcardmanagement.com"
    And I have a valid account ID "ACC606"
    When I send a POST request to "/accounts/ACC606/balance-transfer" with an amount exceeding the available credit
    Then the response status should be 400
    And the response should contain an error message about exceeding credit limit

  Scenario: Verify credit card application response time
    Given the API base URL is "http://api.creditcardmanagement.com"
    When I send a POST request to "/applications" with valid application data
    Then the response should be received within 5 seconds

  Scenario: Verify encryption of sensitive data during transmission
    Given the API base URL is "http://api.creditcardmanagement.com"
    When I monitor data transmission during a POST request to "/applications"
    Then all personal and financial data should be encrypted in transit

  Scenario: Test system recovery after unexpected shutdown
    Given the API base URL is "http://api.creditcardmanagement.com"
    And a transaction is in progress
    When the system experiences an unexpected shutdown
    And the system restarts
    Then all API endpoints should be accessible
    And the in-progress transaction should either be completed or rolled back
