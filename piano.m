function piano()%主程序
    clc;clear;close all
    global fs dt; fs = 44100; dt = 1/fs;%采样频率44.1kHz
    %% 多声部乐谱yf1，yf2，yf3，yf4，用于演奏程序开头的bgm钢琴曲《星空》
    yf1 = [n_sound(8,5)                          n_sound(3,6)                           n_sound(8,5,0.125)  n_sound(11,5,0.125) n_sound(3,6,0.125) n_sound(6,6)                         n_sound(4,6,0.125) n_sound(3,6,0.125) n_sound(4,6,0.625) zeros(1,7)];yf1 = [yf1 n_sound(6,3)                          n_sound(1,6)                           n_sound(6,5,0.125)  n_sound(10,5,0.125) n_sound(1,6,0.125) n_sound(4,6)                          n_sound(3,6,0.125) n_sound(1,6,0.125) n_sound(3,6,0.625) zeros(1,7)];yf1 = [yf1 n_sound(8,5)                          n_sound(3,6)                           n_sound(8,5,0.125) n_sound(11,5,0.125) n_sound(3,6,0.125) n_sound(6,6)                           n_sound(4,6,0.125) n_sound(3,6,0.125) n_sound(4,6,0.5) zeros(1,6)];
    yf2 = [n_sound(8,2,0.125) n_sound(3,3,0.125) n_sound(11,3,0.125) n_sound(3,3,0.125) n_sound(11,3,0.125) n_sound(8,3,0.125) n_sound(3,4,0.125) n_sound(8,3,0.125) n_sound(1,3,0.125) n_sound(8,3,0.125) n_sound(4,4,0.125) n_sound(8,3,0.125) n_sound(4,3,0.125) n_sound(1,4,0.125) n_sound(8,4,0.125) n_sound(1,4,0.125)];yf2 = [yf2 n_sound(6,2,0.125) n_sound(1,3,0.125) n_sound(10,3,0.125) n_sound(1,3,0.125) n_sound(10,2,0.125) n_sound(6,3,0.125) n_sound(1,4,0.125) n_sound(6,3,0.125) n_sound(11,2,0.125) n_sound(6,3,0.125) n_sound(3,4,0.125) n_sound(6,3,0.125) n_sound(10,2,0.125) n_sound(5,3,0.125) n_sound(1,4,0.125) n_sound(3,3,0.125)];yf2 = [yf2 n_sound(8,2,0.125) n_sound(3,3,0.125) n_sound(11,3,0.125) n_sound(3,3,0.125) n_sound(11,2,0.125) n_sound(8,3,0.125)  n_sound(3,4,0.125) n_sound(8,3,0.125) n_sound(1,3,0.125) n_sound(8,3,0.125) n_sound(4,4,0.125) n_sound(8,3,0.125) n_sound(4,3,0.125) n_sound(1,4,0.125) n_sound(8,3,0.125)];
    yf3 = [zeros(1,length(yf1)) [n_sound(1,4,0.125)                   n_sound(3,3,0.125)                    n_sound(11,3,0.125) n_sound(8,4,0.125) n_sound(11,3,0.125)]*0 n_sound(10,5,1/6) n_sound(8,5,1/6) n_sound(6,5,1/6) n_sound(8,5) 0];
    yf1 = [yf1                   n_sound(8,6,1/16) n_sound(10,6,1/16) n_sound(11,6,1/16) n_sound(10,6,1/16) n_sound(11,6,3*0.125)                                         n_sound(10,6,1/6) n_sound(8,6,1/6) n_sound(6,6,1/6) n_sound(8,6) 0];
    yf2 = [yf2                   n_sound(1,4,0.125)                   n_sound(3,3,0.125)                    n_sound(11,3,0.125) n_sound(8,4,0.125) n_sound(11,3,0.125)    n_sound(3,3,0.125) n_sound(1,4,0.125) n_sound(5,4)  n_sound(8,2,0.125) n_sound(3,3,0.125)]; 
    yf4 = [0 0 0 zeros(1,length(yf1)) n_sound(8,5)                     n_sound(12,5)                                n_sound(3,6)];
    yf3 = [0 0 0 yf3                  n_sound(3,5)                     n_sound(8,5)                                 n_sound(12,5)];
    yf1 = [0 0 0 yf1                  n_sound(12)                      n_sound(3,5)                                 n_sound(8,5)];
    yf2 = [      yf2                  n_sound(12,3,0.125) n_sound(3,3,0.125) n_sound(12,3,0.125) n_sound(3,3,0.125) n_sound(12,3,0.125) n_sound(3,3,0.125)];
    
    yf = yf1+yf2+yf3+yf4;  yf = yf/max(yf); %多声部合并到一起,音量标准化
    sound(yf,fs);%播放bgm
    %创建一个图形窗口，在窗口中上部显示“键盘钢琴”字符串
    fig = figure; set(gcf,'outerposition',[1 1 1536 864]);
    uicontrol('Style','text','Position',[655 720 200 60],'String','键盘钢琴','FontSize',30);
    ax = axes('Parent',fig); ax.YAxis.Visible = 'off'; ax.XAxis.Visible = 'off';% 设置x,y轴不可见
    %按钮：单击此处停止播放bgm
    clear_sound = uicontrol('Style', 'pushbutton', 'String', '单击此处停止播放bgm','FontSize',12, 'Position', [1350 700 170 40],'Callback', 'cla');  
    clear_sound.Enable = 'Inactive'; clear_sound.ButtonDownFcn = 'clear sound';
    %% 绘制钢琴键，默认octave=4（第四八度）
    global octave; octave = 4; draw_piano_key();
    %钢琴的使用说明
    uicontrol('Style','text','Position',[120 500 100 30],'String','钢琴键C#3','FontSize',15); 
    uicontrol('Style','text','Position',[120 457 100 30],'String','键盘按键S','FontSize',15); 
    uicontrol('Style','text','Position',[850 720 150 30],'String','请使用英文输入法','FontSize',10); 
    uicontrol('Style','text','Position',[10 53 220 200],'String','            小星星：         C4 C4 G4 G4 A4 A4 G4','FontSize',15); 
    uicontrol('Style','text','Position',[10 -12 220 200],'String','Q   Q   T   T   Y   Y   T','FontSize',15);
    %音高可选择4-7八度
    uicontrol('Style','text','Position',[1350 368 20 20],'String','第','FontSize',10); uicontrol('Style','text','Position',[1400 368 60 20],'String','个八度','FontSize',10);
    uicontrol('Style', 'popup','String', {'4','5','6','7'},'FontSize',10,'Position', [1372 340 30 50],'Callback', @choose_octave);
    set(fig,'windowkeypressfcn',@keypressfcn);%当检测到有按键按下时播放钢琴音，并且对应钢琴键变红
    set(fig,'windowkeyreleasefcn',@keyreleasefcn);%当按键松开时钢琴键恢复黑白色
