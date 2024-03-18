Feature: Obtener Reservas

  Background:
    Given url apiUrl
    * def schemaAllBooking = read('classpath:restfulBooker/req/Booking/schema-get-all-booking-200.json')
    * def schemaidBooking = read('classpath:restfulBooker/req/Booking/schema-get-id-booking-200.json')

  Scenario: Obtención de lista total de reservas sin filtros
    Given path 'booking'
    When method Get
    Then status 200
    And match response == "#array"
    And assert response.length > 0
    And match each response == schemaAllBooking

  Scenario Outline: Obtención de lista total de reservas con filtros
    Given path 'booking'
    And params {<firstname>,<lastname>,<checkin>,<checkout>}
    When method Get
    Then status 200
    And match response == "#array"
    And assert response.length > 0
    And match each response == schemaAllBooking
    Examples:
      |read('classpath:restfulBooker/Data/Booking/all-booking-v1-GET-200.csv')|

  Scenario Outline: Obtención de lista de reservas vacía
    Given path 'booking'
    And params {firstname: <firstname>,lastname: <lastname>,checkin:<checkin>,checkout:<checkout>}
    When method Get
    Then status 200
    And match response == "#array"
    And assert response.length == 0
    Examples:
      | firstname | lastname     | checkin    | checkout   |
      |           | Smith        | 2017-03-13 | 2024-03-13 |
      | John      |              | 2017-03-13 | 2024-03-13 |
      | John      | Smith        | 2037-03-13 | 2024-03-13 |
      | John      | Smith        | 2010-03-13 | 2009-03-13 |
      | 555555555 | Smith        | 2010-03-13 | 2025-03-13 |

  Scenario Outline: Obtención exitosa del detalle de una reserva
    Given path 'booking/<idBooking>'
    And header Accept = 'application/json'
    When method Get
    Then status 200
    And match response == "#object"
    And match response contains schemaidBooking
    Examples:
      |read('classpath:restfulBooker/Data/Booking/booking-v2-GET-200.csv')|

  Scenario Outline: Obtención no exitosa del detalle de una reserva
    Given path 'booking/<idBooking>'
    And header Accept = 'application/json'
    When method Get
    * print response
    Then status 404
    And assert response != null
    And match response == "Not Found"
    Examples:
      | idBooking |
      | 5555555   |
      | 1115555   |
      | 3335555   |
      | 4445555   |
      | 1235555   |