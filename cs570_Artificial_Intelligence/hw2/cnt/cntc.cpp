/*��ʼ��д����2011��9��21��*/
//����������
//�����ۺ�������
//�����������������ڶ�����
//����������
//��PVS���ڶ�����
//����ϣ��(�ڶ���)(�߳��߽�)(ʼ�ո���)
//�޳��������汾(�޳�һЩû���õı�������������)
#include<iostream>
#include<conio.h>
#include<stdio.h>
#include<stdlib.h>
#include<time.h>
using namespace std;
class CONNECT_FOUR;
class SITE;
enum HASH_FLAGS{hash_exact,hash_alpha,hash_beta,hash_null};
class HASH_TABLE//ɢ�б�
{
public:
	unsigned long long x_key;//x������bit״̬,���ڽ��о���У��
	unsigned long long o_key;//o������bit״̬,���ڽ��о���У��
	int ply;//����
	int value;//����
	HASH_FLAGS flags;//���ֱ�־������ȷ����ϣ���д洢����Ϣ�Ƿ�ɿ�
	int best;//����з�
	//int now_player;//����˳��
	char my;//��ǰ�������巽������ȷ����ϣ���д洢����Ϣ�Ƿ�ɿ�
	inline HASH_TABLE();
};
inline HASH_TABLE::HASH_TABLE()
{
	x_key=-1;
	o_key=-1;
	ply=-1;
	value=0;
	best=-1;
	//now_player=-1;
	my=NULL;
	flags=hash_null;
}
class MAIN_LINE
{
public:
	int move_array_max_index;
	int move_array[50];
	inline MAIN_LINE();
};
inline MAIN_LINE::MAIN_LINE()
{
	move_array_max_index=0;
}
class BOARD_LINE
{
public:
	BOARD_LINE *last;//ǰ��
	int now_player;//������Ĳ���
	char board[6][7];//��һά�Ǵ�ֱ���꣬�ڶ�ά��ˮƽ����
	bool undo();//����
	BOARD_LINE *next;//����
	inline BOARD_LINE();
	inline ~BOARD_LINE();
};
class SITE
{
public:
	//x��ˮƽ����(�У���y�Ǵ�ֱ���꣨�У���boole�����ж�λ���Ƿ���Ч
	bool boole;
	//bool search;//Ϊ���ʾ��Ҫ����
	int value;//�з���ֵ
	int x;
	int y;
	int index;//���з��±�
	MAIN_LINE *main_line_pointer;//���з���Ҫ·��
	inline SITE();
};
class CONNECT_FOUR//������ ��
{
public:
	static char my;//������
	static char foe;//���෽
	static char board[6][7];//��һά�Ǵ�ֱ���꣬�ڶ�ά��ˮƽ����
	static const int board_bit_site[6][7];//����ӳ���ά�����±���һάbit�����е�λ��
	static int now_player;//��ǰ����
	static int hash_max_now_player;//�����ж��Ƿ񸲸ǹ�ϣ������ϣ���еľ�����뵱ǰ˼�����泬����ֵ����и���
	static int ply;//��������
	static BOARD_LINE *last;//ǰһ������
	static int const unknown=2147483647;
	static int const infinite=2147483647-1000000;//�����
	static int const win=infinite-1000000;//ʤ��
	static int const lose=-win;//ʧ��
	static int const draw=0;//�;�
	static bool iterative_deepening;//��������״̬
	static const unsigned int hash_table_size=16777216;
	static HASH_TABLE *hash_table;//��ϣ������ָ��
	static MAIN_LINE *now_main_line;//��ǰ��Ҫ·��
	inline void hash_key_update(const unsigned long long &x_key,const unsigned long long &o_key,unsigned long long &next_x_key,unsigned long long &next_o_key,SITE &move);//�����ϣ��KEY���º���
	inline bool player_switch();//�����ж�
	inline void scanf_board(char player,SITE &site,bool &undo);
	inline void printf_board(void);//������ʾ����
	inline int evaluate(char my,bool &game_end);//�������ۺ���
	inline int connect_evaluate(char player,int x,int y);
	inline void go(SITE &best_move);
	inline int seek(const unsigned long long &x_key,const unsigned long long &o_key,const int &alpha,const int &beta,const int &ply,const char &my,bool &hash_best_boole);//�û�����Һ���
	inline void save(const unsigned long long &x_key,const unsigned long long &o_key,const int &value,const int &ply,const char &my,const HASH_FLAGS &hash_flags,const int best_move);//�û���д�뺯��
	inline int search(int alpha,int beta,char my,char foe,int ply,SITE last_move_array[7],MAIN_LINE *line_pointer,int ply_counter,SITE &last_move,unsigned long long x_key,unsigned long long o_key);
};
HASH_TABLE *CONNECT_FOUR::hash_table=new HASH_TABLE[hash_table_size];//��ϣ������ָ��
BOARD_LINE *CONNECT_FOUR::last=NULL;//ǰһ������
const int CONNECT_FOUR::board_bit_site[6][7]={0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41};//����ӳ���ά�����±���һά����λ���е�λ��
char CONNECT_FOUR::board[6][7]={NULL}; //����
char CONNECT_FOUR::my=NULL; //������
char CONNECT_FOUR::foe=NULL; //���෽
int CONNECT_FOUR::now_player=0; //��ǰ����
int CONNECT_FOUR::ply=-1; //��������
int CONNECT_FOUR::hash_max_now_player=-1;//�����ж��Ƿ񸲸ǹ�ϣ������ϣ���еľ�����뵱ǰ˼�����泬����ֵ����и���
MAIN_LINE *CONNECT_FOUR::now_main_line;//��ǰ��Ҫ·��
bool CONNECT_FOUR::iterative_deepening=false;//��������״̬

