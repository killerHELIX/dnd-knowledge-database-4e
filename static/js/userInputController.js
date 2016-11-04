var userInput = angular.module('userInput', []);
var socket = io.connect('https://' + document.domain + ':' + location.port);

userInput.controller('ChatController', function($scope) {

    socket.on('connect', function() {
        console.log('connected');
    });
});