Feature: Credit Card Application

  Scenario: Successfully submit a valid online credit card application
    Given the API endpoint for credit card application is "/api/credit-card/apply"
    And I have valid personal information, income details, and contact information
    When I send a POST request to "/api/credit-card/apply" with the valid information
    Then the response status should be 201
    And the response should contain a confirmation message
    And the response should include an application reference number

  Scenario: Attempt to submit an incomplete credit card application
    Given the API endpoint for credit card application is "/api/credit-card/apply"
    And I have incomplete personal information with missing required fields
    When I send a POST request to "/api/credit-card/apply" with the incomplete information
    Then the response status should be 400
    And the response should contain an error message
    And the response should highlight the missing information

  Scenario: Submit a valid in-branch credit card application
    Given the API endpoint for in-branch application is "/api/credit-card/apply/in-branch"
    And I have valid information for an in-branch application
    When I send a POST request to "/api/credit-card/apply/in-branch" with the valid information
    Then the response status should be 201
    And the response should contain a confirmation message
    And the response should include an application reference number

Feature: Fee Waiver Requests

  Scenario: Successfully request a late payment fee waiver
    Given the API endpoint for fee waiver requests is "/api/credit-card/fee-waiver"
    And I have a customer account with an unexpected late payment fee
    When I send a POST request to "/api/credit-card/fee-waiver" with the account details and fee information
    Then the response status should be 200
    And the response should indicate the waiver was approved
    And the response should confirm the fee has been removed from the statement

  Scenario: Request an annual fee waiver that gets denied
    Given the API endpoint for fee waiver requests is "/api/credit-card/fee-waiver"
    And I have a customer account with an annual fee
    When I send a POST request to "/api/credit-card/fee-waiver" with the account details and fee information
    Then the response status should be 200
    And the response should indicate the waiver was denied
    And the response should include an explanation for the denial

Feature: Redeeming Reward Points

  Scenario: Successfully redeem points for a gift card
    Given the API endpoint for point redemption is "/api/credit-card/redeem-points"
    And I have a customer account with 10000 reward points
    When I send a POST request to "/api/credit-card/redeem-points" with the redemption details for a $100 gift card
    Then the response status should be 200
    And the response should confirm successful redemption
    And the response should include the gift card details
    And the response should show an updated points balance of 0

  Scenario: Attempt to redeem points with insufficient balance
    Given the API endpoint for point redemption is "/api/credit-card/redeem-points"
    And I have a customer account with 5000 reward points
    When I send a POST request to "/api/credit-card/redeem-points" with the redemption details for a $100 gift card
    Then the response status should be 400
    And the response should contain an error message indicating insufficient points

Feature: Credit Limit Adjustments

  Scenario: Bank initiates a credit limit increase
    Given the API endpoint for credit limit adjustments is "/api/credit-card/adjust-limit"
    And I have a customer with good credit history and stable income
    When I send a PUT request to "/api/credit-card/adjust-limit" with the account details and new limit
    Then the response status should be 200
    And the response should confirm the credit limit increase
    And the response should include the new credit limit amount

  Scenario: Bank initiates a credit limit decrease
    Given the API endpoint for credit limit adjustments is "/api/credit-card/adjust-limit"
    And I have a customer with declining credit score
    When I send a PUT request to "/api/credit-card/adjust-limit" with the account details and new lower limit
    Then the response status should be 200
    And the response should confirm the credit limit decrease
    And the response should include the new credit limit amount

Feature: Balance Transfers

  Scenario: Process a promotional balance transfer
    Given the API endpoint for balance transfers is "/api/credit-card/balance-transfer"
    And I have an existing cardholder with an eligible account
    When I send a POST request to "/api/credit-card/balance-transfer" with the transfer details
    Then the response status should be 200
    And the response should confirm successful balance transfer
    And the response should include the promotional interest rate applied

Feature: Non-Functional Requirements

  Scenario: Measure response time for credit card application submission
    Given the API endpoint for credit card application is "/api/credit-card/apply"
    When I send a POST request to "/api/credit-card/apply" with valid application data
    Then the response should be received within 5 seconds

  Scenario: Verify encryption of sensitive customer data
    Given the API endpoint for credit card application is "/api/credit-card/apply"
    When I send a POST request to "/api/credit-card/apply" with sensitive customer data
    Then the request should be sent over HTTPS
    And the response should indicate that the data was securely processed

  Scenario: Test system scalability with concurrent applications
    Given the API endpoint for credit card application is "/api/credit-card/apply"
    When I send 1000 concurrent POST requests to "/api/credit-card/apply" with valid application data
    Then all requests should be processed successfully
    And the average response time should not exceed 10 seconds

  Scenario: Verify system behavior during network interruptions
    Given the API endpoint for credit card application is "/api/credit-card/apply"
    And a network interruption occurs during the application submission
    When I retry the POST request to "/api/credit-card/apply" after the network is restored
    Then the response status should be 200
    And the response should indicate that the application was successfully submitted
