Feature: Verificar estado API

  Background:
    Given url apiUrl
    Given path 'ping'

  Scenario Outline: Verificación exitosa del funcionamiento del API
    When method Get
    Then status <code>
    And match response == "<msjCode>"
    Examples:
      | code | msjCode |
      | 201  | Created |
      | 201  | Created |
      | 201  | Created |