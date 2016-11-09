var dnd = angular.module('dnd', []);

dnd.controller('inputController', function($scope) {
    var socket = io.connect('https://' + document.domain + ':' + location.port);
    
    $scope.possibleLevels = [];
    $scope.possibleRaces = ['Human', 'Dragonborn', 'Dwarf', 'Eladrin', 'Elf', 'Half-Elf', 'Halfling', 'Tiefling'];
    $scope.possibleClasses = [];
    
    $scope.selectedLevel = 'Level';
    $scope.selectedRace = 'Race';
    $scope.selectedClass = 'Class';
    
    socket.on('updateInfo', function(race) {
       console.log('Entering updateInfo in USERINPUTCONTROLLER.JS');
    });

    $scope.initLevels = function(){
        for(var i = 1; i <= 30; i++){
            $scope.possibleLevels.push(i);
        }
    };

    socket.on('connect', function() {
        console.log('connected');
        
    });
    
    $scope.initLevels();
});