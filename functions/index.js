const functions = require('firebase-functions');
const admin = require('firebase-admin');

const serviceAccount = require('./ServiceAccountKey.json');
admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
});

exports.generateCustomToken = functions.https.onCall((data,context) => {
    return admin.auth().createCustomToken(data.uid)
        .then((customToken) => {console.log('Success: ', customToken); return customToken;})
        .catch((error) => {console.log('Error creating custom token: ',error)});
})