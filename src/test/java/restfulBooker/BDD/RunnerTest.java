package restfulBooker.BDD;

import com.intuit.karate.junit5.Karate;

class RunnerTest {
    
    @Karate.Test
    Karate testUsers() {
        return Karate.run("Booking/createBooking.feature").relativeTo(getClass());
    }    

}
