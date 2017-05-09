//var exec = require('cordova/exec');
//
//exports.coolMethod = function(arg0, success, error) {
//    exec(success, error, "helloworld-plugin", "coolMethod", [arg0]);
//};

module.exports = {

    showPicker:function (arg, successCallback, errorCallback) {

        cordova.exec(successCallback, errorCallback, "YHPickerview", "showPicker", [arg]);
    },
    hidePicker:function (arg, successCallback, errorCallback) {

        cordova.exec(successCallback, errorCallback, "YHPickerview", "hidePicker", [arg]);
    },
    destoryPicker:function (arg, successCallback, errorCallback) {

        cordova.exec(successCallback, errorCallback, "YHPickerview", "destoryPicker", [arg]);
    }


};
