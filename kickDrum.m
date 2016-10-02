%% File: kickDrum.m
%% NetID: pf51
%% Usage: Create kick drum sample oscillation

function [ note ] = kickDrum( freq, octave, duration, envNum )
% see function "noteGenerator.m" for reference of input variables
% kickDrum.m function creates a piecewise function with a rise and
% a fall, and thus creating a peak that when the envNum is reasonably
% high, it sounds like a kick drum

sampleRate = 8000;

t = [0 : 1./sampleRate : duration - 1/sampleRate];

calc = cos(2.*pi.*freq.*octave.*t);

rise = round(length(t) ./ 12);

begin = t(1:rise);
envBeg = exp(-begin.*envNum);

rest = t((rise+1):end);
envRest = exp(-rest.*envNum);

env = [envBeg, envRest];


note = calc .* env;

end

