%% File: Main.m
%% NetID: pf51
%% Usage: Run this to play and save song

clear;

% set frequencies of notes
pause  = 0;
A      = 220*2.^(0/12);
Asharp = 220*2.^(1/12);
B      = 220*2.^(2/12);
C      = 220*2.^(3/12);
Csharp = 220*2.^(4/12);
D      = 220*2.^(5/12);
Dsharp = 220*2.^(6/12);
E      = 220*2.^(7/12);
F      = 220*2.^(8/12);
Fsharp = 220*2.^(9/12);
G      = 220*2.^(10/12);
Gsharp = 220*2.^(11/12);

% set sample rate
sampleRate = 8000;


%% last note
% this is the last note of the song
% declared first to be concatenated with all channels

lastNote = (1/3).*(noteGenerator(Fsharp, 1, 1, .5) + ...
noteGenerator(A, 1, 1, .5) + ...
noteGenerator(Csharp, 1, 1, .5) + ...
noteGenerator(Fsharp, .5, 1, .5) + ...
kickDrum(Fsharp, 1/2, 1, 14));

%% main melody

% create empty arrays of melody parts
myMel = [0];

% these are the individual sequences of myMel
myMel1 = [0];
myMel2 = [0];
myMel3 = [0];
myMel4 = [0];

% first melody is single note melody
melody1   = [A,   A,   A,   Gsharp, E,    Fsharp, Fsharp, E,    Fsharp,  ...
    E,    Csharp,  E,    Csharp,  B,    Csharp,   A,   A, A, Gsharp, A,Gsharp];
durationM1 = [1/2, 1/4, 1/4, 1/3,    1/3, 3/4, 1/2, 1/3,  1/3,  1/4, ...
    1/2,     1/4,  1/4,     1/3,  1/3,      3/4, 1/4, 1/4, 1/3   , 1/3, 1/4];
octaveM1 = [2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, ...
    0.5, 1, 0.5];
envM1 = [5, 5, 7, 4, 2, 2, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5];

% create notes
myMel1 = [0];
for i = 1:length(melody1)
   
    noteCurrent = noteGenerator(melody1(i), octaveM1(i), durationM1(i), envM1(i));
    myMel1 = [myMel1, noteCurrent];
    
end

% second melody is superposition of two wave forms
% "newSound" is alternate wave form
% superimpose them but scale newSound to lower amplitude, to barely be
% percievable but sound still creating an effect
melody2   = [A,    A,   A,   Gsharp,  Gsharp,  E,    Fsharp, Fsharp, E, ...
    E,    Fsharp,  E,    Csharp,  E,    Csharp,  B,   B,    Csharp, ...
    A,   A,   A,   Gsharp, Gsharp, A,   Gsharp];
durationM2 = [1/2, 1/4, 1/4, 1/4,     1/4,     1/4,  3/4,    1/2, ...
    1/4, 1/4,  1/4,     1/4,  1/2,     1/4,  1/4,     1/4, 1/4,  1/4, ...
    3/4, 1/4, 1/4, 1/4   , 1/4,    1/4, 1/4];
octaveM2 = [2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, ...
    1, 1, 0.5, 0.5, 1, 0.5];
envM2 = [5, 5, 7, 4, 2, 2, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5,...
    5, 5, 5, 5, 5, 5];

for i = 1:length(melody2)
   
    noteCurrent = noteGenerator(melody2(i), octaveM2(i), durationM2(i), envM2(i));
    myMel2 = [myMel2, noteCurrent];
    
end

myMel2_2 = [0];
for i = 1:length(melody2)
   
    noteCurrent = newSound(melody2(i), octaveM2(i), durationM2(i), envM2(i));
    myMel2_2 = [myMel2_2, noteCurrent];
    
end

myMel2 = myMel2 + .05.*myMel2_2;