inline SITE::SITE()
{
	x=0;
	y=0;
	value=-CONNECT_FOUR::infinite;//�з���ֵ
	boole=false;
	index=-1;
	main_line_pointer=NULL;
	//search=false;
}

inline void CONNECT_FOUR::save(const unsigned long long &x_key,const unsigned long long &o_key,const int &value,const int &ply,const char &my,const HASH_FLAGS &hash_flags,const int best_move)//�û���д�뺯��
{
	const unsigned int now_node_index=(x_key+o_key)%hash_table_size;//���㵱ǰ���ɢ��ֵ,ͨ����ǰ���ɢ��ֵ���㵱ǰ����ڹ�ϣ���е�λ��
	/*if((ply>=hash_table[now_node_index].ply)||((hash_table[now_node_index].now_player<=CONNECT_FOUR::now_player)||(hash_table[now_node_index].now_player>CONNECT_FOUR::hash_max_now_player)))
	{*/
		hash_table[now_node_index].my=my;
		hash_table[now_node_index].flags=hash_flags;
		//hash_table[now_node_index].now_player=now_node_player;
		hash_table[now_node_index].best=best_move;
		hash_table[now_node_index].value=value;
		hash_table[now_node_index].x_key=x_key;
		hash_table[now_node_index].o_key=o_key;
		hash_table[now_node_index].ply=ply;
	/*}*/
}

inline int CONNECT_FOUR::seek(const unsigned long long &x_key,const unsigned long long &o_key,const int &alpha,const int &beta,const int &ply,const char &my,bool &hash_best_boole)
{
	const unsigned int now_node_index=(x_key+o_key)%hash_table_size;//���㵱ǰ���ɢ��ֵ,ͨ����ǰ���ɢ��ֵ���㵱ǰ����ڹ�ϣ���е�λ��
	hash_best_boole=false;
	if((hash_table[now_node_index].flags!=hash_null)&&(hash_table[now_node_index].my==my)&&((hash_table[now_node_index].x_key==x_key)&&(hash_table[now_node_index].o_key==o_key)))
	{
		if(hash_table[now_node_index].ply>=ply)
		{
			if(hash_table[now_node_index].flags==hash_exact)
			{
				return hash_table[now_node_index].value;
			}
			else if((hash_table[now_node_index].flags==hash_alpha)&&(hash_table[now_node_index].value<=alpha))
			{
				return hash_table[now_node_index].value;
			}
			else if((hash_table[now_node_index].flags==hash_beta)&&(hash_table[now_node_index].value>=beta))
			{
				return hash_table[now_node_index].value;
			}
		}
	}
	if(hash_table[now_node_index].best != -1)
	{
		hash_best_boole=true;
		return hash_table[now_node_index].best;
	}
	return unknown;
}

inline void CONNECT_FOUR::hash_key_update(const unsigned long long &x_key,const unsigned long long &o_key,unsigned long long &next_x_key,unsigned long long &next_o_key,SITE &move)//�����ϣ��KEY���º���
{
	if(board[move.y][move.x]=='X')
	{
		next_o_key=o_key;
		next_x_key=x_key|(1LL<<board_bit_site[move.y][move.x]);
	}
	else if(board[move.y][move.x]=='O')
	{
		next_x_key=x_key;
		next_o_key=o_key|(1LL<<board_bit_site[move.y][move.x]);
	}
	//(board[move.y][move.x]=='X')?(next_x_key=x_key|(1LL<<board_bit_site[move.y][move.x])):next_o_key=o_key|(1LL<<board_bit_site[move.y][move.x]);
}


