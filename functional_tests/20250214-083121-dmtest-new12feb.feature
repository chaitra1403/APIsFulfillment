Feature: Credit Card Lifecycle API

  Scenario: Successful Credit Card Application Submission
    Given the API endpoint for credit card application is "/apply"
    And I have valid personal information, income details, and contact information
    When I send a POST request to "/apply" with the valid information
    Then the response status should be 201
    And the response should contain a confirmation message
    And the response should include an application ID

  Scenario: Invalid Credit Card Application Submission
    Given the API endpoint for credit card application is "/apply"
    And I have incomplete personal information
    When I send a POST request to "/apply" with the incomplete information
    Then the response status should be 400
    And the response should contain error messages highlighting missing fields

  Scenario: Successful Fee Waiver
    Given the API endpoint for fee waiver is "/accounts/{accountId}/waive-fee"
    And I have a valid account ID
    And the account has an unexpected fee
    When I send a PUT request to "/accounts/{accountId}/waive-fee" with the fee details
    Then the response status should be 200
    And the response should confirm the fee has been waived
    And the response should include the updated account balance

  Scenario: Fee Waiver Rejection
    Given the API endpoint for fee waiver is "/accounts/{accountId}/waive-fee"
    And I have a valid account ID with poor account history
    When I send a PUT request to "/accounts/{accountId}/waive-fee" with the fee details
    Then the response status should be 403
    And the response should contain a message explaining the rejection reason

  Scenario: Successful Points Redemption
    Given the API endpoint for points redemption is "/accounts/{accountId}/redeem-points"
    And I have a valid account ID with sufficient points
    When I send a POST request to "/accounts/{accountId}/redeem-points" with redemption details
    Then the response status should be 200
    And the response should confirm the points redemption
    And the response should include the gift card details
    And the response should show the updated points balance

  Scenario: Insufficient Points for Redemption
    Given the API endpoint for points redemption is "/accounts/{accountId}/redeem-points"
    And I have a valid account ID with insufficient points
    When I send a POST request to "/accounts/{accountId}/redeem-points" with redemption details
    Then the response status should be 400
    And the response should contain an error message about insufficient points

  Scenario: Automatic Credit Limit Increase
    Given the API endpoint for credit limit management is "/accounts/{accountId}/credit-limit"
    And I have a valid account ID with excellent payment history
    When the system sends a PUT request to "/accounts/{accountId}/credit-limit" for evaluation
    Then the response status should be 200
    And the response should contain the new credit limit
    And the response should include a notification message for the customer

  Scenario: Manual Credit Limit Increase Request
    Given the API endpoint for credit limit requests is "/accounts/{accountId}/request-limit-increase"
    And I have a valid account ID
    When I send a POST request to "/accounts/{accountId}/request-limit-increase" with increase details
    Then the response status should be 202
    And the response should confirm the request is under review

  Scenario: Risk-Based Credit Limit Reduction
    Given the API endpoint for credit limit management is "/accounts/{accountId}/credit-limit"
    And I have a valid account ID with declining credit score
    When the system sends a PUT request to "/accounts/{accountId}/credit-limit" for reduction
    Then the response status should be 200
    And the response should contain the new reduced credit limit
    And the response should include a notification message for the customer

  Scenario: Successful Balance Transfer
    Given the API endpoint for balance transfers is "/accounts/{accountId}/balance-transfer"
    And I have a valid account ID with sufficient available credit
    When I send a POST request to "/accounts/{accountId}/balance-transfer" with transfer details
    Then the response status should be 200
    And the response should confirm the balance transfer
    And the response should include the promotional rate applied
    And the response should show the updated account balance

  Scenario: Balance Transfer Exceeding Available Credit
    Given the API endpoint for balance transfers is "/accounts/{accountId}/balance-transfer"
    And I have a valid account ID with insufficient available credit
    When I send a POST request to "/accounts/{accountId}/balance-transfer" with transfer details
    Then the response status should be 400
    And the response should contain an error message about insufficient available credit

  Scenario: Credit Card Application Performance Test
    Given the API endpoint for credit card application is "/apply"
    When I send 100 concurrent POST requests to "/apply" with valid information
    Then all responses should be received within 3 seconds
    And all response statuses should be 201

  Scenario: Data Encryption Verification
    Given the API endpoint for sensitive data transmission is "/accounts/{accountId}/details"
    When I send a GET request to "/accounts/{accountId}/details"
    Then the response status should be 200
    And the response headers should include encryption information
    And the response body should be encrypted

  Scenario: High Volume Application Processing
    Given the API endpoint for credit card application is "/apply"
    When I send 1000 concurrent POST requests to "/apply" with valid information
    Then all responses should be received
    And all response statuses should be 201
    And the system should maintain consistent performance

  Scenario: Regulatory Compliance for Credit Limit Changes
    Given the API endpoint for credit limit management is "/accounts/{accountId}/credit-limit"
    When I send a PUT request to "/accounts/{accountId}/credit-limit" with new limit details
    Then the response status should be 200
    And the response should include a compliance verification status
    And the compliance status should be "Passed"