end %主程序结束

function ns = n_sound(n,m,T)%返回音符对应的声音信号
%1<=n<=12，对应十二平均律中的每个音符（C，C#/Db，D，D#/Eb，E，F，F#/Gb，G，G#/Ab，A，A#/Bb，B），m表示第m个八度，T表示持续时间
    if nargin == 1 %参数缺省值，默认4个八度，1/4音符
        m = 4; T = 0.25;
    elseif nargin == 2, T = 0.25;
    end
    T = T*24/7; %每个音符的时间，如1/4音符持续时间为1/4*24/7=6/7 
     fA4 = 440;%第4个八度的A音频率为440Hz，每高i个音符频率变为2^（i/12）倍，每高一个八度即12个音符，频率变为2倍
    f = fA4 * 2^((n-10)/12) * 2^(m-4);%音高对应的频率
    global dt; t = 0:dt:T; 
    bl = exp( -4*t/(0.25*24/7) );%ADSR包络曲线，钢琴的曲线大概是常数+指数衰减
    %钢琴的基波和谐波
    ns = cos(2*pi * f * (0:dt:T));
    for i=2:5
        ns = ns + cos(2*pi * i*f * (0:dt:T)) * (0.4^(i-1)) + cos(2*pi * (2^i)*f * (0:dt:T)) * (0.3^i);
    end
    ns = (bl).*ns; %包络乘以音乐信号
end 

function choose_octave(source,event) %改变八度值时钢琴键上的音符值也要改变
    global octave; octave = source.Value + 3; draw_piano_key();
end