inline int CONNECT_FOUR::connect_evaluate(char player,int x,int y) // һ���ĵ÷�
{
	int increment_x=0,increment_y=0;
	int value=0,temp_value=0;
	//ˮƽ��������
	for(increment_x=0;((x-increment_x)>=0)&&((x-increment_x)<=6);increment_x++)
	{
		if(board[y][x-increment_x]==player)
		{
			temp_value++;
		}
		else
		{
			break;
		}
	}
	for(increment_x=0;((x+increment_x)>=0)&&((x+increment_x)<=6);increment_x++)
	{
		if(board[y][x+increment_x]==player)
		{
			temp_value++;
		}
		else
		{
			break;
		}
	}
	temp_value--;
	if(temp_value>=4)//�����������ڵ���4����ʾʤ��
	{
		return win;
	}
	value+=temp_value;
	temp_value=0;
	//��ֱ��������
	for(increment_y=0;((y-increment_y)>=0)&&((y-increment_y)<=5);increment_y++)
	{
		if(board[y-increment_y][x]==player)
		{
			temp_value++;
		}
		else
		{
			break;
		}
	}
	for(increment_y=0;((y+increment_y)>=0)&&((y+increment_y)<=5);increment_y++)
	{
		if(board[y+increment_y][x]==player)
		{
			temp_value++;
		}
		else
		{
			break;
		}
	}
	temp_value--;
	if(temp_value>=4)//�����������ڵ���4����ʾʤ��
	{
		return win;
	}
	value+=temp_value;
	temp_value=0;
	//��������б���ж�
	for(increment_x=0,increment_y=0;(((x-increment_x)>=0)&&((x-increment_x)<=6))&&(((y-increment_y)>=0)&&((y-increment_y)<=5));increment_x++,increment_y++)
	{
		if(board[y-increment_y][x-increment_x]==player)
		{
			temp_value++;
		}
		else
		{
			break;
		}
	}
	for(increment_x=0,increment_y=0;(((x+increment_x)>=0)&&((x+increment_x)<=6))&&(((y+increment_y)>=0)&&((y+increment_y)<=5));increment_x++,increment_y++)
	{
		if(board[y+increment_y][x+increment_x]==player)
		{
			temp_value++;
		}
		else
		{
			break;
		}
	}
	temp_value--;
	if(temp_value>=4)//�����������ڵ���4����ʾʤ��
	{
		return win;
	}
	value+=temp_value;
	temp_value=0;
	//��������б���ж�
	for(increment_x=0,increment_y=0;(((x+increment_x)>=0)&&((x+increment_x)<=6))&&(((y-increment_y)>=0)&&((y-increment_y)<=5));increment_x++,increment_y++)
	{
		if(board[y-increment_y][x+increment_x]==player)
		{
			temp_value++;
		}
		else
		{
			break;
		}
	}
	for(increment_x=0,increment_y=0;(((x-increment_x)>=0)&&((x-increment_x)<=6))&&(((y+increment_y)>=0)&&((y+increment_y)<=5));increment_x++,increment_y++)
	{
		if(board[y+increment_y][x-increment_x]==player)
		{
			temp_value++;
		}
		else
		{
			break;
		}
	}
	temp_value--;
	if(temp_value>=4)//�����������ڵ���4����ʾʤ��
	{
		return win;
	}
	value+=temp_value;
	temp_value=0;
	//ˮƽ����ֱ���������¡��������� �ĸ���������������������
	return value;
}


inline int CONNECT_FOUR::evaluate(char my,bool &game_end)
{
  int my_value=0,foe_value=0;
  int temp_value=0;
  int x=0, y=0;
  bool draw=true;//����״̬
  for(x=0;x<7;x++)
    {
      for(y=0;y<6;y++)
	{
	  if(board[y][x]!=NULL)
	    {
	      temp_value=connect_evaluate(board[y][x],x,y);
	      if(temp_value>=win)
		{
		  game_end=true;
		  if(board[y][x]==my)
		    {
		      return win;//����ʤ��
		    }
		  else
		    {
		      return lose;//�з�ʤ��
		    }
		}
	      else
		{
		  if(board[y][x]==my)
		    {
		      my_value+=temp_value;//�������ӷ�������
		    }
		  else
		    {
		      foe_value+=temp_value;//�з����ӷ�������
		    }
		}

	    }
	}
    }
  for(x=0;x<7;x++)
    {
      if(board[0][x]==NULL)
	{
	  draw=false;
	  break;
	}
    }
  if(draw)
    {
      game_end=true;
      return CONNECT_FOUR::draw;//����Ǻ����򷵻غ������
    }
  game_end=false;
  return my_value-foe_value;//���Ǻ��壬���ر��������������ۣ�������������������ָ �������ӷ��� ��ȥ �з����ӷ��� �󣬱�����ʣ�����ӷ�����
}

