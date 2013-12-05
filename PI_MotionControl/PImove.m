% ----------------------------
% PI presentation2 plannar motion
% ----------------------------

%% Load the HEX_GCS_DLL if not loaded already
if (~libisloaded('HEX_GCS_DLL'))
    loadlibrary('HEX_GCS_DLL')
    loadlibrary('HEX_GCS_DLL.H')
end
clc;
%% Show all functions
% libfunctionsview('HEX_GCS_DLL')
%% If not connected yet, open a connection
if(~exist('ID'))
    [ID] = calllib('HEX_GCS_DLL','HEX_ConnectTCPIP','192.168.1.28',50000);
    idn = blanks(100);
    [ret,idn] = calllib('HEX_GCS_DLL','HEX_qIDN',ID,idn,100);
    disp(sprintf('���� %s\n',idn));

end
%% Initialize Hexapod
if(ID>=0)
    tic;
    szAxes = blanks(9);
    [iRet,szAxes] = calllib('HEX_GCS_DLL','HEX_qSAI',ID,szAxes,8);
    szAxes = 'XYZUVW';
    nAxes = 6;
    disp(sprintf('��ʼ����...\n'));
  [iRet,cRet] = calllib('HEX_GCS_DLL','HEX_INI',ID,szAxes);
    
    disp(sprintf('��ʼ����ʱ %g ��\n',toc));
    
    pause(0.5);
end
%% motion
disp(['          פ���㹲' num2str(N) '��']);
disp('----------------------------------------');

for i=1:N
    if(ID>=0)
        setpos=[X(i),Y(i),Z(i),U(i),V(i),W(i)];
        setvel=v(i)*ones(1,6);
        [iRet,cRet,setvel] = calllib('HEX_GCS_DLL','HEX_VEL',ID,szAxes,setvel);
        [iRet,cRet,setpos] = calllib('HEX_GCS_DLL','HEX_MOV',ID,szAxes,setpos);
        
       
        % initialize status pointer
        state = 1;
        pstate = libpointer('int32Ptr',state);
        pause(0.5); % give motion time to start
        stateret = 1;
        tic;
        disp(['Ŀ��� #' num2str(i) ]);
        disp(setpos);
        disp(sprintf('�ƶ��� %g mm/s',v(i)));
        while(pstate.value==1)
            % poll for ready state
            [iRet,cRet,stateret] = calllib('HEX_GCS_DLL','HEX_IsMoving',ID,'',pstate);
            pause(0.1);
        end
        
        
         % initialize return pointer for position
        getpos=zeros(6,1);
        pgetpos = libpointer('doublePtr',getpos);
        % query reached position
        [iRet,cRet,getpos] = calllib('HEX_GCS_DLL','HEX_qPOS',ID,szAxes,pgetpos);
        
        disp(sprintf('����Ŀ�� ��ʱ %f s',toc));
        disp(getpos');
        disp(sprintf('פ��ʱ�� %g ��\n',T(i)));
        disp('----------------------------------------');
        pause(T(i));
    end
end
        disp('                 �������н���');
if(0) % enable this section only if you want to reconnect each time you run the whole macro
    if(bConnected>0) % close com port
        calllib('HEX_GCS_DLL','HEX_CloseConnection');
        clear('bConnected');
    end % unload dll
    if (libisloaded('HEX_GCS_DLL'))
        unloadlibrary('HEX_GCS_DLL')
    end
end   
%plot the trace


    











