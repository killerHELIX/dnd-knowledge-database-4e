var dnd = angular.module('dnd', ['ngSanitize']);

dnd.controller('inputController', function($scope, $sce) {
    var socket = io.connect('https://' + document.domain + ':' + location.port);
    
    $scope.loggedIn = false;
    $scope.character = [];
    
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
    
    $scope.loggedInQuery = function(){
            
            // clear the info lists
            $scope.raceInfo = [];
            $scope.classInfo = [];
            
            $scope.selectedLevel = $scope.character[0].level;
            $scope.selectedRace = $scope.character[0].race;
            $scope.selectedClass = $scope.character[0].class;
            $scope.statsEntered = true;
            
            $scope.str = $scope.character[0].str;
            $scope.con = $scope.character[0].con;
            $scope.dex = $scope.character[0].dex;
            $scope.int = $scope.character[0].int;
            $scope.wis = $scope.character[0].wis;
            $scope.cha = $scope.character[0].cha;
            $scope.skillsEntered = true;
            
            $scope.acrobatics = $scope.character[0].acrobatics;
            $scope.arcana = $scope.character[0].arcana;
            $scope.athletics = $scope.character[0].athletics;
            $scope.bluff = $scope.character[0].bluff;
            $scope.dungeoneering = $scope.character[0].dungeoneering;
            $scope.endurance = $scope.character[0].endurance;
            $scope.heal = $scope.character[0].heal;
            $scope.intimidate = $scope.character[0].intimidate;
            $scope.nature = $scope.character[0].nature;
            $scope.perception = $scope.character[0].perception;
            $scope.religion = $scope.character[0].religion;
            $scope.stealth = $scope.character[0].stealth;
            $scope.statsReady = true;
            
            console.log("arcana:");
            console.log($scope.arcana);
            
            socket.emit('getInfo', $scope.selectedLevel, $scope.selectedRace, $scope.selectedClass);
            
            console.log($scope.statsEntered);
            console.log("Sent: ");
            console.log($scope.selectedLevel);
            console.log($scope.selectedRace);
            console.log($scope.selectedClass);
        
        
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
        $scope.statsReady = false;
    };
    
    $scope.register = function(){
        console.log("Entered register on CONTROLLER.JS");
        if ($scope.username != null && $scope.password != null){
            $scope.response = "Username and password aren't null, emitting to server!"
            socket.emit('register', $scope.username, $scope.password);
        } else {
            $scope.response = "Username or password not entered!"
            console.log("Username or password are null.");
        }
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
    
    socket.on('characterData', function(character){
        console.log(character);
        $scope.character.push(character);
        $scope.$apply();
    });
    
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
        $scope.resetStats();
        
        $scope.selectedLevel = 'Level';
        $scope.selectedRace = 'Race';
        $scope.selectedClass = 'Class';
        
        $scope.classInfo = [];
        $scope.raceInfo = [];
        $scope.features = "";
    };

    socket.on('connect', function() {
        console.log('connected');
        
    });
    
    $scope.initLevels();
});