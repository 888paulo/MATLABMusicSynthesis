%% File: noteGenerator.m
%% NetID: pf51
%% Usage: Create an oscillation at a particular frequency, octave, duration and envelope

function [ note ] = noteGenerator( freq, octave, duration, envNum )
% freq = frequency of note that is going to be generated
% octave = octave of the note relative to the input frequency,
    % 1 means same, 2 means one above, 0.5 means one below
% duration = duration of the note relative to whole, half, double notes
% envNum = a constant that will define how fast the envelope decays, thus
    % the higher this constant, the faster it will decay and the quicker
    % this note will end

sampleRate = 8000;

t = [0 : 1./sampleRate : duration - 1/sampleRate];

calc = cos(2.*pi.*freq.*octave.*t);

env = exp(-t.*envNum);

note = calc .* env;

end