%% 以下三个子函数为每个按键的发音、变色操作，每个按键都对应一个操作所以代码很长，但其实都长一个样
function draw_piano_key() %绘制钢琴键
    global Cn_1 Dn_1 En_1 Fn_1 Gn_1 An_1 Bn_1 Cn Dn En Fn Gn An Bn Cn1 Dn1 En1 Fn1 Cun_1 Dun_1 Fun_1 Gun_1 Aun_1 Cun Dun Fun Gun Aun Cun1 Dun1
    global keyZ keyS keyX keyD keyC keyV keyG keyB keyH keyN keyJ keyM keyQ key2 keyW key3 keyE keyR key5 keyT key6 keyY key7 keyU keyI key9 keyO key0 keyP keyKuo
    global octave;n=octave;
    %钢琴白键 n-1八度
    keyZ=rectangle('Position',[-70,0,10,100],'Curvature', [0 0], 'FaceColor','w');
    Cn_1=uicontrol('Style', 'text','String', ['C' num2str(n-1) '     Z'],'Position', [240 150 30 80],'BackgroundColor',[1 1 1],'FontSize',15,'foregroundcolor',[1 0 1]);
    keyX=rectangle('Position',[-60,0,10,100],'Curvature', [0 0], 'FaceColor','w');
    Dn_1=uicontrol('Style', 'text','String', ['D' num2str(n-1) '    X'],'Position', [300 150 30 80],'BackgroundColor',[1 1 1],'FontSize',15,'foregroundcolor',[1 0 1]);
    keyC=rectangle('Position',[-50,0,10,100],'Curvature', [0 0], 'FaceColor','w');
    En_1=uicontrol('Style', 'text','String', ['E' num2str(n-1) '    C'],'Position', [365 150 30 80],'BackgroundColor',[1 1 1],'FontSize',15,'foregroundcolor',[1 0 1]);
    keyV=rectangle('Position',[-40,0,10,100],'Curvature', [0 0], 'FaceColor','w');
    Fn_1=uicontrol('Style', 'text','String', ['F' num2str(n-1) '    V'],'Position', [430 150 30 80],'BackgroundColor',[1 1 1],'FontSize',15,'foregroundcolor',[1 0 1]);
    keyB=rectangle('Position',[-30,0,10,100],'Curvature', [0 0], 'FaceColor','w');
    Gn_1=uicontrol('Style', 'text','String', ['G' num2str(n-1) '     B'],'Position', [490 150 30 80],'BackgroundColor',[1 1 1],'FontSize',15,'foregroundcolor',[1 0 1]);
    keyN=rectangle('Position',[-20,0,10,100],'Curvature', [0 0], 'FaceColor','w');
    An_1=uicontrol('Style', 'text','String', ['A' num2str(n-1) '    N'],'Position', [555 150 30 80],'BackgroundColor',[1 1 1],'FontSize',15,'foregroundcolor',[1 0 1]);
    keyM=rectangle('Position',[-10,0,10,100],'Curvature', [0 0], 'FaceColor','w');
    Bn_1=uicontrol('Style', 'text','String', ['B' num2str(n-1) '    M'],'Position', [620 150 30 80],'BackgroundColor',[1 1 1],'FontSize',15,'foregroundcolor',[1 0 1]);
    %钢琴白键 n八度
    keyQ=rectangle('Position',[0,0,10,100],'Curvature', [0 0], 'FaceColor','w');
    Cn=uicontrol('Style', 'text','String', ['C' num2str(n) '    Q'],'Position', [685 150 30 80],'BackgroundColor',[1 1 1],'FontSize',15,'foregroundcolor',[0 1 0]);
    keyW=rectangle('Position',[10,0,10,100],'Curvature', [0 0], 'FaceColor','w');
    Dn=uicontrol('Style', 'text','String', ['D' num2str(n) '    W'],'Position', [745 150 30 80],'BackgroundColor',[1 1 1],'FontSize',15,'foregroundcolor',[0 1 0]);
    keyE=rectangle('Position',[20,0,10,100],'Curvature', [0 0], 'FaceColor','w');
    En=uicontrol('Style', 'text','String', ['E' num2str(n) '    E'],'Position', [810 150 30 80],'BackgroundColor',[1 1 1],'FontSize',15,'foregroundcolor',[0 1 0]);
    keyR=rectangle('Position',[30,0,10,100],'Curvature', [0 0], 'FaceColor','w');
    Fn=uicontrol('Style', 'text','String', ['F' num2str(n) '    R'],'Position', [870 150 30 80],'BackgroundColor',[1 1 1],'FontSize',15,'foregroundcolor',[0 1 0]);
    keyT=rectangle('Position',[40,0,10,100],'Curvature', [0 0], 'FaceColor','w');
    Gn=uicontrol('Style', 'text','String', ['G' num2str(n) '     T'],'Position', [935 150 30 80],'BackgroundColor',[1 1 1],'FontSize',15,'foregroundcolor',[0 1 0]);
    keyY=rectangle('Position',[50,0,10,100],'Curvature', [0 0], 'FaceColor','w');
    An=uicontrol('Style', 'text','String', ['A' num2str(n) '    Y'],'Position', [995 150 30 80],'BackgroundColor',[1 1 1],'FontSize',15,'foregroundcolor',[0 1 0]);
    keyU=rectangle('Position',[60,0,10,100],'Curvature', [0 0], 'FaceColor','w');
    Bn=uicontrol('Style', 'text','String', ['B' num2str(n) '    U'],'Position', [1060 150 30 80],'BackgroundColor',[1 1 1],'FontSize',15,'foregroundcolor',[0 1 0]);
    %钢琴白键 n+1八度
    keyI=rectangle('Position',[70,0,10,100],'Curvature', [0 0], 'FaceColor','w');
    Cn1=uicontrol('Style', 'text','String', ['C' num2str(n+1) '      I'],'Position', [1120 150 30 80],'BackgroundColor',[1 1 1],'FontSize',15,'foregroundcolor',[1 1 0]);
    keyO=rectangle('Position',[80,0,10,100],'Curvature', [0 0], 'FaceColor','w');
    Dn1=uicontrol('Style', 'text','String', ['D' num2str(n+1) '    O'],'Position', [1185 150 30 80],'BackgroundColor',[1 1 1],'FontSize',15,'foregroundcolor',[1 1 0]);
    keyP=rectangle('Position',[90,0,10,100],'Curvature', [0 0], 'FaceColor','w');
    En1=uicontrol('Style', 'text','String', ['E' num2str(n+1) '    P'],'Position', [1245 150 30 80],'BackgroundColor',[1 1 1],'FontSize',15,'foregroundcolor',[1 1 0]);
    keyKuo=rectangle('Position',[100,0,10,100],'Curvature', [0 0], 'FaceColor','w');axis equal;
    Fn1=uicontrol('Style', 'text','String', ['F' num2str(n+1) '      ['],'Position', [1310 150 30 80],'BackgroundColor',[1 1 1],'FontSize',15,'foregroundcolor',[1 1 0]);
    %钢琴黑键 n-1八度
    keyS=rectangle('Position',[-64,40,8,60],'Curvature', [0 0], 'FaceColor','black');
    Cun_1=uicontrol('Style', 'text','String', ['C#' num2str(n-1) '      S'],'Position', [265 450 40 80],'BackgroundColor',[0 0 0],'FontSize',15,'foregroundcolor','w');
    keyD=rectangle('Position',[-54,40,8,60],'Curvature', [0 0], 'FaceColor','black');
    Dun_1=uicontrol('Style', 'text','String', ['D#' num2str(n-1) '      D'],'Position', [330 450 40 80],'BackgroundColor',[0 0 0],'FontSize',15,'foregroundcolor','w');
    keyG=rectangle('Position',[-34,40,8,60],'Curvature', [0 0], 'FaceColor','black');
    Fun_1=uicontrol('Style', 'text','String', ['F#' num2str(n-1) '      G'],'Position', [455 450 40 80],'BackgroundColor',[0 0 0],'FontSize',15,'foregroundcolor','w');
    keyH=rectangle('Position',[-24,40,8,60],'Curvature', [0 0], 'FaceColor','black');
    Gun_1=uicontrol('Style', 'text','String', ['G#' num2str(n-1) '      H'],'Position', [520 450 40 80],'BackgroundColor',[0 0 0],'FontSize',15,'foregroundcolor','w');
    keyJ=rectangle('Position',[-14,40,8,60],'Curvature', [0 0], 'FaceColor','black');
    Aun_1=uicontrol('Style', 'text','String', ['A#' num2str(n-1) '       J'],'Position', [580 450 40 80],'BackgroundColor',[0 0 0],'FontSize',15,'foregroundcolor','w');
    %钢琴黑键 n八度
    key2=rectangle('Position',[6,40,8,60],'Curvature', [0 0], 'FaceColor','black');
    Cun=uicontrol('Style', 'text','String', ['C#' num2str(n) '       2'],'Position', [705 450 40 80],'BackgroundColor',[0 0 0],'FontSize',15,'foregroundcolor','w');
    key3=rectangle('Position',[16,40,8,60],'Curvature', [0 0], 'FaceColor','black');
    Dun=uicontrol('Style', 'text','String', ['D#' num2str(n) '       3'],'Position', [770 450 40 80],'BackgroundColor',[0 0 0],'FontSize',15,'foregroundcolor','w');
    key5=rectangle('Position',[36,40,8,60],'Curvature', [0 0], 'FaceColor','black');
    Fun=uicontrol('Style', 'text','String', ['F#' num2str(n) '      5'],'Position', [895 450 40 80],'BackgroundColor',[0 0 0],'FontSize',15,'foregroundcolor','w');
    key6=rectangle('Position',[46,40,8,60],'Curvature', [0 0], 'FaceColor','black');
    Gun=uicontrol('Style', 'text','String', ['G#' num2str(n) '       6'],'Position', [960 450 40 80],'BackgroundColor',[0 0 0],'FontSize',15,'foregroundcolor','w');
    key7=rectangle('Position',[56,40,8,60],'Curvature', [0 0], 'FaceColor','black');
    Aun=uicontrol('Style', 'text','String', ['A#' num2str(n) '       7'],'Position', [1025 450 40 80],'BackgroundColor',[0 0 0],'FontSize',15,'foregroundcolor','w');
    %钢琴黑键 n+1八度
    key9=rectangle('Position',[76,40,8,60],'Curvature', [0 0], 'FaceColor','black');
    Cun1=uicontrol('Style', 'text','String', ['C#' num2str(n+1) '       9'],'Position', [1145 450 40 80],'BackgroundColor',[0 0 0],'FontSize',15,'foregroundcolor','w');
    key0=rectangle('Position',[86,40,8,60],'Curvature', [0 0], 'FaceColor','black');
    Dun1=uicontrol('Style', 'text','String', ['D#' num2str(n+1) '       0'],'Position', [1210 450 40 80],'BackgroundColor',[0 0 0],'FontSize',15,'foregroundcolor','w');
    xlim([-68 108]); ylim([0 100]);
