Feature: Eliminar una Reserva

  Background:
    * def getToken = call read('classpath:restfulBooker/BDD/Auth/getToken.feature')
    * def token = getToken.accessToken
    Given url apiUrl

  Scenario Outline: Eliminación exitosa de una reserva
    Given path 'booking/<idBooking>'
    And header Content-Type = 'application/json'
    And header Cookie = 'token=' + token
    When method Delete
    Then status 201
    And match response == "Created"
    Examples:
      | idBooking |
      | 16        |
      | 17        |
      | 18        |
      | 52        |

  Scenario Outline: Eliminación no exitosa de una reserva
    Given path 'booking/<idBooking>'
    And header Content-Type = 'application/json'
    And header Cookie = 'token=' + token
    When method Delete
    Then status <code>
    * print response
    And match response == "<msjCode>"
    Examples:
      | idBooking | code | msjCode             |
      | 555555    | 405  | Method Not Allowed  |
      | ASDF      | 405  | Method Not Allowed  |
      | -1        | 405  | Method Not Allowed  |
      | .         | 405  | Method Not Allowed  |