inline int CONNECT_FOUR::search(int alpha,int beta,char my,char foe,int ply,SITE last_move_array[7],MAIN_LINE *line_pointer,int ply_counter,SITE &last_move,unsigned long long x_key,unsigned long long o_key)
{
	const int mini_save_ply=1;
	int x=0;
	const int x_max=7;
	int value=-infinite;
	int best_value=-infinite;
	bool game_end=false;
	bool search_sort=true;//�ñ�������ȷ��ÿ������ʱ����һ�������з�������
	bool draw_boole=true;//�����ж��Ƿ�;�
	bool pvs_boole=false;
	bool hash_best_boole=false;
	char temp_chessman;
	unsigned long long next_x_key=0;//x������bit״̬,���ڽ��о���У�飬��������Ǵ�����һ���
	unsigned long long next_o_key=0;//o������bit״̬,���ڽ��о���У�飬��������Ǵ�����һ���
	SITE move_array[7],*move_temp_pointer=NULL;
	HASH_FLAGS hash_flags=hash_alpha;
	int hash_best_move=-1;//Ҫд���ϣ�������з�
	int hash_best_move_value=-infinite;
	MAIN_LINE line;
	//	value=evaluate(my,game_end);
	value=seek(x_key,o_key,alpha,beta,ply,my,hash_best_boole);
	if(value!=unknown)
	{
		if(hash_best_boole)
		{
			hash_best_move=value;//���ʱ��value��ֵʵ���ϲ����Ƿ�ֵ,�����з��������е��±�,��seek�������ص����з����Ƿ�ֵ
		}
		else
		{
			return value;//��ʱseek�������ص�����Ч��ֵ,����ֱ�ӷ���
		}
	}
	if(ply<=0)//�����������꣬������ͨ���ۺ���
	{
		line_pointer->move_array_max_index=0;
		value=evaluate(my,game_end);
		if(ply>=mini_save_ply)
		{
			save(x_key,o_key,value,ply,my,hash_exact,hash_best_move);
		}
		return value;
	}
	else if(connect_evaluate(board[last_move.y][last_move.x],last_move.x,last_move.y)>=win)//��������δ���꣬���ÿ������ۺ���
	{
		line_pointer->move_array_max_index=0;
		return lose;
	}
	for(x=0;x<x_max;x++)//��ǰ����з�����
	{
		if(board[0][last_move_array[x].x]!=NULL)
		{
			move_array[x].boole=false;
		}
		else if(board[last_move_array[x].y][last_move_array[x].x]==NULL)
		{
			move_array[x]=last_move_array[x];
			move_array[x].index=x;
			move_array[x].boole=true;
			draw_boole=false;
		}
		else if(board[last_move_array[x].y-1][last_move_array[x].x]==NULL)
		{
			move_array[x]=last_move_array[x];
			move_array[x].y-=1;
			move_array[x].index=x;
			move_array[x].boole=true;
			draw_boole=false;
		}
	}
	if(draw_boole)//û���κκ����з����ߣ����غ;�����
	{
		line_pointer->move_array_max_index=0;
		return draw;
	}
	if(iterative_deepening)
	{
		if(ply_counter < now_main_line->move_array_max_index)
		{
			if(move_array[now_main_line->move_array[ply_counter]].boole)
			{
				temp_chessman=board[move_array[now_main_line->move_array[ply_counter]].y][move_array[now_main_line->move_array[ply_counter]].x];
				board[move_array[now_main_line->move_array[ply_counter]].y][move_array[now_main_line->move_array[ply_counter]].x]=my;
				hash_key_update(x_key,o_key,next_x_key,next_o_key,move_array[now_main_line->move_array[ply_counter]]);
				if(pvs_boole)
				{
					value=-search(-alpha - 1,-alpha,foe,my,ply-1,move_array,&line,ply_counter+1,move_array[now_main_line->move_array[ply_counter]],next_x_key,next_o_key);
					if((value>alpha)&&(value<beta))
					{
						value=-search(-beta,-alpha,foe,my,ply-1,move_array,&line,ply_counter+1,move_array[now_main_line->move_array[ply_counter]],next_x_key,next_o_key);
					}
				}
				else
				{
					value=-search(-beta,-alpha,foe,my,ply-1,move_array,&line,ply_counter+1,move_array[now_main_line->move_array[ply_counter]],next_x_key,next_o_key);
				}
				board[move_array[now_main_line->move_array[ply_counter]].y][move_array[now_main_line->move_array[ply_counter]].x]=temp_chessman;
				if(value>=beta)
				{
					if(ply>=mini_save_ply)
					{
						save(x_key,o_key,value,ply,my,hash_beta,move_array[now_main_line->move_array[ply_counter]].index);
					}
					return value;
				}
				if(value>best_value)
				{
					best_value=value;
					if(value>alpha)
					{
						alpha = value;
						pvs_boole=true;
						hash_flags=hash_exact;
						line_pointer->move_array[0] = move_array[now_main_line->move_array[ply_counter]].index;
						memcpy(line_pointer->move_array+1,line.move_array,line.move_array_max_index * sizeof(int));
						line_pointer->move_array_max_index = line.move_array_max_index + 1;
					}
					if(value>hash_best_move_value)
					{
						hash_best_move_value=value;
						hash_best_move=move_array[now_main_line->move_array[ply_counter]].index;
					}
				}
				move_array[now_main_line->move_array[ply_counter]].boole=false;
			}
		}
	}
	iterative_deepening=false;
	if(hash_best_boole)
	{
		if(move_array[hash_best_move].boole)
		{
			temp_chessman=board[move_array[hash_best_move].y][move_array[hash_best_move].x];
			board[move_array[hash_best_move].y][move_array[hash_best_move].x]=my;
			hash_key_update(x_key,o_key,next_x_key,next_o_key,move_array[hash_best_move]);
			if(pvs_boole)
			{
				value=-search(-alpha - 1,-alpha,foe,my,ply-1,move_array,&line,ply_counter+1,move_array[hash_best_move],next_x_key,next_o_key);
				if((value>alpha)&&(value<beta))
				{
					value=-search(-beta,-alpha,foe,my,ply-1,move_array,&line,ply_counter+1,move_array[hash_best_move],next_x_key,next_o_key);
				}
			}
			else
			{
				value=-search(-beta,-alpha,foe,my,ply-1,move_array,&line,ply_counter+1,move_array[hash_best_move],next_x_key,next_o_key);
			}
			board[move_array[hash_best_move].y][move_array[hash_best_move].x]=temp_chessman;
			if(value>=beta)
			{
				if(ply>=mini_save_ply)
				{
					save(x_key,o_key,value,ply,my,hash_beta,move_array[hash_best_move].index);
				}
				return value;
			}
			if(value>best_value)
			{
				best_value=value;
				if(value>alpha)
				{
					alpha = value;
					pvs_boole=true;
					hash_flags=hash_exact;
					line_pointer->move_array[0] = move_array[hash_best_move].index;
					memcpy(line_pointer->move_array+1,line.move_array,line.move_array_max_index * sizeof(int));
					line_pointer->move_array_max_index = line.move_array_max_index + 1;
				}
				if(value>hash_best_move_value)
				{
					hash_best_move_value=value;
					hash_best_move=move_array[hash_best_move].index;
				}
			}
			move_array[hash_best_move].boole=false;
		}
	}
	for(x=0;x<x_max;x++)
	{
		if((&move_array[x])->boole)
		{
			temp_chessman=board[(&move_array[x])->y][(&move_array[x])->x];
			board[(&move_array[x])->y][(&move_array[x])->x]=my;
			(&move_array[x])->value=evaluate(my,game_end);
			board[(&move_array[x])->y][(&move_array[x])->x]=temp_chessman;
		}
	}
	for(;;)
	{
		search_sort=true;
		for(x=0;x<x_max;x++)
		{
			if((&move_array[x])->boole)
			{
				if(search_sort)
				{
					move_temp_pointer=&move_array[x];
					search_sort=false;
				}
				else if((&move_array[x])->value > move_temp_pointer->value)
				{
					move_temp_pointer=(&move_array[x]);
				}
			}
		}
		if(search_sort)
		{
			break;
		}
		if(move_temp_pointer->boole)
		{
			temp_chessman=board[move_temp_pointer->y][move_temp_pointer->x];
			board[move_temp_pointer->y][move_temp_pointer->x]=my;
			hash_key_update(x_key,o_key,next_x_key,next_o_key,*move_temp_pointer);
			if(pvs_boole)
			{
				value=-search(-alpha - 1,-alpha,foe,my,ply-1,move_array,&line,ply_counter+1,*move_temp_pointer,next_x_key,next_o_key);
				if((value>alpha)&&(value<beta))
				{
					value=-search(-beta,-alpha,foe,my,ply-1,move_array,&line,ply_counter+1,*move_temp_pointer,next_x_key,next_o_key);
				}
			}
			else
			{
				value=-search(-beta,-alpha,foe,my,ply-1,move_array,&line,ply_counter+1,*move_temp_pointer,next_x_key,next_o_key);
			}
			board[move_temp_pointer->y][move_temp_pointer->x]=temp_chessman;
			if(value>=beta)
			{
				if(ply>=mini_save_ply)
				{
					save(x_key,o_key,value,ply,my,hash_beta,move_temp_pointer->index);
				}
				return value;
			}
			if(value>best_value)
			{
				best_value=value;
				if(value>alpha)
				{
					alpha=value;
					pvs_boole=true;
					hash_flags=hash_exact;
					line_pointer->move_array[0]=move_temp_pointer->index;
					memcpy(line_pointer->move_array+1,line.move_array,line.move_array_max_index * sizeof(int));
					line_pointer->move_array_max_index=line.move_array_max_index + 1;
				}
				if(value>hash_best_move_value)
				{
					hash_best_move_value=value;
					hash_best_move=move_temp_pointer->index;
				}
			}
			move_temp_pointer->boole=false;
		}
	}
	if(ply>=mini_save_ply)
	{
		save(x_key,o_key,best_value,ply,my,hash_flags,hash_best_move);
	}
	return best_value;
}

