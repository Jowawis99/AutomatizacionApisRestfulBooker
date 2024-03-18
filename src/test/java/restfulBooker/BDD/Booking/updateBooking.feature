Feature: Actualizar una nueva Reserva

  Background:
    * def getToken = call read('classpath:restfulBooker/BDD/Auth/getToken.feature')
    * def token = getToken.accessToken
    Given url apiUrl
    * def schemaCreateBooking = read('classpath:restfulBooker/req/Booking/schema-put-booking-200.json')

  Scenario Outline: Actualización exitosa de una reserva
    Given path 'booking/<idBooking>'
    And header Accept = 'application/json'
    And header Content-Type = 'application/json'
    And header Cookie = 'token=' + token
    And request
    """
        {
          "firstname" : "<firstname>",
          "lastname" : "<lastname>",
          "totalprice" : <totalprice>,
          "depositpaid" : <depositpaid>,
          "bookingdates" : {
              "checkin" : "<checkin>",
              "checkout" : "<checkout>"
          },
          "additionalneeds" : "<additionalneeds>"
        }
    """
    When method Put
    Then status 200
    And match response == "#object"
    And match response contains schemaCreateBooking
    And match response.firstname contains "<firstname>"
    And match response.lastname contains "<lastname>"
    And match response.totalprice == <totalprice>
    And match response.depositpaid == <depositpaid>
    And match response.bookingdates.checkin contains "<checkin>"
    And match response.bookingdates.checkout contains "<checkout>"
    And match response.additionalneeds contains "<additionalneeds>"
    Examples:
      |read('classpath:restfulBooker/Data/Booking/update-booking-v1-PUT-200.csv')|