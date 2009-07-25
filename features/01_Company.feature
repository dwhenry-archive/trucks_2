Feature: User Creates a new Account/Company
  In order to allow access to paid content
  As a new user
  I want to create a new company account

  Scenario: User creates a new Company
    Given no current Users
    When I go to /dashboard/home
    And I follow "Create New Account"
    Then I should see "Create New Company Account"
    When I fill in "Company Name" with "Test"
    And I fill in "ABN" with "123-1452-1254"
    And I check "Grower"
    And I fill in "Phone" with "07 4654 9196"
    And I fill in "Address Line 1" with "Moorak"
    And I fill in "Address Line 2" with "test"
    And I fill in "Town" with "Morven"
    And I fill in "Postcode" with "4468"
    And I fill in "Email Address" with "dw_henry@yahoo.com.au"
    And I fill in "Password" with "ybt486"
    And I fill in "Confirm Password" with "ybt486"
    And I follow "Create"
    Then I should see "Company way successfully created"