inline void CONNECT_FOUR::go(SITE &best_move)
{
	int x=0;
	int y=0;
	int low=5;
	int value;
	const int x_max=7;
	const int y_max=6;
	const int tall=0;
	int temp_rand=0;
	int temp_ply=0;
	unsigned long long x_key=0;//x������bit״̬,���ڽ��о���У�飬����Ǳ����
	unsigned long long o_key=0;//o������bit״̬,���ڽ��о���У�飬����Ǳ����
	unsigned long long next_x_key=0;//x������bit״̬,���ڽ��о���У�飬��������Ǵ�����һ���
	unsigned long long next_o_key=0;//o������bit״̬,���ڽ��о���У�飬��������Ǵ�����һ���
	char temp_chessman;//��ʱ����
	bool first_search=true;//�״�����״̬
	bool search_sort=true;//�ñ�������ȷ��ÿ������ʱ����һ�������з�������
	bool pvs_boole=false;
	bool temp_best_move_boole=false;
	SITE move_array[7],move_array_backups[7],*move_temp_pointer=NULL;
	SITE *temp_best_move_pointer=NULL;//��ʱ����з�
	SITE *move_pointer_array[7]={NULL};//�з�ָ�����飬�����ø�����з��������Ӱ���ӽ�����±��ʾ���з������ڸ��ڵ���move_array�±�a��ʾ�з�A����ô������ӽ�����з�A��Ȼ�Ϸ������ӽ����move_array�±�a��Ȼ��ʾ�з�A
	for(x=0;x<x_max;x++)//�����з�
	{
		if(board[0][x]==0)
		{
			for(low=5;low>=tall;low--)
			{
				if(board[low][x]==0)
				{
					move_array[x].boole=true;
					move_array[x].main_line_pointer=new MAIN_LINE;
					move_array[x].x=x;
					move_array[x].y=low;
					move_array[x].index=x;
					break;
				}
			}
		}
		else
		{
			move_array[x].boole=false;
			continue;
		}
	}
	for(x=0;x<x_max;x++)//���ݵ�ǰ�����з�״̬
	{
		move_array_backups[x]=move_array[x];
	}
	for(x=0;x<x_max;x++)
	{
		move_pointer_array[x]=&move_array[x];
	}
	for(x=0;x<x_max;x++)//��ʼ��˫������bit״̬
	{
		for(y=0;y<y_max;y++)
		{

			if(board[y][x]=='X')
			{
				x_key=x_key|(1LL<<board_bit_site[y][x]);
			}
			else if(board[y][x]=='O')
			{
				o_key=o_key|(1LL<<board_bit_site[y][x]);
			}
		}
	}
	/*}*/
	for(x=0;x<x_max;x++)//�з��������������壬ͬʱ�����õĻ����ܼ���˼������)
	{
		temp_rand=rand()%x_max;
		move_temp_pointer=move_pointer_array[x];
		move_pointer_array[x]=move_pointer_array[temp_rand];
		move_pointer_array[temp_rand]=move_temp_pointer;
	}
	/*for(x=0;x<x_max;x++)//�з�����
	{
	temp_chessman=board[move_pointer_array[x]->y][move_pointer_array[x]->x];
	board[move_pointer_array[x]->y][move_pointer_array[x]->x]=my;
	move_pointer_array[x]->value=-search(-infinite,infinite,foe,my,0,move_array,move_pointer_array[x]->main_line_pointer,0);
	board[move_pointer_array[x]->y][move_pointer_array[x]->x]=temp_chessman;
	}*/
	for(temp_ply=0;temp_ply<=ply;temp_ply++)
	{
		CONNECT_FOUR::hash_max_now_player=CONNECT_FOUR::now_player+ply;
		first_search=true;
		pvs_boole=false;
		best_move.value=-infinite;
		if(temp_best_move_pointer!=NULL)
		{
			if(temp_best_move_pointer->boole)
			{
				temp_chessman=board[temp_best_move_pointer->y][temp_best_move_pointer->x];
				board[temp_best_move_pointer->y][temp_best_move_pointer->x]=my;
				hash_key_update(x_key,o_key,next_x_key,next_o_key,*temp_best_move_pointer);
				best_move=*temp_best_move_pointer;
				best_move.value=-search(-infinite,infinite,foe,my,temp_ply,move_array,temp_best_move_pointer->main_line_pointer,0,*temp_best_move_pointer,next_x_key,next_o_key);
				board[temp_best_move_pointer->y][temp_best_move_pointer->x]=temp_chessman;
				temp_best_move_pointer->boole=false;
				first_search=false;
				pvs_boole=true;
			}
		}
		/*if(best_move.value>=win)
		{
			break;
		}*/
		for(;;)
		{

			search_sort=true;
			for(x=0;x<x_max;x++)
			{
				if(move_pointer_array[x]->boole)
				{
					move_temp_pointer=move_pointer_array[x];
					search_sort=false;
					break;
				}
			}
			if(search_sort)
			{
				break;
			}
			if(move_temp_pointer->boole)
			{
				temp_chessman=board[move_temp_pointer->y][move_temp_pointer->x];
				board[move_temp_pointer->y][move_temp_pointer->x]=my;
				hash_key_update(x_key,o_key,next_x_key,next_o_key,*move_temp_pointer);
				if(first_search)
				{
					iterative_deepening=true;
					now_main_line=move_temp_pointer->main_line_pointer;
					if(pvs_boole)
					{
						value=-search(-best_move.value - 1,-best_move.value,foe,my,temp_ply,move_array,move_temp_pointer->main_line_pointer,0,*move_temp_pointer,next_x_key,next_o_key);
						if((value>best_move.value)&&(value<infinite))
						{
							value=-search(-infinite,infinite,foe,my,temp_ply,move_array,move_temp_pointer->main_line_pointer,0,*move_temp_pointer,next_x_key,next_o_key);
						}
					}
					else
					{
						value=-search(-infinite,infinite,foe,my,temp_ply,move_array,move_temp_pointer->main_line_pointer,0,*move_temp_pointer,next_x_key,next_o_key);
					}
					move_temp_pointer->boole=false;
					first_search=false;
				}
				else
				{
					iterative_deepening=true;
					now_main_line=move_temp_pointer->main_line_pointer;
					if(pvs_boole)
					{
						value=-search(-best_move.value - 1,-best_move.value,foe,my,temp_ply,move_array,move_temp_pointer->main_line_pointer,0,*move_temp_pointer,next_x_key,next_o_key);
						if((value>best_move.value)&&(value<infinite))
						{
							value=-search(-infinite,-best_move.value,foe,my,temp_ply,move_array,move_temp_pointer->main_line_pointer,0,*move_temp_pointer,next_x_key,next_o_key);
						}
					}
					else
					{
						value=-search(-infinite,-best_move.value,foe,my,temp_ply,move_array,move_temp_pointer->main_line_pointer,0,*move_temp_pointer,next_x_key,next_o_key);
					}
					move_temp_pointer->boole=false;
				}
				board[move_temp_pointer->y][move_temp_pointer->x]=temp_chessman;
				if(value>best_move.value)
				{
					pvs_boole=true;
					best_move=*move_temp_pointer;
					temp_best_move_pointer=move_temp_pointer;
					best_move.value=value;
					if(best_move.value>=win)
					{
						break;
					}
				}
			}
		}
		/*if(best_move.value>=win)
		{
			break;
		}*/
		for(x=0;x<x_max;x++)
		{
			move_array[x]=move_array_backups[x];
		}
	}
	for(x=0;x<x_max;x++)
	{
		delete move_array[x].main_line_pointer;
	}
	board[best_move.y][best_move.x]=my;
}

