var dnd = angular.module('dnd', ['ngSanitize']);

dnd.controller('inputController', function($scope, $sce) {
    var socket = io.connect('https://' + document.domain + ':' + location.port);
    
    $scope.possibleLevels = [];
    $scope.possibleRaces = ['Human', 'Dragonborn', 'Dwarf', 'Eladrin', 'Elf', 'Half-Elf', 'Halfling', 'Tiefling'];
    $scope.possibleClasses = ['Cleric', 'Fighter', 'Paladin', 'Ranger', 'Rogue', 'Warlock', 'Warlord', 'Wizard'];
    $scope.statsEntered = false;
    
    $scope.selectedLevel = 'Level';
    $scope.selectedRace = 'Race';
    $scope.selectedClass = 'Class';
    
    $scope.classInfo = [];
    $scope.raceInfo = [];
    $scope.features = "";
    
    socket.on('updateClassInfo', function(Class) {
       console.log('Entering updateInfo in USERINPUTCONTROLLER.JS');
       console.log(Class);
       $scope.classInfo.push(Class);
       $scope.$apply();
       console.log($scope.classInfo[0].features);
       $scope.features = $sce.trustAsHtml($scope.classInfo[0].features);
       console.log($scope.features);
       $scope.$apply();
       
       document.getElementById("go").href = "#features";
       
    });


    $scope.initLevels = function(){
        for(var i = 1; i <= 30; i++){
            $scope.possibleLevels.push(i);
        }
    };
    
    $scope.getInfo = function(){
        
        if ($scope.selectedLevel == "Level" || $scope.selectedRace == "Race" || $scope.selectedClass == "Class") {
            console.log("Missing an input value! (Level, race, or class)");
        } else {
            $scope.statsEntered = true;  
            
            // clear the info lists
            $scope.raceInfo = [];
            $scope.classInfo = [];
            
            socket.emit('getInfo', $scope.selectedLevel, $scope.selectedRace, $scope.selectedClass);
            
            console.log($scope.statsEntered);
            console.log("Sent: ");
            console.log($scope.selectedLevel);
            console.log($scope.selectedRace);
            console.log($scope.selectedClass);
        }
        
    };

    socket.on('connect', function() {
        console.log('connected');
        
    });
    
    $scope.initLevels();
});