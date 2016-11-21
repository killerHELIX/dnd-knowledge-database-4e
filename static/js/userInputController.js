var dnd = angular.module('dnd', ['ngSanitize']);

dnd.controller('inputController', function($scope, $sce) {
    var socket = io.connect('https://' + document.domain + ':' + location.port);
    
    $scope.loggedIn = false;
    
    $scope.possibleLevels = [];
    $scope.possibleRaces = ['Human', 'Dragonborn', 'Dwarf', 'Eladrin', 'Elf', 'Half-Elf', 'Halfling', 'Tiefling'];
    $scope.possibleClasses = ['Cleric', 'Fighter', 'Paladin', 'Ranger', 'Rogue', 'Warlock', 'Warlord', 'Wizard'];
    $scope.statsEntered = false;
    $scope.skillsEntered = false;
    $scope.statsReady = false;
    
    $scope.selectedLevel = 'Level';
    $scope.selectedRace = 'Race';
    $scope.selectedClass = 'Class';
    
    $scope.classInfo = [];
    $scope.raceInfo = [];
    $scope.features = "";


    $scope.str = '10';
    $scope.con = '10';
    $scope.dex = '10';
    $scope.int = '10';
    $scope.wis = '10';
    $scope.cha = '10';

    
    socket.on('updateClassInfo', function(Class) {
        
       $scope.statsReady = true;
        
       console.log('Entering updateInfo in USERINPUTCONTROLLER.JS');
       console.log(Class);
       $scope.classInfo.push(Class);
       $scope.$apply();
       console.log($scope.classInfo[0].features);
       $scope.features = $sce.trustAsHtml($scope.classInfo[0].features);
       console.log($scope.features);
       $scope.$apply();
       
    });


    $scope.initLevels = function(){
        for(var i = 1; i <= 30; i++){
            $scope.possibleLevels.push(i);
        }
    };
    
    $scope.getBasic = function(){
        
        if ($scope.selectedLevel == "Level" || $scope.selectedRace == "Race" || $scope.selectedClass == "Class") {
            console.log("Missing an input value! (Level, race, or class)");
        } else {
            $scope.statsEntered = true; 
        }
    };
    
    $scope.getStats = function(){
        if ($scope.str == null || $scope.con == null || $scope.dex == null ||
            $scope.int == null || $scope.wis == null || $scope.cha == null){
                console.log("Missing an input value! (str, con, dex, int, wis, or cha)");
            } else {
                $scope.skillsEntered = true;
            }
    };
    
    $scope.query = function(){
        
            console.log("arcana:");
            console.log($scope.arcana);
            
            // clear the info lists
            $scope.raceInfo = [];
            $scope.classInfo = [];
            
            socket.emit('getInfo', $scope.selectedLevel, $scope.selectedRace, $scope.selectedClass);
            
            console.log($scope.statsEntered);
            console.log("Sent: ");
            console.log($scope.selectedLevel);
            console.log($scope.selectedRace);
            console.log($scope.selectedClass);
        
        
    };
    
    $scope.resetStats = function(){
        $scope.statsEntered = false;
        $scope.skillsEntered = false;
    };
    
    $scope.login = function(){
        console.log("Entered login on CONTROLLER.JS");
        console.log($scope.username + " " + $scope.password);
        if ($scope.username != null && $scope.password != null){
            socket.emit('login', $scope.username, $scope.password);
        } else {
            console.log("Username or password are null.");
        }
        
    };
    
    socket.on('loginResult', function(success) {
       if (success){
           console.log("Logged in successfully! $scope.loggedIn = true.");
           $scope.loggedIn = true;
           $scope.$apply();
       } else {
           console.log("Login failed. $scope.loggedIn = true anyways.");
       }
    });
    
    $scope.logout = function(){
        $scope.loggedIn = false;  
    };

    socket.on('connect', function() {
        console.log('connected');
        
    });
    
    $scope.initLevels();
});