inline bool CONNECT_FOUR::player_switch()
{
	SITE site;
	bool undo=false;//����״̬
	int undo_cin=-2;//����״̬
	bool game_end=false;//��ֽ���״̬
	int game_end_value=-infinite;
	BOARD_LINE *last_temp=NULL;
	for(;;)
	{
		undo=false;//����״̬��ֵΪ���ʾ��Ҫ����
		if(((my=='X')&&(now_player%2==0))||((my=='O')&&(now_player%2!=0)))//������
		{
			cout<<"����˼���У������ĵȴ�"<<endl;
			go(site);
			cout<<my<<"�����������棺"<<endl;
			printf_board();
			cout<<"���������Ե�ǰ��������֣�"<<site.value<<endl;
			game_end_value=evaluate(my,game_end);
			if(game_end)
			{
				CONNECT_FOUR::now_player++;
				last_temp=NULL;
				if(CONNECT_FOUR::last==NULL)
				{
					CONNECT_FOUR::last=new BOARD_LINE;
				}
				else
				{
					last_temp=CONNECT_FOUR::last;
					CONNECT_FOUR::last->next=new BOARD_LINE;
					CONNECT_FOUR::last->next->last=last_temp;
					CONNECT_FOUR::last=CONNECT_FOUR::last->next;
				}
				if(game_end_value>=win)
				{
					cout<<"��ֽ�����"<<my<<"�����ʤ"<<endl;
				}
				else
				{
					cout<<"��ֽ�����"<<"�;�"<<endl;
				}
				cout<<"���� -1 ���壬��������������ر�"<<endl;
				cin.clear();
				cin.sync();
				cin>>undo_cin;
				if(undo_cin==-1)
				{
					undo=true;
				}
				else
				{
					return true;
				}
			}
		}
		else//������
		{
			scanf_board(CONNECT_FOUR::foe,site,undo);
			cout<<foe<<"���������棺"<<endl;
			printf_board();
			game_end_value=evaluate(foe,game_end);
			if(game_end)
			{
				CONNECT_FOUR::now_player++;
				last_temp=NULL;
				if(CONNECT_FOUR::last==NULL)
				{
					CONNECT_FOUR::last=new BOARD_LINE;
				}
				else
				{
					last_temp=CONNECT_FOUR::last;
					CONNECT_FOUR::last->next=new BOARD_LINE;
					CONNECT_FOUR::last->next->last=last_temp;
					CONNECT_FOUR::last=CONNECT_FOUR::last->next;
				}
				if(game_end_value>=win)
				{
					cout<<"��ֽ�����"<<foe<<"���ʤ"<<endl;
				}
				else
				{
					cout<<"��ֽ�����"<<"�;�"<<endl;
				}
				cout<<"���� -1 ���壬��������������ر�"<<endl;
				cin.clear();
				cin.sync();
				cin>>undo_cin;
				if(undo_cin==-1)
				{
					undo=true;
				}
				else
				{
					return true;
				}
			}
		}
		if(undo)
		{
			if(last_temp->undo())
			{
				cout<<"����ɹ�"<<endl;
				cout<<"�������棺"<<endl;
				printf_board();
			}
			else
			{
				cout<<"����ʧ��"<<endl;
			}
		}
		else
		{
			break;
		}
	}
	CONNECT_FOUR::now_player++;
	last_temp=NULL;
	if(CONNECT_FOUR::last==NULL)
	{
		CONNECT_FOUR::last=new BOARD_LINE;
	}
	else
	{
		last_temp=CONNECT_FOUR::last;
		CONNECT_FOUR::last->next=new BOARD_LINE;
		CONNECT_FOUR::last->next->last=last_temp;
		CONNECT_FOUR::last=CONNECT_FOUR::last->next;
	}
	return false;
}

