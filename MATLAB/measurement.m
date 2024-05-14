% -----------------------------
% Automatic measurement script 
% Author: C. Hediger, 2018
% -----------------------------

% Number of full Measurement sets. (Bode curves)
measRounds = 9;

actMeasurement = 0;

while actMeasurement < measRounds

    clc; % Clears the Logwindow
    % Enter the desired VISA Address. You can find they with the instrument
    % explorer app. 
    visaObj = visa('agilent','USB0::0x0957::0x1796::MY53400384::0::INSTR');

    % Set the buffer size
    visaObj.InputBufferSize = 100000;
    % Set the timeout value
    visaObj.Timeout = 1;
    % Set the Byte order
    visaObj.ByteOrder = 'littleEndian';
    
    % Open the connection
    fopen(visaObj);
    fprintf(visaObj, ':WGEN:RST'); %Reset Generator
    fprintf(visaObj, ':WGEN:FUNCtion SIN'); %Set SINUSODIAL signal
    fprintf(visaObj, ':WGEN:FREQ 1.00E3'); %Dummy freq of 1kHz
    fprintf(visaObj, ':WGEN:VOLT 2'); %Dummy amplitude 
    fprintf(visaObj, ':MEASure:VAMPlitude CHANNEL1'); %Measure ampl.
    fprintf(visaObj, ':MEASure:VAMPlitude CHANNEL2');
    fprintf(visaObj, ':WGEN:OUTPut 1'); % Enable GEN-Output

    fprintf(visaObj, ':CHANnel1:DISPlay 1'); %Show Channel 1
    fprintf(visaObj, ':CHANnel2:DISPlay 0'); %Disable channel 2
    fprintf(visaObj, ':CHANnel2:UNITs VOLT'); %Set units

    fprintf(visaObj, ':TRIGger:LEVel:ASETup'); %Automatic find trigger level
    pause(1.5);
    fprintf(visaObj, ':TRIGger:LEVel:HIGH 0,CHANNEL1'); %Set Triggerlevel to 0V
    pause(1.5);
    fprintf(visaObj, ':CHANnel1:OFFSet 0');
    fprintf(visaObj, ':CHANnel2:OFFSet 0');


    % Enter the amplitude of the Generator. 
    amplitude = 0.5; %Vpp
    outputStartAmplitude = 0.5;

    % Set the measurement parameters.
    startFreq = 100; % Start Freq. in Hertz
    decades = 5; % StopFreq = startFreq * 10^(1 * decaces)
    pointsPerDecade = 100; 
    genAmplitude = 0.5; 


    % ---------- AUTOMATIC CALCULATIONS BEGINS HERE ----------- %
    totMeasPoint = decades * pointsPerDecade;
    stopFreq = startFreq * 10^(1 * decades);

    actMeasPoint = 0;
    clear A;
    A(1,1) = 0;

    fprintf(visaObj, [':CHANnel1:SCALe ',sprintf('%d',amplitude/6)]);
    %fprintf(visaObj, [':CHANnel2:SCALe ',sprintf('%d',outputStartAmplitude/6)]);

    while actMeasPoint < totMeasPoint
       measFreq = exp(log(startFreq) + actMeasPoint/totMeasPoint*(log(stopFreq) - log(startFreq)));
       fprintf(visaObj, [':WGEN:FREQ ',num2str(measFreq)]);

       timebase = (1/(measFreq)) / 3  ;
       fprintf(visaObj, [':TIMebase:SCALe ',sprintf('%d',timebase)]);   

       disp([':TIMebase:SCALe ',sprintf('%d',timebase)]);

       pause(0.2);

       fprintf(visaObj, ':MEASure:VAMPlitude? CHANNEL1');
       data = fscanf(visaObj);

       A(actMeasPoint+1, 3) = measFreq;
       A(actMeasPoint+1, 1) = 20 * log10(str2num(data)/genAmplitude);

       tmpValue = str2num(data);
       A(actMeasPoint+1, 2) = tmpValue;

       % CHANNEL2 -----------------------
       %fprintf(visaObj, ':MEASure:VAMPlitude? CHANNEL2');
       %data = fscanf(visaObj);

       % --------------------------------



       disp(['InputValue: ',sprintf('%d',tmpValue)]);
       if tmpValue > 0 && tmpValue < 50  
         %fprintf(visaObj, [':CHANnel1:SCALe ',sprintf('%d',tmpValue/6)]);

         valueToSet = tmpValue/4;
         if valueToSet > 50e-3 
           fprintf(visaObj, [':CHANnel1:SCALe ',sprintf('%d',valueToSet)]);
         else
           fprintf(visaObj, [':CHANnel1:SCALe ',sprintf('%d',50e-3)]);   
         end

         disp([':CHANnel1:SCALe ',sprintf('%d',valueToSet)]);

       end

       tmpValue = 0;

       actMeasPoint = actMeasPoint + 1;

    end
    fprintf(visaObj, ':WGEN:OUTPut 0');
    fclose(visaObj);

    x= 1:size(A);
    filepath = 'C:\HFET\Schule\Arbeiten_4.Semester\ICT\AbgabeDokumente\Messreihe_2_26.12.2018\';
    filesuffix = datestr(now,'dd-mm-yyyy_HH.MM.SS');
    
    csvwrite([filepath,filesuffix,'_with_0.5s_delay.csv'],A);
    
    semilogx(A(x,3),A(x,1),'-o');
    title('Bodeplot: Amplitude in decibels');
    xlabel('f [Hz] - 100Hz..10Mhz'); 
    ylabel('A [dB]'); 
    saveas(gcf,[filepath,filesuffix,'_dB_.png'],'png');
    
    
    semilogx(A(x,3),A(x,2),'-o');
    xlabel('f [Hz] - 100Hz..10Mhz'); 
    ylabel('A [Volt]');
    title('Bodeplot: Amplitude in volts');
    saveas(gcf,[filepath,filesuffix,'_voltage_.png'],'png');

    actMeasurement = actMeasurement + 1;
end
