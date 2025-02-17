function [Gripper] = Workspace_Arrow(QS,RightArm,LeftArm)
%function [Dex] = ReachableWorkspace(Visual_LW,Visual_RW,N,QS,RightMaster)
Nq = 7;
% global LeftMaster;
% 3D Position --- Dexterity 


Vector_Left = [0 0 30 ] * rotx(2.84) *roty(0.26);
Vector_Right = [0 0 30 ] * rotx(2.84) *roty(-0.26);
 
Vector_Left = [0 0 30 ] * rotx(2.2253) *roty(0.5236);
Vector_Right = [0 0 30 ] * rotx(2.2253) *roty(-0.5236);

[N,~] = size(QS);
Gripper = zeros(N,2);

for i = 1:1:N
    [TQS,All]= RightArm.fkine(QS(i,:));
    TQS = TQS.T;
    T_All = All(1).T;
    PP = T_All(1:3,4);
    PP = PP';   
    P(1)= TQS(1,4);   P(2) = TQS(2,4);    P(3) = TQS(3,4);
    A  =  (P - PP);
    A = A/norm(A);
    
    Gripper(i,1) = Two_Vector_Angle(A,Vector_Right);
end


for i = 1:1:N
     [TQS,All]= LeftArm.fkine(QS(i,:));
     TQS= TQS.T;
     T_All = All(1).T;
     PP =T_All(1:3,4);
     PP = PP';  P(1)= TQS(1,4);   P(2) = TQS(2,4);    P(3) = TQS(3,4);
     A  =  (P - PP);
     A = A/norm(A);
    
     Gripper(i,2) = Two_Vector_Angle(A,Vector_Left);
    
end

     %RightArm.plot(QS(Num,:),'shading','notiles','noshadow','nobase','jointdiam',1,'jointcolor','y','scale',1 );
%%
% Norminization

Max1 = max(Gripper(:,1));
Gripper(:,1) = Gripper(:,1)/Max1;
Gripper(:,1) = 1-Gripper(:,1);

Max1 = max(Gripper(:,2));
Gripper(:,2) = Gripper(:,2)/Max1;
Gripper(:,2) = 1-Gripper(:,2);

path = '.\\Data\\Gripper';  
save(path,'Gripper');

end

