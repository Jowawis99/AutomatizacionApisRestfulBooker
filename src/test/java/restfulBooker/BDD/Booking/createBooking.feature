Feature: Crear una nueva Reserva

  Background:
    Given url apiUrl
    Given path 'booking'
    * def schemaCreateBooking = read('classpath:restfulBooker/req/Booking/schema-post-booking-200.json')

  Scenario Outline: Creación exitosa de una nueva reserva
    And header Accept = 'application/json'
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
    When method Post
    Then status 200
    And match response == "#object"
    And match response contains schemaCreateBooking
    And match response.booking.firstname contains "<firstname>"
    And match response.booking.lastname contains "<lastname>"
    And match response.booking.totalprice == <totalprice>
    And match response.booking.depositpaid == <depositpaid>
    And match response.booking.bookingdates.checkin contains "<checkin>"
    And match response.booking.bookingdates.checkout contains "<checkout>"
    And match response.booking.additionalneeds contains "<additionalneeds>"
    Examples:
      |read('classpath:restfulBooker/Data/Booking/create-booking-v1-POST-200.csv')|

  Scenario Outline: Creación exitosa de una nueva reserva - Sin enviar campo additionalneeds
    And header Accept = 'application/json'
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
          }
        }
    """
    When method Post
    Then status 200
    And match response == "#object"
    And match response contains schemaCreateBooking
    And match response.booking.firstname contains "<firstname>"
    And match response.booking.lastname contains "<lastname>"
    And match response.booking.totalprice == <totalprice>
    And match response.booking.depositpaid == <depositpaid>
    And match response.booking.bookingdates.checkin contains "<checkin>"
    And match response.booking.bookingdates.checkout contains "<checkout>"
    * def isAdditionalNeedsPresent = response.booking['additionalneeds'] != null
    * def additionalNeedsMatch = isAdditionalNeedsPresent ? (response.booking.additionalneeds == '<additionalneeds>') : true
    * assert additionalNeedsMatch
    Examples:
      |read('classpath:restfulBooker/Data/Booking/create-booking-v2-POST-200.csv')|