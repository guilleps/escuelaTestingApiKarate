function fn() {
    var env = karate.env; // get system property 'karate.env'
    karate.log('karate.env system property was:', env);
    if (!env) {
        env = 'dev';
    }

    var apiPetStore;
    if (env == 'dev') {
        apiPetStore = "https://petstore.swagger.io/v2"
    } else if (env == 'e2e') {
        // customize
    }

    var config = {
        env: env,
        myVarName: 'someValue',
        apiPetStore: apiPetStore
    }

    return config;
}