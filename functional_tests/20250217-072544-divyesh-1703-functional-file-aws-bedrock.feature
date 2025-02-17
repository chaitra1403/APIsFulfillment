Feature: API Testing for Test Management System

  # JIRA Integration Tests
  Scenario: Verify JIRA connection
    Given the API base URL is "http://api.testmanagement.com"
    When I send a POST request to "/jira/connect" with the following data:
      | email    | hostname         |
      | user@example.com | jira.example.com |
    Then the response status should be 200
    And the response body should contain "Connection successful"

  Scenario: Fetch JIRA ticket details
    Given the API base URL is "http://api.testmanagement.com"
    When I send a GET request to "/jira/ticket/PROJ-123"
    Then the response status should be 200
    And the response body should contain "title"
    And the response body should contain "description"
    And the response body should contain "comments"

  Scenario: Handle invalid JIRA ticket ID
    Given the API base URL is "http://api.testmanagement.com"
    When I send a GET request to "/jira/ticket/INVALID-ID"
    Then the response status should be 404
    And the response body should contain "Ticket not found"

  # AI Model Integration Tests
  Scenario: Verify AI model connection
    Given the API base URL is "http://api.testmanagement.com"
    When I send a POST request to "/ai/connect" with valid AI model credentials
    Then the response status should be 200
    And the response body should contain "AI model connected successfully"

  Scenario: Generate test cases using AI
    Given the API base URL is "http://api.testmanagement.com"
    When I send a POST request to "/ai/generate-tests" with the following data:
      | ticketId | PROJ-123 |
    Then the response status should be 200
    And the response body should contain "generatedTestCases"

  Scenario Outline: Adjust AI temperature setting
    Given the API base URL is "http://api.testmanagement.com"
    When I send a POST request to "/ai/generate-tests" with the following data:
      | ticketId    | PROJ-123   |
      | temperature | <temp_val> |
    Then the response status should be 200
    And the response body should contain "generatedTestCases"

    Examples:
      | temp_val |
      | 0.1      |
      | 0.5      |
      | 0.9      |

  # Test Creation and Management
  Scenario: Create functional test
    Given the API base URL is "http://api.testmanagement.com"
    When I send a POST request to "/tests" with the following data:
      | title            | Test Login Functionality        |
      | steps            | 1. Open login page...           |
      | expectedResults  | User should be logged in...     |
    Then the response status should be 201
    And the response body should contain "testId"

  Scenario: Create test without git information
    Given the API base URL is "http://api.testmanagement.com"
    When I send a POST request to "/tests" with the following data:
      | title            | Test Registration               |
      | steps            | 1. Open registration page...    |
      | expectedResults  | User should be registered...    |
      | jiraIds          | PROJ-123, PROJ-124              |
    Then the response status should be 201
    And the response body should contain "testId"

  Scenario: Attempt to create test without git info and JIRA IDs
    Given the API base URL is "http://api.testmanagement.com"
    When I send a POST request to "/tests" with the following data:
      | title            | Test Profile Update             |
      | steps            | 1. Open profile page...         |
      | expectedResults  | Profile should be updated...    |
    Then the response status should be 400
    And the response body should contain "Error: Git info or JIRA IDs required"

  # Performance Tests
  Scenario: Measure response time for JIRA ticket fetch
    Given the API base URL is "http://api.testmanagement.com"
    When I send GET requests to "/jira/ticket/" for the following ticket IDs:
      | PROJ-123 |
      | PROJ-124 |
      | PROJ-125 |
    Then all responses should be received within 2 seconds

  Scenario: Measure AI test case generation time
    Given the API base URL is "http://api.testmanagement.com"
    When I send a POST request to "/ai/generate-tests" with a complex JIRA ticket
    Then the response should be received within 30 seconds

  # Scalability Tests
  Scenario: Handle multiple concurrent test creations
    Given the API base URL is "http://api.testmanagement.com"
    When I simulate 100 concurrent POST requests to "/tests"
    Then all responses should be successful
    And the average response time should be less than 5 seconds

  # Security Tests
  Scenario: Verify data encryption for JIRA credentials
    Given the API base URL is "http://api.testmanagement.com"
    When I send a POST request to "/jira/connect" with JIRA credentials
    Then the response status should be 200
    And the stored credentials should be encrypted

  Scenario: Test access control for private tests
    Given the API base URL is "http://api.testmanagement.com"
    And I am an unauthorized user
    When I send a GET request to "/tests/private/TEST-123"
    Then the response status should be 403
    And the response body should contain "Access denied"

  # Usability Tests
  Scenario: Verify UI elements for test creation
    Given the API base URL is "http://api.testmanagement.com"
    When I send a GET request to "/ui/test-creation"
    Then the response status should be 200
    And the response body should contain all required UI elements

  Scenario: Test error message clarity
    Given the API base URL is "http://api.testmanagement.com"
    When I send a POST request to "/tests" with invalid data
    Then the response status should be 400
    And the response body should contain a clear error message

  # Compatibility Tests
  Scenario Outline: Verify functionality across different browsers
    Given I am using <browser>
    When I send a GET request to "http://api.testmanagement.com/tests"
    Then the response status should be 200
    And the response body should be consistent across browsers

    Examples:
      | browser |
      | Chrome  |
      | Firefox |
      | Safari  |

  Scenario: Test responsiveness on mobile devices
    Given I am using a mobile device with screen size <screen_size>
    When I send a GET request to "http://api.testmanagement.com/ui"
    Then the response status should be 200
    And the response body should contain responsive UI elements

    Examples:
      | screen_size |
      | 375x667     |
      | 414x896     |
      | 360x640     |