inline void CONNECT_FOUR::scanf_board(char player,SITE &site,bool &undo)
{
	int x=0;
	int low=5;
	const int tall=0;
	for(;;)
	{
		printf("���������ӵ����������� -1 ����\n");
		fflush(stdin);
		scanf("%d",&x);
		if(x == -1)
		{
			undo=true;
			return;
		}
		else
		{
			if((x>=1)&&(x<=7))
			{
				if(board[0][x-1]==0)
				{
					for(low=5;low>=tall;low--)
					{
						if(board[low][x-1]==0)
						{
							board[low][x-1]=player;
							site.boole=true;
							site.x=(x-1);
							site.y=(low);
							return;
						}
					}
				}
				else
				{
					printf("������Ϸ�����λ��\n");
				}
			}
			else
			{
				printf("������Ϸ�����λ��\n");
			}
		}
	}
}

inline void CONNECT_FOUR::printf_board(void)//������ʾ����
{
	printf("%c|%c|%c|%c|%c|%c|%c\n",board[0][0],board[0][1],board[0][2],board[0][3],board[0][4],board[0][5],board[0][6]);
	printf("-------------\n");
	printf("%c|%c|%c|%c|%c|%c|%c\n",board[1][0],board[1][1],board[1][2],board[1][3],board[1][4],board[1][5],board[1][6]);
	printf("-------------\n");
	printf("%c|%c|%c|%c|%c|%c|%c\n",board[2][0],board[2][1],board[2][2],board[2][3],board[2][4],board[2][5],board[2][6]);
	printf("-------------\n");
	printf("%c|%c|%c|%c|%c|%c|%c\n",board[3][0],board[3][1],board[3][2],board[3][3],board[3][4],board[3][5],board[3][6]);
	printf("-------------\n");
	printf("%c|%c|%c|%c|%c|%c|%c\n",board[4][0],board[4][1],board[4][2],board[4][3],board[4][4],board[4][5],board[4][6]);
	printf("-------------\n");
	printf("%c|%c|%c|%c|%c|%c|%c\n",board[5][0],board[5][1],board[5][2],board[5][3],board[5][4],board[5][5],board[5][6]);
};

