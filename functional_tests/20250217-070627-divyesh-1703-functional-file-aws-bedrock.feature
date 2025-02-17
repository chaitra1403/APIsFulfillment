Feature: Credit Card Management System API

  Scenario: Successful Credit Card Application Submission
    Given the API base URL is "https://api.creditcardmanagement.com"
    And I have valid personal information, income details, and contact information
    When I send a POST request to "/applications" with the valid information
    Then the response status should be 201
    And the response should contain a confirmation message
    And the response should include an application ID

  Scenario: Invalid Credit Card Application Submission
    Given the API base URL is "https://api.creditcardmanagement.com"
    And I have incomplete personal information
    When I send a POST request to "/applications" with the incomplete information
    Then the response status should be 400
    And the response should contain an error message
    And the error message should specify the missing or invalid information

  Scenario: Successful Fee Waiver
    Given the API base URL is "https://api.creditcardmanagement.com"
    And I have a customer ID with a positive history
    When I send a PUT request to "/accounts/{customerID}/fees/{feeID}/waive"
    Then the response status should be 200
    And the response should confirm the fee has been waived
    And the response should include the updated account balance

  Scenario: Fee Waiver Denial
    Given the API base URL is "https://api.creditcardmanagement.com"
    And I have a customer ID with a negative history
    When I send a PUT request to "/accounts/{customerID}/fees/{feeID}/waive"
    Then the response status should be 403
    And the response should contain a denial message
    And the response should include an explanation for the denial

  Scenario: Successful Points Redemption
    Given the API base URL is "https://api.creditcardmanagement.com"
    And I have a customer ID with sufficient points
    When I send a POST request to "/accounts/{customerID}/redeem" with valid reward details
    Then the response status should be 200
    And the response should confirm the reward has been claimed
    And the response should include the updated points balance

  Scenario: Insufficient Points for Redemption
    Given the API base URL is "https://api.creditcardmanagement.com"
    And I have a customer ID with insufficient points
    When I send a POST request to "/accounts/{customerID}/redeem" with reward details
    Then the response status should be 400
    And the response should contain an error message about insufficient points

  Scenario: Approved Credit Limit Increase
    Given the API base URL is "https://api.creditcardmanagement.com"
    And I have a customer ID with positive creditworthiness
    When I send a PUT request to "/accounts/{customerID}/credit-limit" with an increase amount
    Then the response status should be 200
    And the response should confirm the credit limit increase
    And the response should include the new credit limit

  Scenario: Denied Credit Limit Increase
    Given the API base URL is "https://api.creditcardmanagement.com"
    And I have a customer ID with negative creditworthiness
    When I send a PUT request to "/accounts/{customerID}/credit-limit" with an increase amount
    Then the response status should be 403
    And the response should contain a denial message

  Scenario: Credit Limit Reduction
    Given the API base URL is "https://api.creditcardmanagement.com"
    And I have a customer ID with changed financial situation
    When I send a PUT request to "/accounts/{customerID}/credit-limit" with a reduction amount
    Then the response status should be 200
    And the response should confirm the credit limit reduction
    And the response should include the new credit limit

  Scenario: Credit Limit Reduction Below Current Balance
    Given the API base URL is "https://api.creditcardmanagement.com"
    And I have a customer ID with a current balance
    When I send a PUT request to "/accounts/{customerID}/credit-limit" with a reduction amount below the current balance
    Then the response status should be 400
    And the response should contain an error message about the invalid reduction

  Scenario: Successful Balance Transfer
    Given the API base URL is "https://api.creditcardmanagement.com"
    And I have a customer ID eligible for balance transfer
    When I send a POST request to "/accounts/{customerID}/balance-transfer" with valid transfer details
    Then the response status should be 200
    And the response should confirm the balance transfer
    And the response should include the updated account details

  Scenario: Balance Transfer Exceeding Limit
    Given the API base URL is "https://api.creditcardmanagement.com"
    And I have a customer ID with a specified credit limit
    When I send a POST request to "/accounts/{customerID}/balance-transfer" with an amount exceeding the available credit
    Then the response status should be 400
    And the response should contain an error message about exceeding the limit

  Scenario: Application Response Time
    Given the API base URL is "https://api.creditcardmanagement.com"
    When I send a POST request to "/applications" with valid information
    Then the response should be received within 3 seconds

  Scenario: Concurrent Application Handling
    Given the API base URL is "https://api.creditcardmanagement.com"
    When I send 100 concurrent POST requests to "/applications" with valid information
    Then all responses should be received within 30 seconds
    And at least 95% of the responses should have a status of 201

  Scenario: System Recovery After Connection Loss
    Given the API base URL is "https://api.creditcardmanagement.com"
    And I have started a POST request to "/applications" with valid information
    When the connection is lost before the request is completed
    And I resend the POST request to "/applications" with the same information
    Then the response status should be 201
    And the response should contain a confirmation message
    And the response should include an application ID

  Scenario: Data Encryption Verification
    Given the API base URL is "https://api.creditcardmanagement.com"
    When I send a POST request to "/applications" with sensitive information
    Then the request should be sent over HTTPS
    And the response should be received over HTTPS

  Scenario: Cross-Platform Compatibility
    Given the API base URL is "https://api.creditcardmanagement.com"
    When I send a GET request to "/application-form" from different user agents
    Then the response status should be 200 for all requests
    And the response content should be consistent across all user agents

  Scenario: Regulatory Compliance Check
    Given the API base URL is "https://api.creditcardmanagement.com"
    When I send a GET request to "/compliance/report"
    Then the response status should be 200
    And the response should contain a compliance report
    And the compliance report should confirm adherence to all relevant financial regulations
