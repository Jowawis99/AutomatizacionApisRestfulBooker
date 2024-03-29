Feature: Token

  Background:
    Given url apiUrl

  Scenario: Creación Exitosa de Token
    Given path 'auth'
    And header Content-Type = 'application/json'
    And request
    """
    {
    "username" : "admin",
    "password" : "password123"
    }
    """
    When method Post
    Then status 200
    And match response == "#object"
    And match response.token == '#notnull'

  Scenario Outline: Creación No exitosa de Token
    Given path 'auth'
    And header Content-Type = 'application/json'
    And request
    """
    {
    "username" : "<username>",
    "password" : "<password>"
    }
    """
    When method Post
    Then status 200
    And match response == "#object"
    And match response.reason == 'Bad credentials'
    Examples:
      | username | password     |
      | admin1   | password123  |
      | admin    | password1234 |
      |          | password123  |
      | admin    |              |
      |          |              |