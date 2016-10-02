%% File: newSound.m
%% NetID: pf51
%% Usage: Create different type of wave to generate sound in noteGenerator.m

function [ note ] = newSound( freq, octave, duration, envNum )
% see function "noteGenerator.m" for reference of input variables
% newSound.m function creates a function with a set of constants
% that are input in the function of instrumental synthesis given
% in the Lab Manual 1 - Music Synthesis, and it uses the input arguments
% in order to create a different type of sound by using a different type
% of wave to generate this sound

sampleRate = 8000;
t = [0 : 1./sampleRate : duration - 1/sampleRate];

K1 = .7;
K2 = .9;
tau = .9;
fc = 4.*freq.*octave;
fm = freq.*octave;

A = K1.*exp(-t./tau);
I = K2.*exp(-t./tau);

env = exp(-t.*envNum);

calc = A.*cos(2.*pi.*fc.*t + I.*cos(2.*fm.*t));

note = calc .* env;

end