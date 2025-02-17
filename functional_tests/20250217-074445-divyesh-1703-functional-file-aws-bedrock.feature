Feature: Credit Card Management System API

  Scenario: Successful Credit Card Application
    Given the API base URL is "https://api.creditcard.com"
    When I send a POST request to "/applications" with the following payload:
      """
      {
        "firstName": "John",
        "lastName": "Doe",
        "ssn": "123-45-6789",
        "income": 50000,
        "email": "john.doe@example.com"
      }
      """
    Then the response status should be 201
    And the response should contain "applicationId"
    And the response should contain "Application submitted successfully"

  Scenario: Invalid Credit Card Application
    Given the API base URL is "https://api.creditcard.com"
    When I send a POST request to "/applications" with the following payload:
      """
      {
        "firstName": "Jane",
        "lastName": "Doe",
        "ssn": "invalid-ssn",
        "income": 45000
      }
      """
    Then the response status should be 400
    And the response should contain "Invalid SSN format"
    And the response should contain "Email is required"

  Scenario: Successful Fee Waiver
    Given the API base URL is "https://api.creditcard.com"
    And a user with id "12345" exists
    When I send a PUT request to "/users/12345/waive-fee" with the following payload:
      """
      {
        "feeType": "late_payment",
        "amount": 35.00
      }
      """
    Then the response status should be 200
    And the response should contain "Fee successfully waived"
    And the response should contain "updatedBalance"

  Scenario: Redeem Points for Gift Card
    Given the API base URL is "https://api.creditcard.com"
    And a user with id "12345" has 15000 points
    When I send a POST request to "/users/12345/redeem-points" with the following payload:
      """
      {
        "pointsToRedeem": 10000,
        "rewardType": "gift_card",
        "rewardValue": 100
      }
      """
    Then the response status should be 200
    And the response should contain "Points redeemed successfully"
    And the response should contain "remainingPoints": 5000
    And the response should contain "giftCardCode"

  Scenario: Automatic Credit Limit Increase
    Given the API base URL is "https://api.creditcard.com"
    And a user with id "12345" has good credit history
    When I send a GET request to "/users/12345/evaluate-credit-limit"
    Then the response status should be 200
    And the response should contain "creditLimitIncreased": true
    And the response should contain "newCreditLimit"

  Scenario: Risk-Based Credit Limit Reduction
    Given the API base URL is "https://api.creditcard.com"
    And a user with id "67890" has a declining credit score
    When I send a GET request to "/users/67890/evaluate-credit-limit"
    Then the response status should be 200
    And the response should contain "creditLimitDecreased": true
    And the response should contain "newCreditLimit"
    And the response should contain "reason": "Declining credit score"

  Scenario: Successful Balance Transfer
    Given the API base URL is "https://api.creditcard.com"
    And a user with id "12345" has available credit
    When I send a POST request to "/users/12345/balance-transfer" with the following payload:
      """
      {
        "amount": 5000,
        "sourceCardNumber": "1234567890123456",
        "promotionalApr": 0.0
      }
      """
    Then the response status should be 200
    And the response should contain "transferSuccessful": true
    And the response should contain "newBalance"
    And the response should contain "promotionalAprApplied": true

  Scenario: Performance Test - Application Processing Time
    Given the API base URL is "https://api.creditcard.com"
    When I send 100 POST requests to "/applications" with valid payloads
    Then all responses should be received within 30 seconds
    And all response statuses should be 201

  Scenario: Security Test - Unauthorized Access Attempt
    Given the API base URL is "https://api.creditcard.com"
    When I send a GET request to "/users/12345/account-info" without authentication
    Then the response status should be 401
    And the response should contain "Unauthorized access"

  Scenario: Reliability Test - System Uptime Check
    Given the API base URL is "https://api.creditcard.com"
    When I send a GET request to "/system/health"
    Then the response status should be 200
    And the response should contain "status": "UP"
    And the response should contain "uptime"