inline BOARD_LINE::BOARD_LINE()//����·�ߣ����ף������캯��
{
	int x=0,y=0;//x��ˮƽ����(�У�,y�Ǵ�ֱ���꣨�У�
	last=NULL;
	next=NULL;
	now_player=CONNECT_FOUR::now_player;
	for(x=0;x<7;x++)
	{
		for(y=0;y<6;y++)
		{
			board[y][x]=CONNECT_FOUR::board[y][x];
		}
	}
}

inline BOARD_LINE::~BOARD_LINE()//����·�ߣ����ף�������������
{
	delete next;
}
inline bool BOARD_LINE::undo()
{
	int i=0;
	int x=0,y=0;//x��ˮƽ����(�У�,y�Ǵ�ֱ���꣨�У�
	BOARD_LINE *last_temp=CONNECT_FOUR::last;
	for(i=0;i<2;i++)
	{
		if(last_temp->last!=NULL)
		{
			last_temp=last_temp->last;
		}
		else
		{
			return false;
		}
	}
	CONNECT_FOUR::last=last_temp;
	CONNECT_FOUR::now_player=last_temp->now_player;
	for(x=0;x<7;x++)
	{
		for(y=0;y<6;y++)
		{
			CONNECT_FOUR::board[y][x]=last_temp->board[y][x];
		}
	}
	delete CONNECT_FOUR::last->next;
	CONNECT_FOUR::last->next=NULL;
	return true;
}
int main()
{
	CONNECT_FOUR connect_four;
	char first=NULL;//����״̬
	char my=NULL;//������
	srand((unsigned int)(time(NULL)));
	for(;;)
	{
		printf("˭���ߣ�\n");
		printf("Y���������ߣ�N�����������\n");
		fflush(stdin);
		scanf("%c",&first);
		if (((first=='y')||(first=='Y'))||((first=='n')||(first=='N')))
		{
			break;
		}
		cout<<"����ȷ����"<<endl;
	}
	if((first=='y')||(first=='Y'))
	{
		my='O';
	}
	else
	{
		my='X';
	}
	for(;;)
	{
		cout<<"������˼������"<<endl;
		cin.clear();
		cin.sync();
		cin>>CONNECT_FOUR::ply;
		if(CONNECT_FOUR::ply>=0)
		{
			break;
		}
		cout<<"����ȷ����"<<endl;
	}
	CONNECT_FOUR::my=my;
	CONNECT_FOUR::foe=(my=='X')?'O':'X';
	CONNECT_FOUR::last=new BOARD_LINE;
	cout<<"��ʼ����"<<endl;
	connect_four.printf_board();
	for(;;)
	{
		if(connect_four.player_switch())
		{
			break;
		}
	}
	cout<<"�����������������"<<endl;
	getch();
	return 0;
}
