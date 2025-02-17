Feature: Credit Card Management System API

  Scenario: Successful Credit Card Application Submission
    Given the API base URL is "http://api.creditcard.com"
    And I have valid personal information, income details, and contact information
    When I send a POST request to "/applications" with the application data
    Then the response status should be 201
    And the response should contain a confirmation message
    And the response should include an application reference number

  Scenario: Invalid Credit Card Application Submission
    Given the API base URL is "http://api.creditcard.com"
    And I have incomplete personal information
    When I send a POST request to "/applications" with the incomplete data
    Then the response status should be 400
    And the response should contain an error message highlighting missing information

  Scenario: Check Application Status
    Given the API base URL is "http://api.creditcard.com"
    And I have a valid application reference number "APP123456"
    When I send a GET request to "/applications/APP123456/status"
    Then the response status should be 200
    And the response should contain the current status of the application

  Scenario: Successful Charge Waiver
    Given the API base URL is "http://api.creditcard.com"
    And I have a customer ID "CUST987654"
    When I send a POST request to "/customers/CUST987654/waivers" with waiver details
    Then the response status should be 200
    And the response should confirm the fee has been waived
    And the response should include the updated account balance

  Scenario: Charge Waiver Rejection
    Given the API base URL is "http://api.creditcard.com"
    And I have a customer ID "CUST123456"
    When I send a POST request to "/customers/CUST123456/waivers" with waiver details
    Then the response status should be 403
    And the response should contain a reason for the waiver rejection

  Scenario: Successful Points Redemption
    Given the API base URL is "http://api.creditcard.com"
    And I have a customer ID "CUST246810"
    When I send a POST request to "/customers/CUST246810/redeem" with redemption details
    Then the response status should be 200
    And the response should confirm the points have been redeemed
    And the response should include the updated points balance

  Scenario: Insufficient Points for Redemption
    Given the API base URL is "http://api.creditcard.com"
    And I have a customer ID "CUST135790"
    When I send a POST request to "/customers/CUST135790/redeem" with redemption details
    Then the response status should be 400
    And the response should contain an error message about insufficient points

  Scenario: Automatic Credit Limit Increase
    Given the API base URL is "http://api.creditcard.com"
    And I have a customer ID "CUST369258"
    When I send a GET request to "/customers/CUST369258/credit-limit"
    Then the response status should be 200
    And the response should show an increased credit limit
    And the response should include a notification about the increase

  Scenario: Manual Credit Limit Increase Request
    Given the API base URL is "http://api.creditcard.com"
    And I have a customer ID "CUST159753"
    When I send a POST request to "/customers/CUST159753/credit-limit-increase" with increase details
    Then the response status should be 202
    And the response should confirm the request is being processed

  Scenario: Risk-Based Credit Limit Reduction
    Given the API base URL is "http://api.creditcard.com"
    And I have a customer ID "CUST753951"
    When I send a GET request to "/customers/CUST753951/credit-limit"
    Then the response status should be 200
    And the response should show a reduced credit limit
    And the response should include an explanation for the reduction

  Scenario: Credit Limit Reduction Below Current Balance
    Given the API base URL is "http://api.creditcard.com"
    And I have a customer ID "CUST852456"
    When I send a POST request to "/customers/CUST852456/credit-limit-decrease" with decrease details
    Then the response status should be 400
    And the response should contain an error message about the current balance

  Scenario: Successful Balance Transfer
    Given the API base URL is "http://api.creditcard.com"
    And I have a customer ID "CUST741852"
    When I send a POST request to "/customers/CUST741852/balance-transfer" with transfer details
    Then the response status should be 200
    And the response should confirm the balance transfer
    And the response should include the promotional rate applied

  Scenario: Balance Transfer Exceeding Limit
    Given the API base URL is "http://api.creditcard.com"
    And I have a customer ID "CUST963852"
    When I send a POST request to "/customers/CUST963852/balance-transfer" with transfer details exceeding the limit
    Then the response status should be 400
    And the response should contain an error message about exceeding the credit limit

  Scenario: Application Response Time
    Given the API base URL is "http://api.creditcard.com"
    When I send a POST request to "/applications" with valid application data
    Then the response should be received within 3 seconds

  Scenario: Data Encryption Check
    Given the API base URL is "http://api.creditcard.com"
    When I send a POST request to "/applications" with sensitive information
    Then the request payload should be encrypted
    And the response payload should be encrypted

  Scenario: System Recovery After Crash
    Given the API base URL is "http://api.creditcard.com"
    And a system crash has occurred during an application process
    When the system recovers and I send a GET request to "/applications/last-incomplete"
    Then the response status should be 200
    And the response should contain the last saved state of the application

  Scenario: Cross-Browser API Compatibility
    Given I am using <browser>
    When I send API requests to all endpoints
    Then all responses should be consistent across browsers

    Examples:
      | browser |
      | Chrome  |
      | Firefox |
      | Safari  |
      | Edge    |
