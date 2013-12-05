%velocity test
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
    disp(sprintf('连接 %s\n',idn));

end
%% Initialize Hexapod
if(ID>=0)
    tic;
    szAxes = blanks(9);
    [iRet,szAxes] = calllib('HEX_GCS_DLL','HEX_qSAI',ID,szAxes,8);
    szAxes = 'XYZUVW';
    nAxes = 6;
    disp(sprintf('初始化中...\n'));
  [iRet,cRet] = calllib('HEX_GCS_DLL','HEX_INI',ID,szAxes);
    
    disp(sprintf('初始化耗时 %g 秒\n',toc));
    
    pause(0.5);
end
%% motion
if(ID>=0)
    setpos=[10,0,0,0,0,0];
    v=[0.1,0.2,0.3,0.4,0.5,0.6];
    [iRet,cRet,setpos] = calllib('HEX_GCS_DLL','HEX_MOV',ID,szAxes,setpos);
    for i=1:5
        setvel=v(i)*ones(1,6);
        [iRet,cRet,setvel] = calllib('HEX_GCS_DLL','HEX_VEL',ID,szAxes,setvel);
        disp(sprintf('移动中 %g mm/s',v(i)));
        pause(3);
    end
     state = 1;
        pstate = libpointer('int32Ptr',state);
        pause(0.5); % give motion time to start
        stateret = 1;
        tic;
%         disp(['目标点 #' num2str(i) ]);
%         disp(setpos);
%         disp(sprintf('移动中 %g mm/s',v(i)));
        while(pstate.value==1)
            % poll for ready state
            [iRet,cRet,stateret] = calllib('HEX_GCS_DLL','HEX_IsMoving',ID,'',pstate);
            pause(0.1);
        end

     disp('                 本次运行结束');
    
end
       if(0) % enable this section only if you want to reconnect each time you run the whole macro
    if(bConnected>0) % close com port
        calllib('HEX_GCS_DLL','HEX_CloseConnection');
        clear('bConnected');
    end % unload dll
    if (libisloaded('HEX_GCS_DLL'))
        unloadlibrary('HEX_GCS_DLL')
    end
end   



