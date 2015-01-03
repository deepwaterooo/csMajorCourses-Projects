#include<stdio.h>
#include<iomanip.h>
    #define N 20 //学习样本个数 
    #define IN 1 //输入层神经元数目 
    #define HN 8 //隐层神经元数目 
    #define ON 1 //输出层神经元数目 
    double P[IN]; //单个样本输入数据 
    double T[ON]; //单个样本教师数据 
    double W[HN][IN]; //输入层至隐层权值 
    double V[ON][HN]; //隐层至输出层权值 
    double X[HN]; //隐层的输入 
    double Y[ON]; //输出层的输入 
    double H[HN]; //隐层的输出 
    double O[ON]; //输出层的输出 
    double sita[HN]; //隐层的阈值 
    double gama[ON]; //输出层的阈值 
    double err_m[N]; //第m个样本的总误差 
    double alpha; //输出层至隐层的学习效率 
    double beta; //隐层至输入层学习效率 
    //定义一个放学习样本的结构 
    struct { 
        double input[IN]; 
        double teach[ON]; 
    }Study_Data[N][IN]; 
     
    /////////////////////////// 
    //初始化权、阈值子程序///// 
    /////////////////////////// 
    initial() 
    { 
        float sgn; 
        float rnd; 
        int i,j; 
        //隐层权、阈值初始化// 
        { 
            //sgn=pow((-1),random(100)); 
            sgn=rand(); 
            rnd=sgn*(rand()%100); 
            W[j][i]= rnd/100;//隐层权值初始化。 
        } 
        //randomize(); 
        { 
            //sgn=pow((-1),random(1000)); 
            sgn=rand(); 
            rnd=sgn*(rand()%1000); 
            sita[j]= rnd/1000;//中间层阈值初始化 
            cout<<"sita"<<sita[j]<<endl; 
        } 
        //输出层权、阈值初始化// 
        //randomize(); 
        for (int k=0;k<ON;k++) 
            for (int j=0;j<HN;j++)  
            { 
                //sgn=pow((-1),random(1000)); 
                sgn=rand(); 
                rnd=sgn*(rand()%1000); 
                V[k][j]=rnd/1000;//第m个样本输出层权值初始化 
            } 
            //randomize(); 
            { 
                //sgn=pow((-1),random(10)); 
                sgn=rand(); 
                rnd=sgn*(rand()%10); 
                gama[k]=rnd/10;//输出层阈值初始化 
                cout<<"gama[k]"<<endl; 
            } 
            return 1; 
             
    }//子程序initial()结束 
     
     
    //////////////////////////////// 
    ////第m个学习样本输入子程序/// 
    /////////////////////////////// 
    input_P(int m) 
    { 
        for (int i=0;i<IN;i++) 
            P[i]=Study_Data[m]->input[i]; 
        //获得第m个样本的数据 
        //cout<<"第"< //fprintf(fp,"第%d个样本的学习输入： 
        //P[%d]=%f\n",m,P[i]); 
        return 1; 
    }//子程序input_P(m）结束 
     
    ///////////////////////////// 
    ////第m个样本教师信号子程序// 
    ///////////////////////////// 
    input_T(int m) 
    { 
        for (int k=0;k<m;k++) 
            T[k]=Study_Data[m]->teach[k]; 
        //cout<<"第"< //fprintf(fp,"第%d个样本的教师信号：T[%d]=%f\n",m,T[k]); 
        return 1; 
    }//子程序input_T(m)结束 
     
    ///////////////////////////////// 
    //隐层各单元输入、输出值子程序/// 
    ///////////////////////////////// 
    H_I_O(){ 
        double sigma; 
        int i,j; 
        for (j=0;j<HN;j++) 
            sigma=0.0; 
        for (i=0;i<IN;i++) 
            sigma+=W[j][i]*P[i];//求隐层内积 
    } 
    X[j]=sigma - sita[i];//求隐层净输入 
    H[j]=1.0/(1.0+exp(-X[j]));//求隐层输出 
    } 
    return 1; 
    }//子程序H_I_O()结束 
     
    /////////////////////////////////// 
    //输出层各单元输入、输出值子程序/// 
    /////////////////////////////////// 
    O_I_O() 
    { 
        double sigma; 
        for (int k=0;k<ON;k++) 
            sigma=0.0; 
        for (int j=0;j<HN;j++) 
            sigma+=V[k][j]*H[k];//求输出层内积 
    } 
    Y[k]=sigma-gama[k]; //求输出层净输入 
    O[k]=1.0/(1.0+exp(-Y[k]));//求输出层输出 
    } 
    return 1; 
    }//子程序O_I_O()结束 
     
    //////////////////////////////////// 
    //输出层至隐层的一般化误差子程序//// 
    //////////////////////////////////// 
    double d_err[ON]; 
    Err_O_H(int m) 
    { 
        double abs_err[ON];//每个样本的绝对误差都是从0开始的 
        double sqr_err=0;//每个样本的平方误差计算都是从0开始的 
        //for (int output=0;output<ON;output++)  //output??? 
        for (int k=0;k<ON;k++) 
            abs_err[k]=T[k]-O[k]; 
        //求第m个样本下的第k个神经元的绝对误差 
        sqr_err+=(abs_err[k])*(abs_err[k]);//求第m个样本下输出层的平方误差 
         
        d_err[k]=abs_err[k]*O[k]*(1.0-O[k]);//d_err[k]输出层各神经元的一般化误差 
    } 
    err_m[m]=sqr_err/2;//第m个样本下输出层的平方误差/2=第m个样本的均方误差 
    return 1; 
    }//子程序Err_O_H(m)结束 
     
    //////////////////////////////////// 
    //隐层至输入层的一般化误差子程序//// 
    //////////////////////////////////// 
    double e_err[HN]; 
    Err_H_I(){ 
        double sigma; 
        //for (int hidden=0;hidden 
        for (int j=0;j<HN;j++)  
            sigma=0.0; 
        for (int k=0;k<ON;k++)  
            sigma=d_err[k]*V[k][j]; 
    } 
    e_err[j]=sigma*H[j]*(1-H[j]);//隐层各神经元的一般化误差 
    } 
    return 1; 
    }//子程序Err_H_I()结束 
     
    //////////////////////////////////////////////////////// 
    //输出层至隐层的权值调整、输出层阈值调整计算子程序////// 
    //////////////////////////////////////////////////////// 
    Delta_O_H(int m,FILE* fp) 
    { 
        for (int k=0;k<ON;k++) 
            for (int j=0;j<HN;j++) 
                //cout<<"第"< fprintf(fp,"第%d个样本时的输出层至隐层的权值为：%f\n",m,W[k][j]); 
                V[k][j]+=alpha*d_err[k]*H[j];//输出层至隐层的权值调整 
    } 
    gama[k]+=alpha*d_err[k];//输出层至隐层的阈值调整 
    } 
    return 1; 
    }//子程序Delta_O_H()结束 
     
    ///////////////////////////////////////////////////// 
    //隐层至输入层的权值调整、隐层阈值调整计算子程序///// 
    ///////////////////////////////////////////////////// 
    Delta_H_I(int m,FILE* fp) 
    { 
        for (int j=0;j<HN;j++) 
            for (int i=0;i<IN;i++)  
                //cout<<"第"< fprintf(fp,"第%d个样本时的输出层至隐层的权值为：%f\n",m,V[j][i]); 
                W[j][i]+=beta*e_err[j]*P[i];//隐层至输入层的权值调整 
    } 
    sita[j]+=beta*e_err[j]; 
    } 
    return 1; 
    }//子程序Delta_H_I()结束 
     
    ///////////////////////////////// 
    //N个样本的全局误差计算子程序//// 
    ///////////////////////////////// 
    double Err_Sum() 
    { 
        double total_err=0; 
        for (int m=0;m<N;m++)  
            total_err+=err_m[m];//每个样本的均方误差加起来就成了全局误差 
    } 
    return 1; 
    }//子程序Err_sum()结束 
     
    /**********************/ 
    /**程序入口，即主程序**/ 
    /**********************/ 
    main() 
    { 
        FILE *fp; 
        double sum_err; 
        int study;//训练次数 
         
        if ((fp=fopen("bp.txt","a+"))==NULL) 
        { 
            printf("不能创建bp.txt文件!\n"); 
            exit(1); 
        } 
        cout<<"请输入输出层到隐含层学习效率: alpha=\n"; 
        cin>>alpha; 
         
        cout<<"请输入隐含层到输入层学习效率: beta=\n"; 
        cin>>beta; 
         
        int study=0; //学习次数 
        double Pre_error ; //预定误差 
        cout<<"请输入预定误差: Pre_error= \n"; 
        cin>>Pre_error; 
         
        int Pre_times; 
        cout<<"请输入预定最大学习次数:Pre_times=\n"; 
        cin>>Pre_times; 
         
        cout<<"请输入学习样本数据\n"; 
        { 
            for (int m=0;m<N;m++) 
                cout<<"请输入第"<<m+1<<"组学习样本"<<endl;  
            for (int i=0;i<IN;i++) 
                cin>>Study_Data[m]->input[i]; 
        } 
        {   
            for (int m=0;m<N;m++) 
                cout<<"请输入第"<<m+1<<"组教师样本"<<endl;  
            for (int k=0;k<ON;k++) 
                cin>>Study_Data[m]->teach[k]; 
        } 
         
        initial(); //隐层、输出层权、阈值初始化 (1)  
        do 
        { 
            ++study; ///??? 
            for (int m=0;m<N;m++)  
            { 
                input_P(m); //输入第m个学习样本 (2) 
                input_T(m);//输入第m个样本的教师信号 (3) 
                H_I_O(); //第m个学习样本隐层各单元输入、输出值 (4) 
                O_I_O(); //第m个学习样本输出层各单元输入、输出值 (5) 
                Err_O_H(m); //第m个学习样本输出层至隐层一般化误差 (6)  
                Err_H_I(); //第m个学习样本隐层至输入层一般化误差 (7) 
                Delta_O_H(m,fp); //第m个学习样本输出层至隐层权阈值调整、修改 (8) 
                Delta_H_I(m,fp); //第m个学习样本隐层至输入层权阈值调整、修改 (9) 
            } //全部样本训练完毕 
             
            sum_err=Err_Sum(); //全部样本全局误差计算 (10) 
            { 
                cout<<"第"<<study<<"次学习的均方误差为"<<sum_err<<endl; 
                fprintf(fp,"第%d次学习的均方误差为：%f\n",study,sum_err); 
            } 
             
            while (sum_err > Pre_error)    //or(study 
            { //N个样本全局误差小于预定误差否？ 小于则退出 (11) 
                cout<<"网络已经学习了"<<study<<"次,学习的均方误差为"<<sum_err<<endl; 
                fprintf(fp,"网络已经学习了%d次，现在的全局误差为：%f\n",study,total_err); 
                fclose(fp); 
            } 
            char s; 
            cout<<"请随便输入一个字符，按回车退出程序！\n"; 
            cin>>s; 
            return 1; 
        } 
    } 