end

function keypressfcn(h,evt) %当检测到有按键按下时播放钢琴音，并且对应钢琴键变红
    global octave fs
    global keyZ keyS keyX keyD keyC keyV keyG keyB keyH keyN keyJ keyM keyQ key2 keyW key3 keyE keyR key5 keyT key6 keyY key7 keyU keyI key9 keyO key0 keyP keyKuo
    global Cn_1 Dn_1 En_1 Fn_1 Gn_1 An_1 Bn_1 Cn Dn En Fn Gn An Bn Cn1 Dn1 En1 Fn1 Cun_1 Dun_1 Fun_1 Gun_1 Aun_1 Cun Dun Fun Gun Aun Cun1 Dun1
    A=1;n=1;m=octave;
    switch evt.Character
        case 'z'
            m=m-1;A=A-isequal(keyZ.FaceColor,[1 0 0]);keyZ.FaceColor=[1 0 0];Cn_1.BackgroundColor=[1 0 0];
        case 'Z'
            m=m-1;A=A-isequal(keyZ.FaceColor,[1 0 0]);keyZ.FaceColor=[1 0 0];Cn_1.BackgroundColor=[1 0 0];
        case 's'
            n=2;m=m-1;A=A-isequal(keyS.FaceColor,[1 0 0]);keyS.FaceColor=[1 0 0];Cun_1.BackgroundColor=[1 0 0];
        case 'S'
            n=2;m=m-1;A=A-isequal(keyS.FaceColor,[1 0 0]);keyS.FaceColor=[1 0 0];Cun_1.BackgroundColor=[1 0 0];
        case 'x'
            n=3;m=m-1;A=A-isequal(keyX.FaceColor,[1 0 0]);keyX.FaceColor=[1 0 0];Dn_1.BackgroundColor=[1 0 0];
        case 'X'
            n=3;m=m-1;A=A-isequal(keyX.FaceColor,[1 0 0]);keyX.FaceColor=[1 0 0];Dn_1.BackgroundColor=[1 0 0];
        case 'd'
            n=4;m=m-1;A=A-isequal(keyD.FaceColor,[1 0 0]);keyD.FaceColor=[1 0 0];Dun_1.BackgroundColor=[1 0 0];
        case 'D'
            n=4;m=m-1;A=A-isequal(keyD.FaceColor,[1 0 0]);keyD.FaceColor=[1 0 0];Dun_1.BackgroundColor=[1 0 0];
        case 'c'
            n=5;m=m-1;A=A-isequal(keyC.FaceColor,[1 0 0]);keyC.FaceColor=[1 0 0];En_1.BackgroundColor=[1 0 0];
        case 'C'
            n=5;m=m-1;A=A-isequal(keyC.FaceColor,[1 0 0]);keyC.FaceColor=[1 0 0];En_1.BackgroundColor=[1 0 0];
        case 'v'
            n=6;m=m-1;A=A-isequal(keyV.FaceColor,[1 0 0]);keyV.FaceColor=[1 0 0];Fn_1.BackgroundColor=[1 0 0];
        case 'V'
            n=6;m=m-1;A=A-isequal(keyV.FaceColor,[1 0 0]);keyV.FaceColor=[1 0 0];Fn_1.BackgroundColor=[1 0 0];
        case 'g'
            n=7;m=m-1;A=A-isequal(keyG.FaceColor,[1 0 0]);keyG.FaceColor=[1 0 0];Fun_1.BackgroundColor=[1 0 0];
        case 'G'
            n=7;m=m-1;A=A-isequal(keyG.FaceColor,[1 0 0]);keyG.FaceColor=[1 0 0];Fun_1.BackgroundColor=[1 0 0];
        case 'b'
            n=8;m=m-1;A=A-isequal(keyB.FaceColor,[1 0 0]);keyB.FaceColor=[1 0 0];Gn_1.BackgroundColor=[1 0 0];
        case 'B'
            n=8;m=m-1;A=A-isequal(keyB.FaceColor,[1 0 0]);keyB.FaceColor=[1 0 0];Gn_1.BackgroundColor=[1 0 0];
        case 'h'
            n=9;m=m-1;A=A-isequal(keyH.FaceColor,[1 0 0]);keyH.FaceColor=[1 0 0];Gun_1.BackgroundColor=[1 0 0];
        case 'H'
            n=9;m=m-1;A=A-isequal(keyH.FaceColor,[1 0 0]);keyH.FaceColor=[1 0 0];Gun_1.BackgroundColor=[1 0 0];
        case 'n'
            n=10;m=m-1;A=A-isequal(keyN.FaceColor,[1 0 0]);keyN.FaceColor=[1 0 0];An_1.BackgroundColor=[1 0 0];
        case 'N'
            n=10;m=m-1;A=A-isequal(keyN.FaceColor,[1 0 0]);keyN.FaceColor=[1 0 0];An_1.BackgroundColor=[1 0 0];
        case 'j'
            n=11;m=m-1;A=A-isequal(keyJ.FaceColor,[1 0 0]);keyJ.FaceColor=[1 0 0];Aun_1.BackgroundColor=[1 0 0];
        case 'J'
            n=11;m=m-1;A=A-isequal(keyJ.FaceColor,[1 0 0]);keyJ.FaceColor=[1 0 0];Aun_1.BackgroundColor=[1 0 0];
        case 'm'
            n=12;m=m-1;A=A-isequal(keyM.FaceColor,[1 0 0]);keyM.FaceColor=[1 0 0];Bn_1.BackgroundColor=[1 0 0];
        case 'M'
            n=12;m=m-1;A=A-isequal(keyM.FaceColor,[1 0 0]);keyM.FaceColor=[1 0 0];Bn_1.BackgroundColor=[1 0 0];
        case 'q'
            A=A-isequal(keyQ.FaceColor,[1 0 0]);keyQ.FaceColor=[1 0 0];Cn.BackgroundColor=[1 0 0];
        case 'Q'
            A=A-isequal(keyQ.FaceColor,[1 0 0]);keyQ.FaceColor=[1 0 0];Cn.BackgroundColor=[1 0 0];
        case '2'
            n=2;A=A-isequal(key2.FaceColor,[1 0 0]);key2.FaceColor=[1 0 0];Cun.BackgroundColor=[1 0 0];
        case 'w'
            n=3;A=A-isequal(keyW.FaceColor,[1 0 0]);keyW.FaceColor=[1 0 0];Dn.BackgroundColor=[1 0 0];
        case 'W'
            n=3;A=A-isequal(keyW.FaceColor,[1 0 0]);keyW.FaceColor=[1 0 0];Dn.BackgroundColor=[1 0 0];
        case '3'
            n=4;A=A-isequal(key3.FaceColor,[1 0 0]);key3.FaceColor=[1 0 0];Dun.BackgroundColor=[1 0 0];
        case 'e'
            n=5;A=A-isequal(keyE.FaceColor,[1 0 0]);keyE.FaceColor=[1 0 0];En.BackgroundColor=[1 0 0];
        case 'E'
            n=5;A=A-isequal(keyE.FaceColor,[1 0 0]);keyE.FaceColor=[1 0 0];En.BackgroundColor=[1 0 0];
        case 'r'
            n=6;A=A-isequal(keyR.FaceColor,[1 0 0]);keyR.FaceColor=[1 0 0];Fn.BackgroundColor=[1 0 0];
        case 'R'
            n=6;A=A-isequal(keyR.FaceColor,[1 0 0]);keyR.FaceColor=[1 0 0];Fn.BackgroundColor=[1 0 0];
        case '5'
            n=7;A=A-isequal(key5.FaceColor,[1 0 0]);key5.FaceColor=[1 0 0];Fun.BackgroundColor=[1 0 0];
        case 't'
            n=8;A=A-isequal(keyT.FaceColor,[1 0 0]);keyT.FaceColor=[1 0 0];Gn.BackgroundColor=[1 0 0];
        case 'T'
            n=8;A=A-isequal(keyT.FaceColor,[1 0 0]);keyT.FaceColor=[1 0 0];Gn.BackgroundColor=[1 0 0];
        case '6'
            n=9;A=A-isequal(key6.FaceColor,[1 0 0]);key6.FaceColor=[1 0 0];Gun.BackgroundColor=[1 0 0];
        case 'y'
            n=10;A=A-isequal(keyY.FaceColor,[1 0 0]);keyY.FaceColor=[1 0 0];An.BackgroundColor=[1 0 0];
        case 'Y'
            n=10;A=A-isequal(keyY.FaceColor,[1 0 0]);keyY.FaceColor=[1 0 0];An.BackgroundColor=[1 0 0];
        case '7'
            n=11;A=A-isequal(key7.FaceColor,[1 0 0]);key7.FaceColor=[1 0 0];Aun.BackgroundColor=[1 0 0];
        case 'u'
            n=12;A=A-isequal(keyU.FaceColor,[1 0 0]);keyU.FaceColor=[1 0 0];Bn.BackgroundColor=[1 0 0];
        case 'U'
            n=12;A=A-isequal(keyU.FaceColor,[1 0 0]);keyU.FaceColor=[1 0 0];Bn.BackgroundColor=[1 0 0];
        case 'i'
            m=m+1;A=A-isequal(keyI.FaceColor,[1 0 0]);keyI.FaceColor=[1 0 0];Cn1.BackgroundColor=[1 0 0];
        case 'I'
            m=m+1;A=A-isequal(keyI.FaceColor,[1 0 0]);keyI.FaceColor=[1 0 0];Cn1.BackgroundColor=[1 0 0];
        case '9'
            n=2;m=m+1;A=A-isequal(key9.FaceColor,[1 0 0]);key9.FaceColor=[1 0 0];Cun1.BackgroundColor=[1 0 0];
        case 'o'
            n=3;m=m+1;A=A-isequal(keyO.FaceColor,[1 0 0]);keyO.FaceColor=[1 0 0];Dn1.BackgroundColor=[1 0 0];
        case 'O'
            n=3;m=m+1;A=A-isequal(keyO.FaceColor,[1 0 0]);keyO.FaceColor=[1 0 0];Dn1.BackgroundColor=[1 0 0];
        case '0'
            n=4;m=m+1;A=A-isequal(key0.FaceColor,[1 0 0]);key0.FaceColor=[1 0 0];Dun1.BackgroundColor=[1 0 0];
        case 'p'
            n=5;m=m+1;A=A-isequal(keyP.FaceColor,[1 0 0]);keyP.FaceColor=[1 0 0];En1.BackgroundColor=[1 0 0];
        case 'P'
            n=5;m=m+1;A=A-isequal(keyP.FaceColor,[1 0 0]);keyP.FaceColor=[1 0 0];En1.BackgroundColor=[1 0 0];
        case '['
            n=6;m=m+1;A=A-isequal(keyKuo.FaceColor,[1 0 0]);keyKuo.FaceColor=[1 0 0];Fn1.BackgroundColor=[1 0 0];
        otherwise
            A=0;
    end
    key_sound=n_sound(n,m);
    key_sound=A*key_sound/max(key_sound);
    sound(key_sound,fs);
