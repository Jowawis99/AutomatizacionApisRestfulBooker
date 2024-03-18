Feature: Token

  Background:
    Given url apiUrl
    Given path 'auth'

  Scenario: Creación Exitosa de Token
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
    * def accessToken = response.token