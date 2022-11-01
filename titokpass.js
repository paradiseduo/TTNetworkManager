/*
	This script bypasses SSL pinning that TikTok has and may change in the future.
	This is for educational purposes only.
	
	To run, run the following command:
	frida -U -f com.ss.iphone.ugc.Aweme -l titokpass.js
	Please note this will only work on Jailbroken iOS devices. You must have frida installed prior to running this script.
*/

Interceptor.attach(ObjC.classes.TTHttpTask["- skipSSLCertificateError"].implementation, {
	onEnter: function (args) {

	},
	onLeave: function (retval) {
		retval.replace(0x1)
	}
});


Interceptor.attach(ObjC.classes.TTNetworkManager["- ServerCertificate"].implementation, {
	onEnter: function (args) {

	},
	onLeave: function (retval) {
		retval.replace(0x0)
	}
});


console.log('Successfully Initalized SSL Bypass...');