% third melody are chords, with each of their notes harmonized with
% 3 extra odd harmonics (3, 5, and 7)
% NOTE: the amplitudes were NOT followed to be 1/n for the nth harmonic
% because they were scaled to be smaller for a different effect
% superimposed with each other over loops, using music theory knowledge for
% their sequences
melody3_1 = [A,      E,      Fsharp, A];
melody3_2 = [Csharp, Gsharp, A,      Csharp];
melody3_3 = [E,      B,      Csharp, E];
durationM3 = [2, 2, 2, 2];
octaveM3_1 = (2/2).*[1, 1, 1, 2];
octaveM3_2 = (2/2).*[1, 1, 2, 2];
octaveM3_3 = (2/2).*[2, 1, 2, 2];
envM3 = 0.001.*[.01, .01, .01, .01];

for i = 1:length(melody3_1)
   
    noteCurrent = noteGenerator(melody3_1(i), octaveM3_1(i), ...
        durationM3(i), envM3(i)) + ...
    noteGenerator(melody3_2(i), octaveM3_2(i), durationM3(i), envM3(i)) + ...
    noteGenerator(melody3_2(i), octaveM3_3(i), durationM3(i), envM3(i));
    
    myMel3 = [myMel3, .6.*noteCurrent];
    
end

% melody3 n harmonic: n = 3
myMel3n3 = [0];
melody3_1n3 = 3*[A,      E,      Fsharp, A];
melody3_2n3 = 3*[Csharp, Gsharp, A,      Csharp];
melody3_3n3 = 3*[E,      B,      Csharp, E];

for i = 1:length(melody3_1)
   
    noteCurrent = noteGenerator(melody3_1n3(i), octaveM3_1(i), ...
        durationM3(i), envM3(i)) + ...
    noteGenerator(melody3_2n3(i), octaveM3_2(i), durationM3(i), envM3(i)) + ...
    noteGenerator(melody3_2n3(i), octaveM3_3(i), durationM3(i), envM3(i));
    
    myMel3n3 = [myMel3n3, .1.*noteCurrent];
    
end

% melody3 n harmonic: n = 5
myMel3n5 = [0];
melody3_1n5 = 5*[A,      E,      Fsharp, A];
melody3_2n5 = 5*[Csharp, Gsharp, A,      Csharp];
melody3_3n5 = 5*[E,      B,      Csharp, E];

for i = 1:length(melody3_1)
   
    noteCurrent = noteGenerator(melody3_1n5(i), octaveM3_1(i), ...
        durationM3(i), envM3(i)) + ...
    noteGenerator(melody3_2n5(i), octaveM3_2(i), durationM3(i), envM3(i)) + ...
    noteGenerator(melody3_2n5(i), octaveM3_3(i), durationM3(i), envM3(i));
    
    myMel3n5 = [myMel3n5, .01.*noteCurrent];
    
end

% melody3 n harmonic: n = 7
myMel3n7 = [0];
melody3_1n7 = 7*[A,      E,      Fsharp, A];
melody3_2n7 = 7*[Csharp, Gsharp, A,      Csharp];
melody3_3n7 = 7*[E,      B,      Csharp, E];

for i = 1:length(melody3_1)
   
    noteCurrent = noteGenerator(melody3_1n7(i), octaveM3_1(i), ...
        durationM3(i), envM3(i)) + ...
    noteGenerator(melody3_2n7(i), octaveM3_2(i), durationM3(i), envM3(i)) + ...
    noteGenerator(melody3_2n7(i), octaveM3_3(i), durationM3(i), envM3(i));
    
    myMel3n7 = [myMel3n7, .005.*noteCurrent];
    
end

% add all different harmonics with each other
myMel3 = 0.7.*(myMel3 + myMel3n3 + myMel3n5 + myMel3n7);

% fourth melody is a chord sequence, purposefully not containing extra
% harmonics because it's meant to be softer to indicate the end of song
melody4_1 = [A,    Fsharp,  E,       F];
melody4_2 = [Csharp,A,  Gsharp,      Gsharp];
melody4_3 = [E,      Csharp, B    , B];
durationM4 = [2, 2, 2, 2];
octaveM4_1 = (2/2).*[1, 1, 1, 1];
octaveM4_2 = (2/2).*[1, 1, 1, 1];
octaveM4_3 = (2/2).*[2, 1, 1, 1];
envM4 = 0.001.*[.01, .01, .01, .01];

