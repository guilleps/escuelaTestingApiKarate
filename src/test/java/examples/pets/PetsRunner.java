package examples.pets;

import com.intuit.karate.junit5.Karate;

// comando de ejecucion de prueba: mvn clean test -Dtest=PetsRunner -Dkarate.options="--tags @TEST-1" -Dkarate.env=dev
class PetsRunner {
    
    @Karate.Test
    Karate testPets() {
        return Karate.run("pets").relativeTo(getClass());
    }    

}