end

function keyreleasefcn(h,evt) %当按键松开时钢琴键恢复黑白色
    global keyZ keyS keyX keyD keyC keyV keyG keyB keyH keyN keyJ keyM keyQ key2 keyW key3 keyE keyR key5 keyT key6 keyY key7 keyU keyI key9 keyO key0 keyP keyKuo
    global Cn_1 Dn_1 En_1 Fn_1 Gn_1 An_1 Bn_1 Cn Dn En Fn Gn An Bn Cn1 Dn1 En1 Fn1 Cun_1 Dun_1 Fun_1 Gun_1 Aun_1 Cun Dun Fun Gun Aun Cun1 Dun1
    switch evt.Character
        case 'z'
            keyZ.FaceColor=[1 1 1];Cn_1.BackgroundColor=[1 1 1];
        case 'Z'
            keyZ.FaceColor=[1 1 1];Cn_1.BackgroundColor=[1 1 1];
        case 's'
            keyS.FaceColor=[0 0 0];Cun_1.BackgroundColor=[0 0 0];
        case 'S'
            keyS.FaceColor=[0 0 0];Cun_1.BackgroundColor=[0 0 0];
        case 'x'
            keyX.FaceColor=[1 1 1];Dn_1.BackgroundColor=[1 1 1];
        case 'X'
            keyX.FaceColor=[1 1 1];Dn_1.BackgroundColor=[1 1 1];
        case 'd'
            keyD.FaceColor=[0 0 0];Dun_1.BackgroundColor=[0 0 0];
        case 'D'
            keyD.FaceColor=[0 0 0];Dun_1.BackgroundColor=[0 0 0];
        case 'c'
            keyC.FaceColor=[1 1 1];En_1.BackgroundColor=[1 1 1];
        case 'C'
            keyC.FaceColor=[1 1 1];En_1.BackgroundColor=[1 1 1];
        case 'v'
            keyV.FaceColor=[1 1 1];Fn_1.BackgroundColor=[1 1 1];
        case 'V'
            keyV.FaceColor=[1 1 1];Fn_1.BackgroundColor=[1 1 1];
        case 'g'
            keyG.FaceColor=[0 0 0];Fun_1.BackgroundColor=[0 0 0];
        case 'G'
            keyG.FaceColor=[0 0 0];Fun_1.BackgroundColor=[0 0 0];
        case 'b'
            keyB.FaceColor=[1 1 1];Gn_1.BackgroundColor=[1 1 1];
        case 'B'
            keyB.FaceColor=[1 1 1];Gn_1.BackgroundColor=[1 1 1];
        case 'h'
            keyH.FaceColor=[0 0 0];Gun_1.BackgroundColor=[0 0 0];
        case 'H'
            keyH.FaceColor=[0 0 0];Gun_1.BackgroundColor=[0 0 0];
        case 'n'
            keyN.FaceColor=[1 1 1];An_1.BackgroundColor=[1 1 1];
        case 'N'
            keyN.FaceColor=[1 1 1];An_1.BackgroundColor=[1 1 1];
        case 'j'
            keyJ.FaceColor=[0 0 0];Aun_1.BackgroundColor=[0 0 0];
        case 'J'
            keyJ.FaceColor=[0 0 0];Aun_1.BackgroundColor=[0 0 0];
        case 'm'
            keyM.FaceColor=[1 1 1];Bn_1.BackgroundColor=[1 1 1];
        case 'M'
            keyM.FaceColor=[1 1 1];Bn_1.BackgroundColor=[1 1 1];
        case 'q'
            keyQ.FaceColor=[1 1 1];Cn.BackgroundColor=[1 1 1];
        case 'Q'
            keyQ.FaceColor=[1 1 1];Cn.BackgroundColor=[1 1 1];
        case '2'
            key2.FaceColor=[0 0 0];Cun.BackgroundColor=[0 0 0];
        case 'w'
            keyW.FaceColor=[1 1 1];Dn.BackgroundColor=[1 1 1];
        case 'W'
            keyW.FaceColor=[1 1 1];Dn.BackgroundColor=[1 1 1];
        case '3'
            key3.FaceColor=[0 0 0];Dun.BackgroundColor=[0 0 0];
        case 'e'
            keyE.FaceColor=[1 1 1];En.BackgroundColor=[1 1 1];
        case 'E'
            keyE.FaceColor=[1 1 1];En.BackgroundColor=[1 1 1];
        case 'r'
            keyR.FaceColor=[1 1 1];Fn.BackgroundColor=[1 1 1];
        case 'R'
            keyR.FaceColor=[1 1 1];Fn.BackgroundColor=[1 1 1];
        case '5'
            key5.FaceColor=[0 0 0];Fun.BackgroundColor=[0 0 0];
        case 't'
            keyT.FaceColor=[1 1 1];Gn.BackgroundColor=[1 1 1];
        case 'T'
            keyT.FaceColor=[1 1 1];Gn.BackgroundColor=[1 1 1];
        case '6'
            key6.FaceColor=[0 0 0];Gun.BackgroundColor=[0 0 0];
        case 'y'
            keyY.FaceColor=[1 1 1];An.BackgroundColor=[1 1 1];
        case 'Y'
            keyY.FaceColor=[1 1 1];An.BackgroundColor=[1 1 1];
        case '7'
            key7.FaceColor=[0 0 0];Aun.BackgroundColor=[0 0 0];
        case 'u'
            keyU.FaceColor=[1 1 1];Bn.BackgroundColor=[1 1 1];
        case 'U'
            keyU.FaceColor=[1 1 1];Bn.BackgroundColor=[1 1 1];
        case 'i'
            keyI.FaceColor=[1 1 1];Cn1.BackgroundColor=[1 1 1];
        case 'I'
            keyI.FaceColor=[1 1 1];Cn1.BackgroundColor=[1 1 1];
        case '9'
            key9.FaceColor=[0 0 0];Cun1.BackgroundColor=[0 0 0];
        case 'o'
            keyO.FaceColor=[1 1 1];Dn1.BackgroundColor=[1 1 1];
        case 'O'
            keyO.FaceColor=[1 1 1];Dn1.BackgroundColor=[1 1 1];
        case '0'
            key0.FaceColor=[0 0 0];Dun1.BackgroundColor=[0 0 0];
        case 'p'
            keyP.FaceColor=[1 1 1];En1.BackgroundColor=[1 1 1];
        case 'P'
            keyP.FaceColor=[1 1 1];En1.BackgroundColor=[1 1 1];
        case '['
            keyKuo.FaceColor=[1 1 1];Fn1.BackgroundColor=[1 1 1];
    end
end