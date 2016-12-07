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
    $scope.feats = [];
    $scope.features = "";
    $scope.traits = "";



    $scope.str = '';
    $scope.con = '';
    $scope.dex = '';
    $scope.int = '';
    $scope.wis = '';
    $scope.cha = '';
    
    $scope.acrobatics = false;
    $scope.arcana = false;
    $scope.athletics = false;
    $scope.bluff = false;
    $scope.dungeoneering = false;
    $scope.endurance = false;
    $scope.heal = false;
    $scope.intimidate = false;
    $scope.nature = false;
    $scope.perception = false;
    $scope.religion = false;
    $scope.stealth = false;
    $scope.streetwise = false;
    $scope.thievery = false;
    
    socket.on('updateFeats', function(Feat) {
        console.log("Entering updateFeats in USERINPUTCONTROLLER.JS");
        console.log(Feat);
        $scope.feats.push(Feat);
        $scope.$apply();
        
    })

    socket.on('updateRaceInfo', function(Race) {
        console.log('Entering updateRaceInfo in USERINPUTCONTROLLER.JS');
        console.log(Race);
        $scope.raceInfo.push(Race);
        $scope.$apply();
        console.log($scope.raceInfo[0].traits);
        $scope.traits = $sce.trustAsHtml($scope.raceInfo[0].traits);
        console.log($scope.traits);
        $scope.$apply();
        
    });
    
    socket.on('updateClassInfo', function(Class) {
        
       $scope.statsReady = true;
        
       console.log('Entering updateClassInfo in USERINPUTCONTROLLER.JS');
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
            $scope.streetwise = $scope.character[0].streetwise;
            $scope.thievery = $scope.character[0].thievery;
            $scope.statsReady = true;
            
            console.log("arcana:");
            console.log($scope.arcana);
            
            var stats = {'str':$scope.str, 'con':$scope.con, 'dex':$scope.dex, 'int':$scope.int, 'wis':$scope.wis, 'cha':$scope.cha};
            var skills = {'acrobatics':$scope.acrobatics, 'arcana':$scope.arcana, 'athletics':$scope.athletics, 'bluff':$scope.bluff, 'dungeoneering':$scope.dungeoneering, 'endurance':$scope.endurance, 'heal':$scope.heal, 'intimidate':$scope.intimidate, 'nature':$scope.nature, 'perception':$scope.perception, 'religion':$scope.religion, 'stealth':$scope.stealth, 'streetwise':$scope.streetwise, 'thievery':$scope.thievery};
            console.log(skills);
            socket.emit('getInfo', $scope.selectedLevel, $scope.selectedRace, $scope.selectedClass, $scope.username, stats, skills);
            
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
            
            var stats = {'str':$scope.str, 'con':$scope.con, 'dex':$scope.dex, 'int':$scope.int, 'wis':$scope.wis, 'cha':$scope.cha};
            var skills = {'acrobatics':$scope.acrobatics, 'arcana':$scope.arcana, 'athletics':$scope.athletics, 'bluff':$scope.bluff, 'dungeoneering':$scope.dungeoneering, 'endurance':$scope.endurance, 'heal':$scope.heal, 'intimidate':$scope.intimidate, 'nature':$scope.nature, 'perception':$scope.perception, 'religion':$scope.religion, 'stealth':$scope.stealth, 'streetwise':$scope.streetwise, 'thievery':$scope.thievery};
            console.log(skills);
            socket.emit('getInfo', $scope.selectedLevel, $scope.selectedRace, $scope.selectedClass, $scope.username, stats, skills);            
            
            console.log($scope.statsEntered);
            console.log("Sent: ");
            console.log($scope.selectedLevel);
            console.log($scope.selectedRace);
            console.log($scope.selectedClass);
            console.log(stats);
            console.log(skills);
        
        
    };
    
    $scope.resetStats = function(){
        $scope.statsEntered = false;
        $scope.skillsEntered = false;
        $scope.statsReady = false;
    };
    
    $scope.resetCredentials = function(){
        $scope.username = '';
        $scope.password = '';
    };
    
    $scope.register = function(){
        console.log("Entered register on CONTROLLER.JS");
        if ($scope.username != null && $scope.password != null){
            console.log($scope.username + " " + $scope.password);
            socket.emit('register', $scope.username, $scope.password);
        } else {
            console.log($scope.username);
            console.log($scope.password);
            $scope.registerResponse = "Username or password not entered!";
            console.log("Username or password are null.");
        }
    };
    
    socket.on('registerResult', function(success){
       console.log('Entered registerResult on CONTROLLER.JS'); 
       if (success){
           console.log("GREEN: registration successful.");
           $scope.registerResponse = "Registered!";
           $('#register').modal('hide');
           $scope.resetCredentials();
           $scope.$apply();
       } else {
           console.log("RED: registration failed.");
           $scope.registerResponse = "Registration failed.  This user is already registered!";
           $scope.$apply();
       }
    });
    
    $scope.login = function(){
        console.log("Entered login on CONTROLLER.JS");
        console.log($scope.username + " " + $scope.password);
        if ($scope.username != null && $scope.password != null){
            socket.emit('login', $scope.username, $scope.password);
        } else {
            $scope.loginResponse = "Username or password not entered!";
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
           $('#login').modal('hide');
           var button = document.getElementById("continue");
           button.setAttribute("href", "#download");
           $scope.$apply();
       } else {
           console.log("Login failed. $scope.loggedIn = true anyways.");
       }
    });
    
    $scope.logout = function(){
        
        document.getElementById("userinformation").style.color = "#ff0000";
        
        $scope.loggedIn = false; 
        $scope.resetStats();
        $scope.resetCredentials();
        
        $scope.selectedLevel = 'Level';
        $scope.selectedRace = 'Race';
        $scope.selectedClass = 'Class';
        
        $scope.character = [];
        
        $scope.classInfo = [];
        $scope.raceInfo = [];
        $scope.features = "";
    };

    socket.on('connect', function() {
        console.log('connected');
        
    });
    
    $scope.initLevels();
});