clear;
Fs = 8000;
ts = 1/Fs;

C4 = 261.63;
D4 = 293.66;
E4 = 329.63;
F4 = 349.23;
G4 = 392.00;
A4 = 440.00;
B4 = 493.88;
C5 = 523.25;

T1 = 0.5; 
T2 = 0.25; 

t1 = 0:ts:T1-ts;
t2 = 0:ts:T2-ts;

paus = zeros(1, 200); 

melody = [];

% Twinkle, Twinkle, Little Star
melody = [melody, sin(2*pi*C4*t1)]; melody = [melody, paus];
melody = [melody, sin(2*pi*C4*t1)]; melody = [melody, paus];
melody = [melody, sin(2*pi*G4*t1)]; melody = [melody, paus];
melody = [melody, sin(2*pi*G4*t1)]; melody = [melody, paus];
melody = [melody, sin(2*pi*A4*t1)]; melody = [melody, paus];
melody = [melody, sin(2*pi*A4*t1)]; melody = [melody, paus];
melody = [melody, sin(2*pi*G4*T2)]; melody = [melody, paus];

melody = [melody, sin(2*pi*F4*t1)]; melody = [melody, paus];
melody = [melody, sin(2*pi*F4*t1)]; melody = [melody, paus];
melody = [melody, sin(2*pi*E4*t1)]; melody = [melody, paus];
melody = [melody, sin(2*pi*E4*t1)]; melody = [melody, paus];
melody = [melody, sin(2*pi*D4*t1)]; melody = [melody, paus];
melody = [melody, sin(2*pi*D4*t1)]; melody = [melody, paus];
melody = [melody, sin(2*pi*C4*T2)]; melody = [melody, paus];

% Repeat the first part
melody = [melody, sin(2*pi*G4*t1)]; melody = [melody, paus];
melody = [melody, sin(2*pi*G4*t1)]; melody = [melody, paus];
melody = [melody, sin(2*pi*F4*t1)]; melody = [melody, paus];
melody = [melody, sin(2*pi*F4*t1)]; melody = [melody, paus];
melody = [melody, sin(2*pi*E4*t1)]; melody = [melody, paus];
melody = [melody, sin(2*pi*E4*t1)]; melody = [melody, paus];
melody = [melody, sin(2*pi*D4*t1)]; melody = [melody, paus];
melody = [melody, sin(2*pi*D4*t1)]; melody = [melody, paus];

melody = [melody, sin(2*pi*C4*t1)]; melody = [melody, paus];
melody = [melody, sin(2*pi*C4*t1)]; melody = [melody, paus];
melody = [melody, sin(2*pi*G4*t1)]; melody = [melody, paus];
melody = [melody, sin(2*pi*G4*t1)]; melody = [melody, paus];
melody = [melody, sin(2*pi*A4*t1)]; melody = [melody, paus];
melody = [melody, sin(2*pi*A4*t1)]; melody = [melody, paus];
melody = [melody, sin(2*pi*G4*T2)]; melody = [melody, paus];

sound(melody, Fs);
audiowrite('mysong.wav', melody, Fs);
