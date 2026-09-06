clear;
clc;
A=880;
B=987.77;
C=523.25;
D=587.33;
E=659.25;
F=698.46;
G=783.99;
A_sharp=932.33;
C_sharp=554.37;
D_sharp=622.25;
F_sharp=739.99;
G_sharp=830.61;
freq=[A,B,C,D,E,F,G,A_sharp,C_sharp,D_sharp,F_sharp,G_sharp];
ts=1/8000;
T1=0.5;
t1=0:ts:T1-ts;
T2=0.25;
t2=0:ts:T2-ts;
pause_zeros=zeros(1,200);
signal=[];
signal=[signal,sin(2*pi*D*t2)];
signal=[signal,pause_zeros];
signal=[signal,sin(2*pi*D*t2)];
signal=[signal,pause_zeros];
signal=[signal,sin(2*pi*G*t1)];
signal=[signal,pause_zeros];
signal=[signal,sin(2*pi*F_sharp*t1)];
signal=[signal,pause_zeros];
signal=[signal,sin(2*pi*D*t1)];
signal=[signal,pause_zeros];
signal=[signal,sin(2*pi*D*t2)];
signal=[signal,pause_zeros];
signal=[signal,sin(2*pi*E*t2)];
signal=[signal,pause_zeros];
signal=[signal,sin(2*pi*E*t2)];
signal=[signal,pause_zeros];
signal=[signal,sin(2*pi*D*t2)];
signal=[signal,pause_zeros];
signal=[signal,sin(2*pi*F_sharp*t2)];
signal=[signal,pause_zeros];
signal=[signal,sin(2*pi*D*t2)];
signal=[signal,pause_zeros];
signal=[signal,sin(2*pi*E*t1)];
signal=[signal,pause_zeros];
signal=[signal,sin(2*pi*D*t1)];
signal=[signal,pause_zeros];
signal=[signal,sin(2*pi*E*t1)];
signal=[signal,pause_zeros];
signal=[signal,sin(2*pi*F_sharp*t1)];
signal=[signal,pause_zeros];
signal=[signal,sin(2*pi*E*t1)];
signal=[signal,pause_zeros];
signal=[signal,sin(2*pi*D*t2)];
signal=[signal,pause_zeros];
signal=[signal,sin(2*pi*E*t2)];
signal=[signal,pause_zeros];
signal=[signal,sin(2*pi*E*t2)];
signal=[signal,pause_zeros];
signal=[signal,sin(2*pi*D*t2)];
signal=[signal,pause_zeros];
signal=[signal,sin(2*pi*F_sharp*t2)];
signal=[signal,pause_zeros];
signal=[signal,sin(2*pi*D*t2)];
signal=[signal,pause_zeros];
signal=[signal,sin(2*pi*E*t1)];
signal=[signal,pause_zeros];
signal=[signal,sin(2*pi*D*t1)];
signal=[signal,pause_zeros];
signal=[signal,sin(2*pi*E*t2)];
signal=[signal,pause_zeros];
signal=[signal,sin(2*pi*D*t2)];
signal=[signal,pause_zeros];
signal=[signal,sin(2*pi*F_sharp*t1)];
signal=[signal,pause_zeros];
signal=[signal,sin(2*pi*E*t1)];
signal=[signal,pause_zeros];
signal=[signal,sin(2*pi*D*t1)];
signal=[signal,pause_zeros];
signal=[signal,sin(2*pi*E*t2)];
signal=[signal,pause_zeros];
signal=[signal,sin(2*pi*D*t2)];
signal=[signal,pause_zeros];
signal=[signal,sin(2*pi*F_sharp*t1)];
signal=[signal,pause_zeros];
signal=[signal,sin(2*pi*E*t1)];
signal=[signal,pause_zeros];
signal=[signal,sin(2*pi*D*t2)];
signal=[signal,pause_zeros];
signal=[signal,sin(2*pi*D*t2)];
signal=[signal,pause_zeros];
signal=[signal,sin(2*pi*E*t1)];
signal=[signal,pause_zeros];
signal=[signal,sin(2*pi*F_sharp*t2)];
signal=[signal,pause_zeros];
signal=[signal,sin(2*pi*E*t2)];
signal=[signal,pause_zeros];
signal=[signal,sin(2*pi*F_sharp*t1)];
signal=[signal,pause_zeros];
signal=[signal,sin(2*pi*F_sharp*t2)];
signal=[signal,pause_zeros];
signal=[signal,sin(2*pi*E*t2)];
signal=[signal,pause_zeros];
signal=[signal,sin(2*pi*F_sharp*t1)];
signal=[signal,pause_zeros];
signal=[signal,sin(2*pi*F_sharp*t1)];
signal=[signal,pause_zeros];
signal=[signal,sin(2*pi*D*t1)];
signal=[signal,pause_zeros];
sound(signal);


counter=1;
note_cells=cell(1,1000);
start_index=1;
for i=3:length(signal)
    if signal(i)~=0 && signal(i-1)==0
        start_index=i-1;
    end
    if signal(i)==0 && signal(i-1)~=0
        segment=(signal(start_index:i-1));
        note_cells(1,counter)={segment};
        counter=counter+1;
    end
end
note_cells = note_cells(~cellfun('isempty',note_cells));
frequencies=zeros(1,length(note_cells));
durations=zeros(1,length(note_cells));
for j=1:length(note_cells)
    segment=cell2mat(note_cells(1,j));
    fft_result=fftshift(fft(segment));
    len=length(segment);
    scaling=len/2000;
    if scaling==1
        step=4;
        durations(j)=0.25;
    elseif scaling==2
        step=2;
        durations(j)=0.5;
    end
    freq_vec=0:step:(4000-step);
    half_spectrum=fft_result((len/2+1):len);
    [~,max_index]=max(half_spectrum);
    frequencies(j)=freq_vec(max_index);
end
Index=zeros(1,length(note_cells));
final_notes=cell(2,length(note_cells));
for w=1:length(note_cells)
    Index(w)=find(min(abs(freq-frequencies(w)))==abs(freq-frequencies(w)));
    if Index(w)==1
        final_notes(1,w)={'A'};
    elseif Index(w)==2
        final_notes(1,w)={'B'};
    elseif Index(w)==3
        final_notes(1,w)={'C'};
    elseif Index(w)==4
        final_notes(1,w)={'D'};
    elseif Index(w)==5
        final_notes(1,w)={'E'};
    elseif Index(w)==6
        final_notes(1,w)={'F'};
    elseif Index(w)==7
        final_notes(1,w)={'G'};
    elseif Index(w)==8
        final_notes(1,w)={'A#'};
    elseif Index(w)==9
        final_notes(1,w)={'C#'};
    elseif Index(w)==10
        final_notes(1,w)={'D#'};
    elseif Index(w)==11
        final_notes(1,w)={'F#'};
    elseif Index(w)==12
        final_notes(1,w)={'G#'};
    end
end
for k=1:length(note_cells)
    final_notes(2,k)=num2cell(durations(k));
end
disp(final_notes);
