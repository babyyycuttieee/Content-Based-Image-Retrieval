%Function for Getting Bin values for Each Block
function bins=getbins(imgb)

[M,N]=size(imgb);
M=2*floor(M/2); N=2*floor(N/2);
imgb=imresize(imgb,[M,N]);      % Making block dimensions divisible by 2
bins=zeros(1,5);     % Initialize Bin

%--------------Operators-------------------
V=[1 -1;1 -1];       % Vertical edge operator
H=[1 1;-1 -1];       % Horizondal edge operator
D45=[1.414 0;0 -1.414];     % Diagonal 45 edge operator
D135=[0 1.414;-1.414 0];    % Diagonal 135 edge operator
ISOT=[2 -2;-2 2];     % isotropic edge operator

T=50;   % Threshold
nobr=M/2; nobc=N/2;     % Loop limits
L=0;

for i=1:nobc
    K=0;
    for j=1:nobr
        block=imgb(K+1:K+2,L+1:L+2);    % Extracting 2x2 block

         % Applying Operators
        pv=abs(sum(sum(block.*V)));    
        ph=abs(sum(sum(block.*H)));
        pd45=abs(sum(sum(block.*D45)));    
        pd135=abs(sum(sum(block.*D135)));
        pisot=abs(sum(sum(block.*ISOT)));    
        [value,index]=max([pv, ph, pd45, pd135, pisot]);    % Finding dominant edge

        if value>=T
            bins(index)=bins(index)+1;  %Updating Bin values
        end
        K=K+2;
    end
    L=L+2;
end

       