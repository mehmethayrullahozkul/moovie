import Ajv from "ajv"
import fastUri from 'fast-uri'

const ajv = new Ajv({
    code: {esm: true},
    coerceTypes: 'array', // change data type of data to match type keyword
    useDefaults: true, // replace missing properties and items with the values from corresponding default keyword
    removeAdditional: true, // remove additional properties if additionalProperties is set to false, see: https://ajv.js.org/guide/modifying-data.html#removing-additional-properties
    uriResolver: fastUri,
    addUsedSchema: false,
    // Explicitly set allErrors to `false`.
    // When set to `true`, a DoS attack is possible.
    allErrors: false
});


export default ajv;

