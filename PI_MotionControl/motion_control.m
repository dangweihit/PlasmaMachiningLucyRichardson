% ----------------------------
% PI presentation2 plannar motion
% ----------------------------

%% Load the HEX_GCS_DLL if not loaded already
if (~libisloaded('HEX_GCS_DLL'))
    loadlibrary('HEX_GCS_DLL')
    loadlibrary('HEX_GCS_DLL.H')
end
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
[m,n]=size(X);
N=max(m,n);
clear m n;

for i=1:N
    if(ID>=0)
        setpos=[X(i),Y(i),Z(i),U(i),V(i),W(i)];
        setvel=v(i)*ones(1,6);
        [iRet,cRet,setvel] = calllib('HEX_GCS_DLL','HEX_VEL',ID,szAxes,setvel);
        [iRet,cRet,setpos] = calllib('HEX_GCS_DLL','HEX_MOV',ID,szAxes,setpos);
        pause(T(i));
        disp(sprintf('פ��ʱ�� %g ��\n',T(i)));
        % initialize status pointer
        state = 1;
        pstate = libpointer('int32Ptr',state);
        pause(0.5); % give motion time to start
        stateret = 1;
        tic;
        disp('Ŀ���:');
        disp(setpos);
        disp('�ƶ���');
        while(pstate.value==1)
            % poll for ready state
            [iRet,cRet,stateret] = calllib('HEX_GCS_DLL','HEX_IsMoving',ID,'',pstate);
            pause(0.1);
        end
        disp(sprintf('��ʱ %f s',toc));
         % initialize return pointer for position
        getpos=zeros(6,1);
        pgetpos = libpointer('doublePtr',getpos);
        % query reached position

        [iRet,cRet,getpos] = calllib('HEX_GCS_DLL','HEX_qPOS',ID,szAxes,pgetpos);

        disp('����Ŀ��:');
        disp(getpos');
    end
end
    
    











