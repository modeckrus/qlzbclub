const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

exports.addUserClaim = functions.https.onCall((data, context) => {
	return admin.auth().getUserByEmail(data.email).then(user=>{
		return admin.auth().setCustomUserClaims(user.uid, {
			"https://dgraph.io/jwt/claims":{
				"USER": user.uid
			}
		});
	}).then(() => {
		return {
			message: `Success!`
		}
	}).catch(err => {
		 return err
	})
})
 

exports.onAddUserClaim = functions.auth.user().onCreate((user, context) => {
	return admin.auth().setCustomUserClaims(user.uid, {
		"https://dgraph.io/jwt/claims":{
			"USER": user.uid
		}
	});
})