for i = 1:length(melody4_1)
   
    noteCurrent = noteGenerator(melody4_1(i), octaveM4_1(i), ...
        durationM4(i), envM4(i)) + ...
    noteGenerator(melody4_2(i), octaveM4_2(i), durationM4(i), envM4(i)) + ...
    noteGenerator(melody4_2(i), octaveM4_3(i), durationM4(i), envM4(i));
    
    myMel4 = [myMel4, .6.*noteCurrent];
    
end

% concatenating all melodies
myMel = [myMel1, myMel2, myMel3, myMel4, lastNote];

%% bass melody

myBass = [0];
myBass1 = [0];
myBass2 = [0];

% bass 1 melody tempo goes with main melody 1 tempo; the tempo subdivisions
% are tricky due to triplet notes
bass1   = [Fsharp,   Fsharp,   Fsharp,   E, E, D, D, D, D, D, ...
    A, A, A, Csharp, Csharp, D, D, D, E, E, E];
octaveB1 = 0.5.*[0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, ...
    0.5, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];

for i = 1:length(bass1)
   
    noteCurrent = noteGenerator(bass1(i), octaveB1(i), durationM1(i), envM1(i));
    myBass1 = [myBass1, noteCurrent];
    
end

% bass 2 melody goes with the rest of the song
% the subdivision of the notes is more straight, since it lacks triplet notes
bass2   =    [Fsharp,   Fsharp,   Fsharp, E,    E,    D,   D,   D,  ...
    D,   A,    A,    A,   Csharp,  Csharp, D,   D,   D,   E,   E,   E,   E];
durationB2 = [1/2,      1/4,      1/4,    1/2,  1/4,  3/4, 1/2, 1/2, ...
    1/4, 1/4,  1/2,  1/4, 1/4,     1/2,    1/4, 3/4, 1/2, 1/4, 1/4, 1/4, 1/4];
octaveB2 = 0.5.*[0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 1, ...
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1];

for i = 1:length(bass2)
   
    noteCurrent = noteGenerator(bass2(i), octaveB2(i), durationB2(i), envM2(i));
    myBass2 = [myBass2, noteCurrent];
    
end

% concatenating all bases, just repeat myBass2 since it doesn't change
myBass = [myBass1, myBass2, myBass2, myBass2, lastNote];

%% kick

myKick = [0];
myKick1 = [0];
myKick2 = [0];

% create empty part of array to go with melody 1 since there is not kick
% for that part of the song
myKick1 = zeros(1, length(myMel1));

% create actual kicks in Fsharp (key of song) by using a function
% "kickDrum" I created
kick2 = [Fsharp, Fsharp, Fsharp, Fsharp, Fsharp, Fsharp, Fsharp, ...
    Fsharp, Fsharp, Fsharp, Fsharp, Fsharp, Fsharp, Fsharp, Fsharp, Fsharp];
durationK2 = [1/2, 1/2, 1/2, 1/2, 1/2, 1/2, 1/2, 1/2, 1/2, 1/2, 1/2, ...
    1/2, 1/2, 1/2, 1/2, 1/2];
octaveK2 = (1/8).*[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, ...
    1, 1, 1, 1];
envK2 = 14.*[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, ...
    1, 1, 1];

for i = 1:length(kick2)
   
    noteCurrent = 4.*kickDrum(kick2(i), octaveK2(i), durationK2(i), envK2(i));
    myKick2 = [myKick2, noteCurrent];
    
end

% concatenating all kicks
myKick = [myKick1, myKick2, myKick2, myKick2, lastNote];

%% final

% add all channels
song = myMel + myBass + myKick;

% play song
soundsc(song, sampleRate)

% convert song
wavwrite(.1.*song, 'Flecha_JulianChainsmokers');